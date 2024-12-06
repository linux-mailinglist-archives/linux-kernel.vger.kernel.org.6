Return-Path: <linux-kernel+bounces-435545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A969E7921
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED83281BCE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2FC204576;
	Fri,  6 Dec 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RP/hKYLJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ECC20ADF7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513918; cv=none; b=WNWmLkUkc23ObOu3F9AvSO0tN8DfSUjdAwRC579T+8FvKcinhTjRUr6sNaT4W0Z67JK1HPHIViQ6KkRkwWxCmV21LAlXFieaD/WLvLVcW/c6m4TzYM0tLlDvMWRb9HddpueaQaUZlbE78sy1zwunmlqEVGaz5aC8JAW8Ga5RMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513918; c=relaxed/simple;
	bh=IamqIF3iwqz2XAtOyq+ARQ2KlRkzcD+2dSgR6uOhCbs=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=g72qw1YXwJXGord/fX9P1CjQ817rO4eYU2AMbsabJRnnudW32F7N5h69L2RntlV7llCS/UbkScU2vER+/ouHSFey+GF/jTYK5ETz6BZuPiRj52T3W3yum8lm2PxDk8f9mhndQ/mxpp6s7bAL///u+AeczyIRaCdB6zK4/ssaYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RP/hKYLJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733513917; x=1765049917;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=IamqIF3iwqz2XAtOyq+ARQ2KlRkzcD+2dSgR6uOhCbs=;
  b=RP/hKYLJZdv8C9yF+uGyb03xMdK84cdoehkg72usaclIrfMWXp3fdghF
   JuYlubNLt9lYUVsmSnVw9gm36L1tG5wFwoQKrG2Tna8x7crHRuXpOFgbS
   FZt3nffEp8+Lr+qP+yfO5HhmyOjUbPGxEKZJRxphAHIX73Zhqg+JMpBqc
   YtEQYNRS7kYmNinbmVvGD9E/X2hvAJSk0MnZIcTgXs0jXAsCfzH+6Vu/i
   AUev/kim3hRqPqzbhcnnxZh+Tn0dSB8B573qfXUr/BkCCkGHdG2eWpqyt
   M25rDtw3OxSFe6m+bHYMBiDrvMkUys09WrKS71gwhIVlRSxas/lsR/NS2
   A==;
X-CSE-ConnectionGUID: XhePq7DhR/GpuD1vZy5JXg==
X-CSE-MsgGUID: QwZkSJ5EQM2uHeY/umQ95Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34027902"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="34027902"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:38:36 -0800
X-CSE-ConnectionGUID: Ck38/9QGTUGuJSjuhJfX9g==
X-CSE-MsgGUID: y6vhAnC9SeCSyaBD9zfWOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94979042"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa009.fm.intel.com with ESMTP; 06 Dec 2024 11:38:36 -0800
Subject: [PATCH 4/5] x86/cpu: Move AMD erratum 1386 table over to 'x86_cpu_id'
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,mingo@kernel.org,peterz@infradead.org,tony.luck@intel.com,pawan.kumar.gupta@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 06 Dec 2024 11:38:35 -0800
References: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
In-Reply-To: <20241206193829.89E12D0B@davehans-spike.ostc.intel.com>
Message-Id: <20241206193835.9B87AADD@davehans-spike.ostc.intel.com>
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
--- a/arch/x86/kernel/cpu/amd.c~amd-x86_cpu_id	2024-12-06 11:33:17.271191446 -0800
+++ b/arch/x86/kernel/cpu/amd.c	2024-12-06 11:33:17.275191602 -0800
@@ -795,10 +795,9 @@ static void init_amd_bd(struct cpuinfo_x
 	clear_rdrand_cpuid_bit(c);
 }
 
-static const struct x86_cpu_desc erratum_1386_microcode[] = {
-	AMD_CPU_DESC(0x17,  0x1, 0x2, 0x0800126e),
-	AMD_CPU_DESC(0x17, 0x31, 0x0, 0x08301052),
-	{},
+static const struct x86_cpu_id erratum_1386_microcode[] = {
+	X86_MATCH_VFM_STEPPINGS(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x01), 0x2, 0x2, 0x0800126e),
+	X86_MATCH_VFM_STEPPINGS(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x31), 0x0, 0x0, 0x08301052),
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

