Return-Path: <linux-kernel+bounces-302182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9DD95FAE5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B197F288857
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D019DF65;
	Mon, 26 Aug 2024 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ewhu568i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B01A0724
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705073; cv=none; b=d5Bv5ZefMMEMOqplBZOLk+khfcpbcCKfDaiSUsTOoXuWRMFFcBZPZKzRo5Ltpx8cR35greogeuGtAK8luAc59ERH3KhTB+V47SW4HOQ0CyQiPNcrVbhh2AzLXFE6CrEJ5Ewp3garZ98OrsBP1LThjP1bVkm33hGaFeSDa605Ejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705073; c=relaxed/simple;
	bh=Eh2leUymwhy+QIbtX8/+/NdJiGHoDFC3uu2OHYBcoWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foYLCKY+LPR7bntjhVyzQGe3EcXwDy3hjLV/xg8/ESLnnIcQPhyWHdWnSggDyt9jtntB0cAh7BbJ+yInyEOaZQgUUUDGSvy48KBIVzfoT/2L9wcOGrXcFWfFD4G1AL0Dy4swq6vmZdN0cx9xZ3bW3x4iPJoBOU9fhJbz3gVZ80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ewhu568i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8WHCJ7kNzF2XCQH70BbHdio2suKNHxAf6rhsHMkPbs=;
	b=Ewhu568iJ9CatpSr3LyDGcOxqb3mTz4UUMA95Hw9gFMfyFgOkzBPc9QxfulJma9qSWNtQh
	N6emNFuCeuYPLBlfbqtm8IK2yzds4P9Jup1iYKPLmgh/ufkIMwosoZTcuV/7cTTQW7PBeF
	dZFCZCNY8GgfBizZUEGLUhLa5Cb3gxY=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-22pvaT7yNBmpHjIuC1GImQ-1; Mon, 26 Aug 2024 16:44:29 -0400
X-MC-Unique: 22pvaT7yNBmpHjIuC1GImQ-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-842f9f7509eso1359989241.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705068; x=1725309868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8WHCJ7kNzF2XCQH70BbHdio2suKNHxAf6rhsHMkPbs=;
        b=uIlXDORgEb0FBbOgVAgiGBcytpsU+JWl8hdQYynbpQVkXhTjAj/m4RueIBcO+d3e87
         2ciEIm5a/8oBCCY61w8Xi8siBl0RpqLhpxeo2Z9M7s2Zaxwpmte3A1Y8CYVTm9OGBXjb
         X7Ky6d5Dq86vhmfBRf8vHIy8FNFSXNIB1MQR1Fl4+ZDYEUwkI2uCkZNqPNHnF6lkKqMG
         6wK81OoYXiLrFJrOosyO/gYtbfcb6Bpf3SHVm462ijjVO8k1Glvxh+UjR1h6ZM4znz1M
         JFQwmdwvYz6YDJppE/mf3y61t34aRZ9LOHoqAImVWTzD1k/uY2eUaKappfYwPSFBbUtq
         Zdcw==
X-Gm-Message-State: AOJu0YyJm0eqaj/504h5Z3haJAlkWjBXqaA1ToOAEKYkdj0R/itKAZJp
	jP+mLc5NaxXTHk/WX12U0pH7jYXyGnpqI8LDRkPtNiT3BQTsF/zsLUrG/KWckX6Y5OqNECcB1M5
	fudWhOTbN/Nj5MWHNzm44oHxGk/MG3kmJLnXxmGdToKiRLj/9+H5ze48CEZeZ9B8uTrSVTG6J3j
	+l/JC4xyfXtnsQz60m3fnWcXOdwwc6SCAMLDsbo+d9QVw=
X-Received: by 2002:a05:6102:3e94:b0:493:e585:6ce3 with SMTP id ada2fe7eead31-49a3bd1cd83mr1005209137.31.1724705068555;
        Mon, 26 Aug 2024 13:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKOe4NKlkU/HSIr+h3CCvXyG5C70MeRvYsCyQPr65oWdFZ+m1iMwzpLlsyBV/cJVa8qCplQQ==
X-Received: by 2002:a05:6102:3e94:b0:493:e585:6ce3 with SMTP id ada2fe7eead31-49a3bd1cd83mr1005176137.31.1724705068153;
        Mon, 26 Aug 2024 13:44:28 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Christopherson <seanjc@google.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 16/19] mm: Remove follow_pte()
Date: Mon, 26 Aug 2024 16:43:50 -0400
Message-ID: <20240826204353.2228736-17-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240826204353.2228736-1-peterx@redhat.com>
References: <20240826204353.2228736-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

follow_pte() users have been converted to follow_pfnmap*().  Remove the
API.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h |  2 --
 mm/memory.c        | 73 ----------------------------------------------
 2 files changed, 75 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 161d496bfd18..b31d4bdd65ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2368,8 +2368,6 @@ void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
-int follow_pte(struct vm_area_struct *vma, unsigned long address,
-	       pte_t **ptepp, spinlock_t **ptlp);
 int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 			void *buf, int len, int write);
 
diff --git a/mm/memory.c b/mm/memory.c
index b5d07f493d5d..288f81a8698e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6100,79 +6100,6 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-/**
- * follow_pte - look up PTE at a user virtual address
- * @vma: the memory mapping
- * @address: user virtual address
- * @ptepp: location to store found PTE
- * @ptlp: location to store the lock for the PTE
- *
- * On a successful return, the pointer to the PTE is stored in @ptepp;
- * the corresponding lock is taken and its location is stored in @ptlp.
- *
- * The contents of the PTE are only stable until @ptlp is released using
- * pte_unmap_unlock(). This function will fail if the PTE is non-present.
- * Present PTEs may include PTEs that map refcounted pages, such as
- * anonymous folios in COW mappings.
- *
- * Callers must be careful when relying on PTE content after
- * pte_unmap_unlock(). Especially if the PTE maps a refcounted page,
- * callers must protect against invalidation with MMU notifiers; otherwise
- * access to the PFN at a later point in time can trigger use-after-free.
- *
- * Only IO mappings and raw PFN mappings are allowed.  The mmap semaphore
- * should be taken for read.
- *
- * This function must not be used to modify PTE content.
- *
- * Return: zero on success, -ve otherwise.
- */
-int follow_pte(struct vm_area_struct *vma, unsigned long address,
-	       pte_t **ptepp, spinlock_t **ptlp)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *ptep;
-
-	mmap_assert_locked(mm);
-	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
-		goto out;
-
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
-		goto out;
-
-	pgd = pgd_offset(mm, address);
-	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		goto out;
-
-	p4d = p4d_offset(pgd, address);
-	if (p4d_none(*p4d) || unlikely(p4d_bad(*p4d)))
-		goto out;
-
-	pud = pud_offset(p4d, address);
-	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
-		goto out;
-
-	pmd = pmd_offset(pud, address);
-	VM_BUG_ON(pmd_trans_huge(*pmd));
-
-	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
-	if (!ptep)
-		goto out;
-	if (!pte_present(ptep_get(ptep)))
-		goto unlock;
-	*ptepp = ptep;
-	return 0;
-unlock:
-	pte_unmap_unlock(ptep, *ptlp);
-out:
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(follow_pte);
-
 static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
 				     spinlock_t *lock, pte_t *ptep,
 				     pgprot_t pgprot, unsigned long pfn_base,
-- 
2.45.0


