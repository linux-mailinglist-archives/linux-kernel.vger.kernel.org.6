Return-Path: <linux-kernel+bounces-293140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078C9957B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A24D1C22FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6192C18C;
	Tue, 20 Aug 2024 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MehpYpiq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9F91BF58
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724118936; cv=none; b=hjvelmtMc4l7JVPMNQmk/CLmI2OBd1w0tMbFsqstyM7JddBhAx6FN6605jf6OCQNSTIdDjVdb4/msIGvSrJ4lgBEaNOeFKwqOSjwQqjqqZXXF24sPxH6DZRE4+F4FqmY6y5Bug/6IIemA++YKMGxodS6YrFk4i8uiN1LwP05QNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724118936; c=relaxed/simple;
	bh=fcvXFnZb2J9/BJD4GIRJxboaymwEMjVV+c4HK73tXzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sct+WtqFkIGyDXLcOUP2lMTQr/aAOB6J87Ol9m846LNWSjW1xykdqHDzO4doZ2MsVd0vCgFhtdN+I22UjA6gmRAT0pvscXx7kmLP0MY4i57VUuaxk8kSYwWOXH9/RTPG8BGLMv0s3shUVRvrBA4D/be19Kyo9RWi6WEiFmIhmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MehpYpiq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724118935; x=1755654935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fcvXFnZb2J9/BJD4GIRJxboaymwEMjVV+c4HK73tXzM=;
  b=MehpYpiqSCe9GVaFeAnmhhhE7DPArbdwoa6R0t1oSfNa5M+iB7AFnQEj
   hGG8vxprBuaxyh3kJkggSBp68fkc4VLKQvIHg7X1ptbK3yVXD1GfyDxWu
   Wl7nbIIs/emQXjw7bxUv4aoD7lK1YFuyFSsFt0Wrfs4tjVx7VNT8S39I3
   I8D7o0hX5e9gToHa/4A4nBHgEtclb+QSWvthsI9zcrkHBn/qcnKWwopMx
   Bqz8P3O4AGQMgpQUaQSHciJYo8CIZF6KLSShB3AhLgIKNsEIhKD8MPL6B
   JtSQwmg8k37gDb1ANu0uvCckv7cXpYSIn5CgFQC9D9T2TfXKkOnVHwWCZ
   w==;
X-CSE-ConnectionGUID: 6TSzwOImQw2S7HKyESlE9Q==
X-CSE-MsgGUID: eiXSh2t2TFaMo5yT1oYShA==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="26191778"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="26191778"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 18:55:35 -0700
X-CSE-ConnectionGUID: VcusfswFRs6tYL/i+f9Qcg==
X-CSE-MsgGUID: uo0vGZedSjePCZ9ss6Veqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="83759627"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa002.fm.intel.com with ESMTP; 19 Aug 2024 18:55:31 -0700
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
Subject: [Patch v3 1/4] perf/x86: Refine hybrid_pmu_type defination
Date: Tue, 20 Aug 2024 07:38:50 +0000
Message-Id: <20240820073853.1974746-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820073853.1974746-1-dapeng1.mi@linux.intel.com>
References: <20240820073853.1974746-1-dapeng1.mi@linux.intel.com>
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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


