Return-Path: <linux-kernel+bounces-445378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1459F1540
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63412846DF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C402C1EC4E8;
	Fri, 13 Dec 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLix1Tsu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46A1E8854
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115893; cv=none; b=l0rcckD57dEbK62iVrilSPWntDE7SSRFx0jQlInEnbJ4wdvLTWry/3EyNV6mcL1BscLx+QbqUdgy9eW3HzHQukUOu93lzz+42Y1ervEwToqEqV+L90fst+woiLjWflMvtZOiz5b9QXN5JyuIRGtuV7z415+eZkJFoyWCr+WjLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115893; c=relaxed/simple;
	bh=gnQVaibsBIWn3qCwAxvX6po7krur5TcnC6Rz+Fw7UR8=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=QrYrcsL2OZdNFYWj8nZ0gL3ecML6Ei52an6iSRb9kMxNmSLf3Luq0hs5tsv+6X2OfLb7n9t0wE3tnDkWfpnxvsNayLOXnRmSRabnRURUESMCDVvf/w73nrUiIVGbBZ78Xf6Mt0u6MIw0DB4E4I01Kw9eaeMUdv6G4Iuw84OGsBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLix1Tsu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734115892; x=1765651892;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=gnQVaibsBIWn3qCwAxvX6po7krur5TcnC6Rz+Fw7UR8=;
  b=ZLix1TsuxaY27Qmg/18MsnOQr+tMhcugGug2yVCX0OePATeIAnCmz5ft
   wquzyV36ipjYG3fMiXu0Y05WSs1IiDkeqBmr5x0O8QLX6li1XITKEkv+d
   fnv2JHnk7w9tUOnVUMPMQf9TBKqGxGLGyiKpP3hN9Uwm5/7n898Z9SZTJ
   bNOaxFXtc6W0dvwn4NEoIdeS8Qlt8eCYQCMrrPh8dFf1zmKukFoU9LjHZ
   cohuS817CvRAGpfk0b9HKioW0s81vWQYYFAvquVTDvFOkFNrO1dxs+Qzu
   Dzzif3tx/HvmMgJ+NierPV+FVfHp9Xc3oF4jYGnfQYeYQGduV4/aQDSEO
   A==;
X-CSE-ConnectionGUID: iwbQTpglS7uKM/Ua2D8wmw==
X-CSE-MsgGUID: YBp4sWgSRaCtjW8x7U1VJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34487443"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34487443"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 10:51:32 -0800
X-CSE-ConnectionGUID: FV3K9HNbRfWREo8WJcD9jQ==
X-CSE-MsgGUID: p1b17C9VS36fTqLpn+Q2WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96478763"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 10:51:32 -0800
Subject: [v2][PATCH 3/5] x86/cpu: Replace PEBS use of 'x86_cpu_desc' use with 'x86_cpu_id'
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 10:51:31 -0800
References: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
Message-Id: <20241213185131.8B610039@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The 'x86_cpu_desc' and 'x86_cpu_id' structures are very similar.
Reduce duplicate infrastructure by moving the few users of
'x86_cpu_desc' to the much more common variant.

The existing X86_MATCH_VFM_STEPS() helper matches ranges of
steppings. Instead of introducing a single-stepping match function
which could get confusing when paired with the range, just use
the stepping min/max match helper and use min==max.

Note that this makes the table more vertically compact because
multiple entries like this:

       INTEL_CPU_DESC(INTEL_SKYLAKE_X,          4, 0x00000000),
       INTEL_CPU_DESC(INTEL_SKYLAKE_X,          5, 0x00000000),
       INTEL_CPU_DESC(INTEL_SKYLAKE_X,          6, 0x00000000),
       INTEL_CPU_DESC(INTEL_SKYLAKE_X,          7, 0x00000000),

can be consolidated down to a single stepping range.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/events/intel/core.c |   62 +++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff -puN arch/x86/events/intel/core.c~zap-x86_cpu_desc arch/x86/events/intel/core.c
--- a/arch/x86/events/intel/core.c~zap-x86_cpu_desc	2024-12-13 10:47:46.965723323 -0800
+++ b/arch/x86/events/intel/core.c	2024-12-13 10:47:46.969723484 -0800
@@ -5371,42 +5371,32 @@ static __init void intel_clovertown_quir
 	x86_pmu.pebs_constraints = NULL;
 }
 
-static const struct x86_cpu_desc isolation_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_HASWELL,		 3, 0x0000001f),
-	INTEL_CPU_DESC(INTEL_HASWELL_L,		 1, 0x0000001e),
-	INTEL_CPU_DESC(INTEL_HASWELL_G,		 1, 0x00000015),
-	INTEL_CPU_DESC(INTEL_HASWELL_X,		 2, 0x00000037),
-	INTEL_CPU_DESC(INTEL_HASWELL_X,		 4, 0x0000000a),
-	INTEL_CPU_DESC(INTEL_BROADWELL,		 4, 0x00000023),
-	INTEL_CPU_DESC(INTEL_BROADWELL_G,	 1, 0x00000014),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 2, 0x00000010),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 3, 0x07000009),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 4, 0x0f000009),
-	INTEL_CPU_DESC(INTEL_BROADWELL_D,	 5, 0x0e000002),
-	INTEL_CPU_DESC(INTEL_BROADWELL_X,	 1, 0x0b000014),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 3, 0x00000021),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 4, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 5, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 6, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		 7, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_X,		11, 0x00000000),
-	INTEL_CPU_DESC(INTEL_SKYLAKE_L,		 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_SKYLAKE,		 3, 0x0000007c),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE_L,	12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		12, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_KABYLAKE,		13, 0x0000004e),
+static const struct x86_cpu_id isolation_ucodes[] = {
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL,	 3,  3, 0x0000001f),
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_L,	 1,  1, 0x0000001e),
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_G,	 1,  1, 0x00000015),
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_X,	 2,  2, 0x00000037),
+	X86_MATCH_VFM_STEPS(INTEL_HASWELL_X,	 4,  4, 0x0000000a),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL,	 4,  4, 0x00000023),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_G,	 1,  1, 0x00000014),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D,	 2,  2, 0x00000010),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D,	 3,  3, 0x07000009),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D,	 4,  4, 0x0f000009),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_D,	 5,  5, 0x0e000002),
+	X86_MATCH_VFM_STEPS(INTEL_BROADWELL_X,	 1,  1, 0x0b000014),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,	 3,  3, 0x00000021),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,	 4,  7, 0x00000000),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_X,	11, 11, 0x00000000),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE_L,	 3,  3, 0x0000007c),
+	X86_MATCH_VFM_STEPS(INTEL_SKYLAKE,	 3,  3, 0x0000007c),
+	X86_MATCH_VFM_STEPS(INTEL_KABYLAKE,	 9, 13, 0x0000004e),
+	X86_MATCH_VFM_STEPS(INTEL_KABYLAKE_L,	 9, 12, 0x0000004e),
 	{}
 };
 
 static void intel_check_pebs_isolation(void)
 {
-	x86_pmu.pebs_no_isolation = !x86_cpu_has_min_microcode_rev(isolation_ucodes);
+	x86_pmu.pebs_no_isolation = !x86_match_min_microcode_rev(isolation_ucodes);
 }
 
 static __init void intel_pebs_isolation_quirk(void)
@@ -5416,16 +5406,16 @@ static __init void intel_pebs_isolation_
 	intel_check_pebs_isolation();
 }
 
-static const struct x86_cpu_desc pebs_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE,	7, 0x00000028),
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	6, 0x00000618),
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	7, 0x0000070c),
+static const struct x86_cpu_id pebs_ucodes[] = {
+	X86_MATCH_VFM_STEPS(INTEL_SANDYBRIDGE,	7, 7, 0x00000028),
+	X86_MATCH_VFM_STEPS(INTEL_SANDYBRIDGE_X,	6, 6, 0x00000618),
+	X86_MATCH_VFM_STEPS(INTEL_SANDYBRIDGE_X,	7, 7, 0x0000070c),
 	{}
 };
 
 static bool intel_snb_pebs_broken(void)
 {
-	return !x86_cpu_has_min_microcode_rev(pebs_ucodes);
+	return !x86_match_min_microcode_rev(pebs_ucodes);
 }
 
 static void intel_snb_check_microcode(void)
_

