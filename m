Return-Path: <linux-kernel+bounces-323786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870BD974376
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA54E1C249E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42991A4F03;
	Tue, 10 Sep 2024 19:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGH3mie/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD491A2567
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996360; cv=none; b=MPObPhWOb+Fnv3uULJcLBAPU9Fki0AGnL0Yf2+s/EEAQkoq7OQI8ls1z5+TstWM7YO75Grz7+DoyoHyC7s2H8C+nwX4OFeM/O6pSe4s5LLtp9vPr7Ko2os58qhpZb6FT6ue3f6bofm8a5f+Q2fXgg3hl15Wqc0PS31L8pRvGYhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996360; c=relaxed/simple;
	bh=pUzgfA7W7491Ugjo4Ip3TySm8TZnt0igo9Y5DzkI224=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ThYno/AZdMVADEEOobKF/8U1JYpnTogvmtqkEhxB9WOqs0upki0d/CkEIYY3bHHYy0KfsZbnjkXkg/hbfEg905CdO1MNkI12oQQrY1INTzweR0OTCiwEnJABw2Vv4FNIx/v1rbZI2M3/qqyvfyxyYQVxnkovxHo7CqzUDG2nFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGH3mie/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725996358; x=1757532358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pUzgfA7W7491Ugjo4Ip3TySm8TZnt0igo9Y5DzkI224=;
  b=UGH3mie/gRFWvNsX8/DBSozpRhViDpHZRPj2kL6tmzEileIScLoYTMnN
   ly9C3+TwGpuqtERE8fLr9Q+PNsslBFKBwGwRMsvSwHvzAYofIm25hc6yW
   PSC2Iho+G9h4p4KxtFrTq+ykTev1m0DbmB+asXYmLRfABnfRLohNivsBJ
   3W33mQdrsJmjsLwQjcCW70ioUvhPoKOL8/Qk7xi6g1EvCt5lzoRp1Rh2o
   SndQGcgkn3SSYJql/1/wGWiIQ7azl5OHdbgORXIVhfkw1870qPBOWNMSG
   6Nn7iPv5cjIKQe+6JJDT7sRV0aX4JtDqBIabCE8JtbmF+Lox5guU5hBl2
   w==;
X-CSE-ConnectionGUID: jSgXY3oqSYWjezNissSsQg==
X-CSE-MsgGUID: EH9Y4VceS/OzoD5X9lP17g==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24588888"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="24588888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 12:25:58 -0700
X-CSE-ConnectionGUID: klMgL1NYQtyW8tyIKfLycA==
X-CSE-MsgGUID: VEdMXkAsSfWp+gMt8MMXZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="67423971"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa006.jf.intel.com with ESMTP; 10 Sep 2024 12:25:58 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: srinivas.pandruvada@intel.com,
	ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/msr: Make SMI and PPERF on by default
Date: Tue, 10 Sep 2024 12:26:26 -0700
Message-Id: <20240910192626.768146-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The MSRs, SMI_COUNT and PPERF, are model-specific MSRs. A very long
CPU ID list is maintained to indicate the supported platforms. With more
and more platforms being introduced, new CPU IDs have to be kept adding.
Also, the old kernel has to be updated to apply the new CPU ID.

The MSRs have been introduced for a long time. There is no plan to
change them in the near future. Furthermore, the current code utilizes
rdmsr_safe() to check the availability of MSRs before using it.

Make them on by default. It should be good enough to only rely on the
rdmsr_safe() to check their availability for both existing and future
platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/msr.c | 80 ++-----------------------------------------
 1 file changed, 3 insertions(+), 77 deletions(-)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 45b1866ff051..7659d145d01b 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -39,85 +39,11 @@ static bool test_therm_status(int idx, void *data)
 
 static bool test_intel(int idx, void *data)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
-	    boot_cpu_data.x86 != 6)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return false;
 
-	switch (boot_cpu_data.x86_vfm) {
-	case INTEL_NEHALEM:
-	case INTEL_NEHALEM_G:
-	case INTEL_NEHALEM_EP:
-	case INTEL_NEHALEM_EX:
-
-	case INTEL_WESTMERE:
-	case INTEL_WESTMERE_EP:
-	case INTEL_WESTMERE_EX:
-
-	case INTEL_SANDYBRIDGE:
-	case INTEL_SANDYBRIDGE_X:
-
-	case INTEL_IVYBRIDGE:
-	case INTEL_IVYBRIDGE_X:
-
-	case INTEL_HASWELL:
-	case INTEL_HASWELL_X:
-	case INTEL_HASWELL_L:
-	case INTEL_HASWELL_G:
-
-	case INTEL_BROADWELL:
-	case INTEL_BROADWELL_D:
-	case INTEL_BROADWELL_G:
-	case INTEL_BROADWELL_X:
-	case INTEL_SAPPHIRERAPIDS_X:
-	case INTEL_EMERALDRAPIDS_X:
-	case INTEL_GRANITERAPIDS_X:
-	case INTEL_GRANITERAPIDS_D:
-
-	case INTEL_ATOM_SILVERMONT:
-	case INTEL_ATOM_SILVERMONT_D:
-	case INTEL_ATOM_AIRMONT:
-
-	case INTEL_ATOM_GOLDMONT:
-	case INTEL_ATOM_GOLDMONT_D:
-	case INTEL_ATOM_GOLDMONT_PLUS:
-	case INTEL_ATOM_TREMONT_D:
-	case INTEL_ATOM_TREMONT:
-	case INTEL_ATOM_TREMONT_L:
-
-	case INTEL_XEON_PHI_KNL:
-	case INTEL_XEON_PHI_KNM:
-		if (idx == PERF_MSR_SMI)
-			return true;
-		break;
-
-	case INTEL_SKYLAKE_L:
-	case INTEL_SKYLAKE:
-	case INTEL_SKYLAKE_X:
-	case INTEL_KABYLAKE_L:
-	case INTEL_KABYLAKE:
-	case INTEL_COMETLAKE_L:
-	case INTEL_COMETLAKE:
-	case INTEL_ICELAKE_L:
-	case INTEL_ICELAKE:
-	case INTEL_ICELAKE_X:
-	case INTEL_ICELAKE_D:
-	case INTEL_TIGERLAKE_L:
-	case INTEL_TIGERLAKE:
-	case INTEL_ROCKETLAKE:
-	case INTEL_ALDERLAKE:
-	case INTEL_ALDERLAKE_L:
-	case INTEL_ATOM_GRACEMONT:
-	case INTEL_RAPTORLAKE:
-	case INTEL_RAPTORLAKE_P:
-	case INTEL_RAPTORLAKE_S:
-	case INTEL_METEORLAKE:
-	case INTEL_METEORLAKE_L:
-		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
-			return true;
-		break;
-	}
-
-	return false;
+	/* Rely on perf_msr_probe() to check the availability */
+	return true;
 }
 
 PMU_EVENT_ATTR_STRING(tsc,				attr_tsc,		"event=0x00"	);
-- 
2.38.1


