Return-Path: <linux-kernel+bounces-389618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC8D9B6F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DB71C21B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79477218315;
	Wed, 30 Oct 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFYP7Toc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB821766F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323997; cv=none; b=OoaaA8SRatY1PX6onHeWF8DdRbX0a6j4Z+8BTJ/XzydyE8p+vDnOa9ikJ7QmdhVqTfC8iksR06YKi1D4B4Ql/OD8sXhpps2nbjptcJQujm+pXyr73MNEbxPbaZt5UlAySrJUQHVBdQ7gjPESGZIZ2fe5X1bcOTtqa7IF7PjPf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323997; c=relaxed/simple;
	bh=gdPb/cie5h5aTBsUi0p8B0ddxH5T5MdH0dbGKN58dbA=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=kIBc9ebsy9pL0MUhnqxyo9dRgrS/ZuuPLMOsNxkVUibwt4YqKseXsbSC3DjZIyty9fPNcVLQ67uhsvqWsuYP17lCFo7Jbz0+hnleww/721YnOm1XTA1S58/MPE5v5o47mf3lIwT3Q6LvsSKW5CoiDctXWDRM/0avYKDh/asuO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFYP7Toc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730323995; x=1761859995;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=gdPb/cie5h5aTBsUi0p8B0ddxH5T5MdH0dbGKN58dbA=;
  b=jFYP7TocdDKtBG/J4+29I3Jay7p1F29x2ztxjUklNVitqpnt7442nt4f
   tcNjENnRMLyCSeedTzDy9h5+eB9pwkVqlGJAJjtBMNIKOaMQvTqq52rRQ
   2/kmVu72Qtw+N9vExhVEoDmrsd85R9pRpd1kzPQtGHX23CmatE/81JHl/
   RZoE7VQGWpT7Xf5eHdXozlEBV9x42/LDsg3tWGOzdLU2tVEd4K1/QvdQO
   9fg+4EJ1qn/rSUzw7liiNMZKhfoJgXWca2z5aMWIAvwrA37Fks0IJdb05
   XD/GEvsAtwQaxYt27Gf2XGnTI3bImCp3Lf90c2L5Ox5bIoz0XoM1EAxBr
   g==;
X-CSE-ConnectionGUID: qGeCVdi3QB+XN+7gF3QkGg==
X-CSE-MsgGUID: mCy/P5G4SMiXCU+bj6plOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29904670"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29904670"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:13 -0700
X-CSE-ConnectionGUID: lgPD0kvSQDekrLhRcsClLg==
X-CSE-MsgGUID: bk/a5UkUQ4OYQFHrzn/NPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82090451"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 14:33:13 -0700
Subject: [PATCH 01/11] x86/cpu: Move MWAIT leaf definition to common header
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:12 -0700
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
In-Reply-To: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Message-Id: <20241030213312.A739971C@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/include/asm/cpuid.h~mwait-leaf-checks-0	2024-10-30 12:28:09.050350096 -0700
+++ b/arch/x86/include/asm/cpuid.h	2024-10-30 12:28:09.062350119 -0700
@@ -19,6 +19,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
+#define CPUID_MWAIT_LEAF		5
+
 #ifdef CONFIG_X86_32
 extern int have_cpuid_p(void);
 #else
diff -puN arch/x86/include/asm/mwait.h~mwait-leaf-checks-0 arch/x86/include/asm/mwait.h
--- a/arch/x86/include/asm/mwait.h~mwait-leaf-checks-0	2024-10-30 12:28:09.050350096 -0700
+++ b/arch/x86/include/asm/mwait.h	2024-10-30 12:28:09.062350119 -0700
@@ -15,7 +15,6 @@
 #define MWAIT_HINT2SUBSTATE(hint)	((hint) & MWAIT_CSTATE_MASK)
 #define MWAIT_C1_SUBSTATE_MASK  0xf0
 
-#define CPUID_MWAIT_LEAF		5
 #define CPUID5_ECX_EXTENSIONS_SUPPORTED 0x1
 #define CPUID5_ECX_INTERRUPT_BREAK	0x2
 
diff -puN arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-0 arch/x86/kernel/acpi/cstate.c
--- a/arch/x86/kernel/acpi/cstate.c~mwait-leaf-checks-0	2024-10-30 12:28:09.054350104 -0700
+++ b/arch/x86/kernel/acpi/cstate.c	2024-10-30 12:28:09.062350119 -0700
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 
 #include <acpi/processor.h>
+#include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
 
diff -puN arch/x86/kernel/hpet.c~mwait-leaf-checks-0 arch/x86/kernel/hpet.c
--- a/arch/x86/kernel/hpet.c~mwait-leaf-checks-0	2024-10-30 12:28:09.054350104 -0700
+++ b/arch/x86/kernel/hpet.c	2024-10-30 12:28:09.062350119 -0700
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
+#include <asm/cpuid.h>
 #include <asm/irq_remapping.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
diff -puN arch/x86/kernel/process.c~mwait-leaf-checks-0 arch/x86/kernel/process.c
--- a/arch/x86/kernel/process.c~mwait-leaf-checks-0	2024-10-30 12:28:09.054350104 -0700
+++ b/arch/x86/kernel/process.c	2024-10-30 12:28:09.062350119 -0700
@@ -30,6 +30,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/entry-common.h>
 #include <asm/cpu.h>
+#include <asm/cpuid.h>
 #include <asm/apic.h>
 #include <linux/uaccess.h>
 #include <asm/mwait.h>
diff -puN arch/x86/kernel/smpboot.c~mwait-leaf-checks-0 arch/x86/kernel/smpboot.c
--- a/arch/x86/kernel/smpboot.c~mwait-leaf-checks-0	2024-10-30 12:28:09.058350111 -0700
+++ b/arch/x86/kernel/smpboot.c	2024-10-30 12:28:09.062350119 -0700
@@ -64,6 +64,7 @@
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
+#include <asm/cpuid.h>
 #include <asm/desc.h>
 #include <asm/nmi.h>
 #include <asm/irq.h>
diff -puN arch/x86/xen/enlighten_pv.c~mwait-leaf-checks-0 arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~mwait-leaf-checks-0	2024-10-30 12:28:09.058350111 -0700
+++ b/arch/x86/xen/enlighten_pv.c	2024-10-30 12:28:09.062350119 -0700
@@ -49,6 +49,7 @@
 #include <xen/hvc-console.h>
 #include <xen/acpi.h>
 
+#include <asm/cpuid.h>
 #include <asm/paravirt.h>
 #include <asm/apic.h>
 #include <asm/page.h>
diff -puN drivers/acpi/acpi_pad.c~mwait-leaf-checks-0 drivers/acpi/acpi_pad.c
--- a/drivers/acpi/acpi_pad.c~mwait-leaf-checks-0	2024-10-30 12:28:09.058350111 -0700
+++ b/drivers/acpi/acpi_pad.c	2024-10-30 12:28:09.062350119 -0700
@@ -19,6 +19,7 @@
 #include <linux/acpi.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
+#include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <xen/xen.h>
 
diff -puN drivers/idle/intel_idle.c~mwait-leaf-checks-0 drivers/idle/intel_idle.c
--- a/drivers/idle/intel_idle.c~mwait-leaf-checks-0	2024-10-30 12:28:09.062350119 -0700
+++ b/drivers/idle/intel_idle.c	2024-10-30 12:28:09.062350119 -0700
@@ -51,6 +51,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <asm/cpuid.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
_

