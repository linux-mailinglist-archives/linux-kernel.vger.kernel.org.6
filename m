Return-Path: <linux-kernel+bounces-293356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C4957E40
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3663282982
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2B321C19D;
	Tue, 20 Aug 2024 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a6UOAP1d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J3FaOV+X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB15205E08
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135419; cv=none; b=hiReW+nU57+MCGkUm1xdPFQVaBvkIIS3/lpcSvY1F9X8V7V8MKyjvt+xY58KOy44LU3sMgiH0FPCVu87jThF5sPMGw/VO1N3pCDQvCv91EVBznDPJl70DNYXAmslll3bA5EzTaK2Gw6tMP5eh3kAAx1od7eMjGuPIwU19CLg358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135419; c=relaxed/simple;
	bh=oHHCOFEDZ5YWw5kcWuz37LUZdox3hXaRXPJD8QdPWw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DyJ/5WusVBdA2WeuFgbOkeOuZByxQ9/siJ+k1qpthkL+Jo0Ho+bi+RYRbFqP0V9MFV/8WrD7yTVP0bWXEib3BEEMdjrxZmBo1CUxCH6fX5975GKYx1T9106WZ2U2BdrhcMCb1zwGM+ydF5r52qxoUjXgM7H8hu1Pm4KizLFdLWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a6UOAP1d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J3FaOV+X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqxRmp/AeGvsSiuO+ivTjNEKk9aVCnQ1EwsDpguXgbs=;
	b=a6UOAP1dbQneQZYSfw4EbIMz7v//KMl98AC31NJGjFkHzkHxgJddpUROT7Ad7vvmzKNWHC
	iPreO25SvfivsEtDJEPnK8k+wXBfsPA90UrWjNs86jSrwpe5qU9fMbayIQWQk1q5Va6/s6
	EsQo7cs+1UjyK5zHJ04pL73IXbDi7qF7Xa6lxrjHT+eEcWMozPv2oGirhifNEf7Q/bUJaB
	lSCX+T+oGwqoZ7vSjW5GylA3+zyyO8FBZGxy665Y+heJTIU4MNJ6Im/Gj2K0Ld9rc4l4AA
	lEh8pu2OtcXl+esPMBumQ06FwqMP7jGPH0cQ0Gn6pC37lGi1v/0FmODCRiPLNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqxRmp/AeGvsSiuO+ivTjNEKk9aVCnQ1EwsDpguXgbs=;
	b=J3FaOV+XZfx5qZzoXx7grngsF927rGuEogOc3nQItmFbj8Np3JfCzbhm8KcZdRpSStp0dj
	Tbh/3HK9lW8S4UAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 30/35] printk: Add helper for flush type logic
Date: Tue, 20 Aug 2024 08:35:56 +0206
Message-Id: <20240820063001.36405-31-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are many call sites where console flushing occur.
Depending on the system state and types of consoles, the flush
methods to use are different. A flush call site generally must
consider:

	@have_boot_console
	@have_nbcon_console
	@have_legacy_console
	@legacy_allow_panic_sync
	is_printk_preferred()

and take into account the current CPU state:

	NBCON_PRIO_NORMAL
	NBCON_PRIO_EMERGENCY
	NBCON_PRIO_PANIC

in order to decide if it should:

	flush nbcon directly via atomic_write() callback
	flush legacy directly via console_unlock
	flush legacy via offload to irq_work

All of these call sites use their own logic to make this
decision, which is complicated and error prone. Especially
later when two more flush methods will be introduced:

	flush nbcon via offload to kthread
	flush legacy via offload to kthread

Introduce a new internal struct console_flush_type that
specifies the flush method(s) that are available for a
particular call site to use.

Introduce a helper function to fill out console_flush_type to
be used for flushing call sites.

Replace the logic of all flushing call sites to use the new
helper.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h | 73 ++++++++++++++++++++++++++++++++++++++++
 kernel/printk/nbcon.c    | 12 +++++--
 kernel/printk/printk.c   | 68 +++++++++++++++++--------------------
 3 files changed, 112 insertions(+), 41 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6b61350a3026..ba2e0f1940bd 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -154,8 +154,81 @@ static inline bool console_is_usable(struct console *con, short flags) { return
 #endif /* CONFIG_PRINTK */
 
 extern bool have_boot_console;
+extern bool have_nbcon_console;
+extern bool have_legacy_console;
 extern bool legacy_allow_panic_sync;
 
+/**
+ * struct console_flush_type - Define available console flush methods
+ * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
+ * @legacy_direct:	Call the legacy loop in this context
+ * @legacy_offload:	Offload the legacy loop into IRQ
+ *
+ * Note that the legacy loop also flushes the nbcon consoles.
+ */
+struct console_flush_type {
+	bool	nbcon_atomic;
+	bool	legacy_direct;
+	bool	legacy_offload;
+};
+
+/*
+ * Identify which console flushing methods should be used in the context of
+ * the caller.
+ */
+static inline void printk_get_console_flush_type(struct console_flush_type *ft)
+{
+	memset(ft, 0, sizeof(*ft));
+
+	switch (nbcon_get_default_prio()) {
+	case NBCON_PRIO_NORMAL:
+		if (have_nbcon_console && !have_boot_console)
+			ft->nbcon_atomic = true;
+
+		/* Legacy consoles are flushed directly when possible. */
+		if (have_legacy_console || have_boot_console) {
+			if (!is_printk_legacy_deferred())
+				ft->legacy_direct = true;
+			else
+				ft->legacy_offload = true;
+		}
+		break;
+
+	case NBCON_PRIO_PANIC:
+		/*
+		 * In panic, the nbcon consoles will directly print. But
+		 * only allowed if there are no boot consoles.
+		 */
+		if (have_nbcon_console && !have_boot_console)
+			ft->nbcon_atomic = true;
+
+		if (have_legacy_console || have_boot_console) {
+			/*
+			 * This is the same decision as NBCON_PRIO_NORMAL
+			 * except that offloading never occurs in panic.
+			 *
+			 * Note that console_flush_on_panic() will flush
+			 * legacy consoles anyway, even if unsafe.
+			 */
+			if (!is_printk_legacy_deferred())
+				ft->legacy_direct = true;
+
+			/*
+			 * In panic, if nbcon atomic printing occurs,
+			 * the legacy consoles must remain silent until
+			 * explicitly allowed.
+			 */
+			if (ft->nbcon_atomic && !legacy_allow_panic_sync)
+				ft->legacy_direct = false;
+		}
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
+
 extern struct printk_buffers printk_shared_pbufs;
 
 /**
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index afdb16c1c733..18488d6c17c0 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1344,6 +1344,7 @@ EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
 void nbcon_device_release(struct console *con)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+	struct console_flush_type ft;
 	int cookie;
 
 	if (!nbcon_context_exit_unsafe(ctxt))
@@ -1359,12 +1360,17 @@ void nbcon_device_release(struct console *con)
 	cookie = console_srcu_read_lock();
 	if (console_is_usable(con, console_srcu_read_flags(con)) &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
-		if (!have_boot_console) {
+		/*
+		 * If nbcon_atomic flushing is not available, fallback to
+		 * using the legacy loop.
+		 */
+		printk_get_console_flush_type(&ft);
+		if (ft.nbcon_atomic) {
 			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
-		} else if (!is_printk_legacy_deferred()) {
+		} else if (ft.legacy_direct) {
 			if (console_trylock())
 				console_unlock();
-		} else {
+		} else if (ft.legacy_offload) {
 			printk_trigger_flush();
 		}
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fc3f8970eea2..6accd1704e73 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -468,14 +468,14 @@ static DEFINE_MUTEX(syslog_lock);
  * present, it is necessary to perform the console lock/unlock dance
  * whenever console flushing should occur.
  */
-static bool have_legacy_console;
+bool have_legacy_console;
 
 /*
  * Specifies if an nbcon console is registered. If nbcon consoles are present,
  * synchronous printing of legacy consoles will not occur during panic until
  * the backtrace has been stored to the ringbuffer.
  */
-static bool have_nbcon_console;
+bool have_nbcon_console;
 
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
@@ -488,14 +488,6 @@ bool have_boot_console;
 /* See printk_legacy_allow_panic_sync() for details. */
 bool legacy_allow_panic_sync;
 
-/*
- * Specifies if the console lock/unlock dance is needed for console
- * printing. If @have_boot_console is true, the nbcon consoles will
- * be printed serially along with the legacy consoles because nbcon
- * consoles cannot print simultaneously with boot consoles.
- */
-#define printing_via_unlock (have_legacy_console || have_boot_console)
-
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -2342,9 +2334,12 @@ int vprintk_store(int facility, int level,
  */
 void printk_legacy_allow_panic_sync(void)
 {
+	struct console_flush_type ft;
+
 	legacy_allow_panic_sync = true;
 
-	if (printing_via_unlock && !is_printk_legacy_deferred()) {
+	printk_get_console_flush_type(&ft);
+	if (ft.legacy_direct) {
 		if (console_trylock())
 			console_unlock();
 	}
@@ -2354,8 +2349,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
-	bool do_trylock_unlock = printing_via_unlock;
-	bool defer_legacy = false;
+	struct console_flush_type ft;
 	int printed_len;
 
 	/* Suppress unimportant messages after panic happens */
@@ -2370,35 +2364,23 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
 		return 0;
 
+	printk_get_console_flush_type(&ft);
+
 	/* If called from the scheduler, we can not call up(). */
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
-		defer_legacy = do_trylock_unlock;
-		do_trylock_unlock = false;
+		ft.legacy_offload |= ft.legacy_direct;
+		ft.legacy_direct = false;
 	}
 
 	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-	if (have_nbcon_console && !have_boot_console) {
+	if (ft.nbcon_atomic)
 		nbcon_atomic_flush_pending();
 
-		/*
-		 * In panic, the legacy consoles are not allowed to print from
-		 * the printk calling context unless explicitly allowed. This
-		 * gives the safe nbcon consoles a chance to print out all the
-		 * panic messages first. This restriction only applies if
-		 * there are nbcon consoles registered and they are allowed to
-		 * flush.
-		 */
-		if (this_cpu_in_panic() && !legacy_allow_panic_sync) {
-			do_trylock_unlock = false;
-			defer_legacy = false;
-		}
-	}
-
-	if (do_trylock_unlock) {
+	if (ft.legacy_direct) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2418,7 +2400,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	if (defer_legacy)
+	if (ft.legacy_offload)
 		defer_console_output();
 	else
 		wake_up_klogd();
@@ -2777,10 +2759,16 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen && printing_via_unlock) {
-		/* If trylock fails, someone else is doing the printing */
-		if (console_trylock())
-			console_unlock();
+	struct console_flush_type ft;
+
+	if (!cpuhp_tasks_frozen) {
+		printk_get_console_flush_type(&ft);
+		if (ft.nbcon_atomic)
+			nbcon_atomic_flush_pending();
+		if (ft.legacy_direct) {
+			if (console_trylock())
+				console_unlock();
+		}
 	}
 	return 0;
 }
@@ -3305,6 +3293,7 @@ static void __console_rewind_all(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	struct console_flush_type ft;
 	bool handover;
 	u64 next_seq;
 
@@ -3328,7 +3317,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (mode == CONSOLE_REPLAY_ALL)
 		__console_rewind_all();
 
-	if (!have_boot_console)
+	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_atomic)
 		nbcon_atomic_flush_pending();
 
 	/* Flush legacy consoles once allowed, even when dangerous. */
@@ -3992,6 +3982,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 {
 	unsigned long timeout_jiffies = msecs_to_jiffies(timeout_ms);
 	unsigned long remaining_jiffies = timeout_jiffies;
+	struct console_flush_type ft;
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
@@ -4005,7 +3996,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	seq = prb_next_reserve_seq(prb);
 
 	/* Flush the consoles so that records up to @seq are printed. */
-	if (printing_via_unlock) {
+	printk_get_console_flush_type(&ft);
+	if (ft.legacy_direct) {
 		console_lock();
 		console_unlock();
 	}
-- 
2.39.2


