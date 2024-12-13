Return-Path: <linux-kernel+bounces-445546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB59F1799
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B55F7A04D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF926198A05;
	Fri, 13 Dec 2024 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgfS+ueN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6591946A2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123034; cv=none; b=KqKCVoC4Cxuvv+b/bBefhr3q4LtrXUmhqT8w3NKXq6vGRwv9Mlm9JH+l16nu5A1rmTdEqkm1BzZRbmXh70249nkUSZCJqZZwX+198SXaI0Btp96XL6V0M4qAhfBN1eYKVAp6nMhxtmzP6jzMGcs8ELYVKCQsMCIX1128HO6oTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123034; c=relaxed/simple;
	bh=oB0v2MYpnGsqE49e3Y8Uuiz8v0EzXXxHO4R8LvmtTus=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=uA1o3hc9dlYe8R8IcSmMD0fduNDgblsgBHMn2Ve1oujzXIFnQ3eYYXmbad5z0wf/m6A/3RM7QFAvaRHzYfYSXLufRLByb7JCdZzcCHDSPHCk9o+cBEQsAenkRGFx+PEsSl6fNlJxyu8PWtYbzEERDI9ISOYwEh06vsC5GYwdY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgfS+ueN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123032; x=1765659032;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=oB0v2MYpnGsqE49e3Y8Uuiz8v0EzXXxHO4R8LvmtTus=;
  b=GgfS+ueNNyfPtebpHSGo8l6s5R8Btae00iuwypwMRlcMx+N6U9QrvpKt
   Nnt2ZN0gnJ2B3MjkYW+6FIdQE0MvRceshgYImPhJQ8MNoxD2OWWG9Y9hu
   r9Iv0fvKpDbH2H1yT0g73ZUnKYye25tzx3bx95C2xman+/PWcNRB0sh7i
   BtQW3iHLN8wyrzbBHLDT8TjJy/Mvi6j7/67xefjpGQS8o3wcEs7bndh3q
   hkyzFLcUf2KDYG2PM/zCcjJksPYt+gNnggN8oCd/+xpjFLLGq0u/7q/Vn
   nzWi+XXtBwUUNDz24RIAtLAUv/7Am6ZEpgoZhbEub8JT36faTwBn43W0X
   g==;
X-CSE-ConnectionGUID: K/OrHAhgSS+M4RLkdnj7uw==
X-CSE-MsgGUID: MiHPUQ0SRImk2GPkHW39LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45973130"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45973130"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:32 -0800
X-CSE-ConnectionGUID: oV4ldtheQeu2r720zr7PFw==
X-CSE-MsgGUID: Vzm5mNOSQhi1GrYOq0oXDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101599676"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa005.jf.intel.com with ESMTP; 13 Dec 2024 12:50:32 -0800
Subject: [PATCH 04/10] x86/cpu: Refresh DCA leaf reading code
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>,zhao1.liu@intel.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:32 -0800
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Message-Id: <20241213205032.476A30FE@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The DCA leaf number is also hard-coded in the CPUID level dependency
table. Move its definition to common code and use it.

While at it, fix up the naming and types in the probe code.  All
CPUID data is provided in 32-bit registers, not 'unsigned long'.
Also stop referring to "level_9".  Move away from test_bit()
because the type is no longer an 'unsigned long'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---

 b/arch/x86/include/asm/cpuid.h |    3 ++-
 b/arch/x86/kernel/cpu/common.c |    2 +-
 b/drivers/dma/ioat/dca.c       |    8 +++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff -puN arch/x86/include/asm/cpuid.h~dca-leaf-checks-1 arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~dca-leaf-checks-1	2024-12-13 12:45:34.247113987 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-12-13 12:45:34.255114326 -0800
@@ -21,7 +21,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_MWAIT_LEAF		5
+#define CPUID_MWAIT_LEAF	0x5
+#define CPUID_DCA_LEAF		0x9
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
diff -puN arch/x86/kernel/cpu/common.c~dca-leaf-checks-1 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~dca-leaf-checks-1	2024-12-13 12:45:34.251114156 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-12-13 12:45:34.255114326 -0800
@@ -638,7 +638,7 @@ struct cpuid_dependent_feature {
 static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
 	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
-	{ X86_FEATURE_DCA,		0x00000009 },
+	{ X86_FEATURE_DCA,		CPUID_DCA_LEAF },
 	{ X86_FEATURE_XSAVE,		0x0000000d },
 	{ 0, 0 }
 };
diff -puN drivers/dma/ioat/dca.c~dca-leaf-checks-1 drivers/dma/ioat/dca.c
--- a/drivers/dma/ioat/dca.c~dca-leaf-checks-1	2024-12-13 12:45:34.251114156 -0800
+++ b/drivers/dma/ioat/dca.c	2024-12-13 12:45:34.255114326 -0800
@@ -10,6 +10,8 @@
 #include <linux/interrupt.h>
 #include <linux/dca.h>
 
+#include <asm/cpuid.h>
+
 /* either a kernel change is needed, or we need something like this in kernel */
 #ifndef CONFIG_SMP
 #include <asm/smp.h>
@@ -58,11 +60,11 @@ static int dca_enabled_in_bios(struct pc
 {
 	/* CPUID level 9 returns DCA configuration */
 	/* Bit 0 indicates DCA enabled by the BIOS */
-	unsigned long cpuid_level_9;
+	u32 eax;
 	int res;
 
-	cpuid_level_9 = cpuid_eax(9);
-	res = test_bit(0, &cpuid_level_9);
+	eax = cpuid_eax(CPUID_DCA_LEAF);
+	res = eax & BIT(0);
 	if (!res)
 		dev_dbg(&pdev->dev, "DCA is disabled in BIOS\n");
 
_

