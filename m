Return-Path: <linux-kernel+bounces-513939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD916A35073
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52766188FC51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012952661BE;
	Thu, 13 Feb 2025 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IWJpYHTG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA8266194
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481879; cv=none; b=Q0ABX0rY2Op2zCfRPz9pwbvWa9zM/sunDXJUMKmVKiMrd4ct4Q8DjhUdYQQspxQaz/uSPYZTcpan7TvP5BHZU0kma17KxJCh7HRagxAFHt3yXIzfnYaOfjI6HGtR3QM25xXz1XiNfwCoEgPAfTOsGimFqnRzkFKhxAiUkWEWa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481879; c=relaxed/simple;
	bh=pUzgfA7W7491Ugjo4Ip3TySm8TZnt0igo9Y5DzkI224=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zd9i2F/WMt4JweN7X0U2qO8uDNMiNS0Kh7fn1Tf+F2TpJzLscOK94RJXpeYOfHgVYuW3uxA3tBHGz9QqMJgOE4qNM4BFwAeDrX9zLt8Gynk6F4bbi2+N5Qq2uunRhcBYz40jHZftnUMIUVwlzSt5PMqAuHrtuZtwB09nIb8tiMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IWJpYHTG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739481878; x=1771017878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pUzgfA7W7491Ugjo4Ip3TySm8TZnt0igo9Y5DzkI224=;
  b=IWJpYHTGm1KY787ALDwnD6RlVtoFYr4YhDJ//R0XdVrW9Gl9fWUv2BkY
   pYwykYh7Z20qcqLNr7xlphDLnou8gPX7qpvFZ09GhS6Am5ddfmYQL+ztD
   U8bvtjw9k/g+PRPE/i0qMd7M4M+wXTZ7C+Hasq5cs6i1Q9vLmLO9a32u5
   bQCoUW3J4zoSQEVWa2vSmzV2w1cerXqG1XgWHdPdlrRa/mrMiase4rPF1
   opl81Tccn4xoFCQU+MhRdurjGuluUVxtrzZuxaig9ZZIgmsCdR25x51/4
   nzN5ye/eaH6NqCC0MtDLHGht06l3Am0Ze4Bi9we//keoam9QNYYKIv6AN
   g==;
X-CSE-ConnectionGUID: OQHnag28QCOx/BRAT11s+g==
X-CSE-MsgGUID: mHztwhI3Rm6TFRcPDt3wTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51643479"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51643479"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 13:24:37 -0800
X-CSE-ConnectionGUID: U6737uRIRzylEfEarp+hrg==
X-CSE-MsgGUID: kUMbJ2ovSpandGkutY9auQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113135713"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 13 Feb 2025 13:24:36 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	srinivas.pandruvada@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH] perf/x86/msr: Make SMI and PPERF on by default
Date: Thu, 13 Feb 2025 13:24:53 -0800
Message-Id: <20250213212453.2406942-1-kan.liang@linux.intel.com>
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


