Return-Path: <linux-kernel+bounces-554022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CDEA591EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D2A3AA45B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5482022E3E1;
	Mon, 10 Mar 2025 10:49:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3857422DFAC;
	Mon, 10 Mar 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603780; cv=none; b=IXBi0NwzT4bEwDpHJ/4qIZOenR6yzD7RWAzeyB1E/QRjVrp+giQDnQbT+lr3VrC54cq/nR1cNMKSkXzQunDmwMA7/kX7j1ZntnZJsyiAex0T/TpRr8BTfmVn2iJKzBPJu9TLUFuBBWCM60q62CC+fRbHLh8qfkXLYOpsFt032CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603780; c=relaxed/simple;
	bh=KkpYxuL1uLu1jKclPiVsV+6ZGMawm3j5Ei8x+PAF5r8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpcMb8mVcOc0FePmEANo13q+tbi37BAucB2x7D6FGKOaEnffoxeDEx8z/gzug1ewESw0vFWr8SLrOJYjkRGXDmpG8iqRk/u+fkjyz+pJHR45zf8H5K8dWeoqHdsy4sZ0X+w75VsrwW8UktnsW4ray8GiAsNrbAl2zANL5CWSc7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 164C0153B;
	Mon, 10 Mar 2025 03:49:50 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE3223F5A1;
	Mon, 10 Mar 2025 03:49:36 -0700 (PDT)
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
Subject: [PATCH v2 5/8] coresight: etm: Add an attribute for updating buffer
Date: Mon, 10 Mar 2025 10:49:16 +0000
Message-Id: <20250310104919.58816-6-leo.yan@arm.com>
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

Add an attribute for updating buffer when the AUX trace is paused.  And
populate the value to the 'update_buf_on_pause' flag during the AUX
setting up.

If the AUX pause operation is attached to a PMU counter, when the
counter is overflow and if the PMU interrupt in an NMI, then AUX pause
operation will be triggered in the NMI context.  On the other hand, the
per CPU sink has its own interrupt handling.  Thus, there will be a race
condition between the updating buffer in NMI and sink's interrupt
handler.

To avoid the race condition, this commit disallows updating buffer on
AUX pause for the per CPU sink.  Currently, this is only applied for
TRBE.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 20 +++++++++++++++++++
 .../hwtracing/coresight/coresight-etm-perf.h  |  2 ++
 include/linux/coresight-pmu.h                 |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 29d52386ffbb..d759663a1f7d 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -62,6 +62,8 @@ PMU_FORMAT_ATTR(contextid1,	"config:" __stringify(ETM_OPT_CTXTID));
 PMU_FORMAT_ATTR(contextid2,	"config:" __stringify(ETM_OPT_CTXTID2));
 PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
 PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
+PMU_FORMAT_ATTR(update_buf_on_pause,
+		"config:" __stringify(ETM_OPT_UPDATE_BUF_ON_PAUSE));
 /* preset - if sink ID is used as a configuration selector */
 PMU_FORMAT_ATTR(preset,		"config:0-3");
 /* Sink ID - same for all ETMs */
@@ -103,6 +105,7 @@ static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_configid.attr,
 	&format_attr_branch_broadcast.attr,
 	&format_attr_cc_threshold.attr,
+	&format_attr_update_buf_on_pause.attr,
 	NULL,
 };
 
@@ -434,6 +437,23 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	if (!sink)
 		goto err;
 
+	/* Populate the flag for updating buffer on AUX pause */
+	event_data->update_buf_on_pause =
+		!!(event->attr.config & BIT(ETM_OPT_UPDATE_BUF_ON_PAUSE));
+
+	if (event_data->update_buf_on_pause) {
+		/*
+		 * The per CPU sink has own interrupt handling, it might have
+		 * race condition with updating buffer on AUX trace pause if
+		 * it is invoked from NMI.  To avoid the race condition,
+		 * disallows updating buffer for the per CPU sink case.
+		 */
+		if (coresight_is_percpu_sink(sink)) {
+			dev_err(&sink->dev, "update_buf_on_pause is not permitted.\n");
+			goto err;
+		}
+	}
+
 	/* If we don't have any CPUs ready for tracing, abort */
 	cpu = cpumask_first(mask);
 	if (cpu >= nr_cpu_ids)
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 744531158d6b..52b9385f8c11 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -51,6 +51,7 @@ struct etm_filters {
  * @aux_hwid_done:	Whether a CPU has emitted the TraceID packet or not.
  * @snk_config:		The sink configuration.
  * @cfg_hash:		The hash id of any coresight config selected.
+ * @update_buf_on_pause: The flag to indicate updating buffer on AUX pause.
  * @path:		An array of path, each slot for one CPU.
  */
 struct etm_event_data {
@@ -59,6 +60,7 @@ struct etm_event_data {
 	cpumask_t aux_hwid_done;
 	void *snk_config;
 	u32 cfg_hash;
+	bool update_buf_on_pause;
 	struct list_head * __percpu *path;
 };
 
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 89b0ac0014b0..04147e30c2f2 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -35,6 +35,7 @@
 #define ETM_OPT_CTXTID2		15
 #define ETM_OPT_TS		28
 #define ETM_OPT_RETSTK		29
+#define ETM_OPT_UPDATE_BUF_ON_PAUSE	30
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
 #define ETM4_CFG_BIT_BB         3
-- 
2.34.1


