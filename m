Return-Path: <linux-kernel+bounces-341478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19E9880AE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FA6283142
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B84F18EFEC;
	Fri, 27 Sep 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="soptG/GD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tj43IAUI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D7B18A6AF
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426931; cv=none; b=rwOHvfUOwEDCPbSpSVUxPlLX4GRTmJPN5uJqt35jrYqnmHvDAO4LaUjZJb4LHB057lXpqCHipD7R3YM6e6O5ckzHs9kKVzWfjx/WiaeoErMoAwbNafZq2wp1dl9gFeY7sNB4FvkqPbCPAn+tBt8E6iYEtoHRlJy+CYqXPf8rt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426931; c=relaxed/simple;
	bh=nMxK2TVQUw9yR6HLv+Lk2ZUa3NgJga3POK/2Yd563DQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KHHP+1StJh8k3nyzHNwN7SKyXG48+aRbDfAahtxhxd3nAENqAtSUwXG8zQCQIPJyhEyojvUhVJwE/Zs4hMOiAtyX8YKky5bEGavq14Qynqz7dJcrpc/U4r9bImWC3zYKtkmeOMPgkOvVbFHyU8iyUkmTOcmKZnMoIomVgYUOrmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=soptG/GD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tj43IAUI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.199851763@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nctofLmIte6TSx5Fcm0ses5QzBfXpuCNkO8zmbzciOI=;
	b=soptG/GDN8YoLc/uvj8wQkW709NG2NkTPcZUgHxBoMS2EMQiLnmT3P7lRmOeR9UKP+Rc4V
	MmfRn51hoU+EeMWy5BZXra1iQHtlOlJvaDB4RKr1YwmBPSuRRCLWOjtplOXCDBw9OgPDjD
	pCT/AcRNnAmEkV3fq4A8dAMfxhTaTFAyat2r5RfCshzyjFy1OBtPYfdDnQHAY8yYqzFAVo
	CBOSpdHFPdrQBfFV8JsAIQ9iA67TiluZafRHZdKYkXY7tiCwZ4wc31qCv2VR5wu4fKWqNP
	SmV1dXT2C3l98uVGmZTUAbI+aWtRvI5alY8VMEL8XPWrCYfRhiRbXSU/EFPT6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nctofLmIte6TSx5Fcm0ses5QzBfXpuCNkO8zmbzciOI=;
	b=tj43IAUIBK8RIXCylZqehFjA0Foufvzfms1zfCv1Hq8QafD+pGALUZhpXuQpPXRqEUlelj
	aLr7ag+KIPLUbHDg==
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
Subject: [patch v4 05/27] signal: Allow POSIX timer signals to be dropped
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:45 +0200 (CEST)

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
 include/linux/posix-timers.h | 5 +++--
 kernel/signal.c              | 7 +++++--
 kernel/time/posix-timers.c   | 3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 670bf03a56ef..4ab49e5c42af 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -100,8 +100,9 @@ static inline void posix_cputimers_rt_watchdog(struct posix_cputimers *pct,
 {
 	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
+
 void posixtimer_rearm_itimer(struct task_struct *p);
-void posixtimer_rearm(struct kernel_siginfo *info);
+bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -125,7 +126,7 @@ static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
-static inline void posixtimer_rearm(struct kernel_siginfo *info) { }
+static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/kernel/signal.c b/kernel/signal.c
index 443baadb5ab0..c35b6ff52767 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -585,6 +585,7 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 
 	lockdep_assert_held(&tsk->sighand->siglock);
 
+again:
 	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info);
 	if (!signr) {
@@ -616,8 +617,10 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
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
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b6cca1ed2f90..d7ed7542f803 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -254,7 +254,7 @@ static void common_hrtimer_rearm(struct k_itimer *timr)
  * info::si_sys_private is not zero, which indicates that the timer has to
  * be rearmed. Restart the timer and update info::si_overrun.
  */
-void posixtimer_rearm(struct kernel_siginfo *info)
+bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
 	struct k_itimer *timr;
 	unsigned long flags;
@@ -286,6 +286,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 
 	/* Don't expose the si_sys_private value to userspace */
 	info->si_sys_private = 0;
+	return true;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)


