Return-Path: <linux-kernel+bounces-259253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23F1939328
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D435EB21E72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C59172BDC;
	Mon, 22 Jul 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jx4He5EY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMMuSyJ+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957116F904
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668795; cv=none; b=I43i9IfPLFNfz+69KdD+4PlATO1ux34l3p8ydEJWG2oUxFLCpR9oov980WAJQDwVkqoKsw3QVC9KOYxjesbBs22MM4jUjDbIe0fDGTjW0Z6/Nt40Tn3uvuWygM30wposn8oA9tx6WIxCijWAQ40C3hGjBG7BCZAOxu0f6JMPQ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668795; c=relaxed/simple;
	bh=78Y+/mL30CW2wNJZ/z19mZ2+DKHPX4jUfdFat/O24P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DcxntJY8bQ/JjpBVxR939ESQxM1QXID3fSsraBKsaUFen7ndxdZIfQPK+XUT1WtYHYJOrCVcNMVpaHP8GP/jxZb/lpoXJkJ/SC+y3dvl63CP7739XYtrd5OSgd0EOi6cC/pkNP71w1/LTr7qgFdFSRwXN/DmT5kGplSuP8cJb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jx4He5EY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMMuSyJ+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPoDtEYbCFJccS865WEeFnUxysoSKgTlrtw+r66U+q4=;
	b=jx4He5EYOUdCU32wwq9qM9ih+4Osp1q06L+ItPy+rFtQ4oYw7Ie1+ggqyjgeoIbSqjrEpW
	YAvZHLwoAANpDIEsoxLHc8n57py/r2OZzMQSfCOpfidJLjjfVQghaQ/sZbl7HWQDShcwLS
	BrujVpHu/vdMEs/uPnn+rETF1VZU2z/rws7U8XBhdgduCIEDxkBw2vFbEMVUYx1Yay6XU8
	5cFO12YQ8bqZi3OyjepN+7ckcMiPSMu88BX0+vFcR0uOFwqVOE0jUD0fQ9mPtGpQggFJAC
	M9KJN7Em+/nqlzlM0mpEHFAROukEnNTUIa8pYVuhy4QaVn+//OtzCBu3kEHQmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPoDtEYbCFJccS865WEeFnUxysoSKgTlrtw+r66U+q4=;
	b=DMMuSyJ+k5Pzua5lMDWGre+JsXn+F3x+36U2aNkIKI37oTq/6vQorG4bKEWaQtfJBugnVv
	61V6ZPch3onbfcAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 17/19] printk: Implement legacy printer kthread for PREEMPT_RT
Date: Mon, 22 Jul 2024 19:25:37 +0206
Message-Id: <20240722171939.3349410-18-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write() callback of legacy consoles usually makes use of
spinlocks. This is not permitted with PREEMPT_RT in atomic
contexts.

For PREEMPT_RT, create a new kthread to handle printing of all
the legacy consoles (and nbcon consoles if boot consoles are
registered). This allows legacy consoles to work on PREEMPT_RT
without requiring modification. (However they will not have
the reliability properties guaranteed by nbcon atomic
consoles.)

Use the existing printk_kthreads_check_locked() to start/stop
the legacy kthread as needed.

Introduce the macro force_legacy_kthread() to query if the
forced threading of legacy consoles is in effect. Although
currently only enabled for PREEMPT_RT, this acts as a simple
mechanism for the future to allow other preemption models to
easily take advantage of the non-interference property provided
by the legacy kthread.

When force_legacy_kthread() is true, the legacy kthread
fulfills the role of the console_flush_type @legacy_offload by
waking the legacy kthread instead of printing via the
console_lock in the irq_work. If the legacy kthread is not
yet available, no legacy printing takes place (unless in
panic).

If for some reason the legacy kthread fails to create, any
legacy consoles are unregistered. With force_legacy_kthread(),
the legacy kthread is a critical component for legacy consoles.

These changes only affect CONFIG_PREEMPT_RT.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  19 ++++-
 kernel/printk/printk.c   | 162 +++++++++++++++++++++++++++++++++++----
 2 files changed, 162 insertions(+), 19 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index a4e7b40458b2..0ac4bdb9e3e8 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -21,6 +21,19 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 		(con->flags & CON_BOOT) ? "boot" : "",		\
 		con->name, con->index, ##__VA_ARGS__)
 
+/*
+ * Identify if legacy printing is forced in a dedicated kthread. If
+ * true, all printing via console lock occurs within a dedicated
+ * legacy printer thread. The only exception is on panic, after the
+ * nbcon consoles have had their chance to print the panic messages
+ * first.
+ */
+#ifdef CONFIG_PREEMPT_RT
+# define force_legacy_kthread()	(true)
+#else
+# define force_legacy_kthread()	(false)
+#endif
+
 #ifdef CONFIG_PRINTK
 
 #ifdef CONFIG_PRINTK_CALLER
@@ -192,7 +205,7 @@ extern bool legacy_allow_panic_sync;
  * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
  * @nbcon_offload:	Offload flush to printer thread
  * @legacy_direct:	Call the legacy loop in this context
- * @legacy_offload:	Offload the legacy loop into IRQ
+ * @legacy_offload:	Offload the legacy loop into IRQ or legacy thread
  */
 struct console_flush_type {
 	bool	nbcon_atomic;
@@ -216,7 +229,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft,
 	switch (nbcon_get_default_prio()) {
 	case NBCON_PRIO_NORMAL:
 		if (have_legacy_console || have_boot_console) {
-			if (prefer_offload || is_printk_deferred())
+			if (force_legacy_kthread() || prefer_offload || is_printk_deferred())
 				ft->legacy_offload = true;
 			else
 				ft->legacy_direct = true;
@@ -267,7 +280,7 @@ static inline void printk_get_emergency_console_flush_type(struct console_flush_
 			ft->nbcon_atomic = true;
 
 		if (have_legacy_console || have_boot_console) {
-			if (is_printk_deferred())
+			if (force_legacy_kthread() || is_printk_deferred())
 				ft->legacy_offload = true;
 			else
 				ft->legacy_direct = true;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6c9c0a42adf3..6f70d3a7153f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -488,6 +488,7 @@ bool legacy_allow_panic_sync;
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
+static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
@@ -2450,6 +2451,7 @@ static u64 syslog_seq;
 
 static bool pr_flush(int timeout_ms, bool reset_on_progress) { return true; }
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress) { return true; }
+static inline void legacy_kthread_wake(void) { }
 
 #endif /* CONFIG_PRINTK */
 
@@ -2704,6 +2706,8 @@ void resume_console(void)
 	printk_get_console_flush_type(&ft, true);
 	if (ft.nbcon_offload)
 		nbcon_wake_kthreads();
+	if (ft.legacy_offload)
+		defer_console_output();
 
 	pr_flush(1000, true);
 }
@@ -3112,19 +3116,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	return false;
 }
 
-/**
- * console_unlock - unblock the console subsystem from printing
- *
- * Releases the console_lock which the caller holds to block printing of
- * the console subsystem.
- *
- * While the console_lock was held, console output may have been buffered
- * by printk().  If this is the case, console_unlock(); emits
- * the output prior to releasing the lock.
- *
- * console_unlock(); may be called from any context.
- */
-void console_unlock(void)
+static void __console_flush_and_unlock(void)
 {
 	bool do_cond_resched;
 	bool handover;
@@ -3168,6 +3160,29 @@ void console_unlock(void)
 		 */
 	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
 }
+
+/**
+ * console_unlock - unblock the legacy console subsystem from printing
+ *
+ * Releases the console_lock which the caller holds to block printing of
+ * the legacy console subsystem.
+ *
+ * While the console_lock was held, console output may have been buffered
+ * by printk(). If this is the case, console_unlock() emits the output on
+ * legacy consoles prior to releasing the lock.
+ *
+ * console_unlock(); may be called from any context.
+ */
+void console_unlock(void)
+{
+	struct console_flush_type ft;
+
+	printk_get_console_flush_type(&ft, false);
+	if (ft.legacy_direct)
+		__console_flush_and_unlock();
+	else
+		__console_unlock();
+}
 EXPORT_SYMBOL(console_unlock);
 
 /**
@@ -3397,6 +3412,8 @@ void console_start(struct console *console)
 	flags = console_srcu_read_flags(console);
 	if ((flags & CON_NBCON) && ft.nbcon_offload)
 		nbcon_kthread_wake(console);
+	else if (!(flags & CON_NBCON) && ft.legacy_offload)
+		defer_console_output();
 	console_srcu_read_unlock(cookie);
 
 	__pr_flush(console, 1000, true);
@@ -3409,6 +3426,87 @@ static int unregister_console_locked(struct console *console);
 /* True when system boot is far enough to create printer threads. */
 static bool printk_kthreads_ready __ro_after_init;
 
+static struct task_struct *printk_legacy_kthread;
+
+static bool legacy_kthread_should_wakeup(void)
+{
+	struct console_flush_type ft;
+	struct console *con;
+	bool ret = false;
+	int cookie;
+
+	if (kthread_should_stop())
+		return true;
+
+	printk_get_console_flush_type(&ft, true);
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		short flags = console_srcu_read_flags(con);
+		u64 printk_seq;
+
+		/*
+		 * The legacy printer thread is only for legacy consoles when
+		 * the nbcon consoles have their printer threads.
+		 */
+		if ((flags & CON_NBCON) && ft.nbcon_offload)
+			continue;
+
+		if (!console_is_usable(con, flags, false))
+			continue;
+
+		if (flags & CON_NBCON) {
+			printk_seq = nbcon_seq_read(con);
+		} else {
+			/*
+			 * It is safe to read @seq because only this
+			 * thread context updates @seq.
+			 */
+			printk_seq = con->seq;
+		}
+
+		if (prb_read_valid(prb, printk_seq, NULL)) {
+			ret = true;
+			break;
+		}
+	}
+	console_srcu_read_unlock(cookie);
+
+	return ret;
+}
+
+static int legacy_kthread_func(void *unused)
+{
+	for (;;) {
+		wait_event_interruptible(legacy_wait, legacy_kthread_should_wakeup());
+
+		if (kthread_should_stop())
+			break;
+
+		console_lock();
+		__console_flush_and_unlock();
+	}
+
+	return 0;
+}
+
+static bool legacy_kthread_create(void)
+{
+	struct task_struct *kt;
+
+	lockdep_assert_console_list_lock_held();
+
+	kt = kthread_run(legacy_kthread_func, NULL, "pr/legacy");
+	if (WARN_ON(IS_ERR(kt))) {
+		pr_err("failed to start legacy printing thread\n");
+		return false;
+	}
+
+	printk_legacy_kthread = kt;
+
+	return true;
+}
+
 /**
  * printk_kthreads_shutdown - shutdown all threaded printers
  *
@@ -3458,6 +3556,27 @@ static void printk_kthreads_check_locked(void)
 	if (!printk_kthreads_ready)
 		return;
 
+	if (have_legacy_console || have_boot_console) {
+		if (!printk_legacy_kthread &&
+		    force_legacy_kthread() &&
+		    !legacy_kthread_create()) {
+			/*
+			 * All legacy consoles must be unregistered. If there
+			 * are any nbcon consoles, they will set up their own
+			 * kthread.
+			 */
+			hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+				if (con->flags & CON_NBCON)
+					continue;
+
+				unregister_console_locked(con);
+			}
+		}
+	} else if (printk_legacy_kthread) {
+		kthread_stop(printk_legacy_kthread);
+		printk_legacy_kthread = NULL;
+	}
+
 	/*
 	 * Printer threads cannot be started as long as any boot console is
 	 * registered because there is no way to synchronize the hardware
@@ -4241,14 +4360,23 @@ static bool pr_flush(int timeout_ms, bool reset_on_progress)
 
 static DEFINE_PER_CPU(int, printk_pending);
 
+static void legacy_kthread_wake(void)
+{
+	if (printk_legacy_kthread)
+		wake_up_interruptible(&legacy_wait);
+}
+
 static void wake_up_klogd_work_func(struct irq_work *irq_work)
 {
 	int pending = this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_OUTPUT) {
-		/* If trylock fails, someone else is doing the printing */
-		if (console_trylock())
-			console_unlock();
+		if (force_legacy_kthread()) {
+			legacy_kthread_wake();
+		} else {
+			if (console_trylock())
+				console_unlock();
+		}
 	}
 
 	if (pending & PRINTK_PENDING_WAKEUP)
@@ -4676,6 +4804,8 @@ void console_try_replay_all(void)
 		__console_rewind_all();
 		if (ft.nbcon_offload)
 			nbcon_wake_kthreads();
+		if (ft.legacy_offload)
+			defer_console_output();
 		/* Consoles are flushed as part of console_unlock(). */
 		console_unlock();
 	}
-- 
2.39.2


