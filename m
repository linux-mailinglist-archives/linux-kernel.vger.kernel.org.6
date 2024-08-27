Return-Path: <linux-kernel+bounces-302579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B42960078
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D272283677
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AB019AD6E;
	Tue, 27 Aug 2024 04:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ME++pZQd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+QTeLVrG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87863153BF6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733824; cv=none; b=dJDo7G0CzPyLUUwEDrmDgauQ2+lKgDaTrtZKbc3/j5TnI5BN3PBNHHG+FWMG1zFaCasvmhpNwkAqRdooc3H8C+TBIyKdfXzGLDKmo0K5X56kQMp1bAAm7YOeIMpHFdDr7/OhIdTswV9tM5PoubMufPXowK2KgFQmuhI+xM52D98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733824; c=relaxed/simple;
	bh=wiWhgZ4qdA6kZFNrmxyOxUP0rslSP+DF1bHLzzKaIBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZMdGnURf1FVdr03WrVOijCCjlz3+bWgfaLiFavoMxQQw66SKbeIb/GemSgFBy21XflmMJa6dyxvBwCh7dJQPj5UfgNudVcYu+Aftf5aL28FW0PCfjQDe/8rYeHRNi4RPXjbArD7ZxCQ9hXmeVuDQj/ozIcCekEc3/2ve3csJcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ME++pZQd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+QTeLVrG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmkCNVznyI/FEQ01aseNGP6nsv5eVM+9zeQn4iQiGas=;
	b=ME++pZQd0yvQ8nvmpfV/OR5lC90Syy7MlB8aEEw7NcMVMguU6h7Bl45otmij0TU8+PT3qw
	b/hwiUl4uzEVYdfE1cAA+6+LnGDQbsBcc8p8WqF20R1+KzTX6hk5T861OoIJPV6tdDLJoa
	qgmMAjzmbqKzNhTUp/8qhRnk5R15oWRMJ1ePtSIPf0FoC5U8svEJftvMt/e4hYbKBIoB9u
	NIIaCRkjRM2f+rzCzFXlA8172J+j1XRO3z2MyGJatAE6IwpRtjQKTHtEP0vl9VfGiZXe4P
	TUo62eW6XWvxBrYQIEUXoo60iruVAn5IY3hAsXZTuqlrxki28f45L+lRS4v4AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmkCNVznyI/FEQ01aseNGP6nsv5eVM+9zeQn4iQiGas=;
	b=+QTeLVrGLTMm0DvmeKktG99ezqQSDcLlztINYtLhMLgBbyAxg7Y8x7eTVC0hY+RxrP24kA
	70gwPc6C/JgQyyAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 15/17] printk: Implement legacy printer kthread for PREEMPT_RT
Date: Tue, 27 Aug 2024 06:49:31 +0206
Message-Id: <20240827044333.88596-16-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h    |  16 +++-
 kernel/printk/printk.c      | 162 ++++++++++++++++++++++++++++++++----
 kernel/printk/printk_safe.c |   4 +-
 3 files changed, 164 insertions(+), 18 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index c365d25b13c7..3fcb48502adb 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -21,6 +21,19 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
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
@@ -173,6 +186,7 @@ static inline void nbcon_kthread_wake(struct console *con)
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline void defer_console_output(void) { }
 static inline bool is_printk_legacy_deferred(void) { return false; }
 static inline u64 nbcon_seq_read(struct console *con) { return 0; }
 static inline void nbcon_seq_force(struct console *con, u64 seq) { }
@@ -200,7 +214,7 @@ extern bool legacy_allow_panic_sync;
  * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
  * @nbcon_offload:	Offload flush to printer thread
  * @legacy_direct:	Call the legacy loop in this context
- * @legacy_offload:	Offload the legacy loop into IRQ
+ * @legacy_offload:	Offload the legacy loop into IRQ or legacy thread
  *
  * Note that the legacy loop also flushes the nbcon consoles.
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8863519438f9..4220abe86296 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -491,6 +491,7 @@ bool legacy_allow_panic_sync;
 
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
 
@@ -2756,6 +2758,8 @@ void resume_console(void)
 	printk_get_console_flush_type(&ft);
 	if (ft.nbcon_offload)
 		nbcon_kthreads_wake();
+	if (ft.legacy_offload)
+		defer_console_output();
 
 	pr_flush(1000, true);
 }
@@ -3165,19 +3169,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
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
@@ -3221,6 +3213,29 @@ void console_unlock(void)
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
+	printk_get_console_flush_type(&ft);
+	if (ft.legacy_direct)
+		__console_flush_and_unlock();
+	else
+		__console_unlock();
+}
 EXPORT_SYMBOL(console_unlock);
 
 /**
@@ -3448,6 +3463,8 @@ void console_start(struct console *console)
 	printk_get_console_flush_type(&ft);
 	if (is_nbcon && ft.nbcon_offload)
 		nbcon_kthread_wake(console);
+	else if (!is_nbcon && ft.legacy_offload)
+		defer_console_output();
 
 	__pr_flush(console, 1000, true);
 }
@@ -3459,6 +3476,87 @@ static int unregister_console_locked(struct console *console);
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
+	printk_get_console_flush_type(&ft);
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
@@ -3508,6 +3606,27 @@ static void printk_kthreads_check_locked(void)
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
@@ -4277,14 +4396,23 @@ static bool pr_flush(int timeout_ms, bool reset_on_progress)
 
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
@@ -4697,6 +4825,8 @@ void console_try_replay_all(void)
 		__console_rewind_all();
 		if (ft.nbcon_offload)
 			nbcon_kthreads_wake();
+		if (ft.legacy_offload)
+			defer_console_output();
 		/* Consoles are flushed as part of console_unlock(). */
 		console_unlock();
 	}
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 86439fd20aab..2b35a9d3919d 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -44,7 +44,9 @@ bool is_printk_legacy_deferred(void)
 	 * The per-CPU variable @printk_context can be read safely in any
 	 * context. CPU migration is always disabled when set.
 	 */
-	return (this_cpu_read(printk_context) || in_nmi());
+	return (force_legacy_kthread() ||
+		this_cpu_read(printk_context) ||
+		in_nmi());
 }
 
 asmlinkage int vprintk(const char *fmt, va_list args)
-- 
2.39.2


