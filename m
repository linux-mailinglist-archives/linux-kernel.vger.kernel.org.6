Return-Path: <linux-kernel+bounces-557994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C92A5E024
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFB93B273A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EF52561BC;
	Wed, 12 Mar 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uaW2RMB9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ZGlDE+T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2225524D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792733; cv=none; b=aY2OLis6QbDfBwNHYqNtELA9fhkRPfcPGPGlnC4TymVzEwZtPmwhJ+EudlOHsrZ6kM3PpMKTzuYzQLTsMoGStgdQnNvOnc9Vtm4AJXBFFna1E1QUYG5juatFIwkVRzqsfD746J4YxMJN8zS7/AxysbydACDwIJsBXfpO72PNaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792733; c=relaxed/simple;
	bh=vx4sdH74llEOpOcG8cANWMWyqu1PNu2SmRXiTBGWo+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0tHO61CN2rAc1jj8ouzZZQC9XMdcqAcCznK0ImZm3Dc+tCacWixwvveRJCa2RC3U0s+6raz7QOGTU3vJ+wCEs48ggzDm9SPD4HJYY6n62D5sMhhbhCdG/9cR4MZYxMqXySwbVMGzzEI0UXxVHZoyVj8b5bjOfhKQCmtgyvTlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uaW2RMB9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ZGlDE+T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 16:18:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vj0ehbSfcdyYO64QF8iLzZz6zNrMWGORTNzMzwKGRjI=;
	b=uaW2RMB9pLdL+/OIKTkcd22geO0kl95C/qTlMABCuxk3lv7+YUqzh5v7r+Twg6JTGuQ8FM
	HNhufq03zfTjw7hQ02zaObWScO0hmbdKT9CGb8CnUm0bmQpOB3cblR6CWX4zBlfVRv4865
	52omNuX7p64dacA95Ayo54IA61QlB4/Ar3VRCF2NT5S/5JOLQZjkjYHIyTqpQL9ntLYEQo
	wRGl38nGJEcRYsalZBI8HBJMB5b4Xfgye+1Ez6s/S9zJULimazW9/fDea5W3XOUrw31BT6
	LGdfjwU58t/saPPLPFEi9FZuv32Pg0iODrjH+ImW1B8Z00Qz5+4QL/W5YsEjGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vj0ehbSfcdyYO64QF8iLzZz6zNrMWGORTNzMzwKGRjI=;
	b=0ZGlDE+T6K5FCbp3S8rxdN37kNTqor0cm5N8Fbf7pqIt12xCXIWZuK1WcePoLtmM5dWsca
	vox7ISc4CA9FknAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 00/21] futex: Add support task local hash maps,
 FUTEX2_NUMA and FUTEX2_MPOL
Message-ID: <20250312151848.RlB_XuHA@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>

On 2025-03-12 16:16:13 [+0100], To linux-kernel@vger.kernel.org wrote:
> The complete tree is at
> 	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git/log/=
?h=3Dfutex_local_v10
> 	https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git fute=
x_local_v10
>=20
> v9=E2=80=A6v10: https://lore.kernel.org/all/20250225170914.289358-1-bigea=
sy@linutronix.de/
The exact diff vs peterz/locking/futex:

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 0cdd5882e89c1..19c37afa0432a 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -82,12 +82,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_=
t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3);
=20
-#ifdef CONFIG_BASE_SMALL
-static inline int futex_hash_allocate_default(void) { return 0; }
-static inline void futex_hash_free(struct mm_struct *mm) { }
-static inline void futex_mm_init(struct mm_struct *mm) { }
-#else /* !CONFIG_BASE_SMALL */
-
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
=20
@@ -97,7 +92,11 @@ static inline void futex_mm_init(struct mm_struct *mm)
 	mutex_init(&mm->futex_hash_lock);
 }
=20
-#endif /* CONFIG_BASE_SMALL */
+#else /* !CONFIG_FUTEX_PRIVATE_HASH */
+static inline int futex_hash_allocate_default(void) { return 0; }
+static inline void futex_hash_free(struct mm_struct *mm) { }
+static inline void futex_mm_init(struct mm_struct *mm) { }
+#endif /* CONFIG_FUTEX_PRIVATE_HASH */
=20
 #else /* !CONFIG_FUTEX */
 static inline void futex_init_task(struct task_struct *tsk) { }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 9399ee7d40201..e0e8adbe66bdd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -938,7 +938,7 @@ struct mm_struct {
 		 */
 		seqcount_t mm_lock_seq;
 #endif
-#if defined(CONFIG_FUTEX) && !defined(CONFIG_BASE_SMALL)
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 		struct mutex			futex_hash_lock;
 		struct futex_private_hash	__rcu *futex_phash;
 		struct futex_private_hash	*futex_phash_new;
diff --git a/include/linux/rcuref.h b/include/linux/rcuref.h
index 6322d8c1c6b42..2fb2af6d98249 100644
--- a/include/linux/rcuref.h
+++ b/include/linux/rcuref.h
@@ -30,7 +30,11 @@ static inline void rcuref_init(rcuref_t *ref, unsigned i=
nt cnt)
  * rcuref_read - Read the number of held reference counts of a rcuref
  * @ref:	Pointer to the reference count
  *
- * Return: The number of held references (0 ... N)
+ * Return: The number of held references (0 ... N). The value 0 does not
+ * indicate that it is safe to schedule the object, protected by this refe=
rence
+ * counter, for deconstruction.
+ * If you want to know if the reference counter has been marked DEAD (as
+ * signaled by rcuref_put()) please use rcuread_is_dead().
  */
 static inline unsigned int rcuref_read(rcuref_t *ref)
 {
@@ -40,6 +44,22 @@ static inline unsigned int rcuref_read(rcuref_t *ref)
 	return c >=3D RCUREF_RELEASED ? 0 : c + 1;
 }
=20
+/**
+ * rcuref_is_dead -	Check if the rcuref has been already marked dead
+ * @ref:		Pointer to the reference count
+ *
+ * Return: True if the object has been marked DEAD. This signals that a pr=
evious
+ * invocation of rcuref_put() returned true on this reference counter mean=
ing
+ * the protected object can safely be scheduled for deconstruction.
+ * Otherwise, returns false.
+ */
+static inline bool rcuref_is_dead(rcuref_t *ref)
+{
+	unsigned int c =3D atomic_read(&ref->refcnt);
+
+	return (c >=3D RCUREF_RELEASED) && (c < RCUREF_NOREF);
+}
+
 extern __must_check bool rcuref_get_slowpath(rcuref_t *ref);
=20
 /**
diff --git a/init/Kconfig b/init/Kconfig
index a0ea04c177842..a4502a9077e03 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1683,6 +1683,16 @@ config FUTEX_PI
 	depends on FUTEX && RT_MUTEXES
 	default y
=20
+config FUTEX_PRIVATE_HASH
+	bool
+	depends on FUTEX && !BASE_SMALL && MMU
+	default y
+
+config FUTEX_MPOL
+	bool
+	depends on FUTEX && NUMA
+	default y
+
 config EPOLL
 	bool "Enable eventpoll support" if EXPERT
 	default y
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 976a487bf3ad5..65523f3cfe32e 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -136,7 +136,7 @@ static inline bool futex_key_is_private(union futex_key=
 *key)
 static struct futex_hash_bucket *
 __futex_hash(union futex_key *key, struct futex_private_hash *fph);
=20
-#ifndef CONFIG_BASE_SMALL
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 static struct futex_hash_bucket *
 __futex_hash_private(union futex_key *key, struct futex_private_hash *fph)
 {
@@ -196,12 +196,12 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
 {
 	struct futex_private_hash *fph;
=20
-	lockdep_assert_held(&mm->futex_hash_lock);
 	WARN_ON_ONCE(mm->futex_phash_new);
=20
-	fph =3D mm->futex_phash;
+	fph =3D rcu_dereference_protected(mm->futex_phash,
+					lockdep_is_held(&mm->futex_hash_lock));
 	if (fph) {
-		if (rcuref_read(&fph->users) !=3D 0) {
+		if (!rcuref_is_dead(&fph->users)) {
 			mm->futex_phash_new =3D new;
 			return false;
 		}
@@ -262,6 +262,10 @@ bool futex_private_hash_get(struct futex_private_hash =
*fph)
=20
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
+	/*
+	 * Ignore the result; the DEAD state is picked up
+	 * when rcuref_get() starts failing via rcuref_is_dead().
+	 */
 	if (rcuref_put(&fph->users))
 		wake_up_var(fph->mm);
 }
@@ -301,7 +305,7 @@ void futex_hash_put(struct futex_hash_bucket *hb)
 	futex_private_hash_put(fph);
 }
=20
-#else
+#else /* !CONFIG_FUTEX_PRIVATE_HASH */
=20
 static inline struct futex_hash_bucket *
 __futex_hash_private(union futex_key *key, struct futex_private_hash *fph)
@@ -314,8 +318,9 @@ struct futex_hash_bucket *futex_hash(union futex_key *k=
ey)
 	return __futex_hash(key, NULL);
 }
=20
-#endif /* CONFIG_BASE_SMALL */
+#endif /* CONFIG_FUTEX_PRIVATE_HASH */
=20
+#ifdef CONFIG_FUTEX_MPOL
 static int __futex_key_to_node(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma =3D vma_lookup(mm, addr);
@@ -325,7 +330,7 @@ static int __futex_key_to_node(struct mm_struct *mm, un=
signed long addr)
 	if (!vma)
 		return FUTEX_NO_NODE;
=20
-	mpol =3D vma->vm_policy;
+	mpol =3D vma_policy(vma);
 	if (!mpol)
 		return FUTEX_NO_NODE;
=20
@@ -373,6 +378,14 @@ static int futex_mpol(struct mm_struct *mm, unsigned l=
ong addr)
 	guard(mmap_read_lock)(mm);
 	return __futex_key_to_node(mm, addr);
 }
+#else /* !CONFIG_FUTEX_MPOL */
+
+static int futex_mpol(struct mm_struct *mm, unsigned long addr)
+{
+	return FUTEX_NO_NODE;
+}
+
+#endif /* CONFIG_FUTEX_MPOL */
=20
 /**
  * futex_hash - Return the hash bucket in the global hash
@@ -420,7 +433,6 @@ __futex_hash(union futex_key *key, struct futex_private=
_hash *fph)
 	return &futex_queues[node][hash & futex_hashmask];
 }
=20
-
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
  * @time:	ptr to the given timeout value
@@ -932,9 +944,6 @@ int futex_unqueue(struct futex_q *q)
=20
 void futex_q_lockptr_lock(struct futex_q *q)
 {
-#if 0
-	struct futex_hash_bucket *hb;
-#endif
 	spinlock_t *lock_ptr;
=20
 	/*
@@ -949,18 +958,6 @@ void futex_q_lockptr_lock(struct futex_q *q)
 		spin_unlock(lock_ptr);
 		goto retry;
 	}
-#if 0
-	hb =3D container_of(lock_ptr, struct futex_hash_bucket, lock);
-	/*
-	 * The caller needs to either hold a reference on the hash (to ensure
-	 * that the hash is not resized) _or_ be enqueued on the hash. This
-	 * ensures that futex_q::lock_ptr is updated while moved to the new
-	 * hash during resize.
-	 * Once the hash bucket is locked the resize operation, which might be
-	 * in progress, will block on the lock.
-	 */
-	return hb;
-#endif
 }
=20
 /*
@@ -1497,7 +1494,7 @@ void futex_exit_release(struct task_struct *tsk)
 static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
 				   struct futex_private_hash *fph)
 {
-#ifndef CONFIG_BASE_SMALL
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 	fhb->priv =3D fph;
 #endif
 	atomic_set(&fhb->waiters, 0);
@@ -1505,21 +1502,30 @@ static void futex_hash_bucket_init(struct futex_has=
h_bucket *fhb,
 	spin_lock_init(&fhb->lock);
 }
=20
-#ifndef CONFIG_BASE_SMALL
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 void futex_hash_free(struct mm_struct *mm)
 {
+	struct futex_private_hash *fph;
+
 	kvfree(mm->futex_phash_new);
-	kvfree(mm->futex_phash);
+	fph =3D rcu_dereference_raw(mm->futex_phash);
+	if (fph) {
+		WARN_ON_ONCE(rcuref_read(&fph->users) > 1);
+		kvfree(fph);
+	}
 }
=20
 static bool futex_pivot_pending(struct mm_struct *mm)
 {
+	struct futex_private_hash *fph;
+
 	guard(rcu)();
=20
 	if (!mm->futex_phash_new)
 		return false;
=20
-	return !rcuref_read(&mm->futex_phash->users);
+	fph =3D rcu_dereference(mm->futex_phash);
+	return !rcuref_read(&fph->users);
 }
=20
 static bool futex_hash_less(struct futex_private_hash *a,
@@ -1560,7 +1566,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, bool custom)
 	 */
 	scoped_guard (rcu) {
 		fph =3D rcu_dereference(mm->futex_phash);
-		if (fph && !mm->futex_phash->hash_mask) {
+		if (fph && !fph->hash_mask) {
 			if (custom)
 				return -EBUSY;
 			return 0;
@@ -1591,7 +1597,8 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, bool custom)
 		struct futex_private_hash *free __free(kvfree) =3D NULL;
 		struct futex_private_hash *cur, *new;
=20
-		cur =3D mm->futex_phash;
+		cur =3D rcu_dereference_protected(mm->futex_phash,
+						lockdep_is_held(&mm->futex_hash_lock));
 		new =3D mm->futex_phash_new;
 		mm->futex_phash_new =3D NULL;
=20
@@ -1602,7 +1609,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, bool custom)
 				 * allocated a replacement hash, drop the initial
 				 * reference on the existing hash.
 				 */
-				futex_private_hash_put(mm->futex_phash);
+				futex_private_hash_put(cur);
 			}
=20
 			if (new) {
@@ -1683,7 +1690,7 @@ static int futex_hash_get_slots(void)
=20
 static int futex_hash_allocate(unsigned int hash_slots, bool custom)
 {
-	return 0;
+	return -EINVAL;
 }
=20
 static int futex_hash_get_slots(void)
@@ -1723,6 +1730,7 @@ static int __init futex_init(void)
 #else
 	hashsize =3D 256 * num_possible_cpus();
 	hashsize /=3D num_possible_nodes();
+	hashsize =3D max(4, hashsize);
 	hashsize =3D roundup_pow_of_two(hashsize);
 #endif
 	futex_hashshift =3D ilog2(hashsize);
@@ -1740,12 +1748,15 @@ static int __init futex_init(void)
 		BUG_ON(!table);
=20
 		for (i =3D 0; i < hashsize; i++)
-			futex_hash_bucket_init(&table[i], 0);
+			futex_hash_bucket_init(&table[i], NULL);
=20
 		futex_queues[n] =3D table;
 	}
=20
 	futex_hashmask =3D hashsize - 1;
+	pr_info("futex hash table entries: %lu (%lu bytes on %d NUMA nodes, total=
 %lu KiB, %s).\n",
+		hashsize, size, num_possible_nodes(), size * num_possible_nodes() / 1024,
+		order > MAX_PAGE_ORDER ? "vmalloc" : "linear");
 	return 0;
 }
 core_initcall(futex_init);
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 40f06523a3565..52e9c0c4b6c87 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -223,14 +223,15 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleep=
er *timeout,
=20
 extern struct futex_hash_bucket *futex_hash(union futex_key *key);
=20
-#ifndef CONFIG_BASE_SMALL
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
=20
 extern struct futex_private_hash *futex_private_hash(void);
 extern bool futex_private_hash_get(struct futex_private_hash *fph);
 extern void futex_private_hash_put(struct futex_private_hash *fph);
-#else
+
+#else /* !CONFIG_FUTEX_PRIVATE_HASH */
 static inline void futex_hash_get(struct futex_hash_bucket *hb) { }
 static inline void futex_hash_put(struct futex_hash_bucket *hb) { }
=20
diff --git a/mm/nommu.c b/mm/nommu.c
index baa79abdaf037..d04e601a8f4d7 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -209,6 +209,11 @@ EXPORT_SYMBOL(vmalloc_noprof);
=20
 void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __weak __ali=
as(__vmalloc_noprof);
=20
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int nod=
e)
+{
+	return vmalloc_huge_noprof(size, gfp_mask);
+}
+
 /*
  *	vzalloc - allocate virtually contiguous memory with zero fill
  *
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 39fe43183a64f..69247b46413ca 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3968,9 +3968,9 @@ EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
=20
 void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int nod=
e)
 {
-	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
-				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
-				    node, __builtin_return_address(0));
+	return __vmalloc_node_range_noprof(size, 1, VMALLOC_START, VMALLOC_END,
+					   gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+					   node, __builtin_return_address(0));
 }
=20
 /**


Sebastian

