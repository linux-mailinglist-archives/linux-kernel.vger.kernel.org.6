Return-Path: <linux-kernel+bounces-258855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91736938D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42191C20DAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD9816E882;
	Mon, 22 Jul 2024 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KzUpwofy"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88116E872
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643235; cv=none; b=TgdEbp3Z+jCCmBOosNEshWn6mAHfUS7+GbvhzN7Olu79MSCPad6tTbs9eEyQuyWXA3ysVzzQqvy4fWWCljfbZ4GHYJ2SxQgWaS+ddBgWoUxK8AIAcAd/WUdNYV3I3sSlO25FGHtBpQOMTDzapapAjxKKdZUhv8ZYAueQEir3uvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643235; c=relaxed/simple;
	bh=jrx2xOG+BGl3DXknE6CcRbBSOPc6efmotOncGu9ZjVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lB8axKT8OZlHL3GZc8MAgmD9mB0IBKEqyN4bXf+L2HzNj+99dX8wehg6eBMAdA6Ui+wOFKnKUeWEDYWy3UXOts+6/D1SNoYZN9eQ4x8yo7SElaTRQ7TcxebnkLy5Hcp6faqkpKAz11sk0/PxrqQ01CGdHnhHLnRsFvwRgr16D1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KzUpwofy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426636ef8c9so28667735e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643231; x=1722248031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+BH4X7qQ4KNzfIEiAndweOYoOD6xkKc0EkDm+LBpWo=;
        b=KzUpwofyDg6q7WgXqy1Ry12hYuU656Ibr45vZmjk1yKbOgq3RbA5RT67If+R76Acaj
         uLbuakJDvVnDPltMu0PsKc8mGidNncnPffKMslaSYvqnhhC5LhwzTxlQ7xGZ67D0wWXe
         NOs3Z+uC9gnVpeQI6yqG8umD4tEi4v93Q9WbKVxpeJUmRuU7N6A/8NBIj/nLQAnML/2K
         KPR4lbaaAUgpuvy8uxpC8R2i4Zgch/fyaRmsbqZmyDFStCZRdEionp5nZMkDQPNoFP54
         oN70drZ916xLDeK/OzHFXFdiAwJoYfBFWYsFKWlAIESuem3rjdunprJaulWqmEGegkwI
         tQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643231; x=1722248031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+BH4X7qQ4KNzfIEiAndweOYoOD6xkKc0EkDm+LBpWo=;
        b=ZdFxIxUOGI2XS26rwBJqCAXdtkjc46PEwSkavfKL6OHdYWErGLN3cnQZIxCxHu83FN
         YsQOqlorpJ49msGOwKTaCWbb/lnze12d4noCmVzU2paGRCgjl0VQnM+CnBEui2oKdyjY
         IaUGXBJBLwqq8UADiNrr7KpxkaPBlchxaR7YP6iTRw6Lp0eQZ/pIkJK1AJER/eA83MAN
         ZuXomV0DeaL31lyvYWLOnkPSsQEHgmU4U3TPWTTZkEjJd5tLpjthsTMMbo0x/6N/2c/c
         joGRYjcTW2CUnVYCm2QpbqAdWrZ3kHakWAe6dXB+EoFuF+IPcbulKsdPc7eGoSbWKVOA
         MdRw==
X-Forwarded-Encrypted: i=1; AJvYcCUwoy3VGT37+sq8c5wW8zf/EZGSgmI6I1JCtp0dwDLSUvtDYa/4p+mIzq9B66iNEj2Sd2vYrJ95AhyOAKV8lAMLaEu9Iod8qsDJ7DQi
X-Gm-Message-State: AOJu0YxgGmoFBGNkfvt7AtasiE0GRfvxyRhayYvd65zk6lvinn6dUnR3
	5smED8mr1OFX/2sxnNtJXI4Mp8do/eQHWTJPk/Bl78AoII+L9EKApNglg87qk9g=
X-Google-Smtp-Source: AGHT+IGEih7x54xnRim+kyshwE4WvvKfQZnB7WzqI+VTII9cpDdOreaV8/bNOtGb2AVj31TH/u3YHA==
X-Received: by 2002:a05:600c:45ce:b0:426:549c:294c with SMTP id 5b1f17b1804b1-427dc57aaacmr39518275e9.35.1721643231649;
        Mon, 22 Jul 2024 03:13:51 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:51 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
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
Subject: [PATCH v6 17/17] coresight: Make trace ID map spinlock local to the map
Date: Mon, 22 Jul 2024 11:11:59 +0100
Message-Id: <20240722101202.26915-18-james.clark@linaro.org>
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

Reduce contention on the lock by replacing the global lock with one for
each map.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c  |  1 +
 .../hwtracing/coresight/coresight-trace-id.c  | 26 +++++++++----------
 include/linux/coresight.h                     |  1 +
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index c427e9344a84..ea38ecf26fcb 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1164,6 +1164,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
 	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+		spin_lock_init(&csdev->perf_sink_id_map.lock);
 		csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
 		if (!csdev->perf_sink_id_map.cpu_map) {
 			kfree(csdev);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index bddaed3e5cf8..d98e12cb30ec 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -15,12 +15,10 @@
 /* Default trace ID map. Used in sysfs mode and for system sources */
 static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
 static struct coresight_trace_id_map id_map_default = {
-	.cpu_map = &id_map_default_cpu_ids
+	.cpu_map = &id_map_default_cpu_ids,
+	.lock = __SPIN_LOCK_UNLOCKED(id_map_default.lock)
 };
 
-/* lock to protect id_map and cpu data  */
-static DEFINE_SPINLOCK(id_map_lock);
-
 /* #define TRACE_ID_DEBUG 1 */
 #if defined(TRACE_ID_DEBUG) || defined(CONFIG_COMPILE_TEST)
 
@@ -123,11 +121,11 @@ static void coresight_trace_id_release_all(struct coresight_trace_id_map *id_map
 	unsigned long flags;
 	int cpu;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 	bitmap_zero(id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
 	for_each_possible_cpu(cpu)
 		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 	DUMP_ID_MAP(id_map);
 }
 
@@ -136,7 +134,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	unsigned long flags;
 	int id;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 
 	/* check for existing allocation for this CPU */
 	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
@@ -163,7 +161,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
 
 get_cpu_id_out_unlock:
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID_CPU(cpu, id);
 	DUMP_ID_MAP(id_map);
@@ -180,12 +178,12 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
 	if (!id)
 		return;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 
 	coresight_trace_id_free(id, id_map);
 	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
 
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 	DUMP_ID_CPU(cpu, id);
 	DUMP_ID_MAP(id_map);
 }
@@ -195,10 +193,10 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
 	unsigned long flags;
 	int id;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 	/* prefer odd IDs for system components to avoid legacy CPU IDS */
 	id = coresight_trace_id_alloc_new_id(id_map, 0, true);
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID(id);
 	DUMP_ID_MAP(id_map);
@@ -209,9 +207,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&id_map_lock, flags);
+	spin_lock_irqsave(&id_map->lock, flags);
 	coresight_trace_id_free(id, id_map);
-	spin_unlock_irqrestore(&id_map_lock, flags);
+	spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID(id);
 	DUMP_ID_MAP(id_map);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 197949fd2c35..c13342594278 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -233,6 +233,7 @@ struct coresight_trace_id_map {
 	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
 	atomic_t __percpu *cpu_map;
 	atomic_t perf_cs_etm_session_active;
+	spinlock_t lock;
 };
 
 /**
-- 
2.34.1


