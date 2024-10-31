Return-Path: <linux-kernel+bounces-390830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A1B9B7EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771F51C2119F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC3F1C8FBD;
	Thu, 31 Oct 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uLvvfyDh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwvP9gqs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEBB13AD32
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389602; cv=none; b=NDSRvc/mYCqxSFUVuOq3htwjVOwOvoFXsm3xfctynpLBj42AnYVvOs4j8BA2emcTlGIcoDQ9cmzJve4/DGEIDW1LzH6rhozr7CZhF23prnlfR+rUDPgTR88rHZmk9TseO3AhruRcOqDa+aaILxiIZ42rrYtOZb9IFmZLJt9EVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389602; c=relaxed/simple;
	bh=uF8HVjyRfSfPENjUQUuN0lAxWCzSjUVmwDegLBJY1Hk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=u3oDFa1LYWjZjh0CWtNa5R6V4YCls1RNntdBuVxQEsO1pivKwOoriFx7qIF03oJBnRaLjjXl7cAEf2ix8jhgbQacqupUYKqSFxCu2C/nOjvG7Wp+AvYAhMH2ga41srmPeqifDhyjYk+XLbjqGLDcGbYIsGvq7CMe8mVxMt6a2vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uLvvfyDh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwvP9gqs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154425.307607463@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QHJKT1FsG81uCFjqfXOJNacFFtoodXXL7f6S1umCJys=;
	b=uLvvfyDhzUvFWhf6x5s2JBlfOGZhs7lnH3IA5H8BGzAIXpC1VQeqFgFcFl0Z3A/3XIUoHG
	WGz3huXX5q6zQn62isQ7eNF7anrnHEIPFU7dQabkysTghv87hLEF4acroxwafqwaFcfxWz
	UfyhpEQsU2xJea+dGX7ybTYIvFDpq7HAGQ/Hbhxqe5iDOV0K/J2omhWFItrXWT32+LkLfA
	uygXKAZaOb7iMiCp00FQrSrDJFXcvCE6SbvwZVrm3+kU7hsxI8AvYEw65TlpmC+XSKgokD
	H4iAxwJHtPtZdiEE3mFndqMoC9Gu5r88w8G2rOkMsL7EO8C8MhGw/v19bVZDLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QHJKT1FsG81uCFjqfXOJNacFFtoodXXL7f6S1umCJys=;
	b=zwvP9gqsv21abafODULvw2191FcpHLB/SZsxFfKwst22zoJMM8h4DW0KgTtNvUIpr74+jr
	fMB/aNwynqv/AqAw==
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
Subject: [patch v6 12/20] signal: Cleanup unused posix-timer leftovers
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:37 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Remove the leftovers of sigqueue preallocation as it's not longer used.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/signal.h |    2 --
 kernel/signal.c              |   39 ++++-----------------------------------
 2 files changed, 4 insertions(+), 37 deletions(-)
---

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -338,8 +338,6 @@ extern void force_fatal_sig(int);
 extern void force_exit_sig(int);
 extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
-extern struct sigqueue *sigqueue_alloc(void);
-extern void sigqueue_free(struct sigqueue *);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -439,8 +439,8 @@ static void __sigqueue_init(struct sigqu
  * - this may be called without locks if and only if t == current, otherwise an
  *   appropriate lock must be held to stop the target task from exiting
  */
-static struct sigqueue *__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
-					 int override_rlimit, const unsigned int sigqueue_flags)
+static struct sigqueue *sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
+				       int override_rlimit)
 {
 	struct ucounts *ucounts = sig_get_ucounts(t, sig, override_rlimit);
 	struct sigqueue *q;
@@ -454,7 +454,7 @@ static struct sigqueue *__sigqueue_alloc
 		return NULL;
 	}
 
-	__sigqueue_init(q, ucounts, sigqueue_flags);
+	__sigqueue_init(q, ucounts, 0);
 	return q;
 }
 
@@ -1070,7 +1070,7 @@ static int __send_signal_locked(int sig,
 	else
 		override_rlimit = 0;
 
-	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit, 0);
+	q = sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
 
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
@@ -1926,37 +1926,6 @@ bool posixtimer_init_sigqueue(struct sig
 	return true;
 }
 
-struct sigqueue *sigqueue_alloc(void)
-{
-	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
-}
-
-void sigqueue_free(struct sigqueue *q)
-{
-	spinlock_t *lock = &current->sighand->siglock;
-	unsigned long flags;
-
-	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
-		return;
-	/*
-	 * We must hold ->siglock while testing q->list
-	 * to serialize with collect_signal() or with
-	 * __exit_signal()->flush_sigqueue().
-	 */
-	spin_lock_irqsave(lock, flags);
-	q->flags &= ~SIGQUEUE_PREALLOC;
-	/*
-	 * If it is queued it will be freed when dequeued,
-	 * like the "regular" sigqueue.
-	 */
-	if (!list_empty(&q->list))
-		q = NULL;
-	spin_unlock_irqrestore(lock, flags);
-
-	if (q)
-		__sigqueue_free(q);
-}
-
 static void posixtimer_queue_sigqueue(struct sigqueue *q, struct task_struct *t, enum pid_type type)
 {
 	struct sigpending *pending;


