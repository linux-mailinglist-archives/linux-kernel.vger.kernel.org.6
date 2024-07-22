Return-Path: <linux-kernel+bounces-259246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DFD93931D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BFC1C215E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295CE171643;
	Mon, 22 Jul 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nf8p0Pcs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdcBLotU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EE716F267
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668792; cv=none; b=L8d31q29rJXhqtZTyfA6+GHMbyaSXgiIk6LpbgGyEv9cfo8vGP24Mu5isX7ROXSk9hilSgL3OR5YUW0l5wjSfnZZOM1OfvNx7jVWh7Q2MAicOFsrexlQvw870Ozqj8xo7nnyhW5LTYplSWR/UWsVf+Oeka2KI+dB5l/wJwLVmyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668792; c=relaxed/simple;
	bh=BGQqE1E1rO6cNjCdjTz0mX/okTHEvHdejZfkDeZZq+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MArItGjpNk0l5xx7QgThlX/KcX9l0UdE0FFxy04gq8ywk0qqFPdN5hhj7bjyTr6aLrr2IUotZYB5d8lYDAJuSun9dXtfDGB6aZyk8XJMq4iH8O1inwCV5XwgGq0zmow0AUV0uznnBNcPjPljPvI7FsVQSLmNphl17eBUtzK07Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nf8p0Pcs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YdcBLotU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jfxsbZMyZbZp6nvc6k5SK6umuoR31LJc1J7BsnGnjI=;
	b=nf8p0PcsHaU47cQ8r6Q+qb1x6ondAqP9QTbpPlhxxM78YwQiRRl/5dV1u8R/hmrFIYaT5t
	jmcW6BTL/ZEm3DwsndL3+ZvPcPEN89+JSfNvCVEgtv4kwkAE7bSCK9jbD1wWYK3TSijKTY
	MCnA/odXMSfiggfzpugqAgCJd76migXf49ytEmWD77WeAEFmqRxUMmHCh7LPDJv3yGENj9
	AxJWMoB7jbob5y0/lfoNloxssIQVqiFqIr5ELJVpwsqrluICNEYoTylVgGjS2CFwQIvxdl
	ov1a9mGQJNQdL8LDyjLkWr/zMcD+NXYd3OnjjAxmwnGUZyPvzo8+Ek+AXx/37Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jfxsbZMyZbZp6nvc6k5SK6umuoR31LJc1J7BsnGnjI=;
	b=YdcBLotULtb8g6LKEt2/CyFF9sKDF+6jlm7ULcOwJH7RiCVn8iAAVGLmP0TrGZsbOuBAlz
	RQx7zHkbBRiwL8Bg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 07/19] printk: Add helpers for flush type logic
Date: Mon, 22 Jul 2024 19:25:27 +0206
Message-Id: <20240722171939.3349410-8-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
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

Introduce helper functions to fill out console_flush_type to
be used for emergency and non-emergency call sites.

In many system states it is acceptable to flush legacy directly
via console_unlock or via offload to irq_work. For this reason
the non-emergency helper provides an argument @prefer_offload
for the caller to specify which method it is interested in
performing. (The helper functions will never allow both.)

Replace the logic of all flushing call sites to use the new
helpers. Note that this cleans up various corner cases where
is_printk_preferred() and @have_boot_console were not being
considerered before.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h | 100 +++++++++++++++++++++++++++++++--
 kernel/printk/nbcon.c    |  32 ++++++++---
 kernel/printk/printk.c   | 116 ++++++++++++++++++++-------------------
 3 files changed, 180 insertions(+), 68 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index d58f5cefbac3..ccdb81dc18f0 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -154,15 +154,105 @@ static inline bool console_is_usable(struct console *con, short flags) { return
 #endif /* CONFIG_PRINTK */
 
 extern bool have_boot_console;
+extern bool have_nbcon_console;
 extern bool have_legacy_console;
+extern bool legacy_allow_panic_sync;
+
+/**
+ * struct console_flush_type - Define how to flush the consoles
+ * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
+ * @legacy_direct:	Call the legacy loop in this context
+ * @legacy_offload:	Offload the legacy loop into IRQ
+ */
+struct console_flush_type {
+	bool	nbcon_atomic;
+	bool	legacy_direct;
+	bool	legacy_offload;
+};
 
 /*
- * Specifies if the console lock/unlock dance is needed for console
- * printing. If @have_boot_console is true, the nbcon consoles will
- * be printed serially along with the legacy consoles because nbcon
- * consoles cannot print simultaneously with boot consoles.
+ * Decide while console flushing methods are to be used. Used
+ * for all flushing except when flushing from emergency state.
+ *
+ * Set @prefer_offload to true if the context is only interested in
+ * offloading. Then offloading types will be set instead of direct,
+ * if appropriate.
  */
-#define printing_via_unlock (have_legacy_console || have_boot_console)
+static inline void printk_get_console_flush_type(struct console_flush_type *ft, bool prefer_offload)
+{
+	memset(ft, 0, sizeof(*ft));
+
+	switch (nbcon_get_default_prio()) {
+	case NBCON_PRIO_NORMAL:
+		if (have_legacy_console || have_boot_console) {
+			if (prefer_offload || is_printk_deferred())
+				ft->legacy_offload = true;
+			else
+				ft->legacy_direct = true;
+		}
+
+		if (have_nbcon_console && !have_boot_console)
+			ft->nbcon_atomic = true;
+		break;
+
+	case NBCON_PRIO_EMERGENCY:
+		/*
+		 * Skip. The consoles will be flushed when exiting emergency
+		 * state. See printk_get_emergency_console_flush_type().
+		 */
+		break;
+
+	case NBCON_PRIO_PANIC:
+		if (have_nbcon_console && !have_boot_console)
+			ft->nbcon_atomic = true;
+
+		/*
+		 * In panic, if nbcon atomic printing occurs, the legacy
+		 * consoles must remain silent until explicitly allowed.
+		 */
+		if (legacy_allow_panic_sync || !ft->nbcon_atomic)
+			ft->legacy_direct = true;
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
+
+/*
+ * Decide while console flushing methods are to be used from
+ * emergency state.
+ */
+static inline void printk_get_emergency_console_flush_type(struct console_flush_type *ft)
+{
+	memset(ft, 0, sizeof(*ft));
+
+	switch (nbcon_get_default_prio()) {
+	case NBCON_PRIO_EMERGENCY:
+		if (have_nbcon_console && !have_boot_console)
+			ft->nbcon_atomic = true;
+
+		if (have_legacy_console || have_boot_console) {
+			if (is_printk_deferred())
+				ft->legacy_offload = true;
+			else
+				ft->legacy_direct = true;
+		}
+		break;
+
+	case NBCON_PRIO_PANIC:
+		/*
+		 * Skip. Console flushing is handled by panic code.
+		 * See printk_get_console_flush_type().
+		 */
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
 
 extern struct printk_buffers printk_shared_pbufs;
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index db1685a6d5cd..917022105b8b 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1235,6 +1235,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 					   bool allow_unsafe_takeover)
 {
+	struct console_flush_type ft;
 	unsigned long flags;
 	int err;
 
@@ -1267,7 +1268,9 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	 * context must flush those remaining records because there is no
 	 * other context that will do it.
 	 */
-	if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+	printk_get_console_flush_type(&ft, false);
+	if (ft.nbcon_atomic &&
+	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		stop_seq = prb_next_reserve_seq(prb);
 		goto again;
 	}
@@ -1362,6 +1365,7 @@ void nbcon_cpu_emergency_exit(void)
 {
 	unsigned int *cpu_emergency_nesting;
 	bool do_trigger_flush = false;
+	struct console_flush_type ft;
 
 	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
 
@@ -1374,19 +1378,25 @@ void nbcon_cpu_emergency_exit(void)
 	 * for the emergency messages is NBCON_PRIO_EMERGENCY.
 	 */
 	if (*cpu_emergency_nesting == 1) {
-		nbcon_atomic_flush_pending();
+		printk_get_emergency_console_flush_type(&ft);
+
+		if (ft.nbcon_atomic)
+			nbcon_atomic_flush_pending();
 
 		/*
 		 * Safely attempt to flush the legacy consoles in this
 		 * context. Otherwise an irq_work context is triggered
 		 * to handle it.
 		 */
-		do_trigger_flush = true;
-		if (printing_via_unlock && !is_printk_deferred()) {
+		if (ft.legacy_direct) {
 			if (console_trylock()) {
 				do_trigger_flush = false;
 				console_unlock();
+			} else {
+				do_trigger_flush = true;
 			}
+		} else {
+			do_trigger_flush = ft.legacy_offload;
 		}
 	}
 
@@ -1412,13 +1422,18 @@ void nbcon_cpu_emergency_exit(void)
  */
 void nbcon_cpu_emergency_flush(void)
 {
+	struct console_flush_type ft;
+
 	/* The explicit flush is needed only in the emergency context. */
 	if (*(nbcon_get_cpu_emergency_nesting()) == 0)
 		return;
 
-	nbcon_atomic_flush_pending();
+	printk_get_emergency_console_flush_type(&ft);
+
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
 
-	if (printing_via_unlock && !is_printk_deferred()) {
+	if (ft.legacy_direct) {
 		if (console_trylock())
 			console_unlock();
 	}
@@ -1521,6 +1536,7 @@ EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
 void nbcon_device_release(struct console *con)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+	struct console_flush_type ft;
 	int cookie;
 
 	if (!nbcon_context_exit_unsafe(ctxt))
@@ -1533,8 +1549,10 @@ void nbcon_device_release(struct console *con)
 	 * was locked. The console_srcu_read_lock must be taken to ensure
 	 * the console is usable throughout flushing.
 	 */
+	printk_get_console_flush_type(&ft, false);
 	cookie = console_srcu_read_lock();
-	if (console_is_usable(con, console_srcu_read_flags(con)) &&
+	if (ft.nbcon_atomic &&
+	    console_is_usable(con, console_srcu_read_flags(con)) &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82440b1f0d1e..3fbe27551f75 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -472,7 +472,7 @@ bool have_legacy_console;
  * synchronous printing of legacy consoles will not occur during panic until
  * the backtrace has been stored to the ringbuffer.
  */
-static bool have_nbcon_console;
+bool have_nbcon_console;
 
 /*
  * Specifies if a boot console is registered. If boot consoles are present,
@@ -482,6 +482,9 @@ static bool have_nbcon_console;
  */
 bool have_boot_console;
 
+/* See printk_legacy_allow_panic_sync() for details. */
+bool legacy_allow_panic_sync;
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -2321,8 +2324,6 @@ int vprintk_store(int facility, int level,
 	return ret;
 }
 
-static bool legacy_allow_panic_sync;
-
 /*
  * This acts as a one-way switch to allow legacy consoles to print from
  * the printk() caller context on a panic CPU. It also attempts to flush
@@ -2330,9 +2331,13 @@ static bool legacy_allow_panic_sync;
  */
 void printk_legacy_allow_panic_sync(void)
 {
+	struct console_flush_type ft;
+
 	legacy_allow_panic_sync = true;
 
-	if (printing_via_unlock && !in_nmi()) {
+	printk_get_console_flush_type(&ft, false);
+
+	if (ft.legacy_direct && !in_nmi()) {
 		if (console_trylock())
 			console_unlock();
 	}
@@ -2342,7 +2347,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
-	bool do_trylock_unlock = printing_via_unlock;
+	struct console_flush_type ft;
+	bool defer_legacy = false;
 	int printed_len;
 
 	/* Suppress unimportant messages after panic happens */
@@ -2360,41 +2366,19 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
 		/* If called from the scheduler, we can not call up(). */
-		do_trylock_unlock = false;
+		defer_legacy = true;
 	}
 
 	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
-	if (have_nbcon_console && !have_boot_console) {
-		bool is_panic_context = this_cpu_in_panic();
+	printk_get_console_flush_type(&ft, false);
 
-		/*
-		 * In panic, the legacy consoles are not allowed to print from
-		 * the printk calling context unless explicitly allowed. This
-		 * gives the safe nbcon consoles a chance to print out all the
-		 * panic messages first. This restriction only applies if
-		 * there are nbcon consoles registered.
-		 */
-		if (is_panic_context)
-			do_trylock_unlock &= legacy_allow_panic_sync;
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
 
-		/*
-		 * There are situations where nbcon atomic printing should
-		 * happen in the printk() caller context:
-		 *
-		 * - When this CPU is in panic.
-		 *
-		 * Note that if boot consoles are registered, the console
-		 * lock/unlock dance must be relied upon instead because nbcon
-		 * consoles cannot print simultaneously with boot consoles.
-		 */
-		if (is_panic_context)
-			nbcon_atomic_flush_pending();
-	}
-
-	if (do_trylock_unlock) {
+	if (!defer_legacy && ft.legacy_direct) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2409,22 +2393,17 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * semaphore. The release will print out buffers. With the
 		 * spinning variant, this context tries to take over the
 		 * printing from another printing context.
-		 *
-		 * Skip it in EMERGENCY priority. The console will be
-		 * explicitly flushed when exiting the emergency section.
 		 */
-		if (nbcon_get_default_prio() != NBCON_PRIO_EMERGENCY) {
-			if (console_trylock_spinning())
-				console_unlock();
-		}
+		if (console_trylock_spinning())
+			console_unlock();
 
 		preempt_enable();
 	}
 
-	if (do_trylock_unlock)
-		wake_up_klogd();
-	else
+	if ((defer_legacy && ft.legacy_direct) || ft.legacy_offload)
 		defer_console_output();
+	else
+		wake_up_klogd();
 
 	return printed_len;
 }
@@ -2728,10 +2707,15 @@ void resume_console(void)
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
+		printk_get_console_flush_type(&ft, false);
+
+		if (ft.legacy_direct) {
+			if (console_trylock())
+				console_unlock();
+		}
 	}
 	return 0;
 }
@@ -3256,6 +3240,7 @@ static void __console_rewind_all(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	struct console_flush_type ft;
 	bool handover;
 	u64 next_seq;
 
@@ -3279,9 +3264,12 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	if (mode == CONSOLE_REPLAY_ALL)
 		__console_rewind_all();
 
-	nbcon_atomic_flush_pending();
+	printk_get_console_flush_type(&ft, false);
+
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
 
-	if (printing_via_unlock)
+	if (ft.legacy_direct)
 		console_flush_all(false, &next_seq, &handover);
 }
 
@@ -3943,6 +3931,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 {
 	unsigned long timeout_jiffies = msecs_to_jiffies(timeout_ms);
 	unsigned long remaining_jiffies = timeout_jiffies;
+	struct console_flush_type ft;
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
@@ -3959,8 +3948,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 	seq = prb_next_reserve_seq(prb);
 
+	printk_get_console_flush_type(&ft, false);
+
 	/* Flush the consoles so that records up to @seq are printed. */
-	if (printing_via_unlock) {
+	if (ft.legacy_direct) {
 		console_lock();
 		console_unlock();
 	}
@@ -3968,18 +3959,19 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	for (;;) {
 		unsigned long begin_jiffies;
 		unsigned long slept_jiffies;
-		bool use_console_lock = printing_via_unlock;
+
+		printk_get_console_flush_type(&ft, false);
 
 		/*
-		 * Ensure the compiler does not optimize @use_console_lock to
-		 * be @printing_via_unlock since the latter can change at any
+		 * Ensure the compiler is re-reading the various state
+		 * variables for setting @ft since they can change at any
 		 * time.
 		 */
 		barrier();
 
 		diff = 0;
 
-		if (use_console_lock) {
+		if (ft.legacy_direct) {
 			/*
 			 * Hold the console_lock to guarantee safe access to
 			 * console->seq. Releasing console_lock flushes more
@@ -4007,7 +3999,16 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);
 			} else {
-				WARN_ON_ONCE(!use_console_lock);
+				/*
+				 * Warn if this is a usable legacy console but
+				 * the console lock was not taken because it
+				 * is not allowed to do the direct printing
+				 * when the console lock is released. Without
+				 * the console lock, reading console->seq is
+				 * unsafe.
+				 */
+				WARN_ON_ONCE(!ft.legacy_direct);
+
 				printk_seq = c->seq;
 			}
 
@@ -4019,7 +4020,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		if (diff != last_diff && reset_on_progress)
 			remaining_jiffies = timeout_jiffies;
 
-		if (use_console_lock)
+		if (ft.legacy_direct)
 			console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
@@ -4086,6 +4087,8 @@ static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
 
 static void __wake_up_klogd(int val)
 {
+	struct console_flush_type ft;
+
 	if (!printk_percpu_data_ready())
 		return;
 
@@ -4110,7 +4113,8 @@ static void __wake_up_klogd(int val)
 	 * registered legacy console when writing the message about it
 	 * being enabled.
 	 */
-	if (!printing_via_unlock)
+	printk_get_console_flush_type(&ft, true);
+	if (!ft.legacy_offload)
 		val &= ~PRINTK_PENDING_OUTPUT;
 
 	if (val) {
-- 
2.39.2


