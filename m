Return-Path: <linux-kernel+bounces-228950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F27EA9168FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDEC1C2528F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C57316A382;
	Tue, 25 Jun 2024 13:33:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE9A15F3F9;
	Tue, 25 Jun 2024 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322431; cv=none; b=QkacynJgzCIHjsOvYk+cS9fu3JnE4eaz0TMMG8DOoq8QqsQhq42awX2pT9ae4418liiRomYpGt25qklKb6SGM6+fzUeup0wZWQOKWCmdd7AmjK9Q7yhUIfZxsU3iOfSSJ731qy1veL9HDMVmztnz9B31afAMXpcvzqFgiUIBZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322431; c=relaxed/simple;
	bh=dURqEr78iL4SJ+PjS1h9hXb4BsJXz45pIuev3F2tKPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQUK18tcTTeMJtyWxdhbi1w27ugs2ABVe65HFKlkwujTYkoXG0fmtJleRyfcl7CfYg4vYMN08nkjIPOAwUnohXG3kHrh9j1Xa5BMcNrxrhMoWfT/nZDluu01g6mTjFErmN+MjYwL/Gm/Co7I18NmYuqsjhObM3J6U7iC1F9KTjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E05E150C;
	Tue, 25 Jun 2024 06:34:14 -0700 (PDT)
Received: from e127643.broadband (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0CE683F73B;
	Tue, 25 Jun 2024 06:33:45 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com,
	jszu@nvidia.com,
	bwicaksono@nvidia.com
Cc: James Clark <james.clark@arm.com>,
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
Subject: [PATCH v4 11/17] coresight: Move struct coresight_trace_id_map to common header
Date: Tue, 25 Jun 2024 14:30:54 +0100
Message-Id: <20240625133105.671245-12-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625133105.671245-1-james.clark@arm.com>
References: <20240625133105.671245-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trace ID maps will need to be created and stored by the core and
Perf code so move the definition up to the common header.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../hwtracing/coresight/coresight-trace-id.c  |  1 +
 .../hwtracing/coresight/coresight-trace-id.h  | 19 -------------------
 include/linux/coresight.h                     | 18 ++++++++++++++++++
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index af5b4ef59cea..19005b5b4dc4 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2022, Linaro Limited, All rights reserved.
  * Author: Mike Leach <mike.leach@linaro.org>
  */
+#include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/cpumask.h>
 #include <linux/kernel.h>
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
index 3797777d367e..49438a96fcc6 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.h
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -32,10 +32,6 @@
 #include <linux/bitops.h>
 #include <linux/types.h>
 
-
-/* architecturally we have 128 IDs some of which are reserved */
-#define CORESIGHT_TRACE_IDS_MAX 128
-
 /* ID 0 is reserved */
 #define CORESIGHT_TRACE_ID_RES_0 0
 
@@ -46,21 +42,6 @@
 #define IS_VALID_CS_TRACE_ID(id)	\
 	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
 
-/**
- * Trace ID map.
- *
- * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
- *		Initialised so that the reserved IDs are permanently marked as
- *		in use.
- * @pend_rel_ids: CPU IDs that have been released by the trace source but not
- *		  yet marked as available, to allow re-allocation to the same
- *		  CPU during a perf session.
- */
-struct coresight_trace_id_map {
-	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
-	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
-};
-
 /* Allocate and release IDs for a single default trace ID map */
 
 /**
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index f09ace92176e..c16c61a8411d 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -218,6 +218,24 @@ struct coresight_sysfs_link {
 	const char *target_name;
 };
 
+/* architecturally we have 128 IDs some of which are reserved */
+#define CORESIGHT_TRACE_IDS_MAX 128
+
+/**
+ * Trace ID map.
+ *
+ * @used_ids:	Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
+ *		Initialised so that the reserved IDs are permanently marked as
+ *		in use.
+ * @pend_rel_ids: CPU IDs that have been released by the trace source but not
+ *		  yet marked as available, to allow re-allocation to the same
+ *		  CPU during a perf session.
+ */
+struct coresight_trace_id_map {
+	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
+	DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
+};
+
 /**
  * struct coresight_device - representation of a device as used by the framework
  * @pdata:	Platform data with device connections associated to this device.
-- 
2.34.1


