Return-Path: <linux-kernel+bounces-549528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75855A55391
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3AC3B4DF9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D11525C6E6;
	Thu,  6 Mar 2025 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ymLSIEQ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D325D522
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283659; cv=none; b=tJpV2ofGZhe/jxhXGkyt9UTqgLpX7jfBYxGJ3ZMoujRP4/YjdgejdPGjOsvnuCZcgn3LTp2othwdWuLv1HhzrziSKDtsfz5cxvCd0NJpUGzA76HodtVASvRxZH1qCNM8x2b4yoZjQCxOgIiOwLbuFGVIF8bz577DqcvyhJdp6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283659; c=relaxed/simple;
	bh=K88Ohbta0Jmw1zMYqJvLnOmOhvYi8e/Qz/vivWaOsqc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=tLltWbHQ81KTwAaOi/xfRtz+ffvyuOIEtuKd0KA9nD2hBOTzlutA0zwMD3zX2nc0E6bQxB14EM7C+AFdE1LjRjxfYuz1AH10eK9CejZHEsSyU5psKhn2RrE3b6A75m419AuoPpi82xGS6AoQyEtzmiIBhJvD827qpTs6taDOZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ymLSIEQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso1789187a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741283656; x=1741888456; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vUA6eR5Cy6R6G2yN7A0vC6xMAzc8FKK5ximtyOCtpms=;
        b=4ymLSIEQ5tHWsyKl5ImDjiPNW4jUmD08nIVLJlqOI5eKJAxLPF9NApOMTNJ+PN5XRz
         xNgdbnJYi8vA46JS+c3DHgjb+egpuLLDZwDvdUs21FgVkcw7AFBP+JVRurdEZ0eHd/jP
         UZ5p+LF1TQhXDJEWC/OyyGu/srT/ZlQ0V0CSsLPw9u4aNNcv2jVUq3r4FAal6JIEG+lh
         mvCCztEsjrm4/kVg62QYEnL7x3ZNRaj85OzLNOI8DmE7/xbPhY+y14d0qzljUykG4TO7
         A/0dEcMN2JfqqqXbt7jTsRC31EfNrcpKqK9aMMnjPJAbXrenq3MQJiHWoOCFosJMAtia
         gFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741283656; x=1741888456;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUA6eR5Cy6R6G2yN7A0vC6xMAzc8FKK5ximtyOCtpms=;
        b=r+/ixqbILDYroWstmXCDFLuyzar6CLCD/n5AOM2my9X1/9BdHGAO+83Jgz1F3br+3X
         f3ejo5G0mMRX688KslLRaLY+mSQOim3+ZRsV5oyWxC3+5yyLVXAeaQFoxtfNdzb2mETU
         XiuIltQxL0kSPgxyQOK6v4cOuPXY/vG4d9CKYC+XbzBW6Tr48GrOTocEyoat+RK8qXF4
         6+m1monfeo8j9Qw+uX0w5s9eZ3rVx5yrgi1qv3zIjPKoXoVQ3O7NDIjrLMKLyx9qYDHs
         5ICpUybq952EhvgnXzMcyJ2FdWGO4PR6045TSk36mmzQ0sYIOSfd8G+c67GLDW4u8CMZ
         jSEA==
X-Forwarded-Encrypted: i=1; AJvYcCXayk31yYYzBamFxLzY/HXUwFkgRgEx6MnMDvn867h7Rrp6UvCH88GyGZ+rl7EdYOZgYBJc1bt0wMUCvPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMUXUZGiA1q/LRwp+hrlBDFVnsVYbhNjol5yyQgyyzixGgY1D
	X1vHKRDFywXMHdyKsT/toVW9u3HG2C4hzDR17+5kWY2JqcaY51N6XqeJDrAXhJGADQT7kShU6+h
	CcW7XjA==
X-Google-Smtp-Source: AGHT+IFPSZrd2iB3AEuiUBgwaydDdZlu2UVP4RyH2f+DgXcj8Mg5ixnqBL95g0UP+e/xgRoWFtw2nStlckYG
X-Received: from pjg3.prod.google.com ([2002:a17:90b:3f43:b0:2f2:e97a:e77f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d4f:b0:2fa:2268:1af4
 with SMTP id 98e67ed59e1d1-2ff6175a47dmr6777378a91.7.1741283655692; Thu, 06
 Mar 2025 09:54:15 -0800 (PST)
Date: Thu,  6 Mar 2025 09:54:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250306175408.852130-1-irogers@google.com>
Subject: [PATCH v1] perf mem: Don't leak mem event names
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When preparing the mem events for the argv copies are intentionally
made. These copies are leaked and cause runs of perf using address
sanitizer to fail. Rather than leak the memory allocate a chunk of
memory for the mem event names upfront and build the strings in this -
the storage is sized larger than the previous buffer size. The caller
is then responsible for clearing up this memory. As part of this
change, remove the mem_loads_name and mem_stores_name global buffers
then change the perf_pmu__mem_events_name to write to an out argument
buffer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c     |  4 ++-
 tools/perf/builtin-mem.c     | 12 ++++---
 tools/perf/util/mem-events.c | 64 +++++++++++++++++++++---------------
 tools/perf/util/mem-events.h |  3 +-
 4 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 15e1fce71c72..5d5bb0f32334 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -3239,6 +3239,7 @@ static int perf_c2c__record(int argc, const char **argv)
 {
 	int rec_argc, i = 0, j;
 	const char **rec_argv;
+	char *event_name_storage = NULL;
 	int ret;
 	bool all_user = false, all_kernel = false;
 	bool event_set = false;
@@ -3300,7 +3301,7 @@ static int perf_c2c__record(int argc, const char **argv)
 	rec_argv[i++] = "--phys-data";
 	rec_argv[i++] = "--sample-cpu";
 
-	ret = perf_mem_events__record_args(rec_argv, &i);
+	ret = perf_mem_events__record_args(rec_argv, &i, &event_name_storage);
 	if (ret)
 		goto out;
 
@@ -3327,6 +3328,7 @@ static int perf_c2c__record(int argc, const char **argv)
 
 	ret = cmd_record(i, rec_argv);
 out:
+	free(event_name_storage);
 	free(rec_argv);
 	return ret;
 }
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 99d5e1491a28..5ec83cd85650 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -74,6 +74,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 	int rec_argc, i = 0, j;
 	int start, end;
 	const char **rec_argv;
+	char *event_name_storage = NULL;
 	int ret;
 	struct perf_mem_event *e;
 	struct perf_pmu *pmu;
@@ -140,7 +141,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 		rec_argv[i++] = "--data-page-size";
 
 	start = i;
-	ret = perf_mem_events__record_args(rec_argv, &i);
+	ret = perf_mem_events__record_args(rec_argv, &i, &event_name_storage);
 	if (ret)
 		goto out;
 	end = i;
@@ -170,6 +171,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 
 	ret = cmd_record(i, rec_argv);
 out:
+	free(event_name_storage);
 	free(rec_argv);
 	return ret;
 }
@@ -521,6 +523,7 @@ int cmd_mem(int argc, const char **argv)
 		NULL,
 		NULL
 	};
+	int ret;
 
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
 					mem_usage, PARSE_OPT_STOP_AT_NON_OPTION);
@@ -536,14 +539,15 @@ int cmd_mem(int argc, const char **argv)
 	}
 
 	if (strlen(argv[0]) > 2 && strstarts("record", argv[0]))
-		return __cmd_record(argc, argv, &mem, record_options);
+		ret = __cmd_record(argc, argv, &mem, record_options);
 	else if (strlen(argv[0]) > 2 && strstarts("report", argv[0]))
-		return __cmd_report(argc, argv, &mem, report_options);
+		ret = __cmd_report(argc, argv, &mem, report_options);
 	else
 		usage_with_options(mem_usage, mem_options);
 
 	/* free usage string allocated by parse_options_subcommand */
 	free((void *)mem_usage[0]);
+	free(sort_order_help);
 
-	return 0;
+	return ret;
 }
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 0277d3e1505c..1d18a5015eea 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -31,9 +31,6 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
 
 bool perf_mem_record[PERF_MEM_EVENTS__MAX] = { 0 };
 
-static char mem_loads_name[100];
-static char mem_stores_name[100];
-
 struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i)
 {
 	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
@@ -81,7 +78,8 @@ int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu)
 	return num;
 }
 
-static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
+static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
+					     char *buf, size_t buf_size)
 {
 	struct perf_mem_event *e;
 
@@ -96,31 +94,31 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
 		if (e->ldlat) {
 			if (!e->aux_event) {
 				/* ARM and Most of Intel */
-				scnprintf(mem_loads_name, sizeof(mem_loads_name),
+				scnprintf(buf, buf_size,
 					  e->name, pmu->name,
 					  perf_mem_events__loads_ldlat);
 			} else {
 				/* Intel with mem-loads-aux event */
-				scnprintf(mem_loads_name, sizeof(mem_loads_name),
+				scnprintf(buf, buf_size,
 					  e->name, pmu->name, pmu->name,
 					  perf_mem_events__loads_ldlat);
 			}
 		} else {
 			if (!e->aux_event) {
 				/* AMD and POWER */
-				scnprintf(mem_loads_name, sizeof(mem_loads_name),
+				scnprintf(buf, buf_size,
 					  e->name, pmu->name);
-			} else
+			} else {
 				return NULL;
+			}
 		}
-
-		return mem_loads_name;
+		return buf;
 	}
 
 	if (i == PERF_MEM_EVENTS__STORE) {
-		scnprintf(mem_stores_name, sizeof(mem_stores_name),
+		scnprintf(buf, buf_size,
 			  e->name, pmu->name);
-		return mem_stores_name;
+		return buf;
 	}
 
 	return NULL;
@@ -238,55 +236,66 @@ void perf_pmu__mem_events_list(struct perf_pmu *pmu)
 	int j;
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+		char buf[128];
 		struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
 
 		fprintf(stderr, "%-*s%-*s%s",
 			e->tag ? 13 : 0,
 			e->tag ? : "",
 			e->tag && verbose > 0 ? 25 : 0,
-			e->tag && verbose > 0 ? perf_pmu__mem_events_name(j, pmu) : "",
+			e->tag && verbose > 0
+			? perf_pmu__mem_events_name(pmu, j, buf, sizeof(buf))
+			: "",
 			e->supported ? ": available\n" : "");
 	}
 }
 
-int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
+int perf_mem_events__record_args(const char **rec_argv, int *argv_nr, char **event_name_storage_out)
 {
 	const char *mnt = sysfs__mount();
 	struct perf_pmu *pmu = NULL;
-	struct perf_mem_event *e;
 	int i = *argv_nr;
-	const char *s;
-	char *copy;
 	struct perf_cpu_map *cpu_map = NULL;
-	int ret;
+	size_t event_name_storage_size =
+		perf_pmu__mem_events_num_mem_pmus(NULL) * PERF_MEM_EVENTS__MAX * 128;
+	size_t event_name_storage_remaining = event_name_storage_size;
+	char *event_name_storage = malloc(event_name_storage_size);
+	char *event_name_storage_ptr = event_name_storage;
 
+	*event_name_storage_out = NULL;
 	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
 		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-			e = perf_pmu__mem_events_ptr(pmu, j);
+			const char *s;
+			struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
+			int ret;
 
 			if (!perf_mem_record[j])
 				continue;
 
 			if (!e->supported) {
+				char buf[128];
+
 				pr_err("failed: event '%s' not supported\n",
-					perf_pmu__mem_events_name(j, pmu));
+					perf_pmu__mem_events_name(pmu, j, buf, sizeof(buf)));
+				free(event_name_storage);
 				return -1;
 			}
 
-			s = perf_pmu__mem_events_name(j, pmu);
+			s = perf_pmu__mem_events_name(pmu, j, event_name_storage_ptr,
+						      event_name_storage_remaining);
 			if (!s || !perf_pmu__mem_events_supported(mnt, pmu, e))
 				continue;
 
-			copy = strdup(s);
-			if (!copy)
-				return -1;
-
 			rec_argv[i++] = "-e";
-			rec_argv[i++] = copy;
+			rec_argv[i++] = event_name_storage_ptr;
+			event_name_storage_remaining -= strlen(event_name_storage_ptr) + 1;
+			event_name_storage_ptr += strlen(event_name_storage_ptr) + 1;
 
 			ret = perf_cpu_map__merge(&cpu_map, pmu->cpus);
-			if (ret < 0)
+			if (ret < 0) {
+				free(event_name_storage);
 				return ret;
+			}
 		}
 	}
 
@@ -301,6 +310,7 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr)
 	}
 
 	*argv_nr = i;
+	*event_name_storage_out = event_name_storage;
 	return 0;
 }
 
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 8dc27db9fd52..a5c19d39ee37 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -38,7 +38,8 @@ int perf_pmu__mem_events_num_mem_pmus(struct perf_pmu *pmu);
 bool is_mem_loads_aux_event(struct evsel *leader);
 
 void perf_pmu__mem_events_list(struct perf_pmu *pmu);
-int perf_mem_events__record_args(const char **rec_argv, int *argv_nr);
+int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
+				 char **event_name_storage_out);
 
 int perf_mem__tlb_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
 int perf_mem__lvl_scnprintf(char *out, size_t sz, const struct mem_info *mem_info);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


