Return-Path: <linux-kernel+bounces-557976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FDAA5E007
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB92C171F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A642571C3;
	Wed, 12 Mar 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3pZYK3w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="76mlXKq7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE08F253B4A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792607; cv=none; b=ROHpXG7LJKR/DAnoofI/L8d6UfAYbs4y/dOrkUiKGbvrZqMwbE/n3TvnRKmvKppAakt9+tSXlZDDRBzDnSX1Vt4cRG6mWeJW4Ge1Tc3VYaNGrdo8VDef+X4S+bHZEmOe3jUAtqbrEi19tTYJvn6xXzz6PCAc6F1dyqyKN87AO28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792607; c=relaxed/simple;
	bh=cAS8HrysPPVrUaecFoBO1lNGEIB8Qf5KtzktvdEyj8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTMeeHp6L0yOoQX/jSlYEJMLaDCYeMHjSkFsyhF3in2Ko2/2sCPB3m5KVfjbUITaXWy155HDSUB+PsLFhaslH4CkFBVVSVr8TYjxQePbLYRQJPf0i+srYNQ+AFsIpjmn7oq/ivdbxLRWNtAkBlTbCI0HU/HV5nESMCZsl89yO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3pZYK3w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=76mlXKq7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShzZceWVd5JqsOVo7vox1R/+m1/uWlP73cHaeuIRA7U=;
	b=a3pZYK3w0bDOVUrumnxRGCr7OvzGPBVo7vO7CRYH2AI668JoBxtulurh6LxcWSYJMe5a3A
	iMBIfp2H95kyL2dqzUn3EWXae75LrPqygnuQmqgGohh3fd7TmVGgCxJW/QsJcBvimH8+03
	XVb+Sa6dgIOBfNUEiVmr6ycfTzCpMSShgKoJFv6gRhQFx5K4CUIJOhWqkZDOyig8luTG3h
	QOG6+sSQRmCTn95op8YeJvOxaKYd3F5kkgp3xhTufpTNA6iI/79gLjufH7mQVgH4tZ6+6H
	Mdx9wnDhU8V9AQJgJY6TYXEat0mjAspAE0/BOA2cvsvwkAc1ufm1maUngghnaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShzZceWVd5JqsOVo7vox1R/+m1/uWlP73cHaeuIRA7U=;
	b=76mlXKq78zsZisu6H6kU6eCUr6Cf5AjwbVFbkOa/Lxs8d5DJNSNfsRx3lwL6yzJVuBjepr
	+zuUf2fDd2i/MdDg==
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
Subject: [PATCH v10 08/21] futex: Hash only the address for private futexes.
Date: Wed, 12 Mar 2025 16:16:21 +0100
Message-ID: <20250312151634.2183278-9-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

futex_hash() passes the whole futex_key to jhash2. The first two member
are passed as the first argument and the offset as the "initial value".

For private futexes, the mm-part is always the same and it is used only
within the process. By excluding the mm part from the hash, we reduce
the length passed to jhash2 from 4 (16 / 4) to 2 (8 / 2). This avoids
the __jhash_mix() part of jhash.

The resulting code is smaller and based on testing this variant performs
as good as the original or slightly better.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1feb7092635d0..8561c41df7dc5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -117,6 +117,18 @@ static inline bool futex_key_is_private(union futex_ke=
y *key)
 	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
 }
=20
+static struct futex_hash_bucket *futex_hash_private(union futex_key *key,
+						    struct futex_hash_bucket *fhb,
+						    u32 hash_mask)
+{
+	u32 hash;
+
+	hash =3D jhash2((void *)&key->private.address,
+		      sizeof(key->private.address) / 4,
+		      key->both.offset);
+	return &fhb[hash & hash_mask];
+}
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -131,14 +143,9 @@ struct futex_hash_bucket *__futex_hash(union futex_key=
 *key)
 	u32 hash;
=20
 	fhb =3D current->mm->futex_hash_bucket;
-	if (fhb && futex_key_is_private(key)) {
-		u32 hash_mask =3D current->mm->futex_hash_mask;
+	if (fhb && futex_key_is_private(key))
+		return futex_hash_private(key, fhb, current->mm->futex_hash_mask);
=20
-		hash =3D jhash2((u32 *)key,
-			      offsetof(typeof(*key), both.offset) / 4,
-			      key->both.offset);
-		return &fhb[hash & hash_mask];
-	}
 	hash =3D jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / 4,
 		      key->both.offset);
--=20
2.47.2


