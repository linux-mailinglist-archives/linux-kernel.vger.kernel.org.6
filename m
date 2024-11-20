Return-Path: <linux-kernel+bounces-416280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5A59D42C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2692B27DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EA91C8FA2;
	Wed, 20 Nov 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwdDW4gP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB971C9EA1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132419; cv=none; b=KoAkkZc8wLbwtjRlM/r6zzDDrYX5+jzo3iEOrCXdIsp8lgeAyHOZiTGuclvFFR38U4gMlpCSDUQshqeNFMMYajqNEYVW/A9UXaMcknZzzPpUdHZCA4bxLXYOWaBh7bW7gu0GUFrC77xH19dHo7E7uuLP4anOUUysyoFd2O0x6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132419; c=relaxed/simple;
	bh=QPG5xWIcCJIWScCVM65LVOX33P/dFxoVIRg+SVz1MUs=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=O0Th5S8IZCDa7ugl50DlWORio1/0+uXXH93MHcOgFB/dq84MZEet0jpRwvVgbDmZJqe2497IjTOqY8ThbXVbpgyZ12maEHwmqH/1jTSMm008XsoOuUYL3ANqNQUA+pgmkyyGJyzzq/a8uAf/O/JDNH1BV1F2aiMTULSJN3aDXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwdDW4gP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132418; x=1763668418;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=QPG5xWIcCJIWScCVM65LVOX33P/dFxoVIRg+SVz1MUs=;
  b=TwdDW4gPJ5He8oKssrHo4aaiQcGmkLbaiOTZsmydP9Lm2kasaL1vPKLk
   MOI65uQuYXgEm5yTaIOqmMYugWKlm7RkRiXYMFGbd1a1h0tV28hzAVc2v
   uN133uXyWH1V4bbUfumRFqk11VhiJmr0FgvdolDRx0Y6P3FgVtIc331Kr
   wsAm8dL9JlySJrtD1PpN863rJLseC7ZCg3vtYgJiP1Zqfht2DijpIaOpN
   kkJ3G4QSMsieIH818XLdmLJhaOPs1JoNGtREYPHX7PjJiQ7M6RMFUjApp
   3UG58s4LdE/g9TAlSzB0p9MX8+snbJ9plch7B669aT3LQqUDwh2STBz6t
   A==;
X-CSE-ConnectionGUID: 6GXc7g7wRP+gqy7Q7dbvlw==
X-CSE-MsgGUID: EcxZG5k5QPOzaZzb8uurzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31580979"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31580979"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:38 -0800
X-CSE-ConnectionGUID: WWtv1EaSRQmlH+9iGJc/2w==
X-CSE-MsgGUID: M5ThJVrMScSzmsNzM3jJ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="120884215"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2024 11:53:38 -0800
Subject: [PATCH 08/11] x86/tsc: Remove CPUID "frequency" leaf magic numbers.
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:38 -0800
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Message-Id: <20241120195338.D035B080@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

All the code that reads the CPUID frequency information leaf hard-codes
a magic number.  Give it a symbolic name and use it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/cpuid.h |    1 +
 b/arch/x86/kernel/tsc.c        |   12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/x86/include/asm/cpuid.h~tsc-leaf-checks-3 arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~tsc-leaf-checks-3	2024-11-20 11:44:19.301730364 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-11-20 11:44:19.305730518 -0800
@@ -22,6 +22,7 @@ enum cpuid_regs_idx {
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
 #define CPUID_TSC_LEAF		0x15
+#define CPUID_FREQ_LEAF		0x16
 
 #ifdef CONFIG_X86_32
 extern int have_cpuid_p(void);
diff -puN arch/x86/kernel/tsc.c~tsc-leaf-checks-3 arch/x86/kernel/tsc.c
--- a/arch/x86/kernel/tsc.c~tsc-leaf-checks-3	2024-11-20 11:44:19.305730518 -0800
+++ b/arch/x86/kernel/tsc.c	2024-11-20 11:44:19.305730518 -0800
@@ -680,8 +680,8 @@ unsigned long native_calibrate_tsc(void)
 
 	/*
 	 * Denverton SoCs don't report crystal clock, and also don't support
-	 * CPUID.0x16 for the calculation below, so hardcode the 25MHz crystal
-	 * clock.
+	 * CPUID_FREQ_LEAF for the calculation below, so hardcode the 25MHz
+	 * crystal clock.
 	 */
 	if (crystal_khz == 0 &&
 			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
@@ -700,10 +700,10 @@ unsigned long native_calibrate_tsc(void)
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
@@ -738,12 +738,12 @@ static unsigned long cpu_khz_from_cpuid(
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

