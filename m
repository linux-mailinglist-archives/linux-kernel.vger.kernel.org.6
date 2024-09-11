Return-Path: <linux-kernel+bounces-324288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 063FF974AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F7A1C218C3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDFB1311AC;
	Wed, 11 Sep 2024 06:56:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14613C3F6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037802; cv=none; b=YEppWFTN1vRlEu4IuT7EtgCGvHXHz9f3j83sFputFe+cwW+pS6pHEi3S21xFZVMgLMF0AdmZZ0pLrWvBsxyhEa5eFJo0YjJA6P2rdnzoWNh+HdiBG/I5f2/XLTTrf4DePW/Zd/+G50Cge/t2nrH9IwP7x1LSxNcB/18kMk6URcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037802; c=relaxed/simple;
	bh=lv+fib3mtQD0w6eDiLk4K3STpScs2BIV+tEDwljlGU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RD9C8l6QUAkLlt2YBD8QFQlCVIZhWDOEyrLXlZAkkbvVCpDRcczv4r2TOEK29YpxLdFdopcuA1VL0quktqdzZYaHhUxOywOxc6HQ6C2nvUN5IJNeqrOD1pVNW08ZR3D+DOUK1h8sOwMFAnVqSCpFtpOkY5B/0rypVLcLoFiZXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FC911007;
	Tue, 10 Sep 2024 23:57:09 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.40.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E1A943F64C;
	Tue, 10 Sep 2024 23:56:30 -0700 (PDT)
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
	mark.rutland@arm.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	jglisse@google.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 2/2] mm: Allocate THP on hugezeropage wp-fault
Date: Wed, 11 Sep 2024 12:26:00 +0530
Message-Id: <20240911065600.1002644-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911065600.1002644-1-dev.jain@arm.com>
References: <20240911065600.1002644-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce do_huge_zero_wp_pmd() to handle wp-fault on a hugezeropage and
replace it with a PMD-mapped THP. Change the helper introduced in the
previous patch to flush TLB entry corresponding to the hugezeropage.
In case of failure, fallback to splitting the PMD.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/huge_memory.c | 52 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b96a1ff2bf40..3e28946a805f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -987,16 +987,20 @@ static void __pmd_thp_fault_success_stats(struct vm_area_struct *vma)
 static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
 			struct vm_area_struct *vma, unsigned long haddr)
 {
-	pmd_t entry;
+	pmd_t entry, old_pmd;
+	bool is_pmd_none = pmd_none(*vmf->pmd);
 
 	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
 	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
 	folio_add_lru_vma(folio, vma);
+	if (!is_pmd_none)
+		old_pmd = pmdp_huge_clear_flush(vma, haddr, vmf->pmd);
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-	mm_inc_nr_ptes(vma->vm_mm);
+	if (is_pmd_none)
+		mm_inc_nr_ptes(vma->vm_mm);
 }
 
 static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
@@ -1576,6 +1580,41 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
 	spin_unlock(vmf->ptl);
 }
 
+static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf, unsigned long haddr)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	gfp_t gfp = vma_thp_gfp_mask(vma);
+	struct mmu_notifier_range range;
+	struct folio *folio;
+	vm_fault_t ret = 0;
+
+	folio = pmd_thp_fault_alloc(gfp, vma, haddr, vmf->address);
+	if (unlikely(!folio)) {
+		ret = VM_FAULT_FALLBACK;
+		goto out;
+	}
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm, haddr,
+				haddr + HPAGE_PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd)))
+		goto release;
+	ret = check_stable_address_space(vma->vm_mm);
+	if (ret)
+		goto release;
+	map_pmd_thp(folio, vmf, vma, haddr);
+	__pmd_thp_fault_success_stats(vma);
+	goto unlock;
+release:
+	folio_put(folio);
+unlock:
+	spin_unlock(vmf->ptl);
+	mmu_notifier_invalidate_range_end(&range);
+out:
+	return ret;
+}
+
 vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 {
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
@@ -1588,8 +1627,15 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
 
-	if (is_huge_zero_pmd(orig_pmd))
+	if (is_huge_zero_pmd(orig_pmd)) {
+		vm_fault_t ret = do_huge_zero_wp_pmd(vmf, haddr);
+
+		if (!(ret & VM_FAULT_FALLBACK))
+			return ret;
+
+		/* Fallback to splitting PMD if THP cannot be allocated */
 		goto fallback;
+	}
 
 	spin_lock(vmf->ptl);
 
-- 
2.30.2


