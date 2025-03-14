Return-Path: <linux-kernel+bounces-561608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5A5A613E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EA3176A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42033202C3A;
	Fri, 14 Mar 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXl+oryi"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A7202C24
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963418; cv=none; b=BaOHOPcMRq6US+3DlGKewAJRpE86I3WFOXDnHZt1dzrvssNrEmFzv+S6Bz+x1ata4wzB4v+EiuHhmWWw5SCYGFCLlCBhgEadyMejDn/f0CtVTQXa8Fir4YCThUWJoLtBlxxJawHtqkDnyUdPyLYT+SD2xEeKkEHDJvqf9CAJx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963418; c=relaxed/simple;
	bh=RwTvuR+8zoXcFD65bjjmsvaSxIRGI2NthpF/9DgsU/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K51qk4hd4toLS81Meva85JdfoSFvFdMipSO0QBfyEyWwbBIGI8MFHyan29AjPRyma6jSMPS6jNGoBHgz/20q84t3vLpIW1ZfwKAccTbIf383z+0cOVk8UNxE6UJxzBtPpjvr7GzelCPYAYnbgrF2CRo8QR4V77Z+ET39i2j4Kf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXl+oryi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22423adf751so35341725ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741963416; x=1742568216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay65LUbO5eKcGHPVzII/RlhoUMhAUU/uSsTtf/99OL0=;
        b=gXl+oryiySXdBmqzgcKYDd+KnB/GM35Nc9/9InSw+KovcGD4gCkWje9+Ijqvz2Vi7X
         H7tOnWG6AuNKpT2uZhQF9E9Jnn8AiQu5HpyNkqNTk3PWqTZqwArsCZsS52sZt+B4o42J
         RfaDYPOMNNz7dnioPe+D1ns6Mh40BFU4/3xv5GNu14Y4IraRud+K92w1ssi8ztfaL7TZ
         BYXGwsOFE75XrhTunwVXctRzOSTKYo7MKPh8SDC0M0pCHupPwHKOFo9fnbwo48cZzkHZ
         KjxfqcdSPcL5e8h73hZWponfsGUMT604Jz903HSDBPKhnhBfq2wgNO1ZyhQhC/iNMoX8
         otXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963416; x=1742568216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay65LUbO5eKcGHPVzII/RlhoUMhAUU/uSsTtf/99OL0=;
        b=kghqjyGwzPkSBtshlW+LqTEyuxFI4+tFBg+5TFa656W0Ceu/LEWH8NJyxC5R0C89lG
         /BCE+6p+cW3Hs3jvxbGNigdEil4ucRxybKPYy9m5UMWl2Bss3QuRUcENq5f3oilqwUb8
         OBUN1XlZejo/RO32Y4VGxMm4Rgw+FC79gw0HMTGfWC5l3C2jYSYnrxyGooziSs0zdttb
         iMMeOz0BDu1Z2RZMwog/hMlYpoY02r2PYZz1PMVX6ivLScqfQ/r2tQzQi+aUk+5z5Ro9
         S5bsNBHxyRp826IeK8UcijmbqaUWLOzGDew4JvEeZWkhXp1b5XEY/yChox+1vGt3D+oX
         fX2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUB8wgyGRZHi7ohgI6VFZlZegDLVwjWtZ59NCdSYcStX0FBkannLV6yOAwCT5cMtvgMJ54zXbuS8bvUpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJprpTueOPJwt4raOwr12CN6b/li/nD0nhw5qiCtBQfMNF9eb9
	aASctYU0EbIIykV8jZRmoHkvBP2fkNcoqTwiEfbzGBvjvL9l8rhp
X-Gm-Gg: ASbGncvxZdOtEqdb7jR7n82NOJ79I86w76eeCGX+KyuxvEng5xdynbHzGGFRSb5NlCJ
	DX+J8+KBYXT7RZBtuVKsd4/0WyGcpcWMw1fXziV/elCb421BQXT8NDEAb/x91YS+YvWKqBrNQ8N
	wSOREmGUbG/8Cd+WmfXMDLP7Lf822vHYb3jxzlkkZ/IL4JHUP095UeddkRTNSTjrpyv9Uei2Y/s
	f1JKI65ewPmhQ3lZOnkun/kE7dxFlLHq6pnjxlkD2SsV1spAH6h77Tgqt9Du2BIchovKbAcksLq
	1RUEtYn9kz7RgqvTSKZL1fVqx1Hlbx5ks9PDv94L/SiHc+jz02Xuf4E=
X-Google-Smtp-Source: AGHT+IEWirJm8wWN2qO9fGJAC+n3K8y4VABKRoPpHPzNLwiOw9noSypWsA/IVtp8uT9UQO5TN2E1LA==
X-Received: by 2002:a17:902:e741:b0:224:1935:fb91 with SMTP id d9443c01a7336-225e0a84d51mr38043875ad.27.1741963416081;
        Fri, 14 Mar 2025 07:43:36 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba7280sm29228835ad.147.2025.03.14.07.43.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Mar 2025 07:43:35 -0700 (PDT)
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
Subject: [PATCH RESEND v2 3/3] samples: add hung_task detector semaphore blocking sample
Date: Fri, 14 Mar 2025 22:43:00 +0800
Message-ID: <20250314144300.32542-4-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250314144300.32542-1-ioworker0@gmail.com>
References: <20250314144300.32542-1-ioworker0@gmail.com>
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


