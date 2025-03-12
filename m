Return-Path: <linux-kernel+bounces-557985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D74FA5E012
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC4B3B59DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29925A2D3;
	Wed, 12 Mar 2025 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKlaf6Mi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtzKOL2o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A992571A7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792611; cv=none; b=VWbfZNYLNnRN3XJhmbkf+HTOfg+zviheTV5SbjUrRim9t+YwcCIQoHv+bRPr1tdpX7MKSSt4mdX5CB06NQvChXU22tpu8BVfLw5sKvpuGZD9ylaXCmDjZjIeLMumaQSA9GgmfYxSJfhAQzb8ogypcW/0h3qYCBkXfwLLS6DcCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792611; c=relaxed/simple;
	bh=SIbPV6uUijvWYp91xoelpRYdlXcaYkw3NXEvR43WxIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOAjwbS8P/lDBLne7LRYuBtj/R0bVhVI4F9FnePfyFMqus0XY6CtN/V1KUHIeljGVT/zaRwhVTUuaffo/W5DMg3anbdk5WkT6SqUhx1teoR2K48YnLUZ0d1Sfixduixdw2VOo3/MdJ3cqyoYoZrdKXuggp4yDym7dQjkDQROmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKlaf6Mi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtzKOL2o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpgcsEM4Xbd8wF12Glc8/S+/uLAOG7pGhETgaTzw7eM=;
	b=xKlaf6MiVtn25d0+s9jXklOHSuHia7eU4xwC5UK6BvH0Z2ozjG80O7txTAvO/3WsZUo967
	0odqMcEHCGXXWq0u8wsgavUwmC+5Abq0y4VDReP9V4iYKE8IdYqZTti8ojs2PpgeCpXn5r
	FrvajH6C8q4PYeLJEYi62e5Tpj8r8nxN7m4l/14/vimqaGFeeTr7EZbourlAh+po52ndST
	dqTWYG6FDpqQhKiu6htEHLAiPblElGL26bY0alKjQzSp/Hoh8fj+O/NQU0KYrl05XjLRcG
	dAn2OUYBR00ahoc9OxY+GnYeBF8YoGBCS9Ox7Bw0LGX4adQ3QblSCSiP8mXdIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpgcsEM4Xbd8wF12Glc8/S+/uLAOG7pGhETgaTzw7eM=;
	b=rtzKOL2oqX9RInGgutz60mL4+T7V6ykiidoQIrtICUbeNpWohHQfCopMjqAH772ehB8sn8
	uoGAB5/8VRfH/oDg==
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
Subject: [PATCH v10 16/21] futex: Remove superfluous state
Date: Wed, 12 Mar 2025 16:16:29 +0100
Message-ID: <20250312151634.2183278-17-bigeasy@linutronix.de>
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

The whole initial_ref_dropped and release state lead to confusing
code.

[bigeasy: use rcuref_is_dead() ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c  | 116 +++++++++++++++++++++----------------------
 kernel/futex/futex.h |   4 +-
 2 files changed, 58 insertions(+), 62 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 9b87c4f128f14..37c3e020f2f03 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -61,8 +61,6 @@ struct futex_private_hash {
 	rcuref_t	users;
 	unsigned int	hash_mask;
 	struct rcu_head	rcu;
-	bool		initial_ref_dropped;
-	bool		released;
 	struct futex_hash_bucket queues[];
 };
=20
@@ -175,49 +173,32 @@ static void futex_rehash_current_users(struct futex_p=
rivate_hash *old,
 	}
 }
=20
-static void futex_assign_new_hash(struct futex_private_hash *new,
-				  struct mm_struct *mm)
+static bool futex_assign_new_hash(struct mm_struct *mm,
+				  struct futex_private_hash *new)
 {
-	bool drop_init_ref =3D new !=3D NULL;
 	struct futex_private_hash *fph;
=20
-	if (!new) {
-		new =3D mm->futex_phash_new;
-		mm->futex_phash_new =3D NULL;
-	}
-	/* Someone was quicker, the current mask is valid */
-	if (!new)
-		return;
+	WARN_ON_ONCE(mm->futex_phash_new);
=20
-	fph =3D rcu_dereference_check(mm->futex_phash,
-				     lockdep_is_held(&mm->futex_hash_lock));
+	fph =3D rcu_dereference_protected(mm->futex_phash,
+					lockdep_is_held(&mm->futex_hash_lock));
 	if (fph) {
 		if (fph->hash_mask >=3D new->hash_mask) {
 			/* It was increased again while we were waiting */
 			kvfree(new);
-			return;
+			return true;
 		}
-		/*
-		 * If the caller started the resize then the initial reference
-		 * needs to be dropped. If the object can not be deconstructed
-		 * we save new for later and ensure the reference counter
-		 * is not dropped again.
-		 */
-		if (drop_init_ref &&
-		    (fph->initial_ref_dropped || !futex_put_private_hash(fph))) {
+
+		if (!rcuref_is_dead(&fph->users)) {
 			mm->futex_phash_new =3D new;
-			fph->initial_ref_dropped =3D true;
-			return;
-		}
-		if (!READ_ONCE(fph->released)) {
-			mm->futex_phash_new =3D new;
-			return;
+			return false;
 		}
=20
 		futex_rehash_current_users(fph, new);
 	}
 	rcu_assign_pointer(mm->futex_phash, new);
 	kvfree_rcu(fph, rcu);
+	return true;
 }
=20
 struct futex_private_hash *futex_get_private_hash(void)
@@ -244,11 +225,26 @@ struct futex_private_hash *futex_get_private_hash(voi=
d)
 		if (rcuref_get(&fph->users))
 			return fph;
 	}
-	scoped_guard(mutex, &current->mm->futex_hash_lock)
-		futex_assign_new_hash(NULL, mm);
+	scoped_guard (mutex, &mm->futex_hash_lock) {
+		struct futex_private_hash *fph;
+
+		fph =3D mm->futex_phash_new;
+		if (fph) {
+			mm->futex_phash_new =3D NULL;
+			futex_assign_new_hash(mm, fph);
+		}
+	}
 	goto again;
 }
=20
+void futex_put_private_hash(struct futex_private_hash *fph)
+{
+	/* Ignore return value, last put is verified via rcuref_is_dead() */
+	if (rcuref_put(&fph->users)) {
+		;
+	}
+}
+
 static struct futex_private_hash *futex_get_private_hb(union futex_key *ke=
y)
 {
 	if (!futex_key_is_private(key))
@@ -289,17 +285,6 @@ struct futex_hash_bucket *__futex_hash(union futex_key=
 *key)
 }
=20
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
-bool futex_put_private_hash(struct futex_private_hash *fph)
-{
-	bool released;
-
-	guard(preempt)();
-	released =3D rcuref_put_rcusafe(&fph->users);
-	if (released)
-		WRITE_ONCE(fph->released, true);
-	return released;
-}
-
 /**
  * futex_hash_get - Get an additional reference for the local hash.
  * @hb:		    ptr to the private local hash.
@@ -1376,22 +1361,11 @@ void futex_hash_free(struct mm_struct *mm)
 	struct futex_private_hash *fph;
=20
 	kvfree(mm->futex_phash_new);
-	/*
-	 * The mm_struct belonging to the task is about to be removed so all
-	 * threads, that ever accessed the private hash, are gone and the
-	 * pointer can be accessed directly (omitting a RCU-read section or
-	 * lock).
-	 * Since there can not be a thread holding a reference to the private
-	 * hash we free it immediately.
-	 */
 	fph =3D rcu_dereference_raw(mm->futex_phash);
-	if (!fph)
-		return;
-
-	if (!fph->initial_ref_dropped && WARN_ON(!futex_put_private_hash(fph)))
-		return;
-
-	kvfree(fph);
+	if (fph) {
+		WARN_ON_ONCE(rcuref_read(&fph->users) > 1);
+		kvfree(fph);
+	}
 }
=20
 static int futex_hash_allocate(unsigned int hash_slots)
@@ -1420,15 +1394,32 @@ static int futex_hash_allocate(unsigned int hash_sl=
ots)
 		return -ENOMEM;
=20
 	rcuref_init(&fph->users, 1);
-	fph->initial_ref_dropped =3D false;
-	fph->released =3D false;
 	fph->hash_mask =3D hash_slots - 1;
=20
 	for (i =3D 0; i < hash_slots; i++)
 		futex_hash_bucket_init(&fph->queues[i], fph);
=20
 	scoped_guard(mutex, &mm->futex_hash_lock) {
+		if (mm->futex_phash && !mm->futex_phash_new) {
+			/*
+			 * If we have an existing hash, but do not yet have
+			 * allocated a replacement hash, drop the initial
+			 * reference on the existing hash.
+			 *
+			 * Ignore the return value; removal is serialized by
+			 * mm->futex_hash_lock which we currently hold and last
+			 * put is verified via rcuref_is_dead().
+			 */
+			if (rcuref_put(&mm->futex_phash->users)) {
+				;
+			}
+		}
+
 		if (mm->futex_phash_new) {
+			/*
+			 * If we already have a replacement hash pending;
+			 * keep the larger hash.
+			 */
 			if (mm->futex_phash_new->hash_mask <=3D fph->hash_mask) {
 				hb_tofree =3D mm->futex_phash_new;
 			} else {
@@ -1437,7 +1428,12 @@ static int futex_hash_allocate(unsigned int hash_slo=
ts)
 			}
 			mm->futex_phash_new =3D NULL;
 		}
-		futex_assign_new_hash(fph, mm);
+
+		/*
+		 * Will set mm->futex_phash_new on failure;
+		 * futex_get_private_hash() will try again.
+		 */
+		futex_assign_new_hash(mm, fph);
 	}
 	kvfree(hb_tofree);
 	return 0;
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 99218d220e534..5b6b58e8a7008 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -209,13 +209,13 @@ extern struct futex_hash_bucket *__futex_hash(union f=
utex_key *key);
 extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
 extern struct futex_private_hash *futex_get_private_hash(void);
-extern bool futex_put_private_hash(struct futex_private_hash *fph);
+extern void futex_put_private_hash(struct futex_private_hash *fph);
=20
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
 static inline void futex_hash_get(struct futex_hash_bucket *hb) { }
 static inline void futex_hash_put(struct futex_hash_bucket *hb) { }
 static inline struct futex_private_hash *futex_get_private_hash(void) { re=
turn NULL; }
-static inline bool futex_put_private_hash(struct futex_private_hash *fph) =
{ return false; }
+static inline void futex_put_private_hash(struct futex_private_hash *fph) =
{ }
 #endif
=20
 DEFINE_CLASS(hb, struct futex_hash_bucket *,
--=20
2.47.2


