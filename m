Return-Path: <linux-kernel+bounces-263065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E130093D092
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED341C21278
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8475817837D;
	Fri, 26 Jul 2024 09:44:47 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2CA176AB2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987087; cv=none; b=JuEdYR10Y0QV2FAWZsutEmC3FiQXwHbdC/PDjw41NqUZ2ann2XWRuUjYHkD90Clp40/r/ZiaVsluWQbBrPo5aM71SGnW0W+Eu7seH3Eq4mH6Iofm8TjiAVq69dUriB7ymRkzc/QlyUHktZBDcUPIwe9PjTe9xACfKXzrJ8vced8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987087; c=relaxed/simple;
	bh=INGOhMkkntAwmHRQOKxLjgYP+YM13K4t6mVeamWNquY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kB/QGl2V++6xPEt2iDMZ93q+LqHmP+zy7ec21VN+CLIgidWHYoladt/6Dmhu53qk6PIpMYWJWCLiYW+gSSW+eZq9lT2lWgfyY7bnBiWoztioPPcWqXgftS+s5V3FOYaB+eDX2i2ClKbn7o/HY5lYu0zXSduDm6EiVMVZpYQafI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id E7434A9D76;
	Fri, 26 Jul 2024 18:44:42 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9qJkmfzVGLZX; Fri, 26 Jul 2024 18:44:42 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id C2D88A9D63;
	Fri, 26 Jul 2024 18:44:42 +0900 (JST)
From: takakura@valinux.co.jp
To: pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	lukas@wunner.de,
	wangkefeng.wang@huawei.com,
	ubizjak@gmail.com,
	feng.tang@intel.com,
	j.granados@samsung.com,
	stephen.s.brennan@oracle.com
Cc: linux-kernel@vger.kernel.org,
	nishimura@valinux.co.jp,
	taka@valinux.co.jp,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH] printk: CPU backtrace not printing on panic
Date: Fri, 26 Jul 2024 18:44:37 +0900
Message-Id: <20240726094437.306330-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
to ringbuffer") disabled non-panic CPUs to further write messages to
ringbuffer after panicked.

Since the commit, non-panicked CPU's are not allowed to write to
ring buffer after panicked and CPU backtrace which is triggered
after panicked to sample non-panicked CPUs' backtrace no longer
serves its function as it can't print anything.

Fix the issue by allowing non-panicked CPUs to write to ringbuffer
when CPU backtrace was enabled if there is no need for message
suppression. This patch brings back commit 13fb0f74d702 ("printk:
Avoid livelock with heavy printk during panic")'s implementation
for suppressing non-panicked CPUs' messages when detected messages
being dropped.

Fixes: 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer")
Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
---

I was not really sure what the best approach would be if we want to
allow cpu backtrace to function while prioritizing the panicked CPU's 
messages. Hoping to get some feedbacks, thanks!

Sincerely,
Ryo Takakura

---
 include/linux/panic.h  |  9 +++++++++
 include/linux/printk.h |  1 +
 kernel/panic.c         | 10 +---------
 kernel/printk/printk.c | 26 ++++++++++++++++++++++++--
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 6717b15e798c..70dc17284785 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -16,6 +16,15 @@ extern void oops_enter(void);
 extern void oops_exit(void);
 extern bool oops_may_print(void);
 
+#define PANIC_PRINT_TASK_INFO		0x00000001
+#define PANIC_PRINT_MEM_INFO		0x00000002
+#define PANIC_PRINT_TIMER_INFO		0x00000004
+#define PANIC_PRINT_LOCK_INFO		0x00000008
+#define PANIC_PRINT_FTRACE_INFO		0x00000010
+#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
+#define PANIC_PRINT_ALL_CPU_BT		0x00000040
+#define PANIC_PRINT_BLOCKED_TASKS	0x00000080
+
 extern int panic_timeout;
 extern unsigned long panic_print;
 extern int panic_on_oops;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 40afab23881a..cbb4c1ec1fca 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -78,6 +78,7 @@ extern char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE];
 struct ctl_table;
 
 extern int suppress_printk;
+extern int suppress_panic_printk;
 
 struct va_format {
 	const char *fmt;
diff --git a/kernel/panic.c b/kernel/panic.c
index 8bff183d6180..8c23cd1f876e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -66,14 +66,6 @@ static unsigned int warn_limit __read_mostly;
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
 
-#define PANIC_PRINT_TASK_INFO		0x00000001
-#define PANIC_PRINT_MEM_INFO		0x00000002
-#define PANIC_PRINT_TIMER_INFO		0x00000004
-#define PANIC_PRINT_LOCK_INFO		0x00000008
-#define PANIC_PRINT_FTRACE_INFO		0x00000010
-#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
-#define PANIC_PRINT_ALL_CPU_BT		0x00000040
-#define PANIC_PRINT_BLOCKED_TASKS	0x00000080
 unsigned long panic_print;
 
 ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
@@ -252,7 +244,7 @@ void check_panic_on_warn(const char *origin)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
+	if (panic_print & PANIC_PRINT_ALL_CPU_BT && !suppress_panic_printk)
 		trigger_all_cpu_backtrace();
 
 	/*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 420fd310129d..0ac2ca1abbbf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -459,6 +459,13 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 static DEFINE_MUTEX(syslog_lock);
 
 #ifdef CONFIG_PRINTK
+
+/*
+ * During panic, heavy printk by other CPUs can delay the
+ * panic and risk deadlock on console resources.
+ */
+int __read_mostly suppress_panic_printk;
+
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -2311,9 +2318,11 @@ asmlinkage int vprintk_emit(int facility, int level,
 	/*
 	 * The messages on the panic CPU are the most important. If
 	 * non-panic CPUs are generating any messages, they will be
-	 * silently dropped.
+	 * silently dropped unless CPU backtrace on panic is enabled.
 	 */
-	if (other_cpu_in_panic())
+	if (other_cpu_in_panic() &&
+	   (!(panic_print & PANIC_PRINT_ALL_CPU_BT) ||
+	    unlikely(suppress_panic_printk)))
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
@@ -2816,6 +2825,8 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_suppress)
 {
+	static int panic_console_dropped;
+
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
@@ -2843,6 +2854,17 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 
+	/*
+	 * Check for dropped messages in panic here so that printk
+	 * suppression can occur as early as possible if necessary.
+	 */
+	if (pmsg->dropped &&
+	    panic_in_progress() &&
+	    panic_console_dropped++ > 10) {
+		suppress_panic_printk = 1;
+		pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
+	}
+
 	/* Skip record that has level above the console loglevel. */
 	if (may_suppress && suppress_message_printing(r.info->level))
 		goto out;
-- 
2.34.1


