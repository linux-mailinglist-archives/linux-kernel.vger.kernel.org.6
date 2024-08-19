Return-Path: <linux-kernel+bounces-291758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D22F7956676
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883F01F226D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C5C15B97E;
	Mon, 19 Aug 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHR+RYjV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430515C121
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058717; cv=none; b=FyskF/x4Klw8fpUsQsWVXORbRRg0EqM9Aj/BI6K6K7FmtYcSUmIn/hpKTewAEAr7fM0xOQmkZb+ETCUOqNJryN7vkjDhrxV8ihz5kjx0bAzjMctW0pknCeLTV7+zOscIRr/YRbRfzEPG0Ol1slny3X2wCkzkDDMwebBJQsp86Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058717; c=relaxed/simple;
	bh=wlaugqbw3LFf3hmhiS7UUatTrBz9k3GzQCs168nS3Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tvmpam1nXzCx8Whh/kswr7fN0IZMfreDk2meSDDBb/wcwO0f1QXYHq3sPxAnKhoMIqgW0jOV7B30rNOv8/MRHB6NV1DHtYmQz6Pc7a8LOB7ZBPiftXo5wbyfHXTwi8qRkbN81+zWS3PqAtDkxYKsc4yWtzZzBRmDYE2DeSxqY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHR+RYjV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724058716; x=1755594716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wlaugqbw3LFf3hmhiS7UUatTrBz9k3GzQCs168nS3Vs=;
  b=hHR+RYjVOVHZ/QXhH0t/lbEhOmkTE1VnSGHUAND3Rq3Hq7UfH3nEBAam
   LUKWu2Vm4vHefcOLdtvRBNnbHCCVNkFWSEmF9VKeA2baL+UcicTQpc2B+
   Du+M4lr7W/1Jll1sf74cTnbvQK9aHLq3Ur02bVO6GM9FZFcUxKehVMAxh
   XervUSUMCrqBnFefXmwXlRNNETrxOOLuEqOQnM9LaccuLg0dO//sGxxm3
   Dr7422Z4RqgNBYAFQvEnBh200JN72V8FbbpN59CbI3DxtoHwZnnBVSYF8
   w/qobgYSIX0IsVQdzU9LKs0pwu53pBKm9fr0uXKk8yNp3PZCsprtWYN0c
   A==;
X-CSE-ConnectionGUID: WNm/Ap8sR8+JfxKSDnvFLw==
X-CSE-MsgGUID: 8sYL9CPdSB6zCMOX0qkD2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33446093"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33446093"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 02:11:56 -0700
X-CSE-ConnectionGUID: W1oaOVW6R6u/ZQQloCG1Iw==
X-CSE-MsgGUID: J5Kqa7UcT/Kc6X5HSZZ1rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="61086706"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa008.jf.intel.com with ESMTP; 19 Aug 2024 02:11:54 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 1/4] perf/x86: Refine hybrid_pmu_type defination
Date: Mon, 19 Aug 2024 14:55:40 +0000
Message-Id: <20240819145543.1833126-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240819145543.1833126-1-dapeng1.mi@linux.intel.com>
References: <20240819145543.1833126-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use macros instead of magic number to define hybrid_pmu_type and remove
X86_HYBRID_NUM_PMUS since it's never used.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/events/perf_event.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ac1182141bf6..fdd7d0369d42 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -674,19 +674,17 @@ enum hybrid_cpu_type {
 	HYBRID_INTEL_CORE	= 0x40,
 };
 
+#define X86_HYBRID_PMU_ATOM_IDX		0
+#define X86_HYBRID_PMU_CORE_IDX		1
+
 enum hybrid_pmu_type {
 	not_hybrid,
-	hybrid_small		= BIT(0),
-	hybrid_big		= BIT(1),
+	hybrid_small		= BIT(X86_HYBRID_PMU_ATOM_IDX),
+	hybrid_big		= BIT(X86_HYBRID_PMU_CORE_IDX),
 
 	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
 };
 
-#define X86_HYBRID_PMU_ATOM_IDX		0
-#define X86_HYBRID_PMU_CORE_IDX		1
-
-#define X86_HYBRID_NUM_PMUS		2
-
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
-- 
2.40.1


