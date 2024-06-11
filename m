Return-Path: <linux-kernel+bounces-209617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11890387C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C901D288613
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72584178380;
	Tue, 11 Jun 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jptw3rzn"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0317B436
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100691; cv=none; b=LBeOEEgNJsy89rp/FiKLBeFEk0WSxrw3yKmoTEQvQEvufkaw6H8EuBG9awpKOFE+Ws33i5XkguI/R4JNReC1oe1+vDnVjl85GRCBbFsvVQNAz0nUTqY9q3zsib3zjQQcvbtjjW8u8Ybq8Yl6cyC6imc0Bik2QO2bZWRvWarcBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100691; c=relaxed/simple;
	bh=70wTV4nMPkC96519CWpP6cXN2DwOUaVtwPlToALg+34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKZMPms8tCS417WfOcoQwB0MNrgiU4GbKGLnw7I0WCYZy5+cRZPj8eo0s0J6gufHckcPRwxZ5S2pPfc93D29S/Z46IZo/4z8R/yIS7gt84jH9SjM6L5ksGrGsNVmQ2b/gzF3kNKukP9wEIJBbNXouzK9ukAnpe5FL79S9XxbP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jptw3rzn; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718100682; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ihHol0Lo4aQL92vXhUE0q0HG3Xsyoz8HlIbQSl3GlRA=;
	b=Jptw3rznsqoHQxQkCYMKVYim7AsECX9znu/4R94NJp8vLd4WcIzqq+a0yaHYvsN5Bwt54eTffUbUeq1WyXmROKAbiVoPr2290bOnpEePq7Cx23kngnfjzAdFNZycFGJFwpb2enBjzGuxIGdknmyd9dla+hIkBGFUeBLOFw+eu1I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8G1Jrq_1718100680;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8G1Jrq_1718100680)
          by smtp.aliyun-inc.com;
          Tue, 11 Jun 2024 18:11:21 +0800
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
Subject: [PATCH v5 5/6] mm: shmem: add mTHP size alignment in shmem_get_unmapped_area
Date: Tue, 11 Jun 2024 18:11:09 +0800
Message-Id: <0c549b57cf7db07503af692d8546ecfad0fcce52.1718090413.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
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
 mm/shmem.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e849c88452b2..f5469c357be6 100644
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
@@ -2439,18 +2441,38 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 			if (IS_ERR(shm_mnt))
 				return addr;
 			sb = shm_mnt->mnt_sb;
+
+			/*
+			 * Find the highest mTHP order used for anonymous shmem to
+			 * provide a suitable alignment address.
+			 */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			hpage_orders = READ_ONCE(huge_shmem_orders_always);
+			hpage_orders |= READ_ONCE(huge_shmem_orders_within_size);
+			hpage_orders |= READ_ONCE(huge_shmem_orders_madvise);
+			if (SHMEM_SB(sb)->huge != SHMEM_HUGE_NEVER)
+				hpage_orders |= READ_ONCE(huge_shmem_orders_inherit);
+
+			if (hpage_orders > 0) {
+				order = highest_order(hpage_orders);
+				hpage_size = PAGE_SIZE << order;
+			}
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
@@ -2463,10 +2485,10 @@ unsigned long shmem_get_unmapped_area(struct file *file,
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


