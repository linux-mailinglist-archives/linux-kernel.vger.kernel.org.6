Return-Path: <linux-kernel+bounces-557991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261CA5E01B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4191890D91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1DB25C6EF;
	Wed, 12 Mar 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OIpKUAqb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G2XdG3/x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83732571BF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792612; cv=none; b=fCcq6qFYtgX0EBqg0nZWHpLtt3Fxj4e1McM6cMHta9yLjdVrXezJ92QbiVurguFdVGwZsKTaLoW1shWNdZLimsxCwvyUj9z2VAgSVfRUQ/m7eMSYHoF5VKg1UTYhAyswY6lCDoj0ZBUAtt93kajywSvmnNOnx6OB1tUq4knI3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792612; c=relaxed/simple;
	bh=olTY4zkLJtGIgjHa3oTn07pR9E/f5tvEKq1v4Ae3qyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYKg68/bcOfYDfqkVtETjzq6GoE/CUMx+e5J+TrGeIWH76gUUQORKyA4TRitCFBRX9spt60iTj7IN8WjPD6ORSb6CI9U+s5yDOTSWKzMK6PDx+3xUfvLvZw6PN1CdEtCDhxy28kUYTUAcyoyeBDg8L7kQIJjLWhvUJY/v5C1sSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OIpKUAqb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G2XdG3/x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHcDZa1MSrRJbJWT1Y3YbvdWTEoyBRWmqHy2swZ12vg=;
	b=OIpKUAqbVERxihz+KXrhCNZxp95H8U0+YcqEQjIkzEH+DYS97cd3FFY/FwwJ+JIvTurJOr
	JfretJ1evh3ZtwLVcSoXbkyPA8kwYw6zuNUaLQrZN3YnyGI0ZaL5oeHJzaocwoln/ZqDh1
	gO9Oeho0ENtKrcQ7ensFFkJAfsqCl26gBIivTqvCjJDSdJVqQFDP+stNU0bbtOSFQUT73U
	87rBaGWzzYauw6trO/auKeMHo/UaFyIb8ikcwdv1qTKmeFUCviCZkXS/gv4i9KegO5icpo
	9oz2z5/LWynSyUB9rk5pd4mciPkfj98aj4pop0pGWbIFlnI1KWfnYkxp41SYug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aHcDZa1MSrRJbJWT1Y3YbvdWTEoyBRWmqHy2swZ12vg=;
	b=G2XdG3/xAxM2XRrbtdX+T2DYmjRvfITnIA4oOV7WqaWqGHS4RUdNlMAgfVXpz62wrJAdJ3
	d5FqeSs7gBarzWBg==
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
Subject: [PATCH v10 17/21] futex: Untangle and naming
Date: Wed, 12 Mar 2025 16:16:30 +0100
Message-ID: <20250312151634.2183278-18-bigeasy@linutronix.de>
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

Untangle the futex_private_hash::users increment from finding the hb.

  hb =3D __futex_hash(key) /* finds the hb */
  hb =3D futex_hash(key)   /* finds the hb and inc users */

Use __futex_hash() for re-hashing, notably allowing to rehash into the
global hash.

This gets us:

  hb =3D futex_hash(key) /* gets hb and inc users */
  futex_hash_get(hb)   /* inc users */
  futex_hash_put(hb)   /* dec users */

But then we have:

  fph =3D futex_get_private_hash()  /* get fph and inc */
  futex_put_private_hash()        /* dec */

Which doesn't match naming, so change to:

  fph =3D futex_private_hash()    /* get and inc */
  futex_private_hash_get(fph)   /* inc */
  futex_private_hash_put(fph)   /* dec */

Add a CLASS for the private_hash, to clean up some trivial wrappers.

Additional random renaming that happened while mucking about with the
code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c     | 170 +++++++++++++++++++++++-----------------
 kernel/futex/futex.h    |  27 +++++--
 kernel/futex/waitwake.c |  25 ++----
 3 files changed, 124 insertions(+), 98 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 37c3e020f2f03..1c00890cc4fb5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -124,25 +124,34 @@ static inline bool futex_key_is_private(union futex_k=
ey *key)
 	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
 }
=20
-static struct futex_hash_bucket *futex_hash_private(union futex_key *key,
-						    struct futex_hash_bucket *fhb,
-						    u32 hash_mask)
+static struct futex_hash_bucket *
+__futex_hash(union futex_key *key, struct futex_private_hash *fph);
+
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
+static struct futex_hash_bucket *
+__futex_hash_private(union futex_key *key, struct futex_private_hash *fph)
 {
 	u32 hash;
=20
+	if (!futex_key_is_private(key))
+		return NULL;
+
+	if (!fph)
+		fph =3D rcu_dereference(key->private.mm->futex_phash);
+	if (!fph || !fph->hash_mask)
+		return NULL;
+
 	hash =3D jhash2((void *)&key->private.address,
 		      sizeof(key->private.address) / 4,
 		      key->both.offset);
-	return &fhb[hash & hash_mask];
+	return &fph->queues[hash & fph->hash_mask];
 }
=20
-#ifdef CONFIG_FUTEX_PRIVATE_HASH
-static void futex_rehash_current_users(struct futex_private_hash *old,
-				       struct futex_private_hash *new)
+static void futex_rehash_private(struct futex_private_hash *old,
+				 struct futex_private_hash *new)
 {
 	struct futex_hash_bucket *hb_old, *hb_new;
 	unsigned int slots =3D old->hash_mask + 1;
-	u32 hash_mask =3D new->hash_mask;
 	unsigned int i;
=20
 	for (i =3D 0; i < slots; i++) {
@@ -158,7 +167,7 @@ static void futex_rehash_current_users(struct futex_pri=
vate_hash *old,
=20
 			WARN_ON_ONCE(this->lock_ptr !=3D &hb_old->lock);
=20
-			hb_new =3D futex_hash_private(&this->key, new->queues, hash_mask);
+			hb_new =3D __futex_hash(&this->key, new);
 			futex_hb_waiters_inc(hb_new);
 			/*
 			 * The new pointer isn't published yet but an already
@@ -173,8 +182,8 @@ static void futex_rehash_current_users(struct futex_pri=
vate_hash *old,
 	}
 }
=20
-static bool futex_assign_new_hash(struct mm_struct *mm,
-				  struct futex_private_hash *new)
+static bool __futex_pivot_hash(struct mm_struct *mm,
+			       struct futex_private_hash *new)
 {
 	struct futex_private_hash *fph;
=20
@@ -194,14 +203,27 @@ static bool futex_assign_new_hash(struct mm_struct *m=
m,
 			return false;
 		}
=20
-		futex_rehash_current_users(fph, new);
+		futex_rehash_private(fph, new);
 	}
 	rcu_assign_pointer(mm->futex_phash, new);
 	kvfree_rcu(fph, rcu);
 	return true;
 }
=20
-struct futex_private_hash *futex_get_private_hash(void)
+static void futex_pivot_hash(struct mm_struct *mm)
+{
+	scoped_guard (mutex, &mm->futex_hash_lock) {
+		struct futex_private_hash *fph;
+
+		fph =3D mm->futex_phash_new;
+		if (fph) {
+			mm->futex_phash_new =3D NULL;
+			__futex_pivot_hash(mm, fph);
+		}
+	}
+}
+
+struct futex_private_hash *futex_private_hash(void)
 {
 	struct mm_struct *mm =3D current->mm;
 	/*
@@ -225,41 +247,73 @@ struct futex_private_hash *futex_get_private_hash(voi=
d)
 		if (rcuref_get(&fph->users))
 			return fph;
 	}
-	scoped_guard (mutex, &mm->futex_hash_lock) {
-		struct futex_private_hash *fph;
-
-		fph =3D mm->futex_phash_new;
-		if (fph) {
-			mm->futex_phash_new =3D NULL;
-			futex_assign_new_hash(mm, fph);
-		}
-	}
+	futex_pivot_hash(mm);
 	goto again;
 }
=20
-void futex_put_private_hash(struct futex_private_hash *fph)
+bool futex_private_hash_get(struct futex_private_hash *fph)
 {
-	/* Ignore return value, last put is verified via rcuref_is_dead() */
-	if (rcuref_put(&fph->users)) {
-		;
+	return rcuref_get(&fph->users);
+}
+
+void futex_private_hash_put(struct futex_private_hash *fph)
+{
+	/*
+	 * Ignore the result; the DEAD state is picked up
+	 * when rcuref_get() starts failing via rcuref_is_dead().
+	 */
+	bool __maybe_unused ignore =3D rcuref_put(&fph->users);
+}
+
+struct futex_hash_bucket *futex_hash(union futex_key *key)
+{
+	struct futex_private_hash *fph;
+	struct futex_hash_bucket *hb;
+
+again:
+	scoped_guard (rcu) {
+		hb =3D __futex_hash(key, NULL);
+		fph =3D hb->priv;
+
+		if (!fph || futex_private_hash_get(fph))
+			return hb;
 	}
+	futex_pivot_hash(key->private.mm);
+	goto again;
 }
=20
-static struct futex_private_hash *futex_get_private_hb(union futex_key *ke=
y)
+void futex_hash_get(struct futex_hash_bucket *hb)
 {
-	if (!futex_key_is_private(key))
-		return NULL;
+	struct futex_private_hash *fph =3D hb->priv;
=20
-	return futex_get_private_hash();
+	if (!fph)
+		return;
+	WARN_ON_ONCE(!futex_private_hash_get(fph));
 }
=20
-#else
+void futex_hash_put(struct futex_hash_bucket *hb)
+{
+	struct futex_private_hash *fph =3D hb->priv;
=20
-static struct futex_private_hash *futex_get_private_hb(union futex_key *ke=
y)
+	if (!fph)
+		return;
+	futex_private_hash_put(fph);
+}
+
+#else /* !CONFIG_FUTEX_PRIVATE_HASH */
+
+static inline struct futex_hash_bucket *
+__futex_hash_private(union futex_key *key, struct futex_private_hash *fph)
 {
 	return NULL;
 }
-#endif
+
+struct futex_hash_bucket *futex_hash(union futex_key *key)
+{
+	return __futex_hash(key, NULL);
+}
+
+#endif /* CONFIG_FUTEX_PRIVATE_HASH */
=20
 /**
  * futex_hash - Return the hash bucket in the global hash
@@ -269,14 +323,15 @@ static struct futex_private_hash *futex_get_private_h=
b(union futex_key *key)
  * corresponding hash bucket in the global hash. If the FUTEX is private a=
nd
  * a local hash table is privated then this one is used.
  */
-struct futex_hash_bucket *__futex_hash(union futex_key *key)
+static struct futex_hash_bucket *
+__futex_hash(union futex_key *key, struct futex_private_hash *fph)
 {
-	struct futex_private_hash *fph;
+	struct futex_hash_bucket *hb;
 	u32 hash;
=20
-	fph =3D futex_get_private_hb(key);
-	if (fph)
-		return futex_hash_private(key, fph->queues, fph->hash_mask);
+	hb =3D __futex_hash_private(key, fph);
+	if (hb)
+		return hb;
=20
 	hash =3D jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / 4,
@@ -284,34 +339,6 @@ struct futex_hash_bucket *__futex_hash(union futex_key=
 *key)
 	return &futex_queues[hash & futex_hashmask];
 }
=20
-#ifdef CONFIG_FUTEX_PRIVATE_HASH
-/**
- * futex_hash_get - Get an additional reference for the local hash.
- * @hb:		    ptr to the private local hash.
- *
- * Obtain an additional reference for the already obtained hash bucket. The
- * caller must already own an reference.
- */
-void futex_hash_get(struct futex_hash_bucket *hb)
-{
-	struct futex_private_hash *fph =3D hb->priv;
-
-	if (!fph)
-		return;
-
-	WARN_ON_ONCE(!rcuref_get(&fph->users));
-}
-
-void futex_hash_put(struct futex_hash_bucket *hb)
-{
-	struct futex_private_hash *fph =3D hb->priv;
-
-	if (!fph)
-		return;
-	futex_put_private_hash(fph);
-}
-#endif
-
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
  * @time:	ptr to the given timeout value
@@ -1152,7 +1179,6 @@ static void compat_exit_robust_list(struct task_struc=
t *curr)
 static void exit_pi_state_list(struct task_struct *curr)
 {
 	struct list_head *next, *head =3D &curr->pi_state_list;
-	struct futex_private_hash *fph;
 	struct futex_pi_state *pi_state;
 	union futex_key key =3D FUTEX_KEY_INIT;
=20
@@ -1166,7 +1192,7 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 	 * on the mutex.
 	 */
 	WARN_ON(curr !=3D current);
-	fph =3D futex_get_private_hash();
+	guard(private_hash)();
 	/*
 	 * We are a ZOMBIE and nobody can enqueue itself on
 	 * pi_state_list anymore, but we have to be careful
@@ -1229,8 +1255,6 @@ static void exit_pi_state_list(struct task_struct *cu=
rr)
 		raw_spin_lock_irq(&curr->pi_lock);
 	}
 	raw_spin_unlock_irq(&curr->pi_lock);
-	if (fph)
-		futex_put_private_hash(fph);
 }
 #else
 static inline void exit_pi_state_list(struct task_struct *curr) { }
@@ -1410,9 +1434,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s)
 			 * mm->futex_hash_lock which we currently hold and last
 			 * put is verified via rcuref_is_dead().
 			 */
-			if (rcuref_put(&mm->futex_phash->users)) {
-				;
-			}
+			futex_private_hash_put(mm->futex_phash);
 		}
=20
 		if (mm->futex_phash_new) {
@@ -1433,7 +1455,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s)
 		 * Will set mm->futex_phash_new on failure;
 		 * futex_get_private_hash() will try again.
 		 */
-		futex_assign_new_hash(mm, fph);
+		__futex_pivot_hash(mm, fph);
 	}
 	kvfree(hb_tofree);
 	return 0;
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 5b6b58e8a7008..8eba9982bcae1 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -204,23 +204,38 @@ extern struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns);
=20
-extern struct futex_hash_bucket *__futex_hash(union futex_key *key);
+extern struct futex_hash_bucket *futex_hash(union futex_key *key);
+
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
-extern struct futex_private_hash *futex_get_private_hash(void);
-extern void futex_put_private_hash(struct futex_private_hash *fph);
+
+extern struct futex_private_hash *futex_private_hash(void);
+extern bool futex_private_hash_get(struct futex_private_hash *fph);
+extern void futex_private_hash_put(struct futex_private_hash *fph);
=20
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
 static inline void futex_hash_get(struct futex_hash_bucket *hb) { }
 static inline void futex_hash_put(struct futex_hash_bucket *hb) { }
-static inline struct futex_private_hash *futex_get_private_hash(void) { re=
turn NULL; }
-static inline void futex_put_private_hash(struct futex_private_hash *fph) =
{ }
+
+static inline struct futex_private_hash *futex_private_hash(void)
+{
+	return NULL;
+}
+static inline bool futex_private_hash_get(struct futex_private_hash *fph)
+{
+	return false;
+}
+static inline void futex_private_hash_put(struct futex_private_hash *fph) =
{ }
 #endif
=20
 DEFINE_CLASS(hb, struct futex_hash_bucket *,
 	     if (_T) futex_hash_put(_T),
-	     __futex_hash(key), union futex_key *key);
+	     futex_hash(key), union futex_key *key);
+
+DEFINE_CLASS(private_hash, struct futex_private_hash *,
+	     if (_T) futex_private_hash_put(_T),
+	     futex_private_hash(), void);
=20
 /**
  * futex_match - Check whether two futex keys are equal
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 0d150453a0b41..74647f6bf75de 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -400,12 +400,18 @@ int futex_unqueue_multiple(struct futex_vector *v, in=
t count)
  *  -  0 - Success
  *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
  */
-static int __futex_wait_multiple_setup(struct futex_vector *vs, int count,=
 int *woken)
+int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wok=
en)
 {
 	bool retry =3D false;
 	int ret, i;
 	u32 uval;
=20
+	/*
+	 * Make sure to have a reference on the private_hash such that we
+	 * don't block on rehash after changing the task state below.
+	 */
+	guard(private_hash)();
+
 	/*
 	 * Enqueuing multiple futexes is tricky, because we need to enqueue
 	 * each futex on the list before dealing with the next one to avoid
@@ -491,23 +497,6 @@ static int __futex_wait_multiple_setup(struct futex_ve=
ctor *vs, int count, int *
 	return 0;
 }
=20
-int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wok=
en)
-{
-	struct futex_private_hash *fph;
-	int ret;
-
-	/*
-	 * Assume to have a private futex and acquire a reference on the private
-	 * hash to avoid blocking on mm_struct::futex_hash_bucket during rehash
-	 * after changing the task state.
-	 */
-	fph =3D futex_get_private_hash();
-	ret =3D __futex_wait_multiple_setup(vs, count, woken);
-	if (fph)
-		futex_put_private_hash(fph);
-	return ret;
-}
-
 /**
  * futex_sleep_multiple - Check sleeping conditions and sleep
  * @vs:    List of futexes to wait for
--=20
2.47.2


