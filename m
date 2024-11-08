Return-Path: <linux-kernel+bounces-402216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD23D9C2512
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376C6B24A71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB91A9B5B;
	Fri,  8 Nov 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFjX21tC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F61C1F04
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091688; cv=none; b=EhnVYMv5FEbh4y4lfLxYlbgTF6HmQ2xLkahbZAeMz/EO5IRa9u6QBJdf73ZPFLx60L3JJvf+g17TKyzEi5H5JhALluEI9FtJaFWHqj8Z30QQUuV+TIzrC52Xomf9p6LgC9tqpyM+6hMxyr44c4vaCVB+iZu2SBZL/ZV+YmlCES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091688; c=relaxed/simple;
	bh=XNY9uVeifqGo+9G7z9AtLWdOgZhYbmroGy7S3lb/rGQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ll+SG/Xv3Ys2yHy3163QObdP9Jx6A1haXOk8UhEBLO2Gh5rauNZHP3175Io7ASkzhVrX8Hqii1ei6tJXL8YlFtiIsr8dTqzvJmlgLhNaNIFhYUeTb4TT9ZWKZUEyXtSTuWfkf8HGVcJmyjuB/XHSUUOq00hfXvwy7Z8EeUfcSAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YFjX21tC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e355f1ff4bso53054777b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731091686; x=1731696486; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3yiiCMIG3iemm8POxI+I5CNo54RJLrHIomM1f2xMGGE=;
        b=YFjX21tCLy5WsdnTb7GVu2lnevzTTt1b9/qqqy5qcijyy29Nee7UkgvtmkD+3thrSV
         s6iX0WdFR9SqXghCGsp9oD6+gHB8tTwG4Z0wTjw/eHYkH3SBJQxKzCqNLTqiC7AhJBUL
         uPVXyjujJTcivQWPzGj3WiRaUo+pGjAg2pAWSputwgMbwSWqTEyVN0pxE1Nfj66PJ+wD
         0+cyWoqfVzaMtkNd7Z7xJxu4oYSrQUviJP5RFa2w/OlrSUq8KDGesc2PPRpjdQL36ozU
         pxlvML4puGN+Ojhc5q36srfFFnYavNeVOK/efcq7rKJ58+He0hXOJZI4yLOycholwK1U
         isFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731091686; x=1731696486;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yiiCMIG3iemm8POxI+I5CNo54RJLrHIomM1f2xMGGE=;
        b=r4gIhnzPilITgcujXMKU9u/HgFSrfsyiwsu7oB0dIb7Hgkc1aH/MTA9FyKW07BHcd+
         r8IJUxi67bRuS+JwfDsmdBkva31HeyWqU5dgZvEKrJAkyX9ywsXmtkOjXJ9LofKWXdsP
         qDf8FcVD1A9vYu6Wnis0p0GJLCiWd8trXIHl8nyPjMzg2eQQ8kndK6A58v7G/lWHf51p
         3lBq4OiRBCh1pc5IdHtLinGPq72CLOv3M26UgOYgzYmtPIESzMfdVlacQ1FHpj3x3768
         pFNCDtFt84lA/41X5/CtPKWVQB16mWbPTshLsvQjwlKMpN30cTu1JS5792pQTo54jt/J
         X99A==
X-Forwarded-Encrypted: i=1; AJvYcCWa6xSy5idHqyM6VZdLfbR7AaajabngiDgO4lnEwQVyhpftaTAbZsqAIY/CqY/ZB1vrEhFT7bwrqJLQWrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGk/WvmBF/Nket/fYolZHwmw5ELdobavVgq7MURH7HNoXTTK9C
	nOh5StWbLFWAcB0ZZNshCXLA099y3hbiZuXYoDMPXXW3ahTmrabYjT4L+YgkZQVJV5WAcKVIQ8M
	LmCHwLg==
X-Google-Smtp-Source: AGHT+IFzAkNfZHGWtP7kN7/RfDS2MdZ/X4ci2pc2Q9JZ6Zpq5CWdk4Aoa5Oot1sh0zBYxRseh2Ed2CeBqCI5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a0d:cf43:0:b0:6e3:1f46:77a6 with SMTP id
 00721157ae682-6eaddd8b07emr399897b3.2.1731091685465; Fri, 08 Nov 2024
 10:48:05 -0800 (PST)
Date: Fri,  8 Nov 2024 10:47:50 -0800
In-Reply-To: <20241108184751.359237-1-irogers@google.com>
Message-Id: <20241108184751.359237-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108184751.359237-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 5/6] perf evsel: Allow evsel__newtp without libtraceevent
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Switch from reading the tracepoint format to reading the id directly
for the evsel config. This avoids the need to initialize
libtraceevent, plugins, etc. It is sufficient for many tracepoint
commands to work like:
$ perf stat -e sched:sched_switch true

To populate evsel->tp_format, do lazy initialization using
libtraceevent in the evsel__tp_format function (the sys and name are
saved in evsel__newtp_idx for this purpose). Reading the id should be
indicative of the format failing to load, but if not an error is
reported in evsel__tp_format. This could happen for a tracepoint with
a format that fails to parse.

As tracepoints can be parsed without libtraceevent with this, remove
the associated #ifdefs in parse-events.c.

By only lazily parsing the tracepoint format information it is hoped
this will help improve the performance of code using tracepoints but
not the format information. It also cuts down on the build and ifdef
logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c        | 103 ++++++++++++++++++++++++---------
 tools/perf/util/evsel.h        |  14 ++---
 tools/perf/util/parse-events.c |  16 +----
 3 files changed, 82 insertions(+), 51 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a95db7e900d5..56e19e32a852 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -543,54 +543,101 @@ struct evsel *evsel__clone(struct evsel *orig)
 	return NULL;
 }
 
+static int trace_event__id(const char *sys, const char *name)
+{
+	char *tp_dir = get_events_file(sys);
+	char path[PATH_MAX];
+	int id, err;
+
+	if (!tp_dir)
+		return -1;
+
+	scnprintf(path, PATH_MAX, "%s/%s/id", tp_dir, name);
+	put_events_file(tp_dir);
+	err = filename__read_int(path, &id);
+	if (err)
+		return err;
+
+	return id;
+}
+
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
-#ifdef HAVE_LIBTRACEEVENT
 struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format)
 {
+	struct perf_event_attr attr = {
+		.type	       = PERF_TYPE_TRACEPOINT,
+		.sample_type   = (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
+				PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
+	};
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
-	int err = -ENOMEM;
+	int err = -ENOMEM, id = -1;
 
-	if (evsel == NULL) {
+	if (evsel == NULL)
 		goto out_err;
-	} else {
-		struct perf_event_attr attr = {
-			.type	       = PERF_TYPE_TRACEPOINT,
-			.sample_type   = (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
-					  PERF_SAMPLE_CPU | PERF_SAMPLE_PERIOD),
-		};
 
-		if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
-			goto out_free;
 
-		event_attr_init(&attr);
+	if (asprintf(&evsel->name, "%s:%s", sys, name) < 0)
+		goto out_free;
 
-		if (format) {
-			evsel->tp_format = trace_event__tp_format(sys, name);
-			if (IS_ERR(evsel->tp_format)) {
-				err = PTR_ERR(evsel->tp_format);
-				evsel->tp_format = NULL;
-				goto out_free;
-			}
-			attr.config = evsel->tp_format->id;
-		} else {
-			attr.config = (__u64) -1;
-		}
+#ifdef HAVE_LIBTRACEEVENT
+	evsel->tp_sys = strdup(sys);
+	if (!evsel->tp_sys)
+		goto out_free;
 
+	evsel->tp_name = strdup(name);
+	if (!evsel->tp_name)
+		goto out_free;
+#endif
 
-		attr.sample_period = 1;
-		evsel__init(evsel, &attr, idx);
-	}
+	event_attr_init(&attr);
 
+	if (format) {
+		id = trace_event__id(sys, name);
+		if (id < 0) {
+			err = id;
+			goto out_free;
+		}
+	}
+	attr.config = (__u64)id;
+	attr.sample_period = 1;
+	evsel__init(evsel, &attr, idx);
 	return evsel;
 
 out_free:
 	zfree(&evsel->name);
+#ifdef HAVE_LIBTRACEEVENT
+	zfree(&evsel->tp_sys);
+	zfree(&evsel->tp_name);
+#endif
 	free(evsel);
 out_err:
 	return ERR_PTR(err);
 }
+
+#ifdef HAVE_LIBTRACEEVENT
+struct tep_event *evsel__tp_format(struct evsel *evsel)
+{
+	struct tep_event *tp_format = evsel->tp_format;
+
+	if (tp_format)
+		return tp_format;
+
+	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
+		return NULL;
+
+	tp_format = trace_event__tp_format(evsel->tp_sys, evsel->tp_name);
+	if (IS_ERR(tp_format)) {
+		int err = -PTR_ERR(evsel->tp_format);
+
+		pr_err("Error getting tracepoint format '%s' '%s'(%d)\n",
+			evsel__name(evsel), strerror(err), err);
+		return NULL;
+	}
+	evsel->tp_format = tp_format;
+	return evsel->tp_format;
+}
 #endif
 
 const char *const evsel__hw_names[PERF_COUNT_HW_MAX] = {
@@ -1587,6 +1634,10 @@ void evsel__exit(struct evsel *evsel)
 	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
+#ifdef HAVE_LIBTRACEEVENT
+	zfree(&evsel->tp_sys);
+	zfree(&evsel->tp_name);
+#endif
 	zfree(&evsel->filter);
 	zfree(&evsel->group_pmu_name);
 	zfree(&evsel->unit);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c3e53d320bf5..93b6244ec302 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -59,6 +59,8 @@ struct evsel {
 		char			*group_name;
 		const char		*group_pmu_name;
 #ifdef HAVE_LIBTRACEEVENT
+		char			*tp_sys;
+		char			*tp_name;
 		struct tep_event	*tp_format;
 #endif
 		char			*filter;
@@ -247,25 +249,17 @@ int copy_config_terms(struct list_head *dst, struct list_head *src);
 void free_config_terms(struct list_head *config_terms);
 
 
-#ifdef HAVE_LIBTRACEEVENT
-struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
-
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
+struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool format);
 static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 {
 	return evsel__newtp_idx(sys, name, 0, true);
 }
 
-static inline struct tep_event *evsel__tp_format(struct evsel *evsel)
-{
-	return evsel->tp_format;
-}
-#endif
-
 #ifdef HAVE_LIBTRACEEVENT
-struct tep_event *event_format__new(const char *sys, const char *name);
+struct tep_event *evsel__tp_format(struct evsel *evsel);
 #endif
 
 void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index afeb8d815bbf..7fc1c36ef2a4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -489,7 +489,6 @@ int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 	return found_supported ? 0 : -EINVAL;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static void tracepoint_error(struct parse_events_error *e, int err,
 			     const char *sys, const char *name, int column)
 {
@@ -644,7 +643,6 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 	closedir(events_dir);
 	return ret;
 }
-#endif /* HAVE_LIBTRACEEVENT */
 
 size_t default_breakpoint_len(void)
 {
@@ -1066,7 +1064,6 @@ static int config_term_pmu(struct perf_event_attr *attr,
 	return config_term_common(attr, term, err);
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int config_term_tracepoint(struct perf_event_attr *attr,
 				  struct parse_events_term *term,
 				  struct parse_events_error *err)
@@ -1111,7 +1108,6 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 
 	return 0;
 }
-#endif
 
 static int config_attr(struct perf_event_attr *attr,
 		       const struct parse_events_terms *head,
@@ -1303,7 +1299,7 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 				struct parse_events_terms *head_config, void *loc_)
 {
 	YYLTYPE *loc = loc_;
-#ifdef HAVE_LIBTRACEEVENT
+
 	if (head_config) {
 		struct perf_event_attr attr;
 
@@ -1318,16 +1314,6 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 	else
 		return add_tracepoint_event(parse_state, list, sys, event,
 					    err, head_config, loc);
-#else
-	(void)parse_state;
-	(void)list;
-	(void)sys;
-	(void)event;
-	(void)head_config;
-	parse_events_error__handle(err, loc->first_column, strdup("unsupported tracepoint"),
-				strdup("libtraceevent is necessary for tracepoint support"));
-	return -1;
-#endif
 }
 
 static int __parse_events_add_numeric(struct parse_events_state *parse_state,
-- 
2.47.0.277.g8800431eea-goog


