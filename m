Return-Path: <linux-kernel+bounces-259256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6F8939329
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D285E1C216C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A709E17334E;
	Mon, 22 Jul 2024 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nr1kIEKo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EgmcqHaa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7F16F82C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668796; cv=none; b=K9dCnAwdREd96TZbspNsPR5H+WLRGtZLzlHhpgyPeCgjicT4QJxrNFwYcH9r6czI7e9m+iF/eC5gDM3Po9M5tdbmYJ2nuxIc8ZYRPGW4A4zBgC370t5HS5DzbVWbGZbhX2u2B0b3pWQJtCPKAbD6ZofDODk7A5asv1JCsH83fIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668796; c=relaxed/simple;
	bh=0pWo/lQazb7NN5gzVmtuRvxoOY+AY0WMnuqYiPdi0fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzrPYganU6aO/KJMA42GP1MfEzOJbtCKB0fAnBaiolZ4lAHWwbPRaL0xi1aY8D6QY6UYkwqnl2vkM4a8tzd6nxslYKN6gMaPtCe5WSmWLwh7CmVQsjaP3BBhtkc8Ygp1/yoEz0hZ+NFGHLtVgFtUHuNvPnduaZzOg0wujOd2hNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nr1kIEKo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EgmcqHaa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HthQAGS/lHQGcobZEvlVi78Lh6Enw1uHeqNlN4mMXhw=;
	b=nr1kIEKoUJsm6Zc9pErp/I2ZBbg6dtF00n8Yd/MooTjNF60SVbrkyuAj+YfLxWpfmnoUwA
	turV1WintKW3nq2Ay1eRZreXhVm6nOpo4R/WSaSrE+LV+KxG0BatgMyjisJioXEnkjE5od
	y/Ah7Awq4bu8rrS0F6IKEaHfZCSWB09f4pBRRUhj9HerWZVxFGK3eslD5/+5nzu59tm/2N
	0USD9Jkuta3P5CZ+PMvAKcrfP8q2gT6rZ9qF8yIahLJUaeSZKGG/uHV8iqM7CkXNf/wso2
	oi2Ns2qhL1M4saUgWRP1O7GYS72dubePF4DM0FFrmyetiTTm+lr/9dtApWe+6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HthQAGS/lHQGcobZEvlVi78Lh6Enw1uHeqNlN4mMXhw=;
	b=EgmcqHaaM6wI/5fb4CMBVq71nSOALcVKhtpLnHdVQMopBKXiPlu/JCpJD0Lhb8IH7RouHA
	4XEvf2ucp9DtqKCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 10/19] printk: nbcon: Use thread callback if in task context for legacy
Date: Mon, 22 Jul 2024 19:25:30 +0206
Message-Id: <20240722171939.3349410-11-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing via console_lock, the write_atomic() callback is
used for nbcon consoles. However, if it is known that the
current context is a task context, the write_thread() callback
can be used instead.

Using write_thread() instead of write_atomic() helps to reduce
large disabled preemption regions when the device_lock does not
disable preemption.

This is mainly a preparatory change to allow avoiding
write_atomic() completely during normal operation if boot
consoles are registered.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  4 +--
 kernel/printk/nbcon.c    | 54 +++++++++++++++++++++++++++++-----------
 kernel/printk/printk.c   |  5 ++--
 3 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 12605e0aff11..bb02788acc7c 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -91,7 +91,7 @@ void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
-				   int cookie);
+				   int cookie, bool use_atomic);
 bool nbcon_kthread_create(struct console *con);
 void nbcon_kthread_stop(struct console *con);
 void nbcon_wake_kthreads(void);
@@ -174,7 +174,7 @@ static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
-						 int cookie) { return false; }
+						 int cookie, bool use_atomic) { return false; }
 static inline void nbcon_kthread_wake(struct console *con) { }
 
 static inline bool console_is_usable(struct console *con, short flags,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 69cecf97bf24..233ab8f90fef 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1294,9 +1294,10 @@ enum nbcon_prio nbcon_get_default_prio(void)
 }
 
 /*
- * nbcon_atomic_emit_one - Print one record for an nbcon console using the
- *				write_atomic() callback
+ * nbcon_emit_one - Print one record for an nbcon console using the
+ *			specified callback
  * @wctxt:	An initialized write context struct to use for this context
+ * @use_atomic:	True if the write_atomic() callback is to be used
  *
  * Return:	True, when a record has been printed and there are still
  *		pending records. The caller might want to continue flushing.
@@ -1309,7 +1310,7 @@ enum nbcon_prio nbcon_get_default_prio(void)
  * This is an internal helper to handle the locking of the console before
  * calling nbcon_emit_next_record().
  */
-static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
+static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 
@@ -1324,7 +1325,7 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	 * The higher priority printing context takes over responsibility
 	 * to print the pending records.
 	 */
-	if (!nbcon_emit_next_record(wctxt, true))
+	if (!nbcon_emit_next_record(wctxt, use_atomic))
 		return false;
 
 	nbcon_context_release(ctxt);
@@ -1341,6 +1342,13 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
  *		both the console_lock and the SRCU read lock. Otherwise it
  *		is set to false.
  * @cookie:	The cookie from the SRCU read lock.
+ * @use_atomic: Set true when called in an atomic or unknown context.
+ *		It affects which nbcon callback will be used: write_atomic()
+ *		or write_thread().
+ *
+ *		When false, the write_thread() callback is used and would be
+ *		called in a preemtible context unless disabled by the
+ *		device_lock. The legacy handover is not allowed in this mode.
  *
  * Context:	Any context except NMI.
  * Return:	True, when a record has been printed and there are still
@@ -1356,26 +1364,44 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
  * Essentially it is the nbcon version of console_emit_next_record().
  */
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
-				   int cookie)
+				   int cookie, bool use_atomic)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
 	unsigned long flags;
 	bool progress;
 
-	/* Use the same procedure as console_emit_next_record(). */
-	printk_safe_enter_irqsave(flags);
-	console_lock_spinning_enable();
-	stop_critical_timings();
-
 	ctxt->console	= con;
 	ctxt->prio	= nbcon_get_default_prio();
 
-	progress = nbcon_atomic_emit_one(&wctxt);
+	if (use_atomic) {
+		/*
+		 * In an atomic or unknown context, use the same procedure as
+		 * in console_emit_next_record(). It allows to handover.
+		 */
+		printk_safe_enter_irqsave(flags);
+		console_lock_spinning_enable();
+		stop_critical_timings();
+	} else {
+		/*
+		 * In task context, use the same procedure as in
+		 * nbcon_kthread_func(). It might allow scheduling depending
+		 * on the device_lock().
+		 */
+		con->device_lock(con, &flags);
+		cant_migrate();
+	}
 
-	start_critical_timings();
-	*handover = console_lock_spinning_disable_and_check(cookie);
-	printk_safe_exit_irqrestore(flags);
+	progress = nbcon_emit_one(&wctxt, use_atomic);
+
+	if (use_atomic) {
+		start_critical_timings();
+		*handover = console_lock_spinning_disable_and_check(cookie);
+		printk_safe_exit_irqrestore(flags);
+	} else {
+		con->device_unlock(con, flags);
+		*handover = false;
+	}
 
 	return progress;
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index cf0b35eaf047..71e946a8c5fa 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3024,12 +3024,13 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			u64 printk_seq;
 			bool progress;
 
-			if (!console_is_usable(con, flags, true))
+			if (!console_is_usable(con, flags, !do_cond_resched))
 				continue;
 			any_usable = true;
 
 			if (flags & CON_NBCON) {
-				progress = nbcon_legacy_emit_next_record(con, handover, cookie);
+				progress = nbcon_legacy_emit_next_record(con, handover, cookie,
+									 !do_cond_resched);
 				printk_seq = nbcon_seq_read(con);
 			} else {
 				progress = console_emit_next_record(con, handover, cookie);
-- 
2.39.2


