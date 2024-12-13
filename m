Return-Path: <linux-kernel+bounces-445552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113219F179F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA2188EFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE91EE01D;
	Fri, 13 Dec 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N09TSjrK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5B1E883E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123042; cv=none; b=R5uPYrfRgWHgT3oHrhnOOko8otxryktIoFrFgm6HAVR5d9rKQEXIZbQTvFHAihGlvnMheiBUsvkTAYz5XRWqcDLJprfEqj/EjUrJkaZsusQG4ZjAJXzg7j8GK+kmH6S8lj8SnvD91/87xq611NWoACyxjYw+Xn9qqta11Is8r+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123042; c=relaxed/simple;
	bh=wOkZ2Cd6tvpRViWyim+Anso+2fUgqhM+9n5NySmVDS0=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=cV5w7medLXyBpF03me0Gce3z/kGCwUjuooVVZ4xF/0KJ+jlAbHDJaxKX2Dx4bZF0lHGyefoMVCQ7TXI4WutG8wz2a2zR5HaDVnQtFvPfCnDb68/S8mbV+EzwX19kH8xtZRYcmSI68ZbECQ2KQCkybssgruE/KKhiEor8kOG7yH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N09TSjrK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123040; x=1765659040;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=wOkZ2Cd6tvpRViWyim+Anso+2fUgqhM+9n5NySmVDS0=;
  b=N09TSjrKPnn89e8cBjR15P8A7NU5fpIyFumGlZfo5Ul2CNddv75/ZP1+
   LQVyX1+ETUdq8MKiEywUuhisyLQ3ni/jAr+s62UN8pno8Y/CUEc+MKMOB
   lHFeAUzoFYNMUKHAXcWTyMjUMwWeSgv96e4jZo9zep5EbPW+rHRbhocjh
   +XRmFHC+YTpSYO9t2S9L9FPteBBpdHbcueocxnG3AbC2pGsyQwr8ITYPA
   LNG9e07IeoUpIdu2LDgAHGKZJA00RMqvqImvKycqEBiseer4SXOt9jtsZ
   l8n0cO7jvq//s4Sj7tfXnRSZemS8EgnQbuis+Z0Xc5stc5FFTm1W/Cl7r
   g==;
X-CSE-ConnectionGUID: hLwQOumBSe+Lt51pzBdrIg==
X-CSE-MsgGUID: dd41XMLoS9uuQav8nBrirg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45973176"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45973176"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:40 -0800
X-CSE-ConnectionGUID: NlYcZSlLTHOjAFhNtWRKrQ==
X-CSE-MsgGUID: Ff4HubECRGmbH6s76/0aTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101599698"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa005.jf.intel.com with ESMTP; 13 Dec 2024 12:50:40 -0800
Subject: [PATCH 10/10] x86/cpu: Make all all CPUID leaf names consistent
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:40 -0800
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Message-Id: <20241213205040.7B0C3241@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The leaf names are not consistent.  Give them all a CPUID_LEAF_ prefix
for consistency and vertical alignment.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Jiang <dave.jiang@intel.com> # for ioatdma bits
---

 b/arch/x86/events/intel/pt.c            |    4 ++--
 b/arch/x86/include/asm/cpuid.h          |   12 ++++++------
 b/arch/x86/kernel/acpi/cstate.c         |    4 ++--
 b/arch/x86/kernel/cpu/common.c          |    6 +++---
 b/arch/x86/kernel/fpu/xstate.c          |   20 ++++++++++----------
 b/arch/x86/kernel/hpet.c                |    2 +-
 b/arch/x86/kernel/process.c             |    2 +-
 b/arch/x86/kernel/smpboot.c             |    2 +-
 b/arch/x86/kernel/tsc.c                 |   18 +++++++++---------
 b/arch/x86/xen/enlighten_pv.c           |    4 ++--
 b/drivers/acpi/acpi_pad.c               |    2 +-
 b/drivers/dma/ioat/dca.c                |    2 +-
 b/drivers/idle/intel_idle.c             |    2 +-
 b/drivers/platform/x86/intel/pmc/core.c |    4 ++--
 14 files changed, 42 insertions(+), 42 deletions(-)

diff -puN arch/x86/events/intel/pt.c~xsave-leaf-checks-3 arch/x86/events/intel/pt.c
--- a/arch/x86/events/intel/pt.c~xsave-leaf-checks-3	2024-12-13 12:45:37.391247243 -0800
+++ b/arch/x86/events/intel/pt.c	2024-12-13 12:45:37.415248260 -0800
@@ -202,10 +202,10 @@ static int __init pt_pmu_hw_init(void)
 	 * otherwise, zero for numerator stands for "not enumerated"
 	 * as per SDM
 	 */
-	if (boot_cpu_data.cpuid_level >= CPUID_TSC_LEAF) {
+	if (boot_cpu_data.cpuid_level >= CPUID_LEAF_TSC) {
 		u32 eax, ebx, ecx, edx;
 
-		cpuid(CPUID_TSC_LEAF, &eax, &ebx, &ecx, &edx);
+		cpuid(CPUID_LEAF_TSC, &eax, &ebx, &ecx, &edx);
 
 		pt_pmu.tsc_art_num = ebx;
 		pt_pmu.tsc_art_den = eax;
diff -puN arch/x86/include/asm/cpuid.h~xsave-leaf-checks-3 arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~xsave-leaf-checks-3	2024-12-13 12:45:37.395247412 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-12-13 12:45:37.415248260 -0800
@@ -21,12 +21,12 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_MWAIT_LEAF	0x5
-#define CPUID_DCA_LEAF		0x9
-#define XSTATE_CPUID		0x0d
-#define CPUID_TSC_LEAF		0x15
-#define CPUID_FREQ_LEAF		0x16
-#define TILE_CPUID		0x1d
+#define CPUID_LEAF_MWAIT	0x5
+#define CPUID_LEAF_DCA		0x9
+#define CPUID_LEAF_XSTATE	0x0d
+#define CPUID_LEAF_TSC		0x15
+#define CPUID_LEAF_FREQ		0x16
+#define CPUID_LEAF_TILE		0x1d
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
diff -puN arch/x86/kernel/acpi/cstate.c~xsave-leaf-checks-3 arch/x86/kernel/acpi/cstate.c
--- a/arch/x86/kernel/acpi/cstate.c~xsave-leaf-checks-3	2024-12-13 12:45:37.395247412 -0800
+++ b/arch/x86/kernel/acpi/cstate.c	2024-12-13 12:45:37.415248260 -0800
@@ -129,7 +129,7 @@ static long acpi_processor_ffh_cstate_pr
 	unsigned int cstate_type; /* C-state type and not ACPI C-state type */
 	unsigned int num_cstate_subtype;
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
+	cpuid(CPUID_LEAF_MWAIT, &eax, &ebx, &ecx, &edx);
 
 	/* Check whether this particular cx_type (in CST) is supported or not */
 	cstate_type = (((cx->address >> MWAIT_SUBSTATE_SIZE) &
@@ -173,7 +173,7 @@ int acpi_processor_ffh_cstate_probe(unsi
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	long retval;
 
-	if (!cpu_cstate_entry || c->cpuid_level < CPUID_MWAIT_LEAF)
+	if (!cpu_cstate_entry || c->cpuid_level < CPUID_LEAF_MWAIT)
 		return -1;
 
 	if (reg->bit_offset != NATIVE_CSTATE_BEYOND_HALT)
diff -puN arch/x86/kernel/cpu/common.c~xsave-leaf-checks-3 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~xsave-leaf-checks-3	2024-12-13 12:45:37.395247412 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-12-13 12:45:37.415248260 -0800
@@ -637,9 +637,9 @@ struct cpuid_dependent_feature {
 
 static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
-	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
-	{ X86_FEATURE_DCA,		CPUID_DCA_LEAF },
-	{ X86_FEATURE_XSAVE,		XSTATE_CPUID },
+	{ X86_FEATURE_MWAIT,		CPUID_LEAF_MWAIT },
+	{ X86_FEATURE_DCA,		CPUID_LEAF_DCA },
+	{ X86_FEATURE_XSAVE,		CPUID_LEAF_XSTATE },
 	{ 0, 0 }
 };
 
diff -puN arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-3 arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-3	2024-12-13 12:45:37.399247581 -0800
+++ b/arch/x86/kernel/fpu/xstate.c	2024-12-13 12:45:37.415248260 -0800
@@ -233,7 +233,7 @@ static void __init setup_xstate_cache(vo
 						       xmm_space);
 
 	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
+		cpuid_count(CPUID_LEAF_XSTATE, i, &eax, &ebx, &ecx, &edx);
 
 		xstate_sizes[i] = eax;
 		xstate_flags[i] = ecx;
@@ -399,7 +399,7 @@ int xfeature_size(int xfeature_nr)
 	u32 eax, ebx, ecx, edx;
 
 	CHECK_XFEATURE(xfeature_nr);
-	cpuid_count(XSTATE_CPUID, xfeature_nr, &eax, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_XSTATE, xfeature_nr, &eax, &ebx, &ecx, &edx);
 	return eax;
 }
 
@@ -442,9 +442,9 @@ static void __init __xstate_dump_leaves(
 	 * just in case there are some goodies up there
 	 */
 	for (i = 0; i < XFEATURE_MAX + 10; i++) {
-		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
+		cpuid_count(CPUID_LEAF_XSTATE, i, &eax, &ebx, &ecx, &edx);
 		pr_warn("CPUID[%02x, %02x]: eax=%08x ebx=%08x ecx=%08x edx=%08x\n",
-			XSTATE_CPUID, i, eax, ebx, ecx, edx);
+			CPUID_LEAF_XSTATE, i, eax, ebx, ecx, edx);
 	}
 }
 
@@ -485,7 +485,7 @@ static int __init check_xtile_data_again
 	 * Check the maximum palette id:
 	 *   eax: the highest numbered palette subleaf.
 	 */
-	cpuid_count(TILE_CPUID, 0, &max_palid, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_TILE, 0, &max_palid, &ebx, &ecx, &edx);
 
 	/*
 	 * Cross-check each tile size and find the maximum number of
@@ -499,7 +499,7 @@ static int __init check_xtile_data_again
 		 *   eax[31:16]:  bytes per title
 		 *   ebx[31:16]:  the max names (or max number of tiles)
 		 */
-		cpuid_count(TILE_CPUID, palid, &eax, &ebx, &edx, &edx);
+		cpuid_count(CPUID_LEAF_TILE, palid, &eax, &ebx, &edx, &edx);
 		tile_size = eax >> 16;
 		max = ebx >> 16;
 
@@ -634,7 +634,7 @@ static unsigned int __init get_compacted
 	 * are no supervisor states, but XSAVEC still uses compacted
 	 * format.
 	 */
-	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_XSTATE, 1, &eax, &ebx, &ecx, &edx);
 	return ebx;
 }
 
@@ -675,7 +675,7 @@ static unsigned int __init get_xsave_siz
 	 *    containing all the *user* state components
 	 *    corresponding to bits currently set in XCR0.
 	 */
-	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_XSTATE, 0, &eax, &ebx, &ecx, &edx);
 	return ebx;
 }
 
@@ -767,13 +767,13 @@ void __init fpu__init_system_xstate(unsi
 	/*
 	 * Find user xstates supported by the processor.
 	 */
-	cpuid_count(XSTATE_CPUID, 0, &eax, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_XSTATE, 0, &eax, &ebx, &ecx, &edx);
 	fpu_kernel_cfg.max_features = eax + ((u64)edx << 32);
 
 	/*
 	 * Find supervisor xstates supported by the processor.
 	 */
-	cpuid_count(XSTATE_CPUID, 1, &eax, &ebx, &ecx, &edx);
+	cpuid_count(CPUID_LEAF_XSTATE, 1, &eax, &ebx, &ecx, &edx);
 	fpu_kernel_cfg.max_features |= ecx + ((u64)edx << 32);
 
 	if ((fpu_kernel_cfg.max_features & XFEATURE_MASK_FPSSE) != XFEATURE_MASK_FPSSE) {
diff -puN arch/x86/kernel/hpet.c~xsave-leaf-checks-3 arch/x86/kernel/hpet.c
--- a/arch/x86/kernel/hpet.c~xsave-leaf-checks-3	2024-12-13 12:45:37.399247581 -0800
+++ b/arch/x86/kernel/hpet.c	2024-12-13 12:45:37.415248260 -0800
@@ -928,7 +928,7 @@ static bool __init mwait_pc10_supported(
 	if (!cpu_feature_enabled(X86_FEATURE_MWAIT))
 		return false;
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
+	cpuid(CPUID_LEAF_MWAIT, &eax, &ebx, &ecx, &mwait_substates);
 
 	return (ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) &&
 	       (ecx & CPUID5_ECX_INTERRUPT_BREAK) &&
diff -puN arch/x86/kernel/process.c~xsave-leaf-checks-3 arch/x86/kernel/process.c
--- a/arch/x86/kernel/process.c~xsave-leaf-checks-3	2024-12-13 12:45:37.403247751 -0800
+++ b/arch/x86/kernel/process.c	2024-12-13 12:45:37.415248260 -0800
@@ -878,7 +878,7 @@ static __init bool prefer_mwait_c1_over_
 	if (boot_cpu_has_bug(X86_BUG_MONITOR) || boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E))
 		return false;
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
+	cpuid(CPUID_LEAF_MWAIT, &eax, &ebx, &ecx, &edx);
 
 	/*
 	 * If MWAIT extensions are not available, it is safe to use MWAIT
diff -puN arch/x86/kernel/smpboot.c~xsave-leaf-checks-3 arch/x86/kernel/smpboot.c
--- a/arch/x86/kernel/smpboot.c~xsave-leaf-checks-3	2024-12-13 12:45:37.403247751 -0800
+++ b/arch/x86/kernel/smpboot.c	2024-12-13 12:45:37.415248260 -0800
@@ -1293,7 +1293,7 @@ static inline void mwait_play_dead(void)
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
 		return;
 
-	eax = CPUID_MWAIT_LEAF;
+	eax = CPUID_LEAF_MWAIT;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 
diff -puN arch/x86/kernel/tsc.c~xsave-leaf-checks-3 arch/x86/kernel/tsc.c
--- a/arch/x86/kernel/tsc.c~xsave-leaf-checks-3	2024-12-13 12:45:37.403247751 -0800
+++ b/arch/x86/kernel/tsc.c	2024-12-13 12:45:37.415248260 -0800
@@ -666,13 +666,13 @@ unsigned long native_calibrate_tsc(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
 		return 0;
 
 	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
 
 	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(CPUID_TSC_LEAF, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+	cpuid(CPUID_LEAF_TSC, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
 
 	if (ebx_numerator == 0 || eax_denominator == 0)
 		return 0;
@@ -681,7 +681,7 @@ unsigned long native_calibrate_tsc(void)
 
 	/*
 	 * Denverton SoCs don't report crystal clock, and also don't support
-	 * CPUID_FREQ_LEAF for the calculation below, so hardcode the 25MHz
+	 * CPUID_LEAF_FREQ for the calculation below, so hardcode the 25MHz
 	 * crystal clock.
 	 */
 	if (crystal_khz == 0 &&
@@ -701,10 +701,10 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_FREQ_LEAF) {
+	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
 		unsigned int eax_base_mhz, ebx, ecx, edx;
 
-		cpuid(CPUID_FREQ_LEAF, &eax_base_mhz, &ebx, &ecx, &edx);
+		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
 		crystal_khz = eax_base_mhz * 1000 *
 			eax_denominator / ebx_numerator;
 	}
@@ -739,12 +739,12 @@ static unsigned long cpu_khz_from_cpuid(
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_FREQ_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
 		return 0;
 
 	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
 
-	cpuid(CPUID_FREQ_LEAF, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
+	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
 
 	return eax_base_mhz * 1000;
 }
@@ -1077,7 +1077,7 @@ static void __init detect_art(void)
 {
 	unsigned int unused;
 
-	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
 		return;
 
 	/*
@@ -1090,7 +1090,7 @@ static void __init detect_art(void)
 	    tsc_async_resets)
 		return;
 
-	cpuid(CPUID_TSC_LEAF, &art_base_clk.denominator,
+	cpuid(CPUID_LEAF_TSC, &art_base_clk.denominator,
 	      &art_base_clk.numerator, &art_base_clk.freq_khz, &unused);
 
 	art_base_clk.freq_khz /= KHZ;
diff -puN arch/x86/xen/enlighten_pv.c~xsave-leaf-checks-3 arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~xsave-leaf-checks-3	2024-12-13 12:45:37.407247920 -0800
+++ b/arch/x86/xen/enlighten_pv.c	2024-12-13 12:45:37.419248429 -0800
@@ -231,7 +231,7 @@ static void xen_cpuid(unsigned int *ax,
 		or_ebx = smp_processor_id() << 24;
 		break;
 
-	case CPUID_MWAIT_LEAF:
+	case CPUID_LEAF_MWAIT:
 		/* Synthesize the values.. */
 		*ax = 0;
 		*bx = 0;
@@ -301,7 +301,7 @@ static bool __init xen_check_mwait(void)
 	 * ecx and edx. The hypercall provides only partial information.
 	 */
 
-	ax = CPUID_MWAIT_LEAF;
+	ax = CPUID_LEAF_MWAIT;
 	bx = 0;
 	cx = 0;
 	dx = 0;
diff -puN drivers/acpi/acpi_pad.c~xsave-leaf-checks-3 drivers/acpi/acpi_pad.c
--- a/drivers/acpi/acpi_pad.c~xsave-leaf-checks-3	2024-12-13 12:45:37.407247920 -0800
+++ b/drivers/acpi/acpi_pad.c	2024-12-13 12:45:37.419248429 -0800
@@ -48,7 +48,7 @@ static void power_saving_mwait_init(void
 	if (!boot_cpu_has(X86_FEATURE_MWAIT))
 		return;
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
+	cpuid(CPUID_LEAF_MWAIT, &eax, &ebx, &ecx, &edx);
 
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
 	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK))
diff -puN drivers/dma/ioat/dca.c~xsave-leaf-checks-3 drivers/dma/ioat/dca.c
--- a/drivers/dma/ioat/dca.c~xsave-leaf-checks-3	2024-12-13 12:45:37.411248089 -0800
+++ b/drivers/dma/ioat/dca.c	2024-12-13 12:45:37.419248429 -0800
@@ -63,7 +63,7 @@ static int dca_enabled_in_bios(struct pc
 	u32 eax;
 	int res;
 
-	eax = cpuid_eax(CPUID_DCA_LEAF);
+	eax = cpuid_eax(CPUID_LEAF_DCA);
 	res = eax & BIT(0);
 	if (!res)
 		dev_dbg(&pdev->dev, "DCA is disabled in BIOS\n");
diff -puN drivers/idle/intel_idle.c~xsave-leaf-checks-3 drivers/idle/intel_idle.c
--- a/drivers/idle/intel_idle.c~xsave-leaf-checks-3	2024-12-13 12:45:37.411248089 -0800
+++ b/drivers/idle/intel_idle.c	2024-12-13 12:45:37.419248429 -0800
@@ -2317,7 +2317,7 @@ static int __init intel_idle_init(void)
 			return -ENODEV;
 	}
 
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
+	cpuid(CPUID_LEAF_MWAIT, &eax, &ebx, &ecx, &mwait_substates);
 
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
 	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK) ||
diff -puN drivers/platform/x86/intel/pmc/core.c~xsave-leaf-checks-3 drivers/platform/x86/intel/pmc/core.c
--- a/drivers/platform/x86/intel/pmc/core.c~xsave-leaf-checks-3	2024-12-13 12:45:37.411248089 -0800
+++ b/drivers/platform/x86/intel/pmc/core.c	2024-12-13 12:45:37.419248429 -0800
@@ -936,13 +936,13 @@ static unsigned int pmc_core_get_crystal
 {
 	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
 
-	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
 		return 0;
 
 	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
 
 	/* TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(CPUID_TSC_LEAF, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+	cpuid(CPUID_LEAF_TSC, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
 
 	if (ebx_numerator == 0 || eax_denominator == 0)
 		return 0;
_

