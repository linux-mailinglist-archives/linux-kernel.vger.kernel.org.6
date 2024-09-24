Return-Path: <linux-kernel+bounces-337708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B658D984DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14A31C23874
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A31AD419;
	Tue, 24 Sep 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQmAHEfk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601084A2C;
	Tue, 24 Sep 2024 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217130; cv=none; b=WaN/a6QRTy44HpzMT64GcfQfvqUewXjzLIlXX1/q+eBGE3kcWytWqiwKgJJSmPjlsiKsNWRMI1qjsiyPF/PB1m+pQkA6sv6RlnSTpvEE8IYB3E6nRkFdNWAUr3Iy91HUKSG54wnJPW6NP/NhgyPM/5+LRNSEvQ7+skzjbsNO8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217130; c=relaxed/simple;
	bh=v2/J5ptPpvS9K3Oo6tUvptEqsFQ42UvwBeVLEGwbh/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4D3KtSPWf7UA7YNdO3/Z6PBwy8Mnq8Vgrm0x9ZHewreDCkfPn8xuNtXqel22VhkPFEhyOAjKaHya88dru8JoFChixk9WV3YVTr2c+WQoCZxxIzFeYLoFLumtFG33CEISp99gLO7sVnXyDxotHmsgkMCCXDumsqG8jVUCi66oyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQmAHEfk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727217129; x=1758753129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v2/J5ptPpvS9K3Oo6tUvptEqsFQ42UvwBeVLEGwbh/Y=;
  b=VQmAHEfkpNPTl8XaaJVuhFKsJWUsEV5H4ORRKxjgWIqZCM28JGN7AaKb
   o8XUlUQ4Z8r7hQlH1MV1xDZ0ZxQ+P5hB/afaiQ9pY4D6re/SCmE2sby2t
   GRltORpi5IoEwrMO4OHLsVARQ1cpXjpqpsYyA+RnMSFScuX4q2NHkL+6v
   map6UCHo3RZkdPuKOVc+4QDXsRb3NFTtgVXJM1LGaASxYlCndiQEP50Z3
   fORtuZ9nyq9Ijh13UaPrso32o+uqb4M87vdkiGc7giPKPQNzQS4aulgow
   zdroeSfSLDyQMceUHsegsBcFWZTyPEpC13mS0vL1Y1q0uqJfNVpBaU32L
   A==;
X-CSE-ConnectionGUID: vimuY2HcSKutEg/x9hQ/Rg==
X-CSE-MsgGUID: TFxf1zcYQEmUSOm1ppaUkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36908099"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="36908099"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:32:00 -0700
X-CSE-ConnectionGUID: GAGHdPveQbiJEuWn7PZVLQ==
X-CSE-MsgGUID: XsFlc0n4QXGy0/c4sCM1Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="102384854"
Received: from laijusti-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.17.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 15:31:58 -0700
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH 6/6] x86/bugs: Clean-up verw mitigations
Date: Tue, 24 Sep 2024 15:31:40 -0700
Message-Id: <20240924223140.1054918-7-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
References: <20240924223140.1054918-1-daniel.sneddon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current md_clear routines duplicate a lot of code, and have to be
called twice because if one of the mitigations gets enabled they all
get enabled since it's the same instruction. This approach leads to
code duplication and extra complexity.

The only piece that really changes between the first call of
*_select_mitigation() and the second is X86_FEATURE_CLEAR_CPU_BUF
being set.  Determine if this feature should be set prior to calling
the _select_mitigation() routines. This not only means those functions
only get called once, but it also simplifies them as well.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 191 +++++++++++++++----------------------
 1 file changed, 77 insertions(+), 114 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 45411880481c..412855391184 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -41,7 +41,6 @@ static void __init spectre_v2_user_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
 static void __init l1tf_select_mitigation(void);
 static void __init mds_select_mitigation(void);
-static void __init md_clear_update_mitigation(void);
 static void __init md_clear_select_mitigation(void);
 static void __init taa_select_mitigation(void);
 static void __init mmio_select_mitigation(void);
@@ -244,21 +243,9 @@ static const char * const mds_strings[] = {
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
-		mds_mitigation = MDS_MITIGATION_OFF;
-		return;
-	}
-
-	if (mds_mitigation == MDS_MITIGATION_FULL) {
-		if (!boot_cpu_has(X86_FEATURE_MD_CLEAR))
-			mds_mitigation = MDS_MITIGATION_VMWERV;
-
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
-
-		if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
-		    (mds_nosmt || cpu_mitigations_auto_nosmt()))
-			cpu_smt_disable(false);
-	}
+	if (mds_mitigation == MDS_MITIGATION_FULL &&
+	    !boot_cpu_has(X86_FEATURE_MD_CLEAR))
+		mds_mitigation = MDS_MITIGATION_VMWERV;
 }
 
 #undef pr_fmt
@@ -284,35 +271,17 @@ static const char * const taa_strings[] = {
 
 static void __init taa_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_TAA)) {
-		taa_mitigation = TAA_MITIGATION_OFF;
-		return;
-	}
-
 	/* TSX previously disabled by tsx=off */
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		taa_mitigation = TAA_MITIGATION_TSX_DISABLED;
 		return;
 	}
 
-	if (cpu_mitigations_off()) {
-		taa_mitigation = TAA_MITIGATION_OFF;
+	if (!boot_cpu_has(X86_FEATURE_MD_CLEAR)) {
+		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
 		return;
 	}
 
-	/*
-	 * TAA mitigation via VERW is turned off if both
-	 * tsx_async_abort=off and mds=off are specified.
-	 */
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    mds_mitigation == MDS_MITIGATION_OFF)
-		return;
-
-	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
-		taa_mitigation = TAA_MITIGATION_VERW;
-	else
-		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
-
 	/*
 	 * VERW doesn't clear the CPU buffers when MD_CLEAR=1 and MDS_NO=1.
 	 * A microcode update fixes this behavior to clear CPU buffers. It also
@@ -325,18 +294,6 @@ static void __init taa_select_mitigation(void)
 	if ( (x86_arch_cap_msr & ARCH_CAP_MDS_NO) &&
 	    !(x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR))
 		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
-
-	/*
-	 * TSX is enabled, select alternate mitigation for TAA which is
-	 * the same as MDS. Enable MDS static branch to clear CPU buffers.
-	 *
-	 * For guests that can't determine whether the correct microcode is
-	 * present on host, enable the mitigation for UCODE_NEEDED as well.
-	 */
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
-
-	if (taa_nosmt || cpu_mitigations_auto_nosmt())
-		cpu_smt_disable(false);
 }
 
 #undef pr_fmt
@@ -360,24 +317,6 @@ static const char * const mmio_strings[] = {
 
 static void __init mmio_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
-	     cpu_mitigations_off()) {
-		mmio_mitigation = MMIO_MITIGATION_OFF;
-		return;
-	}
-
-	if (mmio_mitigation == MMIO_MITIGATION_OFF)
-		return;
-
-	/*
-	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
-	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
-	 */
-	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
-					      boot_cpu_has(X86_FEATURE_RTM)))
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
-
 	/*
 	 * X86_FEATURE_CLEAR_CPU_BUF could be enabled by other VERW based
 	 * mitigations, disable KVM-only mitigation in that case.
@@ -409,9 +348,6 @@ static void __init mmio_select_mitigation(void)
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 	else
 		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
-
-	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
-		cpu_smt_disable(false);
 }
 
 #undef pr_fmt
@@ -435,16 +371,7 @@ static const char * const rfds_strings[] = {
 
 static void __init rfds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
-		rfds_mitigation = RFDS_MITIGATION_OFF;
-		return;
-	}
-	if (rfds_mitigation == RFDS_MITIGATION_OFF)
-		return;
-
-	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
-	else
+	if (!(x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR))
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
 }
 
@@ -485,41 +412,92 @@ static int __init clear_cpu_buffers_cmdline(char *str)
 }
 early_param("clear_cpu_buffers", clear_cpu_buffers_cmdline);
 
-static void __init md_clear_update_mitigation(void)
+static bool __init cpu_bug_needs_verw(void)
 {
-	if (cpu_mitigations_off())
-		return;
+	return boot_cpu_has_bug(X86_BUG_MDS) ||
+	       boot_cpu_has_bug(X86_BUG_TAA) ||
+	       boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
+	       boot_cpu_has_bug(X86_BUG_RFDS);
+}
 
-	if (!boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
-		goto out;
+static bool __init verw_mitigations_disabled(void)
+{
+	/*
+	 * TODO: Create a single mitigation variable that will allow for setting
+	 * the location of the mitigation, i.e.:
+	 *
+	 * kernel->user
+	 * kvm->guest
+	 * kvm->guest if device passthrough
+	 * kernel->idle
+	 */
+	return (mds_mitigation == MDS_MITIGATION_OFF &&
+		taa_mitigation == TAA_MITIGATION_OFF &&
+		mmio_mitigation == MMIO_MITIGATION_OFF &&
+		rfds_mitigation == RFDS_MITIGATION_OFF);
+}
 
+static void __init md_clear_select_mitigation(void)
+{
 	/*
-	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
-	 * Stale Data mitigation, if necessary.
+	 * If no CPU bug needs VERW, all VERW mitigations are disabled, or all
+	 * mitigations are disabled we bail.
 	 */
-	if (mds_mitigation == MDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_MDS)) {
+	if (!cpu_bug_needs_verw() || verw_mitigations_disabled() ||
+	    cpu_mitigations_off()) {
+		mds_mitigation = MDS_MITIGATION_OFF;
+		taa_mitigation = TAA_MITIGATION_OFF;
+		mmio_mitigation = MMIO_MITIGATION_OFF;
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+		goto out;
+	}
+
+	/* Check that at least one mitigation is using the verw mitigaiton.
+	 * If the cpu doesn't have the correct ucode or if the BUG_* is mitigated
+	 * by disabling a feature we won't want to use verw. Ignore MMIO
+	 * for now since it depends on what the others choose.
+	 */
+
+	if (boot_cpu_has_bug(X86_BUG_MDS)) {
 		mds_mitigation = MDS_MITIGATION_FULL;
 		mds_select_mitigation();
+	}  else {
+		mds_mitigation = MDS_MITIGATION_OFF;
 	}
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_TAA)) {
+	if (boot_cpu_has_bug(X86_BUG_TAA)) {
 		taa_mitigation = TAA_MITIGATION_VERW;
 		taa_select_mitigation();
+	} else {
+		taa_mitigation = TAA_MITIGATION_OFF;
 	}
-	/*
-	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
-	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
-	 */
+	if (boot_cpu_has_bug(X86_BUG_RFDS)) {
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+		rfds_select_mitigation();
+	} else {
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+	}
+
+	if (mds_mitigation == MDS_MITIGATION_FULL ||
+	    taa_mitigation == TAA_MITIGATION_VERW ||
+	    rfds_mitigation == RFDS_MITIGATION_VERW)
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+
+	/* Now handle MMIO since it may not use X86_FEATURE_CLEAR_CPU_BUF */
 	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 		mmio_select_mitigation();
+	} else {
+		mmio_mitigation = MMIO_MITIGATION_OFF;
 	}
-	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_RFDS)) {
-		rfds_mitigation = RFDS_MITIGATION_VERW;
-		rfds_select_mitigation();
-	}
+
+	/* handle nosmt */
+	if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
+	    (mds_nosmt || cpu_mitigations_auto_nosmt()))
+		cpu_smt_disable(false);
+
+	if (taa_nosmt || mmio_nosmt || cpu_mitigations_auto_nosmt())
+		cpu_smt_disable(false);
+
 out:
 	if (boot_cpu_has_bug(X86_BUG_MDS))
 		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
@@ -533,21 +511,6 @@ static void __init md_clear_update_mitigation(void)
 		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
 }
 
-static void __init md_clear_select_mitigation(void)
-{
-	mds_select_mitigation();
-	taa_select_mitigation();
-	mmio_select_mitigation();
-	rfds_select_mitigation();
-
-	/*
-	 * As these mitigations are inter-related and rely on VERW instruction
-	 * to clear the microarchitural buffers, update and print their status
-	 * after mitigation selection is done for each of these vulnerabilities.
-	 */
-	md_clear_update_mitigation();
-}
-
 #undef pr_fmt
 #define pr_fmt(fmt)	"SRBDS: " fmt
 
-- 
2.25.1


