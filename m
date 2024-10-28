Return-Path: <linux-kernel+bounces-384288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951169B28EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C726B1C214F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99FA1DDC18;
	Mon, 28 Oct 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qYnvkr1r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KudblmCy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7151DB360
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100749; cv=none; b=f1bB+RwCIRueY1h8mKgqxoC5LgrAJB+Om1v9EvUnolaY2NxqTy/x4egs0awUMqyJJp0ZvioKzrIWuXpw/pdpKLK2xL7KpG9PV2gfQxgoPsU3518OGRca0hKO3739JuJIm8NtDC+4YGg8eJ04CP/+hL9FW3S0DfgBF/sJuXs6nwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100749; c=relaxed/simple;
	bh=fferLxSF64tTCJV6ylfzClO0kBRcFPkVfO/chNQdXHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THS+0W29mkMDot2HGwI65iZY1C/Aag7K+AW2yZxH+Gt5ZP+kxCXVJ3t/WQSseYsmpZbYooOP+dBslL9byxaoCpH7IGqB9Qbxz8hwFkdl9KG+4VsPlAph+b5ICytn/+Jal8Pc/YH0YISeaFZ3CLN/WtoX5otaLhZ1TG6hthx2wxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qYnvkr1r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KudblmCy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+awgZ1IkZBVUFUbAPP/P6eD+NItkoQ24Ixi+M66CZuc=;
	b=qYnvkr1rYnUBHWMpHPWXTW9hEB/cD/ZySOnMdE2mU+k/F5OnYacKQV/vbyXzbmKRo8C92m
	E9oHn+t9kpRSKIM/U1HF6IL64BNLa9WGQcTE7ttpZ5Bj+tnmj4IJWY48V3ca/UdBUEZ/Ib
	PW+KAQ1klKP1jlyDQuDGuE20B9PQy4jt8NptDiwqqQWqcZTGZmrEjYlFWrVQsxOvgoNGEw
	sOZNCEA1FZfZxkjaZyVYLrj3uc6oTF6HyFrG7NYwE4Tv+5BY5zsmeqtmuBNq0ec7CkxL/7
	XVxZwDBtJbQ1SFxR7T4PQxA2vsuvKZHKeXTjak7aSFGE4LydeYJhPFMWFMqIQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+awgZ1IkZBVUFUbAPP/P6eD+NItkoQ24Ixi+M66CZuc=;
	b=KudblmCynY90OV3IuCXaA3UzSmIxfqE/dLU3j/V2x4AYB1Cbsag3n6z7GOzIqEkVwHBS59
	+6WT98NOqR+4kbAw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 25/31] block, bfq: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:58 +0100
Message-Id: <5f34af8523a77a9f308ba90790ba4e5518f78695.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/bfq-iosched.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0747d9d0e48c..7ce1ab0b65b4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -7294,9 +7294,8 @@ static int bfq_init_queue(struct request_queue *q, st=
ruct elevator_type *e)
=20
 	INIT_LIST_HEAD(&bfqd->dispatch);
=20
-	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	bfqd->idle_slice_timer.function =3D bfq_idle_slice_timer;
+	hrtimer_setup(&bfqd->idle_slice_timer, bfq_idle_slice_timer, CLOCK_MONOTO=
NIC,
+		      HRTIMER_MODE_REL);
=20
 	bfqd->queue_weights_tree =3D RB_ROOT_CACHED;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
--=20
2.39.5


