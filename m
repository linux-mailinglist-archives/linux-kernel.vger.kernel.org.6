Return-Path: <linux-kernel+bounces-520059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CACA3A52B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBE3189545D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3128137D;
	Tue, 18 Feb 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nf6qYb3t"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4417A2EA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902651; cv=none; b=YeyQLzBf7jKCr87t7HO27rpjLui3yMJGNsIqVNZUTkybF/eSTSQjLWzUVR0arkuw09YFAPVn044sxfQE+OAZ9pbHR4H0NC+MDbbn0h0X9O1g/iVlJK7Xao9yFv7odunW+ES53MhNnGhLsGqiY0yUKen6RwFVy9yhC/DL22R4zNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902651; c=relaxed/simple;
	bh=eyNUEg3UMMVJHFSq4sCMnhysZx7HdsE7puplnk5S9pU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZiGs6FofsMU2DGQKQanaOk3XufHQVS/aU5w3h8VV1bgUsrj4Ytx3W5nT8ZlGgpMvd9BQpJAqyI4eDrb7tL0CevOzETQj2ENtGHjRj2LrPWbIMnf2jw6E24y/yrWkUnKPJi4mZm6Zq8UgPNiyM/p6r6QXsIdxd98ZCTDgyLNxIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nf6qYb3t; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22109f29c99so66174145ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902649; x=1740507449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndjpqFzmue1FVYKX2ILaxRtTculNzXNDNbdJe9j9peI=;
        b=nf6qYb3t5GhBXMQwnDbwlcPzXZwJv0/whHxR3lfscyYmTt7zGjhxEz3UMbVGI8fORi
         av7olXyGdWWMjnEjA4Y+HKwiBWCEpCgQNH9hjojEm0LRFsbvEexhs8U8gSUTvl/FATHG
         YxgSltDqDf2qbK59wzRhiC4htm/Zm5y0Lv/trjX7tXFMJZddtIyWCcOLQ65gtxQRjaDr
         LHWrCtp67cU/QK4yBV7Gc8KteCBYqLJ41WNQ0X/BTHBkUlQ1gUM7PbTNtjG/8DvSj5Pm
         jn1p/PTgZKxqLnTQL+1ojA8OZEK9zV6oP0KsS6wmaDpWBctII1keq0jnePy2ARCbyRq0
         X2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902649; x=1740507449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndjpqFzmue1FVYKX2ILaxRtTculNzXNDNbdJe9j9peI=;
        b=uGZ43octFR3Pjkq4R1byzVmR+wPCrV64jrp9NEvmdOSGuZGbpsfGDmoMSkA+Hz96zR
         H6yIvoJAxwOCJ4xsMxYZzFZWW1tYQb9X0xUAabK/J3JWAjaOWKBibLbVC17/e3DWgaZe
         odFWAySETq3ugKtI5uGoTQt51AouM06A6p0hXvZIK30Ilpkd0JBTZBA1D/3323NS57jB
         d2MiNnAy0m3VE7FZzTtoxXrpMYExDt1K6qetAuc887neAkA3czEyKmsS45C6k1R16uNT
         do9WB9JGAVaaE7SG9fUOAIhWjG0RJ9nEtHyHuM4GDXXAERAiDISahRmwHPI7VgUCRgR8
         KcQg==
X-Forwarded-Encrypted: i=1; AJvYcCWVF83gF2tBAOtY0IaZn7bnMKFHoRwA1ZVurEaDjksJ1ydDIp5C4cz9WPEK+Y8+0FiWuIrkAGFlS/uDAD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb8DhXjIfyD8esNau3GFjgmDiaTaAFskCrl+GJIKlnZqgG4Rre
	bfuf2VN4qsaXoAUWN7EP6OOmNU7EkAvgzA/u1nv9X6XjbdJZ/qkm9shkDexQyxepaXFj3A==
X-Google-Smtp-Source: AGHT+IFy/y4SdHiSsCJxJvo+FEGoVCcMZnIS41yIyMZQQV2TA0dYBg625jQNShPtSAzKdBaABpM16dqb
X-Received: from pfbcv8.prod.google.com ([2002:a05:6a00:44c8:b0:730:796b:a54a])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7289:b0:1ee:c598:7a90
 with SMTP id adf61e73a8af0-1eec5987d29mr6917388637.39.1739902648950; Tue, 18
 Feb 2025 10:17:28 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:42 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-15-fvdl@google.com>
Subject: [PATCH v4 14/27] mm/sparse: add vmemmap_*_hvo functions
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a few functions to enable early HVO:

vmemmap_populate_hvo
vmemmap_undo_hvo
vmemmap_wrprotect_hvo

The populate and undo functions are expected to be used in early
init, from the sparse_init_nid_early() function. The wrprotect
function is to be used, potentially, later.

To implement these functions, mostly re-use the existing
compound pages vmemmap logic used by DAX. vmemmap_populate_address
has its argument changed a bit in this commit: the page structure
passed in to be reused in the mapping is replaced by a PFN and a
flag. The flag indicates whether an extra ref should be taken on
the vmemmap page containing the head page structure. Taking the
ref is appropriate to for DAX / ZONE_DEVICE, but not for HugeTLB
HVO.

The HugeTLB vmemmap optimization maps tail page structure pages
read-only. The vmemmap_wrprotect_hvo function that does this is
implemented separately, because it cannot be guaranteed that reserved
page structures will not be write accessed during memory initialization.
Even with CONFIG_DEFERRED_STRUCT_PAGE_INIT, they might still be
written to (if they are at the bottom of a zone). So,
vmemmap_populate_hvo leaves the tail page structure pages RW initially,
and then later during initialization, after memmap init is fully done,
vmemmap_wrprotect_hvo must be called to finish the job.

Subsequent commits will use these functions for early HugeTLB HVO.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/mm.h  |   9 ++-
 mm/sparse-vmemmap.c | 141 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 135 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index df83653ed6e3..0463c062fd7a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3837,7 +3837,8 @@ p4d_t *vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node);
 pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
 pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
 pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
-			    struct vmem_altmap *altmap, struct page *reuse);
+			    struct vmem_altmap *altmap, unsigned long ptpfn,
+			    unsigned long flags);
 void *vmemmap_alloc_block(unsigned long size, int node);
 struct vmem_altmap;
 void *vmemmap_alloc_block_buf(unsigned long size, int node,
@@ -3853,6 +3854,12 @@ int vmemmap_populate_hugepages(unsigned long start, unsigned long end,
 			       int node, struct vmem_altmap *altmap);
 int vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap);
+int vmemmap_populate_hvo(unsigned long start, unsigned long end, int node,
+			 unsigned long headsize);
+int vmemmap_undo_hvo(unsigned long start, unsigned long end, int node,
+		     unsigned long headsize);
+void vmemmap_wrprotect_hvo(unsigned long start, unsigned long end, int node,
+			  unsigned long headsize);
 void vmemmap_populate_print_last(void);
 #ifdef CONFIG_MEMORY_HOTPLUG
 void vmemmap_free(unsigned long start, unsigned long end,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 8751c46c35e4..8cc848c4b17c 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -30,6 +30,13 @@
 
 #include <asm/dma.h>
 #include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+
+/*
+ * Flags for vmemmap_populate_range and friends.
+ */
+/* Get a ref on the head page struct page, for ZONE_DEVICE compound pages */
+#define VMEMMAP_POPULATE_PAGEREF	0x0001
 
 #include "internal.h"
 
@@ -144,17 +151,18 @@ void __meminit vmemmap_verify(pte_t *pte, int node,
 
 pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 				       struct vmem_altmap *altmap,
-				       struct page *reuse)
+				       unsigned long ptpfn, unsigned long flags)
 {
 	pte_t *pte = pte_offset_kernel(pmd, addr);
 	if (pte_none(ptep_get(pte))) {
 		pte_t entry;
 		void *p;
 
-		if (!reuse) {
+		if (ptpfn == (unsigned long)-1) {
 			p = vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
 			if (!p)
 				return NULL;
+			ptpfn = PHYS_PFN(__pa(p));
 		} else {
 			/*
 			 * When a PTE/PMD entry is freed from the init_mm
@@ -165,10 +173,10 @@ pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 			 * and through vmemmap_populate_compound_pages() when
 			 * slab is available.
 			 */
-			get_page(reuse);
-			p = page_to_virt(reuse);
+			if (flags & VMEMMAP_POPULATE_PAGEREF)
+				get_page(pfn_to_page(ptpfn));
 		}
-		entry = pfn_pte(__pa(p) >> PAGE_SHIFT, PAGE_KERNEL);
+		entry = pfn_pte(ptpfn, PAGE_KERNEL);
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
 	return pte;
@@ -238,7 +246,8 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 
 static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 					      struct vmem_altmap *altmap,
-					      struct page *reuse)
+					      unsigned long ptpfn,
+					      unsigned long flags)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -258,7 +267,7 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 	pmd = vmemmap_pmd_populate(pud, addr, node);
 	if (!pmd)
 		return NULL;
-	pte = vmemmap_pte_populate(pmd, addr, node, altmap, reuse);
+	pte = vmemmap_pte_populate(pmd, addr, node, altmap, ptpfn, flags);
 	if (!pte)
 		return NULL;
 	vmemmap_verify(pte, node, addr, addr + PAGE_SIZE);
@@ -269,13 +278,15 @@ static pte_t * __meminit vmemmap_populate_address(unsigned long addr, int node,
 static int __meminit vmemmap_populate_range(unsigned long start,
 					    unsigned long end, int node,
 					    struct vmem_altmap *altmap,
-					    struct page *reuse)
+					    unsigned long ptpfn,
+					    unsigned long flags)
 {
 	unsigned long addr = start;
 	pte_t *pte;
 
 	for (; addr < end; addr += PAGE_SIZE) {
-		pte = vmemmap_populate_address(addr, node, altmap, reuse);
+		pte = vmemmap_populate_address(addr, node, altmap,
+					       ptpfn, flags);
 		if (!pte)
 			return -ENOMEM;
 	}
@@ -286,7 +297,107 @@ static int __meminit vmemmap_populate_range(unsigned long start,
 int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
 					 int node, struct vmem_altmap *altmap)
 {
-	return vmemmap_populate_range(start, end, node, altmap, NULL);
+	return vmemmap_populate_range(start, end, node, altmap, -1, 0);
+}
+
+/*
+ * Undo populate_hvo, and replace it with a normal base page mapping.
+ * Used in memory init in case a HVO mapping needs to be undone.
+ *
+ * This can happen when it is discovered that a memblock allocated
+ * hugetlb page spans multiple zones, which can only be verified
+ * after zones have been initialized.
+ *
+ * We know that:
+ * 1) The first @headsize / PAGE_SIZE vmemmap pages were individually
+ *    allocated through memblock, and mapped.
+ *
+ * 2) The rest of the vmemmap pages are mirrors of the last head page.
+ */
+int __meminit vmemmap_undo_hvo(unsigned long addr, unsigned long end,
+				      int node, unsigned long headsize)
+{
+	unsigned long maddr, pfn;
+	pte_t *pte;
+	int headpages;
+
+	/*
+	 * Should only be called early in boot, so nothing will
+	 * be accessing these page structures.
+	 */
+	WARN_ON(!early_boot_irqs_disabled);
+
+	headpages = headsize >> PAGE_SHIFT;
+
+	/*
+	 * Clear mirrored mappings for tail page structs.
+	 */
+	for (maddr = addr + headsize; maddr < end; maddr += PAGE_SIZE) {
+		pte = virt_to_kpte(maddr);
+		pte_clear(&init_mm, maddr, pte);
+	}
+
+	/*
+	 * Clear and free mappings for head page and first tail page
+	 * structs.
+	 */
+	for (maddr = addr; headpages-- > 0; maddr += PAGE_SIZE) {
+		pte = virt_to_kpte(maddr);
+		pfn = pte_pfn(ptep_get(pte));
+		pte_clear(&init_mm, maddr, pte);
+		memblock_phys_free(PFN_PHYS(pfn), PAGE_SIZE);
+	}
+
+	flush_tlb_kernel_range(addr, end);
+
+	return vmemmap_populate(addr, end, node, NULL);
+}
+
+/*
+ * Write protect the mirrored tail page structs for HVO. This will be
+ * called from the hugetlb code when gathering and initializing the
+ * memblock allocated gigantic pages. The write protect can't be
+ * done earlier, since it can't be guaranteed that the reserved
+ * page structures will not be written to during initialization,
+ * even if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled.
+ *
+ * The PTEs are known to exist, and nothing else should be touching
+ * these pages. The caller is responsible for any TLB flushing.
+ */
+void vmemmap_wrprotect_hvo(unsigned long addr, unsigned long end,
+				    int node, unsigned long headsize)
+{
+	unsigned long maddr;
+	pte_t *pte;
+
+	for (maddr = addr + headsize; maddr < end; maddr += PAGE_SIZE) {
+		pte = virt_to_kpte(maddr);
+		ptep_set_wrprotect(&init_mm, maddr, pte);
+	}
+}
+
+/*
+ * Populate vmemmap pages HVO-style. The first page contains the head
+ * page and needed tail pages, the other ones are mirrors of the first
+ * page.
+ */
+int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
+				       int node, unsigned long headsize)
+{
+	pte_t *pte;
+	unsigned long maddr;
+
+	for (maddr = addr; maddr < addr + headsize; maddr += PAGE_SIZE) {
+		pte = vmemmap_populate_address(maddr, node, NULL, -1, 0);
+		if (!pte)
+			return -ENOMEM;
+	}
+
+	/*
+	 * Reuse the last page struct page mapped above for the rest.
+	 */
+	return vmemmap_populate_range(maddr, end, node, NULL,
+					pte_pfn(ptep_get(pte)), 0);
 }
 
 void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
@@ -409,7 +520,8 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 * with just tail struct pages.
 		 */
 		return vmemmap_populate_range(start, end, node, NULL,
-					      pte_page(ptep_get(pte)));
+					      pte_pfn(ptep_get(pte)),
+					      VMEMMAP_POPULATE_PAGEREF);
 	}
 
 	size = min(end - start, pgmap_vmemmap_nr(pgmap) * sizeof(struct page));
@@ -417,13 +529,13 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		unsigned long next, last = addr + size;
 
 		/* Populate the head page vmemmap page */
-		pte = vmemmap_populate_address(addr, node, NULL, NULL);
+		pte = vmemmap_populate_address(addr, node, NULL, -1, 0);
 		if (!pte)
 			return -ENOMEM;
 
 		/* Populate the tail pages vmemmap page */
 		next = addr + PAGE_SIZE;
-		pte = vmemmap_populate_address(next, node, NULL, NULL);
+		pte = vmemmap_populate_address(next, node, NULL, -1, 0);
 		if (!pte)
 			return -ENOMEM;
 
@@ -433,7 +545,8 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 		 */
 		next += PAGE_SIZE;
 		rc = vmemmap_populate_range(next, last, node, NULL,
-					    pte_page(ptep_get(pte)));
+					    pte_pfn(ptep_get(pte)),
+					    VMEMMAP_POPULATE_PAGEREF);
 		if (rc)
 			return -ENOMEM;
 	}
-- 
2.48.1.601.g30ceb7b040-goog


