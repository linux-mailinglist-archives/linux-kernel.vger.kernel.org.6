Return-Path: <linux-kernel+bounces-532015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A89A44793
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A47188632E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D708A20AF82;
	Tue, 25 Feb 2025 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EuTnzjtn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yootGPQG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7271A2393
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503374; cv=none; b=OWwvrZtltNcJ5v0kKZhGy8dcy9i6+7iNhsyqLnNQsQscsQTJxI/uhVRSpg2PTFMKuXtO2yESgEectQwIAGXXJbHfwMYQOaAO6xaaLYBUxefKQGTwoduIbRjMxTzrHTJc9UYFTTsLHRNl7D9tPXHYw2+k4W5MIsH3LWpLZ24+oBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503374; c=relaxed/simple;
	bh=YqUvIPoskup33fFPxdQ0BXsA0l7ziIULXaMUdvIc5Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2IWxPBbuSQvQI5PPGT9EvVjAx/BCpF8Q9s71IGZdxHIVNqVxBN1hvDKFLQO4ADL/JMRRirVUt73cwEUWJrkc/LsiNoNQZJG4M3DveFk1kZVZ/OaFioJuHsl9caLPzCBYrrVgrBorU7sB55ywaMyNJ5/xQ6YABpM+PAx7E5IVCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EuTnzjtn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yootGPQG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740503363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/jdKtUOrhKM1O89fZWDstXrS8WnNa8003TLtytQv0I=;
	b=EuTnzjtnsykRHADxvqkCUIc+8NZdyZ5HvegBoh4L0XzkgJfZxOo8lFEmc9eqZTrT0+XhrD
	t/iX/q/1by8J1DNedqlOpsV9SLdwa4SQTGnVQFGMOuLsJioU835Qfot7cTqeitrmhC8Nvd
	6Jv537yaHMX394/RfW7zlQzY3s98eA5ifz1MDPmCQZQch30WkEUM+8c6JXKVlZEifxeQyn
	dmPXy/3ZeowIdoTSvJ8Qcto4Z5iS4U+RbiRGfd4X2mZntcsjqm4Da5nvIseOymRBgcSLzR
	R83nL6IieREIvQxTb7s6hlgPUEB/C7LRZl7Ah5GabPzLkcrv7SU5Typ5OoErhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740503363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/jdKtUOrhKM1O89fZWDstXrS8WnNa8003TLtytQv0I=;
	b=yootGPQGSUvw+iZnQILtjZ2UsrWGGfNnOiDwX+tSFUljHoIun2cSTr137AHTveGdHjaFn2
	hCPD9hrlNmCSwNBg==
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
Subject: [PATCH v9 09/11] futex: Allow to re-allocate the private local hash.
Date: Tue, 25 Feb 2025 18:09:12 +0100
Message-ID: <20250225170914.289358-10-bigeasy@linutronix.de>
In-Reply-To: <20250225170914.289358-1-bigeasy@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
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
allocation of struct futex_private_hash sets the reference count
to one. Every user acquires a reference on the local hash before using
it and drops it after it enqueued itself on the hash bucket. There is no
reference held while the task is scheduled out while waiting for the
wake up.
The resize allocates a new struct futex_private_hash and drops the
initial reference under the mm_struct::futex_hash_lock. If the reference
drop results in destruction of the object then users currently queued on
the local hash will be requeued on the new local hash. At the end
mm_struct::futex_phash is updated, the old pointer is RCU freed
and the mutex is dropped.
If the reference drop does not result in destruction of the object then
the new pointer is saved as mm_struct::futex_phash_new. In this case
replacement is delayed. The user dropping the last reference is not
always the best choice to perform the replacement. For instance
futex_wait_queue() drops the reference after changing its task
state which will also be modified while the futex_hash_lock is acquired.
Therefore the replacement is delayed to the task acquiring a reference
on the current local hash.

This scheme keeps the requirement that all waiters/ wakers of the same addr=
ess
block always on the same futex_hash_bucket::lock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h    |   5 +-
 include/linux/mm_types.h |   7 +-
 kernel/futex/core.c      | 248 +++++++++++++++++++++++++++++++++++----
 kernel/futex/futex.h     |   1 +
 kernel/futex/requeue.c   |   5 +
 5 files changed, 237 insertions(+), 29 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index bad377c30de5e..bfb38764bac7a 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -83,12 +83,13 @@ void futex_hash_free(struct mm_struct *mm);
=20
 static inline void futex_mm_init(struct mm_struct *mm)
 {
-	mm->futex_hash_bucket =3D NULL;
+	rcu_assign_pointer(mm->futex_phash, NULL);
+	mutex_init(&mm->futex_hash_lock);
 }
=20
 static inline bool futex_hash_requires_allocation(void)
 {
-	if (current->mm->futex_hash_bucket)
+	if (current->mm->futex_phash)
 		return false;
 	return true;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c20f2310d78ca..19abbc870e0a9 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -30,7 +30,7 @@
 #define INIT_PASID	0
=20
 struct address_space;
-struct futex_hash_bucket;
+struct futex_private_hash;
 struct mem_cgroup;
=20
 /*
@@ -938,8 +938,9 @@ struct mm_struct {
 		seqcount_t mm_lock_seq;
 #endif
 #ifdef CONFIG_FUTEX
-		unsigned int			futex_hash_mask;
-		struct futex_hash_bucket	*futex_hash_bucket;
+		struct mutex			futex_hash_lock;
+		struct futex_private_hash	__rcu *futex_phash;
+		struct futex_private_hash	*futex_phash_new;
 #endif
=20
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index b08bca2ed0342..4d9ee3bcaa6d0 100644
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
@@ -56,6 +57,14 @@ static struct {
 #define futex_queues   (__futex_data.queues)
 #define futex_hashsize (__futex_data.hashsize)
=20
+struct futex_private_hash {
+	rcuref_t	users;
+	unsigned int	hash_mask;
+	struct rcu_head	rcu;
+	bool		initial_ref_dropped;
+	bool		released;
+	struct futex_hash_bucket queues[];
+};
=20
 /*
  * Fault injections for futexes.
@@ -129,9 +138,122 @@ static struct futex_hash_bucket *futex_hash_private(u=
nion futex_key *key,
 	return &fhb[hash & hash_mask];
 }
=20
+static void futex_rehash_current_users(struct futex_private_hash *old,
+				       struct futex_private_hash *new)
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
+			 * moved user can be unqueued due to timeout or signal.
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
+static void futex_assign_new_hash(struct futex_private_hash *hb_p_new,
+				  struct mm_struct *mm)
+{
+	bool drop_init_ref =3D hb_p_new !=3D NULL;
+	struct futex_private_hash *hb_p;
+
+	if (!hb_p_new) {
+		hb_p_new =3D mm->futex_phash_new;
+		mm->futex_phash_new =3D NULL;
+	}
+	/* Someone was quicker, the current mask is valid */
+	if (!hb_p_new)
+		return;
+
+	hb_p =3D rcu_dereference_check(mm->futex_phash,
+				     lockdep_is_held(&mm->futex_hash_lock));
+	if (hb_p) {
+		if (hb_p->hash_mask >=3D hb_p_new->hash_mask) {
+			/* It was increased again while we were waiting */
+			kvfree(hb_p_new);
+			return;
+		}
+		/*
+		 * If the caller started the resize then the initial reference
+		 * needs to be dropped. If the object can not be deconstructed
+		 * we save hb_p_new for later and ensure the reference counter
+		 * is not dropped again.
+		 */
+		if (drop_init_ref &&
+		    (hb_p->initial_ref_dropped || !futex_put_private_hash(hb_p))) {
+			mm->futex_phash_new =3D hb_p_new;
+			hb_p->initial_ref_dropped =3D true;
+			return;
+		}
+		if (!READ_ONCE(hb_p->released)) {
+			mm->futex_phash_new =3D hb_p_new;
+			return;
+		}
+
+		futex_rehash_current_users(hb_p, hb_p_new);
+	}
+	rcu_assign_pointer(mm->futex_phash, hb_p_new);
+	kvfree_rcu(hb_p, rcu);
+}
+
 struct futex_private_hash *futex_get_private_hash(void)
 {
-	return NULL;
+	struct mm_struct *mm =3D current->mm;
+	/*
+	 * Ideally we don't loop. If there is a replacement in progress
+	 * then a new private hash is already prepared and a reference can't be
+	 * obtained once the last user dropped it's.
+	 * In that case we block on mm_struct::futex_hash_lock and either have
+	 * to perform the replacement or wait while someone else is doing the
+	 * job. Eitherway, on the second iteration we acquire a reference on the
+	 * new private hash or loop again because a new replacement has been
+	 * requested.
+	 */
+again:
+	scoped_guard(rcu) {
+		struct futex_private_hash *hb_p;
+
+		hb_p =3D rcu_dereference(mm->futex_phash);
+		if (!hb_p)
+			return NULL;
+
+		if (rcuref_get(&hb_p->users))
+			return hb_p;
+	}
+	scoped_guard(mutex, &current->mm->futex_hash_lock)
+		futex_assign_new_hash(NULL, mm);
+	goto again;
+}
+
+static struct futex_private_hash *futex_get_private_hb(union futex_key *ke=
y)
+{
+	if (!futex_key_is_private(key))
+		return NULL;
+
+	return futex_get_private_hash();
 }
=20
 /**
@@ -144,12 +266,12 @@ struct futex_private_hash *futex_get_private_hash(voi=
d)
  */
 struct futex_hash_bucket *__futex_hash(union futex_key *key)
 {
-	struct futex_hash_bucket *fhb;
+	struct futex_private_hash *hb_p;
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
@@ -159,7 +281,13 @@ struct futex_hash_bucket *__futex_hash(union futex_key=
 *key)
=20
 bool futex_put_private_hash(struct futex_private_hash *hb_p)
 {
-	return false;
+	bool released;
+
+	guard(preempt)();
+	released =3D rcuref_put_rcusafe(&hb_p->users);
+	if (released)
+		WRITE_ONCE(hb_p->released, true);
+	return released;
 }
=20
 /**
@@ -171,9 +299,22 @@ bool futex_put_private_hash(struct futex_private_hash =
*hb_p)
  */
 void futex_hash_get(struct futex_hash_bucket *hb)
 {
+	struct futex_private_hash *hb_p =3D hb->hb_p;
+
+	if (!hb_p)
+		return;
+
+	WARN_ON_ONCE(!rcuref_get(&hb_p->users));
 }
=20
-void futex_hash_put(struct futex_hash_bucket *hb) { }
+void futex_hash_put(struct futex_hash_bucket *hb)
+{
+	struct futex_private_hash *hb_p =3D hb->hb_p;
+
+	if (!hb_p)
+		return;
+	futex_put_private_hash(hb_p);
+}
=20
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
@@ -615,6 +756,8 @@ int futex_unqueue(struct futex_q *q)
 	spinlock_t *lock_ptr;
 	int ret =3D 0;
=20
+	/* RCU so lock_ptr is not going away during locking. */
+	guard(rcu)();
 	/* In the common case we don't take the spinlock, which is nice. */
 retry:
 	/*
@@ -1028,9 +1171,21 @@ static void compat_exit_robust_list(struct task_stru=
ct *curr)
 static void exit_pi_state_list(struct task_struct *curr)
 {
 	struct list_head *next, *head =3D &curr->pi_state_list;
+	struct futex_private_hash *hb_p;
 	struct futex_pi_state *pi_state;
 	union futex_key key =3D FUTEX_KEY_INIT;
=20
+	/*
+	 * The mutex mm_struct::futex_hash_lock might be acquired.
+	 */
+	might_sleep();
+	/*
+	 * Ensure the hash remains stable (no resize) during the while loop
+	 * below. The hb pointer is acquired under the pi_lock so we can't block
+	 * on the mutex.
+	 */
+	WARN_ON(curr !=3D current);
+	hb_p =3D futex_get_private_hash();
 	/*
 	 * We are a ZOMBIE and nobody can enqueue itself on
 	 * pi_state_list anymore, but we have to be careful
@@ -1093,6 +1248,8 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
+	if (hb_p)
+		futex_put_private_hash(hb_p);
 }
 #else
 static inline void exit_pi_state_list(struct task_struct *curr) { }
@@ -1206,8 +1363,10 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
=20
-static void futex_hash_bucket_init(struct futex_hash_bucket *fhb)
+static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
+				   struct futex_private_hash *hb_p)
 {
+	fhb->hb_p =3D hb_p;
 	atomic_set(&fhb->waiters, 0);
 	plist_head_init(&fhb->chain);
 	spin_lock_init(&fhb->lock);
@@ -1215,20 +1374,34 @@ static void futex_hash_bucket_init(struct futex_has=
h_bucket *fhb)
=20
 void futex_hash_free(struct mm_struct *mm)
 {
-	kvfree(mm->futex_hash_bucket);
+	struct futex_private_hash *hb_p;
+
+	kvfree(mm->futex_phash_new);
+	/*
+	 * The mm_struct belonging to the task is about to be removed so all
+	 * threads, that ever accessed the private hash, are gone and the
+	 * pointer can be accessed directly (omitting a RCU-read section or
+	 * lock).
+	 * Since there can not be a thread holding a reference to the private
+	 * hash we free it immediately.
+	 */
+	hb_p =3D rcu_dereference_raw(mm->futex_phash);
+	if (!hb_p)
+		return;
+
+	if (!hb_p->initial_ref_dropped && WARN_ON(!futex_put_private_hash(hb_p)))
+		return;
+
+	kvfree(hb_p);
 }
=20
 static int futex_hash_allocate(unsigned int hash_slots)
 {
-	struct futex_hash_bucket *fhb;
+	struct futex_private_hash *hb_p, *hb_tofree =3D NULL;
+	struct mm_struct *mm =3D current->mm;
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
@@ -1238,16 +1411,39 @@ static int futex_hash_allocate(unsigned int hash_sl=
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
+	if (unlikely(check_add_overflow(alloc_size, sizeof(struct futex_private_h=
ash),
+					&alloc_size)))
+		return -ENOMEM;
+
+	hb_p =3D kvmalloc(alloc_size, GFP_KERNEL_ACCOUNT);
+	if (!hb_p)
+		return -ENOMEM;
+
+	rcuref_init(&hb_p->users, 1);
+	hb_p->initial_ref_dropped =3D false;
+	hb_p->released =3D false;
+	hb_p->hash_mask =3D hash_slots - 1;
=20
 	for (i =3D 0; i < hash_slots; i++)
-		futex_hash_bucket_init(&fhb[i]);
+		futex_hash_bucket_init(&hb_p->queues[i], hb_p);
=20
-	current->mm->futex_hash_bucket =3D fhb;
+	scoped_guard(mutex, &mm->futex_hash_lock) {
+		if (mm->futex_phash_new) {
+			if (mm->futex_phash_new->hash_mask <=3D hb_p->hash_mask) {
+				hb_tofree =3D mm->futex_phash_new;
+			} else {
+				hb_tofree =3D hb_p;
+				hb_p =3D mm->futex_phash_new;
+			}
+			mm->futex_phash_new =3D NULL;
+		}
+		futex_assign_new_hash(hb_p, mm);
+	}
+	kvfree(hb_tofree);
 	return 0;
 }
=20
@@ -1258,8 +1454,12 @@ int futex_hash_allocate_default(void)
=20
 static int futex_hash_get_slots(void)
 {
-	if (current->mm->futex_hash_bucket)
-		return current->mm->futex_hash_mask + 1;
+	struct futex_private_hash *hb_p;
+
+	guard(rcu)();
+	hb_p =3D rcu_dereference(current->mm->futex_phash);
+	if (hb_p)
+		return hb_p->hash_mask + 1;
 	return 0;
 }
=20
@@ -1301,7 +1501,7 @@ static int __init futex_init(void)
 	futex_hashsize =3D 1UL << futex_shift;
=20
 	for (i =3D 0; i < futex_hashsize; i++)
-		futex_hash_bucket_init(&futex_queues[i]);
+		futex_hash_bucket_init(&futex_queues[i], 0);
=20
 	return 0;
 }
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 0a76ee6e7dc10..973efcca2e01b 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -118,6 +118,7 @@ struct futex_hash_bucket {
 	atomic_t waiters;
 	spinlock_t lock;
 	struct plist_head chain;
+	struct futex_private_hash *hb_p;
 } ____cacheline_aligned_in_smp;
=20
 /*
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b0e64fd454d96..c716a66f86929 100644
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
--=20
2.47.2


