Return-Path: <linux-kernel+bounces-291557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E873195640F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74DA6B20813
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC9B155A59;
	Mon, 19 Aug 2024 07:02:13 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E53B1B960
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050932; cv=none; b=gi7A7xq3DpQsmwW1sNy5b8H/RhQFvl6g80C/xgbW2ScNr4TbrhFs4Y/8CYj65d7Mqg7J6uBIPue4vIR6fL0Pa7tRd6kIIK4C0KtT9aXCNWFdlSAgIRLnvgvyGJMO8PWKSSlgM7RGvUCM6DrfoF0Tr+/3f/DCuOSX6s4412kA2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050932; c=relaxed/simple;
	bh=j3CDlAzuwqAGcjLC0B83z0v7NIFNOYMwsYt6N/sA4FY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AW3+RLSs2l6L173AfDz2LcCS6vfWkengC90TuyUer5+bT6J5hP4OdpcM/F2nAsdJobPiJWdvi1tdZjarpYJtDih+yiqLSBfmw0WViGWKdder0iUItYULV90P4ZcL3tNG8pQxt78cJSx520uYVsmHriyeqaVSgd5qPCz+vswPdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnNlB05f3zfbYH;
	Mon, 19 Aug 2024 15:00:06 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (unknown [7.185.36.59])
	by mail.maildlp.com (Postfix) with ESMTPS id 8ADFC1400CD;
	Mon, 19 Aug 2024 15:02:05 +0800 (CST)
Received: from huawei.com (10.175.112.125) by dggpeml500005.china.huawei.com
 (7.185.36.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 15:02:04 +0800
From: Yongqiang Liu <liuyongqiang13@huawei.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <zhangxiaoxu5@huawei.com>, <cl@linux.com>,
	<wangkefeng.wang@huawei.com>, <penberg@kernel.org>, <rientjes@google.com>,
	<iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>, <vbabka@suse.cz>,
	<roman.gushchin@linux.dev>, <42.hyeyoo@gmail.com>
Subject: [PATCH] mm, slub: prefetch freelist in ___slab_alloc()
Date: Mon, 19 Aug 2024 15:02:04 +0800
Message-ID: <20240819070204.753179-1-liuyongqiang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500005.china.huawei.com (7.185.36.59)

commit 0ad9500e16fe ("slub: prefetch next freelist pointer in
slab_alloc()") introduced prefetch_freepointer() for fastpath
allocation. Use it at the freelist firt load could have a bit
improvement in some workloads. Here is hackbench results at
arm64 machine(about 3.8%):

Before:
  average time cost of 'hackbench -g 100 -l 1000': 17.068

Afther:
  average time cost of 'hackbench -g 100 -l 1000': 16.416

There is also having about 5% improvement at x86_64 machine
for hackbench.

Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
---
 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index c9d8a2497fd6..f9daaff10c6a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3630,6 +3630,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	VM_BUG_ON(!c->slab->frozen);
 	c->freelist = get_freepointer(s, freelist);
 	c->tid = next_tid(c->tid);
+	prefetch_freepointer(s, c->freelist);
 	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 	return freelist;
 
-- 
2.25.1


