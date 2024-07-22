Return-Path: <linux-kernel+bounces-258854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2398938D58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119051C217BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ED616E869;
	Mon, 22 Jul 2024 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oB5gEgPK"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8E16CD3F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643230; cv=none; b=GpwlYGNaNuR9HB0G3mcVJiE5Mz40NTbxtSYc4VWMcjG2eFW4oXQbhBTLvjVTZnMbuGBtQaX6seIWO5y9rU3uZk4fBriLuZVGb3ownJ0nEFlS5615yHCDWMMZNhVL91h+B/ae1S8PENCXEFk9bgADdj4CGDNmkAbJJM/t4f7S9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643230; c=relaxed/simple;
	bh=fJ/zk4sI5hDeFJ8JK7nyxy+JEwWUtC1QD5z/TV3AQkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4CZmwe2+f9druB1mP/GacSp0qcY9bAVk8Xd0tdKoFxveu2fJF3Dn3v9FWmmpzAh6YnXvDmNRTf/2ESpdL2vrECkqyPAASnlDxo2YReU73TLe2NHjbRU/iDqS8fiafKy2PbGEsBsyDHYDFB1FbItZNUieOZjSx3aDkwDbd/mSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oB5gEgPK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so34693465e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643227; x=1722248027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDPT+SohkS2L9e6jRwH/Ybo4YFVpFyjtzqXPW1x2dY8=;
        b=oB5gEgPKgkN9YKqG005Oe7l5L/ffNb49U+pDEKTj6XaFjit+5yrW1cnHFU86FmKBbx
         2yCgyfAByydz7sl/LA/JB6T/Wbas1SNFXAaveiNF0mh/g+fBCr+XFotxAoBG9YDKrUet
         97LRHnZEJwgaOa2+Y6aA7kOvW58zkgjXMLQT6Pmdjy7g13xH7XUFkyYK+egK7a1/6Zf+
         zoB4/J95hlRec/A4HU4OYj2iIthOvMeFfboUOkBHLMZSyaV4xX0fKuHZx5hOWlRQp6zE
         fjxnWNHaNjQv0tn/gvPR7m5v64UHB5Axhq2T4iCQnEN+sO+PuFtq/pO3lwYR3S2K3PYK
         Mn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643227; x=1722248027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDPT+SohkS2L9e6jRwH/Ybo4YFVpFyjtzqXPW1x2dY8=;
        b=wOBchiVgbUwyKv9YEARaaIor3msaJb+scQwKzvxE46KUZvPruvBz4XQH9jxrpPKaIu
         lUpVgQ31Rndg6gy8wlMVbpz/uOwW3ppuIHwfwHxvTlY59t3Q06dWsz3RrUILfK+pj83L
         GDgekYn9xd3z7A53lQCshWindi1Nbmp0gFOr0/JGuC5+XLCKBcPnN0rESI2pB2DXlAoQ
         t/F7CII+vQamKltEcBTISQ9cI6JmRIz8hSEqh6ZOX4763/zo21OlsOQLJMBW2IIjW6qn
         Thx1hN82+aCHuThJW27XUflUMe/J2rjNdjm88pnhUIsMSpxB9q/xQVRQCHh9AIv2gXrN
         cgSw==
X-Forwarded-Encrypted: i=1; AJvYcCUl1RMRstwgFeefX1JlHBqQjFd2EyVpCnKFtWoLlQJiSGPtAY5VW4fNJZqtGXLiTLPoDuQDlb7ua671RShqnHYqkLfFdCsxzrVyEX4O
X-Gm-Message-State: AOJu0YyNsmDpZD6+DZ8NxvGgAqHctw7yxNB7Yatkhr1ap6gN098lANcX
	gCOeb8gL9Z+T5jzMrdXfeSvJkCm4nMNVXE002iLCQcPpcUjjL8HDrdU41K6yAFg=
X-Google-Smtp-Source: AGHT+IEF/yoLSdvMIE/olXGPCBno7lcjbtysDOgtFqxYSK5IvP4v88qAJ20p7sXbE3UZY9M3aUZyrA==
X-Received: by 2002:a05:600c:4fd3:b0:424:aa35:9fb9 with SMTP id 5b1f17b1804b1-427dc515d0bmr48796895e9.2.1721643226834;
        Mon, 22 Jul 2024 03:13:46 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:46 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 16/17] coresight: Emit sink ID in the HW_ID packets
Date: Mon, 22 Jul 2024 11:11:58 +0100
Message-Id: <20240722101202.26915-17-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>
References: <20240722101202.26915-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

For Perf to be able to decode when per-sink trace IDs are used, emit the
sink that's being written to for each ETM.

Perf currently errors out if it sees a newer packet version so instead
of bumping it, add a new minor version field. This can be used to
signify new versions that have backwards compatible fields. Considering
this change is only for high core count machines, it doesn't make sense
to make a breaking change for everyone.

Signed-off-by: James Clark <james.clark@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c  | 26 ++++++++++---------
 .../hwtracing/coresight/coresight-etm-perf.c  | 16 ++++++++----
 drivers/hwtracing/coresight/coresight-priv.h  |  1 +
 include/linux/coresight-pmu.h                 | 17 +++++++++---
 4 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index faf560ba8d64..c427e9344a84 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -487,23 +487,25 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
 	return csdev;
 }
 
+u32 coresight_get_sink_id(struct coresight_device *csdev)
+{
+	if (!csdev->ea)
+		return 0;
+
+	/*
+	 * See function etm_perf_add_symlink_sink() to know where
+	 * this comes from.
+	 */
+	return (u32) (unsigned long) csdev->ea->var;
+}
+
 static int coresight_sink_by_id(struct device *dev, const void *data)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
-	unsigned long hash;
 
 	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
-	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
-
-		if (!csdev->ea)
-			return 0;
-		/*
-		 * See function etm_perf_add_symlink_sink() to know where
-		 * this comes from.
-		 */
-		hash = (unsigned long)csdev->ea->var;
-
-		if ((u32)hash == *(u32 *)data)
+	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		if (coresight_get_sink_id(csdev) == *(u32 *)data)
 			return 1;
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 70c99f0409b2..ad6a8f4b70b6 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -460,6 +460,7 @@ static void etm_event_start(struct perf_event *event, int flags)
 	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
 	struct list_head *path;
 	u64 hw_id;
+	u8 trace_id;
 
 	if (!csdev)
 		goto fail;
@@ -512,11 +513,16 @@ static void etm_event_start(struct perf_event *event, int flags)
 	 */
 	if (!cpumask_test_cpu(cpu, &event_data->aux_hwid_done)) {
 		cpumask_set_cpu(cpu, &event_data->aux_hwid_done);
-		hw_id = FIELD_PREP(CS_AUX_HW_ID_VERSION_MASK,
-				   CS_AUX_HW_ID_CURR_VERSION);
-		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK,
-				    coresight_trace_id_read_cpu_id_map(cpu,
-								       &sink->perf_sink_id_map));
+
+		trace_id = coresight_trace_id_read_cpu_id_map(cpu, &sink->perf_sink_id_map);
+
+		hw_id = FIELD_PREP(CS_AUX_HW_ID_MAJOR_VERSION_MASK,
+				CS_AUX_HW_ID_MAJOR_VERSION);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_MINOR_VERSION_MASK,
+				CS_AUX_HW_ID_MINOR_VERSION);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_TRACE_ID_MASK, trace_id);
+		hw_id |= FIELD_PREP(CS_AUX_HW_ID_SINK_ID_MASK, coresight_get_sink_id(sink));
+
 		perf_report_aux_output_id(event, hw_id);
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 61a46d3bdcc8..05f891ca6b5c 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -148,6 +148,7 @@ int coresight_make_links(struct coresight_device *orig,
 			 struct coresight_device *target);
 void coresight_remove_links(struct coresight_device *orig,
 			    struct coresight_connection *conn);
+u32 coresight_get_sink_id(struct coresight_device *csdev);
 
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 extern int etm_readl_cp14(u32 off, unsigned int *val);
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 51ac441a37c3..89b0ac0014b0 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -49,12 +49,21 @@
  * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
  * Used to associate a CPU with the CoreSight Trace ID.
  * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
- * [59:08] - Unused (SBZ)
- * [63:60] - Version
+ * [39:08] - Sink ID - as reported in /sys/bus/event_source/devices/cs_etm/sinks/
+ *	      Added in minor version 1.
+ * [55:40] - Unused (SBZ)
+ * [59:56] - Minor Version - previously existing fields are compatible with
+ *	      all minor versions.
+ * [63:60] - Major Version - previously existing fields mean different things
+ *	      in new major versions.
  */
 #define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
-#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
+#define CS_AUX_HW_ID_SINK_ID_MASK	GENMASK_ULL(39, 8)
 
-#define CS_AUX_HW_ID_CURR_VERSION 0
+#define CS_AUX_HW_ID_MINOR_VERSION_MASK	GENMASK_ULL(59, 56)
+#define CS_AUX_HW_ID_MAJOR_VERSION_MASK	GENMASK_ULL(63, 60)
+
+#define CS_AUX_HW_ID_MAJOR_VERSION 0
+#define CS_AUX_HW_ID_MINOR_VERSION 1
 
 #endif
-- 
2.34.1


