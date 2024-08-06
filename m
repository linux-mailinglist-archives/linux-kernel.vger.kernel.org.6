Return-Path: <linux-kernel+bounces-276862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8B594994C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411AC283398
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7FE16DEA6;
	Tue,  6 Aug 2024 20:41:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD1514EC44
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976914; cv=none; b=FPE4SWkPTi288MVcTV8fF0cPDYoDjU3tqJ/f7QQuOoUrDY6w0dojQF/si/0ZKfAmK5o6SdYIqBDNhHHssMBwnjv0ZmMX+ylqy8vtf5oMRjgqgY2/WCI7R60OAwPNV1YHEP7kqH42YGvHp1VWur9AMYk2XLb1QOO2DWOfY/3m9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976914; c=relaxed/simple;
	bh=devTyGaODtto/FuKq7PIddIKeFGOLuZLMaTOQDXRWdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SetF1Go8JM8KehHXW67+HmKeufgFmuNIEuKDv7QXWSjw0AqkWvXHE4GdfUP/PX3nEDacLKD1X4fQzMN0SNG26QMAjLci+nZP0pkBhPfB8J6HZJuFGOC2J0CWZwRFYmWq4pOj7BhZzGBivQ4QSlKBFoYzu4y5pRIT3St0LpmEWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE3AF1063;
	Tue,  6 Aug 2024 13:42:17 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C8E63F766;
	Tue,  6 Aug 2024 13:41:49 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 3/9] perf auxtrace: Refactor auxtrace__evsel_is_auxtrace()
Date: Tue,  6 Aug 2024 21:41:24 +0100
Message-Id: <20240806204130.720977-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806204130.720977-1-leo.yan@arm.com>
References: <20240806204130.720977-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The auxtrace__evsel_is_auxtrace() function invokes the callback
.evsel_is_auxtrace() to check if an event is an AUX trace. In the
low-level code, every AUX trace module provides its callback to
compare the PMU type.

This commit refactors auxtrace__evsel_is_auxtrace() by simply
calling evsel__is_aux_event() rather than using the callback function.
As a result, the callback .evsel_is_auxtrace() is no longer needed, so
the definition and implementations are removed.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c     |  9 ---------
 tools/perf/util/auxtrace.c    |  4 ++--
 tools/perf/util/auxtrace.h    |  2 --
 tools/perf/util/cs-etm.c      | 13 +------------
 tools/perf/util/hisi-ptt.c    |  9 ---------
 tools/perf/util/intel-bts.c   | 10 ----------
 tools/perf/util/intel-pt.c    | 10 ----------
 tools/perf/util/s390-cpumsf.c |  9 ---------
 8 files changed, 3 insertions(+), 63 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index afbd5869f6bf..27e393a0beec 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1053,14 +1053,6 @@ static void arm_spe_free(struct perf_session *session)
 	free(spe);
 }
 
-static bool arm_spe_evsel_is_auxtrace(struct perf_session *session,
-				      struct evsel *evsel)
-{
-	struct arm_spe *spe = container_of(session->auxtrace, struct arm_spe, auxtrace);
-
-	return evsel->core.attr.type == spe->pmu_type;
-}
-
 static const char * const arm_spe_info_fmts[] = {
 	[ARM_SPE_PMU_TYPE]		= "  PMU Type           %"PRId64"\n",
 };
@@ -1344,7 +1336,6 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->auxtrace.flush_events = arm_spe_flush;
 	spe->auxtrace.free_events = arm_spe_free_events;
 	spe->auxtrace.free = arm_spe_free;
-	spe->auxtrace.evsel_is_auxtrace = arm_spe_evsel_is_auxtrace;
 	session->auxtrace = &spe->auxtrace;
 
 	arm_spe_print_info(&auxtrace_info->priv[0]);
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c3f0ef4349fc..03462ff346e7 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2874,8 +2874,8 @@ void auxtrace__free(struct perf_session *session)
 bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 				 struct evsel *evsel)
 {
-	if (!session->auxtrace || !session->auxtrace->evsel_is_auxtrace)
+	if (!session->auxtrace)
 		return false;
 
-	return session->auxtrace->evsel_is_auxtrace(session, evsel);
+	return evsel__is_aux_event(evsel);
 }
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 95304368103b..f13c2de17653 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -221,8 +221,6 @@ struct auxtrace {
 			    struct perf_tool *tool);
 	void (*free_events)(struct perf_session *session);
 	void (*free)(struct perf_session *session);
-	bool (*evsel_is_auxtrace)(struct perf_session *session,
-				  struct evsel *evsel);
 };
 
 /**
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d3e9c64d17d4..dac0f7c7e44d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -899,16 +899,6 @@ static void cs_etm__free(struct perf_session *session)
 	zfree(&aux);
 }
 
-static bool cs_etm__evsel_is_auxtrace(struct perf_session *session,
-				      struct evsel *evsel)
-{
-	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
-						   struct cs_etm_auxtrace,
-						   auxtrace);
-
-	return evsel->core.attr.type == aux->pmu_type;
-}
-
 static struct machine *cs_etm__get_machine(struct cs_etm_queue *etmq,
 					   ocsd_ex_level el)
 {
@@ -2877,7 +2867,7 @@ static int cs_etm__setup_timeless_decoding(struct cs_etm_auxtrace *etm)
 	 * Find the cs_etm evsel and look at what its timestamp setting was
 	 */
 	evlist__for_each_entry(evlist, evsel)
-		if (cs_etm__evsel_is_auxtrace(etm->session, evsel)) {
+		if (evsel__is_aux_event(evsel)) {
 			etm->timeless_decoding =
 				!(evsel->core.attr.config & BIT(ETM_OPT_TS));
 			return 0;
@@ -3380,7 +3370,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->auxtrace.flush_events = cs_etm__flush_events;
 	etm->auxtrace.free_events = cs_etm__free_events;
 	etm->auxtrace.free = cs_etm__free;
-	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
 	session->auxtrace = &etm->auxtrace;
 
 	err = cs_etm__setup_timeless_decoding(etm);
diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index 37ea987017f6..57dd98afb0d2 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -141,14 +141,6 @@ static void hisi_ptt_free(struct perf_session *session)
 	free(ptt);
 }
 
-static bool hisi_ptt_evsel_is_auxtrace(struct perf_session *session,
-				       struct evsel *evsel)
-{
-	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt, auxtrace);
-
-	return evsel->core.attr.type == ptt->pmu_type;
-}
-
 static void hisi_ptt_print_info(__u64 type)
 {
 	if (!dump_trace)
@@ -181,7 +173,6 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 	ptt->auxtrace.flush_events = hisi_ptt_flush;
 	ptt->auxtrace.free_events = hisi_ptt_free_events;
 	ptt->auxtrace.free = hisi_ptt_free;
-	ptt->auxtrace.evsel_is_auxtrace = hisi_ptt_evsel_is_auxtrace;
 	session->auxtrace = &ptt->auxtrace;
 
 	hisi_ptt_print_info(auxtrace_info->priv[0]);
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index ec1b3bd9f530..2b571e56f9c9 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -728,15 +728,6 @@ static void intel_bts_free(struct perf_session *session)
 	free(bts);
 }
 
-static bool intel_bts_evsel_is_auxtrace(struct perf_session *session,
-					struct evsel *evsel)
-{
-	struct intel_bts *bts = container_of(session->auxtrace, struct intel_bts,
-					     auxtrace);
-
-	return evsel->core.attr.type == bts->pmu_type;
-}
-
 struct intel_bts_synth {
 	struct perf_tool dummy_tool;
 	struct perf_session *session;
@@ -892,7 +883,6 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	bts->auxtrace.flush_events = intel_bts_flush;
 	bts->auxtrace.free_events = intel_bts_free_events;
 	bts->auxtrace.free = intel_bts_free;
-	bts->auxtrace.evsel_is_auxtrace = intel_bts_evsel_is_auxtrace;
 	session->auxtrace = &bts->auxtrace;
 
 	intel_bts_print_info(&auxtrace_info->priv[0], INTEL_BTS_PMU_TYPE,
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index d6d7b7512505..1608d0e38679 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3589,15 +3589,6 @@ static void intel_pt_free(struct perf_session *session)
 	free(pt);
 }
 
-static bool intel_pt_evsel_is_auxtrace(struct perf_session *session,
-				       struct evsel *evsel)
-{
-	struct intel_pt *pt = container_of(session->auxtrace, struct intel_pt,
-					   auxtrace);
-
-	return evsel->core.attr.type == pt->pmu_type;
-}
-
 static int intel_pt_process_auxtrace_event(struct perf_session *session,
 					   union perf_event *event,
 					   struct perf_tool *tool __maybe_unused)
@@ -4356,7 +4347,6 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	pt->auxtrace.flush_events = intel_pt_flush;
 	pt->auxtrace.free_events = intel_pt_free_events;
 	pt->auxtrace.free = intel_pt_free;
-	pt->auxtrace.evsel_is_auxtrace = intel_pt_evsel_is_auxtrace;
 	session->auxtrace = &pt->auxtrace;
 
 	if (dump_trace)
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6fe478b0b61b..a9b0dea199d5 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -1048,14 +1048,6 @@ static void s390_cpumsf_free(struct perf_session *session)
 	free(sf);
 }
 
-static bool
-s390_cpumsf_evsel_is_auxtrace(struct perf_session *session __maybe_unused,
-			      struct evsel *evsel)
-{
-	return evsel->core.attr.type == PERF_TYPE_RAW &&
-	       evsel->core.attr.config == PERF_EVENT_CPUM_SF_DIAG;
-}
-
 static int s390_cpumsf_get_type(const char *cpuid)
 {
 	int ret, family = 0;
@@ -1152,7 +1144,6 @@ int s390_cpumsf_process_auxtrace_info(union perf_event *event,
 	sf->auxtrace.flush_events = s390_cpumsf_flush;
 	sf->auxtrace.free_events = s390_cpumsf_free_events;
 	sf->auxtrace.free = s390_cpumsf_free;
-	sf->auxtrace.evsel_is_auxtrace = s390_cpumsf_evsel_is_auxtrace;
 	session->auxtrace = &sf->auxtrace;
 
 	if (dump_trace)
-- 
2.34.1


