Return-Path: <linux-kernel+bounces-336972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A71C98436F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6911C228C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2CA18C006;
	Tue, 24 Sep 2024 10:17:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B4189F5C
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173052; cv=none; b=OX1PgnpWdORjdnjVX7rSHaILz+q6WdgPueZdT6jWOMQZ1vjvRfT3B5yaZfLVHFOWxh7y/B2WNmLYn7sYyZAekdYexTkobktUJYznleecYhxJAyICHbQLu5my1n9iqgYslGBTy/CA0GN/0aHQv9AxIgd0tj9c1hjP/QJITj9423Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173052; c=relaxed/simple;
	bh=goBL+IoX0FbfYMYOX5LWOCWqh4ljzDqEM5t290OudUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPIqnsFuBM/l/TW7W/ZwenftPpmyOYvEAs1l3eVN7lYyreWbBcFw7kEu9vUhPd7T5kBbhPgLy4MIqHAio1Mp36Ug8iumf9Utco6L/EwAN/S3uIHptjhaUcqIPKtQ3MmFIhOSr5sJax7XRODVzuIIjzz2D05A+bGcRC3H7QF/BqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27785DA7;
	Tue, 24 Sep 2024 03:17:59 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B21BC3F528;
	Tue, 24 Sep 2024 03:17:20 -0700 (PDT)
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
Subject: [PATCH v5 2/2] mm: Allocate THP on hugezeropage wp-fault
Date: Tue, 24 Sep 2024 15:46:54 +0530
Message-Id: <20240924101654.1777697-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924101654.1777697-1-dev.jain@arm.com>
References: <20240924101654.1777697-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce do_huge_zero_wp_pmd() to handle wp-fault on a hugezeropage and
replace it with a PMD-mapped THP. Remember to flush TLB entry
corresponding to the hugezeropage. In case of failure, fallback
to splitting the PMD.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/huge_memory.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bdbf67c18f6c..fbb195bc2038 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1790,6 +1790,41 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
 	spin_unlock(vmf->ptl);
 }
 
+static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf)
+{
+	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	struct vm_area_struct *vma = vmf->vma;
+	struct mmu_notifier_range range;
+	struct folio *folio;
+	vm_fault_t ret = 0;
+
+	folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
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
+	(void)pmdp_huge_clear_flush(vma, haddr, vmf->pmd);
+	map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
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
@@ -1802,8 +1837,15 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
 	VM_BUG_ON_VMA(!vma->anon_vma, vma);
 
-	if (is_huge_zero_pmd(orig_pmd))
+	if (is_huge_zero_pmd(orig_pmd)) {
+		vm_fault_t ret = do_huge_zero_wp_pmd(vmf);
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


