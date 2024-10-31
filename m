Return-Path: <linux-kernel+bounces-390828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7069B7EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DB61C2105F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA261C2441;
	Thu, 31 Oct 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKhDVGre";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SPJWRAbv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD61BDA9B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389599; cv=none; b=s2sCQdSvBAsGLxdQ6FXEPID06zI1BKhHerYkATxRGzxtKlomf9hh1sZfxB5OmO7FXs5cTVlVskhDI6cJhg6tvN0Nfe7pQOuKmj3aSs/mUSKiwT0N2/Y3vqWd5Pane6oTH8K/aOXmS2vBo6ZTzj86lfg0WkRBX3p/tCtgtV/Fvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389599; c=relaxed/simple;
	bh=W9vkcg3goHw3toa/NPatBgcGiFKl03A2/EGpx0AvsdE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RFwWH3wUZXN1Z+xy7WlAM3eGPug5tAkxju4meL2fYFQgjBMa1is7qXYxGYpWd2m9kKQOvMpkXUnH4pMwrdSMnD/URsBFjDjW/ZqpLcb1aibMYrLkDHrEItKxzQlb7ikzPI1k+4HhCEmWLatPBQIEPhEiF30iPsK0cENva1kGZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKhDVGre; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SPJWRAbv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241031154425.182629074@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=I2JKYlpS9EROm2PXQHeSksdbFrfFm6VApPBBZM9ycE4=;
	b=nKhDVGreMefqEU/ghR9JuGellFhk+cHje4Q2CTYAtmlhb3tQo689wfjKWL0nd5MKgygK2V
	CQ4DFKP/7cyr7WW9bih4YUIoHOAdNPqoKsxR4BPvpmnGgukMrH93AprLZEyzhz5TJFguhn
	yC7wAVuMG/+mZIufqGtHb6WBC2VNx7TF0e5j0wr8r4944RAnpy2NAy0q55ORnF72bt3MLP
	o88xM/DnC1T8ACTijCogiQysUE5xC3cSCo8Tjq9TLm2zBGswoY7HI7qIePH2EDbkhER3t7
	QyAeTwrTUNgd/i2eKhC0Z5d/iqvRWy4vAwDp8Hs6bN/PHSvZjlnclMNkLqHK8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=I2JKYlpS9EROm2PXQHeSksdbFrfFm6VApPBBZM9ycE4=;
	b=SPJWRAbvjNxaZNeRvMUKFxQj80GpjFr6+4bkZ82NY6Xh32w+D+4+9+/c3W9KtEAbyi9Oxt
	NU1Y1JY0/uR0RhDg==
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
Subject: [patch v6 10/20] signal: Replace resched_timer logic
References: <20241031151625.361697424@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Oct 2024 16:46:35 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

In preparation for handling ignored posix timer signals correctly and
embedding the sigqueue struct into struct k_itimer, hand down a pointer to
the sigqueue struct into posix_timer_deliver_signal() instead of just
having a boolean flag.

No functional change.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
V6: NULLify timer_sigq after again: in dequeue_signal() - Frederic
V5: New patch
---
 include/linux/posix-timers.h |    5 +++--
 kernel/signal.c              |   32 ++++++++++++++++++++------------
 kernel/time/posix-timers.c   |    2 +-
 3 files changed, 24 insertions(+), 15 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -110,7 +110,7 @@ static inline void posix_cputimers_rt_wa
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_init_sigqueue(struct sigqueue *q);
 int posixtimer_send_sigqueue(struct k_itimer *tmr);
-bool posixtimer_deliver_signal(struct kernel_siginfo *info);
+bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq);
 void posixtimer_free_timer(struct k_itimer *timer);
 
 /* Init task static initializer */
@@ -135,7 +135,8 @@ static inline void posix_cputimers_init(
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
-static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
+static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info,
+					     struct sigqueue *timer_sigq) { return false; }
 static inline void posixtimer_free_timer(struct k_itimer *timer) { }
 #endif
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -545,7 +545,7 @@ bool unhandled_signal(struct task_struct
 }
 
 static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *info,
-			   bool *resched_timer)
+			   struct sigqueue **timer_sigq)
 {
 	struct sigqueue *q, *first = NULL;
 
@@ -568,10 +568,17 @@ static void collect_signal(int sig, stru
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
 
-		*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
-				 (info->si_code == SI_TIMER);
-
-		__sigqueue_free(first);
+		/*
+		 * posix-timer signals are preallocated and freed when the
+		 * timer goes away. Either directly or by clearing
+		 * SIGQUEUE_PREALLOC so that the next delivery will free
+		 * them. Spare the extra round through __sigqueue_free()
+		 * which is ignoring preallocated signals.
+		 */
+		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code == SI_TIMER)))
+			*timer_sigq = first;
+		else
+			__sigqueue_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -588,12 +595,12 @@ static void collect_signal(int sig, stru
 }
 
 static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
-			kernel_siginfo_t *info, bool *resched_timer)
+			    kernel_siginfo_t *info, struct sigqueue **timer_sigq)
 {
 	int sig = next_signal(pending, mask);
 
 	if (sig)
-		collect_signal(sig, pending, info, resched_timer);
+		collect_signal(sig, pending, info, timer_sigq);
 	return sig;
 }
 
@@ -605,18 +612,19 @@ static int __dequeue_signal(struct sigpe
 int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
 	struct task_struct *tsk = current;
-	bool resched_timer = false;
+	struct sigqueue *timer_sigq;
 	int signr;
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
 again:
 	*type = PIDTYPE_PID;
-	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
+	timer_sigq = NULL;
+	signr = __dequeue_signal(&tsk->pending, mask, info, &timer_sigq);
 	if (!signr) {
 		*type = PIDTYPE_TGID;
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
-					 mask, info, &resched_timer);
+					 mask, info, &timer_sigq);
 
 		if (unlikely(signr == SIGALRM))
 			posixtimer_rearm_itimer(tsk);
@@ -642,8 +650,8 @@ int dequeue_signal(sigset_t *mask, kerne
 		current->jobctl |= JOBCTL_STOP_DEQUEUED;
 	}
 
-	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(resched_timer)) {
-		if (!posixtimer_deliver_signal(info))
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(timer_sigq)) {
+		if (!posixtimer_deliver_signal(info, timer_sigq))
 			goto again;
 	}
 
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -254,7 +254,7 @@ static void common_hrtimer_rearm(struct
  * This function is called from the signal delivery code. It decides
  * whether the signal should be dropped and rearms interval timers.
  */
-bool posixtimer_deliver_signal(struct kernel_siginfo *info)
+bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq)
 {
 	struct k_itimer *timr;
 	unsigned long flags;


