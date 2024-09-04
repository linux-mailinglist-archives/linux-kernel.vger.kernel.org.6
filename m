Return-Path: <linux-kernel+bounces-314962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8693996BBAC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912F7B2852C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646341D86D8;
	Wed,  4 Sep 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pru0TQq4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cvUkisJ5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC801D6C48
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451541; cv=none; b=geuQPuwjcMlGZlOEka8LC1nHCszSo4sHGHFG8YbKGnN2E65DCNB4acnnBO2bOqpx/7ojWUhL/OXwpZddQ5Ye4ai7rq1tQaCiQz5RFW1WRbEKTKIugXZ+DmMx50O8WNgC+vVdRdL179BqlrfcLM2r7uykyhG4j1Y6VNNjTqqQpSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451541; c=relaxed/simple;
	bh=RrReenFUhfTNr3w7bbASYlY5ocUTouRIzthzq0CXPbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3ri+1D2JETrzegLQZDcrP+9QCZbojKhR20HryPymT179DCzWwkpZ+7wFwsGsUX2Ds+lqGwIC7A2RWR03iWtvmfrPMDMwG0B/SR4SKWWCFoHOQWL4wSpOL0mSsBLBYuDI0Z/f3+AJfN16SMCEl4vvYd2ZoKEFwxfyN5AENPgtp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pru0TQq4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cvUkisJ5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37MXrnqoeJsVYXjVaOEeuGP3aysXis+jCd7SmDa0irI=;
	b=pru0TQq4x0GkA8GuOJzproiWawlQoRjp0i6pnajsy0uwAzPRNtPfNz63icligALv0hvxRU
	R4yIbDOiUZ0G44KLfrNfJl0daze9qBTCqaeaprYbEq9zjsWJ1V4tKnQzsi606mCMDzHQMJ
	CQXYHjDjnfOlf33ov6Jx9J3UWIx3jbe35DZFLWmjm7CYatC//rZYeeNE3HIYUQ+BwDJu0S
	o6Csp43B0ucBQP3Z7vd3VsimpotG+/5vZqhdQw7vUt8CTTOfUMud92xAiqowGzC+MxPVXQ
	+FX7EgCTLH0QXRcNCf4f4nEhLVeNs8AmvvWUR/Kq8CNjS4mSebZUGuzOON/ykg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37MXrnqoeJsVYXjVaOEeuGP3aysXis+jCd7SmDa0irI=;
	b=cvUkisJ5okf+t34UQpvgHVsLie3SslbiFkbWMsrZE8MCTsAWQBO2hEPqBRYtjZlcGO9V1G
	G0AdXogS4FcekiAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 04/17] printk: nbcon: Add context to usable() and emit()
Date: Wed,  4 Sep 2024 14:11:23 +0206
Message-Id: <20240904120536.115780-5-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nbcon consoles will have two callbacks to be used for
different contexts. In order to determine if an nbcon console
is usable, console_is_usable() must know if it is a context
that will need to use the optional write_atomic() callback.
Also, nbcon_emit_next_record() must know which callback it
needs to call.

Add an extra parameter @use_atomic to console_is_usable() and
nbcon_emit_next_record() to specify this.

Since so far only the write_atomic() callback exists,
@use_atomic is set to true for all call sites.

For legacy consoles, @use_atomic is not used.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  8 +++++---
 kernel/printk/nbcon.c    | 34 +++++++++++++++++++---------------
 kernel/printk/printk.c   |  6 +++---
 3 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 8e36d8695f81..ad631824e7e5 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -97,7 +97,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  * which can also play a role in deciding if @con can be used to print
  * records.
  */
-static inline bool console_is_usable(struct console *con, short flags)
+static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
 {
 	if (!(flags & CON_ENABLED))
 		return false;
@@ -106,7 +106,8 @@ static inline bool console_is_usable(struct console *con, short flags)
 		return false;
 
 	if (flags & CON_NBCON) {
-		if (!con->write_atomic)
+		/* The write_atomic() callback is optional. */
+		if (use_atomic && !con->write_atomic)
 			return false;
 	} else {
 		if (!con->write)
@@ -149,7 +150,8 @@ static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 						 int cookie) { return false; }
 
-static inline bool console_is_usable(struct console *con, short flags) { return false; }
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic) { return false; }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 8a1bf6f94bce..88db24f9a8de 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -922,6 +922,7 @@ EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
+ * @use_atomic:	True if the write_atomic() callback is to be used
  *
  * Return:	True if this context still owns the console. False if
  *		ownership was handed over or taken.
@@ -935,7 +936,7 @@ EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
  * When true is returned, @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
+static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_atomic)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 	struct console *con = ctxt->console;
@@ -946,6 +947,18 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	unsigned long con_dropped;
 	unsigned long dropped;
 
+	/*
+	 * This function should never be called for consoles that have not
+	 * implemented the necessary callback for writing: i.e. legacy
+	 * consoles and, when atomic, nbcon consoles with no write_atomic().
+	 * Handle it as if ownership was lost and try to continue.
+	 */
+	if (WARN_ON_ONCE((use_atomic && !con->write_atomic) ||
+			 !(console_srcu_read_flags(con) & CON_NBCON))) {
+		nbcon_context_release(ctxt);
+		return false;
+	}
+
 	/*
 	 * The printk buffers are filled within an unsafe section. This
 	 * prevents NBCON_PRIO_NORMAL and NBCON_PRIO_EMERGENCY from
@@ -980,17 +993,8 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	/* Initialize the write context for driver callbacks. */
 	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
-	if (con->write_atomic) {
+	if (use_atomic)
 		con->write_atomic(con, wctxt);
-	} else {
-		/*
-		 * This function should never be called for legacy consoles.
-		 * Handle it as if ownership was lost and try to continue.
-		 */
-		WARN_ON_ONCE(1);
-		nbcon_context_release(ctxt);
-		return false;
-	}
 
 	if (!wctxt->outbuf) {
 		/*
@@ -1118,7 +1122,7 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	 * The higher priority printing context takes over responsibility
 	 * to print the pending records.
 	 */
-	if (!nbcon_emit_next_record(wctxt))
+	if (!nbcon_emit_next_record(wctxt, true))
 		return false;
 
 	nbcon_context_release(ctxt);
@@ -1219,7 +1223,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 		 * handed over or taken over. In both cases the context is no
 		 * longer valid.
 		 */
-		if (!nbcon_emit_next_record(&wctxt))
+		if (!nbcon_emit_next_record(&wctxt, true))
 			return -EAGAIN;
 
 		if (!ctxt->backlog) {
@@ -1305,7 +1309,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
 		if (!(flags & CON_NBCON))
 			continue;
 
-		if (!console_is_usable(con, flags))
+		if (!console_is_usable(con, flags, true))
 			continue;
 
 		if (nbcon_seq_read(con) >= stop_seq)
@@ -1490,7 +1494,7 @@ void nbcon_device_release(struct console *con)
 	 * the console is usable throughout flushing.
 	 */
 	cookie = console_srcu_read_lock();
-	if (console_is_usable(con, console_srcu_read_flags(con)) &&
+	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		/*
 		 * If nbcon_atomic flushing is not available, fallback to
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c79e962b822a..846306ac2663 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3071,7 +3071,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			u64 printk_seq;
 			bool progress;
 
-			if (!console_is_usable(con, flags))
+			if (!console_is_usable(con, flags, true))
 				continue;
 			any_usable = true;
 
@@ -3773,7 +3773,7 @@ static int unregister_console_locked(struct console *console)
 
 	if (!console_is_registered_locked(console))
 		res = -ENODEV;
-	else if (console_is_usable(console, console->flags))
+	else if (console_is_usable(console, console->flags, true))
 		__pr_flush(console, 1000, true);
 
 	/* Disable it unconditionally */
@@ -4043,7 +4043,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c, flags))
+			if (!console_is_usable(c, flags, true))
 				continue;
 
 			if (flags & CON_NBCON) {
-- 
2.39.2


