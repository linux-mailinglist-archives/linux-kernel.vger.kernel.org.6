Return-Path: <linux-kernel+bounces-399747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8852A9C03B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC25284B11
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B438A1F4721;
	Thu,  7 Nov 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9xvkSfR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KnxUBCaR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64A1F582B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978308; cv=none; b=GlouQnXWgSs3QFktJNOC4mcadSAxzdqA9coJ6KGLZn/lbu2YAO12y2hOAc+sh7btMEl4HRU+XC9xcRVXU9OGPvHpuiFLQOs4JEQEoqeGBkkWhc9uYinrofhOer2vsgg4RMqAaCTfUvl3hkhSE9jaducOHcbZ6OuNgnHZwKOQq78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978308; c=relaxed/simple;
	bh=xXgdPQajIX3QF9Pj+zYTgpnN5VTr6dxFGsnPh/dOmgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIcjj9mcFCSI1A1lxFfSu3dDafg7z+wwDtjbquNDWQbgUBav2ERo0wHhheocJAc3InssPCMn+r8C2/+uwZCiy2KlJNrh2eMeuzrUExV936JGwqUtNxF423uE8Wkj5X9Gm0kHAiQJW+IWulq5gGvhTVJZbMGW8IK98ijarQd+yVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9xvkSfR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KnxUBCaR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730978304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSS1F9zfYFqWED7mnEuItD0xDLRRE+69aaEbBshj25g=;
	b=M9xvkSfRi0mLUpX9TLv4MNv7FmIhnXB2PGcxl8jqrsZiTgmfXRBrLhJpqFMwH7Uch3kAc0
	Zgq5WD3+uqCt0eWW7v/qYhFeIIFg+7gSe1HKqZTPiut9f7Nis8B0xtXwsCcBUfiRJZmYI9
	f4ks6rTTH/lP2QUC1WpSLTqTVjPGBAxeJk77KGrjHjmpZry5sAqKOspHaB85k+uv/YpO3j
	wFY/7jBhLyKRB8MVxFb4SAPQP4KvF4hkpyOem2RkBmMB2phCWxSH06T9nGeKeCpXC9mS0W
	4zW4IJ+UDHlgfIK2+ko98AltF74QmSgKRxPRF4YjOWQ+JWpVccUKawT/MVp8sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730978304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSS1F9zfYFqWED7mnEuItD0xDLRRE+69aaEbBshj25g=;
	b=KnxUBCaRXPrO8SHNZYEuBzqr9XpR/DJfDS0jlMBpakInVwKuNBU6xlNJN/hBffhYxpmnVc
	Lj9nJ2NCMjyOJXDQ==
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
Subject: [PATCH v2 2/3] scftorture: Move memory allocation outside of preempt_disable region.
Date: Thu,  7 Nov 2024 12:13:07 +0100
Message-ID: <20241107111821.3417762-3-bigeasy@linutronix.de>
In-Reply-To: <20241107111821.3417762-1-bigeasy@linutronix.de>
References: <20241107111821.3417762-1-bigeasy@linutronix.de>
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
index 455cbff35a1a2..555b3b10621fe 100644
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


