Return-Path: <linux-kernel+bounces-190096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8758CF963
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BF5B215DA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4336913BC1B;
	Mon, 27 May 2024 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IzsJikse";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ScfevS/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543C537F2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791908; cv=none; b=mZdQWXrJuuv/EGTc0pwDzW9XDmilrYzv80nk/IPDcufk747FUj9n//1qitebd4/cJDZXepAiH189JygGBrxTKgVTTqPsJlgBPuOGwiG0zxh8DdFsZw03KgRlrW+ucypL8Ltpbqgn3G9lEw4vCnEVPQHF8xc2Ci9AP+KPx4QmeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791908; c=relaxed/simple;
	bh=Q6b6AVR+OLPi2moRw9nS56wTI2Qvg3VL+I9G/3D9t3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=drtt5WdALahA8Ea0RMSas6mq439mNa/d29B5vlgQAA2wYVP5rsmvj2CkzlMxB4SMCXkWio3OwRvX+wPHjFteOGwCeMGD8+j+yk7Rch6DNYXKEgeu2g0ErDPMgMCCKv/N6Wi/RJCwUISo5yHNyxZBwNjy4n0PO0feQH3qZjbI1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IzsJikse; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ScfevS/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3In+KGOOeAXG80pN26YZIQE7Yh4V5NoQeSHCFrtsvU=;
	b=IzsJikseyh7cFQVKhRQZhdxqns8x0P2CGGeKKVYR/hBrGIDKHJ4VKbTebjSVGCxyZLcqkm
	waDbIAjQxP8MUGUVV0KAOM5b9jCKXBqDIzbKK2wENYWYwI8R/Ce8L2zT0WAdePHy/7Bmjr
	fJE2ep65pTv/Rj3ZAgNu+Sia4++M8STqwQNLwGgdBsXfaCvqQdFvF6SznXC7Kyt0T3aunr
	WIpo2Hi8xbl3ia8F5deu15WTJHCo0mXUrZmR20urN/3f5ixwc09GeUdr6nChFO/BTuPCz5
	7HBImiCd9a2CyliVeprRt7Ys8C3chwu8+KO1OpNROSjb4VS7x56m0OcP/dfX4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3In+KGOOeAXG80pN26YZIQE7Yh4V5NoQeSHCFrtsvU=;
	b=1ScfevS/Ae6sD8CaeGPDW/93aQoAdCYPhZH7U1QuCYKoBahOJms+/gN3gGXGarEejIaGYX
	FRnsWuGgbgq5tgBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 21/30] printk: nbcon: Use nbcon consoles in console_flush_all()
Date: Mon, 27 May 2024 08:43:40 +0206
Message-Id: <20240527063749.391035-22-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow nbcon consoles to print messages in the legacy printk()
caller context (printing via unlock) by integrating them into
console_flush_all(). The write_atomic() callback is used for
printing.

Provide nbcon_legacy_emit_next_record(), which acts as the
nbcon variant of console_emit_next_record(). Call this variant
within console_flush_all() for nbcon consoles. Since nbcon
consoles use their own @nbcon_seq variable to track the next
record to print, this also must be appropriately handled in
console_flush_all().

Note that the legacy printing logic uses @handover to detect
handovers for printing all consoles. For nbcon consoles,
handovers/takeovers occur on a per-console basis and thus do
not cause the console_flush_all() loop to abort.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  6 +++
 kernel/printk/nbcon.c    | 87 ++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   | 17 +++++---
 3 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 5a93825871de..91bc0ee43f8d 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -78,6 +78,8 @@ void defer_console_output(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
+void console_lock_spinning_enable(void);
+int console_lock_spinning_disable_and_check(int cookie);
 
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
@@ -86,6 +88,8 @@ void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
+bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+				   int cookie);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -142,6 +146,8 @@ static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_pending(void) { }
+static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+						 int cookie) { return false; }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fc48fcb4da9b..f6fbcf6d80fa 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -953,6 +953,93 @@ enum nbcon_prio nbcon_get_default_prio(void)
 }
 
 /*
+ * nbcon_atomic_emit_one - Print one record for an nbcon console using the
+ *				write_atomic() callback
+ * @wctxt:	An initialized write context struct to use for this context
+ *
+ * Return:	True, when a record has been printed and there are still
+ *		pending records. The caller might want to continue flushing.
+ *
+ *		False, when there is no pending record, or when the console
+ *		context cannot be acquired, or the ownership has been lost.
+ *		The caller should give up. Either the job is done, cannot be
+ *		done, or will be handled by the owning context.
+ *
+ * This is an internal helper to handle the locking of the console before
+ * calling nbcon_emit_next_record().
+ */
+static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return false;
+
+	/*
+	 * nbcon_emit_next_record() returns false when the console was
+	 * handed over or taken over. In both cases the context is no
+	 * longer valid.
+	 *
+	 * The higher priority printing context takes over responsibility
+	 * to print the pending records.
+	 */
+	if (!nbcon_emit_next_record(wctxt))
+		return false;
+
+	nbcon_context_release(ctxt);
+
+	return ctxt->backlog;
+}
+
+/**
+ * nbcon_legacy_emit_next_record - Print one record for an nbcon console
+ *					in legacy contexts
+ * @con:	The console to print on
+ * @handover:	Will be set to true if a printk waiter has taken over the
+ *		console_lock, in which case the caller is no longer holding
+ *		both the console_lock and the SRCU read lock. Otherwise it
+ *		is set to false.
+ * @cookie:	The cookie from the SRCU read lock.
+ *
+ * Context:	Any context except NMI.
+ * Return:	True, when a record has been printed and there are still
+ *		pending records. The caller might want to continue flushing.
+ *
+ *		False, when there is no pending record, or when the console
+ *		context cannot be acquired, or the ownership has been lost.
+ *		The caller should give up. Either the job is done, cannot be
+ *		done, or will be handled by the owning context.
+ *
+ * This function is meant to be called by console_flush_all() to print records
+ * on nbcon consoles from legacy context (printing via console unlocking).
+ * Essentially it is the nbcon version of console_emit_next_record().
+ */
+bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+				   int cookie)
+{
+	struct nbcon_write_context wctxt = { };
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+	unsigned long flags;
+	bool progress;
+
+	/* Use the same procedure as console_emit_next_record(). */
+	printk_safe_enter_irqsave(flags);
+	console_lock_spinning_enable();
+	stop_critical_timings();
+
+	ctxt->console	= con;
+	ctxt->prio	= nbcon_get_default_prio();
+
+	progress = nbcon_atomic_emit_one(&wctxt);
+
+	start_critical_timings();
+	*handover = console_lock_spinning_disable_and_check(cookie);
+	printk_safe_exit_irqrestore(flags);
+
+	return progress;
+}
+
+/**
  * __nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
  *					write_atomic() callback
  * @con:			The nbcon console to flush
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d81d541558fd..9a7532cff8d2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1860,7 +1860,7 @@ static bool console_waiter;
  * there may be a waiter spinning (like a spinlock). Also it must be
  * ready to hand over the lock at the end of the section.
  */
-static void console_lock_spinning_enable(void)
+void console_lock_spinning_enable(void)
 {
 	/*
 	 * Do not use spinning in panic(). The panic CPU wants to keep the lock.
@@ -1899,7 +1899,7 @@ static void console_lock_spinning_enable(void)
  *
  * Return: 1 if the lock rights were passed, 0 otherwise.
  */
-static int console_lock_spinning_disable_and_check(int cookie)
+int console_lock_spinning_disable_and_check(int cookie)
 {
 	int waiter;
 
@@ -2951,13 +2951,20 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
 			short flags = console_srcu_read_flags(con);
+			u64 printk_seq;
 			bool progress;
 
 			if (!console_is_usable(con, flags))
 				continue;
 			any_usable = true;
 
-			progress = console_emit_next_record(con, handover, cookie);
+			if (flags & CON_NBCON) {
+				progress = nbcon_legacy_emit_next_record(con, handover, cookie);
+				printk_seq = nbcon_seq_read(con);
+			} else {
+				progress = console_emit_next_record(con, handover, cookie);
+				printk_seq = con->seq;
+			}
 
 			/*
 			 * If a handover has occurred, the SRCU read lock
@@ -2967,8 +2974,8 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 				return false;
 
 			/* Track the next of the highest seq flushed. */
-			if (con->seq > *next_seq)
-				*next_seq = con->seq;
+			if (printk_seq > *next_seq)
+				*next_seq = printk_seq;
 
 			if (!progress)
 				continue;
-- 
2.39.2


