Return-Path: <linux-kernel+bounces-340120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4F986EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929E52830DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2B31A705D;
	Thu, 26 Sep 2024 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dbkI0f5H"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090B1A4E9A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339265; cv=none; b=pa4KlCqkclYB2YuCMS3Ucam/5TWmZAEQQHPsG+M5MFcxRWLAb8xduV5geIKwyWahUZCwVES6swXOTYMEt+VCWUTbYZusdZg5wGRLEUhomPCa3ZQm5lvLBUZh0YEWQDC2zx8/GW/JyeDOtuKeK5tHTtYib1DoUzQHW/rDPr+liGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339265; c=relaxed/simple;
	bh=axWl36bjzVBxJlA5cP6QqV5SOPKCoh4BVoEWlvvtTl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DcJ9q9X/PNzchUubnoO+7tD3XpUgBeMzciU2tYU44Mz3ujwf3gYpeql5sFANu/yb0b5a09MwVsmeVwvttJ2hSCGJNQycv04e9ARddqn+c/ly84uUSDXHTPStbKeD1M+1eA6ZaqfugRq1PhHKmRXPmQ5qdfnUMQ1GX6yQ+N7yiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dbkI0f5H; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727339261; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JgLfYDPlwcFd/0+L3cGA3cxYkitaWODfvWI7HPn1wc4=;
	b=dbkI0f5HZwyaXtjB6se2OajeVHdM/+fO1WmTna9YeSyOLBBZFgJeboTI0XB1m0RQkkkEIoLjJotYFL4nLW1K66/4f6+U0t11oE4yGK/POFzZ/AzNHdEtDZogCdJEq+znFnDQR629HiXz314oNryFdqgMHMOQCsu64ACB3Ydw/gY=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFmcorO_1727339259)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 16:27:40 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] mm: shmem: use mTHP interface to control huge orders for tmpfs
Date: Thu, 26 Sep 2024 16:27:27 +0800
Message-Id: <bcfa80f6293affdebb7e7bf70200133b65e73a6b.1727338549.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1727338549.git.baolin.wang@linux.alibaba.com>
References: <cover.1727338549.git.baolin.wang@linux.alibaba.com>
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
 mm/shmem.c  | 51 ++++++++++++++++++++++++++-------------------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2366578015ad..99dd75b84605 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5098,10 +5098,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
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
index 6dece90ff421..569d3ab37161 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1721,31 +1721,6 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
 		return 0;
 
-	global_huge = shmem_huge_global_enabled(inode, index, write_end,
-					shmem_huge_force, vma, vm_flags);
-	if (!vma || !vma_is_anon_shmem(vma)) {
-		size_t len;
-
-		/*
-		 * For tmpfs, if top level huge page is enabled, we just allow
-		 * PMD sized THP to keep interface backward compatibility.
-		 */
-		if (global_huge)
-			return BIT(HPAGE_PMD_ORDER);
-
-		if (!write_end)
-			return 0;
-
-		/*
-		 * Otherwise, get a highest order hint based on the size of
-		 * write and fallocate paths, then will try each allowable
-		 * huge orders.
-		 */
-		len = write_end - (index << PAGE_SHIFT);
-		order = shmem_mapping_size_order(inode->i_mapping, index, len);
-		return order > 0 ? BIT(order + 1) - 1 : 0;
-	}
-
 	/*
 	 * Following the 'deny' semantics of the top level, force the huge
 	 * option off from all mounts.
@@ -1776,9 +1751,35 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	if (vm_flags & VM_HUGEPAGE)
 		mask |= READ_ONCE(huge_shmem_orders_madvise);
 
+	global_huge = shmem_huge_global_enabled(inode, index, write_end,
+						shmem_huge_force, vma, vm_flags);
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
+		size_t len;
+
+		if (!write_end)
+			return 0;
+
+		len = write_end - (index << PAGE_SHIFT);
+		order = shmem_mapping_size_order(inode->i_mapping, index, len);
+		if (!mask)
+			return order > 0 ? BIT(order + 1) - 1 : 0;
+
+		mask &= BIT(order + 1) - 1;
+	}
 	return THP_ORDERS_ALL_FILE_DEFAULT & mask;
 }
 
-- 
2.39.3


