Return-Path: <linux-kernel+bounces-416278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C369E9D42BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C21283EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25BB1C9DD3;
	Wed, 20 Nov 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZ0DdHl7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87791C8FA2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132417; cv=none; b=hVzhahj8A6kPCWyyFqGkzJlu/zjOqMd0a2M0K4xc9kM/vv0b21nUG04Hq0z7fHXr/RUMxkjpSJk6Png9ybxc35n4ZL2G3Alqb9VAVujhn45luba6EGlFuGGWVOr0uLzJZuliLSY+LmcVHcMrarkwXYzk1I+MExruIykUFZoJCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132417; c=relaxed/simple;
	bh=TMgJUjOrao2Zxf/CLQAJYRm7lOQFV4DYeNCbMNQzwmM=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=FPuTmhsj83uWu1ql1/li1W0S6HO7EZhN52Nng2v90igU1Qk23B52UotLb84EcGBBiCyQnoLWvupOE5Ede3YZqGBTZKSD8cSCUh/Ne0F2TswYUoEUs2JjTn40X1Q8ezAJj/tsRZ7+skJ8hJlTh09WhwGcK0l/jXw2mHdqcgm6Rmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZ0DdHl7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132416; x=1763668416;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=TMgJUjOrao2Zxf/CLQAJYRm7lOQFV4DYeNCbMNQzwmM=;
  b=DZ0DdHl7mz0xfsH6jo1TLkQEkBa0X7A81L5DUOZvYd668hVPnlywRNVv
   YyEhAcGtItAPtUUvyCSCxc3K18sLl88LyW0KZ9TZiQICe8p2bLAdXe70Y
   SX6/JTzkBTr9dwET5gc469g0rjpXm09wD8h0D75K1gSdF5EEk1dAmF7pR
   +wB/wh3NCddr0CZx/B407GsEDl/unZSwASQhzvufHSavpdCDWs9ihcMQa
   K1WnXQeuoyLi6MBymxpcJ+sGXCOJ3t974222FNTqyiEny31MFkusoepGT
   CryqTI/7fN8eP8tPsrJZ6183YptRu8PNLIeh5SUqXeCoNe0FpOq+RXtgj
   g==;
X-CSE-ConnectionGUID: 8eV+yIy6TO2TirTQ8M/XNw==
X-CSE-MsgGUID: ViFOYgjiQkWBAxIVBzT9Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31580964"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="31580964"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:35 -0800
X-CSE-ConnectionGUID: TiltVwY4QQypFsk3HQEXig==
X-CSE-MsgGUID: gteWNb09S8WUJLs5dOuRww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="120884192"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa002.jf.intel.com with ESMTP; 20 Nov 2024 11:53:36 -0800
Subject: [PATCH 06/11] x86/cpu: Move TSC CPUID leaf definition
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:35 -0800
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Message-Id: <20241120195335.91B979C8@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Prepare to use the TSC CPUID leaf definition more widely by moving
it to the common header.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/events/intel/pt.c   |    1 +
 b/arch/x86/events/intel/pt.h   |    3 ---
 b/arch/x86/include/asm/cpuid.h |    1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff -puN arch/x86/events/intel/pt.c~tsc-leaf-checks-1 arch/x86/events/intel/pt.c
--- a/arch/x86/events/intel/pt.c~tsc-leaf-checks-1	2024-11-20 11:44:18.257690404 -0800
+++ b/arch/x86/events/intel/pt.c	2024-11-20 11:44:18.265690710 -0800
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 
+#include <asm/cpuid.h>
 #include <asm/perf_event.h>
 #include <asm/insn.h>
 #include <asm/io.h>
diff -puN arch/x86/events/intel/pt.h~tsc-leaf-checks-1 arch/x86/events/intel/pt.h
--- a/arch/x86/events/intel/pt.h~tsc-leaf-checks-1	2024-11-20 11:44:18.257690404 -0800
+++ b/arch/x86/events/intel/pt.h	2024-11-20 11:44:18.265690710 -0800
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
--- a/arch/x86/include/asm/cpuid.h~tsc-leaf-checks-1	2024-11-20 11:44:18.261690557 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-11-20 11:44:18.265690710 -0800
@@ -21,6 +21,7 @@ enum cpuid_regs_idx {
 
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
+#define CPUID_TSC_LEAF		0x15
 
 #ifdef CONFIG_X86_32
 extern int have_cpuid_p(void);
_

