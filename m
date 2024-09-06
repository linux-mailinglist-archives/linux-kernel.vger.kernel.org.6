Return-Path: <linux-kernel+bounces-318157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62AE96E941
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7E1284A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3A3823DE;
	Fri,  6 Sep 2024 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RgjjMUgS"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82501805A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 05:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725600523; cv=none; b=R1J3/o4AppfvtUA5XWwy0w9J60YdWFoZfzVBkJXuDe8Eh0Iwnasbq294bBlJGnWNVFB7Uw7IRiVgp+VVAyEtsky9xr++Wnb3tP4PU3wYJnRKVUi5nMdVsHLtSQWTRYRY6qBAzOZNE+fkDLjz4CZGrXoyxnKMuzzbxcvE8W3To3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725600523; c=relaxed/simple;
	bh=P8NzR1clZZHvq168490j+k6VhlPtn3NzB9PTUUKGTrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bD8JeBBxseAsSCLqKTQ9nxxHod3VY895FmLl8DxNOtaCQ19bmIsl/h36hXlzfzaaUuF2RRMQt4cbUTPfM96Agwt2fO95jKJofUxguT+K+sKvfioE6sXDBtRwFsHvya0TgxZBYatv6uFMuOYiH1t0JztjtfBTpPko6oROu06hxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RgjjMUgS; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725600517; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=B59qOTQ5B/DlCcvhL+utjjELqTBP0dtzxxRmP6Grzk4=;
	b=RgjjMUgSpMjTIS/K9iWKiNvlyIQaT+0h0uwPzqWeeqC9ZLKjDQCZFJo2vZBvGWfmjiqecAm319j4RUrVQnOTNvnSJz4Pf3rWWWXSWg1qZ/j8MmBIQeE6mR24ew9nfQhg/tKo7z/jfH6e5JDp7Jl558yRR2xXDQxqCLW3b9S+DLU=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WEOJP-i_1725600516)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 13:28:37 +0800
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
Subject: [PATCH] mm: shmem: fix khugepaged activation policy for shmem
Date: Fri,  6 Sep 2024 13:28:23 +0800
Message-Id: <7c796904528e21152ba5aa639e963e0ae45b7040.1725600217.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
---
Hi Ryan,

I remember we discussed the shmem khugepaged activation issue before, but
I haven’t seen any follow-up patches to fix it. Recently, I am trying to
fix the shmem mTHP collapse issue in the series [1], and I also addressed
this activation issue. Please correct me if you have a better idea. Thanks.

[1] https://lore.kernel.org/all/cover.1724140601.git.baolin.wang@linux.alibaba.com/T/#u
---
 include/linux/shmem_fs.h |  6 ++++++
 mm/khugepaged.c          |  2 ++
 mm/shmem.c               | 29 +++++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

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
index f9c39898eaff..caf10096d4d1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -430,6 +430,8 @@ static bool hugepage_pmd_enabled(void)
 	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
 	    hugepage_global_enabled())
 		return true;
+	if (shmem_hpage_pmd_enabled())
+		return true;
 	return false;
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 74f093d88c78..d7c342ae2b37 100644
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


