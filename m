Return-Path: <linux-kernel+bounces-389625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A64439B6F11
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6411F26490
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF721A4DB;
	Wed, 30 Oct 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2AOmhte"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83553219CA1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324008; cv=none; b=lNwnLR1Ple0U8KN6Vb3TM9d7l2MHB+vq1xoz7NezrwHtPJZgrofs3MiVD0wO+hGD7guk+vA+X6nr1YIT2q1JYM9qD+gYSutEYFPpNnUcXrmPFSQJ+EGSIUtZT++otPb/Q1r+HNaEHZQRAeD2bqfSRJTeNzQC2uy6MkPmLVYuL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324008; c=relaxed/simple;
	bh=tzCoA4Ftaa60Y4uWBgOHGUJtOBHfSgNUhRZfF/Qx16g=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=cMNgQ9OgQ7iB0TeRt1b/Gd/tcDMqWGKywEZp1oqX/G0uXtICnPKywuF3fpVV1cgHb3CZ090ljeKx2E0wkwIGgV61dQlDkaWxdDRtyFSL62j2uZCT36h+bH9CbpiPYGEloxwUhE7sdXR0yi+1FnGiDSkA0tuBW6r/66j+IlV3NWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2AOmhte; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730324007; x=1761860007;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=tzCoA4Ftaa60Y4uWBgOHGUJtOBHfSgNUhRZfF/Qx16g=;
  b=S2AOmhtes8/JxsFYmAlVdlb32c5XkqV/RphFOF37zwMlb338shH7XDIq
   HmN4jGdLfbHveI3N5fppf0PP1smZOfVUiGu5hVHVK6Y4Jdk9CBvcTuBo+
   /YIX71fg1Lfrz2FGGIxfJZjUwtHyTmiD8AzdmNoYHpD5jSwT3vXuqN3uY
   8XYfrfH3F6ip0mfXvjqbmxFjgTny+yaTaw1xVbYGFP3lavGKbYssTtaYC
   iTnlFOgs2gj8q37Xgq1JiK73HtlhnsYGKUF6IUfoLKHnNRkmd+ttBlLAP
   FNxnrh8WPUFsbF2gwtv8jn5MmaSTQV7l8smSsj0FoL3kjltwxUe7OMQJd
   g==;
X-CSE-ConnectionGUID: HJLsveW9SdaQJ+qD1p+z8w==
X-CSE-MsgGUID: Ec8dQhFBThWr4Ahqu1xTMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33741633"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33741633"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:27 -0700
X-CSE-ConnectionGUID: DxljJrihQl+SP56IQus5nw==
X-CSE-MsgGUID: +K7e5/+wSBuzrKJpqZxQvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="83257716"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 30 Oct 2024 14:33:27 -0700
Subject: [PATCH 09/11] x86/fpu: Move CPUID leaf definitions to common code
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:26 -0700
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
In-Reply-To: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Message-Id: <20241030213326.DDC9A7A1@davehans-spike.ostc.intel.com>
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
---

 b/arch/x86/include/asm/cpuid.h      |    2 ++
 b/arch/x86/include/asm/fpu/xstate.h |    4 ----
 b/arch/x86/kernel/cpu/common.c      |    2 +-
 b/arch/x86/kernel/fpu/xstate.c      |    1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff -puN arch/x86/include/asm/cpuid.h~xsave-leaf-checks-1 arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~xsave-leaf-checks-1	2024-10-30 12:26:58.406214724 -0700
+++ b/arch/x86/include/asm/cpuid.h	2024-10-30 12:26:58.414214739 -0700
@@ -21,8 +21,10 @@ enum cpuid_regs_idx {
 
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
+#define XSTATE_CPUID		0x0d
 #define CPUID_TSC_LEAF		0x15
 #define CPUID_FREQ_LEAF		0x16
+#define TILE_CPUID		0x1d
 
 #ifdef CONFIG_X86_32
 extern int have_cpuid_p(void);
diff -puN arch/x86/include/asm/fpu/xstate.h~xsave-leaf-checks-1 arch/x86/include/asm/fpu/xstate.h
--- a/arch/x86/include/asm/fpu/xstate.h~xsave-leaf-checks-1	2024-10-30 12:26:58.410214731 -0700
+++ b/arch/x86/include/asm/fpu/xstate.h	2024-10-30 12:26:58.414214739 -0700
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
--- a/arch/x86/kernel/cpu/common.c~xsave-leaf-checks-1	2024-10-30 12:26:58.410214731 -0700
+++ b/arch/x86/kernel/cpu/common.c	2024-10-30 12:26:58.414214739 -0700
@@ -639,7 +639,7 @@ static const struct cpuid_dependent_feat
 cpuid_dependent_features[] = {
 	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
 	{ X86_FEATURE_DCA,		CPUID_DCA_LEAF },
-	{ X86_FEATURE_XSAVE,		0x0000000d },
+	{ X86_FEATURE_XSAVE,		XSTATE_CPUID },
 	{ 0, 0 }
 };
 
diff -puN arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-1 arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-1	2024-10-30 12:26:58.410214731 -0700
+++ b/arch/x86/kernel/fpu/xstate.c	2024-10-30 12:26:58.414214739 -0700
@@ -20,6 +20,7 @@
 #include <asm/fpu/signal.h>
 #include <asm/fpu/xcr.h>
 
+#include <asm/cpuid.h>
 #include <asm/tlbflush.h>
 #include <asm/prctl.h>
 #include <asm/elf.h>
_

