Return-Path: <linux-kernel+bounces-557978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BA6A5E009
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACB01756E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197DC257429;
	Wed, 12 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DhzD1OmG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c47PcOYu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE109253B4B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792607; cv=none; b=Zl4YDO/HGEMZBjhjUg5L9oywQvrTEtuiCzm9/4cgEI0wBkPTLxo1Aw3vLyMN/cyDVcVy1zT50Wd8ywSkptqQS5PjPEuBfJipJ4Z0ssvKrZ+hHakPjW5mWSM2k3h0T4LpnIui5BhU+zab72BLUtL5e6mmTjHNAhJ1mZdgYMaU+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792607; c=relaxed/simple;
	bh=q1V5yYTSdJWOEMOeqhqb0Ea6SrRVRvGM1XThjnfcnKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0eEcHsUiM+CJZlXpmFnVosnd6yNUXMzzZNVOWYeKCD9TBPOvcxG9zM/BZRQo+sSrFi4N9ygJHW6p5qpSv6LRNWMp7WQWP1wXQ1Mw+MOZmTZqU6pvLnvGlRblkU0d4cnFwub259l6JSbbkF8WU1JTlwlcN5DdEdEndGHQZ6MEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DhzD1OmG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c47PcOYu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EITFuj2xFcReNPnL6ovL+LhxtFO1rhrxKDTWPkOHOKw=;
	b=DhzD1OmGL1VFjGL32TN8ASX8rqtCT+Tay8bLhiw2p9qHqjIV+nexGM73X7zMWvepSBn8CM
	EbMMTI7AKY72/ACVwrCh8IODk5G+sBmDRdyH+b4E3TDfdtH6V+/z7B7MZZ/EHFcxnjsjg6
	k+OYB/A2OPfxaHv21dgvqyRpGEORfsLb945/TzYhuy0Dvn/JWnBf7VKCPg4B/MAAZunJHN
	aBXbqPBITQORWtu8Xy77KgzWhBSaXA9uVafhJpWUO6aQV8b5WGevGCemx07mbYTH8mSBVv
	JvVHRCz82FjXhC4XxY2G31hVgO76YdMU1YOSszqIbYBwg38+Z0O1LlZ11tGAeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EITFuj2xFcReNPnL6ovL+LhxtFO1rhrxKDTWPkOHOKw=;
	b=c47PcOYuGwBJ8ObWiI72eTTZvKkmypVNdlRqK/gBZth0Ayx+uOrAFbSwEFTPnhIy6ScQDu
	weckwPZ0z+abjODQ==
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
Subject: [PATCH v10 05/21] futex: Create futex_hash() get/put class
Date: Wed, 12 Mar 2025 16:16:18 +0100
Message-ID: <20250312151634.2183278-6-bigeasy@linutronix.de>
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

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c     |  7 +++----
 kernel/futex/futex.h    |  8 +++++++-
 kernel/futex/pi.c       | 10 ++++++----
 kernel/futex/requeue.c  | 10 +++-------
 kernel/futex/waitwake.c | 15 +++++----------
 5 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index e4cb5ce9785b1..08cf54567aeb6 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -114,7 +114,7 @@ late_initcall(fail_futex_debugfs);
  * We hash on the keys returned from get_futex_key (see below) and return =
the
  * corresponding hash bucket in the global hash.
  */
-struct futex_hash_bucket *futex_hash(union futex_key *key)
+struct futex_hash_bucket *__futex_hash(union futex_key *key)
 {
 	u32 hash =3D jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
@@ -122,6 +122,7 @@ struct futex_hash_bucket *futex_hash(union futex_key *k=
ey)
 	return &futex_queues[hash & futex_hashmask];
 }
=20
+void futex_hash_put(struct futex_hash_bucket *hb) { }
=20
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
@@ -957,9 +958,7 @@ static void exit_pi_state_list(struct task_struct *curr)
 		pi_state =3D list_entry(next, struct futex_pi_state, list);
 		key =3D pi_state->key;
 		if (1) {
-			struct futex_hash_bucket *hb;
-
-			hb =3D futex_hash(&key);
+			CLASS(hb, hb)(&key);
=20
 			/*
 			 * We can race against put_pi_state() removing itself from the
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index a219903e52084..eac6de6ed563a 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -7,6 +7,7 @@
 #include <linux/sched/wake_q.h>
 #include <linux/compat.h>
 #include <linux/uaccess.h>
+#include <linux/cleanup.h>
=20
 #ifdef CONFIG_PREEMPT_RT
 #include <linux/rcuwait.h>
@@ -201,7 +202,12 @@ extern struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns);
=20
-extern struct futex_hash_bucket *futex_hash(union futex_key *key);
+extern struct futex_hash_bucket *__futex_hash(union futex_key *key);
+extern void futex_hash_put(struct futex_hash_bucket *hb);
+
+DEFINE_CLASS(hb, struct futex_hash_bucket *,
+	     if (_T) futex_hash_put(_T),
+	     __futex_hash(key), union futex_key *key);
=20
 /**
  * futex_match - Check whether two futex keys are equal
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 62ce5ecaeddd6..4cee9ec5d97d6 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -939,9 +939,8 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags=
, ktime_t *time, int tryl
=20
 retry_private:
 	if (1) {
-		struct futex_hash_bucket *hb;
+		CLASS(hb, hb)(&q.key);
=20
-		hb =3D futex_hash(&q.key);
 		futex_q_lock(&q, hb);
=20
 		ret =3D futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
@@ -1017,6 +1016,10 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fl=
ags, ktime_t *time, int tryl
 		 */
 		raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
 		spin_unlock(q.lock_ptr);
+		/*
+		 * Caution; releasing @hb in-scope.
+		 */
+		futex_hash_put(no_free_ptr(hb));
 		/*
 		 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
 		 * such that futex_unlock_pi() is guaranteed to observe the waiter when
@@ -1119,7 +1122,6 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 {
 	u32 curval, uval, vpid =3D task_pid_vnr(current);
 	union futex_key key =3D FUTEX_KEY_INIT;
-	struct futex_hash_bucket *hb;
 	struct futex_q *top_waiter;
 	int ret;
=20
@@ -1139,7 +1141,7 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int f=
lags)
 	if (ret)
 		return ret;
=20
-	hb =3D futex_hash(&key);
+	CLASS(hb, hb)(&key);
 	spin_lock(&hb->lock);
 retry_hb:
=20
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 209794cad6f2f..992e3ce005c6f 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -444,10 +444,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int fla=
gs1,
=20
 retry_private:
 	if (1) {
-		struct futex_hash_bucket *hb1, *hb2;
-
-		hb1 =3D futex_hash(&key1);
-		hb2 =3D futex_hash(&key2);
+		CLASS(hb, hb1)(&key1);
+		CLASS(hb, hb2)(&key2);
=20
 		futex_hb_waiters_inc(hb2);
 		double_lock_hb(hb1, hb2);
@@ -817,9 +815,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 	switch (futex_requeue_pi_wakeup_sync(&q)) {
 	case Q_REQUEUE_PI_IGNORE:
 		{
-			struct futex_hash_bucket *hb;
-
-			hb =3D futex_hash(&q.key);
+			CLASS(hb, hb)(&q.key);
 			/* The waiter is still on uaddr1 */
 			spin_lock(&hb->lock);
 			ret =3D handle_early_requeue_pi_wakeup(hb, &q, to);
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 4bf839c85b66c..44034dee7a48c 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -154,7 +154,6 @@ void futex_wake_mark(struct wake_q_head *wake_q, struct=
 futex_q *q)
  */
 int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bit=
set)
 {
-	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
 	union futex_key key =3D FUTEX_KEY_INIT;
 	DEFINE_WAKE_Q(wake_q);
@@ -170,7 +169,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, i=
nt nr_wake, u32 bitset)
 	if ((flags & FLAGS_STRICT) && !nr_wake)
 		return 0;
=20
-	hb =3D futex_hash(&key);
+	CLASS(hb, hb)(&key);
=20
 	/* Make sure we really have tasks to wakeup */
 	if (!futex_hb_waiters_pending(hb))
@@ -267,10 +266,8 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int fla=
gs, u32 __user *uaddr2,
=20
 retry_private:
 	if (1) {
-		struct futex_hash_bucket *hb1, *hb2;
-
-		hb1 =3D futex_hash(&key1);
-		hb2 =3D futex_hash(&key2);
+		CLASS(hb, hb1)(&key1);
+		CLASS(hb, hb2)(&key2);
=20
 		double_lock_hb(hb1, hb2);
 		op_ret =3D futex_atomic_op_inuser(op, uaddr2);
@@ -444,9 +441,8 @@ int futex_wait_multiple_setup(struct futex_vector *vs, =
int count, int *woken)
 		u32 val =3D vs[i].w.val;
=20
 		if (1) {
-			struct futex_hash_bucket *hb;
+			CLASS(hb, hb)(&q->key);
=20
-			hb =3D futex_hash(&q->key);
 			futex_q_lock(q, hb);
 			ret =3D futex_get_value_locked(&uval, uaddr);
=20
@@ -618,9 +614,8 @@ int futex_wait_setup(u32 __user *uaddr, u32 val, unsign=
ed int flags,
=20
 retry_private:
 	if (1) {
-		struct futex_hash_bucket *hb;
+		CLASS(hb, hb)(&q->key);
=20
-		hb =3D futex_hash(&q->key);
 		futex_q_lock(q, hb);
=20
 		ret =3D futex_get_value_locked(&uval, uaddr);
--=20
2.47.2


