Return-Path: <linux-kernel+bounces-396085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A09BC7C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C18B282288
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EE91FF60F;
	Tue,  5 Nov 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w+r8dhK+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zVnc00xJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD201FF037
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794476; cv=none; b=rl/35HB5GXVnoEeX7zC6tk2WyBmJ9EbDLfgLIIK5g6wDCaa2twSzALOQp9gRPTMA3SfXAAK+F/qVkVoOpvAdcSuNVp682KaGYXwJNC0j8Hl5LMVIMrfT/pIUZ4eodKra6BIDT1PqF+Yz3ysJ0dCsuwut5PsgdMMr0/FkOuJptwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794476; c=relaxed/simple;
	bh=Q6pXf5V3j8nQ9045nPm1TJ3cU53VkCYCSiipo6ErkQM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=G+n8aO0bH+grPbB3ehaCJ4E4ZQ8mnp7XauLqk/ugaPLzaS4BW6AUDaUlJVpvujuI9Fq9L984A+6eFTgFKmIPQBvb8k/gEVdSUd9FqhlVn2d2BLUDNvWcYZeHtndjv1usHI215xt9dXPlSW7dEQMkCvsl7A/ZWmAZ7UAE62L0xcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w+r8dhK+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zVnc00xJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064213.040348644@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=OW8kSbrudqsAE1VCv/WIGxwxA4XCByyu9C/jff+AjFQ=;
	b=w+r8dhK+FjqY2EApZHVS5DeXlWT2mJkuv665Y5vzj1CfIspZiRAwKN3xNMSIPB6Qf9IVLP
	SvsKjanhUMENG/cPELBakvMtYBAi6B5Sf50yNxewMzqzOPx1pB2LAlW9vrMtOjXUAadMlR
	f4hgNClqc6QgdM2JQDdauF5tQOs4KDu1MoFFyGzvdJEswOh3wCjDNfPaKowq3I309xJrA6
	prIgkE/m41d60+xlNuHDjJFe92x2rj+Q35RVwnOPW8a0WxF8KTktgw2Kbwtq1bkEQXT8eE
	Y1MUxxzj3RK9l/KPBPfYLWigQYM6hrMH7IYZ6WN5qU4W0fdSR9e76fGeW6dHYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=OW8kSbrudqsAE1VCv/WIGxwxA4XCByyu9C/jff+AjFQ=;
	b=zVnc00xJttgYwphMfk70rYSL3NJl2WlbQG/v81i7mzDN/Ge5EhcyOLbwH2sylaITNI1KY0
	OIZa3wb43oC64yDQ==
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
Subject: [patch V7 02/21] posix-timers: Make signal delivery consistent
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:31 +0100 (CET)

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
posix_timer_deliver_signal() unconditionally for posix timer related
signals.

Change posix_timer_deliver_signal() so it controls the actual signal
delivery via the return value. It now instructs the signal code to drop the
signal when:

  1) The timer does not longer exist in the hash table

  2) The timer signal_seq value is not the same as the si_sys_private value
     which was set when the signal was queued.

This is also a preparatory change to embed the sigqueue into the k_itimer
structure, which in turn allows to remove the si_sys_private magic.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
V6: Remove the sequence increment from delivery and turn the requeue
    pending check into a WARN_ON_ONCE() (Frederic)
    Move the sequence increment into the delete hook so that the exit
    cleanup path is covered too
---
 include/linux/posix-timers.h   |    2 --
 kernel/signal.c                |    6 ++----
 kernel/time/posix-cpu-timers.c |    2 +-
 kernel/time/posix-timers.c     |   28 ++++++++++++++++------------
 4 files changed, 19 insertions(+), 19 deletions(-)
---

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -137,8 +137,6 @@ static inline void clear_posix_cputimers
 static inline void posix_cputimers_init_work(void) { }
 #endif
 
-#define REQUEUE_PENDING 1
-
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
  * @list:		List head for binding the timer to signals->posix_timers
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -550,10 +550,8 @@ static void collect_signal(int sig, stru
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
 
-		*resched_timer =
-			(first->flags & SIGQUEUE_PREALLOC) &&
-			(info->si_code == SI_TIMER) &&
-			(info->si_sys_private);
+		*resched_timer = (first->flags & SIGQUEUE_PREALLOC) &&
+				 (info->si_code == SI_TIMER);
 
 		__sigqueue_free(first);
 	} else {
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -746,7 +746,7 @@ static void __posix_cpu_timer_get(struct
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && ((timer->it_signal_seq & REQUEUE_PENDING) || sigev_none))
+	if (iv && timer->it_status != POSIX_TIMER_ARMED)
 		expires = bump_cpu_timer(timer, now);
 	else
 		expires = cpu_timer_getexpires(&timer->it.cpu);
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -269,7 +269,10 @@ bool posixtimer_deliver_signal(struct ke
 	if (!timr)
 		goto out;
 
-	if (timr->it_interval && timr->it_signal_seq == info->si_sys_private) {
+	if (timr->it_signal_seq != info->si_sys_private)
+		goto out_unlock;
+
+	if (timr->it_interval && !WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING)) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_status = POSIX_TIMER_ARMED;
@@ -281,6 +284,7 @@ bool posixtimer_deliver_signal(struct ke
 	}
 	ret = true;
 
+out_unlock:
 	unlock_timer(timr, flags);
 out:
 	spin_lock(&current->sighand->siglock);
@@ -293,19 +297,18 @@ bool posixtimer_deliver_signal(struct ke
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	int ret, si_private = 0;
 	enum pid_type type;
+	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
 
-	if (timr->it_interval) {
+	if (timr->it_interval)
 		state = POSIX_TIMER_REQUEUE_PENDING;
-		si_private = ++timr->it_signal_seq;
-	}
+
 	timr->it_status = state;
 
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -663,7 +666,7 @@ void common_timer_get(struct k_itimer *t
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && (timr->it_signal_seq & REQUEUE_PENDING || sig_none))
+	if (iv && timr->it_status != POSIX_TIMER_ARMED)
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
@@ -863,8 +866,6 @@ void posix_timer_set_common(struct k_iti
 	else
 		timer->it_interval = 0;
 
-	/* Prevent reloading in case there is a signal pending */
-	timer->it_signal_seq = (timer->it_signal_seq + 2) & ~REQUEUE_PENDING;
 	/* Reset overrun accounting */
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1LL;
@@ -882,8 +883,6 @@ int common_timer_set(struct k_itimer *ti
 	if (old_setting)
 		common_timer_get(timr, old_setting);
 
-	/* Prevent rearming by clearing the interval */
-	timr->it_interval = 0;
 	/*
 	 * Careful here. On SMP systems the timer expiry function could be
 	 * active and spinning on timr->it_lock.
@@ -933,6 +932,9 @@ static int do_timer_settime(timer_t time
 	if (old_spec64)
 		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
 
+	/* Prevent signal delivery and rearming. */
+	timr->it_signal_seq++;
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
@@ -1001,7 +1003,6 @@ int common_timer_del(struct k_itimer *ti
 {
 	const struct k_clock *kc = timer->kclock;
 
-	timer->it_interval = 0;
 	if (kc->timer_try_to_cancel(timer) < 0)
 		return TIMER_RETRY;
 	timer->it_status = POSIX_TIMER_DISARMED;
@@ -1012,6 +1013,9 @@ static inline int timer_delete_hook(stru
 {
 	const struct k_clock *kc = timer->kclock;
 
+	/* Prevent signal delivery and rearming. */
+	timer->it_signal_seq++;
+
 	if (WARN_ON_ONCE(!kc || !kc->timer_del))
 		return -EINVAL;
 	return kc->timer_del(timer);


