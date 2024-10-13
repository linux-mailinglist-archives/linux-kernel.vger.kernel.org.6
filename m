Return-Path: <linux-kernel+bounces-362943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053399BB8E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C910D281874
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5161A0724;
	Sun, 13 Oct 2024 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="rGWrqf3E"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202E19CC0C;
	Sun, 13 Oct 2024 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728850701; cv=none; b=HDpIT6GWUDVr9K5aCSL/71eYoU8omsG4nuDMDN+OXI8pDA7VPOaS7px4lmI74eLbk4Kquqj2byVBKq5VI/Us09nyR+UBJ35q+7PYtMswpHOa7SaaTv2PFmrSi8qvzdgVTXMTc5E1XMhHIxw2wmw06wXGTgTAva0lTACBHjekh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728850701; c=relaxed/simple;
	bh=6An9S/siRwhmwbVluykurPo61eOfwueY+HGkOHjY1vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7fEgNmF+BE6owYtVpMJze/wmjHcCh/Yyrzn9fx8bmG/3yp+0uS59gyhBVvpZ5F8ajxHXIffP3U8Whpm9azSRUEKUAerPSWfWXs0b+hl6ZLSatzGvj6zEpZdbPYHn53ePaq4heVgXGHpp4VYnnv7CUxsyhflbksypTd9TSPpyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=rGWrqf3E; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OElZQM5ftpXkAIYEg2wSpmlZ5mutMZsH6O0UVGuE2vs=;
  b=rGWrqf3Eov7b0YX3dQVIH+apVQTU9kg2boAPqm1vZtKEw4SiUB5uOjXf
   PJMAHkry97LZ4JVAJCrfUg/J7OqSrn/46sKUPmW/xwNcrJA2krA/uKO5k
   FP+btH/Xoq4T2lNZyGds0nXbdPTK8auMGyZtlHWHe+wNLh7TsGpNLBpw0
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400"; 
   d="scan'208";a="98968286"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:18:00 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] posix-timers: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:58 +0200
Message-Id: <20241013201704.49576-12-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 kernel/time/posix-timers.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 4576aaed13b2..fc40dacabe78 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -413,18 +413,11 @@ static struct k_itimer * alloc_posix_timer(void)
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


