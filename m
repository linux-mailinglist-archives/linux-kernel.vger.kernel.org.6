Return-Path: <linux-kernel+bounces-416279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1136C9D42BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFE02844CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A01C9EC0;
	Wed, 20 Nov 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FzoJdt1v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018A1C9B89
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132418; cv=none; b=kOJgVpqsE4Z8viJkHiAG7TfynAGchsbIzOhi3/x3DWoKmTHlO6uv1bJao/sezyCRqK/ax7hLQEETaRWfsgHWxreKFqlFdwsku+TQaPHFh6a1dRjKaF7nE8keYO7wQ7zWxJfAz1Pit+J+/TBVQOL9mImDtUWltjbwj8X04WYvK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132418; c=relaxed/simple;
	bh=PbKFXsnsumX2YeTPDXy09fLI9xVz55DAQrahwkjRlA8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=O37HyyrApWQn5gJOUTSkdtdHjD+Xvb7Xp66mTeXiJ79c7cX1+CJs9lEYss0BvsXPrRXoXWeIYGj9Pvs3M/kjHVdl4hqpzbxzinQpznIBnu9S0nGMPxC/jhwGyFWZO81sFUO0Jwt1oRLdu/mgCmP59yVn3gWMeV0/N6CqD3weimk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FzoJdt1v; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132417; x=1763668417;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=PbKFXsnsumX2YeTPDXy09fLI9xVz55DAQrahwkjRlA8=;
  b=FzoJdt1vWtQrDtjqRDjhE1gf83ch+W+nCJxDPz2twO4yBj8/sBFQyvW1
   GdRo+p6RWIZBfPlFJU7YhSQ+H6djM2Q6Q311cf8iLR7Q1v/CfF3jEwYWj
   beFSiVXzfr/VP3ALmCr1IXnM0BizMXIx7nNWaCULRpt1K0vvS9qNVkJvs
   Exkokh8hX5Bm30GjVX9Q0AhVcEk2Q1hKqHcASKv088b/5TjqahGlcrPPd
   GCM6ofiL5o6G0ZPPBrUdMFIptMMxfpAH7woknKWsPpDaGJejEusow8a1F
   wtR5Y6IO+K+IatObaXJM9Od0edRdL8LpXmhtP20JpYDiFdvO0io6+wdvk
   A==;
X-CSE-ConnectionGUID: UXjEgdCJR9+YsDw8BheV0Q==
X-CSE-MsgGUID: DVKm2m2gROeO0/xWTiIAEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31580972"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31580972"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:37 -0800
X-CSE-ConnectionGUID: lSTcCa6KTcqJ0y3KcA0fFA==
X-CSE-MsgGUID: BhsGvBrURgmgMEVn5U6vcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="120884203"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2024 11:53:37 -0800
Subject: [PATCH 07/11] x86/tsc: Move away from TSC leaf magic numbers
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:36 -0800
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Message-Id: <20241120195336.FCF1277D@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/kernel/tsc.c~tsc-leaf-checks-2	2024-11-20 11:44:18.789710767 -0800
+++ b/arch/x86/kernel/tsc.c	2024-11-20 11:44:18.793710919 -0800
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
--- a/drivers/platform/x86/intel/pmc/core.c~tsc-leaf-checks-2	2024-11-20 11:44:18.793710919 -0800
+++ b/drivers/platform/x86/intel/pmc/core.c	2024-11-20 11:44:18.793710919 -0800
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

