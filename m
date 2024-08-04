Return-Path: <linux-kernel+bounces-273650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029F946BB6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BEF0B21A76
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439413AA3F;
	Sun,  4 Aug 2024 00:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CTyCE+HI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qfoZd1Th"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF422219F3
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732718; cv=none; b=gkWAnB7Jp3Y2Emc9t1/BlVyWwXCv9XB2QpLRR0pRdvSCWaeacbkcEkRaZkoaUTSbl1NKzZkTBBcyyj6q/Rl1hCBPmHoCEMqXFrZCLe8vxt8om+HcKMbSDK5yky2zx4R/4fS7qeXeirKgTJIObx16OtEZIOHREjHqrL+PS//raLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732718; c=relaxed/simple;
	bh=fHRlbO82M1ecm4QKgz9Fg4ODXedTXW3RX8ny9eOnknA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UNugYcsT/kUtcXKVc/05TuCVbolmlqA8RDHal/GbZO/kl14nPg3zWzUOtEa9DhyPOGinzhJ/RFfL+ZUpsoLnOYvIBXNs+qLZ1xZTCBQHe4mRY2lshM4WhdPL+ebKDqRR1l6Qn+kL8W1N/YjejqTrcht8LsVnOstii35K0yDoI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CTyCE+HI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qfoZd1Th; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzRalWX9fgWLr4aSPnKrAfljE47gc8TiN9BZAtLeu0o=;
	b=CTyCE+HIxBWala6WkQUkSaazAjaYD//RbMJIubYWed2CtWH6ZscVLxafVIFKJmJAAjz4f5
	eYufsKM2EicrM9IhkRBfIXmyX1LZLZJ2VXMlG7YvLlrItUNN8xk5duqe4clxbtReeeYusX
	gY1Hbtw1p/pAwMnCSYkiUv4L41pnK6NXwHVAg0sG3FhMt7yUSAfZvLyrQFIuKZn8iyD+kN
	8S0R6RvoNM3qtsnFPFqoB+NgUwPjNHXtNnMMOd+zEyU+kxF8mX3AGMqQoEoNWGE7/V0KQ5
	xZiS+2jT6MklQMnVU/O2nqVTYjHX8kMRdJOtV+LLWljIIJUWNMnAKaYXn3CRhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzRalWX9fgWLr4aSPnKrAfljE47gc8TiN9BZAtLeu0o=;
	b=qfoZd1ThjeYVN7tpBPLAOZVR5RdOJubhE7WqJyGYVXDkOE5PexmijH2Wy2rei5a2hZo/9D
	C+rRvzcfCvZ7XbCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 27/35] printk: Avoid console_lock dance if no legacy or boot consoles
Date: Sun,  4 Aug 2024 02:57:30 +0206
Message-Id: <20240804005138.3722656-28-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the console lock is used to attempt legacy-type
printing even if there are no legacy or boot consoles registered.
If no such consoles are registered, the console lock does not
need to be taken.

Add tracking of legacy console registration and use it with
boot console tracking to avoid unnecessary code paths, i.e.
do not use the console lock if there are no boot consoles
and no legacy consoles.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f61ecb84c3f6..a172c545e8dd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -463,6 +463,13 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
+/*
+ * Specifies if a legacy console is registered. If legacy consoles are
+ * present, it is necessary to perform the console lock/unlock dance
+ * whenever console flushing should occur.
+ */
+static bool have_legacy_console;
+
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
  * nbcon consoles cannot print simultaneously and must be synchronized by
@@ -471,6 +478,14 @@ static DEFINE_MUTEX(syslog_lock);
  */
 bool have_boot_console;
 
+/*
+ * Specifies if the console lock/unlock dance is needed for console
+ * printing. If @have_boot_console is true, the nbcon consoles will
+ * be printed serially along with the legacy consoles because nbcon
+ * consoles cannot print simultaneously with boot consoles.
+ */
+#define printing_via_unlock (have_legacy_console || have_boot_console)
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -2339,7 +2354,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && printing_via_unlock) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2359,7 +2374,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	if (in_sched)
+	if (in_sched && printing_via_unlock)
 		defer_console_output();
 	else
 		wake_up_klogd();
@@ -2718,7 +2733,7 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen) {
+	if (!cpuhp_tasks_frozen && printing_via_unlock) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
@@ -3625,6 +3640,7 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_NBCON) {
 		nbcon_seq_force(newcon, init_seq);
 	} else {
+		have_legacy_console = true;
 		newcon->seq = init_seq;
 	}
 
@@ -3701,6 +3717,7 @@ EXPORT_SYMBOL(register_console);
 static int unregister_console_locked(struct console *console)
 {
 	bool use_device_lock = (console->flags & CON_NBCON) && console->write_atomic;
+	bool found_legacy_con = false;
 	bool found_boot_con = false;
 	unsigned long flags;
 	struct console *c;
@@ -3768,9 +3785,13 @@ static int unregister_console_locked(struct console *console)
 	for_each_console(c) {
 		if (c->flags & CON_BOOT)
 			found_boot_con = true;
+		if (!(c->flags & CON_NBCON))
+			found_legacy_con = true;
 	}
 	if (!found_boot_con)
 		have_boot_console = found_boot_con;
+	if (!found_legacy_con)
+		have_legacy_console = found_legacy_con;
 
 	return res;
 }
@@ -3931,8 +3952,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	seq = prb_next_reserve_seq(prb);
 
 	/* Flush the consoles so that records up to @seq are printed. */
-	console_lock();
-	console_unlock();
+	if (printing_via_unlock) {
+		console_lock();
+		console_unlock();
+	}
 
 	for (;;) {
 		unsigned long begin_jiffies;
@@ -3945,6 +3968,12 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		 * console->seq. Releasing console_lock flushes more
 		 * records in case @seq is still not printed on all
 		 * usable consoles.
+		 *
+		 * Holding the console_lock is not necessary if there
+		 * are no legacy or boot consoles. However, such a
+		 * console could register at any time. Always hold the
+		 * console_lock as a precaution rather than
+		 * synchronizing against register_console().
 		 */
 		console_lock();
 
-- 
2.39.2


