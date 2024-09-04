Return-Path: <linux-kernel+bounces-315174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DEE96BED5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854B21F255F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A221DB53C;
	Wed,  4 Sep 2024 13:41:37 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663411D9D96
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457297; cv=none; b=aZHsJyb13TjLdjWtRTQzt04jeOSHCqSyH0y2w5czaDbLx1yP8fSBCG9Lcqr0MxoFUikfamOk27IKR1vc52Bc23YEVAPurgUAWTPsYrVa/cdNQ+0qgzQqMk+zu1rltauaNZ+nbGbrOBn87A4pwQCnFprOk5ajIHEV9vlERV9Uiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457297; c=relaxed/simple;
	bh=4of56Nx30EiO+1gvFAy8PDdS0NIkA3vPkyzmyPdX9uU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEZ2fpdtSNNM1x43s70xs/JtoEBZMnf/cpQPHFK9sbez38f2+HGyD2jWea3uBvjUR8BC8gTdSkutSOrnWUN2rzu9VGzLtJQeJc/hmv3mGhy+dlpejW/Y8dnV7bjejytpC70tyK6xGQ1j5XrOZKJZwPUVvFYz/rSgH4i2U+1CVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WzNsv48JSz13vb2;
	Wed,  4 Sep 2024 21:40:35 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 2599018005F;
	Wed,  4 Sep 2024 21:41:33 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:41:32 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 6/6] debugobjects: Delete a piece of redundant code
Date: Wed, 4 Sep 2024 21:39:44 +0800
Message-ID: <20240904133944.2124-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20240904133944.2124-1-thunder.leizhen@huawei.com>
References: <20240904133944.2124-1-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100006.china.huawei.com (7.185.36.228)

The statically allocated objects are all located in obj_static_pool[],
the whole memory of obj_static_pool[] will be reclaimed later. Therefore,
there is no need to split the remaining statically nodes in list obj_pool
into isolated ones, no one will use them anymore. Just write
INIT_HLIST_HEAD(&obj_pool) is enough. Since hlist_move_list() directly
discards the old list, even this can be omitted.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 9876e7ad5291492..65ecc611ac24720 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1337,10 +1337,7 @@ static int __init debug_objects_replace_static_objects(void)
 	 * active object references.
 	 */
 
-	/* Remove the statically allocated objects from the pool */
-	hlist_for_each_entry_safe(obj, tmp, &obj_pool, node)
-		hlist_del(&obj->node);
-	/* Move the allocated objects to the pool */
+	/* Replace the statically allocated objects list with the allocated objects list */
 	hlist_move_list(&objects, &obj_pool);
 
 	/* Replace the active object references */
-- 
2.34.1


