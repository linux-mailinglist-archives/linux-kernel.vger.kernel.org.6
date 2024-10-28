Return-Path: <linux-kernel+bounces-384903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CDF9B2FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9301F22859
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2A1DA631;
	Mon, 28 Oct 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YMUoDIvd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yoNTYwf4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523561D9660
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117973; cv=none; b=Tpcs3j0oTxufCvb+92p60+UCJNQMtQwIiaE4FsSWgTVZteOnY6e/XuYkU0zAZ7B9UEPWSmYl5SLS7JRfAGVtOIQHk1WYr0DJtDRqrDBenV7tb2IWviGXq7wmEQvHB/BeCwdffFvI1jzCpvP/FIGXe5JIC1jWEWxYDXVit9RPNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117973; c=relaxed/simple;
	bh=5JdtUbK9JRTP/7wNU4slhmmPugwMyf/XIiP/M4WwZZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDJgBH8R+BzjWgemteyTdRYdXj5SkiZ4Z2b33adm0Uq88ikWRXjm+Jl0KUWx/wQAacM035VRBDttnWb8/ygeleAP44v1RB2B4C78BJENALUT9YY/Tcq78vFaA/mrQw0cQQhIAhUUCtmVtBkDSrHFP1TLq8Om1c/VyV457OM3It4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YMUoDIvd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yoNTYwf4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730117969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oblyvANSZqruSqs+9bBfCTS3ayrNqKZAV/NQ1ZYwdp8=;
	b=YMUoDIvd4HsFu8ZDoDyXTWetTGAEe6T2FYlB32uJQOVqgXmrCOEj57uUdV6cC0pIyz/RYY
	TEAOV45fYbG+woDlvZBsa7uSOG4MmNyVMzP8XZtCABG13RYzkHbP3zFbyUi+io9P5Uf2jq
	sT1Vo7oLW7AbwIuW3O73IhhozZZ9S7yi9E4MAcSL9uf0euNrJRcf4jMA/sEonuSmpvcLw5
	oM7oxr+iHKRnKLfXXRbtZKCQzHySwkc2rxcyZ8KLCnhd1N0mC4BfpwqS+JW5+vn6XTI0VE
	kjxegAg7La3yH/3ZP0DrzBNajDk6H8TN4vOgt1kMoMemHDe8hBz5jQ7akFWUzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730117969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oblyvANSZqruSqs+9bBfCTS3ayrNqKZAV/NQ1ZYwdp8=;
	b=yoNTYwf4FjKV0LjT2m8Hax2uFzr5w1RueUUwQFyS/bjilranO6eEEu6UIpJ9XxH8T1iBjF
	A8q40WyvDCEUVaDQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH v2 3/4] futex: Use the task local hashmap.
Date: Mon, 28 Oct 2024 13:13:57 +0100
Message-ID: <20241028121921.1264150-4-bigeasy@linutronix.de>
In-Reply-To: <20241028121921.1264150-1-bigeasy@linutronix.de>
References: <20241028121921.1264150-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the hashlocal hashmap if provided.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 14e4cb5ccd722..3ef4cbd5cfa72 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -108,18 +108,33 @@ late_initcall(fail_futex_debugfs);
=20
 #endif /* CONFIG_FAIL_FUTEX */
=20
+static inline bool futex_key_is_private(union futex_key *key)
+{
+	/*
+	 * Relies on get_futex_key() to set either bit for shared
+	 * futexes -- see comment with union futex_key.
+	 */
+	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
+}
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
  *
  * We hash on the keys returned from get_futex_key (see below) and return =
the
- * corresponding hash bucket in the global hash.
+ * corresponding hash bucket in the global hash. If the FUTEX is private a=
nd
+ * a local hash table is privated then this one is used.
  */
 struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
+	struct futex_hash_bucket *fhb;
 	u32 hash =3D jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
=20
+	fhb =3D current->signal->futex_hash_bucket;
+	if (fhb && futex_key_is_private(key))
+		return &fhb[hash & current->signal->futex_hash_mask];
+
 	return &futex_queues[hash & (futex_hashsize - 1)];
 }
=20
--=20
2.45.2


