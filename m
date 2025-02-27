Return-Path: <linux-kernel+bounces-537105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECCFA48817
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605E3188AC28
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237B26E956;
	Thu, 27 Feb 2025 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EftE+tCO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C726E62B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681914; cv=none; b=VpLklKYmnO335Ex0Xjuoi7mR3v42vZqDYNF1DdVEAP/4HTyrCbI/B2X7X0TcDT1Ag6qocNncPlCGvceScZ//CH+zWqUjp8LELttp/s/kz4YgDHWAx33uaagbC1uvRR1+qYTuqX9iFRFznZwCKB5qIRM2/hYw7Yf74ZFZPW0THik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681914; c=relaxed/simple;
	bh=REmHNjR8Fo9U3fYKvVBoHL/0BHoODOVa27a+IerHqUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc9l35tM8pfpniO9s2gzGdx1BIMa1hKuAX2GGIj+W+oj0tVmfZKqHGz7jjJnwocA78XNB+AiDVb0+5xlbKREyk9NcQ7EYV5fanmjU5JSGWs/oe/XZRVu6acCXNqFt35rmTJX7xu196ATlt6PAz6DToOBQmSFKby462rj1lmX/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EftE+tCO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681913; x=1772217913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=REmHNjR8Fo9U3fYKvVBoHL/0BHoODOVa27a+IerHqUk=;
  b=EftE+tCO3ZHfIqFPqhAmSHcA/dpSuA+tlNKD1mjubRh3DKPnojLe/sTq
   IhDVOPN0nWPB3B2rt+dl+rO6dKWWPYc/ijSMjZj1WfCh7xIvvzsJKEswO
   ejYt1SjJFGMv34yWbI/cYT02/vuWezdL53yStUxTxkEQ3p9mCiXwxtz/k
   CLVebpeNtCSpRGYVmBQGnNWIIUUzvEjtdfDuJoGkYWfgcp/HZBTzLpTFP
   Oh9gpmLLMdJK08MeRg9Umb3wZCRFh8nUiQHfcT+js7Pj/j9eYt9WCayuF
   K9rbunk1UfwJK6n4oeLqQQpXn8PqI7FWEMDYMecPBJMODaRzIyrulhW/6
   g==;
X-CSE-ConnectionGUID: lIjasAn6TTe/hWXjpDWydA==
X-CSE-MsgGUID: NigtH3fpSl+m5IsLVJqHeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720904"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720904"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:12 -0800
X-CSE-ConnectionGUID: zh9BqUzTRuG+gw+WMqsJ6A==
X-CSE-MsgGUID: cz0J8MLzTG6PXRjyUSVrgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767424"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:11 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 08/11] x86/fpu/apx: Define APX state component
Date: Thu, 27 Feb 2025 10:44:53 -0800
Message-ID: <20250227184502.10288-9-chang.seok.bae@intel.com>
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

Previously, Advanced Performance Extensions (APX) feature flag was
defined. The feature is associated with a new state component number 19.
Considering the feature support, it is essential to identify the new
xstate component and implement necessary sanity checks.

Define the new component number, the state naming, and those registers'
data type. Then, extend the size checker to ensure correct validation of
the register data type and explicitly sets the APX feature flag as a
dependency for the new component in xsave_cpuid_features[].

Include APX in xfeature_noncompact_order[]. Notably, this out-of-order
placement demonstrates the practical value of the feature order table.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/include/asm/fpu/types.h | 9 +++++++++
 arch/x86/kernel/fpu/xstate.c     | 4 ++++
 2 files changed, 13 insertions(+)

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
index 16f45fff8811..6a6f0e78e2c3 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -62,6 +62,7 @@ static const char *xfeature_names[] =
 	"unknown xstate feature",
 	"AMX Tile config",
 	"AMX Tile data",
+	"APX registers",
 	"unknown xstate feature",
 };
 
@@ -78,6 +79,7 @@ static unsigned short xsave_cpuid_features[] __initdata = {
 	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
 	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
 	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
+	[XFEATURE_APX]				= X86_FEATURE_APX,
 };
 
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
@@ -99,6 +101,7 @@ static const enum xfeature xfeature_noncompact_order[] = {
 	XFEATURE_FP,
 	XFEATURE_SSE,
 	XFEATURE_YMM,
+	XFEATURE_APX,		/* Out-of-order feature */
 	XFEATURE_OPMASK,
 	XFEATURE_ZMM_Hi256,
 	XFEATURE_Hi16_ZMM,
@@ -557,6 +560,7 @@ static bool __init check_xstate_against_struct(int nr)
 	case XFEATURE_XTILE_CFG:  return XCHECK_SZ(sz, nr, struct xtile_cfg);
 	case XFEATURE_CET_USER:	  return XCHECK_SZ(sz, nr, struct cet_user_state);
 	case XFEATURE_XTILE_DATA: check_xtile_data_against_struct(sz); return true;
+	case XFEATURE_APX:        return XCHECK_SZ(sz, nr, struct apx_state);
 	default:
 		XSTATE_WARN_ON(1, "No structure for xstate: %d\n", nr);
 		return false;
-- 
2.45.2


