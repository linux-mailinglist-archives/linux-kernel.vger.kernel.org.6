Return-Path: <linux-kernel+bounces-389622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36589B6F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78BD282E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A562194AE;
	Wed, 30 Oct 2024 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eP4puUEd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4BB21894E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324003; cv=none; b=TbN1pO4TcYpsKeMYa06jnUo93bLMgU+x9OuwKN7InwSQcxIUoFjSu7HRZ6wV9Ra/DnzNPxYv8nsz6LpYFdbHahSmzYECfecSjrgPNHGGqWfd1VLyygYb739W5/auYGtuK+FoaZFtYwekWuCcJ1S6J68wSEdADUayXMB92ibOWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324003; c=relaxed/simple;
	bh=HkhvFw9HtOhYhsYwXTJoOyj0okIXN+sBWdfJSX+8Qk4=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=deQ02RPwqOpwUV1aqjegMoeLPiYVHb6LhGYwTyFQ8na3qGre/AW+C1V5cxBbzlyQAphg6LI8uCFwiy/z+A0oZU95q8db0RGudkSM35VBaMJ8z8IyFfo1M1AAVR9uRC6uhwcqbW+PaHTivDTbqKKRhmOijoKmXLAAYUIHHaxmbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eP4puUEd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730324002; x=1761860002;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=HkhvFw9HtOhYhsYwXTJoOyj0okIXN+sBWdfJSX+8Qk4=;
  b=eP4puUEd6F149/P+hlH+VYRtrevYcrSicWYE8cb8YQunThnkFkiYOEgH
   Uf68kVvgpl6locmCBSHADyMMbUXZOR4k+NKAI877cQp/s/P8Wflk84ycu
   fTPf0nnuudR4FmeZWcbpSkorqzxMgrFP385/aAqGgAAxopUOzJSIqK8HN
   Tiv8mFHw/VyWjVacN52mRMiB6b5Utfpea5Y+F2rnMnDXJN8++b/EOj2JZ
   FIeke5rp9pIms13SjG1pEfzc9bJGXF0qTH1lNq0w9RaLeSw3lZGFULBde
   Nab5DVSFBp0AuhW7rlNNZ5VqJtfUDs5+E8CdM6FYOGEsVNrDguyZa7G4H
   w==;
X-CSE-ConnectionGUID: AotzA5TITuWAWDT72Qtogw==
X-CSE-MsgGUID: ds+qdWK0Qa++1fjWVPBmPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33741601"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33741601"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:22 -0700
X-CSE-ConnectionGUID: 7IJpNWiYQgKE4FtfEXvqrg==
X-CSE-MsgGUID: QVdzjOcyQEitXgdc7CGoQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="83257657"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 30 Oct 2024 14:33:22 -0700
Subject: [PATCH 06/11] x86/cpu: Move TSC CPUID leaf definition
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:21 -0700
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
In-Reply-To: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Message-Id: <20241030213321.B3F6031D@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Prepare to use the TSC CPUID leaf definition more widely by moving
it to the common header.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/events/intel/pt.c   |    1 +
 b/arch/x86/events/intel/pt.h   |    3 ---
 b/arch/x86/include/asm/cpuid.h |    1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff -puN arch/x86/events/intel/pt.c~tsc-leaf-checks-1 arch/x86/events/intel/pt.c
--- a/arch/x86/events/intel/pt.c~tsc-leaf-checks-1	2024-10-30 12:26:57.198212340 -0700
+++ b/arch/x86/events/intel/pt.c	2024-10-30 12:26:57.206212355 -0700
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 
+#include <asm/cpuid.h>
 #include <asm/perf_event.h>
 #include <asm/insn.h>
 #include <asm/io.h>
diff -puN arch/x86/events/intel/pt.h~tsc-leaf-checks-1 arch/x86/events/intel/pt.h
--- a/arch/x86/events/intel/pt.h~tsc-leaf-checks-1	2024-10-30 12:26:57.202212347 -0700
+++ b/arch/x86/events/intel/pt.h	2024-10-30 12:26:57.206212355 -0700
@@ -37,9 +37,6 @@ struct topa_entry {
 	u64	rsvd4	: 12;
 };
 
-/* TSC to Core Crystal Clock Ratio */
-#define CPUID_TSC_LEAF		0x15
-
 struct pt_pmu {
 	struct pmu		pmu;
 	u32			caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
diff -puN arch/x86/include/asm/cpuid.h~tsc-leaf-checks-1 arch/x86/include/asm/cpuid.h
--- a/arch/x86/include/asm/cpuid.h~tsc-leaf-checks-1	2024-10-30 12:26:57.202212347 -0700
+++ b/arch/x86/include/asm/cpuid.h	2024-10-30 12:26:57.206212355 -0700
@@ -21,6 +21,7 @@ enum cpuid_regs_idx {
 
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
+#define CPUID_TSC_LEAF		0x15
 
 #ifdef CONFIG_X86_32
 extern int have_cpuid_p(void);
_

