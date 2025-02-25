Return-Path: <linux-kernel+bounces-532016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47773A447C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A00B3B5A62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654552063EB;
	Tue, 25 Feb 2025 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0b374hwN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bmm2fdvp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829F1A5BAF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503374; cv=none; b=ZgPqGYBF/xKt9+2lyb2jf9Hq+P85Pw1VxNEaiO2+GKdJwtOed2grAwH9ApJiIdkqjSfkbjFJNsVvqmmATUygG3Q8YngmlybuFojX/0l4e/ByVmrY3yj79p1O4+FdFSBAU0Ivsy1W8VrRUcSurYZJ0qsHXe1kCwDOQ42e6/MtZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503374; c=relaxed/simple;
	bh=bZh6gXEa9LZriRoawUsQKgPpDMmzOzeYTGlY71VV2K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk9D78K4dDDaJr8FR38YoF5AkkaLLD5IiVuc1Xjj+vgCB4j3Ry6siUJwHlFg4n6sxWsBosXtVKKIqDkLktBe7za+wpLhW7fvBimiIBkfMIukN+Ts7xihuhEneBiuNKdyYTH+WtVFqKhMg/U1PDtLseVlzm065L0MjebDos535Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0b374hwN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bmm2fdvp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740503364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUPvwagFivNcKsYclfPvVNwDsNwAco0iq8Mt4vpkuNQ=;
	b=0b374hwNB9OMUEQP0gIad2ewTO48TIjaTpjoJdq/x2s85HjeIbaLYTN6X7OMpULLoSCg+J
	Z1t+uDTE3QVPF3p0utc5vOsIUYp1SaFS6zuP6aSKOHZ9S48rENJr+Nwm30bbGroI2ZXNtq
	Bxw4D1ldb56VG2852iWRfq2agC4NIVVCUIwLI8BR32PODfVdT41thDuxVpXrfklOLhFLdd
	iAC4u/xY21CTtUtf+hI5wdexHOlTAqv1sPopLAAxBalFtr3in1QnbdSlkBxHqnxF9CNnfY
	27ZYbein5IlpdJCwdRtka2XchZwLdlSDVdHuaxPkJUyan7MZtUKQtwMzCHj9pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740503364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUPvwagFivNcKsYclfPvVNwDsNwAco0iq8Mt4vpkuNQ=;
	b=Bmm2fdvp7vZuLcqYsABzuL1UpDfNoB/JH553DImoiYEBKgxlDkqfoXcHP7ea8jODegaf8U
	5hik9gJTxtpBL0Ag==
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
Subject: [PATCH v9 11/11] futex: Use a hashmask instead of hashsize.
Date: Tue, 25 Feb 2025 18:09:14 +0100
Message-ID: <20250225170914.289358-12-bigeasy@linutronix.de>
In-Reply-To: <20250225170914.289358-1-bigeasy@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The global hash uses futex_hashsize to save the amount of the hash
buckets that have been allocated during system boot. On each
futex_hash() invocation this number is substracted by one to get the
mask. This can be optimized by saving directly the mask avoiding the
substraction on each futex_hash() invocation.

Rename futex_hashsize to futex_hashmask and save the mask of the
allocated hash map.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 6d375b9407c85..283e6644c05f9 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -52,10 +52,10 @@
  */
 static struct {
 	struct futex_hash_bucket *queues;
-	unsigned long            hashsize;
+	unsigned long            hashmask;
 } __futex_data __read_mostly __aligned(2*sizeof(long));
 #define futex_queues   (__futex_data.queues)
-#define futex_hashsize (__futex_data.hashsize)
+#define futex_hashmask (__futex_data.hashmask)
=20
 struct futex_private_hash {
 	rcuref_t	users;
@@ -285,7 +285,7 @@ struct futex_hash_bucket *__futex_hash(union futex_key =
*key)
 	hash =3D jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / 4,
 		      key->both.offset);
-	return &futex_queues[hash & (futex_hashsize - 1)];
+	return &futex_queues[hash & futex_hashmask];
 }
=20
 #ifndef CONFIG_BASE_SMALL
@@ -1420,8 +1420,8 @@ static int futex_hash_allocate(unsigned int hash_slot=
s)
 		hash_slots =3D 16;
 	if (hash_slots < 2)
 		hash_slots =3D 2;
-	if (hash_slots > futex_hashsize)
-		hash_slots =3D futex_hashsize;
+	if (hash_slots > futex_hashmask + 1)
+		hash_slots =3D futex_hashmask + 1;
 	if (!is_power_of_2(hash_slots))
 		hash_slots =3D rounddown_pow_of_two(hash_slots);
=20
@@ -1482,7 +1482,7 @@ int futex_hash_allocate_default(void)
 	 */
 	buckets =3D roundup_pow_of_two(4 * threads);
 	buckets =3D max(buckets, 16);
-	buckets =3D min(buckets, futex_hashsize);
+	buckets =3D min(buckets, futex_hashmask + 1);
=20
 	if (current_buckets >=3D buckets)
 		return 0;
@@ -1536,24 +1536,25 @@ int futex_hash_prctl(unsigned long arg2, unsigned l=
ong arg3)
=20
 static int __init futex_init(void)
 {
+	unsigned long i, hashsize;
 	unsigned int futex_shift;
-	unsigned long i;
=20
 #ifdef CONFIG_BASE_SMALL
-	futex_hashsize =3D 16;
+	hashsize =3D 16;
 #else
-	futex_hashsize =3D roundup_pow_of_two(256 * num_possible_cpus());
+	hashsize =3D roundup_pow_of_two(256 * num_possible_cpus());
 #endif
=20
 	futex_queues =3D alloc_large_system_hash("futex", sizeof(*futex_queues),
-					       futex_hashsize, 0, 0,
+					       hashsize, 0, 0,
 					       &futex_shift, NULL,
-					       futex_hashsize, futex_hashsize);
-	futex_hashsize =3D 1UL << futex_shift;
+					       hashsize, hashsize);
+	hashsize =3D 1UL << futex_shift;
=20
-	for (i =3D 0; i < futex_hashsize; i++)
+	for (i =3D 0; i < hashsize; i++)
 		futex_hash_bucket_init(&futex_queues[i], 0);
=20
+	futex_hashmask =3D hashsize - 1;
 	return 0;
 }
 core_initcall(futex_init);
--=20
2.47.2


