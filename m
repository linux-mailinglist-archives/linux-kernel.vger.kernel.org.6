Return-Path: <linux-kernel+bounces-393203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6015D9B9D97
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 08:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B07283FDF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF0B14B965;
	Sat,  2 Nov 2024 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KSVdHIs6"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BB166F26
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730532185; cv=none; b=ML6PvH5fmYf/nnl7nt7HSkQm3NCCVd4LZN/CiWqZxZdhNX5XtP2q69jAaDBfbh5IlKtGKexW/3M6HNK/Mb4DP6p02uWrvRp6A2iG07soAoZKXKmmR5YPwTSvrPiqhF8vCXTwAADKzO9Q0jMs2nA+wT7nOYJg3I6AY/GnBI2qQ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730532185; c=relaxed/simple;
	bh=p7JbZtY359sIwsP6/30E7FGfNcIiIa5lbTt91oXbRrA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XrHrcL9n+Lm94EiNyFTZ+C97jdhi5Oys829XyAyxwuRAn/IoEGZHxGZrqUFKuaSLkNoFB6+QjSPH/c1GbYKS1Aa6mAxSL/QXAGm7Leb1bcbUczO2CXDphu4A98etNxXpxi0VlR46vGJqmrFPuuKTapbp2piDpSxrEi5ohuv54JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KSVdHIs6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35bdb6a31so50652457b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 00:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730532183; x=1731136983; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRBQ2ML6N/YG88KmO13bVL/2Y2EfcM0lDZcGBfBGi9k=;
        b=KSVdHIs6C4eEJltLGDln1a/bjH8TWQX8S3sUlw/IgtQP5Fvv6GVGkGEH+e01qfl/ST
         k2ld7GhelUnVC0xbnPEsvyWnUi35tzq0lxvec9rBIqg/LQg3NC317DgvydI8v/0ToK4H
         RKG9cg1eNdnakD3d79wDavXeLueEyaiLKe6IRekaOqguLSdF2iZDAhvHvDIrYhW1GQYP
         S8Nfp9u7CDMO97F35yOyl2Re6QMZI52xUcwdx9/XjC/EXm1ca7+0Z2RVfu+bo7/A/AWZ
         XfZhSa8uzHVcd9WHmG0wA0m4IsTyLbrpiUalsPzr6LjRS+QqQCjnvv853PCHeqs2Pp7P
         G86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730532183; x=1731136983;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRBQ2ML6N/YG88KmO13bVL/2Y2EfcM0lDZcGBfBGi9k=;
        b=oCboT+WrHYzZewp8zAZMhlKZVP5TJ4ZEmEU8OuPWIPXJAA8NpFCIhZO6vAkQsB0jkT
         7e2159yWWcMjPmCBZGdhlIpyA2qkfy4ZWyXIPKaBvjuH+K/ODW3hu8TCpph5iLLtDgeo
         hv4QGlt+K7NBHzSQDeJwU43mTZ5ctxe6Pz+zw1xTNbawoE0gKoWTxlItEZvydZEye0Ki
         aaHk7XJbWD5X5g6Enzi7BBiwEVNXuFaTyNFfYXgon2uW7ULkQsl3dii8I6nMTlK8uAig
         bAO1U0iQt9u+HX+YV7Zk5fwfaj52zSoT9hMcXKMDvRsbifWJF3bCXQeK2O4Rmmw702Qq
         El4g==
X-Forwarded-Encrypted: i=1; AJvYcCWOr5FvE8BowbUgwWC7/7tvY/NEul4x0mwLXJ7ULGOaTWvTfHs53IXZWzspFCt5rVMsxQps/zdEjHX4gEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDNSAu5i428T9ANw7dIoEqW3g7bg3TSoVcjLkxCn8OjCxp3Kia
	tno9ZMtsVRCCth9EXX+5sBLLL5LEPNNpA9KbsSUSYxtfJDEipFVEdaas9Vlt4gPqpGtw50y4+oi
	72hOWrA==
X-Google-Smtp-Source: AGHT+IHZ7z2HGzkFH5D86agOkKNcaEYmRPTby7MJdObVLpuuar6XVPSl5ANL1bYcXD8g/E0GqgbyATgHxlcV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a05:690c:802:b0:6ea:1f5b:1f5e with SMTP id
 00721157ae682-6ea52518ac3mr150457b3.4.1730532182714; Sat, 02 Nov 2024
 00:23:02 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:22:46 -0700
In-Reply-To: <20241102072248.12836-1-irogers@google.com>
Message-Id: <20241102072248.12836-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102072248.12836-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 4/6] perf evsel: Add/use accessor for tp_format
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

Add an accessor function for tp_format. Rather than search+replace
uses try to use a variable and reuse it. Add additional NULL checks
when accessing/using the value. Make sure the PTR_ERR is nulled out on
error path in evsel__newtp_idx.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c                     | 15 ++--
 tools/perf/builtin-kwork.c                    |  3 +-
 tools/perf/builtin-script.c                   |  9 ++-
 tools/perf/builtin-trace.c                    | 80 +++++++++++++------
 tools/perf/util/data-convert-bt.c             | 10 ++-
 tools/perf/util/data-convert-json.c           |  8 +-
 tools/perf/util/evsel.c                       |  9 ++-
 tools/perf/util/evsel.h                       |  5 ++
 tools/perf/util/evsel_fprintf.c               |  4 +-
 .../util/scripting-engines/trace-event-perl.c |  3 +-
 .../scripting-engines/trace-event-python.c    |  3 +-
 tools/perf/util/sort.c                        | 33 +++++---
 tools/perf/util/trace-event-scripting.c       | 10 ++-
 13 files changed, 131 insertions(+), 61 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index a756147e2eec..8d9477d3f52b 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -761,6 +761,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 	};
 	struct trace_seq seq;
 	char *str, *pos = NULL;
+	const struct tep_event *tp_format;
 
 	if (nr_gfps) {
 		struct gfp_flag key = {
@@ -772,8 +773,9 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 	}
 
 	trace_seq_init(&seq);
-	tep_print_event(evsel->tp_format->tep,
-			&seq, &record, "%s", TEP_PRINT_INFO);
+	tp_format = evsel__tp_format(evsel);
+	if (tp_format)
+		tep_print_event(tp_format->tep, &seq, &record, "%s", TEP_PRINT_INFO);
 
 	str = strtok_r(seq.buffer, " ", &pos);
 	while (str) {
@@ -2011,14 +2013,15 @@ int cmd_kmem(int argc, const char **argv)
 	}
 
 	if (kmem_page) {
-		struct evsel *evsel = evlist__find_tracepoint_by_name(session->evlist, "kmem:mm_page_alloc");
+		struct evsel *evsel = evlist__find_tracepoint_by_name(session->evlist,
+								      "kmem:mm_page_alloc");
+		const struct tep_event *tp_format = evsel ? evsel__tp_format(evsel) : NULL;
 
-		if (evsel == NULL) {
+		if (tp_format == NULL) {
 			pr_err(errmsg, "page", "page");
 			goto out_delete;
 		}
-
-		kmem_page_size = tep_get_page_size(evsel->tp_format->tep);
+		kmem_page_size = tep_get_page_size(tp_format->tep);
 		symbol_conf.use_callchain = true;
 	}
 
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index c1daf82c9b92..8834e642c4ba 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1103,7 +1103,8 @@ static char *evsel__softirq_name(struct evsel *evsel, u64 num)
 	char *name = NULL;
 	bool found = false;
 	struct tep_print_flag_sym *sym = NULL;
-	struct tep_print_arg *args = evsel->tp_format->print_fmt.args;
+	const struct tep_event *tp_format = evsel__tp_format(evsel);
+	struct tep_print_arg *args = tp_format ? evsel__tp_format(evsel)->print_fmt.args : NULL;
 
 	if ((args == NULL) || (args->next == NULL))
 		return NULL;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6b6d4472db6e..0acdb98314f8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2289,8 +2289,13 @@ static void process_event(struct perf_script *script,
 	}
 #ifdef HAVE_LIBTRACEEVENT
 	if (PRINT_FIELD(TRACE) && sample->raw_data) {
-		event_format__fprintf(evsel->tp_format, sample->cpu,
-				      sample->raw_data, sample->raw_size, fp);
+		const struct tep_event *tp_format = evsel__tp_format(evsel);
+
+		if (tp_format) {
+			event_format__fprintf(tp_format, sample->cpu,
+					      sample->raw_data, sample->raw_size,
+					      fp);
+		}
 	}
 #endif
 	if (attr->type == PERF_TYPE_SYNTH && PRINT_FIELD(SYNTH))
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 748b061f8678..86f159f25169 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -389,7 +389,12 @@ static struct syscall_arg_fmt *evsel__syscall_arg_fmt(struct evsel *evsel)
 	}
 
 	if (et->fmt == NULL) {
-		et->fmt = calloc(evsel->tp_format->format.nr_fields, sizeof(struct syscall_arg_fmt));
+		const struct tep_event *tp_format = evsel__tp_format(evsel);
+
+		if (tp_format == NULL)
+			goto out_delete;
+
+		et->fmt = calloc(tp_format->format.nr_fields, sizeof(struct syscall_arg_fmt));
 		if (et->fmt == NULL)
 			goto out_delete;
 	}
@@ -2154,8 +2159,12 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel, bool *use_btf)
 	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
 	if (fmt != NULL) {
-		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, use_btf);
-		return 0;
+		const struct tep_event *tp_format = evsel__tp_format(evsel);
+
+		if (tp_format) {
+			syscall_arg_fmt__init_array(fmt, tp_format->format.fields, use_btf);
+			return 0;
+		}
 	}
 
 	return -ENOMEM;
@@ -3026,7 +3035,8 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 {
 	char bf[2048];
 	size_t size = sizeof(bf);
-	struct tep_format_field *field = evsel->tp_format->format.fields;
+	const struct tep_event *tp_format = evsel__tp_format(evsel);
+	struct tep_format_field *field = tp_format ? tp_format->format.fields : NULL;
 	struct syscall_arg_fmt *arg = __evsel__syscall_arg_fmt(evsel);
 	size_t printed = 0, btf_printed;
 	unsigned long val;
@@ -3096,6 +3106,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 {
 	struct thread *thread;
 	int callchain_ret = 0;
+
 	/*
 	 * Check if we called perf_evsel__disable(evsel) due to, for instance,
 	 * this event's max_events having been hit and this is an entry coming
@@ -3149,11 +3160,13 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 	if (evsel__is_bpf_output(evsel)) {
 		bpf_output__fprintf(trace, sample);
-	} else if (evsel->tp_format) {
-		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
-		    trace__fprintf_sys_enter(trace, evsel, sample)) {
+	} else {
+		const struct tep_event *tp_format = evsel__tp_format(evsel);
+
+		if (tp_format && (strncmp(tp_format->name, "sys_enter_", 10) ||
+				  trace__fprintf_sys_enter(trace, evsel, sample))) {
 			if (trace->libtraceevent_print) {
-				event_format__fprintf(evsel->tp_format, sample->cpu,
+				event_format__fprintf(tp_format, sample->cpu,
 						      sample->raw_data, sample->raw_size,
 						      trace->output);
 			} else {
@@ -4081,17 +4094,23 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel *evsel, char *arg,
 								   char **type)
 {
-	struct tep_format_field *field;
+	const struct tep_format_field *field;
 	struct syscall_arg_fmt *fmt = __evsel__syscall_arg_fmt(evsel);
+	const struct tep_event *tp_format;
+
+	if (!fmt)
+		return NULL;
 
-	if (evsel->tp_format == NULL || fmt == NULL)
+	tp_format = evsel__tp_format(evsel);
+	if (!tp_format)
 		return NULL;
 
-	for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
+	for (field = tp_format->format.fields; field; field = field->next, ++fmt) {
 		if (strcmp(field->name, arg) == 0) {
 			*type = field->type;
 			return fmt;
 		}
+	}
 
 	return NULL;
 }
@@ -4844,13 +4863,18 @@ static void evsel__set_syscall_arg_fmt(struct evsel *evsel, const char *name)
 		const struct syscall_fmt *scfmt = syscall_fmt__find(name);
 
 		if (scfmt) {
-			int skip = 0;
+			const struct tep_event *tp_format = evsel__tp_format(evsel);
+
+			if (tp_format) {
+				int skip = 0;
 
-			if (strcmp(evsel->tp_format->format.fields->name, "__syscall_nr") == 0 ||
-			    strcmp(evsel->tp_format->format.fields->name, "nr") == 0)
-				++skip;
+				if (strcmp(tp_format->format.fields->name, "__syscall_nr") == 0 ||
+				    strcmp(tp_format->format.fields->name, "nr") == 0)
+					++skip;
 
-			memcpy(fmt + skip, scfmt->arg, (evsel->tp_format->format.nr_fields - skip) * sizeof(*fmt));
+				memcpy(fmt + skip, scfmt->arg,
+				       (tp_format->format.nr_fields - skip) * sizeof(*fmt));
+			}
 		}
 	}
 }
@@ -4860,10 +4884,16 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist, bool *use_btf)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->priv || !evsel->tp_format)
+		const struct tep_event *tp_format;
+
+		if (evsel->priv)
+			continue;
+
+		tp_format = evsel__tp_format(evsel);
+		if (!tp_format)
 			continue;
 
-		if (strcmp(evsel->tp_format->system, "syscalls")) {
+		if (strcmp(tp_format->system, "syscalls")) {
 			evsel__init_tp_arg_scnprintf(evsel, use_btf);
 			continue;
 		}
@@ -4871,20 +4901,24 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist, bool *use_btf)
 		if (evsel__init_syscall_tp(evsel))
 			return -1;
 
-		if (!strncmp(evsel->tp_format->name, "sys_enter_", 10)) {
+		if (!strncmp(tp_format->name, "sys_enter_", 10)) {
 			struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 			if (__tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64)))
 				return -1;
 
-			evsel__set_syscall_arg_fmt(evsel, evsel->tp_format->name + sizeof("sys_enter_") - 1);
-		} else if (!strncmp(evsel->tp_format->name, "sys_exit_", 9)) {
+			evsel__set_syscall_arg_fmt(evsel,
+						   tp_format->name + sizeof("sys_enter_") - 1);
+		} else if (!strncmp(tp_format->name, "sys_exit_", 9)) {
 			struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
-			if (__tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap))
+			if (__tp_field__init_uint(&sc->ret, sizeof(u64),
+						  sc->id.offset + sizeof(u64),
+						  evsel->needs_swap))
 				return -1;
 
-			evsel__set_syscall_arg_fmt(evsel, evsel->tp_format->name + sizeof("sys_exit_") - 1);
+			evsel__set_syscall_arg_fmt(evsel,
+						   tp_format->name + sizeof("sys_exit_") - 1);
 		}
 	}
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 021e9b1d5cc5..d022d3c2955e 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -426,8 +426,9 @@ static int add_tracepoint_values(struct ctf_writer *cw,
 				 struct evsel *evsel,
 				 struct perf_sample *sample)
 {
-	struct tep_format_field *common_fields = evsel->tp_format->format.common_fields;
-	struct tep_format_field *fields        = evsel->tp_format->format.fields;
+	const struct tep_event *tp_format = evsel__tp_format(evsel);
+	struct tep_format_field *common_fields = tp_format->format.common_fields;
+	struct tep_format_field *fields        = tp_format->format.fields;
 	int ret;
 
 	ret = add_tracepoint_fields_values(cw, event_class, event,
@@ -1064,8 +1065,9 @@ static int add_tracepoint_types(struct ctf_writer *cw,
 				struct evsel *evsel,
 				struct bt_ctf_event_class *class)
 {
-	struct tep_format_field *common_fields = evsel->tp_format->format.common_fields;
-	struct tep_format_field *fields        = evsel->tp_format->format.fields;
+	const struct tep_event *tp_format = evsel__tp_format(evsel);
+	struct tep_format_field *common_fields = tp_format ? tp_format->format.common_fields : NULL;
+	struct tep_format_field *fields        = tp_format ? tp_format->format.fields : NULL;
 	int ret;
 
 	ret = add_tracepoint_fields_types(cw, common_fields, class);
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 20bfb0884e9e..eb068f38ca81 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -230,12 +230,12 @@ static int process_sample_event(const struct perf_tool *tool,
 
 #ifdef HAVE_LIBTRACEEVENT
 	if (sample->raw_data) {
-		int i;
-		struct tep_format_field **fields;
+		struct tep_event *tp_format = evsel__tp_format(evsel);
+		struct tep_format_field **fields = tp_format ? tep_event_fields(tp_format) : NULL;
 
-		fields = tep_event_fields(evsel->tp_format);
 		if (fields) {
-			i = 0;
+			int i = 0;
+
 			while (fields[i]) {
 				struct trace_seq s;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f780e30aa259..a95db7e900d5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -570,6 +570,7 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx, bool
 			evsel->tp_format = trace_event__tp_format(sys, name);
 			if (IS_ERR(evsel->tp_format)) {
 				err = PTR_ERR(evsel->tp_format);
+				evsel->tp_format = NULL;
 				goto out_free;
 			}
 			attr.config = evsel->tp_format->id;
@@ -3209,12 +3210,16 @@ u16 evsel__id_hdr_size(const struct evsel *evsel)
 #ifdef HAVE_LIBTRACEEVENT
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name)
 {
-	return tep_find_field(evsel->tp_format, name);
+	struct tep_event *tp_format = evsel__tp_format(evsel);
+
+	return tp_format ? tep_find_field(tp_format, name) : NULL;
 }
 
 struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *name)
 {
-	return tep_find_common_field(evsel->tp_format, name);
+	struct tep_event *tp_format = evsel__tp_format(evsel);
+
+	return tp_format ? tep_find_common_field(tp_format, name) : NULL;
 }
 
 void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 04934a7af174..c3e53d320bf5 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -257,6 +257,11 @@ static inline struct evsel *evsel__newtp(const char *sys, const char *name)
 {
 	return evsel__newtp_idx(sys, name, 0, true);
 }
+
+static inline struct tep_event *evsel__tp_format(struct evsel *evsel)
+{
+	return evsel->tp_format;
+}
 #endif
 
 #ifdef HAVE_LIBTRACEEVENT
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index c2c0500d5da9..54c5702f8c00 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -81,13 +81,15 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
 #ifdef HAVE_LIBTRACEEVENT
 	if (details->trace_fields) {
 		struct tep_format_field *field;
+		const struct tep_event *tp_format;
 
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT) {
 			printed += comma_fprintf(fp, &first, " (not a tracepoint)");
 			goto out;
 		}
 
-		field = evsel->tp_format->format.fields;
+		tp_format = evsel__tp_format(evsel);
+		field = tp_format ? tp_format->format.fields : NULL;
 		if (field == NULL) {
 			printed += comma_fprintf(fp, &first, " (no trace field)");
 			goto out;
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index e16257d5ab2c..0d63b77b5140 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -344,7 +344,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 				    struct addr_location *al)
 {
 	struct thread *thread = al->thread;
-	struct tep_event *event = evsel->tp_format;
+	struct tep_event *event;
 	struct tep_format_field *field;
 	static char handler[256];
 	unsigned long long val;
@@ -362,6 +362,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
 	if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 		return;
 
+	event = evsel__tp_format(evsel);
 	if (!event) {
 		pr_debug("ug! no event found for type %" PRIu64, (u64)evsel->core.attr.config);
 		return;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d7183134b669..77f1ab2d3eac 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -946,7 +946,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 				      struct addr_location *al,
 				      struct addr_location *addr_al)
 {
-	struct tep_event *event = evsel->tp_format;
+	struct tep_event *event;
 	PyObject *handler, *context, *t, *obj = NULL, *callchain;
 	PyObject *dict = NULL, *all_entries_dict = NULL;
 	static char handler_name[256];
@@ -963,6 +963,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
 
 	bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
 
+	event = evsel__tp_format(evsel);
 	if (!event) {
 		snprintf(handler_name, sizeof(handler_name),
 			 "ug! no event found for type %" PRIu64, (u64)evsel->core.attr.config);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 168c488f0178..710839ec3f99 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1038,17 +1038,19 @@ static char *get_trace_output(struct hist_entry *he)
 		.data = he->raw_data,
 		.size = he->raw_size,
 	};
+	struct tep_event *tp_format;
 
 	evsel = hists_to_evsel(he->hists);
 
 	trace_seq_init(&seq);
-	if (symbol_conf.raw_trace) {
-		tep_print_fields(&seq, he->raw_data, he->raw_size,
-				 evsel->tp_format);
-	} else {
-		tep_print_event(evsel->tp_format->tep,
-				&seq, &rec, "%s", TEP_PRINT_INFO);
+	tp_format = evsel__tp_format(evsel);
+	if (tp_format) {
+		if (symbol_conf.raw_trace)
+			tep_print_fields(&seq, he->raw_data, he->raw_size, tp_format);
+		else
+			tep_print_event(tp_format->tep, &seq, &rec, "%s", TEP_PRINT_INFO);
 	}
+
 	/*
 	 * Trim the buffer, it starts at 4KB and we're not going to
 	 * add anything more to this buffer.
@@ -3293,9 +3295,8 @@ static int __dynamic_dimension__add(struct evsel *evsel,
 static int add_evsel_fields(struct evsel *evsel, bool raw_trace, int level)
 {
 	int ret;
-	struct tep_format_field *field;
-
-	field = evsel->tp_format->format.fields;
+	struct tep_event *tp_format = evsel__tp_format(evsel);
+	struct tep_format_field *field = tp_format ? tp_format->format.fields : NULL;
 	while (field) {
 		ret = __dynamic_dimension__add(evsel, field, raw_trace, level);
 		if (ret < 0)
@@ -3328,13 +3329,19 @@ static int add_all_matching_fields(struct evlist *evlist,
 {
 	int ret = -ESRCH;
 	struct evsel *evsel;
-	struct tep_format_field *field;
 
 	evlist__for_each_entry(evlist, evsel) {
+		struct tep_event *tp_format;
+		struct tep_format_field *field;
+
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
 
-		field = tep_find_any_field(evsel->tp_format, field_name);
+		tp_format = evsel__tp_format(evsel);
+		if (tp_format == NULL)
+			continue;
+
+		field = tep_find_any_field(tp_format, field_name);
 		if (field == NULL)
 			continue;
 
@@ -3416,7 +3423,9 @@ static int add_dynamic_entry(struct evlist *evlist, const char *tok,
 	if (!strcmp(field_name, "*")) {
 		ret = add_evsel_fields(evsel, raw_trace, level);
 	} else {
-		struct tep_format_field *field = tep_find_any_field(evsel->tp_format, field_name);
+		struct tep_event *tp_format = evsel__tp_format(evsel);
+		struct tep_format_field *field =
+			tp_format ? tep_find_any_field(tp_format, field_name) : NULL;
 
 		if (field == NULL) {
 			pr_debug("Cannot find event field for %s.%s\n",
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index bd0000300c77..bab893587863 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -28,12 +28,14 @@ void scripting_context__update(struct scripting_context *c,
 			       struct addr_location *al,
 			       struct addr_location *addr_al)
 {
-	c->event_data = sample->raw_data;
-	c->pevent = NULL;
 #ifdef HAVE_LIBTRACEEVENT
-	if (evsel->tp_format)
-		c->pevent = evsel->tp_format->tep;
+	const struct tep_event *tp_format = evsel__tp_format(evsel);
+
+	c->pevent = tp_format ? tp_format->tep : NULL;
+#else
+	c->pevent = NULL;
 #endif
+	c->event_data = sample->raw_data;
 	c->event = event;
 	c->sample = sample;
 	c->evsel = evsel;
-- 
2.47.0.199.ga7371fff76-goog


