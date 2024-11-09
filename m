Return-Path: <linux-kernel+bounces-402607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 476779C299A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B91B22903
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A558137905;
	Sat,  9 Nov 2024 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhTyiGM3"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483AC13210D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 02:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731121086; cv=none; b=QKMVx9QAXMMBFksmrDia8xwuSU2e4cl5m9Gwmilrn3a0MY8DR6dAg0kKc8K0vKKRLdDrLb/mApd2IPnW2zPDoEoSnhZG9cON5KosOLKIDxyx6dhQGSJy5u1qABc59cy7qAkN1OvjtY66GsdmVamwMT1lFkmi78Vy6bj9wItcT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731121086; c=relaxed/simple;
	bh=okD8PZlyuduO7Pj+Y0baUDgknvMMd1GbbUlD73IOEAs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=O7BOLbxD5HMAC6kNyNEfJAqoduLKWDZC+r6KeKleomKbebQzxgEgRjpbUMRg8OHCx7WakSZsS8Vgkh1TtpTx64XFCuAvMyK6xDBTJMGIunrNbeiDK0aDTL3Naxjspa4y06nj1uuuSpCeKORKpy5P2x4AzH5cknR0ZGJnAw/VC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qhTyiGM3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30d7b4205eso4509963276.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 18:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731121084; x=1731725884; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xeepDSMekLWdN9dw+iAAPG9h5iMUwhHzvrTsRjDcopM=;
        b=qhTyiGM3YP72OkvhbSh1SzP7WR/phQbKSCRD26bflYFb2LF436xv+Kn7H8/aVhRxsP
         N+rFg827+zrPyHqtDvkCMN1y3IolTTSxnR/i8ZsQnOULiZprXZ4HLeyFcM5hl4dgm9nh
         DbHsbev4/qu7B9CLAwYC4k7BBH1f39QfVoLHjV9t+6uqO7osm3M1PNQ3BDTeStrlRB2W
         RRWumz7WfaHVKuBUb26e677jP00DJ21R1/1AZgLbh0CLxpvNi+Qg80qIZmHearhOw9C2
         EezYGjfQ2PC7LnTNoEanUbn6F3aSsWK2Zon5Q71fT+1rtLxRN9iLw0a4t8i8KtPiCynn
         iPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731121084; x=1731725884;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xeepDSMekLWdN9dw+iAAPG9h5iMUwhHzvrTsRjDcopM=;
        b=bY7yBlz80tmIj1q2/GcQWvrj8gqmduUn94qszLwVjzYFkH7hC/1Tw8SZPAEzOT9JpY
         gXnvmF4fHEH2zNdXqiSLr5EpzWAD5HlJzG41rF12C8IQgw/fMg1wbUYD+rItfbvq+cGW
         EjGDfZ0+AlVc4+1c/Hxf08WKsGlv9HpNsbwbW7SK7N/Khu2U9X8TZVbKfKydWScUQnWA
         O12LkGcQDV2ewUHU5+jEWVBI9MDDPtnqY3p1m4yYPMwqS3vOSF4misauQ2wHxnWv3rTU
         9L34DCFMUTNyRTYch3rXqsuga1zK1BMUIRvggxFjDLb3c1fvYR8e7vs1vJlCl37Kr85A
         vohA==
X-Forwarded-Encrypted: i=1; AJvYcCXcQGKuqGs+qQWzNLbU/hjUxVJvZku+xRNodiehwzZmdPp2PchfLZJvBaewgvC1gDL1pIzrkjs+dJNKKHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5DRhI3IVVMagWVoXTowI/nK7XZSRwvVOlPyumJYxdavhy+um
	57hG+HId/DMrBhtD+crn4DFYw/HQAlhS1C7HlMF2BbmfHS2YxYNJcexgZ1UK8f40nP+qbLtGH5G
	45kFgFg==
X-Google-Smtp-Source: AGHT+IFyKQHcp6GwqhTuAtmFz55t1ESJhipFBhyeMD9PmkvvGJQ689MBuqnef3qOPc8jI+vcC4J712fGpHZ4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a5b:c09:0:b0:e30:cdd0:fc14 with SMTP id
 3f1490d57ef6-e337f8ed79emr4049276.9.1731121084313; Fri, 08 Nov 2024 18:58:04
 -0800 (PST)
Date: Fri,  8 Nov 2024 18:58:01 -0800
Message-Id: <20241109025801.560378-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v1] perf list: Fix topic and pmu_name argument order
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>

Fix function definitions to match header file declaration. Fix two
callers to pass the arguments in the right order.

On Intel Tigerlake, before:
```
$ perf list -j|grep "\"Topic\""|sort|uniq
        "Topic": "cache",
        "Topic": "cpu",
        "Topic": "floating point",
        "Topic": "frontend",
        "Topic": "memory",
        "Topic": "other",
        "Topic": "pfm icl",
        "Topic": "pfm ix86arch",
        "Topic": "pfm perf_raw",
        "Topic": "pipeline",
        "Topic": "tool",
        "Topic": "uncore interconnect",
        "Topic": "uncore memory",
        "Topic": "uncore other",
        "Topic": "virtual memory",
$ perf list -j|grep "\"Unit\""|sort|uniq
        "Unit": "cache",
        "Unit": "cpu",
        "Unit": "cstate_core",
        "Unit": "cstate_pkg",
        "Unit": "i915",
        "Unit": "icl",
        "Unit": "intel_bts",
        "Unit": "intel_pt",
        "Unit": "ix86arch",
        "Unit": "msr",
        "Unit": "perf_raw",
        "Unit": "power",
        "Unit": "tool",
        "Unit": "uncore_arb",
        "Unit": "uncore_clock",
        "Unit": "uncore_imc_free_running_0",
        "Unit": "uncore_imc_free_running_1",
```

After:
```
$ perf list -j|grep "\"Topic\""|sort|uniq
        "Topic": "cache",
        "Topic": "floating point",
        "Topic": "frontend",
        "Topic": "memory",
        "Topic": "other",
        "Topic": "pfm icl",
        "Topic": "pfm ix86arch",
        "Topic": "pfm perf_raw",
        "Topic": "pipeline",
        "Topic": "tool",
        "Topic": "uncore interconnect",
        "Topic": "uncore memory",
        "Topic": "uncore other",
        "Topic": "virtual memory",
$ perf list -j|grep "\"Unit\""|sort|uniq
        "Unit": "cpu",
        "Unit": "cstate_core",
        "Unit": "cstate_pkg",
        "Unit": "i915",
        "Unit": "icl",
        "Unit": "intel_bts",
        "Unit": "intel_pt",
        "Unit": "ix86arch",
        "Unit": "msr",
        "Unit": "perf_raw",
        "Unit": "power",
        "Unit": "tool",
        "Unit": "uncore_arb",
        "Unit": "uncore_clock",
        "Unit": "uncore_imc_free_running_0",
        "Unit": "uncore_imc_free_running_1",
```

Fixes: e5c6109f4813 ("perf list: Reorganize to use callbacks to allow honouring command line options")
Signed-off-by: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
Tested-by: Ian Rogers <irogers@google.com>
---
Note from Ian, I fixed the two callers and added it to
Jean-Phillippe's original change.
---
 tools/perf/builtin-list.c | 4 ++--
 tools/perf/util/pfm.c     | 4 ++--
 tools/perf/util/pmus.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index b8378ba18c28..9e7fdfcdd7ff 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -113,7 +113,7 @@ static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
 	}
 }
 
-static void default_print_event(void *ps, const char *pmu_name, const char *topic,
+static void default_print_event(void *ps, const char *topic, const char *pmu_name,
 				const char *event_name, const char *event_alias,
 				const char *scale_unit __maybe_unused,
 				bool deprecated, const char *event_type_desc,
@@ -354,7 +354,7 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
 	fputs(buf->buf, fp);
 }
 
-static void json_print_event(void *ps, const char *pmu_name, const char *topic,
+static void json_print_event(void *ps, const char *topic, const char *pmu_name,
 			     const char *event_name, const char *event_alias,
 			     const char *scale_unit,
 			     bool deprecated, const char *event_type_desc,
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 5ccfe4b64cdf..0dacc133ed39 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -233,7 +233,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 	}
 
 	if (is_libpfm_event_supported(name, cpus, threads)) {
-		print_cb->print_event(print_state, pinfo->name, topic,
+		print_cb->print_event(print_state, topic, pinfo->name,
 				      name, info->equiv,
 				      /*scale_unit=*/NULL,
 				      /*deprecated=*/NULL, "PFM event",
@@ -267,8 +267,8 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 				continue;
 
 			print_cb->print_event(print_state,
-					pinfo->name,
 					topic,
+					pinfo->name,
 					name, /*alias=*/NULL,
 					/*scale_unit=*/NULL,
 					/*deprecated=*/NULL, "PFM event",
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 107de86c2637..6d4c7c9ecf3a 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -501,8 +501,8 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 			goto free;
 
 		print_cb->print_event(print_state,
-				aliases[j].pmu_name,
 				aliases[j].topic,
+				aliases[j].pmu_name,
 				aliases[j].name,
 				aliases[j].alias,
 				aliases[j].scale_unit,
-- 
2.47.0.277.g8800431eea-goog


