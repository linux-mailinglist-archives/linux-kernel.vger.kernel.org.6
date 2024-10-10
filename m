Return-Path: <linux-kernel+bounces-358740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1E998305
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B43A285662
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA4E1BF80A;
	Thu, 10 Oct 2024 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nmGiYb/Z"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389ED1BE86F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554306; cv=none; b=kh6u8uRj9m1dEWd0mT3xuIWMHJVu8tt9n6v51evGH44oW1b/0qQv4jkdFS/1NP76ewHL/RSfgOklmwUTBqMwBovW3vccCDof5GaDjw4hwldvV+ZycOV+G8t9zG/eQyyFMtKZjBvp8cF0V4gwPs8IvP5ipSMsDIBQMr7+PL5/A0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554306; c=relaxed/simple;
	bh=5+gX2Wp3dxdEacjMq8pP3jKsECs5CoHoKOL9Jaxyz3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zvv0Hw75Ex7M6XHA98kdpsDD5z3oJ7tcfmLrUW+p79T7raGGC/3TtDzFIBFQH/C4NGyB21ulW2yfCzXGMyYV1TUREEtjryyLlK3C+mQF/SlTxNM9yqPX+Z9/0OQFfe2wERWL5AdoI4MV9Doy/8a2f8LJCiplbctN3E2OhIPTzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nmGiYb/Z; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728554302; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0/z9eme036ELYbZ0x9xP/AM4BDPvXGK6kIU0Y8j+uE0=;
	b=nmGiYb/ZdFE63ymZzgWaWErPpAh66/ltmnC91kyf7T+qw/Inw7qb2iwe/Wl4P/e2lLmGQ/R9CNyWHxpBHphYUKAWUBYf4oz8RywWiBYPL2g44COvtIejM6LxWbUgp5tD7b+9qCtj7jP6WEyrTMyzurZALDQ2uqtZmcecK73MzqE=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WGm.dgu_1728554300 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:58:21 +0800
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
Subject: [RFC PATCH v3 3/4] mm: shmem: add large folio support to the write and fallocate paths for tmpfs
Date: Thu, 10 Oct 2024 17:58:13 +0800
Message-Id: <252c5999f8789d4f511e8e1466414238990f7e18.1728548374.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
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

Add shmem_mapping_size_order() to get a hint for the order of the folio
based on the file size which takes care of the mapping requirements.

Considering that tmpfs already has the 'huge=' option to control the huge
pages allocation, it is necessary to maintain compatibility with the 'huge='
 option, as well as considering the 'deny' and 'force' option controlled
by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.

Add a new huge option 'write_size' to support large folio allocation based
on the write size for tmpfs write and fallocate paths. So the huge pages
allocation strategy for tmpfs is that, if the 'huge=' option
(huge=always/within_size/advise) is enabled or the 'shmem_enabled' option
is 'force', it need just allow PMD sized THP to keep backward compatibility
for tmpfs. While 'huge=' option is disabled (huge=never) or the 'shmem_enabled'
option is 'deny', it will still disable any large folio allocations. Only
when the 'huge=' option is 'write_size', it will allow allocating large
folios based on the write size.

Co-developed-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f04935722457..66f1cf5b1645 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -523,12 +523,15 @@ static bool shmem_confirm_swap(struct address_space *mapping,
  *	also respect fadvise()/madvise() hints;
  * SHMEM_HUGE_ADVISE:
  *	only allocate huge pages if requested with fadvise()/madvise();
+ * SHMEM_HUGE_WRITE_SIZE:
+ *	only allocate huge pages based on the write size.
  */
 
 #define SHMEM_HUGE_NEVER	0
 #define SHMEM_HUGE_ALWAYS	1
 #define SHMEM_HUGE_WITHIN_SIZE	2
 #define SHMEM_HUGE_ADVISE	3
+#define SHMEM_HUGE_WRITE_SIZE	4
 
 /*
  * Special values.
@@ -548,12 +551,46 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
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
+ * Return: The order.
+ */
+static inline unsigned int
+shmem_mapping_size_order(struct address_space *mapping, pgoff_t index, size_t size)
+{
+	unsigned int order;
+
+	if (!mapping_large_folio_support(mapping))
+		return 0;
+
+	order = filemap_get_order(size);
+	if (!order)
+		return 0;
+
+	/* If we're not aligned, allocate a smaller folio */
+	if (index & ((1UL << order) - 1))
+		order = __ffs(index);
+
+	return min_t(size_t, order, MAX_PAGECACHE_ORDER);
+}
+
 static unsigned int __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 						loff_t write_end, bool shmem_huge_force,
 						struct vm_area_struct *vma,
 						unsigned long vm_flags)
 {
 	struct mm_struct *mm = vma ? vma->vm_mm : NULL;
+	unsigned int order;
+	size_t len;
 	loff_t i_size;
 
 	if (!S_ISREG(inode->i_mode))
@@ -568,6 +605,17 @@ static unsigned int __shmem_huge_global_enabled(struct inode *inode, pgoff_t ind
 	switch (SHMEM_SB(inode->i_sb)->huge) {
 	case SHMEM_HUGE_ALWAYS:
 		return BIT(HPAGE_PMD_ORDER);
+	/*
+	 * If the huge option is SHMEM_HUGE_WRITE_SIZE, it will allow
+	 * getting a highest order hint based on the size of write and
+	 * fallocate paths, then will try each allowable huge orders.
+	 */
+	case SHMEM_HUGE_WRITE_SIZE:
+		if (!write_end)
+			return 0;
+		len = write_end - (index << PAGE_SHIFT);
+		order = shmem_mapping_size_order(inode->i_mapping, index, len);
+		return order > 0 ? BIT(order + 1) - 1 : 0;
 	case SHMEM_HUGE_WITHIN_SIZE:
 		index = round_up(index + 1, HPAGE_PMD_NR);
 		i_size = max(write_end, i_size_read(inode));
@@ -624,6 +672,8 @@ static const char *shmem_format_huge(int huge)
 		return "always";
 	case SHMEM_HUGE_WITHIN_SIZE:
 		return "within_size";
+	case SHMEM_HUGE_WRITE_SIZE:
+		return "write_size";
 	case SHMEM_HUGE_ADVISE:
 		return "advise";
 	case SHMEM_HUGE_DENY:
@@ -1694,13 +1744,9 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 
 	global_order = shmem_huge_global_enabled(inode, index, write_end,
 					shmem_huge_force, vma, vm_flags);
-	if (!vma || !vma_is_anon_shmem(vma)) {
-		/*
-		 * For tmpfs, we now only support PMD sized THP if huge page
-		 * is enabled, otherwise fallback to order 0.
-		 */
+	/* Tmpfs huge pages allocation? */
+	if (!vma || !vma_is_anon_shmem(vma))
 		return global_order;
-	}
 
 	/*
 	 * Following the 'deny' semantics of the top level, force the huge
@@ -2851,7 +2897,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	cache_no_acl(inode);
 	if (sbinfo->noswap)
 		mapping_set_unevictable(inode->i_mapping);
-	mapping_set_large_folios(inode->i_mapping);
+	if (sbinfo->huge)
+		mapping_set_large_folios(inode->i_mapping);
 
 	switch (mode & S_IFMT) {
 	default:
@@ -4224,6 +4271,7 @@ static const struct constant_table shmem_param_enums_huge[] = {
 	{"always",	SHMEM_HUGE_ALWAYS },
 	{"within_size",	SHMEM_HUGE_WITHIN_SIZE },
 	{"advise",	SHMEM_HUGE_ADVISE },
+	{"write_size",	SHMEM_HUGE_WRITE_SIZE },
 	{}
 };
 
-- 
2.39.3


