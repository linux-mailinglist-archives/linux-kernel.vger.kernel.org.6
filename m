Return-Path: <linux-kernel+bounces-354529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5E6993EAB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A362B20E4D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EFB17995E;
	Tue,  8 Oct 2024 06:18:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D113AA47
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368307; cv=none; b=NS8sILDX1FURLN1pun+uFXu5Ne1JZvhY9jO7TxprXDUQZt4kYT/tORDjZSYoD/Ff/IHfUQ0SUnsKMkldBWfWbWw035bxopDd/wzOiG5GXcPF1FHCwfRbMVDta5zdvQTk/pMoLaFgn8czu/m/MTtpq/2ec4112cxHYkvbL2f95Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368307; c=relaxed/simple;
	bh=N32P+d4hMhLobPDqT7RJO/7/otDqGCIEPXjh7ObafuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ArzwdoPLyb/4TfJ+DTAvmRuUdWIxbTmYlu6RUnWHkPqLnY2459mSO0KTWbUldYgm+pF046ZVs6sREdblrq5RJmO3uRBTP+jl7fWVt6DHeR3UtkKvcw3XXlmVJ93QwGR2R7UFiYsmeqdX8DCCPPXmpDl6Cy4TPf4ZzUg83hEmxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B0C4DA7;
	Mon,  7 Oct 2024 23:18:55 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.43.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8AA563F73F;
	Mon,  7 Oct 2024 23:18:16 -0700 (PDT)
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
Subject: [PATCH v7 2/2] mm: Allocate THP on hugezeropage wp-fault
Date: Tue,  8 Oct 2024 11:47:46 +0530
Message-Id: <20241008061746.285961-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008061746.285961-1-dev.jain@arm.com>
References: <20241008061746.285961-1-dev.jain@arm.com>
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

Acked-by: David Hildenbrand <david@redhat.com> 
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com> 
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/huge_memory.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e21c4f759e00..606ed782a15a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1790,6 +1790,38 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
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
+	if (unlikely(!folio))
+		return VM_FAULT_FALLBACK;
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
+	return ret;
+}
+
 vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 {
 	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
@@ -1802,8 +1834,15 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
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


