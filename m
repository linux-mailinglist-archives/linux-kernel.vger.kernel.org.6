Return-Path: <linux-kernel+bounces-276864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A673294994F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB31282D2F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653915688F;
	Tue,  6 Aug 2024 20:41:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AB416F29F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976918; cv=none; b=SafFSePMSlrntoMHfdmRX6jGI7wnQo9upq4C3WtTXcasTfVdFahv0U0ZgMo924oses7sFI2ua+B9WJItfgUIszONoSwz68eA6LvXGIGH/IN4ZBV2/aCkwH4ZkiFc2T1QWyGju0egec0P6gWajhp54FjmO9hPzMKPs36tFu3uJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976918; c=relaxed/simple;
	bh=tWqjLIpLEKkWX93fLgDmjOA9c9Ocqxb4bG2luZZVg3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guZVJTTe+W1gGT1dnwjOi03DMoxl6KLMv4XXNKOB40X3RwLOVWW6E/qOK+FTG+LKHzD2bX5dY3xoskFPNrhRKp1RIs4HBnsVxlFY4ndhz3c6LkgH5K7gUqebmznNDAZQcC/Fg303t2OFbekNB7jz8gfOBydETTlDPInsRMo7Uqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF52C113E;
	Tue,  6 Aug 2024 13:42:21 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 552213F766;
	Tue,  6 Aug 2024 13:41:54 -0700 (PDT)
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
Subject: [PATCH v1 5/9] perf cs-etm: Remove the 'pmu_type' field
Date: Tue,  6 Aug 2024 21:41:26 +0100
Message-Id: <20240806204130.720977-6-leo.yan@arm.com>
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

Use the evsel__is_aux_event() function in the Arm CoreSight layer to
detect the enabled AUX events. So the 'pmu_type' field is not used,
remove it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index dac0f7c7e44d..13050b1919c8 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -77,7 +77,6 @@ struct cs_etm_auxtrace {
 	u64 instructions_sample_period;
 	u64 instructions_id;
 	u64 **metadata;
-	unsigned int pmu_type;
 	enum cs_etm_pid_fmt pid_fmt;
 };
 
@@ -1629,7 +1628,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 	int err;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == etm->pmu_type) {
+		if (evsel__is_aux_event(evsel)) {
 			found = true;
 			break;
 		}
@@ -3338,7 +3337,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->session = session;
 
 	etm->num_cpu = num_cpu;
-	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
 	etm->snapshot_mode = (ptr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
 	etm->auxtrace_type = auxtrace_info->type;
-- 
2.34.1


