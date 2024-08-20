Return-Path: <linux-kernel+bounces-294484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0555A958E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB733286217
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE61662EF;
	Tue, 20 Aug 2024 18:47:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE6D161311;
	Tue, 20 Aug 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179677; cv=none; b=LOneQqXUl7RPXAvWpTCxbwhvqRW9B86y8r2FupZn0GPAA59dkVFUyiFOLK8vLc1z5DpybvtHwlpLMBdn/SVn8j7m9CTX1OunZhQUTR4dIBVKZDqbaPw3vCZ63vDDDRc943EH7e+QbZ0Hq+4l5CRuAjvJpOOdkJ2JZPTBHxuhOvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179677; c=relaxed/simple;
	bh=obz0C+FpcdM6N6VsfsEmviC3TU3bTDwL9sKihig86y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pG26+eZVcJZ4P/q5BP9mFydIuRaSrid/OTTUqcsBQ2iXsrII3i4+LtrN8x3dz1yFiIViZqDuA9KvS7juS2L+JIlGb+f3MffbLCZZNiKtIibD42L8Y7XIUTT0kumKMv6Vifwqb+QohPvbleIrQyB5oyUOndBxJE6F9+OFJ4RDNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4E5BDA7;
	Tue, 20 Aug 2024 11:48:21 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D11CB3F58B;
	Tue, 20 Aug 2024 11:47:52 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v5 3/8] perf auxtrace: Remove unused 'pmu' pointer from struct auxtrace_record
Date: Tue, 20 Aug 2024 19:47:26 +0100
Message-Id: <20240820184731.2937551-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820184731.2937551-1-leo.yan@arm.com>
References: <20240820184731.2937551-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'pmu' pointer in the auxtrace_record structure is not used after
support multiple AUX events, remove it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/arm/util/cs-etm.c     | 1 -
 tools/perf/arch/arm64/util/arm-spe.c  | 1 -
 tools/perf/arch/arm64/util/hisi-ptt.c | 1 -
 tools/perf/arch/x86/util/intel-bts.c  | 1 -
 tools/perf/arch/x86/util/intel-pt.c   | 1 -
 tools/perf/util/auxtrace.h            | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index da6231367993..96aeb7cdbee1 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -888,7 +888,6 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	}
 
 	ptr->cs_etm_pmu			= cs_etm_pmu;
-	ptr->itr.pmu			= cs_etm_pmu;
 	ptr->itr.parse_snapshot_options	= cs_etm_parse_snapshot_options;
 	ptr->itr.recording_options	= cs_etm_recording_options;
 	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index d59f6ca499f2..2be99fdf997d 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -514,7 +514,6 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	}
 
 	sper->arm_spe_pmu = arm_spe_pmu;
-	sper->itr.pmu = arm_spe_pmu;
 	sper->itr.snapshot_start = arm_spe_snapshot_start;
 	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
 	sper->itr.find_snapshot = arm_spe_find_snapshot;
diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
index ba97c8a562a0..eac9739c87e6 100644
--- a/tools/perf/arch/arm64/util/hisi-ptt.c
+++ b/tools/perf/arch/arm64/util/hisi-ptt.c
@@ -174,7 +174,6 @@ struct auxtrace_record *hisi_ptt_recording_init(int *err,
 	}
 
 	pttr->hisi_ptt_pmu = hisi_ptt_pmu;
-	pttr->itr.pmu = hisi_ptt_pmu;
 	pttr->itr.recording_options = hisi_ptt_recording_options;
 	pttr->itr.info_priv_size = hisi_ptt_info_priv_size;
 	pttr->itr.info_fill = hisi_ptt_info_fill;
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 34696f3d3d5d..85c8186300c8 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -434,7 +434,6 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
 	}
 
 	btsr->intel_bts_pmu = intel_bts_pmu;
-	btsr->itr.pmu = intel_bts_pmu;
 	btsr->itr.recording_options = intel_bts_recording_options;
 	btsr->itr.info_priv_size = intel_bts_info_priv_size;
 	btsr->itr.info_fill = intel_bts_info_fill;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 4b710e875953..ea510a7486b1 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1197,7 +1197,6 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
 	}
 
 	ptr->intel_pt_pmu = intel_pt_pmu;
-	ptr->itr.pmu = intel_pt_pmu;
 	ptr->itr.recording_options = intel_pt_recording_options;
 	ptr->itr.info_priv_size = intel_pt_info_priv_size;
 	ptr->itr.info_fill = intel_pt_info_fill;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index d405efcd8708..a1895a4f530b 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -411,7 +411,6 @@ struct auxtrace_record {
 	int (*read_finish)(struct auxtrace_record *itr, int idx);
 	unsigned int alignment;
 	unsigned int default_aux_sample_size;
-	struct perf_pmu *pmu;
 	struct evlist *evlist;
 };
 
-- 
2.34.1


