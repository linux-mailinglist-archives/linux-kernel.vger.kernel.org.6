Return-Path: <linux-kernel+bounces-173001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26BF8BF9E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5ACB1C20E11
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919327BB1B;
	Wed,  8 May 2024 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sOWryHtG"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF67BAF0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162195; cv=none; b=XPzoLEneKtRbm01VwFbyb8J8dhENjnx6POcFOnBjO6CaC5ggFbF7OgADn+Z/hSxZ4QzkaE6PhXxVWE7O8UVhzmTecowTvWnaEzRYrqesipLWJDC7jY2BNYDtiZN7KK21NDW+WRHCSa9khlB0ZyVZKR01HBFzJbmSY5wy/0gvQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162195; c=relaxed/simple;
	bh=zT3260cOojJ9YkJT42xnisTrezwzaldkD24iYYJXwwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QiiqpQCjWceF4DGQR5P28yP5td/xhrTWLJDFz+3JPFZ6Qfmu0mOGQba52Yqx0SZPGkKHMWXGNsD8FU5JdcS6LCZxgnf9WnCyT/y3zJDtyIJiSTVTMqdGA3K8qL97Lkeq2jkDlT4P7D/7goucpK+/BkJ2VB9T+jakVlNsWJjR0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sOWryHtG; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715162191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bLQ4gptvM3L1QRVzQ/kljeJWLtVefD+oipqeUeshP8=;
	b=sOWryHtG3kXzk2QHXqC3vWzkFP+FlHnR4lQWZKayTg4D2xGZnkjYjf+0j5aWmIgXNvd7zT
	2QTe1nDeX5MKcr4QGAkBy3rzDwzo0dDxHfeOb8oJM+xxOXS9rkqgLYVByDvnSqwIxXy2bs
	iLs3tqru3cEhRFU15/Fg6ROIvd2+Gv8=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Wed, 08 May 2024 17:55:39 +0800
Subject: [PATCH 2/4] mm/ksm: fix ksm_zero_pages accounting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-b4-ksm-counters-v1-2-e2a9b13f70c5@linux.dev>
References: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
In-Reply-To: <20240508-b4-ksm-counters-v1-0-e2a9b13f70c5@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, 
 xu xin <xu.xin16@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715162174; l=4898;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=zT3260cOojJ9YkJT42xnisTrezwzaldkD24iYYJXwwo=;
 b=pw9F/6MfqwjmEILvTY9Kw8kVwDgxLbZH1bNRvo778ZsSVX+2PHfvvqg43hSoNnMZZzZZRsU89
 AoIeAp0psC8AQfATubxnDjo3cEl5nWUpcfboQr/FSoASz3WAK8siagH
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

We normally ksm_zero_pages++ in ksmd when page is merged with zero page,
but ksm_zero_pages-- is done from page tables side, which can't protected
by the ksmd mutex.

So we can read very exceptional value of ksm_zero_pages in rare cases,
such as -1, which is very confusing to users.

Fix it by changing to use atomic_long_t, and the same case with the
mm->ksm_zero_pages.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 fs/proc/base.c           |  2 +-
 include/linux/ksm.h      | 22 +++++++++++++++++++---
 include/linux/mm_types.h |  2 +-
 mm/ksm.c                 | 11 +++++------
 4 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 18550c071d71..72a1acd03675 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3214,7 +3214,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 	mm = get_task_mm(task);
 	if (mm) {
 		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
-		seq_printf(m, "ksm_zero_pages %lu\n", mm->ksm_zero_pages);
+		seq_printf(m, "ksm_zero_pages %ld\n", mm_ksm_zero_pages(mm));
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
 		mmput(mm);
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 52c63a9c5a9c..bfc2cf756b0d 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -33,16 +33,32 @@ void __ksm_exit(struct mm_struct *mm);
  */
 #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
 
-extern unsigned long ksm_zero_pages;
+extern atomic_long_t ksm_zero_pages;
+
+static inline void ksm_map_zero_page(struct mm_struct *mm)
+{
+	atomic_long_inc(&ksm_zero_pages);
+	atomic_long_inc(&mm->ksm_zero_pages);
+}
 
 static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
 {
 	if (is_ksm_zero_pte(pte)) {
-		ksm_zero_pages--;
-		mm->ksm_zero_pages--;
+		atomic_long_dec(&ksm_zero_pages);
+		atomic_long_dec(&mm->ksm_zero_pages);
 	}
 }
 
+static inline long get_ksm_zero_pages(void)
+{
+	return atomic_long_read(&ksm_zero_pages);
+}
+
+static inline long mm_ksm_zero_pages(struct mm_struct *mm)
+{
+	return atomic_long_read(&mm->ksm_zero_pages);
+}
+
 static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	if (test_bit(MMF_VM_MERGEABLE, &oldmm->flags))
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 24323c7d0bd4..af3a0256fa93 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -985,7 +985,7 @@ struct mm_struct {
 		 * Represent how many empty pages are merged with kernel zero
 		 * pages when enabling KSM use_zero_pages.
 		 */
-		unsigned long ksm_zero_pages;
+		atomic_long_t ksm_zero_pages;
 #endif /* CONFIG_KSM */
 #ifdef CONFIG_LRU_GEN_WALKS_MMU
 		struct {
diff --git a/mm/ksm.c b/mm/ksm.c
index 0f9c491552ff..6e0dca3cecf3 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -296,7 +296,7 @@ static bool ksm_use_zero_pages __read_mostly;
 static bool ksm_smart_scan = true;
 
 /* The number of zero pages which is placed by KSM */
-unsigned long ksm_zero_pages;
+atomic_long_t ksm_zero_pages = ATOMIC_LONG_INIT(0);
 
 /* The number of pages that have been skipped due to "smart scanning" */
 static unsigned long ksm_pages_skipped;
@@ -1429,8 +1429,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		 * the dirty bit in zero page's PTE is set.
 		 */
 		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
-		ksm_zero_pages++;
-		mm->ksm_zero_pages++;
+		ksm_map_zero_page(mm);
 		/*
 		 * We're replacing an anonymous page with a zero page, which is
 		 * not anonymous. We need to do proper accounting otherwise we
@@ -3373,7 +3372,7 @@ static void wait_while_offlining(void)
 #ifdef CONFIG_PROC_FS
 long ksm_process_profit(struct mm_struct *mm)
 {
-	return (long)(mm->ksm_merging_pages + mm->ksm_zero_pages) * PAGE_SIZE -
+	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
 		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
 }
 #endif /* CONFIG_PROC_FS */
@@ -3662,7 +3661,7 @@ KSM_ATTR_RO(pages_skipped);
 static ssize_t ksm_zero_pages_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%ld\n", ksm_zero_pages);
+	return sysfs_emit(buf, "%ld\n", get_ksm_zero_pages());
 }
 KSM_ATTR_RO(ksm_zero_pages);
 
@@ -3671,7 +3670,7 @@ static ssize_t general_profit_show(struct kobject *kobj,
 {
 	long general_profit;
 
-	general_profit = (ksm_pages_sharing + ksm_zero_pages) * PAGE_SIZE -
+	general_profit = (ksm_pages_sharing + get_ksm_zero_pages()) * PAGE_SIZE -
 				ksm_rmap_items * sizeof(struct ksm_rmap_item);
 
 	return sysfs_emit(buf, "%ld\n", general_profit);

-- 
2.45.0


