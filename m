Return-Path: <linux-kernel+bounces-445550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB969F179D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F8C16984F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37791E8826;
	Fri, 13 Dec 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXP08Gyu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C51A8F7C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123039; cv=none; b=ZbB7fCmAKq1WOGpDE9oun7UJc5zcELFSzEE0oQv1PixYYKDmV1skjA2UQnzKvq4TVYYQHJ357q35sPVfDIpjlmTL8UU7x5sg48ttRfH4tX8G+Gng4TdYq8iRzNHIRcY1cWNtDZjPJaNOXVsydW9AafYTC33yBg07tDuF9Xk46vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123039; c=relaxed/simple;
	bh=cEgyYpgh94K2l0H//C1sGA4R+ovA75LZEUl6JlnC9ro=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=F4aKQtvQxxl++1Rbh07hDjo7aToPJX1Vztp/pnHYG+9W8Rbrul/zx6AO1zlCTpv8u2C/DY/rcjtbVM5tu+/vlHiS6rV7MqKJbCVUUdf2kE8MoTXKb4i4LfcjhqtFkO+s1LuPwWVXpWr9Jb063ZwUwmTL1YU5Bh2Cdu5izE8T2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXP08Gyu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123037; x=1765659037;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=cEgyYpgh94K2l0H//C1sGA4R+ovA75LZEUl6JlnC9ro=;
  b=HXP08Gyu/KcE2Yp9610oy5lbtMEnm1+MZu1yA7UeE+P429QSSim0itGp
   /KfFD0gn3ImTwsytX1ug3CZVXaL90zWfciPJfZ2MhzClvUrybF3H86jb2
   M9t7EgVahWU6cvbdFuBCuNLmiwnVf5FIT0d+eIKBAlE2iqMwwIRq/PjeH
   PIsi2y3mxOvjpy2zFsYrafwWshtw2L0/i3G5bBqRWy0uze9h5Xa2Zzssu
   Bya/rWBnU92PaLxqf+/AgGw0+PjJpA0Ea0qHRUq5C7eKfbHgEXn8OApxO
   8Xrdw1HeYQ4/SEboUukTJrrRjfHCTbcMjWAJM0BCRY9USnP9uA1k/ONZL
   Q==;
X-CSE-ConnectionGUID: spXHovGARcKu+sW749JoWw==
X-CSE-MsgGUID: nhzEjj8zQ3SKBck7my96oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45973163"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45973163"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:37 -0800
X-CSE-ConnectionGUID: ybx7ynE9Q5ukOWVM55ZbDQ==
X-CSE-MsgGUID: rUFRP4ePRdK1k3cOvQCroQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101599692"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa005.jf.intel.com with ESMTP; 13 Dec 2024 12:50:37 -0800
Subject: [PATCH 08/10] x86/fpu: Move CPUID leaf definitions to common code
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>,zhao1.liu@intel.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:37 -0800
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Message-Id: <20241213205037.43C57CDE@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Move the XSAVE-related CPUID leaf definitions to common code.  Then,
use the new definition to remove the last magic number from the CPUID
level dependency table.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---

 b/arch/x86/include/asm/cpuid.h      |    2 ++
 b/arch/x86/include/asm/fpu/xstate.h |    4 ----
 b/arch/x86/kernel/cpu/common.c      |    2 +-
 b/arch/x86/kernel/fpu/xstate.c      |    1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff -puN arch/x86/include/asm/cpuid.h~xsave-leaf-checks-1 arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~xsave-leaf-checks-1	2024-12-13 12:45:36.351203168 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-12-13 12:45:36.359203508 -0800
@@ -23,8 +23,10 @@ enum cpuid_regs_idx {
 
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
+#define XSTATE_CPUID		0x0d
 #define CPUID_TSC_LEAF		0x15
 #define CPUID_FREQ_LEAF		0x16
+#define TILE_CPUID		0x1d
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
diff -puN arch/x86/include/asm/fpu/xstate.h~xsave-leaf-checks-1 arch/x86/include/asm/fpu/xstate.h
--- a/arch/x86/include/asm/fpu/xstate.h~xsave-leaf-checks-1	2024-12-13 12:45:36.355203337 -0800
+++ b/arch/x86/include/asm/fpu/xstate.h	2024-12-13 12:45:36.359203508 -0800
@@ -12,10 +12,6 @@
 /* Bit 63 of XCR0 is reserved for future expansion */
 #define XFEATURE_MASK_EXTEND	(~(XFEATURE_MASK_FPSSE | (1ULL << 63)))
 
-#define XSTATE_CPUID		0x0000000d
-
-#define TILE_CPUID		0x0000001d
-
 #define FXSAVE_SIZE	512
 
 #define XSAVE_HDR_SIZE	    64
diff -puN arch/x86/kernel/cpu/common.c~xsave-leaf-checks-1 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~xsave-leaf-checks-1	2024-12-13 12:45:36.355203337 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-12-13 12:45:36.359203508 -0800
@@ -639,7 +639,7 @@ static const struct cpuid_dependent_feat
 cpuid_dependent_features[] = {
 	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
 	{ X86_FEATURE_DCA,		CPUID_DCA_LEAF },
-	{ X86_FEATURE_XSAVE,		0x0000000d },
+	{ X86_FEATURE_XSAVE,		XSTATE_CPUID },
 	{ 0, 0 }
 };
 
diff -puN arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-1 arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-1	2024-12-13 12:45:36.359203508 -0800
+++ b/arch/x86/kernel/fpu/xstate.c	2024-12-13 12:45:36.359203508 -0800
@@ -20,6 +20,7 @@
 #include <asm/fpu/signal.h>
 #include <asm/fpu/xcr.h>
 
+#include <asm/cpuid.h>
 #include <asm/tlbflush.h>
 #include <asm/prctl.h>
 #include <asm/elf.h>
_

