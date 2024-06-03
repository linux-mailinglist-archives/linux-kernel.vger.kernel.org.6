Return-Path: <linux-kernel+bounces-199825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB968FA670
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCD51C235AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04713DDC6;
	Mon,  3 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8Ji3U76";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1jC6egg5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F313CF96
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457101; cv=none; b=qD9UDgj3NOQDj2LDxixxdd4a8LvGr/mvYSHkVfWJD3Z8D3EemUShygd63IwT3Z/F+kVvmRmCX4RwcvJ7rvyJOaPOWgDpUTQfVZo7mTFBByGkRHaVmmDAXGniNSWHz9nV4kEQtcZiUPnJUuUrYsTpx2/R/7kCSJ8C2u+GT1FEt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457101; c=relaxed/simple;
	bh=h2xMza0pIQO539SBEF2bOG10SNxaO64Y36tbIZ1NJiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OTXbpkaTxNx4y548u+vHVp9nLgV0SQ9jeekcq3Z4xOCneG6sOALJ6bm1gg7z0jff0+qQz3amKW4A9v3VOrAustkZH91hR8kJ6HpCsP+4wfnFKv6cBw46u4UPK58ovLbqZTvfoKJT/c8B/nvoK8w8ZXM3TPhA7U7wxNwf5YZ6VL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y8Ji3U76; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1jC6egg5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pr40aimvVoxs/7225bC4/W64BDXKDTy5/ujSTndIDGE=;
	b=y8Ji3U76CjKRLf3D9VTzoCW2CEw+//r5l49+k97RHLBIIMjJamgP6u1SnM/tVxw66knEyQ
	m5Me5QlmXTbCT0JALBFys3p37g6oP/Z4wJ0V3fkJSPWCspKk9kv4+ef5dyP74r9AUFsWNK
	Z1V8c8f0iGTqoYP5KVYYPF/dQ6HXxyMgN0lIOplS3e64Y+d6NgXMes4sqS4HBRbmlDMy0Y
	gykfkQ0E9okxEzhxKeLV79MG2x0pU+fPXXmFptezobWhNKMSu+yFDyduAUrBzc1yL0yd4c
	CazzkcJyOH2g6sScPu7LUkKfkrJ2RB7vmbEgrVdjQOixVP1mVSc66lxixT8Kog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pr40aimvVoxs/7225bC4/W64BDXKDTy5/ujSTndIDGE=;
	b=1jC6egg58HtK5mqFOWq9YgaeY2QhFJsGl9NuJnAEnzv+AGEOGCzE/gpNhG4qWw8HMiU2jY
	9gi2mfcZAs65aCBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH printk v2 07/18] printk: nbcon: Add printer thread wakeups
Date: Tue,  4 Jun 2024 01:30:42 +0206
Message-Id: <20240603232453.33992-8-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Add a function to wakeup the printer threads. The printer threads
are woken when:

  - a record is added to the printk ringbuffer
  - consoles are resumed
  - triggered via printk_trigger_flush()
  - consoles should be replayed via sysrq

The actual waking is performed via irq_work so that the function
can be called from any context.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h  |  3 +++
 kernel/printk/internal.h |  1 +
 kernel/printk/nbcon.c    | 56 ++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   |  8 ++++++
 4 files changed, 68 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 4de42ec1527c..adcc1a74aeee 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,6 +16,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bits.h>
+#include <linux/irq_work.h>
 #include <linux/rculist.h>
 #include <linux/rcuwait.h>
 #include <linux/types.h>
@@ -327,6 +328,7 @@ struct nbcon_write_context {
  * @pbufs:		Pointer to nbcon private buffer
  * @kthread:		Printer kthread for this console
  * @rcuwait:		RCU-safe wait object for @kthread waking
+ * @irq_work:		Defer @kthread waking to IRQ work context
  */
 struct console {
 	char			name[16];
@@ -446,6 +448,7 @@ struct console {
 	struct printk_buffers	*pbufs;
 	struct task_struct	*kthread;
 	struct rcuwait		rcuwait;
+	struct irq_work		irq_work;
 };
 
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 243d3d3bc889..b2b5c10a4321 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -93,6 +93,7 @@ void nbcon_atomic_flush_pending(void);
 bool nbcon_legacy_emit_next_record(struct console *con, bool *handover,
 				   int cookie);
 void nbcon_kthread_create(struct console *con);
+void nbcon_wake_threads(void);
 
 /*
  * Check if the given console is currently capable and allowed to print
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 4200953d368e..4ab47cc014a3 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1058,6 +1058,61 @@ static int nbcon_kthread_func(void *__console)
 	goto wait_for_event;
 }
 
+/**
+ * nbcon_irq_work - irq work to wake printk thread
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
+	bool has_sleeper;
+
+	rcu_read_lock();
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
+	has_sleeper = !!rcu_dereference(w->task);
+	rcu_read_unlock();
+
+	return has_sleeper;
+}
+
+/**
+ * nbcon_wake_threads - Wake up printing threads using irq_work
+ */
+void nbcon_wake_threads(void)
+{
+	struct console *con;
+	int cookie;
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		/*
+		 * Only schedule irq_work if the printing thread is
+		 * actively waiting. If not waiting, the thread will
+		 * notice by itself that it has work to do.
+		 */
+		if (con->kthread && rcuwait_has_sleeper(&con->rcuwait))
+			irq_work_queue(&con->irq_work);
+	}
+	console_srcu_read_unlock(cookie);
+}
+
 /* Track the nbcon emergency nesting per CPU. */
 static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
 static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
@@ -1558,6 +1613,7 @@ void nbcon_init(struct console *con, u64 init_seq)
 	BUG_ON(!con->pbufs);
 
 	rcuwait_init(&con->rcuwait);
+	init_irq_work(&con->irq_work, nbcon_irq_work);
 	nbcon_seq_force(con, init_seq);
 	nbcon_state_set(con, &state);
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a2c4fe3d21cc..457c01311a95 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2402,6 +2402,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 		}
 	}
 
+	nbcon_wake_threads();
+
 	if (do_trylock_unlock) {
 		/*
 		 * The caller may be holding system-critical or
@@ -2708,6 +2710,10 @@ void resume_console(void)
 	 */
 	synchronize_srcu(&console_srcu);
 
+	/*
+	 * Since this runs in task context, wake the threaded printers
+	 * directly rather than scheduling irq_work to do it.
+	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
 		flags = console_srcu_read_flags(con);
@@ -4178,6 +4184,7 @@ void defer_console_output(void)
 
 void printk_trigger_flush(void)
 {
+	nbcon_wake_threads();
 	defer_console_output();
 }
 
@@ -4513,6 +4520,7 @@ void console_try_replay_all(void)
 {
 	if (console_trylock()) {
 		__console_rewind_all();
+		nbcon_wake_threads();
 		/* Consoles are flushed as part of console_unlock(). */
 		console_unlock();
 	}
-- 
2.39.2


