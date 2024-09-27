Return-Path: <linux-kernel+bounces-341494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B39880CF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674F2282371
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FC21B2EC2;
	Fri, 27 Sep 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="INt5j6XA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7t7oC8X8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507971B29C1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426945; cv=none; b=tIzmCsfHFleZt6VqIPqdUzqFM9Uj31Io/QX4wJOnphgn6W+2XWhT7qae7Df43O8ctcnRcJk9aLBGT5c3xZp2hYHS9Kb12yCXY8huzrXvd7mzPUxLUd9ajnACasETKhZ+4xyDv1vFPl/3v3xqOREAK+F3SEzPnbvW3iDMiUPpxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426945; c=relaxed/simple;
	bh=UlHBOibUs+tPQI7hVRid7/rykm8kuHRH0y7EnCEYm+o=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=p/OMkUkq4NNdk43koWgyyElRFqCjyiQThlkP3X+ZYJg3dVPMldjE/L65O9+TtdsSplqsvVvL3s2ZA8pg9XG3l1o2V++gTB6ssT3rIsGLLzP1+NIHBVSO1/33sT30HFSLvdRCGgthqCbzb0yCch3Fj0WLjaB/d++JnbnFISjseA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=INt5j6XA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7t7oC8X8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084818.069667397@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mQNrbcp+YcyVuJXLebTnSEkknpAl3WACHMwmKH9HqYw=;
	b=INt5j6XAyzF65xDyuh3XWAgIh0Z36i8qAqCqwLd6zJ9p9yyn+DanXPkkEO5FgOVNmBGBKt
	i7eFzAOpp/1KAskyrxVLX/sl04oKRHOjBj6hn+YkLST0Lb+uJntQVSQvUPSvI6IU0j3l7P
	cT+Ewj2FH+StWZbxFVNScTHlSSKjQXVSGE+/vRwWXNz2peRXF291GJbGhGmISFhX27PjCV
	Wkn8IGGGXsl2rXuG4silHUA7QSFMVQuVhX1dSQQMQV7uxzHcIbVFPLaGLVB2IUSWeaz7ru
	bXi+WRq01LKLSCZT6PhqD91poLSRleiotATxg8oqyQQOdq/94DWem9x+VqH7ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mQNrbcp+YcyVuJXLebTnSEkknpAl3WACHMwmKH9HqYw=;
	b=7t7oC8X8F+KZgEbnwB+oMgUqr4KCkmYNU1/vuZoViNkRvXbm5NHo/8yMOF8yMRZPgrVxnZ
	yNWq7n/8QHUgj7BQ==
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
Subject: [patch v4 19/27] signal: Cleanup unused posix-timer leftovers
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:49:02 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Remove the leftovers of sigqueue preallocation as it's not longer used.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/sched/signal.h |  2 --
 kernel/signal.c              | 43 +++++++------------------------------------
 2 files changed, 7 insertions(+), 38 deletions(-)
---
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 36283c1c55e9..02972fd41931 100644
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
diff --git a/kernel/signal.c b/kernel/signal.c
index 7a07f86e2ae6..48bceca90a91 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -439,8 +439,8 @@ static void __sigqueue_init(struct sigqueue *q, struct ucounts *ucounts,
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
@@ -454,14 +454,16 @@ static struct sigqueue *__sigqueue_alloc(int sig, struct task_struct *t, gfp_t g
 		return NULL;
 	}
 
-	__sigqueue_init(q, ucounts, sigqueue_flags);
+	__sigqueue_init(q, ucounts, 0);
 	return q;
 }
 
 static void __sigqueue_free(struct sigqueue *q)
 {
-	if (q->flags & SIGQUEUE_PREALLOC)
+	if (q->flags & SIGQUEUE_PREALLOC) {
+		posixtimer_sigqueue_putref(q);
 		return;
+	}
 	if (q->ucounts) {
 		dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		q->ucounts = NULL;
@@ -1065,7 +1067,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 	else
 		override_rlimit = 0;
 
-	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit, 0);
+	q = sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
 
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
@@ -1921,37 +1923,6 @@ bool posixtimer_init_sigqueue(struct sigqueue *q)
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


