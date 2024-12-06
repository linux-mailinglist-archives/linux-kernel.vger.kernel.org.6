Return-Path: <linux-kernel+bounces-435544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34A9E7922
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66EC1888025
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0BE2135C9;
	Fri,  6 Dec 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eiecnL7L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B4206286
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513917; cv=none; b=JiSdbPazo8cSaujX0qVaPAG/opPYhvVNQwFeUnvwMGclRTKrz0GyFQuowZaBAIpVPb8BRbvMtFLXLCTQv3Mv3TXeXoB6tqCOC17HTbJbIhFb7bF83dYGImJ9Q6RAqkaOgGofuDUmGzbKRj+dCPjaombXWYBBsjF6UPhaUkyHODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513917; c=relaxed/simple;
	bh=VtbOhO5Fcm+Lvu2qyiy3/HJvm06tqTpf5L0cvQxTqSw=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=tdrQ15Jfqc5k/bgMCOg5vKHTyPDTKbN29bW+7Ywi9PMFfkSvLLdPjHtA+VKC8SDyUJXqWvkD5dCcc7HyWI9nMDn4+cdyUP5ZcUnLHgP4oaPrOCll3aFRCSaUNx0kdfSSTby7nha76etmOp/AscCS35ueTxQiDWMY2cwxiEfBZuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eiecnL7L; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733513915; x=1765049915;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=VtbOhO5Fcm+Lvu2qyiy3/HJvm06tqTpf5L0cvQxTqSw=;
  b=eiecnL7LWUxKX0DSJbVCNuEpeZkueTgILlM8bwRXF5EZA02lmTu6rK46
   eS1LqhOMBOWjlMYD7QKwyv3g6Q6/n57rTqRBpZ86f9NMcRpSzAkGhPYfl
   B+lJRfzOIz2xwAi2fk5Vs8RhpPSe9eOkNCUMpuMVsRvU3tO3zlpN8Wuwv
   Ve9z/B9r3ePaj7vXUwflAgCQZExEvuJePxEJqgvxu/OVGlUe6tY2MZyIH
   GdQqWlBP/8XEWe6uMZIxzpADP+e8Y5XibYFO7qu4ht7pnCDjkR+vIftGs
   /kguUUethoF+TRF2slfp1va4VqB0KdKweV87EKHN3RhrcQJe0i6dxzDro
   g==;
X-CSE-ConnectionGUID: 8YZCIMEVTxOwcR69T/E0aw==
X-CSE-MsgGUID: QNt7mLgoQYulhpbSbo+XNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34027895"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34027895"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:38:35 -0800
X-CSE-ConnectionGUID: fB/hFe0cRS2CWIUwTAWAhQ==
X-CSE-MsgGUID: k5RFNKJ8S16S5GW9dUjb5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94979022"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa009.fm.intel.com with ESMTP; 06 Dec 2024 11:38:34 -0800
Subject: [PATCH 3/5] x86/cpu: Replace PEBS use of 'x86_cpu_desc' use with 'x86_cpu_id'
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,mingo@kernel.org,peterz@infradead.org,tony.luck@intel.com,pawan.kumar.gupta@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 06 Dec 2024 11:38:34 -0800
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
In-Reply-To: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
Message-Id: <20241206193834.3ABE2E95@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The 'x86_cpu_desc' and 'x86_cpu_id' structures are very similar.
Reduce duplicate infrastructure by moving the few users of
'x86_cpu_id' to the much more common variant.

The existing X86_MATCH_VFM_STEPPINGS() helper matches ranges of
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

 b/arch/x86/events/intel/core.c |   63 +++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff -puN arch/x86/events/intel/core.c~zap-x86_cpu_desc arch/x86/events/intel/core.c
--- a/arch/x86/events/intel/core.c~zap-x86_cpu_desc	2024-12-06 11:33:16.775171950 -0800
+++ b/arch/x86/events/intel/core.c	2024-12-06 11:33:16.779172107 -0800
@@ -5371,42 +5371,33 @@ static __init void intel_clovertown_quir
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
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL,		 3,  3, 0x0000001f),
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_L,	 1,  1, 0x0000001e),
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_G,	 1,  1, 0x00000015),
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X,	 2,  2, 0x00000037),
+	X86_MATCH_VFM_STEPPINGS(INTEL_HASWELL_X,	 4,  4, 0x0000000a),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL,	 4,  4, 0x00000023),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_G,	 1,  1, 0x00000014),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D,	 2,  2, 0x00000010),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D,	 3,  3, 0x07000009),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D,	 4,  4, 0x0f000009),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_D,	 5,  5, 0x0e000002),
+	X86_MATCH_VFM_STEPPINGS(INTEL_BROADWELL_X,	 1,  1, 0x0b000014),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X,	 3,  3, 0x00000021),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X,	 4,  7, 0x00000000),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_X,	11, 11, 0x00000000),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE_L,	 3,  3, 0x0000007c),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SKYLAKE,		 3,  3, 0x0000007c),
+	X86_MATCH_VFM_STEPPINGS(INTEL_KABYLAKE,		 9,  9, 0x0000004e),
+	X86_MATCH_VFM_STEPPINGS(INTEL_KABYLAKE_L,	 9, 12, 0x0000004e),
+	X86_MATCH_VFM_STEPPINGS(INTEL_KABYLAKE,		10, 13, 0x0000004e),
 	{}
 };
 
 static void intel_check_pebs_isolation(void)
 {
-	x86_pmu.pebs_no_isolation = !x86_cpu_has_min_microcode_rev(isolation_ucodes);
+	x86_pmu.pebs_no_isolation = !x86_match_min_microcode_rev(isolation_ucodes);
 }
 
 static __init void intel_pebs_isolation_quirk(void)
@@ -5416,16 +5407,16 @@ static __init void intel_pebs_isolation_
 	intel_check_pebs_isolation();
 }
 
-static const struct x86_cpu_desc pebs_ucodes[] = {
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE,	7, 0x00000028),
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	6, 0x00000618),
-	INTEL_CPU_DESC(INTEL_SANDYBRIDGE_X,	7, 0x0000070c),
+static const struct x86_cpu_id pebs_ucodes[] = {
+	X86_MATCH_VFM_STEPPINGS(INTEL_SANDYBRIDGE,	7, 7, 0x00000028),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SANDYBRIDGE_X,	6, 6, 0x00000618),
+	X86_MATCH_VFM_STEPPINGS(INTEL_SANDYBRIDGE_X,	7, 7, 0x0000070c),
 	{}
 };
 
 static bool intel_snb_pebs_broken(void)
 {
-	return !x86_cpu_has_min_microcode_rev(pebs_ucodes);
+	return !x86_match_min_microcode_rev(pebs_ucodes);
 }
 
 static void intel_snb_check_microcode(void)
_

