Return-Path: <linux-kernel+bounces-570532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50008A6B1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287E23BF02A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406671EDA00;
	Thu, 20 Mar 2025 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RK12fon3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0F22D786
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514206; cv=none; b=sskYeK1zBie2/OKAVUyDwwB60MZc9kuQmyuzd4hso9dPdJQt9AzlgYD8aiAVcnT+oOQ4x37U0U95vCpNF9GZtOVHz6lBPtcfr3W21xhhj4TBLxv17WqHTj1SsDtmFtUhhP6VYjHkvpfFPDejsKRSa0VjIW2yrHzxaO47b43YD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514206; c=relaxed/simple;
	bh=hUBrU2riw54JbGjbrObRF5oJyPterDJkVSk73+3ZkDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7qHX/f5wpdQjm3wfravIuzlw74TXwcZ6PjFdeRzTTw3uy1HSFNxk7dpk9p4MoEy5bep2rZmeFFdd5E/ypjXaWs47JY0XcHWRF0DSa+KGGgyAgndtTpF7uBIHBlB93AkuKhKxLC+I1j2eXPfm8NVU48geK3InSczOpfQq5lO2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RK12fon3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514203; x=1774050203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hUBrU2riw54JbGjbrObRF5oJyPterDJkVSk73+3ZkDw=;
  b=RK12fon3NjnFrRbLNmHrEBZN7Qv+Xx4SKxCqHu0wf97rj5ZdWmIKhUmd
   pY3EyKtjAMgXaU1xg9JZPticzkSzhUzA3h3nLh3DVi4x0Vq7c+u3itGmv
   wRRlymiGuUI5Vq2mZHxIxLDQbSYBZtnlJIgu10Xl3o0ZoQNbmDu508IOw
   ea69dA7sTL7FO/p5H6NRCyww62OiKAFkGypM+q6rCTDR2kWp2YqgPK1YX
   kkHpQUodrPJFlsuefGM54FICmr+0D3COmd7e2BMUngZ5Gxrps8njjV8hm
   W06jKK3uOjYZZoMAiBvMUWWnLIaivuCii3USy+neO8BWJwV+nNeJ/1rDA
   g==;
X-CSE-ConnectionGUID: 1C3z/Jj8TzyAdFsKCDOSEA==
X-CSE-MsgGUID: nYsxH3w5S+Wue64+L+8vBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502609"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502609"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:23 -0700
X-CSE-ConnectionGUID: 277gBNJORLmXDYbuQt+Gzw==
X-CSE-MsgGUID: bCEIsnlKSC+KE4Apug0AvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122962991"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2025 16:43:23 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v2 7/9] x86/fpu/apx: Disallow conflicting MPX presence
Date: Thu, 20 Mar 2025 16:42:58 -0700
Message-ID: <20250320234301.8342-8-chang.seok.bae@intel.com>
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

APX is introduced as xstate component 19, following AMX. However, in the
non-compacted format, its offset overlaps with the space previously
occupied by the now-deprecated MPX:

  45fc24e89b7c ("x86/mpx: remove MPX from arch/x86")

To prevent conflicts, the kernel must ensure the CPU never expose both
features at the same time. If so, it indicates unreliable hardware. In
such cases, XSAVE should be disabled entirely as a precautionary measure.

Add a sanity check to detect this condition and disable XSAVE if an
invalid hardware configuration is identified.

Note: MPX state components remain enabled on legacy systems solely for
KVM guest support.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 2a270683a762..0d68d5c4bc48 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -814,6 +814,17 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	if (fpu_kernel_cfg.max_features & XFEATURE_MASK_APX &&
+	    fpu_kernel_cfg.max_features & (XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR)) {
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


