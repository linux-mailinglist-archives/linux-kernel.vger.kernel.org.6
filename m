Return-Path: <linux-kernel+bounces-389856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303D69B722B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BAB286734
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55214BF8F;
	Thu, 31 Oct 2024 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7KvGWlU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277414B092
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339041; cv=none; b=XO/9d9s/M/hv0BLr0ZSjNGUlfP4r3Wc0Tkfyu4Y1yBraKLdivHc9DOiuj0EvQ/F+pTOh2zMInkCjb0RrrZ3osVn7FOfEmDKACpqxbPDVQjsrkoxk88M+X8FtQ11vwbykku/zwFl8ntJMfylZLfWscoj1WBE/Zwt50ARVjD1gz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339041; c=relaxed/simple;
	bh=wFg8rXKhwSk+/WnE2Ybco7HPsV496JVgIBfe+G5oj+I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CHNUUWdHItSFwnSNS2DNAoJwOZg5t6F2ubdRfaHC1xPbekRvGj8eZLvTeXwFacvCk2gVvlRrKf61T29GOEmUq2hLfD/fhh1LNIOiPNQyZEu5OXLMnysVvI+0QlDs01CimtfCVZRJlok3K4rKZkJDgequeBFHaViDhSSCkRBWCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V7KvGWlU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e31e5d1739so8342537b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339038; x=1730943838; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACBWh/O4/X4qiB3oXOqHhx7Z60zaZQtrFXt6UTS1Yas=;
        b=V7KvGWlUOgO3XuIJiy5vYNCJfyuWJhGuyhvZ7EuEcuLmLixdt8+oBiUhA3HFLSrfD/
         1OXgPD84gJ8m9OwAwscVycMX5r/23Z7fdVhkmOCW+nrdLm2As9f5cSV/4zB8voWz/+Lt
         54f/KyrJyrArDXS4FR3RdJpzQf3L6qeEaIhBB9ILOyk35BqxZWNoGKLojqXEf7paD7K2
         SNhU8xZaIGWvlJfsDUGSnJcqsqN4Xpdmj3G9c4PwsgDMPausmMZXzdH04vcSFFn/yacf
         qXnlSXcZpAaD/adcCtYbOrlckcs7w38RddifCss/A3raGXIYedyUWVSzYqm90WpgXJGI
         1chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339038; x=1730943838;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACBWh/O4/X4qiB3oXOqHhx7Z60zaZQtrFXt6UTS1Yas=;
        b=klLDNNluH03ViYyb1mUU7tT7WL6o/hmuAY9oqeUOpPAsL1BJcWG9MgFM5pnfOQuDdu
         4k1BdQA2Wktkc1l3JewC4Gg9fhcVUknkdvXC0HWLbIla+Wpka2/fa5wGAyr+wI01CS1Q
         HoIdeFTN9nRzA2h9H+ZpnWHyoW7tG5Hm9xPdfK9/blIwDg1pPWvr8SkAWlvMF3AY3caK
         6lxV7h0sxltLxAzm3S7DquEWT0DqgXGb59UGX8lZxpEdYxzFQpuHg4oYLMxXm+j6B2Wt
         KkWlx8VfpSAzkygjMhc7izdsUcDwm/MgMX8aauNSjRSbfC3EsDjLHgspE9z9VyO8huxm
         4WZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqdKv4A7jcgPQjABJlTnK9UuQ67m/tjdeWwsZNLxacsescwOnt7NpqVQL46OKQNguBpTUHMArwddwl1Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8qfjs2EwbYgUp7M/DyhQNhD042biH8+yTID55+hRH64f3Q7wQ
	xkfZCzTBRUtQnlEDzqX+PurlL/haFGCsW62bmm7kSD5GL63Lc7DA24FvY6JndQ3Mo//kH8XnmT+
	On6i+wg==
X-Google-Smtp-Source: AGHT+IEqaz7ycUlhAWtRd1uPjKDmpfP1/3VQIxzcug2wLaT0TrrwpCVBkUafJHmQLBHVodYIBtZod9ELpHSN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a81:a844:0:b0:62c:f976:a763 with SMTP id
 00721157ae682-6e9d892d6cemr5326627b3.1.1730339037973; Wed, 30 Oct 2024
 18:43:57 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:49 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 18/21] perf python: Add parse_events function
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add basic parse_events function that takes a string and returns an
evlist. As the python evlist is embedded in a pyrf_evlist, and the
evsels are embedded in pyrf_evsels, copy the parsed data into those
structs and update evsel__clone to enable this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cgroup.c |  2 +-
 tools/perf/util/evsel.c  | 19 ++++++++-----
 tools/perf/util/evsel.h  |  2 +-
 tools/perf/util/python.c | 61 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 0f759dd96db7..fbcc0626f9ce 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -473,7 +473,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 
 		leader = NULL;
 		evlist__for_each_entry(orig_list, pos) {
-			evsel = evsel__clone(pos);
+			evsel = evsel__clone(/*dest=*/NULL, pos);
 			if (evsel == NULL)
 				goto out_err;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f780e30aa259..4213ffacdc3c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -453,7 +453,7 @@ static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
  * The assumption is that @orig is not configured nor opened yet.
  * So we only care about the attributes that can be set while it's parsed.
  */
-struct evsel *evsel__clone(struct evsel *orig)
+struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 {
 	struct evsel *evsel;
 
@@ -466,7 +466,11 @@ struct evsel *evsel__clone(struct evsel *orig)
 	if (orig->bpf_obj)
 		return NULL;
 
-	evsel = evsel__new(&orig->core.attr);
+	if (dest)
+		evsel = dest;
+	else
+		evsel = evsel__new(&orig->core.attr);
+
 	if (evsel == NULL)
 		return NULL;
 
@@ -511,11 +515,12 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.leader = orig->core.leader;
 
 	evsel->max_events = orig->max_events;
-	free((char *)evsel->unit);
-	evsel->unit = strdup(orig->unit);
-	if (evsel->unit == NULL)
-		goto out_err;
-
+	zfree(&evsel->unit);
+	if (orig->unit) {
+		evsel->unit = strdup(orig->unit);
+		if (evsel->unit == NULL)
+			goto out_err;
+	}
 	evsel->scale = orig->scale;
 	evsel->snapshot = orig->snapshot;
 	evsel->per_pkg = orig->per_pkg;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 04934a7af174..7f41d6f8cf6f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -241,7 +241,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 	return evsel__new_idx(attr, 0);
 }
 
-struct evsel *evsel__clone(struct evsel *orig);
+struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig);
 
 int copy_config_terms(struct list_head *dst, struct list_head *src);
 void free_config_terms(struct list_head *config_terms);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6e2ff0076daa..1a53a97c513d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -13,6 +13,7 @@
 #include "evsel.h"
 #include "event.h"
 #include "print_binary.h"
+#include "strbuf.h"
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
@@ -1201,6 +1202,60 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 #endif // HAVE_LIBTRACEEVENT
 }
 
+static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
+{
+	struct pyrf_evsel *pevsel = PyObject_New(struct pyrf_evsel, &pyrf_evsel__type);
+
+	if (!pevsel)
+		return NULL;
+
+	memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
+	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
+
+	evsel__clone(&pevsel->evsel, evsel);
+	return (PyObject *)pevsel;
+}
+
+static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
+{
+	struct pyrf_evlist *pevlist = PyObject_New(struct pyrf_evlist, &pyrf_evlist__type);
+	struct evsel *pos;
+
+	if (!pevlist)
+		return NULL;
+
+	memset(&pevlist->evlist, 0, sizeof(pevlist->evlist));
+	evlist__init(&pevlist->evlist, evlist->core.all_cpus, evlist->core.threads);
+	evlist__for_each_entry(evlist, pos) {
+		struct pyrf_evsel *pevsel = (void *)pyrf_evsel__from_evsel(pos);
+
+		evlist__add(&pevlist->evlist, &pevsel->evsel);
+	}
+	return (PyObject *)pevlist;
+}
+
+static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
+{
+	const char *input;
+	struct evlist evlist = {};
+	struct parse_events_error err;
+	PyObject *result;
+
+	if (!PyArg_ParseTuple(args, "s", &input))
+		return NULL;
+
+	parse_events_error__init(&err);
+	evlist__init(&evlist, NULL, NULL);
+	if (parse_events(&evlist, input, &err)) {
+		parse_events_error__print(&err, input);
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	result = pyrf_evlist__from_evlist(&evlist);
+	evlist__exit(&evlist);
+	return result;
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "tracepoint",
@@ -1208,6 +1263,12 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("Get tracepoint config.")
 	},
+	{
+		.ml_name  = "parse_events",
+		.ml_meth  = (PyCFunction) pyrf__parse_events,
+		.ml_flags = METH_VARARGS,
+		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
+	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.47.0.163.g1226f6d8fa-goog


