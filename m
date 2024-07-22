Return-Path: <linux-kernel+bounces-258850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D57938D54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E491C21957
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D316DC1E;
	Mon, 22 Jul 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJISrhqz"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFB716DC0F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643210; cv=none; b=E4D5xYXq10J7edzybsJ8pUu86shTM/cMDa/WHqpYHpSxhWHhHB/GhNO/DtMcdkEJ9muH7Rr4RoWg+KOSQh632OfFZU8Z0XDkRRisxAN4cVi04iC2lKvusnRFQCcU4dC/sQRa/NbfYtK1wvwVP8n8isBrA03tJo4WBPYVXHbWuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643210; c=relaxed/simple;
	bh=8R5OmeoGLlv5vqwVm9o4il46zprkK1aLP1TxCFBpp4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UGWQ660BEesbhdPeHRArq/+mxFDQwaij1l0ad1rweQ2KP/aDySYAvFXtZo9IfAxa0M2VzcfVfYK7toU5L8hG0PDkn30nuO0tDz6i/rXGgHlt9J8+HFi56ZarsOXG//SzDwo30DKprqx8gwlRIHF4/oMesbprQfSUt49myhJHVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TJISrhqz; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so2107627e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643207; x=1722248007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6Zkl3RZ0YZqXGz3k9BNGR/j5j9H7UAlIZzg0Q8iJLg=;
        b=TJISrhqzA+6QJcgHbb2fdtCWIlgcEh1HKDjJlvqM9P4X6kdVHi9KarReB8KMesXMyn
         4JKet8HpmjC8Hwh0DYaljF7aQQa/MmJmaJ7yMk1C58adwwypNs1zqe+Nm4ll9+asTw6s
         ZNNtFvlVeZAWQcxzpLAGPoMMfuXmMeRna81NI5npH7bPac/wEyTH35vMI1pNt23DEQnU
         lohEYG8wrAZuh33lyaDaDYOfRNpILzhQ+pHgw0etsF6dYWjGg6hylk6yefuQ78NfDMax
         t1BgDoxDJpABdt0AGAbet5pfdDI9bZM8RnbBzVjtIfWyqIJ89oDrsEfyDUlx3o6B3SXa
         8k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643207; x=1722248007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6Zkl3RZ0YZqXGz3k9BNGR/j5j9H7UAlIZzg0Q8iJLg=;
        b=lACI85OQVWsu4a0g3iz/DmzPJXw3V1ypn0KoWejEPP/ai8aDbJMckrSpEtUQ6VmQNY
         yN9OygxQljStlLyMIy51nGScNvc5L5UYg6jZ+trSuRL4JQbscWJXsRc53KiQUimG1iza
         OGO0mI4PmJ2R7YoLdqIGDjLFZmOvz8Q9OCS5qMSa9rvJLSG2ohe5AbtofZhR2Gk5CYiJ
         Edrn/Ua3mDAHvlEviMLFAqmT3pBmK6fkuX3kN5Gl8NbUprzu66xeXVpMW6X3Mf6Sy9JK
         JstCuj5urKKQLIvtE+Nkmd9h1rMQDlvYz1P+jN1gSYyaEg+KzfUuN1iRaWBu9QfLu1C5
         3Yjg==
X-Forwarded-Encrypted: i=1; AJvYcCWejTiOc1/9hAcn791Q7f7jOjoHo/RceP2P9tKclXkOngTghjwfcFxXKXXhSovb21eDf8CrrOCL+fQg6hdeJzcs4SVK7gUAJCep/i3/
X-Gm-Message-State: AOJu0YyhpQW4Miixr1WQHAlbAwoYwBIsW9AJJfcVvfHYC+muddhBjJms
	xR+istnZsXqujn2skARoVJv0lwwpU3lb3RbsWRiWN+qO5Yx2ihWIPiQgDg33Yc8=
X-Google-Smtp-Source: AGHT+IHtzUnS25hXmocvsE039YvTk03X0Hq/y0ReZ7EbenrUSY/BqUT58J9l2FysaxuwFgPpAsPnJw==
X-Received: by 2002:a05:6512:3409:b0:52c:dac3:392b with SMTP id 2adb3069b0e04-52efb7c592emr3426436e87.33.1721643207351;
        Mon, 22 Jul 2024 03:13:27 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:27 -0700 (PDT)
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
Subject: [PATCH v6 12/17] coresight: Expose map arguments in trace ID API
Date: Mon, 22 Jul 2024 11:11:54 +0100
Message-Id: <20240722101202.26915-13-james.clark@linaro.org>
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

The trace ID API is currently hard coded to always use the global map.
Add public versions that allow the map to be passed in so that Perf
mode can use per-sink maps. Keep the non-map versions so that sysfs
mode can continue to use the default global map.

System ID functions are unchanged because they will always use the
default map.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../hwtracing/coresight/coresight-trace-id.c  | 36 ++++++++++++++-----
 .../hwtracing/coresight/coresight-trace-id.h  | 20 +++++++++--
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 19005b5b4dc4..5561989a03fa 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -12,7 +12,7 @@
 
 #include "coresight-trace-id.h"
 
-/* Default trace ID map. Used on systems that don't require per sink mappings */
+/* Default trace ID map. Used in sysfs mode and for system sources */
 static struct coresight_trace_id_map id_map_default;
 
 /* maintain a record of the mapping of IDs and pending releases per cpu */
@@ -47,7 +47,7 @@ static void coresight_trace_id_dump_table(struct coresight_trace_id_map *id_map,
 #endif
 
 /* unlocked read of current trace ID value for given CPU */
-static int _coresight_trace_id_read_cpu_id(int cpu)
+static int _coresight_trace_id_read_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
 {
 	return atomic_read(&per_cpu(cpu_id, cpu));
 }
@@ -152,7 +152,7 @@ static void coresight_trace_id_release_all_pending(void)
 	DUMP_ID_MAP(id_map);
 }
 
-static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
 {
 	unsigned long flags;
 	int id;
@@ -160,7 +160,7 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 	spin_lock_irqsave(&id_map_lock, flags);
 
 	/* check for existing allocation for this CPU */
-	id = _coresight_trace_id_read_cpu_id(cpu);
+	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
 	if (id)
 		goto get_cpu_id_clr_pend;
 
@@ -196,13 +196,13 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
 	return id;
 }
 
-static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
+static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
 {
 	unsigned long flags;
 	int id;
 
 	/* check for existing allocation for this CPU */
-	id = _coresight_trace_id_read_cpu_id(cpu);
+	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
 	if (!id)
 		return;
 
@@ -254,22 +254,40 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 
 int coresight_trace_id_get_cpu_id(int cpu)
 {
-	return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
+	return _coresight_trace_id_get_cpu_id(cpu, &id_map_default);
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
 
+int coresight_trace_id_get_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
+{
+	return _coresight_trace_id_get_cpu_id(cpu, id_map);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id_map);
+
 void coresight_trace_id_put_cpu_id(int cpu)
 {
-	coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
+	_coresight_trace_id_put_cpu_id(cpu, &id_map_default);
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
 
+void coresight_trace_id_put_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
+{
+	_coresight_trace_id_put_cpu_id(cpu, id_map);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id_map);
+
 int coresight_trace_id_read_cpu_id(int cpu)
 {
-	return _coresight_trace_id_read_cpu_id(cpu);
+	return _coresight_trace_id_read_cpu_id(cpu, &id_map_default);
 }
 EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
 
+int coresight_trace_id_read_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map)
+{
+	return _coresight_trace_id_read_cpu_id(cpu, id_map);
+}
+EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id_map);
+
 int coresight_trace_id_get_system_id(void)
 {
 	return coresight_trace_id_map_get_system_id(&id_map_default);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
index 49438a96fcc6..840babdd0794 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.h
+++ b/drivers/hwtracing/coresight/coresight-trace-id.h
@@ -42,8 +42,6 @@
 #define IS_VALID_CS_TRACE_ID(id)	\
 	((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_TOP))
 
-/* Allocate and release IDs for a single default trace ID map */
-
 /**
  * Read and optionally allocate a CoreSight trace ID and associate with a CPU.
  *
@@ -59,6 +57,12 @@
  */
 int coresight_trace_id_get_cpu_id(int cpu);
 
+/**
+ * Version of coresight_trace_id_get_cpu_id() that allows the ID map to operate
+ * on to be provided.
+ */
+int coresight_trace_id_get_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
+
 /**
  * Release an allocated trace ID associated with the CPU.
  *
@@ -72,6 +76,12 @@ int coresight_trace_id_get_cpu_id(int cpu);
  */
 void coresight_trace_id_put_cpu_id(int cpu);
 
+/**
+ * Version of coresight_trace_id_put_cpu_id() that allows the ID map to operate
+ * on to be provided.
+ */
+void coresight_trace_id_put_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
+
 /**
  * Read the current allocated CoreSight Trace ID value for the CPU.
  *
@@ -92,6 +102,12 @@ void coresight_trace_id_put_cpu_id(int cpu);
  */
 int coresight_trace_id_read_cpu_id(int cpu);
 
+/**
+ * Version of coresight_trace_id_read_cpu_id() that allows the ID map to operate
+ * on to be provided.
+ */
+int coresight_trace_id_read_cpu_id_map(int cpu, struct coresight_trace_id_map *id_map);
+
 /**
  * Allocate a CoreSight trace ID for a system component.
  *
-- 
2.34.1


