Return-Path: <linux-kernel+bounces-311459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C02968985
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C5E1F2303E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01F821C17E;
	Mon,  2 Sep 2024 14:09:48 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA32139A2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286188; cv=none; b=HOwLSZD45Pkg2gNqOqZiCO0s7kXBawReqHr6r3aVx4YVMgebeYprLXDmsgycyrMfZX7iQEDSyKvdL32HqG7uWu4f/1J7iKWb5gn6Btf1fxWHWsTeygWo3mqGRE8pwa4+T9mRWfpRru8RjPGIvFbiekgkClPVst4/B9liBwKOALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286188; c=relaxed/simple;
	bh=vwY9EPrT8amryegjt5G92JC+4cXSQnZdKcMxvJhBW54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akGOXWwdmtvqwnIQ3kKiunA4jAPkLlabb5Osx9BpXyWaaZDM04Qf2oa83FkQzEaz9OGJNbBw24Q7uzpZ2IDorCqVmuRWrFjhgWSQnnrt53rCA4CQPGI/1Edlp/XKTHbkIU1ZBUeddaWhP0eHqL3pz1NbkXj2CIPyksDhXjckaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wy9XS5dBjz1HJ3S;
	Mon,  2 Sep 2024 22:06:16 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C26F140360;
	Mon,  2 Sep 2024 22:09:42 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 22:09:41 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/5] debugobjects: Remove redundant checks in fill_pool()
Date: Mon, 2 Sep 2024 22:05:29 +0800
Message-ID: <20240902140532.2028-3-thunder.leizhen@huawei.com>
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

The conditions for the inner and outer loops are exactly the same, so the
outer 'while' should be changed to 'if'. Then we'll see that the second
condition of the new 'if' is already guaranteed above and can be removed.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/debugobjects.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 1ea8af72849cdb1..aba3e62a4315f51 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -142,8 +142,7 @@ static void fill_pool(void)
 	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
 	 * sections.
 	 */
-	while (READ_ONCE(obj_nr_tofree) &&
-	       READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
+	if (READ_ONCE(obj_nr_tofree)) {
 		raw_spin_lock_irqsave(&pool_lock, flags);
 		/*
 		 * Recheck with the lock held as the worker thread might have
-- 
2.34.1


