Return-Path: <linux-kernel+bounces-309048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B23966588
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83CA1F21732
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FACA1BD516;
	Fri, 30 Aug 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nqEWWsAG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A6ZbNNvm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0401BAEEA
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031773; cv=none; b=AHDqbRAJjaEFXFnZ1aaHpGp9owca7mB/Y/+SJ9utsO+V7Iy3IuEoNNuRLQT+Iaq2r6Kbo+o/lJPxOL2mNv0jE1NC3DMRXyOb01B/2ru2/240idtGav56utptZxyVm1tQG6aPK8RavnWO/xJ5J8E3XOkaPqTC7YmYluN9I7BL3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031773; c=relaxed/simple;
	bh=9IGRyHvIOyO4h4UgC+kRSg00xKhgkenj+kdyGqiNM1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KAykUb5ICnBNe6rg/sNM4woRuSp3VNrnteyxAG2uiyUQx3LGvxjYLaGwbdEUNQb9x3Ml/3McJxwB2cIIafxsmXN00mhUr2JUdtzlLrq/0jxxceu9CvaVeXKse9NIiQC8Uav14KHjtvB/iiv8dy7GzsD2FS0z9rF+5dIDJC1pdIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nqEWWsAG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A6ZbNNvm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFlbLUwcAn0jTkWxIFR5wHqelEelckpUmnq7kM1wCmY=;
	b=nqEWWsAGukMmhlJFxLIOHOoIX5Z5X7P743hH9AJqJBw3kzzqgp4ulillUCMxyXTCkXYW/7
	02rk+OifIatwUcNwfJdfT3cAXW8zW1lyg5iZE7ZV1VmvjIdYfa6z5k8tNXQ9zRTCr13cPA
	k80aIqiU18RAriNEy6uZZGj47dc3qq5d6uuYJjlFTAfAjP3VYwwIFrwhBbJfSNgP3o8SQG
	o8Pp89jE8ETIOrsoTMjge18GLzKuj0nOBvI0RVuc94pA11CmGDTsvUJ3jrMB++TZuZn5zt
	u4eSN0lYsEySCkpo1Gaw0HQ/aUBFmemCgEgGNU1H8t16TfgbXdcDNv1b2qOWCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFlbLUwcAn0jTkWxIFR5wHqelEelckpUmnq7kM1wCmY=;
	b=A6ZbNNvmOBTPYK0TaT5D5wU/8l8dEj8GxJcKdwl545K2Oe26MRcPR98ODaUUCnqmJ8WIND
	urUpb57y/dgLSEBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 17/17] printk: Avoid false positive lockdep report for legacy printing
Date: Fri, 30 Aug 2024 17:35:16 +0206
Message-Id: <20240830152916.10136-18-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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
index c4a6aaddf8e6..19e998c4985b 100644
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


