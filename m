Return-Path: <linux-kernel+bounces-309050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9EA966589
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F99A1C237C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE7E1BDAB5;
	Fri, 30 Aug 2024 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jr3oDtX6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AzhGqqUp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC61BAEE9
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031773; cv=none; b=g0faUCuPFD0bxapWnSmc5m1RxxWUNwY32HAURuRpsm5YSCZP6wiR4yF6hQ/iwJG81/MYwdk5nz2rb6SQVaUHiNOm3TgE8s5k6zyhBvPaL+ResbZx2x8WEB22dpWOj8/2DJ1I1/+bENpp8SndTbkhBIKte7Nbih0F2mqp8kTYkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031773; c=relaxed/simple;
	bh=GJwpqL8oZySmLddjaRONC8PnggaG2Q1DpU4VpaoVps4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UFfU1TfISTHmWsNVfxKPr8ywpurBezrGTL8LcHXCn+KgYABqTCYAHQXMKBC4YxtvSIw5NXcTaDhaAWFnSA1T2ePt07fszucAVA/J1Hlviphsy2rbS/y4SAfo/OE6kwhC5fYEWenMQK1J7k/YFjW0GqhRnItCI3uM9QM29+oZflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jr3oDtX6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AzhGqqUp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7LMz46ZyOLjNjPEBevrUlbTcLThpW9R4IOrEJIp2lg=;
	b=jr3oDtX6hyG2LyVmhYKdSZND5c+HmsMwRzEsfWXbQV7R5VG4/eU26Yv19Tj5xyOiwifOyb
	YkoRhqgDcL4Wn2ZzL7ZqcZlnqReyP2PnKcZpOH3jwu0tqSjqPjQEQbIDPwgs7P2mVCmPcL
	NFsK2nfEbT10C6w5d7MxJb16KhbDTrQ2nHm92BGtMp+32Wr0lUUVQhJR7gwd9PBbXbR8jX
	z4YpuyAwiUI+nVwO6w9i/0BqKMdV6Ifb1+qQ3ppxRGBob2HXOpmzErCKjJkPimv+TYHLiS
	lS97ryVkvcqTBNX16KG+LRVxdTqaXk8R4cmdOyK5NWToi/TkVD2mWPrUBW71Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7LMz46ZyOLjNjPEBevrUlbTcLThpW9R4IOrEJIp2lg=;
	b=AzhGqqUpGFwzhqAC18jau+mQygptq4hhdbaxjJ9gTDGQioEVUGEom/3lu747sCmB6tc3Za
	j1FQehsW+bP8/bAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 15/17] printk: Implement legacy printer kthread for PREEMPT_RT
Date: Fri, 30 Aug 2024 17:35:14 +0206
Message-Id: <20240830152916.10136-16-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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
 kernel/printk/internal.h    |  16 +++-
 kernel/printk/printk.c      | 156 ++++++++++++++++++++++++++++++++----
 kernel/printk/printk_safe.c |   4 +-
 3 files changed, 158 insertions(+), 18 deletions(-)

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
index f43cb87a7fb1..1c6afb0ed4d2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -491,6 +491,7 @@ bool legacy_allow_panic_sync;
 
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
+static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
@@ -2756,6 +2757,8 @@ void resume_console(void)
 	printk_get_console_flush_type(&ft);
 	if (ft.nbcon_offload)
 		nbcon_kthreads_wake();
+	if (ft.legacy_offload)
+		defer_console_output();
 
 	pr_flush(1000, true);
 }
@@ -3165,19 +3168,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
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
@@ -3221,6 +3212,29 @@ void console_unlock(void)
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
@@ -3448,6 +3462,8 @@ void console_start(struct console *console)
 	printk_get_console_flush_type(&ft);
 	if (is_nbcon && ft.nbcon_offload)
 		nbcon_kthread_wake(console);
+	else if (ft.legacy_offload)
+		defer_console_output();
 
 	__pr_flush(console, 1000, true);
 }
@@ -3459,6 +3475,87 @@ static int unregister_console_locked(struct console *console);
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
@@ -3508,6 +3605,27 @@ static void printk_kthreads_check_locked(void)
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
@@ -4284,9 +4402,13 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 	int pending = this_cpu_xchg(printk_pending, 0);
 
 	if (pending & PRINTK_PENDING_OUTPUT) {
-		/* If trylock fails, someone else is doing the printing */
-		if (console_trylock())
-			console_unlock();
+		if (force_legacy_kthread()) {
+			if (printk_legacy_kthread)
+				wake_up_interruptible(&legacy_wait);
+		} else {
+			if (console_trylock())
+				console_unlock();
+		}
 	}
 
 	if (pending & PRINTK_PENDING_WAKEUP)
@@ -4701,6 +4823,8 @@ void console_try_replay_all(void)
 			nbcon_atomic_flush_pending();
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


