Return-Path: <linux-kernel+bounces-324463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6973974CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751B51F21C63
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A231156962;
	Wed, 11 Sep 2024 08:35:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06213B2A8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043747; cv=none; b=JOrU0Sr77i1Gcj5wFJhH9/f6L1EeqEODgLcEzmKwdfU/4rx9vIwemGnioBuc6xmaejMh2sH7eFVagIg+zK46BHJ/8RpYF25lUXBMhGBAIgNjFCENlBs4pjtIWjdHqlwZAKTBaaLVNwzGh0064zTX97oTdCn+4oE/svDO1D8uwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043747; c=relaxed/simple;
	bh=wB+SnixEt/enl9uuT7ynNFchmAWCrPQWUclb9SOQGfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIzNAGnRFeAvAITqMVjWgoU3iEV7K3MDi7lLnBF6CM5go+WtEBRh6FU4Mg45rXrMBUZjnNWOvKG3ON+itm1HNXia3YQFiE9q3GHg0gRsY+OUmXGOA1zDBwmYlr9Vw2v/S9L6jxJlh5+RMs4myYSlUwV9+oAHdkU4QCqpFt8KZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X3Ylb17GZzyQsJ;
	Wed, 11 Sep 2024 16:34:35 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id E645A180113;
	Wed, 11 Sep 2024 16:35:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 16:35:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 2/3] debugobjects: Use hlist_splice_init() to reduce lock conflicts
Date: Wed, 11 Sep 2024 16:35:20 +0800
Message-ID: <20240911083521.2257-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20240911083521.2257-1-thunder.leizhen@huawei.com>
References: <20240911083521.2257-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)

The newly allocated debug_obj control blocks can be concatenated into a
sub list in advance outside the lock, so that the operation time inside
the lock can be reduced and the possibility of lock conflict can be
reduced.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index df48acc5d4b34fc..19a91c6bc67eb9c 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -161,23 +161,25 @@ static void fill_pool(void)
 		return;
 
 	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
-		struct debug_obj *new[ODEBUG_BATCH_SIZE];
+		struct debug_obj *new, *last = NULL;
+		HLIST_HEAD(freelist);
 		int cnt;
 
 		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
-			if (!new[cnt])
+			new = kmem_cache_zalloc(obj_cache, gfp);
+			if (!new)
 				break;
+			hlist_add_head(&new->node, &freelist);
+			if (!last)
+				last = new;
 		}
 		if (!cnt)
 			return;
 
 		raw_spin_lock_irqsave(&pool_lock, flags);
-		while (cnt) {
-			hlist_add_head(&new[--cnt]->node, &obj_pool);
-			debug_objects_allocated++;
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
+		hlist_splice_init(&freelist, &last->node, &obj_pool);
+		debug_objects_allocated += cnt;
+		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
 }
-- 
2.34.1


