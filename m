Return-Path: <linux-kernel+bounces-324102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA259747EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555C01F26199
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF2224CF;
	Wed, 11 Sep 2024 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iZZ8olVN"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE081CF92
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018964; cv=none; b=W+Scb19gXWfdRjIbLUEMdjhZTZTtbQryIZAgiLBISV7L1nYu7mihtI/hn6XlduoZxeLIjDLxAWpXIzzOeAcdXsDQZ16qJVmJdcfdl5WeipQNzOzs/ZasUq9sTrJ6TmXNJajZ1zZcM6T2nEV1U6misKbQ5x4LcbWSXaUUdMZKFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018964; c=relaxed/simple;
	bh=xHvx3A6s4hakklFSJT/IZMnsgdHT+nsQQQ690tZlHzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d91HOSZBEo93RrkF4iLdoGP5C6oH0lvW7r5JJ2aLPqZLrUevgL6WdwY323rz3g9UUKQoimvwbFOLyOV3BWuKtZPVaXjZhPQ3dft59udMJbJislad3Le32K/xf4ZIRhH85fdLy6f9HOutjA/HB1Pnp9Kb9ajGVZy7qwZx36Msqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iZZ8olVN; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726018958; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=DfCL37UysHfNkqniIfqYNCGqdfKJNSoWCe1sTKj/AZ0=;
	b=iZZ8olVNC7QowgL7hC0+TzojkmQ5NMkDFsXozVUfLVz+Yx1toDvK7GwtvlvDV8SwYSuMJHWamsoGPAptsrkZsxAHVOpBVexVmG+/EybzTlxSyuglWBGnA+DrIhgbGHTN0Kb2fIsJV2UrEm5rJX6IzVcKIy3bP02/WdgnJwN9Mws=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WEm09Ww_1726018957)
          by smtp.aliyun-inc.com;
          Wed, 11 Sep 2024 09:42:38 +0800
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
Subject: [PATCH v2] mm: shmem: fix khugepaged activation policy for shmem
Date: Wed, 11 Sep 2024 09:42:30 +0800
Message-Id: <bc8e7e2d6306e561fbd2217df52f083eb5839c27.1726018044.git.baolin.wang@linux.alibaba.com>
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
index f9c39898eaff..ee4dd03bf7d4 100644
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
+	if (shmem_hpage_pmd_enabled())
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


