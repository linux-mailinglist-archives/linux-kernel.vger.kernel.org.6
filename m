Return-Path: <linux-kernel+bounces-417307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1421D9D5247
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E65828223E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BDC158A33;
	Thu, 21 Nov 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLrqylnR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4271AA1D4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 18:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212273; cv=none; b=mIFNJHJRqblkkHAiiDtpK5g/uWalYDUdANZjpILrunWjDv744lIbSa8XkFe3XanIlA3h46EdS2za4UG6mB7tPiNI2vax8oeZmPA3koGtRfE7SvanLPQXf46XjY/SAAoNKVwAeuVvXOvGf7ppABQR5h3MUgC5uJfLDNDqT6ECetk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212273; c=relaxed/simple;
	bh=FdN4QpUgFwDpPphzHWE0oTIPuxj47EiZ4BexOKoPyAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gYGVDXcNQ5n8s2AsV0uSfI9g0sUr5UDdXQIHFFd6h5f6PV0jNe2OAW0aAa8j48hlkFLb7KU9rYjgBLBZv9QEMftCJn7jWj+1NbYkN7ceNhqu2mqaL78QQQ54pPXvB9fVqZG/P4YsOxv0KkjD+Hc9kzFNS+KLCzmeUQZkpQ/WnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLrqylnR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732212272; x=1763748272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FdN4QpUgFwDpPphzHWE0oTIPuxj47EiZ4BexOKoPyAI=;
  b=DLrqylnRdVA2WFoaTbpgJudRZzWIDJijwWlUH6alr0L4Jb6GNJzF6HTJ
   oEtb1DVazHd8zBq0rxf5bwq/E+XqHiLWYvS3EhJiRmt4qCTeVcyNwQogs
   +Ds6f+zFwrp4T3nOVxL+6pqntjMHO12sb8jn1gTCj7keg1Ypb7nuXDcQ4
   GwiJwe3InBLkNANxW65xwSe6F9OigttFzR7MKTc67fjAmQkOfnenYurEh
   niI3vp5uX1+vENC5sulOdOwuhokpCPLzWzXnHd9b2gxHY6jRetMzZ6TKp
   k+uiAuxxAURGFolviIz7sfNZTMAAOYysFPVRpZH3icqC0qqBB/ZO5PzV4
   A==;
X-CSE-ConnectionGUID: UcoeVaIBT1KPTkDFAlLuqA==
X-CSE-MsgGUID: rchPjJ6XTMi4SRVVD70WFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43408049"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="43408049"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 10:04:31 -0800
X-CSE-ConnectionGUID: psFAniG6TauLiq8GRGN+Nw==
X-CSE-MsgGUID: mQs296gnQRqfYSWxeKqlSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90132452"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa007.fm.intel.com with ESMTP; 21 Nov 2024 10:04:30 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	qzhao@redhat.com,
	mpetlan@redhat.com,
	vmolnaro@redhat.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Add Arrow Lake U support
Date: Thu, 21 Nov 2024 10:05:26 -0800
Message-Id: <20241121180526.2364759-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

From PMU's perspective, the new Arrow Lake U is the same as the
Meteor Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a7d92e70e756..23104dc9a599 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7534,6 +7534,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_METEORLAKE:
 	case INTEL_METEORLAKE_L:
+	case INTEL_ARROWLAKE_U:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
 		x86_pmu.pebs_latency_data = cmt_latency_data;
-- 
2.38.1


