Return-Path: <linux-kernel+bounces-205385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B889F8FFAE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3390328B8BC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45E51459E3;
	Fri,  7 Jun 2024 04:30:38 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A79D14AD35
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734638; cv=none; b=kHdqjmq8MTNMi3FENQ85arC9s/XB/uhlW6uACO48HPEbjj+YSiH5m/gSgcdaxOKcr8IYMNmuulxAeZiGokrnc8Rc5JmgBuZzUjai2eigjeKLMM8BDR2dG5T1Tab1b5eXjduBrGlY4VGsfJsTzj2LoMi+KKE80umpfN0IvBXgh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734638; c=relaxed/simple;
	bh=oORbDPD6+8Kfdt5Tqb0NrZV+hZayvS3khE3RcT0167I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFPH6QbN9EbGINuqvPiAkNlWLX7QRlUhH6Md07JX5DzamubFrQ9IGiP0Vi5ZIlsqqfsClKKOHFztWsRQ+/abNItlWuc3yFOYrgd6PWL9eZJ3NtEpJwL822Y85Fhvt2mPbETECu1xUBz7MeF1YzpO6U5pD87mDfmVMiFgg1KRdNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSrj4HjhzdZhH;
	Fri,  7 Jun 2024 12:29:09 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 829B9140203;
	Fri,  7 Jun 2024 12:30:19 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:42 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 103/110] tests: ubifs_tools: fsck_tests: Add corrupt+fsck+fault_inject test
Date: Fri, 7 Jun 2024 12:26:08 +0800
Message-ID: <20240607042615.2069840-104-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Inject memory/io fault while doing fsck for corrupted UBIFS images.
This testcase mainly checks whether fsck.ubifs has problems (eg.
UAF, null-ptr-def, etc.) in random error paths. Besides, it provides
a similar way to simulate powercut during fsck, and checks whether
the fsck.ubifs can fix an UBIFS image after many rounds interrupted
by kinds of errors.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 .gitignore                                         |   1 +
 configure.ac                                       |   3 +-
 tests/ubifs_tools-tests/Makemodule.am              |   3 +-
 .../cycle_corrupted_fsck_fault_inject.sh.in        | 225 +++++++++++++++++++++
 tests/ubifs_tools-tests/lib/common.sh.in           |   3 +-
 5 files changed, 232 insertions(+), 3 deletions(-)
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh.in

diff --git a/.gitignore b/.gitignore
index b63b9868..ea99a614 100644
--- a/.gitignore
+++ b/.gitignore
@@ -117,6 +117,7 @@ tests/ubifs_tools-tests/lib/common.sh
 tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
 tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
 tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
+tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh
 
 #
 # Files generated by autotools
diff --git a/configure.ac b/configure.ac
index 99ce86c8..ed8a5f12 100644
--- a/configure.ac
+++ b/configure.ac
@@ -293,7 +293,8 @@ AC_CONFIG_FILES([tests/fs-tests/fs_help_all.sh
 	tests/ubifs_tools-tests/lib/common.sh
 	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
 	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
-	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh])
+	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
+	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh])
 
 AC_OUTPUT([Makefile])
 
diff --git a/tests/ubifs_tools-tests/Makemodule.am b/tests/ubifs_tools-tests/Makemodule.am
index d54514da..932a2bcb 100644
--- a/tests/ubifs_tools-tests/Makemodule.am
+++ b/tests/ubifs_tools-tests/Makemodule.am
@@ -2,4 +2,5 @@ test_SCRIPTS += \
 	tests/ubifs_tools-tests/lib/common.sh \
 	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh \
 	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh \
-	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
+	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh \
+	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh
diff --git a/tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh.in b/tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh.in
new file mode 100755
index 00000000..2073fecf
--- /dev/null
+++ b/tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh.in
@@ -0,0 +1,225 @@
+#!/bin/sh
+# Copyright (c), 2024, Huawei Technologies Co, Ltd.
+# Author: Zhihao Cheng <chengzhihao1@huawei.com>
+#
+# Test Description:
+# For many kinds of flash, do following things
+#  1. mount UBIFS
+#  2. fsstress && unmount
+#  3. inject corruption into UBIFS image randomly
+#  3. fsck UBIFS && inject kinds of errors(memory, io)
+#  4. check UBIFS mounting result
+# Running time: 15min
+
+TESTBINDIR=@TESTBINDIR@
+source $TESTBINDIR/common.sh
+
+function run_test()
+{
+	local simulator="$1";
+	local size="$2";
+	local peb_size="$3";
+	local page_size="$4";
+	local encryption=$5;
+
+	echo "======================================================================"
+	printf "%s" "$simulator: ${size}MiB PEB size ${peb_size}KiB"
+	if [ "$simulator" = "nandsim" ]; then
+		printf " %s" "page size ${page_size}Bytes"
+	fi
+	printf " $encryption\n"
+
+	if [ "$simulator" = "nandsim" ]; then
+		$TESTBINDIR/load_nandsim.sh "$size" "$peb_size" "$page_size" || echo "cannot load nandsim";
+		mtdnum="$(find_mtd_device "$nandsim_patt")"
+	elif [ "$simulator" = "mtdram" ]; then
+		load_mtdram "$size" "$peb_size" || echo "cannot load mtdram"
+		mtdnum="$(find_mtd_device "$mtdram_patt")"
+	else
+		fatal "$simulator is not supported"
+	fi
+
+	flash_eraseall /dev/mtd$mtdnum
+	modprobe ubi mtd="$mtdnum,$page_size" || fatal "modprobe ubi fail"
+	ubimkvol -N vol_test -m -n 0 /dev/ubi$UBI_NUM || fatal "mkvol fail"
+	modprobe ubifs || fatal "modprobe ubifs fail"
+	mount_ubifs $DEV $MNT || fatal "mount ubifs fail"
+	if [[ "$encryption" == "encrypted" ]]; then
+		encryption_gen_key
+		encryption_set_key $MNT
+	fi
+
+	fsstress -d $MNT -l0 -p4 -n10000 &
+
+	sleep $((RANDOM % 20))
+
+	ps -e | grep -w fsstress > /dev/null 2>&1
+	while [ $? -eq 0 ]
+	do
+		killall -9 fsstress > /dev/null 2>&1
+		sleep 1
+		ps -e | grep -w fsstress > /dev/null 2>&1
+	done
+
+	while true
+	do
+		res=`mount | grep "$MNT"`
+		if [[ "$res" == "" ]]
+		then
+			break;
+		fi
+		umount $MNT
+		sleep 0.1
+	done
+
+	# inject corruption
+	times=$((RANDOM % 10))
+	let times=$times+10
+	i=0
+	tot_peb=`cat /sys/class/ubi/ubi$UBI_NUM/total_eraseblocks`;
+
+	modprobe -r ubifs
+	modprobe -r ubi # Stop wear-leveling & erasing worker
+	while [[ $i -lt $times ]]
+	do
+		let i=$i+1;
+		peb=$((RANDOM % $tot_peb));
+		pg=`expr $peb_size \* 1024`;
+		peb_off=`expr $pg \* $peb`
+		pages=`expr $pg / $page_size`;
+		pg=`expr $pages - 2`;
+		pg=$((RANDOM % $pg));
+		pg_off=`expr $pg + 2`;
+		pg_start=`expr $pages \* $peb`;
+		pg=`expr $pg_start + $pg_off`;
+		vid_pg=`expr $pg_start + 1`;
+		dd if=/dev/mtd$mtdnum of=$TMP_FILE bs=$page_size skip=$vid_pg count=1 2>/dev/null;
+		content=`cat $TMP_FILE | grep UBI!`; # vid header magic
+		if [[ "$content" == "" ]]; then
+			# Skip free PEB, otherwise LEB data could be overwritten in UBIFS
+			continue;
+		fi
+		if [[ $((RANDOM % 2)) == 0 ]]; then
+			# Corrupts 1 page
+			dd if=/dev/urandom of=/dev/mtd$mtdnum bs=$page_size seek=$pg count=1;
+		else
+			# Erase 1 LEB, TNC points to an unmapped area
+			flash_erase /dev/mtd$mtdnum $peb_off 1
+		fi
+	done
+	rm -f $TMP_FILE 2>/dev/null
+	sync
+
+	skip=0
+	modprobe ubi mtd="$mtdnum,$page_size"
+	ret=$?
+	if [[ $ret != 0 ]]
+	then
+		skip=1
+		echo "UBI layout volume is corrupted, skip"
+	fi
+
+	if [[ $skip == 0 ]]; then
+		modprobe ubifs || fatal "modprobe ubifs2 fail"
+		dmesg -c > /dev/null
+
+		round=0
+		while [[ $round -lt 50 ]];
+		do
+			let round=$round+1
+			inject_mem=0
+
+			fsck.ubifs -yb $DEV 2>&1 > $LOG_FILE &
+			pid=$!
+			if [[ $((RANDOM % 2)) == 0 ]]; then
+				inject_mem_err $pid
+				inject_mem=1
+			fi
+			inject_io_err
+			wait $pid
+			cat $LOG_FILE
+			if [[ $inject_mem == 1 ]]; then
+				cancel_mem_err
+			fi
+			cancel_io_err
+
+			# UBI could become ro-mode, reload it
+			modprobe -r ubifs
+			modprobe -r ubi
+			modprobe ubi mtd="$mtdnum,$page_size" || fatal "modprobe ubi2 fail"
+			modprobe ubifs || fatal "modprobe ubifs3 fail"
+		done
+
+		fsck.ubifs -yb $DEV 2>&1 > $LOG_FILE
+		res=$?
+		cat $LOG_FILE
+		let "ret=$res&~$FSCK_NONDESTRUCT"
+		if [[ $ret != $FSCK_OK ]]
+		then
+			# Skip superblock error
+			log=`cat $LOG_FILE | grep "bad node at LEB 0:"`
+			if [[ "$log" != "" ]]
+			then
+				skip=1
+				echo "SB is corrupted, skip fsck & mounting"
+			else
+				fatal "fsck fail $res"
+			fi
+		fi
+
+		if [[ $skip == 0 ]]; then
+			enable_chkfs
+
+			mount_ubifs $DEV $MNT "noauthentication" "noatime"
+			res=$?
+			if [[ $res != 0 ]]
+			then
+				fatal "mount fail $res"
+			fi
+
+			if [[ "$encryption" == "encrypted" ]]; then
+				# Ignore the encrypting error, root dir could be
+			        # corrupted, the new root dir cannot be
+			        # encrypted because it is not empty.
+				encryption_set_key $MNT 1
+			fi
+
+			du -sh $MNT > /dev/null  # Make sure all files are accessible
+			ret=$?
+			if [[ $ret != 0 ]]; then
+				fatal "Cannot access all files"
+			fi
+			# check_err_msg is not suggested in this testcase, because
+			# ubi_io_read(triggered by wear_leveling_worker -> ubi_eba_copy_leb)
+			# could print stack if ecc uncorrectable errors are detected.
+
+			umount $MNT
+			res=$?
+			if [[ $res != 0 ]]
+			then
+				fatal "unmount fail $res"
+			fi
+		fi
+
+		modprobe -r ubifs
+		modprobe -r ubi
+	fi
+	modprobe -r $simulator
+
+	echo "----------------------------------------------------------------------"
+}
+
+check_fsstress
+start_t=$(date +%s)
+echo "Do corrruption+cycle_fsck_fault_injection test in kinds of flashes"
+for simulator in "mtdram" "nandsim"; do
+	for encryption in "encrypted" "noencrypted"; do
+		run_test "$simulator" "16" "16" "512" $encryption
+		run_test "$simulator" "256" "128" "2048" $encryption
+		run_test "$simulator" "1024" "512" "2048" $encryption
+	done
+done
+end_t=$(date +%s)
+time_cost=$(( end_t - start_t ))
+echo "Success, cost $time_cost seconds"
+exit 0
diff --git a/tests/ubifs_tools-tests/lib/common.sh.in b/tests/ubifs_tools-tests/lib/common.sh.in
index 5a07ebcd..a27fe108 100755
--- a/tests/ubifs_tools-tests/lib/common.sh.in
+++ b/tests/ubifs_tools-tests/lib/common.sh.in
@@ -234,12 +234,13 @@ function encryption_gen_key()
 function encryption_set_key()
 {
 	mnt=$1
+	ignore_err=$2
 	# https://github.com/google/fscryptctl
 	key=$(fscryptctl add_key $mnt < $KEY_FILE)
 	fscryptctl set_policy $key $mnt
 	#fscryptctl get_policy $mnt
 	ret=$?
-	if [[ $ret != 0 ]]; then
+	if [[ $ret != 0 && $ignore_err != 1 ]]; then
 		fatal "set encryption policy failed"
 	fi
 }
-- 
2.13.6


