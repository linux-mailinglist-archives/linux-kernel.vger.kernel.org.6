Return-Path: <linux-kernel+bounces-258307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A94938610
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 22:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32151C2091C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 20:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB116C6AB;
	Sun, 21 Jul 2024 20:21:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E02B16B748;
	Sun, 21 Jul 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721593302; cv=none; b=YU0py06KUM3seWU4MaMPMiI4G813jo/wa5boMzjJjtoDmvzjAvuIsYrYNvuKrFgpQxPsO+zakoKU2/GebUXf95LiS2a3mPO4XXP6KRQOcuvjmG5bXsfHA5LFW2VRU+Iqq5vxC+UXB00lsao/Z24c1gSFUaFGiuAkrqaqpF7Mwx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721593302; c=relaxed/simple;
	bh=QCskOjoelAR8tSAW21Y50GMX3Wwb3ImxoRkugiEIraU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QhEc+rPgKcoTW0Fcw6SEcQSWhOnQ1YRcjg8/TFIQHJG7+tnUSjlQj4vQbJPZBIFge2LdW4l066zipYwVdI6F8ifN/4jBBjgEqZeXMgf8/YC7mt2P0B7T4I8wkwETWdUw2HMnOhtFSqThRV7FJrafURIvwSeNjyYJ4VRAIRE0958=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08A2511FB;
	Sun, 21 Jul 2024 13:22:01 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CF023F73F;
	Sun, 21 Jul 2024 13:21:32 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 2/6] perf auxtrace arm: Set the 'auxtrace' flag for AUX events
Date: Sun, 21 Jul 2024 21:21:09 +0100
Message-Id: <20240721202113.380750-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721202113.380750-1-leo.yan@arm.com>
References: <20240721202113.380750-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally, the 'auxtrace' flag in the PMU event is used for AUX area
sampling. It indicates a PMU event is for AUX tracing.

Set this flag for AUX trace events on Arm.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm/util/pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 1c9541d01722..b7fa1245e242 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -25,6 +25,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 		/* add ETM default config here */
 		pmu->selectable = true;
 		pmu->perf_event_attr_init_default = cs_etm_get_default_config;
+		pmu->auxtrace = true;
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
 		pmu->selectable = true;
@@ -32,8 +33,10 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
 		if (strstarts(pmu->name, "arm_spe_"))
 			pmu->mem_events = perf_mem_events_arm;
+		pmu->auxtrace = true;
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
 		pmu->selectable = true;
+		pmu->auxtrace = true;
 #endif
 	}
 #endif
-- 
2.34.1


