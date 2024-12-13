Return-Path: <linux-kernel+bounces-445543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A849F1796
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3594188E50F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1519259D;
	Fri, 13 Dec 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huJyY7sA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F1D18F2D8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123030; cv=none; b=CsQu/iAtioQ41Y2g4B6KA3LFRNSHvl4phFlqpv6GsTtRl6lXJBhtyP0kWiRDbeuYNEUkg0dHSG+lj4Y4vw5GbZcFz+KDHwEYVtNGxQjphwJ3FkNLffMuzUOEYn5hvrEFaihRSIAxkHZUNFZosGvciTjq3hU3WqgKYfu/ynGp6Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123030; c=relaxed/simple;
	bh=PdNE16znsAXToRM9EAaV0MfSOv4mBd2IprSp1pNlFn8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=QYV/32bGtf4/XAHyo0rw7n4GZar2+hapzNd0bnUrwm5VcrMZyVm7qZ+TuR3ThawPXFSzwCQgycnMZ2hFnCLN4OwW4oTfRP7yrAnKS0ko77XYlfS6XzdcPuiQ2OBWjBMSwQPlDo+QklnlwJzTJPhLUKGJe8M21mWk0gCLljgmCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huJyY7sA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123029; x=1765659029;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=PdNE16znsAXToRM9EAaV0MfSOv4mBd2IprSp1pNlFn8=;
  b=huJyY7sAxOb9z8ZL3fX0YfgwVVODtssxkVhVE5wZxTeP6XbA25did1gQ
   Wz1/sMNAnls2CAX+ieQ+1x9KfCT96OetwMsMZ9FsS+xO/FfrJQHQa3zKB
   RQZSWa4sLy5l9KrkwuTQqT3o+Pb61j9LjYY63pEy12a+kmZeJTpMNGPuP
   qwRH3bHkIzhmHP7W4ZbhLWMOvPU2I4GJAl9ErvmkZNaT5stEQ7/2RAWAM
   RGyARskA78fIIWV6lHG0KlyDoP8eH4Kj6ANUNn8DXip/L186aZiZRhm95
   5CtDH67A3++kmOsq6rCcb1Qyflm9FWZh1a5g8LE+frs/hvnqJrqTqj+eh
   w==;
X-CSE-ConnectionGUID: gqEs5cJZSV6mKXCluGSNOQ==
X-CSE-MsgGUID: uwnOOCiiRom59sJIEMvZtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34820482"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34820482"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:28 -0800
X-CSE-ConnectionGUID: 8xKfJzhRRmq59ANzfE4ydQ==
X-CSE-MsgGUID: 9msi18D3S7O+8frqDgu7YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96501675"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 12:50:29 -0800
Subject: [PATCH 01/10] x86/cpu: Move MWAIT leaf definition to common header
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>,zhao1.liu@intel.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:28 -0800
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Message-Id: <20241213205028.EE94D02A@davehans-spike.ostc.intel.com>
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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
--- a/arch/x86/include/asm/cpuid.h~mwait-leaf-checks-0	2024-12-13 12:45:32.547041911 -0800
+++ b/arch/x86/include/asm/cpuid.h	2024-12-13 12:45:32.563042590 -0800
@@ -21,6 +21,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
+#define CPUID_MWAIT_LEAF		5
+
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
 #else
diff -puN arch/x86/include/asm/mwait.h~mwait-leaf-checks-0 arch/x86/include/asm/mwait.h
--- a/arch/x86/include/asm/mwait.h~mwait-leaf-checks-0	2024-12-13 12:45:32.547041911 -0800
+++ b/arch/x86/include/asm/mwait.h	2024-12-13 12:45:32.563042590 -0800
@@ -15,7 +15,6 @@
 #define MWAIT_HINT2SUBSTATE(hint)	((hint) & MWAIT_CSTATE_MASK)
 #define MWAIT_C1_SUBSTATE_MASK  0xf0
 
-#define CPUID_MWAIT_LEAF		5
 #define CPUID5_ECX_EXTENSIONS_SUPPORTED 0x1
 #define CPUID5_ECX_INTERRUPT_BREAK	0x2
 
diff -puN arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-0 arch/x86/kernel/acpi/cstate.c
--- a/arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-0	2024-12-13 12:45:32.551042081 -0800
+++ b/arch/x86/kernel/acpi/cstate.c	2024-12-13 12:45:32.563042590 -0800
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 
 #include <acpi/processor.h>
+#include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
 
diff -puN arch/x86/kernel/hpet.c~mwait-leaf-checks-0 arch/x86/kernel/hpet.c
--- a/arch/x86/kernel/hpet.c~mwait-leaf-checks-0	2024-12-13 12:45:32.551042081 -0800
+++ b/arch/x86/kernel/hpet.c	2024-12-13 12:45:32.563042590 -0800
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
+#include <asm/cpuid.h>
 #include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
diff -puN arch/x86/kernel/process.c~mwait-leaf-checks-0 arch/x86/kernel/process.c
--- a/arch/x86/kernel/process.c~mwait-leaf-checks-0	2024-12-13 12:45:32.551042081 -0800
+++ b/arch/x86/kernel/process.c	2024-12-13 12:45:32.563042590 -0800
@@ -30,6 +30,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/entry-common.h>
 #include <asm/cpu.h>
+#include <asm/cpuid.h>
 #include <asm/apic.h>
 #include <linux/uaccess.h>
 #include <asm/mwait.h>
diff -puN arch/x86/kernel/smpboot.c~mwait-leaf-checks-0 arch/x86/kernel/smpboot.c
--- a/arch/x86/kernel/smpboot.c~mwait-leaf-checks-0	2024-12-13 12:45:32.555042251 -0800
+++ b/arch/x86/kernel/smpboot.c	2024-12-13 12:45:32.563042590 -0800
@@ -64,6 +64,7 @@
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
+#include <asm/cpuid.h>
 #include <asm/desc.h>
 #include <asm/nmi.h>
 #include <asm/irq.h>
diff -puN arch/x86/xen/enlighten_pv.c~mwait-leaf-checks-0 arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~mwait-leaf-checks-0	2024-12-13 12:45:32.555042251 -0800
+++ b/arch/x86/xen/enlighten_pv.c	2024-12-13 12:45:32.563042590 -0800
@@ -49,6 +49,7 @@
 #include <xen/hvc-console.h>
 #include <xen/acpi.h>
 
+#include <asm/cpuid.h>
 #include <asm/paravirt.h>
 #include <asm/apic.h>
 #include <asm/page.h>
diff -puN drivers/acpi/acpi_pad.c~mwait-leaf-checks-0 drivers/acpi/acpi_pad.c
--- a/drivers/acpi/acpi_pad.c~mwait-leaf-checks-0	2024-12-13 12:45:32.555042251 -0800
+++ b/drivers/acpi/acpi_pad.c	2024-12-13 12:45:32.563042590 -0800
@@ -19,6 +19,7 @@
 #include <linux/acpi.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
+#include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <xen/xen.h>
 
diff -puN drivers/idle/intel_idle.c~mwait-leaf-checks-0 drivers/idle/intel_idle.c
--- a/drivers/idle/intel_idle.c~mwait-leaf-checks-0	2024-12-13 12:45:32.559042421 -0800
+++ b/drivers/idle/intel_idle.c	2024-12-13 12:45:32.563042590 -0800
@@ -51,6 +51,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <asm/cpuid.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
_

