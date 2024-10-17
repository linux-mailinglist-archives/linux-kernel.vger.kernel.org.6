Return-Path: <linux-kernel+bounces-370355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A50B9A2B76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D915286BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACB81DFE1B;
	Thu, 17 Oct 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoIlyL0t"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B971DFDAD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187647; cv=none; b=sGwl03D1xhsAGR5e/M7gqGLLmJhncSV/ixpOJtEgywwayZdG+LueN5C/rnr6kUeUzub1QBsPBYUVxwUBop/1gcxNRhxQ5UZKOYw+9kjQOItC2ORRi0DuWr62W1JNYJ5yE8RfV1CPtptBwOlqOBdLvesMX8jSSW1mwXpqiB9rWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187647; c=relaxed/simple;
	bh=JHZeSmkWIrj8EFARpnwwv3ZxZXRwxkO0vkOgH6dtkac=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fYF0Jpk8nRSKGi2NCYXt00SX+/kSlq5lOowArCid8uTPH1b7NG7oDZUNdQUU27xuiyPm7x55lpjerP3Kh3ydmdeN6AH+4Pd2JTpzL7jCLyZ6RXESJtzi85fEiFrvpfpdzpWoUVDDmt16RTfjotar6Jlz+naaRW8myJYq3gybJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoIlyL0t; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e315a5b199so21355247b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187644; x=1729792444; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2gIFyt42nntsnGaIcEwttdqpxaZNfusYx2zy+lIpHc=;
        b=QoIlyL0tBLLfEwdePreiKV/41rOpxPdkWGVW3dbfC40Oont4rjxMm6zeu5bDMmvrdp
         W+ADQknoDgpRzKdzbtu7F3OBOSB9JOg9oQnpoR4B5vxOL8t0g6rTbd8v9UOj1aRvPNfk
         2ZqGNe9hjVS9ADnv30Yz+cJeQRdyDhKh4by/pc25eQyP9cAM7shPohV74mSpCcSRPqZG
         hQ5Z2dvIIfumsqw1n+2uOi7ya3XSNdpTyZkO5y4dRvhc6Ia3sFDYqhD5sO/Qp8vIYdto
         99+7/NBERu8IZTvCCq6VGYwHWh+XTqGwCPHuMN0SkCQBJJ3vver4KSXQqlYOE4yw1WuN
         AhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187644; x=1729792444;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2gIFyt42nntsnGaIcEwttdqpxaZNfusYx2zy+lIpHc=;
        b=QfExfqezS7LplVig83N4+BIeP+VrxT6OvqICAOqVAQa9n145Oj9tJTpU2d8KF6+efJ
         QPFm14AqzstfuPwDcVw8XbczNTEsm4EtMLNZ2nS/sA/r6THHaas/mR6mm2h4jVPGUsmk
         Pk4LME3qUaDlZlKNYtwkzu3IF2Ihc0QkGNmEJ6nSgpOUZA7RS9cwxkyn8zdV99j2RQjm
         xk9atejADYciQp6iBa1ri+0wJYs6w3OcxD4c33oraxv2LiinewcvwW9C08pqmNmMxqj/
         vm/ZhVXANGXWufSD+jFuAvGtmIHiTy7JtABIRd3bo+8r9t/+YcA7sn1ClKdUeNqQR5Wc
         34uA==
X-Forwarded-Encrypted: i=1; AJvYcCUCuUdS6/19Qo/dzL6s47JpeSRkIhuaXiBl4cGLOZ5B2W8L/mBKhHKnkFGKSHH4QNjtU070PHz6y8vPM8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlubfh2CkOnD+1PCqV3sBRz+FF6IBvQ6S8CgIcJ1fuCaqCC6y
	ExQ8Plhe62pCrsP1pzsMqb+YMDYFhW1FR9tp/srTzbAPYc1QKFRlN+Qm5OPTMb7iXspzb/zanGd
	U/T31FA==
X-Google-Smtp-Source: AGHT+IFOb7Ly95ignRrZpM2eJffAbLiYBD5BXqW5NZZKWGFTAymVVA4fkRvwEwltD1JaiD5Sx3sRyDuUmgkk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:d8b:b0:69b:c01:82a5 with SMTP id
 00721157ae682-6e3d41e6b49mr1223917b3.7.1729187643820; Thu, 17 Oct 2024
 10:54:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:50 -0700
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
Message-Id: <20241017175356.783793-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 1/7] perf color: Add printf format checking and resolve issues
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add printf format checking to vararg printf routines in
color.h. Resolve build errors/bugs that are found through this
checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c        | 2 +-
 tools/perf/builtin-trace.c        | 2 +-
 tools/perf/util/arm-spe.c         | 2 +-
 tools/perf/util/color.h           | 9 +++++----
 tools/perf/util/intel-bts.c       | 2 +-
 tools/perf/util/intel-pt.c        | 2 +-
 tools/perf/util/s390-cpumsf.c     | 2 +-
 tools/perf/util/s390-sample-raw.c | 8 ++++----
 8 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index fdf979aaf275..99bfc3ad71e2 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1739,7 +1739,7 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
 	}
 
 	if (sched->map.comp && new_cpu)
-		color_fprintf(stdout, color, " (CPU %d)", this_cpu);
+		color_fprintf(stdout, color, " (CPU %d)", this_cpu.cpu);
 
 	if (proceed != 1) {
 		color_fprintf(stdout, color, "\n");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0b30297b4ecb..748b061f8678 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1873,7 +1873,7 @@ static int trace__process_event(struct trace *trace, struct machine *machine,
 	switch (event->header.type) {
 	case PERF_RECORD_LOST:
 		color_fprintf(trace->output, PERF_COLOR_RED,
-			      "LOST %" PRIu64 " events!\n", event->lost.lost);
+			      "LOST %" PRIu64 " events!\n", (u64)event->lost.lost);
 		ret = machine__process_lost_event(machine, event, sample);
 		break;
 	default:
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 13fd2c8afebd..fd0d793ecad8 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -122,7 +122,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
 		else
 			pkt_len = 1;
 		printf(".");
-		color_fprintf(stdout, color, "  %08x: ", pos);
+		color_fprintf(stdout, color, "  %08zx: ", pos);
 		for (i = 0; i < pkt_len; i++)
 			color_fprintf(stdout, color, " %02x", buf[i]);
 		for (; i < 16; i++)
diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index aecf56dae73f..b2f37de305f6 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -2,6 +2,7 @@
 #ifndef __PERF_COLOR_H
 #define __PERF_COLOR_H
 
+#include <linux/compiler.h>
 #include <stdio.h>
 #include <stdarg.h>
 
@@ -37,11 +38,11 @@ int perf_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 int color_vsnprintf(char *bf, size_t size, const char *color,
 		    const char *fmt, va_list args);
 int color_vfprintf(FILE *fp, const char *color, const char *fmt, va_list args);
-int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
-int color_snprintf(char *bf, size_t size, const char *color, const char *fmt, ...);
+int color_fprintf(FILE *fp, const char *color, const char *fmt, ...) __printf(3, 4);
+int color_snprintf(char *bf, size_t size, const char *color, const char *fmt, ...) __printf(4, 5);
 int value_color_snprintf(char *bf, size_t size, const char *fmt, double value);
-int percent_color_snprintf(char *bf, size_t size, const char *fmt, ...);
-int percent_color_len_snprintf(char *bf, size_t size, const char *fmt, ...);
+int percent_color_snprintf(char *bf, size_t size, const char *fmt, ...) __printf(3, 4);
+int percent_color_len_snprintf(char *bf, size_t size, const char *fmt, ...) __printf(3, 4);
 int percent_color_fprintf(FILE *fp, const char *fmt, double percent);
 const char *get_percent_color(double percent);
 
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 27d9b5c9fec8..3ea82d5e8d2e 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -100,7 +100,7 @@ static void intel_bts_dump(struct intel_bts *bts __maybe_unused,
 		else
 			sz = len;
 		printf(".");
-		color_fprintf(stdout, color, "  %08x: ", pos);
+		color_fprintf(stdout, color, "  %08zx: ", pos);
 		for (i = 0; i < sz; i++)
 			color_fprintf(stdout, color, " %02x", buf[i]);
 		for (; i < br_sz; i++)
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index fd2597613f3d..3fe67bf652b6 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -249,7 +249,7 @@ static void intel_pt_dump(struct intel_pt *pt __maybe_unused,
 		else
 			pkt_len = 1;
 		printf(".");
-		color_fprintf(stdout, color, "  %08x: ", pos);
+		color_fprintf(stdout, color, "  %08zx: ", pos);
 		for (i = 0; i < pkt_len; i++)
 			color_fprintf(stdout, color, " %02x", buf[i]);
 		for (; i < 16; i++)
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 73846b73d0cf..30638653ad2d 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -345,7 +345,7 @@ static bool s390_cpumsf_trailer_show(const char *color, size_t pos,
 	}
 	color_fprintf(stdout, color, "    [%#08zx] Trailer %c%c%c bsdes:%d"
 		      " dsdes:%d Overflow:%lld Time:%#llx\n"
-		      "\t\tC:%d TOD:%#lx\n",
+		      "\t\tC:%d TOD:%#llx\n",
 		      pos,
 		      te->f ? 'F' : ' ',
 		      te->a ? 'A' : ' ',
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index 53383e97ec9d..335217bb532b 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -98,12 +98,12 @@ static void s390_cpumcfdg_dumptrail(const char *color, size_t offset,
 	te.res2 = be32_to_cpu(tep->res2);
 
 	color_fprintf(stdout, color, "    [%#08zx] Trailer:%c%c%c%c%c"
-		      " Cfvn:%d Csvn:%d Speed:%d TOD:%#llx\n",
+		      " Cfvn:%d Csvn:%d Speed:%d TOD:%#lx\n",
 		      offset, te.clock_base ? 'T' : ' ',
 		      te.speed ? 'S' : ' ', te.mtda ? 'M' : ' ',
 		      te.caca ? 'C' : ' ', te.lcda ? 'L' : ' ',
 		      te.cfvn, te.csvn, te.cpu_speed, te.timestamp);
-	color_fprintf(stdout, color, "\t\t1:%lx 2:%lx 3:%lx TOD-Base:%#llx"
+	color_fprintf(stdout, color, "\t\t1:%lx 2:%lx 3:%lx TOD-Base:%#lx"
 		      " Type:%x\n\n",
 		      te.progusage1, te.progusage2, te.progusage3,
 		      te.tod_base, te.mach_type);
@@ -205,7 +205,7 @@ static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
 			char *ev_name = get_counter_name(ce.set, i, pmu);
 
 			color_fprintf(stdout, color,
-				      "\tCounter:%03d %s Value:%#018lx\n", i,
+				      "\tCounter:%03zd %s Value:%#018"PRIx64"\n", i,
 				      ev_name ?: "<unknown>", be64_to_cpu(*p));
 			free(ev_name);
 		}
@@ -260,7 +260,7 @@ static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
 
 		ev_name = get_counter_name(evsel->core.attr.config,
 					   pai_data.event_nr, evsel->pmu);
-		color_fprintf(stdout, color, "\tCounter:%03d %s Value:%#018lx\n",
+		color_fprintf(stdout, color, "\tCounter:%03d %s Value:%#018"PRIx64"\n",
 			      pai_data.event_nr, ev_name ?: "<unknown>",
 			      pai_data.event_val);
 		free(ev_name);
-- 
2.47.0.105.g07ac214952-goog


