#!/bin/bash

# It is important to have error handling set up inside your PHP scripts,
# but Fatal and Parse errors in PHP will cause a script to die without
# ever using any of those error handling methods. This shell script
# monitors error log files and sends an e-mail notification whenever a
# Fatal or Parse error is encountered.

# First, begin monitoring some error log files using tail
tail -f <paths to some error log files> | while read LINE;do
    # For each line, check if it contains the following regular expression:
    rege='PHP (Parse|Fatal) error'
    if [[ $LINE =~ $rege ]]; then

        # Send an e-mail with the parameters below.
        # To send a CC, uncomment the corresponding two lines.
        SUBJ="PHP Fatal Error on Server!"
        FROM="your@email.com"
        TO="your@email.com"
        # TO1="additional@email.com"

        echo "From: ${FROM}" > /tmp/mailtest
        echo "To: ${TO}" >> /tmp/mailtest
        # echo "CC: ${TO1}" >> /tmp/mailtest
        echo "Subject: ${SUBJ}" >> /tmp/mailtest
        echo "" >> /tmp/mailtest
        echo "${LINE}" >> /tmp/mailtest
        echo "" >> /tmp/mailtest
        echo "${SUBJ}" >> /tmp/mailtest
        cat /tmp/mailtest | /usr/sbin/sendmail -t
    fi
done
