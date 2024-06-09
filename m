Return-Path: <linux-kernel+bounces-207292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CBE901521
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9D228271C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3437557888;
	Sun,  9 Jun 2024 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="jVC72JU7"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DC4D8BF;
	Sun,  9 Jun 2024 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921693; cv=none; b=qMdcomPV44e4S5nqEwEko0ymf9wOFXSyBV47zUwJ+mr12zgf8p2hJq5ndxTVhAShoN6T/Xf5bz4vGn2SsumUX5y93nxLFVQ4jV6jp071+qMsJmaEWrtJgLHDXGwfqbZIfSa2JdgvznNLpzQyLE6hEe3aIHEeov4dzHb+LcWLU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921693; c=relaxed/simple;
	bh=mQ3EDAVm4CCUHrkqlx/DX6sXVOIvE+vo6Q6lBCjqo4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nG3xiyM5cvaMKuOd427maNAbAtoHljgfHcsfXxt2bBUqbhtcDX0Yjo27u2tq1kY6+bIW7ZFThzmtJxtVvsZgPgOCplVaY7vEli3osjzp74rK08LwxdbF/yk+kZ3EWcUdsUuPIPpdmlgW94rDK4gi5vEbjyElSFIt1I0ZTyhOM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=jVC72JU7; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ygyQ5hnv+3lKS8dtNJ/yFc43Rpbcbrp+lT/TZAkOJVM=;
  b=jVC72JU7hF53dnZUuUMgmhliEsXK3xdP852+pxN3iJY+4py8rdh5w9j1
   KjpVieoTCrs6zpAhqC9mmNZlBo4etvXQdfHTLJsNLO8S6+3q1tZkBXm7f
   R17cewoA53OG2cKOeI3V1wnLEUz5YJbOCrKDi1iFyKuochepa6zjIo4Vo
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,225,1712613600"; 
   d="scan'208";a="169696907"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 10:27:49 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 12/14] workqueue: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun,  9 Jun 2024 10:27:24 +0200
Message-Id: <20240609082726.32742-13-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240609082726.32742-1-Julia.Lawall@inria.fr>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed, it is not necessary to use call_rcu
when the callback only performs kmem_cache_free. Use
kfree_rcu() directly.

The changes were done using the following Coccinelle semantic patch.
This semantic patch is designed to ignore cases where the callback
function is used in another way.

// <smpl>
@r@
expression e;
local idexpression e2;
identifier cb,f;
position p;
@@

(
call_rcu(...,e2)
|
call_rcu(&e->f,cb@p)
)

@r1@
type T;
identifier x,r.cb;
@@

 cb(...) {
(
   kmem_cache_free(...);
|
   T x = ...;
   kmem_cache_free(...,x);
|
   T x;
   x = ...;
   kmem_cache_free(...,x);
)
 }

@s depends on r1@
position p != r.p;
identifier r.cb;
@@

 cb@p

@script:ocaml@
cb << r.cb;
p << s.p;
@@

Printf.eprintf "Other use of %s at %s:%d\n"
   cb (List.hd p).file (List.hd p).line

@depends on r1 && !s@
expression e;
identifier r.cb,f;
position r.p;
@@

- call_rcu(&e->f,cb@p)
+ kfree_rcu(e,f)

@r1a depends on !s@
type T;
identifier x,r.cb;
@@

- cb(...) {
(
-  kmem_cache_free(...);
|
-  T x = ...;
-  kmem_cache_free(...,x);
|
-  T x;
-  x = ...;
-  kmem_cache_free(...,x);
)
- }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

---
 kernel/workqueue.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3fbaecfc88c2..2ec195dcc2bb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5038,12 +5038,6 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 	return NULL;
 }
 
-static void rcu_free_pwq(struct rcu_head *rcu)
-{
-	kmem_cache_free(pwq_cache,
-			container_of(rcu, struct pool_workqueue, rcu));
-}
-
 /*
  * Scheduled on pwq_release_worker by put_pwq() when an unbound pwq hits zero
  * refcnt and needs to be destroyed.
@@ -5089,7 +5083,7 @@ static void pwq_release_workfn(struct kthread_work *work)
 		raw_spin_unlock_irq(&nna->lock);
 	}
 
-	call_rcu(&pwq->rcu, rcu_free_pwq);
+	kfree_rcu(pwq, rcu);
 
 	/*
 	 * If we're the last pwq going away, @wq is already dead and no one


