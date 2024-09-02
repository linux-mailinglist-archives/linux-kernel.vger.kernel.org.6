Return-Path: <linux-kernel+bounces-311457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4AA968983
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE1A282C81
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EFE21C177;
	Mon,  2 Sep 2024 14:09:48 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C3183CDC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286188; cv=none; b=WAv586DYKQ1uKEtdU5Asgr9W/Mva9yrzE+z71hpgGwoCCJgQOVEZfMigdasGt2krTkUw38mtG3THorcUh/qpgzPTLW8ftJaVLHPHMGHmcjPuVC0SF6nvPBhp99hoK/i6nFu5Lj9hGuweA+eOVYpGxFRsxvM8Sg7yZtO66kMa0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286188; c=relaxed/simple;
	bh=wRFqaBMJzjtMKwr/05ElStcIe5hf+gW4WrjXMBA5jHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3SafJWdLQxFaOVgJahy4u8BR20X/WCOi91TwMqBeEHaTyKY1NAYgxW0qncTu9ouqgtGTdqW6xVrzT4RhoTjXqMuPezY+N9RLx3A+/FhCBo9wBluRasz83xdUnCpg4LCVFeAsz+00YKwXkicxTo3p8yfY3Oms6vyY6W8QIZ7qV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wy9ZK4g7lzpV2n;
	Mon,  2 Sep 2024 22:07:53 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B735140121;
	Mon,  2 Sep 2024 22:09:43 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 22:09:43 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 5/5] debugobjects: Delete a piece of redundant code
Date: Mon, 2 Sep 2024 22:05:32 +0800
Message-ID: <20240902140532.2028-6-thunder.leizhen@huawei.com>
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

The statically allocated objects are all located in obj_static_pool[],
no one will use them anymore, the whole memory of obj_static_pool[] will
be reclaimed later. Therefore, there is no need to split the remaining
statically nodes in list obj_pool into isolated ones. Just write
INIT_HLIST_HEAD(&obj_pool) is enough. Since hlist_move_list() directly
discards the old list, even this can be omitted.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 998724e9dee526b..d3845705db955fa 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1333,10 +1333,7 @@ static int __init debug_objects_replace_static_objects(void)
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


