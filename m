Return-Path: <linux-kernel+bounces-446628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 184A89F2754
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D47118846E2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80971CEEBA;
	Sun, 15 Dec 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CjCv2qE6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Ab+4GIV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8741C7B8D
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304018; cv=none; b=LEngKFQI6OSJAuAoySiHaOTEblpGQZRjESClgrC/UEwGEy6nLpf7t9t6bzrins7UwxnBSvfWcFUMNeqV2UxHG9g4kxo++Xz5UcSC643mlMSDUkmEMDaNu7dl49OkaBEVKqtOACUT+XKjV99NjMwLIwoB6RfLpaUVBqgW3Ib8OV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304018; c=relaxed/simple;
	bh=i9MijDvVOWfckqUfUJqCPM813s6GxsIU5dJt1BnSsbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI23QNv1JfqTqcH6Qhi5pb9ZggbRVrEgLL1LQqKrUhVJNYdKQbi4o8VcfsvO5VG1IGuonBxVSM5isgbid5r27HWE9vMj3F8p8pIFPxnjM7CVCIAszqxhLjIMXzBefOVeVbgEugfDIJaX4OmkthxvdMZCxcs8wNP75EF68gxk8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CjCv2qE6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7Ab+4GIV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=521YN3lEQj8wnb4LQ1VCL1pUFnvlLLrWT5SguDVioRo=;
	b=CjCv2qE6jzYuNwZ2KGp4sNWJTkxQSNF3l4Y1la5rGLKlGwMj0q8P7qNuTE5WT3HuuiJ4U/
	vq6FJDtzC4eiRAA4z4NWLtqE4mrfFi07hYYb9md5Txo1E9k/SBVIglwK0ON0JO5EZ+Kea+
	YV0R7+iXweytboatFLG4dcsvd6Uogq1xqIAPD6LkFPL5cXNsEdsOOQoiEgslnolftxGZRI
	9Y6qKDQS1rUG5RFD6gfk0tI592dkr+hbuU/wqZ/fHx2rN48zQ8IS+zqsCI6TqBs6AoXrMo
	LfkvY7tsADjEcvs96NltgF6q0dv+vpzdhYdoZBJ5poT3vhxIRcg9MTrku5lO3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=521YN3lEQj8wnb4LQ1VCL1pUFnvlLLrWT5SguDVioRo=;
	b=7Ab+4GIVOvafesQaNqjZwJMBAVtUmpqvskyB4G9L6IjEdcdrqG2NoBxsq/J0tkzKJEUUSv
	vVdxzRpVmSAP2oCw==
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
Subject: [PATCH v5 08/14] futex: Introduce futex_get_locked_hb().
Date: Mon, 16 Dec 2024 00:00:12 +0100
Message-ID: <20241215230642.104118-9-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

futex_lock_pi() and __fixup_pi_state_owner() acquire the
futex_q::lock_ptr without holding a reference assuming the previously
obtained hb and the assigned lock_ptr are still valid. This isn't the
case once the hb can be resized and becomes invalid after the reference
drop.

Introduce futex_get_locked_hb() to lock the hb recorded in
futex_q::lock_ptr. The lock pointer is read in a RCU section to ensure
that it does not go away if the hb has been replaced and the old pointer
has been observed. After locking the pointer needs to be compared
to check if it changed. If so then the hb has been replaced and the user
has been moved to the new one and lock_ptr has been updated. The lock
operation needs to be redone in this case.
Once the lock_ptr is the same, we can return the futex_hash_bucket it
belongs to as the hb for the caller locked. This is important because we
don't own a reference so the hb is valid as long as we hold the lock.
This means if the hb is resized then this (old) hb remains valid as long
as we hold the lock because it all user need to be moved to the new
lock. So the task performing the resize will block.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c    | 27 +++++++++++++++++++++++++++
 kernel/futex/futex.h   |  2 +-
 kernel/futex/pi.c      |  9 +++++++--
 kernel/futex/requeue.c |  8 +++++---
 4 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 3cfdd4c02f261..6bccf48cdb049 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -639,6 +639,33 @@ int futex_unqueue(struct futex_q *q)
 	return ret;
 }
=20
+struct futex_hash_bucket *futex_get_locked_hb(struct futex_q *q)
+{
+	struct futex_hash_bucket *hb;
+	spinlock_t *lock_ptr;
+
+	/*
+	 * See futex_unqueue() why lock_ptr can change.
+	 */
+	guard(rcu)();
+retry:
+	lock_ptr =3D READ_ONCE(q->lock_ptr);
+	spin_lock(lock_ptr);
+
+	if (unlikely(lock_ptr !=3D q->lock_ptr)) {
+		spin_unlock(lock_ptr);
+		goto retry;
+	}
+
+	hb =3D container_of(lock_ptr, struct futex_hash_bucket, lock);
+	/*
+	 * We don't acquire a reference on the hb because we don't get it
+	 * if a resize is in progress and we got the old hb->lock before the
+	 * other task got it which meant to move us to the new hb.
+	 */
+	return hb;
+}
+
 /*
  * PI futexes can not be requeued and must remove themselves from the hash
  * bucket. The hash bucket lock (i.e. lock_ptr) is held.
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 5793546a48ebf..143bf1523fa4a 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -196,7 +196,7 @@ enum futex_access {
=20
 extern int get_futex_key(u32 __user *uaddr, unsigned int flags, union fute=
x_key *key,
 			 enum futex_access rw);
-
+extern struct futex_hash_bucket *futex_get_locked_hb(struct futex_q *q);
 extern struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns);
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 8561f94f21ed9..506ba1ad8ff23 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -806,7 +806,7 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, st=
ruct futex_q *q,
 		break;
 	}
=20
-	spin_lock(q->lock_ptr);
+	futex_get_locked_hb(q);
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
=20
 	/*
@@ -922,6 +922,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags=
, ktime_t *time, int tryl
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
 	struct futex_q q =3D futex_q_init;
+	bool no_block_fp =3D false;
 	DEFINE_WAKE_Q(wake_q);
 	int res, ret;
=20
@@ -988,6 +989,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags=
, ktime_t *time, int tryl
 		ret =3D rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
 		/* Fixup the trylock return value: */
 		ret =3D ret ? 0 : -EWOULDBLOCK;
+		no_block_fp =3D true;
 		goto no_block;
 	}
=20
@@ -1024,6 +1026,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fla=
gs, ktime_t *time, int tryl
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
 	wake_up_q(&wake_q);
 	preempt_enable();
+	futex_hash_put(hb);
=20
 	if (ret) {
 		if (ret =3D=3D 1)
@@ -1063,7 +1066,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fla=
gs, ktime_t *time, int tryl
 	 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
 	 * the
 	 */
-	spin_lock(q.lock_ptr);
+	hb =3D futex_get_locked_hb(&q);
 	/*
 	 * Waiter is unqueued.
 	 */
@@ -1083,6 +1086,8 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fla=
gs, ktime_t *time, int tryl
=20
 	futex_unqueue_pi(&q);
 	spin_unlock(q.lock_ptr);
+	if (no_block_fp)
+		futex_hash_put(hb);
 	goto out;
=20
 out_unlock_put_key:
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 0395740ce5e71..1f3ac76ce1229 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -826,15 +826,17 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned=
 int flags,
 	switch (futex_requeue_pi_wakeup_sync(&q)) {
 	case Q_REQUEUE_PI_IGNORE:
 		/* The waiter is still on uaddr1 */
-		spin_lock(&hb->lock);
+		hb =3D futex_get_locked_hb(&q);
+
 		ret =3D handle_early_requeue_pi_wakeup(hb, &q, to);
 		spin_unlock(&hb->lock);
+
 		break;
=20
 	case Q_REQUEUE_PI_LOCKED:
 		/* The requeue acquired the lock */
 		if (q.pi_state && (q.pi_state->owner !=3D current)) {
-			spin_lock(q.lock_ptr);
+			futex_get_locked_hb(&q);
 			ret =3D fixup_pi_owner(uaddr2, &q, true);
 			/*
 			 * Drop the reference to the pi state which the
@@ -861,7 +863,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret =3D 0;
=20
-		spin_lock(q.lock_ptr);
+		futex_get_locked_hb(&q);
 		debug_rt_mutex_free_waiter(&rt_waiter);
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we
--=20
2.45.2


