Return-Path: <linux-kernel+bounces-204400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5BF8FE83E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A221C2482D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC010196451;
	Thu,  6 Jun 2024 13:57:58 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A039A195998
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682278; cv=none; b=EhbQ5WiTW4sM+KC+OD7yPBEBCRwDUfuIQwsB+w09UCMTZXLbLbo/cv7wrzq9Yv6WPqVkwmrBstRA+NNuBaDyTdomAGLgEAwgiYy0/tCl0Ct0POyxEn+oz94pmX+JOgV8WW57XJmxv7K/klysNm8yeABY+QobamlEBJLicrYkB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682278; c=relaxed/simple;
	bh=b/IaQER0MTYnAfXxKI9/hVZr+pfP+z0ECFHNGnD9BGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eu48lSEEgLGopAO+oBxhtwvRw9+3fb4xgCChhL5TnQjiwceg1lBSqJxhTSrhFZa7kJaF8LamEEIpKynnc0zQO5p2Gx0qOrqHWVPaMk0EKpm9YuDVNDQXc67donDPE8S+ibsLwBiz2Ar/LoDe2fj4nWoFq2vcMpSCC9eQW2HFfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 231164 invoked by uid 1000); 6 Jun 2024 09:57:55 -0400
Date: Thu, 6 Jun 2024 09:57:55 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: [PATCH 1/2] tools/memory-model: Fix bug in lock.cat
Message-ID: <eb202b3b-7408-4ab9-be82-81ca554b7603@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andrea reported that the following innocuous litmus test:

C T

{}

P0(spinlock_t *x)
{
	int r0;

	spin_lock(x);
	spin_unlock(x);
	r0 = spin_is_locked(x);
}

gives rise to a nonsensical empty result with no executions:

$ herd7 -conf linux-kernel.cfg T.litmus
Test T Required
States 0
Ok
Witnesses
Positive: 0 Negative: 0
Condition forall (true)
Observation T Never 0 0
Time T 0.00
Hash=6fa204e139ddddf2cb6fa963bad117c0

The problem is caused by a bug in the lock.cat part of the LKMM.  Its
computation of the rf relation for RU (read-unlocked) events is
faulty; it implicitly assumes that every RU event must read from
either a UL (unlock) event in another thread or from the lock's
initial state.  Neither is true in the litmus test above, so the
computation yields no possible executions.

The lock.cat code tries to make up for this deficiency by allowing RU
events outside of critical sections to read from the last po-previous
UL event.  But it does this incorrectly, trying to keep these rfi links
separate from the rfe links that might also be needed, and passing only
the latter to herd7's cross() macro.

The problem is fixed by merging the two sets of possible rf links for
RU events and using them all in the call to cross().

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andrea Parri <parri.andrea@gmail.com>
Closes: https://lore.kernel.org/linux-arch/ZlC0IkzpQdeGj+a3@andrea/
Fixes: 15553dcbca06 ("tools/memory-model: Add model support for spin_is_locked()")
CC: <stable@vger.kernel.org>

---

 tools/memory-model/lock.cat |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: usb-devel/tools/memory-model/lock.cat
===================================================================
--- usb-devel.orig/tools/memory-model/lock.cat
+++ usb-devel/tools/memory-model/lock.cat
@@ -102,19 +102,19 @@ let rf-lf = rfe-lf | rfi-lf
  * within one of the lock's critical sections returns False.
  *)
 
-(* rfi for RU events: an RU may read from the last po-previous UL *)
-let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
-
-(* rfe for RU events: an RU may read from an external UL or the initial write *)
-let all-possible-rfe-ru =
-	let possible-rfe-ru r =
+(*
+ * rf for RU events: an RU may read from an external UL or the initial write,
+ * or from the last po-previous UL
+ *)
+let all-possible-rf-ru =
+	let possible-rf-ru r =
 		let pair-to-relation p = p ++ 0
-		in map pair-to-relation (((UL | IW) * {r}) & loc & ext)
-	in map possible-rfe-ru RU
+		in map pair-to-relation ((((UL | IW) * {r}) & loc & ext) |
+			(((UL * {r}) & po-loc) \ ([UL] ; po-loc ; [LKW] ; po-loc)))
+	in map possible-rf-ru RU
 
 (* Generate all rf relations for RU events *)
-with rfe-ru from cross(all-possible-rfe-ru)
-let rf-ru = rfe-ru | rfi-ru
+with rf-ru from cross(all-possible-rf-ru)
 
 (* Final rf relation *)
 let rf = rf | rf-lf | rf-ru


