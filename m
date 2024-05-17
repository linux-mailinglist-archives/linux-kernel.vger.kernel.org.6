Return-Path: <linux-kernel+bounces-182531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139048C8C64
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD377284EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580C13E3E0;
	Fri, 17 May 2024 19:00:36 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638213D8B7
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972436; cv=none; b=g4h3XpcrHWy6Ah8cSITywpKQErZQ3ZwdooXK/xyd8IfFdUcsLZYudgmZSX8mlEdc1SLb6SPCRrnST6bTA2CBdQj95uYf33NDdUpX3dLAxxYKNhEeBI/gyGAM5k9p/LErIzGCjFfm6ad6ZJN0mlAMBQUzXB8DbruqcQmgbrixWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972436; c=relaxed/simple;
	bh=Dh0nhguSpL9n3XQFSbUbzJ8GDug0jKbT2rL1D1ri4LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djFMe0+Wuk8rk8kcjWOHH+h4L4D05ESVhBxnOq9sJnVxuTSwZbOOFa8a3wIWHYxBMxuS8svUiW5vukn9P+WmR4d152AUssbox011OOwkVWrAOoMepCoJUzDNg/9iC/8J/xjw2N4MkyUbID82MrEb2ekdFx6RoDVB1luGRRMg04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Vgx9L15H6z9syQ;
	Fri, 17 May 2024 21:00:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZubkgE9RBfQR; Fri, 17 May 2024 21:00:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Vgx9J6TWWz9sv8;
	Fri, 17 May 2024 21:00:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D9E288B783;
	Fri, 17 May 2024 21:00:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id K8bPZqaUNiS5; Fri, 17 May 2024 21:00:04 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.121])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D7848B775;
	Fri, 17 May 2024 21:00:04 +0200 (CEST)
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
Subject: [RFC PATCH v2 03/20] mm: Provide pmd to pte_leaf_size()
Date: Fri, 17 May 2024 20:59:57 +0200
Message-ID: <ab93995d27055f055249e1e8770b22f89c980322.1715971869.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715971869.git.christophe.leroy@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715972396; l=4424; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Dh0nhguSpL9n3XQFSbUbzJ8GDug0jKbT2rL1D1ri4LQ=; b=wvraNPMkAKUlglx94Er8Qmm1y2YxNqFMrMAfd0xmtKmew69Jy03RGG1CstL3zHihW0dmzSVVd vdSl4fQh+mcBXkBHxMcABuo4U+z1HETYzKkIEE25b/I7VEwLq9+t2J8
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

On powerpc 8xx, when a page is 8M size, the information is in the PMD
entry. So provide it to pte_leaf_size().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/arm64/include/asm/pgtable.h             | 2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
 arch/riscv/include/asm/pgtable.h             | 2 +-
 arch/sparc/include/asm/pgtable_64.h          | 2 +-
 arch/sparc/mm/hugetlbpage.c                  | 2 +-
 include/linux/pgtable.h                      | 2 +-
 kernel/events/core.c                         | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index afdd56d26ad7..57c40f2498ab 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -624,7 +624,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 #define pmd_bad(pmd)		(!pmd_table(pmd))
 
 #define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
-#define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
+#define pte_leaf_size(pmd, pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
 
 #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
 static inline bool pud_sect(pud_t pud) { return false; }
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index 137dc3c84e45..07df6b664861 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -151,7 +151,7 @@ static inline unsigned long pgd_leaf_size(pgd_t pgd)
 
 #define pgd_leaf_size pgd_leaf_size
 
-static inline unsigned long pte_leaf_size(pte_t pte)
+static inline unsigned long pte_leaf_size(pmd_t pmd, pte_t pte)
 {
 	pte_basic_t val = pte_val(pte);
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 6afd6bb4882e..9d9abe161a89 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -434,7 +434,7 @@ static inline pte_t pte_mkhuge(pte_t pte)
 }
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-#define pte_leaf_size(pte)	(pte_napot(pte) ?				\
+#define pte_leaf_size(pmd, pte)	(pte_napot(pte) ?				\
 					napot_cont_size(napot_cont_order(pte)) :\
 					PAGE_SIZE)
 #endif
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 4d1bafaba942..67063af2ff8f 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1175,7 +1175,7 @@ extern unsigned long pud_leaf_size(pud_t pud);
 extern unsigned long pmd_leaf_size(pmd_t pmd);
 
 #define pte_leaf_size pte_leaf_size
-extern unsigned long pte_leaf_size(pte_t pte);
+extern unsigned long pte_leaf_size(pmd_t pmd, pte_t pte);
 
 #endif /* CONFIG_HUGETLB_PAGE */
 
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 5a342199e837..60c845a15bee 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -276,7 +276,7 @@ static unsigned long huge_tte_to_size(pte_t pte)
 
 unsigned long pud_leaf_size(pud_t pud) { return 1UL << tte_to_shift(*(pte_t *)&pud); }
 unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift(*(pte_t *)&pmd); }
-unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift(pte); }
+unsigned long pte_leaf_size(pmd_t pmd, pte_t pte) { return 1UL << tte_to_shift(pte); }
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz)
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 85fc7554cd52..e605a4149fc7 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1802,7 +1802,7 @@ typedef unsigned int pgtbl_mod_mask;
 #define pmd_leaf_size(x) PMD_SIZE
 #endif
 #ifndef pte_leaf_size
-#define pte_leaf_size(x) PAGE_SIZE
+#define pte_leaf_size(x, y) PAGE_SIZE
 #endif
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..5c1c083222b2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7585,7 +7585,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 
 	pte = ptep_get_lockless(ptep);
 	if (pte_present(pte))
-		size = pte_leaf_size(pte);
+		size = pte_leaf_size(pmd, pte);
 	pte_unmap(ptep);
 #endif /* CONFIG_HAVE_FAST_GUP */
 
-- 
2.44.0


