Return-Path: <linux-kernel+bounces-557975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4CA5E006
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484AD3A316B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CEC2566E9;
	Wed, 12 Mar 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p8HQJS9j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/6YnKMHK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40208252907
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792606; cv=none; b=Emd53t6EgbxaSi/9nGVKcwZJoJvV3QDh0wBbrR0oG2q0FGH19uCrMmCVSr7/VUddVmWHJhPuAc9Lh1EuBIpYRsX/RQUQHGwuUH1UeNRs+mMLMFtruz3eO0P+UezZnlmw1LiHYxpxUhk+7HgBtuJveuSaEx7jrjaXgY2tFWNPaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792606; c=relaxed/simple;
	bh=zNHF9gLRJbaWgJ86a6QXAXpvHh0UaOvRjG2O6sAVe6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYQ5RCFdJaIQnmYBXD+Fd0W64A8Cd8NdO5JIenEjEBzfdGU94ZEM3WuOciFZJSm4xcd31aC8IIThlk3iXbeDZ7pD6FGkvhr9lpKXFSTaj48QilpiAZrtap8Hot0JoJavV8fitFUCxooLAlryj/8rT5AIe57kEn7KObyIC07LMtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p8HQJS9j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/6YnKMHK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8eVr2NQkknRf1y68E2hvHz4ee/KkpMgqGwjShLOjZE=;
	b=p8HQJS9joM1yZg+lnVruYvXCUayevADHVRUB48NXX2m/7EStQt+xCAuBB0bBnknsis08l4
	GAumTG5wSqIGRlrAjgTiVPd3H6vu81U9xcfST3ygjUuQtaCbhDK+/BYTF1LNGOqyiPHvqT
	clSSZQMjbuIjGos9zKgcYSFfeb3TZO+7taqmI6qKwuNyYaphHjxdJwCGRX8tD3MDCpZhB3
	m8ZVCpefMgl8GB+DpZnw2FhFFseFkoSlCv6TfX6uqPX3E2a0teJSCw/HFXueVF995B1tmV
	BsNdxFZaRriTgPBXO5/fpfBPJexEAX9WeHC+1JotWIVuLlcl2YJr0MDbZjKHxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8eVr2NQkknRf1y68E2hvHz4ee/KkpMgqGwjShLOjZE=;
	b=/6YnKMHKwaTB/t80orjLcoyyRn91o/s9BKHuSBrfYjr7oCO4AXNHKdjfqYI8t7gy+KuOpO
	vDjytlNFqusFnvDg==
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
Subject: [PATCH v10 06/21] futex: Create helper function to initialize a hash slot.
Date: Wed, 12 Mar 2025 16:16:19 +0100
Message-ID: <20250312151634.2183278-7-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Factor out the futex_hash_bucket initialisation into a helpr function.
The helper function will be used in a follow up patch implementing
process private hash buckets.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 08cf54567aeb6..c6c5cde78e0cb 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1122,6 +1122,13 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
=20
+static void futex_hash_bucket_init(struct futex_hash_bucket *fhb)
+{
+	atomic_set(&fhb->waiters, 0);
+	plist_head_init(&fhb->chain);
+	spin_lock_init(&fhb->lock);
+}
+
 static int __init futex_init(void)
 {
 	unsigned long hashsize, i;
@@ -1139,11 +1146,8 @@ static int __init futex_init(void)
 					       hashsize, hashsize);
 	hashsize =3D 1UL << futex_shift;
=20
-	for (i =3D 0; i < hashsize; i++) {
-		atomic_set(&futex_queues[i].waiters, 0);
-		plist_head_init(&futex_queues[i].chain);
-		spin_lock_init(&futex_queues[i].lock);
-	}
+	for (i =3D 0; i < hashsize; i++)
+		futex_hash_bucket_init(&futex_queues[i]);
=20
 	futex_hashmask =3D hashsize - 1;
 	return 0;
--=20
2.47.2


