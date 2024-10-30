Return-Path: <linux-kernel+bounces-389626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65FC9B6F12
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF501F264B5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5280B21FDBC;
	Wed, 30 Oct 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDWPTvlS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B072219CBF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324009; cv=none; b=bN/ty60AUp6q0teR3oQb5ZdgH5KqZuRewLIOt//gkmk2EROJJfVCAt3oRR4RoVSSL0IK6enTHTSLqn8LYcxm7W5yP4KqaEK5e3X7E+5aEXnTPZKKXdsDN5I6zaHfDGD3FzG/2AALaxfNbKWqs3aKSHEP8g05KGj/ldVZ38R19mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324009; c=relaxed/simple;
	bh=Z3rQeURAjzU3ZhgDlAc/qGN0DoXKHoYRkKHt3P+UvgU=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=iFt+I8L0HPAw96nKnNi/rfs8c+e5YuKTeDww9Iq2ZHdbf5lqebA5VytDGQ+ax6mHVgy0eUMm5rLA+4kGAFdirwSQ0GpY8Yhu2A1uya/O/x0Zc1RwkKyn9PZccOTKVgZZHIHA7pq7rv2Jd0NHaq6Sdr23Un4+B4wA0kPge1ByAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDWPTvlS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730324008; x=1761860008;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=Z3rQeURAjzU3ZhgDlAc/qGN0DoXKHoYRkKHt3P+UvgU=;
  b=WDWPTvlSOjIU6mLT9uhQ+eXXulBzaAmu/jQ1StJCVVrXYTQvzWMftQT+
   YZ9NtCtEm+jqIWFaE1jXJVBimSd4qWnWdeRekI0y7V+S0h8Nagiwzhhga
   jj9WpwOt/VLYbvBkPZ50iJa5Aqq/dVxwNi2i+W3CDvMnvZ2eey6wefKCL
   hiuRm2OGEZrDWWJgDIzL+rwv5tDRqV3Tzb164mlN5gjTbQpKw0O74kRBj
   L+SA+CfNmJ9ppK+p0HD+DkJRhAB1TRobiMYbJQYbrUZZvD81SPPIgsXEB
   1J3bLAmAxyqfX3T2eBg0PTk+30Jb/mgQvqlKwcP4qoLefAERoX2a43hJS
   A==;
X-CSE-ConnectionGUID: XXnTRzFQRC6JfQe8zKUpow==
X-CSE-MsgGUID: Xvqi6kdiSKSjsxHmBxjYRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33741646"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33741646"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 14:33:28 -0700
X-CSE-ConnectionGUID: XA7aIZP8RrSInS/bYmzX7A==
X-CSE-MsgGUID: dzXlFgbiQ5GxC91v1u8XRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="83257723"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 30 Oct 2024 14:33:28 -0700
Subject: [PATCH 10/11] x86/fpu: Remove unnecessary CPUID level check
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,rafael@kernel.org,lenb@kernel.org,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 30 Oct 2024 14:33:27 -0700
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
In-Reply-To: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
Message-Id: <20241030213327.E04359C9@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The CPUID level dependency table will entirely zap X86_FEATURE_XSAVE
if the CPUID level is too low.  This code is unreachable.  Kill it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/fpu/xstate.c |    5 -----
 1 file changed, 5 deletions(-)

diff -puN arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-2 arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~xsave-leaf-checks-2	2024-10-30 12:26:58.838215576 -0700
+++ b/arch/x86/kernel/fpu/xstate.c	2024-10-30 12:26:58.842215584 -0700
@@ -764,11 +764,6 @@ void __init fpu__init_system_xstate(unsi
 		return;
 	}
 
-	if (boot_cpu_data.cpuid_level < XSTATE_CPUID) {
-		WARN_ON_FPU(1);
-		return;
-	}
-
 	/*
 	 * Find user xstates supported by the processor.
 	 */
_

