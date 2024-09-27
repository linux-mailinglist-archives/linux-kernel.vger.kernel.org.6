Return-Path: <linux-kernel+bounces-341483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC09880BB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B79EB2358B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD21B140F;
	Fri, 27 Sep 2024 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GxXjKeez";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/tDPDNKL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A395194138
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426934; cv=none; b=a62o2fDrNYxFNOWBqlydztZRzns8/VbfbK5gB19wQAH6IVWumsywzXLn+e66odD17V0aPsOiWU3/NIpur7H0K0tH2iRy76fsJhQAEwuw3raJLUAYDkWsEkWf18ZYRTStgW57MlVIhgTkdmCp+cFW45q0jpBDW2IWBWA2/+9LFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426934; c=relaxed/simple;
	bh=kcnbNFf0PqRgHjX+kLb8eKf2yoh61nkQKKITQrvCz+E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=E+5VaLQZmE6bdqQWUkZ84QNQALNNNbQiMp/A5einkF964rTWsRcx8+XensNv4USx499gTvuW5TeCOT2dKstrr0FkCpTkVh2qXjo4sPyLowScAA9ZqWd+p1GNmrVbqh0wZVRpybV8dfPa+Y2u4f+gSXgHLRIEcdwawzy2LtM0Ads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GxXjKeez; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/tDPDNKL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240927084817.449464642@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727426930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=S11ye5tLkZYHnPip+zXMdwlR8ANrj5PEcLf0WRbbImk=;
	b=GxXjKeezjSe0ico0FyVFThgbGB0cnTKGLO7xhu05KVXVqe8058B1m7dhE0CAm3Zp60Q81+
	sBHuBGRXTYdGqVk2iBqM5ED2bJp2fcdbi4XXZYUph9R6d3wqJQ8X0bhfm/HlZ1L5/dbxW5
	WsFShq4k/vYgj+Z+Ho/Ztv85IEeNu1ZJlfe+Og8WXSXNdsaaKmbWjc+Sr8iEDX4ZG2zFML
	t7zYbsZXq23LVkyiZLZpyREaHh2KGpUv1CWw0YQRQ8gfNthnRi4lZUYHIMJ6ZFhlQ1II9/
	cxzelcwORfCbJ0oZNH8j2Uvkmaonwu7Tqz8GkKJcrXKcTzrbPWkjsWf2lWLWYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727426930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=S11ye5tLkZYHnPip+zXMdwlR8ANrj5PEcLf0WRbbImk=;
	b=/tDPDNKLJ122BdU3KJ8pjVgq8+73Z/G1zm4LwPzNDm9LLJzUnx6e6USgRPjXV4Zh9Mmi5F
	06NzzYp11eQuVlAQ==
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
Subject: [patch v4 09/27] posix-timers: Make signal delivery consistent
References: <20240927083900.989915582@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Sep 2024 10:48:50 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Signals of timers which are reprogammed, disarmed or deleted can deliver
signals related to the past. The POSIX spec is blury about this:

 - "The effect of disarming or resetting a timer with pending expiration
   notifications is unspecified."

 - "The disposition of pending signals for the deleted timer is
    unspecified."

In both cases it is reasonable to expect that pending signals are
discarded. Especially in the reprogramming case it does not make sense to
account for previous overruns or to deliver a signal for a timer which has
been disarmed. This makes the behaviour consistent and understandable.

Remove the si_sys_private check from the signal delivery code and invoke
posix_timer_deliver_signal() unconditionally.

Change that function so it controls the actual signal delivery via the
return value. It now instructs the signal code to drop the signal when:

  1) The timer does not longer exist in the hash table

  2) The timer signal_seq value is not the same as the si_sys_private value
     which was set when the signal was queued.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

---
 include/linux/posix-timers.h   |  2 --
 kernel/signal.c                |  2 +-
 kernel/time/posix-cpu-timers.c |  2 +-
 kernel/time/posix-timers.c     | 25 +++++++++++++++----------
 4 files changed, 17 insertions(+), 14 deletions(-)
---
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 02afbb4da7f7..8c6d97412526 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -137,8 +137,6 @@ static inline void clear_posix_cputimers_work(struct task_struct *p) { }
 static inline void posix_cputimers_init_work(void) { }
 #endif
 
-#define REQUEUE_PENDING 1
-
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
  * @list:		List head for binding the timer to signals->posix_timers
diff --git a/kernel/signal.c b/kernel/signal.c
index c35b6ff52767..a407724f1267 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -617,7 +617,7 @@ int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 	}
 
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
-		if (unlikely(info->si_code == SI_TIMER && info->si_sys_private)) {
+		if (unlikely(info->si_code == SI_TIMER)) {
 			if (!posixtimer_deliver_signal(info))
 				goto again;
 		}
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 12f828d704b1..bc2cd32b7a40 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -746,7 +746,7 @@ static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *i
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && ((timer->it_signal_seq & REQUEUE_PENDING) || sigev_none))
+	if (iv && timer->it_status != POSIX_TIMER_ARMED)
 		expires = bump_cpu_timer(timer, now);
 	else
 		expires = cpu_timer_getexpires(&timer->it.cpu);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 6f0dacec25e0..1231efb7c30f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -269,7 +269,10 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 	if (!timr)
 		goto out;
 
-	if (timr->it_interval && timr->it_signal_seq == info->si_sys_private) {
+	if (timr->it_signal_seq != info->si_sys_private)
+		goto out_unlock;
+
+	if (timr->it_interval && timr->it_status == POSIX_TIMER_REQUEUE_PENDING) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_status = POSIX_TIMER_ARMED;
@@ -281,6 +284,7 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 	}
 	ret = true;
 
+out_unlock:
 	unlock_timer(timr, flags);
 out:
 	spin_lock(&current->sighand->siglock);
@@ -293,19 +297,19 @@ bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	int ret, si_private = 0;
 	enum pid_type type;
+	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
 
 	if (timr->it_interval) {
+		timr->it_signal_seq++;
 		state = POSIX_TIMER_REQUEUE_PENDING;
-		si_private = ++timr->it_signal_seq;
 	}
 	timr->it_status = state;
 
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -670,7 +674,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && (timr->it_signal_seq & REQUEUE_PENDING || sig_none))
+	if (iv && timr->it_status != POSIX_TIMER_ARMED)
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
@@ -870,8 +874,6 @@ void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_set
 	else
 		timer->it_interval = 0;
 
-	/* Prevent reloading in case there is a signal pending */
-	timer->it_signal_seq = (timer->it_signal_seq + 2) & ~REQUEUE_PENDING;
 	/* Reset overrun accounting */
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1LL;
@@ -889,8 +891,6 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	if (old_setting)
 		common_timer_get(timr, old_setting);
 
-	/* Prevent rearming by clearing the interval */
-	timr->it_interval = 0;
 	/*
 	 * Careful here. On SMP systems the timer expiry function could be
 	 * active and spinning on timr->it_lock.
@@ -940,6 +940,9 @@ static int do_timer_settime(timer_t timer_id, int tmr_flags,
 	if (old_spec64)
 		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
 
+	/* Prevent signal delivery and rearming. */
+	timr->it_signal_seq++;
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
@@ -1008,7 +1011,6 @@ int common_timer_del(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
 
-	timer->it_interval = 0;
 	if (kc->timer_try_to_cancel(timer) < 0)
 		return TIMER_RETRY;
 	timer->it_status = POSIX_TIMER_DISARMED;
@@ -1036,6 +1038,9 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 	if (!timer)
 		return -EINVAL;
 
+	/* Prevent signal delivery and rearming. */
+	timer->it_signal_seq++;
+
 	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
 		/* Unlocks and relocks the timer if it still exists */
 		timer = timer_wait_running(timer, &flags);


