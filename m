Return-Path: <linux-kernel+bounces-302565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278B960067
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263D61C21EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C913C9A9;
	Tue, 27 Aug 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJXeOIBR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jwQAz4Xw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D05A4D5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733818; cv=none; b=HEdge2E/0S54niHAAKjVZ8IYKLm6oY9OiW974JpEp/AwI19UYBZrEaO3MTmU+INt6v9rruP1RSR/GO6BunRh47VteSSNQhnVl4iOrx49szmS76CicVem7z5sdgSgDX5l58poiQKOI802Ks0kbmmD7e30tkdDDbH5y9KV3OAzh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733818; c=relaxed/simple;
	bh=CbFsGyHVClMvGt6qKSP3h17q8ilW3/7SuhYwURG4p2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6DxUfBkrqlARRA57mdQhZ/44Dx44MnrSw3E8d9WWD2/arSyL+wlhDkd70ymdwFNq5oGdLJTKT/5QXsuGmAM5ryGRB42PGuPRVqtfwl24jc9sj5TXpDP772Phb76idwHXjHSq/9PXKKXEi5fsLgsZcZQ7eSCSyBdam65R7zCSbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tJXeOIBR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jwQAz4Xw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc1DpkMZMf3xeK5PE6XCQrymc1EeZpAAWNqJhRXdseA=;
	b=tJXeOIBRWvG18QaZdEWFIpEagCTVCkgW+SvIaw9pI8TH55ipVZH1qmOzD/5RwTViBUjkSX
	CuxikW9Ra8AVkQQ1+5zXbB5fCpblUsprxxy2YcO3asPKYXRtZjRHrcCVAFtOjYjA44x7fJ
	HWqyOcRV5ua1ptX8kTW6Qu5xjndw0uI1nIcdgJW8rJryBaRxW+ptbLvNlgZJZJoh5Qzb3k
	FcgBKq29OkAr91GsKI12e8k3bziKzNH66bwfkBVt/gRJKj0YYmGo6T+dSdiR5IU9IO3oEH
	VrPgBtmfTzrpQQYZK2BWDpW6xGtuZPiXNQ+Dn3OzNvtXw72B+sp3hjXJnbu/dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc1DpkMZMf3xeK5PE6XCQrymc1EeZpAAWNqJhRXdseA=;
	b=jwQAz4Xwb7IM+uoHXk2PS/4hddiAjj/9ue/o2rBtmCHdBgNk4KDd0oR5P5xV6uhOHdy26q
	Qt3zjYZGzvOE3uCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 04/17] printk: nbcon: Add context to usable() and emit()
Date: Tue, 27 Aug 2024 06:49:20 +0206
Message-Id: <20240827044333.88596-5-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
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
index d1c640e7e645..de6faf34e114 100644
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
@@ -1119,7 +1123,7 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	 * The higher priority printing context takes over responsibility
 	 * to print the pending records.
 	 */
-	if (!nbcon_emit_next_record(wctxt))
+	if (!nbcon_emit_next_record(wctxt, true))
 		return false;
 
 	nbcon_context_release(ctxt);
@@ -1220,7 +1224,7 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 		 * handed over or taken over. In both cases the context is no
 		 * longer valid.
 		 */
-		if (!nbcon_emit_next_record(&wctxt))
+		if (!nbcon_emit_next_record(&wctxt, true))
 			return -EAGAIN;
 
 		if (!ctxt->backlog) {
@@ -1306,7 +1310,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
 		if (!(flags & CON_NBCON))
 			continue;
 
-		if (!console_is_usable(con, flags))
+		if (!console_is_usable(con, flags, true))
 			continue;
 
 		if (nbcon_seq_read(con) >= stop_seq)
@@ -1491,7 +1495,7 @@ void nbcon_device_release(struct console *con)
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


