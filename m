Return-Path: <linux-kernel+bounces-276867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26BF949953
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D754287294
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8C1741C4;
	Tue,  6 Aug 2024 20:42:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C73C172BD6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976924; cv=none; b=VufJ3wAYD8OBj/qzGmlVA7JTDOMaR7NyFU0wkSxq0VEJz9u/dq1S0QfX7ET8uLeD2npMrhLHP010C9lLcNlnSEa1H3EbK2bJt0/T/Yqz0NxaIJkD/wJGMAP+BZxDIDM+s5Ncm4aGdpuJi3ZY0IRK7t5jlZfISsKyXnkjxwfEZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976924; c=relaxed/simple;
	bh=reCgguHKU5+C1E2rKdlQVSjqShjcTtPjfB4NKk0xU9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRXNxGFYijWEuwHyGueV3GnXY4cVLXqB62m0x3xizBxjJtgCsfv1ZANcH7qtzO1qdsWTdvBsyjT77tH3U0mqcTI4r+Uss30pUOdQFunNEYYRAzBuIpn0tWDkpaQgfsjoVnZgwfdWDoDIhTLD/A/frW6+0bTXfhM0Qp71lvXsWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57FAAFEC;
	Tue,  6 Aug 2024 13:42:28 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BACDD3F766;
	Tue,  6 Aug 2024 13:42:00 -0700 (PDT)
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
Subject: [PATCH v1 8/9] perf intel-pt: Remove the 'pmu_type' field
Date: Tue,  6 Aug 2024 21:41:29 +0100
Message-Id: <20240806204130.720977-9-leo.yan@arm.com>
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

Use the evsel__is_aux_event() function to detect the enabled AUX events.
The 'pmu_type' field is not used, remove it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/intel-pt.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 1608d0e38679..69b664059c2d 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -84,7 +84,6 @@ struct intel_pt {
 	unsigned int br_stack_sz;
 	unsigned int br_stack_sz_plus;
 	int have_sched_switch;
-	u32 pmu_type;
 	u64 kernel_start;
 	u64 switch_ip;
 	u64 ptss_ip;
@@ -1020,10 +1019,11 @@ static bool intel_pt_pgd_ip(uint64_t ip, void *data)
 	return __intel_pt_pgd_ip(ip, data) > 0;
 }
 
-static bool intel_pt_get_config(struct intel_pt *pt,
-				struct perf_event_attr *attr, u64 *config)
+static bool intel_pt_get_config(struct evsel *evsel, u64 *config)
 {
-	if (attr->type == pt->pmu_type) {
+	struct perf_event_attr *attr = &evsel->core.attr;
+
+	if (evsel__is_aux_event(evsel)) {
 		if (config)
 			*config = attr->config;
 		return true;
@@ -1037,7 +1037,7 @@ static bool intel_pt_exclude_kernel(struct intel_pt *pt)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (intel_pt_get_config(pt, &evsel->core.attr, NULL) &&
+		if (intel_pt_get_config(evsel, NULL) &&
 		    !evsel->core.attr.exclude_kernel)
 			return false;
 	}
@@ -1053,7 +1053,7 @@ static bool intel_pt_return_compression(struct intel_pt *pt)
 		return true;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (intel_pt_get_config(pt, &evsel->core.attr, &config) &&
+		if (intel_pt_get_config(evsel, &config) &&
 		    (config & pt->noretcomp_bit))
 			return false;
 	}
@@ -1066,7 +1066,7 @@ static bool intel_pt_branch_enable(struct intel_pt *pt)
 	u64 config;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (intel_pt_get_config(pt, &evsel->core.attr, &config) &&
+		if (intel_pt_get_config(evsel, &config) &&
 		    (config & INTEL_PT_CFG_PASS_THRU) &&
 		    !(config & INTEL_PT_CFG_BRANCH_EN))
 			return false;
@@ -1080,7 +1080,7 @@ static bool intel_pt_disabled_tnt(struct intel_pt *pt)
 	u64 config;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (intel_pt_get_config(pt, &evsel->core.attr, &config) &&
+		if (intel_pt_get_config(evsel, &config) &&
 		    config & INTEL_PT_CFG_TNT_DIS)
 			return true;
 	}
@@ -1100,7 +1100,7 @@ static unsigned int intel_pt_mtc_period(struct intel_pt *pt)
 		config >>= 1;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (intel_pt_get_config(pt, &evsel->core.attr, &config))
+		if (intel_pt_get_config(evsel, &config))
 			return (config & pt->mtc_freq_bits) >> shift;
 	}
 	return 0;
@@ -1118,7 +1118,7 @@ static bool intel_pt_timeless_decoding(struct intel_pt *pt)
 	evlist__for_each_entry(pt->session->evlist, evsel) {
 		if (!(evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
 			return true;
-		if (intel_pt_get_config(pt, &evsel->core.attr, &config)) {
+		if (intel_pt_get_config(evsel, &config)) {
 			if (config & pt->tsc_bit)
 				timeless_decoding = false;
 			else
@@ -1133,7 +1133,7 @@ static bool intel_pt_tracing_kernel(struct intel_pt *pt)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (intel_pt_get_config(pt, &evsel->core.attr, NULL) &&
+		if (intel_pt_get_config(evsel, NULL) &&
 		    !evsel->core.attr.exclude_kernel)
 			return true;
 	}
@@ -1150,7 +1150,7 @@ static bool intel_pt_have_tsc(struct intel_pt *pt)
 		return false;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (intel_pt_get_config(pt, &evsel->core.attr, &config)) {
+		if (intel_pt_get_config(evsel, &config)) {
 			if (config & pt->tsc_bit)
 				have_tsc = true;
 			else
@@ -1166,7 +1166,7 @@ static bool intel_pt_have_mtc(struct intel_pt *pt)
 	u64 config;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (intel_pt_get_config(pt, &evsel->core.attr, &config) &&
+		if (intel_pt_get_config(evsel, &config) &&
 		    (config & pt->mtc_bit))
 			return true;
 	}
@@ -1191,7 +1191,7 @@ static u64 intel_pt_ctl(struct intel_pt *pt)
 	u64 config;
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
-		if (intel_pt_get_config(pt, &evsel->core.attr, &config))
+		if (intel_pt_get_config(evsel, &config))
 			return config;
 	}
 	return 0;
@@ -3703,13 +3703,12 @@ static void intel_pt_set_event_name(struct evlist *evlist, u64 id,
 	}
 }
 
-static struct evsel *intel_pt_evsel(struct intel_pt *pt,
-					 struct evlist *evlist)
+static struct evsel *intel_pt_evsel(struct evlist *evlist)
 {
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == pt->pmu_type && evsel->core.ids)
+		if (evsel__is_aux_event(evsel) && evsel->core.ids)
 			return evsel;
 	}
 
@@ -3720,7 +3719,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 				 struct perf_session *session)
 {
 	struct evlist *evlist = session->evlist;
-	struct evsel *evsel = intel_pt_evsel(pt, evlist);
+	struct evsel *evsel = intel_pt_evsel(evlist);
 	struct perf_event_attr attr;
 	u64 id;
 	int err;
@@ -4219,7 +4218,6 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	pt->session = session;
 	pt->machine = &session->machines.host; /* No kvm support */
 	pt->auxtrace_type = auxtrace_info->type;
-	pt->pmu_type = auxtrace_info->priv[INTEL_PT_PMU_TYPE];
 	pt->tc.time_shift = auxtrace_info->priv[INTEL_PT_TIME_SHIFT];
 	pt->tc.time_mult = auxtrace_info->priv[INTEL_PT_TIME_MULT];
 	pt->tc.time_zero = auxtrace_info->priv[INTEL_PT_TIME_ZERO];
-- 
2.34.1


