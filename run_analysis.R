download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data.zip")

unzip("data.zip")

train<-read.table("./UCI HAR Dataset/train/X_train.txt")

activity_train<-read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")

test<-read.table("./UCI HAR Dataset/test/X_test.txt")

activity_test<-read.table("./UCI HAR Dataset/test/y_test.txt")

subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

all_measurements<-rbind(train, test)

names<-read.table("./UCI HAR Dataset/features.txt")

colnames(all_measurements)<-names$V2

all_measurements<-all_measurements[,grep("mean|std", colnames(all_measurements))]

all_activity<-rbind(activity_train, activity_test)

colnames(all_activity)<-"activity"

all_subject<-rbind(subject_train, subject_test)

colnames(all_subject)<-"subject"

data<-cbind("activity"=all_activity, "subject"=all_subject, all_measurements)

data$activity<-factor(data$activity, labels=c("walking", "walking upstairs", "walking downstairs", "sitting", "standing", "laying"))

data$subject<-factor(data$subject)

data<-arrange(data, activity, subject)

colnames(data)<-gsub("\\()","", names(data))

data_means<-data %>% group_by(activity, subject) %>% summarise_all(funs(mean))
