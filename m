Return-Path: <linux-kernel+bounces-556559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A64A5CBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D5B189A7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F34260A52;
	Tue, 11 Mar 2025 17:05:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0D5264615;
	Tue, 11 Mar 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712740; cv=none; b=bKnL6foAhgwJhwCx3fNdLDuoeKdSnqKaV8TRLUzqpm9IKQq5BxBPkk2Gwg7/9Gf18JXuHIDF8WMNYYlLPYVXyeoxPqnrHXIpTHW9tf7ZvlSmhV8IFNEk9L4MmbLUcY/pQuiVfg6nSXzgHvPP+aF0nObcFVv0uSSXXVf/hJeoTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712740; c=relaxed/simple;
	bh=tTdUH6cvxH8txoURn+4skClahU/Ec7GOvhlxyIpT3JM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRemEhuSPO2EUD/cjACecdUxO0ycvJm+501+btkfdDk0p3541F4FYgJDZBh4vXWbqQsbvG/lP4W5nXocW0bK61Z4W1p1leRbYTBxfmwLCvSb0jwqMcnBpLPyk4CL/IpEBaTiix5ERq6gg5sRLzS6h18Nge3wzAynavr7yVSS2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A9981688;
	Tue, 11 Mar 2025 10:05:49 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB20C3F673;
	Tue, 11 Mar 2025 10:05:36 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 4/6] coresight: perf: Support AUX trace pause and resume
Date: Tue, 11 Mar 2025 17:04:49 +0000
Message-Id: <20250311170451.611389-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311170451.611389-1-leo.yan@arm.com>
References: <20250311170451.611389-1-leo.yan@arm.com>
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
 .../hwtracing/coresight/coresight-etm-perf.c  | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f4cccd68e625..2dcf1809cb7f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -365,6 +365,18 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 			continue;
 		}
 
+		/*
+		 * If AUX pause feature is enabled but the ETM driver does not
+		 * support the operations, clear this CPU from the mask and
+		 * continue to next one.
+		 */
+		if (event->attr.aux_start_paused &&
+		    (!source_ops(csdev)->pause_perf || !source_ops(csdev)->resume_perf)) {
+			dev_err_once(&csdev->dev, "AUX pause is not supported.\n");
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
+
 		/*
 		 * No sink provided - look for a default sink for all the ETMs,
 		 * where this event can be scheduled.
@@ -450,6 +462,15 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	goto out;
 }
 
+static int etm_event_resume(struct coresight_device *csdev,
+			     struct etm_ctxt *ctxt)
+{
+	if (!ctxt->event_data)
+		return 0;
+
+	return coresight_resume_source(csdev);
+}
+
 static void etm_event_start(struct perf_event *event, int flags)
 {
 	int cpu = smp_processor_id();
@@ -463,6 +484,14 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (!csdev)
 		goto fail;
 
+	if (flags & PERF_EF_RESUME) {
+		if (etm_event_resume(csdev, ctxt) < 0) {
+			dev_err(&csdev->dev, "Failed to resume ETM event.\n");
+			goto fail;
+		}
+		return;
+	}
+
 	/* Have we messed up our tracking ? */
 	if (WARN_ON(ctxt->event_data))
 		goto fail;
@@ -545,6 +574,16 @@ static void etm_event_start(struct perf_event *event, int flags)
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
@@ -555,6 +594,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	struct etm_event_data *event_data;
 	struct coresight_path *path;
 
+	if (mode & PERF_EF_PAUSE)
+		return etm_event_pause(csdev, ctxt);
+
 	/*
 	 * If we still have access to the event_data via handle,
 	 * confirm that we haven't messed up the tracking.
@@ -899,7 +941,8 @@ int __init etm_perf_init(void)
 	int ret;
 
 	etm_pmu.capabilities		= (PERF_PMU_CAP_EXCLUSIVE |
-					   PERF_PMU_CAP_ITRACE);
+					   PERF_PMU_CAP_ITRACE |
+					   PERF_PMU_CAP_AUX_PAUSE);
 
 	etm_pmu.attr_groups		= etm_pmu_attr_groups;
 	etm_pmu.task_ctx_nr		= perf_sw_context;
-- 
2.34.1


