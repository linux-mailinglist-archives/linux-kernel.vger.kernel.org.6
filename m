Return-Path: <linux-kernel+bounces-309042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36179966583
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27B2285DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCD1BB6A3;
	Fri, 30 Aug 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/0ApaWg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2SK9c0J6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DA71B5EB9
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031770; cv=none; b=EPNFDF0ulcCoGIGGKTeDTa3ECYBoSwV6nwT2lMCXYy0s5T28qe952cpOuLB68oI6C439g5nGFfaGfLuCiWL3jVGDkZOhPJfhNgEEm+3e7QSrvlfkzo98YFhKgB9tJN6//38s8xv1e52MNTQLzd3J5SHJy72CL1thxadFei3Khb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031770; c=relaxed/simple;
	bh=SDTh/5f6K/T1YNyTMfofCY2NZ0cpcZYH4JqrtxcaTjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+YcnYTGaQy0RpZ0t9228w5WBSMDm+3/1b8vgqecNtF+/KUbl5WpLykUnfaY/Cu6MkmvBvt+XWZW/GmKk4owyhBWQ0DtUODwHZuk3vpeSyPLF3KZY+z/PGKSKW7EMB2RM5wjmdm3VVXG6c3LAmCHD3NNssZEelcCB0aCNFod0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/0ApaWg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2SK9c0J6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnnub2JBKw4ncZI/uPE2HgPxoXFMsSDgUiwh6Mxy6Fk=;
	b=D/0ApaWgcRObZKgDFGIesxgWTSVsRfo+2mUkqiDWsoeMLWQiNjpgPQsXPNUhzZzr3u6JgL
	LY1uAfVnZyvOFAoSi2hCzcj5dDu0KxCQ57yIns20A3VJVhs7WLVoeDpYcRQoeRMSgWCqXZ
	jei2dQYhMEPK4gTgbhcCsXT064ZYpqYEV68vZKU1SEhjiOPDTh2HDKQ2jzqvazbnSR/sP0
	7FV9Sjd/TKppqJsXXD3xftGO83TgbSsVmQuO0nDs2nOdYobLoSqWxyqUFZrS+gWoJydJa/
	odDFYQNEZO3YS9RA7a06LFA8PBwEqTZFAoU++N1jrR/U1RFB1/ZG/LBH8W2a9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnnub2JBKw4ncZI/uPE2HgPxoXFMsSDgUiwh6Mxy6Fk=;
	b=2SK9c0J6hM5l8hKBtY6wdCCGDK51nDE6isNbsRXZ1b/a4nsQYQPKlYaRuGSkjebAzfjBJ1
	cQ4YtIXxPTAfgUCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 09/17] printk: nbcon: Rely on kthreads for normal operation
Date: Fri, 30 Aug 2024 17:35:08 +0206
Message-Id: <20240830152916.10136-10-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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
 kernel/printk/internal.h | 26 ++++++++++++++++++++++
 kernel/printk/nbcon.c    | 17 ++++++++++-----
 kernel/printk/printk.c   | 47 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index a96d4114a1db..8166e24f8780 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -113,6 +113,13 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 		/* The write_atomic() callback is optional. */
 		if (use_atomic && !con->write_atomic)
 			return false;
+
+		/*
+		 * For the !use_atomic case, @printk_kthreads_running is not
+		 * checked because the write_thread() callback is also used
+		 * via the legacy loop when the printer threads are not
+		 * available.
+		 */
 	} else {
 		if (!con->write)
 			return false;
@@ -176,6 +183,7 @@ static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 						 int cookie, bool use_atomic) { return false; }
 static inline void nbcon_kthread_wake(struct console *con) { }
+static inline void nbcon_kthreads_wake(void) { }
 
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
@@ -190,6 +198,7 @@ extern bool legacy_allow_panic_sync;
 /**
  * struct console_flush_type - Define available console flush methods
  * @nbcon_atomic:	Flush directly using nbcon_atomic() callback
+ * @nbcon_offload:	Offload flush to printer thread
  * @legacy_direct:	Call the legacy loop in this context
  * @legacy_offload:	Offload the legacy loop into IRQ
  *
@@ -197,6 +206,7 @@ extern bool legacy_allow_panic_sync;
  */
 struct console_flush_type {
 	bool	nbcon_atomic;
+	bool	nbcon_offload;
 	bool	legacy_direct;
 	bool	legacy_offload;
 };
@@ -211,6 +221,22 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
 
 	switch (nbcon_get_default_prio()) {
 	case NBCON_PRIO_NORMAL:
+		if (have_nbcon_console && !have_boot_console) {
+			if (printk_kthreads_running)
+				ft->nbcon_offload = true;
+			else
+				ft->nbcon_atomic = true;
+		}
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
 	case NBCON_PRIO_EMERGENCY:
 		if (have_nbcon_console && !have_boot_console)
 			ft->nbcon_atomic = true;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 8745fffbfbb0..cebdb9936609 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1492,6 +1492,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 					   bool allow_unsafe_takeover)
 {
+	struct console_flush_type ft;
 	unsigned long flags;
 	int err;
 
@@ -1521,10 +1522,12 @@ static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 
 	/*
 	 * If flushing was successful but more records are available, this
-	 * context must flush those remaining records because there is no
-	 * other context that will do it.
+	 * context must flush those remaining records if the printer thread
+	 * is not available do it.
 	 */
-	if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+	printk_get_console_flush_type(&ft);
+	if (!ft.nbcon_offload &&
+	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		stop_seq = prb_next_reserve_seq(prb);
 		goto again;
 	}
@@ -1752,17 +1755,19 @@ void nbcon_device_release(struct console *con)
 
 	/*
 	 * This context must flush any new records added while the console
-	 * was locked. The console_srcu_read_lock must be taken to ensure
-	 * the console is usable throughout flushing.
+	 * was locked if the printer thread is not available to do it. The
+	 * console_srcu_read_lock must be taken to ensure the console is
+	 * usable throughout flushing.
 	 */
 	cookie = console_srcu_read_lock();
+	printk_get_console_flush_type(&ft);
 	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
+	    !ft.nbcon_offload &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		/*
 		 * If nbcon_atomic flushing is not available, fallback to
 		 * using the legacy loop.
 		 */
-		printk_get_console_flush_type(&ft);
 		if (ft.nbcon_atomic) {
 			__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
 		} else if (ft.legacy_direct) {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 55d75db00042..b9378636188e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2384,6 +2384,9 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (ft.nbcon_atomic)
 		nbcon_atomic_flush_pending();
 
+	if (ft.nbcon_offload)
+		nbcon_kthreads_wake();
+
 	if (ft.legacy_direct) {
 		/*
 		 * The caller may be holding system-critical or
@@ -2732,6 +2735,7 @@ void suspend_console(void)
 
 void resume_console(void)
 {
+	struct console_flush_type ft;
 	struct console *con;
 
 	if (!console_suspend_enabled)
@@ -2749,6 +2753,10 @@ void resume_console(void)
 	 */
 	synchronize_srcu(&console_srcu);
 
+	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_offload)
+		nbcon_kthreads_wake();
+
 	pr_flush(1000, true);
 }
 
@@ -3060,6 +3068,7 @@ static inline void printk_kthreads_check_locked(void) { }
  */
 static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
 {
+	struct console_flush_type ft;
 	bool any_usable = false;
 	struct console *con;
 	bool any_progress;
@@ -3071,12 +3080,21 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 	do {
 		any_progress = false;
 
+		printk_get_console_flush_type(&ft);
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
@@ -3387,9 +3405,25 @@ EXPORT_SYMBOL(console_stop);
 
 void console_start(struct console *console)
 {
+	struct console_flush_type ft;
+	bool is_nbcon;
+
 	console_list_lock();
 	console_srcu_write_flags(console, console->flags | CON_ENABLED);
+	is_nbcon = console->flags & CON_NBCON;
 	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. The related
+	 * printing context must be able to see it is enabled so that
+	 * it is guaranteed to wake up and resume printing.
+	 */
+	synchronize_srcu(&console_srcu);
+
+	printk_get_console_flush_type(&ft);
+	if (is_nbcon && ft.nbcon_offload)
+		nbcon_kthread_wake(console);
+
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -4115,6 +4149,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 	/* Flush the consoles so that records up to @seq are printed. */
 	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
 	if (ft.legacy_direct) {
 		console_lock();
 		console_unlock();
@@ -4152,8 +4188,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
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
@@ -4629,8 +4667,15 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
  */
 void console_try_replay_all(void)
 {
+	struct console_flush_type ft;
+
+	printk_get_console_flush_type(&ft);
 	if (console_trylock()) {
 		__console_rewind_all();
+		if (ft.nbcon_atomic)
+			nbcon_atomic_flush_pending();
+		if (ft.nbcon_offload)
+			nbcon_kthreads_wake();
 		/* Consoles are flushed as part of console_unlock(). */
 		console_unlock();
 	}
-- 
2.39.2


