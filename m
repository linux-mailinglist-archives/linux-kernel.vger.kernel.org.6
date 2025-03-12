Return-Path: <linux-kernel+bounces-557974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F848A5E00A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCE93AC4EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB22256C87;
	Wed, 12 Mar 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtFsFavh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGWl8X29"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8022E402
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792606; cv=none; b=DdSwJuahrXKY97vutDObaquTOXkbn3wQcBS4MvAXGpBfEt9X9Pd8paTe3+ZeFrCVSLjqAzt5DXNZlX5hFPpcT/cBwrW7laMwXKOxv/NYrv41ATOoURoYgjtkAj/JsFfW8XVmWf+iAWQ3n/D1ycqKwu6ZdmaulPX9UAIM59wLNwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792606; c=relaxed/simple;
	bh=qSclWI5j7fYsWU29QPiQ3wQIvBffUM0HHXFz2qvjq9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3AaIsn6Y8YFJxDtCmSVaSGx4cNq1Fuc5+MH90J4zupEXudxDHt4xD9v8UiMJIoSd7Df79rl3eLYQFxJIllGhHBmDyPdwIFzFHrUIaFOqCfRpszG25kZI5T6hH+/fO1ZyJtxe9ltM3cAKZ6I4p42E6XLhS/CgBKW99+DiYceZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtFsFavh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGWl8X29; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5edmI3ndtPp9qZ90xZ0EIqpommqwQbXTEX78nyveRmc=;
	b=rtFsFavhs7Tax8rx8uDNoT5NJGKrNk6vKeXWqbJ2Uve7C6T1sFbYHpANgZu0HpmGYgF6ZR
	byceGTgybvzg3VXMi0YAnCDOFonIBbD+IpX4OE5F1WHAO3L418/VdqDalJNUy0VFMFlnXV
	HR8PK4vJmxtrAhvrA9yAiHK+j8zHcfjk9FipMiAoE4PBtRztgc25D6guB7M3ZbggiBCg9X
	n/K359ijqBgEfibq2SgNo94wYlcX2uDuFybHYXh+1j/9KOJ3L36eVIXQWojovkZo0TQpox
	Kwp2EH0qGE01Svza76tAy4Al4j/RWRcfXw51myfxDl00xC0vUSDqMKp44wSe5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5edmI3ndtPp9qZ90xZ0EIqpommqwQbXTEX78nyveRmc=;
	b=aGWl8X29x8ktKq7UyfwDLTqs5nn6se4wqT3U08WaucT1+4jsl9cMTQvJRMxgfIcNGAlzuR
	hzF6Mczo8+MH4mDQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v10 04/21] futex: Create hb scopes
Date: Wed, 12 Mar 2025 16:16:17 +0100
Message-ID: <20250312151634.2183278-5-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Zijlstra <peterz@infradead.org>

Create explicit scopes for hb variables; almost pure re-indent.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c     |  81 ++++----
 kernel/futex/pi.c       | 282 +++++++++++++-------------
 kernel/futex/requeue.c  | 433 ++++++++++++++++++++--------------------
 kernel/futex/waitwake.c | 193 +++++++++---------
 4 files changed, 504 insertions(+), 485 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 7adc914878933..e4cb5ce9785b1 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -944,7 +944,6 @@ static void exit_pi_state_list(struct task_struct *curr)
 {
 	struct list_head *next, *head =3D &curr->pi_state_list;
 	struct futex_pi_state *pi_state;
-	struct futex_hash_bucket *hb;
 	union futex_key key =3D FUTEX_KEY_INIT;
=20
 	/*
@@ -957,50 +956,54 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 		next =3D head->next;
 		pi_state =3D list_entry(next, struct futex_pi_state, list);
 		key =3D pi_state->key;
-		hb =3D futex_hash(&key);
+		if (1) {
+			struct futex_hash_bucket *hb;
=20
-		/*
-		 * We can race against put_pi_state() removing itself from the
-		 * list (a waiter going away). put_pi_state() will first
-		 * decrement the reference count and then modify the list, so
-		 * its possible to see the list entry but fail this reference
-		 * acquire.
-		 *
-		 * In that case; drop the locks to let put_pi_state() make
-		 * progress and retry the loop.
-		 */
-		if (!refcount_inc_not_zero(&pi_state->refcount)) {
+			hb =3D futex_hash(&key);
+
+			/*
+			 * We can race against put_pi_state() removing itself from the
+			 * list (a waiter going away). put_pi_state() will first
+			 * decrement the reference count and then modify the list, so
+			 * its possible to see the list entry but fail this reference
+			 * acquire.
+			 *
+			 * In that case; drop the locks to let put_pi_state() make
+			 * progress and retry the loop.
+			 */
+			if (!refcount_inc_not_zero(&pi_state->refcount)) {
+				raw_spin_unlock_irq(&curr->pi_lock);
+				cpu_relax();
+				raw_spin_lock_irq(&curr->pi_lock);
+				continue;
+			}
 			raw_spin_unlock_irq(&curr->pi_lock);
-			cpu_relax();
-			raw_spin_lock_irq(&curr->pi_lock);
-			continue;
-		}
-		raw_spin_unlock_irq(&curr->pi_lock);
=20
-		spin_lock(&hb->lock);
-		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
-		raw_spin_lock(&curr->pi_lock);
-		/*
-		 * We dropped the pi-lock, so re-check whether this
-		 * task still owns the PI-state:
-		 */
-		if (head->next !=3D next) {
-			/* retain curr->pi_lock for the loop invariant */
-			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
+			spin_lock(&hb->lock);
+			raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+			raw_spin_lock(&curr->pi_lock);
+			/*
+			 * We dropped the pi-lock, so re-check whether this
+			 * task still owns the PI-state:
+			 */
+			if (head->next !=3D next) {
+				/* retain curr->pi_lock for the loop invariant */
+				raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
+				spin_unlock(&hb->lock);
+				put_pi_state(pi_state);
+				continue;
+			}
+
+			WARN_ON(pi_state->owner !=3D curr);
+			WARN_ON(list_empty(&pi_state->list));
+			list_del_init(&pi_state->list);
+			pi_state->owner =3D NULL;
+
+			raw_spin_unlock(&curr->pi_lock);
+			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 			spin_unlock(&hb->lock);
-			put_pi_state(pi_state);
-			continue;
 		}
=20
-		WARN_ON(pi_state->owner !=3D curr);
-		WARN_ON(list_empty(&pi_state->list));
-		list_del_init(&pi_state->list);
-		pi_state->owner =3D NULL;
-
-		raw_spin_unlock(&curr->pi_lock);
-		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
-		spin_unlock(&hb->lock);
-
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
 		put_pi_state(pi_state);
=20
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 3bf942e9400ac..62ce5ecaeddd6 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -920,7 +920,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags=
, ktime_t *time, int tryl
 	struct hrtimer_sleeper timeout, *to;
 	struct task_struct *exiting =3D NULL;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb;
 	struct futex_q q =3D futex_q_init;
 	DEFINE_WAKE_Q(wake_q);
 	int res, ret;
@@ -939,152 +938,169 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int f=
lags, ktime_t *time, int tryl
 		goto out;
=20
 retry_private:
-	hb =3D futex_hash(&q.key);
-	futex_q_lock(&q, hb);
+	if (1) {
+		struct futex_hash_bucket *hb;
=20
-	ret =3D futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
-				   &exiting, 0);
-	if (unlikely(ret)) {
-		/*
-		 * Atomic work succeeded and we got the lock,
-		 * or failed. Either way, we do _not_ block.
-		 */
-		switch (ret) {
-		case 1:
-			/* We got the lock. */
-			ret =3D 0;
-			goto out_unlock_put_key;
-		case -EFAULT:
-			goto uaddr_faulted;
-		case -EBUSY:
-		case -EAGAIN:
+		hb =3D futex_hash(&q.key);
+		futex_q_lock(&q, hb);
+
+		ret =3D futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
+					   &exiting, 0);
+		if (unlikely(ret)) {
 			/*
-			 * Two reasons for this:
-			 * - EBUSY: Task is exiting and we just wait for the
-			 *   exit to complete.
-			 * - EAGAIN: The user space value changed.
+			 * Atomic work succeeded and we got the lock,
+			 * or failed. Either way, we do _not_ block.
 			 */
-			futex_q_unlock(hb);
-			/*
-			 * Handle the case where the owner is in the middle of
-			 * exiting. Wait for the exit to complete otherwise
-			 * this task might loop forever, aka. live lock.
-			 */
-			wait_for_owner_exiting(ret, exiting);
-			cond_resched();
-			goto retry;
-		default:
-			goto out_unlock_put_key;
+			switch (ret) {
+			case 1:
+				/* We got the lock. */
+				ret =3D 0;
+				goto out_unlock_put_key;
+			case -EFAULT:
+				goto uaddr_faulted;
+			case -EBUSY:
+			case -EAGAIN:
+				/*
+				 * Two reasons for this:
+				 * - EBUSY: Task is exiting and we just wait for the
+				 *   exit to complete.
+				 * - EAGAIN: The user space value changed.
+				 */
+				futex_q_unlock(hb);
+				/*
+				 * Handle the case where the owner is in the middle of
+				 * exiting. Wait for the exit to complete otherwise
+				 * this task might loop forever, aka. live lock.
+				 */
+				wait_for_owner_exiting(ret, exiting);
+				cond_resched();
+				goto retry;
+			default:
+				goto out_unlock_put_key;
+			}
 		}
-	}
=20
-	WARN_ON(!q.pi_state);
+		WARN_ON(!q.pi_state);
=20
-	/*
-	 * Only actually queue now that the atomic ops are done:
-	 */
-	__futex_queue(&q, hb, current);
+		/*
+		 * Only actually queue now that the atomic ops are done:
+		 */
+		__futex_queue(&q, hb, current);
=20
-	if (trylock) {
-		ret =3D rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
-		/* Fixup the trylock return value: */
-		ret =3D ret ? 0 : -EWOULDBLOCK;
-		goto no_block;
-	}
+		if (trylock) {
+			ret =3D rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
+			/* Fixup the trylock return value: */
+			ret =3D ret ? 0 : -EWOULDBLOCK;
+			goto no_block;
+		}
=20
-	/*
-	 * Must be done before we enqueue the waiter, here is unfortunately
-	 * under the hb lock, but that *should* work because it does nothing.
-	 */
-	rt_mutex_pre_schedule();
+		/*
+		 * Must be done before we enqueue the waiter, here is unfortunately
+		 * under the hb lock, but that *should* work because it does nothing.
+		 */
+		rt_mutex_pre_schedule();
=20
-	rt_mutex_init_waiter(&rt_waiter);
+		rt_mutex_init_waiter(&rt_waiter);
=20
-	/*
-	 * On PREEMPT_RT, when hb->lock becomes an rt_mutex, we must not
-	 * hold it while doing rt_mutex_start_proxy(), because then it will
-	 * include hb->lock in the blocking chain, even through we'll not in
-	 * fact hold it while blocking. This will lead it to report -EDEADLK
-	 * and BUG when futex_unlock_pi() interleaves with this.
-	 *
-	 * Therefore acquire wait_lock while holding hb->lock, but drop the
-	 * latter before calling __rt_mutex_start_proxy_lock(). This
-	 * interleaves with futex_unlock_pi() -- which does a similar lock
-	 * handoff -- such that the latter can observe the futex_q::pi_state
-	 * before __rt_mutex_start_proxy_lock() is done.
-	 */
-	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
-	spin_unlock(q.lock_ptr);
-	/*
-	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
-	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
-	 * it sees the futex_q::pi_state.
-	 */
-	ret =3D __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, cu=
rrent, &wake_q);
-	raw_spin_unlock_irq_wake(&q.pi_state->pi_mutex.wait_lock, &wake_q);
+		/*
+		 * On PREEMPT_RT, when hb->lock becomes an rt_mutex, we must not
+		 * hold it while doing rt_mutex_start_proxy(), because then it will
+		 * include hb->lock in the blocking chain, even through we'll not in
+		 * fact hold it while blocking. This will lead it to report -EDEADLK
+		 * and BUG when futex_unlock_pi() interleaves with this.
+		 *
+		 * Therefore acquire wait_lock while holding hb->lock, but drop the
+		 * latter before calling __rt_mutex_start_proxy_lock(). This
+		 * interleaves with futex_unlock_pi() -- which does a similar lock
+		 * handoff -- such that the latter can observe the futex_q::pi_state
+		 * before __rt_mutex_start_proxy_lock() is done.
+		 */
+		raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
+		spin_unlock(q.lock_ptr);
+		/*
+		 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
+		 * such that futex_unlock_pi() is guaranteed to observe the waiter when
+		 * it sees the futex_q::pi_state.
+		 */
+		ret =3D __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, c=
urrent, &wake_q);
+		raw_spin_unlock_irq_wake(&q.pi_state->pi_mutex.wait_lock, &wake_q);
=20
-	if (ret) {
-		if (ret =3D=3D 1)
-			ret =3D 0;
-		goto cleanup;
-	}
+		if (ret) {
+			if (ret =3D=3D 1)
+				ret =3D 0;
+			goto cleanup;
+		}
=20
-	if (unlikely(to))
-		hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
+		if (unlikely(to))
+			hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
=20
-	ret =3D rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
+		ret =3D rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
=20
 cleanup:
-	/*
-	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
-	 * must unwind the above, however we canont lock hb->lock because
-	 * rt_mutex already has a waiter enqueued and hb->lock can itself try
-	 * and enqueue an rt_waiter through rtlock.
-	 *
-	 * Doing the cleanup without holding hb->lock can cause inconsistent
-	 * state between hb and pi_state, but only in the direction of not
-	 * seeing a waiter that is leaving.
-	 *
-	 * See futex_unlock_pi(), it deals with this inconsistency.
-	 *
-	 * There be dragons here, since we must deal with the inconsistency on
-	 * the way out (here), it is impossible to detect/warn about the race
-	 * the other way around (missing an incoming waiter).
-	 *
-	 * What could possibly go wrong...
-	 */
-	if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter=
))
-		ret =3D 0;
+		/*
+		 * If we failed to acquire the lock (deadlock/signal/timeout), we must
+		 * must unwind the above, however we canont lock hb->lock because
+		 * rt_mutex already has a waiter enqueued and hb->lock can itself try
+		 * and enqueue an rt_waiter through rtlock.
+		 *
+		 * Doing the cleanup without holding hb->lock can cause inconsistent
+		 * state between hb and pi_state, but only in the direction of not
+		 * seeing a waiter that is leaving.
+		 *
+		 * See futex_unlock_pi(), it deals with this inconsistency.
+		 *
+		 * There be dragons here, since we must deal with the inconsistency on
+		 * the way out (here), it is impossible to detect/warn about the race
+		 * the other way around (missing an incoming waiter).
+		 *
+		 * What could possibly go wrong...
+		 */
+		if (ret && !rt_mutex_cleanup_proxy_lock(&q.pi_state->pi_mutex, &rt_waite=
r))
+			ret =3D 0;
=20
-	/*
-	 * Now that the rt_waiter has been dequeued, it is safe to use
-	 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
-	 * the
-	 */
-	spin_lock(q.lock_ptr);
-	/*
-	 * Waiter is unqueued.
-	 */
-	rt_mutex_post_schedule();
+		/*
+		 * Now that the rt_waiter has been dequeued, it is safe to use
+		 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
+		 * the
+		 */
+		spin_lock(q.lock_ptr);
+		/*
+		 * Waiter is unqueued.
+		 */
+		rt_mutex_post_schedule();
 no_block:
-	/*
-	 * Fixup the pi_state owner and possibly acquire the lock if we
-	 * haven't already.
-	 */
-	res =3D fixup_pi_owner(uaddr, &q, !ret);
-	/*
-	 * If fixup_pi_owner() returned an error, propagate that.  If it acquired
-	 * the lock, clear our -ETIMEDOUT or -EINTR.
-	 */
-	if (res)
-		ret =3D (res < 0) ? res : 0;
+		/*
+		 * Fixup the pi_state owner and possibly acquire the lock if we
+		 * haven't already.
+		 */
+		res =3D fixup_pi_owner(uaddr, &q, !ret);
+		/*
+		 * If fixup_pi_owner() returned an error, propagate that.  If it acquired
+		 * the lock, clear our -ETIMEDOUT or -EINTR.
+		 */
+		if (res)
+			ret =3D (res < 0) ? res : 0;
=20
-	futex_unqueue_pi(&q);
-	spin_unlock(q.lock_ptr);
-	goto out;
+		futex_unqueue_pi(&q);
+		spin_unlock(q.lock_ptr);
+		goto out;
=20
 out_unlock_put_key:
-	futex_q_unlock(hb);
+		futex_q_unlock(hb);
+		goto out;
+
+uaddr_faulted:
+		futex_q_unlock(hb);
+
+		ret =3D fault_in_user_writeable(uaddr);
+		if (ret)
+			goto out;
+
+		if (!(flags & FLAGS_SHARED))
+			goto retry_private;
+
+		goto retry;
+	}
=20
 out:
 	if (to) {
@@ -1092,18 +1108,6 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fl=
ags, ktime_t *time, int tryl
 		destroy_hrtimer_on_stack(&to->timer);
 	}
 	return ret !=3D -EINTR ? ret : -ERESTARTNOINTR;
-
-uaddr_faulted:
-	futex_q_unlock(hb);
-
-	ret =3D fault_in_user_writeable(uaddr);
-	if (ret)
-		goto out;
-
-	if (!(flags & FLAGS_SHARED))
-		goto retry_private;
-
-	goto retry;
 }
=20
 /*
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 0e55975af515c..209794cad6f2f 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -371,7 +371,6 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 	union futex_key key1 =3D FUTEX_KEY_INIT, key2 =3D FUTEX_KEY_INIT;
 	int task_count =3D 0, ret;
 	struct futex_pi_state *pi_state =3D NULL;
-	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
=20
@@ -443,240 +442,244 @@ int futex_requeue(u32 __user *uaddr1, unsigned int =
flags1,
 	if (requeue_pi && futex_match(&key1, &key2))
 		return -EINVAL;
=20
-	hb1 =3D futex_hash(&key1);
-	hb2 =3D futex_hash(&key2);
-
 retry_private:
-	futex_hb_waiters_inc(hb2);
-	double_lock_hb(hb1, hb2);
+	if (1) {
+		struct futex_hash_bucket *hb1, *hb2;
=20
-	if (likely(cmpval !=3D NULL)) {
-		u32 curval;
+		hb1 =3D futex_hash(&key1);
+		hb2 =3D futex_hash(&key2);
=20
-		ret =3D futex_get_value_locked(&curval, uaddr1);
+		futex_hb_waiters_inc(hb2);
+		double_lock_hb(hb1, hb2);
=20
-		if (unlikely(ret)) {
-			double_unlock_hb(hb1, hb2);
-			futex_hb_waiters_dec(hb2);
+		if (likely(cmpval !=3D NULL)) {
+			u32 curval;
=20
-			ret =3D get_user(curval, uaddr1);
-			if (ret)
-				return ret;
+			ret =3D futex_get_value_locked(&curval, uaddr1);
=20
-			if (!(flags1 & FLAGS_SHARED))
-				goto retry_private;
+			if (unlikely(ret)) {
+				double_unlock_hb(hb1, hb2);
+				futex_hb_waiters_dec(hb2);
=20
-			goto retry;
-		}
-		if (curval !=3D *cmpval) {
-			ret =3D -EAGAIN;
-			goto out_unlock;
-		}
-	}
+				ret =3D get_user(curval, uaddr1);
+				if (ret)
+					return ret;
=20
-	if (requeue_pi) {
-		struct task_struct *exiting =3D NULL;
+				if (!(flags1 & FLAGS_SHARED))
+					goto retry_private;
=20
-		/*
-		 * Attempt to acquire uaddr2 and wake the top waiter. If we
-		 * intend to requeue waiters, force setting the FUTEX_WAITERS
-		 * bit.  We force this here where we are able to easily handle
-		 * faults rather in the requeue loop below.
-		 *
-		 * Updates topwaiter::requeue_state if a top waiter exists.
-		 */
-		ret =3D futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
-						 &key2, &pi_state,
-						 &exiting, nr_requeue);
-
-		/*
-		 * At this point the top_waiter has either taken uaddr2 or
-		 * is waiting on it. In both cases pi_state has been
-		 * established and an initial refcount on it. In case of an
-		 * error there's nothing.
-		 *
-		 * The top waiter's requeue_state is up to date:
-		 *
-		 *  - If the lock was acquired atomically (ret =3D=3D 1), then
-		 *    the state is Q_REQUEUE_PI_LOCKED.
-		 *
-		 *    The top waiter has been dequeued and woken up and can
-		 *    return to user space immediately. The kernel/user
-		 *    space state is consistent. In case that there must be
-		 *    more waiters requeued the WAITERS bit in the user
-		 *    space futex is set so the top waiter task has to go
-		 *    into the syscall slowpath to unlock the futex. This
-		 *    will block until this requeue operation has been
-		 *    completed and the hash bucket locks have been
-		 *    dropped.
-		 *
-		 *  - If the trylock failed with an error (ret < 0) then
-		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
-		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
-		 *    interleaved early wakeup.
-		 *
-		 *  - If the trylock did not succeed (ret =3D=3D 0) then the
-		 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
-		 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
-		 *    This will be cleaned up in the loop below, which
-		 *    cannot fail because futex_proxy_trylock_atomic() did
-		 *    the same sanity checks for requeue_pi as the loop
-		 *    below does.
-		 */
-		switch (ret) {
-		case 0:
-			/* We hold a reference on the pi state. */
-			break;
-
-		case 1:
-			/*
-			 * futex_proxy_trylock_atomic() acquired the user space
-			 * futex. Adjust task_count.
-			 */
-			task_count++;
-			ret =3D 0;
-			break;
-
-		/*
-		 * If the above failed, then pi_state is NULL and
-		 * waiter::requeue_state is correct.
-		 */
-		case -EFAULT:
-			double_unlock_hb(hb1, hb2);
-			futex_hb_waiters_dec(hb2);
-			ret =3D fault_in_user_writeable(uaddr2);
-			if (!ret)
 				goto retry;
-			return ret;
-		case -EBUSY:
-		case -EAGAIN:
-			/*
-			 * Two reasons for this:
-			 * - EBUSY: Owner is exiting and we just wait for the
-			 *   exit to complete.
-			 * - EAGAIN: The user space value changed.
-			 */
-			double_unlock_hb(hb1, hb2);
-			futex_hb_waiters_dec(hb2);
-			/*
-			 * Handle the case where the owner is in the middle of
-			 * exiting. Wait for the exit to complete otherwise
-			 * this task might loop forever, aka. live lock.
-			 */
-			wait_for_owner_exiting(ret, exiting);
-			cond_resched();
-			goto retry;
-		default:
-			goto out_unlock;
-		}
-	}
-
-	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (task_count - nr_wake >=3D nr_requeue)
-			break;
-
-		if (!futex_match(&this->key, &key1))
-			continue;
-
-		/*
-		 * FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI should always
-		 * be paired with each other and no other futex ops.
-		 *
-		 * We should never be requeueing a futex_q with a pi_state,
-		 * which is awaiting a futex_unlock_pi().
-		 */
-		if ((requeue_pi && !this->rt_waiter) ||
-		    (!requeue_pi && this->rt_waiter) ||
-		    this->pi_state) {
-			ret =3D -EINVAL;
-			break;
+			}
+			if (curval !=3D *cmpval) {
+				ret =3D -EAGAIN;
+				goto out_unlock;
+			}
 		}
=20
-		/* Plain futexes just wake or requeue and are done */
-		if (!requeue_pi) {
-			if (++task_count <=3D nr_wake)
-				this->wake(&wake_q, this);
-			else
+		if (requeue_pi) {
+			struct task_struct *exiting =3D NULL;
+
+			/*
+			 * Attempt to acquire uaddr2 and wake the top waiter. If we
+			 * intend to requeue waiters, force setting the FUTEX_WAITERS
+			 * bit.  We force this here where we are able to easily handle
+			 * faults rather in the requeue loop below.
+			 *
+			 * Updates topwaiter::requeue_state if a top waiter exists.
+			 */
+			ret =3D futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
+							 &key2, &pi_state,
+							 &exiting, nr_requeue);
+
+			/*
+			 * At this point the top_waiter has either taken uaddr2 or
+			 * is waiting on it. In both cases pi_state has been
+			 * established and an initial refcount on it. In case of an
+			 * error there's nothing.
+			 *
+			 * The top waiter's requeue_state is up to date:
+			 *
+			 *  - If the lock was acquired atomically (ret =3D=3D 1), then
+			 *    the state is Q_REQUEUE_PI_LOCKED.
+			 *
+			 *    The top waiter has been dequeued and woken up and can
+			 *    return to user space immediately. The kernel/user
+			 *    space state is consistent. In case that there must be
+			 *    more waiters requeued the WAITERS bit in the user
+			 *    space futex is set so the top waiter task has to go
+			 *    into the syscall slowpath to unlock the futex. This
+			 *    will block until this requeue operation has been
+			 *    completed and the hash bucket locks have been
+			 *    dropped.
+			 *
+			 *  - If the trylock failed with an error (ret < 0) then
+			 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
+			 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
+			 *    interleaved early wakeup.
+			 *
+			 *  - If the trylock did not succeed (ret =3D=3D 0) then the
+			 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
+			 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
+			 *    This will be cleaned up in the loop below, which
+			 *    cannot fail because futex_proxy_trylock_atomic() did
+			 *    the same sanity checks for requeue_pi as the loop
+			 *    below does.
+			 */
+			switch (ret) {
+			case 0:
+				/* We hold a reference on the pi state. */
+				break;
+
+			case 1:
+				/*
+				 * futex_proxy_trylock_atomic() acquired the user space
+				 * futex. Adjust task_count.
+				 */
+				task_count++;
+				ret =3D 0;
+				break;
+
+				/*
+				 * If the above failed, then pi_state is NULL and
+				 * waiter::requeue_state is correct.
+				 */
+			case -EFAULT:
+				double_unlock_hb(hb1, hb2);
+				futex_hb_waiters_dec(hb2);
+				ret =3D fault_in_user_writeable(uaddr2);
+				if (!ret)
+					goto retry;
+				return ret;
+			case -EBUSY:
+			case -EAGAIN:
+				/*
+				 * Two reasons for this:
+				 * - EBUSY: Owner is exiting and we just wait for the
+				 *   exit to complete.
+				 * - EAGAIN: The user space value changed.
+				 */
+				double_unlock_hb(hb1, hb2);
+				futex_hb_waiters_dec(hb2);
+				/*
+				 * Handle the case where the owner is in the middle of
+				 * exiting. Wait for the exit to complete otherwise
+				 * this task might loop forever, aka. live lock.
+				 */
+				wait_for_owner_exiting(ret, exiting);
+				cond_resched();
+				goto retry;
+			default:
+				goto out_unlock;
+			}
+		}
+
+		plist_for_each_entry_safe(this, next, &hb1->chain, list) {
+			if (task_count - nr_wake >=3D nr_requeue)
+				break;
+
+			if (!futex_match(&this->key, &key1))
+				continue;
+
+			/*
+			 * FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI should always
+			 * be paired with each other and no other futex ops.
+			 *
+			 * We should never be requeueing a futex_q with a pi_state,
+			 * which is awaiting a futex_unlock_pi().
+			 */
+			if ((requeue_pi && !this->rt_waiter) ||
+			    (!requeue_pi && this->rt_waiter) ||
+			    this->pi_state) {
+				ret =3D -EINVAL;
+				break;
+			}
+
+			/* Plain futexes just wake or requeue and are done */
+			if (!requeue_pi) {
+				if (++task_count <=3D nr_wake)
+					this->wake(&wake_q, this);
+				else
+					requeue_futex(this, hb1, hb2, &key2);
+				continue;
+			}
+
+			/* Ensure we requeue to the expected futex for requeue_pi. */
+			if (!futex_match(this->requeue_pi_key, &key2)) {
+				ret =3D -EINVAL;
+				break;
+			}
+
+			/*
+			 * Requeue nr_requeue waiters and possibly one more in the case
+			 * of requeue_pi if we couldn't acquire the lock atomically.
+			 *
+			 * Prepare the waiter to take the rt_mutex. Take a refcount
+			 * on the pi_state and store the pointer in the futex_q
+			 * object of the waiter.
+			 */
+			get_pi_state(pi_state);
+
+			/* Don't requeue when the waiter is already on the way out. */
+			if (!futex_requeue_pi_prepare(this, pi_state)) {
+				/*
+				 * Early woken waiter signaled that it is on the
+				 * way out. Drop the pi_state reference and try the
+				 * next waiter. @this->pi_state is still NULL.
+				 */
+				put_pi_state(pi_state);
+				continue;
+			}
+
+			ret =3D rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
+							this->rt_waiter,
+							this->task);
+
+			if (ret =3D=3D 1) {
+				/*
+				 * We got the lock. We do neither drop the refcount
+				 * on pi_state nor clear this->pi_state because the
+				 * waiter needs the pi_state for cleaning up the
+				 * user space value. It will drop the refcount
+				 * after doing so. this::requeue_state is updated
+				 * in the wakeup as well.
+				 */
+				requeue_pi_wake_futex(this, &key2, hb2);
+				task_count++;
+			} else if (!ret) {
+				/* Waiter is queued, move it to hb2 */
 				requeue_futex(this, hb1, hb2, &key2);
-			continue;
-		}
-
-		/* Ensure we requeue to the expected futex for requeue_pi. */
-		if (!futex_match(this->requeue_pi_key, &key2)) {
-			ret =3D -EINVAL;
-			break;
+				futex_requeue_pi_complete(this, 0);
+				task_count++;
+			} else {
+				/*
+				 * rt_mutex_start_proxy_lock() detected a potential
+				 * deadlock when we tried to queue that waiter.
+				 * Drop the pi_state reference which we took above
+				 * and remove the pointer to the state from the
+				 * waiters futex_q object.
+				 */
+				this->pi_state =3D NULL;
+				put_pi_state(pi_state);
+				futex_requeue_pi_complete(this, ret);
+				/*
+				 * We stop queueing more waiters and let user space
+				 * deal with the mess.
+				 */
+				break;
+			}
 		}
=20
 		/*
-		 * Requeue nr_requeue waiters and possibly one more in the case
-		 * of requeue_pi if we couldn't acquire the lock atomically.
-		 *
-		 * Prepare the waiter to take the rt_mutex. Take a refcount
-		 * on the pi_state and store the pointer in the futex_q
-		 * object of the waiter.
+		 * We took an extra initial reference to the pi_state in
+		 * futex_proxy_trylock_atomic(). We need to drop it here again.
 		 */
-		get_pi_state(pi_state);
-
-		/* Don't requeue when the waiter is already on the way out. */
-		if (!futex_requeue_pi_prepare(this, pi_state)) {
-			/*
-			 * Early woken waiter signaled that it is on the
-			 * way out. Drop the pi_state reference and try the
-			 * next waiter. @this->pi_state is still NULL.
-			 */
-			put_pi_state(pi_state);
-			continue;
-		}
-
-		ret =3D rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
-						this->rt_waiter,
-						this->task);
-
-		if (ret =3D=3D 1) {
-			/*
-			 * We got the lock. We do neither drop the refcount
-			 * on pi_state nor clear this->pi_state because the
-			 * waiter needs the pi_state for cleaning up the
-			 * user space value. It will drop the refcount
-			 * after doing so. this::requeue_state is updated
-			 * in the wakeup as well.
-			 */
-			requeue_pi_wake_futex(this, &key2, hb2);
-			task_count++;
-		} else if (!ret) {
-			/* Waiter is queued, move it to hb2 */
-			requeue_futex(this, hb1, hb2, &key2);
-			futex_requeue_pi_complete(this, 0);
-			task_count++;
-		} else {
-			/*
-			 * rt_mutex_start_proxy_lock() detected a potential
-			 * deadlock when we tried to queue that waiter.
-			 * Drop the pi_state reference which we took above
-			 * and remove the pointer to the state from the
-			 * waiters futex_q object.
-			 */
-			this->pi_state =3D NULL;
-			put_pi_state(pi_state);
-			futex_requeue_pi_complete(this, ret);
-			/*
-			 * We stop queueing more waiters and let user space
-			 * deal with the mess.
-			 */
-			break;
-		}
-	}
-
-	/*
-	 * We took an extra initial reference to the pi_state in
-	 * futex_proxy_trylock_atomic(). We need to drop it here again.
-	 */
-	put_pi_state(pi_state);
+		put_pi_state(pi_state);
=20
 out_unlock:
-	double_unlock_hb(hb1, hb2);
+		double_unlock_hb(hb1, hb2);
+		futex_hb_waiters_dec(hb2);
+	}
 	wake_up_q(&wake_q);
-	futex_hb_waiters_dec(hb2);
 	return ret ? ret : task_count;
 }
=20
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 1108f373fd315..4bf839c85b66c 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -253,7 +253,6 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flag=
s, u32 __user *uaddr2,
 		  int nr_wake, int nr_wake2, int op)
 {
 	union futex_key key1 =3D FUTEX_KEY_INIT, key2 =3D FUTEX_KEY_INIT;
-	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	int ret, op_ret;
 	DEFINE_WAKE_Q(wake_q);
@@ -266,67 +265,71 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int fl=
ags, u32 __user *uaddr2,
 	if (unlikely(ret !=3D 0))
 		return ret;
=20
-	hb1 =3D futex_hash(&key1);
-	hb2 =3D futex_hash(&key2);
-
 retry_private:
-	double_lock_hb(hb1, hb2);
-	op_ret =3D futex_atomic_op_inuser(op, uaddr2);
-	if (unlikely(op_ret < 0)) {
-		double_unlock_hb(hb1, hb2);
+	if (1) {
+		struct futex_hash_bucket *hb1, *hb2;
=20
-		if (!IS_ENABLED(CONFIG_MMU) ||
-		    unlikely(op_ret !=3D -EFAULT && op_ret !=3D -EAGAIN)) {
-			/*
-			 * we don't get EFAULT from MMU faults if we don't have
-			 * an MMU, but we might get them from range checking
-			 */
-			ret =3D op_ret;
-			return ret;
-		}
+		hb1 =3D futex_hash(&key1);
+		hb2 =3D futex_hash(&key2);
=20
-		if (op_ret =3D=3D -EFAULT) {
-			ret =3D fault_in_user_writeable(uaddr2);
-			if (ret)
+		double_lock_hb(hb1, hb2);
+		op_ret =3D futex_atomic_op_inuser(op, uaddr2);
+		if (unlikely(op_ret < 0)) {
+			double_unlock_hb(hb1, hb2);
+
+			if (!IS_ENABLED(CONFIG_MMU) ||
+			    unlikely(op_ret !=3D -EFAULT && op_ret !=3D -EAGAIN)) {
+				/*
+				 * we don't get EFAULT from MMU faults if we don't have
+				 * an MMU, but we might get them from range checking
+				 */
+				ret =3D op_ret;
 				return ret;
-		}
-
-		cond_resched();
-		if (!(flags & FLAGS_SHARED))
-			goto retry_private;
-		goto retry;
-	}
-
-	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
-		if (futex_match (&this->key, &key1)) {
-			if (this->pi_state || this->rt_waiter) {
-				ret =3D -EINVAL;
-				goto out_unlock;
 			}
-			this->wake(&wake_q, this);
-			if (++ret >=3D nr_wake)
-				break;
-		}
-	}
=20
-	if (op_ret > 0) {
-		op_ret =3D 0;
-		plist_for_each_entry_safe(this, next, &hb2->chain, list) {
-			if (futex_match (&this->key, &key2)) {
+			if (op_ret =3D=3D -EFAULT) {
+				ret =3D fault_in_user_writeable(uaddr2);
+				if (ret)
+					return ret;
+			}
+
+			cond_resched();
+			if (!(flags & FLAGS_SHARED))
+				goto retry_private;
+			goto retry;
+		}
+
+		plist_for_each_entry_safe(this, next, &hb1->chain, list) {
+			if (futex_match (&this->key, &key1)) {
 				if (this->pi_state || this->rt_waiter) {
 					ret =3D -EINVAL;
 					goto out_unlock;
 				}
 				this->wake(&wake_q, this);
-				if (++op_ret >=3D nr_wake2)
+				if (++ret >=3D nr_wake)
 					break;
 			}
 		}
-		ret +=3D op_ret;
-	}
+
+		if (op_ret > 0) {
+			op_ret =3D 0;
+			plist_for_each_entry_safe(this, next, &hb2->chain, list) {
+				if (futex_match (&this->key, &key2)) {
+					if (this->pi_state || this->rt_waiter) {
+						ret =3D -EINVAL;
+						goto out_unlock;
+					}
+					this->wake(&wake_q, this);
+					if (++op_ret >=3D nr_wake2)
+						break;
+				}
+			}
+			ret +=3D op_ret;
+		}
=20
 out_unlock:
-	double_unlock_hb(hb1, hb2);
+		double_unlock_hb(hb1, hb2);
+	}
 	wake_up_q(&wake_q);
 	return ret;
 }
@@ -402,7 +405,6 @@ int futex_unqueue_multiple(struct futex_vector *v, int =
count)
  */
 int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wok=
en)
 {
-	struct futex_hash_bucket *hb;
 	bool retry =3D false;
 	int ret, i;
 	u32 uval;
@@ -441,21 +443,25 @@ int futex_wait_multiple_setup(struct futex_vector *vs=
, int count, int *woken)
 		struct futex_q *q =3D &vs[i].q;
 		u32 val =3D vs[i].w.val;
=20
-		hb =3D futex_hash(&q->key);
-		futex_q_lock(q, hb);
-		ret =3D futex_get_value_locked(&uval, uaddr);
+		if (1) {
+			struct futex_hash_bucket *hb;
=20
-		if (!ret && uval =3D=3D val) {
-			/*
-			 * The bucket lock can't be held while dealing with the
-			 * next futex. Queue each futex at this moment so hb can
-			 * be unlocked.
-			 */
-			futex_queue(q, hb, current);
-			continue;
+			hb =3D futex_hash(&q->key);
+			futex_q_lock(q, hb);
+			ret =3D futex_get_value_locked(&uval, uaddr);
+
+			if (!ret && uval =3D=3D val) {
+				/*
+				 * The bucket lock can't be held while dealing with the
+				 * next futex. Queue each futex at this moment so hb can
+				 * be unlocked.
+				 */
+				futex_queue(q, hb, current);
+				continue;
+			}
+
+			futex_q_unlock(hb);
 		}
-
-		futex_q_unlock(hb);
 		__set_current_state(TASK_RUNNING);
=20
 		/*
@@ -584,7 +590,6 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsign=
ed int flags,
 		     struct futex_q *q, union futex_key *key2,
 		     struct task_struct *task)
 {
-	struct futex_hash_bucket *hb;
 	u32 uval;
 	int ret;
=20
@@ -612,44 +617,48 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsi=
gned int flags,
 		return ret;
=20
 retry_private:
-	hb =3D futex_hash(&q->key);
-	futex_q_lock(q, hb);
+	if (1) {
+		struct futex_hash_bucket *hb;
=20
-	ret =3D futex_get_value_locked(&uval, uaddr);
+		hb =3D futex_hash(&q->key);
+		futex_q_lock(q, hb);
=20
-	if (ret) {
-		futex_q_unlock(hb);
+		ret =3D futex_get_value_locked(&uval, uaddr);
=20
-		ret =3D get_user(uval, uaddr);
-		if (ret)
-			return ret;
+		if (ret) {
+			futex_q_unlock(hb);
=20
-		if (!(flags & FLAGS_SHARED))
-			goto retry_private;
+			ret =3D get_user(uval, uaddr);
+			if (ret)
+				return ret;
=20
-		goto retry;
+			if (!(flags & FLAGS_SHARED))
+				goto retry_private;
+
+			goto retry;
+		}
+
+		if (uval !=3D val) {
+			futex_q_unlock(hb);
+			return -EWOULDBLOCK;
+		}
+
+		if (key2 && futex_match(&q->key, key2)) {
+			futex_q_unlock(hb);
+			return -EINVAL;
+		}
+
+		/*
+		 * The task state is guaranteed to be set before another task can
+		 * wake it. set_current_state() is implemented using smp_store_mb() and
+		 * futex_queue() calls spin_unlock() upon completion, both serializing
+		 * access to the hash list and forcing another memory barrier.
+		 */
+		if (task =3D=3D current)
+			set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+		futex_queue(q, hb, task);
 	}
=20
-	if (uval !=3D val) {
-		futex_q_unlock(hb);
-		return -EWOULDBLOCK;
-	}
-
-	if (key2 && futex_match(&q->key, key2)) {
-		futex_q_unlock(hb);
-		return -EINVAL;
-	}
-
-	/*
-	 * The task state is guaranteed to be set before another task can
-	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * futex_queue() calls spin_unlock() upon completion, both serializing
-	 * access to the hash list and forcing another memory barrier.
-	 */
-	if (task =3D=3D current)
-		set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
-	futex_queue(q, hb, task);
-
 	return ret;
 }
=20
--=20
2.47.2


