Return-Path: <linux-kernel+bounces-258849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92531938D53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A2D1C2170F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7716DC0A;
	Mon, 22 Jul 2024 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UltkTRvY"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1570516DC01
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643207; cv=none; b=NyZVtAVqrGg68Igh5G436xhGH42czD7hgOyJte98a8gBRyPMEaS8Ptw4D6evZ8uyYJgtabJ8Ul1LqP1ohOMAAZySorkemBjl4O32JHJDnV4lB3ZIJ25nq1MTj9rTlK5+AV+aafSQ9wK8YGHdSGgc/+gZ/z9fwDkWU8Xsgm2Sga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643207; c=relaxed/simple;
	bh=pfTg193U03VQHBc5Y92Ek7wGOxzx6knrjLyWX8sWCXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1xD2iyclg7AnVV/hktOhjyyzCj0B/sw0LzWa6gyNJtXAtFaO5YQXBmNAS1dxq9k2nLaEH80E0qiRykmSnNJUCCV9B8U/ZOwMZA3aF09RBJ5FCh12sFdK/cwyKjUqbYHeyNWQjjacbCGeuPA7oLDdhSQW2SJJBs+7bHlR2fmNws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UltkTRvY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so27083195e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643202; x=1722248002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob3o88R/yxUBwonSp9vzDZCeFMZAfTzy7u2JCgClFSk=;
        b=UltkTRvYoPweB+lBm1Nc6gJvL9IwFYxxQSEQ2ihtZlq5wCvIDokdk/a9nMVW1H2pdW
         xHD2vmHt4Hn5EICc5S04x7nBrax2Uv8Fmgn6v1tAvtnV2LtrksbxtCYLTUyiYSslst5C
         X0tfk1v19ufyGILO6pmqi2k2FVqgCntRjnWuZTdSXDNaeGrjA/kTNYDo8l9zNhHGFlaX
         dSQrp/YcgKTjpIh5eh5qL0QPLMKvmB4KG3QkHcCT14IY1HVpuoqtGY61kKuNE7go9Qx5
         b4xrDto743DFthLWHiqk2cJa8jBwykioB2SnMdonK7ZwwMbrRVZQC6tZ9giQQZHJR/L0
         37LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643202; x=1722248002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ob3o88R/yxUBwonSp9vzDZCeFMZAfTzy7u2JCgClFSk=;
        b=iYBSQO+NSxKZPDyeZ5WZ8YYSrT09MpJnluiNpg20TyPh/Q1HFw6vvfaKrbI0BBcoTM
         CYFXaApFTYRyzMWVSFxbU2JuXPSg7cGlGrJRF14Bt5q4VDapRFt+QOjF1WdWtiztrdcc
         zipEUzWJcSw99Vl/fIpZ9bO8tkNGog4yfTCpFyNWmzFunb8ZPgRpz8d8G09tc0ZBNHvD
         GPVMBuiduDoBvoaYYbGxuG9ZDdH1/ynFEBJbMt5vJu+hYYQ56K+WlZPSGZ6iWYXISkzs
         SyGthlk+yPCnRvfh1QZ18+HJWBA+A6sDvzJH1KqEa2msm/HF0t4nlfUiakDMb6Eqrna7
         uP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzdE3AjmmrdGs34ylSfzmgrrJZ7CC0omyY5tSiSQ12sVaDkS6Fa3/NVu2ZKEKwT23yOtruLJHkW0UGFsGJB1GYdGpvWouWNIrj5C41
X-Gm-Message-State: AOJu0YyIAMXN91KBX0IyBbQH2G9nWGgWcMBxZixrFzdxD4aia7HGg6l2
	rVc9HidOaetkSOYEzxogre0yhmk72+YsuadYfnIfN+6X+Q/Wkz2iJzjxPd8ucFg=
X-Google-Smtp-Source: AGHT+IFnRlQjxIzplZP9hmspE1klaaY7FAnTuoO73aRSdCaRY/lNjrX74jyuwVgqrmifZPXhzx+e5A==
X-Received: by 2002:a05:600c:4f4e:b0:427:b995:5bd0 with SMTP id 5b1f17b1804b1-427daa61cbfmr47929775e9.23.1721643202485;
        Mon, 22 Jul 2024 03:13:22 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:22 -0700 (PDT)
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
Subject: [PATCH v6 11/17] coresight: Move struct coresight_trace_id_map to common header
Date: Mon, 22 Jul 2024 11:11:53 +0100
Message-Id: <20240722101202.26915-12-james.clark@linaro.org>
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

The trace ID maps will need to be created and stored by the core and
Perf code so move the definition up to the common header.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Signed-off-by: James Clark <james.clark@linaro.org>
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


