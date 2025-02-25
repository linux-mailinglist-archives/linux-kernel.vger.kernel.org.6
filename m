Return-Path: <linux-kernel+bounces-532008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B577A447C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A575288103F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00351A238A;
	Tue, 25 Feb 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZKvLIIR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AoqM9zZb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000919258C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503371; cv=none; b=ImSYkUiVsxBTnh2HVd2C0vecLuZQLWTffISqr6WHI4iT4ukttI9aB0E5DdPpjvAuDOHBjUbjxZzqlcU0cGqLDNhk564Nx+FLt/P71W0XGsS5ADWw3DtZLLEfj9PtV8x98s9PsuBjxWWj9tb4ErpDo/mMj11Sr1ZaTz/MKuGw7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503371; c=relaxed/simple;
	bh=z7SKTQ7Ma64q/SAOUM4xlnyQVGuryAeFCcdUA7KW4bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuESnIp94NvTp5R5ysE/Cm3AMKYDa/52wvOIRyDc7QFgnGMaNzWYcdMEkn+dyMbgDFNjhAceEGvBlb2EhXO50cOrun+CAZxDC6/XoT4ayasxICNP2S1npg1WYFt6/MM4bPSbL7hirMXcpYlI07TFp05a3INy8i1SUAvE+Ol7XLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZKvLIIR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AoqM9zZb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740503361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkKAJ4zyYXh6FJYQyMom9miYRg7bgz+h0w13kY0QJBI=;
	b=KZKvLIIR1P2O5E1vcCB1yqF0Cr8B6O6jgTeTQT8zyfsdv4uVG327uEpG9c3dCW5sCPd9sU
	lsJo+oib+Q8pd7m/e4p80X7k1NZqlEggx3cTRsCe9ZJET3WJOUofslVvll4lvd2L1TWZjF
	xA+biGrTRBr9Ij4KQreDtPlBf0+WnY5Esuo0SDpNJj8aY15IRp9nlPdMYbIxOKVafLNGMa
	CWZodrkkd9Ke7PFvBVwmpTZ44VwULDFaymKP24HgYb7oWM1udCu9+uSctcwUZYDifkq8Oj
	MPzi4o4FDFRgVtdx9alN7H+nMRFnZ4dGhtJoLrQHEANZVSH1+g0b1OytAy47pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740503361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkKAJ4zyYXh6FJYQyMom9miYRg7bgz+h0w13kY0QJBI=;
	b=AoqM9zZbFZey+sikzxRYPfDE8/qG9Mgw9tDuP6raihhKPvXLtEOYRP+6Py1Nax33XvEQPc
	GtiFpaa/5G6TF8Dw==
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
Subject: [PATCH v9 04/11] futex: Hash only the address for private futexes.
Date: Tue, 25 Feb 2025 18:09:07 +0100
Message-ID: <20250225170914.289358-5-bigeasy@linutronix.de>
In-Reply-To: <20250225170914.289358-1-bigeasy@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
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
---
 kernel/futex/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index e64a5cf818414..e4e0bc7722d78 100644
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
  * futex_hash - Return the hash bucket in the global or local hash
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


