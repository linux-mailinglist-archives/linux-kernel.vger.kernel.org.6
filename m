Return-Path: <linux-kernel+bounces-386062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E068B9B3EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9D61F22C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E38D1D5171;
	Mon, 28 Oct 2024 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0Hgd6vs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028C1F8EE8;
	Mon, 28 Oct 2024 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159448; cv=none; b=eET0iMB2eFOZsKZjRN1nvK0mfDa/i9WgejAwzD49i9w6coWViah24JA/zY2Si9C2nPFrklSKZCLsFlldCmz03Ob2ScgtNQ/Mm9f0d+z+DR/5dv8mNbfv/22zgqSbp/pevJMfbiSAsjMtPESHr6r4GuYu3vjENKsjNTkiVHVA0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159448; c=relaxed/simple;
	bh=yj7eOyWQkCOKe5C0f2TpWmsXiQumOyQf2sksJQtsO8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VNgMw0RQPwEhaqgqyDtej0REsC4pYwtZi+VQDh/Lsmzos894fut17PK69CInCwMs4EqPJGenqfViRpWeeHQ2rL9wVK0fgoXPq5TK7cFRW1ujt7lDHW77PcGdDyMYLlmsHHeIHwc2cGs/BVtyDkUnb7hFxfZCn6PjoWzEUlnaQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0Hgd6vs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730159446; x=1761695446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yj7eOyWQkCOKe5C0f2TpWmsXiQumOyQf2sksJQtsO8c=;
  b=N0Hgd6vsi/NuNfuHbVrTXDJTm90JhvHW7IZMgn5leMcr9D7EGYYp9uOe
   +gDoqaSQrHyExwbKRdF/h62q/gU9Vs42ngGlkqfDoJxKM+xGDNriWfhZM
   QYMh5k60b7WVC0gKpMspMGJvceXixLaIjT8vKAoS1sO2veD/1o5YNHpCB
   lhGUxzsH+pi6eWpa28PxIzSbReFD5cu77habSVqDvsKKzmpNW36fxKhBS
   webz9zLlhIukMNgoYLHyI+LsfuHDYGsGAy0Egy0ym2SdhHM1/rGAyxWf+
   Vs/ojz+VU6Cbx+isS1n/Bq17eHib+m4CBu2A7l+Y5Np292kSMajHvdmwp
   g==;
X-CSE-ConnectionGUID: 6IP2mNG/RXioFbJTbZUjtQ==
X-CSE-MsgGUID: AdjWvq5JScqSgHhfTDao6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29987689"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="29987689"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 16:50:45 -0700
X-CSE-ConnectionGUID: YtlnV6grRiGe3srZ9R/0Ag==
X-CSE-MsgGUID: nEx3GQ5gSoaiJCnw5QZWXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86381239"
Received: from salmansi-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.80.18])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 16:50:44 -0700
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
Subject: [PATCH 2/2] x86/bugs: Clean-up verw mitigations
Date: Mon, 28 Oct 2024 16:50:35 -0700
Message-Id: <20992658d2c79f27de91a474a7b122782be5f04b.1730158506.git.daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
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
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/processor.h |   2 +-
 arch/x86/kernel/cpu/bugs.c       | 206 ++++++++++++-------------------
 2 files changed, 81 insertions(+), 127 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4a686f0e5dbf..c855cd1a6d57 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -736,7 +736,7 @@ extern enum l1tf_mitigations l1tf_mitigation;
 
 enum mds_mitigations {
 	MDS_MITIGATION_OFF,
-	MDS_MITIGATION_FULL,
+	MDS_MITIGATION_VERW,
 	MDS_MITIGATION_VMWERV,
 };
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b26b3b554330..bbf3a03435f8 100644
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
@@ -234,32 +233,23 @@ static void x86_amd_ssb_disable(void)
 
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_FULL : MDS_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_VERW : MDS_MITIGATION_OFF;
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
 	[MDS_MITIGATION_OFF]	= "Vulnerable",
-	[MDS_MITIGATION_FULL]	= "Mitigation: Clear CPU buffers",
+	[MDS_MITIGATION_VERW]	= "Mitigation: Clear CPU buffers",
 	[MDS_MITIGATION_VMWERV]	= "Vulnerable: Clear CPU buffers attempted, no microcode",
 };
 
 static void __init mds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		mds_mitigation = MDS_MITIGATION_OFF;
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
+	else if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
+		mds_mitigation = MDS_MITIGATION_VERW;
+	else
+		mds_mitigation = MDS_MITIGATION_VMWERV;
 }
 
 static int __init mds_cmdline(char *str)
@@ -273,9 +263,9 @@ static int __init mds_cmdline(char *str)
 	if (!strcmp(str, "off"))
 		mds_mitigation = MDS_MITIGATION_OFF;
 	else if (!strcmp(str, "full"))
-		mds_mitigation = MDS_MITIGATION_FULL;
+		mds_mitigation = MDS_MITIGATION_VERW;
 	else if (!strcmp(str, "full,nosmt")) {
-		mds_mitigation = MDS_MITIGATION_FULL;
+		mds_mitigation = MDS_MITIGATION_VERW;
 		mds_nosmt = true;
 	}
 
@@ -316,25 +306,12 @@ static void __init taa_select_mitigation(void)
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		taa_mitigation = TAA_MITIGATION_TSX_DISABLED;
 		return;
-	}
-
-	if (cpu_mitigations_off()) {
-		taa_mitigation = TAA_MITIGATION_OFF;
-		return;
-	}
-
-	/*
-	 * TAA mitigation via VERW is turned off if both
-	 * tsx_async_abort=off and mds=off are specified.
-	 */
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    mds_mitigation == MDS_MITIGATION_OFF)
+	} else if (!boot_cpu_has(X86_FEATURE_MD_CLEAR)) {
+		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
 		return;
-
-	if (boot_cpu_has(X86_FEATURE_MD_CLEAR))
+	} else {
 		taa_mitigation = TAA_MITIGATION_VERW;
-	else
-		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
+	}
 
 	/*
 	 * VERW doesn't clear the CPU buffers when MD_CLEAR=1 and MDS_NO=1.
@@ -348,18 +325,6 @@ static void __init taa_select_mitigation(void)
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
 
 static int __init tsx_async_abort_parse_cmdline(char *str)
@@ -405,24 +370,11 @@ static const char * const mmio_strings[] = {
 
 static void __init mmio_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
-	     cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
 	}
 
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
@@ -454,9 +406,6 @@ static void __init mmio_select_mitigation(void)
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 	else
 		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
-
-	if (mmio_nosmt || cpu_mitigations_auto_nosmt())
-		cpu_smt_disable(false);
 }
 
 static int __init mmio_stale_data_parse_cmdline(char *str)
@@ -501,17 +450,12 @@ static const char * const rfds_strings[] = {
 
 static void __init rfds_select_mitigation(void)
 {
-	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
 		rfds_mitigation = RFDS_MITIGATION_OFF;
-		return;
-	}
-	if (rfds_mitigation == RFDS_MITIGATION_OFF)
-		return;
-
-	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
-		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
-	else
+	else if (!(x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR))
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
+	else
+		rfds_mitigation = RFDS_MITIGATION_VERW;
 }
 
 static __init int rfds_parse_cmdline(char *str)
@@ -534,52 +478,12 @@ early_param("reg_file_data_sampling", rfds_parse_cmdline);
 #undef pr_fmt
 #define pr_fmt(fmt)     "" fmt
 
-static void __init md_clear_update_mitigation(void)
+static bool __init cpu_bug_needs_verw(void)
 {
-	if (cpu_mitigations_off())
-		return;
-
-	if (!boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
-		goto out;
-
-	/*
-	 * X86_FEATURE_CLEAR_CPU_BUF is now enabled. Update MDS, TAA and MMIO
-	 * Stale Data mitigation, if necessary.
-	 */
-	if (mds_mitigation == MDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_MDS)) {
-		mds_mitigation = MDS_MITIGATION_FULL;
-		mds_select_mitigation();
-	}
-	if (taa_mitigation == TAA_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_TAA)) {
-		taa_mitigation = TAA_MITIGATION_VERW;
-		taa_select_mitigation();
-	}
-	/*
-	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
-	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
-	 */
-	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
-		mmio_mitigation = MMIO_MITIGATION_VERW;
-		mmio_select_mitigation();
-	}
-	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_RFDS)) {
-		rfds_mitigation = RFDS_MITIGATION_VERW;
-		rfds_select_mitigation();
-	}
-out:
-	if (boot_cpu_has_bug(X86_BUG_MDS))
-		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
-	if (boot_cpu_has_bug(X86_BUG_TAA))
-		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
-	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
-		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
-	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
-		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
-	if (boot_cpu_has_bug(X86_BUG_RFDS))
-		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
+	return boot_cpu_has_bug(X86_BUG_MDS) ||
+	       boot_cpu_has_bug(X86_BUG_TAA) ||
+	       boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
+	       boot_cpu_has_bug(X86_BUG_RFDS);
 }
 
 static void __init verw_mitigations_check(void)
@@ -599,20 +503,70 @@ static void __init verw_mitigations_check(void)
 	}
 }
 
-static void __init md_clear_select_mitigation(void)
+static bool __init verw_mitigations_disabled(void)
 {
 	verw_mitigations_check();
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
+
+static void __init md_clear_select_mitigation(void)
+{
+	if (verw_mitigations_disabled())
+		goto out;
+
+	if (!cpu_bug_needs_verw() || cpu_mitigations_off()) {
+		mds_mitigation = MDS_MITIGATION_OFF;
+		taa_mitigation = TAA_MITIGATION_OFF;
+		mmio_mitigation = MMIO_MITIGATION_OFF;
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+		goto out;
+	}
+
 	mds_select_mitigation();
 	taa_select_mitigation();
-	mmio_select_mitigation();
 	rfds_select_mitigation();
 
+	if (mds_mitigation == MDS_MITIGATION_VERW ||
+	    taa_mitigation == TAA_MITIGATION_VERW ||
+	    rfds_mitigation == RFDS_MITIGATION_VERW)
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+
 	/*
-	 * As these mitigations are inter-related and rely on VERW instruction
-	 * to clear the microarchitural buffers, update and print their status
-	 * after mitigation selection is done for each of these vulnerabilities.
+	 * The MMIO mitigation has a dependency on X86_FEATURE_CLEAR_CPU_BUF so
+	 * this must be called after it gets set
 	 */
-	md_clear_update_mitigation();
+	mmio_select_mitigation();
+
+	if (!boot_cpu_has(X86_BUG_MSBDS_ONLY) &&
+	    (mds_nosmt || cpu_mitigations_auto_nosmt()))
+		cpu_smt_disable(false);
+
+	if (taa_nosmt || mmio_nosmt || cpu_mitigations_auto_nosmt())
+		cpu_smt_disable(false);
+
+out:
+	if (boot_cpu_has_bug(X86_BUG_MDS))
+		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
+	if (boot_cpu_has_bug(X86_BUG_TAA))
+		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
+	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
+		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
+	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
+		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
+	if (boot_cpu_has_bug(X86_BUG_RFDS))
+		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
 }
 
 #undef pr_fmt
@@ -1974,7 +1928,7 @@ void cpu_bugs_smt_update(void)
 	}
 
 	switch (mds_mitigation) {
-	case MDS_MITIGATION_FULL:
+	case MDS_MITIGATION_VERW:
 	case MDS_MITIGATION_VMWERV:
 		if (sched_smt_active() && !boot_cpu_has(X86_BUG_MSBDS_ONLY))
 			pr_warn_once(MDS_MSG_SMT);
-- 
2.25.1


