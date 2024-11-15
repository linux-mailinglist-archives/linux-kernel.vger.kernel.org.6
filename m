Return-Path: <linux-kernel+bounces-411084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7459CF40E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25EDB620E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193571E1A32;
	Fri, 15 Nov 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUu2icoD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="albHp5bJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A561D618A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691248; cv=none; b=aKIknrx/bp7TB+yD5ZLjQbarsOerxVCIoBjd5SJ+RJUc0UuRTpG61eiXEAc5YvYCWuvtV2JrCIStEv8cvu11rT8luENyW6t1BUVDBN1KHI81tXGnKj3wZu+lB8E4XovIY9kV4nEz1ulPKsMpAE5YhdnCnu56S0EqleEnpMNhrzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691248; c=relaxed/simple;
	bh=DH58qurgKZ3NE3npPwHdlb4AJ1ljYjCmbxGxiwkUg2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIRK4JT32z1uqG/jRG+NXNsyVJFaLDQ6MyEeCpPI3tYIYue6SiafbFDolcVGvdIYyO/lqDZ8x0GAbRWOah+XhZzMqak+ttcXbhE/eCjZd5LizQc1p4yhopU9KJ4oj3hqgO4BaukBWBXerQuhmqg1qDz/lV8XZlL2+X/2cflKmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUu2icoD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=albHp5bJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731691243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuNDl7xyS9sedFEMEU6wMQC/X2A0lAOMTqby/qP6gQU=;
	b=DUu2icoDMQXb1lm7Uf83Udw4o+I1YgUvz2s+EZ0Ztq5zyzrRgpzRxMoxTQ0hNMYw+EBfuH
	gyz7HCmwjIOyBsOUPNg28x856AxW+BsjlcXeqnQrmy7iWHKVxGceqGQ/OXZvHmTuXBPGat
	Iaa5E5dAD+OzeVSrPOxKwCBja/YPhf2UkrplHrWyu89UQhsojB1ISCgCVtRhEG/xgvk3tn
	StHVexJHG5EQvSmosAxH9Phzz0DOplCfFgsi7QR9U5swWiEc8FsbqHOliaHQAZT0TE5IOn
	PO/p3bCMyq6sbCnbFn0tl/dJRwAU3SYHGZ73lzoVB6ktPLXrDUGRnW3NF2XC9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731691243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuNDl7xyS9sedFEMEU6wMQC/X2A0lAOMTqby/qP6gQU=;
	b=albHp5bJu0xft0J9jVLygTXTFxxh/thCXImsz4FJILcjgsZSUZSlbT0UYUEJzPr+Kqx+sP
	pVCILychx9bHzPCA==
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
Subject: [RFC PATCH v3 4/9] futex: Hash only the address for private futexes.
Date: Fri, 15 Nov 2024 17:58:45 +0100
Message-ID: <20241115172035.795842-5-bigeasy@linutronix.de>
In-Reply-To: <20241115172035.795842-1-bigeasy@linutronix.de>
References: <20241115172035.795842-1-bigeasy@linutronix.de>
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
 kernel/futex/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 2f5087fde57ef..5b66b6e52aeb5 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -134,8 +134,8 @@ struct futex_hash_bucket *futex_hash(union futex_key *k=
ey)
 	if (fhb && futex_key_is_private(key)) {
 		u32 hash_mask =3D current->mm->futex_hash_mask;
=20
-		hash =3D jhash2((u32 *)key,
-			      offsetof(typeof(*key), both.offset) / 4,
+		hash =3D jhash2((void *)&key->private.address,
+			      sizeof(key->private.address) / 4,
 			      key->both.offset);
 		return &fhb[hash & hash_mask];
 	}
--=20
2.45.2


