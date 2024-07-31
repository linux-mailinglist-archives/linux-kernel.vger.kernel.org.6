Return-Path: <linux-kernel+bounces-268540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD49425F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF84C2877B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854DE7316E;
	Wed, 31 Jul 2024 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wfpR+KpI"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63C53364
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404802; cv=none; b=IAklwA9ZFRUDwvSe7qf22yeTnqIzHQtW6lY75U8yDWTwFF7eD0DniodmcFc5VcIGLi5BF2bsE/OmLpNX5hR/XvLRLkdRWi7kQ50JdeVpT/BXmoOc1AQaPSFBQykIZO/HaR1fsh0lPL57BvFRkV2yJ2J0bxrzG9w6Q5fXXRb3uwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404802; c=relaxed/simple;
	bh=LbFlBynU4gRVQPYyZQBt7ZUb64NERHknQwncnfDYzhU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mEM84AXxWnvAeiyXfVAp0w/xYuuXg3brVw7k1CSqBilPM4uGeBRbDt8JYHxjX8ZkhAyqBJNdFFajsOfYHRuIH0Q20nAjU1wkddKUI8UhLoIHDihERFDWMohU8clqPTXJeU47BnBuIg6UEjzgBZIh3yo63IheQaaE5LF177qwFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wfpR+KpI; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722404792; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9iYPuftUH8jdllTlmDLAs9X/H1+vtZ8NK0gmpMdbLv4=;
	b=wfpR+KpIhN/TkcohwwLhOFqn0yCL1xYjiQ6AG5XxThsBGKoqDMepkma7+sgZ8b5tEbykBlAdQWLW5E1aCEsCadvFvZ7qvAP+Un5cLwSvJCb1XBUAhMPD2s1SXZCklRXtH4SLUVGmyn1xAq6t/d64f2U65tuDwDl1w+qWVIp84CQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WBi1RBW_1722404790;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBi1RBW_1722404790)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 13:46:31 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	gshan@redhat.com,
	ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than MAX_PAGECACHE_ORDER for shmem
Date: Wed, 31 Jul 2024 13:46:19 +0800
Message-Id: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to commit d659b715e94ac ("mm/huge_memory: avoid PMD-size page cache
if needed"), ARM64 can support 512MB PMD-sized THP when the base page size is
64KB, which is larger than the maximum supported page cache size MAX_PAGECACHE_ORDER.
This is not expected. To fix this issue, use THP_ORDERS_ALL_FILE_DEFAULT for
shmem to filter allowable huge orders.

Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2faa9daaf54b..a4332a97558c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1630,10 +1630,10 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
 	unsigned long vm_flags = vma->vm_flags;
 	/*
-	 * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
+	 * Check all the (large) orders below MAX_PAGECACHE_ORDER + 1 that
 	 * are enabled for this vma.
 	 */
-	unsigned long orders = BIT(PMD_ORDER + 1) - 1;
+	unsigned long orders = THP_ORDERS_ALL_FILE_DEFAULT;
 	loff_t i_size;
 	int order;
 
-- 
2.39.3


