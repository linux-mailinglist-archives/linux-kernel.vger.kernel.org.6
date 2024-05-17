Return-Path: <linux-kernel+bounces-182534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E93E8C8C68
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E7428545F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EC13FD88;
	Fri, 17 May 2024 19:00:47 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFB13E409
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972446; cv=none; b=oghc/3HwZW8esvujW1KwkVrE+KE+ZrJYyqEywPAI0+ldAHC+k6s5lJaMCeAZ1KPq45nQy+zPh9JZoduraZYwLxFmWDnu+ZE1TM9OHQqREkBiMxfXygGyfCP0sqkctlLzPcSSJULC1pYvD2dUAu6MOqAVlcK1M0jwjHtkuL/kotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972446; c=relaxed/simple;
	bh=I4UsJaxfqWCr6V6W5RXQLS8pGH/1YRxr58LkMABPEp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAvs3kXR+H6jXl7HRKuLG1OJloFOxq0vuzyZMTFvwWEv+ypP+or9hEI4JFb9JeZJDiPGQaDccjgzWSSKg8ZIwvuFDKX1Q8ZkaDZawsXUYGs93oJ+WxQj76AUhqzZkIujiqh+Z5f/9pGrDwDPez7F0rZRLruGHXewyNQ0iHn4ZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Vgx9P0dblz9t0b;
	Fri, 17 May 2024 21:00:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dh53uZwyolMl; Fri, 17 May 2024 21:00:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Vgx9L0fNXz9sy4;
	Fri, 17 May 2024 21:00:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 123E58B775;
	Fri, 17 May 2024 21:00:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gSQP0sesHSz5; Fri, 17 May 2024 21:00:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.121])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 81FEC8B786;
	Fri, 17 May 2024 21:00:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 05/20] powerpc/mm: Allow hugepages without hugepd
Date: Fri, 17 May 2024 20:59:59 +0200
Message-ID: <cb65d20e42e80e39dc2be240e7eb118333ce5171.1715971869.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715971869.git.christophe.leroy@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715972396; l=5056; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=I4UsJaxfqWCr6V6W5RXQLS8pGH/1YRxr58LkMABPEp8=; b=y8YNsxDQQALuLaML6eKaripIXxjHtP2GbnBYFSWLMGP9P0CyaP47NYx88GjVwawkyAE6f73e4 vZXnDXc/h2iC/zyQC1DT24JmlUA+mWWBXRQc6pM3mcyCmfPBKuvsdxH
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In preparation of implementing huge pages on powerpc 8xx
without hugepd, enclose hugepd related code inside an
ifdef CONFIG_ARCH_HAS_HUGEPD

This also allows removing some stubs.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h |  2 --
 arch/powerpc/include/asm/hugetlb.h           | 10 ++--------
 arch/powerpc/include/asm/nohash/pgtable.h    |  8 +++++---
 arch/powerpc/mm/hugetlbpage.c                | 13 +++++++++++++
 arch/powerpc/mm/pgtable.c                    |  2 ++
 5 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index dc5c039eb28e..dd4eb3063175 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -47,8 +47,6 @@ static inline void pgtable_free(void *table, unsigned index_size)
 	}
 }
 
-#define get_hugepd_cache_index(x)  (x)
-
 static inline void pgtable_free_tlb(struct mmu_gather *tlb,
 				    void *table, int shift)
 {
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index ea71f7245a63..79176a499763 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -30,10 +30,12 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 }
 #define is_hugepage_only_range is_hugepage_only_range
 
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 #define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
 			    unsigned long ceiling);
+#endif
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
@@ -67,14 +69,6 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 {
 }
 
-#define hugepd_shift(x) 0
-static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
-				    unsigned pdshift)
-{
-	return NULL;
-}
-
-
 static inline void __init gigantic_hugetlb_cma_reserve(void)
 {
 }
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 427db14292c9..ac3353f7f2ac 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -340,7 +340,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #define pgprot_writecombine pgprot_noncached_wc
 
-#ifdef CONFIG_HUGETLB_PAGE
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 static inline int hugepd_ok(hugepd_t hpd)
 {
 #ifdef CONFIG_PPC_8xx
@@ -351,6 +351,10 @@ static inline int hugepd_ok(hugepd_t hpd)
 #endif
 }
 
+#define is_hugepd(hpd)		(hugepd_ok(hpd))
+#endif
+
+#ifdef CONFIG_HUGETLB_PAGE
 static inline int pmd_huge(pmd_t pmd)
 {
 	return 0;
@@ -360,8 +364,6 @@ static inline int pud_huge(pud_t pud)
 {
 	return 0;
 }
-
-#define is_hugepd(hpd)		(hugepd_ok(hpd))
 #endif
 
 int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot);
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 66ac56b26007..82495b8ea793 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -42,6 +42,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr, unsigned long s
 	return __find_linux_pte(mm->pgd, addr, NULL, NULL);
 }
 
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			   unsigned long address, unsigned int pdshift,
 			   unsigned int pshift, spinlock_t *ptl)
@@ -193,6 +194,16 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	return hugepte_offset(*hpdp, addr, pdshift);
 }
+#else
+pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
+		      unsigned long addr, unsigned long sz)
+{
+	if (sz < PMD_SIZE)
+		return pte_alloc_huge(mm, pmd_off(mm, addr), addr, sz);
+
+	return NULL;
+}
+#endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
 /*
@@ -248,6 +259,7 @@ int __init alloc_bootmem_huge_page(struct hstate *h, int nid)
 	return __alloc_bootmem_huge_page(h, nid);
 }
 
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 #ifndef CONFIG_PPC_BOOK3S_64
 #define HUGEPD_FREELIST_SIZE \
 	((PAGE_SIZE - sizeof(struct hugepd_freelist)) / sizeof(pte_t))
@@ -505,6 +517,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 		}
 	} while (addr = next, addr != end);
 }
+#endif
 
 bool __init arch_hugetlb_valid_size(unsigned long size)
 {
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9e7ba9c3851f..acdf64c9b93e 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -487,8 +487,10 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	if (!hpdp)
 		return NULL;
 
+#ifdef CONFIG_ARCH_HAS_HUGEPD
 	ret_pte = hugepte_offset(*hpdp, ea, pdshift);
 	pdshift = hugepd_shift(*hpdp);
+#endif
 out:
 	if (hpage_shift)
 		*hpage_shift = pdshift;
-- 
2.44.0


