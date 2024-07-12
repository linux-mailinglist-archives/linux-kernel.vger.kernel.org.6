Return-Path: <linux-kernel+bounces-250544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EB692F8E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DBF1C21A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D75916F840;
	Fri, 12 Jul 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTBHdaiO"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2216F831
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779787; cv=none; b=MJ/qAa0toCfVh4kT0O25cnZGJkQUXTu3FYF0YRMB6wfwCQoklZ2qoWEXSyQgnc6WAdJphvi1RSdWmM5r1Eddp65ZxH1aBcVDPjRujUNC9+cdf7rDqGwhd7Gs33iiWS6CsjGMPJZ4IEwXXHahzOu2f/14TSEAFztHi6uxBqlMAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779787; c=relaxed/simple;
	bh=wZRKP7nDhoSPLzcqOUMoUSFBKE8aiivx6pZpDeh+KyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRBXMQ2XEyTE6BdlgJiBOXVpOfD9q0lO80ykEtU48Xq4UZu79HKTFrE6IbY70byM9FcS2wO7llIvVh970HcJfH1Bk4k+Nf4bJQ7KpcPuaw8uXTN50ykyexv0zD6ktcPYHzimDFeRedf+2824MbuNR9I2blOKni5XKihKUPYW0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LTBHdaiO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36794da7c96so1040018f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779784; x=1721384584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvSzWZ4RPZWpHAYvZ7ovInhjLve5KVWdGP1z4smKc8c=;
        b=LTBHdaiONDI+nyCdjhWtXAR2xsS36Os2lWpGuv/no71Wdul30vM0dhbhXpvFT7mHxS
         3vhE+vOw2klPANx1G5zwBMtTC10s7TeChuQCK1paDZrzk+/QMqp/HGWDBCBWT6Y5Lfcn
         NEE9klN/UfCRE3QVYZHg1Qe1xlPlKL6JDYjTSm2OgOwpvOXHSjddfWacqjPA6ga1S55+
         nnChWTMzLemH6oZCLkLmrnM9OfW4RXitmXx62zttDkLJANdbdU38xjrErGLo/MKVKVY9
         EMnawMpCLgssdfOu0nCJ5464H08estL3HJegYVdkNpxQSAYQNes6q0GckxJpZIvrBnn4
         dgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779784; x=1721384584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvSzWZ4RPZWpHAYvZ7ovInhjLve5KVWdGP1z4smKc8c=;
        b=Wy8j3Rcx/KZbMEcZFygqYxbcTQk3/Tluu6O3w3Qwrrgpf8otLTAjgYGc07ty/8UGG/
         6n06re6fkJhSPuUfOIm/jLWNGGBEeWsTozogpJXFfk36m0q7NCsetM2xp31XmgLbXVOU
         eGnBza24/INH/rdeY2eGTsGZLj3czI0xoBF9w03aBO6yJkChOFPbtYK/NMDenruQxIJD
         v8bLvvSjONvF++EzT0HADbQ3ymFAd9MOcstRpnK00kcMG3Af+1b3rj2SVhBWGiCxVLBx
         OdwVl2yOVmUEqqELsMDdYiR4OoVgV5d7RepE21pFrSIfeSp3TLWYmkDk983kD/HSaigB
         ETGw==
X-Forwarded-Encrypted: i=1; AJvYcCVzsK9/NgX7WrNG2HiXeFjnhiYFZGzGXT0AOtyA37cK3l5fyi73lORWjGKr8gCqzY+VHZEKRHL6MCKNqlQ6m+/9N3y/hPAtfNtSGrnD
X-Gm-Message-State: AOJu0Yx4Q7mYlAAyzIr7qDO1m9di1CE0WW/S2eSKDHAJR3powPC8YJa6
	u+FugT1D/p+V8VcpeLprDU/Bfg9z1w0UOe9WXldcQWh34ke81K4ND+98bmMGuSc=
X-Google-Smtp-Source: AGHT+IHzT2J3mTVoCZJ5r0fsOC5+sDVLqrON4rQGn86Q0ieoOdHY+/Xt6w7qzQgBlK7Za4+m1tgp9w==
X-Received: by 2002:a5d:548a:0:b0:367:892a:b32 with SMTP id ffacd0b85a97d-367cead8f99mr6582511f8f.60.1720779784099;
        Fri, 12 Jul 2024 03:23:04 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:23:03 -0700 (PDT)
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
Subject: [PATCH v5 12/17] coresight: Expose map arguments in trace ID API
Date: Fri, 12 Jul 2024 11:20:21 +0100
Message-Id: <20240712102029.3697965-13-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712102029.3697965-1-james.clark@linaro.org>
References: <20240712102029.3697965-1-james.clark@linaro.org>
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


