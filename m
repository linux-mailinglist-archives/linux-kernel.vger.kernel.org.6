Return-Path: <linux-kernel+bounces-205386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAAF8FFAEB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADE728BCEC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F4314E2D2;
	Fri,  7 Jun 2024 04:30:53 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AFF17582
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734653; cv=none; b=KLjtCaQD+bL88qWtX8HigrO24LfElvdFcE6Ka8i8HpDJCPTb2gUUIzfHPoK60zXxhZonFAiy8jDCD+jJStyP8fnkzJGnerrSOs7gk5+kDtNZkwEdId+Ft/WPPIA03loafgr3/CLlh+4X4ahN88dgrb9hW6mk01SHoDhgpQfm68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734653; c=relaxed/simple;
	bh=Tc4hUpgvlVlUSyQrALkU6V9XxxjottVWLvK1ekmE1A0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tjo6/+hSLjmtW5vFR8MjfmUER7wbA4xW7qNNwZgxw2twO3RPaX7qFrCDcbRcSl0Fwvl68k76TomH0cgYGSONuFL7aO3E3UPRuZKbNn+BdkX2ztm7BikyyHv3oaCpOJ1L0/vneith7Wa9W0JB1WMZwK9gXFxoGDk5QMKEY2Y4N3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSp26ZwWzsT6P;
	Fri,  7 Jun 2024 12:26:50 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F19A140124;
	Fri,  7 Jun 2024 12:30:34 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:43 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 104/110] tests: ubifs_tools: fsck_tests: Add cycle_powercut+fsck test
Date: Fri, 7 Jun 2024 12:26:09 +0800
Message-ID: <20240607042615.2069840-105-chengzhihao1@huawei.com>
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

Inject powercut while doing fsstress on mounted UBIFS, check the
consistency of UBIFS after fsck.
This testscase mainly makes sure that fsck.ubifs can make UBIFS
image be consistent in common stress cases and powercut cases.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 .gitignore                                         |   1 +
 configure.ac                                       |   3 +-
 tests/ubifs_tools-tests/Makemodule.am              |   3 +-
 .../fsck_tests/cycle_powercut_mount_fsck.sh.in     | 144 +++++++++++++++++++++
 4 files changed, 149 insertions(+), 2 deletions(-)
 create mode 100755 tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh.in

diff --git a/.gitignore b/.gitignore
index ea99a614..1d150f7a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,6 +118,7 @@ tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
 tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
 tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
 tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh
+tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh
 
 #
 # Files generated by autotools
diff --git a/configure.ac b/configure.ac
index ed8a5f12..1a7174a5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -294,7 +294,8 @@ AC_CONFIG_FILES([tests/fs-tests/fs_help_all.sh
 	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
 	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
 	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
-	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh])
+	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh
+	tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh])
 
 AC_OUTPUT([Makefile])
 
diff --git a/tests/ubifs_tools-tests/Makemodule.am b/tests/ubifs_tools-tests/Makemodule.am
index 932a2bcb..2c190e2b 100644
--- a/tests/ubifs_tools-tests/Makemodule.am
+++ b/tests/ubifs_tools-tests/Makemodule.am
@@ -3,4 +3,5 @@ test_SCRIPTS += \
 	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh \
 	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh \
 	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh \
-	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh
+	tests/ubifs_tools-tests/fsck_tests/cycle_corrupted_fsck_fault_inject.sh \
+	tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh
diff --git a/tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh.in b/tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh.in
new file mode 100755
index 00000000..fac5a033
--- /dev/null
+++ b/tests/ubifs_tools-tests/fsck_tests/cycle_powercut_mount_fsck.sh.in
@@ -0,0 +1,144 @@
+#!/bin/sh
+# Copyright (c), 2024, Huawei Technologies Co, Ltd.
+# Author: Zhihao Cheng <chengzhihao1@huawei.com>
+#
+# Test Description:
+# Do many cycles of mount/fsstress/powercut/umount/fsck/mount, check whether
+# mount is successful.
+# Running time: 9h
+
+TESTBINDIR=@TESTBINDIR@
+source $TESTBINDIR/common.sh
+
+ID="0x20,0xa7,0x00,0x26" # 4G 256KB 4KB 2KB-sub-page
+
+function run_test()
+{
+	local encryption=$1
+
+	echo "Do cycle mount+powercut+fsck+umount($encryption) test"
+	modprobe nandsim id_bytes=$ID
+	mtdnum="$(find_mtd_device "$nandsim_patt")"
+	flash_eraseall /dev/mtd$mtdnum
+
+	dmesg -c > /dev/null
+
+	modprobe ubi mtd="$mtdnum,4096" || fatal "modprobe ubi fail"
+	ubimkvol -N vol_test -m -n 0 /dev/ubi$UBI_NUM || fatal "mkvol fail"
+	modprobe ubifs || fatal "modprobe ubifs fail"
+
+	if [[ "$encryption" == "encrypted" ]]; then
+		encryption_gen_key
+	fi
+
+	round=0
+	while [[ $round -lt 60 ]]
+	do
+		echo "---------------------- ROUND $round ----------------------"
+		let round=$round+1
+
+		mount_ubifs $DEV $MNT || fatal "mount ubifs fail"
+		if [[ "$encryption" == "encrypted" ]]; then
+			encryption_set_key $MNT
+		fi
+
+		if [[ $(($round % 30)) == 0 ]]
+		then
+			echo "Clean files"
+			rm -rf $MNT/*
+			check_err_msg
+		fi
+
+		fsstress -d $MNT -l0 -p4 -n10000 &
+		sleep $((RANDOM % 30))
+
+		per=`df -Th | grep ubifs | awk '{print $6}'`;
+		if [[ ${per%?} -gt 95 ]]; then
+			dmesg -c > /dev/null # The ENOSPC error messages may exist
+		else
+			check_err_msg # Make sure new operations are okay after fsck
+		fi
+		powercut
+
+		ps -e | grep -w fsstress > /dev/null 2>&1
+		while [ $? -eq 0 ]
+		do
+			killall -9 fsstress > /dev/null 2>&1
+			sleep 1
+			ps -e | grep -w fsstress > /dev/null 2>&1
+		done
+
+		while true
+		do
+			res=`mount | grep "$MNT"`
+			if [[ "$res" == "" ]]
+			then
+				break;
+			fi
+			umount $MNT
+			sleep 0.1
+		done
+
+		fsck.ubifs -a $DEV 2>&1 > $LOG_FILE
+		res=$?
+		cat $LOG_FILE
+		if [[ $res != $FSCK_OK ]]
+		then
+			# Powercut during layout_leb_in_gaps may change index
+			# LEBs without updating LPT.
+			log=`cat $LOG_FILE | grep "Inconsistent properties" | grep "is_idx 1"`
+			if [[ "$log" == "" ]]; then
+				fatal "fsck fail $res"
+			fi
+			if [[ $res != $FSCK_NONDESTRUCT ]]; then
+				fatal "fsck fail $res"
+			fi
+		fi
+
+		dmesg -c > /dev/null # powercut could reproduce error messages
+
+		enable_chkfs
+
+		mount_ubifs $DEV $MNT "noauthentication" "noatime"
+		res=$?
+		if [[ $res != 0 ]]
+		then
+			fatal "mount fail $res"
+		fi
+
+		if [[ "$encryption" == "encrypted" ]]; then
+			encryption_set_key $MNT
+		fi
+
+		du -sh $MNT > /dev/null  # Make sure all files are accessible
+		ret=$?
+		if [[ $ret != 0 ]]; then
+			fatal "Cannot access all files"
+		fi
+		check_err_msg
+
+		umount $MNT
+		res=$?
+		if [[ $res != 0 ]]
+		then
+			fatal "unmount fail $res"
+		fi
+
+		check_err_msg
+
+		disable_chkfs
+	done
+
+	modprobe -r ubifs
+	modprobe -r ubi
+	modprobe -r nandsim
+}
+
+check_fsstress
+start_t=$(date +%s)
+run_test "encrypted"
+run_test "noencrypted"
+end_t=$(date +%s)
+time_cost=$(( end_t - start_t ))
+echo "Success, cost $time_cost seconds"
+exit 0
-- 
2.13.6


