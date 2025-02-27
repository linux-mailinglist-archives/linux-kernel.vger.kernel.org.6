Return-Path: <linux-kernel+bounces-537101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDAA48813
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1EE188BF00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924AB26E16C;
	Thu, 27 Feb 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N6qHBZRB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045426D5A9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681911; cv=none; b=C/B2GVvJ4NYdRABpevX9mBRFU75K/DUFFzJcC+QhX7WBa4wsTOt/+2yyYE6lm7RX6j9AR/vnormSi+uugOV7NR0bGTZLfY53YQPyxpUYYDL9D5xsUpsNtyx/98MrcPJhepYzOMYY7xrwnDsFhrIxolshvgZasHE0O6rBDbgHxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681911; c=relaxed/simple;
	bh=j+BCRed+9G0JDy4ms61fhOSISvI8yxPsmuGYZ95UX3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMgHugPNOhLAK7FGtknmzS1LHvubo8K1XR8C1FDP0KoKcwkHMJVDMDCMK2IPYQ1H56XDmD9/OJCFHlOMhToLC3iEaGgbsf37TDa3iEkKzdmG9sEU0vxhyYyqO0vWgKKHovPoPaZp513FUjhtw/Ulyy7BVYGPkdp3O87ZKDaI2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N6qHBZRB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681909; x=1772217909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j+BCRed+9G0JDy4ms61fhOSISvI8yxPsmuGYZ95UX3Q=;
  b=N6qHBZRBFh8k6IvIYdev74aU4kCcB9l2CoFv3swOSyR83xnzy0vvNI8D
   f0EAom5Lbgg5y+REz2ZGXS7Pq4X1UZDZxIWR4XzT8RFp8rVv0mCu2I4za
   5lEG0ZjFMdmxg2+fRmD1fFJTug1QWAo25aXoGTox4fFHR3sCpGhTmeELk
   I3axDKpXtX0+InWLGUhcQgUGZeK5RBz0Q7co9ieVMN4dKvt7ibWuxAEjs
   yiMYZy9ODJQWKY7F0C5Cn9hQuT6zNa6U6tQGzDd18mF3kE58jAAJDzE77
   8Gtw0l26yd2klPijSLiN7y8ipI+vVz1UhHvzGZ6EymKrTPGTkxxwu9bwg
   A==;
X-CSE-ConnectionGUID: WbMJyKLiQXaSmdxXCgSuFw==
X-CSE-MsgGUID: Gj7IxRXWS8WfTeieh3KIgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720876"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720876"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:08 -0800
X-CSE-ConnectionGUID: 5M9e5LwFR1uJZ4dkZtgwmA==
X-CSE-MsgGUID: x4ujSbY5SMqrFq6If0Ct0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767396"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:08 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 04/11] x86/fpu/xstate: Adjust XSAVE buffer size calculation
Date: Thu, 27 Feb 2025 10:44:49 -0800
Message-ID: <20250227184502.10288-5-chang.seok.bae@intel.com>
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

The current xstate size calculation assumes that the highest-numbered
xstate feature has the highest offset in the buffer, determining the size
based on the topmost bit in the feature mask. However, this assumption is
not architecturally guaranteed -- higher-numbered features may have lower
offsets.

With the introduction of the xfeature order table and its helper macro,
xstate components can now be traversed in their positional order. Update
the non-compacted format handling to iterate through the table to
determine the last-positioned feature. Then, set the offset accordingly.

Since size calculation primarily occurs during initialization or in
non-critical paths, looping to find the last feature is not expected to
have a meaningful performance impact.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c6f825bb744b..06d2be602ea9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -576,13 +576,20 @@ static bool __init check_xstate_against_struct(int nr)
 static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 {
 	unsigned int topmost = fls64(xfeatures) -  1;
-	unsigned int offset = xstate_offsets[topmost];
+	unsigned int offset, i;
 
 	if (topmost <= XFEATURE_SSE)
 		return sizeof(struct xregs_state);
 
-	if (compacted)
+	if (compacted) {
 		offset = xfeature_get_offset(xfeatures, topmost);
+	} else {
+		/* Walk through the xfeature order to pick the last */
+		for_each_extended_xfeature_in_order(i, xfeatures)
+			topmost = xfeature_noncompact_order[i];
+		offset = xstate_offsets[topmost];
+	}
+
 	return offset + xstate_sizes[topmost];
 }
 
-- 
2.45.2


