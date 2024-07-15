Return-Path: <linux-kernel+bounces-252982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92C7931ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610151F21A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667013C9C8;
	Mon, 15 Jul 2024 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0Hmeqeu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C313BC03
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071323; cv=none; b=tXfO/sZqCOxurfrFZeWCD93RtQZWUpUIgj+R9+5B49h/b1KJYtirLyzhBZ3ReDc4q1n2J1RwMurPPNHlSg0VmQxaqTAGE+mr6MjJD9fIX6EzyvlxL7rbNj8f1fHEDCPrfDQwzVklXcu17qHUOzuGmpkkUyMkLZyBATUQr9mgdL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071323; c=relaxed/simple;
	bh=hY43WIIcWNxPexB6TkE7xeF3vzFmSYWkWv1MKduVE34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk5kNxuchCIFL2jhlM+jFr1fzG/QlVqaPEpER424UG80qaznPZzMSou2tsjzAPqSGU3FUz7hlhZPeMZ7nbJoBFxUwQeuzdzv/LeLArFGlHgf0FlSbhoY0Evm/eZQDJ8S1sJ+jSKWwIaU0rVwg5WY9E9HtdcLJvs9GeqTCiR8F2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0Hmeqeu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JbEXa1vvY/QVlVssvu52FPZK180R34zP6ifpD40mks=;
	b=B0HmeqeucqQnsPnA9X1fNGVT0HoiO+FLZpvIBoHY7Tz6hJAZzO4kl+/N769vcKTtrM9XJP
	cx+TBFvMN/4YoxMfbEO5d+IVGelQwPNquB9bNr5L0DZ3w4DV1YFMnrh+xYWkBzku2bbo1A
	e5Iu5qRAi1kbv7vwU4ZpuvVoTAB+Vnw=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-RUN8ZuNANUSXBi2hAZNZHA-1; Mon, 15 Jul 2024 15:21:59 -0400
X-MC-Unique: RUN8ZuNANUSXBi2hAZNZHA-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e039b7a67aeso1253356276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071319; x=1721676119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JbEXa1vvY/QVlVssvu52FPZK180R34zP6ifpD40mks=;
        b=ci4QqRLG5b3QsM4JGhzkZPPn+FMOuZl2t7Vg6wRtpmrjZ3O95VVYRkrGQO/DhEANUl
         VVC2qhEc6tyDJBzLlA4y30/R5uimOFwMFLMMU9dsH1iFHXfBQVi+4R/SqbNBSmC4g98T
         ozDkGdudPFURb03Rmsp7bsSkbTwZepBdaxfTXFVcKO3ttGAULrFYV8LUWsYbSaacKIur
         fT1eGdBFSfa7VaF+2ZXGVu5f+k7svV2+3Zb/nzAEaRlKt/v46PDsPNtDpYmgPJOultC8
         jHaNSdO4n4HWtX5bGNP8ff20G1uJAHkpfvVF1DiaNDRXCPJDdeMmiGOpup+8invdGilz
         MVIg==
X-Forwarded-Encrypted: i=1; AJvYcCXWca5DCKdWy5rl/M6ctT8Yg27H8cOgm+rathKqyC44RrR79J4dgWRzUcTJweVHaeYszyKodp8lpe7xNRvB8RI+sxeklI9nQZCPp+1j
X-Gm-Message-State: AOJu0YymrW3dofhuo+KjFbC04pNA8xuyMeIuyNuBUxmI7HLgVaxrDuXC
	mfLISdZ7+93+pPrtO9TbmZC6Z3gwKayunV1YbJsp4GnSS6E8Xnq6F8m2YUsztNQ4+8StLPH6tpO
	WAEOh1KaCqEDA67L6qfatw8G7WMz+rCbSZ4RJsuoToeH9Kd6kTNDrUyCIWPcCmA==
X-Received: by 2002:a25:2d11:0:b0:e05:900d:32e6 with SMTP id 3f1490d57ef6-e05d3c17338mr350142276.8.1721071319224;
        Mon, 15 Jul 2024 12:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmDbyBksbC4qmpVrfmmZ0A/VGjIJHLQ2OfuPZrkWmoJhvnJgk6xUDZyR/TdOg4zaQrzDq1HQ==
X-Received: by 2002:a25:2d11:0:b0:e05:900d:32e6 with SMTP id 3f1490d57ef6-e05d3c17338mr350112276.8.1721071318815;
        Mon, 15 Jul 2024 12:21:58 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761978d30sm24039356d6.31.2024.07.15.12.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:21:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>,
	x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 6/8] mm/x86: arch_check_zapped_pud()
Date: Mon, 15 Jul 2024 15:21:40 -0400
Message-ID: <20240715192142.3241557-7-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240715192142.3241557-1-peterx@redhat.com>
References: <20240715192142.3241557-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce arch_check_zapped_pud() to sanity check shadow stack on PUD zaps.
It has the same logic of the PMD helper.

One thing to mention is, it might be a good idea to use page_table_check in
the future for trapping wrong setups of shadow stack pgtable entries [1].
That is left for the future as a separate effort.

[1] https://lore.kernel.org/all/59d518698f664e07c036a5098833d7b56b953305.camel@intel.com

Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 10 ++++++++++
 arch/x86/mm/pgtable.c          |  7 +++++++
 include/linux/pgtable.h        |  7 +++++++
 mm/huge_memory.c               |  4 +++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 25fc6d809572..cdf044c2ad6e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -169,6 +169,13 @@ static inline int pud_young(pud_t pud)
 	return pud_flags(pud) & _PAGE_ACCESSED;
 }
 
+static inline bool pud_shstk(pud_t pud)
+{
+	return cpu_feature_enabled(X86_FEATURE_SHSTK) &&
+	       (pud_flags(pud) & (_PAGE_RW | _PAGE_DIRTY | _PAGE_PSE)) ==
+	       (_PAGE_DIRTY | _PAGE_PSE);
+}
+
 static inline int pte_write(pte_t pte)
 {
 	/*
@@ -1662,6 +1669,9 @@ void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte);
 #define arch_check_zapped_pmd arch_check_zapped_pmd
 void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd);
 
+#define arch_check_zapped_pud arch_check_zapped_pud
+void arch_check_zapped_pud(struct vm_area_struct *vma, pud_t pud);
+
 #ifdef CONFIG_XEN_PV
 #define arch_has_hw_nonleaf_pmd_young arch_has_hw_nonleaf_pmd_young
 static inline bool arch_has_hw_nonleaf_pmd_young(void)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 93e54ba91fbf..564b8945951e 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -926,3 +926,10 @@ void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd)
 	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
 			pmd_shstk(pmd));
 }
+
+void arch_check_zapped_pud(struct vm_area_struct *vma, pud_t pud)
+{
+	/* See note in arch_check_zapped_pte() */
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
+			pud_shstk(pud));
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a6a3cccfc36..2289e9f7aa1b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -447,6 +447,13 @@ static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
 }
 #endif
 
+#ifndef arch_check_zapped_pud
+static inline void arch_check_zapped_pud(struct vm_area_struct *vma,
+					 pud_t pud)
+{
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9fec5bd1c8b0..c10247bef08a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2291,12 +2291,14 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 pud_t *pud, unsigned long addr)
 {
 	spinlock_t *ptl;
+	pud_t orig_pud;
 
 	ptl = __pud_trans_huge_lock(pud, vma);
 	if (!ptl)
 		return 0;
 
-	pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
+	orig_pud = pudp_huge_get_and_clear_full(vma, addr, pud, tlb->fullmm);
+	arch_check_zapped_pud(vma, orig_pud);
 	tlb_remove_pud_tlb_entry(tlb, pud, addr);
 	if (vma_is_special_huge(vma)) {
 		spin_unlock(ptl);
-- 
2.45.0


