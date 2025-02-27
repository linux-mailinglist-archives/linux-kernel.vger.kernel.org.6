Return-Path: <linux-kernel+bounces-537106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07130A48818
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E867A66B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078B26E97B;
	Thu, 27 Feb 2025 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KttnG9L6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917AD26E654
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681915; cv=none; b=rhNTrm15XB2Dsh2JCff/iqOUBvTT0xoyLhLBoh32bmy+Qs4GN6D3vBPd1Hbjv3rlsv4TPiPvnszhZdH26++1PubPWk1UGQNX3m+9bcwiMa9pC679PWi+6NzCNDGzSAgzP2q0O5zMPvjDZowDrLfLCX4jsXpJJJVFujCr0ofOR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681915; c=relaxed/simple;
	bh=FuZDfr0iMvg+YyvQyryZ01+Rs/T97pmuvT6UOiJxHPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9AxXQsg8juKG5pRew4ZoJEyVYMzmDfPq84B+VQryVVtr2Ji52/5EMJc36i3AjjeVhJJwl+e0xV/R+jnYQOJFngU/I7VUQOMct9Z/jAshtN+8JX9i9wMNX038fZwqCTZbT4xYn/5YHXnHpVPSDbQDUnJEk2MAHItf4Y7v/XFcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KttnG9L6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681914; x=1772217914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FuZDfr0iMvg+YyvQyryZ01+Rs/T97pmuvT6UOiJxHPI=;
  b=KttnG9L6pIgQ5imrOgxPNmLYdPXA6/vCPjl/ltlpPJyWwUJ0nlN+D7GR
   umVuM+skLYfaWjZov0SZZ30mKmLB+7zJ0p8jouruNSqpO+ZQKuMSzl9/7
   nkEVLmxnDpQb6/SB2NpTXIb83ua9soRlu/FGzNGrTxHbHw2xXcg6ymrcq
   HxS2aJXwExp4OnJRw8P8I9tVYcSknp25GG+fbp08ycm7iFwLsMuEMjgpD
   bbrVrQJPbHhePcrn7TPsSG721axP+0gU4WE0Z3m0Qs3SKo6RDwkHvRvby
   4w3HYNm5LIvOWJ5xFpoBS+TDkZbSBMnsUEdzw97dZvnQiBy47xt0pKyRm
   g==;
X-CSE-ConnectionGUID: BqfR1iqGTcq42LDE/rwo5g==
X-CSE-MsgGUID: 2r6sSyAkSc2IcLy9DrTY2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720912"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720912"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:13 -0800
X-CSE-ConnectionGUID: zTFsV2QMTyiCZQqg1IH8Ug==
X-CSE-MsgGUID: 9m5tbQwYRuKtT1UF1eFXrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767433"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:13 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 09/11] x86/fpu/apx: Disallow conflicting MPX presence
Date: Thu, 27 Feb 2025 10:44:54 -0800
Message-ID: <20250227184502.10288-10-chang.seok.bae@intel.com>
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

APX is introduced as xstate component 19, following AMX. However, its
offset in the non-compacted format overlaps with the area previously
occupied by the now-removed MPX. As they cannot coexist, MPX support was
removed from the kernel.

Despite this, the kernel must ensure the CPU never expose both features
at the same time. If so, it indicates unreliable hardware. In such cases,
XSAVE should be disabled entirely as a precautionary measure.

Add a sanity check to detect this condition and disable XSAVE if an
invalid hardware configuration is identified.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 6a6f0e78e2c3..0f731e11c414 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -802,6 +802,17 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	if (fpu_kernel_cfg.max_features & XFEATURE_MASK_APX &&
+	    fpu_kernel_cfg.max_features & XFEATURE_MASK_BNDREGS) {
+		/*
+		 * This is a problematic CPU configuration where two
+		 * conflicting state components are both enumerated.
+		 */
+		pr_err("x86/fpu: both APX and MPX present in the CPU's xstate features: 0x%llx.\n",
+		       fpu_kernel_cfg.max_features);
+		goto out_disable;
+	}
+
 	fpu_kernel_cfg.independent_features = fpu_kernel_cfg.max_features &
 					      XFEATURE_MASK_INDEPENDENT;
 
-- 
2.45.2


