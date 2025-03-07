Return-Path: <linux-kernel+bounces-550306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A7A55DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D29D17461C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01222185920;
	Fri,  7 Mar 2025 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drhbWENn"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2215E5AE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315154; cv=none; b=qFlE0i8f+w1t2x2PiCFAMtHVN6VMUO7QyP2oVJmzYL6GyhD7uOJGcBNypM3S48yGtPvn/wbIA8BZ6KWqEUzP3/bAYQUXPptGTOD18Suk5WUPJKlZoiLcaUWav5DjkdgnOqC4X1eHQA+og+10Gqnqa0s3cBvchKTdVPuRYrz91pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315154; c=relaxed/simple;
	bh=GSdij2jltzo6YXvD0onu1jCX78P9L2C644taeTScCYo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=cqpWJDjBNocf/oZiTn1JIcynhrqjNkmsbVBkt+1mORoqt0aX6n3XvbwVzYpPJgAoQvJXr8C3hRrQvXwtt1Ar/cVRF2KUm+OpuGvsYG2mqV1bQFqG2Dtd6d6sg/vJjB1ASiPWJZEPd9R71ip1KBAVRJ/y4uZ3oGMqXUltRfqwkp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drhbWENn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22379c2e96aso41190765ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 18:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741315152; x=1741919952; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9B7w2nipLEIELqoEy2ZwhSMH0iyjOD+M7dAXlsL2a2k=;
        b=drhbWENnryoOutmQudSWomrO6WeD0ohIClYtJSe+Tmz5oful7b7Y9QdUJ8kYbfwD4o
         hPY2Y4a2JwrXoIroVaC+vryMQWhGM4VrH7hQ3VwGh+mAN1xpxnbEjbC5+/XWHOBOxi/1
         2k0ii4VCjgYDqbWVaoMMltBhT2/crUtx0Y32maVHN6w4+nBpmyvST/J/Re8H3W/tszak
         +MQv7RYtgQ7a9Q8CA7DDBv0ve6X81QMTrCgwz1NHM4ELDOqrVQDO/WkFUa2vvpXAOw5C
         84gfLso7YZsg0F5/QdSZLSJB3eQ89rLGsry/mKE65QK/x1Ijy28XrxqCaTxOe2r7hB5l
         BC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315152; x=1741919952;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9B7w2nipLEIELqoEy2ZwhSMH0iyjOD+M7dAXlsL2a2k=;
        b=sgbsZMOKKtYMiuTd+pE+2CSs4+Z8O31zeO7PhmglKXJ1bJk/aaTR1n/mLhKxSfGKfN
         BcaYCoAxGFiQANZlUuNKDOHalbgeghk8BThBUZkfg6mlLfWqcStQobXiLZopaDzX7mJv
         PYrfeUoypdi1DoPbADkc2DlLJmCpyQl7DgiCaUjSwI0mc9YSvx5WR1llWC92VSdya9vH
         nes3S2X/OfdqHLsWltuPVvvEnfTEWkfrAPMRJbxE77WBlR2g4v9HufipQGUhcTP/iV1L
         4PqGhDz2JtHAufgKFuwtLiGnDNhxr/uDur5ByBSvGBWOLVyGWE4FUopwk9k1BpmhrxGr
         CVYw==
X-Forwarded-Encrypted: i=1; AJvYcCWPVFoPxnbkEcHKdrLENsrWv8oNKCq8mRCanSF7NZnGr9+NH4DAyy9KPs2dLuq6/obAN2OqGjDuYJBCNT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3WOQ+SkCpT2ci1miuN5p1ZF6Ytc0YpVk4KmH//CcugsZfDJG
	tdhzPlveREte/g/zq7JZfHRydyyRagPw26BT0MJARYJAAk3t1RIItCuWafJXl7k+ya4fMw3e8rh
	j7jA+ow==
X-Google-Smtp-Source: AGHT+IH3LncrV9yJSafzK++RmIMA8uTVeM+E7NP3jSc2exS34f2sc68yrbqIlOlcgV2xJ4GLpHgaeg0nwAt0
X-Received: from plbmq6.prod.google.com ([2002:a17:902:fd46:b0:21f:3ef1:c029])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8a:b0:220:faa2:c911
 with SMTP id d9443c01a7336-2242888a696mr26687845ad.14.1741315151730; Thu, 06
 Mar 2025 18:39:11 -0800 (PST)
Date: Thu,  6 Mar 2025 18:39:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307023906.1135613-1-irogers@google.com>
Subject: [PATCH v2 1/5] perf tools: Improve handling of hybrid PMUs in perf_event_attr__fprintf
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Support the PMU name from the legacy hardware and hw_cache PMU
extended types.  Remove some macros and make variables more intention
revealing, rather than just being called "value".

Before:
```
$ perf stat -vv -e instructions true
...
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0xa00000001
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 181636  cpu -1  group_fd -1  flags 0x8 = 5
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0x400000001
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 181636  cpu -1  group_fd -1  flags 0x8 = 6
...
```

After:
```
$ perf stat -vv -e instructions true
...
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0xa00000001 (cpu_atom/PERF_COUNT_HW_INSTRUCTIONS/)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 181724  cpu -1  group_fd -1  flags 0x8 = 5
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0x400000001 (cpu_core/PERF_COUNT_HW_INSTRUCTIONS/)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 181724  cpu -1  group_fd -1  flags 0x8 = 6
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 124 +++++++++++++---------
 1 file changed, 75 insertions(+), 49 deletions(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index c7f3543b9921..66b666d9ce64 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -79,24 +79,22 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 #define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
 static const char *stringify_perf_type_id(struct perf_pmu *pmu, u32 type)
 {
-	if (pmu)
-		return pmu->name;
-
 	switch (type) {
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_SOFTWARE)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_TRACEPOINT)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_HW_CACHE)
-	ENUM_ID_TO_STR_CASE(PERF_TYPE_RAW)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_BREAKPOINT)
+	case PERF_TYPE_RAW:
+		return pmu ? pmu->name : "PERF_TYPE_RAW";
 	default:
-		return NULL;
+		return pmu ? pmu->name : NULL;
 	}
 }
 
 static const char *stringify_perf_hw_id(u64 value)
 {
-	switch (value) {
+	switch (value & PERF_HW_EVENT_MASK) {
 	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CPU_CYCLES)
 	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_INSTRUCTIONS)
 	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_REFERENCES)
@@ -169,79 +167,100 @@ static const char *stringify_perf_sw_id(u64 value)
 }
 #undef ENUM_ID_TO_STR_CASE
 
-#define PRINT_ID(_s, _f)					\
-do {								\
-	const char *__s = _s;					\
-	if (__s == NULL)					\
-		snprintf(buf, size, _f, value);			\
-	else							\
-		snprintf(buf, size, _f" (%s)", value, __s);	\
-} while (0)
-#define print_id_unsigned(_s)	PRINT_ID(_s, "%"PRIu64)
-#define print_id_hex(_s)	PRINT_ID(_s, "%#"PRIx64)
+static void print_id_unsigned(char *buf, size_t size, u64 value, const char *s)
+{
+	if (s == NULL)
+		snprintf(buf, size, "%"PRIu64, value);
+	else
+		snprintf(buf, size, "%"PRIu64" (%s)", value, s);
+}
+
+static void print_id_hex(char *buf, size_t size, u64 value, const char *s)
+{
+	if (s == NULL)
+		snprintf(buf, size, "%#"PRIx64, value);
+	else
+		snprintf(buf, size, "%#"PRIx64" (%s)", value, s);
+}
 
-static void __p_type_id(struct perf_pmu *pmu, char *buf, size_t size, u64 value)
+static void __p_type_id(char *buf, size_t size, struct perf_pmu *pmu, u32 type)
 {
-	print_id_unsigned(stringify_perf_type_id(pmu, value));
+	print_id_unsigned(buf, size, type, stringify_perf_type_id(pmu, type));
 }
 
-static void __p_config_hw_id(char *buf, size_t size, u64 value)
+static void __p_config_hw_id(char *buf, size_t size, struct perf_pmu *pmu, u64 config)
 {
-	print_id_hex(stringify_perf_hw_id(value));
+	const char *name = stringify_perf_hw_id(config);
+
+	if (name == NULL) {
+		if (pmu == NULL) {
+			snprintf(buf, size, "%#"PRIx64, config);
+		} else {
+			snprintf(buf, size, "%#"PRIx64" (%s/config=%#"PRIx64"/)", config, pmu->name,
+				 config);
+		}
+	} else {
+		if (pmu == NULL)
+			snprintf(buf, size, "%#"PRIx64" (%s)", config, name);
+		else
+			snprintf(buf, size, "%#"PRIx64" (%s/%s/)", config, pmu->name, name);
+	}
 }
 
-static void __p_config_sw_id(char *buf, size_t size, u64 value)
+static void __p_config_sw_id(char *buf, size_t size, u64 id)
 {
-	print_id_hex(stringify_perf_sw_id(value));
+	print_id_hex(buf, size, id, stringify_perf_sw_id(id));
 }
 
-static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
+static void __p_config_hw_cache_id(char *buf, size_t size, struct perf_pmu *pmu, u64 config)
 {
-	const char *hw_cache_str = stringify_perf_hw_cache_id(value & 0xff);
+	const char *hw_cache_str = stringify_perf_hw_cache_id(config & 0xff);
 	const char *hw_cache_op_str =
-		stringify_perf_hw_cache_op_id((value & 0xff00) >> 8);
+		stringify_perf_hw_cache_op_id((config & 0xff00) >> 8);
 	const char *hw_cache_op_result_str =
-		stringify_perf_hw_cache_op_result_id((value & 0xff0000) >> 16);
-
-	if (hw_cache_str == NULL || hw_cache_op_str == NULL ||
-	    hw_cache_op_result_str == NULL) {
-		snprintf(buf, size, "%#"PRIx64, value);
+		stringify_perf_hw_cache_op_result_id((config & 0xff0000) >> 16);
+
+	if (hw_cache_str == NULL || hw_cache_op_str == NULL || hw_cache_op_result_str == NULL) {
+		if (pmu == NULL) {
+			snprintf(buf, size, "%#"PRIx64, config);
+		} else {
+			snprintf(buf, size, "%#"PRIx64" (%s/config=%#"PRIx64"/)", config, pmu->name,
+				 config);
+		}
 	} else {
-		snprintf(buf, size, "%#"PRIx64" (%s | %s | %s)", value,
-			 hw_cache_op_result_str, hw_cache_op_str, hw_cache_str);
+		if (pmu == NULL) {
+			snprintf(buf, size, "%#"PRIx64" (%s | %s | %s)", config,
+				 hw_cache_op_result_str, hw_cache_op_str, hw_cache_str);
+		} else {
+			snprintf(buf, size, "%#"PRIx64" (%s/%s | %s | %s/)", config, pmu->name,
+				 hw_cache_op_result_str, hw_cache_op_str, hw_cache_str);
+		}
 	}
 }
 
-static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
+static void __p_config_tracepoint_id(char *buf, size_t size, u64 id)
 {
-	char *str = tracepoint_id_to_name(value);
+	char *str = tracepoint_id_to_name(id);
 
-	print_id_hex(str);
+	print_id_hex(buf, size, id, str);
 	free(str);
 }
 
-static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
+static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 config)
 {
-	const char *name = perf_pmu__name_from_config(pmu, value);
-
-	if (name) {
-		print_id_hex(name);
-		return;
-	}
 	switch (type) {
 	case PERF_TYPE_HARDWARE:
-		return __p_config_hw_id(buf, size, value);
+		return __p_config_hw_id(buf, size, pmu, config);
 	case PERF_TYPE_SOFTWARE:
-		return __p_config_sw_id(buf, size, value);
+		return __p_config_sw_id(buf, size, config);
 	case PERF_TYPE_HW_CACHE:
-		return __p_config_hw_cache_id(buf, size, value);
+		return __p_config_hw_cache_id(buf, size, pmu, config);
 	case PERF_TYPE_TRACEPOINT:
-		return __p_config_tracepoint_id(buf, size, value);
+		return __p_config_tracepoint_id(buf, size, config);
 	case PERF_TYPE_RAW:
 	case PERF_TYPE_BREAKPOINT:
 	default:
-		snprintf(buf, size, "%#"PRIx64, value);
-		return;
+		return print_id_hex(buf, size, config, perf_pmu__name_from_config(pmu, config));
 	}
 }
 
@@ -253,7 +272,7 @@ static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type
 #define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
-#define p_type_id(val)		__p_type_id(pmu, buf, BUF_SIZE, val)
+#define p_type_id(val)		__p_type_id(buf, BUF_SIZE, pmu, val)
 #define p_config_id(val)	__p_config_id(pmu, buf, BUF_SIZE, attr->type, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
@@ -273,6 +292,13 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	char buf[BUF_SIZE];
 	int ret = 0;
 
+	if (!pmu && (attr->type == PERF_TYPE_HARDWARE || attr->type == PERF_TYPE_HW_CACHE)) {
+		u32 extended_type = attr->config >> PERF_PMU_TYPE_SHIFT;
+
+		if (extended_type)
+			pmu = perf_pmus__find_by_type(extended_type);
+	}
+
 	PRINT_ATTRn("type", type, p_type_id, true);
 	PRINT_ATTRf(size, p_unsigned);
 	PRINT_ATTRn("config", config, p_config_id, true);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


