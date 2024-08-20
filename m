Return-Path: <linux-kernel+bounces-293347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38173957E35
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5DD1C23E50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE06020127B;
	Tue, 20 Aug 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sDEv+Koy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhkwCSUs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE571E6739
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135415; cv=none; b=Xdv4pCtZXgWzdCY9WTmyRLeOzgr3MVfjA7iyUkUwCmhAmfzQVPHnfDrpVmLUFYwaeeXOzb/E74rIREHtRgxrJ9nXvNGFuzWl305Cw2cCErcRP1XLjPn3HxK3kuYtona+nr6S5wWiu7E8W9GYqN7sxMwS8VPgnCFVvh6hpzPapa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135415; c=relaxed/simple;
	bh=EuY1karmZHQCdc0BrgyqwwQbtZF2KquBxbCraHzRjp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P3vmBxhs66gcjKiR2fXGkBYC4i6efO3d61SXDpiUG6iyNSEWClSODjXS0zQ3ckud0XsjoNAzQpD5H0fjHD39E8yrDsFwY7AG1GH+hK5Tp4k367erkee5U1lpMwP84NEWxwPqXaVIexfClHL3WS1VVCgkUBtGgXNDxXiFoBKq8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sDEv+Koy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VhkwCSUs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Kje0ATM9ChnUy7eEmipOsI1z8jXVDszL+xoENEAEAY=;
	b=sDEv+Koy/vRbFBPu5AFOTRFMad3576PGwVRSTspfFRFU2WDkTashD43fbQkdiW/5y+t0m7
	ku6HySHo2SihkTRRd/57dyUV1o5sdTwA57zXfwPQ+SbrHLU/Q9uhQHTqFzzQgZBFwnd47k
	Xji5yiW9HmsGKsxFyrEGahY8HiwLuLkPixrv3iMbI0XotfjXmIJcAa3WYSxwSt/DB4Lgi+
	O6afIn7no2pIv7fJSBXh/lNo58Eu4pip98Zi/ekYt5TGjKDi9w5oaeWY9BoCcKK3AKL82j
	ep+ShZFOXKO1EuTOfQe7FtUY6dIZLmAYdU8JXUkAVKwTW+Ij/dlqXIj/Mu5isQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Kje0ATM9ChnUy7eEmipOsI1z8jXVDszL+xoENEAEAY=;
	b=VhkwCSUsh6vs0Xnd/+EvuonMfcoeaj7QXZU1wwnV/G/COf6kS6fHKr4REYsnlSmuaL5fNG
	Lng1MdHAJuRQAFBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 22/35] printk: nbcon: Use nbcon consoles in console_flush_all()
Date: Tue, 20 Aug 2024 08:35:48 +0206
Message-Id: <20240820063001.36405-23-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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
index 0dc9b92b5dd0..44468f3828f3 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -78,6 +78,8 @@ void defer_console_output(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
+void console_lock_spinning_enable(void);
+int console_lock_spinning_disable_and_check(int cookie);
 
 u64 nbcon_seq_read(struct console *con);
 void nbcon_seq_force(struct console *con, u64 seq);
@@ -85,6 +87,8 @@ bool nbcon_alloc(struct console *con);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
+bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+				   int cookie);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -140,6 +144,8 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_pending(void) { }
+static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
+						 int cookie) { return false; }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 3982d68979d6..d09c084c9af4 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -992,6 +992,93 @@ enum nbcon_prio nbcon_get_default_prio(void)
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
index b8634a153d1d..f08bf5e82fc7 100644
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
 
@@ -3021,13 +3021,20 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
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
@@ -3037,8 +3044,8 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
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


