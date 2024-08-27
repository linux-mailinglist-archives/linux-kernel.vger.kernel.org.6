Return-Path: <linux-kernel+bounces-302566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C6960068
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC971C219AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C513D291;
	Tue, 27 Aug 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jW2TK+0F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6xIT9O1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D914EB5E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733818; cv=none; b=M5e4I2rgN3AnUU3krm226jXmVgOcJV7lU2XXbG++ps4yjIbg5bLwjzfCko+RnVkfRBOrHkO2aIK4NRul/GcAgw6bw0A0StuqC1vMP1n2oyde3Xiq47HdO0x2thchfffwW+jwdJO0s8KTJnFOEfbLFv8o1hyjOmjVS+tqMFTwk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733818; c=relaxed/simple;
	bh=uYu4mQMFuI8yeG9XvXlfOKjSdd3b0lBbmmwodCwqC2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrFN/2snkqOSwuXaZs+QAu6hDwQm+K6/dPkn+nlsAtwjPF+e2WUjR2F3yfGLIKmWbIxdBm7Qm3Fe550KbQmh8IqnCmtTBawNRh+VFrHi69escKjM69zBTpPo3hAJAZ+c0ae/QTFVGDmCgBEOzNc8bxjogUj+CRXS4pw23tOBYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jW2TK+0F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6xIT9O1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yf4jbljXWY8PAPTbbDHBJy4C3txbuHDOpF+lqNl4ktA=;
	b=jW2TK+0FRq5XXsLNJbp1didRdjDUrRmDEp3DoeD0ykDmMg2JkfFa3PJK13wOguxiM3I3vQ
	nueQ+naKQwOq8xke4iVbN7/FGbVXemcwjluq6euMp11v3qAZu2y01mQPdXmGE0lWHd57aw
	A/+tlkbSCGIO5Ve+HszWdegT0FfCkrg+hHlnXWRn/5+vts5p1qcoWwOwaLzwEPoBZ5az87
	/YmVIaIo86jfFZYXZl8odlGJ7BqfQQ6TaflnMxxlL1av8A1NVdfsqvqt8kRolh+jpLiApP
	th8YiP13MRrY72/TbaKiP4a5BSqQPo/fuSHSwJlXX9DycGF0/MioJUBM13OYuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yf4jbljXWY8PAPTbbDHBJy4C3txbuHDOpF+lqNl4ktA=;
	b=D6xIT9O1Zta8ss+J8ltHJzNlZnX1xVF9U3Q6XwOTjmWZ06RhoKNQIxY5+6zcAsTsXfYQEj
	47d5HnbHLOBSQoDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 01/17] printk: nbcon: Add function for printers to reacquire ownership
Date: Tue, 27 Aug 2024 06:49:17 +0206
Message-Id: <20240827044333.88596-2-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since ownership can be lost at any time due to handover or
takeover, a printing context _must_ be prepared to back out
immediately and carefully. However, there are scenarios where
the printing context must reacquire ownership in order to
finalize or revert hardware changes.

One such example is when interrupts are disabled during
printing. No other context will automagically re-enable the
interrupts. For this case, the disabling context _must_
reacquire nbcon ownership so that it can re-enable the
interrupts.

Provide nbcon_reacquire_nobuf() for exactly this purpose. It
allows a printing context to reacquire ownership using the same
priority as its previous ownership.

Note that after a successful reacquire the printing context
will have no output buffer because that has been lost. This
function cannot be used to resume printing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  6 ++++
 kernel/printk/nbcon.c   | 74 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 9a13f91b0c43..88050d30a9cc 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -366,6 +366,10 @@ struct console {
 	 *
 	 * The callback should allow the takeover whenever it is safe. It
 	 * increases the chance to see messages when the system is in trouble.
+	 * If the driver must reacquire ownership in order to finalize or
+	 * revert hardware changes, nbcon_reacquire_nobuf() can be used.
+	 * However, on reacquire the buffer content is no longer available. A
+	 * reacquire cannot be used to resume printing.
 	 *
 	 * The callback can be called from any context (including NMI).
 	 * Therefore it must avoid usage of any locking and instead rely
@@ -558,12 +562,14 @@ extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
+extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 92ac5c590927..d1c640e7e645 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -830,6 +830,19 @@ static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsaf
 	return nbcon_context_can_proceed(ctxt, &cur);
 }
 
+static void nbcon_write_context_set_buf(struct nbcon_write_context *wctxt,
+					char *buf, unsigned int len)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	struct nbcon_state cur;
+
+	wctxt->outbuf = buf;
+	wctxt->len = len;
+	nbcon_state_read(con, &cur);
+	wctxt->unsafe_takeover = cur.unsafe_takeover;
+}
+
 /**
  * nbcon_enter_unsafe - Enter an unsafe region in the driver
  * @wctxt:	The write context that was handed to the write function
@@ -845,8 +858,12 @@ static bool __nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsaf
 bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	bool is_owner;
 
-	return nbcon_context_enter_unsafe(ctxt);
+	is_owner = nbcon_context_enter_unsafe(ctxt);
+	if (!is_owner)
+		nbcon_write_context_set_buf(wctxt, NULL, 0);
+	return is_owner;
 }
 EXPORT_SYMBOL_GPL(nbcon_enter_unsafe);
 
@@ -865,11 +882,43 @@ EXPORT_SYMBOL_GPL(nbcon_enter_unsafe);
 bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	bool ret;
 
-	return nbcon_context_exit_unsafe(ctxt);
+	ret = nbcon_context_exit_unsafe(ctxt);
+	if (!ret)
+		nbcon_write_context_set_buf(wctxt, NULL, 0);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 
+/**
+ * nbcon_reacquire_nobuf - Reacquire a console after losing ownership
+ *				while printing
+ * @wctxt:	The write context that was handed to the write callback
+ *
+ * Since ownership can be lost at any time due to handover or takeover, a
+ * printing context _must_ be prepared to back out immediately and
+ * carefully. However, there are scenarios where the printing context must
+ * reacquire ownership in order to finalize or revert hardware changes.
+ *
+ * This function allows a printing context to reacquire ownership using the
+ * same priority as its previous ownership.
+ *
+ * Note that after a successful reacquire the printing context will have no
+ * output buffer because that has been lost. This function cannot be used to
+ * resume printing.
+ */
+void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	while (!nbcon_context_try_acquire(ctxt))
+		cpu_relax();
+
+	nbcon_write_context_set_buf(wctxt, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(nbcon_reacquire_nobuf);
+
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
@@ -895,7 +944,6 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 		.pbufs = ctxt->pbufs,
 	};
 	unsigned long con_dropped;
-	struct nbcon_state cur;
 	unsigned long dropped;
 
 	/*
@@ -930,10 +978,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 		goto update_con;
 
 	/* Initialize the write context for driver callbacks. */
-	wctxt->outbuf = &pmsg.pbufs->outbuf[0];
-	wctxt->len = pmsg.outbuf_len;
-	nbcon_state_read(con, &cur);
-	wctxt->unsafe_takeover = cur.unsafe_takeover;
+	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
 	if (con->write_atomic) {
 		con->write_atomic(con, wctxt);
@@ -947,6 +992,21 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 		return false;
 	}
 
+	if (!wctxt->outbuf) {
+		/*
+		 * Ownership was lost and reacquired by the driver. Handle it
+		 * as if ownership was lost.
+		 */
+		nbcon_context_release(ctxt);
+		return false;
+	}
+
+	/*
+	 * Ownership may have been lost but _not_ reacquired by the driver.
+	 * This case is detected and handled when entering unsafe to update
+	 * dropped/seq values.
+	 */
+
 	/*
 	 * Since any dropped message was successfully output, reset the
 	 * dropped count for the console.
-- 
2.39.2


