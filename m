Return-Path: <linux-kernel+bounces-525912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6AA3F748
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E927ACA15
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572EA21019A;
	Fri, 21 Feb 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksk3S1tg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A420B80A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148214; cv=none; b=WpNtmsYcUMvvuH/ZIMv8GYbUFaxTw1I79bC2evO1Tfr4iH0qglzgDOY4hUud4xya03NdIwz1c+Z+NTdMDzOPCsMX1aryddFBMdolr8MDpSioL7JKZYgBZxMiBz39ed1MtOFBzvO6yCPcCWuP9Sz4sp9fXevbRv0I98uJU2H5DrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148214; c=relaxed/simple;
	bh=yRt/VaZXQuh0DYvzuCq9THX6LnIgF5KQbpuqcMQ4SZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOdvbjDxWrO/xU4RKF+x27xBu+fqYMmkMg4U/cHkBbrW5qTLl2H2Hn7/b6nc+qY+niuH8uMA2nEsC2pKA3NsceIWYSFx7f/u+Vb+SfTxhfFBv+k+sVrRavqkdirp1ZNaU4Uxn9Eix/3UbwUrXih03bFgc6/O0dQrF4FUZIR1sp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksk3S1tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116EDC4CED6;
	Fri, 21 Feb 2025 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740148214;
	bh=yRt/VaZXQuh0DYvzuCq9THX6LnIgF5KQbpuqcMQ4SZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksk3S1tgYuROL7UgfHUrXCnpirZOHp1GEEzJx56LQVwdwK0q8OD3m2ByYUp+IyJbG
	 1L8g58dUPlnuRJYwb7AKBg4Vj+JpSNa7rKh7t9y0xWTUdSUuuS3iMDi+iGdbWoK0D/
	 bjvXkfDMLX6WW3yyqWV6lPSRSo6GMs5TviI7d6mlVG07179/bugan8Vt1hnOO87RLx
	 ly7CSZ0unrVCVk+ZfKwtmiBthadPLPficgKRAEIVaXmhRcksYH7CZxjKa3iFeDJvPo
	 OUQ7oOpF06OFEHXEzyw2MoGRHUP0e9C2p8rTPeSQwiwJPjnN++tEAXndA6IBiJFI1/
	 9trgp4Cd0+wSw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Joel Granados <joel.granados@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Lance Yang <ioworker0@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Yongliang Gao <leonylgao@tencent.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] samples: Add hung_task detector mutex blocking sample
Date: Fri, 21 Feb 2025 23:30:10 +0900
Message-ID:  <174014821034.967666.8904118579315019613.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To:  <174014819072.967666.10146255401631551816.stgit@mhiramat.tok.corp.google.com>
References:  <174014819072.967666.10146255401631551816.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add a hung_task detector mutex blocking test sample code.

This module will create a dummy file on the debugfs. That file will
cause the read process to sleep for enough long time (256 seconds)
while holding a mutex. As a result, the second process will wait on
the mutex for a prolonged duration and be detected by the hung_task
detector.

Usage is;

 > cd /sys/kernel/debug/hung_task
 > cat mutex & cat mutex

and wait for hung_task message.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 samples/Kconfig                     |    9 +++++
 samples/Makefile                    |    1 +
 samples/hung_task/Makefile          |    2 +
 samples/hung_task/hung_task_mutex.c |   66 +++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)
 create mode 100644 samples/hung_task/Makefile
 create mode 100644 samples/hung_task/hung_task_mutex.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 820e00b2ed68..09011be2391a 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -300,6 +300,15 @@ config SAMPLE_CHECK_EXEC
 	  demonstrate how they should be used with execveat(2) +
 	  AT_EXECVE_CHECK.
 
+config SAMPLE_HUNG_TASK
+	tristate "Hung task detector test code"
+	depends on DETECT_HUNG_TASK && DEBUG_FS
+	help
+	  Build a module which provide a simple debugfs file. If user reads
+	  the file, it will sleep long time (256 seconds) with holding a
+	  mutex. Thus if there are 2 or more processes read this file, it
+	  will be detected by the hung_task watchdog.
+
 source "samples/rust/Kconfig"
 
 source "samples/damon/Kconfig"
diff --git a/samples/Makefile b/samples/Makefile
index f24cd0d72dd0..bf6e6fca5410 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
 obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
 obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
+obj-$(CONFIG_SAMPLE_HUNG_TASK)		+= hung_task/
diff --git a/samples/hung_task/Makefile b/samples/hung_task/Makefile
new file mode 100644
index 000000000000..fe9dde799880
--- /dev/null
+++ b/samples/hung_task/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SAMPLE_HUNG_TASK) += hung_task_mutex.o
\ No newline at end of file
diff --git a/samples/hung_task/hung_task_mutex.c b/samples/hung_task/hung_task_mutex.c
new file mode 100644
index 000000000000..7a29f2246d22
--- /dev/null
+++ b/samples/hung_task/hung_task_mutex.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * hung_task_mutex.c - Sample code which causes hung task by mutex
+ *
+ * Usage: load this module and read `<debugfs>/hung_task/mutex`
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
+#include <linux/mutex.h>
+
+#define HUNG_TASK_DIR   "hung_task"
+#define HUNG_TASK_FILE  "mutex"
+#define SLEEP_SECOND 256
+
+static const char dummy_string[] = "This is a dummy string.";
+static DEFINE_MUTEX(dummy_mutex);
+struct dentry *hung_task_dir;
+
+static ssize_t read_dummy(struct file *file, char __user *user_buf,
+			  size_t count, loff_t *ppos)
+{
+	/* If the second task waits on the lock, it is uninterruptible sleep. */
+	guard(mutex)(&dummy_mutex);
+
+	/* When the first task sleep here, it is interruptible. */
+	msleep_interruptible(SLEEP_SECOND * 1000);
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				dummy_string, sizeof(dummy_string));
+}
+
+static const struct file_operations hung_task_fops = {
+	.read = read_dummy,
+};
+
+static int __init hung_task_sample_init(void)
+{
+	hung_task_dir = debugfs_create_dir(HUNG_TASK_DIR, NULL);
+	if (IS_ERR(hung_task_dir))
+		return PTR_ERR(hung_task_dir);
+
+	debugfs_create_file(HUNG_TASK_FILE, 0400, hung_task_dir,
+			    NULL, &hung_task_fops);
+
+	return 0;
+}
+
+static void __exit hung_task_sample_exit(void)
+{
+	debugfs_remove_recursive(hung_task_dir);
+}
+
+module_init(hung_task_sample_init);
+module_exit(hung_task_sample_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Masami Hiramatsu");
+MODULE_DESCRIPTION("Simple sleep under mutex file for testing hung task");


