Return-Path: <linux-kernel+bounces-556560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BE2A5CBB5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EC13A8F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ACC264F81;
	Tue, 11 Mar 2025 17:05:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068C264A6D;
	Tue, 11 Mar 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712742; cv=none; b=m3phSl+tgI2H3WTiA/ZfqKlkq9yZOgcjqZu9ToJDspk8jAqJ+PMbuwQrYCuL3WBU/rAErDKGwa1eUkZCStQoRdqAtg0uVg8cTXe+TeOFbzfL3sr/gAb00tZbw4aSq3wBr3P6mr96b9JKA1TRAI7vvyVL3gUnSOS7oWWkuWR4qEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712742; c=relaxed/simple;
	bh=vZJJwRJKk4yUsnu54EbxNFfmWfWIu4Rnq3NkC/8cyTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOfsEehdQZcX+5qhkPtPtdDmTOPnpzAO6bIujnHbYm+Hrvd5JkdhQJXUGmtV3PbuOKS0csEuiUGiKIKs1mu5hgi3F2wMo8sRqxK4Fb4/ZAfpaD8uGmLmthUwUuynq+JwvGj0YI+LxKudxUkDszD8j+1IJchH5GzQPW4mrchQgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 208F71762;
	Tue, 11 Mar 2025 10:05:51 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 926003F673;
	Tue, 11 Mar 2025 10:05:38 -0700 (PDT)
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
Subject: [PATCH v3 5/6] coresight: perf: Update buffer on AUX pause
Date: Tue, 11 Mar 2025 17:04:50 +0000
Message-Id: <20250311170451.611389-6-leo.yan@arm.com>
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

Due to sinks like ETR and ETB don't support interrupt handling, the
hardware trace data might be lost for continuous running tasks.

This commit takes advantage of the AUX pause for updating trace buffer
to mitigate the trace data losing issue.

The per CPU sink has its own interrupt handling.  Thus, there will be a
race condition between the updating buffer in NMI and sink's interrupt
handler.  To avoid the race condition, this commit disallows updating
buffer on AUX pause for the per CPU sink.  Currently, this is only
applied for TRBE.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 2dcf1809cb7f..f1551c08ecb2 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -574,14 +574,53 @@ static void etm_event_start(struct perf_event *event, int flags)
 	return;
 }
 
-static void etm_event_pause(struct coresight_device *csdev,
+static void etm_event_pause(struct perf_event *event,
+			    struct coresight_device *csdev,
 			    struct etm_ctxt *ctxt)
 {
+	int cpu = smp_processor_id();
+	struct coresight_device *sink;
+	struct perf_output_handle *handle = &ctxt->handle;
+	struct coresight_path *path;
+	unsigned long size;
+
 	if (!ctxt->event_data)
 		return;
 
 	/* Stop tracer */
 	coresight_pause_source(csdev);
+
+	path = etm_event_cpu_path(ctxt->event_data, cpu);
+	sink = coresight_get_sink(path);
+	if (WARN_ON_ONCE(!sink))
+		return;
+
+	/*
+	 * The per CPU sink has own interrupt handling, it might have
+	 * race condition with updating buffer on AUX trace pause if
+	 * it is invoked from NMI.  To avoid the race condition,
+	 * disallows updating buffer for the per CPU sink case.
+	 */
+	if (coresight_is_percpu_sink(sink))
+		return;
+
+	if (WARN_ON_ONCE(handle->event != event))
+		return;
+
+	if (!sink_ops(sink)->update_buffer)
+		return;
+
+	size = sink_ops(sink)->update_buffer(sink, handle,
+					     ctxt->event_data->snk_config);
+	if (READ_ONCE(handle->event)) {
+		if (!size)
+			return;
+
+		perf_aux_output_end(handle, size);
+		perf_aux_output_begin(handle, event);
+	} else {
+		WARN_ON_ONCE(size);
+	}
 }
 
 static void etm_event_stop(struct perf_event *event, int mode)
@@ -595,7 +634,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	struct coresight_path *path;
 
 	if (mode & PERF_EF_PAUSE)
-		return etm_event_pause(csdev, ctxt);
+		return etm_event_pause(event, csdev, ctxt);
 
 	/*
 	 * If we still have access to the event_data via handle,
-- 
2.34.1


