Return-Path: <linux-kernel+bounces-413588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4879D1B53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA19B23707
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EDB1EABA0;
	Mon, 18 Nov 2024 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0/gzjx0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F61EE01F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970484; cv=none; b=fAYmrmjT781EnVGoLYzBdpAVuQF3hJolYycyMiLlPU3Jf+a0MRe1Yg1HMbBUfIkigx25nhAM/QqKZ2bPe6hdkX0PK/RWGIU3SGz2QLwfB6aB2EoSn1S6trOgmz4DwJ2cSs3KAsp5+rpW5fkCBbm54L8q9a1yI7RhFA0+Qc8Rg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970484; c=relaxed/simple;
	bh=bYH4LKGJAu2JkyiwoaF6CJMpGr6DfUExCzpwzjBU1UE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CVI93EHIip7CjlkX1+cqEjn9+JxFV0yKDtRun7JslCORNy21Gn0E7seHlbE5T92e7FlYFCgotQGidInXvYLCfXynv0juHd5eCGVi/cugg7C7oSX4WakB5M4OPDhr2vxSGu3RZUeroAsOq0NEweqLV+UfvpDxH8CY02HRioEXOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0/gzjx0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee426e3414so61795427b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970482; x=1732575282; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TkdfKR0RxAasZPeEtuzLUXU2avDKikbT7HP7un2dUo=;
        b=N0/gzjx0LKMMQ7rTAqV5lmPjnfJtFaZDlsIeNfQJ5RCadugHgXrusGjztSh2x1PObo
         K4zTAAsxa15b+nBmxGLSp6/Rx7vARlNTgVKvf0q/9YciysTLhekGtzTZMcZvosqUt2UM
         oejkNmJ2mZV1W8wOV2OV8K0bZ4sfj2t087yc5I+WW6LHFuvMQxWclqsAKuH+fdSHxlIr
         fIoV0Zb3LcR5rdMfdCxC2tygIqay1yYUx35qGFbiK7U3nzTv715p2YzzUsu9slCKS3Sq
         ++1AyaVD2XiDUBZ6b4V+ZZfKxP7lMAT/4L7JAP5K6wdVX5xzQAFqSzdJfWbOT9xPKU9e
         fFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970482; x=1732575282;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TkdfKR0RxAasZPeEtuzLUXU2avDKikbT7HP7un2dUo=;
        b=R8uSWk7ukL8XRKajY3128KUo9z65Tz2bgPv+7MyBOoQVgDCdxwEBonVHcyfoehUhrY
         EE11Ry5q+uVWyKDpW6i5vzu+hqLsQxizp9Jfs9vgVtcr/02eUUCs4RQvuawLruDFUaxE
         FuKhUg9/obZjk9GUzQVchXXJ1S0T6lEzwNiAHxaSUL9khgE2wDWRSIlkqpk+51NtTiWd
         RphmwBK49mFj+HwoYqKnR4PC2L/du7QI/9qq5CEircadjwcZWDb4KV3YguKlAq6ICNId
         /4+2ig7LaXKIXbEAyS7w/1qx83oO6PW/8GldnWRt5foYir/tRBhp7hL8LwgKjmsbpZWP
         yVnA==
X-Forwarded-Encrypted: i=1; AJvYcCVBPvhQ/Jb/CuA+TfxRJFmXhSJqtswpfpA7XDLrgZ6nW6MnnLY07WJ828maycdkw6XaUiQoi/46RKdrTQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHySGW+/enSrAtsqx8e76O028ON8zosrncGncgSjylI1WPWrh
	wkiZcq8e2sOaaALw3lHGUqNjex+JUgtbGXYTV8d4myh/x8gwzFYZgJM43OQCUcghfhydR1lpWy5
	qftfPEw==
X-Google-Smtp-Source: AGHT+IGMI+SDlmNkfxJrIzlOTnDXSAFa6oFdQqPI8mWkiZCCyyKWgJveun+tJonhhJcLxWOhRjo32pBPUuYU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:6585:b0:6e2:371f:4aef with SMTP
 id 00721157ae682-6ee55c95c78mr1282607b3.3.1731970481857; Mon, 18 Nov 2024
 14:54:41 -0800 (PST)
Date: Mon, 18 Nov 2024 14:53:44 -0800
In-Reply-To: <20241118225345.889810-1-irogers@google.com>
Message-Id: <20241118225345.889810-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118225345.889810-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 6/7] perf evsel: Allow evsel__newtp without libtraceevent
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
index 4759d644a5aa..6cffba96477e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -544,54 +544,101 @@ struct evsel *evsel__clone(struct evsel *orig)
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
@@ -1588,6 +1635,10 @@ void evsel__exit(struct evsel *evsel)
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
2.47.0.338.g60cca15819-goog


