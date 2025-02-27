Return-Path: <linux-kernel+bounces-537100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816CEA48811
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA8A188C499
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F44B26BDB4;
	Thu, 27 Feb 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJKdUbIi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C626B97F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681909; cv=none; b=glk/BLBAqJwKbMfKGJJPDeV4J52wyCjlUamZ7c8rpvJkK/pdEMgC2o5SACDo5nUk5yK0xIUZTJgSD+JONkT7hp5qhWrG5AvFHQGVYmDyGPAH+8zOlaUs/HodkIfoOzwPO68P+SuQ+8/lrJW8Ll/Pn72xmipLzGAd8c8vFxjaL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681909; c=relaxed/simple;
	bh=M67rS9H7Qso6AOXIDWb/hoSSdA5CWVIzCPpTU22f688=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJuxSa2rsJCD7xsRbM0zrPq4BUtbvu826kVQxcgtXv0tWHSoTt2kGteoYxHtwLhTeBT3QaIss84McBzxFGU6Oc8InGutXvH/DadlqLZ/Z+t7eLEMuIKEZ10fEzI1qQtP/WRZTSV4mMzHglvjSHtL+vZRxuVfg6+DSxCQsSRsVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJKdUbIi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681908; x=1772217908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M67rS9H7Qso6AOXIDWb/hoSSdA5CWVIzCPpTU22f688=;
  b=RJKdUbIicghEeG0XsDH5vn9a8CSkWW+OkfwLdxZLT/3zPCQhjsfAux7U
   JPh/Qc9h6kAW6vc37Hwy5D5KL+GwVcDbBOdmxBLevQfFkRjeLZRgL1DHR
   +/YOkOaPL41Ds2Ni4b1eVAX/Mo0A9NiZ0U7lNw0bi8Q4IyyS/IAI1PwZ2
   x++PoMzI2vB+Voo6cG3lFpF8tsRRz1z3by8NvO57zNaMlQLqtA/vMSjUC
   A3tbd9W/mubo/fig3XxbzMzdQ1ysymYXQ4HxXcwsUyzxFXMLHcIOiGwip
   3ICEbRlhI3JACNwEbLkjKnjAkMrQwQcUA7IOOP820qdxaJYpPD8PfiQgt
   A==;
X-CSE-ConnectionGUID: a7HdJwAwSimSi8Mm2ELOtw==
X-CSE-MsgGUID: WZD2wjSoRemUfUT6C+9keQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720870"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720870"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:07 -0800
X-CSE-ConnectionGUID: fUS3uTsuTD2ONtuDIDYXhw==
X-CSE-MsgGUID: 3cl642s2Rh6WtyVGt7TtYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767387"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:07 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 03/11] x86/fpu/xstate: Remove xstate offset check
Date: Thu, 27 Feb 2025 10:44:48 -0800
Message-ID: <20250227184502.10288-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227184502.10288-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
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
strict requirement. As part of supporting out-of-order offsets, remove
this unnecessary validation.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index cee9a1e454b7..c6f825bb744b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -253,9 +253,6 @@ static bool xfeature_enabled(enum xfeature xfeature)
 static void __init setup_xstate_cache(void)
 {
 	u32 eax, ebx, ecx, edx, i;
-	/* start at the beginning of the "extended state" */
-	unsigned int last_good_offset = offsetof(struct xregs_state,
-						 extended_state_area);
 	/*
 	 * The FP xstates and SSE xstates are legacy states. They are always
 	 * in the fixed offsets in the xsave area in either compacted form
@@ -283,16 +280,6 @@ static void __init setup_xstate_cache(void)
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


