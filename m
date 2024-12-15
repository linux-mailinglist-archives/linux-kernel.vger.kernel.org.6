Return-Path: <linux-kernel+bounces-446630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C374C9F2755
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83851164F76
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F61D1724;
	Sun, 15 Dec 2024 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZzVI4xUJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fncCmHO0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E61CBE9D
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304019; cv=none; b=lYYUZUhImfj+dDzyx6aj5rng0HwvJywyIFoTlWvbjCOGFykGOppc9XQ5OXRzquPDOailGuSQQG2npoYyop6hHxoVSZQ6iQmQNU+e5DTaFernzDITM3UQ/L6TWAT3jeSOR/H9k6a+H2tf2Y064KMfQh4a8CweXB13IBMISNwxE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304019; c=relaxed/simple;
	bh=ApSE6kj/TaY7TtI1krjzNXsHoRPLQpQTs1ZcO8nxEt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLhr8BL8p86hetCSWrJUdLihZG7kHpvEUpRenblIlf7BMajBzooALuPMe7K9NK34JGBaBmwscQvmj+2789nKjEwlqNOTvSrR7tL5pqcfBrto71rTu4uSbTNas9ILaij0O76HFca5LJCH8TVgBuU07+/4+91jFFOm0EjWKhXt28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZzVI4xUJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fncCmHO0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNK33miYFEQI02d8SciwtswjvFmdUE/Kvrm/kWYmMWM=;
	b=ZzVI4xUJQ08bQ83t4/lFpCm5Y+lSZWVY5jgqgT/WBxltaHIru4Ztz5CiPhwFUkXPbx+BFP
	0A9rLQO3l7JoDFMsE83PjxspgmUpOJy3WczkKp5GSnigLZjHxaVBV2lELCpTBF18O5m/wm
	Gde6oNdd0veOLxjM5q2XwbrmskL3kmNB7jwHTgcIg2Mf083Tx4KFbzuKl46jmj/HJ4K40Q
	MSxq4F/X9Jp9pDLGi3bxWYrhFN3E4e0XV4VxpQ3C+K4GxpsSgq6QfR3aqyuL/Xno0DL20v
	3U8ITkfVtwZh/AIctNqvFW7+BNNicQJ29fwFGxlRA55WK8L8afdLCT6kTjPF1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNK33miYFEQI02d8SciwtswjvFmdUE/Kvrm/kWYmMWM=;
	b=fncCmHO0LKncLW+nKp0jzCgF7IeRw0PhIF4NsuwWG2BI+AVgrpD8RAVOZYo1MzmV8HZX4+
	3V3b9JPqK27HlUCw==
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
Subject: [PATCH v5 10/14] futex: Resize futex hash table based on number of threads.
Date: Mon, 16 Dec 2024 00:00:14 +0100
Message-ID: <20241215230642.104118-11-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Automatically size hash bucket based on the number of threads. The logic
tries to allocate between 16 and futex_hashsize (the default for the
system wide hash bucket) and uses 4 * number-of-threads.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h | 12 ------------
 kernel/fork.c         |  4 +---
 kernel/futex/core.c   | 28 +++++++++++++++++++++++++---
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 3ced01a9c5218..403b54526a081 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -87,13 +87,6 @@ static inline void futex_mm_init(struct mm_struct *mm)
 	mutex_init(&mm->futex_hash_lock);
 }
=20
-static inline bool futex_hash_requires_allocation(void)
-{
-	if (current->mm->futex_hash_bucket)
-		return false;
-	return true;
-}
-
 #else
 static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
@@ -116,11 +109,6 @@ static inline int futex_hash_allocate_default(void)
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
diff --git a/kernel/fork.c b/kernel/fork.c
index e34bb2a107a9d..35ec9958707c5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2134,9 +2134,7 @@ static bool need_futex_hash_allocate_default(u64 clon=
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
index f80ae39f2a83a..15e319239c282 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -64,6 +64,8 @@ struct futex_hash_bucket_private {
 	struct futex_hash_bucket queues[];
 };
=20
+static unsigned int futex_default_max_buckets;
+
 /*
  * Fault injections for futexes.
  */
@@ -1400,8 +1402,8 @@ static int futex_hash_allocate(unsigned int hash_slot=
s)
 		hash_slots =3D 16;
 	if (hash_slots < 2)
 		hash_slots =3D 2;
-	if (hash_slots > 131072)
-		hash_slots =3D 131072;
+	if (hash_slots > futex_default_max_buckets)
+		hash_slots =3D futex_default_max_buckets;
 	if (!is_power_of_2(hash_slots))
 		hash_slots =3D rounddown_pow_of_two(hash_slots);
=20
@@ -1429,7 +1431,26 @@ static int futex_hash_allocate(unsigned int hash_slo=
ts)
=20
 int futex_hash_allocate_default(void)
 {
-	return futex_hash_allocate(0);
+	unsigned int threads, buckets, current_buckets =3D 0;
+	struct futex_hash_bucket_private *hb_p;
+
+	if (!current->mm)
+		return 0;
+
+	scoped_guard(rcu) {
+		threads =3D get_nr_threads(current);
+		hb_p =3D rcu_dereference(current->mm->futex_hash_bucket);
+		if (hb_p)
+			current_buckets =3D hb_p->hash_mask + 1;
+	}
+
+	buckets =3D roundup_pow_of_two(4 * threads);
+	buckets =3D max(buckets, 16);
+	buckets =3D min(buckets, futex_default_max_buckets);
+	if (current_buckets >=3D buckets)
+		return 0;
+
+	return futex_hash_allocate(buckets);
 }
=20
 static int futex_hash_get_slots(void)
@@ -1473,6 +1494,7 @@ static int __init futex_init(void)
 #else
 	futex_hashsize =3D roundup_pow_of_two(256 * num_possible_cpus());
 #endif
+	futex_default_max_buckets =3D futex_hashsize;
=20
 	futex_queues =3D alloc_large_system_hash("futex", sizeof(*futex_queues),
 					       futex_hashsize, 0, 0,
--=20
2.45.2


