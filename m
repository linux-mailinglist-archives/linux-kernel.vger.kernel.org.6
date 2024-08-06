Return-Path: <linux-kernel+bounces-276863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE5194994D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9B4284CA8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1862E16EB70;
	Tue,  6 Aug 2024 20:41:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3970E16D4DD
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976915; cv=none; b=D5H3V9vWjnX1vee03dLaHQT/ZbXD8HUfWHXyO7Xpw7oqcml0isn6XA5utNnX6pBI1P7VvhbRwc7HpU0I/YVL2aIIs7V51K8zsJDFVrlWlngFb880xNhgsUNpnv69V1aO8Iym7otVFs5ObGMo5xAp6jfZ/WYr7W6xC0lBBQneVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976915; c=relaxed/simple;
	bh=NbNvGp7PWP2JXjBqXf+9QHthD/WmkmYSFHfQPVfbVnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C8N6zepqv7MK8gVKiJ1xjProrstEXTUMD/lzvkJh2Cfm3+dOw3B01Ew4+cFgwKjVRsjdoWcbyaiUeJzRvhYO74DLQM7smgtMiubQZ3pxSQ/lpXTjb/sbZzMHL3HTiJHHcM+pqSpWa+z21fhO6AmrhdXyug7pBSwfXMwWyEmBtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAC01113E;
	Tue,  6 Aug 2024 13:42:19 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 39BB73F766;
	Tue,  6 Aug 2024 13:41:52 -0700 (PDT)
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
Subject: [PATCH v1 4/9] perf arm-spe: Remove the 'pmu_type' field
Date: Tue,  6 Aug 2024 21:41:25 +0100
Message-Id: <20240806204130.720977-5-leo.yan@arm.com>
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

Use the evsel__is_aux_event() function in the Arm SPE layer to detected
the enabled AUX events. It is safe for this change as it is no chance
for mixing AUX events and only the same kind of AUX events are enabled
during the initialization.

After the refactoring, the 'pmu_type' field is not used, so remove it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 27e393a0beec..213320cfcea7 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -45,7 +45,6 @@ struct arm_spe {
 	u32				auxtrace_type;
 	struct perf_session		*session;
 	struct machine			*machine;
-	u32				pmu_type;
 	u64				midr;
 
 	struct perf_tsc_conversion	tc;
@@ -1120,7 +1119,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	int err;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == spe->pmu_type) {
+		if (evsel__is_aux_event(evsel)) {
 			found = true;
 			break;
 		}
@@ -1305,7 +1304,6 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	spe->session = session;
 	spe->machine = &session->machines.host; /* No kvm support */
 	spe->auxtrace_type = auxtrace_info->type;
-	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 	spe->midr = midr;
 
 	spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
-- 
2.34.1


