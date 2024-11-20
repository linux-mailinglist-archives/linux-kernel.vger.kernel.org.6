Return-Path: <linux-kernel+bounces-416281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9155B9D42C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB81B21C13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117251CB31B;
	Wed, 20 Nov 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHcEm723"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD31C9EDC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132421; cv=none; b=U9UObXHY0qJYky3qI2f2DIgJ/uUvwl3bPMgfsegGF4RRAOZCRchDlJVwpREr3XVHP8LDoDArKAJi9w7NKHE9zvD7oD0IhuYOOjnGQaiXbnYbbZ+syuDysgy0AThk/6/mQr6qk4Su7T5XY3btUqxjXUTVNVGSP2zHxVjl7c+ihDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132421; c=relaxed/simple;
	bh=phO1s1tSEWm92i+sUaemBphtu0xkX5E3/ye/D7a5V+M=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=TOZ8usvDimnbxPJhj+fdifjvNQZnbj6UxVven72nDMGCYL3mbmrDynOM4/j6C1TvrcgLkjwHmrnjqVduLFbgrGtGyTcxaFV6409vVS0RErxHIL5BpLx+BTFCIHvxJidbLKv0SOgE99pCjhAaa5MJA/w5K7HsZYmQDfwBVGY5wfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHcEm723; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132420; x=1763668420;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=phO1s1tSEWm92i+sUaemBphtu0xkX5E3/ye/D7a5V+M=;
  b=HHcEm723+Wbm0U1bcAt7rTOJiqVneg7v0zFASMYNWeG5iRPM50NLl+uO
   H4LmKnngcNehGgzOkx4BZz+pBsZtzBUWRtvisdlAvnBA7Lc3KbToFSSEt
   iEGDe4K7BRCe06h47+HRb3NAuPdJiCI808deWiucnDoVFCrHudmC/nNI/
   CXs/C/+uAJZYlcCy06orWCPostrHD71hj3GtNDGd8rkK3G0CLN2kxk3yM
   aXDnApM3estT0gpZ0I3E+pehRWzL1SkSxyYwfNU3Df1x0UFHdNIX6K4rc
   5kGL6DYtZaEtSrbMAUdspOx7EoHAlbTFNahiZqRMjj4PL7NGytF8rw34f
   Q==;
X-CSE-ConnectionGUID: UyTN5delSBuTbLJr8xMiMA==
X-CSE-MsgGUID: 9QRUuFGhQAOvJfncCwHRmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31580991"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31580991"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:39 -0800
X-CSE-ConnectionGUID: aWWIvkEiSEWvCV4XRdb8gg==
X-CSE-MsgGUID: Jc0A7YNPRUaxWm6/f8Tj0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="120884226"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2024 11:53:40 -0800
Subject: [PATCH 09/11] x86/fpu: Move CPUID leaf definitions to common code
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:39 -0800
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Message-Id: <20241120195339.6BC10FDE@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/include/asm/cpuid.h~xsave-leaf-checks-1	2024-11-20 11:44:19.817750116 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-11-20 11:44:19.825750422 -0800
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
--- a/arch/x86/include/asm/fpu/xstate.h~xsave-leaf-checks-1	2024-11-20 11:44:19.817750116 -0800
+++ b/arch/x86/include/asm/fpu/xstate.h	2024-11-20 11:44:19.825750422 -0800
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
--- a/arch/x86/kernel/cpu/common.c~xsave-leaf-checks-1	2024-11-20 11:44:19.821750269 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-11-20 11:44:19.825750422 -0800
@@ -640,7 +640,7 @@ static const struct cpuid_dependent_feat
 cpuid_dependent_features[] = {
 	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
 	{ X86_FEATURE_DCA,		CPUID_DCA_LEAF },
-	{ X86_FEATURE_XSAVE,		0x0000000d },
+	{ X86_FEATURE_XSAVE,		XSTATE_CPUID },
 	{ 0, 0 }
 };
 
diff -puN arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-1 arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-1	2024-11-20 11:44:19.821750269 -0800
+++ b/arch/x86/kernel/fpu/xstate.c	2024-11-20 11:44:19.825750422 -0800
@@ -20,6 +20,7 @@
 #include <asm/fpu/signal.h>
 #include <asm/fpu/xcr.h>
 
+#include <asm/cpuid.h>
 #include <asm/tlbflush.h>
 #include <asm/prctl.h>
 #include <asm/elf.h>
_

