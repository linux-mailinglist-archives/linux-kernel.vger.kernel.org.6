Return-Path: <linux-kernel+bounces-416273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB749D42B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C577E1F21F80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B21C4A00;
	Wed, 20 Nov 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqOs1sB3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB151C2337
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132411; cv=none; b=d/ABpVIdBnVTfLM0yv8WuW8iCPidg6B+UvGRYOtVgIf3QETlRpfI2vgkzqVC/S4CXfN1Tcn3vYP9EPJsPb/7N2b+dOGO4s/O+2qw//2ZiKVk5uJPx3DuwTeNLLQYTDbTdAKyEvRNunNedTPahrReE3UmgoSr/lmL39rKnY4fQos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132411; c=relaxed/simple;
	bh=3J36Gh0oEqfHMnPHid0T7QcBYIBfjARqblhtajsTFh8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=gXJa+1aFuscILdnIv1KEjUb6zQ8SyBMC4koy0bo3025T9tGmm0pFbnpyJZeG0rGoUGrxfEfTFeyow5GBIJZNycc3izg85qpJ8AJd6K79cj+nL6Rtc1EQcZzYPFw9XqiEGFaW7XLNyh7QATT6/yAxMqBXcgoF+cjdvJQUF7aJHIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqOs1sB3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732132410; x=1763668410;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=3J36Gh0oEqfHMnPHid0T7QcBYIBfjARqblhtajsTFh8=;
  b=dqOs1sB3+20nk1hcuQ1Xy5YEWHKcItJXNouWtyFQfWz1xXEX/ha7oeyt
   cQL9d/qjA2lqBk+jJdljNaGZAOoB5xFFzr+nAixPjVDgE1aAjIQgHSu4U
   xEI5F0iPusO/3f2a1w7RlI//TKsv8NrYDDeUtb+b0P0yGoLYKTTisRRzy
   9LkQHQw47C0XIJmv6jSYTNOhEH55CF+HCrDHc29W+7LcX4f22lGCNT/AQ
   l7F5X8DcvO5JlakO482q81YDbWixQr0O4sci2CeOQr2TPCmahvblyYHJm
   kuAqBXcGpL4vCuGKI0A3Ds8JwXN/232MEqAN/qEpfaJ1Zb2jf2ia/BGOa
   A==;
X-CSE-ConnectionGUID: X0/haTQeQfuTgAyhrny/QQ==
X-CSE-MsgGUID: MDmLaVZZRb2pGnL9wsO2Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32322890"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="32322890"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 11:53:29 -0800
X-CSE-ConnectionGUID: ec4J/hhCRDqAQBYaFLPXCg==
X-CSE-MsgGUID: rigcB/A1Q3ONs6QDpL53lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90409766"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa007.jf.intel.com with ESMTP; 20 Nov 2024 11:53:29 -0800
Subject: [PATCH 01/11] x86/cpu: Move MWAIT leaf definition to common header
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 11:53:28 -0800
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
Message-Id: <20241120195328.4C71D0A5@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Begin constructing a common place to keep all CPUID leaf definitions.
Move CPUID_MWAIT_LEAF to the CPUID header and include it where
needed.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/cpuid.h  |    2 ++
 b/arch/x86/include/asm/mwait.h  |    1 -
 b/arch/x86/kernel/acpi/cstate.c |    1 +
 b/arch/x86/kernel/hpet.c        |    1 +
 b/arch/x86/kernel/process.c     |    1 +
 b/arch/x86/kernel/smpboot.c     |    1 +
 b/arch/x86/xen/enlighten_pv.c   |    1 +
 b/drivers/acpi/acpi_pad.c       |    1 +
 b/drivers/idle/intel_idle.c     |    1 +
 9 files changed, 9 insertions(+), 1 deletion(-)

diff -puN arch/x86/include/asm/cpuid.h~mwait-leaf-checks-0 arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~mwait-leaf-checks-0	2024-11-20 11:44:15.481584146 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-11-20 11:44:15.497584759 -0800
@@ -19,6 +19,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
+#define CPUID_MWAIT_LEAF		5
+
 #ifdef CONFIG_X86_32
 extern int have_cpuid_p(void);
 #else
diff -puN arch/x86/include/asm/mwait.h~mwait-leaf-checks-0 arch/x86/include/asm/mwait.h
--- a/arch/x86/include/asm/mwait.h~mwait-leaf-checks-0	2024-11-20 11:44:15.481584146 -0800
+++ b/arch/x86/include/asm/mwait.h	2024-11-20 11:44:15.497584759 -0800
@@ -15,7 +15,6 @@
 #define MWAIT_HINT2SUBSTATE(hint)	((hint) & MWAIT_CSTATE_MASK)
 #define MWAIT_C1_SUBSTATE_MASK  0xf0
 
-#define CPUID_MWAIT_LEAF		5
 #define CPUID5_ECX_EXTENSIONS_SUPPORTED 0x1
 #define CPUID5_ECX_INTERRUPT_BREAK	0x2
 
diff -puN arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-0 arch/x86/kernel/acpi/cstate.c
--- a/arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-0	2024-11-20 11:44:15.485584299 -0800
+++ b/arch/x86/kernel/acpi/cstate.c	2024-11-20 11:44:15.497584759 -0800
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 
 #include <acpi/processor.h>
+#include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
 
diff -puN arch/x86/kernel/hpet.c~mwait-leaf-checks-0 arch/x86/kernel/hpet.c
--- a/arch/x86/kernel/hpet.c~mwait-leaf-checks-0	2024-11-20 11:44:15.485584299 -0800
+++ b/arch/x86/kernel/hpet.c	2024-11-20 11:44:15.497584759 -0800
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
+#include <asm/cpuid.h>
 #include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
diff -puN arch/x86/kernel/process.c~mwait-leaf-checks-0 arch/x86/kernel/process.c
--- a/arch/x86/kernel/process.c~mwait-leaf-checks-0	2024-11-20 11:44:15.489584453 -0800
+++ b/arch/x86/kernel/process.c	2024-11-20 11:44:15.497584759 -0800
@@ -30,6 +30,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/entry-common.h>
 #include <asm/cpu.h>
+#include <asm/cpuid.h>
 #include <asm/apic.h>
 #include <linux/uaccess.h>
 #include <asm/mwait.h>
diff -puN arch/x86/kernel/smpboot.c~mwait-leaf-checks-0 arch/x86/kernel/smpboot.c
--- a/arch/x86/kernel/smpboot.c~mwait-leaf-checks-0	2024-11-20 11:44:15.489584453 -0800
+++ b/arch/x86/kernel/smpboot.c	2024-11-20 11:44:15.497584759 -0800
@@ -64,6 +64,7 @@
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
+#include <asm/cpuid.h>
 #include <asm/desc.h>
 #include <asm/nmi.h>
 #include <asm/irq.h>
diff -puN arch/x86/xen/enlighten_pv.c~mwait-leaf-checks-0 arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~mwait-leaf-checks-0	2024-11-20 11:44:15.489584453 -0800
+++ b/arch/x86/xen/enlighten_pv.c	2024-11-20 11:44:15.497584759 -0800
@@ -49,6 +49,7 @@
 #include <xen/hvc-console.h>
 #include <xen/acpi.h>
 
+#include <asm/cpuid.h>
 #include <asm/paravirt.h>
 #include <asm/apic.h>
 #include <asm/page.h>
diff -puN drivers/acpi/acpi_pad.c~mwait-leaf-checks-0 drivers/acpi/acpi_pad.c
--- a/drivers/acpi/acpi_pad.c~mwait-leaf-checks-0	2024-11-20 11:44:15.493584606 -0800
+++ b/drivers/acpi/acpi_pad.c	2024-11-20 11:44:15.497584759 -0800
@@ -19,6 +19,7 @@
 #include <linux/acpi.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
+#include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <xen/xen.h>
 
diff -puN drivers/idle/intel_idle.c~mwait-leaf-checks-0 drivers/idle/intel_idle.c
--- a/drivers/idle/intel_idle.c~mwait-leaf-checks-0	2024-11-20 11:44:15.493584606 -0800
+++ b/drivers/idle/intel_idle.c	2024-11-20 11:44:15.497584759 -0800
@@ -51,6 +51,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <asm/cpuid.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
_

