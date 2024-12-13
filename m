Return-Path: <linux-kernel+bounces-445549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5AB9F179C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3309B166E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544311A8F9B;
	Fri, 13 Dec 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsnSbxWc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EDB19048A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123037; cv=none; b=dmRNj4NhQvyjAgAYmOienwfQv02a2i5rITrA9veYGH74gFdiSZj0PWyHOpTxiVT5AbiUSLHsbpFQrjWVhgdUREqUC5+oaA4nMKDy6U30zuk2eAVyWevliYFkAY1A6kuIq2l0Mb+g4e3VUBxp1Q+YMnq4RrMiXMZNadJVKKr6Cm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123037; c=relaxed/simple;
	bh=Vy9ACxVbR5UiMJdUo2ernIhjxEJ9urdstlK2zG54xWM=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=mQmjTE/cWXtQvjo937Urc6EM6WuRX4uE/yfVjolddoSQ75NqCEh5JY5/AcD92fuDd3ibLLVL41kmb3IJ6LmQdKTrgDlzoxIwhFHTKIhfUj+muWuaUSam4iO2T/IpiNoZWNPRISOVXr/v2Ip6zaTXR3mEVw8y3yQyjJ+reNkdcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsnSbxWc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123036; x=1765659036;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=Vy9ACxVbR5UiMJdUo2ernIhjxEJ9urdstlK2zG54xWM=;
  b=OsnSbxWcz9L3TgR/hr5aFClxprZFzMRiVnGRmkC7hkScAHTG4ZAiJAC3
   W/oQMju9q68KwiSeBxdHvh+2nnJcSSKztUfYDWjH7438akVBmuedRejsX
   HuceqvV9FL7Fz0zJwqIg9YGeRNedxBiqf1ocWaYU/D3KGNBzJOcTOvnBY
   bODdsgib6yxSUi8byXrgCZoRE8UR36H3o50AbHrysC9BbWz2W4i/Af1iy
   rqjiD1q3VsKFNDJqkcAgQXUcRMOmCNGtRCApQD6t6eLHLudYCr/NqI8Dr
   xXAhTTGCPKO3tpVZET+ulVCy7OKcbK4KHarK4pQbKQwCRoAmr1rg4tI7u
   A==;
X-CSE-ConnectionGUID: GnKNouunRY6IitTcT9TmeA==
X-CSE-MsgGUID: EGIClttMTy6CrnOUwKc7/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45973153"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45973153"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:36 -0800
X-CSE-ConnectionGUID: 6dassuF+SJeBSxQu3BPfUw==
X-CSE-MsgGUID: HfLbkrqKTOC/1Cj19psUEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101599688"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa005.jf.intel.com with ESMTP; 13 Dec 2024 12:50:36 -0800
Subject: [PATCH 07/10] x86/tsc: Remove CPUID "frequency" leaf magic numbers.
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>,zhao1.liu@intel.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:36 -0800
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Message-Id: <20241213205036.4397658F@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

All the code that reads the CPUID frequency information leaf hard-codes
a magic number.  Give it a symbolic name and use it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---

 b/arch/x86/include/asm/cpuid.h |    1 +
 b/arch/x86/kernel/tsc.c        |   12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/x86/include/asm/cpuid.h~tsc-leaf-checks-3 arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~tsc-leaf-checks-3	2024-12-13 12:45:35.839181468 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-12-13 12:45:35.843181638 -0800
@@ -24,6 +24,7 @@ enum cpuid_regs_idx {
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
 #define CPUID_TSC_LEAF		0x15
+#define CPUID_FREQ_LEAF		0x16
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
diff -puN arch/x86/kernel/tsc.c~tsc-leaf-checks-3 arch/x86/kernel/tsc.c
--- a/arch/x86/kernel/tsc.c~tsc-leaf-checks-3	2024-12-13 12:45:35.839181468 -0800
+++ b/arch/x86/kernel/tsc.c	2024-12-13 12:45:35.843181638 -0800
@@ -681,8 +681,8 @@ unsigned long native_calibrate_tsc(void)
 
 	/*
 	 * Denverton SoCs don't report crystal clock, and also don't support
-	 * CPUID.0x16 for the calculation below, so hardcode the 25MHz crystal
-	 * clock.
+	 * CPUID_FREQ_LEAF for the calculation below, so hardcode the 25MHz
+	 * crystal clock.
 	 */
 	if (crystal_khz == 0 &&
 			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
@@ -701,10 +701,10 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= 0x16) {
+	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_FREQ_LEAF) {
 		unsigned int eax_base_mhz, ebx, ecx, edx;
 
-		cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
+		cpuid(CPUID_FREQ_LEAF, &eax_base_mhz, &ebx, &ecx, &edx);
 		crystal_khz = eax_base_mhz * 1000 *
 			eax_denominator / ebx_numerator;
 	}
@@ -739,12 +739,12 @@ static unsigned long cpu_khz_from_cpuid(
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < 0x16)
+	if (boot_cpu_data.cpuid_level < CPUID_FREQ_LEAF)
 		return 0;
 
 	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
 
-	cpuid(0x16, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
+	cpuid(CPUID_FREQ_LEAF, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
 
 	return eax_base_mhz * 1000;
 }
_

