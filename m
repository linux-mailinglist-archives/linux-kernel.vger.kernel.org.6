Return-Path: <linux-kernel+bounces-283566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A3394F66A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D161F22FB5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF85192B69;
	Mon, 12 Aug 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfKe42/b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DC18E764
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486364; cv=none; b=evAJrt0VhXi278JMR2/EztarR2b9I2888S7OH4HqW3TJsQvoYL3XqVs4+KbfAjAEEjqVSia+VeiwkGGM/vWD2ihC1ay97KFtlbd7Vm5iJHuSxzsGND9FwU4V6e9QqJIpxoWce0mOdrNzQztqUKWclqEmX2gZReT9+QbQu8BZ9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486364; c=relaxed/simple;
	bh=Cg+h4Co4PHJshxw6DV3hzIA306WhOch+JjvPDHPW480=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEiObStwsxaXUXTjgACd9sftEu9eB78mLWxFYcihzUL97neb5BkUKV5ffv8GrrsjGFXEB3bjGWib/9lq1o0WR0/9wwxKQ99UPQ+OUEVXg2sgUu12WZudW4xF/lfkCET5KuFfeqQ8ip0qWXKFucWLf1QDurbVMgcWGIyARvY3Hak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfKe42/b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723486362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vL+nA7AT6HH2fptU3fDtubaziCDql6jx+j3l3b3Xtg8=;
	b=BfKe42/bRHXNqVfrNHN/VS3QIpxmD86GOpGOXws/q/xmVthKvSHIPvubxCCd5lWASCfbxG
	RZS9QWi8gQaopCoav/0NNaq8Rlc7w1zAr72LCvd/UPCdU0787tJIP3z1u39I4MMuHpZ2H0
	qXLpaNaXq/YeLb6UPSWaB1g2UJhr2hI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-YACrwIVCO_yUtGVWGy__IQ-1; Mon, 12 Aug 2024 14:12:41 -0400
X-MC-Unique: YACrwIVCO_yUtGVWGy__IQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1e41eda5aso13487885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486360; x=1724091160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vL+nA7AT6HH2fptU3fDtubaziCDql6jx+j3l3b3Xtg8=;
        b=oaZ1sBkePbQn09V2wwMe7pUZ6XogtvI20j/8zn2Yx/Q7OSW5U+zF0d19FJ+ojwVfHO
         27VMwtO4L1yLAMQdmt7Z47yx2CZcgIlx7srnlEdr+B0urc/PjhhHj3L6GNVyeo7unwup
         4j9Pio9wsV6ZyPpKk1rjaSTJPJ53FInZMt94gURrEBQJxzGCRERdKlUB+ZNsK3cFeXS9
         bdpnRJx3qQc+rm1/GqMzlxSQa4ymhRvw43owsSGUfqbOZoOKiAAjuvQflAgNNEltfOe3
         fHCuXRF79VNa2Q55d7fpgNwSCkKUryr3jQ7m/Stqoei0sg6Cc0EnOBC1fwTcShcssdGM
         UKQA==
X-Gm-Message-State: AOJu0YxceXqVBAY9NK7QtGufwbXC6fnZAyxuGxUe5NhsLlTWIvEhnTfj
	B1fX/3FNYsIIIi8V5m36bAzBSFQ7D8niO0NhmzlvxR/afSG8OsAr1Y26J0ZmnrVoDTmeiQdEr1r
	gqs3N2eio8Ee/MYclK9buLXDGEXpqQbymKuvBRVsCldUc8glSRL77jW946pjY+z+VcGnri98xxg
	pyAHuc/FXQtOXAqMJ1Lw3BoDQ2kPc25ecv2TAAOlDdMR8=
X-Received: by 2002:a05:620a:d95:b0:7a1:5683:b04b with SMTP id af79cd13be357-7a4e1625378mr68906285a.9.1723486360265;
        Mon, 12 Aug 2024 11:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHermK5CePcyhPQZfo7QtCxftIfNR9zVAKZznJ8AtnLMjyZZZpq0Zdfjnp4iDQgBs3zunmzLQ==
X-Received: by 2002:a05:620a:d95:b0:7a1:5683:b04b with SMTP id af79cd13be357-7a4e1625378mr68901885a.9.1723486359781;
        Mon, 12 Aug 2024 11:12:39 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dee013sm268663985a.84.2024.08.12.11.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:12:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Kirill A . Shutemov" <kirill@shutemov.name>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Huang Ying <ying.huang@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	peterx@redhat.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 5/7] mm/x86: Implement arch_check_zapped_pud()
Date: Mon, 12 Aug 2024 14:12:23 -0400
Message-ID: <20240812181225.1360970-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240812181225.1360970-1-peterx@redhat.com>
References: <20240812181225.1360970-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce arch_check_zapped_pud() to sanity check shadow stack on PUD zaps.
It has the same logic as the PMD helper.

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
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 10 ++++++++++
 arch/x86/mm/pgtable.c          |  6 ++++++
 include/linux/pgtable.h        |  6 ++++++
 mm/huge_memory.c               |  4 +++-
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a2a3bd4c1bda..fdb8ac9e7030 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -174,6 +174,13 @@ static inline int pud_young(pud_t pud)
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
@@ -1667,6 +1674,9 @@ void arch_check_zapped_pte(struct vm_area_struct *vma, pte_t pte);
 #define arch_check_zapped_pmd arch_check_zapped_pmd
 void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd);
 
+#define arch_check_zapped_pud arch_check_zapped_pud
+void arch_check_zapped_pud(struct vm_area_struct *vma, pud_t pud);
+
 #ifdef CONFIG_XEN_PV
 #define arch_has_hw_nonleaf_pmd_young arch_has_hw_nonleaf_pmd_young
 static inline bool arch_has_hw_nonleaf_pmd_young(void)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f5931499c2d6..36e7139a61d9 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -926,3 +926,9 @@ void arch_check_zapped_pmd(struct vm_area_struct *vma, pmd_t pmd)
 	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) &&
 			pmd_shstk(pmd));
 }
+
+void arch_check_zapped_pud(struct vm_area_struct *vma, pud_t pud)
+{
+	/* See note in arch_check_zapped_pte() */
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_SHADOW_STACK) && pud_shstk(pud));
+}
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a6a3cccfc36..780f3b439d98 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -447,6 +447,12 @@ static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
 }
 #endif
 
+#ifndef arch_check_zapped_pud
+static inline void arch_check_zapped_pud(struct vm_area_struct *vma, pud_t pud)
+{
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0024266dea0a..81c5da0708ed 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2293,12 +2293,14 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
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


