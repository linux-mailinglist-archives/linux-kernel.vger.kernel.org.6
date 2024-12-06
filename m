Return-Path: <linux-kernel+bounces-435543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D009E791F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B5B1624E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A750F207658;
	Fri,  6 Dec 2024 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crg5hvEE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B0204599
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513915; cv=none; b=Fgzmhail5gbnKQ7Gz51pnPa/kgkoPjOrSzcix5J6ra3IDBekiDuJuVZmQlpoRUxOMAzhCVtIoiIujC6VUbHiPPexz64dg0f5wthhOU++1/+k0rUGLAAHYpY7nYtA5psayPsnnfHrl+g3TBDoIziwaSM/S9gbdLx/ubFc6PcHd8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513915; c=relaxed/simple;
	bh=WFKn4gSiw9pHKaXOVDiX59STjEFOdvdlUThNCYnjNd0=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=uLfAhBdb9efvSt5o7tKHPbmYPYiROA1oESoO4pJQO3gSGEXbhOoVxmBPHcKjbJoxmjwApjoAbP3kq1fhPlBAJZLHbZ7G16oWkhQzdNAuu6Z2iyGsgP9VK+WH4fwfXDPc0y04SfNtOB/Ger5Cy4nHFf/fHd+bsRQNAtwtnJOAP3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crg5hvEE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733513913; x=1765049913;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=WFKn4gSiw9pHKaXOVDiX59STjEFOdvdlUThNCYnjNd0=;
  b=crg5hvEEkulHzvtAr3n8HQxvUIV3Y9XTYV+fE07eGO8XznKLERJLwuc/
   yVgcmTv1zJb6wx2CAJ64wDqhyGuXUCjqB9H7Z9RzNkX1bR4mt35NpLOja
   pBFHuTZyWhgriF4urWRa8VxCLu5WiPww5uRpXl9Z/J5Le7uyuF5SRuWd0
   tcxC4kWIplyheoDPFkpi9/SPFHZQ0aH4XqxHPIb3FFkHTkqNYzQ5+BWMh
   5+uAC6dyOIi+bE0rRiaVGN9dVnbhWVoMFVgN4tkob0tn6+Lv4lXpV9Sfk
   I8wF699xrgMccArezsj8TiUluwU2407HZ0eS4ey32/cQW0+rHDTPqy8hA
   g==;
X-CSE-ConnectionGUID: wNzU3DbnT+qhs0RHCIyepw==
X-CSE-MsgGUID: ZNEfty8/Q62wVdGA/FuoJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34027888"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34027888"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:38:33 -0800
X-CSE-ConnectionGUID: amNAuvHeSyug/DvaxiwHFQ==
X-CSE-MsgGUID: LJXFOh1PTtm36MONlWo9Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94979014"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa009.fm.intel.com with ESMTP; 06 Dec 2024 11:38:33 -0800
Subject: [PATCH 2/5] x86/cpu: Expose only stepping min/max interface
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,mingo@kernel.org,peterz@infradead.org,tony.luck@intel.com,pawan.kumar.gupta@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 06 Dec 2024 11:38:32 -0800
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
In-Reply-To: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
Message-Id: <20241206193832.DCF208DC@davehans-spike.ostc.intel.com>
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
(X86_MATCH_VFM_STEPPING()) just take a stepping range. This ends up
actually being even more compact than before.

Leave the helper in place (renamed to __X86_STEPPINGS()) to make it
more clear what is going on instead of just having a random GENMASK()
in the middle of an already complicated macro.

One oddity that I hit was this macro:

#define VULNBL_INTEL_STEPPINGS(vfm, max_stepping, issues)                 \
       X86_MATCH_VFM_STEPPINGS(vfm, X86_STEPPING_MIN, max_stepping, issues)

It *could* have been converted over to take a min/max stepping value
for each entry. But that would have been a bit too verbose and would
prevent the one oddball in the list (INTEL_COMETLAKE_L stepping 0)
from sticking out.

Instead, just have it take a *maximum* stepping and imply that the match
is from 0=>max_stepping. This is functional for all the cases now and
also retains the nice property of having INTEL_COMETLAKE_L stepping 0
stick out like a sore thumb.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
---

 b/arch/x86/include/asm/cpu_device_id.h |   15 +++---
 b/arch/x86/kernel/apic/apic.c          |   18 +++----
 b/arch/x86/kernel/cpu/common.c         |   78 ++++++++++++++++-----------------
 b/drivers/edac/i10nm_base.c            |   20 ++++----
 b/drivers/edac/skx_base.c              |    2 
 b/include/linux/mod_devicetable.h      |    2 
 6 files changed, 69 insertions(+), 66 deletions(-)

diff -puN arch/x86/include/asm/cpu_device_id.h~zap-X86_STEPPINGS arch/x86/include/asm/cpu_device_id.h
--- a/arch/x86/include/asm/cpu_device_id.h~zap-X86_STEPPINGS	2024-12-06 11:33:16.179148524 -0800
+++ b/arch/x86/include/asm/cpu_device_id.h	2024-12-06 11:33:16.191148995 -0800
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
+#define X86_MATCH_VFM_STEPPINGS(vfm, min_step, max_step, data)	\
+	X86_MATCH_VENDORID_FAM_MODEL_STEPPINGS_FEATURE(		\
+		VFM_VENDOR(vfm),				\
+		VFM_FAMILY(vfm),				\
+		VFM_MODEL(vfm),					\
+		__X86_STEPPINGS(min_step, max_step),		\
+		X86_FEATURE_ANY, data)
 
 /**
  * X86_MATCH_VFM_FEATURE - Match encoded vendor/family/model/feature
diff -puN arch/x86/kernel/apic/apic.c~zap-X86_STEPPINGS arch/x86/kernel/apic/apic.c
--- a/arch/x86/kernel/apic/apic.c~zap-X86_STEPPINGS	2024-12-06 11:33:16.183148680 -0800
+++ b/arch/x86/kernel/apic/apic.c	2024-12-06 11:33:16.191148995 -0800
@@ -509,19 +509,19 @@ static struct clock_event_device lapic_c
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
 static const struct x86_cpu_id deadline_match[] __initconst = {
-	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
-	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, 0x2, 0x2, 0x3a), /* EP */
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X, 0x4, 0x4, 0x0f), /* EX */
 
 	X86_MATCH_VFM(INTEL_BROADWELL_X,	0x0b000020),
 
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
-	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, 0x2, 0x2, 0x00000011),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, 0x3, 0x3, 0x0700000e),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, 0x4, 0x4, 0x0f00000c),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D, 0x5, 0x5, 0x0e000003),
 
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, 0x3, 0x3, 0x01000136),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, 0x4, 0x4, 0x02000014),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, 0x5, 0xf, 0),
 
 	X86_MATCH_VFM(INTEL_HASWELL,		0x22),
 	X86_MATCH_VFM(INTEL_HASWELL_L,		0x20),
diff -puN arch/x86/kernel/cpu/common.c~zap-X86_STEPPINGS arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~zap-X86_STEPPINGS	2024-12-06 11:33:16.183148680 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-12-06 11:33:16.191148995 -0800
@@ -1201,8 +1201,8 @@ static const __initconst struct x86_cpu_
 #define VULNBL(vendor, family, model, blacklist)	\
 	X86_MATCH_VENDOR_FAM_MODEL(vendor, family, model, blacklist)
 
-#define VULNBL_INTEL_STEPPINGS(vfm, steppings, issues)		   \
-	X86_MATCH_VFM_STEPPINGS(vfm, steppings, issues)
+#define VULNBL_INTEL_STEPPINGS(vfm, max_stepping, issues)		   \
+	X86_MATCH_VFM_STEPPINGS(vfm, X86_STEPPING_MIN, max_stepping, issues)
 
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
+	VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_MAX,		SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL,		X86_STEPPING_MAX,		SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_L,		X86_STEPPING_MAX,		SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_G,		X86_STEPPING_MAX,		SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_HASWELL_X,		X86_STEPPING_MAX,		MMIO),
+	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_D,	X86_STEPPING_MAX,		MMIO),
+	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_G,	X86_STEPPING_MAX,		SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_X,	X86_STEPPING_MAX,		MMIO),
+	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL,		X86_STEPPING_MAX,		SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPING_MAX,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_L,		X86_STEPPING_MAX,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE,		X86_STEPPING_MAX,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPING_MAX,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPING_MAX,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_CANNONLAKE_L,	X86_STEPPING_MAX,		RETBLEED),
+	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_L,		X86_STEPPING_MAX,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_D,		X86_STEPPING_MAX,		MMIO | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_X,		X86_STEPPING_MAX,		MMIO | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE,		X86_STEPPING_MAX,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	0x0,				MMIO | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPING_MAX,		MMIO | MMIO_SBDS | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE_L,	X86_STEPPING_MAX,		GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE,		X86_STEPPING_MAX,		GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_LAKEFIELD,		X86_STEPPING_MAX,		MMIO | MMIO_SBDS | RETBLEED),
+	VULNBL_INTEL_STEPPINGS(INTEL_ROCKETLAKE,	X86_STEPPING_MAX,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE,		X86_STEPPING_MAX,		RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE_L,	X86_STEPPING_MAX,		RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE,	X86_STEPPING_MAX,		RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE_P,	X86_STEPPING_MAX,		RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE_S,	X86_STEPPING_MAX,		RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GRACEMONT,	X86_STEPPING_MAX,		RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT,	X86_STEPPING_MAX,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT_D,	X86_STEPPING_MAX,		MMIO | RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_TREMONT_L,	X86_STEPPING_MAX,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT,	X86_STEPPING_MAX,		RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT_D,	X86_STEPPING_MAX,		RFDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ATOM_GOLDMONT_PLUS, X86_STEPPING_MAX,		RFDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
diff -puN drivers/edac/i10nm_base.c~zap-X86_STEPPINGS drivers/edac/i10nm_base.c
--- a/drivers/edac/i10nm_base.c~zap-X86_STEPPINGS	2024-12-06 11:33:16.187148838 -0800
+++ b/drivers/edac/i10nm_base.c	2024-12-06 11:33:16.191148995 -0800
@@ -938,16 +938,16 @@ static struct res_config gnr_cfg = {
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
+	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	0x0, 0x3, &i10nm_cfg0),
+	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_TREMONT_D,	0x4, 0xf, &i10nm_cfg1),
+	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	0x0, 0x3, &i10nm_cfg0),
+	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_X,	0x4, 0xf, &i10nm_cfg1),
+	X86_MATCH_VFM_STEPPINGS(INTEL_ICELAKE_D,	0x0, 0xf, &i10nm_cfg1),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SAPPHIRERAPIDS_X,	0x0, 0xf, &spr_cfg),
+	X86_MATCH_VFM_STEPPINGS(INTEL_EMERALDRAPIDS_X,	0x0, 0xf, &spr_cfg),
+	X86_MATCH_VFM_STEPPINGS(INTEL_GRANITERAPIDS_X,	0x0, 0xf, &gnr_cfg),
+	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT_X,	0x0, 0xf, &gnr_cfg),
+	X86_MATCH_VFM_STEPPINGS(INTEL_ATOM_CRESTMONT,	0x0, 0xf, &gnr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
diff -puN drivers/edac/skx_base.c~zap-X86_STEPPINGS drivers/edac/skx_base.c
--- a/drivers/edac/skx_base.c~zap-X86_STEPPINGS	2024-12-06 11:33:16.187148838 -0800
+++ b/drivers/edac/skx_base.c	2024-12-06 11:33:16.191148995 -0800
@@ -164,7 +164,7 @@ static struct res_config skx_cfg = {
 };
 
 static const struct x86_cpu_id skx_cpuids[] = {
-	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, X86_STEPPINGS(0x0, 0xf), &skx_cfg),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X, 0x0, 0xf, &skx_cfg),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
diff -puN include/linux/mod_devicetable.h~zap-X86_STEPPINGS include/linux/mod_devicetable.h
--- a/include/linux/mod_devicetable.h~zap-X86_STEPPINGS	2024-12-06 11:33:16.187148838 -0800
+++ b/include/linux/mod_devicetable.h	2024-12-06 11:33:16.191148995 -0800
@@ -700,6 +700,8 @@ struct x86_cpu_id {
 #define X86_FAMILY_ANY 0
 #define X86_MODEL_ANY  0
 #define X86_STEPPING_ANY 0
+#define X86_STEPPING_MIN 0
+#define X86_STEPPING_MAX 0xf
 #define X86_FEATURE_ANY 0	/* Same as FPU, you can't test for that */
 
 /*
_

