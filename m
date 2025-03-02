Return-Path: <linux-kernel+bounces-540746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A192CA4B475
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADFA18918E3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91CD1EF0B7;
	Sun,  2 Mar 2025 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fl2XLSYk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cacJ0U03"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2F1EF09B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944220; cv=none; b=Gi9PH41C5nWoPEHti+YGAmj6dX5iOJjSIyO+dranYB+0Qn20/g+Ik8vfvfS2GSiFYEuGPnCwnrX1Xn5yQJcvuC340fmFEWjbOh7J8x6f2k3hRC1v2vITfwAKb4lBTgcCTKkw/CYt1MUYw3qOjpdLhe9YTQUGGjQFZA8xaDu8uWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944220; c=relaxed/simple;
	bh=vR/TzYQakpYs1sHXKlUvtCoII5mBGoIDBKvXRHmj4mc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PkIKL7WFl9QYYwIKBKKAmmqXD5aVsswCmn+OMqMm8lTMJ9g5N16ZhGGcu/ieIjm2wc4QqMFARM5uYYW7D7rJPpMFjc1Pwa5JLis5kKR+DOooa2VC9nxVFMbLxgzLrpZXd3sMcxv5MjZl70/zqxvdONsk0HzzdlTqGA/qlP43iDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fl2XLSYk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cacJ0U03; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.416552300@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gPOW6XpJD24jD66AeI2zsMmm3AcWYl09YPLa3iWKVj8=;
	b=fl2XLSYkJRrJMckb94PNHO2vWwCfMagJ4WkvRsw0yiUsgl21LPCgCD1pDEGoDzfMDLxjbr
	f5I17aDXWGBqVewAAqD5TbjxFMDYb/KMvGyBZtK1v8Hvc9D8ROwQV618A2guu7mFu38z8V
	wgX+0QhOHytS1ciquZ3IYEgPusnAprf9HnDIsqh3enyRGrYSD8cMOZFLSZ8X6qFyby0B8e
	qMYGT8GyPxQ5iBKZgLo+LDMfXISp5RNF1KD+oXu6gRquP4FSc43Ss3Lxa6vhaUsPnm6wKX
	ph4jdAL8chhoarSmVph78ADEU9CddL0jQ412D21+r//lKPyM6Ned64XGpb+jIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gPOW6XpJD24jD66AeI2zsMmm3AcWYl09YPLa3iWKVj8=;
	b=cacJ0U03Mf6Mzalb1oDc3xmLDaJQ9VzcjvJTxHE04TS7Qx6m8b8JMtNI/6FYviMQ8qN/v3
	cceNyoo8cpvmpPCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 08/17] posix-timers: Rework timer removal
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:36:56 +0100 (CET)

sys_timer_delete() and the do_exit() cleanup function itimer_delete() are
doing the same thing, but have needlessly different implementations instead
of sharing the code.

The other oddity of timer deletion is the fact that the timer is not
invalidated before the actual deletion happens, which allows concurrent
lookups to succeed.

That's wrong because a timer which is in the process of being deleted
should not be visible and any actions like signal queueing, delivery and
rearming should not happen once the task, which invoked timer_delete(), has
the timer locked.

Rework the code so that:

   1) The signal queueing and delivery code ignore timers which are marked
      invalid

   2) The deletion implementation between sys_timer_delete() and
      itimer_delete() is shared

   3) The timer is invalidated and removed from the linked lists before
      the deletion callback of the relevant clock is invoked.

      That requires to rework timer_wait_running() as it does a lookup of
      the timer when relocking it at the end. In case of deletion this
      lookup would fail due to the preceding invalidation and the wait loop
      would terminate prematurely.

      But due to the preceding invalidation the timer cannot be accessed by
      other tasks anymore, so there is no way that the timer has been freed
      after the timer lock has been dropped.

      Move the re-validation out of timer_wait_running() and handle it at
      the only other usage site, timer_settime().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Simplify timer_wait_running() locking - PeterZ
---
 include/linux/posix-timers.h |    7 +
 kernel/signal.c              |    2 
 kernel/time/posix-timers.c   |  194 ++++++++++++++++++-------------------------
 3 files changed, 90 insertions(+), 113 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -240,6 +240,13 @@ static inline void posixtimer_sigqueue_p
 
 	posixtimer_putref(tmr);
 }
+
+static inline bool posixtimer_valid(const struct k_itimer *timer)
+{
+	unsigned long val = (unsigned long)timer->it_signal;
+
+	return !(val & 0x1UL);
+}
 #else  /* CONFIG_POSIX_TIMERS */
 static inline void posixtimer_sigqueue_getref(struct sigqueue *q) { }
 static inline void posixtimer_sigqueue_putref(struct sigqueue *q) { }
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2092,7 +2092,7 @@ static inline void posixtimer_sig_ignore
 	 * from a non-periodic timer, then just drop the reference
 	 * count. Otherwise queue it on the ignored list.
 	 */
-	if (tmr->it_signal && tmr->it_sig_periodic)
+	if (posixtimer_valid(tmr) && tmr->it_sig_periodic)
 		hlist_add_head(&tmr->ignored_list, &tsk->signal->ignored_posix_timers);
 	else
 		posixtimer_putref(tmr);
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -279,7 +279,7 @@ static bool __posixtimer_deliver_signal(
 	 * since the signal was queued. In either case, don't rearm and
 	 * drop the signal.
 	 */
-	if (timr->it_signal_seq != timr->it_sigqueue_seq || WARN_ON_ONCE(!timr->it_signal))
+	if (timr->it_signal_seq != timr->it_sigqueue_seq || !posixtimer_valid(timr))
 		return false;
 
 	if (!timr->it_interval || WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING))
@@ -324,6 +324,9 @@ void posix_timer_queue_signal(struct k_i
 {
 	lockdep_assert_held(&timr->it_lock);
 
+	if (!posixtimer_valid(timr))
+		return;
+
 	timr->it_status = timr->it_interval ? POSIX_TIMER_REQUEUE_PENDING : POSIX_TIMER_DISARMED;
 	posixtimer_send_sigqueue(timr);
 }
@@ -546,11 +549,11 @@ static struct k_itimer *__lock_timer(tim
 	 * The hash lookup and the timers are RCU protected.
 	 *
 	 * Timers are added to the hash in invalid state where
-	 * timr::it_signal == NULL. timer::it_signal is only set after the
-	 * rest of the initialization succeeded.
+	 * timr::it_signal is marked invalid. timer::it_signal is only set
+	 * after the rest of the initialization succeeded.
 	 *
 	 * Timer destruction happens in steps:
-	 *  1) Set timr::it_signal to NULL with timr::it_lock held
+	 *  1) Set timr::it_signal marked invalid with timr::it_lock held
 	 *  2) Release timr::it_lock
 	 *  3) Remove from the hash under hash_lock
 	 *  4) Put the reference count.
@@ -567,8 +570,8 @@ static struct k_itimer *__lock_timer(tim
 	 *
 	 * The lookup validates locklessly that timr::it_signal ==
 	 * current::it_signal and timr::it_id == @timer_id. timr::it_id
-	 * can't change, but timr::it_signal becomes NULL during
-	 * destruction.
+	 * can't change, but timr::it_signal can become invalid during
+	 * destruction, which makes the locked check fail.
 	 */
 	guard(rcu)();
 	timr = posix_timer_by_id(timer_id);
@@ -804,22 +807,13 @@ static void common_timer_wait_running(st
  * when the task which tries to delete or disarm the timer has preempted
  * the task which runs the expiry in task work context.
  */
-static struct k_itimer *timer_wait_running(struct k_itimer *timer)
+static void timer_wait_running(struct k_itimer *timer)
 {
-	timer_t timer_id = READ_ONCE(timer->it_id);
-
-	/* Prevent kfree(timer) after dropping the lock */
-	scoped_guard (rcu) {
-		unlock_timer(timer);
-		/*
-		 * kc->timer_wait_running() might drop RCU lock. So @timer
-		 * cannot be touched anymore after the function returns!
-		 */
-		timer->kclock->timer_wait_running(timer);
-	}
-
-	/* Relock the timer. It might be not longer hashed. */
-	return lock_timer(timer_id);
+	/*
+	 * kc->timer_wait_running() might drop RCU lock. So @timer
+	 * cannot be touched anymore after the function returns!
+	 */
+	timer->kclock->timer_wait_running(timer);
 }
 
 /*
@@ -878,8 +872,7 @@ static int do_timer_settime(timer_t time
 			    struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
-	struct k_itimer *timr;
-	int error;
+	int ret;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
 	    !timespec64_valid(&new_spec64->it_value))
@@ -888,29 +881,36 @@ static int do_timer_settime(timer_t time
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 
-	timr = lock_timer(timer_id);
-retry:
-	if (!timr)
-		return -EINVAL;
+	for (;;) {
+		struct k_itimer *timr = lock_timer(timer_id);
 
-	if (old_spec64)
-		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
+		if (!timr)
+			return -EINVAL;
 
-	/* Prevent signal delivery and rearming. */
-	timr->it_signal_seq++;
+		if (old_spec64)
+			old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
 
-	error = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
+		/* Prevent signal delivery and rearming. */
+		timr->it_signal_seq++;
+
+		ret = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
+		if (ret != TIMER_RETRY) {
+			unlock_timer(timr);
+			break;
+		}
 
-	if (error == TIMER_RETRY) {
-		// We already got the old time...
+		/* Read the old time only once */
 		old_spec64 = NULL;
-		/* Unlocks and relocks the timer if it still exists */
-		timr = timer_wait_running(timr);
-		goto retry;
+		/* Protect the timer from being freed after the lock is dropped */
+		guard(rcu)();
+		unlock_timer(timr);
+		/*
+		 * timer_wait_running() might drop RCU read side protection
+		 * so the timer has to be looked up again!
+		 */
+		timer_wait_running(timr);
 	}
-	unlock_timer(timr);
-
-	return error;
+	return ret;
 }
 
 /* Set a POSIX.1b interval timer */
@@ -981,90 +981,56 @@ static inline void posix_timer_cleanup_i
 	}
 }
 
-/* Delete a POSIX.1b interval timer. */
-SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
+static void posix_timer_delete(struct k_itimer *timer)
 {
-	struct k_itimer *timer = lock_timer(timer_id);
-
-retry_delete:
-	if (!timer)
-		return -EINVAL;
-
-	/* Prevent signal delivery and rearming. */
+	/*
+	 * Invalidate the timer, remove it from the linked list and remove
+	 * it from the ignored list if pending.
+	 *
+	 * The invalidation must be written with siglock held so that the
+	 * signal code observes timer->it_valid == false in do_sigaction(),
+	 * which prevents it from moving a pending signal of a deleted
+	 * timer to the ignore list.
+	 *
+	 * The invalidation also prevents signal queueing, signal delivery
+	 * and therefore rearming from the signal delivery path.
+	 *
+	 * A concurrent lookup can still find the timer in the hash, but it
+	 * will check timer::it_signal with timer::it_lock held and observe
+	 * bit 0 set, which invalidates it. That also prevents the timer ID
+	 * from being handed out before this timer is completely gone.
+	 */
 	timer->it_signal_seq++;
 
-	if (unlikely(timer->kclock->timer_del(timer) == TIMER_RETRY)) {
-		/* Unlocks and relocks the timer if it still exists */
-		timer = timer_wait_running(timer);
-		goto retry_delete;
-	}
-
 	scoped_guard (spinlock, &current->sighand->siglock) {
+		unsigned long sig = (unsigned long)timer->it_signal | 1UL;
+
+		WRITE_ONCE(timer->it_signal, (struct signal_struct *)sig);
 		hlist_del(&timer->list);
 		posix_timer_cleanup_ignored(timer);
-		/*
-		 * A concurrent lookup could check timer::it_signal lockless. It
-		 * will reevaluate with timer::it_lock held and observe the NULL.
-		 *
-		 * It must be written with siglock held so that the signal code
-		 * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
-		 * which prevents it from moving a pending signal of a deleted
-		 * timer to the ignore list.
-		 */
-		WRITE_ONCE(timer->it_signal, NULL);
 	}
 
-	unlock_timer(timer);
-	posix_timer_unhash_and_free(timer);
-	return 0;
+	while (timer->kclock->timer_del(timer) == TIMER_RETRY) {
+		guard(rcu)();
+		spin_unlock_irq(&timer->it_lock);
+		timer_wait_running(timer);
+		spin_lock_irq(&timer->it_lock);
+	}
 }
 
-/*
- * Delete a timer if it is armed, remove it from the hash and schedule it
- * for RCU freeing.
- */
-static void itimer_delete(struct k_itimer *timer)
+/* Delete a POSIX.1b interval timer. */
+SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 {
-	spin_lock_irq(&timer->it_lock);
-
-retry_delete:
-	/*
-	 * Even if the timer is not longer accessible from other tasks
-	 * it still might be armed and queued in the underlying timer
-	 * mechanism. Worse, that timer mechanism might run the expiry
-	 * function concurrently.
-	 */
-	if (timer->kclock->timer_del(timer) == TIMER_RETRY) {
-		/*
-		 * Timer is expired concurrently, prevent livelocks
-		 * and pointless spinning on RT.
-		 *
-		 * timer_wait_running() drops timer::it_lock, which opens
-		 * the possibility for another task to delete the timer.
-		 *
-		 * That's not possible here because this is invoked from
-		 * do_exit() only for the last thread of the thread group.
-		 * So no other task can access and delete that timer.
-		 */
-		if (WARN_ON_ONCE(timer_wait_running(timer) != timer))
-			return;
-
-		goto retry_delete;
-	}
-	hlist_del(&timer->list);
-
-	posix_timer_cleanup_ignored(timer);
+	struct k_itimer *timer = lock_timer(timer_id);
 
-	/*
-	 * Setting timer::it_signal to NULL is technically not required
-	 * here as nothing can access the timer anymore legitimately via
-	 * the hash table. Set it to NULL nevertheless so that all deletion
-	 * paths are consistent.
-	 */
-	WRITE_ONCE(timer->it_signal, NULL);
+	if (!timer)
+		return -EINVAL;
 
-	spin_unlock_irq(&timer->it_lock);
+	posix_timer_delete(timer);
+	unlock_timer(timer);
+	/* Remove it from the hash, which frees up the timer ID */
 	posix_timer_unhash_and_free(timer);
+	return 0;
 }
 
 /*
@@ -1075,6 +1041,8 @@ static void itimer_delete(struct k_itime
 void exit_itimers(struct task_struct *tsk)
 {
 	struct hlist_head timers;
+	struct hlist_node *next;
+	struct k_itimer *timer;
 
 	if (hlist_empty(&tsk->signal->posix_timers))
 		return;
@@ -1084,8 +1052,10 @@ void exit_itimers(struct task_struct *ts
 		hlist_move_list(&tsk->signal->posix_timers, &timers);
 
 	/* The timers are not longer accessible via tsk::signal */
-	while (!hlist_empty(&timers)) {
-		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+	hlist_for_each_entry_safe(timer, next, &timers, list) {
+		scoped_guard (spinlock_irq, &timer->it_lock)
+			posix_timer_delete(timer);
+		posix_timer_unhash_and_free(timer);
 		cond_resched();
 	}
 


