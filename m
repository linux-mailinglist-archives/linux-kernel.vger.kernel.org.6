Return-Path: <linux-kernel+bounces-314967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE64F96BBAB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552B2B297AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955641D9346;
	Wed,  4 Sep 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="omMNLTZ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vp3UfWbH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F91D86CE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451544; cv=none; b=jkJkUyILpnMpCRoLamO4k0Xkh1q0QiB+Q7b3q6nYs/pP2nCiGX85Grx3OwBZQdtJC+e5x4a1A+uB/WpsPyp48lqB9QDfAjMF0nZUXtNnhUNGGFGej5rW/kYtKu1IonCBt2oSRdwWh+e6/QSK5l+Dn7k00VWIfinSVJ72WayFjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451544; c=relaxed/simple;
	bh=dOcBRaMqOhKCFSoO+4uYLBwWL3lUDA6G+WVEd1ECURI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APISKGvAXWC2BEdKDgmmVMsgF925Ica2pL+eWyoSNNlmiGFiRwdGZ7DZfkyb3jDWWQHUa5rT0JzbIg4YAcweHClidi7zNc5I0ZVs4zehJkkYranOgo61ZleNn/mx0ZcDFphkRciDvOSGd0o1FszSWT5n20+OecOBFNvDLChizEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=omMNLTZ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vp3UfWbH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WuN9fWRqK5TsC6f8oELa0gTbKFC9yghBzA+BDMRVfU=;
	b=omMNLTZ8WkkcZL8p9Moo9IXR4RCN83+s7y9/0Eqim0bXDDDEU+Mr6S2CcIwvCTt1NC+9Vb
	tQyIvLNaD98BobVS9XwnBR2XHGb58c/ehVj+AMOJ2TYGxRjja3HjzY+Q1IZfBWpjJQmrpj
	ZUA+pl5aRNJPymqvyEkFDeGhLIKQWAhPNxp++TZ+cUnyzBHdaFZPNbkdSSpYE6V6bk804k
	zpwHgocHfdS7D8tozsa6UdM1A8PdZa/C1u4R+zNnUBZalNETpWLFw7fGvNvOFyh6DWUgpE
	Y6EclqRzaKM5mP3D6qIRCUmVdYcE2JzUUQZnGf7RyHEb5Pd7PKGpuHPPMGYgFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WuN9fWRqK5TsC6f8oELa0gTbKFC9yghBzA+BDMRVfU=;
	b=vp3UfWbHDAqlbdZ8QsrVKnsWb3y9JrmSwz2mY5fXMSt8r+hfrKwTRfDLamm/+umZ8hsDox
	BUF5NXxCZrpahbCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 08/17] printk: nbcon: Use thread callback if in task context for legacy
Date: Wed,  4 Sep 2024 14:11:27 +0206
Message-Id: <20240904120536.115780-9-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
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

As a side-effect, it also allows consolidating the printing
code for legacy printing and the kthread printer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  4 +-
 kernel/printk/nbcon.c    | 95 +++++++++++++++++++++++-----------------
 kernel/printk/printk.c   |  5 ++-
 3 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 14f7fc71e20d..a96d4114a1db 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -90,7 +90,7 @@ void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
-				   int cookie);
+				   int cookie, bool use_atomic);
 bool nbcon_kthread_create(struct console *con);
 void nbcon_kthread_stop(struct console *con);
 void nbcon_kthreads_wake(void);
@@ -174,7 +174,7 @@ static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
 static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
-						 int cookie) { return false; }
+						 int cookie, bool use_atomic) { return false; }
 static inline void nbcon_kthread_wake(struct console *con) { }
 
 static inline bool console_is_usable(struct console *con, short flags,
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 57a0e9b542fe..784e5de88abf 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1043,9 +1043,10 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
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
@@ -1058,12 +1059,25 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
  * This is an internal helper to handle the locking of the console before
  * calling nbcon_emit_next_record().
  */
-static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
+static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	unsigned long flags;
+	bool ret = false;
+
+	if (!use_atomic) {
+		con->device_lock(con, &flags);
+
+		/*
+		 * Ensure this stays on the CPU to make handover and
+		 * takeover possible.
+		 */
+		cant_migrate();
+	}
 
 	if (!nbcon_context_try_acquire(ctxt))
-		return false;
+		goto out;
 
 	/*
 	 * nbcon_emit_next_record() returns false when the console was
@@ -1073,12 +1087,16 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	 * The higher priority printing context takes over responsibility
 	 * to print the pending records.
 	 */
-	if (!nbcon_emit_next_record(wctxt, true))
-		return false;
+	if (!nbcon_emit_next_record(wctxt, use_atomic))
+		goto out;
 
 	nbcon_context_release(ctxt);
 
-	return ctxt->backlog;
+	ret = ctxt->backlog;
+out:
+	if (!use_atomic)
+		con->device_unlock(con, flags);
+	return ret;
 }
 
 /**
@@ -1163,30 +1181,8 @@ static int nbcon_kthread_func(void *__console)
 
 		con_flags = console_srcu_read_flags(con);
 
-		if (console_is_usable(con, con_flags, false)) {
-			unsigned long lock_flags;
-
-			con->device_lock(con, &lock_flags);
-
-			/*
-			 * Ensure this stays on the CPU to make handover and
-			 * takeover possible.
-			 */
-			cant_migrate();
-
-			if (nbcon_context_try_acquire(ctxt)) {
-				/*
-				 * If the emit fails, this context is no
-				 * longer the owner.
-				 */
-				if (nbcon_emit_next_record(&wctxt, false)) {
-					nbcon_context_release(ctxt);
-					backlog = ctxt->backlog;
-				}
-			}
-
-			con->device_unlock(con, lock_flags);
-		}
+		if (console_is_usable(con, con_flags, false))
+			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
 
@@ -1367,6 +1363,13 @@ enum nbcon_prio nbcon_get_default_prio(void)
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
@@ -1382,26 +1385,36 @@ enum nbcon_prio nbcon_get_default_prio(void)
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
+		/* Non-atomic does not perform legacy spinning handovers. */
+		*handover = false;
+	}
 
 	return progress;
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f27c76c3b5cf..55d75db00042 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3077,12 +3077,13 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
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


