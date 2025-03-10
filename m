Return-Path: <linux-kernel+bounces-554019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66782A591DF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50BB16CA44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBF922D7A8;
	Mon, 10 Mar 2025 10:49:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F5522A1D5;
	Mon, 10 Mar 2025 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603774; cv=none; b=iJt6ntXHvcYuNqJDH9N//UYUPqpURdLA8CTx7KghNaMFpCzXNoUfQ3Ehd192HC7UuUqTPZibCSHZR01zr1IG5mrFNNpZDJ7XndgKDLRVDvvK7OxF0dtMUnnmQr8f03BFQxrWCvuhHSsRbtTvMDSwW/d01Sfevx3aaTmnTcT5HfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603774; c=relaxed/simple;
	bh=o8VOJBBR9eT3wIp6AnnF06ZDv2ZfycmayowxyOG0/6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBkN10nPJU9Ad/tikraGKODmSafaPNvqtvGNooyAfuF2zJyRPfVD7ons/dwRhfQwQd1XQPittWcctozsseRKQ8YC07uh1mczI2rB8LruyXfhAbyra4d2pLSjQpGpqulJne0Hi3PyQLcPuGtC0RSKTXQ+3VWptBTtZyY5FvREwIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2EE153B;
	Mon, 10 Mar 2025 03:49:44 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5F273F673;
	Mon, 10 Mar 2025 03:49:30 -0700 (PDT)
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
Subject: [PATCH v2 2/8] coresight: Introduce pause and resume APIs for source
Date: Mon, 10 Mar 2025 10:49:13 +0000
Message-Id: <20250310104919.58816-3-leo.yan@arm.com>
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

Introduce APIs for pausing and resuming trace source and export as GPL
symbols.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 20 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h |  2 ++
 include/linux/coresight.h                    |  4 ++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 0a9380350fb5..eb7b83a7bfa2 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -365,6 +365,26 @@ void coresight_disable_source(struct coresight_device *csdev, void *data)
 }
 EXPORT_SYMBOL_GPL(coresight_disable_source);
 
+void coresight_pause_source(struct coresight_device *csdev)
+{
+	if (!csdev || !coresight_is_percpu_source(csdev))
+		return;
+
+	if (source_ops(csdev)->pause)
+		source_ops(csdev)->pause(csdev);
+}
+EXPORT_SYMBOL_GPL(coresight_pause_source);
+
+void coresight_resume_source(struct coresight_device *csdev)
+{
+	if (!csdev || !coresight_is_percpu_source(csdev))
+		return;
+
+	if (source_ops(csdev)->resume)
+		source_ops(csdev)->resume(csdev);
+}
+EXPORT_SYMBOL_GPL(coresight_resume_source);
+
 /*
  * coresight_disable_path_from : Disable components in the given path beyond
  * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 76403530f33e..a9f14c075e91 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -247,5 +247,7 @@ void coresight_add_helper(struct coresight_device *csdev,
 void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
 struct coresight_device *coresight_get_percpu_sink(int cpu);
 void coresight_disable_source(struct coresight_device *csdev, void *data);
+void coresight_pause_source(struct coresight_device *csdev);
+void coresight_resume_source(struct coresight_device *csdev);
 
 #endif
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 17276965ff1d..703e1b8dbe22 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -385,6 +385,8 @@ struct coresight_ops_link {
  *		is associated to.
  * @enable:	enables tracing for a source.
  * @disable:	disables tracing for a source.
+ * @resume:	resumes tracing for a source.
+ * @pause:	pauses tracing for a source.
  */
 struct coresight_ops_source {
 	int (*cpu_id)(struct coresight_device *csdev);
@@ -392,6 +394,8 @@ struct coresight_ops_source {
 		      enum cs_mode mode, struct coresight_trace_id_map *id_map);
 	void (*disable)(struct coresight_device *csdev,
 			struct perf_event *event);
+	int (*resume)(struct coresight_device *csdev);
+	void (*pause)(struct coresight_device *csdev);
 };
 
 /**
-- 
2.34.1


