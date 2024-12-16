Return-Path: <linux-kernel+bounces-447763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1195E9F36C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FBF16B03B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E6820D4E4;
	Mon, 16 Dec 2024 16:51:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F241207DF1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367919; cv=none; b=VO3DKMtHJlxE6QEsjyGIT0ulbAEG5IrQQnASR1f62fbYkQT352rjhHI4MBn42IQACc83jR2O31kfkJfj5kCSUStmB6pxegQSKhSR/Rq4TBiGve75a2L2WTnnD2bme6tLzqNfKMPHDSTuPDKrn2PttTMqq94QW9dOx1yWPox1aN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367919; c=relaxed/simple;
	bh=mq5qjwjE+ui40jJfnEACvGFzl1xWmIFAoM5IxTU3rAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dN852zo271KdHfcf24Z5svPg7YkwcAVgdH1Z9crboYlINhheKTDaCWFAbCwjNh2YUr0RnHBQMd0kz36tMz0mBppLwG7nJag+5V8VFSYDbWHmsLYUWGjvSiB5gaJq3S92vs2IdYMefn68HJBCWYjhUlQJ4FqRlN1SNgDovUB1vBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C211B1692;
	Mon, 16 Dec 2024 08:52:24 -0800 (PST)
Received: from K4MQJ0H1H2.arm.com (unknown [10.163.78.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E60D3F528;
	Mon, 16 Dec 2024 08:51:45 -0800 (PST)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	jack@suse.cz,
	srivatsa@csail.mit.edu,
	haowenchao22@gmail.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	jglisse@google.com,
	surenb@google.com,
	vishal.moola@gmail.com,
	zokeefe@google.com,
	zhengqi.arch@bytedance.com,
	jhubbard@nvidia.com,
	21cnbao@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [RFC PATCH 02/12] khugepaged: Generalize alloc_charge_folio()
Date: Mon, 16 Dec 2024 22:20:55 +0530
Message-Id: <20241216165105.56185-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241216165105.56185-1-dev.jain@arm.com>
References: <20241216165105.56185-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass order to alloc_charge_folio() and update mTHP statistics.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 include/linux/huge_mm.h |  2 ++
 mm/huge_memory.c        |  4 ++++
 mm/khugepaged.c         | 13 +++++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 93e509b6c00e..8b6d0fed99b3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -119,6 +119,8 @@ enum mthp_stat_item {
 	MTHP_STAT_ANON_FAULT_ALLOC,
 	MTHP_STAT_ANON_FAULT_FALLBACK,
 	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	MTHP_STAT_ANON_COLLAPSE_ALLOC,
+	MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED,
 	MTHP_STAT_ZSWPOUT,
 	MTHP_STAT_SWPIN,
 	MTHP_STAT_SWPIN_FALLBACK,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2da5520bfe24..2e582fad4c77 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -615,6 +615,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
 DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+DEFINE_MTHP_STAT_ATTR(anon_collapse_alloc, MTHP_STAT_ANON_COLLAPSE_ALLOC);
+DEFINE_MTHP_STAT_ATTR(anon_collapse_alloc_failed, MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);
 DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
 DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
 DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
@@ -636,6 +638,8 @@ static struct attribute *anon_stats_attrs[] = {
 	&anon_fault_alloc_attr.attr,
 	&anon_fault_fallback_attr.attr,
 	&anon_fault_fallback_charge_attr.attr,
+	&anon_collapse_alloc_attr.attr,
+	&anon_collapse_alloc_failed_attr.attr,
 #ifndef CONFIG_SHMEM
 	&zswpout_attr.attr,
 	&swpin_attr.attr,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 95643e6e5f31..02cd424b8e48 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1073,21 +1073,26 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 }
 
 static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
-			      struct collapse_control *cc)
+			      int order, struct collapse_control *cc)
 {
 	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
 		     GFP_TRANSHUGE);
 	int node = hpage_collapse_find_target_node(cc);
 	struct folio *folio;
 
-	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
+	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
 	if (!folio) {
 		*foliop = NULL;
 		count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
+		if (order != HPAGE_PMD_ORDER)
+			count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC_FAILED);
 		return SCAN_ALLOC_HUGE_PAGE_FAIL;
 	}
 
 	count_vm_event(THP_COLLAPSE_ALLOC);
+	if (order != HPAGE_PMD_ORDER)
+		count_mthp_stat(order, MTHP_STAT_ANON_COLLAPSE_ALLOC);
+
 	if (unlikely(mem_cgroup_charge(folio, mm, gfp))) {
 		folio_put(folio);
 		*foliop = NULL;
@@ -1124,7 +1129,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 */
 	mmap_read_unlock(mm);
 
-	result = alloc_charge_folio(&folio, mm, cc);
+	result = alloc_charge_folio(&folio, mm, order, cc);
 	if (result != SCAN_SUCCEED)
 		goto out_nolock;
 
@@ -1850,7 +1855,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
 
-	result = alloc_charge_folio(&new_folio, mm, cc);
+	result = alloc_charge_folio(&new_folio, mm, HPAGE_PMD_ORDER, cc);
 	if (result != SCAN_SUCCEED)
 		goto out;
 
-- 
2.30.2


