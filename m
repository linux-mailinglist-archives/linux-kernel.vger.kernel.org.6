Return-Path: <linux-kernel+bounces-340119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E92986EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8074C1F22DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283B1A4F18;
	Thu, 26 Sep 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kMQ1hzyJ"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2751A4E83
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339264; cv=none; b=rTFPYt2FkfCRjkMcwGyOdN6vfECBjIPWtOpejPJTMihIMVG3TINb+XJMPcOekpZZyX5lSeqsMmNaAEQ3IBTItzh18XXbjgkXGmWGFFFmZkqzFSArCknwrawvd92+dlxGv0gjRWGoBokUS+fI+EQdC/4BHnNQz+6LdgyxlYGIet8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339264; c=relaxed/simple;
	bh=9an382UdEW0XeaOSyPFzP2AEHruPp8N3RdhdKaWx3Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UPPXJuzNlJ9Tlk+R3q08+Ml3GVXj67dyWJDFEQclocI/Ym0WcR2Z94exCzghtjHndB2jk9JGIzcUyIADoTdmf82maVggx7/MlV5Nr0xaJK3POfaJlAJ9zqUniWnEGuDOrLVfzkg9YxQsVKivpgyhtzi6hhXYbFigcnOIXckGjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kMQ1hzyJ; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727339260; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YCfvBtZVEzVJoPVwJXjBCYZjSgR2b99w/DEiUCw3oWM=;
	b=kMQ1hzyJus9aNnm85hQFm9ePVhsig82KImD/mnLT0omzt/UbSMnmQkDz1Z5FPRpkUIdUGmrpInmeM2eDf5TZvGZi4x9c9tIz9dh99o92FZ31vz48XUrMVTBNKiipq6KYcEBRNfGb/VpyjwYEU77i7N+hk9x8KutLpgOrCcb+kF4=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFmcoqg_1727339258)
          by smtp.aliyun-inc.com;
          Thu, 26 Sep 2024 16:27:39 +0800
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
Subject: [RFC PATCH v2 1/2] mm: shmem: add large folio support to the write and fallocate paths
Date: Thu, 26 Sep 2024 16:27:26 +0800
Message-Id: <c03ec1cb1392332726ab265a3d826fe1c408c7e7.1727338549.git.baolin.wang@linux.alibaba.com>
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

From: Daniel Gomez <da.gomez@samsung.com>

Add large folio support for shmem write and fallocate paths matching the
same high order preference mechanism used in the iomap buffered IO path
as used in __filemap_get_folio().

Add shmem_mapping_size_order() to get a hint for the order of the folio
based on the file size which takes care of the mapping requirements.

If the top level huge page (controlled by '/sys/kernel/mm/transparent_hugepage/shmem_enabled')
is enabled, we just allow PMD sized THP to keep interface backward
compatibility.

Co-developed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0613421e09e7..6dece90ff421 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1672,6 +1672,36 @@ bool shmem_hpage_pmd_enabled(void)
 	return false;
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
+shmem_mapping_size_order(struct address_space *mapping, pgoff_t index, size_t size)
+{
+	unsigned int order = get_order(max_t(size_t, size, PAGE_SIZE));
+
+	if (!mapping_large_folio_support(mapping))
+		return 0;
+
+	/* If we're not aligned, allocate a smaller folio */
+	if (index & ((1UL << order) - 1))
+		order = __ffs(index);
+
+	return min_t(size_t, order, MAX_PAGECACHE_ORDER);
+}
+
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
 				loff_t write_end, bool shmem_huge_force)
@@ -1694,11 +1724,26 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	global_huge = shmem_huge_global_enabled(inode, index, write_end,
 					shmem_huge_force, vma, vm_flags);
 	if (!vma || !vma_is_anon_shmem(vma)) {
+		size_t len;
+
+		/*
+		 * For tmpfs, if top level huge page is enabled, we just allow
+		 * PMD sized THP to keep interface backward compatibility.
+		 */
+		if (global_huge)
+			return BIT(HPAGE_PMD_ORDER);
+
+		if (!write_end)
+			return 0;
+
 		/*
-		 * For tmpfs, we now only support PMD sized THP if huge page
-		 * is enabled, otherwise fallback to order 0.
+		 * Otherwise, get a highest order hint based on the size of
+		 * write and fallocate paths, then will try each allowable
+		 * huge orders.
 		 */
-		return global_huge ? BIT(HPAGE_PMD_ORDER) : 0;
+		len = write_end - (index << PAGE_SHIFT);
+		order = shmem_mapping_size_order(inode->i_mapping, index, len);
+		return order > 0 ? BIT(order + 1) - 1 : 0;
 	}
 
 	/*
-- 
2.39.3


