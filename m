Return-Path: <linux-kernel+bounces-332995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C397C1F9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 00:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43861C21911
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C71F1CBEB0;
	Wed, 18 Sep 2024 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oq6P01Hd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016BB1CBEA6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726700070; cv=none; b=JKxHMRG+JipgvbFnxBNkZqUmXl1dJRoLG8QxEJt8t0m/e8v5c4z56z1MrYMeQ9NXAcf2ii1Y4ZUD+h2iUF0FMUtwF8TM30/fvJMDFfNp0XAGjDQq9zAsC3eo2V40vCXTsjYUgG4JgU9/dekP0lq0fcEpPAzgkUUTsJURWrC3zWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726700070; c=relaxed/simple;
	bh=xnyUkugBLFjm8eo1+OAmXlSTl6AOrpWiEEEJQVuMy1g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GuSc2Vc/LJLhWaRvU0Pl9YUNU5b5nFUdWeeKQR+uVcOl7BUQ6vsewiE9Du8QtdrH43rKSBX8mYDklE3bSIIMhfN629wXfud3TrGjUMXlMBBf1mtIcrm3cTSHVJIfc+MUkqNhE/7hTNf6VK7vsn5AB8VNx42KX+ySQmJjgJyz9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oq6P01Hd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6dbffbae597so5490107b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726700068; x=1727304868; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7D8jXB6B056rVyMaAWUNp36V2RCCrGLmJuSoHlr5mog=;
        b=oq6P01Hdr2KlqBJDaKUWqHu7MKJVrTmp6GkHtPe5dASvF/UvuROOnxmGaxTvJ22X5z
         24/rBRPnxzV0+C1c19obMycZeIIrck+JXLrqxxeJ1Ivkrayq6+DmN3VSXvdp074Yvgbs
         8CRkt6NXw08aPHkp4psf523NL6Yj1uGaMvcra4GnNAslJfOR0hzwOKDh4FUYtIm8nVqT
         ldUBOLaVoaEGKTukoZrCmRssU/Y+Jl12ufAqNVXZ6wSuVidPn0foA/txli0+yInSyU15
         4dBFQourkwbszBTXDuLnePP6WE8MHeChF/Cnq1g171kBVSrbulaTHhxB87p8kSWtjHTA
         agdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726700068; x=1727304868;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7D8jXB6B056rVyMaAWUNp36V2RCCrGLmJuSoHlr5mog=;
        b=Uw0tphoJfRlewd5dkwo4ApChbsUojdEiv13r07e0FRlG1WPBvqQxSCfoSzh63T7PIS
         BMSUv69Bh8I3+BtR3DHTkZ1v3B8keW5XZA4jA9x1m4l2AxWIWIGvfyOBjCz9Dmy7MzJX
         YEMJh4hQUaiQF9mnAlTAIw0ITXaUfMjmSSJoBZ7XU7lDkwS/yWFjP+BFD6J5iXl6rC+1
         CMOwH08FQL4yWGafecCLf2vbrHck8Mm0BclQo/K8NmQZJqCNVdJOPaVnNpYj8HA7g21Z
         p88H3kKuwfgtxbkGmyZ7BdWeomLgWonad8nhHMcs4zm7MCVozGpiym+SxE0iVcOaQVnj
         5jFg==
X-Forwarded-Encrypted: i=1; AJvYcCXwFXNp6eCqxs7OXi/RDodYIxQXq+ogENFGA9UENFUey551N9Lc8NOxr3y7DYg0H4J1gIBzAy0Hu3Sk5KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyocTt30AQhlHXjpICa7VVwnBceKc654TWEGPFSsPhGe37hjGCu
	/+vzDZAmO1TAxbYDeoybE+xk5gU2NQXrBlHMZiL3P7quz+AsB2SUXCZiDJ62uGowBI1UfaAC4Ec
	IYBsz7g==
X-Google-Smtp-Source: AGHT+IErz5AxPJwUfRhBCeeSOOvqygeP/B4LBPQPtxguF6Clqm/Q6xAKQf8ov1EdVINpWWQJuRPlH4tbsNgx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cb6b:1e62:cfd8:bd50])
 (user=irogers job=sendgmr) by 2002:a05:690c:610b:b0:6dc:7288:a90a with SMTP
 id 00721157ae682-6dc7288aacbmr8757487b3.3.1726700066655; Wed, 18 Sep 2024
 15:54:26 -0700 (PDT)
Date: Thu, 19 Sep 2024 00:54:18 +0200
In-Reply-To: <20240918225418.166717-1-irogers@google.com>
Message-Id: <20240918225418.166717-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918225418.166717-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v1 2/2] perf python: Constify variables and parameters
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Andi Kleen <ak@linux.intel.com>, Zixian Cai <fzczx123@gmail.com>, Paran Lee <p4ranlee@gmail.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
2.46.0.662.g92d0881bb0-goog


