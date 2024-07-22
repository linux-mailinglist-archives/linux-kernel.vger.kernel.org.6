Return-Path: <linux-kernel+bounces-259250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDBA939325
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A4D1F225CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B147A17279E;
	Mon, 22 Jul 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5VafPi0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GnZt7jKP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07E16F839
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668794; cv=none; b=TVE0ZwLsu2J848CoNint0NwF081WYcRsN8/Sb2b2I5C/33JyRw50TM0zstupLKGQSQhqYC+4gathS5kucI0FW12fmK9ooHGPUwkNfuC+JdeaMVQqxeSnrcRz5G5KRcVdK6ACExgQkdaRVUnzyECOvrQyMMlLRoK/7r5k1ZniFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668794; c=relaxed/simple;
	bh=cWen4vYnz724hLmKR7UFhL+NUHjyCz1iTl7++hxKFz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Py0ds6bHV7KQoU9/NWuH6xtZBvwRy7NADgFCi2TW60wmME6iYAIoUZ9sRv6KS+g8ji4SaASL+uawDuTki3JVKIOehFRHOk5w2Czx3T1wkf0cCqWX2dHWmzSnf6qipLjgmk9GciOIllOO3D4MkQszL8TS7PqimB5yRIpy9Q+9OD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5VafPi0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GnZt7jKP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17Bi15EZIim7Q8Yy+Y73cfLP9CjFh04+t2xjfxlTuCY=;
	b=X5VafPi0vSky+dlU56f3f+06nEMxPBMms2pvF8Zx21Vg1mSEhXoQaJPo2xNah/9GDRGzpJ
	IrSNTHyx+epkYQPxr5lVlAj8u/hyjAgKstMSpVFHvIe11i3T85B+wLXIxN+D4W5ALBaEvf
	VI5SAwrwKXr4UneM/X4kj+TPnOeAo1sullRctVRIjaHqY6YEn7n+bWJFQ8Z7ULYCQdYJMz
	5aQukSY3ex137YVUj4engJ18sMEjG803BsOQJlgIHXILoiIrLvVIe4rJ7R9IyYs77JkBSz
	ymIu1ibV3t3zfeRoK8SB8hOca/9PD4Wm/GJnLNmEpoNlvcpJ00gW7OyE2zEpvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=17Bi15EZIim7Q8Yy+Y73cfLP9CjFh04+t2xjfxlTuCY=;
	b=GnZt7jKPcsXUSm4Ytyk7Vd3StG6TinX7MkA2HcwJ8mMoN1Zl1XyKb//BtlFGD7GJMmbNbQ
	siOBKDoiRzOcsACw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 09/19] printk: nbcon: Introduce printer kthreads
Date: Mon, 22 Jul 2024 19:25:29 +0206
Message-Id: <20240722171939.3349410-10-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Provide the main implementation for running a printer kthread
per nbcon console that is takeover/handover aware. This
includes:

- new mandatory write_thread() callback
- kthread creation
- kthread main printing loop
- kthread wakeup mechanism
- kthread shutdown

kthread creation is a bit tricky because consoles may register
before kthreads can be created. In such cases, registration
will succeed, even though no kthread exists. Once kthreads can
be created, an early_initcall will set @printk_kthreads_ready.
If there are no registered boot consoles, the early_initcall
creates the kthreads for all registered nbcon consoles. If
kthread creation fails, the related console is unregistered.

If there are registered boot consoles when
@printk_kthreads_ready is set, no kthreads are created until
the final boot console unregisters.

Once kthread creation finally occurs, @printk_kthreads_running
is set so that the system knows kthreads are available for all
registered nbcon consoles.

If @printk_kthreads_running is already set when the console
is registering, the kthread is created during registration. If
kthread creation fails, the registration will fail.

Until @printk_kthreads_running is set, console printing occurs
directly via the console_lock.

kthread shutdown on system shutdown/reboot is necessary to
ensure the printer kthreads finish their printing so that the
system can cleanly transition back to direct printing via the
console_lock in order to reliably push out the final
shutdown/reboot messages. @printk_kthreads_running is cleared
before shutting down the individual kthreads.

The kthread uses a new mandatory write_thread() callback that
is called with both device_lock() and the console context
acquired.

The console ownership handling is necessary for synchronization
against write_atomic() which is synchronized only via the
console context ownership.

The device_lock() serializes acquiring the console context with
NBCON_PRIO_NORMAL. It is needed in case the device_lock() does
not disable preemption. It prevents the following race:

CPU0				CPU1

 [ task A ]

 nbcon_context_try_acquire()
   # success with NORMAL prio
   # .unsafe == false;  // safe for takeover

 [ schedule: task A -> B ]

				WARN_ON()
				  nbcon_atomic_flush_pending()
				    nbcon_context_try_acquire()
				      # success with EMERGENCY prio

				      # flushing
				      nbcon_context_release()

				      # HERE: con->nbcon_state is free
				      #       to take by anyone !!!

 nbcon_context_try_acquire()
   # success with NORMAL prio [ task B ]

 [ schedule: task B -> A ]

 nbcon_enter_unsafe()
   nbcon_context_can_proceed()

BUG: nbcon_context_can_proceed() returns "true" because
     the console is owned by a context on CPU0 with
     NBCON_PRIO_NORMAL.

     But it should return "false". The console is owned
     by a context from task B and we do the check
     in a context from task A.

Note that with these changes, the printer kthreads do not yet
take over full responsibility for nbcon printing during normal
operation. These changes only focus on the lifecycle of the
kthreads.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h  |  40 +++++++
 kernel/printk/internal.h |  27 +++++
 kernel/printk/nbcon.c    | 244 +++++++++++++++++++++++++++++++++++++--
 kernel/printk/printk.c   | 108 +++++++++++++++++
 4 files changed, 409 insertions(+), 10 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 5e9285e886f5..b8fb9fb24cbf 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,7 +16,9 @@
 
 #include <linux/atomic.h>
 #include <linux/bits.h>
+#include <linux/irq_work.h>
 #include <linux/rculist.h>
+#include <linux/rcuwait.h>
 #include <linux/types.h>
 #include <linux/vesa.h>
 
@@ -324,6 +326,9 @@ struct nbcon_write_context {
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @nbcon_device_ctxt:	Context available for non-printing operations
  * @pbufs:		Pointer to nbcon private buffer
+ * @kthread:		Printer kthread for this console
+ * @rcuwait:		RCU-safe wait object for @kthread waking
+ * @irq_work:		Defer @kthread waking to IRQ work context
  */
 struct console {
 	char			name[16];
@@ -377,6 +382,37 @@ struct console {
 	 */
 	void (*write_atomic)(struct console *con, struct nbcon_write_context *wctxt);
 
+	/**
+	 * @write_thread:
+	 *
+	 * NBCON callback to write out text in task context.
+	 *
+	 * This callback must be called only in task context with both
+	 * device_lock() and the nbcon console acquired with
+	 * NBCON_PRIO_NORMAL.
+	 *
+	 * The same rules for console ownership verification and unsafe
+	 * sections handling applies as with write_atomic().
+	 *
+	 * The console ownership handling is necessary for synchronization
+	 * against write_atomic() which is synchronized only via the context.
+	 *
+	 * The device_lock() provides the primary serialization for operations
+	 * on the device. It might be as relaxed (mutex)[*] or as tight
+	 * (disabled preemption and interrupts) as needed. It allows
+	 * the kthread to operate in the least restrictive mode[**].
+	 *
+	 * [*] Standalone nbcon_context_try_acquire() is not safe with
+	 *     the preemption enabled, see nbcon_owner_matches(). But it
+	 *     can be safe when always called in the preemptive context
+	 *     under the device_lock().
+	 *
+	 * [**] The device_lock() makes sure that nbcon_context_try_acquire()
+	 *      would never need to spin which is important especially with
+	 *      PREEMPT_RT.
+	 */
+	void (*write_thread)(struct console *con, struct nbcon_write_context *wctxt);
+
 	/**
 	 * @device_lock:
 	 *
@@ -423,7 +459,11 @@ struct console {
 	atomic_t		__private nbcon_state;
 	atomic_long_t		__private nbcon_seq;
 	struct nbcon_context	__private nbcon_device_ctxt;
+
 	struct printk_buffers	*pbufs;
+	struct task_struct	*kthread;
+	struct rcuwait		rcuwait;
+	struct irq_work		irq_work;
 };
 
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 8211623aee9b..12605e0aff11 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -48,6 +48,7 @@ struct printk_ringbuffer;
 struct dev_printk_info;
 
 extern struct printk_ringbuffer *prb;
+extern bool printk_kthreads_running;
 
 __printf(4, 0)
 int vprintk_store(int facility, int level,
@@ -91,6 +92,9 @@ enum nbcon_prio nbcon_get_default_prio(void);
 void nbcon_atomic_flush_pending(void);
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 				   int cookie);
+bool nbcon_kthread_create(struct console *con);
+void nbcon_kthread_stop(struct console *con);
+void nbcon_wake_kthreads(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -126,12 +130,34 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 	return true;
 }
 
+/**
+ * nbcon_kthread_wake - Wake up a console printing thread
+ * @con:	Console to operate on
+ */
+static inline void nbcon_kthread_wake(struct console *con)
+{
+	/*
+	 * Guarantee any new records can be seen by tasks preparing to wait
+	 * before this context checks if the rcuwait is empty.
+	 *
+	 * The full memory barrier in rcuwait_wake_up() pairs with the full
+	 * memory barrier within set_current_state() of
+	 * ___rcuwait_wait_event(), which is called after prepare_to_rcuwait()
+	 * adds the waiter but before it has checked the wait condition.
+	 *
+	 * This pairs with nbcon_kthread_func:A.
+	 */
+	rcuwait_wake_up(&con->rcuwait); /* LMM(nbcon_kthread_wake:A) */
+}
+
 #else
 
 #define PRINTK_PREFIX_MAX	0
 #define PRINTK_MESSAGE_MAX	0
 #define PRINTKRB_RECORD_MAX	0
 
+#define printk_kthreads_running (false)
+
 /*
  * In !PRINTK builds we still export console_sem
  * semaphore and some of console functions (console_unlock()/etc.), so
@@ -149,6 +175,7 @@ static inline enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_N
 static inline void nbcon_atomic_flush_pending(void) { }
 static inline bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 						 int cookie) { return false; }
+static inline void nbcon_kthread_wake(struct console *con) { }
 
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index ae9cd6d0b740..69cecf97bf24 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
+#include <linux/kthread.h>
 #include <linux/minmax.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
@@ -985,17 +986,10 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	/* Initialize the write context for driver callbacks. */
 	nbcon_write_context_set_buf(wctxt, &pmsg.pbufs->outbuf[0], pmsg.outbuf_len);
 
-	if (use_atomic) {
+	if (use_atomic)
 		con->write_atomic(con, wctxt);
-	} else {
-		/*
-		 * This function should never be called for legacy consoles.
-		 * Handle it as if ownership was lost and try to continue.
-		 */
-		WARN_ON_ONCE(1);
-		nbcon_context_release(ctxt);
-		return false;
-	}
+	else
+		con->write_thread(con, wctxt);
 
 	if (!wctxt->outbuf) {
 		/*
@@ -1031,6 +1025,219 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_a
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/**
+ * nbcon_kthread_should_wakeup - Check whether a printer thread should wakeup
+ * @con:	Console to operate on
+ * @ctxt:	The nbcon context from nbcon_context_try_acquire()
+ *
+ * Return:	True if the thread should shutdown or if the console is
+ *		allowed to print and a record is available. False otherwise.
+ *
+ * After the thread wakes up, it must first check if it should shutdown before
+ * attempting any printing.
+ */
+static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_context *ctxt)
+{
+	bool ret = false;
+	short flags;
+	int cookie;
+
+	if (kthread_should_stop())
+		return true;
+
+	cookie = console_srcu_read_lock();
+
+	flags = console_srcu_read_flags(con);
+	if (console_is_usable(con, flags, false)) {
+		/* Bring the sequence in @ctxt up to date */
+		ctxt->seq = nbcon_seq_read(con);
+
+		ret = prb_read_valid(prb, ctxt->seq, NULL);
+	}
+
+	console_srcu_read_unlock(cookie);
+	return ret;
+}
+
+/**
+ * nbcon_kthread_func - The printer thread function
+ * @__console:	Console to operate on
+ *
+ * Return:	0
+ */
+static int nbcon_kthread_func(void *__console)
+{
+	struct console *con = __console;
+	struct nbcon_write_context wctxt = {
+		.ctxt.console	= con,
+		.ctxt.prio	= NBCON_PRIO_NORMAL,
+	};
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
+	short con_flags;
+	bool backlog;
+	int cookie;
+
+wait_for_event:
+	/*
+	 * Guarantee this task is visible on the rcuwait before
+	 * checking the wake condition.
+	 *
+	 * The full memory barrier within set_current_state() of
+	 * ___rcuwait_wait_event() pairs with the full memory
+	 * barrier within rcuwait_has_sleeper().
+	 *
+	 * This pairs with rcuwait_has_sleeper:A and nbcon_kthread_wake:A.
+	 */
+	rcuwait_wait_event(&con->rcuwait,
+			   nbcon_kthread_should_wakeup(con, ctxt),
+			   TASK_INTERRUPTIBLE); /* LMM(nbcon_kthread_func:A) */
+
+	do {
+		if (kthread_should_stop())
+			return 0;
+
+		backlog = false;
+
+		/*
+		 * Keep the srcu read lock around the entire operation so that
+		 * synchronize_srcu() can guarantee that the kthread stopped
+		 * or suspended printing.
+		 */
+		cookie = console_srcu_read_lock();
+
+		con_flags = console_srcu_read_flags(con);
+
+		if (console_is_usable(con, con_flags, false)) {
+			unsigned long lock_flags;
+
+			con->device_lock(con, &lock_flags);
+
+			/*
+			 * Ensure this stays on the CPU to make handover and
+			 * takeover possible.
+			 */
+			cant_migrate();
+
+			if (nbcon_context_try_acquire(ctxt)) {
+				/*
+				 * If the emit fails, this context is no
+				 * longer the owner.
+				 */
+				if (nbcon_emit_next_record(&wctxt, false)) {
+					nbcon_context_release(ctxt);
+					backlog = ctxt->backlog;
+				}
+			}
+
+			con->device_unlock(con, lock_flags);
+		}
+
+		console_srcu_read_unlock(cookie);
+
+		cond_resched();
+
+	} while (backlog);
+
+	goto wait_for_event;
+}
+
+/**
+ * nbcon_irq_work - irq work to wake console printer thread
+ * @irq_work:	The irq work to operate on
+ */
+static void nbcon_irq_work(struct irq_work *irq_work)
+{
+	struct console *con = container_of(irq_work, struct console, irq_work);
+
+	nbcon_kthread_wake(con);
+}
+
+static inline bool rcuwait_has_sleeper(struct rcuwait *w)
+{
+	/*
+	 * Guarantee any new records can be seen by tasks preparing to wait
+	 * before this context checks if the rcuwait is empty.
+	 *
+	 * This full memory barrier pairs with the full memory barrier within
+	 * set_current_state() of ___rcuwait_wait_event(), which is called
+	 * after prepare_to_rcuwait() adds the waiter but before it has
+	 * checked the wait condition.
+	 *
+	 * This pairs with nbcon_kthread_func:A.
+	 */
+	smp_mb(); /* LMM(rcuwait_has_sleeper:A) */
+	return rcuwait_active(w);
+}
+
+/**
+ * nbcon_wake_kthreads - Wake up printing threads using irq_work
+ */
+void nbcon_wake_kthreads(void)
+{
+	struct console *con;
+	int cookie;
+
+	if (!printk_kthreads_running)
+		return;
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		/*
+		 * Only schedule irq_work if the printing thread is
+		 * actively waiting. If not waiting, the thread will
+		 * notice by itself that it has work to do.
+		 */
+		if (rcuwait_has_sleeper(&con->rcuwait))
+			irq_work_queue(&con->irq_work);
+	}
+	console_srcu_read_unlock(cookie);
+}
+
+/*
+ * nbcon_kthread_stop - Stop a console printer thread
+ * @con:	Console to operate on
+ */
+void nbcon_kthread_stop(struct console *con)
+{
+	lockdep_assert_console_list_lock_held();
+
+	if (!con->kthread)
+		return;
+
+	kthread_stop(con->kthread);
+	con->kthread = NULL;
+}
+
+/**
+ * nbcon_kthread_create - Create a console printer thread
+ * @con:	Console to operate on
+ *
+ * Return:	True if the kthread was started or already exists.
+ *		Otherwise false and @con must not be registered.
+ *
+ * If @con was already registered, it must be unregistered before
+ * the global state variable @printk_kthreads_running can be set.
+ */
+bool nbcon_kthread_create(struct console *con)
+{
+	struct task_struct *kt;
+
+	lockdep_assert_console_list_lock_held();
+
+	if (con->kthread)
+		return true;
+
+	kt = kthread_run(nbcon_kthread_func, con, "pr/%s%d", con->name, con->index);
+	if (WARN_ON(IS_ERR(kt))) {
+		con_printk(KERN_ERR, con, "failed to start printing thread\n");
+		return false;
+	}
+
+	con->kthread = kt;
+
+	return true;
+}
+
 /* Track the nbcon emergency nesting per CPU. */
 static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
 static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
@@ -1466,6 +1673,13 @@ bool nbcon_alloc(struct console *con)
 {
 	struct nbcon_state state = { };
 
+	if (!con->write_thread) {
+		con_printk(KERN_ERR, con, "no write_thread() callback provided\n");
+		return false;
+	}
+
+	rcuwait_init(&con->rcuwait);
+	init_irq_work(&con->irq_work, nbcon_irq_work);
 	nbcon_state_set(con, &state);
 
 	if (con->flags & CON_BOOT) {
@@ -1481,6 +1695,13 @@ bool nbcon_alloc(struct console *con)
 			con_printk(KERN_ERR, con, "failed to allocate printing buffer\n");
 			return false;
 		}
+
+		if (printk_kthreads_running) {
+			if (!nbcon_kthread_create(con)) {
+				kfree(con->pbufs);
+				return false;
+			}
+		}
 	}
 
 	return true;
@@ -1494,6 +1715,9 @@ void nbcon_free(struct console *con)
 {
 	struct nbcon_state state = { };
 
+	if (printk_kthreads_running)
+		nbcon_kthread_stop(con);
+
 	nbcon_state_set(con, &state);
 
 	/* Boot consoles share global printk buffers. */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e5e575384b3c..cf0b35eaf047 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -34,6 +34,7 @@
 #include <linux/security.h>
 #include <linux/memblock.h>
 #include <linux/syscalls.h>
+#include <linux/syscore_ops.h>
 #include <linux/vmcore_info.h>
 #include <linux/ratelimit.h>
 #include <linux/kmsg_dump.h>
@@ -493,6 +494,9 @@ static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
+/* True when _all_ printer threads are available for printing. */
+bool printk_kthreads_running;
+
 struct latched_seq {
 	seqcount_latch_t	latch;
 	u64			val[2];
@@ -2974,6 +2978,8 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 	return false;
 }
 
+static inline void printk_kthreads_check_locked(void) { }
+
 #endif /* CONFIG_PRINTK */
 
 /*
@@ -3334,6 +3340,102 @@ void console_start(struct console *console)
 }
 EXPORT_SYMBOL(console_start);
 
+#ifdef CONFIG_PRINTK
+static int unregister_console_locked(struct console *console);
+
+/* True when system boot is far enough to create printer threads. */
+static bool printk_kthreads_ready __ro_after_init;
+
+/**
+ * printk_kthreads_shutdown - shutdown all threaded printers
+ *
+ * On system shutdown all threaded printers are stopped. This allows printk
+ * to transition back to atomic printing, thus providing a robust mechanism
+ * for the final shutdown/reboot messages to be output.
+ */
+static void printk_kthreads_shutdown(void)
+{
+	struct console *con;
+
+	console_list_lock();
+	if (printk_kthreads_running) {
+		printk_kthreads_running = false;
+
+		for_each_console(con) {
+			if (con->flags & CON_NBCON)
+				nbcon_kthread_stop(con);
+		}
+
+		/*
+		 * The threads may have been stopped while printing a
+		 * backlog. Flush any records left over.
+		 */
+		nbcon_atomic_flush_pending();
+	}
+	console_list_unlock();
+}
+
+static struct syscore_ops printk_syscore_ops = {
+	.shutdown = printk_kthreads_shutdown,
+};
+
+/*
+ * If appropriate, start nbcon kthreads and set @printk_kthreads_running.
+ * If any kthreads fail to start, those consoles are unregistered.
+ *
+ * Must be called under console_list_lock().
+ */
+static void printk_kthreads_check_locked(void)
+{
+	struct hlist_node *tmp;
+	struct console *con;
+
+	lockdep_assert_console_list_lock_held();
+
+	if (!printk_kthreads_ready)
+		return;
+
+	/*
+	 * Printer threads cannot be started as long as any boot console is
+	 * registered because there is no way to synchronize the hardware
+	 * registers between boot console code and regular console code.
+	 * It can only be known that there will be no new boot consoles when
+	 * an nbcon console is registered.
+	 */
+	if (have_boot_console || !have_nbcon_console) {
+		/* Clear flag in case all nbcon consoles unregistered. */
+		printk_kthreads_running = false;
+		return;
+	}
+
+	if (printk_kthreads_running)
+		return;
+
+	hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+		if (!(con->flags & CON_NBCON))
+			continue;
+
+		if (!nbcon_kthread_create(con))
+			unregister_console_locked(con);
+	}
+
+	printk_kthreads_running = true;
+}
+
+static int __init printk_set_kthreads_ready(void)
+{
+	register_syscore_ops(&printk_syscore_ops);
+
+	console_list_lock();
+	printk_kthreads_ready = true;
+	printk_kthreads_check_locked();
+	console_list_unlock();
+
+	return 0;
+}
+early_initcall(printk_set_kthreads_ready);
+#endif /* CONFIG_PRINTK */
+
 static int __read_mostly keep_bootcon;
 
 static int __init keep_bootcon_setup(char *str)
@@ -3689,6 +3791,9 @@ void register_console(struct console *newcon)
 				unregister_console_locked(con);
 		}
 	}
+
+	/* Changed console list, may require printer threads to start/stop. */
+	printk_kthreads_check_locked();
 unlock:
 	console_list_unlock();
 }
@@ -3785,6 +3890,9 @@ static int unregister_console_locked(struct console *console)
 	if (!found_nbcon_con)
 		have_nbcon_console = found_nbcon_con;
 
+	/* Changed console list, may require printer threads to start/stop. */
+	printk_kthreads_check_locked();
+
 	return res;
 }
 
-- 
2.39.2


