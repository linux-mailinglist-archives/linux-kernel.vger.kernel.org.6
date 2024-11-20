Return-Path: <linux-kernel+bounces-416277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF489D42BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A591F23845
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36DB1C9B6D;
	Wed, 20 Nov 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XYYzYhW1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4D1C82E2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132416; cv=none; b=Eiym/VhJGlTsfEkrex0vNQIVwPTEN6xUc5X4ALAJMYpCZ+/t70AJbzK8l1ZcnF0KbPJ2+adHI5j6d3wxH/nVyxDTn4niME7MkEe2IixTH5yoyFakCFjD0unmVGDlZHPnJzWNIiNc4kx5jeeONU0xssz9XaF0fgByb4n9n2SOUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132416; c=relaxed/simple;
	bh=ufKR/HxIONSAlvislfnSWD+gd9w6J6HqJhN3qcyIDr8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=oUiFmQC8+Is/3TQIpSIe7w2WQlEQcr0E4SHrqZOylajmG3fB+4RSEDWGW4OIhwWZhhMT3eHuXKhI3qyg7Ht0em5wV94vypsTQxUsulKh+70DA+HzhTg2EdUKem2s7bmwPYH4koOQW2AI4bRkcCzULBHJ3ruWwMbOzUY4Dy88wjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XYYzYhW1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132414; x=1763668414;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=ufKR/HxIONSAlvislfnSWD+gd9w6J6HqJhN3qcyIDr8=;
  b=XYYzYhW1A2qIrHziPu30jczcbIusbdPJp7OOZE0l37ogEkyY7/YvmVMP
   G38eKSYdPWQfap+Gssy1qXatiY0UzjB3KgBBsV98jwhY/ExndC0XB6pMV
   feg7ozj8Y1V4OJWLKgaKCLhRUyv5GfF8OHiYJ328KLD+Se43FAK3m57k0
   gdJkF5ArpPtaff5CsEmB4BQiN3Diu/P/bhRmurcRm5OMBla+8uXimEUch
   lQ9zy6P6BkafrPdJ/RYFxEo8dO+Qp83wcWCAreC+6AhFsziHfs6wi5/h3
   EutxCojb6ost+0Rfn3+48QZTFfLE0ZmpHuVN76mEk+bIQmu+SC5k2jBxs
   g==;
X-CSE-ConnectionGUID: Y7PmdNGXT+aKt2nlNIQmiQ==
X-CSE-MsgGUID: TxxgY92EQtGwhx9s3JD2mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31580957"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31580957"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:34 -0800
X-CSE-ConnectionGUID: 6x9Tv/WWSuuqB6RMt2S2Hg==
X-CSE-MsgGUID: EpjDYOnhTqa1PcS+wDC4og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="120884177"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2024 11:53:35 -0800
Subject: [PATCH 05/11] x86/cpu: Refresh DCA leaf reading code
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:34 -0800
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Message-Id: <20241120195334.2F676736@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/include/asm/cpuid.h~dca-leaf-checks-1	2024-11-20 11:44:17.721669887 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-11-20 11:44:17.725670041 -0800
@@ -19,7 +19,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_MWAIT_LEAF		5
+#define CPUID_MWAIT_LEAF	0x5
+#define CPUID_DCA_LEAF		0x9
 
 #ifdef CONFIG_X86_32
 extern int have_cpuid_p(void);
diff -puN arch/x86/kernel/cpu/common.c~dca-leaf-checks-1 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~dca-leaf-checks-1	2024-11-20 11:44:17.721669887 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-11-20 11:44:17.725670041 -0800
@@ -639,7 +639,7 @@ struct cpuid_dependent_feature {
 static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
 	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
-	{ X86_FEATURE_DCA,		0x00000009 },
+	{ X86_FEATURE_DCA,		CPUID_DCA_LEAF },
 	{ X86_FEATURE_XSAVE,		0x0000000d },
 	{ 0, 0 }
 };
diff -puN drivers/dma/ioat/dca.c~dca-leaf-checks-1 drivers/dma/ioat/dca.c
--- a/drivers/dma/ioat/dca.c~dca-leaf-checks-1	2024-11-20 11:44:17.721669887 -0800
+++ b/drivers/dma/ioat/dca.c	2024-11-20 11:44:17.725670041 -0800
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

