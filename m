Return-Path: <linux-kernel+bounces-376709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D1B9AB518
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A842B1C23038
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700661BDA9C;
	Tue, 22 Oct 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjFxM0+a"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DEF1BE85C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618254; cv=none; b=H3cRRgPQlxcPNDJl6BvMkCokeMUC97Mx9ehSGL2m3TlEf/+2ZcU24CRoDi2dptaERu1G36TnKE2UmSJVpvEsxOGiPQMLhzHHxfEjXA7Yz7negj9vNLffXG0AC4ueVEhoEBVD+qQbMxiqihEvHjqmIiOzGg8BNCcQhpO21CqqTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618254; c=relaxed/simple;
	bh=06rUym8mEKwnrNebRhLzrvBcLI6yg+52u2nqnHXOz4k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tRkthc6EgXcHkWaqeO4kaXSPZLuFZyoGMUDa0p+YpMGOicU74abwLo2o8S094jjJ1PxMnAY4emXOV2SbmjZ+mwSy8VrRckoxaw5jcQJtEU/gicdwslrVru/5xGRD8O3PlwriyNEtJ96/U2ugzXQnmUMDlZj5zdwJtq4YXpcXTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjFxM0+a; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32e8436adso84542587b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618251; x=1730223051; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xl5YYT6/j2snqAzcSfRTiY37ktA1YE2VwqMAMMgNcVo=;
        b=pjFxM0+a2qLeYZY/aREHB+oVIS+w1/6jZYLvH6crUtqXNKA/vYf74sISEtgN1aHbmY
         hH4kCkC1QKb/vZYnNxvy/jytu2OmV/WF0XeAWcE5O+3Hee0KGOT3qi69gJh/8QlQstYA
         9Dgb/i6sS0mK+v0y6nu0220vxhwzCQwawOVwEgEXe5wS2AS26O0YzVSME2UkAriPPioM
         Y8YxplkLuxhTgXgxPL9RoelagkMpGj7+FQ1z+zNE25dxkXT5YGJrwn04x5zCzqZ8aOV6
         iXvoPg8YGr9UUPY2IvtvPOj5iuw41Rn5z34dh7dnxpEVA8tHz+N9NS4z8Fu0gV2wt8+U
         LRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618251; x=1730223051;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xl5YYT6/j2snqAzcSfRTiY37ktA1YE2VwqMAMMgNcVo=;
        b=dTER+7MNLedqG9zM0Yf/A4WlwdtY8PyrLQVI6K/aW94+nq3eZ2UHNmLDyypvG6E7lC
         uVoykLgbjBmCNh66bZEddfpNtWIHmKYo0qPA2h61MKwO9+hsYI99gXc7S6K1ftkNw0j1
         CElGy8TaFYltLbGdr6GVG6jMnA9vFhRFULhdkjfRcQOBVXdWyt25YEscS7XY+IQUQCmL
         Yg+yR29+BrjfDVvOi/ER5gEprNlv2odI2CHyFqW//ZyBd/IWc0wzLhrkvBY5ej/j1HvR
         rPlAEVqkfhZnw6TY6ym5XN3Uqro6KGnHZkJaNWpadg/C3b41QwD3wTlv8l2PaFlItRP4
         pmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSIuD2ghvkAXuUdUE4JsLqnRQmjps+r+qDTsTMZn6uvbcxguOjVGKTFMokgXtaZ7I1MjNUhfzCoNutGbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhqBSG8tJ2juPvGSvM5aKMi/NMO8NPkAxVP2wqKEyCWlo9G4e
	a585S2Uq4v2dvG1V3CHwQe2PcRc5A19M9UMGoxy2X2NGaR6LtEJbecsFyZZRk2Ct32h7yzA4hd8
	8NT3IqQ==
X-Google-Smtp-Source: AGHT+IHu23lfa777lZDghM4tj+r8X+0qvHQd456fRs1Z7PJFRRiVSqxKSVDvOU44o+EjZAZ1tu3L57z0R9D2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:6902:248b:b0:e2e:2fe8:2d0b with SMTP
 id 3f1490d57ef6-e2e2fe833e0mr6954276.5.1729618251184; Tue, 22 Oct 2024
 10:30:51 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:29:59 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 01/16] perf python: Remove python 2 scripting support
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

Python2 was deprecated 4 years ago, remove support and workarounds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../scripts/python/Perf-Trace-Util/Context.c  | 18 -----
 tools/perf/util/python.c                      | 73 +++----------------
 .../scripting-engines/trace-event-python.c    | 63 +---------------
 3 files changed, 15 insertions(+), 139 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 01f54d6724a5..d742daaa5d5a 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -24,16 +24,6 @@
 #include "../../../util/srcline.h"
 #include "../../../util/srccode.h"
 
-#if PY_MAJOR_VERSION < 3
-#define _PyCapsule_GetPointer(arg1, arg2) \
-  PyCObject_AsVoidPtr(arg1)
-#define _PyBytes_FromStringAndSize(arg1, arg2) \
-  PyString_FromStringAndSize((arg1), (arg2))
-#define _PyUnicode_AsUTF8(arg) \
-  PyString_AsString(arg)
-
-PyMODINIT_FUNC initperf_trace_context(void);
-#else
 #define _PyCapsule_GetPointer(arg1, arg2) \
   PyCapsule_GetPointer((arg1), (arg2))
 #define _PyBytes_FromStringAndSize(arg1, arg2) \
@@ -42,7 +32,6 @@ PyMODINIT_FUNC initperf_trace_context(void);
   PyUnicode_AsUTF8(arg)
 
 PyMODINIT_FUNC PyInit_perf_trace_context(void);
-#endif
 
 static struct scripting_context *get_args(PyObject *args, const char *name, PyObject **arg2)
 {
@@ -213,12 +202,6 @@ static PyMethodDef ContextMethods[] = {
 	{ NULL, NULL, 0, NULL}
 };
 
-#if PY_MAJOR_VERSION < 3
-PyMODINIT_FUNC initperf_trace_context(void)
-{
-	(void) Py_InitModule("perf_trace_context", ContextMethods);
-}
-#else
 PyMODINIT_FUNC PyInit_perf_trace_context(void)
 {
 	static struct PyModuleDef moduledef = {
@@ -240,4 +223,3 @@ PyMODINIT_FUNC PyInit_perf_trace_context(void)
 
 	return mod;
 }
-#endif
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 31a223eaf8e6..02279ab4967c 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -25,40 +25,14 @@
 #include <internal/lib.h>
 #include "../builtin.h"
 
-#if PY_MAJOR_VERSION < 3
-#define _PyUnicode_FromString(arg) \
-  PyString_FromString(arg)
-#define _PyUnicode_AsString(arg) \
-  PyString_AsString(arg)
-#define _PyUnicode_FromFormat(...) \
-  PyString_FromFormat(__VA_ARGS__)
-#define _PyLong_FromLong(arg) \
-  PyInt_FromLong(arg)
-
-#else
-
 #define _PyUnicode_FromString(arg) \
   PyUnicode_FromString(arg)
 #define _PyUnicode_FromFormat(...) \
   PyUnicode_FromFormat(__VA_ARGS__)
 #define _PyLong_FromLong(arg) \
   PyLong_FromLong(arg)
-#endif
 
-#ifndef Py_TYPE
-#define Py_TYPE(ob) (((PyObject*)(ob))->ob_type)
-#endif
-
-/* Define PyVarObject_HEAD_INIT for python 2.5 */
-#ifndef PyVarObject_HEAD_INIT
-# define PyVarObject_HEAD_INIT(type, size) PyObject_HEAD_INIT(type) size,
-#endif
-
-#if PY_MAJOR_VERSION < 3
-PyMODINIT_FUNC initperf(void);
-#else
 PyMODINIT_FUNC PyInit_perf(void);
-#endif
 
 #define member_def(type, member, ptype, help) \
 	{ #member, ptype, \
@@ -116,7 +90,7 @@ static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
 		     pevent->event.mmap.pgoff, pevent->event.mmap.filename) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -147,7 +121,7 @@ static PyMemberDef pyrf_task_event__members[] = {
 
 static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
 {
-	return _PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
+	return PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
 				   "ptid: %u, time: %" PRI_lu64 "}",
 				   pevent->event.header.type == PERF_RECORD_FORK ? "fork" : "exit",
 				   pevent->event.fork.pid,
@@ -180,7 +154,7 @@ static PyMemberDef pyrf_comm_event__members[] = {
 
 static PyObject *pyrf_comm_event__repr(struct pyrf_event *pevent)
 {
-	return _PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
+	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
 				   pevent->event.comm.pid,
 				   pevent->event.comm.tid,
 				   pevent->event.comm.comm);
@@ -211,7 +185,7 @@ static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
 {
 	struct perf_record_throttle *te = (struct perf_record_throttle *)(&pevent->event.header + 1);
 
-	return _PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
+	return PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
 				   ", stream_id: %" PRI_lu64 " }",
 				   pevent->event.header.type == PERF_RECORD_THROTTLE ? "" : "un",
 				   te->time, te->id, te->stream_id);
@@ -246,7 +220,7 @@ static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
 		     pevent->event.lost.id, pevent->event.lost.lost) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -273,7 +247,7 @@ static PyMemberDef pyrf_read_event__members[] = {
 
 static PyObject *pyrf_read_event__repr(struct pyrf_event *pevent)
 {
-	return _PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
+	return PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
 				   pevent->event.read.pid,
 				   pevent->event.read.tid);
 	/*
@@ -308,7 +282,7 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
 	if (asprintf(&s, "{ type: sample }") < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -342,7 +316,7 @@ tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
 		}
 		if (field->flags & TEP_FIELD_IS_STRING &&
 		    is_printable_array(data + offset, len)) {
-			ret = _PyUnicode_FromString((char *)data + offset);
+			ret = PyUnicode_FromString((char *)data + offset);
 		} else {
 			ret = PyByteArray_FromStringAndSize((const char *) data + offset, len);
 			field->flags &= ~TEP_FIELD_IS_STRING;
@@ -431,7 +405,7 @@ static PyObject *pyrf_context_switch_event__repr(struct pyrf_event *pevent)
 		     !!(pevent->event.header.misc & PERF_RECORD_MISC_SWITCH_OUT)) < 0) {
 		ret = PyErr_NoMemory();
 	} else {
-		ret = _PyUnicode_FromString(s);
+		ret = PyUnicode_FromString(s);
 		free(s);
 	}
 	return ret;
@@ -917,17 +891,8 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
 	for (i = 0; i < evlist->core.pollfd.nr; ++i) {
 		PyObject *file;
-#if PY_MAJOR_VERSION < 3
-		FILE *fp = fdopen(evlist->core.pollfd.entries[i].fd, "r");
-
-		if (fp == NULL)
-			goto free_list;
-
-		file = PyFile_FromFile(fp, "perf", "r", NULL);
-#else
 		file = PyFile_FromFd(evlist->core.pollfd.entries[i].fd, "perf", "r", -1,
 				     NULL, NULL, NULL, 0);
-#endif
 		if (file == NULL)
 			goto free_list;
 
@@ -1233,9 +1198,9 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 
 	tp_format = trace_event__tp_format(sys, name);
 	if (IS_ERR(tp_format))
-		return _PyLong_FromLong(-1);
+		return PyLong_FromLong(-1);
 
-	return _PyLong_FromLong(tp_format->id);
+	return PyLong_FromLong(tp_format->id);
 #endif // HAVE_LIBTRACEEVENT
 }
 
@@ -1249,18 +1214,11 @@ static PyMethodDef perf__methods[] = {
 	{ .ml_name = NULL, }
 };
 
-#if PY_MAJOR_VERSION < 3
-PyMODINIT_FUNC initperf(void)
-#else
 PyMODINIT_FUNC PyInit_perf(void)
-#endif
 {
 	PyObject *obj;
 	int i;
 	PyObject *dict;
-#if PY_MAJOR_VERSION < 3
-	PyObject *module = Py_InitModule("perf", perf__methods);
-#else
 	static struct PyModuleDef moduledef = {
 		PyModuleDef_HEAD_INIT,
 		"perf",			/* m_name */
@@ -1273,7 +1231,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 		NULL,			/* m_free */
 	};
 	PyObject *module = PyModule_Create(&moduledef);
-#endif
 
 	if (module == NULL ||
 	    pyrf_event__setup_types() < 0 ||
@@ -1281,11 +1238,7 @@ PyMODINIT_FUNC PyInit_perf(void)
 	    pyrf_evsel__setup_types() < 0 ||
 	    pyrf_thread_map__setup_types() < 0 ||
 	    pyrf_cpu_map__setup_types() < 0)
-#if PY_MAJOR_VERSION < 3
-		return;
-#else
 		return module;
-#endif
 
 	/* The page_size is placed in util object. */
 	page_size = sysconf(_SC_PAGE_SIZE);
@@ -1334,7 +1287,7 @@ PyMODINIT_FUNC PyInit_perf(void)
 		goto error;
 
 	for (i = 0; perf__constants[i].name != NULL; i++) {
-		obj = _PyLong_FromLong(perf__constants[i].value);
+		obj = PyLong_FromLong(perf__constants[i].value);
 		if (obj == NULL)
 			goto error;
 		PyDict_SetItemString(dict, perf__constants[i].name, obj);
@@ -1344,9 +1297,7 @@ PyMODINIT_FUNC PyInit_perf(void)
 error:
 	if (PyErr_Occurred())
 		PyErr_SetString(PyExc_ImportError, "perf: Init failed!");
-#if PY_MAJOR_VERSION >= 3
 	return module;
-#endif
 }
 
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d7183134b669..f1d461d47d73 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -58,22 +58,6 @@
 #include "mem-events.h"
 #include "util/perf_regs.h"
 
-#if PY_MAJOR_VERSION < 3
-#define _PyUnicode_FromString(arg) \
-  PyString_FromString(arg)
-#define _PyUnicode_FromStringAndSize(arg1, arg2) \
-  PyString_FromStringAndSize((arg1), (arg2))
-#define _PyBytes_FromStringAndSize(arg1, arg2) \
-  PyString_FromStringAndSize((arg1), (arg2))
-#define _PyLong_FromLong(arg) \
-  PyInt_FromLong(arg)
-#define _PyLong_AsLong(arg) \
-  PyInt_AsLong(arg)
-#define _PyCapsule_New(arg1, arg2, arg3) \
-  PyCObject_FromVoidPtr((arg1), (arg2))
-
-PyMODINIT_FUNC initperf_trace_context(void);
-#else
 #define _PyUnicode_FromString(arg) \
   PyUnicode_FromString(arg)
 #define _PyUnicode_FromStringAndSize(arg1, arg2) \
@@ -88,7 +72,6 @@ PyMODINIT_FUNC initperf_trace_context(void);
   PyCapsule_New((arg1), (arg2), (arg3))
 
 PyMODINIT_FUNC PyInit_perf_trace_context(void);
-#endif
 
 #ifdef HAVE_LIBTRACEEVENT
 #define TRACE_EVENT_TYPE_MAX				\
@@ -181,17 +164,7 @@ static int get_argument_count(PyObject *handler)
 {
 	int arg_count = 0;
 
-	/*
-	 * The attribute for the code object is func_code in Python 2,
-	 * whereas it is __code__ in Python 3.0+.
-	 */
-	PyObject *code_obj = PyObject_GetAttrString(handler,
-		"func_code");
-	if (PyErr_Occurred()) {
-		PyErr_Clear();
-		code_obj = PyObject_GetAttrString(handler,
-			"__code__");
-	}
+	PyObject *code_obj = code_obj = PyObject_GetAttrString(handler, "__code__");
 	PyErr_Clear();
 	if (code_obj) {
 		PyObject *arg_count_obj = PyObject_GetAttrString(code_obj,
@@ -1899,12 +1872,6 @@ static void set_table_handlers(struct tables *tables)
 	tables->synth_handler = get_handler("synth_data");
 }
 
-#if PY_MAJOR_VERSION < 3
-static void _free_command_line(const char **command_line, int num)
-{
-	free(command_line);
-}
-#else
 static void _free_command_line(wchar_t **command_line, int num)
 {
 	int i;
@@ -1912,7 +1879,6 @@ static void _free_command_line(wchar_t **command_line, int num)
 		PyMem_RawFree(command_line[i]);
 	free(command_line);
 }
-#endif
 
 
 /*
@@ -1922,30 +1888,12 @@ static int python_start_script(const char *script, int argc, const char **argv,
 			       struct perf_session *session)
 {
 	struct tables *tables = &tables_global;
-#if PY_MAJOR_VERSION < 3
-	const char **command_line;
-#else
 	wchar_t **command_line;
-#endif
-	/*
-	 * Use a non-const name variable to cope with python 2.6's
-	 * PyImport_AppendInittab prototype
-	 */
-	char buf[PATH_MAX], name[19] = "perf_trace_context";
+	char buf[PATH_MAX];
 	int i, err = 0;
 	FILE *fp;
 
 	scripting_context->session = session;
-#if PY_MAJOR_VERSION < 3
-	command_line = malloc((argc + 1) * sizeof(const char *));
-	if (!command_line)
-		return -1;
-
-	command_line[0] = script;
-	for (i = 1; i < argc + 1; i++)
-		command_line[i] = argv[i - 1];
-	PyImport_AppendInittab(name, initperf_trace_context);
-#else
 	command_line = malloc((argc + 1) * sizeof(wchar_t *));
 	if (!command_line)
 		return -1;
@@ -1953,15 +1901,10 @@ static int python_start_script(const char *script, int argc, const char **argv,
 	command_line[0] = Py_DecodeLocale(script, NULL);
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
-	PyImport_AppendInittab(name, PyInit_perf_trace_context);
-#endif
+	PyImport_AppendInittab("perf_trace_context", PyInit_perf_trace_context);
 	Py_Initialize();
 
-#if PY_MAJOR_VERSION < 3
-	PySys_SetArgv(argc + 1, (char **)command_line);
-#else
 	PySys_SetArgv(argc + 1, command_line);
-#endif
 
 	fp = fopen(script, "r");
 	if (!fp) {
-- 
2.47.0.163.g1226f6d8fa-goog


