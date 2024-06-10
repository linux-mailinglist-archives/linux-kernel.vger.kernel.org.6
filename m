Return-Path: <linux-kernel+bounces-208592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A092902702
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90A81F22310
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20823156875;
	Mon, 10 Jun 2024 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ztJs/u9a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qb3vq1eg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5B156641
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037764; cv=none; b=YYL3o8wUP5Wr3FxsNA2nMCISwO06kssZCmia5Yy4Wizeodxeyxq24YfEptjksmb1xMPZUZ/OE9zrvcLBk4rWCLYNugLEfZh+5uqg9ckkNRO73B0seUemqat55WZ96zOTQ336CAMhZoXdX9Cr2IwwCAxUvdlESM9C44AOXU1ql8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037764; c=relaxed/simple;
	bh=YH2GNJxCNBMbmtwU0fr39UpQz8wyT6gB/kPu6Cst2a0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FP9tzDb7jpYV3bT1dhRgoRzWkNh9Us0PevO0pENH+v733+tNR2ytiVAVIgDeSid1+aVNAO1T7ZU5nAdRSwl5ajoVdkCopZ42c9zaN0BewEqe6SjTYCvmjY/wMbVJTA3/EAtIqEAsv64f4bzkk/7HeigUOrJee1NgDkaWYB6Rx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ztJs/u9a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qb3vq1eg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.303056339@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7CK+FAEXH0tvW3CxjLUKVaxfftLEf1lOjkxUKErNSnE=;
	b=ztJs/u9ajzIRsznRPRxyZeDVlvQuouAZZx/Bsm3yOQzN787cQRuYagCrsNrkMTGxcCikwd
	1ZmPt97/josOM6ZPUniDbpJgr03sq4HHyndPYizI2Mb3Mp4eNoctdkHHK8ES8UWRiF/yDi
	p5RjpqVLDCK+zCuHW7oE4S5SSZ3vMlfIrVl8BR+UKrOgpgT2jeD9gwyNxL54Q8tuaQFTmp
	kNeOwi25aUugSjitZSEfn8wW+JQ2snbn8jfDG5JYHNDWhjAr8XF9oUd+NKOw66G/W8oRNh
	8Z0Kqbi81t3ZM7Vwo3FAMhzGuGTl2n7kJLlrQ7hi2H73jaNtyXhYRh66FOjDdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7CK+FAEXH0tvW3CxjLUKVaxfftLEf1lOjkxUKErNSnE=;
	b=qb3vq1eg+tk9rQfpuDtolPFd2U1w1rQI1S4Wkai9LMXApyd+pZb2C+4LZwwKIxYQpKPwvR
	9T7SkDvN+sTUp3Bw==
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
Subject: [patch V3 29/51] signal: Allow POSIX timer signals to be dropped
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:41 +0200 (CEST)

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
---
 include/linux/posix-timers.h |    5 +++--
 kernel/signal.c              |    7 +++++--
 kernel/time/posix-timers.c   |    3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

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
@@ -585,6 +585,7 @@ int dequeue_signal(sigset_t *mask, kerne
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
+again:
 	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info);
 	if (!signr) {
@@ -616,8 +617,10 @@ int dequeue_signal(sigset_t *mask, kerne
 	}
 
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private))
-			posixtimer_rearm(info);
+		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private)) {
+			if (!posixtimer_deliver_signal(info))
+				goto again;
+		}
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


