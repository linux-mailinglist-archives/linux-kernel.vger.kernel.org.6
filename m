Return-Path: <linux-kernel+bounces-199837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A538FA67E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F5F1F28C89
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9408614264A;
	Mon,  3 Jun 2024 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i8jFjHw+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhR94kBB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E613DB99
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457105; cv=none; b=PkazDtERN2zTXJDSQkrO2JNdw/4lCryLrkv9uD5mTzHFVydn0a1oLDfnXVIq2MNvGy9VH5neah4XZ97EmyzZW/qvVY4zq+QH66mRoTSO9wBbj6lXat2cIU5RmNHy37o4Pc0eTVKp/cDMH5+DKVS5AEveSQu0ja2Igg5cXIIX6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457105; c=relaxed/simple;
	bh=mw7cQ+FxaYowLEMZlVrUFi9i+grzxHJlJgNLS1vc3NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QIsj1U1qoCEV4N5vqV+QpINOE16wS+H5z/FPLzib5pDDk+qzM5UrKiN7HPMTGgC7u+OqWjV+KS+CvwDt0Ka9qIgUKXsWOloR04sPS8Xb7p3yIfl1pSsJNCgVaRTOTI9Owlnkr4djysdgSa2+Epi9YHoJ31w7j0/VUyksKEDaGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i8jFjHw+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VhR94kBB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ic2rSbk+60U0wta2R3AH4a6suWFhXIL12Fm/tXauPlI=;
	b=i8jFjHw+saIi0bOZ80VAukv7aDi98Lfx4hiUjv9uqdqcFm4+jjEBzEzo83leDrb25bOikV
	p6CpMpq5kWNZa9nEv+U1raT9z6CZKxMk+OnHOWyQ4r/shbr0mun+7T48puGb9KuRAy03tr
	gqv/jQfeNL8uDs77RqVYSN+mJ8hyI1y594tsFW/pfZ5pVqSSJa17K9r+597aKGpK7QntBq
	c5EEnWySetR25WN61CrJg1ap5rTQnrzkX/DewLqaWoJAI9korZSC9q7RHkswwVKT1v4Qbh
	2aF8suuGPlir5WandgKcoRQlweo0iM16KAtsxxbshEToZ6WCQdIaYoLyMk0K7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ic2rSbk+60U0wta2R3AH4a6suWFhXIL12Fm/tXauPlI=;
	b=VhR94kBBQojOusNbQnESARW2oY7H6lF7un9C1awKKgs8E3f9dKZVCdP/eRaPgbSffhCwfm
	ZhKB7bruNHpNukDw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 18/18] printk: nbcon: Add function for printers to reacquire ownership
Date: Tue,  4 Jun 2024 01:30:53 +0206
Message-Id: <20240603232453.33992-19-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
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

Provide nbcon_reacquire() for exactly this purpose. It allows a
printing context to reacquire ownership using the same priority
as its previous ownership.

Note that after a successful reacquire the printing context
will have no output buffer because that has been lost. This
function cannot be used to resume printing.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  6 ++++++
 kernel/printk/nbcon.c   | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 9927f08ac054..96c0923d023b 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -372,6 +372,10 @@ struct console {
 	 *
 	 * The callback should allow the takeover whenever it is safe. It
 	 * increases the chance to see messages when the system is in trouble.
+	 * If the driver must reacquire ownership in order to finalize or
+	 * revert hardware changes, nbcon_reacquire() can be used. However,
+	 * on reacquire the buffer content is no longer available. A
+	 * reacquire cannot be used to resume printing.
 	 *
 	 * The callback can be called from any context (including NMI).
 	 * Therefore it must avoid usage of any locking and instead rely
@@ -591,6 +595,7 @@ extern void nbcon_cpu_emergency_flush(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
+extern void nbcon_reacquire(struct nbcon_write_context *wctxt);
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
@@ -598,6 +603,7 @@ static inline void nbcon_cpu_emergency_flush(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_reacquire(struct nbcon_write_context *wctxt) { }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index e8060b5abdf8..4b9645e7ed70 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -838,6 +838,38 @@ bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 
+/**
+ * nbcon_reacquire - Reacquire a console after losing ownership while printing
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
+void nbcon_reacquire(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	struct nbcon_state cur;
+
+	while (!nbcon_context_try_acquire(ctxt))
+		cpu_relax();
+
+	wctxt->outbuf = NULL;
+	wctxt->len = 0;
+	nbcon_state_read(con, &cur);
+	wctxt->unsafe_takeover = cur.unsafe_takeover;
+}
+EXPORT_SYMBOL_GPL(nbcon_reacquire);
+
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
@@ -945,6 +977,15 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
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


