Return-Path: <linux-kernel+bounces-273652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C14946BBA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA02E1F2528B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7C013CFAA;
	Sun,  4 Aug 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c8AXeB0J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jzWkoBzJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06A422081
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732718; cv=none; b=Ex1tcy/c5Gz/lRed4slkrL3Ps85eODZwbYgfrSbWjN9vHh1XP9KUgswKBIwgHPJ1XLJDazLGgwBi6Qkt/5CP9aEj0sW9seiIgCroj48W50m7OekaqK8nkBA5edrqiAEpkX3z7/Hw34aoN8ZuCs8NYBotNq5QVNnz3adIXcrDCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732718; c=relaxed/simple;
	bh=02uBS3SK0uI6i7egrbWBVa0YWyj8nlyA26FqupjG2Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lst/m4J7fi166hiLt7WGW/ujAUBljV6dQLs5r8Ji8MAMCTRFJscK6pawwebQlin3fRGlHcnPg2gJwP2kmG2kOqkZf+TfhXqcByNfDleojdbRs985NF65U6T56vPuBPaFvVJP/dzkWV5i7CS0seBBj/ReTNNYjc0qgaF3+t3rn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c8AXeB0J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jzWkoBzJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSVN0gPPr6tHTy/VzHokuF6g1s3xpImF0LVj64Z+MkU=;
	b=c8AXeB0JzQbSvM7FxA2ZIWmYXSCJlid4AfTvR0RN/UJh5xSa16Q0nJNBjSqgqvLSH0WHEA
	B7AyZwPSyIZFOJwnnkSc8jcXieWQejiJw0fxERdUZhDpUgMoDn7vzFnI76a7RoJf304Uy3
	Ne2xdhAaoFE6dbWmcLIV8N95PAHLxz+5eK56M7iIkxf/kfbdgRs+ZGPG/MYEQ8TRFBFGM9
	cucR8Kgw+2s8yv+AQgc3ILer88d8EGIzo+2B8qIkSHD9CFTmERmkyHo41BbZrdWU8vz9zF
	UF2l8pGODcALMsPiMbIcWQb1nPgAGip3dYQIE7pJxjIzJUGwSTrb2aEdVHc15g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSVN0gPPr6tHTy/VzHokuF6g1s3xpImF0LVj64Z+MkU=;
	b=jzWkoBzJburWxIHcNXD9xFnnvJUUfge5mP18/7sHLOTvusDuXBzrrvp5bIKth1boGZ6G7y
	Kkf1/Sv4JwN307Cg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v7 30/35] printk: Add helper for flush type logic
Date: Sun,  4 Aug 2024 02:57:33 +0206
Message-Id: <20240804005138.3722656-31-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
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

In many system states it is acceptable to flush legacy directly
via console_unlock or via offload to irq_work. The caller must
decide which of these methods it prefers.

Replace the logic of all flushing call sites to use the new
helper.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h | 65 +++++++++++++++++++++++++++++++++++++++
 kernel/printk/nbcon.c    | 25 ++++++++++++---
 kernel/printk/printk.c   | 66 ++++++++++++++++++----------------------
 3 files changed, 114 insertions(+), 42 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index dbda90f0dc08..58eb2a58b07b 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -48,6 +48,7 @@ struct printk_ringbuffer;
 struct dev_printk_info;
 
 extern struct printk_ringbuffer *prb;
+extern bool legacy_allow_panic_sync;
 
 __printf(4, 0)
 int vprintk_store(int facility, int level,
@@ -156,6 +157,70 @@ static inline bool console_is_usable(struct console *con, short flags) { return
 #endif /* CONFIG_PRINTK */
 
 extern bool have_boot_console;
+extern bool have_nbcon_console;
+extern bool have_legacy_console;
+
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
+ * Identify which console flushing methods are available to the context of
+ * the caller. The caller can then decide which of the available flushing
+ * methods it will use.
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
+		if (have_legacy_console || have_boot_console) {
+			ft->legacy_offload = true;
+			if (!is_printk_legacy_deferred())
+				ft->legacy_direct = true;
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
+		/*
+		 * In panic, if nbcon atomic printing occurs, the legacy
+		 * consoles must remain silent until explicitly allowed.
+		 * Also, legacy consoles cannot print when deferred. However,
+		 * console_flush_on_panic() will flush them anyway, even if
+		 * unsafe.
+		 */
+		if ((legacy_allow_panic_sync || !ft->nbcon_atomic) &&
+		    !is_printk_legacy_deferred()) {
+			ft->legacy_direct = true;
+		}
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
 
 extern struct printk_buffers printk_shared_pbufs;
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index afdb16c1c733..9e13327b4fe3 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1153,6 +1153,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 					   bool allow_unsafe_takeover)
 {
+	struct console_flush_type ft;
 	unsigned long flags;
 	int err;
 
@@ -1186,8 +1187,16 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	 * other context that will do it.
 	 */
 	if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
-		stop_seq = prb_next_reserve_seq(prb);
-		goto again;
+		printk_get_console_flush_type(&ft);
+		/*
+		 * If nbcon_atomic flushing is not available, this printing
+		 * must be occurring via the legacy loop. Let that loop be
+		 * responsible for flushing the new records.
+		 */
+		if (ft.nbcon_atomic) {
+			stop_seq = prb_next_reserve_seq(prb);
+			goto again;
+		}
 	}
 }
 
@@ -1344,6 +1353,7 @@ EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
 void nbcon_device_release(struct console *con)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+	struct console_flush_type ft;
 	int cookie;
 
 	if (!nbcon_context_exit_unsafe(ctxt))
@@ -1359,12 +1369,17 @@ void nbcon_device_release(struct console *con)
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
index 480c0993abd5..6bed91b5a55b 100644
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
@@ -485,14 +485,6 @@ static bool have_nbcon_console;
  */
 bool have_boot_console;
 
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
@@ -2332,7 +2324,7 @@ int vprintk_store(int facility, int level,
 	return ret;
 }
 
-static bool legacy_allow_panic_sync;
+bool legacy_allow_panic_sync;
 
 /*
  * This acts as a one-way switch to allow legacy consoles to print from
@@ -2341,9 +2333,12 @@ static bool legacy_allow_panic_sync;
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
@@ -2353,8 +2348,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
-	bool do_trylock_unlock = printing_via_unlock;
-	bool defer_legacy = !do_trylock_unlock;
+	struct console_flush_type ft;
+	bool do_trylock_unlock;
 	int printed_len;
 
 	/* Suppress unimportant messages after panic happens */
@@ -2369,34 +2364,23 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (other_cpu_in_panic())
 		return 0;
 
+	printk_get_console_flush_type(&ft);
+
 	/* If called from the scheduler, we can not call up(). */
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
 		do_trylock_unlock = false;
-		defer_legacy = true;
+	} else {
+		do_trylock_unlock = ft.legacy_direct;
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
 	if (do_trylock_unlock) {
 		/*
 		 * The caller may be holding system-critical or
@@ -2417,7 +2401,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	if (defer_legacy)
+	if (!do_trylock_unlock && ft.legacy_offload)
 		defer_console_output();
 	else
 		wake_up_klogd();
@@ -2776,10 +2760,14 @@ void resume_console(void)
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
+		if (ft.legacy_direct) {
+			if (console_trylock())
+				console_unlock();
+		}
 	}
 	return 0;
 }
@@ -3304,6 +3292,7 @@ static void __console_rewind_all(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	struct console_flush_type ft;
 	bool handover;
 	u64 next_seq;
 
@@ -3327,7 +3316,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (mode == CONSOLE_REPLAY_ALL)
 		__console_rewind_all();
 
-	if (!have_boot_console)
+	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_atomic)
 		nbcon_atomic_flush_pending();
 
 	/* Flush legacy consoles once allowed, even when dangerous. */
@@ -3991,6 +3981,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 {
 	unsigned long timeout_jiffies = msecs_to_jiffies(timeout_ms);
 	unsigned long remaining_jiffies = timeout_jiffies;
+	struct console_flush_type ft;
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
@@ -4004,7 +3995,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
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


