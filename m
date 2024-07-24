Return-Path: <linux-kernel+bounces-260681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77593ACEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E9283A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C461FCA;
	Wed, 24 Jul 2024 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tY+ggRWe"
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A37C0B7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804682; cv=none; b=cd2QTwg6x3FurqJPeJwUfTk9abidfY8VxbbfpTsPPQEZAhgtRYOEFVmv55IxeWBBaXFP8j9UUx8tG4rHJa2oW/HJgLpXWMmgBPTns+sHHYOCkAom4AREVAVwSpRQBjFQe2MoZleEf3Fe9TAtPC8my4klmIOHxOZlrJXjEnAUCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804682; c=relaxed/simple;
	bh=1eEI2J/7NFOfsTYeA5VjrGvkQpPcv9rU6r1M/49RL84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SYx3OxIXNySgIaFvbjm/R6rMfUEq6sHvZElqgeYiZ0eTgRBBnRa/lUwCvf/gTAxXbDYprLzgMb5NQO5N/H6bYm7bUCV1/ladIylmGgU3lPZ9PZZ9SO+4ItPTqahn7PU0LMo2riMI1mGi0wn1viRUYQr7gIQCfSp2Xp8K6Y8DLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tY+ggRWe; arc=none smtp.client-ip=47.90.199.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721804663; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tdqWP64rTR+e1Asc5O6zn2fOj7NNlZAEMcoj2njyV9U=;
	b=tY+ggRWeZ7iwXAAcHSVxs1nslPchK6vv5cwzoJ0+vkrp6BtYWmlSvbfOjNAJRF7KjVLshyFhluJTpafbbUFYtSOW3vGGJauo0quUGz3EHZ27prrpo/Cewxr1mP7R6oDmUapkZ7L/Y1B74X6WXzmr5KJmZvCm2eDHTMehGcHV9F8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBDDM3B_1721804661;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBDDM3B_1721804661)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 15:04:21 +0800
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
Subject: [RFC PATCH 3/3] mm: shmem: use mTHP interface to control huge orders for tmpfs
Date: Wed, 24 Jul 2024 15:04:00 +0800
Message-Id: <03c77c20a8a6ccdd90678dcc6bf7d4aeaa9d29ad.1721720891.git.baolin.wang@linux.alibaba.com>
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

For the huge orders allowed by writable mmap() faults on tmpfs,
the mTHP interface is used to control the allowable huge orders,
while 'huge_shmem_orders_inherit' maintains backward compatibility
with top-level interface.

For the huge orders allowed by write() and fallocate() paths on tmpfs,
getting a highest order hint based on the size of write and fallocate
paths, then will try each allowable huge orders filtered by the mTHP
interfaces if set.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/memory.c |  4 ++--
 mm/shmem.c  | 42 ++++++++++++++++++++++--------------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 802d0d8a40f9..3a7f43c66db7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4877,10 +4877,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	/*
 	 * Using per-page fault to maintain the uffd semantics, and same
-	 * approach also applies to non-anonymous-shmem faults to avoid
+	 * approach also applies to non shmem/tmpfs faults to avoid
 	 * inflating the RSS of the process.
 	 */
-	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
+	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
 		nr_pages = 1;
 	} else if (nr_pages > 1) {
 		pgoff_t idx = folio_page_idx(folio, page);
diff --git a/mm/shmem.c b/mm/shmem.c
index cc0c1b790267..8e60cc566196 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1692,26 +1692,6 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
 		return 0;
 
-	global_huge = shmem_huge_global_enabled(inode, index, shmem_huge_force,
-						vma, vm_flags);
-	if (!vma || !vma_is_anon_shmem(vma)) {
-		/*
-		 * For tmpfs, if top level huge page is enabled, we just allow
-		 * PMD size THP to keep interface backward compatibility.
-		 */
-		if (global_huge)
-			return BIT(HPAGE_PMD_ORDER);
-
-		/*
-		 * Otherwise, get a highest order hint based on the size of
-		 * write and fallocate paths, then will try each allowable
-		 * huge orders.
-		 */
-		order = shmem_mapping_size_order(inode->i_mapping, index,
-						 len, SHMEM_SB(inode->i_sb));
-		return BIT(order + 1) - 1;
-	}
-
 	/*
 	 * Following the 'deny' semantics of the top level, force the huge
 	 * option off from all mounts.
@@ -1742,9 +1722,31 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	if (vm_flags & VM_HUGEPAGE)
 		mask |= READ_ONCE(huge_shmem_orders_madvise);
 
+	global_huge = shmem_huge_global_enabled(inode, index, shmem_huge_force,
+						vma, vm_flags);
 	if (global_huge)
 		mask |= READ_ONCE(huge_shmem_orders_inherit);
 
+	/*
+	 * For the huge orders allowed by writable mmap() faults on tmpfs,
+	 * the mTHP interface is used to control the allowable huge orders,
+	 * while 'huge_shmem_orders_inherit' maintains backward compatibility
+	 * with top-level interface.
+	 *
+	 * For the huge orders allowed by write() and fallocate() paths on tmpfs,
+	 * get a highest order hint based on the size of write and fallocate
+	 * paths, then will try each allowable huge orders filtered by the mTHP
+	 * interfaces if set.
+	 */
+	if (!vma && !global_huge) {
+		int highest_order = shmem_mapping_size_order(inode->i_mapping, index, len,
+							     SHMEM_SB(inode->i_sb));
+
+		if (!mask)
+			return highest_order > 0 ? BIT(highest_order + 1) - 1 : 0;
+
+		mask &= BIT(highest_order + 1) - 1;
+	}
 	return orders & mask;
 }
 
-- 
2.39.3


