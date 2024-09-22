Return-Path: <linux-kernel+bounces-335033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 407F397E023
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 06:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253C0B20F93
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 04:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C20155386;
	Sun, 22 Sep 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WOjH7m9p"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382038DE1
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726979555; cv=none; b=ra5zgHEfrFs57j5YN0pXeCcw2hSWUOHh3WTjSrk7tqSgsMbioqgF2SoinPb8jM8LPXuYVTUO5xAg82I2sb4X3W2CKRFZcLLks1R8DEQmgQpKnSgbgC6Ni2yZoOKzMs7ASvj+RhS+qeQvkCcOhMNdpQ4/YndqMlm6UtHS3iJl7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726979555; c=relaxed/simple;
	bh=Zfv9pRjJjmP2iGqVuCdA/ixB3jYJd6tnLMns0usLr4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2rMg71lpa07ijdS17UUrOKSYHVvZ0G4L+XC4EYNPi61CnwE5soLJA1C7gsxPWlsmg7vM6KziEol+DuxAXwYVSu6fcSXCecfwJ6TMwFJk9HfihPOU1egMbHRIX4OOL/R62IxS6U7wClpe9qyOlGEwu7zS2Akfpwfc0zJcNz3Yxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WOjH7m9p; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726979543; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AJIqkPeSg0kDGuLUkbSeWADD2GKVOIFf/Ecw0K1tnO0=;
	b=WOjH7m9p8skSPrJ/17XZZsmJSubNRoK/DAMM0psBTnvFe6S4IJOJyczDWhf5Uvb3pHX5XYPNVfFd01G/hsyj4n68Q6mPr/8zblI6Ogl2Toduq8A5g6ko+PRC1Iv/6Bm3sxkHmOHXSGSg7GsCyEPzay0B2Q1eHHbRMHqn+jf0fsk=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFPfeQH_1726979540)
          by smtp.aliyun-inc.com;
          Sun, 22 Sep 2024 12:32:21 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm: shmem: fix khugepaged activation policy for shmem
Date: Sun, 22 Sep 2024 12:32:13 +0800
Message-Id: <9b9c6cbc4499bf44c6455367fd9e0f6036525680.1726978977.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shmem has a separate interface (different from anonymous pages) to control
huge page allocation, that means shmem THP can be enabled while anonymous
THP is disabled. However, in this case, khugepaged will not start to collapse
shmem THP, which is unreasonable.

To fix this issue, we should call start_stop_khugepaged() to activate or
deactivate the khugepaged thread when setting shmem mTHP interfaces.
Moreover, add a new helper shmem_hpage_pmd_enabled() to help to check
whether shmem THP is enabled, which will determine if khugepaged should
be activated.

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
Changes from v2:
 - Fix building errors reported by kernel test robot.
Changes from v1:
 - Add reviewed tag from Ryan. Thanks.
 - Add some shmem comments per Ryan.
---
 include/linux/shmem_fs.h |  6 ++++++
 mm/khugepaged.c          |  6 +++++-
 mm/shmem.c               | 29 +++++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 515a9a6a3c6f..ee6635052383 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -114,6 +114,7 @@ int shmem_unuse(unsigned int type);
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
 				loff_t write_end, bool shmem_huge_force);
+bool shmem_hpage_pmd_enabled(void);
 #else
 static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
@@ -121,6 +122,11 @@ static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
 {
 	return 0;
 }
+
+static inline bool shmem_hpage_pmd_enabled(void)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_SHMEM
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f9c39898eaff..feb101f465c6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -416,9 +416,11 @@ static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
 static bool hugepage_pmd_enabled(void)
 {
 	/*
-	 * We cover both the anon and the file-backed case here; file-backed
+	 * We cover the anon, shmem and the file-backed case here; file-backed
 	 * hugepages, when configured in, are determined by the global control.
 	 * Anon pmd-sized hugepages are determined by the pmd-size control.
+	 * Shmem pmd-sized hugepages are also determined by its pmd-size control,
+	 * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
 	 */
 	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
 	    hugepage_global_enabled())
@@ -430,6 +432,8 @@ static bool hugepage_pmd_enabled(void)
 	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
 	    hugepage_global_enabled())
 		return true;
+	if (IS_ENABLED(CONFIG_SHMEM) && shmem_hpage_pmd_enabled())
+		return true;
 	return false;
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 361affdf3990..181b1b051070 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1653,6 +1653,23 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+bool shmem_hpage_pmd_enabled(void)
+{
+	if (shmem_huge == SHMEM_HUGE_DENY)
+		return false;
+	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_always))
+		return true;
+	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_madvise))
+		return true;
+	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_within_size))
+		return true;
+	if (test_bit(HPAGE_PMD_ORDER, &huge_shmem_orders_inherit) &&
+	    shmem_huge != SHMEM_HUGE_NEVER)
+		return true;
+
+	return false;
+}
+
 unsigned long shmem_allowable_huge_orders(struct inode *inode,
 				struct vm_area_struct *vma, pgoff_t index,
 				loff_t write_end, bool shmem_huge_force)
@@ -5036,7 +5053,7 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
 		struct kobj_attribute *attr, const char *buf, size_t count)
 {
 	char tmp[16];
-	int huge;
+	int huge, err;
 
 	if (count + 1 > sizeof(tmp))
 		return -EINVAL;
@@ -5060,7 +5077,9 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
 	shmem_huge = huge;
 	if (shmem_huge > SHMEM_HUGE_DENY)
 		SHMEM_SB(shm_mnt->mnt_sb)->huge = shmem_huge;
-	return count;
+
+	err = start_stop_khugepaged();
+	return err ? err : count;
 }
 
 struct kobj_attribute shmem_enabled_attr = __ATTR_RW(shmem_enabled);
@@ -5137,6 +5156,12 @@ static ssize_t thpsize_shmem_enabled_store(struct kobject *kobj,
 		ret = -EINVAL;
 	}
 
+	if (ret > 0) {
+		int err = start_stop_khugepaged();
+
+		if (err)
+			ret = err;
+	}
 	return ret;
 }
 
-- 
2.39.3


