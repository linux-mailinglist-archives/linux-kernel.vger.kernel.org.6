Return-Path: <linux-kernel+bounces-411087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D7C9CF2BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F991283B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936CD1E1C2D;
	Fri, 15 Nov 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kaSpaicU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j+gApzTn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B431D8A12
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691249; cv=none; b=AAUQhDwi0bJRhNxtSP5M9mBoatGzhF6uQoSEGWoJ082/eHIykTjzUdXjQ2ZYjuFfe1rOJxC9mOtaMT4H/kvIu7x3TdnjDdRCWa2JMLtsaSThNhbW/TQrKWM8wtoctPWQxewl8RIhDYZDh0iqHVcCDETEL7QlRZ4jFr9LcCg9oL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691249; c=relaxed/simple;
	bh=KHZ338Al8IJJw1ZC1QdqBLGaCPHTdlMrAcWX2HKh9jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwkfRKvyl7U+5BaCHEnQxERG7o6bg9ki8OjO8oGh/S3U2cdgg1IKfUVofgtYP9e7W1nD5JGFTVFuDpjxn2mr23Hml/BJyOTX9TNPVcOc2145AVnycd7WDlvY3OtB/YCOPdHsFOKfapHfVjEmvkc0rbSaeSHRHnvqDouNyuMuQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kaSpaicU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j+gApzTn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731691244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7xbsHSY0yw52MGuaTTTzZKF0el2JDMLD+w9bMwrA7Y=;
	b=kaSpaicUhLLTqaF+gl0ZWHhlHUy0bzr+1MECxzk9DPlyNhBew1lMTpu2nKx8YLFJvoHc2s
	12DhIk113xVbldLwbFz3FhAFdqt9NdqR2+V3O3Nn01lR4Vm1Wi/PhMPunhBSEDo1z5A64U
	MpIpLtVKwyxxDPFzaawXoHUsuO3gleD4tf32yiDsp8fZDU+l2sSTYFxJrfGE627UlvDCzk
	sPN5dTJuCMgWfvUpxafwvaWbS75iFZ4OFvCsN5M+UqEBcWeZFyknS9wcQHJJ/0luLMAXnQ
	NtvmIZ55vIJ96jI9Ns0KnmPEgPCtUsTM2sPWMX1wBVaehcVY1bfcqcd5J5C0hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731691244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L7xbsHSY0yw52MGuaTTTzZKF0el2JDMLD+w9bMwrA7Y=;
	b=j+gApzTnfB25ML3ndORcAmz/N1PLTz1F6rct2lvEcqxdUgcu6VCMe04ZPJutT6ZCT2eEm2
	lmvbcn4hCJTRYcCA==
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
Subject: [RFC PATCH v3 6/9] futex: Allow to re-allocate the private hash bucket.
Date: Fri, 15 Nov 2024 17:58:47 +0100
Message-ID: <20241115172035.795842-7-bigeasy@linutronix.de>
In-Reply-To: <20241115172035.795842-1-bigeasy@linutronix.de>
References: <20241115172035.795842-1-bigeasy@linutronix.de>
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
The idea is to use the recently introduced ref counting to keep a valid
HB around. On resize/ replacement the new HB is assigned and all users
currently queued on hb will get poked so they can requeue themself.

This has been only tested with FUTEX_LOCK_PI.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h           |  1 +
 include/linux/mm_types.h        |  1 +
 kernel/futex/core.c             | 64 ++++++++++++++++++++++++++++-----
 kernel/futex/futex.h            |  1 +
 kernel/futex/pi.c               | 25 +++++++++++++
 kernel/locking/rtmutex.c        | 26 ++++++++++++++
 kernel/locking/rtmutex_common.h |  2 ++
 7 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 359fc24eb37ff..838a5a6be0444 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -85,6 +85,7 @@ void futex_hash_free(struct mm_struct *mm);
 static inline void futex_mm_init(struct mm_struct *mm)
 {
 	rcu_assign_pointer(mm->futex_hash_bucket, NULL);
+	mutex_init(&mm->futex_hash_lock);
 }
=20
 #else
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 057ad1de59ca0..5bf86ea363780 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -899,6 +899,7 @@ struct mm_struct {
 		int mm_lock_seq;
 #endif
=20
+		struct mutex				futex_hash_lock;
 		struct futex_hash_bucket_private	__rcu *futex_hash_bucket;
=20
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index cff5652a29917..70d4b1d93bbb8 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -595,6 +595,7 @@ struct futex_hash_bucket *futex_q_lock(struct futex_q *=
q)
 {
 	struct futex_hash_bucket *hb;
=20
+try_again:
 	hb =3D futex_hash(&q->key);
=20
 	/*
@@ -610,7 +611,13 @@ struct futex_hash_bucket *futex_q_lock(struct futex_q =
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
@@ -1238,18 +1245,50 @@ void futex_hash_free(struct mm_struct *mm)
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
 	if (hash_slots < 2)
 		hash_slots =3D 2;
 	if (hash_slots > 131072)
@@ -1277,7 +1316,14 @@ static int futex_hash_allocate(unsigned int hash_slo=
ts)
 		hb_p->queues[i].hb_slot =3D i + 1;
 	}
=20
-	rcu_assign_pointer(current->mm->futex_hash_bucket, hb_p);
+	mm =3D current->mm;
+	scoped_guard(mutex, &mm->futex_hash_lock) {
+		hb_p_old =3D rcu_dereference_check(mm->futex_hash_bucket,
+						 lockdep_is_held(&mm->futex_hash_lock));
+		rcu_assign_pointer(mm->futex_hash_bucket, hb_p);
+	}
+	if (hb_p_old)
+		futex_put_old_hb_p(hb_p_old);
 	return 0;
 }
=20
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index c6d59949766d2..b974d675730e4 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -204,6 +204,7 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper=
 *timeout,
 extern struct futex_hash_bucket *futex_hash(union futex_key *key);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
 extern void futex_hash_get(struct futex_hash_bucket *hb);
+extern bool futex_check_hb_valid(struct futex_hash_bucket *hb);
=20
 static inline struct futex_hash_bucket *futex_hb_from_futex_q(struct futex=
_q *q)
 {
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 399ac712f1fd6..1a0a9cd31f911 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -998,6 +998,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags=
, ktime_t *time, int tryl
 	rt_mutex_pre_schedule();
=20
 	rt_mutex_init_waiter(&rt_waiter);
+	rt_waiter.hb =3D hb;
=20
 	/*
 	 * On PREEMPT_RT, when hb->lock becomes an rt_mutex, we must not
@@ -1066,6 +1067,23 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fl=
ags, ktime_t *time, int tryl
 	 */
 	rt_mutex_post_schedule();
 no_block:
+	if (!futex_check_hb_valid(hb)) {
+		/*
+		 * We might got the lock, we might not. If the HB changed under
+		 * us it was all for nothing. Try again from scratch.
+		 */
+		futex_unqueue_pi(&q);
+		spin_unlock(q.lock_ptr);
+		futex_hash_put(hb);
+
+		if (to) {
+			hrtimer_cancel(&to->timer);
+			destroy_hrtimer_on_stack(&to->timer);
+		}
+		if (refill_pi_state_cache())
+			return -ENOMEM;
+		goto retry_private;
+	}
 	/*
 	 * Fixup the pi_state owner and possibly acquire the lock if we
 	 * haven't already.
@@ -1226,6 +1244,12 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int =
flags)
 		 * space.
 		 */
 		return ret;
+	} else {
+		if (!futex_check_hb_valid(hb)) {
+			spin_unlock(&hb->lock);
+			futex_hash_put(hb);
+			goto retry;
+		}
 	}
=20
 	/*
@@ -1250,6 +1274,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 			return ret;
 		}
 	}
+	/* XXX if the HB changed but uval did not, we might need to check if ther=
e is a waiter pending */
=20
 	/*
 	 * If uval has changed, let user space handle it.
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ebebd0eec7f63..188a9b16412df 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -56,10 +56,29 @@ static inline int __ww_mutex_check_kill(struct rt_mutex=
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
@@ -1626,6 +1645,13 @@ static int __sched rt_mutex_slowlock_block(struct rt=
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
index 1162e07cdaea1..fb26ad08f259a 100644
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
@@ -215,6 +216,7 @@ static inline void rt_mutex_init_waiter(struct rt_mutex=
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


