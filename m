Return-Path: <linux-kernel+bounces-446635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5FB9F275B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE371884634
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B11D5AB8;
	Sun, 15 Dec 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eW9OsYBg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ly1z6IbL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFACF1CCEF8
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304020; cv=none; b=t/xgU6vl1O5dkaP1f3ko9mTcwYnpV0SWJECqRVOydS14LVTUraxZqV+3q2fhSA7uK04xWYjq0mE4LSpN3UpCH/1VL/JiMswQHnLLCHaRcbcAqgnswO7Xz3p216lXqMLaX3+h/8X3IneJ4Toz4G5ZCxFp6nflxSXzNUgFI+vwyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304020; c=relaxed/simple;
	bh=kwdf7FnpnKp/razSaMtYYvLUagOr6onBiGOeyXzLbl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2OkIop7YeUvobf2rAgYtaTlpca60Hnu9RQnPErR5BwUVBC5ciYjON6XT1b5I745iz0bY2t2+qFxvHqnx/CvHxZqZHvPBbwEzOWmPe9iDQKpxLeCgefHZMqf26uleb8/m0yjYXzTvKt/oOzkpIG0EFx4aTpJ9/Q1NfiKJZdNkhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eW9OsYBg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ly1z6IbL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHrceZ449XC5Ya6yQJk3mw9ylGHggZCqe4BUBnkBmN8=;
	b=eW9OsYBgogh7XXnVKiPp7Fr/IL06bNel+KTypJkmMX6IJ10iteymw5sgL+Qop3eKhFXnV9
	GSM/n71xs3HnJkcH7pV4h3zz3mOGhRxVoO+BApKVlCMyAtSaLmuSFXiP9Ju3AAJkxmz4NC
	HzEhE2EC6P1GYfsS9OZTQfHt2VBQA+FkWcUomqORNvLJrlCrGYeMz4bdk+asBxil2qc5ll
	250vPHALD68qkHFQ7BogS4QqBsCjHn04OgOPuGAqpromYDFm6/oG11L1pwwbB+FFVpTtbp
	oqhvW+s6c837GqsZBVPosMvWmyGURovoaet7MRqO6scO1wWa6SHG4aE3lT8LEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHrceZ449XC5Ya6yQJk3mw9ylGHggZCqe4BUBnkBmN8=;
	b=Ly1z6IbLoo42+z98vqUV83M/M52QBFSsQE7HsQ/J/N6ItTJESeEiw2u9NYXipeyGfUVpVQ
	SIfzaaRn3nbhgwAg==
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
Subject: [PATCH v5 09/14] futex: Allow to re-allocate the private hash bucket.
Date: Mon, 16 Dec 2024 00:00:13 +0100
Message-ID: <20241215230642.104118-10-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mm_struct::futex_hash_lock guards the futex_hash_bucket assignment/
replacement. The futex_hash_allocate()/ PR_FUTEX_HASH_SET_SLOTS
operation can now be invoked at runtime and resize an already existing
internal private futex_hash_bucket to another size.

The reallocation is based on an idea by Thomas Gleixner: The initial
allocation of struct futex_hash_bucket_private set the reference count
to one. Every user acquires a reference on the hb before using it and
drops it after it enqueued itself on the hash bucket. This means that
there is no reference held while the task is scheduled out while waiting
for the wake up.
The resize allocates a new futex_hash_bucket_private and drops the
initial reference under the mm_struct::futex_hash_lock. If the reference
drop results in destruction of the object then users currently queued on
the hash bucket(s) will be requeued on the new hash bucket. At the end
mm_struct::futex_hash_bucket is updated, the old pointer is RCU freed
and the mutex is dropped.
If the reference drop does not result in destruction of the object then
the new pointer is saved as mm_struct::futex_hash_new. In this case
replacement is delayed to the user that drops the last reference. All
new user, that fail to acquire a reference, block on
mm_struct::futex_hash_lock and attempt to perform the replacement.

This scheme keeps the requirement that during a lock/ unlock operation
all waiter block on the same futex_hash_bucket::lock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h    |   3 +-
 include/linux/mm_types.h |   7 +-
 kernel/futex/core.c      | 243 +++++++++++++++++++++++++++++++++++----
 kernel/futex/futex.h     |   1 +
 kernel/futex/requeue.c   |   5 +
 kernel/futex/waitwake.c  |   4 +-
 6 files changed, 237 insertions(+), 26 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index bad377c30de5e..3ced01a9c5218 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -83,7 +83,8 @@ void futex_hash_free(struct mm_struct *mm);
=20
 static inline void futex_mm_init(struct mm_struct *mm)
 {
-	mm->futex_hash_bucket =3D NULL;
+	rcu_assign_pointer(mm->futex_hash_bucket, NULL);
+	mutex_init(&mm->futex_hash_lock);
 }
=20
 static inline bool futex_hash_requires_allocation(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2337a2e481fd0..62fe872b381f8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -30,7 +30,7 @@
 #define INIT_PASID	0
=20
 struct address_space;
-struct futex_hash_bucket;
+struct futex_hash_bucket_private;
 struct mem_cgroup;
=20
 /*
@@ -904,8 +904,9 @@ struct mm_struct {
 #endif
=20
 #ifdef CONFIG_FUTEX
-		unsigned int			futex_hash_mask;
-		struct futex_hash_bucket	*futex_hash_bucket;
+		struct mutex				futex_hash_lock;
+		struct futex_hash_bucket_private	__rcu *futex_hash_bucket;
+		struct futex_hash_bucket_private	*futex_hash_new;
 #endif
=20
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 6bccf48cdb049..f80ae39f2a83a 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -40,6 +40,7 @@
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
 #include <linux/prctl.h>
+#include <linux/rcuref.h>
=20
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -56,6 +57,12 @@ static struct {
 #define futex_queues   (__futex_data.queues)
 #define futex_hashsize (__futex_data.hashsize)
=20
+struct futex_hash_bucket_private {
+	rcuref_t	users;
+	unsigned int	hash_mask;
+	struct rcu_head rcu;
+	struct futex_hash_bucket queues[];
+};
=20
 /*
  * Fault injections for futexes.
@@ -129,6 +136,148 @@ static struct futex_hash_bucket *futex_hash_private(u=
nion futex_key *key,
 	return &fhb[hash & hash_mask];
 }
=20
+static void futex_rehash_current_users(struct futex_hash_bucket_private *o=
ld,
+				       struct futex_hash_bucket_private *new)
+{
+	struct futex_hash_bucket *hb_old, *hb_new;
+	unsigned int slots =3D old->hash_mask + 1;
+	u32 hash_mask =3D new->hash_mask;
+	unsigned int i;
+
+	for (i =3D 0; i < slots; i++) {
+		struct futex_q *this, *tmp;
+
+		hb_old =3D &old->queues[i];
+
+		spin_lock(&hb_old->lock);
+		plist_for_each_entry_safe(this, tmp, &hb_old->chain, list) {
+
+			plist_del(&this->list, &hb_old->chain);
+			futex_hb_waiters_dec(hb_old);
+
+			WARN_ON_ONCE(this->lock_ptr !=3D &hb_old->lock);
+
+			hb_new =3D futex_hash_private(&this->key, new->queues, hash_mask);
+			futex_hb_waiters_inc(hb_new);
+			/*
+			 * The new pointer isn't published yet but an already
+			 * moved user can unqueue itself so locking is needed.
+			 */
+			spin_lock_nested(&hb_new->lock, SINGLE_DEPTH_NESTING);
+			plist_add(&this->list, &hb_new->chain);
+			this->lock_ptr =3D &hb_new->lock;
+			spin_unlock(&hb_new->lock);
+		}
+		spin_unlock(&hb_old->lock);
+	}
+}
+
+struct futex_assign_cleanup {
+	struct futex_hash_bucket_private *rcu;
+	struct futex_hash_bucket_private *free;
+	struct futex_hash_bucket_private *free2;
+};
+
+static void __futex_assign_new_hb(struct futex_hash_bucket_private *hb_p_n=
ew,
+				  struct mm_struct *mm,
+				  struct futex_assign_cleanup *fu_cleanup)
+{
+	struct futex_hash_bucket_private *hb_p;
+	bool drop_last_ref =3D hb_p_new !=3D NULL;
+
+	/*
+	 * If the supplied hb_p is NULL then we must have one in mm. We might
+	 * have both. The pointer with the larger amount of slots is
+	 * considered. If we are late, we have none and someone else did the
+	 * work while we blocked on the lock.
+	 */
+	if (mm->futex_hash_new) {
+		if (hb_p_new) {
+			if (mm->futex_hash_new->hash_mask <=3D hb_p_new->hash_mask) {
+				fu_cleanup->free =3D mm->futex_hash_new;
+			} else {
+				fu_cleanup->free =3D hb_p_new;
+				hb_p_new =3D mm->futex_hash_new;
+			}
+		} else {
+			hb_p_new =3D mm->futex_hash_new;
+		}
+		mm->futex_hash_new =3D NULL;
+	}
+
+	/* Someone was quicker, the current mask is valid */
+	if (!hb_p_new)
+		return;
+
+	hb_p =3D rcu_dereference_check(mm->futex_hash_bucket,
+				     lockdep_is_held(&mm->futex_hash_lock));
+	if (hb_p) {
+		if (hb_p->hash_mask >=3D hb_p_new->hash_mask) {
+			/* It was increased again while we were waiting */
+			fu_cleanup->free2 =3D hb_p_new;
+			return;
+		}
+
+		if (drop_last_ref && !rcuref_put(&hb_p->users)) {
+			/* We are not the last user, let the last one continue */
+			mm->futex_hash_new =3D hb_p_new;
+			return;
+		}
+
+		futex_rehash_current_users(hb_p, hb_p_new);
+		fu_cleanup->rcu =3D hb_p;
+	}
+	rcu_assign_pointer(mm->futex_hash_bucket, hb_p_new);
+}
+
+static void futex_assign_cleanup(struct futex_assign_cleanup *fu_cleanup)
+{
+	kvfree(fu_cleanup->free);
+	kvfree(fu_cleanup->free2);
+	kvfree_rcu(fu_cleanup->rcu, rcu);
+}
+
+static void futex_assign_new_hb(struct futex_hash_bucket_private *hb_p_new)
+{
+	struct futex_assign_cleanup fu_cleanup =3D {};
+	struct mm_struct *mm =3D current->mm;
+
+	scoped_guard(mutex, &mm->futex_hash_lock)
+		__futex_assign_new_hb(hb_p_new, mm, &fu_cleanup);
+	futex_assign_cleanup(&fu_cleanup);
+}
+
+static struct futex_hash_bucket_private *futex_get_private_hb(union futex_=
key *key)
+{
+	struct mm_struct *mm =3D current->mm;
+
+	if (!futex_key_is_private(key))
+		return NULL;
+	/*
+	 * Ideally we don't loop. If there is a replacement in progress
+	 * then a new HB is already prepared. We fail to obtain a
+	 * reference only after the last user returned its referefence.
+	 * In that case futex_assign_new_hb() blocks on futex_hash_bucket
+	 * and we either have to performon the replacement or wait
+	 * while someone else is doing the job. Eitherway, after we
+	 * return we can acquire a reference on the new hash bucket
+	 * (unless it is replaced again).
+	 */
+again:
+	scoped_guard(rcu) {
+		struct futex_hash_bucket_private *hb_p;
+
+		hb_p =3D rcu_dereference(mm->futex_hash_bucket);
+		if (!hb_p)
+			return NULL;
+
+		if (rcuref_get(&hb_p->users))
+			return hb_p;
+	}
+	futex_assign_new_hb(NULL);
+	goto again;
+}
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -139,12 +288,12 @@ static struct futex_hash_bucket *futex_hash_private(u=
nion futex_key *key,
  */
 struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
-	struct futex_hash_bucket *fhb;
+	struct futex_hash_bucket_private *hb_p =3D NULL;
 	u32 hash;
=20
-	fhb =3D current->mm->futex_hash_bucket;
-	if (fhb && futex_key_is_private(key))
-		return futex_hash_private(key, fhb, current->mm->futex_hash_mask);
+	hb_p =3D futex_get_private_hb(key);
+	if (hb_p)
+		return futex_hash_private(key, hb_p->queues, hb_p->hash_mask);
=20
 	hash =3D jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / 4,
@@ -154,6 +303,17 @@ struct futex_hash_bucket *futex_hash(union futex_key *=
key)
=20
 void futex_hash_put(struct futex_hash_bucket *hb)
 {
+	struct futex_hash_bucket_private *hb_p;
+
+	if (hb->hb_slot =3D=3D 0)
+		return;
+	hb_p =3D container_of(hb, struct futex_hash_bucket_private,
+			    queues[hb->hb_slot - 1]);
+
+	if (!rcuref_put(&hb_p->users))
+		return;
+
+	futex_assign_new_hb(NULL);
 }
=20
 /**
@@ -601,6 +761,8 @@ int futex_unqueue(struct futex_q *q)
 	spinlock_t *lock_ptr;
 	int ret =3D 0;
=20
+	/* RCU so lock_ptr is not going away during locking. */
+	guard(rcu)();
 	/* In the common case we don't take the spinlock, which is nice. */
 retry:
 	/*
@@ -1008,10 +1170,27 @@ static void compat_exit_robust_list(struct task_str=
uct *curr)
 static void exit_pi_state_list(struct task_struct *curr)
 {
 	struct list_head *next, *head =3D &curr->pi_state_list;
+	struct futex_hash_bucket_private *hb_p;
 	struct futex_pi_state *pi_state;
 	struct futex_hash_bucket *hb;
 	union futex_key key =3D FUTEX_KEY_INIT;
=20
+	/*
+	 * Lock the futex_hash_bucket to ensure that the hb remains unchanged.
+	 * This is important so we can invoke futex_hash() under the pi_lock.
+	 */
+	guard(mutex)(&curr->mm->futex_hash_lock);
+	hb_p =3D rcu_dereference_check(curr->mm->futex_hash_bucket,
+				     lockdep_is_held(&curr->mm->futex_hash_lock));
+	if (hb_p) {
+		if (rcuref_read(&hb_p->users) =3D=3D 0) {
+			struct futex_assign_cleanup fu_cleanup =3D {};
+
+			__futex_assign_new_hb(NULL, curr->mm, &fu_cleanup);
+			futex_assign_cleanup(&fu_cleanup);
+		}
+	}
+
 	/*
 	 * We are a ZOMBIE and nobody can enqueue itself on
 	 * pi_state_list anymore, but we have to be careful
@@ -1037,6 +1216,7 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 		if (!refcount_inc_not_zero(&pi_state->refcount)) {
 			raw_spin_unlock_irq(&curr->pi_lock);
 			cpu_relax();
+			futex_hash_put(hb);
 			raw_spin_lock_irq(&curr->pi_lock);
 			continue;
 		}
@@ -1053,6 +1233,7 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
 			spin_unlock(&hb->lock);
+			futex_hash_put(hb);
 			put_pi_state(pi_state);
 			continue;
 		}
@@ -1065,6 +1246,7 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 		raw_spin_unlock(&curr->pi_lock);
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 		spin_unlock(&hb->lock);
+		futex_hash_put(hb);
=20
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
 		put_pi_state(pi_state);
@@ -1185,8 +1367,9 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
=20
-static void futex_hash_bucket_init(struct futex_hash_bucket *fhb)
+static void futex_hash_bucket_init(struct futex_hash_bucket *fhb, unsigned=
 int slot)
 {
+	fhb->hb_slot =3D slot;
 	atomic_set(&fhb->waiters, 0);
 	plist_head_init(&fhb->chain);
 	spin_lock_init(&fhb->lock);
@@ -1194,20 +1377,25 @@ static void futex_hash_bucket_init(struct futex_has=
h_bucket *fhb)
=20
 void futex_hash_free(struct mm_struct *mm)
 {
-	kvfree(mm->futex_hash_bucket);
+	struct futex_hash_bucket_private *hb_p;
+
+	/* We are the last one and we hold the initial reference */
+	hb_p =3D rcu_dereference_check(mm->futex_hash_bucket, true);
+	if (!hb_p)
+		return;
+
+	if (WARN_ON(!rcuref_put(&hb_p->users)))
+		return;
+
+	kvfree(hb_p);
 }
=20
 static int futex_hash_allocate(unsigned int hash_slots)
 {
-	struct futex_hash_bucket *fhb;
+	struct futex_hash_bucket_private *hb_p;
+	size_t alloc_size;
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
@@ -1217,16 +1405,25 @@ static int futex_hash_allocate(unsigned int hash_sl=
ots)
 	if (!is_power_of_2(hash_slots))
 		hash_slots =3D rounddown_pow_of_two(hash_slots);
=20
-	fhb =3D kvmalloc_array(hash_slots, sizeof(struct futex_hash_bucket), GFP_=
KERNEL_ACCOUNT);
-	if (!fhb)
+	if (unlikely(check_mul_overflow(hash_slots, sizeof(struct futex_hash_buck=
et),
+					&alloc_size)))
 		return -ENOMEM;
=20
-	current->mm->futex_hash_mask =3D hash_slots - 1;
+	if (unlikely(check_add_overflow(alloc_size, sizeof(struct futex_hash_buck=
et_private),
+					&alloc_size)))
+		return -ENOMEM;
+
+	hb_p =3D kvmalloc(alloc_size, GFP_KERNEL_ACCOUNT);
+	if (!hb_p)
+		return -ENOMEM;
+
+	rcuref_init(&hb_p->users, 1);
+	hb_p->hash_mask =3D hash_slots - 1;
=20
 	for (i =3D 0; i < hash_slots; i++)
-		futex_hash_bucket_init(&fhb[i]);
+		futex_hash_bucket_init(&hb_p->queues[i], i + 1);
=20
-	current->mm->futex_hash_bucket =3D fhb;
+	futex_assign_new_hb(hb_p);
 	return 0;
 }
=20
@@ -1237,8 +1434,12 @@ int futex_hash_allocate_default(void)
=20
 static int futex_hash_get_slots(void)
 {
-	if (current->mm->futex_hash_bucket)
-		return current->mm->futex_hash_mask + 1;
+	struct futex_hash_bucket_private *hb_p;
+
+	guard(rcu)();
+	hb_p =3D rcu_dereference(current->mm->futex_hash_bucket);
+	if (hb_p)
+		return hb_p->hash_mask + 1;
 	return 0;
 }
=20
@@ -1280,7 +1481,7 @@ static int __init futex_init(void)
 	futex_hashsize =3D 1UL << futex_shift;
=20
 	for (i =3D 0; i < futex_hashsize; i++)
-		futex_hash_bucket_init(&futex_queues[i]);
+		futex_hash_bucket_init(&futex_queues[i], 0);
=20
 	return 0;
 }
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 143bf1523fa4a..7de1117c2eab0 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -115,6 +115,7 @@ static inline bool should_fail_futex(bool fshared)
  */
 struct futex_hash_bucket {
 	atomic_t waiters;
+	unsigned int hb_slot;
 	spinlock_t lock;
 	struct plist_head chain;
 } ____cacheline_aligned_in_smp;
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 1f3ac76ce1229..684f4eff20854 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -87,6 +87,11 @@ void requeue_futex(struct futex_q *q, struct futex_hash_=
bucket *hb1,
 		futex_hb_waiters_inc(hb2);
 		plist_add(&q->list, &hb2->chain);
 		q->lock_ptr =3D &hb2->lock;
+		/*
+		 * hb1 and hb2 belong to the same futex_hash_bucket_private
+		 * because if we managed get a reference on hb1 then it can't be
+		 * replaced. Therefore we avoid put(hb1)+get(hb2) here.
+		 */
 	}
 	q->key =3D *key2;
 }
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index ec73a6ea7462a..4dc71ff8911fd 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -173,8 +173,10 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, =
int nr_wake, u32 bitset)
 	hb =3D futex_hash(&key);
=20
 	/* Make sure we really have tasks to wakeup */
-	if (!futex_hb_waiters_pending(hb))
+	if (!futex_hb_waiters_pending(hb)) {
+		futex_hash_put(hb);
 		return ret;
+	}
=20
 	spin_lock(&hb->lock);
=20
--=20
2.45.2


