Return-Path: <linux-kernel+bounces-230504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057B9917DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289F21C21770
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323F178376;
	Wed, 26 Jun 2024 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7cwz19/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B8176FD8;
	Wed, 26 Jun 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397597; cv=none; b=C0DkN/HFMMBc1+iHorMsEwtm9JdG1qvVFPqXomoXV2EDsbA8aCwNl1HmI/j+2mZe/I4ZdVf/4gTO3B3YvzHX1EIYj2rqYX8lTqA8B2ZCQHSc+YV306SpVD4ElRXizjX0dc4nF78C0AH3+QbNI3gVKxR3EosC5KynA/bnfiqMEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397597; c=relaxed/simple;
	bh=aZu+Mw0vfm4/9w7mYiCaTAnZdqPaRT0XCeUV9gyIA/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQhaGMrnSxFeEYmD3u+jUn424ABcOs0brBsNBfyPXeaTb3O9dD2IVpkFn06c5Wj5QtiLWtSrDlNM+V7UtLQPKZ7pc4GTtRsISVPPq5q8Hgv3AnB2omGCHVIzXC1iaJZI9MXUuOeAuoca827jVFQAWgIfD0mb4dtrNke25grudn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7cwz19/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719397595; x=1750933595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aZu+Mw0vfm4/9w7mYiCaTAnZdqPaRT0XCeUV9gyIA/I=;
  b=K7cwz19/8xs3WFKjmY8hdqP5XwgnyQh4YThAKpBU9r2CQQ1aHc/uQxVe
   35yKP6Y2vIEPoXvwGfcmylWOLUQUFCvYUpOZhp+sPUpj+64ZE1ExvLLk/
   aWFSxl75s+//xV+Fn6C3cYAkDTybbzOyrTX2tBxdTGbUjkkhnKuLJFKaq
   ZiuP2e1GoJjWeWP4rxrgTTBG+rm2J5PfNE03XkJJ2+hUbe536eJDGbv4K
   MiMzQS5z/Hhp+xO6Cb3HydpJO/9siYCBxy48+c3mCNAHg2RkvdtZmfzQp
   qzPpHX8cZL/x3HNnVxrGvp9ZdIqdxxO/hyy77O4ZD/yGuG8BaDSY24VVr
   Q==;
X-CSE-ConnectionGUID: vsiYa5cWQPurpoE6ak3CrQ==
X-CSE-MsgGUID: mn4Pf3P+Sb6NGEB7+ewqtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16289598"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16289598"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:26:34 -0700
X-CSE-ConnectionGUID: alq2O/tdTzC+p2wktYbNcA==
X-CSE-MsgGUID: yw3vwxmvRmyD9IvLd1iJKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44053625"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 26 Jun 2024 03:26:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7E75B346; Wed, 26 Jun 2024 13:26:27 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: lkp@intel.com
Cc: ardb@kernel.org,
	bp@alien8.de,
	brijesh.singh@amd.com,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	jan.kiszka@siemens.com,
	jgross@suse.com,
	kbingham@kernel.org,
	kirill.shutemov@linux.intel.com,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	luto@kernel.org,
	michael.roth@amd.com,
	mingo@redhat.com,
	oe-kbuild-all@lists.linux.dev,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	sandipan.das@amd.com,
	tglx@linutronix.de,
	thomas.lendacky@amd.com,
	x86@kernel.org
Subject: [PATCH] x86/64/mm: Make 5-level paging support unconditional
Date: Wed, 26 Jun 2024 13:26:23 +0300
Message-ID: <20240626102624.1059275-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202406260735.rkb4c8N7-lkp@intel.com>
References: <202406260735.rkb4c8N7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both Intel and AMD CPUs support 5-level paging, which is expected to
become more widely adopted in the future.

Remove CONFIG_X86_5LEVEL and ifdeffery for it to make it more readable.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
---

 v2:
  - Fix 32-bit build by wrapping p4d_set_huge() and p4d_clear_huge() in
    #if CONFIG_PGTABLE_LEVELS > 4

---
 Documentation/arch/x86/cpuinfo.rst            |  8 +++----
 .../arch/x86/x86_64/5level-paging.rst         |  9 --------
 arch/x86/Kconfig                              | 22 +------------------
 arch/x86/boot/compressed/pgtable_64.c         | 11 ++--------
 arch/x86/boot/header.S                        |  4 ----
 arch/x86/include/asm/disabled-features.h      |  9 +-------
 arch/x86/include/asm/page_64.h                |  2 --
 arch/x86/include/asm/page_64_types.h          |  7 ------
 arch/x86/include/asm/pgtable_64_types.h       | 18 ---------------
 arch/x86/kernel/alternative.c                 |  2 +-
 arch/x86/kernel/head64.c                      |  5 -----
 arch/x86/kernel/head_64.S                     |  2 --
 arch/x86/mm/init.c                            |  4 ----
 arch/x86/mm/pgtable.c                         |  2 +-
 drivers/firmware/efi/libstub/x86-5lvl.c       |  2 +-
 .../arch/x86/include/asm/disabled-features.h  |  9 +-------
 16 files changed, 11 insertions(+), 105 deletions(-)

diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/cpuinfo.rst
index 8895784d4784..0ea70924c89e 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -171,10 +171,10 @@ For example, when an old kernel is running on new hardware.
 
 c: The kernel disabled support for it at compile-time.
 ------------------------------------------------------
-For example, if 5-level-paging is not enabled when building (i.e.,
-CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show up [#f1]_.
+For example, if Linear Address Masking (LAM) is not enabled when building (i.e.,
+CONFIG_ADDRESS_MASKING is not selected) the flag "lam" will not show up.
 Even though the feature will still be detected via CPUID, the kernel disables
-it by clearing via setup_clear_cpu_cap(X86_FEATURE_LA57).
+it by clearing via setup_clear_cpu_cap(X86_FEATURE_LAM).
 
 d: The feature is disabled at boot-time.
 ----------------------------------------
@@ -197,5 +197,3 @@ missing at runtime. For example, AVX flags will not show up if XSAVE feature
 is disabled since they depend on XSAVE feature. Another example would be broken
 CPUs and them missing microcode patches. Due to that, the kernel decides not to
 enable a feature.
-
-.. [#f1] 5-level paging uses linear address of 57 bits.
diff --git a/Documentation/arch/x86/x86_64/5level-paging.rst b/Documentation/arch/x86/x86_64/5level-paging.rst
index 71f882f4a173..ad7ddc13f79d 100644
--- a/Documentation/arch/x86/x86_64/5level-paging.rst
+++ b/Documentation/arch/x86/x86_64/5level-paging.rst
@@ -22,15 +22,6 @@ QEMU 2.9 and later support 5-level paging.
 Virtual memory layout for 5-level paging is described in
 Documentation/arch/x86/x86_64/mm.rst
 
-
-Enabling 5-level paging
-=======================
-CONFIG_X86_5LEVEL=y enables the feature.
-
-Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
-In this case additional page table level -- p4d -- will be folded at
-runtime.
-
 User-space and large virtual address space
 ==========================================
 On x86, 5-level paging enables 56-bit userspace virtual address space.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 54ad2462e9ef..f95a5048ad09 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -408,8 +408,7 @@ config DYNAMIC_PHYSICAL_MASK
 
 config PGTABLE_LEVELS
 	int
-	default 5 if X86_5LEVEL
-	default 4 if X86_64
+	default 5 if X86_64
 	default 3 if X86_PAE
 	default 2
 
@@ -1498,25 +1497,6 @@ config X86_PAE
 	  has the cost of more pagetable lookup overhead, and also
 	  consumes more pagetable space per process.
 
-config X86_5LEVEL
-	bool "Enable 5-level page tables support"
-	default y
-	depends on X86_64
-	help
-	  5-level paging enables access to larger address space:
-	  up to 128 PiB of virtual address space and 4 PiB of
-	  physical address space.
-
-	  It will be supported by future Intel CPUs.
-
-	  A kernel with the option enabled can be booted on machines that
-	  support 4- or 5-level paging.
-
-	  See Documentation/arch/x86/x86_64/5level-paging.rst for more
-	  information.
-
-	  Say N if unsure.
-
 config X86_DIRECT_GBPAGES
 	def_bool y
 	depends on X86_64
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c882e1f67af0..61b9ca61bde1 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -10,12 +10,10 @@
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
 
-#ifdef CONFIG_X86_5LEVEL
 /* __pgtable_l5_enabled needs to be in .data to avoid being cleared along with .bss */
 unsigned int __section(".data") __pgtable_l5_enabled;
 unsigned int __section(".data") pgdir_shift = 39;
 unsigned int __section(".data") ptrs_per_p4d = 1;
-#endif
 
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
@@ -113,18 +111,13 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	 * Check if LA57 is desired and supported.
 	 *
 	 * There are several parts to the check:
-	 *   - if the kernel supports 5-level paging: CONFIG_X86_5LEVEL=y
 	 *   - if user asked to disable 5-level paging: no5lvl in cmdline
 	 *   - if the machine supports 5-level paging:
 	 *     + CPUID leaf 7 is supported
 	 *     + the leaf has the feature bit set
-	 *
-	 * That's substitute for boot_cpu_has() in early boot code.
 	 */
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) &&
-			!cmdline_find_option_bool("no5lvl") &&
-			native_cpuid_eax(0) >= 7 &&
-			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
+	if (!cmdline_find_option_bool("no5lvl") &&
+	    native_cpuid_eax(0) >= 7 && (native_cpuid_ecx(7) & BIT(16))) {
 		l5_required = true;
 
 		/* Initialize variables for 5-level paging */
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b5c79f43359b..32361cef909e 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -361,12 +361,8 @@ xloadflags:
 #endif
 
 #ifdef CONFIG_X86_64
-#ifdef CONFIG_X86_5LEVEL
 #define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
 #else
-#define XLF56 XLF_5LEVEL
-#endif
-#else
 #define XLF56 0
 #endif
 
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c492bdc97b05..19cf1678fcaa 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -38,12 +38,6 @@
 # define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
 #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
-#ifdef CONFIG_X86_5LEVEL
-# define DISABLE_LA57	0
-#else
-# define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
-#endif
-
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 # define DISABLE_PTI		0
 #else
@@ -149,8 +143,7 @@
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
-#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
+#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_UMIP|DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	(DISABLE_SEV_SNP)
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e087192..3b8cb6a8b122 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -60,7 +60,6 @@ static inline void clear_page(void *page)
 
 void copy_page(void *to, void *from);
 
-#ifdef CONFIG_X86_5LEVEL
 /*
  * User space process size.  This is the first address outside the user range.
  * There are a few constraints that determine this:
@@ -91,7 +90,6 @@ static __always_inline unsigned long task_size_max(void)
 
 	return ret;
 }
-#endif	/* CONFIG_X86_5LEVEL */
 
 #endif	/* !__ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index c2f3c50a2787..666a5d6ab910 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -48,14 +48,7 @@
 /* See Documentation/arch/x86/x86_64/mm.rst for a description of the memory map. */
 
 #define __PHYSICAL_MASK_SHIFT	52
-
-#ifdef CONFIG_X86_5LEVEL
 #define __VIRTUAL_MASK_SHIFT	(pgtable_l5_enabled() ? 56 : 47)
-/* See task_size_max() in <asm/page_64.h> */
-#else
-#define __VIRTUAL_MASK_SHIFT	47
-#define task_size_max()		((_AC(1,UL) << __VIRTUAL_MASK_SHIFT) - PAGE_SIZE)
-#endif
 
 #define TASK_SIZE_MAX		task_size_max()
 #define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 09df8939b997..2c77489ac86c 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -23,7 +23,6 @@ typedef struct { pmdval_t pmd; } pmd_t;
 
 extern unsigned int __pgtable_l5_enabled;
 
-#ifdef CONFIG_X86_5LEVEL
 #ifdef USE_EARLY_PGTABLE_L5
 /*
  * cpu_feature_enabled() is not available in early boot code.
@@ -37,10 +36,6 @@ static inline bool pgtable_l5_enabled(void)
 #define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
 #endif /* USE_EARLY_PGTABLE_L5 */
 
-#else
-#define pgtable_l5_enabled() 0
-#endif /* CONFIG_X86_5LEVEL */
-
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
@@ -48,8 +43,6 @@ extern unsigned int ptrs_per_p4d;
 
 #define SHARED_KERNEL_PMD	0
 
-#ifdef CONFIG_X86_5LEVEL
-
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
@@ -67,17 +60,6 @@ extern unsigned int ptrs_per_p4d;
 
 #define MAX_POSSIBLE_PHYSMEM_BITS	52
 
-#else /* CONFIG_X86_5LEVEL */
-
-/*
- * PGDIR_SHIFT determines what a top-level page table entry can map
- */
-#define PGDIR_SHIFT		39
-#define PTRS_PER_PGD		512
-#define MAX_PTRS_PER_P4D	1
-
-#endif /* CONFIG_X86_5LEVEL */
-
 /*
  * 3rd level page
  */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 37596a417094..f1c519abb925 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -457,7 +457,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 
 	/*
-	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
+	 * KASAN_SHADOW_START is defined using
 	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
 	 * During the process, KASAN becomes confused seeing partial LA57
 	 * conversion and triggers a false-positive out-of-bound report.
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index ec36ad7117ae..ec3a7e2ea222 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -52,13 +52,11 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
 static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
-#ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled __ro_after_init;
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
-#endif
 
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
@@ -69,9 +67,6 @@ EXPORT_SYMBOL(vmemmap_base);
 
 static inline bool check_la57_support(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
-		return false;
-
 	/*
 	 * 5-level paging is detected and enabled at kernel decompression
 	 * stage. Only check if it has been enabled there.
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 330922b328bf..4b2b2138c163 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -659,12 +659,10 @@ SYM_DATA_START_PTI_ALIGNED(init_top_pgt)
 SYM_DATA_END(init_top_pgt)
 #endif
 
-#ifdef CONFIG_X86_5LEVEL
 SYM_DATA_START_PAGE_ALIGNED(level4_kernel_pgt)
 	.fill	511,8,0
 	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 SYM_DATA_END(level4_kernel_pgt)
-#endif
 
 SYM_DATA_START_PAGE_ALIGNED(level3_kernel_pgt)
 	.fill	L3_START_KERNEL,8,0
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index eb503f53c319..5a980a452f4c 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -173,11 +173,7 @@ __ref void *alloc_low_pages(unsigned int num)
  * randomization is enabled.
  */
 
-#ifndef CONFIG_X86_5LEVEL
-#define INIT_PGD_PAGE_TABLES    3
-#else
 #define INIT_PGD_PAGE_TABLES    4
-#endif
 
 #ifndef CONFIG_RANDOMIZE_MEMORY
 #define INIT_PGD_PAGE_COUNT      (2 * INIT_PGD_PAGE_TABLES)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 93e54ba91fbf..a3ef75c06c58 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -691,7 +691,7 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 }
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-#ifdef CONFIG_X86_5LEVEL
+#if CONFIG_PGTABLE_LEVELS > 4
 /**
  * p4d_set_huge - setup kernel P4D mapping
  *
diff --git a/drivers/firmware/efi/libstub/x86-5lvl.c b/drivers/firmware/efi/libstub/x86-5lvl.c
index 77359e802181..f1c5fb45d5f7 100644
--- a/drivers/firmware/efi/libstub/x86-5lvl.c
+++ b/drivers/firmware/efi/libstub/x86-5lvl.c
@@ -62,7 +62,7 @@ efi_status_t efi_setup_5level_paging(void)
 
 void efi_5level_switch(void)
 {
-	bool want_la57 = IS_ENABLED(CONFIG_X86_5LEVEL) && !efi_no5lvl;
+	bool want_la57 = !efi_no5lvl;
 	bool have_la57 = native_read_cr4() & X86_CR4_LA57;
 	bool need_toggle = want_la57 ^ have_la57;
 	u64 *pgt = (void *)la57_toggle + PAGE_SIZE;
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index c492bdc97b05..19cf1678fcaa 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -38,12 +38,6 @@
 # define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
 #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
-#ifdef CONFIG_X86_5LEVEL
-# define DISABLE_LA57	0
-#else
-# define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
-#endif
-
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 # define DISABLE_PTI		0
 #else
@@ -149,8 +143,7 @@
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
-#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
+#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_UMIP|DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	(DISABLE_SEV_SNP)
-- 
2.43.0


