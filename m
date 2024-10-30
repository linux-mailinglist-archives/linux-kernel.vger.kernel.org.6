Return-Path: <linux-kernel+bounces-389621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBADD9B6F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073EC1C21CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE89B2178F3;
	Wed, 30 Oct 2024 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZohnSTq+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74985218923
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324002; cv=none; b=nLVnG/qNIQZXFZW4dL7pouIIt5pcb+V9LYY9sqV/wxERtz2kCrwy48JKWekunRbDt3vlaPNif7GY6hwguOyGPFTs8YrS72lVC1Gq1r7ZwX6+0x/XTc/EM83vCMyRLOC7nvLikLDSw0zW+JaJ1YCKKSz8Hm8FAPjKhbFfAqTi75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324002; c=relaxed/simple;
	bh=go8B4+pe7siTW5DGoQOIZxJeBXZ27xgMdk1GnZ/0bVQ=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=cFS093fEtDSk1MmPCxRVlgzA+9JTh/0B+GT7aSSgw1NmeNHqQ5nJUtNbNUe9upGLEqs/02OzI/iL5ZhARF5OG1Aj4e2viyciC/FcnlrAHuvqyMymr5CY+zKNX6ithipFoN/dYOoR2Uno+iaB8QkZ/yEJyQdGnUEw9BvVjES9QLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZohnSTq+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730324001; x=1761860001;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=go8B4+pe7siTW5DGoQOIZxJeBXZ27xgMdk1GnZ/0bVQ=;
  b=ZohnSTq+bsgC+p9GuE/bOvz+bxKl9xqyj31H3adkjqSsV4ePE6QMG8X5
   dFenXqGWYGbq06aFoBZKKB/n46BU4sMe1bPkNteZ23R9Y5SSUj+dYSrPi
   rCyu/gL7EHmqxx2ghR/vEnOduTQjDZAFUzxEtZRV2rz45D7ltAtIcRZpn
   +1zswcJn6R9QLMQk+g9F7QisnMkys9QJ8yRbhlolPqo50zDWRoj45rYoD
   V9kiGtS7U+EWFmD2A6SXanQXrmuUPWE7ZTqbbnaF9aiHl83L+EdzEE4qy
   XAMPFRPYnBvQBcyXGnbFnE2/TYhUPtfLc3y2bUReB6TyHt1ttgtZ+JCtx
   Q==;
X-CSE-ConnectionGUID: wke4n1gMTHqFRZCKBy1Twg==
X-CSE-MsgGUID: cXqV+RNiR6iGzRaWOpD51A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33741592"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33741592"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:20 -0700
X-CSE-ConnectionGUID: 76FhRMrbSmeR9xD1gsggfQ==
X-CSE-MsgGUID: TQQrXaHhR9qOUEKpFvMtrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="83257642"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 30 Oct 2024 14:33:20 -0700
Subject: [PATCH 05/11] x86/cpu: Move DCA leaf definition
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:19 -0700
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
In-Reply-To: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Message-Id: <20241030213319.DF09AE20@davehans-spike.ostc.intel.com>
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
---

 b/arch/x86/include/asm/cpuid.h |    3 ++-
 b/arch/x86/kernel/cpu/common.c |    2 +-
 b/drivers/dma/ioat/dca.c       |    8 +++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff -puN arch/x86/include/asm/cpuid.h~dca-leaf-checks-1 arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~dca-leaf-checks-1	2024-10-30 12:26:56.778211510 -0700
+++ b/arch/x86/include/asm/cpuid.h	2024-10-30 12:26:56.782211518 -0700
@@ -19,7 +19,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_MWAIT_LEAF		5
+#define CPUID_MWAIT_LEAF	0x5
+#define CPUID_DCA_LEAF		0x9
 
 #ifdef CONFIG_X86_32
 extern int have_cpuid_p(void);
diff -puN arch/x86/kernel/cpu/common.c~dca-leaf-checks-1 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~dca-leaf-checks-1	2024-10-30 12:26:56.782211518 -0700
+++ b/arch/x86/kernel/cpu/common.c	2024-10-30 12:26:56.782211518 -0700
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
--- a/drivers/dma/ioat/dca.c~dca-leaf-checks-1	2024-10-30 12:26:56.782211518 -0700
+++ b/drivers/dma/ioat/dca.c	2024-10-30 12:26:56.782211518 -0700
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

