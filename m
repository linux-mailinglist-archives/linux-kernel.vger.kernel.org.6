Return-Path: <linux-kernel+bounces-413684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851E9D1D28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53531F20DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6B6156F41;
	Tue, 19 Nov 2024 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GLzZcWQ9"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83215854F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979109; cv=none; b=GVauLukVmv8kwDeFHsQOLY/hu6+cdyqvs7snYNvmx8KCjKcky2DK+FQFT6F2B4vrkH2TTKdntavwYh6ERyBgOEvo4dE/JGuw37BOC9iXOPdQvT9axp0jSACnLWyweEl72V22pA/It4Ij62HtbwR1ohWMHnyB2jf+ZeCm0V9LI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979109; c=relaxed/simple;
	bh=z6Pm8ATKpcVHRFX9lVjqQEXey9GaIdXlbaie6pTu+zw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Nj6wc71Z4gDdAFicjEng2vSgH30cAdpHx/6aHqRyXOyKD3LJvHZIaCWppmkDE+zvB65a4kZnigLdwvw8nUKd2ZTJ+2q2j1LVoPwdSI2maRf3shW2vPLu3JVR1CPzwVDFZvuy1JVUiktVtwf7Gk/5K7ye85lT8YxWiN3YF0gghAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GLzZcWQ9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3314237b86so3452331276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979106; x=1732583906; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=55R+aYCHOFQ2GhoTuF38RCq5QtZuRMd9/UXqCPviTZU=;
        b=GLzZcWQ9gXGow2uTxw6j3mqbnu8LNkA9T/hrLePUM67bo3imuRSyyMmJEHI3qGj+l5
         lVNLXkPG6FRNGc9HZ+Hlo5kgSKc/NuOw8CndIJCuf1cKHtUZia2vcjsLg54DDd3JCyU0
         gQw4kD1nYL9jWz+QlwKY6TX1Ye5f5vMzSem7/6Mq3Kql978G89EThky7JjzrK9a5VtGP
         92pVNDHK7Mxn/hBQpRmw0eeJpGOW23n/Iy8e6MR2rnw4WRtUj+tS3nx24Z0tuY+NfjyL
         X5j8U5mWR57kNeTf79RNHDifWwscFC9bodQlY10xZH56Qn/X9p64CMZttuBmJENtFXYF
         3dEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979106; x=1732583906;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55R+aYCHOFQ2GhoTuF38RCq5QtZuRMd9/UXqCPviTZU=;
        b=sKiLBYTFSJpQ9WB8GquK7hqMpwcr8fU5M6dmuq52yFJaybuNaDcHdMfTnLp6TVBqeH
         d1KooUZrQYNF4n1E4tQ7CrsRb1kBDUTceli1EuL/rNqbTWfi90m0gBxl4ja5FTYjFOE9
         Nkpfcuu53NRRSqUh21W5X+/71bnf511QUgJaW/vdycns1OGbtmNUEhGIJ3ic+A1+eOwU
         O1mOt8IkaqmpnJPQRK3u1ca58fUOiyQvd+vwO67y027CMebfj6VUn2NmUyxJrbNmNC4W
         UigVVKErEPBV01iUkInXlaCpYNRiknOt7ubQ3ZoWUSkWIg22eXw2V0xUqDr9PPClsuA4
         DObQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNbdwFcCBtyqjNVHN2YyZHgNMJ2f8KZGDIX2jBuUj/7swKHYPxSN84xfMOFjDLlIHO9RCjkpxzXVxfgfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmHvDWiHemei5sv4OBoFNoj1nvdm6dTsWjdvwuEYR+yHtrjk7P
	thzwYqwj6/uFP4DVOkJdf3xGk9ieZT9bS4XYe7ZyxBonTo0u7atpybctTmWKPDzhPLnpCqkx2FI
	+PsJIhA==
X-Google-Smtp-Source: AGHT+IEHz5EAkyZuzVFmLmsZNPk64z5IYcXA0UKpehcSG3KUXHBFmAD0H9nOd16MT32Tkcbkyrh54koqsWAj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:6902:240d:b0:e16:68fb:f261 with SMTP
 id 3f1490d57ef6-e38263b0b42mr12215276.5.1731979105853; Mon, 18 Nov 2024
 17:18:25 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:41 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 19/22] perf python: Add parse_events function
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
index f745723d486b..5fd32b6729b4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -454,7 +454,7 @@ static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
  * The assumption is that @orig is not configured nor opened yet.
  * So we only care about the attributes that can be set while it's parsed.
  */
-struct evsel *evsel__clone(struct evsel *orig)
+struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 {
 	struct evsel *evsel;
 
@@ -467,7 +467,11 @@ struct evsel *evsel__clone(struct evsel *orig)
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
 
@@ -512,11 +516,12 @@ struct evsel *evsel__clone(struct evsel *orig)
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
index 3e32a502a41c..c84c912874b7 100644
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
2.47.0.338.g60cca15819-goog


