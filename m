Return-Path: <linux-kernel+bounces-567470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D5A68671
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382D37A3E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62996250C1E;
	Wed, 19 Mar 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lATh1+H7"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06492512CF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371930; cv=none; b=LnmBAa39NSBucAz99EiSE+Nmgrwf77zp2ylNpvXG7r/cSt7lCxpYKtuUMAozl3qnQVIGcsfsc1SSb1zLS0X+b/CyBq9qKqveJChypOocEt4+jQCwa1v6XTkLXRlBqMEkBoLt1JvkGA65JG6Riw087LsQAOLFFsGxc2KrP/F9vDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371930; c=relaxed/simple;
	bh=7rPZTeGhdI3Ln/Z1N9HwWMHQseHL4s9TkJyTiDkBXYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9Rn3TYraYyI94sLnufs5z1l7kyvWxZsVzLZc0BVzQoG2tzYRH0EClAmaQSyZjlXExhR8v8mmOd0Q1SHwY22HBW1gzGYAEvrPBZ6+ehwF02DXaicd6bJROuDnP9cNWd+y6E2baRFpQpweQDoUg4O/SOCVexJj2HlhMXAqwmoPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lATh1+H7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so855805a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742371928; x=1742976728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR30uU4szHa/1P3ked4ixlsJHVltwDf5YGhf0SDzuac=;
        b=lATh1+H7DG3F4fuCo7+TuRfv5UZjiLqIzxWgMeWfGHRCP+TfCNPuBbOHXOo2mEAxYb
         JneeJ00rP3tI65eRKKkLRODwSQMim2p4GxlKgxp1JCqoo50d+yPCff4H9ZYhKKry4HIA
         MzzseEDKac/zEUXxqdOOwdoJorzmAplZtgB7H/HfH3JdOwZI3FfoYLoLFgYFTN91GLpH
         yYnnk2RLdSUGRdMVgebU7lxpb+DuVswnDI72aYbJtK9U5Q0WS4nw3Vn8gFW/EA5ehKni
         tcGyCYvT6jN3+omSXxue9CxwU+bJT7pxMLgLVZwruW5p9oJFTbJw2OoPRwIrTvLv5/zB
         P3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742371928; x=1742976728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR30uU4szHa/1P3ked4ixlsJHVltwDf5YGhf0SDzuac=;
        b=o796ztJkVeLxiJQIUBAbxnxsvL2kkI8dICuwuaeLi92Za0VZD3dc5/aE9NiEWtTrkj
         dOeZpPz4yqzg45hS5xhQB0zYOeLCBrzlF7dcWbNzSgPCTaIbmQq8+iwdzPDeI6tpQsLM
         F+kKfod7RBY6ucmaM2jeZD1NVfyNMaiSthtL/e2Y/K5GSi9FsdPuzxvIlcibvYsCzqKo
         Lh6jY22UtGz9YSsuTJJUBpAGzlevYTrMz3TqaZNJWM06Is3ors7jr8o4SmkRLA3HfSn+
         2rCU0Da06Q3f8qRBf+IukhVCzZfykaImKHC5DdvBqMTFKfAFgQAaM4BLd+hElUqq5gVk
         5rCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnPVKR5KOicqBbKaR5pNQGmAtq1myyQzTcNpr2Fg8IfuAqLnvKpSebdPYSZSnqQNhXEmq0qBHIN0SCvPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyruqfLMKreBeyAcnAgQE1NPNNu6tp8LKFqwi4umfN2snJAvLr+
	4/mOrG2AHkAwBrXUKpVHtdqPu0fPLBSat8AujIY4aaBwifJdLKbT
X-Gm-Gg: ASbGncsW/u2GBwWV4bRhz2Vu0iy6SFKB1QUEmDIkWegYmEAUy0fS1spxgFXEpKEyiWD
	zbIKyqkJ98mVit9wQOpI/0QLdek7V/9J6oLd4/iGIlm6lKxXFhuXgRZgT5/U6DO8lKHf9YmtezA
	P8a73egd4W2USvlCqrdCLKj6y0EZYxMXdy/+vVBpSJ7ZmwP9/pMEYsrk1bERIoogmVWuvZMyWNU
	ljPlL4i12/aeRD9EplZXAczQrgjHYuqM3y6O9awfjkcv6Nx/tJL3HBFTTX9B4tuXPHCxfUqXGcx
	Iqied4gqyHZ5sdT5+P8hWh7tOOPZm2aCzSqM4GjDowReDY+Ac4a6G9zi01tM
X-Google-Smtp-Source: AGHT+IHo2DNGtYbveJRzVDoK2c7abC2UjdVFIlVaNLgUXoNv97fpNm9ks1c8+AINXFaaTn4gnsGx5g==
X-Received: by 2002:a17:90b:4a48:b0:2f9:d0cd:3403 with SMTP id 98e67ed59e1d1-301bdb11b37mr2766337a91.16.1742371927909;
        Wed, 19 Mar 2025 01:12:07 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68887bfsm108059455ad.34.2025.03.19.01.12.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 01:12:07 -0700 (PDT)
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
	jstultz@google.com,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v3 3/3] samples: extend hung_task detector test with semaphore support
Date: Wed, 19 Mar 2025 16:11:38 +0800
Message-ID: <20250319081138.25133-4-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250319081138.25133-1-ioworker0@gmail.com>
References: <20250319081138.25133-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Li <amaindex@outlook.com>

Extend the existing hung_task detector test module to support multiple lock
types, including mutex and semaphore, with room for future additions (e.g.,
spinlock, etc.). This module creates dummy files under <debugfs>/hung_task,
such as 'mutex' and 'semaphore'. The read process on any of these files will
sleep for enough long time (256 seconds) while holding the respective lock.
As a result, the second process will wait on the lock for a prolonged
duration and be detected by the hung_task detector.

This change unifies the previous mutex-only sample into a single,
extensible hung_task_tests module, reducing code duplication and improving
maintainability.

Usage is:

	> cd /sys/kernel/debug/hung_task
	> cat mutex & cat mutex          # Test mutex blocking
	> cat semaphore & cat semaphore  # Test semaphore blocking

Update the Kconfig description to reflect multiple debugfs files support.

Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
Signed-off-by: Zi Li <amaindex@outlook.com>
---
 samples/Kconfig                     |  9 +--
 samples/hung_task/Makefile          |  2 +-
 samples/hung_task/hung_task_mutex.c | 66 --------------------
 samples/hung_task/hung_task_tests.c | 97 +++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 71 deletions(-)
 delete mode 100644 samples/hung_task/hung_task_mutex.c
 create mode 100644 samples/hung_task/hung_task_tests.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 09011be2391a..753ed1f170b5 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -304,10 +304,11 @@ config SAMPLE_HUNG_TASK
 	tristate "Hung task detector test code"
 	depends on DETECT_HUNG_TASK && DEBUG_FS
 	help
-	  Build a module which provide a simple debugfs file. If user reads
-	  the file, it will sleep long time (256 seconds) with holding a
-	  mutex. Thus if there are 2 or more processes read this file, it
-	  will be detected by the hung_task watchdog.
+	  Build a module that provides debugfs files (e.g., mutex, semaphore,
+	  etc.) under <debugfs>/hung_task. If user reads one of these files,
+	  it will sleep long time (256 seconds) with holding a lock. Thus,
+	  if 2 or more processes read the same file concurrently, it will
+	  be detected by the hung_task watchdog.
 
 source "samples/rust/Kconfig"
 
diff --git a/samples/hung_task/Makefile b/samples/hung_task/Makefile
index fe9dde799880..86036f1a204d 100644
--- a/samples/hung_task/Makefile
+++ b/samples/hung_task/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
\ No newline at end of file
+obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_tests.o
diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/hung_task_mutex.c
deleted file mode 100644
index 7a29f2246d22..000000000000
--- a/samples/hung_task/hung_task_mutex.c
+++ /dev/null
@@ -1,66 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * hung_task_mutex.c - Sample code which causes hung task by mutex
- *
- * Usage: load this module and read `<debugfs>/hung_task/mutex`
- *        by 2 or more processes.
- *
- * This is for testing kernel hung_task error message.
- * Note that this will make your system freeze and maybe
- * cause panic. So do not use this except for the test.
- */
-
-#include <linux/debugfs.h>
-#include <linux/delay.h>
-#include <linux/fs.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-
-#define HUNG_TASK_DIR   "hung_task"
-#define HUNG_TASK_FILE  "mutex"
-#define SLEEP_SECOND 256
-
-static const char dummy_string[] = "This is a dummy string.";
-static DEFINE_MUTEX(dummy_mutex);
-struct dentry *hung_task_dir;
-
-static ssize_t read_dummy(struct file *file, char __user *user_buf,
-			  size_t count, loff_t *ppos)
-{
-	/* If the second task waits on the lock, it is uninterruptible sleep. */
-	guard(mutex)(&dummy_mutex);
-
-	/* When the first task sleep here, it is interruptible. */
-	msleep_interruptible(SLEEP_SECOND * 1000);
-
-	return simple_read_from_buffer(user_buf, count, ppos,
-				dummy_string, sizeof(dummy_string));
-}
-
-static const struct file_operations hung_task_fops = {
-	.read = read_dummy,
-};
-
-static int __init hung_task_sample_init(void)
-{
-	hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
-	if (IS_ERR(hung_task_dir))
-		return PTR_ERR(hung_task_dir);
-
-	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir,
-			    NULL, &hung_task_fops);
-
-	return 0;
-}
-
-static void __exit hung_task_sample_exit(void)
-{
-	debugfs_remove_recursive(hung_task_dir);
-}
-
-module_init(hung_task_sample_init);
-module_exit(hung_task_sample_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Masami Hiramatsu");
-MODULE_DESCRIPTION("Simple sleep under mutex file for testing hung task");
diff --git a/samples/hung_task/hung_task_tests.c b/samples/hung_task/hung_task_tests.c
new file mode 100644
index 000000000000..a5c09bd3a47d
--- /dev/null
+++ b/samples/hung_task/hung_task_tests.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * hung_task_tests.c - Sample code for testing hung tasks with mutex,
+ * semaphore, etc.
+ *
+ * Usage: Load this module and read `<debugfs>/hung_task/mutex`,
+ *        `<debugfs>/hung_task/semaphore`, etc., with 2 or more processes.
+ *
+ * This is for testing kernel hung_task error messages with various locking
+ * mechanisms (e.g., mutex, semaphore, etc.). Note that this may freeze
+ * your system or cause a panic. Use only for testing purposes.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+
+#define HUNG_TASK_DIR		"hung_task"
+#define HUNG_TASK_MUTEX_FILE	"mutex"
+#define HUNG_TASK_SEM_FILE	"semaphore"
+#define SLEEP_SECOND		256
+
+static const char dummy_string[] = "This is a dummy string.";
+static DEFINE_MUTEX(dummy_mutex);
+static DEFINE_SEMAPHORE(dummy_sem, 1);
+static struct dentry *hung_task_dir;
+
+/* Mutex-based read function */
+static ssize_t read_dummy_mutex(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	/* Second task waits on mutex, entering uninterruptible sleep */
+	guard(mutex)(&dummy_mutex);
+
+	/* First task sleeps here, interruptible */
+	msleep_interruptible(SLEEP_SECOND * 1000);
+
+	return simple_read_from_buffer(user_buf, count, ppos, dummy_string,
+				       sizeof(dummy_string));
+}
+
+/* Semaphore-based read function */
+static ssize_t read_dummy_semaphore(struct file *file, char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	/* Second task waits on semaphore, entering uninterruptible sleep */
+	down(&dummy_sem);
+
+	/* First task sleeps here, interruptible */
+	msleep_interruptible(SLEEP_SECOND * 1000);
+
+	up(&dummy_sem);
+
+	return simple_read_from_buffer(user_buf, count, ppos, dummy_string,
+				       sizeof(dummy_string));
+}
+
+/* File operations for mutex */
+static const struct file_operations hung_task_mutex_fops = {
+	.read = read_dummy_mutex,
+};
+
+/* File operations for semaphore */
+static const struct file_operations hung_task_sem_fops = {
+	.read = read_dummy_semaphore,
+};
+
+static int __init hung_task_tests_init(void)
+{
+	hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
+	if (IS_ERR(hung_task_dir))
+		return PTR_ERR(hung_task_dir);
+
+	/* Create debugfs files for mutex and semaphore tests */
+	debugfs_create_file(HUNG_TASK_MUTEX_FILE, 0400, hung_task_dir, NULL,
+			    &hung_task_mutex_fops);
+	debugfs_create_file(HUNG_TASK_SEM_FILE, 0400, hung_task_dir, NULL,
+			    &hung_task_sem_fops);
+
+	return 0;
+}
+
+static void __exit hung_task_tests_exit(void)
+{
+	debugfs_remove_recursive(hung_task_dir);
+}
+
+module_init(hung_task_tests_init);
+module_exit(hung_task_tests_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Masami Hiramatsu <mhiramat@kernel.org>");
+MODULE_AUTHOR("Zi Li <amaindex@outlook.com>");
+MODULE_DESCRIPTION("Simple sleep under lock files for testing hung task");
-- 
2.45.2


