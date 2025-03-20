Return-Path: <linux-kernel+bounces-570530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC03A6B1C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9048A643A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D915722D4E1;
	Thu, 20 Mar 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DhpbrB7n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4822A7FE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514200; cv=none; b=WmSAAhv4ayqdepEXJmPHvRPVd1v3z+rEmGSl6qbkYnwNbDeEQ0OMCYAad2BFUZh/3fowsArJNUXW6iD87+gGU7l5VU9pVK4qpRF4qbRQ6O0FMZHGCdCtu7LO0c6MMO6biAy1OqyptTXXiBilHxk9Nz7ARdiUByOchVt2Fo44QKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514200; c=relaxed/simple;
	bh=4WdVz2DiTJMi4lJ95AekVUkV4P/HvSpzDdot8HCUWAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/8X06zYweStxEVfVKpqkXJthQcN9nwRjErX7wVFGFsbaQVPoh8VGtAKi9AyKYtNMDCTu05v230kIEeiqYuVJkvOoKdB/KaGJ9VoHZlywfi/J0ZMeXGygerwt+JfatF0pwYt5FcVdvFYRNEVXeyBocgxbKS0jZY0BXIDhragYoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DhpbrB7n; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514198; x=1774050198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4WdVz2DiTJMi4lJ95AekVUkV4P/HvSpzDdot8HCUWAw=;
  b=DhpbrB7n/0RRWIiaP4Ke6vWuFX8COlEm6I5pnxmAh7xrQ+E+g9uecnsa
   gtMniFftbvyC5+iSpsFnYwW47V2OqLkpy6HouI4zYjT1uc8olP1kBaI5a
   tgk06fTrZgt7ACvWS8sdUjODFABx12rx4/ClboMb/3elwlqJy+2agvqSD
   SpseIpWb5rgO5MRjv77+tYn7HWaap/2+13AWDKtaEoCy+hcmcp6Xvo/eN
   jGrSwrd2Xsuv6ZI4A+GGcgMvPVjWQyVpfQKI2pD+Vt/+jtVmIe6qTSUVp
   Y4i/0wIoRzOLZbJY0Z+RT7uwbe2X7YY4Fh8BYzrmR99OcBnKWByHdtaHW
   g==;
X-CSE-ConnectionGUID: NLYXDAMESuKMM0Ph4hgvwA==
X-CSE-MsgGUID: WjAD7JMJQHeTWR0QVc5NSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502598"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502598"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:18 -0700
X-CSE-ConnectionGUID: qniWYAk9SRqM6xSRIb3YaQ==
X-CSE-MsgGUID: hnsvfRm/R3SCyRxNGZV6lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122962977"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2025 16:43:17 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v2 5/9] x86/cpufeatures: Add X86_FEATURE_APX
Date: Thu, 20 Mar 2025 16:42:56 -0700
Message-ID: <20250320234301.8342-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234301.8342-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250320234301.8342-1-chang.seok.bae@intel.com>
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
index 8b7cf13e0acb..51178d4a6308 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -479,6 +479,7 @@
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
+#define X86_FEATURE_APX			(21*32 + 8) /* Advanced Performance Extensions */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index a2fbea0be535..d5e5013e0e9f 100644
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


