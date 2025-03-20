Return-Path: <linux-kernel+bounces-570525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DC2A6B1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476593BECC3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292C22AE49;
	Thu, 20 Mar 2025 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhewwLaI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C254D21C19E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514189; cv=none; b=UqACpMorZWeAecqv1xHbbFpozJgC8QKiQ6q2lscITzVVqYo3VRr423qa+3OrPmp7IXZw6uRQennjBaV5ZfqW5nrlcf7F+Htzw9cPMYk62LbwPaDECpDiNBDffquGJc72a6a0pQINCryxhZzlsWGIwjCJ/hkwbhGI7mikdkdsihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514189; c=relaxed/simple;
	bh=sX0VIggX6XGsEWj/HgxAlguQVIvI1fIdZXONOUBygNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5t9A4dhA4V+ifdJiTdJBY2fSxdHqlq3/0QRrmOigCEhso91dIG4Z+VoVVn9ZNIm3lLFMvmymFGmJ6rweDr6pkSElnGXgtWFpJOoegruQOk/Cp38PCS9h7kSwO6qrIsOuODM4IJZf9glN35+zciUOqegv2CMLQObQ5hk+i9Jx4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhewwLaI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514187; x=1774050187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sX0VIggX6XGsEWj/HgxAlguQVIvI1fIdZXONOUBygNw=;
  b=IhewwLaI/d7TuLM94jcsep997x7lX8nboLUs/I9kFuYPC6Wp6vUxumCn
   76ElR3xMX169Q/2WWPUG3Gw3ZLy/oxWUNCd/vmkwOqAROTu6spYlAW4w7
   MBOMcK2pExL8iYjxNG8AMGKdKmokDs1YB1IePkqtF9J68nIF75ThVeyv7
   zipEyTB3TfVsw2XysKAxc6R0fmVpRZu4Aqxmwo0FXksrvFYdZjVtF5zDP
   CwULqSfyhzZO5yINck7Hb48hpwiB8QhhzOvC4wqW1C7QpsxV7/vNekGnQ
   EDzo+b3cwKtd0G7wgLlYeQH1HyMhWX6Ia4tuBskFCrt3o/kLJkXnLqsKl
   w==;
X-CSE-ConnectionGUID: qaQXSvVcTcWEXhlOMzqFNg==
X-CSE-MsgGUID: HNALlYvsT8aWUgT0boyq8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502577"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502577"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:07 -0700
X-CSE-ConnectionGUID: 2FunZjn+SZuRq67IiBE2Gw==
X-CSE-MsgGUID: NF4S2XxLT8Cgkwp/9mBIvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122962933"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2025 16:43:07 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v2 1/9] x86/fpu/xstate: Remove xstate offset check
Date: Thu, 20 Mar 2025 16:42:52 -0700
Message-ID: <20250320234301.8342-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234301.8342-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250320234301.8342-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Traditionally, new xstate components have been assigned sequentially,
aligning feature numbers with their offsets in the XSAVE buffer. However,
this ordering is not architecturally mandated in the non-compacted
format, where a component's offset may not correspond to its feature
number.

The kernel caches CPUID-reported xstate component details, including size
and offset in the non-compacted format. As part of this process, a sanity
check is also conducted to ensure alignment between feature numbers and
offsets.

This check was likely intended as a general guideline rather than a
strict requirement. Upcoming changes will support out-of-order offsets.
Remove the check as becoming obsolete.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 6a41d1610d8b..542c6981180d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -216,9 +216,6 @@ static bool xfeature_enabled(enum xfeature xfeature)
 static void __init setup_xstate_cache(void)
 {
 	u32 eax, ebx, ecx, edx, i;
-	/* start at the beginning of the "extended state" */
-	unsigned int last_good_offset = offsetof(struct xregs_state,
-						 extended_state_area);
 	/*
 	 * The FP xstates and SSE xstates are legacy states. They are always
 	 * in the fixed offsets in the xsave area in either compacted form
@@ -246,16 +243,6 @@ static void __init setup_xstate_cache(void)
 			continue;
 
 		xstate_offsets[i] = ebx;
-
-		/*
-		 * In our xstate size checks, we assume that the highest-numbered
-		 * xstate feature has the highest offset in the buffer.  Ensure
-		 * it does.
-		 */
-		WARN_ONCE(last_good_offset > xstate_offsets[i],
-			  "x86/fpu: misordered xstate at %d\n", last_good_offset);
-
-		last_good_offset = xstate_offsets[i];
 	}
 }
 
-- 
2.45.2


