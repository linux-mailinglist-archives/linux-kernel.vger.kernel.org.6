Return-Path: <linux-kernel+bounces-557983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003C7A5E010
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DE33BBD69
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E2724E00E;
	Wed, 12 Mar 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ewfi0l8/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CsqMtexp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94D2566DF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792610; cv=none; b=GwLgG5rVZaQ3jmK6F/SBnb+YAUB+IU/bEHQVHtZQ4D8pcHAqPdzgSn2AspIe7pysXjcOFEzf5u5nRAw0tdmndasiiUYn0RDqEfF7/6A9KOXSkpy6c8V0+5ckTVUCPZa7IeUiv9hPO5140MyUmIK1Zz0kBwUcwvoSF+o7G/UzOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792610; c=relaxed/simple;
	bh=w6nmezl4P7xWIJ1VKGZJWoIDWUkwhzVPj7rCnwJ6W/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnRo1QbHDC+OYql3Jx1o/03l/HXiJKVh+b2E3xHov5uB1i+kLhHp2aPVI8pFHhBPbjau0kZsU4gotF2AEIeQz0jsMY+SfUuIfK2ju+9OjQPkQSrcu0DvNuMu0JoYRg0624THEedZFj4+TDf0dUxwXP41ys5iq40vRdhxcdRDQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ewfi0l8/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CsqMtexp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wES9Ujp59eDAVRR2NFrJ5uT4AeYkmwPj68ViJNLFAAk=;
	b=ewfi0l8/50RJkq1Y79QNpLu212Xo0EUDryIGXSX88hDzlxQ+2n9DjnGt/7lFqrBEV2VJv/
	uBrmXID/6Ttw+vPScsTOlIvGW8jXRhRiz1918Fx9AE9thG9F9UrNKVgj/5EyAVO40oKJv0
	yM5bXEMsKtMuGOJAdWzwyM44z4sPQMFK4puBKds77Nwohb7JkrBKbsLMADVBh+yCRUjupd
	jjF2faU/nWYvdEoTwHMXnrSRtZnHeKuy/RmaJCuzVc8f7Djso0dj6W8658hqq4rtfgwVJO
	Nd/L1qqGbyxpRzU0KtrP4+BvmSLcOShBoHS6hH2/NrQOBi2kWLf7eQ7APb1/RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wES9Ujp59eDAVRR2NFrJ5uT4AeYkmwPj68ViJNLFAAk=;
	b=CsqMtexpgrFU9U2b9c5qRX8/zLm9pH9lXqumx5Oe7ZFKO2E/4gGUROnjyKBK7jQ1ADpHsT
	iuGUp8CeB9M9ldBQ==
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
Subject: [PATCH v10 14/21] futex: Resize local futex hash table based on number of threads.
Date: Wed, 12 Mar 2025 16:16:27 +0100
Message-ID: <20250312151634.2183278-15-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Automatically size the local hash based on the number of threads but
don't exceed the number of online CPUs. The logic tries to allocate
between 16 and futex_hashsize (the default for the system wide hash
bucket) and uses 4 * number-of-threads.

On CONFIG_BASE_SMALL configs, the additional members for private hash
resize have been removed in order to save memory on mm_struct and avoid
any additional memory consumption. To achive this, a
CONFIG_FUTEX_PRIVATE_HASH has been introduced which depends on
!BASE_SMALL and can be extended later.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h    | 20 ++++++--------
 include/linux/mm_types.h |  2 +-
 init/Kconfig             |  5 ++++
 kernel/fork.c            |  4 +--
 kernel/futex/core.c      | 57 ++++++++++++++++++++++++++++++++++++----
 kernel/futex/futex.h     |  8 ++++++
 6 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index bfb38764bac7a..7e14d2e9162d2 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -78,6 +78,8 @@ void futex_exec_release(struct task_struct *tsk);
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3);
+
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
=20
@@ -87,14 +89,13 @@ static inline void futex_mm_init(struct mm_struct *mm)
 	mutex_init(&mm->futex_hash_lock);
 }
=20
-static inline bool futex_hash_requires_allocation(void)
-{
-	if (current->mm->futex_phash)
-		return false;
-	return true;
-}
+#else /* !CONFIG_FUTEX_PRIVATE_HASH */
+static inline int futex_hash_allocate_default(void) { return 0; }
+static inline void futex_hash_free(struct mm_struct *mm) { }
+static inline void futex_mm_init(struct mm_struct *mm) { }
+#endif /* CONFIG_FUTEX_PRIVATE_HASH */
=20
-#else
+#else /* !CONFIG_FUTEX */
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
@@ -116,11 +117,6 @@ static inline int futex_hash_allocate_default(void)
 static inline void futex_hash_free(struct mm_struct *mm) { }
 static inline void futex_mm_init(struct mm_struct *mm) { }
=20
-static inline bool futex_hash_requires_allocation(void)
-{
-	return false;
-}
-
 #endif
=20
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 46abaf1ce1c0a..e0e8adbe66bdd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -938,7 +938,7 @@ struct mm_struct {
 		 */
 		seqcount_t mm_lock_seq;
 #endif
-#ifdef CONFIG_FUTEX
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 		struct mutex			futex_hash_lock;
 		struct futex_private_hash	__rcu *futex_phash;
 		struct futex_private_hash	*futex_phash_new;
diff --git a/init/Kconfig b/init/Kconfig
index a0ea04c177842..bb209c12a2bda 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1683,6 +1683,11 @@ config FUTEX_PI
 	depends on FUTEX && RT_MUTEXES
 	default y
=20
+config FUTEX_PRIVATE_HASH
+	bool
+	depends on FUTEX && !BASE_SMALL
+	default y
+
 config EPOLL
 	bool "Enable eventpoll support" if EXPERT
 	default y
diff --git a/kernel/fork.c b/kernel/fork.c
index 440c5808f70a2..69f98d7e85054 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2141,9 +2141,7 @@ static bool need_futex_hash_allocate_default(u64 clon=
e_flags)
 {
 	if ((clone_flags & (CLONE_THREAD | CLONE_VM)) !=3D (CLONE_THREAD | CLONE_=
VM))
 		return false;
-	if (!thread_group_empty(current))
-		return false;
-	return futex_hash_requires_allocation();
+	return true;
 }
=20
 /*
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index c5a9db946b421..229009279ee7d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -138,6 +138,7 @@ static struct futex_hash_bucket *futex_hash_private(uni=
on futex_key *key,
 	return &fhb[hash & hash_mask];
 }
=20
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 static void futex_rehash_current_users(struct futex_private_hash *old,
 				       struct futex_private_hash *new)
 {
@@ -256,6 +257,14 @@ static struct futex_private_hash *futex_get_private_hb=
(union futex_key *key)
 	return futex_get_private_hash();
 }
=20
+#else
+
+static struct futex_private_hash *futex_get_private_hb(union futex_key *ke=
y)
+{
+	return NULL;
+}
+#endif
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -279,6 +288,7 @@ struct futex_hash_bucket *__futex_hash(union futex_key =
*key)
 	return &futex_queues[hash & futex_hashmask];
 }
=20
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 bool futex_put_private_hash(struct futex_private_hash *hb_p)
 {
 	bool released;
@@ -315,6 +325,7 @@ void futex_hash_put(struct futex_hash_bucket *hb)
 		return;
 	futex_put_private_hash(hb_p);
 }
+#endif
=20
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
@@ -1351,12 +1362,15 @@ void futex_exit_release(struct task_struct *tsk)
 static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
 				   struct futex_private_hash *hb_p)
 {
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 	fhb->hb_p =3D hb_p;
+#endif
 	atomic_set(&fhb->waiters, 0);
 	plist_head_init(&fhb->chain);
 	spin_lock_init(&fhb->lock);
 }
=20
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 void futex_hash_free(struct mm_struct *mm)
 {
 	struct futex_private_hash *hb_p;
@@ -1389,10 +1403,7 @@ static int futex_hash_allocate(unsigned int hash_slo=
ts)
=20
 	if (hash_slots =3D=3D 0)
 		hash_slots =3D 16;
-	if (hash_slots < 2)
-		hash_slots =3D 2;
-	if (hash_slots > 131072)
-		hash_slots =3D 131072;
+	hash_slots =3D clamp(hash_slots, 2, futex_hashmask + 1);
 	if (!is_power_of_2(hash_slots))
 		hash_slots =3D rounddown_pow_of_two(hash_slots);
=20
@@ -1434,7 +1445,30 @@ static int futex_hash_allocate(unsigned int hash_slo=
ts)
=20
 int futex_hash_allocate_default(void)
 {
-	return futex_hash_allocate(0);
+	unsigned int threads, buckets, current_buckets =3D 0;
+	struct futex_private_hash *hb_p;
+
+	if (!current->mm)
+		return 0;
+
+	scoped_guard(rcu) {
+		threads =3D min_t(unsigned int, get_nr_threads(current), num_online_cpus=
());
+		hb_p =3D rcu_dereference(current->mm->futex_phash);
+		if (hb_p)
+			current_buckets =3D hb_p->hash_mask + 1;
+	}
+
+	/*
+	 * The default allocation will remain within
+	 *   16 <=3D threads * 4 <=3D global hash size
+	 */
+	buckets =3D roundup_pow_of_two(4 * threads);
+	buckets =3D clamp(buckets, 16, futex_hashmask + 1);
+
+	if (current_buckets >=3D buckets)
+		return 0;
+
+	return futex_hash_allocate(buckets);
 }
=20
 static int futex_hash_get_slots(void)
@@ -1448,6 +1482,19 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
=20
+#else
+
+static int futex_hash_allocate(unsigned int hash_slots)
+{
+	return -EINVAL;
+}
+
+static int futex_hash_get_slots(void)
+{
+	return 0;
+}
+#endif
+
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3)
 {
 	int ret;
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 973efcca2e01b..782021feffe2e 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -205,11 +205,19 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleep=
er *timeout,
 		  int flags, u64 range_ns);
=20
 extern struct futex_hash_bucket *__futex_hash(union futex_key *key);
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
 extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
 extern struct futex_private_hash *futex_get_private_hash(void);
 extern bool futex_put_private_hash(struct futex_private_hash *hb_p);
=20
+#else /* !CONFIG_FUTEX_PRIVATE_HASH */
+static inline void futex_hash_get(struct futex_hash_bucket *hb) { }
+static inline void futex_hash_put(struct futex_hash_bucket *hb) { }
+static inline struct futex_private_hash *futex_get_private_hash(void) { re=
turn NULL; }
+static inline bool futex_put_private_hash(struct futex_private_hash *hb_p)=
 { return false; }
+#endif
+
 DEFINE_CLASS(hb, struct futex_hash_bucket *,
 	     if (_T) futex_hash_put(_T),
 	     __futex_hash(key), union futex_key *key);
--=20
2.47.2


