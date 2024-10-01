Return-Path: <linux-kernel+bounces-345534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6D98B751
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC3B1C20B47
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0995719F120;
	Tue,  1 Oct 2024 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1h9501R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2x2JEmA3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B319E80A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772132; cv=none; b=Gyf2fDCXbqUWZhSpffcD/7nrMgaRs/aonIZQTX+/BB66XiozeXfQijOeElbplnjSlZbgvxJAkRzxP3Ht6RAdW7yC5mybMFaT8tXAiH4RuVfysYQCmAgO5AJpbvz9FU+RawUo8SiGJEa9KxxvALXcg1h6N42vdFIDSLU+coFF1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772132; c=relaxed/simple;
	bh=7cvYyslHnX2Jf275TKsBgbpcsrgLg3w2OAOMpNyZnqg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=V5BS+I1DZiiLSeTpzh8Bm6e90maBCjZihzjyOlUMS6CYXD1T97l9EfK5q2+NGzCkZpR4UiJFyIE6B8WvXTE+2UaKEfLP6VlT6qNDSUsJ5hp6n4N7EH2Nu1E6sKWIRrxYDNO+k/26aLjAORfHOjweD6xIMYYrnBAgBc1S3GwOZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1h9501R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2x2JEmA3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241001083835.611997737@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727772128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=d6JevVhVI/1VH0mDd9yh89FDebBHZv3TZQSw7wec8CU=;
	b=j1h9501RZ3TzQEfnOonf+mwKCiJkXKZpCRmtwqxM4fOS8Gi8e2j+Spl90eNpBWQgwNoSHd
	j7PUqgQv3ZfpqMu2KqPCIi+rwR9Rao+/UdQ0PePojIXoI1avpU02WYtWO5MBWmzizdgFGJ
	pKr2BP7yNCIhuopLkr2FYM4BZnLYnBKB3aVF1KnMxdlqYBHJRvRWjK0bQZVJtaTQxX0GSM
	PP2d75MFMWQDg4T8Pg5xs8sEHkPjfmtd4FxEjT1o4xQWlk8fuFJ+sfBoKgtvlKoRpvHntW
	hgeM6KTAWJYR1pKISoUtLZp/aWGc22o/GahUmmL2HjsfoJ89rDbPiFbHeZ8KrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727772128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=d6JevVhVI/1VH0mDd9yh89FDebBHZv3TZQSw7wec8CU=;
	b=2x2JEmA3R4kl2mI1FLbuRQaqcEcg1aD3qrJLzed/bGMcNQr7puTycupK25WIeQasXTQe4n
	M81BWu/ziALqnBCg==
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
Subject: [patch V5 06/26] posix-timers: Rename k_itimer::it_requeue_pending
References: <20241001083138.922192481@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Oct 2024 10:42:07 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Prepare for using this struct member to do a proper reprogramming and
deletion accounting so that stale signals can be dropped.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/posix-timers.h   |  5 ++---
 kernel/time/alarmtimer.c       |  2 +-
 kernel/time/posix-cpu-timers.c |  4 ++--
 kernel/time/posix-timers.c     | 12 ++++++------
 4 files changed, 11 insertions(+), 12 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 4ab49e5c42af..253d106fac2c 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -150,8 +150,7 @@ static inline void posix_cputimers_init_work(void) { }
  * @it_active:		Marker that timer is active
  * @it_overrun:		The overrun counter for pending signals
  * @it_overrun_last:	The overrun at the time of the last delivered signal
- * @it_requeue_pending:	Indicator that timer waits for being requeued on
- *			signal delivery
+ * @it_signal_seq:	Sequence count to control signal delivery
  * @it_sigev_notify:	The notify word of sigevent struct for signal delivery
  * @it_interval:	The interval for periodic timers
  * @it_signal:		Pointer to the creators signal struct
@@ -172,7 +171,7 @@ struct k_itimer {
 	int			it_active;
 	s64			it_overrun;
 	s64			it_overrun_last;
-	int			it_requeue_pending;
+	unsigned int		it_signal_seq;
 	int			it_sigev_notify;
 	ktime_t			it_interval;
 	struct signal_struct	*it_signal;
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 76bd4fda3472..22d5145dd9a7 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -584,7 +584,7 @@ static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
 		 * small intervals cannot starve the system.
 		 */
 		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
-		++ptr->it_requeue_pending;
+		++ptr->it_signal_seq;
 		ptr->it_active = 1;
 		result = ALARMTIMER_RESTART;
 	}
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 6bcee4704059..993243b5be98 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -608,7 +608,7 @@ static void cpu_timer_fire(struct k_itimer *timer)
 		 * ticking in case the signal is deliverable next time.
 		 */
 		posix_cpu_timer_rearm(timer);
-		++timer->it_requeue_pending;
+		++timer->it_signal_seq;
 	}
 }
 
@@ -745,7 +745,7 @@ static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *i
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && ((timer->it_requeue_pending & REQUEUE_PENDING) || sigev_none))
+	if (iv && ((timer->it_signal_seq & REQUEUE_PENDING) || sigev_none))
 		expires = bump_cpu_timer(timer, now);
 	else
 		expires = cpu_timer_getexpires(&timer->it.cpu);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b5d7e71c10f2..26243d38d27d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -269,13 +269,13 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 	if (!timr)
 		goto out;
 
-	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
+	if (timr->it_interval && timr->it_signal_seq == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_active = 1;
 		timr->it_overrun_last = timr->it_overrun;
 		timr->it_overrun = -1LL;
-		++timr->it_requeue_pending;
+		++timr->it_signal_seq;
 
 		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
@@ -299,7 +299,7 @@ int posix_timer_queue_signal(struct k_itimer *timr)
 
 	timr->it_active = 0;
 	if (timr->it_interval)
-		si_private = ++timr->it_requeue_pending;
+		si_private = ++timr->it_signal_seq;
 
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
 	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
@@ -366,7 +366,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 
 			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
 			ret = HRTIMER_RESTART;
-			++timr->it_requeue_pending;
+			++timr->it_signal_seq;
 			timr->it_active = 1;
 		}
 	}
@@ -667,7 +667,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
+	if (iv && (timr->it_signal_seq & REQUEUE_PENDING || sig_none))
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
@@ -868,7 +868,7 @@ void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_set
 		timer->it_interval = 0;
 
 	/* Prevent reloading in case there is a signal pending */
-	timer->it_requeue_pending = (timer->it_requeue_pending + 2) & ~REQUEUE_PENDING;
+	timer->it_signal_seq = (timer->it_signal_seq + 2) & ~REQUEUE_PENDING;
 	/* Reset overrun accounting */
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1LL;


