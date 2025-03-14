Return-Path: <linux-kernel+bounces-561575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4DEA613A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D39C880E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B5C20126B;
	Fri, 14 Mar 2025 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR+Ioo33"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796C201004
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962587; cv=none; b=qA/o09VSTGVgGr/WQr2lByEHtRTTInhFn0YjdwwYFTilmcliHDZ9UsTG5mcSH9Bt/zKyI/at4g6bUj/fDgmIlvB4gX6rDza1oTRw9XjH0Je79qlg0A2av1Vo3omv6ncTwoyiQiMvA0IiqJrVoTv2xQfoGSxLWTRFJXBARrSPufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962587; c=relaxed/simple;
	bh=RwTvuR+8zoXcFD65bjjmsvaSxIRGI2NthpF/9DgsU/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDVeC3ukUFsDGb2nuJiJf5XUZhoinY5nX0M+3M7jYo+beBImDg3kzT6oU59AqQJZ5BpCBDxNSTO5PQt3me6dgW3PPwG7GRo2RLn47AlkHPy7o5gp0VXxhi71QsJM/SgsLijDRpffKADX0Uil1ufiPRjIp+UzNzyGQR7xMaPhxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR+Ioo33; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22403cbb47fso41449265ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741962584; x=1742567384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay65LUbO5eKcGHPVzII/RlhoUMhAUU/uSsTtf/99OL0=;
        b=nR+Ioo33gjVE+09uaLImAbeV4mVB6zAz9zGjX7p9mACakr1/OuBfljx59p+wmH+0Wm
         QuG8MasU7To//KS6q3GA58UL7yvOTaxrBQxjxBtU1SPu3XOXT6zEPt4TRFyHyBGCflP5
         7UcoorP25n0NomctWiHf6RMKwU2Z8qtzjAyi2nx7Of7ztrOzDXQA0+yShKTYQvIE0myi
         1ZpLdeBf+WgXxsgAQWLZLNvOqvoQFdva08puftuwcT+FmDDjoL7xEbCTp2Ki/gAbVOF1
         kQUSXVQS+sVnYQOHzj+xzfv/IvzKYGHedqhp1x745sT3qcuVSWsZ4zgYuK0paRfDAN39
         k+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962584; x=1742567384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay65LUbO5eKcGHPVzII/RlhoUMhAUU/uSsTtf/99OL0=;
        b=q5KklkKaXLNpCSJc4Oo+mijgwi8vFSyDEh4wx/KnSKS0jCXMuu1ebA8/oZoCDFaktN
         i6IZBJWtGUwnaNUAYm3sCFH8XB+IiN+nupcGn5vM2vzf4EoSZERLH0U4eODSLKII0gKg
         PQPPgpEwEAcmDi7C9SSi0e+bncDFt8j35XW3dlUMsRvdsd92HV7JIs2dyYWGi2YgBSih
         nsb78avEEPIFfAmI+rFnXj+lwn+NWHaG0DbVpnyLjWOKaZ6CZLFOIQLwPLY/421dFwOi
         wCjjdBpRyCqZmcmp6JNSBpioX1f+iToR3aJqivtusR/TVtutL2fsyaj3cNm3klBKLBXP
         zpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAwQ9LVyIFWBKXz/TI6Swpz/rhuCBFkGBlH2JYqYieCcZLGnNFoUDTZi889670bRDrRbcZsTsUFZL1zLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkWjxK5Ien4e6hLpb7r1LFax31r7fwg4fx4q8xU0OsK/cpTCR
	Duv6u1L3+k4DgoFKe6FbYsd2GgmjI5zj4+SocNVya4jThdw3vksR
X-Gm-Gg: ASbGncu/1OTqbPgQ/lAdM8WB/fEspVptO+2e3kjsxWHiYZKQ67rHkrqKxH7rkxuHQ/h
	d9GKBEB+2xOjy7GzNu04E9fUKFc+9iqs96Wwz0HTcHG7gvUnx8V4r5ad5LQv/nh+7Z9QKXhzWcU
	REElqqEIHzqtgv+cXBZqiEgcBGWexvJTSA+WP8nxJpu2a5uPCYHZX6wRb3UZdCozSV23VchDlTb
	PybelhefJI0BJn6Dz6dAiXCPllcJmWpVlp7g4EhAHxg2oOG7cJE1feIYS7zsXlky31Zuk0ouAhf
	xQr++dy/GH/7myvwUIOzdY7WT0/V7zzPhLIpijRtBL4f1iN4eudHgqo=
X-Google-Smtp-Source: AGHT+IEdTzwUl491Lo3IGpsgVfAmXzJqFtxM9eDgUmVh/3vTRIKANJ3UBFfhbV00zb/svUrQHNnLXA==
X-Received: by 2002:a17:903:2412:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-225e0af4fe0mr42137685ad.40.1741962584486;
        Fri, 14 Mar 2025 07:29:44 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe833sm29142445ad.183.2025.03.14.07.29.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Mar 2025 07:29:44 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: will@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	longman@redhat.com,
	mhiramat@kernel.org,
	anna.schumaker@oracle.com,
	boqun.feng@gmail.com,
	joel.granados@kernel.org,
	kent.overstreet@linux.dev,
	leonylgao@tencent.com,
	linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	amaindex@outlook.com,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 3/3] samples: add hung_task detector semaphore blocking sample
Date: Fri, 14 Mar 2025 22:28:38 +0800
Message-ID: <20250314142839.24910-4-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250314142839.24910-1-ioworker0@gmail.com>
References: <20250314142839.24910-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Li <amaindex@outlook.com>

Add a hung_task detector semaphore blocking test sample code.

This module will create a dummy file on the debugfs. That file will cause
the read process to sleep for a sufficiently long time (256 seconds)
while holding a semaphore. As a result, the second process will wait on
the semaphore for a prolonged duration and be detected by the hung_task
detector.

Usage is;

 > cd /sys/kernel/debug/hung_task
 > cat semaphore & cat semaphore

and wait for hung_task message.

Signed-off-by: Lance Yang <ioworker0@gmail.com>
Signed-off-by: Zi Li <amaindex@outlook.com>
---
 samples/Kconfig                         | 11 ++--
 samples/hung_task/Makefile              |  3 +-
 samples/hung_task/hung_task_mutex.c     | 20 ++++---
 samples/hung_task/hung_task_semaphore.c | 74 +++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 12 deletions(-)
 create mode 100644 samples/hung_task/hung_task_semaphore.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 09011be2391a..3a073d6b848b 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -304,10 +304,13 @@ config SAMPLE_HUNG_TASK
 	tristate "Hung task detector test code"
 	depends on DETECT_HUNG_TASK && DEBUG_FS
 	help
-	  Build a module which provide a simple debugfs file. If user reads
-	  the file, it will sleep long time (256 seconds) with holding a
-	  mutex. Thus if there are 2 or more processes read this file, it
-	  will be detected by the hung_task watchdog.
+	  Build multiple modules to test the hung task detector. Each module
+	  provides a simple debugfs file corresponding to a specific
+	  synchronization primitive (e.g., mutex, semaphore, etc.). When the
+	  file is read, the module will sleep for a long time (256 seconds)
+	  while holding the respective synchronizer. If multiple processes
+	  attempt to read these files concurrently, the hung_task watchdog
+	  can detect potential hangs or deadlocks.
 
 source "samples/rust/Kconfig"
 
diff --git a/samples/hung_task/Makefile b/samples/hung_task/Makefile
index fe9dde799880..7483c2c0a0ef 100644
--- a/samples/hung_task/Makefile
+++ b/samples/hung_task/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
\ No newline at end of file
+obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
+obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_semaphore.o
\ No newline at end of file
diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/hung_task_mutex.c
index 7a29f2246d22..e4d1d69618b8 100644
--- a/samples/hung_task/hung_task_mutex.c
+++ b/samples/hung_task/hung_task_mutex.c
@@ -22,7 +22,7 @@
 
 static const char dummy_string[] = "This is a dummy string.";
 static DEFINE_MUTEX(dummy_mutex);
-struct dentry *hung_task_dir;
+static struct dentry *hung_task_dir;
 
 static ssize_t read_dummy(struct file *file, char __user *user_buf,
 			  size_t count, loff_t *ppos)
@@ -43,19 +43,25 @@ static const struct file_operations hung_task_fops = {
 
 static int __init hung_task_sample_init(void)
 {
-	hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
-	if (IS_ERR(hung_task_dir))
-		return PTR_ERR(hung_task_dir);
+	hung_task_dir = debugfs_lookup(HUNG_TASK_DIR, NULL);
+	if (!hung_task_dir) {
+		hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
+		if (IS_ERR(hung_task_dir))
+			return PTR_ERR(hung_task_dir);
+	}
 
-	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir,
-			    NULL, &hung_task_fops);
+	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir, NULL,
+			    &hung_task_fops);
 
 	return 0;
 }
 
 static void __exit hung_task_sample_exit(void)
 {
-	debugfs_remove_recursive(hung_task_dir);
+	debugfs_lookup_and_remove(HUNG_TASK_FILE, hung_task_dir);
+
+	if (simple_empty(hung_task_dir))
+		debugfs_remove(hung_task_dir);
 }
 
 module_init(hung_task_sample_init);
diff --git a/samples/hung_task/hung_task_semaphore.c b/samples/hung_task/hung_task_semaphore.c
new file mode 100644
index 000000000000..a5814971bfb8
--- /dev/null
+++ b/samples/hung_task/hung_task_semaphore.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * hung_task_semaphore.c - Sample code which causes hung task by semaphore
+ *
+ * Usage: load this module and read `<debugfs>/hung_task/semaphore`
+ *        by 2 or more processes.
+ *
+ * This is for testing kernel hung_task error message.
+ * Note that this will make your system freeze and maybe
+ * cause panic. So do not use this except for the test.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/semaphore.h>
+
+#define HUNG_TASK_DIR   "hung_task"
+#define HUNG_TASK_FILE  "semaphore"
+#define SLEEP_SECOND 256
+
+static const char dummy_string[] = "This is a dummy string.";
+static DEFINE_SEMAPHORE(dummy_sem, 1);
+static struct dentry *hung_task_dir;
+
+static ssize_t read_dummy(struct file *file, char __user *user_buf,
+			  size_t count, loff_t *ppos)
+{
+	/* If the second task waits on the semaphore, it is uninterruptible sleep. */
+	down(&dummy_sem);
+
+	/* When the first task sleep here, it is interruptible. */
+	msleep_interruptible(SLEEP_SECOND * 1000);
+
+	up(&dummy_sem);
+
+	return simple_read_from_buffer(user_buf, count, ppos, dummy_string,
+				       sizeof(dummy_string));
+}
+
+static const struct file_operations hung_task_fops = {
+	.read = read_dummy,
+};
+
+static int __init hung_task_sample_init(void)
+{
+	hung_task_dir = debugfs_lookup(HUNG_TASK_DIR, NULL);
+	if (!hung_task_dir) {
+		hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
+		if (IS_ERR(hung_task_dir))
+			return PTR_ERR(hung_task_dir);
+	}
+
+	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir, NULL,
+			    &hung_task_fops);
+
+	return 0;
+}
+
+static void __exit hung_task_sample_exit(void)
+{
+	debugfs_lookup_and_remove(HUNG_TASK_FILE, hung_task_dir);
+
+	if (simple_empty(hung_task_dir))
+		debugfs_remove(hung_task_dir);
+}
+
+module_init(hung_task_sample_init);
+module_exit(hung_task_sample_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Zi Li");
+MODULE_DESCRIPTION("Simple sleep under semaphore file for testing hung task");
-- 
2.45.2


