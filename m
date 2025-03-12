Return-Path: <linux-kernel+bounces-557986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45221A5E014
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C533B9DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0925A32C;
	Wed, 12 Mar 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RHDP6JGj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JmbDrjy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926D2571A8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792611; cv=none; b=ufyDgAPgwkSDHpfFq3F9HONmdrT8kuXaT+8cm+TkSTMVO6wnw26NrXXFdJa4J9yzoYrY6Hd/z3na8F9Q2kEFjEZgAni6XyKJNnKmS0unbQpfhxAchTlchNkBO+i00axRMGhgwjKk029PqIL9mzJFyj1MVPiKcMi5cijtV76QRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792611; c=relaxed/simple;
	bh=l/WqEIOlaQmwjwfryMtEc6A+aNo5oTbMaNRP00d86oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC9a9nurKC8FwHWY+dlj0V4QYrfg/mtSwNUcUtoiN/JAoHNg1VKNZMBhEgLBHI5h8Z6ToDm0JUqcHA+QNrNLeCmjPVemuW8oua2k3p6QxN1BabIR7F148wb6zHHKpRjLRGyMB8v0oaqdVu4qq0qwhnPOQ71k+ZiWQ9r2yU23//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RHDP6JGj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1JmbDrjy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5GwabWDNOE2x/DiLAHMAH0N3IFUH1OABi7nIU2t/j0=;
	b=RHDP6JGjgis4TJC2nUf/q18RIsGnLgZl7LaCSY/Bl5gLi9TSgjli72xYDsszD2AmfhbZ5V
	WaH1RivsupvUr6qGwCNVKDxtiMUIlA1GqHOyLDW4W7WAN0iwaBq9IaNwKfOacnWUK0xWpC
	U/FjZTwXmNhZfj47BbrzPrJHoiECJNrX6xTbESjGPWQMqu8HKhmi0MOY3GswqOgiPpW7BZ
	jVT51WBBWoAgvg7Bk9CF51DkGn/n1AsAK3TLkA0+5tlpT3XEStFYEEovPTDPS6i2v930uq
	cSZq+tYqJ66MIcqk9Yr3UlXbEQOzdkaGaMAmuQdrXrUnsRUAGKUuiH3QzVD3eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5GwabWDNOE2x/DiLAHMAH0N3IFUH1OABi7nIU2t/j0=;
	b=1JmbDrjy+zK83coQufQhyvEeBIc+im0OB7KHKzBVP8fT9/QSBHSD6ERpHoeh6yHP8ItFUy
	3+gi43DOkmOOTWCg==
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
Subject: [PATCH v10 15/21] futex: s/hb_p/fph/
Date: Wed, 12 Mar 2025 16:16:28 +0100
Message-ID: <20250312151634.2183278-16-bigeasy@linutronix.de>
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

To me hb_p reads like hash-bucket-private, but these things are
pointers to private hash table, not bucket.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c     | 136 ++++++++++++++++++++--------------------
 kernel/futex/futex.h    |   6 +-
 kernel/futex/waitwake.c |   8 +--
 3 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 229009279ee7d..9b87c4f128f14 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -175,49 +175,49 @@ static void futex_rehash_current_users(struct futex_p=
rivate_hash *old,
 	}
 }
=20
-static void futex_assign_new_hash(struct futex_private_hash *hb_p_new,
+static void futex_assign_new_hash(struct futex_private_hash *new,
 				  struct mm_struct *mm)
 {
-	bool drop_init_ref =3D hb_p_new !=3D NULL;
-	struct futex_private_hash *hb_p;
+	bool drop_init_ref =3D new !=3D NULL;
+	struct futex_private_hash *fph;
=20
-	if (!hb_p_new) {
-		hb_p_new =3D mm->futex_phash_new;
+	if (!new) {
+		new =3D mm->futex_phash_new;
 		mm->futex_phash_new =3D NULL;
 	}
 	/* Someone was quicker, the current mask is valid */
-	if (!hb_p_new)
+	if (!new)
 		return;
=20
-	hb_p =3D rcu_dereference_check(mm->futex_phash,
+	fph =3D rcu_dereference_check(mm->futex_phash,
 				     lockdep_is_held(&mm->futex_hash_lock));
-	if (hb_p) {
-		if (hb_p->hash_mask >=3D hb_p_new->hash_mask) {
+	if (fph) {
+		if (fph->hash_mask >=3D new->hash_mask) {
 			/* It was increased again while we were waiting */
-			kvfree(hb_p_new);
+			kvfree(new);
 			return;
 		}
 		/*
 		 * If the caller started the resize then the initial reference
 		 * needs to be dropped. If the object can not be deconstructed
-		 * we save hb_p_new for later and ensure the reference counter
+		 * we save new for later and ensure the reference counter
 		 * is not dropped again.
 		 */
 		if (drop_init_ref &&
-		    (hb_p->initial_ref_dropped || !futex_put_private_hash(hb_p))) {
-			mm->futex_phash_new =3D hb_p_new;
-			hb_p->initial_ref_dropped =3D true;
+		    (fph->initial_ref_dropped || !futex_put_private_hash(fph))) {
+			mm->futex_phash_new =3D new;
+			fph->initial_ref_dropped =3D true;
 			return;
 		}
-		if (!READ_ONCE(hb_p->released)) {
-			mm->futex_phash_new =3D hb_p_new;
+		if (!READ_ONCE(fph->released)) {
+			mm->futex_phash_new =3D new;
 			return;
 		}
=20
-		futex_rehash_current_users(hb_p, hb_p_new);
+		futex_rehash_current_users(fph, new);
 	}
-	rcu_assign_pointer(mm->futex_phash, hb_p_new);
-	kvfree_rcu(hb_p, rcu);
+	rcu_assign_pointer(mm->futex_phash, new);
+	kvfree_rcu(fph, rcu);
 }
=20
 struct futex_private_hash *futex_get_private_hash(void)
@@ -235,14 +235,14 @@ struct futex_private_hash *futex_get_private_hash(voi=
d)
 	 */
 again:
 	scoped_guard(rcu) {
-		struct futex_private_hash *hb_p;
+		struct futex_private_hash *fph;
=20
-		hb_p =3D rcu_dereference(mm->futex_phash);
-		if (!hb_p)
+		fph =3D rcu_dereference(mm->futex_phash);
+		if (!fph)
 			return NULL;
=20
-		if (rcuref_get(&hb_p->users))
-			return hb_p;
+		if (rcuref_get(&fph->users))
+			return fph;
 	}
 	scoped_guard(mutex, &current->mm->futex_hash_lock)
 		futex_assign_new_hash(NULL, mm);
@@ -275,12 +275,12 @@ static struct futex_private_hash *futex_get_private_h=
b(union futex_key *key)
  */
 struct futex_hash_bucket *__futex_hash(union futex_key *key)
 {
-	struct futex_private_hash *hb_p;
+	struct futex_private_hash *fph;
 	u32 hash;
=20
-	hb_p =3D futex_get_private_hb(key);
-	if (hb_p)
-		return futex_hash_private(key, hb_p->queues, hb_p->hash_mask);
+	fph =3D futex_get_private_hb(key);
+	if (fph)
+		return futex_hash_private(key, fph->queues, fph->hash_mask);
=20
 	hash =3D jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / 4,
@@ -289,14 +289,14 @@ struct futex_hash_bucket *__futex_hash(union futex_ke=
y *key)
 }
=20
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
-bool futex_put_private_hash(struct futex_private_hash *hb_p)
+bool futex_put_private_hash(struct futex_private_hash *fph)
 {
 	bool released;
=20
 	guard(preempt)();
-	released =3D rcuref_put_rcusafe(&hb_p->users);
+	released =3D rcuref_put_rcusafe(&fph->users);
 	if (released)
-		WRITE_ONCE(hb_p->released, true);
+		WRITE_ONCE(fph->released, true);
 	return released;
 }
=20
@@ -309,21 +309,21 @@ bool futex_put_private_hash(struct futex_private_hash=
 *hb_p)
  */
 void futex_hash_get(struct futex_hash_bucket *hb)
 {
-	struct futex_private_hash *hb_p =3D hb->hb_p;
+	struct futex_private_hash *fph =3D hb->priv;
=20
-	if (!hb_p)
+	if (!fph)
 		return;
=20
-	WARN_ON_ONCE(!rcuref_get(&hb_p->users));
+	WARN_ON_ONCE(!rcuref_get(&fph->users));
 }
=20
 void futex_hash_put(struct futex_hash_bucket *hb)
 {
-	struct futex_private_hash *hb_p =3D hb->hb_p;
+	struct futex_private_hash *fph =3D hb->priv;
=20
-	if (!hb_p)
+	if (!fph)
 		return;
-	futex_put_private_hash(hb_p);
+	futex_put_private_hash(fph);
 }
 #endif
=20
@@ -1167,7 +1167,7 @@ static void compat_exit_robust_list(struct task_struc=
t *curr)
 static void exit_pi_state_list(struct task_struct *curr)
 {
 	struct list_head *next, *head =3D &curr->pi_state_list;
-	struct futex_private_hash *hb_p;
+	struct futex_private_hash *fph;
 	struct futex_pi_state *pi_state;
 	union futex_key key =3D FUTEX_KEY_INIT;
=20
@@ -1181,7 +1181,7 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 	 * on the mutex.
 	 */
 	WARN_ON(curr !=3D current);
-	hb_p =3D futex_get_private_hash();
+	fph =3D futex_get_private_hash();
 	/*
 	 * We are a ZOMBIE and nobody can enqueue itself on
 	 * pi_state_list anymore, but we have to be careful
@@ -1244,8 +1244,8 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
-	if (hb_p)
-		futex_put_private_hash(hb_p);
+	if (fph)
+		futex_put_private_hash(fph);
 }
 #else
 static inline void exit_pi_state_list(struct task_struct *curr) { }
@@ -1360,10 +1360,10 @@ void futex_exit_release(struct task_struct *tsk)
 }
=20
 static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
-				   struct futex_private_hash *hb_p)
+				   struct futex_private_hash *fph)
 {
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
-	fhb->hb_p =3D hb_p;
+	fhb->priv =3D fph;
 #endif
 	atomic_set(&fhb->waiters, 0);
 	plist_head_init(&fhb->chain);
@@ -1373,7 +1373,7 @@ static void futex_hash_bucket_init(struct futex_hash_=
bucket *fhb,
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 void futex_hash_free(struct mm_struct *mm)
 {
-	struct futex_private_hash *hb_p;
+	struct futex_private_hash *fph;
=20
 	kvfree(mm->futex_phash_new);
 	/*
@@ -1384,19 +1384,19 @@ void futex_hash_free(struct mm_struct *mm)
 	 * Since there can not be a thread holding a reference to the private
 	 * hash we free it immediately.
 	 */
-	hb_p =3D rcu_dereference_raw(mm->futex_phash);
-	if (!hb_p)
+	fph =3D rcu_dereference_raw(mm->futex_phash);
+	if (!fph)
 		return;
=20
-	if (!hb_p->initial_ref_dropped && WARN_ON(!futex_put_private_hash(hb_p)))
+	if (!fph->initial_ref_dropped && WARN_ON(!futex_put_private_hash(fph)))
 		return;
=20
-	kvfree(hb_p);
+	kvfree(fph);
 }
=20
 static int futex_hash_allocate(unsigned int hash_slots)
 {
-	struct futex_private_hash *hb_p, *hb_tofree =3D NULL;
+	struct futex_private_hash *fph, *hb_tofree =3D NULL;
 	struct mm_struct *mm =3D current->mm;
 	size_t alloc_size;
 	int i;
@@ -1415,29 +1415,29 @@ static int futex_hash_allocate(unsigned int hash_sl=
ots)
 					&alloc_size)))
 		return -ENOMEM;
=20
-	hb_p =3D kvmalloc(alloc_size, GFP_KERNEL_ACCOUNT);
-	if (!hb_p)
+	fph =3D kvmalloc(alloc_size, GFP_KERNEL_ACCOUNT);
+	if (!fph)
 		return -ENOMEM;
=20
-	rcuref_init(&hb_p->users, 1);
-	hb_p->initial_ref_dropped =3D false;
-	hb_p->released =3D false;
-	hb_p->hash_mask =3D hash_slots - 1;
+	rcuref_init(&fph->users, 1);
+	fph->initial_ref_dropped =3D false;
+	fph->released =3D false;
+	fph->hash_mask =3D hash_slots - 1;
=20
 	for (i =3D 0; i < hash_slots; i++)
-		futex_hash_bucket_init(&hb_p->queues[i], hb_p);
+		futex_hash_bucket_init(&fph->queues[i], fph);
=20
 	scoped_guard(mutex, &mm->futex_hash_lock) {
 		if (mm->futex_phash_new) {
-			if (mm->futex_phash_new->hash_mask <=3D hb_p->hash_mask) {
+			if (mm->futex_phash_new->hash_mask <=3D fph->hash_mask) {
 				hb_tofree =3D mm->futex_phash_new;
 			} else {
-				hb_tofree =3D hb_p;
-				hb_p =3D mm->futex_phash_new;
+				hb_tofree =3D fph;
+				fph =3D mm->futex_phash_new;
 			}
 			mm->futex_phash_new =3D NULL;
 		}
-		futex_assign_new_hash(hb_p, mm);
+		futex_assign_new_hash(fph, mm);
 	}
 	kvfree(hb_tofree);
 	return 0;
@@ -1446,16 +1446,16 @@ static int futex_hash_allocate(unsigned int hash_sl=
ots)
 int futex_hash_allocate_default(void)
 {
 	unsigned int threads, buckets, current_buckets =3D 0;
-	struct futex_private_hash *hb_p;
+	struct futex_private_hash *fph;
=20
 	if (!current->mm)
 		return 0;
=20
 	scoped_guard(rcu) {
 		threads =3D min_t(unsigned int, get_nr_threads(current), num_online_cpus=
());
-		hb_p =3D rcu_dereference(current->mm->futex_phash);
-		if (hb_p)
-			current_buckets =3D hb_p->hash_mask + 1;
+		fph =3D rcu_dereference(current->mm->futex_phash);
+		if (fph)
+			current_buckets =3D fph->hash_mask + 1;
 	}
=20
 	/*
@@ -1473,12 +1473,12 @@ int futex_hash_allocate_default(void)
=20
 static int futex_hash_get_slots(void)
 {
-	struct futex_private_hash *hb_p;
+	struct futex_private_hash *fph;
=20
 	guard(rcu)();
-	hb_p =3D rcu_dereference(current->mm->futex_phash);
-	if (hb_p)
-		return hb_p->hash_mask + 1;
+	fph =3D rcu_dereference(current->mm->futex_phash);
+	if (fph)
+		return fph->hash_mask + 1;
 	return 0;
 }
=20
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 782021feffe2e..99218d220e534 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -118,7 +118,7 @@ struct futex_hash_bucket {
 	atomic_t waiters;
 	spinlock_t lock;
 	struct plist_head chain;
-	struct futex_private_hash *hb_p;
+	struct futex_private_hash *priv;
 } ____cacheline_aligned_in_smp;
=20
 /*
@@ -209,13 +209,13 @@ extern struct futex_hash_bucket *__futex_hash(union f=
utex_key *key);
 extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
 extern struct futex_private_hash *futex_get_private_hash(void);
-extern bool futex_put_private_hash(struct futex_private_hash *hb_p);
+extern bool futex_put_private_hash(struct futex_private_hash *fph);
=20
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
 static inline void futex_hash_get(struct futex_hash_bucket *hb) { }
 static inline void futex_hash_put(struct futex_hash_bucket *hb) { }
 static inline struct futex_private_hash *futex_get_private_hash(void) { re=
turn NULL; }
-static inline bool futex_put_private_hash(struct futex_private_hash *hb_p)=
 { return false; }
+static inline bool futex_put_private_hash(struct futex_private_hash *fph) =
{ return false; }
 #endif
=20
 DEFINE_CLASS(hb, struct futex_hash_bucket *,
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 67eebb5b4b212..0d150453a0b41 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -493,7 +493,7 @@ static int __futex_wait_multiple_setup(struct futex_vec=
tor *vs, int count, int *
=20
 int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wok=
en)
 {
-	struct futex_private_hash *hb_p;
+	struct futex_private_hash *fph;
 	int ret;
=20
 	/*
@@ -501,10 +501,10 @@ int futex_wait_multiple_setup(struct futex_vector *vs=
, int count, int *woken)
 	 * hash to avoid blocking on mm_struct::futex_hash_bucket during rehash
 	 * after changing the task state.
 	 */
-	hb_p =3D futex_get_private_hash();
+	fph =3D futex_get_private_hash();
 	ret =3D __futex_wait_multiple_setup(vs, count, woken);
-	if (hb_p)
-		futex_put_private_hash(hb_p);
+	if (fph)
+		futex_put_private_hash(fph);
 	return ret;
 }
=20
--=20
2.47.2


