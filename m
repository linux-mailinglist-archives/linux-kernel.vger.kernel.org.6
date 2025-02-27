Return-Path: <linux-kernel+bounces-537104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81FEA48816
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40FB168B32
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644C26E946;
	Thu, 27 Feb 2025 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAfcam4Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26726E164
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681913; cv=none; b=BpKzF3f+rO2UeROOAh0nnpArsGrImy5CJQXzmeEpZr98TKIkGdHJa73Zas+bPkO0Ykl97yX1Y4P3iEA3mieKstRgh0VlTt61F0Jg0G9VZjFYvBfSzMX53G/quszqFVjsvfDQwLT54DszHOQ/b6Kdi/OZdPTEKwNXidw+2gjKEqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681913; c=relaxed/simple;
	bh=Ttb0stKkHrz//TRHFoP47ogiPUYTJSc9VP0jS2S74tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPRLrpax8pv03PABPGKgq0pJ+gItgXSd7N8pEcopaFCyPzHwVp/oCSmCclY35RYZpIyKcniTbIx/lNZ9Qi/EF2rKVphm0Xwbg7i2F4aQYr0JMggGhOI92twNBqqbXlvFR2QwVtSCs5WwuvM5J6B7X2jeu8oDqZ2SstYcDPHfrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAfcam4Y; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681912; x=1772217912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ttb0stKkHrz//TRHFoP47ogiPUYTJSc9VP0jS2S74tw=;
  b=KAfcam4Ykx4k+ZfC40NsFT6dsgVE/HUI+ubEv0aNxDqI2E+2o5oKTzU8
   z8cB1bMzKyRdO/CM7mRmXUSa42PgzrRb2Sen1UhhYPfiYb3pAKIvg4Lb/
   ZgLPn1ytP3mP6AyL+MuzUvnz7KoPCMMZcsBndVJszTa/btkqA2uQkwTN3
   RURR98F/AEeCn4DRDWn2UoTDVAM44NrZYtGsJvkILrDUmvTzMOGFX7ixY
   wFN3G0viEZYolPBosyLgTdOgYmjTpjfGfRAJ7QlRkeU2oPVhZrI/cBYAJ
   nAZKsam3hQ1qvLnYPUnZpPdLEJCDn1zYoj7vJm8/FLLSctazKx6h0tNaR
   Q==;
X-CSE-ConnectionGUID: 93VtB3Z8RISA10DYIspvOw==
X-CSE-MsgGUID: JwOG2sHqT5Gu2OqAa3uqSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720898"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720898"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:11 -0800
X-CSE-ConnectionGUID: ifDXZUN0SO+N9UFcLhmyGg==
X-CSE-MsgGUID: iqrI5RlOS+CYu+08fuRxjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767420"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:10 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 07/11] x86/cpufeatures: Add X86_FEATURE_APX
Date: Thu, 27 Feb 2025 10:44:52 -0800
Message-ID: <20250227184502.10288-8-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227184502.10288-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Advanced Performance Extensions (APX) introduce a new set of
general-purpose registers, managed as an extended state component via the
xstate management facility.

Before enabling this new xstate, define a feature flag to clarify the
dependency in xsave_cpuid_features[]. APX is enumerated under CPUID level
7 with EDX=1. Since this CPUID leaf is not yet allocated, place the flag
in a scattered feature word.

While this feature is intended only for userspace, exposing it via
/proc/cpuinfo is unnecessary. Instead, the existing arch_prctl(2)
mechanism with the ARCH_GET_XCOMP_SUPP option can be used to query the
feature availability.

Finally, clarify that APX depends on XSAVE.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Allocating a new feature word for this bit seems excessive at this stage,
given that no other imminent features are quite known.
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 508c0dad116b..4f96515af7c3 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -483,6 +483,7 @@
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
+#define X86_FEATURE_APX			(21*32 + 8) /* Advanced Performance Extensions */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index df838e3bdbe0..44ab6baeec42 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -84,6 +84,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
+	{ X86_FEATURE_APX,			X86_FEATURE_XSAVE     },
 	{}
 };
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 16f3ca30626a..6c40d5af8479 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -54,6 +54,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_HETEROGENEOUS_CORES,	CPUID_EAX, 30, 0x80000026, 0 },
+	{ X86_FEATURE_APX,			CPUID_EDX, 21, 0x00000007, 1 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.45.2


