Return-Path: <linux-kernel+bounces-445379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2329F1541
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380697A110D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C065A1E0B86;
	Fri, 13 Dec 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OiNrixR7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13391EBFF7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115894; cv=none; b=lZBQIXZZInqY5YHaVOKWQzZobhwzoC3a+ExyFPovESe/bwAASRdxs6s7XRcOPK0IlC+K9rDTRxnIY8N1ea6+T1sLSv9Z0VStpSn7h0bM90E4rgedVY7udhqiAuWg0qPq/d1D8Hy/SPMU2TsYwAldTmSq0ijWxgvPDZtiVGZMfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115894; c=relaxed/simple;
	bh=6YlPooVRgYbEiAuJHRT9aKGR45pVF99Xv0tI4XQjsGg=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=oRJN9ikYKpxODCv10eYyxLNPpH923CCnfWABGw8MPgzsQhRyQABLUxWmghwOKHEEDFevyS2Gwx+NZ4NEaKFD5vRGh7ydJC7Nfkp33z4S72XmC5KKZeldKpthKS4h94+YJed4L5LSRqu2K4MA2YwgjJVkTbLh6udu+FJ7XToVtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OiNrixR7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734115893; x=1765651893;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=6YlPooVRgYbEiAuJHRT9aKGR45pVF99Xv0tI4XQjsGg=;
  b=OiNrixR7+VXv9sEf5YKh6kExSnP7HL5QgytxR2vFxZzuONhy8fFfheSc
   PrXKSvRcqcLeCqb655/bZhgeX7YyXqnAG9t2JKVd5jcVs8f3p87kNrMRq
   56BfjYCQlj03ejsTS+mblpNuMJywhlVl3Ow1fAaf0ww96YF7CBMv65fC+
   7vP/Ae865qHVn8BLTekEJf6OytX9tFxVlAuUvnB0L+cGNw62jkl/hrhEx
   eEy2TKxW9XrGyv296RNOQhuMVBHxgVuXNlmNTJcTTQB93LyWAdvQICMG7
   LoMLeLaMr7hjpgPm/arGQoskr1W9U0CBLLXkWLNdXTVy0y1jCg109xmzP
   w==;
X-CSE-ConnectionGUID: C0D4hMuuQ5+73JEe3MR0XA==
X-CSE-MsgGUID: DkovexS1R4C8GIS6ks9Uxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34487455"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34487455"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 10:51:33 -0800
X-CSE-ConnectionGUID: YLQ0vwgjQvq1D8pzz2hwhA==
X-CSE-MsgGUID: vfM6aSx2QXqjiK5tYVU3kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96478768"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 10:51:33 -0800
Subject: [v2][PATCH 4/5] x86/cpu: Move AMD erratum 1386 table over to 'x86_cpu_id'
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 10:51:32 -0800
References: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
Message-Id: <20241213185132.07555E1D@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The AMD erratum 1386 detection code uses and old style 'x86_cpu_desc'
table. Replace it with 'x86_cpu_id' so the old style can be removed.

I did not create a new helper macro here. The new table is certainly
more noisy than the old and it can be improved on. But I was hesitant
to create a new macro just for a single site that is only two ugly
lines in the end.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/amd.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff -puN arch/x86/kernel/cpu/amd.c~amd-x86_cpu_id arch/x86/kernel/cpu/amd.c
--- a/arch/x86/kernel/cpu/amd.c~amd-x86_cpu_id	2024-12-13 10:47:55.714076132 -0800
+++ b/arch/x86/kernel/cpu/amd.c	2024-12-13 10:47:55.718076292 -0800
@@ -795,10 +795,9 @@ static void init_amd_bd(struct cpuinfo_x
 	clear_rdrand_cpuid_bit(c);
 }
 
-static const struct x86_cpu_desc erratum_1386_microcode[] = {
-	AMD_CPU_DESC(0x17,  0x1, 0x2, 0x0800126e),
-	AMD_CPU_DESC(0x17, 0x31, 0x0, 0x08301052),
-	{},
+static const struct x86_cpu_id erratum_1386_microcode[] = {
+	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x01), 0x2, 0x2, 0x0800126e),
+	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x31), 0x0, 0x0, 0x08301052),
 };
 
 static void fix_erratum_1386(struct cpuinfo_x86 *c)
@@ -814,7 +813,7 @@ static void fix_erratum_1386(struct cpui
 	 * Clear the feature flag only on microcode revisions which
 	 * don't have the fix.
 	 */
-	if (x86_cpu_has_min_microcode_rev(erratum_1386_microcode))
+	if (x86_match_min_microcode_rev(erratum_1386_microcode))
 		return;
 
 	clear_cpu_cap(c, X86_FEATURE_XSAVES);
_

