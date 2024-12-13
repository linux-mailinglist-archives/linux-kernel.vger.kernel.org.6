Return-Path: <linux-kernel+bounces-445548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCFD9F179B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CAF1169D87
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186A51A8F60;
	Fri, 13 Dec 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbYJMYRO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0E198E84
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123036; cv=none; b=Wbo03zPJZQrC+zyKevVCdKAMd8x7wdG9Q+j3/xQJEgt/CmH4yWYE933LvnajstM5eemL9NM2Z7lfkISpCNYn/6wjP7N4aFpUao5EXeEIhv30csXgom++ldqPEoLQ403kr5T1U5C4FAKmBcRdL1HR1eRe7zACa/VQJceOyTKoiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123036; c=relaxed/simple;
	bh=bvg3kykeix6Mr8rmCZKJX42XZ45C4+yD/p8ki5CTO9E=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Z4KzoqFUZ4mAkhXBhIQIOPmJ9EeBBjUFguuQY9Z48sdhGDvvlN3Aye5vaASDAfQo5VU7GEs34N8bCfZnNvz/aCQ+JJaJvQrYz4qehN7zFRVyiX9sWcB4obx0LUyJRb7nwGZ1HYrxMC7g/zeGRlE4LEYpRM1u46U0xzeidfGJI2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbYJMYRO; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123035; x=1765659035;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=bvg3kykeix6Mr8rmCZKJX42XZ45C4+yD/p8ki5CTO9E=;
  b=dbYJMYRO/h5GhKEPOA34hkhAcaPf/Us+ZWmrBk2DDFmb7TKSfRgkMbV9
   VbnlIcHfGYsNe3VQxZ5zcQp3t3nrdke6+Bk+zCd7bKnWkWLDUU4Y5eFP5
   geAQjfyqQqpZ+HtENHluieIkGHp1/ckKjNZyXOu7AUNzHABH4BZTlbhW7
   mhZtU1G5+HiWcTWHwWPdP+82OXs/8RKbpJ0LyE+RcUBKp3LVqgV9rzSAq
   Bo1eHFcIU7s5hBlJyjYXol9CBavjrth2L8g10y+NcFx4xPqNEXaKXmen+
   QT2sBYourZ4wXTVbA05QFYD3E2bcT8A7ptPJCaFpkQyiSb6MdXh1ZFLnx
   A==;
X-CSE-ConnectionGUID: 2vnm7mFCSRCI1AYnepMnlA==
X-CSE-MsgGUID: nOtvetrcQ+ip2+Pow51e6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45973144"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45973144"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:34 -0800
X-CSE-ConnectionGUID: i/LFahFJTJ614yCAi+EKMg==
X-CSE-MsgGUID: kyzr+AigQQSxOpYm92PYhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101599683"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa005.jf.intel.com with ESMTP; 13 Dec 2024 12:50:35 -0800
Subject: [PATCH 06/10] x86/tsc: Move away from TSC leaf magic numbers
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:34 -0800
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Message-Id: <20241213205034.B79D6224@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The TSC code has a bunch of hard-coded references to leaf 0x15.  Change
them over to the symbolic name.  Also zap the 'ART_CPUID_LEAF' definition.
It was a duplicate of 'CPUID_TSC_LEAF'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/tsc.c                 |   11 +++++------
 b/drivers/platform/x86/intel/pmc/core.c |    7 ++++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff -puN arch/x86/kernel/tsc.c~tsc-leaf-checks-2 arch/x86/kernel/tsc.c
--- a/arch/x86/kernel/tsc.c~tsc-leaf-checks-2	2024-12-13 12:45:35.323159598 -0800
+++ b/arch/x86/kernel/tsc.c	2024-12-13 12:45:35.331159936 -0800
@@ -16,6 +16,7 @@
 #include <linux/static_key.h>
 #include <linux/static_call.h>
 
+#include <asm/cpuid.h>
 #include <asm/hpet.h>
 #include <asm/timer.h>
 #include <asm/vgtod.h>
@@ -665,13 +666,13 @@ unsigned long native_calibrate_tsc(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < 0x15)
+	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
 		return 0;
 
 	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
 
 	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+	cpuid(CPUID_TSC_LEAF, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
 
 	if (ebx_numerator == 0 || eax_denominator == 0)
 		return 0;
@@ -1067,10 +1068,8 @@ core_initcall(cpufreq_register_tsc_scali
 
 #endif /* CONFIG_CPU_FREQ */
 
-#define ART_CPUID_LEAF (0x15)
 #define ART_MIN_DENOMINATOR (1)
 
-
 /*
  * If ART is present detect the numerator:denominator to convert to TSC
  */
@@ -1078,7 +1077,7 @@ static void __init detect_art(void)
 {
 	unsigned int unused;
 
-	if (boot_cpu_data.cpuid_level < ART_CPUID_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
 		return;
 
 	/*
@@ -1091,7 +1090,7 @@ static void __init detect_art(void)
 	    tsc_async_resets)
 		return;
 
-	cpuid(ART_CPUID_LEAF, &art_base_clk.denominator,
+	cpuid(CPUID_TSC_LEAF, &art_base_clk.denominator,
 	      &art_base_clk.numerator, &art_base_clk.freq_khz, &unused);
 
 	art_base_clk.freq_khz /= KHZ;
diff -puN drivers/platform/x86/intel/pmc/core.c~tsc-leaf-checks-2 drivers/platform/x86/intel/pmc/core.c
--- a/drivers/platform/x86/intel/pmc/core.c~tsc-leaf-checks-2	2024-12-13 12:45:35.327159767 -0800
+++ b/drivers/platform/x86/intel/pmc/core.c	2024-12-13 12:45:35.331159936 -0800
@@ -22,6 +22,7 @@
 #include <linux/suspend.h>
 #include <linux/units.h>
 
+#include <asm/cpuid.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/msr.h>
@@ -935,13 +936,13 @@ static unsigned int pmc_core_get_crystal
 {
 	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
 
-	if (boot_cpu_data.cpuid_level < 0x15)
+	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
 		return 0;
 
 	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
 
-	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
+	/* TSC/Crystal ratio, plus optionally Crystal Hz */
+	cpuid(CPUID_TSC_LEAF, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
 
 	if (ebx_numerator == 0 || eax_denominator == 0)
 		return 0;
_

