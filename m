Return-Path: <linux-kernel+bounces-190094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA48CF961
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EA31F20FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377D313BC02;
	Mon, 27 May 2024 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yk0764/h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rc5aQReb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFF2030B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791908; cv=none; b=WeXlsg6B5qp8LTbCqX3wu1/JOIhYpsOUq7n1699ltuwsY33sayfekZMiQIVbfpiDC7Ct5nrLB21s2E2e0YUJ7stXUGOvTx9+hvP87RhRpKn06a1VeL5evJJBblQE/mH76XOoLMVi4vBLCoxhGJfmtvSJSnLt1hvse6MLPRchdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791908; c=relaxed/simple;
	bh=dpzXjOanPnBbd1Ae7HCtcVqYVTtvZJapQQySvGVpBNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G67Or5zf7OUWIMbk4jkbK11/cW27x5pLZuDaTxw/o/ZADjFGQDq7s07l9y116l7plSYL3Bg55loc5/Qwa9TB1mDSinauVL2KeJWptvyC/b/mXy+IsgTzHSluwyxkQJ+zUtQ/KgXKCpaj34c3PFLmHMMskQGVsRaN4kBXziN6zLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yk0764/h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rc5aQReb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tb9xTUaRDo4DonPbcR+009ZjcAxnSNSSkX832/2ms80=;
	b=Yk0764/h5jLVPEUrCu4bPmQEmfkv0fcmia5VD0FA2wYjtOTeHQtF2huC3Ry6Wtds4m1JC2
	CCRIBOZMHmRj2RHjgcsSWfeorECVMLpMEhoKQMUXsrqnq2FlPVycMonmuXtkdJXCsWGHux
	3T57CLg+2ASjDZBpIcv1MyZSyoOU47Ar4dsnednEz/RJ+flRHnnHZ38vaWe9RBbM8yLsEm
	sky3vZHfpd1BzXQaRXRmDOOikeZ1gifzYZtSyWAPUPlNa9yWALdJRftM18LOu5aFp/oFnt
	FG1Km4kKyjwAimytWU7Tyn5JBRto2zhSERQSKaZOKxjw9wdS73Ile28risLCEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tb9xTUaRDo4DonPbcR+009ZjcAxnSNSSkX832/2ms80=;
	b=rc5aQRebkmWA2y92KAVbTgq/zQpXVkSYc87HNOhycJ3XMBfMfscrgUmK7w35oet/gnpiUN
	ErcOyECPro/auuBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 19/30] printk: nbcon: Provide function to flush using write_atomic()
Date: Mon, 27 May 2024 08:43:38 +0206
Message-Id: <20240527063749.391035-20-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Provide nbcon_atomic_flush_pending() to perform flushing of all
registered nbcon consoles using their write_atomic() callback.

Unlike console_flush_all(), nbcon_atomic_flush_pending() will
only flush up through the newest record at the time of the
call. This prevents a CPU from printing unbounded when other
CPUs are adding records. If new records are added while
flushing, it is expected that the dedicated printer threads
will print those records. If the printer thread is not
available (which is always the case at this point in the
rework), nbcon_atomic_flush_pending() _will_ flush all records
in the ringbuffer.

Unlike console_flush_all(), nbcon_atomic_flush_pending() will
fully flush one console before flushing the next. This helps to
guarantee that a block of pending records (such as a stack
trace in an emergency situation) can be printed atomically at
once before releasing console ownership.

nbcon_atomic_flush_pending() is safe in any context because it
uses write_atomic() and acquires with unsafe_takeover disabled.

Use it in console_flush_on_panic() before flushing legacy
consoles. The legacy write() callbacks are not fully safe when
oops_in_progress is set.

Also use it in nbcon_device_release() to flush records added
while the driver had the console locked to perform non-printing
operations.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 kernel/printk/internal.h |   2 +
 kernel/printk/nbcon.c    | 169 ++++++++++++++++++++++++++++++++++++++-
 kernel/printk/printk.c   |   2 +
 3 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 5826cd4eed58..5a93825871de 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -85,6 +85,7 @@ bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con, u64 init_seq);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
+void nbcon_atomic_flush_pending(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -140,6 +141,7 @@ static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con, u64 init_seq) { }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
+static inline void nbcon_atomic_flush_pending(void) { }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 85bebea1a326..fc48fcb4da9b 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -850,7 +850,6 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
  * When true is returned, @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-__maybe_unused
 static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
@@ -953,6 +952,155 @@ enum nbcon_prio nbcon_get_default_prio(void)
 	return NBCON_PRIO_NORMAL;
 }
 
+/*
+ * __nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
+ *					write_atomic() callback
+ * @con:			The nbcon console to flush
+ * @stop_seq:			Flush up until this record
+ *
+ * Return:	0 if @con was flushed up to @stop_seq Otherwise, error code on
+ *		failure.
+ *
+ * Errors:
+ *
+ *	-EPERM:		Unable to acquire console ownership.
+ *
+ *	-EAGAIN:	Another context took over ownership while printing.
+ *
+ *	-ENOENT:	A record before @stop_seq is not available.
+ *
+ * If flushing up to @stop_seq was not successful, it only makes sense for the
+ * caller to try again when -EAGAIN was returned. When -EPERM is returned,
+ * this context is not allowed to acquire the console. When -ENOENT is
+ * returned, it cannot be expected that the unfinalized record will become
+ * available.
+ */
+static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+{
+	struct nbcon_write_context wctxt = { };
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+	int err = 0;
+
+	ctxt->console			= con;
+	ctxt->spinwait_max_us		= 2000;
+	ctxt->prio			= nbcon_get_default_prio();
+
+	if (!nbcon_context_try_acquire(ctxt))
+		return -EPERM;
+
+	while (nbcon_seq_read(con) < stop_seq) {
+		/*
+		 * nbcon_emit_next_record() returns false when the console was
+		 * handed over or taken over. In both cases the context is no
+		 * longer valid.
+		 */
+		if (!nbcon_emit_next_record(&wctxt))
+			return -EAGAIN;
+
+		if (!ctxt->backlog) {
+			/* Are there reserved but not yet finalized records? */
+			if (nbcon_seq_read(con) < stop_seq)
+				err = -ENOENT;
+			break;
+		}
+	}
+
+	nbcon_context_release(ctxt);
+	return err;
+}
+
+/**
+ * nbcon_atomic_flush_pending_con - Flush specified nbcon console using its
+ *					write_atomic() callback
+ * @con:			The nbcon console to flush
+ * @stop_seq:			Flush up until this record
+ *
+ * This will stop flushing before @stop_seq if another context has ownership.
+ * That context is then responsible for the flushing. Likewise, if new records
+ * are added while this context was flushing and there is no other context
+ * to handle the printing, this context must also flush those records.
+ */
+static void nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq)
+{
+	unsigned long flags;
+	int err;
+
+again:
+	/*
+	 * Atomic flushing does not use console driver synchronization (i.e.
+	 * it does not hold the port lock for uart consoles). Therefore IRQs
+	 * must be disabled to avoid being interrupted and then calling into
+	 * a driver that will deadlock trying to acquire console ownership.
+	 */
+	local_irq_save(flags);
+
+	err = __nbcon_atomic_flush_pending_con(con, stop_seq);
+
+	local_irq_restore(flags);
+
+	/*
+	 * If there was a new owner (-EPERM, -EAGAIN), that context is
+	 * responsible for completing.
+	 *
+	 * Do not wait for records not yet finalized (-ENOENT) to avoid a
+	 * possible deadlock. They will either get flushed by the writer or
+	 * eventually skipped on panic CPU.
+	 */
+	if (err)
+		return;
+
+	/*
+	 * If flushing was successful but more records are available, this
+	 * context must flush those remaining records because there is no
+	 * other context that will do it.
+	 */
+	if (prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+		stop_seq = prb_next_reserve_seq(prb);
+		goto again;
+	}
+}
+
+/**
+ * __nbcon_atomic_flush_pending - Flush all nbcon consoles using their
+ *					write_atomic() callback
+ * @stop_seq:			Flush up until this record
+ */
+static void __nbcon_atomic_flush_pending(u64 stop_seq)
+{
+	struct console *con;
+	int cookie;
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		short flags = console_srcu_read_flags(con);
+
+		if (!(flags & CON_NBCON))
+			continue;
+
+		if (!console_is_usable(con, flags))
+			continue;
+
+		if (nbcon_seq_read(con) >= stop_seq)
+			continue;
+
+		nbcon_atomic_flush_pending_con(con, stop_seq);
+	}
+	console_srcu_read_unlock(cookie);
+}
+
+/**
+ * nbcon_atomic_flush_pending - Flush all nbcon consoles using their
+ *				write_atomic() callback
+ *
+ * Flush the backlog up through the currently newest record. Any new
+ * records added while flushing will not be flushed. This is to avoid
+ * one CPU printing unbounded because other CPUs continue to add records.
+ */
+void nbcon_atomic_flush_pending(void)
+{
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+}
+
 /**
  * nbcon_alloc - Allocate buffers needed by the nbcon console
  * @con:	Console to allocate buffers for
@@ -1065,8 +1213,23 @@ EXPORT_SYMBOL_GPL(nbcon_device_try_acquire);
 void nbcon_device_release(struct console *con)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(con, nbcon_device_ctxt);
+	int cookie;
 
-	if (nbcon_context_exit_unsafe(ctxt))
-		nbcon_context_release(ctxt);
+	if (!nbcon_context_exit_unsafe(ctxt))
+		return;
+
+	nbcon_context_release(ctxt);
+
+	/*
+	 * This context must flush any new records added while the console
+	 * was locked. The console_srcu_read_lock must be taken to ensure
+	 * the console is usable throughout flushing.
+	 */
+	cookie = console_srcu_read_lock();
+	if (console_is_usable(con, console_srcu_read_flags(con)) &&
+	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
+		__nbcon_atomic_flush_pending_con(con, prb_next_reserve_seq(prb));
+	}
+	console_srcu_read_unlock(cookie);
 }
 EXPORT_SYMBOL_GPL(nbcon_device_release);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2dd7add07b5d..56d2377fc97f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3172,6 +3172,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		console_srcu_read_unlock(cookie);
 	}
 
+	nbcon_atomic_flush_pending();
+
 	console_flush_all(false, &next_seq, &handover);
 }
 
-- 
2.39.2


