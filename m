Return-Path: <linux-kernel+bounces-194873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B13F8D4352
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 04:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3822E283613
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584B1B80F;
	Thu, 30 May 2024 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XypK4/JW"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A9A22EED
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034691; cv=none; b=oX6ZHva4eAhG0yFGqF6HmyLekqwxUhIWiUwvdWqOqVK6rXJ8rqGj7qQO/dIMPApV7p1wZATnwJn71Td2UE5zfOcqU76efTF6fBND6A7pvnFDM1GI0IaX2f8D5wve7WI35D6BG6OIpKUMzzLXkJQ26cusvoymW+KbwFkvhP5/Qac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034691; c=relaxed/simple;
	bh=DCLpbiumVdaZe+rSZntSUm/RXQvdQ4mbHP4ZLPPiJzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XhiJcyuwlPs7AlTqdBTTb78217duxwKy1zkFEFxqgNrAlDXQjVwhOBuO+Z790phYy7BsQpMM3v0YZOnmdjC6whCOvf6xJzyNrraf2xWsAwtxP2KPhUi31QXMwq9UhryaSfEo2x3YxyJC93olxPeMf3jX8fgo2VSd2kC0mKufV+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XypK4/JW; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717034681; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OpKbZmXRrURMX+/QsaD7+TkYK79RF0tdTg/q8PuO7h4=;
	b=XypK4/JWee0Alk9Dp1YxzwUyqWQRv1drfxnEnzpZy50yvbcyg5h+GsSs7+GS6MgxEnFsZkE/Z3ETrncSO+eU8tmO5STBbjQoi0ntP8FL+tNwUG09AVAeVN5On1/2LxgE9YWz6Nq9nI67f+JNzSQyVOwRkkwb/FKHjrH/sZsGoaE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7V1J68_1717034679;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7V1J68_1717034679)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 10:04:39 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] mm: shmem: add mTHP size alignment in shmem_get_unmapped_area
Date: Thu, 30 May 2024 10:04:16 +0800
Message-Id: <4d0b226f2a14f93d156a01855db32ff562547bcc.1717033868.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
References: <cover.1717033868.git.baolin.wang@linux.alibaba.com>
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
index 493873d7246c..efc093ee7d4d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2394,6 +2394,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	unsigned long inflated_len;
 	unsigned long inflated_addr;
 	unsigned long inflated_offset;
+	unsigned long hpage_size;
 
 	if (len > TASK_SIZE)
 		return -ENOMEM;
@@ -2412,8 +2413,6 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return addr;
-	if (len < HPAGE_PMD_SIZE)
-		return addr;
 	if (flags & MAP_FIXED)
 		return addr;
 	/*
@@ -2425,8 +2424,11 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	if (uaddr == addr)
 		return addr;
 
+	hpage_size = HPAGE_PMD_SIZE;
 	if (shmem_huge != SHMEM_HUGE_FORCE) {
 		struct super_block *sb;
+		unsigned long __maybe_unused hpage_orders;
+		int order = 0;
 
 		if (file) {
 			VM_BUG_ON(file->f_op != &shmem_file_operations);
@@ -2439,18 +2441,34 @@ unsigned long shmem_get_unmapped_area(struct file *file,
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
@@ -2463,10 +2481,10 @@ unsigned long shmem_get_unmapped_area(struct file *file,
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


