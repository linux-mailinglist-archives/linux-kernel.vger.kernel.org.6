Return-Path: <linux-kernel+bounces-177155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77B8C3AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19681C20E90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B180146A69;
	Mon, 13 May 2024 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PzG+9wE0"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68650146019
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715576928; cv=none; b=JMUhutW3cYfXoHp2521FZGkcwhy8ucNqWDtUOyQUiJmTIO5MTj4vj1okPjJK/D8ZUx91+W4R873I2ofuJHKj+QhR6hEqL10QIuY7pGj+Kx2XlXQm1Php0rEZiiLCEjIRUiCKmyBytvNtClOfLG8WQxw6NS98KfyGqcuIw53BKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715576928; c=relaxed/simple;
	bh=cpfZRxAVQPpUwrvlZPkCD36NqPeyWd9dDp7mDH++jkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHe7RjVcU6bqG/8m3IEr9PTyx19ffX9QH0e7vSbkNBr9uonExx3k9OZ26S/ePluj+OPaCe/FJjio394mVZUbD6YgM/HeJUPe3o3MguaN4hsW8I9zvAbRH+DDlu3IcKCaEbK9qgvR+SmYDtd5/xNQzoRTe8dy7AhZndTnjYmCfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PzG+9wE0; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715576924; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vWL4N5Yma0Cz0eiOf0sAW+iyKgVOoYbMTHPZ99SVNnk=;
	b=PzG+9wE0a/KnrQOlY906rEaJdjtjLAwYCVa+767wmfRbnmLIaz1BTZSTFibPujcQRrhI/IISeLMcc3tXrepw9enuU9FvRk+6GqvZV6eN8dHebJWWLgDulEkJ6aPfZUeDBQjSjccoTtCzYdiado5BofehFgY2TW/13KV3ihH5Xk0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6HFTD5_1715576921;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6HFTD5_1715576921)
          by smtp.aliyun-inc.com;
          Mon, 13 May 2024 13:08:42 +0800
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
Subject: [PATCH v2 6/7] mm: shmem: add mTHP size alignment in shmem_get_unmapped_area
Date: Mon, 13 May 2024 13:08:16 +0800
Message-Id: <664d35cfa7192adb28c133efffa81b0947f60d67.1715571279.git.baolin.wang@linux.alibaba.com>
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

Although the top-level hugepage allocation can be turned off, anonymous shmem
can still use mTHP by configuring the sysfs interface located at
'/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled'. Therefore,
add alignment for mTHP size to provide a suitable alignment address in
shmem_get_unmapped_area().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Lance Yang <ioworker0@gmail.com>
---
 mm/shmem.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b50ddf013e37..8b020ff09c72 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2404,6 +2404,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	unsigned long inflated_len;
 	unsigned long inflated_addr;
 	unsigned long inflated_offset;
+	unsigned long hpage_size;
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
@@ -2422,8 +2423,6 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return addr;
-	if (len < HPAGE_PMD_SIZE)
-		return addr;
 	if (flags & MAP_FIXED)
 		return addr;
 	/*
@@ -2435,8 +2434,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	if (uaddr == addr)
 		return addr;
 
+	hpage_size = HPAGE_PMD_SIZE;
 	if (shmem_huge != SHMEM_HUGE_FORCE) {
 		struct super_block *sb;
+		unsigned long __maybe_unused hpage_orders;
+		int order = 0;
 
 		if (file) {
 			VM_BUG_ON(file->f_op != &shmem_file_operations);
@@ -2449,18 +2451,34 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 			if (IS_ERR(shm_mnt))
 				return addr;
 			sb = shm_mnt->mnt_sb;
+
+			/*
+			 * Find the highest mTHP order used for anonymous shmem to
+			 * provide a suitable alignment address.
+			 */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			hpage_orders = READ_ONCE(huge_anon_shmem_orders_always);
+			hpage_orders |= READ_ONCE(huge_anon_shmem_orders_within_size);
+			hpage_orders |= READ_ONCE(huge_anon_shmem_orders_madvise);
+			hpage_orders |= READ_ONCE(huge_anon_shmem_orders_inherit);
+			order = highest_order(hpage_orders);
+			hpage_size = PAGE_SIZE << order;
+#endif
 		}
-		if (SHMEM_SB(sb)->huge == SHMEM_HUGE_NEVER)
+		if (SHMEM_SB(sb)->huge == SHMEM_HUGE_NEVER && !order)
 			return addr;
 	}
 
-	offset = (pgoff << PAGE_SHIFT) & (HPAGE_PMD_SIZE-1);
-	if (offset && offset + len < 2 * HPAGE_PMD_SIZE)
+	if (len < hpage_size)
+		return addr;
+
+	offset = (pgoff << PAGE_SHIFT) & (hpage_size - 1);
+	if (offset && offset + len < 2 * hpage_size)
 		return addr;
-	if ((addr & (HPAGE_PMD_SIZE-1)) == offset)
+	if ((addr & (hpage_size - 1)) == offset)
 		return addr;
 
-	inflated_len = len + HPAGE_PMD_SIZE - PAGE_SIZE;
+	inflated_len = len + hpage_size - PAGE_SIZE;
 	if (inflated_len > TASK_SIZE)
 		return addr;
 	if (inflated_len < len)
@@ -2473,10 +2491,10 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	if (inflated_addr & ~PAGE_MASK)
 		return addr;
 
-	inflated_offset = inflated_addr & (HPAGE_PMD_SIZE-1);
+	inflated_offset = inflated_addr & (hpage_size - 1);
 	inflated_addr += offset - inflated_offset;
 	if (inflated_offset > offset)
-		inflated_addr += HPAGE_PMD_SIZE;
+		inflated_addr += hpage_size;
 
 	if (inflated_addr > TASK_SIZE - len)
 		return addr;
-- 
2.39.3


