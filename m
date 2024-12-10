Return-Path: <linux-kernel+bounces-439788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B569EB3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABEC2847E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A63F1C07F8;
	Tue, 10 Dec 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0ah19co"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769401AAE25
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842219; cv=none; b=hKrU3HSk1DZfnVJWqSCDeOsL+XBVEIcK8gEHWSuZC8yrVZSbg5RuheVnmEyk7DqLpRVWO2sPxdzmVCgF6A/UJgiZ998skT6p3usJFsMh6TZJAwybrHtACqdtgKEhsBr8gMsjQEht+vQV4JrSXtXK/FiECZtz50JoX/l3m+Z5eh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842219; c=relaxed/simple;
	bh=GRqjA+rpBHOuSjrsnumnoiqHxjJy3xN3vZ5oljrS+jM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDsLNyZSGF94EK2SVJpfRdpZloomffjLKHxSVQarSLB+sRC/G4szoKLG6Dx68Cura3rAf32CF8w4wzOthyYTK6Roz4d1NVyPDfB9tKJv+zbuSg8D2407wozfkEoeYCGkWIm4Ovwgwe4mFqcoxWTJarwr+fNZm4vsQUTYtjEnR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0ah19co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B7BC4CED6;
	Tue, 10 Dec 2024 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842218;
	bh=GRqjA+rpBHOuSjrsnumnoiqHxjJy3xN3vZ5oljrS+jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0ah19coPDOz8KHkIoNiQI90fZNo2HYPDoX4iUF92AxvldBLQA5G4x+2DwMZCTwFb
	 z+sUTtDgtKpwXtmO/5YrrBi3wUjEb6gcGLh3cpHBeMlZR0QY1ZN5uZoevIzDU0uez4
	 qP15rPuUu4OO0CD4wfyXCbKrWf0ZLB2QguP28qp41VCjWopL9c+s0ry539OWfV6Ti7
	 wWSVMImmikNQTwyQtnC9SA0YCiGR7QH7RIjV57XP9wxp7KGzSSmPqx3/ejlP5lA0sd
	 CK36lvo+ygKj++p16ZRtdMlAz67oMFItJfWyfvrzE9eOdVZR7kmPZWCr7LsrR2xkxN
	 kXRRYdr+c6XQw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 08/11] x86: drop support for CONFIG_HIGHPTE
Date: Tue, 10 Dec 2024 15:49:42 +0100
Message-Id: <20241210144945.2325330-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210144945.2325330-1-arnd@kernel.org>
References: <20241210144945.2325330-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With the maximum amount of RAM now 4GB, there is very little point
to still have PTE pages in highmem. Drop this for simplification.

The only other architecture supporting HIGHPTE is 32-bit arm, and
once that feature is removed as well, the highpte logic can be
dropped from common code as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../admin-guide/kernel-parameters.txt         |  7 -----
 arch/x86/Kconfig                              |  9 -------
 arch/x86/include/asm/pgalloc.h                |  5 ----
 arch/x86/mm/pgtable.c                         | 27 +------------------
 4 files changed, 1 insertion(+), 47 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index eca370e99844..cf25853a5c4a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7341,13 +7341,6 @@
 				16 - SIGBUS faults
 			Example: user_debug=31
 
-	userpte=
-			[X86,EARLY] Flags controlling user PTE allocations.
-
-				nohigh = do not allocate PTE pages in
-					HIGHMEM regardless of setting
-					of CONFIG_HIGHPTE.
-
 	vdso=		[X86,SH,SPARC]
 			On X86_32, this is an alias for vdso32=.  Otherwise:
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d0d055f6f56e..d8a8bf9ea9b9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1621,15 +1621,6 @@ config X86_PMEM_LEGACY
 
 	  Say Y if unsure.
 
-config HIGHPTE
-	bool "Allocate 3rd-level pagetables from highmem"
-	depends on HIGHMEM
-	help
-	  The VM uses one page table entry for each page of physical memory.
-	  For systems with a lot of RAM, this can be wasteful of precious
-	  low memory.  Setting this option will put user-space page table
-	  entries in high memory.
-
 config X86_CHECK_BIOS_CORRUPTION
 	bool "Check for low memory corruption"
 	help
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index dcd836b59beb..582cf5b7ec8c 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -29,11 +29,6 @@ static inline void paravirt_release_pud(unsigned long pfn) {}
 static inline void paravirt_release_p4d(unsigned long pfn) {}
 #endif
 
-/*
- * Flags to use when allocating a user page table page.
- */
-extern gfp_t __userpte_alloc_gfp;
-
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
  * Instead of one PGD, we acquire two PGDs.  Being order-1, it is
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index b8f9e69b25c1..3d7072aec486 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -12,12 +12,6 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
 EXPORT_SYMBOL(physical_mask);
 #endif
 
-#ifdef CONFIG_HIGHPTE
-#define PGTABLE_HIGHMEM __GFP_HIGHMEM
-#else
-#define PGTABLE_HIGHMEM 0
-#endif
-
 #ifndef CONFIG_PARAVIRT
 static inline
 void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
@@ -26,29 +20,10 @@ void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 }
 #endif
 
-gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
-
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	return __pte_alloc_one(mm, __userpte_alloc_gfp);
-}
-
-static int __init setup_userpte(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	/*
-	 * "userpte=nohigh" disables allocation of user pagetables in
-	 * high memory.
-	 */
-	if (strcmp(arg, "nohigh") == 0)
-		__userpte_alloc_gfp &= ~__GFP_HIGHMEM;
-	else
-		return -EINVAL;
-	return 0;
+	return __pte_alloc_one(mm, GFP_PGTABLE_USER);
 }
-early_param("userpte", setup_userpte);
 
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
-- 
2.39.5


