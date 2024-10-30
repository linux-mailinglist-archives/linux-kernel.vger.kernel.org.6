Return-Path: <linux-kernel+bounces-389623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2799B6F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB4D28316E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3590219C91;
	Wed, 30 Oct 2024 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMonBqRQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE01CF7BB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324005; cv=none; b=Sfw43FhDPQKMFFuLQ5HuLCdQ6ca1hwCdfu0+Soz5bDtjGJYTSvpluyFvaY+xNXxr5DyzBqRmGTe7RVjMZCsuxtLVo78sEEeWE3NOdwyLOo89VzOx3N+VqTSDjU5catHkcBY6Yx9RR/vx/k1GBlJkJ4HTsuBd45P4SzxP+ZLS5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324005; c=relaxed/simple;
	bh=XXaph0Yjj6ONE7l5bDNoFF1nGnAUoZDuz4ySk0S5zKk=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=r9vw9728AWLGXRrQI0hFuKfMQnH1ioKwdixSQRF2/aZx0/1oI1Nsav86B6ynQ3XtaePagXhvkW50b3b0T9o+6wAkv8GnmTgnmmD7wbmjqDx4qfgs0D9BF/M2QgYdEu/oK9TVGcLk5/dmO2LRnuVi1wVPJC+7jv0avLH16kO5azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMonBqRQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730324004; x=1761860004;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=XXaph0Yjj6ONE7l5bDNoFF1nGnAUoZDuz4ySk0S5zKk=;
  b=iMonBqRQUveNSwp4XITCNQH8uLOYmY/1PCssC/2s1cCUj0zbWC1Llkqh
   eTnd3BGh++Q9fbv3hj7fQ34AToUaJAMqMEMGUC4qc2McOa1NaFdiC8tEX
   SIGCIwG1HYhOqtrqRNbXBOknQl5FOu3xzlSsAKUCKqOfex7yMopRnNvrh
   1872cjRolFSCk536iv4cTeEdmQl8m+TOgKSksuWhCXSZnYSfq1cPfjM8Q
   H+Eebb50riOxREJb5XhNwsCG25axB1vws6Y7ZdFjk0H/l7TZrfkyu7UaA
   HR+PXenFgT//eMKVB44beoLCFeeEawP/IN47J7kKHOtuN8ejMuYJO/e1b
   A==;
X-CSE-ConnectionGUID: 6zrAPJAPSOG+ltI/dq+tuA==
X-CSE-MsgGUID: lpeZMWSQSH6SwpJhjHNfew==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33741608"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33741608"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:23 -0700
X-CSE-ConnectionGUID: 97LQT6X7TEWDQihZTKrSKQ==
X-CSE-MsgGUID: mmRFM+JTQbuvZqEULr/BTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="83257684"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 30 Oct 2024 14:33:24 -0700
Subject: [PATCH 07/11] x86/tsc: Move away from TSC leaf magic numbers
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:22 -0700
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
In-Reply-To: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Message-Id: <20241030213322.34C47B3E@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/kernel/tsc.c~tsc-leaf-checks-2	2024-10-30 12:26:57.614213161 -0700
+++ b/arch/x86/kernel/tsc.c	2024-10-30 12:26:57.618213169 -0700
@@ -16,6 +16,7 @@
 #include <linux/static_key.h>
 #include <linux/static_call.h>
 
+#include <asm/cpuid.h>
 #include <asm/hpet.h>
 #include <asm/timer.h>
 #include <asm/vgtod.h>
@@ -664,13 +665,13 @@ unsigned long native_calibrate_tsc(void)
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
@@ -1066,10 +1067,8 @@ core_initcall(cpufreq_register_tsc_scali
 
 #endif /* CONFIG_CPU_FREQ */
 
-#define ART_CPUID_LEAF (0x15)
 #define ART_MIN_DENOMINATOR (1)
 
-
 /*
  * If ART is present detect the numerator:denominator to convert to TSC
  */
@@ -1077,7 +1076,7 @@ static void __init detect_art(void)
 {
 	unsigned int unused;
 
-	if (boot_cpu_data.cpuid_level < ART_CPUID_LEAF)
+	if (boot_cpu_data.cpuid_level < CPUID_TSC_LEAF)
 		return;
 
 	/*
@@ -1090,7 +1089,7 @@ static void __init detect_art(void)
 	    tsc_async_resets)
 		return;
 
-	cpuid(ART_CPUID_LEAF, &art_base_clk.denominator,
+	cpuid(CPUID_TSC_LEAF, &art_base_clk.denominator,
 	      &art_base_clk.numerator, &art_base_clk.freq_khz, &unused);
 
 	art_base_clk.freq_khz /= KHZ;
diff -puN drivers/platform/x86/intel/pmc/core.c~tsc-leaf-checks-2 drivers/platform/x86/intel/pmc/core.c
--- a/drivers/platform/x86/intel/pmc/core.c~tsc-leaf-checks-2	2024-10-30 12:26:57.614213161 -0700
+++ b/drivers/platform/x86/intel/pmc/core.c	2024-10-30 12:26:57.618213169 -0700
@@ -23,6 +23,7 @@
 #include <linux/suspend.h>
 #include <linux/units.h>
 
+#include <asm/cpuid.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/msr.h>
@@ -936,13 +937,13 @@ static unsigned int pmc_core_get_crystal
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

