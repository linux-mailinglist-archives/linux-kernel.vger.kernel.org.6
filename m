Return-Path: <linux-kernel+bounces-324462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21524974CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DE51F21C63
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA2A1552F6;
	Wed, 11 Sep 2024 08:35:47 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81414386C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043747; cv=none; b=O5m39vyhbIQxF22tdpl/p0NzPk37mAYoRWgQ5GfD7uN9CDOIytqScCsSqCkCa7/SdEEseVlVOVfRsoJVRWL3MWUQc5q9ZQd0M3UmwGbwW2Ggz6oeNGZkSVvJTGzpWBoDn4d4aOO3m4ESDTILfSYuIARlV2b74JKjvJlZu3mc5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043747; c=relaxed/simple;
	bh=0iIOk45VJROiy8gf7E83iZ6tIJSp58nuV/qYXDLRkTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocVPWFemXzQFeEVoaVI8DiA6sbbSOedjJpx/QolfZqR7LQHdA39B4HAhC4bwxecPCreyc+2EzbA/G6PQbg4MgrbmKdVe28T0PfCUCnkyYRI4YGv3fZyRNSlcMdykDpcWO3vaZ70ruLPYsnE/P5IPGtJYXI23+mB7Y7UoBf0ZHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X3Yhk2vwNz1HJXs;
	Wed, 11 Sep 2024 16:32:06 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 765E41402E2;
	Wed, 11 Sep 2024 16:35:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 16:35:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 1/3] debugobjects: Delete a piece of redundant code
Date: Wed, 11 Sep 2024 16:35:19 +0800
Message-ID: <20240911083521.2257-2-thunder.leizhen@huawei.com>
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

The statically allocated objects are all located in obj_static_pool[],
the whole memory of obj_static_pool[] will be reclaimed later. Therefore,
there is no need to split the remaining statically nodes in list obj_pool
into isolated ones, no one will use them anymore. Just write
INIT_HLIST_HEAD(&obj_pool) is enough. Since hlist_move_list() directly
discards the old list, even this can be omitted.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 5ce473ad499bad3..df48acc5d4b34fc 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1325,10 +1325,10 @@ static int __init debug_objects_replace_static_objects(void)
 	 * active object references.
 	 */
 
-	/* Remove the statically allocated objects from the pool */
-	hlist_for_each_entry_safe(obj, tmp, &obj_pool, node)
-		hlist_del(&obj->node);
-	/* Move the allocated objects to the pool */
+	/*
+	 * Replace the statically allocated objects list with the allocated
+	 * objects list.
+	 */
 	hlist_move_list(&objects, &obj_pool);
 
 	/* Replace the active object references */
-- 
2.34.1


