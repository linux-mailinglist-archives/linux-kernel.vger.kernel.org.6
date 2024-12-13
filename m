Return-Path: <linux-kernel+bounces-445544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3679F1797
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA55C188E4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6CD192D83;
	Fri, 13 Dec 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGC4HyZ5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6CA1917CD
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123031; cv=none; b=kLFYDS3jGdd/VL1bD7ZmA+w4S2QNvt/SLuMzK41IuTA2TJhI/zq1powIs54Yw6yaU2UbUJykSdOuzr1f5XOkTKx8Msium9WMlwhCKO/Bc9iYpnnXBKD8cl8LdzEOwbsm5M9mwRNdxoecqnmQ/77dhR1xf5xmU1IRecYF4CjUIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123031; c=relaxed/simple;
	bh=88UGnMCyuLdp374UNJMyhK04Kwhaf6mQ7GYjqxXB7rc=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=JJVMGzEJkETmmGjp2WQxjNds8Ktncrf9fAaufeOKLdVWfo+AFvi8ks4ofr2zazvrWiSrn86fPtDspYqK/B/XcC3hV62Xp6rDQdZGRYU5DJa3jjKWEtPpCbXIcSCKGhn1UK5gmaOL0KFEu5EKK4xeu4UYcMWxtgR6tws8pU/cMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGC4HyZ5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734123030; x=1765659030;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=88UGnMCyuLdp374UNJMyhK04Kwhaf6mQ7GYjqxXB7rc=;
  b=CGC4HyZ5swPbM+9HffkYvmRW+hHyxzrS2IklnBxZJZCystWEoM3iY9IE
   bqqqrXHvaFOczKC/oS28VnPZzyngZwy0Y0e5DKxzxFCxmO99P5tnmAgSf
   XJhPfq6YgLTGOheVlIUNldTr4S6ls2QISG9OSpU1/ZPqRoT3nr6kUUZwZ
   PQzUfgFG/m5I1IQELotjA2+gB7slrJAG8G3BJL5IxDMfgIZLJRsZEaMxD
   pu9/eOtLYX6TkIxEf8Sw4SCHBiLHie+jJm86U61fAfSRQXuOa1bS/8K+J
   lp1B2u3lX8PoALCk1/Fz7WobTQZa8ls1q/MF6eD3IkuU7NlTKMOngdNlv
   w==;
X-CSE-ConnectionGUID: 5t5dQaw/QamCXTCBTEFESA==
X-CSE-MsgGUID: k5D5XORrT5mEIJ0sf5trXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34820487"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34820487"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:50:30 -0800
X-CSE-ConnectionGUID: A7MJixjdQwS436Am6P1meA==
X-CSE-MsgGUID: GVI67gCgTBScibKanP81pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96501685"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 12:50:30 -0800
Subject: [PATCH 02/10] x86/cpu: Use MWAIT leaf definition
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,dave.jiang@intel.com,irenic.rajneesh@gmail.com,david.e.box@intel.com,Dave Hansen <dave.hansen@linux.intel.com>,zhao1.liu@intel.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 12:50:29 -0800
References: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
In-Reply-To: <20241213205026.25B1D283@davehans-spike.ostc.intel.com>
Message-Id: <20241213205029.5B055D6E@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The leaf-to-feature dependency array uses hard-coded leaf numbers.
Use the new common header definition for the MWAIT leaf.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---

 b/arch/x86/kernel/cpu/common.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/x86/kernel/cpu/common.c~mwait-leaf-checks-1 arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~mwait-leaf-checks-1	2024-12-13 12:45:33.207069895 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-12-13 12:45:33.211070065 -0800
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

