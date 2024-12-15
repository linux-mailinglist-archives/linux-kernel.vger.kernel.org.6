Return-Path: <linux-kernel+bounces-446623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1C9F274F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA083164EAA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920481C54B3;
	Sun, 15 Dec 2024 23:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wj1RtPGw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROwnjMX9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20A1885A5
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304016; cv=none; b=YQMhXxO9oznLjYtEl/mNlwAFUsxl7N3V3T3y5NLMS4qAj4XQZtI/1sYKwIKJB+JIahnpehtRauEL7Ls1bIuEWgpNrcMtvNwz9R5c5idpzvLOR6jKGXHjGWY23UUSFaJ+vjQSDb+CfQ1RY6UN2e59wcAwdRqLWdHsKfupBph51bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304016; c=relaxed/simple;
	bh=KHeSjPd0zRCAGUtxGFlcWOPrmx9y+ukDcIFpzj3jkJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdphbcoZP6xBF0NDQndhO/l9CGCu/Jh0woBjqwiQZhsxM7u337sJrvV1ECN1CQh23BZ4JHyIt0NAJ8Znc0FhpmhDw5oLLNqkWOulOt+YVQ6iHjyF+82tZDVV7JGxvO6XwrS6L4Ya1DFJRJ9JyHZxGiIIdydc50j2QHtbpc9A07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wj1RtPGw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROwnjMX9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734304007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOfEVIxyuzb94jSGu1mkbITIF88QTRaDLmkNO646qMs=;
	b=Wj1RtPGwGqK4iS882X2utHk7Xonbp1mBivUjy0D1YuCupWOe/9vnnbBqZJCOap/LzbNHUk
	TyDSggtUpL5IVLMO6RjPOvn3/g/kqQHETd+yvdMGvQK6dEDbdh8L0I9UyWb8SytEhXbUlp
	LqrTGnFqYe1R9TuI5YVgEUduV3+Sc1HJWLyJl+nHxQf/KOUgu+hEa92D2oeCIfNQ+05WFa
	Qyiqt8sW2PbOlK7jmSUcKJqro7XRU6LH4kKOX6kRw0QVnNjAwX242Y4kwfs/HWwCCYxc8D
	fBT1tLwiZGJtpfhj/SnUF/81fbibzp1GrdzbTKLd13rxYdTq0v38+wT527AXRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734304007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOfEVIxyuzb94jSGu1mkbITIF88QTRaDLmkNO646qMs=;
	b=ROwnjMX9Pjj3paSZUe1UCai39B5ThLmwtZ6/SrGAB75Vpz+807rKiO18QToxYefKGfymJi
	n6YQfDa9AKSAgnAg==
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
Subject: [PATCH v5 04/14] futex: Hash only the address for private futexes.
Date: Mon, 16 Dec 2024 00:00:08 +0100
Message-ID: <20241215230642.104118-5-bigeasy@linutronix.de>
In-Reply-To: <20241215230642.104118-1-bigeasy@linutronix.de>
References: <20241215230642.104118-1-bigeasy@linutronix.de>
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
index b87bd27b73707..583a0149d62c9 100644
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


