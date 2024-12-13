Return-Path: <linux-kernel+bounces-445377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B95F9F153F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6891618AA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414461EB9E1;
	Fri, 13 Dec 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQ7WzXMK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC31BD01D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115892; cv=none; b=PDaDM87fn++SKD3uaG9Z4aREETu6O6SXhuVEigGuCWwQVIG7AFe8R7/MJo7r9uZMsFkzRwO4Lvh36tZeNgr8OzIyxpUADQe0AqRchjX2hCPCWB03+c5Dqq57Hi2A0MsQ32eY7xeVJf6ak2BEJJQ5DPGvQzrAVhKNitOC9qAPctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115892; c=relaxed/simple;
	bh=8WHe9Gtjba18LGhb9HPwjyjdxJODy8ZwfhU5Toh4RF4=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=NavV75z4KoBeywYDSupP0qn2KrGxDDsM+vi9+DVZ8MmkmdlPvxcxp455n3q70Rz5Ggf8U9Z8zQ5aP/GsGX8iwrcdFaJcE8hbYH1a855GAzXh/HABqLKCSqaDvqEU32ULKLZjdOm8dYnOe68DIj88nHvk/Y3PMTyv0BdsEoqVQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQ7WzXMK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734115891; x=1765651891;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=8WHe9Gtjba18LGhb9HPwjyjdxJODy8ZwfhU5Toh4RF4=;
  b=XQ7WzXMKmQlck19T+fM8Tk33cjN9/0N1xB10ax38tLNB9G/qUqaiyRKT
   mD2V9tLW88kUeRr3UZ+Po1Q4LfMFnGSG5GeXtVKgRhyHVOrCWs8a8O87x
   HaaJLHWMaQdqxutYIVcFRg/WaQzZNrp6rURi7h9PJ1B0srDL33ob7sXli
   GQ40TzcBe4SGogBTzyzQfpnPfZOmKX1zx1mqJJOCkNuZTO1aAmc8Y8/Ff
   RS4IOHtTVHg/EmPPLAxi3Hn/ovdevVt4HN7oq6Umu3lQvEz4YI5Zp6leM
   74PJZqflfKUhXVFcZJ5FcG0zE3RCQYnU3Q2vFzymnpiH4F4LMzvHArX4w
   Q==;
X-CSE-ConnectionGUID: 8vJvWU4PQ+SM3/Hc7sj2Gg==
X-CSE-MsgGUID: zVfOTcd4TzOqaFRhUQtvRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34487432"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34487432"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 10:51:30 -0800
X-CSE-ConnectionGUID: 7h37SbDKQpuQz7AGM59Biw==
X-CSE-MsgGUID: QZ9AT6XETh+x04vM7pMeog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96478751"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 10:51:31 -0800
Subject: [v2][PATCH 2/5] x86/cpu: Expose only stepping min/max interface
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>,mingo@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 10:51:29 -0800
References: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
Message-Id: <20241213185129.65527B2A@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The x86_match_cpu() infrastructure can match CPU steppings. Since
there are only 16 possible steppings, the matching infrastructure goes
all out and stores the stepping match as a bitmap. That means it can
match any possible steppings in a single list entry. Fun.

But it exposes this bitmap to each of the X86_MATCH_*() helpers when
none of them really need a bitmap. It makes up for this by exporting a
helper (X86_STEPPINGS()) which converts a contiguous stepping range
into the bitmap which every single user leverages.

Instead of a bitmap, have the main helper for this sort of thing
(X86_MATCH_VFM_STEPS()) just take a stepping range. This ends up
actually being even more compact than before.

Leave the helper in place (renamed to __X86_STEPPINGS()) to make it
more clear what is going on instead of just having a random GENMASK()
in the middle of an already complicated macro.

One oddity that I hit was this macro:

#define VULNBL_INTEL_STEPS(vfm, max_stepping, issues)                 \
       X86_MATCH_VFM_STEPS(vfm, X86_STEPPING_MIN, max_stepping, issues)

It *could* have been converted over to take a min/max stepping value
for each entry. But that would have been a bit too verbose and would
prevent the one oddball in the list (INTEL_COMETLAKE_L stepping 0)
from sticking out.

Instead, just have it take a *maximum* stepping and imply that the match
is from 0=>max_stepping. This is functional for all the cases now and
also retains the nice property of having INTEL_COMETLAKE_L stepping 0
stick out like a sore thumb.

skx_cpuids[] is goofy. It uses the stepping match but encodes all
possible steppings. Just use a normal, non-stepping match helper.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
---

 b/arch/x86/include/asm/cpu_device_id.h |   15 +++---
 b/arch/x86/kernel/apic/apic.c          |   18 +++----
 b/arch/x86/kernel/cpu/common.c         |   78 ++++++++++++++++-----------------
 b/drivers/edac/i10nm_base.c            |   21 ++++----
 b/drivers/edac/skx_base.c              |    2 
 b/include/linux/mod_devicetable.h      |    2 
 6 files changed, 70 insertions(+), 66 deletions(-)

diff -puN arch/x86/include/asm/cpu_device_id.h~zap-X86_STEPPINGS arch/x86/include/asm/cpu_device_id.h
--- a/arch/x86/include/asm/cpu_device_id.h~zap-X86_STEPPINGS	2024-12-13 10:47:38.281373050 -0800
+++ b/arch/x86/include/asm/cpu_device_id.h	2024-12-13 10:47:38.293373533 -0800
@@ -56,7 +56,6 @@
 /* x86_cpu_id::flags */
 #define X86_CPU_ID_FLAG_ENTRY_VALID	BIT(0)
 
-#define X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
  * X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE - Base macro for CPU matching
  * @_vendor:	The vendor name, e.g. INTEL, AMD, HYGON, ..., ANY
@@ -208,6 +207,7 @@
 		VFM_MODEL(vfm),				\
 		X86_STEPPING_ANY, X86_FEATURE_ANY, data)
 
+#define __X86_STEPPINGS(mins, maxs)    GENMASK(maxs, mins)
 /**
  * X86_MATCH_VFM_STEPPINGS - Match encoded vendor/family/model/stepping
  * @vfm:	Encoded 8-bits each for vendor, family, model
@@ -218,12 +218,13 @@
  *
  * feature is set to wildcard
  */
-#define X86_MATCH_VFM_STEPPINGS(vfm, steppings, data)	\
-	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(	\
-		VFM_VENDOR(vfm),			\
-		VFM_FAMILY(vfm),			\
-		VFM_MODEL(vfm),				\
-		steppings, X86_FEATURE_ANY, data)
+#define X86_MATCH_VFM_STEPS(vfm, min_step, max_step, data)	\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(		\
+		VFM_VENDOR(vfm),				\
+		VFM_FAMILY(vfm),				\
+		VFM_MODEL(vfm),					\
+		__X86_STEPPINGS(min_step, max_step),		\
+		X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
diff -puN arch/x86/kernel/apic/apic.c~zap-X86_STEPPINGS arch/x86/kernel/apic/apic.c
--- a/arch/x86/kernel/apic/apic.c~zap-X86_STEPPINGS	2024-12-13 10:47:38.285373210 -0800
+++ b/arch/x86/kernel/apic/apic.c	2024-12-13 10:47:38.293373533 -0800
@@ -509,19 +509,19 @@ static struct clock_event_device lapic_c
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
 static const struct x86_cpu_id deadline_match[] __initconst = {
-	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
-	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_X,   0x2, 0x2, 0x3a), /* EP */
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_X,   0x4, 0x4, 0x0f), /* EX */
 
 	X86_MATCH_VFM(INTEL_BROADWELL_X,	0x0b000020),
 
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D, 0x2, 0x2, 0x00000011),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D, 0x3, 0x3, 0x0700000e),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D, 0x4, 0x4, 0x0f00000c),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D, 0x5, 0x5, 0x0e000003),
 
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,   0x3, 0x3, 0x01000136),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,   0x4, 0x4, 0x02000014),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,   0x5, 0xf, 0),
 
 	X86_MATCH_VFM(INTEL_HASWELL,		0x22),
 	X86_MATCH_VFM(INTEL_HASWELL_L,		0x20),
diff -puN arch/x86/kernel/cpu/common.c~zap-X86_STEPPINGS arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~zap-X86_STEPPINGS	2024-12-13 10:47:38.285373210 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-12-13 10:47:38.293373533 -0800
@@ -1201,8 +1201,8 @@ static const __initconst struct x86_cpu_
 #define VULNBL(vendor, family, model, blacklist)	\
 	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, blacklist)
 
-#define VULNBL_INTEL_STEPPINGS(vfm, steppings, issues)		   \
-	X86_MATCH_VFM_STEPPINGS(vfm, steppings, issues)
+#define VULNBL_INTEL_STEPS(vfm, max_stepping, issues)		   \
+	X86_MATCH_VFM_STEPS(vfm, X86_STEP_MIN, max_stepping, issues)
 
 #define VULNBL_AMD(family, blacklist)		\
 	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
@@ -1227,43 +1227,43 @@ static const __initconst struct x86_cpu_
 #define RFDS		BIT(7)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
-	VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_L,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_G,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_X,		X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_L,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_L,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_D,		X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_X,		X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE_L,	X86_STEPPING_ANY,		GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE,		X86_STEPPING_ANY,		GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_LAKEFIELD,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE,		X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE_P,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE_S,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GRACEMONT,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO | RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT_D,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT_PLUS, X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPS(INTEL_IVYBRIDGE,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL_L,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL_G,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL_X,	     X86_STEP_MAX,	MMIO),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL_D,	     X86_STEP_MAX,	MMIO),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL_G,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL_X,	     X86_STEP_MAX,	MMIO),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL,	     X86_STEP_MAX,	SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_X,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPS(INTEL_CANNONLAKE_L,	     X86_STEP_MAX,	RETBLEED),
+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_D,	     X86_STEP_MAX,	MMIO | GDS),
+	VULNBL_INTEL_STEPS(INTEL_ICELAKE_X,	     X86_STEP_MAX,	MMIO | GDS),
+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,		      0x0,	MMIO | RETBLEED),
+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE_L,	     X86_STEP_MAX,	GDS),
+	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE,	     X86_STEP_MAX,	GDS),
+	VULNBL_INTEL_STEPS(INTEL_LAKEFIELD,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED),
+	VULNBL_INTEL_STEPS(INTEL_ROCKETLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_P,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_S,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_GRACEMONT,     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_TREMONT,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_TREMONT_D,     X86_STEP_MAX,	MMIO | RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_TREMONT_L,     X86_STEP_MAX,	MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_GOLDMONT,      X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_GOLDMONT_D,    X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_GOLDMONT_PLUS, X86_STEP_MAX,	RFDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
diff -puN drivers/edac/i10nm_base.c~zap-X86_STEPPINGS drivers/edac/i10nm_base.c
--- a/drivers/edac/i10nm_base.c~zap-X86_STEPPINGS	2024-12-13 10:47:38.285373210 -0800
+++ b/drivers/edac/i10nm_base.c	2024-12-13 10:47:38.293373533 -0800
@@ -938,16 +938,17 @@ static struct res_config gnr_cfg = {
 };
 
 static const struct x86_cpu_id i10nm_cpuids[] = {
-	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_D,	X86_STEPPINGS(0x0, 0xf), &i10nm_cfg1),
-	X86_MATCH_VFM_STEPPINGS(INTEL_SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
-	X86_MATCH_VFM_STEPPINGS(INTEL_EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
-	X86_MATCH_VFM_STEPPINGS(INTEL_GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
-	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
+	X86_MATCH_VFM_STEPS(INTEL_ATOM_TREMONT_D, X86_STEP_MIN,		 0x3, &i10nm_cfg0),
+	X86_MATCH_VFM_STEPS(INTEL_ATOM_TREMONT_D, 	   0x4,	X86_STEP_MAX, &i10nm_cfg1),
+	X86_MATCH_VFM_STEPS(INTEL_ICELAKE_X,	  X86_STEP_MIN, 	 0x3, &i10nm_cfg0),
+	X86_MATCH_VFM_STEPS(INTEL_ICELAKE_X,	 	   0x4, X86_STEP_MAX, &i10nm_cfg1),
+	X86_MATCH_VFM(	    INTEL_ICELAKE_D, 				      &i10nm_cfg1),
+
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, &spr_cfg),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,  &spr_cfg),
+	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,  &gnr_cfg),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X, &gnr_cfg),
+	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,   &gnr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
diff -puN drivers/edac/skx_base.c~zap-X86_STEPPINGS drivers/edac/skx_base.c
--- a/drivers/edac/skx_base.c~zap-X86_STEPPINGS	2024-12-13 10:47:38.289373371 -0800
+++ b/drivers/edac/skx_base.c	2024-12-13 10:47:38.293373533 -0800
@@ -164,7 +164,7 @@ static struct res_config skx_cfg = {
 };
 
 static const struct x86_cpu_id skx_cpuids[] = {
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x0, 0xf), &skx_cfg),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X, &skx_cfg),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
diff -puN include/linux/mod_devicetable.h~zap-X86_STEPPINGS include/linux/mod_devicetable.h
--- a/include/linux/mod_devicetable.h~zap-X86_STEPPINGS	2024-12-13 10:47:38.289373371 -0800
+++ b/include/linux/mod_devicetable.h	2024-12-13 10:47:38.293373533 -0800
@@ -700,6 +700,8 @@ struct x86_cpu_id {
 #define X86_FAMILY_ANY 0
 #define X86_MODEL_ANY  0
 #define X86_STEPPING_ANY 0
+#define X86_STEP_MIN 0
+#define X86_STEP_MAX 0xf
 #define X86_FEATURE_ANY 0	/* Same as FPU, you can't test for that */
 
 /*
_

