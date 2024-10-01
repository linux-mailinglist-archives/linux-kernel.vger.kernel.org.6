Return-Path: <linux-kernel+bounces-345544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8683F98B75B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BFC1C21CF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359B01A0BC6;
	Tue,  1 Oct 2024 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zix3ZTsb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ehsTybQh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804A1A08D7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772145; cv=none; b=jgc3ZG70tBbXmHs/rU8JCI8253/mNaSDC7thX2aU8H96860hpq+wnubV79/NLJm008NjHHRHB6Aa5XOpu7WJbjxd/F8wPCchQ4sCqnX8WdD5Si69cYQ8nGhX16cBv1czSPMNfnrv9E5RfgFLwsqgsozng0FahFiQcdEFBKM+Z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772145; c=relaxed/simple;
	bh=jmiVBba5EyouQAyF/JsSn4pK9BZLxqcgvMNhqRj+3UE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=O33LLLkx7LTOfmOJRfx6JcYlx1djrQ1vTvQR2Y6Jtvw3JrpsJ4ElGVg+glVDWhuUpVRoPGFl0L11WyjOdw0uyvKjlN6yUQ3CXt/Ywig5M0wlIIynQZCBjy/ReLK5oFcofEBHfSS4N8iJK+CkyiPi8+AeMuD5VwSecUYtTu4nj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zix3ZTsb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ehsTybQh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083836.220867629@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+v67TyAZ9r1vym76xiHeHNazqzzBfBwFWzGymjqyf/8=;
	b=Zix3ZTsbxfrW2gQYsm/MTDceotkBNH3mep9SqXUVZnUNZ9XXCm4Q2mgGxpSxPDATQE/DOx
	G2uP1rRmb1/+WMW6GoSjJhtVvHk1gafpqROswOy+pwyI2WtKIwHmWWC6/X6mgpsO87kmVF
	NxGCbdpkTkPd5XRnkbvdjhu1BLcFKZ/0xSj6tPnYKP+f3ESmfrP/HnthEkcl8f2WlMOibq
	FYNxJ1qp0XkZ9aGENL2g9t51dGCClY7+pf8OM3jLj0ucMYXHxcdLZRAoaJXaGc04Jz3YeN
	6trzaRqihIA6srrwO2vjp/rt1cc9uF1YIvtsliYWNUpycTERNh8WGWCo4VZ2jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+v67TyAZ9r1vym76xiHeHNazqzzBfBwFWzGymjqyf/8=;
	b=ehsTybQhcOZGpgyBNzQxJCncOoP7xrgIMbuSx4Sn7ScE41dVXzbjZRE4HKppOBBLoSXORd
	dGGvpNhhCEU51eDA==
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
Subject: [patch V5 16/26] signal: Replace resched_timer logic
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:21 +0200 (CEST)

In preparation for handling ignored posix timer signals correctly and
embedding the sigqueue struct into struct k_itimer, hand down a pointer to
the sigqueue struct into posix_timer_deliver_signal() instead of just
having a boolean flag.

No functional change.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 include/linux/posix-timers.h |    5 +++--
 kernel/signal.c              |   24 ++++++++++++------------
 kernel/time/posix-timers.c   |    2 +-
 3 files changed, 16 insertions(+), 15 deletions(-)

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
 
@@ -568,10 +568,10 @@ static void collect_signal(int sig, stru
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
 
-		*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
-				 (info->si_code == SI_TIMER);
-
-		__sigqueue_free(first);
+		if (unlikely((first->flags & SIGQUEUE_PREALLOC) && (info->si_code == SI_TIMER)))
+			*timer_sigq = first;
+		else
+			__sigqueue_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -588,12 +588,12 @@ static void collect_signal(int sig, stru
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
 
@@ -604,19 +604,19 @@ static int __dequeue_signal(struct sigpe
  */
 int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
+	struct sigqueue *timer_sigq = NULL;
 	struct task_struct *tsk = current;
-	bool resched_timer = false;
 	int signr;
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
 again:
 	*type = PIDTYPE_PID;
-	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
+	signr = __dequeue_signal(&tsk->pending, mask, info, &timer_sigq);
 	if (!signr) {
 		*type = PIDTYPE_TGID;
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
-					 mask, info, &resched_timer);
+					 mask, info, &timer_sigq);
 
 		if (unlikely(signr == SIGALRM))
 			posixtimer_rearm_itimer(tsk);
@@ -642,8 +642,8 @@ int dequeue_signal(sigset_t *mask, kerne
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
@@ -253,7 +253,7 @@ static void common_hrtimer_rearm(struct
  * This function is called from the signal delivery code. It decides
  * whether the signal should be dropped and rearms interval timers.
  */
-bool posixtimer_deliver_signal(struct kernel_siginfo *info)
+bool posixtimer_deliver_signal(struct kernel_siginfo *info, struct sigqueue *timer_sigq)
 {
 	struct k_itimer *timr;
 	unsigned long flags;


