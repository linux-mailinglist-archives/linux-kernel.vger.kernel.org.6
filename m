Return-Path: <linux-kernel+bounces-413667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5DF9D1D14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40317B222F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FA333998;
	Tue, 19 Nov 2024 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOEjkkXn"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9EF839F4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979031; cv=none; b=YELPCj+ivOE0rSPXjB5SawUlBLyZc3Y6r4kgqJy0VKCJxhnPb5rQxF9qd/0jvCJQOj+B0cLTD7fYvX1K76c/OxmHJd0ey9lytQtlQT70+W2BIZzGar73w9IdRdO1X3Vz4DZoV+3eNd5pnnq92MisBkjlZK3yOfgMUZWr+pKMcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979031; c=relaxed/simple;
	bh=XkHI5vkt+p0utWgVFkj1bE6/MPtZ1e5+uRY99mTndWo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=cH6YcvYoMEnh8ISQjMpUuleqG+8N+kaHYHQG+ezHaC9x6+zkbnoRxhkDLYB7oVChKjyW6AFdvdU6O+WV6VIjOmceSaya4tHD++8CVCPAmDA+k5JNb6jL/gQlVCmVe/NIPl/hq0HRlV62GZ9mZysAp9N83+zZMysRaffWO0ZJJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOEjkkXn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3826e5c0c0so763344276.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979028; x=1732583828; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c715NU8W48BvJWXkpfehEr5nm+el313VPIVccpZyvRA=;
        b=UOEjkkXn4qWdRJZBplkqxtxmwf/qOy63zp2LNjdpw1yfC98Syh+2N+qbbs3TK1SNyp
         jN9LBMijPUW2zzy3U4KdkLGuw3yyE+g1BPh8Rugsl98eYIJ7cVf7Q9/E9c9854QRSZfC
         3ifbd5k8xB/+wMdtYXTGz0Izdw46qgvD15rkhyj9jLI1lADaMCJiEQxXE91jpWwnDc3a
         zRvsOjLJ819OTt67A/nSefPCNgMHdoOozW9UVG9KQx0qOb6T22hoxbvtGAdiMGRG8m2z
         7P/D5zlB29/pZXK+VxjSWqtbtj+wDp4oKQzHpbhU586d1lKNANMLIIOpQ4v8a8gDVjSX
         9zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979028; x=1732583828;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c715NU8W48BvJWXkpfehEr5nm+el313VPIVccpZyvRA=;
        b=Y6+c7lfcF8Urs8BKF7GByFI9DuX9fIS5mw5vOBXNeedxf5eioCoKJj7m5CnXBPMBT7
         Drhy0bWy6RWeWjX9JWFFlQgLP+ZA1tx2ZNgiikgoovYJyY2UhjNlFu2RgICmtzldm4jO
         fq0NDZP0fLoldr7Fi1k+OWsUKOS1GPz9GfoO+g88xTnISAyY4uFSG4AIz0Prp33MdOgD
         a1yNZPa8jRdSvo5B9u14E7cHGKlzmfZbH4euyB/4vc2/yGiUXntHvz9G5YefZ5UZ8N6M
         F90BeSznUZTE4eMgkEYrqsJk8RTWy1zh4UE5wOHjfqdWwQb8C/8NzUe8fg9IOnSXGy6R
         +B8g==
X-Forwarded-Encrypted: i=1; AJvYcCWpo2PL1eWSH6FzEG2W66KxxWHeOzUCEvLa3qSRc5UL1uts9M5+9WrLkihe2Yy5+mz4Uw+llsbAth/237k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPqXzEsqQwDGrRpwwgQirugwV6o+n/ly37Ags2UItrnf+M8Jcz
	aObL5r/OeCtwRHQRaTqN08Ll0X28NfIW1H+h7JTSLrO1Jiw6EaLCz5gY168Zz7GvGFleCPwUv2L
	Dy7Ty6A==
X-Google-Smtp-Source: AGHT+IGaTeSVsjLRPzmVL0dXDXl9jkDBCCuHJQ6ccoYtwMoM7COuqWxF+pdfj2SUmTUVYrTqwGlJzEz2ZRuM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:ef0e:0:b0:e28:f231:1aa8 with SMTP id
 3f1490d57ef6-e3825d14d07mr148005276.2.1731979027876; Mon, 18 Nov 2024
 17:17:07 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:24 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 02/22] perf python: Constify variables and parameters
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Opportunistically constify variables and parameters when possible.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 55 +++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ea6dbe6e4317..e04c05612830 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -63,7 +63,7 @@ struct pyrf_event {
 	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
 	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
 
-static char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
+static const char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
 
 static PyMemberDef pyrf_mmap_event__members[] = {
 	sample_members
@@ -78,7 +78,7 @@ static PyMemberDef pyrf_mmap_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_mmap_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -107,7 +107,7 @@ static PyTypeObject pyrf_mmap_event__type = {
 	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
 };
 
-static char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
+static const char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
 
 static PyMemberDef pyrf_task_event__members[] = {
 	sample_members
@@ -120,7 +120,7 @@ static PyMemberDef pyrf_task_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_task_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
 				   "ptid: %u, time: %" PRI_lu64 "}",
@@ -142,7 +142,7 @@ static PyTypeObject pyrf_task_event__type = {
 	.tp_repr	= (reprfunc)pyrf_task_event__repr,
 };
 
-static char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
+static const char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
 
 static PyMemberDef pyrf_comm_event__members[] = {
 	sample_members
@@ -153,7 +153,7 @@ static PyMemberDef pyrf_comm_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_comm_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_comm_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
 				   pevent->event.comm.pid,
@@ -171,7 +171,7 @@ static PyTypeObject pyrf_comm_event__type = {
 	.tp_repr	= (reprfunc)pyrf_comm_event__repr,
 };
 
-static char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
+static const char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
 
 static PyMemberDef pyrf_throttle_event__members[] = {
 	sample_members
@@ -182,9 +182,10 @@ static PyMemberDef pyrf_throttle_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_throttle_event__repr(const struct pyrf_event *pevent)
 {
-	struct perf_record_throttle *te = (struct perf_record_throttle *)(&pevent->event.header + 1);
+	const struct perf_record_throttle *te = (const struct perf_record_throttle *)
+		(&pevent->event.header + 1);
 
 	return PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
 				   ", stream_id: %" PRI_lu64 " }",
@@ -202,7 +203,7 @@ static PyTypeObject pyrf_throttle_event__type = {
 	.tp_repr	= (reprfunc)pyrf_throttle_event__repr,
 };
 
-static char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
+static const char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
 
 static PyMemberDef pyrf_lost_event__members[] = {
 	sample_members
@@ -211,7 +212,7 @@ static PyMemberDef pyrf_lost_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_lost_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -237,7 +238,7 @@ static PyTypeObject pyrf_lost_event__type = {
 	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
 };
 
-static char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
+static const char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
 
 static PyMemberDef pyrf_read_event__members[] = {
 	sample_members
@@ -246,7 +247,7 @@ static PyMemberDef pyrf_read_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_read_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_read_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
 				   pevent->event.read.pid,
@@ -267,7 +268,7 @@ static PyTypeObject pyrf_read_event__type = {
 	.tp_repr	= (reprfunc)pyrf_read_event__repr,
 };
 
-static char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
+static const char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
 
 static PyMemberDef pyrf_sample_event__members[] = {
 	sample_members
@@ -275,7 +276,7 @@ static PyMemberDef pyrf_sample_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -290,13 +291,13 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
 }
 
 #ifdef HAVE_LIBTRACEEVENT
-static bool is_tracepoint(struct pyrf_event *pevent)
+static bool is_tracepoint(const struct pyrf_event *pevent)
 {
 	return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
 }
 
 static PyObject*
-tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
+tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
 {
 	struct tep_handle *pevent = field->event->tep;
 	void *data = pe->sample.raw_data;
@@ -385,7 +386,7 @@ static PyTypeObject pyrf_sample_event__type = {
 	.tp_getattro	= (getattrofunc) pyrf_sample_event__getattro,
 };
 
-static char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
+static const char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
 
 static PyMemberDef pyrf_context_switch_event__members[] = {
 	sample_members
@@ -395,7 +396,7 @@ static PyMemberDef pyrf_context_switch_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_context_switch_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_context_switch_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -475,7 +476,7 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
 };
 
-static PyObject *pyrf_event__new(union perf_event *event)
+static PyObject *pyrf_event__new(const union perf_event *event)
 {
 	struct pyrf_event *pevent;
 	PyTypeObject *ptype;
@@ -543,7 +544,7 @@ static PySequenceMethods pyrf_cpu_map__sequence_methods = {
 	.sq_item   = pyrf_cpu_map__item,
 };
 
-static char pyrf_cpu_map__doc[] = PyDoc_STR("cpu map object.");
+static const char pyrf_cpu_map__doc[] = PyDoc_STR("cpu map object.");
 
 static PyTypeObject pyrf_cpu_map__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -612,7 +613,7 @@ static PySequenceMethods pyrf_thread_map__sequence_methods = {
 	.sq_item   = pyrf_thread_map__item,
 };
 
-static char pyrf_thread_map__doc[] = PyDoc_STR("thread map object.");
+static const char pyrf_thread_map__doc[] = PyDoc_STR("thread map object.");
 
 static PyTypeObject pyrf_thread_map__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -796,7 +797,7 @@ static PyMethodDef pyrf_evsel__methods[] = {
 	{ .ml_name = NULL, }
 };
 
-static char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
+static const char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
 
 static PyTypeObject pyrf_evsel__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -1079,7 +1080,7 @@ static PySequenceMethods pyrf_evlist__sequence_methods = {
 	.sq_item   = pyrf_evlist__item,
 };
 
-static char pyrf_evlist__doc[] = PyDoc_STR("perf event selector list object.");
+static const char pyrf_evlist__doc[] = PyDoc_STR("perf event selector list object.");
 
 static PyTypeObject pyrf_evlist__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -1101,10 +1102,12 @@ static int pyrf_evlist__setup_types(void)
 
 #define PERF_CONST(name) { #name, PERF_##name }
 
-static struct {
+struct perf_constant {
 	const char *name;
 	int	    value;
-} perf__constants[] = {
+};
+
+static const struct perf_constant perf__constants[] = {
 	PERF_CONST(TYPE_HARDWARE),
 	PERF_CONST(TYPE_SOFTWARE),
 	PERF_CONST(TYPE_TRACEPOINT),
-- 
2.47.0.338.g60cca15819-goog


