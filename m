Return-Path: <linux-kernel+bounces-177156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0F78C3ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9DC28150B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1444146A6F;
	Mon, 13 May 2024 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="unmtCXjI"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992BA14601E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715576928; cv=none; b=gp8Fzj3a4eDr26ZQAPAiUw4eTXQV4w1lokd7eJH1tOqAsFKTD08132WuZGwGFzomGZf3oxfErGjmuhJR5tO2lmnZGZIV8sUiOXrnFYUWF6Xbb88E192iz0BodLbQo/dRlwXQ9s3bLzrjhCf84xJqMRwHNAw+1ujW7codCUkBz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715576928; c=relaxed/simple;
	bh=KSE8PzIjqSwH61R6iAt633ULjGLPnWmzNqBKlZgUjh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZYfRE1qSYaV9ocP6oyAdcMjUuL6UZnE/qaRpnQMcfXCE9P/qT0FX0VLFeVKXbq4v+idfO/eJJotWMYY94NI+IcRxMCCXe2GbyE0sjGfs+c0vS8bIsD7sqKOXn59lnU6s9tur9RYrFN+awUWz32NBstoAUFWwvsbgmkCC6I8Ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=unmtCXjI; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715576918; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=e+vn44n5PSOyoo2A5G9/u00K/6MLWmZWHwZJ5wJKuyA=;
	b=unmtCXjI8CuR6IvBh5xtCewYhu7ukzTMUDezLtXpOYLGR1UrdoWFZbZR7MsLX2umf1BL3NNZYkDZIss57OArA3Bzf9BVMQsRLppPNmzm8pGoJzscVjIkdK7owoASlf2v0kH/++EJFQw2/HU30S005EH/4eWzAiXrKDvMw0uWAcw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6HFTBL_1715576915;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6HFTBL_1715576915)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 13:08:36 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] mm: shmem: add an 'order' parameter for shmem_alloc_hugefolio()
Date: Mon, 13 May 2024 13:08:12 +0800
Message-Id: <ba362281dbcdc851dd3e21b8c0d4b6b29c5bed65.1715571279.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
References: <cover.1715571279.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new parameter to specify the huge page order for shmem_alloc_hugefolio(),
as a preparation to supoort mTHP.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index fa2a0ed97507..e4483c4596a8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1604,14 +1604,14 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 }
 
 static struct folio *shmem_alloc_hugefolio(gfp_t gfp,
-		struct shmem_inode_info *info, pgoff_t index)
+		struct shmem_inode_info *info, pgoff_t index, int order)
 {
 	struct mempolicy *mpol;
 	pgoff_t ilx;
 	struct page *page;
 
-	mpol = shmem_get_pgoff_policy(info, index, HPAGE_PMD_ORDER, &ilx);
-	page = alloc_pages_mpol(gfp, HPAGE_PMD_ORDER, mpol, ilx, numa_node_id());
+	mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
+	page = alloc_pages_mpol(gfp, order, mpol, ilx, numa_node_id());
 	mpol_cond_put(mpol);
 
 	return page_rmappable_folio(page);
@@ -1660,7 +1660,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_t gfp,
 				index + HPAGE_PMD_NR - 1, XA_PRESENT))
 			return ERR_PTR(-E2BIG);
 
-		folio = shmem_alloc_hugefolio(gfp, info, index);
+		folio = shmem_alloc_hugefolio(gfp, info, index, HPAGE_PMD_ORDER);
 		if (!folio)
 			count_vm_event(THP_FILE_FALLBACK);
 	} else {
-- 
2.39.3


