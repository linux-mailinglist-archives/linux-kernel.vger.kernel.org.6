Return-Path: <linux-kernel+bounces-399748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2588B9C03B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBE2284B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19611F5851;
	Thu,  7 Nov 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wtsNZeNO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="94PFRSzp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5781F4298
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978308; cv=none; b=NynQsXpez03+VcbEP5YSulTxngmXi5ZT4NjVbhzrPTxnTUeAS8QxtPxlNzUex9g+C7276NTegaAFVjQgVb/Ss75kQQpUV099j/wv6DApvTmj80bhKQL3qRddSYsbhR/6DzCg+eeE5KDUTTsYa6WVY2spOE9PDTMJvEkrRZhEQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978308; c=relaxed/simple;
	bh=n/wesm0uKO7AlZ/J2WWe+dCoVouDNP5+tIlmkRDg3qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvuMJZyVjPg10zDFpVr3ROM78lSXfwZ6zNRcENRYxCouxszc0on+MIZCjyR6mNIcts66jvJwHKaOMg7ywrxHN2KQoaI2N/2s/K/FhnWqSFMV+/xiyXvN2CkO5EzZ6WQJ7IbcDVqQYEI0Y9JL7PgRNqWgZfmvdhU28T5xQEM/ZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wtsNZeNO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=94PFRSzp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730978304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlnDNt/q+P1z8kgLF+N992bHvMJ9T7IfJZldadLin68=;
	b=wtsNZeNOyMJaldtbOFaqNx8Fida5NHgixfmht+XXgQL0xo2mc7k4R5BDokhZGEAAf8puhY
	RdaNsQqt5gLo9RzhmXtjmMEXAPSzEDrdEM428J0L8X8bgAKSqxHlUZmercMPgiaI4clbkB
	ovMAgCRyrdKw8bOWUgivcosNYwZGearQAPTjk3OWJxxP/+/QluQm+XzyzydmSOR1TurxAw
	1VcmIe6jEMY5XIEv8bkhXi30L0O0zucKKTJ/kmEtxzTugkWiTe09cQe2z1SvGwVM/L0Uyt
	IymvOb70uBfkVjuv82GnKmMyUulUqf+9FRNZl+3BDNeakG35dM8WrAZv2JZZ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730978304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlnDNt/q+P1z8kgLF+N992bHvMJ9T7IfJZldadLin68=;
	b=94PFRSzpi6CjV9+fwfoYfFcVVSDiklFOujZck6z98CsK6lfD6ykQFvnYpIGnoHzKMnEoru
	u2W1K7fZOV3JHVAA==
To: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	akpm@linux-foundation.org,
	cl@linux.com,
	iamjoonsoo.kim@lge.com,
	longman@redhat.com,
	penberg@kernel.org,
	rientjes@google.com,
	sfr@canb.auug.org.au,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/3] scftorture: Avoid additional div operation.
Date: Thu,  7 Nov 2024 12:13:06 +0100
Message-ID: <20241107111821.3417762-2-bigeasy@linutronix.de>
In-Reply-To: <20241107111821.3417762-1-bigeasy@linutronix.de>
References: <20241107111821.3417762-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Replace "scfp->cpu % nr_cpu_ids" with "cpu". This has been computed
earlier.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 44e83a6462647..455cbff35a1a2 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -463,7 +463,7 @@ static int scftorture_invoker(void *arg)
=20
 	// Make sure that the CPU is affinitized appropriately during testing.
 	curcpu =3D raw_smp_processor_id();
-	WARN_ONCE(curcpu !=3D scfp->cpu % nr_cpu_ids,
+	WARN_ONCE(curcpu !=3D cpu,
 		  "%s: Wanted CPU %d, running on %d, nr_cpu_ids =3D %d\n",
 		  __func__, scfp->cpu, curcpu, nr_cpu_ids);
=20
--=20
2.45.2


