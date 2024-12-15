Return-Path: <linux-kernel+bounces-446627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F189F2753
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DED165019
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E061CEEA0;
	Sun, 15 Dec 2024 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zyYGNDBS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiRxPRgi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7671C54BF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304018; cv=none; b=hOm//SmmmJiuPKKTq2O/9IIPQm8EgLiaswT5wu8L16rEPXEmhsqrr37/ToTQccs2WakTM+LPfTnAUfjy/TdglgjlJEiHphaKkzGF9DQK+y7Z28YTpAwX1h2ZeDlZ7MrPTm/hueP655d5GeGmxb6PuQpaNFAYUOixDh1G6qnXxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304018; c=relaxed/simple;
	bh=XCZnUcVRTg/OdBNdYd0llHPmAfBHZiYKdMr5bvCqgZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7rHyD6C2XustAh+IeavmnEpaKjOQrPMCC+v5UDPb/xWYrRl6nqpVsnOSxyLDcgw6aZNKEl0C/E1FQLpHLS83ot++6vW+5Vi0AwL7C6H+KF8CZQtR17wb+qTOQlHi9m1TAfWvAZZFT43HRKjaTibkmxWWkZEN89FAc1/MYqx78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zyYGNDBS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiRxPRgi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FjMoQW4IUAh/X7O25zMu1DmUj0sv7Y/29SSuFX54hl0=;
	b=zyYGNDBS6MzYtimsNxXaj3pKa/3MHj/OtFxs8T2zMbQeGC3XS0zMziBarTx61dLQZ7mzyA
	499z23StgdVeDvXidER2SDApQ0mrdd8dHhcvemX6UwlO6W4mrc4N+bMi5hUNI0gMBpfLDW
	y5J1Tyc0PCHpXqITVN6Yj69VhB6u6ZDMmGcHPPig6b0BdW7tGLEQ39blCW1GT/tmihHy/x
	jM3B2BS8MhpjKnHNk32KRuqUJGCY12yxFzx5O358OGNI3k1azYHXlYOq3Qy6g7u1hwojFY
	qFzaLrODOWJCaNYVXUDMQbDWsWETSbqGzrGnvp3rkHV+QsFRNeDqHuFOKeixkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FjMoQW4IUAh/X7O25zMu1DmUj0sv7Y/29SSuFX54hl0=;
	b=fiRxPRgi2xx9o6KwA997m5S8tC3VBNjFoGe/rjzjs2yiwpaUPhfv9W1uL3nf+g9fchTIC+
	T2zm6Ix3re5aIxAw==
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
Subject: [PATCH v5 05/14] futex: Move private hashing into its own function.
Date: Mon, 16 Dec 2024 00:00:09 +0100
Message-ID: <20241215230642.104118-6-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hashing of the private is slightly different and will be needed
again while moving a futex_q entry to a different hash bucket after the
resize.

Move the private hashing into its own function.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 583a0149d62c9..907b76590df16 100644
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
@@ -131,14 +143,9 @@ struct futex_hash_bucket *futex_hash(union futex_key *=
key)
 	u32 hash;
=20
 	fhb =3D current->mm->futex_hash_bucket;
-	if (fhb && futex_key_is_private(key)) {
-		u32 hash_mask =3D current->mm->futex_hash_mask;
+	if (fhb && futex_key_is_private(key))
+		return futex_hash_private(key, fhb, current->mm->futex_hash_mask);
=20
-		hash =3D jhash2((void *)&key->private.address,
-			      sizeof(key->private.address) / 4,
-			      key->both.offset);
-		return &fhb[hash & hash_mask];
-	}
 	hash =3D jhash2((u32 *)key,
 		      offsetof(typeof(*key), both.offset) / 4,
 		      key->both.offset);
--=20
2.45.2


