Return-Path: <linux-kernel+bounces-314976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D550B96BBA9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938B728A7CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB241DA637;
	Wed,  4 Sep 2024 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VU1OSV+y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wg01OJMc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5527D1D9D89
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451548; cv=none; b=cApw7AduaatpLiUhC3TH2zQZxXIFhTIoTFcZjbgIepJYRUKFZq+kcpWZADb3ecA/alaEqaRhRLGs7WG+YHijubk1U0y9RqVckYJqaIiXfVVC/MUOwvP8nY6JOtNGSriTA5YM0/LPt0RNeHED50Oa6L7gY0VbywYkE8cCD8hx/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451548; c=relaxed/simple;
	bh=rtsc9CXnrtxsOZoaxdjwm8kc3O7QoCX7ibR6K/q90cM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbNbmF74//XwxN2FhfrY6aWc9/lLqecc1l6/QGhPjPc9xgks+F2s6y6qvhoTs2KdovOsit3C3uzyY5IQ2wmwmf+t50FQLI9atet48wbT7t35Eh4a2aWl52tQW/vNSUlvVakRlco+4UCcc7soG/ohiIMJmAykzg8zDbj5mGtsyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VU1OSV+y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wg01OJMc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ1XXcB9ioxO+CUQGXaIVuBG5iuRuzRh+87SQ2Ms8/Y=;
	b=VU1OSV+yI2AGrc0HY1WnSREXtiM1A7VP23DWt8kLisvV7y5DqTUWxNKcdMg0lKFjbVdIV5
	D49TndzR0pfSzHjhacTQKafxZIRGphrKeIazTlIOhVp0kF3eba83vUapu2Db7wA3ObLIpt
	qeLdTiVfLWQyLrCkZlQeBk5mQs+4upu8/qm549NxIb5RrN7IjlUq6jBP8NjBaxaBKviCbb
	WXYLm/NrHZgEQaqMrvRfJO9HsSjXAj57Ct3UA9GQogFT2Qng73dzkumS2zVyj7phXeRLba
	RUphi3yOoRwW7BUGgr0vzxOUSLaHEJJpznwPToXwYpi/Og9gT1Jng4NXDWgZsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZ1XXcB9ioxO+CUQGXaIVuBG5iuRuzRh+87SQ2Ms8/Y=;
	b=wg01OJMcD6sRh2K68yrhOOx4AoQzKlrmgsdDvEbTeq330huATemcnVOtwek0kPytXZimYu
	hxJKOYcfLGKsXNBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v6 17/17] printk: Avoid false positive lockdep report for legacy printing
Date: Wed,  4 Sep 2024 14:11:36 +0206
Message-Id: <20240904120536.115780-18-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Legacy console printing from printk() caller context may invoke
the console driver from atomic context. This leads to a lockdep
splat because the console driver will acquire a sleeping lock
and the caller may already hold a spinning lock. This is noticed
by lockdep on !PREEMPT_RT configurations because it will lead to
a problem on PREEMPT_RT.

However, on PREEMPT_RT the printing path from atomic context is
always avoided and the console driver is always invoked from a
dedicated thread. Thus the lockdep splat on !PREEMPT_RT is a
false positive.

For !PREEMPT_RT override the lock-context before invoking the
console driver to avoid the false positive.

Do not override the lock-context for PREEMPT_RT in order to
allow lockdep to catch any real locking context issues related
to the write callback usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 83 ++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index afd926611f0f..578723208f14 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2981,6 +2981,34 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	return true;
 }
 
+/*
+ * Legacy console printing from printk() caller context does not respect
+ * raw_spinlock/spinlock nesting. For !PREEMPT_RT the lockdep warning is a
+ * false positive. For PREEMPT_RT the false positive condition does not
+ * occur.
+ *
+ * This map is used to temporarily establish LD_WAIT_SLEEP context for the
+ * console write() callback when legacy printing to avoid false positive
+ * lockdep complaints, thus allowing lockdep to continue to function for
+ * real issues.
+ */
+#ifdef CONFIG_PREEMPT_RT
+static inline void printk_legacy_allow_spinlock_enter(void) { }
+static inline void printk_legacy_allow_spinlock_exit(void) { }
+#else
+static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
+
+static inline void printk_legacy_allow_spinlock_enter(void)
+{
+	lock_map_acquire_try(&printk_legacy_map);
+}
+
+static inline void printk_legacy_allow_spinlock_exit(void)
+{
+	lock_map_release(&printk_legacy_map);
+}
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * Used as the printk buffers for non-panic, serialized console printing.
  * This is for legacy (!CON_NBCON) as well as all boot (CON_BOOT) consoles.
@@ -3030,31 +3058,46 @@ static bool console_emit_next_record(struct console *con, bool *handover, int co
 		con->dropped = 0;
 	}
 
-	/*
-	 * While actively printing out messages, if another printk()
-	 * were to occur on another CPU, it may wait for this one to
-	 * finish. This task can not be preempted if there is a
-	 * waiter waiting to take over.
-	 *
-	 * Interrupts are disabled because the hand over to a waiter
-	 * must not be interrupted until the hand over is completed
-	 * (@console_waiter is cleared).
-	 */
-	printk_safe_enter_irqsave(flags);
-	console_lock_spinning_enable();
+	/* Write everything out to the hardware. */
 
-	/* Do not trace print latency. */
-	stop_critical_timings();
+	if (force_legacy_kthread() && !panic_in_progress()) {
+		/*
+		 * With forced threading this function is in a task context
+		 * (either legacy kthread or get_init_console_seq()). There
+		 * is no need for concern about printk reentrance, handovers,
+		 * or lockdep complaints.
+		 */
 
-	/* Write everything out to the hardware. */
-	con->write(con, outbuf, pmsg.outbuf_len);
+		con->write(con, outbuf, pmsg.outbuf_len);
+		con->seq = pmsg.seq + 1;
+	} else {
+		/*
+		 * While actively printing out messages, if another printk()
+		 * were to occur on another CPU, it may wait for this one to
+		 * finish. This task can not be preempted if there is a
+		 * waiter waiting to take over.
+		 *
+		 * Interrupts are disabled because the hand over to a waiter
+		 * must not be interrupted until the hand over is completed
+		 * (@console_waiter is cleared).
+		 */
+		printk_safe_enter_irqsave(flags);
+		console_lock_spinning_enable();
 
-	start_critical_timings();
+		/* Do not trace print latency. */
+		stop_critical_timings();
 
-	con->seq = pmsg.seq + 1;
+		printk_legacy_allow_spinlock_enter();
+		con->write(con, outbuf, pmsg.outbuf_len);
+		printk_legacy_allow_spinlock_exit();
 
-	*handover = console_lock_spinning_disable_and_check(cookie);
-	printk_safe_exit_irqrestore(flags);
+		start_critical_timings();
+
+		con->seq = pmsg.seq + 1;
+
+		*handover = console_lock_spinning_disable_and_check(cookie);
+		printk_safe_exit_irqrestore(flags);
+	}
 skip:
 	return true;
 }
-- 
2.39.2


