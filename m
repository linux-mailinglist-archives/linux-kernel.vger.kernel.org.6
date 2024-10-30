Return-Path: <linux-kernel+bounces-389617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3E9B6F09
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFDE1F2607B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2478217904;
	Wed, 30 Oct 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkojOPKK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF8F1CF7BB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323997; cv=none; b=aAuM8RT9Ki53yMfz6ShcpQDyriWuttr50A+oiOQi8vTnmqUGpA359FDggetlocEROz2GrgNH+0scCJIpexXmtsNvnnBiGwBecNmTYNx9LBKPQmVIfhNWol3rzS/2PR1eMcF7KHDMLkYOBeE+JXfNel/n8ojiWKUbQI/0I585YzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323997; c=relaxed/simple;
	bh=n9hYAXlaVXpArJ2wCSI+AA6g+IWO0VOGCZptk7q34Xo=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=aQen7oujC3K4pyiDScU1S9v6IbSk0G1yAz+2ELAslx9b6UrzRAq7wtf7QS1ycW0R0OFK7ucN0Zmpmv5B4qoHzYHLzAi3mnMAimsNgPYt30EOy6zzpkOKX8KoGUMGWF4c8YhMveWyh/LSsDTmF4sU1Qwjx5PGHE2Mx4DFhH1DA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkojOPKK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730323995; x=1761859995;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=n9hYAXlaVXpArJ2wCSI+AA6g+IWO0VOGCZptk7q34Xo=;
  b=IkojOPKKN9xY+By2hjG8j+C7hMhfg1leu05OHtr+F28u7oNp1FDL7Fb2
   rD5CAEmwUbhPVYdxVJkHstiZDlqii57B3l6zQAh+RanO5pfs/5w/IdkfW
   +qdAy1zk9GroQIwIcxb9nL6N6qQybfqAQUPx0+iZZUGd73HvKzoiJjqwC
   k1m+O/XfcyveTWtO0TlVgSgxEPF7pvV/0/zM6szwQR1cSLxnsudA3RtV1
   U52bdJnJX4C4/4ylRTJt/ghxupwUxR87k3/SxN4WtYPYklMLu87/IjR0z
   ozg7am3HVmvEXpFpmqvQDTFPOouiXu7V+5kgfaMRzm7sL1rv2cULxC0fn
   A==;
X-CSE-ConnectionGUID: WoR3MolNT3GHRHIlFjAv1g==
X-CSE-MsgGUID: sDAhc1dfRb6hSgXc2YrnLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29904680"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29904680"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:15 -0700
X-CSE-ConnectionGUID: 8AX0lb+3RzyyhKj+aoJh2A==
X-CSE-MsgGUID: jrF3z2raQpGJjIx4todeLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="82090462"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 14:33:14 -0700
Subject: [PATCH 02/11] x86/cpu: Use MWAIT leaf definition
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:14 -0700
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
In-Reply-To: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Message-Id: <20241030213314.6F84C490@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This dependency array uses hard-coded leaf numbers.  Use the new common
header definition for the MWAIT leaf.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/x86/kernel/cpu/common.c~mwait-leaf-checks-1 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~mwait-leaf-checks-1	2024-10-30 12:28:09.562351049 -0700
+++ b/arch/x86/kernel/cpu/common.c	2024-10-30 12:28:09.566351056 -0700
@@ -29,6 +29,7 @@
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
+#include <asm/cpuid.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
 #include <asm/doublefault.h>
@@ -636,7 +637,7 @@ struct cpuid_dependent_feature {
 
 static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
-	{ X86_FEATURE_MWAIT,		0x00000005 },
+	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
 	{ X86_FEATURE_DCA,		0x00000009 },
 	{ X86_FEATURE_XSAVE,		0x0000000d },
 	{ 0, 0 }
_

