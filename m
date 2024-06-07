Return-Path: <linux-kernel+bounces-205392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E639E8FFAF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E54228C954
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD79A14F9E2;
	Fri,  7 Jun 2024 04:31:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A514F105
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734702; cv=none; b=mwAu9DHaLIdqNl8afVRRNBV3JbMtwyeozj+2xqTkzMoHH4KxsEoKgrA3LmnQ+R0SeFjD21yn8f1K6UwsPFvvk7UoGvCP6FMYuRebFJPhDUNWJicZfDqgSZ81MeeRUCl6mIC01uRSXvzraU3CRteaDMAV7AVl1vNCTrREhpOUeiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734702; c=relaxed/simple;
	bh=gzZLVi/p97JbLav/BM6ZI097XV5leywKwBv3JtZBKAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSqGRrnFWjCBNBYUEr0DsTXIZsxSl/lVNjMY80B8qED3mnEaowe6/EEYHcofuiQAeLom/SP+L1LepIkM+u3EAUxes+2aVkrta3bXdV66ffWnqNK5zqf4PoD/svmZ64o0mkymSFw+asYjhU/TCikf1pLMxilnnTGc5Yv4O8TpT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VwSst1mSPzdZhG;
	Fri,  7 Jun 2024 12:30:10 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 29F92180085;
	Fri,  7 Jun 2024 12:31:35 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:47 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 109/110] tests: ubifs_tools: Add run_all script
Date: Fri, 7 Jun 2024 12:26:14 +0800
Message-ID: <20240607042615.2069840-110-chengzhihao1@huawei.com>
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

Add run_all script to run all UBIFS fsck & mkfs testcases.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 .gitignore                                        |  1 +
 configure.ac                                      |  1 +
 tests/ubifs_tools-tests/Makemodule.am             |  1 +
 tests/ubifs_tools-tests/ubifs_tools_run_all.sh.in | 65 +++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 create mode 100755 tests/ubifs_tools-tests/ubifs_tools_run_all.sh.in

diff --git a/.gitignore b/.gitignore
index ffbde6e5..673536e9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,6 +114,7 @@ tests/fs-tests/stress/fs_stress01.sh
 tests/ubi-tests/runubitests.sh
 tests/ubi-tests/ubi-stress-test.sh
 tests/ubifs_tools-tests/lib/common.sh
+tests/ubifs_tools-tests/ubifs_tools_run_all.sh
 tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
 tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
 tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
diff --git a/configure.ac b/configure.ac
index 13974090..da1b0cfc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -291,6 +291,7 @@ AC_CONFIG_FILES([tests/fs-tests/fs_help_all.sh
 	tests/ubi-tests/runubitests.sh
 	tests/ubi-tests/ubi-stress-test.sh
 	tests/ubifs_tools-tests/lib/common.sh
+	tests/ubifs_tools-tests/ubifs_tools_run_all.sh
 	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh
 	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh
 	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh
diff --git a/tests/ubifs_tools-tests/Makemodule.am b/tests/ubifs_tools-tests/Makemodule.am
index f4d8a073..1715757e 100644
--- a/tests/ubifs_tools-tests/Makemodule.am
+++ b/tests/ubifs_tools-tests/Makemodule.am
@@ -1,5 +1,6 @@
 test_SCRIPTS += \
 	tests/ubifs_tools-tests/lib/common.sh \
+	tests/ubifs_tools-tests/ubifs_tools_run_all.sh \
 	tests/ubifs_tools-tests/fsck_tests/authentication_refuse.sh \
 	tests/ubifs_tools-tests/fsck_tests/cycle_mount_fsck_check.sh \
 	tests/ubifs_tools-tests/fsck_tests/powercut_fsck_mount.sh \
diff --git a/tests/ubifs_tools-tests/ubifs_tools_run_all.sh.in b/tests/ubifs_tools-tests/ubifs_tools_run_all.sh.in
new file mode 100755
index 00000000..a7caad04
--- /dev/null
+++ b/tests/ubifs_tools-tests/ubifs_tools_run_all.sh.in
@@ -0,0 +1,65 @@
+#!/bin/sh
+# Copyright (c), 2024, Huawei Technologies Co, Ltd.
+# Author: Zhihao Cheng <chengzhihao1@huawei.com>
+#
+# Test Description:
+# Run all testcases under 'tests' directory
+
+function print_line()
+{
+	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
+	echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
+}
+
+TESTBINDIR=@TESTBINDIR@
+
+print_line
+$TESTBINDIR/authentication_refuse.sh
+if [[ $? != 0 ]]; then
+	echo "authentication_refuse failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/powercut_fsck_mount.sh
+if [[ $? != 0 ]]; then
+	echo "powercut_fsck_mount failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/cycle_corrupted_fsck_fault_inject.sh
+if [[ $? != 0 ]]; then
+	echo "cycle_corrupted_fsck_fault_inject failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/fsck_bad_image.sh
+if [[ $? != 0 ]]; then
+	echo "fsck_bad_image failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/random_corrupted_fsck.sh
+if [[ $? != 0 ]]; then
+	echo "random_corrupted_fsck failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/cycle_powercut_mount_fsck.sh
+if [[ $? != 0 ]]; then
+	echo "cycle_powercut_mount_fsck failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/cycle_mount_fsck_check.sh
+if [[ $? != 0 ]]; then
+	echo "cycle_mount_fsck_check failed"
+	exit 1
+fi
+print_line
+$TESTBINDIR/build_fs_from_dir.sh
+if [[ $? != 0 ]]; then
+	echo "build_fs_from_dir failed"
+	exit 1
+fi
+
+exit 0
-- 
2.13.6


