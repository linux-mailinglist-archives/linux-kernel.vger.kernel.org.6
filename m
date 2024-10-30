Return-Path: <linux-kernel+bounces-389624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D44E9B6F10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9A11C21F10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF5219CB5;
	Wed, 30 Oct 2024 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heTQP3VI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6D52194B9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324006; cv=none; b=hd59SgP0317M5FasE8oydbNKKdkTHwk9xBNjpxXRKMU+u0vun9kK5EKjUsogFfoyIcXKJqYiopECm/5ut1Vbop5yrkYCNW/+NITY8JKHZjmo+rE2YgGQF4B1kNXdnEu8phThW+iwIWZGD1UdhvAI5WT8kSMWz/1w69LKzosQCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324006; c=relaxed/simple;
	bh=6qodWXABKoKLSgLw339vyiDw3eix/wPdhhHAMnrFV5s=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=LpqvfN2PcA5j8sxAjVhsfHu2gfv3DKWOuOu78ioc7dWQOgu2mtxFc8Pfv9HV6Jxk17lg8zRYC48hMfKyJTZ7b/Gjwls9WGMrY2+SPw4DUwa7vD21ujYm20lVIDSk1cbcBykVXCVkH7IsCHoujrRequzlfRBWMhD76kiG2KgdEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=heTQP3VI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730324005; x=1761860005;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=6qodWXABKoKLSgLw339vyiDw3eix/wPdhhHAMnrFV5s=;
  b=heTQP3VI8u9UMeL1nLhu7fMeO0qbLiXdRxqbseIv8tFtkokBTNDM//ca
   Lw7x1IJcadeBfAlo3Jfl7Pv7QOtGKRQttBrHgpHxDEgfLXwpzatB5kgqr
   5XOIu6nMQNkIPCyIQGYpf55hB4AO9oL2zk7ipvi7g6/j0AUi3P9lvoTd4
   SE4wZQHrwhlt0pb7QvJXHirpzpMOjk07XEUFMW3cg8Uaag5d1Hv0ORqql
   6vIodgYBqm+wv4Jg4OGUG8+nY/raolgapf8bYzVgaJ/oAK5u3uf7MLq1G
   EzZ0seMJFfSNKeHyLPUrvIiDx6IGxYZGYAkaUI8hBOWohUe19BHAR8HPb
   w==;
X-CSE-ConnectionGUID: C1D30Z6VTnmjjJteZfqpbw==
X-CSE-MsgGUID: iFiuKMYBT8q+0VtxD60PzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33741622"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33741622"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:25 -0700
X-CSE-ConnectionGUID: D/X7jZPrTkGajF5OmUGNxw==
X-CSE-MsgGUID: V9uFEfLXS7+ChQCiRUABWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="83257701"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 30 Oct 2024 14:33:25 -0700
Subject: [PATCH 08/11] x86/tsc: Remove CPUID "frequency" leaf magic numbers.
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:24 -0700
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
In-Reply-To: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Message-Id: <20241030213324.3750CF43@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/include/asm/cpuid.h~tsc-leaf-checks-3	2024-10-30 12:26:58.006213934 -0700
+++ b/arch/x86/include/asm/cpuid.h	2024-10-30 12:26:58.010213943 -0700
@@ -22,6 +22,7 @@ enum cpuid_regs_idx {
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
 #define CPUID_TSC_LEAF		0x15
+#define CPUID_FREQ_LEAF		0x16
 
 #ifdef CONFIG_X86_32
 extern int have_cpuid_p(void);
diff -puN arch/x86/kernel/tsc.c~tsc-leaf-checks-3 arch/x86/kernel/tsc.c
--- a/arch/x86/kernel/tsc.c~tsc-leaf-checks-3	2024-10-30 12:26:58.010213943 -0700
+++ b/arch/x86/kernel/tsc.c	2024-10-30 12:26:58.010213943 -0700
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

