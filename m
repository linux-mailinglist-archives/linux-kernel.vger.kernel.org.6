Return-Path: <linux-kernel+bounces-200417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D13788FAFBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F361B232C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9383145A1F;
	Tue,  4 Jun 2024 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xg8KIn88"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A71459EC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496303; cv=none; b=XoD4Qcg3LNaIT7BP6cmZAYBShtrZT6LKVFucg2PuYa8VU0hyz52UPyDaPkQVlBO8oGLAKluDV7ImDoWWoHsjVYUIrNQh+/YmAIWwK5H4JjPzTLWKlxXTVg8GWX0Vh9fatnu71cZiuZhKSuXYGLYGcWxkBkst1u1NRo0ys4WO7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496303; c=relaxed/simple;
	bh=rP21fUuQQQToDvqa5Zoy0et3OXxLIaOzGgJakF6b+H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h80zjaalGKsQnvttARdRc/379Iu2i21PPvSjTFmlb+zmQHbyH72MWUK/G/YfWEnwacDvo5mLrGF2CisiIOosxnJ2lOTFSyVo4qwNshNdz/axXysa4pqxrmpiOAIcO1z7Xuz81rWiYut3y0fZv5EjElz+J1SDES86QxgEPHn+IZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xg8KIn88; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717496293; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mF0SOFHOYjsa4DTAJ1q9V/3Dk01gX+rLS8KbnSGFj9Q=;
	b=Xg8KIn88zwHc/B3tvibj+yVf1vRdVQfmY4uLgkTgp9ix6aZhmWjJrf/5o0smegHIKSUv3rE490HvbMMl/V/oGu1un8T2GQxAkS1+A3tQHUb1zxpoz+PD69MI3xLzT+aM6cax6kcmJwdKv9kdfXoFm1tnOHFJz37rRvdpV/Cd2j8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7qooJc_1717496289;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7qooJc_1717496289)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 18:18:09 +0800
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
Subject: [PATCH v4 5/6] mm: shmem: add mTHP size alignment in shmem_get_unmapped_area
Date: Tue,  4 Jun 2024 18:17:49 +0800
Message-Id: <1d2f719d558d5c789c4cceebdaac42a814e8f107.1717495894.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
References: <cover.1717495894.git.baolin.wang@linux.alibaba.com>
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
index 9a8533482208..2ecc41521dbb 100644
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
+			hpage_orders = READ_ONCE(huge_anon_shmem_orders_always);
+			hpage_orders |= READ_ONCE(huge_anon_shmem_orders_within_size);
+			hpage_orders |= READ_ONCE(huge_anon_shmem_orders_madvise);
+			if (SHMEM_SB(sb)->huge != SHMEM_HUGE_NEVER)
+				hpage_orders |= READ_ONCE(huge_anon_shmem_orders_inherit);
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


