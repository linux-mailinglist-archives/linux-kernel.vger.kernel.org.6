Return-Path: <linux-kernel+bounces-389619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 759FF9B6F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A713F1C214A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4582185A3;
	Wed, 30 Oct 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RR8SFUrc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2C2178F3
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323999; cv=none; b=gRjaPqmU1RVAkEKhqjrtrsoqqcoagcvqJWKcXDdQ040M6BaBRDDGXKlQWZ6YewSxwuh8pXF2SOrFCNwpjqb8OE04kUbEAQqRFPVTDRDc5AK9FVVlE32UTvKGLu/BgPvm1RG0nXFRcxAuw91ahBClSvNpQ4z2KBB6Aor0cvb12UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323999; c=relaxed/simple;
	bh=RiZlqPOkcWDYV3s/DPOSTEM4pUVUz5XSVeQqPPc2XjI=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=N+Sf4VzLMA+KAiCxhYomoBeiycGCPzJvSRLHPXpCpEIdWfsI6u2GDaF5ZzIntWW46d9KfrL1cNmgKqrf7nQvGLq8+YfXuAykE7t6+//mFiZJnA8HV4PTeqlWGA5RSOzrepZU0ZhF9GXmvATCTVboVZLhhN+yeE79wo/8aMce90w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RR8SFUrc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730323997; x=1761859997;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=RiZlqPOkcWDYV3s/DPOSTEM4pUVUz5XSVeQqPPc2XjI=;
  b=RR8SFUrcwDdjmilcs84p2KE+YqASnY4l0KtgQUs03h4NXzVsSendgcfT
   HCISidVr2yetuGdqq6rHFItpUHIWa3nL1C1kh8K4vzc/xqGepxrtXWFvH
   bKEiupd5EdWJ4QVyrqkuXiksdaIL/ccoZ6KfYuS/uuP66vXRX+vHwXi9d
   7pPfc7ldEo00iDzs/+quT1dFLw4gJoYQdFq8VAzprI/KDTTkMUTOvYkn5
   s3dQUGareedOnSoSWp/KesZ3eRRTz3A7t+EbRQJWOa+xYtPw1xPJP7moJ
   rCXMP6YPSQ9mMGuoDP0xlAneiqAHB7JcHA0OazXgJMNWskZRz9cT4dshW
   A==;
X-CSE-ConnectionGUID: T6fbU6UGQhifv+mNCZoRcg==
X-CSE-MsgGUID: fTZiZ3BuSeqDaTUGUQC4Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29904696"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29904696"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:17 -0700
X-CSE-ConnectionGUID: zmfkBLItQXm954vjwb8Jug==
X-CSE-MsgGUID: iTKVLLViSh2m8UwckepvLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82090496"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 14:33:16 -0700
Subject: [PATCH 03/11] x86/cpu: Remove unnecessary MwAIT leaf checks
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:16 -0700
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
In-Reply-To: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Message-Id: <20241030213316.95FD3C59@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/kernel/hpet.c~mwait-leaf-checks-2	2024-10-30 12:28:09.946351764 -0700
+++ b/arch/x86/kernel/hpet.c	2024-10-30 12:28:09.950351772 -0700
@@ -928,9 +928,6 @@ static bool __init mwait_pc10_supported(
 	if (!cpu_feature_enabled(X86_FEATURE_MWAIT))
 		return false;
 
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return false;
-
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
 	return (ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) &&
diff -puN arch/x86/kernel/smpboot.c~mwait-leaf-checks-2 arch/x86/kernel/smpboot.c
--- a/arch/x86/kernel/smpboot.c~mwait-leaf-checks-2	2024-10-30 12:28:09.946351764 -0700
+++ b/arch/x86/kernel/smpboot.c	2024-10-30 12:28:09.950351772 -0700
@@ -1291,8 +1291,6 @@ static inline void mwait_play_dead(void)
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
 		return;
-	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
-		return;
 
 	eax = CPUID_MWAIT_LEAF;
 	ecx = 0;
diff -puN drivers/acpi/acpi_pad.c~mwait-leaf-checks-2 drivers/acpi/acpi_pad.c
--- a/drivers/acpi/acpi_pad.c~mwait-leaf-checks-2	2024-10-30 12:28:09.946351764 -0700
+++ b/drivers/acpi/acpi_pad.c	2024-10-30 12:28:09.950351772 -0700
@@ -47,8 +47,6 @@ static void power_saving_mwait_init(void
 
 	if (!boot_cpu_has(X86_FEATURE_MWAIT))
 		return;
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
 
diff -puN drivers/idle/intel_idle.c~mwait-leaf-checks-2 drivers/idle/intel_idle.c
--- a/drivers/idle/intel_idle.c~mwait-leaf-checks-2	2024-10-30 12:28:09.946351764 -0700
+++ b/drivers/idle/intel_idle.c	2024-10-30 12:28:09.950351772 -0700
@@ -2269,9 +2269,6 @@ static int __init intel_idle_init(void)
 			return -ENODEV;
 	}
 
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return -ENODEV;
-
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
_

