Return-Path: <linux-kernel+bounces-259245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5016893931B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9DB281600
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B5D17107B;
	Mon, 22 Jul 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f081GcMy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DT8lEzvc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28C16F26D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668792; cv=none; b=fvyD55v0rxCRFwDAtde7Axoens+6a4e8KjM+SwoTDD8sm2eX2K+9bqF2OE7+6myRMCc+LaQvqlbAq0jwR5Fpg1fjQuutG86fzvicXQM/HDr0vfOkxFEkF0MZWYndRNU0FEFgCcGIYgrKJv5ZHGn9RQGtzW9+MGxoZlq2/HCq9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668792; c=relaxed/simple;
	bh=YawcJYPNd32k3XMh42rCyY3UosJYYeCPwQMuyikeX4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJhi2FT8Ba1hnw7bnBhEBAcIItt/seVVcNRIhL+axzex+vzJqHx2VYnsiGcOBtbEjyXxMePdNLAu1MNdJgjJ0TTA6BjkEuR9avjj+i7Cpe4ztyyo+l9XNEgog4cqT0P+TtixzSIts3X4u6sSMsuoRBUq6huu2ggoPkXp1vFrDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f081GcMy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DT8lEzvc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2c1xVI1G9qKeLg5Cn/WeTC9NVB748aI4bpBGv+D/NU=;
	b=f081GcMyF6rwHpTpW3bACjwXvwHitcwWkgteUVWDMzlXYG/2W52o0g2/4a30Utiq+YUUAJ
	dW8wUJeIKUZOZGztS6fLpOGCTm8LpfmbdQPXLVxOStnfwy2KjFuK9YjK0Wg2cJ8iySCFT5
	0FK+O8to8ZTTc6N52kuFrX+Er19Uac9CUgw6XOCQf416ei4WP+DMv1dBUsayvmypbWVvvr
	tMxqcMRAi523IFBUnyvVmNOtHVs28nI+WaYbiDwQ78e2e5pDxrFGqMnOxrZYYgXs+Xlmfi
	jh6V2laSD2W+PGEDFSqlGb8YoMf5+7ddjvXR0fiAomrwAtD3FDnuCMWpiVzzjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2c1xVI1G9qKeLg5Cn/WeTC9NVB748aI4bpBGv+D/NU=;
	b=DT8lEzvcOx7LLAtXfplQF8sDmnyYVZ3ZVmnDbJPXERGEGfuDTy4XSp+gpqZXL7M3lRlOfB
	cij8rYBi9MiYxCAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 08/19] printk: nbcon: Add context to usable() and emit()
Date: Mon, 22 Jul 2024 19:25:28 +0206
Message-Id: <20240722171939.3349410-9-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
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
---
 include/linux/console.h  |  2 +-
 kernel/printk/internal.h |  8 +++++---
 kernel/printk/nbcon.c    | 25 +++++++++++++++++++------
 kernel/printk/printk.c   |  6 +++---
 4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 38ef6e64da19..5e9285e886f5 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -349,7 +349,7 @@ struct console {
 	/**
 	 * @write_atomic:
 	 *
-	 * NBCON callback to write out text in any context.
+	 * NBCON callback to write out text in any context. (Optional)
 	 *
 	 * This callback is called with the console already acquired. However,
 	 * a higher priority context is allowed to take it over by default.
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ccdb81dc18f0..8211623aee9b 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -98,7 +98,7 @@ bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
  * which can also play a role in deciding if @con can be used to print
  * records.
  */
-static inline bool console_is_usable(struct console *con, short flags)
+static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
 {
 	if (!(flags & CON_ENABLED))
 		return false;
@@ -107,7 +107,8 @@ static inline bool console_is_usable(struct console *con, short flags)
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
index 917022105b8b..ae9cd6d0b740 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -914,6 +914,7 @@ EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
+ * @use_atomic:	True if the write_atomic() callback is to be used
  *
  * Return:	True if this context still owns the console. False if
  *		ownership was handed over or taken.
@@ -927,7 +928,7 @@ EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
  * When true is returned, @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
+static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_atomic)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 	struct console *con = ctxt->console;
@@ -938,6 +939,18 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
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
@@ -972,7 +985,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	/* Initialize the write context for driver callbacks. */
 	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
-	if (con->write_atomic) {
+	if (use_atomic) {
 		con->write_atomic(con, wctxt);
 	} else {
 		/*
@@ -1104,7 +1117,7 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	 * The higher priority printing context takes over responsibility
 	 * to print the pending records.
 	 */
-	if (!nbcon_emit_next_record(wctxt))
+	if (!nbcon_emit_next_record(wctxt, true))
 		return false;
 
 	nbcon_context_release(ctxt);
@@ -1205,7 +1218,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 		 * handed over or taken over. In both cases the context is no
 		 * longer valid.
 		 */
-		if (!nbcon_emit_next_record(&wctxt))
+		if (!nbcon_emit_next_record(&wctxt, true))
 			return -EAGAIN;
 
 		if (!ctxt->backlog) {
@@ -1294,7 +1307,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
 		if (!(flags & CON_NBCON))
 			continue;
 
-		if (!console_is_usable(con, flags))
+		if (!console_is_usable(con, flags, true))
 			continue;
 
 		if (nbcon_seq_read(con) >= stop_seq)
@@ -1552,7 +1565,7 @@ void nbcon_device_release(struct console *con)
 	printk_get_console_flush_type(&ft, false);
 	cookie = console_srcu_read_lock();
 	if (ft.nbcon_atomic &&
-	    console_is_usable(con, console_srcu_read_flags(con)) &&
+	    console_is_usable(con, console_srcu_read_flags(con), true) &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb), false);
 	}
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3fbe27551f75..e5e575384b3c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3018,7 +3018,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			u64 printk_seq;
 			bool progress;
 
-			if (!console_is_usable(con, flags))
+			if (!console_is_usable(con, flags, true))
 				continue;
 			any_usable = true;
 
@@ -3717,7 +3717,7 @@ static int unregister_console_locked(struct console *console)
 
 	if (!console_is_registered_locked(console))
 		res = -ENODEV;
-	else if (console_is_usable(console, console->flags))
+	else if (console_is_usable(console, console->flags, true))
 		__pr_flush(console, 1000, true);
 
 	/* Disable it unconditionally */
@@ -3993,7 +3993,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c, flags))
+			if (!console_is_usable(c, flags, true))
 				continue;
 
 			if (flags & CON_NBCON) {
-- 
2.39.2


