Return-Path: <linux-kernel+bounces-429867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5919E27EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD0C288A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005A41FCD17;
	Tue,  3 Dec 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eaRjOliy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MlipyIrT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2931FA167
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244224; cv=none; b=qf6sCrxBI7c3jgDU2qiTr7fQdqRVLjSaskA+F3AY2lO8KmpVqGnk9rHtihqOz4a6nSGV6qC3agp1H0XMZCS9DPxzu8TV965H3KEd2mgSz2zqnc02Ur1l4YGeTx2gxTCdtcDLhpnOAGHLZVNKi3+NBBt2V37OO+7quXHKRcssres=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244224; c=relaxed/simple;
	bh=kVN2hfIojMc/AG54+sdOHXIgWCq4aNVEYbrMlU3QDps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq7ZLsGxFmL5/6p59lE7z2J5QKVsNGeVJ254IketwExdhTcWGjTMh2deuSFuvQUZPeja6BB0+UEJ5wwgEK3LijIwJffbHBSoNrmk6LSyuqTohkuudH+QCrC0gxKMWuzQzpWt9Ju6z7h6WqvoF+59uM+pxNTHhiuJ846dzHbix8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eaRjOliy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MlipyIrT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vx6odPE5/M/zu43Vy1csw0o+66LVJ83d3Ac8QFvOmM=;
	b=eaRjOliyVWp05gLuJ6RSUp8qLdPAL15qtoZUcS8UMvbGO4sI8vVkzgMHSoUTHfY6lduEtB
	i2BI+H4URmoCMmfu8NONki1kI1MxR7xxvrbORqyFWw/NrETZSCr/0dOG/OrPYec5JB3OZN
	wj5VCmP7o4A/a0XWN1Tdxe/wi7XWouP8FZqjICxg9C56QrTXtLKX4DR548oSzr5fKvEvDL
	R3qn4ZLmwuMTiBtN1gbmLO3i8A10yGzNianHqxG4d0CcfKnckkpo3Nl/skizwvWtmzzVLR
	ji7aP/BIUpYSVBl/FEelPx8ebc6qSJtugDSaj/kIWhfRayoLaVkKiu5tm4+87A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vx6odPE5/M/zu43Vy1csw0o+66LVJ83d3Ac8QFvOmM=;
	b=MlipyIrTh252aBTkvvUF+4wWCubtr4tXSZpYH+Pyt2Xd6/yxGR0TQv+EJjWWC9kRWvANym
	uuFhAQBXRrFxiIAg==
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
Subject: [PATCH v4 05/11] futex: Track the futex hash bucket.
Date: Tue,  3 Dec 2024 17:42:13 +0100
Message-ID: <20241203164335.1125381-6-bigeasy@linutronix.de>
In-Reply-To: <20241203164335.1125381-1-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add futex_hash_get/put() to keep the assigned hash_bucket around while a
futex operation is performed. Have RCU lifetime guarantee for
futex_hash_bucket_private.

This is should have the right amount of gets/ puts so that the private
hash bucket is released on exit. This is preparatory work to allow
change the hash bucket at runtime.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h    |   2 +-
 include/linux/mm_types.h |   5 +-
 kernel/futex/core.c      | 104 +++++++++++++++++++++++++++++++++------
 kernel/futex/futex.h     |   8 +++
 kernel/futex/pi.c        |   7 +++
 kernel/futex/requeue.c   |  16 ++++++
 kernel/futex/waitwake.c  |  15 +++++-
 7 files changed, 136 insertions(+), 21 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 61e81b866d34e..359fc24eb37ff 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -84,7 +84,7 @@ void futex_hash_free(struct mm_struct *mm);
=20
 static inline void futex_mm_init(struct mm_struct *mm)
 {
-	mm->futex_hash_bucket =3D NULL;
+	rcu_assign_pointer(mm->futex_hash_bucket, NULL);
 }
=20
 #else
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b16b97ab8fb2a..4f39928631042 100644
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
@@ -903,8 +903,7 @@ struct mm_struct {
 		int mm_lock_seq;
 #endif
=20
-		unsigned int			futex_hash_mask;
-		struct futex_hash_bucket	*futex_hash_bucket;
+		struct futex_hash_bucket_private	__rcu *futex_hash_bucket;
=20
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
 		unsigned long hiwater_vm;  /* High-water virtual memory usage */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 14251bbafaffb..464918d85395e 100644
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
@@ -127,17 +134,24 @@ static inline bool futex_key_is_private(union futex_k=
ey *key)
  */
 struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
-	struct futex_hash_bucket *fhb;
+	struct futex_hash_bucket_private *hb_p =3D NULL;
 	u32 hash;
=20
-	fhb =3D current->mm->futex_hash_bucket;
-	if (fhb && futex_key_is_private(key)) {
-		u32 hash_mask =3D current->mm->futex_hash_mask;
+	if (futex_key_is_private(key)) {
+		guard(rcu)();
+
+		do {
+			hb_p =3D rcu_dereference(current->mm->futex_hash_bucket);
+		} while (hb_p && !rcuref_get(&hb_p->users));
+	}
+
+	if (hb_p) {
+		u32 hash_mask =3D hb_p->hash_mask;
=20
 		hash =3D jhash2((void *)&key->private.address,
 			      sizeof(key->private.address) / 4,
 			      key->both.offset);
-		return &fhb[hash & hash_mask];
+		return &hb_p->queues[hash & hash_mask];
 	}
 	hash =3D jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / 4,
@@ -145,6 +159,35 @@ struct futex_hash_bucket *futex_hash(union futex_key *=
key)
 	return &futex_queues[hash & (futex_hashsize - 1)];
 }
=20
+static void futex_hash_priv_put(struct futex_hash_bucket_private *hb_p)
+{
+	if (rcuref_put(&hb_p->users))
+		kvfree_rcu(hb_p, rcu);
+}
+
+void futex_hash_put(struct futex_hash_bucket *hb)
+{
+	struct futex_hash_bucket_private *hb_p;
+
+	if (hb->hb_slot =3D=3D 0)
+		return;
+	hb_p =3D container_of(hb, struct futex_hash_bucket_private,
+			    queues[hb->hb_slot - 1]);
+	futex_hash_priv_put(hb_p);
+}
+
+void futex_hash_get(struct futex_hash_bucket *hb)
+{
+	struct futex_hash_bucket_private *hb_p;
+
+	if (hb->hb_slot =3D=3D 0)
+		return;
+
+	hb_p =3D container_of(hb, struct futex_hash_bucket_private,
+			    queues[hb->hb_slot - 1]);
+	/* The ref needs to be owned by the caller so this can't fail */
+	WARN_ON_ONCE(!rcuref_get(&hb_p->users));
+}
=20
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
@@ -599,7 +642,10 @@ int futex_unqueue(struct futex_q *q)
 	 */
 	lock_ptr =3D READ_ONCE(q->lock_ptr);
 	if (lock_ptr !=3D NULL) {
+		struct futex_hash_bucket *hb;
+
 		spin_lock(lock_ptr);
+		hb =3D futex_hb_from_futex_q(q);
 		/*
 		 * q->lock_ptr can change between reading it and
 		 * spin_lock(), causing us to take the wrong lock.  This
@@ -622,6 +668,7 @@ int futex_unqueue(struct futex_q *q)
 		BUG_ON(q->pi_state);
=20
 		spin_unlock(lock_ptr);
+		futex_hash_put(hb);
 		ret =3D 1;
 	}
=20
@@ -999,6 +1046,7 @@ static void exit_pi_state_list(struct task_struct *cur=
r)
 		if (!refcount_inc_not_zero(&pi_state->refcount)) {
 			raw_spin_unlock_irq(&curr->pi_lock);
 			cpu_relax();
+			futex_hash_put(hb);
 			raw_spin_lock_irq(&curr->pi_lock);
 			continue;
 		}
@@ -1015,6 +1063,7 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 			/* retain curr->pi_lock for the loop invariant */
 			raw_spin_unlock(&pi_state->pi_mutex.wait_lock);
 			spin_unlock(&hb->lock);
+			futex_hash_put(hb);
 			put_pi_state(pi_state);
 			continue;
 		}
@@ -1027,6 +1076,7 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 		raw_spin_unlock(&curr->pi_lock);
 		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 		spin_unlock(&hb->lock);
+		futex_hash_put(hb);
=20
 		rt_mutex_futex_unlock(&pi_state->pi_mutex);
 		put_pi_state(pi_state);
@@ -1147,8 +1197,9 @@ void futex_exit_release(struct task_struct *tsk)
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
@@ -1156,12 +1207,20 @@ static void futex_hash_bucket_init(struct futex_has=
h_bucket *fhb)
=20
 void futex_hash_free(struct mm_struct *mm)
 {
-	kvfree(mm->futex_hash_bucket);
+	struct futex_hash_bucket_private *hb_p;
+
+	/* own a reference */
+	hb_p =3D rcu_dereference_check(mm->futex_hash_bucket, true);
+	if (!hb_p)
+		return;
+	WARN_ON(rcuref_read(&hb_p->users) !=3D 1);
+	futex_hash_priv_put(hb_p);
 }
=20
 static int futex_hash_allocate(unsigned int hash_slots)
 {
-	struct futex_hash_bucket *fhb;
+	struct futex_hash_bucket_private *hb_p;
+	size_t alloc_size;
 	int i;
=20
 	if (current->mm->futex_hash_bucket)
@@ -1179,16 +1238,25 @@ static int futex_hash_allocate(unsigned int hash_sl=
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
+	rcu_assign_pointer(current->mm->futex_hash_bucket, hb_p);
 	return 0;
 }
=20
@@ -1199,8 +1267,12 @@ int futex_hash_allocate_default(void)
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
@@ -1243,7 +1315,7 @@ static int __init futex_init(void)
 	futex_hashsize =3D 1UL << futex_shift;
=20
 	for (i =3D 0; i < futex_hashsize; i++)
-		futex_hash_bucket_init(&futex_queues[i]);
+		futex_hash_bucket_init(&futex_queues[i], 0);
=20
 	return 0;
 }
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 618ce1fe870e9..ceea260ad9e80 100644
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
@@ -202,6 +203,13 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleepe=
r *timeout,
 		  int flags, u64 range_ns);
=20
 extern struct futex_hash_bucket *futex_hash(union futex_key *key);
+extern void futex_hash_put(struct futex_hash_bucket *hb);
+extern void futex_hash_get(struct futex_hash_bucket *hb);
+
+static inline struct futex_hash_bucket *futex_hb_from_futex_q(struct futex=
_q *q)
+{
+	return container_of(q->lock_ptr, struct futex_hash_bucket, lock);
+}
=20
 /**
  * futex_match - Check whether two futex keys are equal
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index d62cca5ed8f4c..60a62ab250b08 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -964,6 +964,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags=
, ktime_t *time, int tryl
 			 * - EAGAIN: The user space value changed.
 			 */
 			futex_q_unlock(hb);
+			futex_hash_put(hb);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -1083,10 +1084,12 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int f=
lags, ktime_t *time, int tryl
=20
 	futex_unqueue_pi(&q);
 	spin_unlock(q.lock_ptr);
+	futex_hash_put(hb);
 	goto out;
=20
 out_unlock_put_key:
 	futex_q_unlock(hb);
+	futex_hash_put(hb);
=20
 out:
 	if (to) {
@@ -1097,6 +1100,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fla=
gs, ktime_t *time, int tryl
=20
 uaddr_faulted:
 	futex_q_unlock(hb);
+	futex_hash_put(hb);
=20
 	ret =3D fault_in_user_writeable(uaddr);
 	if (ret)
@@ -1197,6 +1201,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
=20
 		get_pi_state(pi_state);
 		spin_unlock(&hb->lock);
+		futex_hash_put(hb);
=20
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret =3D wake_futex_pi(uaddr, uval, pi_state, rt_waiter);
@@ -1236,6 +1241,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 	 */
 	if ((ret =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, 0))) {
 		spin_unlock(&hb->lock);
+		futex_hash_put(hb);
 		switch (ret) {
 		case -EFAULT:
 			goto pi_faulted;
@@ -1256,6 +1262,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
=20
 out_unlock:
 	spin_unlock(&hb->lock);
+	futex_hash_put(hb);
 	return ret;
=20
 pi_retry:
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b47bb764b3520..39e96f1bef8ce 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -87,6 +87,8 @@ void requeue_futex(struct futex_q *q, struct futex_hash_b=
ucket *hb1,
 		futex_hb_waiters_inc(hb2);
 		plist_add(&q->list, &hb2->chain);
 		q->lock_ptr =3D &hb2->lock;
+		futex_hash_put(hb1);
+		futex_hash_get(hb2);
 	}
 	q->key =3D *key2;
 }
@@ -231,8 +233,10 @@ void requeue_pi_wake_futex(struct futex_q *q, union fu=
tex_key *key,
=20
 	WARN_ON(!q->rt_waiter);
 	q->rt_waiter =3D NULL;
+	futex_hash_put(futex_hb_from_futex_q(q));
=20
 	q->lock_ptr =3D &hb->lock;
+	futex_hash_get(hb);
=20
 	/* Signal locked state to the waiter */
 	futex_requeue_pi_complete(q, 1);
@@ -458,6 +462,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
 			futex_hb_waiters_dec(hb2);
+			futex_hash_put(hb1);
+			futex_hash_put(hb2);
=20
 			ret =3D get_user(curval, uaddr1);
 			if (ret)
@@ -544,6 +550,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 		case -EFAULT:
 			double_unlock_hb(hb1, hb2);
 			futex_hb_waiters_dec(hb2);
+			futex_hash_put(hb1);
+			futex_hash_put(hb2);
 			ret =3D fault_in_user_writeable(uaddr2);
 			if (!ret)
 				goto retry;
@@ -558,6 +566,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 			 */
 			double_unlock_hb(hb1, hb2);
 			futex_hb_waiters_dec(hb2);
+			futex_hash_put(hb1);
+			futex_hash_put(hb2);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -677,6 +687,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
 	futex_hb_waiters_dec(hb2);
+	futex_hash_put(hb1);
+	futex_hash_put(hb2);
 	return ret ? ret : task_count;
 }
=20
@@ -815,6 +827,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 	 */
 	if (futex_match(&q.key, &key2)) {
 		futex_q_unlock(hb);
+		futex_hash_put(hb);
 		ret =3D -EINVAL;
 		goto out;
 	}
@@ -828,6 +841,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 		spin_lock(&hb->lock);
 		ret =3D handle_early_requeue_pi_wakeup(hb, &q, to);
 		spin_unlock(&hb->lock);
+		futex_hash_put(hb);
 		break;
=20
 	case Q_REQUEUE_PI_LOCKED:
@@ -847,6 +861,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 			 */
 			ret =3D ret < 0 ? ret : 0;
 		}
+		futex_hash_put(futex_hb_from_futex_q(&q));
 		break;
=20
 	case Q_REQUEUE_PI_DONE:
@@ -876,6 +891,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
=20
 		futex_unqueue_pi(&q);
 		spin_unlock(q.lock_ptr);
+		futex_hash_put(futex_hb_from_futex_q(&q));
=20
 		if (ret =3D=3D -EINTR) {
 			/*
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 3a10375d95218..1f2d11eb7f89f 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -113,6 +113,8 @@ bool __futex_wake_mark(struct futex_q *q)
 		return false;
=20
 	__futex_unqueue(q);
+	/* Waiters reference */
+	futex_hash_put(futex_hb_from_futex_q(q));
 	/*
 	 * The waiting task can free the futex_q as soon as q->lock_ptr =3D NULL
 	 * is written, without taking any locks. This is possible in the event
@@ -173,8 +175,10 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, =
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
@@ -196,6 +200,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, i=
nt nr_wake, u32 bitset)
 	}
=20
 	spin_unlock(&hb->lock);
+	futex_hash_put(hb);
 	wake_up_q(&wake_q);
 	return ret;
 }
@@ -275,6 +280,8 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flag=
s, u32 __user *uaddr2,
 	op_ret =3D futex_atomic_op_inuser(op, uaddr2);
 	if (unlikely(op_ret < 0)) {
 		double_unlock_hb(hb1, hb2);
+		futex_hash_put(hb1);
+		futex_hash_put(hb2);
=20
 		if (!IS_ENABLED(CONFIG_MMU) ||
 		    unlikely(op_ret !=3D -EFAULT && op_ret !=3D -EAGAIN)) {
@@ -329,6 +336,8 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flag=
s, u32 __user *uaddr2,
 out_unlock:
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
+	futex_hash_put(hb1);
+	futex_hash_put(hb2);
 	return ret;
 }
=20
@@ -466,6 +475,8 @@ int futex_wait_multiple_setup(struct futex_vector *vs, =
int count, int *woken)
 		}
=20
 		futex_q_unlock(hb);
+		futex_hash_put(hb);
+
 		__set_current_state(TASK_RUNNING);
=20
 		/*
@@ -625,6 +636,7 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsign=
ed int flags,
=20
 	if (ret) {
 		futex_q_unlock(*hb);
+		futex_hash_put(*hb);
=20
 		ret =3D get_user(uval, uaddr);
 		if (ret)
@@ -638,6 +650,7 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsign=
ed int flags,
=20
 	if (uval !=3D val) {
 		futex_q_unlock(*hb);
+		futex_hash_put(*hb);
 		ret =3D -EWOULDBLOCK;
 	}
=20
--=20
2.45.2


