Return-Path: <linux-kernel+bounces-341500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08E49880D8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23862821FF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7C91B3B30;
	Fri, 27 Sep 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ko1WePtd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xs7M0AcF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566531B3B07
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426953; cv=none; b=fVh4RzRt/6Gg0wdOBEtVVCz1OUdLe62P78ANn/dy3qLpK/9JwVD7zPvC4ECrUJzAyKKJKrjS9H+2T1HaK0FH8BxHhl6+X3X15dhBwckfWR9gj5T0XXr5YKjj6/q88iHk5jjRqWus9vUvOojmR5zua4WcNE900hRIcg5pXyXFeWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426953; c=relaxed/simple;
	bh=OotEkdlkvMQJgL29FdEkVAojV0i26KLmzxwQSi5vj+g=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=r+2vo/4B1y8DPtwe9bdp+rkWSDpX9NaZy3Q9Hdt9TzMPjE9r3J8DxshkmyoA0FbgWtzdVUKUyajJSFtmE9g2IliEh69u6bc4uzVm1hhp6CHHUKInGwb8GDtzv8nypB4mfal8VxiG8EieRLf4yx9M6K29b1mehz37lzJ4av3x6ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ko1WePtd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xs7M0AcF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084818.428157721@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u11WxY/lGhbpoPTuquxmgFwL7MsbHwkGbP1bdkzo7pA=;
	b=Ko1WePtdbZLv4BdIySURdWnWfFArYzUWmJdNBh8AhRyWddnrv78zJFr6isIZMJw5QvywNZ
	fnPrEcoR+ihp0YpbtJ9lGHWYrotBeaEOGgfxlAXCmrKAlyotqmS6keGzWROyHPdZTIvVF6
	OWEkMh9Bn1npMfxsOfOQKYLNBdpfE9Xpk4yE7ZLrAsnLdnFEcmNcs+gNtFkppr6AAlNwpK
	IMjji5TqaA8DuOhCQEJAD43nw0NLGp5OUq/ltzJP+s79ngqEnPDpr3mRC139LPkm52FxDg
	+jgj0mnDGuJJwLPeZhItlYUJyrJb7KWQVqt56Q8nuAS83StUtBpfOrIs+mKY3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u11WxY/lGhbpoPTuquxmgFwL7MsbHwkGbP1bdkzo7pA=;
	b=Xs7M0AcFTp/eQGxL3tOUf+F2dn7QpO2vLjM58loMQhP2Z9e6r3IrriSDP/AVvG/X5mnN5v
	087i9FqUTPO/dUCA==
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
Subject: [patch v4 25/27] posix-timers: Cleanup SIG_IGN workaround leftovers
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:49:09 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the relevant hacks and the not longer required return values from
the related functions. The alarm timer workarounds will be cleaned up in a
separate step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/posix-timers.h   |    2 -
 kernel/signal.c                |    3 -
 kernel/time/alarmtimer.c       |   47 +++++------------------------
 kernel/time/posix-cpu-timers.c |   18 ++---------
 kernel/time/posix-timers.c     |   65 +++--------------------------------------
 kernel/time/posix-timers.h     |    2 -
 6 files changed, 21 insertions(+), 116 deletions(-)
---
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -111,7 +111,7 @@ static inline void posix_cputimers_rt_wa
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_init_sigqueue(struct sigqueue *q);
-int posixtimer_send_sigqueue(struct k_itimer *tmr);
+void posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1964,7 +1964,7 @@ static inline struct task_struct *posixt
 	return t;
 }
 
-int posixtimer_send_sigqueue(struct k_itimer *tmr)
+void posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
 	struct sigqueue *q = &tmr->sigq;
 	int sig = q->info.si_signo;
@@ -2049,7 +2049,6 @@ int posixtimer_send_sigqueue(struct k_it
 	unlock_task_sighand(t, &flags);
 ret:
 	rcu_read_unlock();
-	return 0;
 }
 
 static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -197,28 +197,15 @@ static enum hrtimer_restart alarmtimer_f
 {
 	struct alarm *alarm = container_of(timer, struct alarm, timer);
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	unsigned long flags;
-	int ret = HRTIMER_NORESTART;
-	int restart = ALARMTIMER_NORESTART;
 
-	spin_lock_irqsave(&base->lock, flags);
-	alarmtimer_dequeue(base, alarm);
-	spin_unlock_irqrestore(&base->lock, flags);
+	scoped_guard (spinlock_irqsave, &base->lock)
+		alarmtimer_dequeue(base, alarm);
 
 	if (alarm->function)
-		restart = alarm->function(alarm, base->get_ktime());
-
-	spin_lock_irqsave(&base->lock, flags);
-	if (restart != ALARMTIMER_NORESTART) {
-		hrtimer_set_expires(&alarm->timer, alarm->node.expires);
-		alarmtimer_enqueue(base, alarm);
-		ret = HRTIMER_RESTART;
-	}
-	spin_unlock_irqrestore(&base->lock, flags);
+		alarm->function(alarm, base->get_ktime());
 
 	trace_alarmtimer_fired(alarm, base->get_ktime());
-	return ret;
-
+	return HRTIMER_NORESTART;
 }
 
 ktime_t alarm_expires_remaining(const struct alarm *alarm)
@@ -567,30 +554,14 @@ static enum alarmtimer_type clock2alarm(
  *
  * Return: whether the timer is to be restarted
  */
-static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
-							ktime_t now)
+static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm, ktime_t now)
 {
-	struct k_itimer *ptr = container_of(alarm, struct k_itimer,
-					    it.alarm.alarmtimer);
-	enum alarmtimer_restart result = ALARMTIMER_NORESTART;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ptr->it_lock, flags);
+	struct k_itimer *ptr = container_of(alarm, struct k_itimer, it.alarm.alarmtimer);
 
-	if (posix_timer_queue_signal(ptr) && ptr->it_interval) {
-		/*
-		 * Handle ignored signals and rearm the timer. This will go
-		 * away once we handle ignored signals proper. Ensure that
-		 * small intervals cannot starve the system.
-		 */
-		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
-		++ptr->it_signal_seq;
-		ptr->it_status = POSIX_TIMER_ARMED;
-		result = ALARMTIMER_RESTART;
-	}
-	spin_unlock_irqrestore(&ptr->it_lock, flags);
+	guard(spinlock_irqsave)(&ptr->it_lock);
+	posix_timer_queue_signal(ptr);
 
-	return result;
+	return ALARMTIMER_NORESTART;
 }
 
 /**
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -595,21 +595,11 @@ static void cpu_timer_fire(struct k_itim
 		 */
 		wake_up_process(timer->it_process);
 		cpu_timer_setexpires(ctmr, 0);
-	} else if (!timer->it_interval) {
-		/*
-		 * One-shot timer.  Clear it as soon as it's fired.
-		 */
+	} else {
 		posix_timer_queue_signal(timer);
-		cpu_timer_setexpires(ctmr, 0);
-	} else if (posix_timer_queue_signal(timer)) {
-		/*
-		 * The signal did not get queued because the signal
-		 * was ignored, so we won't get any callback to
-		 * reload the timer.  But we need to keep it
-		 * ticking in case the signal is deliverable next time.
-		 */
-		posix_cpu_timer_rearm(timer);
-		++timer->it_signal_seq;
+		/* Disable oneshot timers */
+		if (!timer->it_interval)
+			cpu_timer_setexpires(ctmr, 0);
 	}
 }
 
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -300,10 +300,9 @@ bool posixtimer_deliver_signal(struct ke
 	return ret;
 }
 
-int posix_timer_queue_signal(struct k_itimer *timr)
+void posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
 
@@ -313,9 +312,7 @@ int posix_timer_queue_signal(struct k_it
 	}
 	timr->it_status = state;
 
-	ret = posixtimer_send_sigqueue(timr);
-	/* If we failed to send the signal the timer stops. */
-	return ret > 0;
+	posixtimer_send_sigqueue(timr);
 }
 
 /*
@@ -328,62 +325,10 @@ int posix_timer_queue_signal(struct k_it
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
 	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
-	enum hrtimer_restart ret = HRTIMER_NORESTART;
-	unsigned long flags;
 
-	spin_lock_irqsave(&timr->it_lock, flags);
-
-	if (posix_timer_queue_signal(timr)) {
-		/*
-		 * The signal was not queued due to SIG_IGN. As a
-		 * consequence the timer is not going to be rearmed from
-		 * the signal delivery path. But as a real signal handler
-		 * can be installed later the timer must be rearmed here.
-		 */
-		if (timr->it_interval != 0) {
-			ktime_t now = hrtimer_cb_get_time(timer);
-
-			/*
-			 * FIXME: What we really want, is to stop this
-			 * timer completely and restart it in case the
-			 * SIG_IGN is removed. This is a non trivial
-			 * change to the signal handling code.
-			 *
-			 * For now let timers with an interval less than a
-			 * jiffy expire every jiffy and recheck for a
-			 * valid signal handler.
-			 *
-			 * This avoids interrupt starvation in case of a
-			 * very small interval, which would expire the
-			 * timer immediately again.
-			 *
-			 * Moving now ahead of time by one jiffy tricks
-			 * hrtimer_forward() to expire the timer later,
-			 * while it still maintains the overrun accuracy
-			 * for the price of a slight inconsistency in the
-			 * timer_gettime() case. This is at least better
-			 * than a timer storm.
-			 *
-			 * Only required when high resolution timers are
-			 * enabled as the periodic tick based timers are
-			 * automatically aligned to the next tick.
-			 */
-			if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS)) {
-				ktime_t kj = TICK_NSEC;
-
-				if (timr->it_interval < kj)
-					now = ktime_add(now, kj);
-			}
-
-			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
-			ret = HRTIMER_RESTART;
-			++timr->it_signal_seq;
-			timr->it_status = POSIX_TIMER_ARMED;
-		}
-	}
-
-	unlock_timer(timr, flags);
-	return ret;
+	guard(spinlock_irqsave)(&timr->it_lock);
+	posix_timer_queue_signal(timr);
+	return HRTIMER_NORESTART;
 }
 
 static struct pid *good_sigevent(sigevent_t * event)
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -42,7 +42,7 @@ extern const struct k_clock clock_proces
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
-int posix_timer_queue_signal(struct k_itimer *timr);
+void posix_timer_queue_signal(struct k_itimer *timr);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
 int common_timer_set(struct k_itimer *timr, int flags,


