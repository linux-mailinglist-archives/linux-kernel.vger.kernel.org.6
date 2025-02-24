Return-Path: <linux-kernel+bounces-529552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7231FA427B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E36169534
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD3B25A347;
	Mon, 24 Feb 2025 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iu6MLiF7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0DB1C7009
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414070; cv=none; b=EeMzBU7jyP0OWLMMPDuPIvzyuY7jZfNy8XcSxoP+xY/LMgZcef/C0lGRzSdD0IbfgRAKS6DttUM5cvukcXuggelZBzaNlJ/jjii5nlMlG7fR9Xsc4mHTQ9Jdl9CN8jmNXzGvlqEffsel4uT/4I++12CFvV6+S9yYyzTO9h0cxeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414070; c=relaxed/simple;
	bh=jIwb6dGWmuP0Yf4HpEXtQpY3/Ijx53O+VH2TtE/T3yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBb5m47YcP0Svr1SIIkimtLYE0dhj5adpdR0RcVgoxlp9koZsaO/rPDdjFqvyXnG6s0f8s21VC3CDp5ufOIkOnRZn0BFjHyL5jqYbnvJUu+g2rysLbCV6y6+F/wmNt+eJEyPCjbPxlNEMzQI7JAWOlEGBfQOztc3zFaSc6Y3xso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iu6MLiF7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D37+WCwOf1pVaNHTH3XhuobNoJeXcm98cYO3EfveS5Q=; b=iu6MLiF7cyy+dVPShcViLgMGHO
	fhmtboCbYwhrbKwDkeDWle9tzL378TVNoZCt/mhtS3xdLKDfRJrS1nhLVGzlBAmPg27d3gKGhOz7G
	mKpCufiPYEJ+3Ia0XtAjBaIFkHFNYTqoYtRVhVH2HE5xLWZIuGvFc+3sl/y+5DbqJ9s9SLvX7iInC
	KlbZUUekVaSzpu3A1YZJdmg83fc8ua8ybRdbLHb/DaifsBiC+KdDpBeAZrV2LzIWVCvRsnv9KdQvK
	ychXDUYCbaUdcrwP5IOsq2dQ0oBJgbfMBowJfBqmJyQ1K58DFli2cWInJau7QCoO3icnnX9cc3+PL
	lp0SZn1Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmbCb-00000007ixC-0N9O;
	Mon, 24 Feb 2025 16:21:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F38A6300756; Mon, 24 Feb 2025 17:21:03 +0100 (CET)
Date: Mon, 24 Feb 2025 17:21:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [patch 04/11] posix-timers: Remove pointless unlock_timer()
 wrapper
Message-ID: <20250224162103.GD11590@noisy.programming.kicks-ass.net>
References: <20250224095736.145530367@linutronix.de>
 <20250224101343.211872476@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224101343.211872476@linutronix.de>

On Mon, Feb 24, 2025 at 11:15:28AM +0100, Thomas Gleixner wrote:
> It's just a wrapper around spin_unlock_irqrestore() with zero value.

Well, I disagree... the value is that is matches lock_timer(). Both in
naming and in argument types.

Anyway, I started tinkering with the code, it's more hacky than I'd like
it to be, but what do you think?

---
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -74,6 +74,29 @@ static struct k_itimer *__lock_timer(tim
 	__timr;								   \
 })
 
+static inline void unlock_timer(struct k_itimer *timer, unsigned long flags)
+{
+	spin_unlock_irqrestore(&timer->it_lock, flags);
+}
+
+__DEFINE_CLASS_IS_CONDITIONAL(lock_timer, true);
+__DEFINE_UNLOCK_GUARD(lock_timer, struct k_itimer,
+		      unlock_timer(_T->lock, _T->flags),
+		      unsigned long flags);
+static inline class_lock_timer_t class_lock_timer_constructor(timer_t id)
+{
+	class_lock_timer_t _t = {
+		.lock = __lock_timer(id, &_t.flags),
+	};
+	return _t;
+}
+
+#define scoped_guard_end(_name) do {		\
+	class_##_name##_t *_T = &(scope);	\
+	class_##_name##_destructor(_T);		\
+	_T->lock = NULL;			\
+} while (0)
+
 static int hash(struct signal_struct *sig, unsigned int nr)
 {
 	return hash_32(hash32_ptr(sig) ^ nr, timer_hashbits);
@@ -327,14 +350,13 @@ bool posixtimer_deliver_signal(struct ke
 	 * Release siglock to ensure proper locking order versus
 	 * timr::it_lock. Keep interrupts disabled.
 	 */
-	spin_unlock(&current->sighand->siglock);
+	guard(spinlock)(&current->sighand->siglock);
 
 	ret = __posixtimer_deliver_signal(info, timr);
 
 	/* Drop the reference which was acquired when the signal was queued */
 	posixtimer_putref(timr);
 
-	spin_lock(&current->sighand->siglock);
 	return ret;
 }
 
@@ -717,24 +739,20 @@ void common_timer_get(struct k_itimer *t
 
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
-	const struct k_clock *kc;
-	struct k_itimer *timr;
-	unsigned long flags;
-	int ret = 0;
-
-	timr = lock_timer(timer_id, &flags);
-	if (!timr)
-		return -EINVAL;
+	scoped_guard (lock_timer, timer_id) {
+		struct k_itimer *timr = __guard_ptr(lock_timer)(&scope);
+		const struct k_clock *kc;
+
+		memset(setting, 0, sizeof(*setting));
+		kc = timr->kclock;
+		if (WARN_ON_ONCE(!kc || !kc->timer_get))
+			return -EINVAL;
 
-	memset(setting, 0, sizeof(*setting));
-	kc = timr->kclock;
-	if (WARN_ON_ONCE(!kc || !kc->timer_get))
-		ret = -EINVAL;
-	else
 		kc->timer_get(timr, setting);
+		return 0;
+	}
 
-	spin_unlock_irqrestore(&timr->it_lock, flags);
-	return ret;
+	return -EINVAL;
 }
 
 /* Get the time remaining on a POSIX.1b interval timer. */
@@ -788,18 +806,12 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t
  */
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {
-	struct k_itimer *timr;
-	unsigned long flags;
-	int overrun;
-
-	timr = lock_timer(timer_id, &flags);
-	if (!timr)
-		return -EINVAL;
-
-	overrun = timer_overrun_to_int(timr);
-	spin_unlock_irqrestore(&timr->it_lock, flags);
+	scoped_guard (lock_timer, timer_id) {
+		struct k_itimer *timr = __guard_ptr(lock_timer)(&scope);
 
-	return overrun;
+		return timer_overrun_to_int(timr);
+	}
+	return -EINVAL;
 }
 
 static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
@@ -855,15 +867,9 @@ static void common_timer_wait_running(st
  * when the task which tries to delete or disarm the timer has preempted
  * the task which runs the expiry in task work context.
  */
-static struct k_itimer *timer_wait_running(struct k_itimer *timer, unsigned long *flags,
-					   bool delete)
+static void timer_wait_running(struct k_itimer *timer)
 {
 	const struct k_clock *kc = READ_ONCE(timer->kclock);
-	timer_t timer_id = READ_ONCE(timer->it_id);
-
-	/* Prevent kfree(timer) after dropping the lock */
-	rcu_read_lock();
-	spin_unlock_irqrestore(&timer->it_lock, *flags);
 
 	/*
 	 * kc->timer_wait_running() might drop RCU lock. So @timer cannot
@@ -872,27 +878,6 @@ static struct k_itimer *timer_wait_runni
 	 */
 	if (!WARN_ON_ONCE(!kc->timer_wait_running))
 		kc->timer_wait_running(timer);
-
-	rcu_read_unlock();
-
-	/*
-	 * On deletion the timer has been marked invalid before
-	 * timer_delete_hook() has been invoked. That means that the
-	 * current task is the only one which has access to the timer and
-	 * even after dropping timer::it_lock above, no other thread can
-	 * have accessed the timer.
-	 */
-	if (delete) {
-		spin_lock_irqsave(&timer->it_lock, *flags);
-		return timer;
-	}
-
-	/*
-	 * If invoked from timer_set() the timer could have been deleted
-	 * after dropping the lock. So in that case the timer needs to be
-	 * looked up and validated.
-	 */
-	return lock_timer(timer_id, flags);
 }
 
 /*
@@ -952,8 +937,6 @@ static int do_timer_settime(timer_t time
 			    struct itimerspec64 *old_spec64)
 {
 	const struct k_clock *kc;
-	struct k_itimer *timr;
-	unsigned long flags;
 	int error;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
@@ -963,33 +946,35 @@ static int do_timer_settime(timer_t time
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 
-	timr = lock_timer(timer_id, &flags);
 retry:
-	if (!timr)
-		return -EINVAL;
+	scoped_guard (lock_timer, timer_id) {
+		struct k_itimer *timr = __guard_ptr(lock_timer)(&scope);
 
-	if (old_spec64)
-		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
+		if (old_spec64)
+			old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
 
-	/* Prevent signal delivery and rearming. */
-	timr->it_signal_seq++;
+		/* Prevent signal delivery and rearming. */
+		timr->it_signal_seq++;
+
+		kc = timr->kclock;
+		if (WARN_ON_ONCE(!kc || !kc->timer_set))
+			return -EINVAL;
 
-	kc = timr->kclock;
-	if (WARN_ON_ONCE(!kc || !kc->timer_set))
-		error = -EINVAL;
-	else
 		error = kc->timer_set(timr, tmr_flags, new_spec64, old_spec64);
+		if (error == TIMER_RETRY) {
+			// We already got the old time...
+			old_spec64 = NULL;
+			/* Unlocks and relocks the timer if it still exists */
+
+			guard(rcu)();
+			scoped_guard_end(lock_timer);
+			timer_wait_running(timr);
+			goto retry;
+		}
 
-	if (error == TIMER_RETRY) {
-		// We already got the old time...
-		old_spec64 = NULL;
-		/* Unlocks and relocks the timer if it still exists */
-		timr = timer_wait_running(timr, &flags, false);
-		goto retry;
+		return error;
 	}
-	spin_unlock_irqrestore(&timr->it_lock, flags);
-
-	return error;
+	return -EINVAL;
 }
 
 /* Set a POSIX.1b interval timer */
@@ -1072,18 +1057,8 @@ static inline int timer_delete_hook(stru
 	return kc->timer_del(timer);
 }
 
-static int posix_timer_delete(struct k_itimer *timer, timer_t id)
+static void posix_timer_invalidate(struct k_itimer *timer, unsigned long flags)
 {
-	unsigned long flags;
-
-	if (!timer) {
-		timer = lock_timer(id, &flags);
-		if (!timer)
-			return -EINVAL;
-	} else {
-		spin_lock_irqsave(&timer->it_lock, flags);
-	}
-
 	/*
 	 * Invalidate the timer, remove it from the linked list and remove
 	 * it from the ignored list if pending.
@@ -1115,19 +1090,23 @@ static int posix_timer_delete(struct k_i
 		 * delete possible after unlocking the timer as the timer
 		 * has been marked invalid above.
 		 */
-		timer_wait_running(timer, &flags, true);
+		guard(rcu)();
+		spin_unlock_irqrestore(&timer->it_lock, flags);
+		timer_wait_running(timer);
+		spin_lock_irqsave(&timer->it_lock, flags);
 	}
-
-	spin_unlock_irqrestore(&timer->it_lock, flags);
-	/* Remove it from the hash, which frees up the timer ID */
-	posix_timer_unhash_and_free(timer);
-	return 0;
 }
 
 /* Delete a POSIX.1b interval timer. */
 SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 {
-	return posix_timer_delete(NULL, timer_id);
+	scoped_guard (lock_timer, timer_id) {
+		posix_timer_invalidate(scope.lock, scope.flags);
+		scoped_guard_end(lock_timer);
+		posix_timer_unhash_and_free(scope.lock);
+		return 0;
+	}
+	return -EINVAL;
 }
 
 /*
@@ -1143,13 +1122,17 @@ void exit_itimers(struct task_struct *ts
 		return;
 
 	/* Protect against concurrent read via /proc/$PID/timers */
-	spin_lock_irq(&tsk->sighand->siglock);
-	hlist_move_list(&tsk->signal->posix_timers, &timers);
-	spin_unlock_irq(&tsk->sighand->siglock);
+	scoped_guard (spinlock_irq, &tsk->sighand->siglock)
+		hlist_move_list(&tsk->signal->posix_timers, &timers);
 
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers)) {
-		posix_timer_delete(hlist_entry(timers.first, struct k_itimer, list), 0);
+		struct k_itimer *timer = hlist_entry(timers.first, struct k_itimer, list);
+
+		scoped_guard (spinlock_irqsave, &timer->it_lock)
+			posix_timer_invalidate(timer, scope.flags);
+
+		posix_timer_unhash_and_free(timer);
 		cond_resched();
 	}
 

