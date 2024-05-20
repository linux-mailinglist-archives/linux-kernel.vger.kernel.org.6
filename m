Return-Path: <linux-kernel+bounces-184255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72EC8CA4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D971C215B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EDD13C9BB;
	Mon, 20 May 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e2yXb5xz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754713BC3F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245211; cv=none; b=NTTEQ50Xih0VrXp5DJCiUF74RwhN7WavJOoZJxwu7Ce0omwTdw56yAiNB0A/CW/OfHwc2iJa82MmPSZBkkDSL4NdytT/hh2ggpV26Z9rstlKqt+STWQRkLm8LmgM7dtvlAR/dCl4+vjWL8KyYIIsI7NydGkKHqHPCMeXkkfTd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245211; c=relaxed/simple;
	bh=l3ocWaXogaTkgtbM/N+j+qLt8Sod225GVPVLcrQcTCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otpkwee3SmQltIHaD4z1VqrpJ6nxU7icxAzObnnf/civsfDXag0/rHnOdfIXvtYArOYA+3cY/8QX1FAkGHReNlxEuZH4EdjFKlkFmyu1X4lhky9oO5tER/LzQF2f8y7dUiFDZdHm21PFcgzHxZifrClteUvuQvLSR5avWy0QCxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e2yXb5xz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245210; x=1747781210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3ocWaXogaTkgtbM/N+j+qLt8Sod225GVPVLcrQcTCY=;
  b=e2yXb5xzw7nwYH3DmB94tixSPM3Zj+WL7p1jKPUlGRsjnN7YA2wB0m5M
   GxZzBThrq+yonIgNQF079TsoZZxBVRfHlY5BpM/qLYAQEcSO+WDahkpTA
   aP4KjAITp3rLkRZV85VICReuPsvv0AiiQFpcPIrnaytgsrNRRGw4rc44h
   G4na7fRFuE131lqrVTYg91001/2AMrDz7VHfr1ZmVGW7oY/FLol0eImAO
   fqJ5ZJDcoxb/hqz2PaRrcp1VRBHEEq2iLi/mnIUprzFoBAds+XJ+uTQiv
   9zOS4Jv8cYJ+zc8+Ug6C38YjDc3u3z0PRUy5p/1R46j+TuGsH0a/Q8+q3
   A==;
X-CSE-ConnectionGUID: nh4bqoicStKrrVRhWCTAjA==
X-CSE-MsgGUID: wFWuVhKHTc66Ux2ekt7Ykw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199818"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199818"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:38 -0700
X-CSE-ConnectionGUID: jgTm0rwLTN+B10D4WpyHZQ==
X-CSE-MsgGUID: T2fWzsTnSCirRuVZuSPuIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593467"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:38 -0700
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Luck <tony.luck@intel.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Thomas Renninger <trenn@suse.de>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v6 28/49] x86/cpu/intel: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:59 -0700
Message-ID: <20240520224620.9480-29-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520224620.9480-1-tony.luck@intel.com>
References: <20240520224620.9480-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 108 ++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 55 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3c3e7e5695ba..98ff73c6ace0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -72,19 +72,19 @@ static bool cpu_model_supports_sld __ro_after_init;
  */
 static void check_memory_type_self_snoop_errata(struct cpuinfo_x86 *c)
 {
-	switch (c->x86_model) {
-	case INTEL_FAM6_CORE_YONAH:
-	case INTEL_FAM6_CORE2_MEROM:
-	case INTEL_FAM6_CORE2_MEROM_L:
-	case INTEL_FAM6_CORE2_PENRYN:
-	case INTEL_FAM6_CORE2_DUNNINGTON:
-	case INTEL_FAM6_NEHALEM:
-	case INTEL_FAM6_NEHALEM_G:
-	case INTEL_FAM6_NEHALEM_EP:
-	case INTEL_FAM6_NEHALEM_EX:
-	case INTEL_FAM6_WESTMERE:
-	case INTEL_FAM6_WESTMERE_EP:
-	case INTEL_FAM6_SANDYBRIDGE:
+	switch (c->x86_vfm) {
+	case INTEL_CORE_YONAH:
+	case INTEL_CORE2_MEROM:
+	case INTEL_CORE2_MEROM_L:
+	case INTEL_CORE2_PENRYN:
+	case INTEL_CORE2_DUNNINGTON:
+	case INTEL_NEHALEM:
+	case INTEL_NEHALEM_G:
+	case INTEL_NEHALEM_EP:
+	case INTEL_NEHALEM_EX:
+	case INTEL_WESTMERE:
+	case INTEL_WESTMERE_EP:
+	case INTEL_SANDYBRIDGE:
 		setup_clear_cpu_cap(X86_FEATURE_SELFSNOOP);
 	}
 }
@@ -106,9 +106,9 @@ static void probe_xeon_phi_r3mwait(struct cpuinfo_x86 *c)
 	 */
 	if (c->x86 != 6)
 		return;
-	switch (c->x86_model) {
-	case INTEL_FAM6_XEON_PHI_KNL:
-	case INTEL_FAM6_XEON_PHI_KNM:
+	switch (c->x86_vfm) {
+	case INTEL_XEON_PHI_KNL:
+	case INTEL_XEON_PHI_KNM:
 		break;
 	default:
 		return;
@@ -134,32 +134,32 @@ static void probe_xeon_phi_r3mwait(struct cpuinfo_x86 *c)
  * - Release note from 20180108 microcode release
  */
 struct sku_microcode {
-	u8 model;
+	u32 vfm;
 	u8 stepping;
 	u32 microcode;
 };
 static const struct sku_microcode spectre_bad_microcodes[] = {
-	{ INTEL_FAM6_KABYLAKE,		0x0B,	0x80 },
-	{ INTEL_FAM6_KABYLAKE,		0x0A,	0x80 },
-	{ INTEL_FAM6_KABYLAKE,		0x09,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_L,	0x0A,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_L,	0x09,	0x80 },
-	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
-	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
-	{ INTEL_FAM6_BROADWELL,		0x04,	0x28 },
-	{ INTEL_FAM6_BROADWELL_G,	0x01,	0x1b },
-	{ INTEL_FAM6_BROADWELL_D,	0x02,	0x14 },
-	{ INTEL_FAM6_BROADWELL_D,	0x03,	0x07000011 },
-	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
-	{ INTEL_FAM6_HASWELL_L,		0x01,	0x21 },
-	{ INTEL_FAM6_HASWELL_G,		0x01,	0x18 },
-	{ INTEL_FAM6_HASWELL,		0x03,	0x23 },
-	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
-	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
-	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
+	{ INTEL_KABYLAKE,	0x0B,	0x80 },
+	{ INTEL_KABYLAKE,	0x0A,	0x80 },
+	{ INTEL_KABYLAKE,	0x09,	0x80 },
+	{ INTEL_KABYLAKE_L,	0x0A,	0x80 },
+	{ INTEL_KABYLAKE_L,	0x09,	0x80 },
+	{ INTEL_SKYLAKE_X,	0x03,	0x0100013e },
+	{ INTEL_SKYLAKE_X,	0x04,	0x0200003c },
+	{ INTEL_BROADWELL,	0x04,	0x28 },
+	{ INTEL_BROADWELL_G,	0x01,	0x1b },
+	{ INTEL_BROADWELL_D,	0x02,	0x14 },
+	{ INTEL_BROADWELL_D,	0x03,	0x07000011 },
+	{ INTEL_BROADWELL_X,	0x01,	0x0b000025 },
+	{ INTEL_HASWELL_L,	0x01,	0x21 },
+	{ INTEL_HASWELL_G,	0x01,	0x18 },
+	{ INTEL_HASWELL,	0x03,	0x23 },
+	{ INTEL_HASWELL_X,	0x02,	0x3b },
+	{ INTEL_HASWELL_X,	0x04,	0x10 },
+	{ INTEL_IVYBRIDGE_X,	0x04,	0x42a },
 	/* Observed in the wild */
-	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
-	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
+	{ INTEL_SANDYBRIDGE_X,	0x06,	0x61b },
+	{ INTEL_SANDYBRIDGE_X,	0x07,	0x712 },
 };
 
 static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
@@ -173,11 +173,8 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
 		return false;
 
-	if (c->x86 != 6)
-		return false;
-
 	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
-		if (c->x86_model == spectre_bad_microcodes[i].model &&
+		if (c->x86_vfm == spectre_bad_microcodes[i].vfm &&
 		    c->x86_stepping == spectre_bad_microcodes[i].stepping)
 			return (c->microcode <= spectre_bad_microcodes[i].microcode);
 	}
@@ -313,7 +310,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 * need the microcode to have already been loaded... so if it is
 	 * not, recommend a BIOS update and disable large pages.
 	 */
-	if (c->x86 == 6 && c->x86_model == 0x1c && c->x86_stepping <= 2 &&
+	if (c->x86_vfm == INTEL_ATOM_BONNELL && c->x86_stepping <= 2 &&
 	    c->microcode < 0x20e) {
 		pr_warn("Atom PSE erratum detected, BIOS microcode update recommended\n");
 		clear_cpu_cap(c, X86_FEATURE_PSE);
@@ -346,11 +343,11 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 
 	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
 	if (c->x86 == 6) {
-		switch (c->x86_model) {
-		case INTEL_FAM6_ATOM_SALTWELL_MID:
-		case INTEL_FAM6_ATOM_SALTWELL_TABLET:
-		case INTEL_FAM6_ATOM_SILVERMONT_MID:
-		case INTEL_FAM6_ATOM_AIRMONT_NP:
+		switch (c->x86_vfm) {
+		case INTEL_ATOM_SALTWELL_MID:
+		case INTEL_ATOM_SALTWELL_TABLET:
+		case INTEL_ATOM_SILVERMONT_MID:
+		case INTEL_ATOM_AIRMONT_NP:
 			set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC_S3);
 			break;
 		default:
@@ -394,7 +391,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 * should be false so that __flush_tlb_all() causes CR3 instead of CR4.PGE
 	 * to be modified.
 	 */
-	if (c->x86 == 5 && c->x86_model == 9) {
+	if (c->x86_vfm == INTEL_QUARK_X1000) {
 		pr_info("Disabling PGE capability bit\n");
 		setup_clear_cpu_cap(X86_FEATURE_PGE);
 	}
@@ -626,12 +623,13 @@ static void init_intel(struct cpuinfo_x86 *c)
 			set_cpu_cap(c, X86_FEATURE_PEBS);
 	}
 
-	if (c->x86 == 6 && boot_cpu_has(X86_FEATURE_CLFLUSH) &&
-	    (c->x86_model == 29 || c->x86_model == 46 || c->x86_model == 47))
+	if (boot_cpu_has(X86_FEATURE_CLFLUSH) &&
+	    (c->x86_vfm == INTEL_CORE2_DUNNINGTON ||
+	     c->x86_vfm == INTEL_NEHALEM_EX ||
+	     c->x86_vfm == INTEL_WESTMERE_EX))
 		set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
 
-	if (c->x86 == 6 && boot_cpu_has(X86_FEATURE_MWAIT) &&
-		((c->x86_model == INTEL_FAM6_ATOM_GOLDMONT)))
+	if (boot_cpu_has(X86_FEATURE_MWAIT) && c->x86_vfm == INTEL_ATOM_GOLDMONT)
 		set_cpu_bug(c, X86_BUG_MONITOR);
 
 #ifdef CONFIG_X86_64
@@ -1247,9 +1245,9 @@ void handle_bus_lock(struct pt_regs *regs)
  * feature even though they do not enumerate IA32_CORE_CAPABILITIES.
  */
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	0),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,	0),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	0),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,	0),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,	0),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,	0),
 	{}
 };
 
-- 
2.45.0


