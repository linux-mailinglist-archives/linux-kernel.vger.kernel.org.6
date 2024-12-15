Return-Path: <linux-kernel+bounces-446629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9509F2757
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6603D1881313
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486681D131E;
	Sun, 15 Dec 2024 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbE7dw2b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEvf4JhB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8211C7B62
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304019; cv=none; b=Xp6WMmZIAXDyNgNZwPesok90890dLOtxIM1tzJIbW6rk2Wh7WrCJlktYrGbDA/IHOvKG2e7wRcsU5acQ5gL1+0LOlddXf7sOLxAZoLKEu0p2ni44Ns0YBcXR7ou8hJUEztTLUvxXW4Vlum8TC5n/CLyxLzKpGtXytl3Hz5O7eKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304019; c=relaxed/simple;
	bh=4OCLSK0IAckDHRlP+nH4B2ka9CDlgPnOHY28BujTCRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REgnhAQQWk62c0Lri4NtH1HRDAC7FBNxpkazweYQaTbDkCcJ9u45qXJi7MCjckEysPsMTFaRaPBw31vgaJXhO22A/r0P2kHT4Fd7gd1FPfKC9lJWWvhIB5CJOBY5lkQkqe0g4eOu1NjMcrY2kSFCY8BTUeCrokIJ3CqgqoPX0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbE7dw2b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEvf4JhB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etNnTYYSTjAmrwSwk7AJnd4JiQiKqSMx0MbJH27pRgc=;
	b=AbE7dw2b5IjDgNp8WZSo2n8vPHV9AgBFCfpowmQRrmPZzD2/qfY4O54567UGB8jVQ+Vhop
	D5FCDgjwG4FhGnIFhXosWKdzF4edy2VCY3PVfCRRdBQa2oWZWJYN02JQHkNeOiJngGSUi4
	5893Ne5GquqCabYWAjMohXcBkCgIpDlkuMf4rPVZAcUdjiTzbDRL4TX+0IH8XQNYha54U9
	FNlO+F73xNNcl+kjlLcVB61PF8k6omzmc8RiDud45Cr2Cu7+8lTgW/jSyK5eLqfZK73jHr
	hIcGoniZzH3aII/89mgWpjrsr83+XfibuB1n+R8M9zce/7xahvm5Hy+BIvaxKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etNnTYYSTjAmrwSwk7AJnd4JiQiKqSMx0MbJH27pRgc=;
	b=MEvf4JhB3pbkICNP769Fv6VrqrdbGMMxGbQ73/6OvHowYs+PVVgG0u2x4sUUNlrOzyk2Pz
	DPxfVYZSrqvmgtDg==
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
Subject: [PATCH v5 06/14] futex: Add helper which include the put of a hb after end of operation.
Date: Mon, 16 Dec 2024 00:00:10 +0100
Message-ID: <20241215230642.104118-7-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With the planned schema of resize of hb, a reference count will be
obtained during futex_hash() and will be dropped after the hb is
unlocked. Once the reference is dropped, the hb must not be used because
it will disappear after a resize.
To prepare the integration, rename
- futex_hb_unlock() to futex_hb_unlock_put()
- futex_queue() to futex_queue_put()
- futex_q_unlock() to futex_q_unlock_put()
- double_unlock_hb() to double_unlock_hb_put()

which is additionally includes futex_hb_unlock_put(), an empty stub.
Introduce futex_hb_unlock_put() which is the unlock plus the reference
drop. Move futex_hb_waiters_dec() before the reference drop, if needed
before the unlock.
Update comments referring to the functions accordingly.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 io_uring/futex.c        |  2 +-
 kernel/futex/core.c     | 12 ++++++++----
 kernel/futex/futex.h    | 31 ++++++++++++++++++++-----------
 kernel/futex/pi.c       | 19 ++++++++++---------
 kernel/futex/requeue.c  | 15 ++++++++-------
 kernel/futex/waitwake.c | 23 ++++++++++++-----------
 6 files changed, 59 insertions(+), 43 deletions(-)

diff --git a/io_uring/futex.c b/io_uring/futex.c
index e29662f039e1a..67246438da228 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -349,7 +349,7 @@ int io_futex_wait(struct io_kiocb *req, unsigned int is=
sue_flags)
 		hlist_add_head(&req->hash_node, &ctx->futex_list);
 		io_ring_submit_unlock(ctx, issue_flags);
=20
-		futex_queue(&ifd->q, hb);
+		futex_queue_put(&ifd->q, hb);
 		return IOU_ISSUE_SKIP_COMPLETE;
 	}
=20
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 907b76590df16..3cfdd4c02f261 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -152,6 +152,9 @@ struct futex_hash_bucket *futex_hash(union futex_key *k=
ey)
 	return &futex_queues[hash & (futex_hashsize - 1)];
 }
=20
+void futex_hash_put(struct futex_hash_bucket *hb)
+{
+}
=20
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
@@ -543,8 +546,8 @@ struct futex_hash_bucket *futex_q_lock(struct futex_q *=
q)
 	 * Increment the counter before taking the lock so that
 	 * a potential waker won't miss a to-be-slept task that is
 	 * waiting for the spinlock. This is safe as all futex_q_lock()
-	 * users end up calling futex_queue(). Similarly, for housekeeping,
-	 * decrement the counter at futex_q_unlock() when some error has
+	 * users end up calling futex_queue_put(). Similarly, for housekeeping,
+	 * decrement the counter at futex_q_unlock_put() when some error has
 	 * occurred and we don't end up adding the task to the list.
 	 */
 	futex_hb_waiters_inc(hb); /* implies smp_mb(); (A) */
@@ -555,11 +558,12 @@ struct futex_hash_bucket *futex_q_lock(struct futex_q=
 *q)
 	return hb;
 }
=20
-void futex_q_unlock(struct futex_hash_bucket *hb)
+void futex_q_unlock_put(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	spin_unlock(&hb->lock);
 	futex_hb_waiters_dec(hb);
+	futex_hash_put(hb);
 }
=20
 void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
@@ -586,7 +590,7 @@ void __futex_queue(struct futex_q *q, struct futex_hash=
_bucket *hb)
  * @q:	The futex_q to unqueue
  *
  * The q->lock_ptr must not be held by the caller. A call to futex_unqueue=
() must
- * be paired with exactly one earlier call to futex_queue().
+ * be paired with exactly one earlier call to futex_queue_put().
  *
  * Return:
  *  - 1 - if the futex_q was still queued (and we removed unqueued it);
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 618ce1fe870e9..5793546a48ebf 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -202,6 +202,7 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper=
 *timeout,
 		  int flags, u64 range_ns);
=20
 extern struct futex_hash_bucket *futex_hash(union futex_key *key);
+extern void futex_hash_put(struct futex_hash_bucket *hb);
=20
 /**
  * futex_match - Check whether two futex keys are equal
@@ -288,23 +289,29 @@ extern void __futex_unqueue(struct futex_q *q);
 extern void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb);
 extern int futex_unqueue(struct futex_q *q);
=20
+static inline void futex_hb_unlock_put(struct futex_hash_bucket *hb)
+{
+	spin_unlock(&hb->lock);
+	futex_hash_put(hb);
+}
+
 /**
- * futex_queue() - Enqueue the futex_q on the futex_hash_bucket
+ * futex_queue_put() - Enqueue the futex_q on the futex_hash_bucket
  * @q:	The futex_q to enqueue
  * @hb:	The destination hash bucket
  *
- * The hb->lock must be held by the caller, and is released here. A call to
- * futex_queue() is typically paired with exactly one call to futex_unqueu=
e().  The
- * exceptions involve the PI related operations, which may use futex_unque=
ue_pi()
- * or nothing if the unqueue is done as part of the wake process and the u=
nqueue
- * state is implicit in the state of woken task (see futex_wait_requeue_pi=
() for
- * an example).
+ * The hb->lock must be held by the caller, and is released here and the r=
eference
+ * on the hb is droppedV. A call to futex_queue_put() is typically paired =
with
+ * exactly one call to futex_unqueue(). The exceptions involve the PI rela=
ted
+ * operations, which may use futex_unqueue_pi() or nothing if the unqueue =
is
+ * done as part of the wake process and the unqueue state is implicit in t=
he
+ * state of woken task (see futex_wait_requeue_pi() for an example).
  */
-static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket=
 *hb)
+static inline void futex_queue_put(struct futex_q *q, struct futex_hash_bu=
cket *hb)
 	__releases(&hb->lock)
 {
 	__futex_queue(q, hb);
-	spin_unlock(&hb->lock);
+	futex_hb_unlock_put(hb);
 }
=20
 extern void futex_unqueue_pi(struct futex_q *q);
@@ -350,7 +357,7 @@ static inline int futex_hb_waiters_pending(struct futex=
_hash_bucket *hb)
 }
=20
 extern struct futex_hash_bucket *futex_q_lock(struct futex_q *q);
-extern void futex_q_unlock(struct futex_hash_bucket *hb);
+extern void futex_q_unlock_put(struct futex_hash_bucket *hb);
=20
=20
 extern int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucke=
t *hb,
@@ -380,11 +387,13 @@ double_lock_hb(struct futex_hash_bucket *hb1, struct =
futex_hash_bucket *hb2)
 }
=20
 static inline void
-double_unlock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *=
hb2)
+double_unlock_hb_put(struct futex_hash_bucket *hb1, struct futex_hash_buck=
et *hb2)
 {
 	spin_unlock(&hb1->lock);
 	if (hb1 !=3D hb2)
 		spin_unlock(&hb2->lock);
+	futex_hash_put(hb1);
+	futex_hash_put(hb2);
 }
=20
 /* syscalls */
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index d62cca5ed8f4c..8561f94f21ed9 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -217,9 +217,9 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uv=
al,
 	/*
 	 * We get here with hb->lock held, and having found a
 	 * futex_top_waiter(). This means that futex_lock_pi() of said futex_q
-	 * has dropped the hb->lock in between futex_queue() and futex_unqueue_pi=
(),
-	 * which in turn means that futex_lock_pi() still has a reference on
-	 * our pi_state.
+	 * has dropped the hb->lock in between futex_queue_put() and
+	 * futex_unqueue_pi(), which in turn means that futex_lock_pi() still
+	 * has a reference on our pi_state.
 	 *
 	 * The waiter holding a reference on @pi_state also protects against
 	 * the unlocked put_pi_state() in futex_unlock_pi(), futex_lock_pi()
@@ -963,7 +963,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags=
, ktime_t *time, int tryl
 			 *   exit to complete.
 			 * - EAGAIN: The user space value changed.
 			 */
-			futex_q_unlock(hb);
+			futex_q_unlock_put(hb);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -1086,7 +1086,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fla=
gs, ktime_t *time, int tryl
 	goto out;
=20
 out_unlock_put_key:
-	futex_q_unlock(hb);
+	futex_q_unlock_put(hb);
=20
 out:
 	if (to) {
@@ -1096,7 +1096,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fla=
gs, ktime_t *time, int tryl
 	return ret !=3D -EINTR ? ret : -ERESTARTNOINTR;
=20
 uaddr_faulted:
-	futex_q_unlock(hb);
+	futex_q_unlock_put(hb);
=20
 	ret =3D fault_in_user_writeable(uaddr);
 	if (ret)
@@ -1196,7 +1196,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 		}
=20
 		get_pi_state(pi_state);
-		spin_unlock(&hb->lock);
+		futex_hb_unlock_put(hb);
=20
 		/* drops pi_state->pi_mutex.wait_lock */
 		ret =3D wake_futex_pi(uaddr, uval, pi_state, rt_waiter);
@@ -1235,7 +1235,8 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 	 * owner.
 	 */
 	if ((ret =3D futex_cmpxchg_value_locked(&curval, uaddr, uval, 0))) {
-		spin_unlock(&hb->lock);
+		futex_hb_unlock_put(hb);
+
 		switch (ret) {
 		case -EFAULT:
 			goto pi_faulted;
@@ -1255,7 +1256,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 	ret =3D (curval =3D=3D uval) ? 0 : -EAGAIN;
=20
 out_unlock:
-	spin_unlock(&hb->lock);
+	futex_hb_unlock_put(hb);
 	return ret;
=20
 pi_retry:
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b47bb764b3520..80e99a498de28 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -58,7 +58,7 @@ enum {
 };
=20
 const struct futex_q futex_q_init =3D {
-	/* list gets initialized in futex_queue()*/
+	/* list gets initialized in futex_queue_put()*/
 	.wake		=3D futex_wake_mark,
 	.key		=3D FUTEX_KEY_INIT,
 	.bitset		=3D FUTEX_BITSET_MATCH_ANY,
@@ -456,8 +456,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 		ret =3D futex_get_value_locked(&curval, uaddr1);
=20
 		if (unlikely(ret)) {
-			double_unlock_hb(hb1, hb2);
 			futex_hb_waiters_dec(hb2);
+			double_unlock_hb_put(hb1, hb2);
=20
 			ret =3D get_user(curval, uaddr1);
 			if (ret)
@@ -542,8 +542,9 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 		 * waiter::requeue_state is correct.
 		 */
 		case -EFAULT:
-			double_unlock_hb(hb1, hb2);
 			futex_hb_waiters_dec(hb2);
+			double_unlock_hb_put(hb1, hb2);
+
 			ret =3D fault_in_user_writeable(uaddr2);
 			if (!ret)
 				goto retry;
@@ -556,8 +557,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 			 *   exit to complete.
 			 * - EAGAIN: The user space value changed.
 			 */
-			double_unlock_hb(hb1, hb2);
 			futex_hb_waiters_dec(hb2);
+			double_unlock_hb_put(hb1, hb2);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -674,9 +675,9 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 	put_pi_state(pi_state);
=20
 out_unlock:
-	double_unlock_hb(hb1, hb2);
-	wake_up_q(&wake_q);
 	futex_hb_waiters_dec(hb2);
+	double_unlock_hb_put(hb1, hb2);
+	wake_up_q(&wake_q);
 	return ret ? ret : task_count;
 }
=20
@@ -814,7 +815,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 	 * shared futexes. We need to compare the keys:
 	 */
 	if (futex_match(&q.key, &key2)) {
-		futex_q_unlock(hb);
+		futex_q_unlock_put(hb);
 		ret =3D -EINVAL;
 		goto out;
 	}
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 3a10375d95218..fdb9fcaaf9fba 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -195,7 +195,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, i=
nt nr_wake, u32 bitset)
 		}
 	}
=20
-	spin_unlock(&hb->lock);
+	futex_hb_unlock_put(hb);
 	wake_up_q(&wake_q);
 	return ret;
 }
@@ -274,7 +274,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flag=
s, u32 __user *uaddr2,
 	double_lock_hb(hb1, hb2);
 	op_ret =3D futex_atomic_op_inuser(op, uaddr2);
 	if (unlikely(op_ret < 0)) {
-		double_unlock_hb(hb1, hb2);
+		double_unlock_hb_put(hb1, hb2);
=20
 		if (!IS_ENABLED(CONFIG_MMU) ||
 		    unlikely(op_ret !=3D -EFAULT && op_ret !=3D -EAGAIN)) {
@@ -327,7 +327,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flag=
s, u32 __user *uaddr2,
 	}
=20
 out_unlock:
-	double_unlock_hb(hb1, hb2);
+	double_unlock_hb_put(hb1, hb2);
 	wake_up_q(&wake_q);
 	return ret;
 }
@@ -335,7 +335,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flag=
s, u32 __user *uaddr2,
 static long futex_wait_restart(struct restart_block *restart);
=20
 /**
- * futex_wait_queue() - futex_queue() and wait for wakeup, timeout, or sig=
nal
+ * futex_wait_queue() - futex_queue_put() and wait for wakeup, timeout, or=
 signal
  * @hb:		the futex hash bucket, must be locked by the caller
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
@@ -346,11 +346,11 @@ void futex_wait_queue(struct futex_hash_bucket *hb, s=
truct futex_q *q,
 	/*
 	 * The task state is guaranteed to be set before another task can
 	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * futex_queue() calls spin_unlock() upon completion, both serializing
+	 * futex_queue_put() calls spin_unlock() upon completion, both serializing
 	 * access to the hash list and forcing another memory barrier.
 	 */
 	set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
-	futex_queue(q, hb);
+	futex_queue_put(q, hb);
=20
 	/* Arm the timer */
 	if (timeout)
@@ -461,11 +461,12 @@ int futex_wait_multiple_setup(struct futex_vector *vs=
, int count, int *woken)
 			 * next futex. Queue each futex at this moment so hb can
 			 * be unlocked.
 			 */
-			futex_queue(q, hb);
+			futex_queue_put(q, hb);
 			continue;
 		}
=20
-		futex_q_unlock(hb);
+		futex_q_unlock_put(hb);
+
 		__set_current_state(TASK_RUNNING);
=20
 		/*
@@ -624,7 +625,7 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsign=
ed int flags,
 	ret =3D futex_get_value_locked(&uval, uaddr);
=20
 	if (ret) {
-		futex_q_unlock(*hb);
+		futex_q_unlock_put(*hb);
=20
 		ret =3D get_user(uval, uaddr);
 		if (ret)
@@ -637,7 +638,7 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsign=
ed int flags,
 	}
=20
 	if (uval !=3D val) {
-		futex_q_unlock(*hb);
+		futex_q_unlock_put(*hb);
 		ret =3D -EWOULDBLOCK;
 	}
=20
@@ -665,7 +666,7 @@ int __futex_wait(u32 __user *uaddr, unsigned int flags,=
 u32 val,
 	if (ret)
 		return ret;
=20
-	/* futex_queue and wait for wakeup, timeout, or a signal. */
+	/* futex_queue_put and wait for wakeup, timeout, or a signal. */
 	futex_wait_queue(hb, &q, to);
=20
 	/* If we were woken (and unqueued), we succeeded, whatever. */
--=20
2.45.2


