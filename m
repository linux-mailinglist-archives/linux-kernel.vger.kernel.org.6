Return-Path: <linux-kernel+bounces-311454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE73A968980
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA2C281A03
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610D2139AC;
	Mon,  2 Sep 2024 14:09:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62412139A1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286187; cv=none; b=jVd6KOkDXTAJQt7K8w4wWQWQwVCnCHzogKFFKF/Apv+rTrdUIXf8Km33IZvrXZdCVviotVOYYO4Ec4paOGq7iniqfQL0MSeLuh+gLG6kDI8SfFdc+GxQ7EFFB+hG6r376N2DdwN7vul8JhFNWaU/dJ2REAoSJrfKS1e3Ix7YAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286187; c=relaxed/simple;
	bh=lMwmFHmCi+nOQxA0agkXT33ljy87fXmy942ayPk0K9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNml+1hsmeZNzoSaWaSjIQwT3kdm0W2JSEY/erHjSYBVAbXSFb6ihEvl+BaQnO4mMLKDz9Snc4EhaufXsmxkNy4QXEnLteOUd/oiKnnomts+rCjAulELDRoEsBTZr7priYaP+AZZzl1S2H2yNglAdIYCXThiOa4ZZIkXJfWtM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wy9Yz3FtvzgYqx;
	Mon,  2 Sep 2024 22:07:35 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id C9F7A1400D1;
	Mon,  2 Sep 2024 22:09:41 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 22:09:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/5] debugobjects: Fix the misuse of global variables in fill_pool()
Date: Mon, 2 Sep 2024 22:05:28 +0800
Message-ID: <20240902140532.2028-2-thunder.leizhen@huawei.com>
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

The global variable 'obj_pool_min_free' records the lowest historical
value of the number of nodes in the global list 'obj_pool', instead of
being used as the lowest threshold value. This may be a mistake and
should be replaced with variable 'debug_objects_pool_min_level'.

Fixes: d26bf5056fc0 ("debugobjects: Reduce number of pool_lock acquisitions in fill_pool()")
Fixes: 36c4ead6f6df ("debugobjects: Add global free list and the counter")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7cea91e193a8f04..1ea8af72849cdb1 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -142,13 +142,14 @@ static void fill_pool(void)
 	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
 	 * sections.
 	 */
-	while (READ_ONCE(obj_nr_tofree) && (READ_ONCE(obj_pool_free) < obj_pool_min_free)) {
+	while (READ_ONCE(obj_nr_tofree) &&
+	       READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have
 		 * won the race and freed the global free list already.
 		 */
-		while (obj_nr_tofree && (obj_pool_free < obj_pool_min_free)) {
+		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
 			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
 			hlist_del(&obj->node);
 			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-- 
2.34.1


