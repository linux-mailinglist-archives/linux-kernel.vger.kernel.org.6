Return-Path: <linux-kernel+bounces-394597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4883D9BB1A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7852B1C21BC4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8051BC065;
	Mon,  4 Nov 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bqSJbLly";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m8UVPQXo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB221B983E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717467; cv=none; b=MTtLZKlSv3FA5KgPvL2c5C6iPyswbF3sXalW7WXZQHVSRlC4i0b8+QDeqMuQFeiLUVrQzm5+6ec2mkiIBCfSIJhWC3TNqMoCuSP3OeJeVAwNnXUFv+GMxkMPxBBg4WiIDIAhsZ4xOdOOEnnYcb2vDAphY5maMRhPzFh1MngePAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717467; c=relaxed/simple;
	bh=t8K2Mf4ZhccTRjIZrJM99GohTdzBGrcI3+qCAdwbr+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q94Mg8oksrrDbIG5fdyVj2u/mepIc9eVqdRZQ/Pk1QiBtlLBgzEtOEAiNpzUGoaBgnL5JvzKeUxYNIBVtv+IXOZaFNj/DIoMZiFBXilObE7lVcpQpMsrQvlmYWaEGcKKDFfh2XytY5Emg3cO6OUIwbbkR/KG0hNettjHmnnBshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bqSJbLly; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m8UVPQXo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730717463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktKI//sMmnnCjs54hJYaz5s5ts5YF9AmvSNM3G4N7f4=;
	b=bqSJbLlylEQ2AcG6qDh3kEVWTHGus5P6fdfo3Jrlw4xmNNbnm4xzJICwI8aKw9mgkdy6eC
	PNT4RHu3ve/GNLutCIO+wHuBdEdnSPgb9t4YGWxXb4IKEhiLRtTxDI5AkPiyx6u7tYJs5J
	Amya4bviFotCVNltb4rQE9pfPy+NHyLzDM0ecLR2KmJEleJklq2Y4rqN8efsC4peNZrswZ
	OA3104g/Z6icuUhCawFpcORc0JBCH1Z8qsqCRzkjzprpzvv+oARYJ8TKPR9Zm/DLHRnFpJ
	VImRB7WxDIIv+zrNOUKnzVdnoPZnquOcihv0hevTweB8DcpiYOMFKtGMBZtorw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730717463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktKI//sMmnnCjs54hJYaz5s5ts5YF9AmvSNM3G4N7f4=;
	b=m8UVPQXoc+16YCShWzyN8Fe07NpM+kXCd6OWtfkqM2d5/axty9p0fFzsP0yXXHo85GL0i3
	R4jFWGF7jhrPunAw==
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	sfr@canb.auug.org.au,
	longman@redhat.com,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	Tomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] scftorture: Move memory allocation outside of preempt_disable region.
Date: Mon,  4 Nov 2024 11:50:52 +0100
Message-ID: <20241104105053.2182833-1-bigeasy@linutronix.de>
In-Reply-To: <88694240-1eea-4f4c-bb7b-80de25f252e7@paulmck-laptop>
References: <88694240-1eea-4f4c-bb7b-80de25f252e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Memory allocations can not happen within regions with explicit disabled
preemption PREEMPT_RT. The problem is that the locking structures
underneath are sleeping locks.

Move the memory allocation outside of the preempt-disabled section. Keep
the GFP_ATOMIC for the allocation to behave like a "ememergncy
allocation".

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/scftorture.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 44e83a6462647..e5546fe256329 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -320,10 +320,6 @@ static void scftorture_invoke_one(struct scf_statistic=
s *scfp, struct torture_ra
 	struct scf_check *scfcp =3D NULL;
 	struct scf_selector *scfsp =3D scf_sel_rand(trsp);
=20
-	if (use_cpus_read_lock)
-		cpus_read_lock();
-	else
-		preempt_disable();
 	if (scfsp->scfs_prim =3D=3D SCF_PRIM_SINGLE || scfsp->scfs_wait) {
 		scfcp =3D kmalloc(sizeof(*scfcp), GFP_ATOMIC);
 		if (!scfcp) {
@@ -337,6 +333,10 @@ static void scftorture_invoke_one(struct scf_statistic=
s *scfp, struct torture_ra
 			scfcp->scfc_rpc =3D false;
 		}
 	}
+	if (use_cpus_read_lock)
+		cpus_read_lock();
+	else
+		preempt_disable();
 	switch (scfsp->scfs_prim) {
 	case SCF_PRIM_RESCHED:
 		if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST)) {
--=20
2.45.2


