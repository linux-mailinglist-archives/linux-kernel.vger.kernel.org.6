Return-Path: <linux-kernel+bounces-345532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1223698B74F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC16E281734
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D6719DF81;
	Tue,  1 Oct 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UUMsG9ov";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3kQm0vV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D612919D089
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772128; cv=none; b=GznxZ5I571tcdpIzk6BNT5m20E5JW3w3oX+IyFKSMggF3/2GVD9sVdaHDM85Ky0dKBGMt43z2YIUUr4wJNonzyqp0HLwnvt6R3/v47cJFGT8okEXtSK1LSv6oPcEmo+6Xxf4Os962V3GQpIR95UilZGWzlClJdw++Ty2XC1Q3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772128; c=relaxed/simple;
	bh=i2LJtxWLqFkcIAuw/Qy0eM1iRXPz0nzC5BS3WiF7Ya8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=N0t5JEryCpP/rgzoKiPVAEZR7yZdL0Mb0/WaWB3bgpn55Kl7DGKewz6hMBR7rU3PtigT2y2EOi1k1H2AWdJ9fW29O+/CdtyswJeLAGKnFs85ovQO3qDgVGmewTaJy7nJLaSpCRGpeucr5FI+aNalPPktXRi158HgJ6KtwB3SX9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UUMsG9ov; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3kQm0vV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083835.494416923@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bMfQs4RXzVSNN9s6N1/ETgB73QLiI7DZqMzM0+UeQF4=;
	b=UUMsG9ovnGgSJ4bZ20MkW0l5JbcbHtMsxgUODdkRjJ9+VdgTysqjtOdIxIUrGGrYva4+II
	8lpG1UM8YqRq/ASUQ7VX2Dy8VxXEjzZvV850Brv5RtFNKXLanlpS6tKwSUElu+8QxltDRo
	tHPB5cXXr8Qborxt3+FD7xBIZJhDmheptdR+fip7UoZ/AWONsSSGIOexrx/LZOlVoR0/se
	1/FQB/HEuLees6u69pho3Sm5pc4ZKBGfUI8yYNJRyA7z2Wc3wj+p5ahRvbYQ3KsJ0Rbj4q
	OwmqlalEBsfmZUfYfn1+7CU2tVsTKm9qN2bgq9u96MFGzIH/+cLojo6ErU3vvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bMfQs4RXzVSNN9s6N1/ETgB73QLiI7DZqMzM0+UeQF4=;
	b=v3kQm0vVmRdlFvGo+UD6dGD5BqLT0HyAHvXUXTFAyXjMMZ0VnFxLEQAYLo6k35N9KopYAL
	8fslsuETvTe0joDg==
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
Subject: [patch V5 04/26] signal: Allow POSIX timer signals to be dropped
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:04 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

In case that a timer was reprogrammed or deleted an already pending signal
is obsolete. Right now such signals are kept around and eventually
delivered. While POSIX is blury about this:

 - "The effect of disarming or resetting a timer with pending expiration
    notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is
    unspecified."

it is reasonable in both cases to expect that pending signals are discarded
as they have no meaning anymore.

Prepare the signal code to allow dropping posix timer signals.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h |    5 +++--
 kernel/signal.c              |    7 ++++---
 kernel/time/posix-timers.c   |    3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)
---
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -100,8 +100,9 @@ static inline void posix_cputimers_rt_wa
 {
 	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
+
 void posixtimer_rearm_itimer(struct task_struct *p);
-void posixtimer_rearm(struct kernel_siginfo *info);
+bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -125,7 +126,7 @@ static inline void posix_cputimers_init(
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
-static inline void posixtimer_rearm(struct kernel_siginfo *info) { }
+static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -594,6 +594,7 @@ int dequeue_signal(sigset_t *mask, kerne
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
+again:
 	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
 	if (!signr) {
@@ -625,9 +626,9 @@ int dequeue_signal(sigset_t *mask, kerne
 		current->jobctl |= JOBCTL_STOP_DEQUEUED;
 	}
 
-	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(resched_timer))
-			posixtimer_rearm(info);
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS) && unlikely(resched_timer)) {
+		if (!posixtimer_deliver_signal(info))
+			goto again;
 	}
 
 	return signr;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -254,7 +254,7 @@ static void common_hrtimer_rearm(struct
  * info::si_sys_private is not zero, which indicates that the timer has to
  * be rearmed. Restart the timer and update info::si_overrun.
  */
-void posixtimer_rearm(struct kernel_siginfo *info)
+bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
 	struct k_itimer *timr;
 	unsigned long flags;
@@ -286,6 +286,7 @@ void posixtimer_rearm(struct kernel_sigi
 
 	/* Don't expose the si_sys_private value to userspace */
 	info->si_sys_private = 0;
+	return true;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)


