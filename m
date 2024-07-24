Return-Path: <linux-kernel+bounces-260680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15A93ACE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEDA1C21C91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3307A6F068;
	Wed, 24 Jul 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ua/zCN0e"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1560543AA1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804672; cv=none; b=FctLyAgGKzcE2/wM2xyvmQ9V51d5D5u0ljeYext5X780qjQ6VkOH8S75Ahesdu2JN+NrNMTohyVKycTTKOgin93ODene4LFcycRDdgs/sri0FDn2A5HX5l/iKUZ0rt2SsD5I7iqil22mgQfKdzudLnvhthnAjHAkasWxID45mQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804672; c=relaxed/simple;
	bh=fCiHkjMmxgKbcT4qE8kEtbnUUlIyom051hu5UsrLiD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DKmX43rCKQFl/6IhTQwxQEbKJhCwPlHwVKqHd+Y6b9dI0lwtF0UKfa4Nr+6feVvf54oaVGUrV34rU29fQ7WCRykuqKijz3V/vsIZM0Vb9wV8kKa1tWr15LUuxmAPsdKrLjfYyEGTj1Wv9MmF4jd3hRYPkucHftLMA4VYjAtJtOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ua/zCN0e; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721804662; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GJHtzrbfRGkXA1beo6I8v9VjRBWlqaeEznsY5RTbsHE=;
	b=Ua/zCN0eLIbXjFO4dYelpVgtUBvPbYS8e9bA9zRjsFI5JRwgNw+ayGQK0Tpk0xdQHnNIusorkzZ4GE2iqW7BgJsZT7CdeOwea/R2Kwtk20drU3yrR9Zozl+Z1dERZfemT0nsmpKzz/YgluJFAcsd1ZZeYZcWEM4RHOZb96Biq2A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBDNN8B_1721804660;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBDNN8B_1721804660)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 15:04:20 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] mm: shmem: add large folio support to the write and fallocate paths
Date: Wed, 24 Jul 2024 15:03:59 +0800
Message-Id: <05a31373ee1aa40a6a85d4897324a400686e2fb1.1721720891.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1721720891.git.baolin.wang@linux.alibaba.com>
References: <cover.1721720891.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Gomez <da.gomez@samsung.com>

Add large folio support for shmem write and fallocate paths matching the
same high order preference mechanism used in the iomap buffered IO path
as used in __filemap_get_folio().

Add shmem_mapping_size_order() to get a hint for the order of the folio
based on the file size which takes care of the mapping requirements.

Swap does not support high order folios for now, so make it order-0 in
case swap is enabled.

If the top level huge page (controlled by '/sys/kernel/mm/transparent_hugepage/shmem_enabled')
is enabled, we just allow PMD sized THP to keep interface backward
compatibility.

Co-developed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/shmem_fs.h |  4 +--
 mm/huge_memory.c         |  2 +-
 mm/shmem.c               | 57 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 34beaca2f853..fb0771218f1b 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -113,11 +113,11 @@ int shmem_unuse(unsigned int type);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
-				bool shmem_huge_force);
+				bool shmem_huge_force, size_t len);
 #else
 static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
-				bool shmem_huge_force)
+				bool shmem_huge_force, size_t len)
 {
 	return 0;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e555fcdd19d4..a8fc3b9e4034 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -162,7 +162,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	if (!in_pf && shmem_file(vma->vm_file))
 		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
 						   vma, vma->vm_pgoff,
-						   !enforce_sysfs);
+						   !enforce_sysfs, PAGE_SIZE);
 
 	if (!vma_is_anonymous(vma)) {
 		/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 92ed09527682..cc0c1b790267 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1630,10 +1630,47 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 	return result;
 }
 
+/**
+ * shmem_mapping_size_order - Get maximum folio order for the given file size.
+ * @mapping: Target address_space.
+ * @index: The page index.
+ * @size: The suggested size of the folio to create.
+ *
+ * This returns a high order for folios (when supported) based on the file size
+ * which the mapping currently allows at the given index. The index is relevant
+ * due to alignment considerations the mapping might have. The returned order
+ * may be less than the size passed.
+ *
+ * Like __filemap_get_folio order calculation.
+ *
+ * Return: The order.
+ */
+static inline unsigned int
+shmem_mapping_size_order(struct address_space *mapping, pgoff_t index,
+			 size_t size, struct shmem_sb_info *sbinfo)
+{
+	unsigned int order = ilog2(size);
+
+	if ((order <= PAGE_SHIFT) ||
+	    (!mapping_large_folio_support(mapping) || !sbinfo->noswap))
+		return 0;
+
+	order -= PAGE_SHIFT;
+
+	/* If we're not aligned, allocate a smaller folio */
+	if (index & ((1UL << order) - 1))
+		order = __ffs(index);
+
+	order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
+
+	/* Order-1 not supported due to THP dependency */
+	return (order == 1) ? 0 : order;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
-				bool shmem_huge_force)
+				bool shmem_huge_force, size_t len)
 {
 	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
 	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
@@ -1659,10 +1696,20 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 						vma, vm_flags);
 	if (!vma || !vma_is_anon_shmem(vma)) {
 		/*
-		 * For tmpfs, we now only support PMD sized THP if huge page
-		 * is enabled, otherwise fallback to order 0.
+		 * For tmpfs, if top level huge page is enabled, we just allow
+		 * PMD size THP to keep interface backward compatibility.
+		 */
+		if (global_huge)
+			return BIT(HPAGE_PMD_ORDER);
+
+		/*
+		 * Otherwise, get a highest order hint based on the size of
+		 * write and fallocate paths, then will try each allowable
+		 * huge orders.
 		 */
-		return global_huge ? BIT(HPAGE_PMD_ORDER) : 0;
+		order = shmem_mapping_size_order(inode->i_mapping, index,
+						 len, SHMEM_SB(inode->i_sb));
+		return BIT(order + 1) - 1;
 	}
 
 	/*
@@ -2174,7 +2221,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	/* Find hugepage orders that are allowed for anonymous shmem and tmpfs. */
-	orders = shmem_allowable_huge_orders(inode, vma, index, false);
+	orders = shmem_allowable_huge_orders(inode, vma, index, false, len);
 	if (orders > 0) {
 		gfp_t huge_gfp;
 
-- 
2.39.3


