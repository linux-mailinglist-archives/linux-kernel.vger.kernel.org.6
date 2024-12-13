Return-Path: <linux-kernel+bounces-445545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F99F1798
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72BA6188E8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61231953A1;
	Fri, 13 Dec 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbYaqotg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A10192B60
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123033; cv=none; b=tdg6Otd+E0/GY7GWA16U52MxeVEGOuntgvmpjGxaluunFfwn7gmnHMl2hfJIPw95MWGNFM6I+NBxvH+slgc5aTz/OUGnVx4nrABQ89pBRu3ov5cRcMWV7A353AIjKQrqZO0HKSMcgq9diYw4N4HS08QU79wsxjRk6Q91m2BHA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123033; c=relaxed/simple;
	bh=WNrCorcx1ZaHvjLY90LjCW7fx9Wt16wHLtzNcRvz+qI=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=mRSxOOdwuoTXzbULfgn21njr1A89/fsy1KKo/Q4LzGpRYJM2dTZ9aNWctTrouISh4ZGPQXdXbrDAoCQ68gpbHLooXk6+KldV/SaQPAegRgl85snHsoqlGUYH3ThQ+Ik0zoZeCLlkw1DhJSQsL8XjXa87gyvaupGiu+nbkHSEDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbYaqotg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123031; x=1765659031;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=WNrCorcx1ZaHvjLY90LjCW7fx9Wt16wHLtzNcRvz+qI=;
  b=nbYaqotgSNmXLRnsXURceKLw9hkPssHMhbWBCtYTwwktEiH8As/pYrqb
   IV3PZ2LLyld/J9Qu08KlK51SC/CD0/saFYNBZumLl3d6S/0q99IWgfnjE
   +/AtoxKXWyyeO5j0K3Dz6XAmLFs6eI88gTegZ9CNbzc4HLDiQALF9tVdN
   Vlna+KFVQFD/mq9KmE92QFN/o5uV0Tx+dzvopgpI2ZeQmKMzpt0usWUVL
   Fwb+7RvHoOKuRW0WzKZFxkCuBJe69lS6qrzmwsatEZrWpewIBeUE5pUgF
   /BI4eBL+p6gfakkN5ulr43G0ZbeEdbCCDq53/grIEvusilJsBOCGqyRT+
   w==;
X-CSE-ConnectionGUID: ra3iXvwBTHe4pHplcZvabg==
X-CSE-MsgGUID: 3MTaXYw5TyKgqXXBa6KCyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45973124"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45973124"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:31 -0800
X-CSE-ConnectionGUID: ct4snp1CQzWJ6uXah5zH4g==
X-CSE-MsgGUID: l09zwUm9Q+SDXmzpVzyalg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101599672"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa005.jf.intel.com with ESMTP; 13 Dec 2024 12:50:31 -0800
Subject: [PATCH 03/10] x86/cpu: Remove unnecessary MwAIT leaf checks
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:30 -0800
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Message-Id: <20241213205030.9B42B458@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The CPUID leaf dependency checker will remove X86_FEATURE_MWAIT if
the CPUID level is below the required level (CPUID_MWAIT_LEAF).
Thus, if you check X86_FEATURE_MWAIT you do not need to also
check the CPUID level.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/hpet.c    |    3 ---
 b/arch/x86/kernel/smpboot.c |    2 --
 b/drivers/acpi/acpi_pad.c   |    2 --
 b/drivers/idle/intel_idle.c |    3 ---
 4 files changed, 10 deletions(-)

diff -puN arch/x86/kernel/hpet.c~mwait-leaf-checks-2 arch/x86/kernel/hpet.c
--- a/arch/x86/kernel/hpet.c~mwait-leaf-checks-2	2024-12-13 12:45:33.699090754 -0800
+++ b/arch/x86/kernel/hpet.c	2024-12-13 12:45:33.707091093 -0800
@@ -928,9 +928,6 @@ static bool __init mwait_pc10_supported(
 	if (!cpu_feature_enabled(X86_FEATURE_MWAIT))
 		return false;
 
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return false;
-
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
 	return (ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) &&
diff -puN arch/x86/kernel/smpboot.c~mwait-leaf-checks-2 arch/x86/kernel/smpboot.c
--- a/arch/x86/kernel/smpboot.c~mwait-leaf-checks-2	2024-12-13 12:45:33.703090924 -0800
+++ b/arch/x86/kernel/smpboot.c	2024-12-13 12:45:33.707091093 -0800
@@ -1292,8 +1292,6 @@ static inline void mwait_play_dead(void)
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
 		return;
-	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
-		return;
 
 	eax = CPUID_MWAIT_LEAF;
 	ecx = 0;
diff -puN drivers/acpi/acpi_pad.c~mwait-leaf-checks-2 drivers/acpi/acpi_pad.c
--- a/drivers/acpi/acpi_pad.c~mwait-leaf-checks-2	2024-12-13 12:45:33.703090924 -0800
+++ b/drivers/acpi/acpi_pad.c	2024-12-13 12:45:33.707091093 -0800
@@ -47,8 +47,6 @@ static void power_saving_mwait_init(void
 
 	if (!boot_cpu_has(X86_FEATURE_MWAIT))
 		return;
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
 
diff -puN drivers/idle/intel_idle.c~mwait-leaf-checks-2 drivers/idle/intel_idle.c
--- a/drivers/idle/intel_idle.c~mwait-leaf-checks-2	2024-12-13 12:45:33.703090924 -0800
+++ b/drivers/idle/intel_idle.c	2024-12-13 12:45:33.707091093 -0800
@@ -2317,9 +2317,6 @@ static int __init intel_idle_init(void)
 			return -ENODEV;
 	}
 
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return -ENODEV;
-
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
_

