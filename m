Return-Path: <linux-kernel+bounces-529428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8589EA4261A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3828916F03F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAA519E997;
	Mon, 24 Feb 2025 15:14:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A110158858;
	Mon, 24 Feb 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410090; cv=none; b=G4HCvTjK5yrOWtbCLxJjKiJCJ8QOzRWZtpUzHIeLeX/Sww8VG5fW7bWUiQh7ROLohlRUZNzgQEWB8ydE/cvxTOKXtDAE4mPmjAf38MxvOj4rpUVa/wHq2qadBGmQvuv37gAerRiHxw/EMigwbxC8nZexJHhwjsM+SKGjYqeessY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410090; c=relaxed/simple;
	bh=AD94CFxJfzegnU9i2F1Cso2ouQs+hEtuQGzWbW+93sY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I+GVLNNdfeoS8dK0x0QVTpdNvQOG7Dkl3aFfE3vZFBffYAsDFZkg6pAJv/BzdIp6hfmEpx4M5uPho2qXSdk6W2ZrvRhlky1HX3oqenHQv9N6w5q783JZGda2chHdpPvrTiCDQnumRIvB2tLnyUHIgo4mo/fUm09rKfsrvVs9crc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00CE01756;
	Mon, 24 Feb 2025 07:15:04 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 919E23F6A8;
	Mon, 24 Feb 2025 07:14:45 -0800 (PST)
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
Subject: [PATCH v1 2/8] coresight: Introduce pause and resume APIs for source
Date: Mon, 24 Feb 2025 15:14:17 +0000
Message-Id: <20250224151423.1630639-3-leo.yan@arm.com>
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

Introduce APIs for pausing and resuming trace source and export as GPL
symbols.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 12 ++++++++++++
 drivers/hwtracing/coresight/coresight-priv.h |  2 ++
 include/linux/coresight.h                    |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 0a9380350fb5..4c911183928c 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -365,6 +365,18 @@ void coresight_disable_source(struct coresight_device *csdev, void *data)
 }
 EXPORT_SYMBOL_GPL(coresight_disable_source);
 
+void coresight_pause_source(struct coresight_device *csdev)
+{
+	source_ops(csdev)->pause(csdev);
+}
+EXPORT_SYMBOL_GPL(coresight_pause_source);
+
+void coresight_resume_source(struct coresight_device *csdev)
+{
+	source_ops(csdev)->resume(csdev);
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


