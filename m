Return-Path: <linux-kernel+bounces-528676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51251A41A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA73A3901
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ADF253F15;
	Mon, 24 Feb 2025 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MMmHGDl/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qmd9X/hC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8892528FB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392134; cv=none; b=Gq8N9bQ/5mo4mwGPi61A4RhStPJXqHwxm+9uXXp723hBuhNplyJJdYhSzlWIFrzxUyySxeyb8Ph0FVUwVU//VsXrRAYZj5OmMPrOAErKLHU/ocLfpt9xdNnPo42QY1xM2esixAUSYNSVHpXZYc9HHYBN54rL0+puMCgdaS+HvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392134; c=relaxed/simple;
	bh=us16OfR37IveHWlWb26AIbWGv/bx0F5NNiaqZiX9su0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iSa77R7+hSfF/bLHn8sNGDyzs1DNZLOox25kO/zHyXL0cCKtLIQgOTRpEWgJ6jAvc9GpqAX5JgHumyPlm0Z4xla9X0ZHZKXo1d/HYrWAikQv4ncMR32lYNIOUVoYfev3Sm2KkIikQB3sjgcc7nd6eeoVF5v74aTN8Ujl/8maLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MMmHGDl/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qmd9X/hC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224101343.277679848@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1NcwSQHUYGMReXSkzTA7ZP6MuBB2dzTz3GVp7qZIRZw=;
	b=MMmHGDl/hKHbyBojjyOJ7IJDXEjcDXRynblyBid8hnw82717uQFBVI1cN5Pv3xr2TktM8I
	Ul778Qpw/IYg+HmInLdrAk0tKVXyef7EC+kP5Wu3NV7ql+w4PWGkmj7ca1YwI1w+oiI9tb
	n6hgqEfZWCMWOhPUlXHJFiiNg45H6K4XBZqWDP/7vSwvkavvxx/Ql0tsRnN2ZD41xSu7SA
	Hp3vhG8OYehfHOqHAfNmLBpDsn0zelHHRhpqlFaMPoBtHCbm5MDIvAXUpXaM36ci2MQhSd
	LPrx8A231gN+TptJwol8N1oN7HDfolkv+nsnsrJOQVkCg0JlkxwkvvV/1RKHyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1NcwSQHUYGMReXSkzTA7ZP6MuBB2dzTz3GVp7qZIRZw=;
	b=Qmd9X/hC34kiEk69DiPfhmMKkcQE5Uo3IDXoaaZCUD9xJHcOFkc6IgXxLebYO6Mx+Swm6S
	jfvYMfhYPvRCO4Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 05/11] posix-timers: Rework timer removal
References: <20250224095736.145530367@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 11:15:30 +0100 (CET)

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

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    7 +
 kernel/signal.c              |    2 
 kernel/time/posix-timers.c   |  156 +++++++++++++++++++------------------------
 3 files changed, 80 insertions(+), 85 deletions(-)

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
@@ -275,7 +275,7 @@ static bool __posixtimer_deliver_signal(
 	 * since the signal was queued. In either case, don't rearm and
 	 * drop the signal.
 	 */
-	if (timr->it_signal_seq != timr->it_sigqueue_seq || WARN_ON_ONCE(!timr->it_signal))
+	if (timr->it_signal_seq != timr->it_sigqueue_seq || !posixtimer_valid(timr))
 		return false;
 
 	if (!timr->it_interval || WARN_ON_ONCE(timr->it_status != POSIX_TIMER_REQUEUE_PENDING))
@@ -320,6 +320,9 @@ void posix_timer_queue_signal(struct k_i
 {
 	lockdep_assert_held(&timr->it_lock);
 
+	if (!posixtimer_valid(timr))
+		return;
+
 	timr->it_status = timr->it_interval ? POSIX_TIMER_REQUEUE_PENDING : POSIX_TIMER_DISARMED;
 	posixtimer_send_sigqueue(timr);
 }
@@ -540,11 +543,11 @@ static struct k_itimer *__lock_timer(tim
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
@@ -561,8 +564,8 @@ static struct k_itimer *__lock_timer(tim
 	 *
 	 * The lookup validates locklessly that timr::it_signal ==
 	 * current::it_signal and timr::it_id == @timer_id. timr::it_id
-	 * can't change, but timr::it_signal becomes NULL during
-	 * destruction.
+	 * can't change, but timr::it_signal can become invalid during
+	 * destruction, which makes the locked check fail.
 	 */
 	rcu_read_lock();
 	timr = posix_timer_by_id(timer_id);
@@ -809,8 +812,8 @@ static void common_timer_wait_running(st
  * when the task which tries to delete or disarm the timer has preempted
  * the task which runs the expiry in task work context.
  */
-static struct k_itimer *timer_wait_running(struct k_itimer *timer,
-					   unsigned long *flags)
+static struct k_itimer *timer_wait_running(struct k_itimer *timer, unsigned long *flags,
+					   bool delete)
 {
 	const struct k_clock *kc = READ_ONCE(timer->kclock);
 	timer_t timer_id = READ_ONCE(timer->it_id);
@@ -820,14 +823,32 @@ static struct k_itimer *timer_wait_runni
 	spin_unlock_irqrestore(&timer->it_lock, *flags);
 
 	/*
-	 * kc->timer_wait_running() might drop RCU lock. So @timer
-	 * cannot be touched anymore after the function returns!
+	 * kc->timer_wait_running() might drop RCU lock. So @timer cannot
+	 * be touched anymore after the function returns, except when
+	 * @delete is true!
 	 */
 	if (!WARN_ON_ONCE(!kc->timer_wait_running))
 		kc->timer_wait_running(timer);
 
 	rcu_read_unlock();
-	/* Relock the timer. It might be not longer hashed. */
+
+	/*
+	 * On deletion the timer has been marked invalid before
+	 * timer_delete_hook() has been invoked. That means that the
+	 * current task is the only one which has access to the timer and
+	 * even after dropping timer::it_lock above, no other thread can
+	 * have accessed the timer.
+	 */
+	if (delete) {
+		spin_lock_irqsave(&timer->it_lock, *flags);
+		return timer;
+	}
+
+	/*
+	 * If invoked from timer_set() the timer could have been deleted
+	 * after dropping the lock. So in that case the timer needs to be
+	 * looked up and validated.
+	 */
 	return lock_timer(timer_id, flags);
 }
 
@@ -920,7 +941,7 @@ static int do_timer_settime(timer_t time
 		// We already got the old time...
 		old_spec64 = NULL;
 		/* Unlocks and relocks the timer if it still exists */
-		timr = timer_wait_running(timr, &flags);
+		timr = timer_wait_running(timr, &flags, false);
 		goto retry;
 	}
 	spin_unlock_irqrestore(&timr->it_lock, flags);
@@ -1008,95 +1029,62 @@ static inline int timer_delete_hook(stru
 	return kc->timer_del(timer);
 }
 
-/* Delete a POSIX.1b interval timer. */
-SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
+static int posix_timer_delete(struct k_itimer *timer, timer_t id)
 {
-	struct k_itimer *timer;
 	unsigned long flags;
 
-	timer = lock_timer(timer_id, &flags);
-
-retry_delete:
-	if (!timer)
-		return -EINVAL;
-
-	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
-		/* Unlocks and relocks the timer if it still exists */
-		timer = timer_wait_running(timer, &flags);
-		goto retry_delete;
+	if (!timer) {
+		timer = lock_timer(id, &flags);
+		if (!timer)
+			return -EINVAL;
+	} else {
+		spin_lock_irqsave(&timer->it_lock, flags);
 	}
 
-	spin_lock(&current->sighand->siglock);
-	hlist_del(&timer->list);
-	posix_timer_cleanup_ignored(timer);
 	/*
-	 * A concurrent lookup could check timer::it_signal lockless. It
-	 * will reevaluate with timer::it_lock held and observe the NULL.
+	 * Invalidate the timer, remove it from the linked list and remove
+	 * it from the ignored list if pending.
 	 *
-	 * It must be written with siglock held so that the signal code
-	 * observes timer->it_signal == NULL in do_sigaction(SIG_IGN),
+	 * The invalidation must be written with siglock held so that the
+	 * signal code observes timer->it_valid == false in do_sigaction(),
 	 * which prevents it from moving a pending signal of a deleted
 	 * timer to the ignore list.
+	 *
+	 * The invalidation also prevents signal queueing, signal delivery
+	 * and therefore rearming from the signal delivery path.
+	 *
+	 * A concurrent lookup can still find the timer in the hash, but it
+	 * will check timer::it_signal with timer::it_lock held and observe
+	 * bit 0 set, which invalidates it. That also prevents the timer ID
+	 * from being handed out before this timer is completely gone.
 	 */
-	WRITE_ONCE(timer->it_signal, NULL);
-	spin_unlock(&current->sighand->siglock);
-
-	spin_unlock_irqrestore(&timer->it_lock, flags);
-	posix_timer_unhash_and_free(timer);
-	return 0;
-}
+	scoped_guard(spinlock, &current->sighand->siglock) {
+		unsigned long sig = (unsigned long)timer->it_signal | 1UL;
 
-/*
- * Delete a timer if it is armed, remove it from the hash and schedule it
- * for RCU freeing.
- */
-static void itimer_delete(struct k_itimer *timer)
-{
-	unsigned long flags;
-
-	/*
-	 * irqsave is required to make timer_wait_running() work.
-	 */
-	spin_lock_irqsave(&timer->it_lock, flags);
+		WRITE_ONCE(timer->it_signal, (struct signal_struct *)sig);
+		hlist_del(&timer->list);
+		posix_timer_cleanup_ignored(timer);
+	}
 
-retry_delete:
-	/*
-	 * Even if the timer is not longer accessible from other tasks
-	 * it still might be armed and queued in the underlying timer
-	 * mechanism. Worse, that timer mechanism might run the expiry
-	 * function concurrently.
-	 */
-	if (timer_delete_hook(timer) == TIMER_RETRY) {
+	while (timer_delete_hook(timer) == TIMER_RETRY) {
 		/*
-		 * Timer is expired concurrently, prevent livelocks
-		 * and pointless spinning on RT.
-		 *
-		 * timer_wait_running() drops timer::it_lock, which opens
-		 * the possibility for another task to delete the timer.
-		 *
-		 * That's not possible here because this is invoked from
-		 * do_exit() only for the last thread of the thread group.
-		 * So no other task can access and delete that timer.
+		 * Unlocks and relocks the timer. There is no concurrent
+		 * delete possible after unlocking the timer as the timer
+		 * has been marked invalid above.
 		 */
-		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer))
-			return;
-
-		goto retry_delete;
+		timer_wait_running(timer, &flags, true);
 	}
-	hlist_del(&timer->list);
-
-	posix_timer_cleanup_ignored(timer);
-
-	/*
-	 * Setting timer::it_signal to NULL is technically not required
-	 * here as nothing can access the timer anymore legitimately via
-	 * the hash table. Set it to NULL nevertheless so that all deletion
-	 * paths are consistent.
-	 */
-	WRITE_ONCE(timer->it_signal, NULL);
 
 	spin_unlock_irqrestore(&timer->it_lock, flags);
+	/* Remove it from the hash, which frees up the timer ID */
 	posix_timer_unhash_and_free(timer);
+	return 0;
+}
+
+/* Delete a POSIX.1b interval timer. */
+SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
+{
+	return posix_timer_delete(NULL, timer_id);
 }
 
 /*
@@ -1118,7 +1106,7 @@ void exit_itimers(struct task_struct *ts
 
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers)) {
-		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+		posix_timer_delete(hlist_entry(timers.first, struct k_itimer, list), 0);
 		cond_resched();
 	}
 


