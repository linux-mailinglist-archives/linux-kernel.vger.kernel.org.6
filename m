Return-Path: <linux-kernel+bounces-534993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B29A46DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5558E188BD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B878265CDF;
	Wed, 26 Feb 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4MWJ+n0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5B2627F9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605872; cv=none; b=L9PhVZk+NDLBwjFX8qYktsBPnG8HywynzTBiDR94g9LRepMF813mn3ckuCrubr4J55hU/il6UlXFhTn1Z+iME5cu2ULtMouDEnMCVDnFE5Mv1Pg1DIflaFB0U9EL1j+VRcIdgdVirRfc0uObzGbjyDFqpiRDqe+AmQ0mcU2pBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605872; c=relaxed/simple;
	bh=xj/gLOZ/k2k+B/blJANMifXDpdMYDOOrLdtoa3y2btI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omF9dI72BnSLNlZUsAOGeTCk6/nzlQ+o5Gcg20zMwJ5ILsAOvgfjlWyy+OFW1T7mgNx+AHxdC7+FCb+zuGymgK75Y2N7yqgK+z9RE1xTeOkSYGbu1n4FnTZXFUfrOQ8daEAqob7AUqRsfI1Zyvq/Qxyj1fhHxeO+Q51dgRoVNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4MWJ+n0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52110C4CEF1;
	Wed, 26 Feb 2025 21:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740605872;
	bh=xj/gLOZ/k2k+B/blJANMifXDpdMYDOOrLdtoa3y2btI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4MWJ+n0WIVD4HgQicoRwhG2JTQFtfijB7juAATE/bwkZmCIJwHFIKaQFy3RDPuVs
	 UPFpDqexwxETqjy+NJWJzYutvaLi1/xi8/2D5REUTWTd+uU24xfiOwgITjZ1XXGnmE
	 OPm1EpZ7kBPuV0ZgQTJj+L5ZUB7y+BH25h/aTZVACqv2rvO8u0cCWXONILRGtn2og6
	 YmIRh1x129yISFf+S43VOxvDl9lM+t4XFVZr+8Gx4KCu6Bx1GDxDIOxsfHTjacNGT2
	 Q22LgxTLJTGGwHvmmUWvGywGxqZso+w/ycT5vLV2523NAQT2C2XS9lmy7ie3TdKa3e
	 F+6MiBITjpebA==
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
Subject: [PATCH v3 07/10] x86: drop support for CONFIG_HIGHPTE
Date: Wed, 26 Feb 2025 22:37:11 +0100
Message-Id: <20250226213714.4040853-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226213714.4040853-1-arnd@kernel.org>
References: <20250226213714.4040853-1-arnd@kernel.org>
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
index 8f923770a566..93177630cefb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7668,13 +7668,6 @@
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
index 2810482dc183..aba32f88870d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1627,15 +1627,6 @@ config X86_PMEM_LEGACY
 
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
index dd4841231bb9..a33147520044 100644
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
index 1fef5ad32d5a..94b5601f2cd8 100644
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
 #ifndef CONFIG_PT_RECLAIM
 static inline
@@ -37,29 +31,10 @@ void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 #endif /* !CONFIG_PT_RECLAIM */
 #endif /* !CONFIG_PARAVIRT */
 
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


