#
url="http://archive.wortfm.org/_pa_dodown.php?id=12816";
f=`echo $url | cut -d'=' -f1`
r=`echo $url | cut -d'=' -f2`
if [[ "$#" -eq 2 && "$1" -le "$2" ]]; then
        echo "Input Verification: OK";
else
        echo "Input error. Enter proper input";
        exit 1;
fi;
declare -i th=80000000;
for z in $(seq "$1" "$2");
do
        #echo "$(echo $z).mp3"
        if [ -f "$(echo $z).mp3" ]; then
                echo "File exist. skipping. $(echo $z).mp3";
        else
                echo "File not found. Starting download $(echo $z).mp3";
                echo "Checking for Size and download";
                if [ $( echo `wget --spider $f=$z -O - 2>&1 | grep Length | wc -l`) -eq 1 ]; then
                        ht1=`wget --spider $f=$z -O - 2>&1 | grep Length | cut -d' ' -f2`;
                        if [ `echo $ht1 | grep [0-9] | wc -l` -eq 0 ]; then
                                echo "File $z.mp3 : Unspecified. Ignoring download";
                        else 
                                ht=`expr $ht1`;
                                if [ "$ht" -gt "$th" ]; then
                                        wget $f=$z -O $z.mp3 2>$1;
                                        echo "File $z.mp3 downloaded";
                                else
                                        echo "File / Size not matching with threshold";
                                fi;
                        fi;
                else
                        echo "File $z not available on Server";
                fi; 
        fi;
done;
echo "End"