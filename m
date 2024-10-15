Return-Path: <linux-kernel+bounces-365208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAFC99DEFD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8754A281DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8A18A6C8;
	Tue, 15 Oct 2024 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA15+yVl"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8AC175D54
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975766; cv=none; b=IKiKkfxyH8oZQMjpliIJkmKSZ2ceWGp4LeOtmdexxWfl15nrUpL7Ptw74KQJhU5ee7VKIaAMuXk95l0UE+/EU6CdwJcpmx7dKxYTyq0vhUOcTqugEcU1GBaMN4tj8Y25puw2bOTTrD7G1GA+4K8EiIB9nZUO4BQNbKoCDH9gg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975766; c=relaxed/simple;
	bh=1CuoeGD+nlobMeGgiysWcd3yow7WVTLODfZKVj6O6Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IuQeF4SFycQy3Yh61Nu1t2ekvEssWJ1aFHzqvxGFgiIOnjWd4fvP0QPJUOuqaztsAf2ls/3N2b8V4ruSTHHlYFFJK1hIhm/u6KOkdboGtr/NH/mvx3Rm7w1rN2D9bk/oUe3mKAZu+BU/Vwc1H972yVCVnyKJYRa4j1oObVTB+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA15+yVl; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c5ab2de184so32237826d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728975763; x=1729580563; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+wZW/ZPoQ+q42jKxPUqYzpXPsInKUUO0HPGzoQL+qc4=;
        b=FA15+yVlaHrSkmOrV8kKn+OUBFzNsJNGaUlcl2B9TZ0LgJs9PPmtrvxoc5FNkLFeP6
         vROgprM8DcHh8bxJAwc8XrMc345d+2/X58E9E+POdg3E9a95vTxCsP8DiShiibT95m2W
         rcmqu/ZFr6aW5ewpqEZgu2A4BMOfLvs8HdRbjZpB9MB3kpz3I416G+f8EaBlGHaCj3GJ
         pl2fRchTmWlbzUNrlvCHEuFPBG5NfRM9++JV+G2NcfZKEMpVo8DNdTmlgloPfOcO7KPq
         jNpN/O2X+dDbbbeaMx3LfcsXhW5COizEl12i8KGB7ZVQQRTh4WF0paHMqZaoYdv2HqJl
         IhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728975763; x=1729580563;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wZW/ZPoQ+q42jKxPUqYzpXPsInKUUO0HPGzoQL+qc4=;
        b=rJDShiZb26MI37vDGV1sr/ZGWwTaKdSNfEwiRv+E4qkcJ0NQwpvIY/4qSIbB7zyJ5N
         ngBwtL+zXnd628PdOA0hHExR1j/JG5/02wfGanV5OgzPQvsKFgVVGIl+gFYX7SG65dua
         Cx2KJ0UYr9U0WhO1TYSXfiDrRkLN1dkdOtgkNTZi1WwedyQ4lyrvznZZzunt2zFWQLG9
         8U9MW9kOzPLJDbbVo9CBEi7h1fitvox3/NvFSfLXLVge2zE+MVWwMqUrDBx891iyfJAn
         8XwVZyQoD47RCksQspXM8WLhwHvxMC8hZOs8O48izZ2zGcO3Bv/d2Y5oim2rrHAiwkiS
         LMBw==
X-Gm-Message-State: AOJu0Yx1nBf5/d7i+dD+ogJ5omQwE+ak2WmsyDMggXcvre3oIooh61w6
	N98dL31zUOiRMyZa7R6fgMS0cy53yPAT958TBUxEa0d6xDKVgO38o/HTfE1Q
X-Google-Smtp-Source: AGHT+IE4WZ4ZLafCvr5R4m7Vxl0ziHZ34bHU34F44cmFBZbfRHXUZzBOBUUfCC0ndWGFYpnlNWdpZg==
X-Received: by 2002:ad4:410b:0:b0:6cb:f077:f2f4 with SMTP id 6a1803df08f44-6cbf077f3aemr183419566d6.17.1728975762487;
        Tue, 15 Oct 2024 00:02:42 -0700 (PDT)
Received: from localhost.localdomain ([66.198.16.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2290fe8csm3401826d6.14.2024.10.15.00.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 00:02:42 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: avimalin@gmail.com,
	vimal.agrawal@sophos.com
Subject: [PATCH v2] misc: misc_minor_alloc to use ida for all dynamic/misc dynamic minors
Date: Tue, 15 Oct 2024 07:02:26 +0000
Message-Id: <20241015070226.15790-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2024101416-scouring-upbeat-b658@gregkh>
References: <2024101416-scouring-upbeat-b658@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

misc_minor_alloc was allocating id using ida for minor only in case of
MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
using ida_free causing a mismatch and following warn:
> > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > ida_free called for id=127 which is not allocated.
> > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
...
> > [<60941eb4>] ida_free+0x3e0/0x41f
> > [<605ac993>] misc_minor_free+0x3e/0xbc
> > [<605acb82>] misc_deregister+0x171/0x1b3

misc_minor_alloc is changed to allocate id from ida for all minors
falling in the range of dynamic/ misc dynamic minors

Fixes: 0ad35fed618c ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
---
 drivers/char/misc.c   | 35 +++++++++++++++++-----
 lib/Kconfig.debug     | 11 +++++++
 lib/Makefile          |  1 +
 lib/test_misc_minor.c | 67 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 7 deletions(-)
 create mode 100644 lib/test_misc_minor.c

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 541edc26ec89..9d0cd3459b4f 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -63,16 +63,30 @@ static DEFINE_MUTEX(misc_mtx);
 #define DYNAMIC_MINORS 128 /* like dynamic majors */
 static DEFINE_IDA(misc_minors_ida);
 
-static int misc_minor_alloc(void)
+static int misc_minor_alloc(int minor)
 {
 	int ret;
 
-	ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
-	if (ret >= 0) {
-		ret = DYNAMIC_MINORS - ret - 1;
-	} else {
-		ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
+	if (minor == MISC_DYNAMIC_MINOR) {
+		/* allocate free id */
+		ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
+		if (ret >= 0) {
+			ret = DYNAMIC_MINORS - ret - 1;
+		} else {
+			ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
 				      MINORMASK, GFP_KERNEL);
+		}
+	} else {
+		/* specific minor, check if it is in dynamic or misc dynamic range  */
+		if (minor < DYNAMIC_MINORS) {
+			minor = DYNAMIC_MINORS - minor - 1;
+			ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
+		} else if (minor > MISC_DYNAMIC_MINOR) {
+			ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
+		} else {
+			/* case of non-dynamic minors, no need to allocate id */
+			ret = 0;
+		}
 	}
 	return ret;
 }
@@ -219,7 +233,7 @@ int misc_register(struct miscdevice *misc)
 	mutex_lock(&misc_mtx);
 
 	if (is_dynamic) {
-		int i = misc_minor_alloc();
+		int i = misc_minor_alloc(misc->minor);
 
 		if (i < 0) {
 			err = -EBUSY;
@@ -228,6 +242,7 @@ int misc_register(struct miscdevice *misc)
 		misc->minor = i;
 	} else {
 		struct miscdevice *c;
+		int i;
 
 		list_for_each_entry(c, &misc_list, list) {
 			if (c->minor == misc->minor) {
@@ -235,6 +250,12 @@ int misc_register(struct miscdevice *misc)
 				goto out;
 			}
 		}
+
+		i = misc_minor_alloc(misc->minor);
+		if (i < 0) {
+			err = -EBUSY;
+			goto out;
+		}
 	}
 
 	dev = MKDEV(MISC_MAJOR, misc->minor);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..5a5d27284e0a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2488,6 +2488,17 @@ config TEST_RHASHTABLE
 config TEST_IDA
 	tristate "Perform selftest on IDA functions"
 
+config TEST_MISC_MINOR
+	tristate "Basic misc minor Kunit test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Kunit test for the misc minor.
+	  It tests misc minor functions for dynamic and misc dynamic minor.
+	  This include misc_xxx functions
+
+	  If unsure, say N.
+
 config TEST_PARMAN
 	tristate "Perform selftest on priority array manager"
 	depends on PARMAN
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..631d73f96f76 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
 obj-$(CONFIG_TEST_IOV_ITER) += kunit_iov_iter.o
 obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
+obj-$(CONFIG_TEST_MISC_MINOR) += test_misc_minor.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, unused-but-set-variable)
diff --git a/lib/test_misc_minor.c b/lib/test_misc_minor.c
new file mode 100644
index 000000000000..bcec3fb1c46a
--- /dev/null
+++ b/lib/test_misc_minor.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+
+/* dynamic minor (2) */
+static struct miscdevice dev_dynamic_minor = {
+        .minor  = 2,
+        .name   = "dev_dynamic_minor",
+};
+
+/* static minor (LCD_MINOR) */
+static struct miscdevice dev_static_minor = {
+        .minor  = LCD_MINOR,
+        .name   = "dev_static_minor",
+};
+
+/* misc dynamic minor */
+static struct miscdevice dev_misc_dynamic_minor = {
+        .minor  = MISC_DYNAMIC_MINOR,
+        .name   = "dev_misc_dynamic_minor",
+};
+
+static void kunit_dynamic_minor(struct kunit *test)
+{
+	int ret;
+
+	ret=misc_register(&dev_dynamic_minor);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, 2, dev_dynamic_minor.minor);
+	misc_deregister(&dev_dynamic_minor);
+}
+
+static void kunit_static_minor(struct kunit *test)
+{
+	int ret;
+
+	ret=misc_register(&dev_static_minor);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	KUNIT_EXPECT_EQ(test, LCD_MINOR, dev_static_minor.minor);
+	misc_deregister(&dev_static_minor);
+}
+
+static void kunit_misc_dynamic_minor(struct kunit *test)
+{
+	int ret;
+
+	ret=misc_register(&dev_misc_dynamic_minor);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	misc_deregister(&dev_misc_dynamic_minor);
+}
+
+static struct kunit_case test_cases[] = {
+	KUNIT_CASE(kunit_dynamic_minor),
+	KUNIT_CASE(kunit_static_minor),
+	KUNIT_CASE(kunit_misc_dynamic_minor),
+	{}
+};
+
+static struct kunit_suite test_suite = {
+	.name = "misc_minor_test",
+	.test_cases = test_cases,
+};
+kunit_test_suite(test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.17.1


