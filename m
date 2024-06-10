Return-Path: <linux-kernel+bounces-208595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B566B902705
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F9D280D62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE2149C76;
	Mon, 10 Jun 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRMrCzxu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOw92IZ2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1918156C68
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037768; cv=none; b=qvm4+liZyd9r9vF9tTBND8trao76Wo9TiUHVdOJTjQ4DkkNi+LkvpyjpIO4SZwUTb1C2eCIWQrcTT+HAsNlRlqTPlat3BvRfCWgzJHwhC35pigfdywIwwPMMFQg6Ve9yk+mRmE0HUQ0h+YZMDruj54tDpnu3MA+VUhp7l0ThgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037768; c=relaxed/simple;
	bh=QRAMzsqKtG3Z4cwj9EcqM7O3sI1tPeIJIx+RIdoHDh8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=izu7QqNj3XLGAHcZgFkjel+MQhSbK0qZQNoebpGmTKrwcgmyDa+bNilhxZOOJs2AxG04qtoNhnnCVRE7m5szWSXhFMDdFa3asxWv8D8KfxWOp3cvxM7PI3aeYM90zutazulRM3dDYGX/PgUVOHj/NUG2sA9lfwyvJ3e89n7t3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRMrCzxu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOw92IZ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.425643445@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4ZXhSygM4HMfUyJQFe7w4Q0s7qUUsNDQCaN6Cvt7YM4=;
	b=XRMrCzxuHVv8T1piULp8/g6QEio0bWKkSHl/qbw/ZVRwVh38jNoDPkwqQ3aC/jzpredshu
	4B6UGIGytwY5QVieY/0GoX0s3UP5c3t6puLvLNqx7kUkLNejXlSAonFTuYBjjVIil+Tgf9
	OTDf95AGbpEF3OzK9Cpl1hhnIXJZIhXyyvIEvPWkA5atK8uIrhJZ1Z+LJpy7ZbiYnikgFJ
	44eWoasghQDiWyGnGVD1WkwdFUU4m28Ik5ZGLqyIm5u/reb1nTZ8d5bpj44hrRnYomaSQh
	eLdFx53WD6dgSzAfkoxzf2vzs5GgDTUtIl53xBxbBJX3aZJpIayF7187pTDMhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4ZXhSygM4HMfUyJQFe7w4Q0s7qUUsNDQCaN6Cvt7YM4=;
	b=sOw92IZ2rsXuXlU4pgFe37DXa9GubkCmxlEQpb/vgVfKj5kF7y+RXNR8UGIW7dn9+IIKM1
	L6nV+1/4as3sK2Dg==
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
Subject: [patch V3 31/51] posix-timers: Rename k_itimer::it_requeue_pending
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:43 +0200 (CEST)

Prepare for using this struct member to do a proper reprogramming and
deletion accounting so that stale signals can be dropped.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    5 ++---
 kernel/time/alarmtimer.c       |    2 +-
 kernel/time/posix-cpu-timers.c |    4 ++--
 kernel/time/posix-timers.c     |   12 ++++++------
 4 files changed, 11 insertions(+), 12 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -150,8 +150,7 @@ static inline void posix_cputimers_init_
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
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -584,7 +584,7 @@ static enum alarmtimer_restart alarm_han
 		 * small intervals cannot starve the system.
 		 */
 		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
-		++ptr->it_requeue_pending;
+		++ptr->it_signal_seq;
 		ptr->it_active = 1;
 		result = ALARMTIMER_RESTART;
 	}
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -608,7 +608,7 @@ static void cpu_timer_fire(struct k_itim
 		 * ticking in case the signal is deliverable next time.
 		 */
 		posix_cpu_timer_rearm(timer);
-		++timer->it_requeue_pending;
+		++timer->it_signal_seq;
 	}
 }
 
@@ -745,7 +745,7 @@ static void __posix_cpu_timer_get(struct
 	 *  - Timers which expired, but the signal has not yet been
 	 *    delivered
 	 */
-	if (iv && ((timer->it_requeue_pending & REQUEUE_PENDING) || sigev_none))
+	if (iv && ((timer->it_signal_seq & REQUEUE_PENDING) || sigev_none))
 		expires = bump_cpu_timer(timer, now);
 	else
 		expires = cpu_timer_getexpires(&timer->it.cpu);
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -269,13 +269,13 @@ bool posixtimer_deliver_signal(struct ke
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
@@ -299,7 +299,7 @@ int posix_timer_queue_signal(struct k_it
 
 	timr->it_active = 0;
 	if (timr->it_interval)
-		si_private = ++timr->it_requeue_pending;
+		si_private = ++timr->it_signal_seq;
 
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
 	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
@@ -366,7 +366,7 @@ static enum hrtimer_restart posix_timer_
 
 			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
 			ret = HRTIMER_RESTART;
-			++timr->it_requeue_pending;
+			++timr->it_signal_seq;
 			timr->it_active = 1;
 		}
 	}
@@ -667,7 +667,7 @@ void common_timer_get(struct k_itimer *t
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
+	if (iv && (timr->it_signal_seq & REQUEUE_PENDING || sig_none))
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
@@ -868,7 +868,7 @@ void posix_timer_set_common(struct k_iti
 		timer->it_interval = 0;
 
 	/* Prevent reloading in case there is a signal pending */
-	timer->it_requeue_pending = (timer->it_requeue_pending + 2) & ~REQUEUE_PENDING;
+	timer->it_signal_seq = (timer->it_signal_seq + 2) & ~REQUEUE_PENDING;
 	/* Reset overrun accounting */
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1LL;


