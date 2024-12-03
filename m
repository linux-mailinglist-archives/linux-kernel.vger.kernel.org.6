Return-Path: <linux-kernel+bounces-429866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F69E28C4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1149DB8178A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A61FC0E2;
	Tue,  3 Dec 2024 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jIrb/sSa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="83/TizOY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF21FA17D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244224; cv=none; b=tnDPHF0AL//UA4wxX28rAn1lGAV69RR1Gvy/I4K6jFFbC17d0ueSzqOg1wRI7hcQsmcfSYc8GzKaftlOr2Dw/yLBIcpSmppzgvoLr8bKCwPJhwO2Y132xFFG4qQoo/IsJUfuStVnuGq3mnXrKPnx3uZsizYkznJDsa4hlNGvZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244224; c=relaxed/simple;
	bh=ZMp6vYNIg9gi1PP51ysgh4RevnxhkX7M+zQrNiRnfyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCjHx2G5P+ygAwjPiSbyyWCTya/FtiMziRhaH7bKBJKxYtyOVui7BJz0+W5787pYnAkBPK+vB3xwE1NWAimGit3HdW7YwuS+iHrK8XNsoFW+5FIe1b//HQbP5wYctc5OBc37ZJopwkK2J4QYj+qUXZmlY4yrqjqc0xl7icGT338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jIrb/sSa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=83/TizOY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733244219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPNujvPD1HpjKF+RNz+0sqiBOxGwTUAti6CTU9Flecs=;
	b=jIrb/sSaxf1Q85+Tm9NhINDTmsQXC3fkOYkeuT5i0cXqdV4Taet1tVkxpJsp9mtBh7eSK/
	cNkqa+yGkR5oDRdBXeXyv5GPbTtr02ck21ElxDlMLGTO/k4fRKgZLed7nMWAAZ+1giJ7k4
	UNBZQD/4R6Sfa7uY+7isv+RgGbe1jngOsRR/HHA97YdAxpFOmoGV09LQE6c6jWrN6NJ0rC
	7P1+1G9cy5aPQn/2n3TIuF5KVoeSi0Rl/raqYSjGdy9uPrNTq8hgT6jlHgeQdBWM9M+2r3
	MByT4gAmtgANQw8NyuV/k9D+6Zrfad7O3mR3MK3pE3OSjHEcyTq5dynBUxXaiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733244219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPNujvPD1HpjKF+RNz+0sqiBOxGwTUAti6CTU9Flecs=;
	b=83/TizOYeBodsemzShK87EWAnjQyVELcIEwduUtxgrGBuw5x45HJZW3f6iGiDMKeYp98Sq
	jrMYOONFN5dCumCw==
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
Subject: [PATCH v4 08/11] futex: Resize futex hash table based on number of threads.
Date: Tue,  3 Dec 2024 17:42:16 +0100
Message-ID: <20241203164335.1125381-9-bigeasy@linutronix.de>
In-Reply-To: <20241203164335.1125381-1-bigeasy@linutronix.de>
References: <20241203164335.1125381-1-bigeasy@linutronix.de>
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

If the upper limit is reached, the HB will be made invariant.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c       |  4 ----
 kernel/futex/core.c | 39 +++++++++++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 6267d600af991..35ec9958707c5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2134,10 +2134,6 @@ static bool need_futex_hash_allocate_default(u64 clo=
ne_flags)
 {
 	if ((clone_flags & (CLONE_THREAD | CLONE_VM)) !=3D (CLONE_THREAD | CLONE_=
VM))
 		return false;
-	if (!thread_group_empty(current))
-		return false;
-	if (current->mm->futex_hash_bucket)
-		return false;
 	return true;
 }
=20
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1abea8f9abd22..19515aa5a6430 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -65,6 +65,8 @@ struct futex_hash_bucket_private {
 	struct futex_hash_bucket queues[];
 };
=20
+static unsigned int futex_default_max_buckets;
+
 /*
  * Fault injections for futexes.
  */
@@ -1262,7 +1264,7 @@ bool futex_check_hb_valid(struct futex_hash_bucket *h=
b)
 	return hb_p_now =3D=3D hb_p;
 }
=20
-static int futex_hash_allocate(unsigned int hash_slots)
+static int futex_hash_allocate(unsigned int hash_slots, bool slots_invaria=
nt)
 {
 	struct futex_hash_bucket_private *hb_p, *hb_p_old =3D NULL;
 	struct mm_struct *mm;
@@ -1274,8 +1276,8 @@ static int futex_hash_allocate(unsigned int hash_slot=
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
@@ -1293,7 +1295,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s)
=20
 	rcuref_init(&hb_p->users, 1);
 	hb_p->hash_mask =3D hash_slots - 1;
-	hb_p->slots_invariant =3D false;
+	hb_p->slots_invariant =3D slots_invariant;
=20
 	for (i =3D 0; i < hash_slots; i++)
 		futex_hash_bucket_init(&hb_p->queues[i], i + 1);
@@ -1321,7 +1323,31 @@ static int futex_hash_allocate(unsigned int hash_slo=
ts)
=20
 int futex_hash_allocate_default(void)
 {
-	return futex_hash_allocate(0);
+	unsigned int threads;
+	unsigned int buckets;
+	unsigned int current_buckets =3D 0;
+	struct futex_hash_bucket_private *hb_p;
+
+	if (!current->mm)
+		return 0;
+
+	scoped_guard(rcu) {
+		threads =3D get_nr_threads(current);
+		hb_p =3D rcu_dereference(current->mm->futex_hash_bucket);
+		if (hb_p) {
+			if (hb_p->slots_invariant)
+				return 0;
+			current_buckets =3D hb_p->hash_mask + 1;
+		}
+	}
+
+	buckets =3D roundup_pow_of_two(4 * threads);
+	buckets =3D max(buckets, 16);
+	buckets =3D min(buckets, futex_default_max_buckets);
+	if (current_buckets > buckets)
+		return 0;
+
+	return futex_hash_allocate(buckets, buckets =3D=3D futex_default_max_buck=
ets);
 }
=20
 static int futex_hash_get_slots(void)
@@ -1372,7 +1398,7 @@ int futex_hash_prctl(unsigned long arg2, unsigned lon=
g arg3,
=20
 	switch (arg2) {
 	case PR_FUTEX_HASH_SET_SLOTS:
-		ret =3D futex_hash_allocate(arg3);
+		ret =3D futex_hash_allocate(arg3, false);
 		break;
=20
 	case PR_FUTEX_HASH_GET_SLOTS:
@@ -1404,6 +1430,7 @@ static int __init futex_init(void)
 #else
 	futex_hashsize =3D roundup_pow_of_two(256 * num_possible_cpus());
 #endif
+	futex_default_max_buckets =3D futex_hashsize;
=20
 	futex_queues =3D alloc_large_system_hash("futex", sizeof(*futex_queues),
 					       futex_hashsize, 0, 0,
--=20
2.45.2


