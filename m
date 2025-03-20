Return-Path: <linux-kernel+bounces-570531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB18A6B1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B447B2BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0857A22D78B;
	Thu, 20 Mar 2025 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgYPeVG+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022BD22D4FA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514203; cv=none; b=i1AhH8rv/TST7XfpdE2Pb6F93pzISVmcIEMvba6w/FdrXuD0JoqHpQ2X+w5lLpySWsQVUSPmd795CNrug+qDIsfxvT0Zmfa6cDazG0wUj89aC7m7M6raF81n0zTiwBAi3VEV8oPmvwQ0zykdOtKCEb1ft70aUj8VQ8DxxyeBKvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514203; c=relaxed/simple;
	bh=lNp44l3ZlB7sSDByBomNZ9z1owRfT9a0f56wu7y0YKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTsRH9lrbGho1YCMjS3pWHiaKJiXtsdRaJBS7q49+twp0JaymJ/HEXVzdxcb9saUgMwhL3xkHzx+8SRUOEEmAHFxW7rEjq7tXtAtm/8Lr430az0s1mqoL4SbRdB2sZ71j1uwPjOUzCrIpNwLRgHdV7V6JBY1/w5Zm5y7Lm9WYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgYPeVG+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514202; x=1774050202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lNp44l3ZlB7sSDByBomNZ9z1owRfT9a0f56wu7y0YKY=;
  b=AgYPeVG+5fbWgXofmMLniwLH9WeFRZyF2lAgqIbf8GVfH65mD751Xk54
   K+l4EIPN35n4kD1Ruayd7dIXgT8vKF4DxTEi6Ed2CKJykC+HXpskNxj+i
   wjqrO/H7Qu1n4TfvV4D1cLx6Ca1s2atVjkQuzIPZarcgr6mzET6jeG0kn
   Qf+FdkC9AKQ+BZiGYYKACBiGitQY7BiDUgBOj5ZituYuKWQv3Q6tU65Ps
   YsuJh8Mu4Vq1EN4ZAoMt0jjFWR79wFV0r4v2y9v+Y1qrlZ2l6wmWbeced
   8IcT4f8Zczz11zTFgH0cpO6yrTnMb/Bew14QUetvH3bd/P1tDKDLLm5Ut
   w==;
X-CSE-ConnectionGUID: qub5apymSpW2DgBLGZLQCg==
X-CSE-MsgGUID: XXNeMvumTI2C4w2+oPHEtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502604"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502604"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:21 -0700
X-CSE-ConnectionGUID: FHVKe0erRWW625wtIt7iMw==
X-CSE-MsgGUID: V0Kh+QO9ReKaGhqe2P8MZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122962987"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2025 16:43:20 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v2 6/9] x86/fpu/apx: Define APX state component
Date: Thu, 20 Mar 2025 16:42:57 -0700
Message-ID: <20250320234301.8342-7-chang.seok.bae@intel.com>
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

The Advanced Performance Extensions (APX) feature flag was previously
defined. This feature is associated with a new state component number 19.
To support APX, it is essential to define this xstate component and
implement the necessary sanity checks.

Define the new component number, state name, and those register data
type. Then, extend the size checker to validate the register data type
and explicitly set the APX feature flag as a dependency for the new
component in xsave_cpuid_features[].

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
RFC-V1 -> RFC-V2:
* Remove the ordering table change, as it is now dynamically populated.
---
 arch/x86/include/asm/fpu/types.h | 9 +++++++++
 arch/x86/kernel/fpu/xstate.c     | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index de16862bf230..97310df3ea13 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -125,6 +125,7 @@ enum xfeature {
 	XFEATURE_RSRVD_COMP_16,
 	XFEATURE_XTILE_CFG,
 	XFEATURE_XTILE_DATA,
+	XFEATURE_APX,
 
 	XFEATURE_MAX,
 };
@@ -145,6 +146,7 @@ enum xfeature {
 #define XFEATURE_MASK_LBR		(1 << XFEATURE_LBR)
 #define XFEATURE_MASK_XTILE_CFG		(1 << XFEATURE_XTILE_CFG)
 #define XFEATURE_MASK_XTILE_DATA	(1 << XFEATURE_XTILE_DATA)
+#define XFEATURE_MASK_APX		(1 << XFEATURE_APX)
 
 #define XFEATURE_MASK_FPSSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
@@ -303,6 +305,13 @@ struct xtile_data {
 	struct reg_1024_byte		tmm;
 } __packed;
 
+/*
+ * State component 19: 8B extended general purpose register.
+ */
+struct apx_state {
+	u64				egpr[16];
+} __packed;
+
 /*
  * State component 10 is supervisor state used for context-switching the
  * PASID state.
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 46c45e2f2a5a..2a270683a762 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -63,6 +63,7 @@ static const char *xfeature_names[] =
 	"unknown xstate feature",
 	"AMX Tile config",
 	"AMX Tile data",
+	"APX registers",
 	"unknown xstate feature",
 };
 
@@ -81,6 +82,7 @@ static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
 	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
 	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
+	[XFEATURE_APX]				= X86_FEATURE_APX,
 };
 
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
@@ -570,6 +572,7 @@ static bool __init check_xstate_against_struct(int nr)
 	case XFEATURE_XTILE_CFG:  return XCHECK_SZ(sz, nr, struct xtile_cfg);
 	case XFEATURE_CET_USER:	  return XCHECK_SZ(sz, nr, struct cet_user_state);
 	case XFEATURE_XTILE_DATA: check_xtile_data_against_struct(sz); return true;
+	case XFEATURE_APX:        return XCHECK_SZ(sz, nr, struct apx_state);
 	default:
 		XSTATE_WARN_ON(1, "No structure for xstate: %d\n", nr);
 		return false;
-- 
2.45.2


