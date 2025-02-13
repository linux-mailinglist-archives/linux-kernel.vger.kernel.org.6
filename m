Return-Path: <linux-kernel+bounces-513932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1111A35067
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91452188FABE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8D24BC0B;
	Thu, 13 Feb 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eae9KOEw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB6266B78
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481425; cv=none; b=uM+12UDK91TwQfrcx9Ho5Q+dMDCxf8e6CWFqmEIBiVDKLOLd2DLyY1smadH3pgdlctygzFMm5DYxHRZy1tPO3nwhmyXt9mH6TA4AS1TB/0uX8+ZIyTE+v4N0M1MJcDrKYxdatM+ouE2AZhcN4fhvwmWdB5G7X+WUC/TC4jYCOoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481425; c=relaxed/simple;
	bh=lEmnA3tIju3nmgAlg2whcVPWZoz5WM4KKLlKQAyXktk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3hvvJgVX4cH+j4/d4/Futqa9aoRRbp6c2I5xwXvAGhrK+0H8nKrPkvPhEdkHsCmvz+zGuliHEaMqBBZ8xuhjRvFPhbOriyo51shbCsOT1UDfNZwmOWkG8HIIIrUTu5h3HFrYuYT8IOkWlZ6+vFMqgi0XpCfdHrLn4YvNwtzXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eae9KOEw; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739481423; x=1771017423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEmnA3tIju3nmgAlg2whcVPWZoz5WM4KKLlKQAyXktk=;
  b=eae9KOEwcpEagLeIqnchQRS2/I/gBn0yQvB93bEfEBmwW5kPcFRouuqU
   lhPcbkF4CKEfGE2sQl8QO3vOLfXZ2TKvBMRb7R88k5raFW8J3VSxE2DTO
   9Prr72VlklKWgiPvyWf7kNCEuvNUFIqej+g/FKNuCqu9n51/lOcEK2YHF
   ujcwBQgAighbut79pUsVYd6YBg2PABiY69DuZUOgR3mxuT++Rnwh1GV1y
   FBuCn9i/4iDdiMWtsYUN3zCdTe3QDNLsa7lK8Nm/pvGaU1SaGs9U9ZTh1
   arCe2KW8V2nCi1lrbvcNuQqx3q+56fQ24mYZ/ZomU8wtnSNgNrdjU/DpU
   g==;
X-CSE-ConnectionGUID: NMHxb1YWTBK1YmiMhJsmMQ==
X-CSE-MsgGUID: washyBzlSvGW8LXbpZzqOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44142411"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44142411"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 13:16:59 -0800
X-CSE-ConnectionGUID: sMhnifXkRCez11IiwOOQlg==
X-CSE-MsgGUID: xTdfmlCYQluLs3yW2+Px+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118469503"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 13 Feb 2025 13:16:59 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 4/5] perf/x86/intel: Add CPUID enumeration for the auto counter reload
Date: Thu, 13 Feb 2025 13:17:17 -0800
Message-Id: <20250213211718.2406744-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250213211718.2406744-1-kan.liang@linux.intel.com>
References: <20250213211718.2406744-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The counters that support the auto counter reload feature can be
enumerated in the CPUID Leaf 0x23 sub-leaf 0x2.

Add acr_cntr_mask to store the mask of counters which are reloadable.
Add acr_cause_mask to store the mask of counters which can cause reload.
Since the e-core and p-core may have different numbers of counters,
track the masks in the struct x86_hybrid_pmu as well.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 10 ++++++++++
 arch/x86/events/perf_event.h      | 17 +++++++++++++++++
 arch/x86/include/asm/perf_event.h |  1 +
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ce04553910ab..8e3ad9efd798 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5075,6 +5075,16 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 		pmu->fixed_cntr_mask64 = fixed_cntr;
 	}
 
+	if (eax.split.acr_subleaf) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
+			    &cntr, &fixed_cntr, &ecx, &edx);
+		/* The mask of the counters which can be reloaded */
+		pmu->acr_cntr_mask64 = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
+
+		/* The mask of the counters which can cause a reload of reloadable counters */
+		pmu->acr_cause_mask64 = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
+	}
+
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5bf9c117e9ef..2184ae0c9a4a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -725,6 +725,15 @@ struct x86_hybrid_pmu {
 			u64		fixed_cntr_mask64;
 			unsigned long	fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	};
+
+	union {
+			u64		acr_cntr_mask64;
+			unsigned long	acr_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
+	union {
+			u64		acr_cause_mask64;
+			unsigned long	acr_cause_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
 	struct event_constraint		unconstrained;
 
 	u64				hw_cache_event_ids
@@ -823,6 +832,14 @@ struct x86_pmu {
 			u64		fixed_cntr_mask64;
 			unsigned long	fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	};
+	union {
+			u64		acr_cntr_mask64;
+			unsigned long	acr_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
+	union {
+			u64		acr_cause_mask64;
+			unsigned long	acr_cause_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
 	int		cntval_bits;
 	u64		cntval_mask;
 	union {
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index eaf0d5245999..5b7a84254ee5 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -195,6 +195,7 @@ union cpuid10_edx {
  */
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
+#define ARCH_PERFMON_ACR_LEAF			0x2
 
 union cpuid35_eax {
 	struct {
-- 
2.38.1


