Return-Path: <linux-kernel+bounces-557973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B57D2A5E003
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6F317143E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A841EB5E3;
	Wed, 12 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XHEliIXa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wBLEr87p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B82033A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792604; cv=none; b=I6lVqTQMScM0SqeDK48NW0nvnA+b5IchNz82jIS8NNZa8sI6XzPJbavmFN7FBRfYdLNhZ00HYAJBEDxA0dusvks7alnrr/AsYwkP/14wGzNzBN5cukQz84yOsTIov/HgmU2YG0+S88tULjWU3GYvwShE3vpHUeogU+oAqiHXBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792604; c=relaxed/simple;
	bh=1OHtfc6oxuVIKAYZqxsbcqsgEg9h4bXv2EV0t++FFrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVBqrQUjHqiAq5TGG0uY83muQUgAg1guAtmxSZRqMWBHCieafOkJHGt46rJwiiYelgQTyFM+ML3uZ5UhhKlsFlretPQUQWD6qrrbXMp/Lx/EyemxhmQg/pjnWwswFSacEDvO8h3AQO3f616eeJ/jjwfn1bB/8KzNVRw+5vZhpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XHEliIXa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wBLEr87p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54xL4DFuTIQO6XeqH5r8yTIXE3kb7XbefsF+2rinLAo=;
	b=XHEliIXaXiVlNf5Act2kTwZcb7izmzVNRgYxD3v6KIItVFaxgVOUxGgEeN8szdCUDDnMtI
	6ojI6e2YOEVAojntxvBNnQM+fQFTBrBI8x5tGuk3YwMh9T+RKcBe9KPKQ3WxUapJ1pAGDO
	3oCQMtaSFzAVThKB90VcO00bu0K4gyByC/J2r2mfqNynuVsQJI/DIcJF5KClm0C3dZQsla
	0rF56VxBC55E5ID7trop/3yFx5sPKmCix7vidEtdPgiM5jLhQ2BrUGqt1+o/YCgXBNTmlG
	eQW3QFP+LuiWBpYekJpsLmKAxCdROeTjp5e8BhAXyxvbCnuQu64QScSv5sUZ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54xL4DFuTIQO6XeqH5r8yTIXE3kb7XbefsF+2rinLAo=;
	b=wBLEr87pF9G1DN9jUVwxZRw7bLKHLlPza9clH0SQJKtphs4xphmAEtOH6Lpfb2D/QI/4Ft
	8LAR7Ouc9EKK0pBA==
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
Subject: [PATCH v10 02/21] futex: Move futex_queue() into futex_wait_setup()
Date: Wed, 12 Mar 2025 16:16:15 +0100
Message-ID: <20250312151634.2183278-3-bigeasy@linutronix.de>
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

futex_wait_setup() has a weird calling convention in order to return
hb to use as an argument to futex_queue().

Mostly such that requeue can have an extra test in between.

Reorder code a little to get rid of this and keep the hb usage inside
futex_wait_setup().

[bigeasy: fixes]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 io_uring/futex.c        |  4 +---
 kernel/futex/futex.h    |  6 +++---
 kernel/futex/requeue.c  | 28 ++++++++++--------------
 kernel/futex/waitwake.c | 47 +++++++++++++++++++++++------------------
 4 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/io_uring/futex.c b/io_uring/futex.c
index 43e2143255f57..e7c264db0818e 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -311,7 +311,6 @@ int io_futex_wait(struct io_kiocb *req, unsigned int is=
sue_flags)
 	struct io_futex *iof =3D io_kiocb_to_cmd(req, struct io_futex);
 	struct io_ring_ctx *ctx =3D req->ctx;
 	struct io_futex_data *ifd =3D NULL;
-	struct futex_hash_bucket *hb;
 	int ret;
=20
 	if (!iof->futex_mask) {
@@ -333,12 +332,11 @@ int io_futex_wait(struct io_kiocb *req, unsigned int =
issue_flags)
 	ifd->req =3D req;
=20
 	ret =3D futex_wait_setup(iof->uaddr, iof->futex_val, iof->futex_flags,
-			       &ifd->q, &hb);
+			       &ifd->q, NULL, NULL);
 	if (!ret) {
 		hlist_add_head(&req->hash_node, &ctx->futex_list);
 		io_ring_submit_unlock(ctx, issue_flags);
=20
-		futex_queue(&ifd->q, hb, NULL);
 		return IOU_ISSUE_SKIP_COMPLETE;
 	}
=20
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 6b2f4c7eb720f..16aafd0113442 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -219,9 +219,9 @@ static inline int futex_match(union futex_key *key1, un=
ion futex_key *key2)
 }
=20
 extern int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
-			    struct futex_q *q, struct futex_hash_bucket **hb);
-extern void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q =
*q,
-				   struct hrtimer_sleeper *timeout);
+			    struct futex_q *q, union futex_key *key2,
+			    struct task_struct *task);
+extern void futex_do_wait(struct futex_q *q, struct hrtimer_sleeper *timeo=
ut);
 extern bool __futex_wake_mark(struct futex_q *q);
 extern void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q);
=20
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b47bb764b3520..0e55975af515c 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -769,7 +769,6 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb;
 	union futex_key key2 =3D FUTEX_KEY_INIT;
 	struct futex_q q =3D futex_q_init;
 	struct rt_mutex_base *pi_mutex;
@@ -805,29 +804,24 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned=
 int flags,
 	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
 	 * is initialized.
 	 */
-	ret =3D futex_wait_setup(uaddr, val, flags, &q, &hb);
+	ret =3D futex_wait_setup(uaddr, val, flags, &q, &key2, current);
 	if (ret)
 		goto out;
=20
-	/*
-	 * The check above which compares uaddrs is not sufficient for
-	 * shared futexes. We need to compare the keys:
-	 */
-	if (futex_match(&q.key, &key2)) {
-		futex_q_unlock(hb);
-		ret =3D -EINVAL;
-		goto out;
-	}
-
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue(hb, &q, to);
+	futex_do_wait(&q, to);
=20
 	switch (futex_requeue_pi_wakeup_sync(&q)) {
 	case Q_REQUEUE_PI_IGNORE:
-		/* The waiter is still on uaddr1 */
-		spin_lock(&hb->lock);
-		ret =3D handle_early_requeue_pi_wakeup(hb, &q, to);
-		spin_unlock(&hb->lock);
+		{
+			struct futex_hash_bucket *hb;
+
+			hb =3D futex_hash(&q.key);
+			/* The waiter is still on uaddr1 */
+			spin_lock(&hb->lock);
+			ret =3D handle_early_requeue_pi_wakeup(hb, &q, to);
+			spin_unlock(&hb->lock);
+		}
 		break;
=20
 	case Q_REQUEUE_PI_LOCKED:
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 25877d4f2f8f3..6cf10701294b4 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -339,18 +339,8 @@ static long futex_wait_restart(struct restart_block *r=
estart);
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
  */
-void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
-			    struct hrtimer_sleeper *timeout)
+void futex_do_wait(struct futex_q *q, struct hrtimer_sleeper *timeout)
 {
-	/*
-	 * The task state is guaranteed to be set before another task can
-	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * futex_queue() calls spin_unlock() upon completion, both serializing
-	 * access to the hash list and forcing another memory barrier.
-	 */
-	set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
-	futex_queue(q, hb, current);
-
 	/* Arm the timer */
 	if (timeout)
 		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
@@ -578,7 +568,8 @@ int futex_wait_multiple(struct futex_vector *vs, unsign=
ed int count,
  * @val:	the expected value
  * @flags:	futex flags (FLAGS_SHARED, etc.)
  * @q:		the associated futex_q
- * @hb:		storage for hash_bucket pointer to be returned to caller
+ * @key2:	the second futex_key if used for requeue PI
+ * task:	Task queueing this futex
  *
  * Setup the futex_q and locate the hash_bucket.  Get the futex value and
  * compare it with the expected value.  Handle atomic faults internally.
@@ -589,8 +580,10 @@ int futex_wait_multiple(struct futex_vector *vs, unsig=
ned int count,
  *  - <1 - -EFAULT or -EWOULDBLOCK (uaddr does not contain val) and hb is =
unlocked
  */
 int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
-		     struct futex_q *q, struct futex_hash_bucket **hb)
+		     struct futex_q *q, union futex_key *key2,
+		     struct task_struct *task)
 {
+	struct futex_hash_bucket *hb;
 	u32 uval;
 	int ret;
=20
@@ -618,12 +611,12 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsi=
gned int flags,
 		return ret;
=20
 retry_private:
-	*hb =3D futex_q_lock(q);
+	hb =3D futex_q_lock(q);
=20
 	ret =3D futex_get_value_locked(&uval, uaddr);
=20
 	if (ret) {
-		futex_q_unlock(*hb);
+		futex_q_unlock(hb);
=20
 		ret =3D get_user(uval, uaddr);
 		if (ret)
@@ -636,10 +629,25 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsi=
gned int flags,
 	}
=20
 	if (uval !=3D val) {
-		futex_q_unlock(*hb);
-		ret =3D -EWOULDBLOCK;
+		futex_q_unlock(hb);
+		return -EWOULDBLOCK;
 	}
=20
+	if (key2 && futex_match(&q->key, key2)) {
+		futex_q_unlock(hb);
+		return -EINVAL;
+	}
+
+	/*
+	 * The task state is guaranteed to be set before another task can
+	 * wake it. set_current_state() is implemented using smp_store_mb() and
+	 * futex_queue() calls spin_unlock() upon completion, both serializing
+	 * access to the hash list and forcing another memory barrier.
+	 */
+	if (task =3D=3D current)
+		set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+	futex_queue(q, hb, task);
+
 	return ret;
 }
=20
@@ -647,7 +655,6 @@ int __futex_wait(u32 __user *uaddr, unsigned int flags,=
 u32 val,
 		 struct hrtimer_sleeper *to, u32 bitset)
 {
 	struct futex_q q =3D futex_q_init;
-	struct futex_hash_bucket *hb;
 	int ret;
=20
 	if (!bitset)
@@ -660,12 +667,12 @@ int __futex_wait(u32 __user *uaddr, unsigned int flag=
s, u32 val,
 	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
 	 * is initialized.
 	 */
-	ret =3D futex_wait_setup(uaddr, val, flags, &q, &hb);
+	ret =3D futex_wait_setup(uaddr, val, flags, &q, NULL, current);
 	if (ret)
 		return ret;
=20
 	/* futex_queue and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue(hb, &q, to);
+	futex_do_wait(&q, to);
=20
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	if (!futex_unqueue(&q))
--=20
2.47.2


