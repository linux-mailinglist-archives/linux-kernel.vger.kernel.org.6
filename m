Return-Path: <linux-kernel+bounces-554023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6059FA591E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147B91884414
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AD822E414;
	Mon, 10 Mar 2025 10:49:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E0E22E015;
	Mon, 10 Mar 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603782; cv=none; b=rPXqK6nhEvyFoljHhAtP8uSu7zLO+/ES1tYQQarMm7hqZFeN+M22/C27SVn1oT/K76sjSQ1rVN5wsUynEiWZiZgc8jBagY+nvV15wJJogCj9XSVZ9ANrT2VE/SSte4hs2Qoffm76TRxFgyyo1OG3RWn/y/ZBcx2vVQ3d0zCdJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603782; c=relaxed/simple;
	bh=h1NUjbsWtVI+rR0BWHzHHmfjMA+kj2h8OixpmVCAlv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJKc6wdnO+a6GYtlhrmC754kLHkfI4uRpaQ2mfEe7Pvb3G53jN0ly7nRBxJ0niu9C+baQZTGHQPz+iUlbr94I2NW68228iiH5bTEFQnE9CdBy6g9yWWn4bGetpHoJW4fNBI/kFLrPCMGTe+V4KPdZYScp4Vsjwbd1hTXRKOYWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2803815A1;
	Mon, 10 Mar 2025 03:49:52 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D07053F5A1;
	Mon, 10 Mar 2025 03:49:38 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 6/8] coresight: perf: Update buffer on AUX pause
Date: Mon, 10 Mar 2025 10:49:17 +0000
Message-Id: <20250310104919.58816-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310104919.58816-1-leo.yan@arm.com>
References: <20250310104919.58816-1-leo.yan@arm.com>
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

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index d759663a1f7d..667110429de9 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -594,14 +594,48 @@ static void etm_event_start(struct perf_event *event, int flags)
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
+	struct list_head *path;
+	unsigned long size;
+
 	if (!ctxt->event_data)
 		return;
 
 	/* Stop tracer */
 	coresight_pause_source(csdev);
+
+	/* Bail out if no need update buffer */
+	if (!ctxt->event_data->update_buf_on_pause)
+		return;
+
+	if (WARN_ON_ONCE(handle->event != event))
+		return;
+
+	path = etm_event_cpu_path(ctxt->event_data, cpu);
+	sink = coresight_get_sink(path);
+	if (WARN_ON_ONCE(!sink))
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
@@ -615,7 +649,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	struct list_head *path;
 
 	if (mode & PERF_EF_PAUSE)
-		return etm_event_pause(csdev, ctxt);
+		return etm_event_pause(event, csdev, ctxt);
 
 	/*
 	 * If we still have access to the event_data via handle,
-- 
2.34.1


