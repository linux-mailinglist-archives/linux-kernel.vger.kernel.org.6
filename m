Return-Path: <linux-kernel+bounces-543221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6659A4D2E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104673AE245
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FE31F4723;
	Tue,  4 Mar 2025 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsqv8id0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C61F4703
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741065605; cv=none; b=A3W3lz9YISmtswxP87AEiHyDPFYFdgQlPsf2U14Nmbio4LttAelyXqkiVeOl/H8bPLSHj1W5BxyWFaT47PzYvTHKplfQDJhzeeTQU96XeM0yBVHHRG0XiRZgzwUvJB/MuMb9BdcNh6s8BI2ykS2geHyAnvWmcKGwHybHCz7lkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741065605; c=relaxed/simple;
	bh=mYJSSAXw5nF44zGFCWonQB1kAY5wPI7TG1wREGSaH9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CIDsYtISAg01UlaemxaVzL/dqh87uUB++LQmo5SLG7ZZKPpwGryFCwNabd2LG0uZWDsT29qDfGzk/fK5+5tY55zp/Lii/kZAdT0jAbA3cK9aBkXLNrOpY+XoEIrgurujIDlbepFchbiDvC1XkDNYKMOBibpTHvuiQSFh2vyZLFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsqv8id0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741065604; x=1772601604;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mYJSSAXw5nF44zGFCWonQB1kAY5wPI7TG1wREGSaH9g=;
  b=dsqv8id0k6+n1AUN0nMj/bo6L51VJBgXDwCaLbHAEwURFw4YL5ehxAx+
   6IS9Mc64H/zlg/BnFaXJAcIQpI3sffpqRqVAF5+//lFZUhr7H3EKGaKLv
   N2e2Agq6G2lnj8O3BVbiCYk32Be+RVvwFa6CFqzwtPZRvsDk+f//wHoXb
   Y1Ju6nznswdRIr1aY7la2SdaJW+V1pn1nuqCtgzASTVn8/Xpb1JOEj9QM
   /wkMYPKUjb9/kdUGQtrcD3/XuHBGFwWygW82ebuyTrV7dnWRhWZWPbQ8b
   C8k1rDbd8aqQbr4VPZBG6qCj1bPmijMsuUCxfnkV5nV9XpTum4vPLvNH3
   w==;
X-CSE-ConnectionGUID: 4EDFA+OjSGaSWpWdWBwzEA==
X-CSE-MsgGUID: iGBPCCtmTuCwpoIywmRBGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41876077"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41876077"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 21:20:03 -0800
X-CSE-ConnectionGUID: l7KH9WSOR8Kxo3Ufvv3x1Q==
X-CSE-MsgGUID: vWkbHxZ0Q/mLbqKSjwepNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118424428"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.44])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 21:20:02 -0800
From: Zide Chen <zide.chen@intel.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	artem.bityutskiy@linux.intel.com,
	rui.zhang@intel.com,
	Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH] perf/x86/intel/cstate: Add Clearwater Forest support
Date: Mon,  3 Mar 2025 21:16:18 -0800
Message-Id: <20250304051618.79198-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenyu Wang <zhenyuw.linux@gmail.com>

Clearwater Forest is based on Darkmont Atom microarchitecture.  From
the C-states residency profiling's perspetive, it supports the same
residency counters as Sierra Forrest: CC1/CC6, PC2/PC6 and MC6.

Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index ae4ec16156bb..028557210e23 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -627,6 +627,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&srf_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&grr_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&srf_cstates),
 
 	X86_MATCH_VFM(INTEL_ICELAKE_L,		&icl_cstates),
 	X86_MATCH_VFM(INTEL_ICELAKE,		&icl_cstates),
-- 
2.34.1


