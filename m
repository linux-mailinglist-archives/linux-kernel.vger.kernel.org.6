Return-Path: <linux-kernel+bounces-416303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45929D42FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5DEB2633C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7D81C578C;
	Wed, 20 Nov 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ei1IYZo2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A81C1F0A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134255; cv=none; b=FMeWkY/YutxCHpiCxuDHoXhIn3t4AbofTqDLQ/zSIsJKF0FHHtxcKgM+AjRX60wS0RGvMl3I5CBRTKUFSVVOpSNBIAdS77jImhcfyQDJHXkuH6PO0DgmKbuCx6e57tWX2rcymhLIuo58dio2LQ4pfKlTCAwMaP0eonG6YOMwqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134255; c=relaxed/simple;
	bh=z2tyZsHSrCWIQH8ADapBIBk1ajBwELUTfIkz84/6PKE=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=MonOrFQfzkrZrmSTJPFWhQ2rsjinEuOpAryXJgEHitsurGOEAxwRi2mbA/p7NIibD3kmxfUcmEtGFd/PufMjYhMXLiui3ovQY0muQ9lzgpU1BaApJ81RlFLOuo4n8WktJ/C1ion3V0smrUbIrDnGn18p8kR1MxvkcG9wt0LhtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ei1IYZo2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732134254; x=1763670254;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=z2tyZsHSrCWIQH8ADapBIBk1ajBwELUTfIkz84/6PKE=;
  b=Ei1IYZo2e8Vh3l21t2l0SNw7AotT6EY/CFI0AeP0ya1uZywGQsBzJ9PZ
   R29B//VRRhqA6ZPUyHPhWvh2MfEE1X3zt57kb3GWsZmEIbKUHqrrqQR2h
   nSxW7bd5htZqWRMzWrKNPFhKZY7H+ywG0/3j/3dsBtRybQXfjk6T4a4zh
   ydRYbJyc3kAwlhTGMDu9CDYwUDyNQ1T6nswYxN+5jHa+ICsfZL54hdqzi
   7Ir9ibkc1v4xgcY4BhDTCyWNa2g+zrG3do5iJItNb3qU2J5nB61T+i6q8
   e9a3S1eI0FsDRz24ynWZcJ4REGAByTbv/ZdPtvhKF5jZn+W2CFeZC3js5
   A==;
X-CSE-ConnectionGUID: X0JKXBysTPePk+sPcfx/VA==
X-CSE-MsgGUID: gMnqt1G8TOq5X56ufC2Kcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="42855776"
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="42855776"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 12:24:14 -0800
X-CSE-ConnectionGUID: 76chjErPQBurRGWa358Y7w==
X-CSE-MsgGUID: d8GEurDLRQaRpvJuzblLlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,170,1728975600"; 
   d="scan'208";a="90407613"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa010.fm.intel.com with ESMTP; 20 Nov 2024 12:24:15 -0800
Subject: [RFC][PATCH 3/4] x86/cpu: Move AMD erratum 1386 table over to 'x86_cpu_id'
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 20 Nov 2024 12:24:13 -0800
References: <20241120202408.0A7215EF@davehans-spike.ostc.intel.com>
In-Reply-To: <20241120202408.0A7215EF@davehans-spike.ostc.intel.com>
Message-Id: <20241120202413.4D0B40F6@davehans-spike.ostc.intel.com>
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

 b/arch/x86/kernel/cpu/amd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/x86/kernel/cpu/amd.c~amd-x86_cpu_id arch/x86/kernel/cpu/amd.c
--- a/arch/x86/kernel/cpu/amd.c~amd-x86_cpu_id	2024-11-20 12:22:05.988420580 -0800
+++ b/arch/x86/kernel/cpu/amd.c	2024-11-20 12:22:05.992420733 -0800
@@ -795,9 +795,9 @@ static void init_amd_bd(struct cpuinfo_x
 	clear_rdrand_cpuid_bit(c);
 }
 
-static const struct x86_cpu_desc erratum_1386_microcode[] = {
-	AMD_CPU_DESC(0x17,  0x1, 0x2, 0x0800126e),
-	AMD_CPU_DESC(0x17, 0x31, 0x0, 0x08301052),
+static const struct x86_cpu_id erratum_1386_microcode[] = {
+	X86_MATCH_VFM_STEPPING(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x01), 0x2, 0x0800126e),
+	X86_MATCH_VFM_STEPPING(VFM_MAKE(X86_VENDOR_AMD, 0x17, 0x31), 0x0, 0x08301052),
 };
 
 static void fix_erratum_1386(struct cpuinfo_x86 *c)
@@ -813,7 +813,7 @@ static void fix_erratum_1386(struct cpui
 	 * Clear the feature flag only on microcode revisions which
 	 * don't have the fix.
 	 */
-	if (x86_cpu_has_min_microcode_rev(erratum_1386_microcode))
+	if (x86_match_min_microcode_rev(erratum_1386_microcode))
 		return;
 
 	clear_cpu_cap(c, X86_FEATURE_XSAVES);
_

