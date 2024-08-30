Return-Path: <linux-kernel+bounces-309034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468DA966576
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B201F21644
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E121B655F;
	Fri, 30 Aug 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gp37x8Nm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WO1vmUGW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC621B5811
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031766; cv=none; b=kHeFLllKh71/+P3qGh/tpNwlBfXQrt3lK4zGuLF0HuFt92FP36IhbMGjQGSHM6NyIVWy6DpQxVR2NoO9SKV1V0emjMAtSounuQgO4WS8vwpS305WJv5Lsn2wxPmSL6p1OUI8V9jAXrdV8XqPKBAoL+BykVg0xtSfuUymyej6Vpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031766; c=relaxed/simple;
	bh=Z2FzLOhrYPb4SwVt3LRiu+LCw82+Xjl4A5u2HlGOY7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5BbUeAjg/WwOr4/JahD2pwtQUtWUufVinTGzEkPz+W9Kqk2z+wpkwIUwtkkClEchZjPzYIcYFuJIxzWNWjfSJBQAbSzGP3Fc8awdJEmVIcXladUHa9/MxEvjVih76XGLjrAJCcI7gU9x5RO1bj3wUkSKVpqEoq/qYlXg0VKl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gp37x8Nm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WO1vmUGW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qs4boc16pkWZxtexxvPfNeVBSJ9Cag6SQbs3NPVnzWA=;
	b=Gp37x8NmtpOR5JxSiHY2bVA2DuFda/MLUxkVy5yGX+pcAd1vcPpv8pL6m8FEj3b0QptkhE
	LV1h3auXVnm3OsB33EluXT9qws6xwZWViZSGehEo9dpUB7ritEthveqt2Vx8mqHDC2IcF2
	+XAMFKAnpGfCde3I+3YhKne71Ql3yCdl0QFjefKqRIyatjJkIMjvxxMroaSe06Q97K3Ind
	o8xhs/SIeaJNEtSOqSbstobMwSrGqcu1UuiCeCWGaXLUW4P5t5Mwze519eyGB4Xtpr0M0z
	Ib5PFHDtIS3gcmeduUuQYcE5us+eMYg4LjwZyJ9S+pIiFqJ/4Fpk6IDESm7FWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qs4boc16pkWZxtexxvPfNeVBSJ9Cag6SQbs3NPVnzWA=;
	b=WO1vmUGW2q6ICk0vvOsZ96YSVscllFHlVGDAUoGFkFHgF2cHHyjKDLYokQX1deze+03Rr2
	q1sJ8M3UtRFJiYDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 01/17] printk: nbcon: Add function for printers to reacquire ownership
Date: Fri, 30 Aug 2024 17:35:00 +0206
Message-Id: <20240830152916.10136-2-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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


