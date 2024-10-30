Return-Path: <linux-kernel+bounces-388456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CEB9B5FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E391C21511
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00C1E2854;
	Wed, 30 Oct 2024 10:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XikBiwo0"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1B1E6DC5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283527; cv=none; b=P+Y7xDrp784mPMZ1nK8tskXWGe0355026F14lSI0MUUOl7Ugnma97lgvXKlfCbnKhT6uSrU6FkUZYr3sLz9jvN/+qUUztRE39XetYRY5bwGGGsRK6/6Al6Nbx29KioRxqHDSRvLVdPbtRmP5dK/5Qu4EbP8EIEfN7Q9pSdkn5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283527; c=relaxed/simple;
	bh=3vAy0d7lFCp1RzQmO1BUis0dlXD2HX7MNLRY8U0tmUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYds6lAwuM1Y8OtKeuTv4frkSSUeT47h//kX345Fxtye+jMr/YCryMCOcf5V6L2Psh47qBt6bQGOUYGXpaHNrB69tg3+sl7cSO0xF2hVwBaArvz9kpa59QK5dE3BKlRWWmPULTNhiWmncb17pd6yGdIsQRZYED1KGFHV40NgSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XikBiwo0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30cf121024so1494862276.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730283523; x=1730888323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg/kIHVTHiz8etJGdNS9GpgXHNuRCTwjnnrHRUXl/AA=;
        b=XikBiwo0tEtktj1PGRig++P3TUlEbmO+BurWBXgUr3va0SdNc7huePRWac9+zzUvvm
         MNXAVxATjrP4316oINTqzjtdD+ncXlNFcLiMbnbZ2Rb8jtdA0HiX0ovHaN2KCFkGq351
         aHQyrXesZNknU4DQr3vrKreQ+f2oDbN8vn5FvMTUQNbfRGgMQyHhAc3oV+om2vENHFBN
         fdqfVQeaZPyn+XLbWl6pDjmgdvmRbG8uDYvpc/cnLr8IbJcE//s6uja/i+PkFdITytYl
         Un0NBOI/xbMTNlA6Mw6pOKUkt5ZbMBF8BZqEaE4LLtENmtuDD8zkxz3qPHoWaP+CWxA0
         NPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283523; x=1730888323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg/kIHVTHiz8etJGdNS9GpgXHNuRCTwjnnrHRUXl/AA=;
        b=EUFifN9aJHhveBDEz+oQO8VXXbs65OXtAaAJJABvb9vkpw5O6kEpQn/CyGaCljzy7d
         yHDtd8MzReQNX5yoBrDFR6KA7ACecD7OS0mYSznFmb4qqe60BxKiOzkkfMy6JpRGvm0K
         dDsVGfIWR3dZ0f6P0bUESz3aZZR/Ml0r76B017b9omcFTUWljraneP5pppOR0nL/WJMh
         3iFcAjCEQWXWNBSbyV+aRbE4qpfGhCc1d2BKGsI+ZS9Sr6oSiaEmVo2hw9Y8113X0fsb
         cVfd8b1VNAwUL0rYjbv6URTea1kMs/wTuL2m62VOhtWWd2+slaMfZ4NGfdz6kPy9aC91
         1H0A==
X-Gm-Message-State: AOJu0Yx8DgTJRhfoRhWkPdpfNUDRZUX5hjdvZonlVlG6oOX5rONOXB0N
	ztG9kWDtltj/hl/ac1YLnuy18V/53L0bbgLTfHgwvV0SzGXMqazEMlLUBQRVCByd7qTo0Q==
X-Google-Smtp-Source: AGHT+IHs9QWvufbOWXr5ECBWgcAR6C8EuNXNWeeS3nrHZJLBKoPbhzIuqfsM8OKvQ+nmRRRRdEtMEeLD
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a5b:91:0:b0:e28:f2a5:f1d with SMTP id
 3f1490d57ef6-e3087a4ed65mr49338276.4.1730283523057; Wed, 30 Oct 2024 03:18:43
 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:18:11 +0100
In-Reply-To: <20241030101803.2037606-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030101803.2037606-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=11655; i=ardb@kernel.org;
 h=from:subject; bh=EsNyVRynRKFNOTFmisbkOFj6S81RcOlobIQYO8jCGKU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIV2J/VlU76I5Jgue2PF8CVvna5Xc0Pj2ixzvq0el4Ut7H
 vhmbNnUUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyXoCR4dmsoy+3PVKvEVdm
 ilj+zV80c5LqTI3m9DY/80xT/oI7QowMVw1z2S5N2z0/ofdY0qFzLmZr/SsU/3zx6suKSJwWt5W NCQA=
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030101803.2037606-17-ardb+git@google.com>
Subject: [RFC PATCH 7/8] arm64/mm: Use reduced VA sizes (36/39/42 bits) only
 for user space
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The advantage of a reduced virtual address space size is its impact on
the number of translation levels, which affects TLB pressure. The
working set of translations covering the kernel side is negligible
compared to user space, where each process has its own set of page
tables, and so most of the same benefit can be obtained by reducing the
VA size only for user space.

As a preparatory step towards implementing this, drop all the reduced VA
space sizes in Kconfig, and replace it with a configurable userland VA
space size that is reflected in TASK_SIZE. This will be taken advantage
of in a subsequent patch to actually reduce the number of translations
used by the MMU for translating user space virtual addresses.

As a bonus, this will allow 36-bit virtual addressing for user space to
be used on SoCs whose physical address space layout is based on the
misguided 'Principles of ARM memory maps' document, which struggle with
this currently, given that a 35-bit linear map can only fit 2 GiB of RAM
(and on these designs, the rest of RAM comes after a 30 GiB hole in the
physical address space)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Kconfig                     | 56 +++++++++-----------
 arch/arm64/include/asm/assembler.h     |  2 +-
 arch/arm64/include/asm/memory.h        |  4 --
 arch/arm64/include/asm/pgtable-hwdef.h |  2 -
 arch/arm64/include/asm/processor.h     |  6 +--
 arch/arm64/kernel/cpufeature.c         |  2 -
 arch/arm64/kernel/head.S               |  4 --
 arch/arm64/mm/init.c                   |  4 +-
 arch/arm64/mm/proc.S                   |  2 -
 9 files changed, 31 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 39d0d2eb5b7c..78e82383f8e2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -111,7 +111,7 @@ config ARM64
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_FRAME_POINTERS
-	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
+	select ARCH_WANT_HUGE_PMD_SHARE if !ARM64_64K_PAGES
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_EXECMEM_LATE if EXECMEM
 	select ARCH_WANTS_NO_INSTR
@@ -321,9 +321,9 @@ config ARCH_MMAP_RND_BITS_MIN
 # max bits determined by the following formula:
 #  VA_BITS - PAGE_SHIFT - 3
 config ARCH_MMAP_RND_BITS_MAX
-	default 19 if ARM64_VA_BITS=36
-	default 24 if ARM64_VA_BITS=39
-	default 27 if ARM64_VA_BITS=42
+	default 19 if ARM64_USER_VA_BITS_36
+	default 24 if ARM64_USER_VA_BITS_39
+	default 27 if ARM64_USER_VA_BITS_42
 	default 29 if ARM64_64K_PAGES
 	default 30 if ARM64_16K_PAGES
 	default 33
@@ -377,9 +377,6 @@ config FIX_EARLYCON_MEM
 
 config PGTABLE_LEVELS
 	int
-	default 2 if ARM64_16K_PAGES && ARM64_VA_BITS_36
-	default 2 if ARM64_64K_PAGES && ARM64_VA_BITS_42
-	default 3 if ARM64_4K_PAGES && ARM64_VA_BITS_39
 	default 3 if ARM64_64K_PAGES
 	default 4 if ARM64_16K_PAGES
 	default 5 if ARM64_4K_PAGES
@@ -410,16 +407,10 @@ config BUILTIN_RETURN_ADDRESS_STRIPS_PAC
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN_GENERIC || KASAN_SW_TAGS
-	default 0xdfff800000000000 if ARM64_VA_BITS_52 && !ARM64_16K_PAGES && !KASAN_SW_TAGS
-	default 0xdfffc00000000000 if ARM64_VA_BITS_52 && ARM64_16K_PAGES && !KASAN_SW_TAGS
-	default 0xdffffe0000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
-	default 0xdfffffc000000000 if ARM64_VA_BITS_39 && !KASAN_SW_TAGS
-	default 0xdffffff800000000 if ARM64_VA_BITS_36 && !KASAN_SW_TAGS
-	default 0xefff800000000000 if ARM64_VA_BITS_52 && !ARM64_16K_PAGES && KASAN_SW_TAGS
-	default 0xefffc00000000000 if ARM64_VA_BITS_52 && ARM64_16K_PAGES && KASAN_SW_TAGS
-	default 0xeffffe0000000000 if ARM64_VA_BITS_42 && KASAN_SW_TAGS
-	default 0xefffffc000000000 if ARM64_VA_BITS_39 && KASAN_SW_TAGS
-	default 0xeffffff800000000 if ARM64_VA_BITS_36 && KASAN_SW_TAGS
+	default 0xdfff800000000000 if !ARM64_16K_PAGES && !KASAN_SW_TAGS
+	default 0xdfffc00000000000 if ARM64_16K_PAGES && !KASAN_SW_TAGS
+	default 0xefff800000000000 if !ARM64_16K_PAGES && KASAN_SW_TAGS
+	default 0xefffc00000000000 if ARM64_16K_PAGES && KASAN_SW_TAGS
 	default 0xffffffffffffffff
 
 config UNWIND_TABLES
@@ -1334,26 +1325,26 @@ config ARM64_64K_PAGES
 endchoice
 
 choice
-	prompt "Virtual address space size"
-	default ARM64_VA_BITS_52
+	prompt "Virtual address space size for user space"
+	default ARM64_USER_VA_BITS_52
 	help
 	  Allows choosing one of multiple possible virtual address
 	  space sizes. The level of translation table is determined by
 	  a combination of page size and virtual address space size.
 
-config ARM64_VA_BITS_36
-	bool "36-bit" if EXPERT
+config ARM64_USER_VA_BITS_36
+	bool "36-bit"
 	depends on PAGE_SIZE_16KB
 
-config ARM64_VA_BITS_39
+config ARM64_USER_VA_BITS_39
 	bool "39-bit"
 	depends on PAGE_SIZE_4KB
 
-config ARM64_VA_BITS_42
+config ARM64_USER_VA_BITS_42
 	bool "42-bit"
 	depends on PAGE_SIZE_64KB
 
-config ARM64_VA_BITS_52
+config ARM64_USER_VA_BITS_52
 	bool "52-bit"
 	help
 	  Enable 52-bit virtual addressing for userspace when explicitly
@@ -1372,7 +1363,7 @@ endchoice
 
 config ARM64_FORCE_52BIT
 	bool "Force 52-bit virtual addresses for userspace"
-	depends on ARM64_VA_BITS_52 && EXPERT
+	depends on ARM64_USER_VA_BITS_52 && EXPERT
 	help
 	  For systems with 52-bit userspace VAs enabled, the kernel will attempt
 	  to maintain compatibility with older software by providing 48-bit VAs
@@ -1385,10 +1376,14 @@ config ARM64_FORCE_52BIT
 
 config ARM64_VA_BITS
 	int
-	default 36 if ARM64_VA_BITS_36
-	default 39 if ARM64_VA_BITS_39
-	default 42 if ARM64_VA_BITS_42
-	default 52 if ARM64_VA_BITS_52
+	default 52
+
+config TASK_SIZE_BITS
+	int
+	default 36 if ARM64_USER_VA_BITS_36
+	default 39 if ARM64_USER_VA_BITS_39
+	default 42 if ARM64_USER_VA_BITS_42
+	default 52
 
 choice
 	prompt "Physical address space size"
@@ -1399,11 +1394,10 @@ choice
 
 config ARM64_PA_BITS_48
 	bool "48-bit"
-	depends on ARM64_64K_PAGES || !ARM64_VA_BITS_52
+	depends on ARM64_64K_PAGES
 
 config ARM64_PA_BITS_52
 	bool "52-bit"
-	depends on ARM64_64K_PAGES || ARM64_VA_BITS_52
 	help
 	  Enable support for a 52-bit physical address space, introduced as
 	  part of the ARMv8.2-LPA extension.
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 3d8d534a7a77..337ba98d0272 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -577,7 +577,7 @@ alternative_endif
  * 	ttbr: Value of ttbr to set, modified.
  */
 	.macro	offset_ttbr1, ttbr, tmp
-#if defined(CONFIG_ARM64_VA_BITS_52) && !defined(CONFIG_ARM64_LPA2)
+#ifndef CONFIG_ARM64_LPA2
 	mrs	\tmp, tcr_el1
 	and	\tmp, \tmp, #TCR_T1SZ_MASK
 	cmp	\tmp, #TCR_T1SZ(VA_BITS_MIN)
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0480c61dbb4f..e138deb78bee 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -53,15 +53,11 @@
 #define PCI_IO_END		(PCI_IO_START + PCI_IO_SIZE)
 #define FIXADDR_TOP		(-UL(SZ_8M))
 
-#if VA_BITS > 48
 #ifdef CONFIG_ARM64_16K_PAGES
 #define VA_BITS_MIN		(47)
 #else
 #define VA_BITS_MIN		(48)
 #endif
-#else
-#define VA_BITS_MIN		(VA_BITS)
-#endif
 
 #define _PAGE_END(va)		(-(UL(1) << ((va) - 1)))
 
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index fd330c1db289..a7e0c0f3c6c8 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -336,10 +336,8 @@
 #define TTBR_BADDR_MASK_52	GENMASK_ULL(47, 2)
 #endif
 
-#ifdef CONFIG_ARM64_VA_BITS_52
 /* Must be at least 64-byte aligned to prevent corruption of the TTBR */
 #define TTBR1_BADDR_4852_OFFSET	(((UL(1) << (52 - PGDIR_SHIFT)) - \
 				 (UL(1) << (48 - PGDIR_SHIFT))) * 8)
-#endif
 
 #endif
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 1bf1a3b16e88..62f30d8f9738 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -50,9 +50,9 @@
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
  */
 
-#define DEFAULT_MAP_WINDOW_64	(UL(1) << VA_BITS_MIN)
-#define TASK_SIZE_64		(UL(1) << vabits_actual)
-#define TASK_SIZE_MAX		(UL(1) << VA_BITS)
+#define DEFAULT_MAP_WINDOW_64	(UL(1) << MIN(VA_BITS_MIN, CONFIG_TASK_SIZE_BITS))
+#define TASK_SIZE_64		(UL(1) << MIN(vabits_actual, CONFIG_TASK_SIZE_BITS))
+#define TASK_SIZE_MAX		(UL(1) << CONFIG_TASK_SIZE_BITS)
 
 #ifdef CONFIG_COMPAT
 #if defined(CONFIG_ARM64_64K_PAGES) && defined(CONFIG_KUSER_HELPERS)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 37e4c02e0272..c36c66562c0a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2866,7 +2866,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_fpmr,
 		ARM64_CPUID_FIELDS(ID_AA64PFR2_EL1, FPMR, IMP)
 	},
-#ifdef CONFIG_ARM64_VA_BITS_52
 	{
 		.capability = ARM64_HAS_VA52,
 		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
@@ -2883,7 +2882,6 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 #endif
 #endif
 	},
-#endif
 	{
 		.desc = "NV1",
 		.capability = ARM64_HAS_HCR_NV1,
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 5ab1970ee543..15e9c1c5547d 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -380,11 +380,9 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	 */
 	mov	x20, x0				// preserve boot mode
 
-#ifdef CONFIG_ARM64_VA_BITS_52
 alternative_if ARM64_HAS_VA52
 	bl	__cpu_secondary_check52bitva
 alternative_else_nop_endif
-#endif
 
 	bl	__cpu_setup			// initialise processor
 	adrp	x1, swapper_pg_dir
@@ -488,7 +486,6 @@ SYM_FUNC_START(__enable_mmu)
 	ret
 SYM_FUNC_END(__enable_mmu)
 
-#ifdef CONFIG_ARM64_VA_BITS_52
 SYM_FUNC_START(__cpu_secondary_check52bitva)
 #ifndef CONFIG_ARM64_LPA2
 	mrs_s	x0, SYS_ID_AA64MMFR2_EL1
@@ -509,7 +506,6 @@ SYM_FUNC_START(__cpu_secondary_check52bitva)
 
 2:	ret
 SYM_FUNC_END(__cpu_secondary_check52bitva)
-#endif
 
 SYM_FUNC_START_LOCAL(__no_granule_support)
 	/* Indicate that this CPU can't boot and is stuck in the kernel */
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d21f67d67cf5..c4349852846f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -236,8 +236,8 @@ void __init arm64_memblock_init(void)
 	 * we have to move it upward. Since memstart_addr represents the
 	 * physical address of PAGE_OFFSET, we have to *subtract* from it.
 	 */
-	if (IS_ENABLED(CONFIG_ARM64_VA_BITS_52) && (vabits_actual != 52))
-		memstart_addr -= _PAGE_OFFSET(vabits_actual) - _PAGE_OFFSET(52);
+	if (vabits_actual != VA_BITS)
+		memstart_addr -= _PAGE_OFFSET(vabits_actual) - _PAGE_OFFSET(VA_BITS);
 
 	/*
 	 * Apply the memory limit if it was set. Since the kernel may be loaded
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 8abdc7fed321..779f589f947c 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -472,7 +472,6 @@ SYM_FUNC_START(__cpu_setup)
 
 	tcr_clear_errata_bits tcr, x9, x5
 
-#ifdef CONFIG_ARM64_VA_BITS_52
 	mov		x9, #64 - VA_BITS
 alternative_if ARM64_HAS_VA52
 	tcr_set_t1sz	tcr, x9
@@ -480,7 +479,6 @@ alternative_if ARM64_HAS_VA52
 	orr		tcr, tcr, #TCR_DS
 #endif
 alternative_else_nop_endif
-#endif
 
 	/*
 	 * Set the IPS bits in TCR_EL1.
-- 
2.47.0.163.g1226f6d8fa-goog


