Return-Path: <linux-kernel+bounces-405328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A099C4FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C725D1F2163D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC2E2101B8;
	Tue, 12 Nov 2024 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IjjYKn/y"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4320B214
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397566; cv=none; b=oy1kB+ymZe/zIUi0+YbOE1rm2ScPTCT3NfgTgSsbBuaLo7Y4WnKZs7mPqRQhxEnAGVc/DwyToIQFYQRWrftfPzgtrfwYRExV1TtW/3VrdLoBSlp4L9E3Y2Q53UQ+HorG073b/BOyK/wbNvnjgX0zXlxGApOJEaf6wIH1MtVu7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397566; c=relaxed/simple;
	bh=Tho3/xRk+k5il9te1bwPre7tXnyjSHYo3l2yjIuYwnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDrjpzX8Fy50+bYDxxukYB4TagxDGptFQ9CtzC4gmAJMBLY/NR2loVReBGxfDI28QOQWe+97Qrv0o6dh6ZZgqj3g6JFTCCV6xiidD/toRy6QWVcGgnKc6cGT8Ph4EFglTJp8xDYSk3EVZ61RF3RudktWOwoCzgVQeupaMvIyKek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IjjYKn/y; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731397559; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=BLfs2hBKLS+Nhpnosu4xyvw0VZRH7d3h79ZeLMJQj1Q=;
	b=IjjYKn/yi1jzD42byU1q931bayceOYNqbqoq7HXrb0tIPBySrdjL3a9CXv7ffyvdZ7fghUyd3rKTU/cwvZHznwMOyO4tFOOC78/VTXBKS9OHL38WfoUsW33vAMtWMJ2AxcQ1ioIY8wJyGCoJPAnPWkJ2p/2pw/uqtSlQMrzJ4hA=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJG9pLm_1731397557 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 15:45:58 +0800
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
Subject: [PATCH v2 3/5] mm: shmem: add large folio support for tmpfs
Date: Tue, 12 Nov 2024 15:45:50 +0800
Message-Id: <eabd8c89fc1b4807eaf28750e04c44b718ae6487.1731397290.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add large folio support for tmpfs write and fallocate paths matching the
same high order preference mechanism used in the iomap buffered IO path
as used in __filemap_get_folio().

Add shmem_mapping_size_orders() to get a hint for the orders of the folio
based on the file size which takes care of the mapping requirements.

Traditionally, tmpfs only supported PMD-sized huge folios. However nowadays
with other file systems supporting any sized large folios, and extending
anonymous to support mTHP, we should not restrict tmpfs to allocating only
PMD-sized huge folios, making it more special. Instead, we should allow
tmpfs can allocate any sized large folios.

Considering that tmpfs already has the 'huge=' option to control the huge
folios allocation, we can extend the 'huge=' option to allow any sized huge
folios. The semantics of the 'huge=' mount option are:

huge=never: no any sized huge folios
huge=always: any sized huge folios
huge=within_size: like 'always' but respect the i_size
huge=advise: like 'always' if requested with fadvise()/madvise()

Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
allocate the PMD-sized huge folios if huge=always/within_size/advise is set.

Moreover, the 'deny' and 'force' testing options controlled by
'/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
semantics. The 'deny' can disable any sized large folios for tmpfs, while
the 'force' can enable PMD sized large folios for tmpfs.

Co-developed-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 91 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 14 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 86b2e417dc6f..a3203cf8860f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -549,10 +549,50 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
+/**
+ * shmem_mapping_size_orders - Get allowable folio orders for the given file size.
+ * @mapping: Target address_space.
+ * @index: The page index.
+ * @write_end: end of a write, could extend inode size.
+ *
+ * This returns huge orders for folios (when supported) based on the file size
+ * which the mapping currently allows at the given index. The index is relevant
+ * due to alignment considerations the mapping might have. The returned order
+ * may be less than the size passed.
+ *
+ * Return: The orders.
+ */
+static inline unsigned int
+shmem_mapping_size_orders(struct address_space *mapping, pgoff_t index, loff_t write_end)
+{
+	unsigned int order;
+	size_t size;
+
+	if (!mapping_large_folio_support(mapping) || !write_end)
+		return 0;
+
+	/* Calculate the write size based on the write_end */
+	size = write_end - (index << PAGE_SHIFT);
+	order = filemap_get_order(size);
+	if (!order)
+		return 0;
+
+	/* If we're not aligned, allocate a smaller folio */
+	if (index & ((1UL << order) - 1))
+		order = __ffs(index);
+
+	order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
+	return order > 0 ? BIT(order + 1) - 1 : 0;
+}
+
 static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 					      loff_t write_end, bool shmem_huge_force,
+					      struct vm_area_struct *vma,
 					      unsigned long vm_flags)
 {
+	unsigned long within_size_orders;
+	unsigned int order;
+	pgoff_t aligned_index;
 	loff_t i_size;
 
 	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
@@ -564,15 +604,41 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
 	if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
 		return BIT(HPAGE_PMD_ORDER);
 
+	/*
+	 * The huge order allocation for anon shmem is controlled through
+	 * the mTHP interface, so we still use PMD-sized huge order to
+	 * check whether global control is enabled.
+	 *
+	 * For tmpfs mmap()'s huge order, we still use PMD-sized order to
+	 * allocate huge pages due to lack of a write size hint.
+	 *
+	 * Otherwise, tmpfs will allow getting a highest order hint based on
+	 * the size of write and fallocate paths, then will try each allowable
+	 * huge orders.
+	 */
 	switch (SHMEM_SB(inode->i_sb)->huge) {
 	case SHMEM_HUGE_ALWAYS:
-		return BIT(HPAGE_PMD_ORDER);
-	case SHMEM_HUGE_WITHIN_SIZE:
-		index = round_up(index + 1, HPAGE_PMD_NR);
-		i_size = max(write_end, i_size_read(inode));
-		i_size = round_up(i_size, PAGE_SIZE);
-		if (i_size >> PAGE_SHIFT >= index)
+		if (vma)
 			return BIT(HPAGE_PMD_ORDER);
+
+		return shmem_mapping_size_orders(inode->i_mapping, index, write_end);
+	case SHMEM_HUGE_WITHIN_SIZE:
+		if (vma)
+			within_size_orders = BIT(HPAGE_PMD_ORDER);
+		else
+			within_size_orders = shmem_mapping_size_orders(inode->i_mapping,
+								       index, write_end);
+
+		order = highest_order(within_size_orders);
+		while (within_size_orders) {
+			aligned_index = round_up(index + 1, 1 << order);
+			i_size = max(write_end, i_size_read(inode));
+			i_size = round_up(i_size, PAGE_SIZE);
+			if (i_size >> PAGE_SHIFT >= aligned_index)
+				return within_size_orders;
+
+			order = next_order(&within_size_orders, order);
+		}
 		fallthrough;
 	case SHMEM_HUGE_ADVISE:
 		if (vm_flags & VM_HUGEPAGE)
@@ -776,6 +842,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 
 static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 					      loff_t write_end, bool shmem_huge_force,
+					      struct vm_area_struct *vma,
 					      unsigned long vm_flags)
 {
 	return 0;
@@ -1173,7 +1240,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	generic_fillattr(idmap, request_mask, inode, stat);
 	inode_unlock_shared(inode);
 
-	if (shmem_huge_global_enabled(inode, 0, 0, false, 0))
+	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	if (request_mask & STATX_BTIME) {
@@ -1690,14 +1757,10 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 		return 0;
 
 	global_orders = shmem_huge_global_enabled(inode, index, write_end,
-						  shmem_huge_force, vm_flags);
-	if (!vma || !vma_is_anon_shmem(vma)) {
-		/*
-		 * For tmpfs, we now only support PMD sized THP if huge page
-		 * is enabled, otherwise fallback to order 0.
-		 */
+						  shmem_huge_force, vma, vm_flags);
+	/* Tmpfs huge pages allocation */
+	if (!vma || !vma_is_anon_shmem(vma))
 		return global_orders;
-	}
 
 	/*
 	 * Following the 'deny' semantics of the top level, force the huge
-- 
2.39.3


