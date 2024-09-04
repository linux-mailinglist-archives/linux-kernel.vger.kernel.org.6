Return-Path: <linux-kernel+bounces-315176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DFE96BED6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9985A1F25B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29B1DB957;
	Wed,  4 Sep 2024 13:41:38 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BB185948
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457298; cv=none; b=jwKoyQsrqlOwqLZl2cOJ0102y59U99d4sFmMV9eSFE5B/THJWkAMOw3FF/J3L1Mvr+E0JnPJ8x+vq8RcRLV5iLiAQTPgO2B/tGa9ggMwPJl5ATSG83AR8NRpSFcZKbX/3AlTGX/25o2t+J+u7CDz8Rs8NxvDxsCHQN+V2kaoTtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457298; c=relaxed/simple;
	bh=LMnM+5IgCL22RvYQlX96uBFPVCZCm7KQizyhj1G3SoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cU7U89dvH3X4PiY1hrqHVg1arr6anHPsTzaeo2mwtat3w+hTOhrSTDlKao3OGE7rOp8xObm6lBQ59FR1Uu4LQHShbUzw4ydEESxGPJkoheUFnblBaraT6Dj9dF68PBWEN1zhy7GB1xWdvXdQ9vJRltFMQ0U0H4KkVUaf2JJKF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WzNnG4Z1nz69Mk;
	Wed,  4 Sep 2024 21:36:34 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 48B1418024B;
	Wed,  4 Sep 2024 21:41:32 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:41:31 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 4/6] debugobjects: Don't start fill if there are remaining nodes locally
Date: Wed, 4 Sep 2024 21:39:42 +0800
Message-ID: <20240904133944.2124-5-thunder.leizhen@huawei.com>
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

If the conditions for starting fill are met, it means that all cores that
call fill() later are blocked until the first core completes the fill
operation. But obviously, for a core that has free nodes locally, it does
not need to be blocked(see below for why). This is good in stress
situations.

1. In the case of no nesting, a core uses only one node at a time. As long
   as there is a local node, there is no need to use the free node in
   obj_pool.
2. In the case of nesting depth is one, nodes in obj_pool need to be used
   only when there is only one local node.
   #define ODEBUG_POOL_PERCPU_SIZE      64
   #define ODEBUG_BATCH_SIZE            16
   Assume that when nested, the probability of percpu_obj_pool having each
   number of nodes is the same. The probability of only one node is less
   than 1/17=6%. Assuming the probability of nesting is 5%, that's a
   pretty high estimate. Then the probability of using obj_pool is
   6% * 5% = 0.3%. In other words, a 333-core environment produces only
   one core to compete for obj_pool.
   #define ODEBUG_POOL_MIN_LEVEL        256
   #define ODEBUG_BATCH_SIZE            16
   But we can tolerate "256 / (16 + 1)" = 15 cores competing at the same
   time.
3. In the case of nesting depth more than one, the probability is lower
   and negligible.
   Nesting Depth=2: "2/17 * 5% * 5%" = 0.03%
   Nesting Depth=3: "3/17 * 5% * 5% * 5%" = 0.002%

However, to ensure sufficient reliability, obj_pool is not filled only
when there are more than two local nodes, reduce the probability of
problems to the impossible.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7a8ccc94cb037ba..4f64b5d4329c27d 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -131,6 +131,16 @@ static void fill_pool(void)
 	struct debug_obj *obj;
 	unsigned long flags;
 
+	/*
+	 * The upper-layer function uses only one node at a time. If there are
+	 * more than two local nodes, it means that even if nesting occurs, it
+	 * doesn't matter. The probability of nesting depth >= 2 is extremely
+	 * low, and the number of global free nodes guarded by
+	 * debug_objects_pool_min_level is adequate.
+	 */
+	if (likely(obj_cache) && this_cpu_read(percpu_obj_pool.obj_free) >= 2)
+		return;
+
 	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
 		return;
 
-- 
2.34.1


