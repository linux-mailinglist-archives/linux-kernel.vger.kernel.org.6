Return-Path: <linux-kernel+bounces-367248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F209A002D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D6CB249CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433931AF0DE;
	Wed, 16 Oct 2024 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/D3wXsg"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1599A19AA58
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052709; cv=none; b=so0np7+y4NlPj1ReJszVK4iuSrXAfvYhiBn1kC9ZQQw9QJy6XRxDgK6Z2BAGlhXU+gmaSLRZLbFj1c2XPJVA1A/IeoD4OhC+MJ7k1SEmbyNZ2xDB3ANrhu+ZPfmPg0KRyar3JDCYHxbMm+ZCRrmXLGl0oX0XE8KbAjbNjjw1Les=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052709; c=relaxed/simple;
	bh=s5yyLidwQ40d4OogKqHnOvqWwc/N1AglqDKRBjOI2yk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ldygx/5ydIQdKc/5PaigtDfGu63RyH2u+6MEyerGls9XOl9uxmGCy9eoqP6zFEcrA9I4JwrTW9zteSBQNQ9pnmUKPeSnm+pHSavpgd6FDTN+OjUr2mX0T7N9ldfnkxs8tU8K8+v6MKld2dpvw/mz5ny6U9a4NN27M8K62lRwsUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/D3wXsg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e293b3e014aso4976616276.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052707; x=1729657507; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSfb1a/n/0uhtJ4YqpAgkjD+74Vwwf3V49tKPgTATBU=;
        b=S/D3wXsgD5rY3sQXZYqKtwCjBhFHFvZD84AhOuTPrVhsx2iP4Qut/K4Rox/MP/GUD8
         TVpMEhz8+5fM29GMhUTqo4fTgeSGEOvHl/sNE2qNlxTd4+evmNh4PcX0YflrhDgCZuUx
         KkH341qU8U1h4j3zMbo3d6XXdjx9igXz83Bn07GOZgsQonJhnN2iS7O74P6TCCBu2PhQ
         8Nl88rKwh6t7838RmQkzMID0dHHpCiEVhgM9WSGm0lSeP2bn7/X5VAOoskSS4in7ABvD
         Co/CwD/xXOqiy8acFYGo3guKQVqc7z6LOwsalrc6HlsiXy5dTJptY0N1UgKBUbx6R26Y
         GJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052707; x=1729657507;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSfb1a/n/0uhtJ4YqpAgkjD+74Vwwf3V49tKPgTATBU=;
        b=UTANPnbZVNS9GR39bUbRJY27NlsqCOP3s51u7JXjDFo6hxp7hXo5W/EgciB7eNKAys
         XruJfRoTPLwYlrMiKjRsQ2RGG4nt5t0DeMjoFrS7W1pmtUPM66PkXJ9A2yfmCTzhU+md
         D3ad3EkgAn9L3/G8UOEnh/l3qBXr9S78nCpBqbjL9jHrGGpFRyAnxqL0PCCo29zlp9lt
         kLMFhVGKdu+JlhurDnmdMIAgYiHNViwgFb6E+rGVzpzeN/Hqfj15yxEQdVZkRdNFMxqJ
         /HGnjjSu4XR6gyKb1WxsfUMD8vghAnwPQAb5ECL1dRws5PSthfx3pX65deBOO6AnANbl
         bgwg==
X-Forwarded-Encrypted: i=1; AJvYcCUXLZRmEgwkfSQF1l7Cr5tiEbtrRtSfx56wYWA1tV5hPSz3j6eLeuYlp8EFZlLDIG5jTZDFeOXZ9QjMN0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4M2NrmpFb5WUMqN28cOutTfmJAfzQgRiNNpvAXRNXBi2Du+xd
	6MGaUDnvGZzqeoV7Jb9eb0KOvJvidCZZH7bNDvd2iyx9GLjzuHKQGRqIgXle5Y5MBi77PJyor3U
	/YrPcZg==
X-Google-Smtp-Source: AGHT+IF7iU/lbO7eXiz62Z6cqJvELGnqBvwlKfToxBCxdccEfMP6WMhQ7/Sl3phnoOJD2uCh5sht0jY1WzGJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d08:b0:e28:f6b3:3666 with SMTP
 id 3f1490d57ef6-e2978567367mr2282276.7.1729052706878; Tue, 15 Oct 2024
 21:25:06 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:13 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 14/16] perf kwork: Make perf_kwork_add_work a callback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_kwork_add_work is declared in builtin-kwork, whereas much kwork
code is in util. To avoid needing to stub perf_kwork_add_work in
python.c, add a callback to struct perf_kwork and initialize it in
builtin-kwork to perf_kwork_add_work - this is the only struct
perf_kwork. This removes the need for the stub in python.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kwork.c      |  3 ++-
 tools/perf/util/bpf_kwork.c     |  2 +-
 tools/perf/util/bpf_kwork_top.c |  2 +-
 tools/perf/util/kwork.h         |  6 ++++--
 tools/perf/util/python.c        | 12 ------------
 5 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index c1daf82c9b92..fabfcb74800b 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1846,7 +1846,7 @@ static void process_skipped_events(struct perf_kwork *kwork,
 	}
 }
 
-struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork,
+static struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork,
 				       struct kwork_class *class,
 				       struct kwork_work *key)
 {
@@ -2344,6 +2344,7 @@ int cmd_kwork(int argc, const char **argv)
 		.all_runtime         = 0,
 		.all_count           = 0,
 		.nr_skipped_events   = { 0 },
+		.add_work            = perf_kwork_add_work,
 	};
 	static const char default_report_sort_order[] = "runtime, max, count";
 	static const char default_latency_sort_order[] = "avg, max, count";
diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
index 6c7126b7670d..5cff755c71fa 100644
--- a/tools/perf/util/bpf_kwork.c
+++ b/tools/perf/util/bpf_kwork.c
@@ -285,7 +285,7 @@ static int add_work(struct perf_kwork *kwork,
 	    (bpf_trace->get_work_name(key, &tmp.name)))
 		return -1;
 
-	work = perf_kwork_add_work(kwork, tmp.class, &tmp);
+	work = kwork->add_work(kwork, tmp.class, &tmp);
 	if (work == NULL)
 		return -1;
 
diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
index 7261cad43468..b6f187dd9136 100644
--- a/tools/perf/util/bpf_kwork_top.c
+++ b/tools/perf/util/bpf_kwork_top.c
@@ -255,7 +255,7 @@ static int add_work(struct perf_kwork *kwork, struct work_key *key,
 	bpf_trace = kwork_class_bpf_supported_list[type];
 	tmp.class = bpf_trace->class;
 
-	work = perf_kwork_add_work(kwork, tmp.class, &tmp);
+	work = kwork->add_work(kwork, tmp.class, &tmp);
 	if (!work)
 		return -1;
 
diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
index 76fe2a821bcf..29352ca1d497 100644
--- a/tools/perf/util/kwork.h
+++ b/tools/perf/util/kwork.h
@@ -251,12 +251,14 @@ struct perf_kwork {
 	 * perf kwork top data
 	 */
 	struct kwork_top_stat top_stat;
-};
 
-struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork,
+	/* Add work callback. */
+	struct kwork_work *(*add_work)(struct perf_kwork *kwork,
 				       struct kwork_class *class,
 				       struct kwork_work *key);
 
+};
+
 #ifdef HAVE_BPF_SKEL
 
 int perf_kwork__trace_prepare_bpf(struct perf_kwork *kwork);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c52da509ae58..6e2ff0076daa 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/kwork.h"
 #include "util/sample.h"
 #include <internal/lib.h>
 
@@ -1297,14 +1296,3 @@ PyMODINIT_FUNC PyInit_perf(void)
 		PyErr_SetString(PyExc_ImportError, "perf: Init failed!");
 	return module;
 }
-
-
-/* The following are stubs to avoid dragging in builtin-* objects. */
-/* TODO: move the code out of the builtin-* file into util. */
-
-struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
-				       struct kwork_class *class __maybe_unused,
-				       struct kwork_work *key  __maybe_unused)
-{
-	return NULL;
-}
-- 
2.47.0.rc1.288.g06298d1525-goog


