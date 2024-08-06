Return-Path: <linux-kernel+bounces-276866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46976949951
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB82BB25097
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8DE15AAD7;
	Tue,  6 Aug 2024 20:42:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E3171E70
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976922; cv=none; b=l7ysslYZrwsAUJ1ALC1r+U0/pWjZkRld2VaWXbfrjWP+t0+6zTS20xlb5afdNu9eLct6751OyKdY5ErZXMoQZDtieLjdszII9MwG+B75PR2WhQFGPnjTozhmwKtfjqOvqGrxo7B2h1JiTOkJjxW/sFrNmHGV5wxVCDNoWsaLgiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976922; c=relaxed/simple;
	bh=b5lwewhvF8u/CcWpRp4OTGCXnKdSs5DuN1J04Nhm+4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6id9Gb5EX4ZFiQXmj2a7wuMUb5xA5+lLSRkdVxCbiib3L+57XxhH1P/fthO98FaKgzFuZHkuMgQ6JFvGzkkGbzuMrB+zy5yZdJdn0Vl5Dahbfo4JsJ/D57wyi6aAydgRA140yr2bfefgsvs/LtH2BJOGOvU1hl+8LO7wS+4Il4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C1BC113E;
	Tue,  6 Aug 2024 13:42:26 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F1C33F766;
	Tue,  6 Aug 2024 13:41:58 -0700 (PDT)
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
Subject: [PATCH v1 7/9] perf intel-bts: Remove the 'pmu_type' field
Date: Tue,  6 Aug 2024 21:41:28 +0100
Message-Id: <20240806204130.720977-8-leo.yan@arm.com>
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
 tools/perf/util/intel-bts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 2b571e56f9c9..93f3452f8220 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -51,7 +51,6 @@ struct intel_bts {
 	bool				sampling_mode;
 	bool				snapshot_mode;
 	bool				data_queued;
-	u32				pmu_type;
 	struct perf_tsc_conversion	tc;
 	bool				cap_user_time_zero;
 	struct itrace_synth_opts	synth_opts;
@@ -768,7 +767,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 	int err;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == bts->pmu_type && evsel->core.ids) {
+		if (evsel__is_aux_event(evsel) && evsel->core.ids) {
 			found = true;
 			break;
 		}
@@ -868,7 +867,6 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	bts->session = session;
 	bts->machine = &session->machines.host; /* No kvm support */
 	bts->auxtrace_type = auxtrace_info->type;
-	bts->pmu_type = auxtrace_info->priv[INTEL_BTS_PMU_TYPE];
 	bts->tc.time_shift = auxtrace_info->priv[INTEL_BTS_TIME_SHIFT];
 	bts->tc.time_mult = auxtrace_info->priv[INTEL_BTS_TIME_MULT];
 	bts->tc.time_zero = auxtrace_info->priv[INTEL_BTS_TIME_ZERO];
-- 
2.34.1


