Return-Path: <linux-kernel+bounces-445547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE5A9F179A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9BC67A075E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7219A297;
	Fri, 13 Dec 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsXUDgdI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC51957E2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123035; cv=none; b=ex7/A1RlO9jnMpDjB/diPEPNtQlFIZ2OycaFj2rLupgBMhSUxWAQ7cHp4bXDyFpNsKLhVCKfPCkkAKBlhMFy1DqOIkgcXeWsieRhwA3JNRTdTJYL2cPOU7k4W4Mdyf7Lagw5yO+ozuftbXPr0A5j7GhOVxzzfOj3oxT43MK6YeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123035; c=relaxed/simple;
	bh=URfoHTLKbqY+f/Je1GHdBwfgPB1IkkIRnziSQJJR87k=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Gg5iXeFMtjqNCboJONFa+r6tEx83HroqgmVlMByhU7olrnfmKOWNtAqd9A2cbYgaYA+SdHyAQzA22PI6g2zlC0Lcq5Z4lsF8MYtFPOi5xjd0nzwiyMuv5anK6PGIUcNW1Cjh0L6Kf5lgWjsoXkJASHCxAoTeWv4eVQdosOc6S1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsXUDgdI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123033; x=1765659033;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=URfoHTLKbqY+f/Je1GHdBwfgPB1IkkIRnziSQJJR87k=;
  b=hsXUDgdIHALOhP8j8IMkAQH9HTTlE/P9LzoF7Sk8HImhfC5u7RW15zQ3
   am3Qr9zWUGQ13/L4/X5GTNO1ig/lFy2vKP+hCkmpo+jUWZYQ5RpZoE0fO
   ighJkdS/NqqN/cERkXeaFUT1whd8FhT19PU4c/R5K65SpI3DV9oTpu1M0
   R0nHZi6irPUHSijmQOTlKCTTuvfSGqGrV/qvBx7PEnxIocaFOav23MeBc
   9Tsrxh5vdSuMzvIQHmOYjp2ZujwIkaA+QNrkwvglaTB0cBU8okjyof177
   DMFRomgYFoDcLKq8hL+Uw/dpk123w7Gkr1rabArx6OMtgZvoMqAm4Usdi
   w==;
X-CSE-ConnectionGUID: WqdNBNVbQd+Vuxo2TeQiPw==
X-CSE-MsgGUID: Z5GCgQJoSeuzvJqeJRgA2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45973136"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="45973136"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:33 -0800
X-CSE-ConnectionGUID: o3bBv8OeQ/OjzsmWVY4UFw==
X-CSE-MsgGUID: bT4JOmtQQQGHLolo3pV2lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101599680"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa005.jf.intel.com with ESMTP; 13 Dec 2024 12:50:33 -0800
Subject: [PATCH 05/10] x86/cpu: Move TSC CPUID leaf definition
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>,zhao1.liu@intel.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:33 -0800
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Message-Id: <20241213205033.68799E53@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Prepare to use the TSC CPUID leaf definition more widely by moving
it to the common header.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---

 b/arch/x86/events/intel/pt.c   |    1 +
 b/arch/x86/events/intel/pt.h   |    3 ---
 b/arch/x86/include/asm/cpuid.h |    1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff -puN arch/x86/events/intel/pt.c~tsc-leaf-checks-1 arch/x86/events/intel/pt.c
--- a/arch/x86/events/intel/pt.c~tsc-leaf-checks-1	2024-12-13 12:45:34.779136538 -0800
+++ b/arch/x86/events/intel/pt.c	2024-12-13 12:45:34.787136878 -0800
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 
+#include <asm/cpuid.h>
 #include <asm/perf_event.h>
 #include <asm/insn.h>
 #include <asm/io.h>
diff -puN arch/x86/events/intel/pt.h~tsc-leaf-checks-1 arch/x86/events/intel/pt.h
--- a/arch/x86/events/intel/pt.h~tsc-leaf-checks-1	2024-12-13 12:45:34.779136538 -0800
+++ b/arch/x86/events/intel/pt.h	2024-12-13 12:45:34.787136878 -0800
@@ -37,9 +37,6 @@ struct topa_entry {
 	u64	rsvd4	: 12;
 };
 
-/* TSC to Core Crystal Clock Ratio */
-#define CPUID_TSC_LEAF		0x15
-
 struct pt_pmu {
 	struct pmu		pmu;
 	u32			caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
diff -puN arch/x86/include/asm/cpuid.h~tsc-leaf-checks-1 arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~tsc-leaf-checks-1	2024-12-13 12:45:34.783136707 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-12-13 12:45:34.787136878 -0800
@@ -23,6 +23,7 @@ enum cpuid_regs_idx {
 
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
+#define CPUID_TSC_LEAF		0x15
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
_

