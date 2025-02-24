Return-Path: <linux-kernel+bounces-529430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18099A42616
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89CF419C1776
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D724887A;
	Mon, 24 Feb 2025 15:14:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D8F2063DD;
	Mon, 24 Feb 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410093; cv=none; b=dgEWOOau3t9kT34Q+LzMDt8hBhZ/psNFa28rGJTuGXvGMlOtPbmljO1GmcTQ//JgAF5JrKARakxqWXoQCCvAwDVUEjo6H2K2d0IIGOYiJkib/UDqMSt95j7Ria7Z8sTjqBx5UXbY/miU/bKnIK1fN9ffFysRYKKAf/62l6ywrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410093; c=relaxed/simple;
	bh=jrL58x5+1qj1SLmhLR7yqfFjVyxGRJnP9/fW+NcEZlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C27HTtkpuETHXNsHTI+YBwhTSW+Qm8Yncq4aMWkLTDHTyetoLqEtcYWyNrL4kdsP+CA2WjT/6NkRFPRpuOaMm5T7h44vyElzJrFLS8C15PboriQ/zf4IPxha1AbOeC9KPu8Iq+v5MoCTc2YOM1rTWQFes471cm2CmgkaVseH8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DBEC2661;
	Mon, 24 Feb 2025 07:15:08 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E8683F6A8;
	Mon, 24 Feb 2025 07:14:49 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 4/8] coresight: perf: Support AUX trace pause and resume
Date: Mon, 24 Feb 2025 15:14:19 +0000
Message-Id: <20250224151423.1630639-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224151423.1630639-1-leo.yan@arm.com>
References: <20250224151423.1630639-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit supports AUX trace pause and resume in a perf session for
Arm CoreSight.

First, we need to decide which flag can indicate the CoreSight PMU event
has started.  The 'event->hw.state' cannot be used for this purpose
because its initial value and the value after hardware trace enabling
are both 0.

On the other hand, the context value 'ctxt->event_data' stores the ETM
private info.  This pointer is valid only when the PMU event has been
enabled. It is safe to permit AUX trace pause and resume operations only
when it is not a NULL pointer.

To achieve fine-grained control of the pause and resume, only the tracer
is disabled and enabled.  This avoids the unnecessary complexity and
latency caused by manipulating the entire link path.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 40 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index ad6a8f4b70b6..29d52386ffbb 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -366,6 +366,18 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 			continue;
 		}
 
+		/*
+		 * If AUX pause feature is enabled but the ETM driver does not
+		 * support the operations, clear this CPU from the mask and
+		 * continue to next one.
+		 */
+		if (event->attr.aux_start_paused &&
+		    (!source_ops(csdev)->pause || !source_ops(csdev)->resume)) {
+			dev_err_once(&csdev->dev, "AUX pause is not supported.\n");
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
+
 		/*
 		 * No sink provided - look for a default sink for all the ETMs,
 		 * where this event can be scheduled.
@@ -451,6 +463,15 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	goto out;
 }
 
+static void etm_event_resume(struct coresight_device *csdev,
+			     struct etm_ctxt *ctxt)
+{
+	if (!ctxt->event_data)
+		return;
+
+	coresight_resume_source(csdev);
+}
+
 static void etm_event_start(struct perf_event *event, int flags)
 {
 	int cpu = smp_processor_id();
@@ -465,6 +486,9 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (!csdev)
 		goto fail;
 
+	if (flags & PERF_EF_RESUME)
+		return etm_event_resume(csdev, ctxt);
+
 	/* Have we messed up our tracking ? */
 	if (WARN_ON(ctxt->event_data))
 		goto fail;
@@ -550,6 +574,16 @@ static void etm_event_start(struct perf_event *event, int flags)
 	return;
 }
 
+static void etm_event_pause(struct coresight_device *csdev,
+			    struct etm_ctxt *ctxt)
+{
+	if (!ctxt->event_data)
+		return;
+
+	/* Stop tracer */
+	coresight_pause_source(csdev);
+}
+
 static void etm_event_stop(struct perf_event *event, int mode)
 {
 	int cpu = smp_processor_id();
@@ -560,6 +594,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	struct etm_event_data *event_data;
 	struct list_head *path;
 
+	if (mode & PERF_EF_PAUSE)
+		return etm_event_pause(csdev, ctxt);
+
 	/*
 	 * If we still have access to the event_data via handle,
 	 * confirm that we haven't messed up the tracking.
@@ -904,7 +941,8 @@ int __init etm_perf_init(void)
 	int ret;
 
 	etm_pmu.capabilities		= (PERF_PMU_CAP_EXCLUSIVE |
-					   PERF_PMU_CAP_ITRACE);
+					   PERF_PMU_CAP_ITRACE |
+					   PERF_PMU_CAP_AUX_PAUSE);
 
 	etm_pmu.attr_groups		= etm_pmu_attr_groups;
 	etm_pmu.task_ctx_nr		= perf_sw_context;
-- 
2.34.1


