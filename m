Return-Path: <linux-kernel+bounces-207290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA4690151D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C671F220B6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D9E54662;
	Sun,  9 Jun 2024 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="bb3XFAHK"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407A4AEEF;
	Sun,  9 Jun 2024 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921692; cv=none; b=KgHh4JOULa6nN9zC4PEpQYlhrxkmDi4Vod9pnQmf31b8kxBlO39ebGJgL0hoD0R1LzFzbb+xNHVuH9BgnD6NVoeQxte3YRb4dLzed7yH5izbh464wMo1RIfi1Wea4d5uFDMvBPCbewHzfZZ8T27rA1274RMM2V87aB/JMFU5nbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921692; c=relaxed/simple;
	bh=GdljLaLr8e2ac9pRTDj/L0VN9xs0OlSFKWDz1A6N+NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lBckZwFHtb14FUDfTizyr9FHmYco6F0MRtfEoVeOMx4gaMlZrvQYEW3GaOzDC9Mxl0MzKD6R1zOI3Bmtl82lpFhjr+2BT4/xN+ql2p/z1MrC3kHK+tNrbzOSAzt2t/uYDXB/ME67Wk04WpXfSLnrVvKIjl6UDyWFMrR71ByuPMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=bb3XFAHK; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a78ss3v9OAJO+CKMzQy2rYpVoY9Q0ZyloAHjx8C4Uac=;
  b=bb3XFAHK0DaOwijmTFrc0riw8PXL4V4YRFwXnaE8buCbFWlGyHgIACL3
   JEQnoTZ16ALbyqH62TEtlLkcP49cjqDZJIt/tbmXgoVOdNucLX/1BEtyU
   CxHi4/QSlmFcsJl+Ke5d6RuugzOyOFyeAWFiSeVJMhZFKbGTMkFPaiQ5L
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,225,1712613600"; 
   d="scan'208";a="169696906"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 10:27:49 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: kernel-janitors@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 11/14] posix-timers: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun,  9 Jun 2024 10:27:23 +0200
Message-Id: <20240609082726.32742-12-Julia.Lawall@inria.fr>
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
 kernel/time/posix-timers.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b924f0f096fa..bad5db979664 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -412,18 +412,11 @@ static struct k_itimer * alloc_posix_timer(void)
 	return tmr;
 }
 
-static void k_itimer_rcu_free(struct rcu_head *head)
-{
-	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
-
-	kmem_cache_free(posix_timers_cache, tmr);
-}
-
 static void posix_timer_free(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->rcu, k_itimer_rcu_free);
+	kfree_rcu(tmr, rcu);
 }
 
 static void posix_timer_unhash_and_free(struct k_itimer *tmr)


