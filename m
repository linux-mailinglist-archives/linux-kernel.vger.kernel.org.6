Return-Path: <linux-kernel+bounces-446634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2F29F275A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CE816520A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4C71D5178;
	Sun, 15 Dec 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BDH1N5Nn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D7qox8Em"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F261CD1E0
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304019; cv=none; b=HyhIha0qB7jIgXFNpnRNG/7KT0dMSAIhj1im8kM7DfZhyvEArI+M2dYePEb4SqgyWbFGv7u+pR4F0tgls1xUiT4KrWgLSXRhhn2GYaPQB+/RU4NwjO2l6StinxuwYGlV4JALA7ffJQjDiwV/9QC+jCG5hv0EMcJH4JwXQO5zt6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304019; c=relaxed/simple;
	bh=tGQ90tQFNBs0LioAZHXxhJi+dnJqsSoi4itaba/oBcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8Pp4WjcTHZ6AfdkOcvYhZW0GIGPNeYKUilJxdksP0p6Wmp7aqmmr2gDrEbJoR6ifAOKo8IheQl8ENMj07Tkj5plMOvDnkeU6qyTXsjw5W6Pwu0ScSpUJe1RFxuRl/+MLKm1UmLaNK8+p6PWCf5gNv6mYiU0Yif+HT+f9FJZfNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BDH1N5Nn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D7qox8Em; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXQJmqhHPrSasMZSAKq9wWCexASoz+ENk/0L1qCztPU=;
	b=BDH1N5Nns2jn+rHBKPB5smoQ6OBUA2MgYwPnWmNkZ3Vn/Bzi1xO1tTVHsGz6/m0FKjqYHc
	lL25xsOzScS3A8GMsZyF8exvJs/O+ElW66sgkOktGcyzc/7fbNzw6FRJZnwViS01zIpudY
	ksu59SW/WHx2LOTTtUe/AhQfBjNeNKyUr44cf2ibjwlDkBm9+4dgOYFMP1OJD7cWELDDR9
	tdAbD/3X3pUpdZdEUt9AkAQN+61ZyvVB+B1+Hg61j/Y5gEL8WVB27oYmtEAtnp4e+yLTh7
	usyvnRau7yD67fP6YQGea1T7AdO59gmRxX1MOAwiZVrzDrHW9dx6pK/lH9/89w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXQJmqhHPrSasMZSAKq9wWCexASoz+ENk/0L1qCztPU=;
	b=D7qox8EmHs5aNj1+QLs6sWdwAHF2xnivF3dNcl7YSH9sBv4mcTv30OSDXrZpNHK3xVs/zE
	6WVZyYWgilGfdzBw==
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
Subject: [PATCH v5 11/14] futex: Use a hashmask instead of hashsize.
Date: Mon, 16 Dec 2024 00:00:15 +0100
Message-ID: <20241215230642.104118-12-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
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
 kernel/futex/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 15e319239c282..b237154d67df0 100644
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
 struct futex_hash_bucket_private {
 	rcuref_t	users;
@@ -300,7 +300,7 @@ struct futex_hash_bucket *futex_hash(union futex_key *k=
ey)
 	hash =3D jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / 4,
 		      key->both.offset);
-	return &futex_queues[hash & (futex_hashsize - 1)];
+	return &futex_queues[hash & futex_hashmask];
 }
=20
 void futex_hash_put(struct futex_hash_bucket *hb)
@@ -1486,25 +1486,25 @@ int futex_hash_prctl(unsigned long arg2, unsigned l=
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
-	futex_default_max_buckets =3D futex_hashsize;
+	futex_default_max_buckets =3D hashsize;
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
-
+	futex_hashmask =3D hashsize - 1;
 	return 0;
 }
 core_initcall(futex_init);
--=20
2.45.2


