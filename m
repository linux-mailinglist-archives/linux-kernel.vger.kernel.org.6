Return-Path: <linux-kernel+bounces-429868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362FF9E27E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF35288A5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54FE1FCCE4;
	Tue,  3 Dec 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l8IJrqF+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Ia6LAZr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD61FA16B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244225; cv=none; b=CvKqV7PrSkpOnxL3uYxR+u70TvIVDFiOCj/jyUeHzrh4HLKrlLo0I32CY96Ln+NxI3uixSHCaR9Mc+MzrIrBbdU4bEowqpGfSHOI+kO1WKh3kbRKWnuHvw19FRxa7Ly1IzB2OvyFxpoP7GTXcI6n9frmNSburvWZ3OoBHJ6etc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244225; c=relaxed/simple;
	bh=249cN2j3NzyyB4xPMe6Du4F38tI5oXp8rh//Bgb6UB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wz/XOry8Jz0SQUUV1m4NkIqu1TNrhVL2nGvYYyglJ/VEYK3E0U+hzlcSjxI1LbKQ4b5AR0bgbCmSBfT+xQeHrKFV3BQLDR1Vwbj5zkSMRk4fTmpLWY1tvahTO1PE3Qf3kb0hOFYtMJkF4C4vfPSof2yrYxTtscQVJA5lXX/e0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l8IJrqF+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Ia6LAZr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ImT2t8RS8Q+PIjBlF2tDKi4h5urza10E3YW86rAn+8c=;
	b=l8IJrqF+0IL8WT2QSSNGkfM5LecxjrcDX+sOj/pBvFDzWRXU77ShnX8KGcTEMbW7h7RM5j
	4jWVyUedL32048YD3M5BTC57sMvW9C7ydmY7MiBFfKSqiwHcyIoa4dtLK2CN18e2UfQijN
	MJeW95U1TN4O0qBThEdVPTl9EtvCpq9zJlFKXlj4d6KDer60FlEsd1JIOxM3DS3IH1Ceeb
	YWefoq03h/GXU9h+cAd9YP1ZqhXalgwPcf8kfGNL5XY7vnaehFrszwvFk7KCoPidGY90sc
	FwPyJjnMRUSdtTsL1RQDKudliFOXDoUEz0Wan7YnfXPoxbWikKzETLSjCk+fAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ImT2t8RS8Q+PIjBlF2tDKi4h5urza10E3YW86rAn+8c=;
	b=1Ia6LAZrDUCtOw+KuElzdems8El1JPtGYHpnNGnd5kgb3/IXfGapomfH7PuGdNrm4AmHCT
	w2l3HVsOuzxfBOBw==
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
Subject: [PATCH v4 07/11] futex: Allow to make the number of slots invariant.
Date: Tue,  3 Dec 2024 17:42:15 +0100
Message-ID: <20241203164335.1125381-8-bigeasy@linutronix.de>
In-Reply-To: <20241203164335.1125381-1-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add an option to freeze the number of hash buckets. The idea is to have
fixed once a certain size is acceptable so that it can be avoided to
acquire mm_struct::futex_hash_lock on certain operations.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/uapi/linux/prctl.h |  2 ++
 kernel/futex/core.c        | 54 ++++++++++++++++++++++++++++++++++++--
 kernel/futex/futex.h       |  1 +
 kernel/futex/pi.c          |  2 +-
 kernel/futex/requeue.c     |  3 ++-
 5 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 55b843644c51a..d1f4b3dea565c 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -357,5 +357,7 @@ struct prctl_mm_map {
 #define PR_FUTEX_HASH			77
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
+# define PR_FUTEX_HASH_SET_INVARIANT	3
+# define PR_FUTEX_HASH_GET_INVARIANT	4
=20
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 0dd7100e36419..1abea8f9abd22 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -61,6 +61,7 @@ struct futex_hash_bucket_private {
 	rcuref_t	users;
 	unsigned int	hash_mask;
 	struct rcu_head rcu;
+	bool		slots_invariant;
 	struct futex_hash_bucket queues[];
 };
=20
@@ -1266,6 +1267,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s)
 	struct futex_hash_bucket_private *hb_p, *hb_p_old =3D NULL;
 	struct mm_struct *mm;
 	size_t alloc_size;
+	int ret =3D 0;
 	int i;
=20
 	if (hash_slots =3D=3D 0)
@@ -1291,20 +1293,30 @@ static int futex_hash_allocate(unsigned int hash_sl=
ots)
=20
 	rcuref_init(&hb_p->users, 1);
 	hb_p->hash_mask =3D hash_slots - 1;
+	hb_p->slots_invariant =3D false;
=20
 	for (i =3D 0; i < hash_slots; i++)
 		futex_hash_bucket_init(&hb_p->queues[i], i + 1);
=20
 	mm =3D current->mm;
 	scoped_guard(rwsem_write, &mm->futex_hash_lock) {
+
 		hb_p_old =3D rcu_dereference_check(mm->futex_hash_bucket,
 						 lockdep_is_held(&mm->futex_hash_lock));
-		rcu_assign_pointer(mm->futex_hash_bucket, hb_p);
+		if (hb_p_old && hb_p_old->slots_invariant)
+			ret =3D -EINVAL;
+		else
+			rcu_assign_pointer(mm->futex_hash_bucket, hb_p);
 	}
+	if (ret) {
+		kvfree(hb_p);
+		return ret;
+	}
+
 	if (hb_p_old)
 		futex_put_old_hb_p(hb_p_old);
=20
-	return 0;
+	return ret;
 }
=20
 int futex_hash_allocate_default(void)
@@ -1323,6 +1335,36 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
=20
+static int futex_hash_set_invariant(void)
+{
+	struct futex_hash_bucket_private *hb_p;
+	struct mm_struct *mm;
+
+	mm =3D current->mm;
+	guard(rwsem_write)(&mm->futex_hash_lock);
+	hb_p =3D rcu_dereference_check(mm->futex_hash_bucket,
+				     lockdep_is_held(&mm->futex_hash_lock));
+	if (!hb_p)
+		return -EINVAL;
+	if (hb_p->slots_invariant)
+		return -EALREADY;
+	hb_p->slots_invariant =3D true;
+	return 0;
+}
+
+bool futex_hash_is_invariant(void)
+{
+	struct futex_hash_bucket_private *hb_p;
+	struct mm_struct *mm;
+
+	mm =3D current->mm;
+	guard(rcu)();
+	hb_p =3D rcu_dereference(mm->futex_hash_bucket);
+	if (!hb_p)
+		return -EINVAL;
+	return hb_p->slots_invariant;
+}
+
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3,
 		     unsigned long arg4, unsigned long arg5)
 {
@@ -1337,6 +1379,14 @@ int futex_hash_prctl(unsigned long arg2, unsigned lo=
ng arg3,
 		ret =3D futex_hash_get_slots();
 		break;
=20
+	case PR_FUTEX_HASH_SET_INVARIANT:
+		ret =3D futex_hash_set_invariant();
+		break;
+
+	case PR_FUTEX_HASH_GET_INVARIANT:
+		ret =3D futex_hash_is_invariant();
+		break;
+
 	default:
 		ret =3D -EINVAL;
 		break;
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 503f56643a966..e81820a393027 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -208,6 +208,7 @@ extern void futex_hash_get(struct futex_hash_bucket *hb=
);
 extern bool futex_check_hb_valid(struct futex_hash_bucket *hb);
 extern bool check_pi_lock_owner(u32 __user *uaddr);
 extern void reset_pi_state_owner(struct futex_pi_state *pi_state);
+extern bool futex_hash_is_invariant(void);
=20
 static inline struct futex_hash_bucket *futex_hb_from_futex_q(struct futex=
_q *q)
 {
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index b4156d1cc6608..9df320be750c3 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1202,7 +1202,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 	if (!IS_ENABLED(CONFIG_FUTEX_PI))
 		return -ENOSYS;
=20
-	if (!(flags & FLAGS_SHARED))
+	if (!(flags & FLAGS_SHARED) && !futex_hash_is_invariant())
 		futex_hash_lock =3D &current->mm->futex_hash_lock;
 retry:
 	if (get_user(uval, uaddr))
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 6b3c4413fbf47..904c68abfb8f3 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -431,7 +431,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 		if (refill_pi_state_cache())
 			return -ENOMEM;
=20
-		if (!(flags1 & FLAGS_SHARED) || !(flags2 & FLAGS_SHARED))
+		if ((!(flags1 & FLAGS_SHARED) || !(flags2 & FLAGS_SHARED)) &&
+		    !futex_hash_is_invariant())
 			futex_hash_lock =3D &current->mm->futex_hash_lock;
 	}
=20
--=20
2.45.2


