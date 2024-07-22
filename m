Return-Path: <linux-kernel+bounces-259247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD72939321
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3731F22573
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB438171676;
	Mon, 22 Jul 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GCXuM4qA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGkz6TH9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505E16F82B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668793; cv=none; b=U4pWSGSi87VFR19OPLUBjZDZLuCcwvFBUP1+qoamUKDABY2/8T4xV9a7H/npiQgorHCCCyVjhhoiT1qYN0W+PNYht3aTYilv8gPlt+n1O+9sfP2pDT6enBrJjzd0cWyBMrfeFlr3tA/Uo5eJIY5w086LeiyF7hb833UNAMkFsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668793; c=relaxed/simple;
	bh=8rZ+orOvhvkg3Xs7cSIelF6l3/TMCwIKMNzN05jG0hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a/wCCuBRyqGBuLfY0khjIKJlWoKzdf3p1Zwai2y/aEGEwsplo2Ka5viUynITHml0yF0agVGLnj6bztJdDDJxjr8tXuuBlH4VgBVTdfg9weFrHangDg+CDZW/PxjjxWLqo8XiuAUYeNFdhY6tLzvxn/LhZEdDz+/fowmud2VmSbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GCXuM4qA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGkz6TH9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wq5SsyqnFMbaCjD78xlUdl8Q0+6byHJFUpkZ0WBc8Uw=;
	b=GCXuM4qAg/bAX1oIQEUaod6+4xOvoFjIa/hChJ7T90yVODcBIudM0Vfw4weFSiv1UWwWQO
	zJqwDeJBiqvNHGql5D50M0YxZBAUyF0FR3Up1At8kSVcSZz+9cTr9P1eMR3dRwGLVCYlom
	+/kRMhycmqbjOrzwhZY8vytC5kjPDhFdQGofcdy9oMHCwZQw4kp2+RbPYu1OhTqWX94I9Q
	rmJzMC1uBoyCqJ4thOf/gjSAG9hwUKYQfcq98UC7VEglRCobfV4ucH26WoUJPKCudNVzSi
	ismduiaIPIaDS4jesjx1M6EpTjqhNx7t0cBdDoYpS1G2yciKsT/AgDKnHPfcVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wq5SsyqnFMbaCjD78xlUdl8Q0+6byHJFUpkZ0WBc8Uw=;
	b=ZGkz6TH9mm/Sqd0ihyXQ1PyFzuP42vyMX5iM2YjQqGELaiSK+qEx8ZiHhHnuLiJzm3J306
	gxJvDImfGf7o6JDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 11/19] printk: nbcon: Rely on kthreads for normal operation
Date: Mon, 22 Jul 2024 19:25:31 +0206
Message-Id: <20240722171939.3349410-12-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once the kthread is running and available
(i.e. @printk_kthreads_running is set), the kthread becomes
responsible for flushing any pending messages which are added
in NBCON_PRIO_NORMAL context. Namely the legacy
console_flush_all() and device_release() no longer flush the
console. And nbcon_atomic_flush_pending() used by
nbcon_cpu_emergency_exit() no longer flushes messages added
after the emergency messages.

The console context is safe when used by the kthread only when
one of the following conditions are true:

  1. Other caller acquires the console context with
     NBCON_PRIO_NORMAL with preemption disabled. It will
     release the context before rescheduling.

  2. Other caller acquires the console context with
     NBCON_PRIO_NORMAL under the device_lock.

  3. The kthread is the only context which acquires the console
     with NBCON_PRIO_NORMAL.

This is satisfied for all atomic printing call sites:

nbcon_legacy_emit_next_record() (#1)

nbcon_atomic_flush_pending_con() (#1)

nbcon_device_release() (#2)

It is even double guaranteed when @printk_kthreads_running
is set because then _only_ the kthread will print for
NBCON_PRIO_NORMAL. (#3)

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  6 +++++-
 kernel/printk/nbcon.c    | 13 ++++++------
 kernel/printk/printk.c   | 46 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index bb02788acc7c..66321836c3fe 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -190,11 +190,13 @@ extern bool legacy_allow_panic_sync;
 /**
  * struct console_flush_type - Define how to flush the consoles
  * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
+ * @nbcon_offload:	Offload flush to printer thread
  * @legacy_direct:	Call the legacy loop in this context
  * @legacy_offload:	Offload the legacy loop into IRQ
  */
 struct console_flush_type {
 	bool	nbcon_atomic;
+	bool	nbcon_offload;
 	bool	legacy_direct;
 	bool	legacy_offload;
 };
@@ -220,7 +222,9 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft,
 				ft->legacy_direct = true;
 		}
 
-		if (have_nbcon_console && !have_boot_console)
+		if (printk_kthreads_running)
+			ft->nbcon_offload = true;
+		else if (have_nbcon_console && !have_boot_console)
 			ft->nbcon_atomic = true;
 		break;
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 233ab8f90fef..8cf9e9e8c6e4 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1511,10 +1511,10 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 
 	/*
 	 * If flushing was successful but more records are available, this
-	 * context must flush those remaining records because there is no
-	 * other context that will do it.
+	 * context must flush those remaining records if the printer thread
+	 * is not available do it.
 	 */
-	printk_get_console_flush_type(&ft, false);
+	printk_get_console_flush_type(&ft, true);
 	if (ft.nbcon_atomic &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		stop_seq = prb_next_reserve_seq(prb);
@@ -1809,10 +1809,11 @@ void nbcon_device_release(struct console *con)
 
 	/*
 	 * This context must flush any new records added while the console
-	 * was locked. The console_srcu_read_lock must be taken to ensure
-	 * the console is usable throughout flushing.
+	 * was locked if the printer thread is not available to do it. The
+	 * console_srcu_read_lock must be taken to ensure the console is
+	 * usable throughout flushing.
 	 */
-	printk_get_console_flush_type(&ft, false);
+	printk_get_console_flush_type(&ft, true);
 	cookie = console_srcu_read_lock();
 	if (ft.nbcon_atomic &&
 	    console_is_usable(con, console_srcu_read_flags(con), true) &&
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 71e946a8c5fa..620c02b069bc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2382,6 +2382,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (ft.nbcon_atomic)
 		nbcon_atomic_flush_pending();
 
+	if (ft.nbcon_offload)
+		nbcon_wake_kthreads();
+
 	if (!defer_legacy && ft.legacy_direct) {
 		/*
 		 * The caller may be holding system-critical or
@@ -2680,6 +2683,7 @@ void suspend_console(void)
 
 void resume_console(void)
 {
+	struct console_flush_type ft;
 	struct console *con;
 
 	if (!console_suspend_enabled)
@@ -2697,6 +2701,10 @@ void resume_console(void)
 	 */
 	synchronize_srcu(&console_srcu);
 
+	printk_get_console_flush_type(&ft, true);
+	if (ft.nbcon_offload)
+		nbcon_wake_kthreads();
+
 	pr_flush(1000, true);
 }
 
@@ -3007,6 +3015,7 @@ static inline void printk_kthreads_check_locked(void) { }
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
+	struct console_flush_type ft;
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
@@ -3018,12 +3027,21 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	do {
 		any_progress = false;
 
+		printk_get_console_flush_type(&ft, true);
+
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
 			short flags = console_srcu_read_flags(con);
 			u64 printk_seq;
 			bool progress;
 
+			/*
+			 * console_flush_all() is only for legacy consoles when
+			 * the nbcon consoles have their printer threads.
+			 */
+			if ((flags & CON_NBCON) && ft.nbcon_offload)
+				continue;
+
 			if (!console_is_usable(con, flags, !do_cond_resched))
 				continue;
 			any_usable = true;
@@ -3334,9 +3352,28 @@ EXPORT_SYMBOL(console_stop);
 
 void console_start(struct console *console)
 {
+	struct console_flush_type ft;
+	short flags;
+	int cookie;
+
 	console_list_lock();
 	console_srcu_write_flags(console, console->flags | CON_ENABLED);
 	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. The related
+	 * printing context must be able to see it is enabled so that
+	 * it is guaranteed to wake up and resume printing.
+	 */
+	synchronize_srcu(&console_srcu);
+
+	printk_get_console_flush_type(&ft, true);
+	cookie = console_srcu_read_lock();
+	flags = console_srcu_read_flags(console);
+	if ((flags & CON_NBCON) && ft.nbcon_offload)
+		nbcon_kthread_wake(console);
+	console_srcu_read_unlock(cookie);
+
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -4102,8 +4139,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c, flags, true))
+			if (!console_is_usable(c, flags, true) &&
+			    !console_is_usable(c, flags, false)) {
 				continue;
+			}
 
 			if (flags & CON_NBCON) {
 				printk_seq = nbcon_seq_read(c);
@@ -4605,8 +4644,13 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
  */
 void console_try_replay_all(void)
 {
+	struct console_flush_type ft;
+
+	printk_get_console_flush_type(&ft, true);
 	if (console_trylock()) {
 		__console_rewind_all();
+		if (ft.nbcon_offload)
+			nbcon_wake_kthreads();
 		/* Consoles are flushed as part of console_unlock(). */
 		console_unlock();
 	}
-- 
2.39.2


