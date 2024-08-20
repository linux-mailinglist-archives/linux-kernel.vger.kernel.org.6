Return-Path: <linux-kernel+bounces-293345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06621957E33
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA431C23B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C7120125D;
	Tue, 20 Aug 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldjlaAn0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9YVN93lc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B61E6724
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135414; cv=none; b=RC02Z0uXL4gcLGZB7m6qL2p4JXTgqyfRsku1CCk5oe3psBTbrPpqaqx9UpbiODzFMwFq03oTeyXDdLKXJXlLToRR0SYU7hvGsOubO/RotWV/ma1XHZSnMfTVtVbSb1X+8P1cwrEblQnx6Gy6Mr+jInDKqTPXAEnShXpv+16O4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135414; c=relaxed/simple;
	bh=TCTIAZtCWd9j6XARPsmDgMhkvEHPQMGAgsgamVDdjPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0AnGqCO8QhHt7W5EUSjBKhL/Eo3aUHHdNGms+HNwjZvI1htDX877BFC94XBf3kN3ABTwBi4HZAibZ8O8baMIG+1hCOyfdqPcxhwuufjG1OHJAFnSW0++h6mFPRw9tOiOWV+urm4CJkc9oBaBYFkdENG8eth0zla8K3Auy9O6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ldjlaAn0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9YVN93lc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ft0m6FjgjOHbE/tA6nBH0OhKPQ/adMN/VS4R2LoSusE=;
	b=ldjlaAn0tTQq7mZu8lqRMIOmTTVzeh0vNOTzIy0/B+JS2GtyygVM08IDadICKy8u+pyvhF
	n0hKi49xd//X7MQa/qLwAKC+esc3zttdBLisCWMY3hGloePmH0HVNt8K2OB0QkrUunxzkP
	OdXG7Zg+70BPisz9aaKQkYWKhyLqaj4PDX/V9x+sRYYZ6A5Fp6f0pfMbmeSKeQNi4chdv+
	Vsg4xJepVYVP3+lXl8tJphd02iKeEV+F+LoqcEpc88oSYLjuILH4kdflMWZzR3hLtHTQx6
	mnfOpuO9Mfjhl87POpPmQCEoueUbVFvtRtTDmPIoCkHJAP3UFk17Kz8qbN8SpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ft0m6FjgjOHbE/tA6nBH0OhKPQ/adMN/VS4R2LoSusE=;
	b=9YVN93lcZ1Jt/2MxwVmkpP6gp9Zzp4CAaMz14iT4hdUMXou7I5BQPKnEZ9VI8oW4NW7glr
	A4cXdGxzJcRWl2DQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v8 20/35] printk: nbcon: Provide function to flush using write_atomic()
Date: Tue, 20 Aug 2024 08:35:46 +0206
Message-Id: <20240820063001.36405-21-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |   2 +
 kernel/printk/nbcon.c    | 151 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 72f229382cfa..0dc9b92b5dd0 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -84,6 +84,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_free(struct console *con);
 enum nbcon_prio nbcon_get_default_prio(void);
+void nbcon_atomic_flush_pending(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -138,6 +139,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_free(struct console *con) { }
 static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
+static inline void nbcon_atomic_flush_pending(void) { }
 
 static inline bool console_is_usable(struct console *con, short flags) { return false; }
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index c6a9aa9f62f6..3982d68979d6 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -886,7 +886,6 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
  * When true is returned, @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-__maybe_unused
 static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
@@ -992,6 +991,156 @@ enum nbcon_prio nbcon_get_default_prio(void)
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
+ * records added while flushing will not be flushed if there is another
+ * context available to handle the flushing. This is to avoid one CPU
+ * printing unbounded because other CPUs continue to add records.
+ */
+void nbcon_atomic_flush_pending(void)
+{
+	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb));
+}
+
 /**
  * nbcon_alloc - Allocate and init the nbcon console specific data
  * @con:	Console to initialize
-- 
2.39.2


