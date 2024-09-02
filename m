Return-Path: <linux-kernel+bounces-311455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B49968981
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8660828326A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B342139BF;
	Mon,  2 Sep 2024 14:09:47 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6721019C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286187; cv=none; b=XhuoLCriSGmrLqhaytGVjxz1au889qIoIE50THJGpdtJ4cH49AsJmNpNwTvZx73y+1pMzPrRJ+gg5BOO0p59SgtcG1g9fLSY4BNjc4TVLe+JJb+ZCOv97LTRK+CtkY9mj7LSt1Il6EvPfduvWHicFI3KCD1fa76gMjWmhtXiNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286187; c=relaxed/simple;
	bh=q2fKjLrs2NiGAyevC46WOaaOqsgpMOMmZb36Y7TisgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9T971H5yFIRbyMW0LTJVZBq0dES5u/SF+aAKr107LaZvoC7Zg8ziBDQLJydeEgGOH0ZhHnqhEPi73zptqmAQVLuqPyT7o3CqD8SKLwN7csm8ORJSlSsm13fi7Sv/pe0iG/4xPRKlM30w2JGQqtBMkiIofo5v2XG1XLVWbRvNxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wy9XT4Zmzz1HJ5x;
	Mon,  2 Sep 2024 22:06:17 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 17F3518001B;
	Mon,  2 Sep 2024 22:09:43 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 22:09:42 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 4/5] debugobjects: Use hlist_splice_init() to reduce lock conflicts
Date: Mon, 2 Sep 2024 22:05:31 +0800
Message-ID: <20240902140532.2028-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20240902140532.2028-1-thunder.leizhen@huawei.com>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)

The sub list can be prepared in advance outside the lock, so that the
operation time inside the lock can be reduced and the possibility of
lock conflict can be reduced.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fc8224f9f0eda8f..998724e9dee526b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -167,23 +167,25 @@ static void fill_pool(void)
 		return;
 
 	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
-		struct debug_obj *new[ODEBUG_BATCH_SIZE];
+		HLIST_HEAD(batch_list);
+		struct debug_obj *new, *last;
 		int cnt;
 
 		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
-			if (!new[cnt])
+			new = kmem_cache_zalloc(obj_cache, gfp);
+			if (!new)
 				break;
+			hlist_add_head(&new->node, &batch_list);
+			if (cnt == 0)
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
+		hlist_splice_init(&batch_list, &last->node, &obj_pool);
+		debug_objects_allocated += cnt;
+		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
 }
-- 
2.34.1


