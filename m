Return-Path: <linux-kernel+bounces-204403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A98FE844
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FAD285B60
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC21C19645A;
	Thu,  6 Jun 2024 13:59:04 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D2B03196442
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682344; cv=none; b=SeSTr9MlkBaQqHn5E9k8C1cETfUtRJCXF04z8ZFUiiKHOO6dExn6hkI+HRWIkV34P3icXddUeNLEZsykh38IkNyPhDnEuyhh1rx+JtD3t72kMJy8aw752tIQbh8oFDTmadrmLTFx6deuR91v7xQk7gHB2Sr/2L3RtTezBPye930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682344; c=relaxed/simple;
	bh=oEB3iQ7W0LF4mrGeU/QllrcvNYC47ASB9Gkcuve3NnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diyOjNGiN12MgTY4pgDHNsc4Ef4DkibaXxA+XGLHjxdc9iNrt8/cjDN6asS1r/rej5wvneQXQztpXy8X3OvGAKlsiOVEgOlv12Xp/9Fw5YpCbUpsmooZ0GDsD4vjIsnSkaXcIzCMquXyd6t56SVLq8joPpSSgDCADwAwTxYN+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 231206 invoked by uid 1000); 6 Jun 2024 09:59:01 -0400
Date: Thu, 6 Jun 2024 09:59:01 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: [PATCH 2/2] tools/memory-model: Code reorganization in lock.cat
Message-ID: <6211154e-7db9-4129-b0d4-26ff69e2398c@rowland.harvard.edu>
References: <eb202b3b-7408-4ab9-be82-81ca554b7603@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb202b3b-7408-4ab9-be82-81ca554b7603@rowland.harvard.edu>

Code reorganization for the lock.cat file in tools/memory-model:

Improve the efficiency by ruling out right at the start RU events
(spin_is_locked() calls that return False) inside a critical section
for the same lock.

Improve the organization of the code for handling LF and RU events by
pulling the definitions of the pair-to-relation macro out from two
different complicated compound expressions, using a single standalone
definition instead.

Rewrite the calculations of the rf relation for LF and RU events, for
greater clarity.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

 tools/memory-model/lock.cat |   56 +++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

Index: usb-devel/tools/memory-model/lock.cat
===================================================================
--- usb-devel.orig/tools/memory-model/lock.cat
+++ usb-devel/tools/memory-model/lock.cat
@@ -54,6 +54,12 @@ flag ~empty LKR \ domain(lk-rmw) as unpa
  *)
 empty ([LKW] ; po-loc ; [LKR]) \ (po-loc ; [UL] ; po-loc) as lock-nest
 
+(*
+ * In the same way, spin_is_locked() inside a critical section must always
+ * return True (no RU events can be in a critical section for the same lock).
+ *)
+empty ([LKW] ; po-loc ; [RU]) \ (po-loc ; [UL] ; po-loc) as nested-is-locked
+
 (* The final value of a spinlock should not be tested *)
 flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
 
@@ -79,39 +85,47 @@ empty ([UNMATCHED-LKW] ; loc ; [UNMATCHE
 (* rfi for LF events: link each LKW to the LF events in its critical section *)
 let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
 
-(* rfe for LF events *)
+(* Utility macro to convert a single pair to a single-edge relation *)
+let pair-to-relation p = p ++ 0
+
+(*
+ * If a given LF event e is outside a critical section, it cannot read
+ * internally but it may read from an LKW event in another thread.
+ * Compute the relation containing these possible edges.
+ *)
+let possible-rfe-noncrit-lf e = (LKW * {e}) & loc & ext
+
+(* Compute set of sets of possible rfe edges for LF events *)
 let all-possible-rfe-lf =
 	(*
-	 * Given an LF event r, compute the possible rfe edges for that event
-	 * (all those starting from LKW events in other threads),
-	 * and then convert that relation to a set of single-edge relations.
+	 * Convert the possible-rfe-noncrit-lf relation for e
+	 * to a set of single edges
 	 *)
-	let possible-rfe-lf r =
-		let pair-to-relation p = p ++ 0
-		in map pair-to-relation ((LKW * {r}) & loc & ext)
-	(* Do this for each LF event r that isn't in rfi-lf *)
-	in map possible-rfe-lf (LF \ range(rfi-lf))
+	let set-of-singleton-rfe-lf e =
+			map pair-to-relation (possible-rfe-noncrit-lf e)
+	(* Do this for each LF event e that isn't in rfi-lf *)
+	in map set-of-singleton-rfe-lf (LF \ range(rfi-lf))
 
 (* Generate all rf relations for LF events *)
 with rfe-lf from cross(all-possible-rfe-lf)
 let rf-lf = rfe-lf | rfi-lf
 
 (*
- * RU, i.e., spin_is_locked() returning False, is slightly different.
- * We rely on the memory model to rule out cases where spin_is_locked()
- * within one of the lock's critical sections returns False.
+ * A given RU event e may read internally from the last po-previous UL,
+ * or it may read from a UL event in another thread or the initial write.
+ * Compute the relation containing these possible edges.
  *)
+let possible-rf-ru e = (((UL * {e}) & po-loc) \
+			([UL] ; po-loc ; [UL] ; po-loc)) |
+		(((UL | IW) * {e}) & loc & ext)
 
-(*
- * rf for RU events: an RU may read from an external UL or the initial write,
- * or from the last po-previous UL
- *)
+(* Compute set of sets of possible rf edges for RU events *)
 let all-possible-rf-ru =
-	let possible-rf-ru r =
-		let pair-to-relation p = p ++ 0
-		in map pair-to-relation ((((UL | IW) * {r}) & loc & ext) |
-			(((UL * {r}) & po-loc) \ ([UL] ; po-loc ; [LKW] ; po-loc)))
-	in map possible-rf-ru RU
+	(* Convert the possible-rf-ru relation for e to a set of single edges *)
+	let set-of-singleton-rf-ru e =
+		map pair-to-relation (possible-rf-ru e)
+	(* Do this for each RU event e *)
+	in map set-of-singleton-rf-ru RU
 
 (* Generate all rf relations for RU events *)
 with rf-ru from cross(all-possible-rf-ru)

