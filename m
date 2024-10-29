Return-Path: <linux-kernel+bounces-387772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B50DA9B55F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28708B221DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F620C006;
	Tue, 29 Oct 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OVLOqlsx"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F020B1EF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241884; cv=none; b=oS9kVbbFMmNpPw35p9yO7GF+igS+OdAz4SSqMHnrP2XfCopQ8T9GCLAXcjlPM0me8hdee2weZg4DVLhqrpIH6A2L2pfrk95MOnQbQu0G3GXjAzBo5mprjmsxgvkHIIEQHnRh3mgZ7KKLwud6NyIZXyJmwsef1wyG1vc5xKEB7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241884; c=relaxed/simple;
	bh=CiUzxYw0RBvkytit97TqdNjM6aeeFRoA/HnhpHqF9To=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=D4eQzq8s6OoS/ErDPdPBVy4aMF0EWob9UANRGqzOqXplu2SJFPX+58/ZRccQHOTRSaYWwHixYucF8DD8kPeVJPEgqB7y7jTdXu614fmBH48nmDxJJ4fgMmwGgIJm8v75Bmr2rJucT2scmiZOEcr6uKXbmcZRaARXacqlpMqFKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OVLOqlsx; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2954ada861so10216186276.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241881; x=1730846681; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H603DVgWa6efETS0jocUXZJdUuhFvKOBL+70ertaUeY=;
        b=OVLOqlsxmegL6Vee/qEZnVPws2Ov9yW7065ekqMGCnhBotHnq5IhQhkjQcVEuBLRfZ
         BXqHu8qQjcrK+D42Zk1uZTMQ3uVYZY+pu6aQBw/o6LYAnemXtJp3GZdwTIi9QQYZMjnO
         mw2DAS8HnKCUx1SZuJ2KdqiSk73WgUYf1b5Ztvw0PdXzFbZojgMp00xYRRUD/tKxctd/
         UxqanWcdBGTSTkxt6Q9cjQQuILsklEro8pyW5iftEpXf0PLUnpxWCBNhGcA7aLGJV1PQ
         I3u9PlTN7FGFWSwLRcyddt/rnMQr9H71MdE6lz/bbQBKnBBEdj3siiAXJSu0WpC2afOy
         7QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241881; x=1730846681;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H603DVgWa6efETS0jocUXZJdUuhFvKOBL+70ertaUeY=;
        b=aeD6MKvtsH8O4Dn8Z1Jr/WeqbcsFvx+dUkhlSYid+XOi6aQDYHZp1y0ifKSr0ULZE7
         Vl+VFSQsAbMObeiT48KP8+IMleQZoAmwM8+VyXTtb1E21M5DwdGjkAJc8sISrqwU3ul5
         SaZEu4d53YwT5jGKsFjRJPB4CHB9kCjy+FOQP9c16S269cUUYG/R6crrOLzzJVYSwS+g
         0hwryTmCIEqncSt5PneMx7VE+skZJj7KVEkd3134npO6Z20HCTg6AIzhlgS1zcxHpunl
         5QlP/DO1d+d9EnH90Z7KPxlp32gIvbVWGM6rz0rvVaGvdHJV9uE0N0+xDv/k7ok4D32E
         06eg==
X-Forwarded-Encrypted: i=1; AJvYcCVzFSqfDQNpbV2cht/lPe7NnroL9eu7dlNo237GpTgr+N9Mc4QsmjFEhOCizoHI9ycYobk2PgkJOvBzdDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXhjS9pKcCaznwhJnu8+RBG2sQ8l/L45Vib8MV4PNjvZBFCDGu
	AK1sNf6bGXJYoNCPwfEPv0gL7mpNGNf0OLd/A6a5xpNbKHKujqgs4TBGl9iuicsMB+ryJVK227p
	VIQKh+w==
X-Google-Smtp-Source: AGHT+IHagm+13IWW2EE3LQN6Gh3ePoggnEOFKoBcoJfbPY7ELsZApNJgOj+3zTWFaULAb7Et6fdw9xd/KVPS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a25:a42a:0:b0:e2e:2b0f:19fc with SMTP id
 3f1490d57ef6-e3087a6b354mr46270276.4.1730241880828; Tue, 29 Oct 2024 15:44:40
 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:14 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 02/19] perf python: Constify variables and parameters
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

Opportunistically constify variables and parameters when possible.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 55 +++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 02279ab4967c..13dad27169a0 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -62,7 +62,7 @@ struct pyrf_event {
 	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
 	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
 
-static char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
+static const char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
 
 static PyMemberDef pyrf_mmap_event__members[] = {
 	sample_members
@@ -77,7 +77,7 @@ static PyMemberDef pyrf_mmap_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_mmap_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -106,7 +106,7 @@ static PyTypeObject pyrf_mmap_event__type = {
 	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
 };
 
-static char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
+static const char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
 
 static PyMemberDef pyrf_task_event__members[] = {
 	sample_members
@@ -119,7 +119,7 @@ static PyMemberDef pyrf_task_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_task_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
 				   "ptid: %u, time: %" PRI_lu64 "}",
@@ -141,7 +141,7 @@ static PyTypeObject pyrf_task_event__type = {
 	.tp_repr	= (reprfunc)pyrf_task_event__repr,
 };
 
-static char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
+static const char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
 
 static PyMemberDef pyrf_comm_event__members[] = {
 	sample_members
@@ -152,7 +152,7 @@ static PyMemberDef pyrf_comm_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_comm_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_comm_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
 				   pevent->event.comm.pid,
@@ -170,7 +170,7 @@ static PyTypeObject pyrf_comm_event__type = {
 	.tp_repr	= (reprfunc)pyrf_comm_event__repr,
 };
 
-static char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
+static const char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
 
 static PyMemberDef pyrf_throttle_event__members[] = {
 	sample_members
@@ -181,9 +181,10 @@ static PyMemberDef pyrf_throttle_event__members[] = {
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
@@ -201,7 +202,7 @@ static PyTypeObject pyrf_throttle_event__type = {
 	.tp_repr	= (reprfunc)pyrf_throttle_event__repr,
 };
 
-static char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
+static const char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
 
 static PyMemberDef pyrf_lost_event__members[] = {
 	sample_members
@@ -210,7 +211,7 @@ static PyMemberDef pyrf_lost_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_lost_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -236,7 +237,7 @@ static PyTypeObject pyrf_lost_event__type = {
 	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
 };
 
-static char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
+static const char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
 
 static PyMemberDef pyrf_read_event__members[] = {
 	sample_members
@@ -245,7 +246,7 @@ static PyMemberDef pyrf_read_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_read_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_read_event__repr(const struct pyrf_event *pevent)
 {
 	return PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
 				   pevent->event.read.pid,
@@ -266,7 +267,7 @@ static PyTypeObject pyrf_read_event__type = {
 	.tp_repr	= (reprfunc)pyrf_read_event__repr,
 };
 
-static char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
+static const char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
 
 static PyMemberDef pyrf_sample_event__members[] = {
 	sample_members
@@ -274,7 +275,7 @@ static PyMemberDef pyrf_sample_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -289,13 +290,13 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
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
@@ -384,7 +385,7 @@ static PyTypeObject pyrf_sample_event__type = {
 	.tp_getattro	= (getattrofunc) pyrf_sample_event__getattro,
 };
 
-static char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
+static const char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
 
 static PyMemberDef pyrf_context_switch_event__members[] = {
 	sample_members
@@ -394,7 +395,7 @@ static PyMemberDef pyrf_context_switch_event__members[] = {
 	{ .name = NULL, },
 };
 
-static PyObject *pyrf_context_switch_event__repr(struct pyrf_event *pevent)
+static PyObject *pyrf_context_switch_event__repr(const struct pyrf_event *pevent)
 {
 	PyObject *ret;
 	char *s;
@@ -474,7 +475,7 @@ static PyTypeObject *pyrf_event__type[] = {
 	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
 };
 
-static PyObject *pyrf_event__new(union perf_event *event)
+static PyObject *pyrf_event__new(const union perf_event *event)
 {
 	struct pyrf_event *pevent;
 	PyTypeObject *ptype;
@@ -542,7 +543,7 @@ static PySequenceMethods pyrf_cpu_map__sequence_methods = {
 	.sq_item   = pyrf_cpu_map__item,
 };
 
-static char pyrf_cpu_map__doc[] = PyDoc_STR("cpu map object.");
+static const char pyrf_cpu_map__doc[] = PyDoc_STR("cpu map object.");
 
 static PyTypeObject pyrf_cpu_map__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -611,7 +612,7 @@ static PySequenceMethods pyrf_thread_map__sequence_methods = {
 	.sq_item   = pyrf_thread_map__item,
 };
 
-static char pyrf_thread_map__doc[] = PyDoc_STR("thread map object.");
+static const char pyrf_thread_map__doc[] = PyDoc_STR("thread map object.");
 
 static PyTypeObject pyrf_thread_map__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -795,7 +796,7 @@ static PyMethodDef pyrf_evsel__methods[] = {
 	{ .ml_name = NULL, }
 };
 
-static char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
+static const char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
 
 static PyTypeObject pyrf_evsel__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -1078,7 +1079,7 @@ static PySequenceMethods pyrf_evlist__sequence_methods = {
 	.sq_item   = pyrf_evlist__item,
 };
 
-static char pyrf_evlist__doc[] = PyDoc_STR("perf event selector list object.");
+static const char pyrf_evlist__doc[] = PyDoc_STR("perf event selector list object.");
 
 static PyTypeObject pyrf_evlist__type = {
 	PyVarObject_HEAD_INIT(NULL, 0)
@@ -1100,10 +1101,12 @@ static int pyrf_evlist__setup_types(void)
 
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
2.47.0.163.g1226f6d8fa-goog


