Return-Path: <linux-kernel+bounces-341495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7829880D0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268661F226FA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ACA18A92F;
	Fri, 27 Sep 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="20P5hVWc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+SHmljH2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73018A922
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426947; cv=none; b=c9VliCyrRl6XCZHYf4bmDmuYVn5+fq9OnmiF4HkL6oMswqTTVoo6OLg3GGBvTLouFPuC9vs2k7Ba2RX80RyvNmjTtQTazA84rIZJo19rHA23Czp2RG+tnKxeg7gFb35B6vzuPy5qCTY95VUEGWFxMNtGKtyBx91OiBIyneuA4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426947; c=relaxed/simple;
	bh=HlE/rB9DJ2iFpW51kf3egByzflBOf5vMGbgvRd4sVBM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bqHnmKq1FYneEWonj6fo1i5DRIHvRx08zUIKnXO5JA9EeyXhQyie5UomvmqiFbLyfm+PsYpeYL82T37rlLoC9EB/h3axNqoyTYtWrrls+3ONws6OVaq4j/6PA8Kqe1fwgJPrKGvFUxgZRRGT+G1+ET+yPzHS2XA5zsnVTKrJ23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=20P5hVWc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+SHmljH2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084818.130965127@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WfdjifQzaEkh29PcCz6zrqcoHSPORIhLPU9iUugztoc=;
	b=20P5hVWcVxQwz/IrPw41/5Ib+IYJqaySxrIUlMArMipyWKmAovYdW4pZtK6Ls9srU2/mej
	9UOqOk3QcMbDGyL2rP5SR7Y2wkBcQNu+jzWI6o2tgjaDpkZuiWR1Gbed0bRdbK0asIMRh/
	Slmbism4G131D6s1AMOTRx+XWoAmkSCDOrxe5GnxNtpCd8c/66LcOtwLMx0tf9gmPcDyef
	kfIhOMa6a1M0H9c7QR9gchLRgdbALGnPH11WjqYjhdR1YuSpfAdIXFZ+/vYvRhTj+pOr0F
	hVrjMBehDPHDEuooOkUuUO5T8kHFOHxhaWt4mVwk5mVvq9+yZ6ZJ5YR+0FyZEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=WfdjifQzaEkh29PcCz6zrqcoHSPORIhLPU9iUugztoc=;
	b=+SHmljH2bQaF9cWtzz8yzRpHADeUmhsQjrgWRLpgSpmeAX4xlFhIqccCmwntoRMoC/aSZx
	gc5H2TLxH3IiNkAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch v4 20/27] signal: Add task argument to flush_sigqueue_mask()
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:49:03 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

To prepare for handling posix timer signals on sigaction(SIG_IGN) properly,
add a task argument to flush_sigqueue_mask() and fixup all call sites.

This argument will be used in a later step to enqueue posix timers on an
ignored list, so their signal can be requeued when SIG_IGN is lifted later
on.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 kernel/signal.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)
---
diff --git a/kernel/signal.c b/kernel/signal.c
index 48bceca90a91..93c2d681309c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -724,11 +724,10 @@ void signal_wake_up_state(struct task_struct *t, unsigned int state)
 
 /*
  * Remove signals in mask from the pending set and queue.
- * Returns 1 if any signals were found.
  *
  * All callers must be holding the siglock.
  */
-static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s)
+static void flush_sigqueue_mask(sigset_t *mask, struct sigpending *s, struct task_struct *ptmr_tsk)
 {
 	struct sigqueue *q, *n;
 	sigset_t m;
@@ -866,18 +865,18 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
 		 * This is a stop signal.  Remove SIGCONT from all queues.
 		 */
 		siginitset(&flush, sigmask(SIGCONT));
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(&flush, &signal->shared_pending, NULL);
 		for_each_thread(p, t)
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(&flush, &t->pending, NULL);
 	} else if (sig == SIGCONT) {
 		unsigned int why;
 		/*
 		 * Remove all stop signals from all queues, wake all threads.
 		 */
 		siginitset(&flush, SIG_KERNEL_STOP_MASK);
-		flush_sigqueue_mask(&flush, &signal->shared_pending);
+		flush_sigqueue_mask(&flush, &signal->shared_pending, NULL);
 		for_each_thread(p, t) {
-			flush_sigqueue_mask(&flush, &t->pending);
+			flush_sigqueue_mask(&flush, &t->pending, NULL);
 			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
 			if (likely(!(t->ptrace & PT_SEIZED))) {
 				t->jobctl &= ~JOBCTL_STOPPED;
@@ -4169,8 +4168,8 @@ void kernel_sigaction(int sig, __sighandler_t action)
 		sigemptyset(&mask);
 		sigaddset(&mask, sig);
 
-		flush_sigqueue_mask(&mask, &current->signal->shared_pending);
-		flush_sigqueue_mask(&mask, &current->pending);
+		flush_sigqueue_mask(&mask, &current->signal->shared_pending, NULL);
+		flush_sigqueue_mask(&mask, &current->pending, NULL);
 		recalc_sigpending();
 	}
 	spin_unlock_irq(&current->sighand->siglock);
@@ -4237,9 +4236,9 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 		if (sig_handler_ignored(sig_handler(p, sig), sig)) {
 			sigemptyset(&mask);
 			sigaddset(&mask, sig);
-			flush_sigqueue_mask(&mask, &p->signal->shared_pending);
+			flush_sigqueue_mask(&mask, &p->signal->shared_pending, NULL);
 			for_each_thread(p, t)
-				flush_sigqueue_mask(&mask, &t->pending);
+				flush_sigqueue_mask(&mask, &t->pending, NULL);
 		}
 	}
 


