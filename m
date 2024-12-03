Return-Path: <linux-kernel+bounces-429870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3CA9E27ED
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7D028827F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD87E1F9A94;
	Tue,  3 Dec 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3zW1BJfp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dkSd5yJU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129C1FA16E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244225; cv=none; b=DRSVFjrDUbSSYq6Kow8hSNjrfSPtxnRVI0JeWhHL9R3t+6MN5q7e+cQ7kKrctYwFoVeaK5UHlsnHftAEN1ChhrIsZUw05Z0VZRUkOsQOt0P9hr5FQ5a3OzEESCw008Srs8fsJYL+VuCJEqRnTFOuPothmfisyGEn62Ncnbq6zfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244225; c=relaxed/simple;
	bh=1P4wggfGo8N1lrg78RRL3VO1TQ2jPBcoWG7btPF78Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hls6kQiCF7+26R/81uaE7otQ/6J+jRv1Kor6v6uL7CHlWowKKnepgjcuBVTkWYjhXwHsoMi2eNaQsdRjvVcvLpUobA2/2dS8McYjYkBdVrYtaemSgfoCrmGMyb6+CRsP0C5msBS5gfSUdkOMqEHZ43TaKkrfg0VvdHNPfpdE8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3zW1BJfp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dkSd5yJU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8OQB/9UCvB6TFuSmvXUFUtblQYkeKf7yS+DTrnPZFE=;
	b=3zW1BJfp7u0sm1WWs79AqoX5YZqluSJRB6eLl4OV67zpBT7xOlI4lPdHPtl5btTRNHEtda
	xRA6+H9QsI9ImbfX30IBPT76pa08YC6dlkMdbce1SCrCWBOxIUKS85bwd8tAscrMbSaaSb
	y+Aymxhf/vGVFfpVYFtWVDm0lyN/vItwIp5Rf8NUDR8hu8cr9vrMvq7d9wlpzzfYLZjzBl
	1OcJvqTN2nNQXT7/CKAKbwjVPHmhHwTynPW4D/QvVD3en1FsecIaX68e/b2dtkVSnib3vO
	aSLZkVSeRCzaEEnVEGI/uUhvonbAPXhDyIk7HFJiox4AYeEBR4DaIJ8lEoLT0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8OQB/9UCvB6TFuSmvXUFUtblQYkeKf7yS+DTrnPZFE=;
	b=dkSd5yJU5+fMVORP0l34vwb7IQ4nB+OhzITG0LtMSo2vFLkCmQE84d2JJcHsGmetaoBnPG
	w8I8TaI0dNWNZOCw==
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
Subject: [PATCH v4 06/11] futex: Allow to re-allocate the private hash bucket.
Date: Tue,  3 Dec 2024 17:42:14 +0100
Message-ID: <20241203164335.1125381-7-bigeasy@linutronix.de>
In-Reply-To: <20241203164335.1125381-1-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mm_struct::futex_hash_lock guards the futex_hash_bucket assignment/
replacement. The futex_hash_allocate()/ PR_FUTEX_HASH_SET_SLOTS
operation can now be invoked at runtime and resize the internal private
futex_hash_bucket to another size.
The idea is to use the recently introduced ref counting to keep a
currently used HB around. On resize/ replacement a new HB (array) is
assigned to the process. All users on the old HB will receive a wakeup
so they can dequeue them self from the old hb and enqueue on the new one.

In the WAIT case, after a wakeup the needs to check if a successful
wake up occurred and if not and the HB changed just dequeue + enqueue and
wait again.
In the WAKE case, it needs to iterate over all waiters. If a the HB
changed then the waiter can not disappear. New waiters will use the new
HB and therefore will be missed. Therefore it will try again if the HB
changed and it may wake more tasks.
The same logic applies to REQUEUE.

LOCK_PI, UNLOCK_PI and its REQUEUE_PI part are slightly more
complicated due to the internal kernel state. If the HB changes then we
have the old PI state created by the first waiter and possible a new PI
state created by waiter on the new HB lock.
On LOCK_PI, if the HB changed it needs to abandon the PI state it may
have acquired the lock on PI state but everyone else might use the "new"
PI state. This PI state won't be used anymore because every water will
requeue. It is needed to check the UADDR if the lock has been passed by
UNLOCK_PI prio the HB change or if were woken up due to the HB change.
If we own the lock based on UADDR, we own it otherwise we retry.
UNLOCK_PI takes the first waiter and passes the lock. If there is no
waiter then it updates the UADDR to 0. Before the update succeeds the HB
can change and a waiter can setup a new PI state based for the UNLOCK_PI
caller and wait on it. To complicate it further, userland can acquire
the lock at this time. This may happen because new waiter no longer
block on the hb lock. To avoid this race, futex_hash_lock is acquired
for the update to 0 ensure the HB can't change and all waiter will
block.
The same logic applies to REQUEUE_PI. WAIT_REQUEUE_PI tries to recover
from a HB change in a similar way LOCK_PI does. If the requeue occurred
but it waits already on UADDR2 then for the last step it simply invokes
futex_lock_pi().
CMP_REQUEUE_PI follows the UNLOCK_PI logic and acquires futex_hash_lock
for the whole operation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h           |   1 +
 include/linux/mm_types.h        |   1 +
 kernel/futex/core.c             |  65 ++++++++++++++++---
 kernel/futex/futex.h            |   3 +
 kernel/futex/pi.c               | 110 +++++++++++++++++++++++++++++++-
 kernel/futex/requeue.c          |  74 ++++++++++++++++++++-
 kernel/futex/waitwake.c         |  42 ++++++++++--
 kernel/locking/rtmutex.c        |  26 ++++++++
 kernel/locking/rtmutex_common.h |   5 +-
 9 files changed, 308 insertions(+), 19 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 359fc24eb37ff..ce9e284bbeb09 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -85,6 +85,7 @@ void futex_hash_free(struct mm_struct *mm);
 static inline void futex_mm_init(struct mm_struct *mm)
 {
 	rcu_assign_pointer(mm->futex_hash_bucket, NULL);
+	init_rwsem(&mm->futex_hash_lock);
 }
=20
 #else
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4f39928631042..07f1567f2b51f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -903,6 +903,7 @@ struct mm_struct {
 		int mm_lock_seq;
 #endif
=20
+		struct rw_semaphore			futex_hash_lock;
 		struct futex_hash_bucket_private	__rcu *futex_hash_bucket;
=20
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 464918d85395e..0dd7100e36419 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -573,6 +573,7 @@ struct futex_hash_bucket *futex_q_lock(struct futex_q *=
q)
 {
 	struct futex_hash_bucket *hb;
=20
+try_again:
 	hb =3D futex_hash(&q->key);
=20
 	/*
@@ -588,7 +589,13 @@ struct futex_hash_bucket *futex_q_lock(struct futex_q =
*q)
 	q->lock_ptr =3D &hb->lock;
=20
 	spin_lock(&hb->lock);
-	return hb;
+	if (futex_check_hb_valid(hb))
+		return hb;
+
+	futex_hb_waiters_dec(hb);
+	spin_unlock(&hb->lock);
+	futex_hash_put(hb);
+	goto try_again;
 }
=20
 void futex_q_unlock(struct futex_hash_bucket *hb)
@@ -1217,18 +1224,50 @@ void futex_hash_free(struct mm_struct *mm)
 	futex_hash_priv_put(hb_p);
 }
=20
+static void futex_put_old_hb_p(struct futex_hash_bucket_private *hb_p)
+{
+	unsigned int slots =3D hb_p->hash_mask + 1;
+	struct futex_hash_bucket *hb;
+	DEFINE_WAKE_Q(wake_q);
+	unsigned int i;
+
+	for (i =3D 0; i < slots; i++) {
+		struct futex_q *this;
+
+		hb =3D &hb_p->queues[i];
+
+		spin_lock(&hb->lock);
+		plist_for_each_entry(this, &hb->chain, list)
+			wake_q_add(&wake_q, this->task);
+		spin_unlock(&hb->lock);
+	}
+	futex_hash_priv_put(hb_p);
+
+	wake_up_q(&wake_q);
+}
+
+bool futex_check_hb_valid(struct futex_hash_bucket *hb)
+{
+	struct futex_hash_bucket_private *hb_p_now;
+	struct futex_hash_bucket_private *hb_p;
+
+	if (hb->hb_slot =3D=3D 0)
+		return true;
+	guard(rcu)();
+	hb_p_now =3D rcu_dereference(current->mm->futex_hash_bucket);
+	hb_p =3D container_of(hb, struct futex_hash_bucket_private,
+			    queues[hb->hb_slot - 1]);
+
+	return hb_p_now =3D=3D hb_p;
+}
+
 static int futex_hash_allocate(unsigned int hash_slots)
 {
-	struct futex_hash_bucket_private *hb_p;
+	struct futex_hash_bucket_private *hb_p, *hb_p_old =3D NULL;
+	struct mm_struct *mm;
 	size_t alloc_size;
 	int i;
=20
-	if (current->mm->futex_hash_bucket)
-		return -EALREADY;
-
-	if (!thread_group_leader(current))
-		return -EINVAL;
-
 	if (hash_slots =3D=3D 0)
 		hash_slots =3D 16;
 	if (hash_slots < 2)
@@ -1256,7 +1295,15 @@ static int futex_hash_allocate(unsigned int hash_slo=
ts)
 	for (i =3D 0; i < hash_slots; i++)
 		futex_hash_bucket_init(&hb_p->queues[i], i + 1);
=20
-	rcu_assign_pointer(current->mm->futex_hash_bucket, hb_p);
+	mm =3D current->mm;
+	scoped_guard(rwsem_write, &mm->futex_hash_lock) {
+		hb_p_old =3D rcu_dereference_check(mm->futex_hash_bucket,
+						 lockdep_is_held(&mm->futex_hash_lock));
+		rcu_assign_pointer(mm->futex_hash_bucket, hb_p);
+	}
+	if (hb_p_old)
+		futex_put_old_hb_p(hb_p_old);
+
 	return 0;
 }
=20
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index ceea260ad9e80..503f56643a966 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -205,6 +205,9 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper=
 *timeout,
 extern struct futex_hash_bucket *futex_hash(union futex_key *key);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
 extern void futex_hash_get(struct futex_hash_bucket *hb);
+extern bool futex_check_hb_valid(struct futex_hash_bucket *hb);
+extern bool check_pi_lock_owner(u32 __user *uaddr);
+extern void reset_pi_state_owner(struct futex_pi_state *pi_state);
=20
 static inline struct futex_hash_bucket *futex_hb_from_futex_q(struct futex=
_q *q)
 {
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 60a62ab250b08..b4156d1cc6608 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -43,8 +43,8 @@ static struct futex_pi_state *alloc_pi_state(void)
 	return pi_state;
 }
=20
-static void pi_state_update_owner(struct futex_pi_state *pi_state,
-				  struct task_struct *new_owner)
+void pi_state_update_owner(struct futex_pi_state *pi_state,
+			   struct task_struct *new_owner)
 {
 	struct task_struct *old_owner =3D pi_state->owner;
=20
@@ -854,6 +854,47 @@ static int fixup_pi_state_owner(u32 __user *uaddr, str=
uct futex_q *q,
 	return ret;
 }
=20
+bool check_pi_lock_owner(u32 __user *uaddr)
+{
+	u32 our_tid, uval;
+	int ret;
+
+	our_tid =3D task_pid_vnr(current);
+	do {
+		ret =3D futex_get_value_locked(&uval, uaddr);
+		switch (ret) {
+		case 0:
+			if ((uval & FUTEX_TID_MASK) =3D=3D our_tid)
+				return true;
+			return false;
+			break;
+
+		case -EFAULT:
+			ret =3D fault_in_user_writeable(uaddr);
+			if (ret < 0)
+				return false;
+			break;
+
+		case -EAGAIN:
+			cond_resched();
+			break;
+
+		default:
+			WARN_ON_ONCE(1);
+			return false;
+		}
+
+	} while (1);
+}
+
+void reset_pi_state_owner(struct futex_pi_state *pi_state)
+{
+	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
+	pi_state_update_owner(pi_state, NULL);
+	pi_state->owner =3D NULL;
+	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
+}
+
 /**
  * fixup_pi_owner() - Post lock pi_state and corner case management
  * @uaddr:	user address of the futex
@@ -999,6 +1040,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flag=
s, ktime_t *time, int tryl
 	rt_mutex_pre_schedule();
=20
 	rt_mutex_init_waiter(&rt_waiter);
+	rt_waiter.hb =3D hb;
=20
 	/*
 	 * On PREEMPT_RT, when hb->lock becomes an rt_mutex, we must not
@@ -1070,6 +1112,37 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fl=
ags, ktime_t *time, int tryl
 	 */
 	rt_mutex_post_schedule();
 no_block:
+	if (!futex_check_hb_valid(hb)) {
+		bool uaddr_owner;
+		/*
+		 * We might got the lock, we might not. We own the outdated internal
+		 * state because the HB changed under us so it might have been all
+		 * for nothing.
+		 * We need to reset the pi_state and its owner because it
+		 * points to current owner of the lock but it is not what new
+		 * lock/ unlock caller will see so it needs a clean up. If we own
+		 * the lock according to uaddr then it has been passed to us by an
+		 * unlock and we got it before the HB changed. Lucky us, we keep
+		 * it. If we were able to steal it or did not get it in the
+		 * first place then we need to try again with the HB in place.
+		 */
+		reset_pi_state_owner(q.pi_state);
+		futex_unqueue_pi(&q);
+		spin_unlock(q.lock_ptr);
+		futex_hash_put(hb);
+
+		uaddr_owner =3D check_pi_lock_owner(uaddr);
+		if (uaddr_owner) {
+			ret =3D 0;
+			goto out;
+		}
+
+		if (refill_pi_state_cache()) {
+			ret =3D -ENOMEM;
+			goto out;
+		}
+		goto retry_private;
+	}
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
 	 * haven't already.
@@ -1121,6 +1194,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 {
 	u32 curval, uval, vpid =3D task_pid_vnr(current);
 	union futex_key key =3D FUTEX_KEY_INIT;
+	struct rw_semaphore *futex_hash_lock =3D NULL;
 	struct futex_hash_bucket *hb;
 	struct futex_q *top_waiter;
 	int ret;
@@ -1128,6 +1202,8 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 	if (!IS_ENABLED(CONFIG_FUTEX_PI))
 		return -ENOSYS;
=20
+	if (!(flags & FLAGS_SHARED))
+		futex_hash_lock =3D &current->mm->futex_hash_lock;
 retry:
 	if (get_user(uval, uaddr))
 		return -EFAULT;
@@ -1232,6 +1308,32 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int =
flags)
 		return ret;
 	}
=20
+	/*
+	 * If the hb changed before the following cmpxchg finished then the
+	 * situtation gets complicated as we don't own the lock anymore but
+	 * there could be an internal state recorded under our name by the
+	 * waiter under a different hb->lock. Also the PI-lock could be snuck in
+	 * userland so there is no guarantee that we get it back.
+	 * To avoid the mess due to this tiny race, ensure that the HB can not
+	 * be resized while the PI lock with no owner is unlocked.
+	 */
+	if (futex_hash_lock) {
+		spin_unlock(&hb->lock);
+		down_read(futex_hash_lock);
+		spin_lock(&hb->lock);
+
+		if (!futex_check_hb_valid(hb)) {
+			spin_unlock(&hb->lock);
+			up_read(futex_hash_lock);
+			futex_hash_put(hb);
+			goto retry;
+		}
+		if (futex_top_waiter(hb, &key)) {
+			up_read(futex_hash_lock);
+			goto retry_hb;
+		}
+	}
+
 	/*
 	 * We have no kernel internal state, i.e. no waiters in the
 	 * kernel. Waiters which are about to queue themselves are stuck
@@ -1241,6 +1343,8 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 	 */
 	if ((ret =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, 0))) {
 		spin_unlock(&hb->lock);
+		if (futex_hash_lock)
+			up_read(futex_hash_lock);
 		futex_hash_put(hb);
 		switch (ret) {
 		case -EFAULT:
@@ -1254,6 +1358,8 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 			return ret;
 		}
 	}
+	if (futex_hash_lock)
+		up_read(futex_hash_lock);
=20
 	/*
 	 * If uval has changed, let user space handle it.
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 39e96f1bef8ce..6b3c4413fbf47 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -378,6 +378,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 	DEFINE_WAKE_Q(wake_q);
+	struct rw_semaphore *futex_hash_lock =3D NULL;
=20
 	if (nr_wake < 0 || nr_requeue < 0)
 		return -EINVAL;
@@ -429,6 +430,9 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 		 */
 		if (refill_pi_state_cache())
 			return -ENOMEM;
+
+		if (!(flags1 & FLAGS_SHARED) || !(flags2 & FLAGS_SHARED))
+			futex_hash_lock =3D &current->mm->futex_hash_lock;
 	}
=20
 retry:
@@ -447,10 +451,12 @@ int futex_requeue(u32 __user *uaddr1, unsigned int fl=
ags1,
 	if (requeue_pi && futex_match(&key1, &key2))
 		return -EINVAL;
=20
+retry_private:
+	if (futex_hash_lock)
+		down_read(futex_hash_lock);
 	hb1 =3D futex_hash(&key1);
 	hb2 =3D futex_hash(&key2);
=20
-retry_private:
 	futex_hb_waiters_inc(hb2);
 	double_lock_hb(hb1, hb2);
=20
@@ -465,6 +471,9 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 			futex_hash_put(hb1);
 			futex_hash_put(hb2);
=20
+			if (futex_hash_lock)
+				up_read(futex_hash_lock);
+
 			ret =3D get_user(curval, uaddr1);
 			if (ret)
 				return ret;
@@ -552,6 +561,9 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 			futex_hb_waiters_dec(hb2);
 			futex_hash_put(hb1);
 			futex_hash_put(hb2);
+			if (futex_hash_lock)
+				up_read(futex_hash_lock);
+
 			ret =3D fault_in_user_writeable(uaddr2);
 			if (!ret)
 				goto retry;
@@ -568,6 +580,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 			futex_hb_waiters_dec(hb2);
 			futex_hash_put(hb1);
 			futex_hash_put(hb2);
+			if (futex_hash_lock)
+				up_read(futex_hash_lock);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -687,6 +701,23 @@ int futex_requeue(u32 __user *uaddr1, unsigned int fla=
gs1,
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
 	futex_hb_waiters_dec(hb2);
+
+	/*
+	 * If there was no error in the process so far and we woke less than we
+	 * could have and hb changed then we try again in case we missed
+	 * someone.
+	 */
+	if (ret >=3D 0 &&
+	    !(task_count - nr_wake >=3D nr_requeue) &&
+	    (!futex_check_hb_valid(hb1) || !futex_check_hb_valid(hb2))) {
+		futex_hash_put(hb1);
+		futex_hash_put(hb2);
+		wake_q_init(&wake_q);
+		goto retry_private;
+	}
+	if (futex_hash_lock)
+		up_read(futex_hash_lock);
+
 	futex_hash_put(hb1);
 	futex_hash_put(hb2);
 	return ret ? ret : task_count;
@@ -783,8 +814,8 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
 	union futex_key key2 =3D FUTEX_KEY_INIT;
-	struct futex_q q =3D futex_q_init;
 	struct rt_mutex_base *pi_mutex;
+	struct futex_q q;
 	int res, ret;
=20
 	if (!IS_ENABLED(CONFIG_FUTEX_PI))
@@ -799,6 +830,8 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 	to =3D futex_setup_timer(abs_time, &timeout, flags,
 			       current->timer_slack_ns);
=20
+hb_changed_again:
+	q =3D futex_q_init;
 	/*
 	 * The waiter is allocated on our stack, manipulated by the requeue
 	 * code while we sleep on uaddr.
@@ -841,6 +874,12 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned =
int flags,
 		spin_lock(&hb->lock);
 		ret =3D handle_early_requeue_pi_wakeup(hb, &q, to);
 		spin_unlock(&hb->lock);
+
+		if (ret =3D=3D -EWOULDBLOCK && !futex_check_hb_valid(hb)) {
+			futex_hash_put(hb);
+			goto hb_changed_again;
+		}
+
 		futex_hash_put(hb);
 		break;
=20
@@ -865,6 +904,8 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 		break;
=20
 	case Q_REQUEUE_PI_DONE:
+		rt_waiter.hb =3D futex_hb_from_futex_q(&q);
+
 		/* Requeue completed. Current is 'pi_blocked_on' the rtmutex */
 		pi_mutex =3D &q.pi_state->pi_mutex;
 		ret =3D rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
@@ -876,6 +917,35 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned =
int flags,
 			ret =3D 0;
=20
 		spin_lock(q.lock_ptr);
+		if (!futex_check_hb_valid(rt_waiter.hb)) {
+			bool uaddr_owner;
+
+			debug_rt_mutex_free_waiter(&rt_waiter);
+			/*
+			 * The HB changed under us after we were requeued on
+			 * uaddr2. We may have acquire the lock on the pi_state
+			 * but this the state that is seen on the current HB.
+			 * However, there could also be an UNLOCK_PI event
+			 * before and we own the lock based on uaddr2.
+			 * Unlock so the next waiter can do the same and
+			 * acquire the PI lock on uaddr2.
+			 */
+			reset_pi_state_owner(q.pi_state);
+
+			futex_unqueue_pi(&q);
+			spin_unlock(q.lock_ptr);
+			futex_hash_put(futex_hb_from_futex_q(&q));
+
+			if (to) {
+				hrtimer_cancel(&to->timer);
+				destroy_hrtimer_on_stack(&to->timer);
+			}
+			uaddr_owner =3D check_pi_lock_owner(uaddr2);
+			if (uaddr_owner)
+				return 0;
+
+			return futex_lock_pi(uaddr2, flags, abs_time, 0);
+		}
 		debug_rt_mutex_free_waiter(&rt_waiter);
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 1f2d11eb7f89f..0179b61877529 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -180,6 +180,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, i=
nt nr_wake, u32 bitset)
 		return ret;
 	}
=20
+again_hb_change:
 	spin_lock(&hb->lock);
=20
 	plist_for_each_entry_safe(this, next, &hb->chain, list) {
@@ -200,6 +201,16 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, =
int nr_wake, u32 bitset)
 	}
=20
 	spin_unlock(&hb->lock);
+	/*
+	 * If there was no error, we woke less than we could have and the hb
+	 * changed then we try again.
+	 */
+	if (ret > 0 && ret < nr_wake && !futex_check_hb_valid(hb)) {
+		futex_hash_put(hb);
+		hb =3D futex_hash(&key);
+		if (futex_hb_waiters_pending(hb))
+			goto again_hb_change;
+	}
 	futex_hash_put(hb);
 	wake_up_q(&wake_q);
 	return ret;
@@ -261,7 +272,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flag=
s, u32 __user *uaddr2,
 	union futex_key key1 =3D FUTEX_KEY_INIT, key2 =3D FUTEX_KEY_INIT;
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
-	int ret, op_ret;
+	int ret, op_ret, op_woke;
 	DEFINE_WAKE_Q(wake_q);
=20
 retry:
@@ -272,11 +283,19 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int fl=
ags, u32 __user *uaddr2,
 	if (unlikely(ret !=3D 0))
 		return ret;
=20
+retry_hash:
 	hb1 =3D futex_hash(&key1);
 	hb2 =3D futex_hash(&key2);
=20
 retry_private:
 	double_lock_hb(hb1, hb2);
+	if (!futex_check_hb_valid(hb1) || !futex_check_hb_valid(hb2)) {
+		double_unlock_hb(hb1, hb2);
+		futex_hash_put(hb1);
+		futex_hash_put(hb2);
+		goto retry_hash;
+	}
+
 	op_ret =3D futex_atomic_op_inuser(op, uaddr2);
 	if (unlikely(op_ret < 0)) {
 		double_unlock_hb(hb1, hb2);
@@ -305,6 +324,8 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flag=
s, u32 __user *uaddr2,
 		goto retry;
 	}
=20
+	op_woke =3D 0;
+retry_wake:
 	plist_for_each_entry_safe(this, next, &hb1->chain, list) {
 		if (futex_match (&this->key, &key1)) {
 			if (this->pi_state || this->rt_waiter) {
@@ -318,7 +339,6 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flag=
s, u32 __user *uaddr2,
 	}
=20
 	if (op_ret > 0) {
-		op_ret =3D 0;
 		plist_for_each_entry_safe(this, next, &hb2->chain, list) {
 			if (futex_match (&this->key, &key2)) {
 				if (this->pi_state || this->rt_waiter) {
@@ -326,19 +346,31 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int fl=
ags, u32 __user *uaddr2,
 					goto out_unlock;
 				}
 				this->wake(&wake_q, this);
-				if (++op_ret >=3D nr_wake2)
+				if (++op_woke >=3D nr_wake2)
 					break;
 			}
 		}
-		ret +=3D op_ret;
 	}
=20
 out_unlock:
 	double_unlock_hb(hb1, hb2);
+	if (ret >=3D 0 &&
+	    (!(ret >=3D nr_wake) || !(op_woke >=3D nr_wake2)) &&
+	    (!futex_check_hb_valid(hb1) || !futex_check_hb_valid(hb2))) {
+
+		futex_hash_put(hb1);
+		futex_hash_put(hb2);
+		hb1 =3D futex_hash(&key1);
+		hb2 =3D futex_hash(&key2);
+		double_lock_hb(hb1, hb2);
+		goto retry_wake;
+	}
+
 	wake_up_q(&wake_q);
+
 	futex_hash_put(hb1);
 	futex_hash_put(hb2);
-	return ret;
+	return ret < 0 ? ret : ret + op_woke;
 }
=20
 static long futex_wait_restart(struct restart_block *restart);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ac1365afcc4a5..ce1cf32dc7ed0 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -58,10 +58,29 @@ static inline int __ww_mutex_check_kill(struct rt_mutex=
 *lock,
 	return 0;
 }
=20
+extern bool futex_check_hb_valid(struct futex_hash_bucket *hb);
+
+static inline bool __internal_retry_reason(struct rt_mutex_waiter *waiter)
+{
+	if (!IS_ENABLED(CONFIG_FUTEX))
+		return false;
+
+	if (!waiter->hb)
+		return false;
+	if (futex_check_hb_valid(waiter->hb))
+		return false;
+	return true;
+}
+
 #else
 # define build_ww_mutex()	(true)
 # define ww_container_of(rtm)	container_of(rtm, struct ww_mutex, base)
 # include "ww_mutex.h"
+
+static inline bool __internal_retry_reason(struct rt_mutex_waiter *waiter)
+{
+	return false;
+}
 #endif
=20
 /*
@@ -1633,6 +1652,13 @@ static int __sched rt_mutex_slowlock_block(struct rt=
_mutex_base *lock,
 				break;
 		}
=20
+		if (!build_ww_mutex()) {
+			if (__internal_retry_reason(waiter)) {
+				ret =3D -EAGAIN;
+				break;
+			}
+		}
+
 		if (waiter =3D=3D rt_mutex_top_waiter(lock))
 			owner =3D rt_mutex_owner(lock);
 		else
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_commo=
n.h
index c38a2d2d4a7ee..3bd0925a73a6a 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -56,6 +56,7 @@ struct rt_mutex_waiter {
 	struct rt_mutex_base	*lock;
 	unsigned int		wake_state;
 	struct ww_acquire_ctx	*ww_ctx;
+	struct futex_hash_bucket *hb;
 };
=20
 /**
@@ -100,7 +101,8 @@ extern int __rt_mutex_futex_trylock(struct rt_mutex_bas=
e *l);
 extern void rt_mutex_futex_unlock(struct rt_mutex_base *lock);
 extern bool __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
 				struct rt_wake_q_head *wqh);
-
+extern void pi_state_update_owner(struct futex_pi_state *pi_state,
+				  struct task_struct *new_owner);
 extern void rt_mutex_postunlock(struct rt_wake_q_head *wqh);
=20
 /*
@@ -216,6 +218,7 @@ static inline void rt_mutex_init_waiter(struct rt_mutex=
_waiter *waiter)
 	RB_CLEAR_NODE(&waiter->tree.entry);
 	waiter->wake_state =3D TASK_NORMAL;
 	waiter->task =3D NULL;
+	waiter->hb =3D NULL;
 }
=20
 static inline void rt_mutex_init_rtlock_waiter(struct rt_mutex_waiter *wai=
ter)
--=20
2.45.2


