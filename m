Return-Path: <linux-kernel+bounces-259241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE6939317
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E8D2827EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D36E16F291;
	Mon, 22 Jul 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i5dvPBqw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cn3OKCHl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558516E870
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668790; cv=none; b=JDWRz5K4XJqlJxE59e/FqDu/oPxs5jc9RTa3xfITMqGCG09Bvf2z1xONr47Q1yVQT5EseMwKFdxTZiPhEVmrUlnbLOLjeG7JVt/xzX9fxjYrmacSo+C6ZHgg7vMlD+ysF/5eimjdE/tLfcq9n55tIBuu5ueg2unVsKh4W/R02pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668790; c=relaxed/simple;
	bh=HuC/CKF1NiRZ7YVPgWU3HdnJRNKQE8cNb/fsf4HFiqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9CYTxa4YC9jBagcZvUc/V1GyHXpVH/LnaTxk7XF+lLdWfrxPm3F0O0LYWXxb0TbRzj5C+oHldwQS9bw6N8SktwISGNrBOmWBtjMhu8MBCC2m3d7U+q3c4J1Qxo1erxbOLR5XNwV5if5tgIz+b2b/eRKZqBzajTKSFtZMO1aRxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i5dvPBqw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cn3OKCHl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWsbf0ByLpBwUeUrEFtNFqNZvJfvWeXWa7MTgQrlekU=;
	b=i5dvPBqw4j5CMQpj0GdW/MiZ1JPj2Movmzk2z/Sk1uBQe6lk/J+WdX43b7hEKcNJEr/V8m
	QURNtIZWqd9rLprBxDgT64MyzT8iGGeQ0NjXuPJS74kdBR8nDdu6Uh0ALr2B0AWL2l3Yrt
	MKeLQvNTsmEnbS3WSgBsgqA7+cd7HnXIBVYS3oxazaao94epCOHNxWPqyUuIBBk0BZ/7Ra
	c9HzL6QThyaA958O9/+ob2uQZMUCMC8lkhK6pAlMNzYxmBDO2nL5XNQjTxYe74qIANzyED
	oSxPgYXnvbp7K/wiMpvfZ0TNkpHm2V0FL9lLiki9an9rlXQ6s7OxKr2o47X01Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nWsbf0ByLpBwUeUrEFtNFqNZvJfvWeXWa7MTgQrlekU=;
	b=cn3OKCHlTy8Wp8lPF451APtllAC4qAQ4UDh01ye/CrwMRe79p0AheNmSI7IW59Tu1lEup4
	5+yMG5k/dB/+J6DQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 03/19] printk: nbcon: Add function for printers to reacquire ownership
Date: Mon, 22 Jul 2024 19:25:23 +0206
Message-Id: <20240722171939.3349410-4-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
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
 include/linux/console.h |  6 +++++
 kernel/printk/nbcon.c   | 56 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 4aaf053840ee..38ef6e64da19 100644
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
@@ -559,6 +563,7 @@ extern void nbcon_cpu_emergency_flush(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
+extern void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt);
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
@@ -566,6 +571,7 @@ static inline void nbcon_cpu_emergency_flush(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 1388e23a439f..18a83d181622 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -834,6 +834,47 @@ bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 
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
@@ -859,7 +900,6 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 		.pbufs = ctxt->pbufs,
 	};
 	unsigned long con_dropped;
-	struct nbcon_state cur;
 	unsigned long dropped;
 
 	/*
@@ -894,10 +934,7 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 		goto update_con;
 
 	/* Initialize the write context for driver callbacks. */
-	wctxt->outbuf = &pmsg.pbufs->outbuf[0];
-	wctxt->len = pmsg.outbuf_len;
-	nbcon_state_read(con, &cur);
-	wctxt->unsafe_takeover = cur.unsafe_takeover;
+	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
 	if (con->write_atomic) {
 		con->write_atomic(con, wctxt);
@@ -911,6 +948,15 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 		return false;
 	}
 
+	if (!wctxt->outbuf) {
+		/*
+		 * Ownership was lost and reacquired by the driver.
+		 * Handle it as if ownership was lost.
+		 */
+		nbcon_context_release(ctxt);
+		return false;
+	}
+
 	/*
 	 * Since any dropped message was successfully output, reset the
 	 * dropped count for the console.
-- 
2.39.2


