Return-Path: <linux-kernel+bounces-574550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F35A6E6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9AA3B18AF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FAD1EF088;
	Mon, 24 Mar 2025 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SbkaN98r"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4761F03DA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855703; cv=none; b=YuT7Ve1vGNkPscKWt77kcgsw7yIoaTRUrq/xW9GKaxCqAR1Ctnz+DATTjgejAWXJfcOkcpWoXwogXtlDdFnpkP8wQg8WgU8ASksGxr7t6QtDYiyN9sjpJhmKE1F4k4KWMZ+gVZCUkh6Uu0fQw+Mo564wXF0cIWS9P5R+gWF5Ew4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855703; c=relaxed/simple;
	bh=aQ94fNPaOZE6PYvgPCW5WSHPBQdQVUZq24pj9KnKwC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NbsruffHyVaKrS7clicYvtfzDRy7GCPtASYe73bGOK7MXb7dmGVGWrroJLwJg2wW6bvNB6iKeuibtHdFXTW4wOQ7g/dSD0WEVVAJTDGMZewqfTDdyDVH8ureYQiHF7dNEdjDI8zGIOmfYrM0YhXw0iZfDjepYKRcSRk9ERhvfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SbkaN98r; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c23beea898so3255127fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742855701; x=1743460501; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZY9q8axMcgGZoMAQk8YvUirygGOk3Mm/VWg06jUJcG8=;
        b=SbkaN98rslRAbA4JV0AazdZCuGNcnEIugMItbI5jWzrlkjHZt6Sxjlz5VN/GlB6Z2D
         VbUMaCkM+gElpnQ2ZwNfWzD4KZTFzurfq8FLrJz/997FZ8jygsdmOFwm+5WTst9Fdmrr
         doUvVJ5OmfNjQjO1O3m+nlTu9MP4MpW9wkPOZpfGJOzd44ZOB8mZJwxZPqZIrgm+Xj/i
         0ZSdyDUUbxh5QnGltJGi4q923XJEagLbiYIIxIayBAzboPhrgZrqAJCbxri3N9ExAejx
         3W0lHnjW5vBnWdLG0A7Ji9qx80b9mxgqijIElJKFdMWjd9meHyCHJXMYKHQgklyct3CO
         CwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855701; x=1743460501;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY9q8axMcgGZoMAQk8YvUirygGOk3Mm/VWg06jUJcG8=;
        b=RhSKWpmMDkiFuEEKwFi9jWtWHS3Py2Xv1OkH4EmDnXHeC9aFqJWfTzpukWpIdWNQg7
         hndLN+ey0KLsw+6q2qkK6QXDaKFZSHkWKNo44xrmisC1JLoCp1qPBb692hm9P5MwuGhp
         QxKjCV3uWntIO5yVNV6PvcBxs/wLW+P0SmbVBeN6Y8kJCC1DogW1vzTUurYBc7yFtVQE
         aLbtUXpa0nP9AqyDF8EWMcxUFvKdCa4pZCRAIkhtvJX8HMZyzzylkwBHkDRqh70eNdJi
         3EwpJgaZgj38wJtzDtiJa4Dxp24BscS1XqFiSWTADiwF9TPBfge6pmrfsO3/4oC6Of4J
         qB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1UXJWRpj1mbn0cvr0KV4NoAsAuV7COySJ8PO2/E1TCmt7QadTTNHKq73bT4fTkI2rhFXPg2ulSGmNAxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPog52sFNpZ/YvKxCDiIxqfo6aEjT5YRumpE5lHSnMVsz6FzP6
	aXPpdWMD4rN8cNoUZoJnOmNR7+j4/HOFWdNbUsFF7LbaNKqUOej+yv/zojoaKd8EjPl1FXzNYzG
	Hys59hA==
X-Google-Smtp-Source: AGHT+IHQY8KHThvchOZrihJb0/lyvXHFRemQHry7URlGvL+rdisr9TeUoaJpCLuUYjxiuiQ10J6XLEvR/aJh
X-Received: from oacqc9.prod.google.com ([2002:a05:6871:e7c9:b0:2b8:4497:1ce5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:1c2:b0:29d:c832:7ef6
 with SMTP id 586e51a60fabf-2c78051a29bmr8800315fac.39.1742855700650; Mon, 24
 Mar 2025 15:35:00 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:34:40 -0700
In-Reply-To: <20250324223452.208081-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324223452.208081-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324223452.208081-3-irogers@google.com>
Subject: [PATCH v1 02/14] perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Try to add more consistency to evsel by having tpebs_start renamed to
evsel__tpebs_open, passing the evsel that is being opened. The unusual
behavior of evsel__tpebs_open opening all events on the evlist is kept
and will be cleaned up further in later patches. The comments are
cleaned up as tpebs_start isn't called from evlist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c       |  2 +-
 tools/perf/util/intel-tpebs.c | 33 ++++++++++++++++-----------------
 tools/perf/util/intel-tpebs.h |  7 +++----
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1974395492d7..121283f2f382 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2595,7 +2595,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	struct perf_cpu cpu;
 
 	if (evsel__is_retire_lat(evsel))
-		return tpebs_start(evsel->evlist);
+		return evsel__tpebs_open(evsel);
 
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index fb28aa211a63..2b2f4b28e8ef 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -12,6 +12,7 @@
 #include <linux/zalloc.h>
 #include <linux/err.h>
 #include "sample.h"
+#include "counts.h"
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -188,18 +189,16 @@ static int tpebs_stop(void)
 	return ret;
 }
 
-/*
- * tpebs_start - start tpebs execution.
- * @evsel_list: retire_latency evsels in this list will be selected and sampled
- * to get the average retire_latency value.
- *
- * This function will be called from evlist level later when evlist__open() is
- * called consistently.
+/**
+ * evsel__tpebs_open - starts tpebs execution.
+ * @evsel: retire_latency evsel, all evsels on its list will be selected. Each
+ *         evsel is sampled to get the average retire_latency value.
  */
-int tpebs_start(struct evlist *evsel_list)
+int evsel__tpebs_open(struct evsel *evsel)
 {
 	int ret = 0;
-	struct evsel *evsel;
+	struct evsel *pos;
+	struct evlist *evsel_list = evsel->evlist;
 	char cpumap_buf[50];
 
 	/*
@@ -214,25 +213,25 @@ int tpebs_start(struct evlist *evsel_list)
 	 * Prepare perf record for sampling event retire_latency before fork and
 	 * prepare workload
 	 */
-	evlist__for_each_entry(evsel_list, evsel) {
+	evlist__for_each_entry(evsel_list, pos) {
 		int i;
 		char *name;
 		struct tpebs_retire_lat *new;
 
-		if (!evsel->retire_lat)
+		if (!pos->retire_lat)
 			continue;
 
-		pr_debug("tpebs: Retire_latency of event %s is required\n", evsel->name);
-		for (i = strlen(evsel->name) - 1; i > 0; i--) {
-			if (evsel->name[i] == 'R')
+		pr_debug("tpebs: Retire_latency of event %s is required\n", pos->name);
+		for (i = strlen(pos->name) - 1; i > 0; i--) {
+			if (pos->name[i] == 'R')
 				break;
 		}
-		if (i <= 0 || evsel->name[i] != 'R') {
+		if (i <= 0 || pos->name[i] != 'R') {
 			ret = -1;
 			goto err;
 		}
 
-		name = strdup(evsel->name);
+		name = strdup(pos->name);
 		if (!name) {
 			ret = -ENOMEM;
 			goto err;
@@ -246,7 +245,7 @@ int tpebs_start(struct evlist *evsel_list)
 			goto err;
 		}
 		new->name = name;
-		new->tpebs_name = evsel->name;
+		new->tpebs_name = pos->name;
 		list_add_tail(&new->nd, &tpebs_results);
 		tpebs_event_size += 1;
 	}
diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
index 766b3fbd79f1..88d70bb37971 100644
--- a/tools/perf/util/intel-tpebs.h
+++ b/tools/perf/util/intel-tpebs.h
@@ -5,19 +5,18 @@
 #ifndef INCLUDE__PERF_INTEL_TPEBS_H__
 #define INCLUDE__PERF_INTEL_TPEBS_H__
 
-#include "stat.h"
-#include "evsel.h"
+struct evsel;
 
 #ifdef HAVE_ARCH_X86_64_SUPPORT
 
 extern bool tpebs_recording;
-int tpebs_start(struct evlist *evsel_list);
+int evsel__tpebs_open(struct evsel *evsel);
 void tpebs_delete(void);
 int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
 
 #else
 
-static inline int tpebs_start(struct evlist *evsel_list __maybe_unused)
+static inline int evsel__tpebs_open(struct evsel *evsel __maybe_unused)
 {
 	return 0;
 }
-- 
2.49.0.395.g12beb8f557-goog


