Return-Path: <linux-kernel+bounces-537098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE1A4880E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A16168636
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3F926BD8C;
	Thu, 27 Feb 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8E6iiwV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9C21DB951
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681907; cv=none; b=hqS5HC9ZB0/tisMLxIpzQPPsLH/9aWq9x/6hd6VzwQF30wYy+F7ic+/lFtgXF2hcoCUp6Uw3m2oCHKUJDX1H5RBHVmX8hth+t9VhYjjJEXtX/ls4/Mz7Q1IGV0gyYXUyfJgq2X1BNi1Q/rd6oHpUrJU61ABuMXy5mL/8T1HY9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681907; c=relaxed/simple;
	bh=AmRvvFfOyTl10D2JcoNSvocA7vsRifO+isIesvxtbaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5OtlpsVUGAcpgB90lXCteynm+YGhQmaQgdykhWrTuJ7WboDqX8l41uq8UPu62hotRbISNIWbypT182N6ucI4weWjNio2fJR9Hg4hgXJmEpoiyeNR4YgS5XC35X3HcS2ax0OyzZ5KltvvzHr+SVpeAJzMsjHJUUnE4HNygF/JUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8E6iiwV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681906; x=1772217906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmRvvFfOyTl10D2JcoNSvocA7vsRifO+isIesvxtbaU=;
  b=C8E6iiwV7YdYNU0orUmlyR5chPiEqjNjGbvLcaBSYkrPoPiLle4ETmOI
   xt+3+eJOWVBId9FiFxuxl7POZWs1dXqRoZz2ocTuOjD4xkz/vsn8NvhBp
   nhQgyuQolP+frrZ+DH95x7Dd0w0JrGpO3mSyxgNCuAr9sO4BliXE0pVKI
   gTAI2QdxVVsxmUNQSdPx628T3yhqKAFfufM2fqMXCM4jp0HOrT9rdKF1y
   rLbCH+Es6bLMG8OXKpkSovA8b/Kj/++ODuLQNIaLrYw5roWnYkUplRd5m
   4ZUQ9qYF3k3SMLhFSHm/9MJ4Kk+VkhqCh66JI2sNKI98gVK9F2iVSNNCV
   Q==;
X-CSE-ConnectionGUID: R6q+X4A5SIysHgfhPdQh8g==
X-CSE-MsgGUID: LqJuuvxhTceXZ1cuxuehuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720858"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720858"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:06 -0800
X-CSE-ConnectionGUID: AEn5FupTRuqlqcQFdyZ85Q==
X-CSE-MsgGUID: u6LORMWMS7C/ivfGXo2pgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767371"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:04 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 01/11] x86/fpu/xstate: Simplify print_xstate_features()
Date: Thu, 27 Feb 2025 10:44:46 -0800
Message-ID: <20250227184502.10288-2-chang.seok.bae@intel.com>
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

print_xstate_features() currently invokes print_xstate_feature() multiple
times on separate lines, which can be simplified in a loop.

print_xstate_feature() already checks the feature's enabled status and is
only called within print_xstate_features(). Inline print_xstate_feature()
and iterate over features in a loop to streamline the enabling message.

No functional changes.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
I find it difficult to justify using separate lines for printing when
they can be efficiently grouped under a simple for-loop. While this
cleanup isn't directly related to APX, it felt like a necessary
improvement, especially when new xstates are introduced.
---
 arch/x86/kernel/fpu/xstate.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 27417b685c1d..6a41d1610d8b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -259,32 +259,20 @@ static void __init setup_xstate_cache(void)
 	}
 }
 
-static void __init print_xstate_feature(u64 xstate_mask)
-{
-	const char *feature_name;
-
-	if (cpu_has_xfeatures(xstate_mask, &feature_name))
-		pr_info("x86/fpu: Supporting XSAVE feature 0x%03Lx: '%s'\n", xstate_mask, feature_name);
-}
-
 /*
  * Print out all the supported xstate features:
  */
 static void __init print_xstate_features(void)
 {
-	print_xstate_feature(XFEATURE_MASK_FP);
-	print_xstate_feature(XFEATURE_MASK_SSE);
-	print_xstate_feature(XFEATURE_MASK_YMM);
-	print_xstate_feature(XFEATURE_MASK_BNDREGS);
-	print_xstate_feature(XFEATURE_MASK_BNDCSR);
-	print_xstate_feature(XFEATURE_MASK_OPMASK);
-	print_xstate_feature(XFEATURE_MASK_ZMM_Hi256);
-	print_xstate_feature(XFEATURE_MASK_Hi16_ZMM);
-	print_xstate_feature(XFEATURE_MASK_PKRU);
-	print_xstate_feature(XFEATURE_MASK_PASID);
-	print_xstate_feature(XFEATURE_MASK_CET_USER);
-	print_xstate_feature(XFEATURE_MASK_XTILE_CFG);
-	print_xstate_feature(XFEATURE_MASK_XTILE_DATA);
+	int i;
+
+	for (i = 0; i < XFEATURE_MAX; i++) {
+		u64 mask = BIT_ULL(i);
+		const char *name;
+
+		if (cpu_has_xfeatures(mask, &name))
+			pr_info("x86/fpu: Supporting XSAVE feature 0x%03Lx: '%s'\n", mask, name);
+	}
 }
 
 /*
-- 
2.45.2


