Return-Path: <linux-kernel+bounces-227412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE5A9150EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8611C23BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8131A0700;
	Mon, 24 Jun 2024 14:47:33 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84319D89D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240452; cv=none; b=UcAwdd9YjmqYvTqrkDks/wbjTtF2hN4p/c/6Ejc7IPqbGwQkSBp1quE81TFbXPX5ztXzoAoZFgJk/KKVNTGg6Owhat/YfGHhAkXt/ylvPBBkCZoxUMXOcF8YKcRLII2QfzeQvnMJr9pPVPmMRb4CjIpbtQ787NeP4oUxOHOwyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240452; c=relaxed/simple;
	bh=cAPYqUBYshpLkzOaz4AEKHKXfgJcSbmgHaFhwK2BmII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rjw6/W58yJtkRHLKkiA7MEIeBETOmqYC0QwrPdzs0DRVhWf0vK33NIPDppwjQsNiMObJQ8+Dx3hiXEfhs19RAUFRt8iJk2JBy/XhjKCovExd1ZLn7Q4u/oiEeJWJIDuB58h3uLNUbv0JSqPuvRsmaeZHW9OvUc8hfUqg+M4cb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4W79kt6HcCz9vFq;
	Mon, 24 Jun 2024 16:46:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IsuUeNndELc3; Mon, 24 Jun 2024 16:46:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4W79kk0b3hz9vFM;
	Mon, 24 Jun 2024 16:46:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FD978B766;
	Mon, 24 Jun 2024 16:46:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Y-D99yslIZel; Mon, 24 Jun 2024 16:46:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.33])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 66DFA8B768;
	Mon, 24 Jun 2024 16:46:05 +0200 (CEST)
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
Subject: [PATCH v6 13/23] powerpc/8xx: Rework support for 8M pages using contiguous PTE entries
Date: Mon, 24 Jun 2024 16:45:39 +0200
Message-ID: <f362bd8cc6b4d4a108b632d74bd7f1c6e95bbea4.1719240269.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719240269.git.christophe.leroy@csgroup.eu>
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719240334; l=18915; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=cAPYqUBYshpLkzOaz4AEKHKXfgJcSbmgHaFhwK2BmII=; b=HBOEj0ThEqwndkKajmj9dSLe6j5G2ReGbxcBR95o5IkciiNTiQ+TbrvsnubMkN5fB+2dgxQfX V3SH+cC6btvDx6EqHzAK6rRK5aEabTe3XhrdCK8pADCmj6mpoctBcWx
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In order to fit better with standard Linux page tables layout, add
support for 8M pages using contiguous PTE entries in a standard
page table. Page tables will then be populated with 1024 similar
entries and two PMD entries will point to that page table.

The PMD entries also get a flag to tell it is addressing an 8M page,
this is required for the HW tablewalk assistance.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
v3:
- Move huge_ptep_get() for a more readable commit diff
- Flag PMD as 8Mbytes in set_huge_pte_at()
- Define __pte_leaf_size()
- Change pte_update() instead of all huge callers of pte_update()
- Added ptep_is_8m_pmdp() helper
- Fixed kasan early memory 8M allocation

v5:
- In huge_ptep_get(), change pte_offset_kernel((pmd_t *)ptep, 0) to pte_offset_kernel((pmd_t *)ptep, ALIGN_DOWN(addr, SZ_8M)) which is more correct allthough not different.
---
 .../include/asm/nohash/32/hugetlb-8xx.h       | 38 +++----------
 arch/powerpc/include/asm/nohash/32/pte-8xx.h  | 53 ++++++++++++-------
 arch/powerpc/include/asm/nohash/pgtable.h     |  4 --
 arch/powerpc/include/asm/page.h               |  5 --
 arch/powerpc/include/asm/pgtable.h            |  3 ++
 arch/powerpc/kernel/head_8xx.S                | 10 +---
 arch/powerpc/mm/hugetlbpage.c                 | 21 +++++---
 arch/powerpc/mm/kasan/8xx.c                   | 21 +++++---
 arch/powerpc/mm/nohash/8xx.c                  | 40 +++++++-------
 arch/powerpc/mm/pgtable.c                     | 27 +++++++---
 arch/powerpc/mm/pgtable_32.c                  |  2 +-
 arch/powerpc/platforms/Kconfig.cputype        |  1 -
 12 files changed, 111 insertions(+), 114 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
index 92df40c6cc6b..014799557f60 100644
--- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
@@ -4,42 +4,12 @@
 
 #define PAGE_SHIFT_8M		23
 
-static inline pte_t *hugepd_page(hugepd_t hpd)
-{
-	BUG_ON(!hugepd_ok(hpd));
-
-	return (pte_t *)__va(hpd_val(hpd) & ~HUGEPD_SHIFT_MASK);
-}
-
-static inline unsigned int hugepd_shift(hugepd_t hpd)
-{
-	return PAGE_SHIFT_8M;
-}
-
-static inline pte_t *hugepte_offset(hugepd_t hpd, unsigned long addr,
-				    unsigned int pdshift)
-{
-	unsigned long idx = (addr & (SZ_4M - 1)) >> PAGE_SHIFT;
-
-	return hugepd_page(hpd) + idx;
-}
-
 static inline void flush_hugetlb_page(struct vm_area_struct *vma,
 				      unsigned long vmaddr)
 {
 	flush_tlb_page(vma, vmaddr);
 }
 
-static inline void hugepd_populate(hugepd_t *hpdp, pte_t *new, unsigned int pshift)
-{
-	*hpdp = __hugepd(__pa(new) | _PMD_USER | _PMD_PRESENT | _PMD_PAGE_8M);
-}
-
-static inline void hugepd_populate_kernel(hugepd_t *hpdp, pte_t *new, unsigned int pshift)
-{
-	*hpdp = __hugepd(__pa(new) | _PMD_PRESENT | _PMD_PAGE_8M);
-}
-
 static inline int check_and_get_huge_psize(int shift)
 {
 	return shift_to_mmu_psize(shift);
@@ -49,6 +19,14 @@ static inline int check_and_get_huge_psize(int shift)
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		     pte_t pte, unsigned long sz);
 
+#define __HAVE_ARCH_HUGE_PTEP_GET
+static inline pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	if (ptep_is_8m_pmdp(mm, addr, ptep))
+		ptep = pte_offset_kernel((pmd_t *)ptep, ALIGN_DOWN(addr, SZ_8M));
+	return ptep_get(ptep);
+}
+
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 				  pte_t *ptep, unsigned long sz)
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 625c31d6ce5c..54ebb91dbdcf 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -119,7 +119,7 @@ static inline pte_t pte_mkhuge(pte_t pte)
 
 #define pte_mkhuge pte_mkhuge
 
-static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
+static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 				     unsigned long clr, unsigned long set, int huge);
 
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
@@ -141,19 +141,12 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma, pte_t *pt
 }
 #define __ptep_set_access_flags __ptep_set_access_flags
 
-static inline unsigned long pgd_leaf_size(pgd_t pgd)
-{
-	if (pgd_val(pgd) & _PMD_PAGE_8M)
-		return SZ_8M;
-	return SZ_4M;
-}
-
-#define pgd_leaf_size pgd_leaf_size
-
-static inline unsigned long pte_leaf_size(pte_t pte)
+static inline unsigned long __pte_leaf_size(pmd_t pmd, pte_t pte)
 {
 	pte_basic_t val = pte_val(pte);
 
+	if (pmd_val(pmd) & _PMD_PAGE_8M)
+		return SZ_8M;
 	if (val & _PAGE_HUGE)
 		return SZ_512K;
 	if (val & _PAGE_SPS)
@@ -161,31 +154,38 @@ static inline unsigned long pte_leaf_size(pte_t pte)
 	return SZ_4K;
 }
 
-#define pte_leaf_size pte_leaf_size
+#define __pte_leaf_size __pte_leaf_size
 
 /*
  * On the 8xx, the page tables are a bit special. For 16k pages, we have
  * 4 identical entries. For 512k pages, we have 128 entries as if it was
  * 4k pages, but they are flagged as 512k pages for the hardware.
- * For other page sizes, we have a single entry in the table.
+ * For 8M pages, we have 1024 entries as if it was 4M pages (PMD_SIZE)
+ * but they are flagged as 8M pages for the hardware.
+ * For 4k pages, we have a single entry in the table.
  */
 static pmd_t *pmd_off(struct mm_struct *mm, unsigned long addr);
-static int hugepd_ok(hugepd_t hpd);
+static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address);
+
+static inline bool ptep_is_8m_pmdp(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	return (pmd_t *)ptep == pmd_off(mm, ALIGN_DOWN(addr, SZ_8M));
+}
 
 static inline int number_of_cells_per_pte(pmd_t *pmd, pte_basic_t val, int huge)
 {
 	if (!huge)
 		return PAGE_SIZE / SZ_4K;
-	else if (hugepd_ok(*((hugepd_t *)pmd)))
-		return 1;
+	else if ((pmd_val(*pmd) & _PMD_PAGE_MASK) == _PMD_PAGE_8M)
+		return SZ_4M / SZ_4K;
 	else if (IS_ENABLED(CONFIG_PPC_4K_PAGES) && !(val & _PAGE_HUGE))
 		return SZ_16K / SZ_4K;
 	else
 		return SZ_512K / SZ_4K;
 }
 
-static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
-				     unsigned long clr, unsigned long set, int huge)
+static inline pte_basic_t __pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
+				       unsigned long clr, unsigned long set, int huge)
 {
 	pte_basic_t *entry = (pte_basic_t *)p;
 	pte_basic_t old = pte_val(*p);
@@ -197,7 +197,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 
 	for (i = 0; i < num; i += PAGE_SIZE / SZ_4K, new += PAGE_SIZE) {
 		*entry++ = new;
-		if (IS_ENABLED(CONFIG_PPC_16K_PAGES) && num != 1) {
+		if (IS_ENABLED(CONFIG_PPC_16K_PAGES)) {
 			*entry++ = new;
 			*entry++ = new;
 			*entry++ = new;
@@ -207,6 +207,21 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 	return old;
 }
 
+static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+				     unsigned long clr, unsigned long set, int huge)
+{
+	pte_basic_t old;
+
+	if (huge && ptep_is_8m_pmdp(mm, addr, ptep)) {
+		pmd_t *pmdp = (pmd_t *)ptep;
+
+		old = __pte_update(mm, addr, pte_offset_kernel(pmdp, 0), clr, set, huge);
+		__pte_update(mm, addr, pte_offset_kernel(pmdp + 1, 0), clr, set, huge);
+	} else {
+		old = __pte_update(mm, addr, ptep, clr, set, huge);
+	}
+	return old;
+}
 #define pte_update pte_update
 
 #ifdef CONFIG_PPC_16K_PAGES
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index e7fc1314c23e..90d6a0943b35 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -343,12 +343,8 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 #ifdef CONFIG_ARCH_HAS_HUGEPD
 static inline int hugepd_ok(hugepd_t hpd)
 {
-#ifdef CONFIG_PPC_8xx
-	return ((hpd_val(hpd) & _PMD_PAGE_MASK) == _PMD_PAGE_8M);
-#else
 	/* We clear the top bit to indicate hugepd */
 	return (hpd_val(hpd) && (hpd_val(hpd) & PD_HUGE) == 0);
-#endif
 }
 
 #define is_hugepd(hpd)		(hugepd_ok(hpd))
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index e411e5a70ea3..018c3d55232c 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -293,13 +293,8 @@ static inline const void *pfn_to_kaddr(unsigned long pfn)
 /*
  * Some number of bits at the level of the page table that points to
  * a hugepte are used to encode the size.  This masks those bits.
- * On 8xx, HW assistance requires 4k alignment for the hugepte.
  */
-#ifdef CONFIG_PPC_8xx
-#define HUGEPD_SHIFT_MASK     0xfff
-#else
 #define HUGEPD_SHIFT_MASK     0x3f
-#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 239709a2f68e..264a6c09517a 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -106,6 +106,9 @@ unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
 void pgtable_cache_add(unsigned int shift);
 
+#ifdef CONFIG_PPC32
+void __init *early_alloc_pgtable(unsigned long size);
+#endif
 pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va);
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index edc479a7c2bc..ac74321b1192 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -415,14 +415,13 @@ FixupDAR:/* Entry point for dcbx workaround. */
 	oris	r11, r11, (swapper_pg_dir - PAGE_OFFSET)@ha
 3:
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	rlwinm	r11, r11, 0, ~_PMD_PAGE_8M
 	mtspr	SPRN_MD_TWC, r11
-	mtcrf	0x01, r11
 	mfspr	r11, SPRN_MD_TWC
 	lwz	r11, 0(r11)	/* Get the pte */
-	bt	28,200f		/* bit 28 = Large page (8M) */
 	/* concat physical page address(r11) and page offset(r10) */
 	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT, 31
-201:	lwz	r11,0(r11)
+	lwz	r11,0(r11)
 /* Check if it really is a dcbx instruction. */
 /* dcbt and dcbtst does not generate DTLB Misses/Errors,
  * no need to include them here */
@@ -441,11 +440,6 @@ FixupDAR:/* Entry point for dcbx workaround. */
 141:	mfspr	r10,SPRN_M_TW
 	b	DARFixed	/* Nope, go back to normal TLB processing */
 
-200:
-	/* concat physical page address(r11) and page offset(r10) */
-	rlwimi	r11, r10, 0, 32 - PAGE_SHIFT_8M, 31
-	b	201b
-
 144:	mfspr	r10, SPRN_DSISR
 	rlwinm	r10, r10,0,7,5	/* Clear store bit for buggy dcbst insn */
 	mtspr	SPRN_DSISR, r10
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 20fad59ff9f5..394846197974 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -183,9 +183,6 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!hpdp)
 		return NULL;
 
-	if (IS_ENABLED(CONFIG_PPC_8xx) && pshift < PMD_SHIFT)
-		return pte_alloc_huge(mm, (pmd_t *)hpdp, addr);
-
 	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
 
 	if (hugepd_none(*hpdp) && __hugepte_alloc(mm, hpdp, addr,
@@ -218,8 +215,18 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (!pmd)
 		return NULL;
 
-	if (sz >= PMD_SIZE)
+	if (sz >= PMD_SIZE) {
+		/* On 8xx, all hugepages are handled as contiguous PTEs */
+		if (IS_ENABLED(CONFIG_PPC_8xx)) {
+			int i;
+
+			for (i = 0; i < sz / PMD_SIZE; i++) {
+				if (!pte_alloc_huge(mm, pmd + i, addr))
+					return NULL;
+			}
+		}
 		return (pte_t *)pmd;
+	}
 
 	return pte_alloc_huge(mm, pmd, addr);
 }
@@ -617,10 +624,8 @@ static int __init hugetlbpage_init(void)
 		 * use pgt cache for hugepd.
 		 */
 		if (pdshift > shift) {
-			if (!IS_ENABLED(CONFIG_PPC_8xx))
-				pgtable_cache_add(pdshift - shift);
-		} else if (IS_ENABLED(CONFIG_PPC_E500) ||
-			   IS_ENABLED(CONFIG_PPC_8xx)) {
+			pgtable_cache_add(pdshift - shift);
+		} else if (IS_ENABLED(CONFIG_PPC_E500)) {
 			pgtable_cache_add(PTE_T_ORDER);
 		}
 
diff --git a/arch/powerpc/mm/kasan/8xx.c b/arch/powerpc/mm/kasan/8xx.c
index 2784224054f8..989d6cdf4141 100644
--- a/arch/powerpc/mm/kasan/8xx.c
+++ b/arch/powerpc/mm/kasan/8xx.c
@@ -6,28 +6,33 @@
 #include <linux/memblock.h>
 #include <linux/hugetlb.h>
 
+#include <asm/pgalloc.h>
+
 static int __init
 kasan_init_shadow_8M(unsigned long k_start, unsigned long k_end, void *block)
 {
 	pmd_t *pmd = pmd_off_k(k_start);
 	unsigned long k_cur, k_next;
 
-	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd += 2, block += SZ_8M) {
-		pte_basic_t *new;
+	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++, block += SZ_4M) {
+		pte_t *ptep;
+		int i;
 
 		k_next = pgd_addr_end(k_cur, k_end);
-		k_next = pgd_addr_end(k_next, k_end);
 		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
 			continue;
 
-		new = memblock_alloc(sizeof(pte_basic_t), SZ_4K);
-		if (!new)
+		ptep = memblock_alloc(PTE_FRAG_SIZE, PTE_FRAG_SIZE);
+		if (!ptep)
 			return -ENOMEM;
 
-		*new = pte_val(pte_mkhuge(pfn_pte(PHYS_PFN(__pa(block)), PAGE_KERNEL)));
+		for (i = 0; i < PTRS_PER_PTE; i++) {
+			pte_t pte = pte_mkhuge(pfn_pte(PHYS_PFN(__pa(block + i * PAGE_SIZE)), PAGE_KERNEL));
 
-		hugepd_populate_kernel((hugepd_t *)pmd, (pte_t *)new, PAGE_SHIFT_8M);
-		hugepd_populate_kernel((hugepd_t *)pmd + 1, (pte_t *)new, PAGE_SHIFT_8M);
+			__set_pte_at(&init_mm, k_cur, ptep + i, pte, 1);
+		}
+		pmd_populate_kernel(&init_mm, pmd, ptep);
+		*pmd = __pmd(pmd_val(*pmd) | _PMD_PAGE_8M);
 	}
 	return 0;
 }
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index d93433e26ded..388bba0ab3e7 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -11,6 +11,7 @@
 #include <linux/hugetlb.h>
 
 #include <asm/fixmap.h>
+#include <asm/pgalloc.h>
 
 #include <mm/mmu_decl.h>
 
@@ -48,20 +49,6 @@ unsigned long p_block_mapped(phys_addr_t pa)
 	return 0;
 }
 
-static pte_t __init *early_hugepd_alloc_kernel(hugepd_t *pmdp, unsigned long va)
-{
-	if (hpd_val(*pmdp) == 0) {
-		pte_t *ptep = memblock_alloc(sizeof(pte_basic_t), SZ_4K);
-
-		if (!ptep)
-			return NULL;
-
-		hugepd_populate_kernel((hugepd_t *)pmdp, ptep, PAGE_SHIFT_8M);
-		hugepd_populate_kernel((hugepd_t *)pmdp + 1, ptep, PAGE_SHIFT_8M);
-	}
-	return hugepte_offset(*(hugepd_t *)pmdp, va, PGDIR_SHIFT);
-}
-
 static int __ref __early_map_kernel_hugepage(unsigned long va, phys_addr_t pa,
 					     pgprot_t prot, int psize, bool new)
 {
@@ -75,24 +62,33 @@ static int __ref __early_map_kernel_hugepage(unsigned long va, phys_addr_t pa,
 		if (WARN_ON(slab_is_available()))
 			return -EINVAL;
 
-		if (psize == MMU_PAGE_512K)
+		if (psize == MMU_PAGE_512K) {
 			ptep = early_pte_alloc_kernel(pmdp, va);
-		else
-			ptep = early_hugepd_alloc_kernel((hugepd_t *)pmdp, va);
+			/* The PTE should never be already present */
+			if (WARN_ON(pte_present(*ptep) && pgprot_val(prot)))
+				return -EINVAL;
+		} else {
+			if (WARN_ON(!pmd_none(*pmdp) || !pmd_none(*(pmdp + 1))))
+				return -EINVAL;
+
+			ptep = early_alloc_pgtable(PTE_FRAG_SIZE);
+			pmd_populate_kernel(&init_mm, pmdp, ptep);
+
+			ptep = early_alloc_pgtable(PTE_FRAG_SIZE);
+			pmd_populate_kernel(&init_mm, pmdp + 1, ptep);
+
+			ptep = (pte_t *)pmdp;
+		}
 	} else {
 		if (psize == MMU_PAGE_512K)
 			ptep = pte_offset_kernel(pmdp, va);
 		else
-			ptep = hugepte_offset(*(hugepd_t *)pmdp, va, PGDIR_SHIFT);
+			ptep = (pte_t *)pmdp;
 	}
 
 	if (WARN_ON(!ptep))
 		return -ENOMEM;
 
-	/* The PTE should never be already present */
-	if (new && WARN_ON(pte_present(*ptep) && pgprot_val(prot)))
-		return -EINVAL;
-
 	set_huge_pte_at(&init_mm, va, ptep,
 			pte_mkhuge(pfn_pte(pa >> PAGE_SHIFT, prot)),
 			1UL << mmu_psize_to_shift(psize));
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9010973f036c..294775c793ab 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -297,11 +297,8 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 }
 
 #if defined(CONFIG_PPC_8xx)
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
-		     pte_t pte, unsigned long sz)
+static void __set_huge_pte_at(pmd_t *pmd, pte_t *ptep, pte_basic_t val)
 {
-	pmd_t *pmd = pmd_off(mm, addr);
-	pte_basic_t val;
 	pte_basic_t *entry = (pte_basic_t *)ptep;
 	int num, i;
 
@@ -311,15 +308,29 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	 */
 	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
 
-	pte = set_pte_filter(pte, addr);
-
-	val = pte_val(pte);
-
 	num = number_of_cells_per_pte(pmd, val, 1);
 
 	for (i = 0; i < num; i++, entry++, val += SZ_4K)
 		*entry = val;
 }
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
+		     pte_t pte, unsigned long sz)
+{
+	pmd_t *pmdp = pmd_off(mm, addr);
+
+	pte = set_pte_filter(pte, addr);
+
+	if (sz == SZ_8M) { /* Flag both PMD entries as 8M and fill both page tables */
+		*pmdp = __pmd(pmd_val(*pmdp) | _PMD_PAGE_8M);
+		*(pmdp + 1) = __pmd(pmd_val(*(pmdp + 1)) | _PMD_PAGE_8M);
+
+		__set_huge_pte_at(pmdp, pte_offset_kernel(pmdp, 0), pte_val(pte));
+		__set_huge_pte_at(pmdp, pte_offset_kernel(pmdp + 1, 0), pte_val(pte) + SZ_4M);
+	} else {
+		__set_huge_pte_at(pmdp, ptep, pte_val(pte));
+	}
+}
 #endif
 #endif /* CONFIG_HUGETLB_PAGE */
 
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index cfd622ebf774..787b22206386 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -48,7 +48,7 @@ notrace void __init early_ioremap_init(void)
 	early_ioremap_setup();
 }
 
-static void __init *early_alloc_pgtable(unsigned long size)
+void __init *early_alloc_pgtable(unsigned long size)
 {
 	void *ptr = memblock_alloc(size, size);
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 0c3c69ebf19f..fa4bb096b3ae 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -37,7 +37,6 @@ config PPC_85xx
 
 config PPC_8xx
 	bool "Freescale 8xx"
-	select ARCH_HAS_HUGEPD if HUGETLB_PAGE
 	select ARCH_SUPPORTS_HUGETLBFS
 	select FSL_SOC
 	select PPC_KUEP
-- 
2.44.0


