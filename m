Return-Path: <linux-kernel+bounces-569209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE1DA69FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3E28A3EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370C31EF36E;
	Thu, 20 Mar 2025 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itej+m5C"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACA91F4C81
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742453403; cv=none; b=AixcWjUOU6ENBrJT1Qjy3SO7WVYvufx2oqFSRClUcpLNnwz8sX5iz47GBa+BaDTSDH0YVbHELl7u9HnE39Hk05V+oNkZmrAVW4ufha8avutYnzXgVjTFhnawo9SH0ACVcjDMIWue2QOz/zv8YlGbeCKFSECCiTnQGXNxYZcHEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742453403; c=relaxed/simple;
	bh=ODHGBUPKrKAqP4VfE6D6tTebFzVEioPEUE2yIRPh+XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXD5xDaRt9biLb5qh9DfUTlqE38rINVUgTfKiARu2WyI4iplob3L0spAN6jbPneT/flsxOHJlYuJgjx2kK3+t5NkfXMsyFAj306su2rqxP2g3tlzE4BqVkrtjy7mzRjl0hT8mOGD0EY434f2UuSCM2j2HuoQyQLnryZIAloX0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itej+m5C; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223fd89d036so5707525ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 23:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742453401; x=1743058201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhCbqNpnCfaE8zH3DllA9v9+aa48ezRrrdydUEDq1QA=;
        b=itej+m5CpJwkgcliMZ9+u5cq9gqmGKU9a5CMJEbjDTIsmcsAaFTicNOJKYhHRHTypm
         g8qH83/40r8AkzwdznPPhWc/f1On/ATLyqypt5J1jFU/DIJ3EuYTTie0IzCxLYAlCFUz
         5JsqlDre6bZaVm7SxKnAUeAeD5sDX7C5E7TYS6R1OnOHvMcJFAc/a8k1a8raocVVe1Er
         v/77aObUyTjySFAff+S+gpuC9CVqKHClQnBIVt5x/neGFIGOVNO5MHSddC3xQ0E1Smci
         JJ9oNfeOMEy4QkwgaeVPePEG4/u2pqdYAis4bKQeBtUjgLdVmbEtluClovU/OApKggMZ
         QlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742453401; x=1743058201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhCbqNpnCfaE8zH3DllA9v9+aa48ezRrrdydUEDq1QA=;
        b=BCKtakj1XQ2sgsZgjYxt/vwOU+0zsxzjF2Cm4A5cMmdx22JsE2mHHbGTU5pImX9e73
         10vQ9CE9ccowPaU3dTsTEfT+Pf32U2Zuwwzva61hK8sEPi4QyH8/bK6wHjRqB1c2//9o
         XfT87/etNhH0xWXUVSRDuheFApBvB149/32YvW3nUzTPEslK0rxB3wehHxm867paOTF+
         Rim4qZ2RAPnCdlpFh329H8ZAs/pxYxMbqtvmfc0KEB4C/+96kFvziXl0bgiVPQSFrDcq
         79GXnbkrtotUDyZRjO3K1LVqT7HpGLFFt9aCrT6IbB6W8ASdMQ/F/IO0hbpwdHu09cN/
         r4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhbTcGTJkha1gffiDVZhopyHDCkk8UHPNi8StcPGlKsT0Q9TGOVcd4CRPPJbJzzifqWgPiak7f45jG85E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZ5sj2PHmOALTBk332V0lk91jTvdGv5cAv9f59c162KL/v1mp
	N0CSdi3hidtE5vutESC5vt1Z54kMy4P/6/7Qo6jSaFmusTWIM2yqeR7rFOhC
X-Gm-Gg: ASbGncvZmiS6ArseT1eK0sZvtYF+iXrMiWawpKzhyNp+b1bbOmHnC5Rp0thPRjQe0g0
	pFlqJihFSEQBZwOaZhHx+dbx4jdbv3FrYFqCR/rDb7L1LZXzrZYHStYlTNtns3NdC2cdwXbkyI0
	mmU6My8RJNBYQuy8ZCTRs/ICK2iJ+453eTZE64zxZVtle6nc61S2ys6keFYqlzTd8gQQeW6kwFr
	uGi6g8fcWuoQHD+vs3+X6zx5N+PCqMgFtlKNW9VhT88rcHSX8+KSocRhiPNvJDzCTgdrbr2ry0W
	vuM2iry099dVM2NHoLk0XvDZrfKBo/DLej650oOg6SnEj/oe1vxc7LXX1ncxuuI=
X-Google-Smtp-Source: AGHT+IHZD1t7I1qHKGxY1sjtj9w2oXmXmmEJvpBfcSZbblUhlcPEBJAsnZ5oZCS0S2hbGvML46vvtA==
X-Received: by 2002:a17:902:f70c:b0:215:9bc2:42ec with SMTP id d9443c01a7336-22649cb4d2emr82996815ad.47.1742453400990;
        Wed, 19 Mar 2025 23:50:00 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68885a1sm127260155ad.13.2025.03.19.23.49.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Mar 2025 23:50:00 -0700 (PDT)
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
Subject: [PATCH v4 3/3] samples: extend hung_task detector test with semaphore support
Date: Thu, 20 Mar 2025 14:49:23 +0800
Message-ID: <20250320064923.24000-4-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320064923.24000-1-ioworker0@gmail.com>
References: <20250320064923.24000-1-ioworker0@gmail.com>
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
such as 'mutex' and 'semaphore'. The read process on any of these files
will sleep for enough long time (256 seconds) while holding the respective
lock. As a result, the second process will wait on the lock for a prolonged
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
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
index f4d6ab563488..86036f1a204d 100644
--- a/samples/hung_task/Makefile
+++ b/samples/hung_task/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
+obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_tests.o
diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/hung_task_mutex.c
deleted file mode 100644
index 47ed38239ea3..000000000000
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
-static struct dentry *hung_task_dir;
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


