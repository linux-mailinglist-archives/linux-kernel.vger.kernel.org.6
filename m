Return-Path: <linux-kernel+bounces-401476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2209C1AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA757B243A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3A1E3DE4;
	Fri,  8 Nov 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kM8bbPnu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rKChvvll"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0B1E2600
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062547; cv=none; b=dAe7XcrkEZJIfcuu8mPZaRzLU+Dae7KCHFKDcM/AcEV9+Y6AJexJs7962NH+cCw/nJEhpadpV9XdBqdQ1wQSPPDgXgaHdc87fsFY9qJ17UoGgfLNBZ0PTHQBI7YW6KH8hqUGaEtvGVNGDHGjy1eZLz45t7rZq8Re7lD30DRhxRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062547; c=relaxed/simple;
	bh=ug0G8pZx8Oc0rUK6VfL9LeNKmZ3uj6cetPA4cXxckek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmtzVUsJ7U+NPMbC2XiEa0spyu2aTTMtmv/PHu9Y9oDXn3vTXQ9SEs9jX1TCWNEbeZ/SuwgROjq1klpJIfOKThFRMF2bwTL50yHeWEVNslFK+LuN5uUzed8oY/M01wC5GZ2Uv9cCKlE85uMQ6sIaohx5asoCnqBL0c6ULeJ+Kic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kM8bbPnu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rKChvvll; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731062544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPuXJvFylkEjsJn/hxrBzgh+RNHJWlCC5YCBuHj3y5U=;
	b=kM8bbPnufm7rZrkKjsXsZE0yKOyGiuiZ4C+yL7LJ1yWKIx/YdkQSuDCmdjbRW91ME5CD2H
	fxcdcTsdEcgRz8DSUt38kG0VDpFFk/lHtAPUuDaksn06IPihgPwwagqZoJbkOiE7/qZNlv
	QffE6A6AT3LOAopHbq/1AtNJtu8TPDq0S9YXx+kZkMp5YC32qqsZcwfWpnquL4DqAcrv2c
	7WD46sCmUYEHSl6kLqHi0nmn1NziAglMGNNeP12h04KFRWebfze3o5Q9/NqiEK2xAo3FxD
	sh5uLzu6YHSGCmw7H4+NfxOj2xvGM61PZFBo7HI+AAri+19EPVhNGQVSYsS9+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731062544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPuXJvFylkEjsJn/hxrBzgh+RNHJWlCC5YCBuHj3y5U=;
	b=rKChvvllSS+AA7SRc/2g+HuioD3b44nZ0BQwWt2Y6+ZFARiyQ7h1vvWHdDrsJ8n195Ta10
	V18leTB7Ofvpa6CA==
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
Subject: [PATCH v3 3/4] scftorture: Move memory allocation outside of preempt_disable region.
Date: Fri,  8 Nov 2024 11:39:33 +0100
Message-ID: <20241108104217.3759904-4-bigeasy@linutronix.de>
In-Reply-To: <20241108104217.3759904-1-bigeasy@linutronix.de>
References: <20241108104217.3759904-1-bigeasy@linutronix.de>
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

Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/scftorture.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 654702f75c54b..e3c60f6dd5477 100644
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


