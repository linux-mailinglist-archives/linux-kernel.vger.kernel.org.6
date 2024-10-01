Return-Path: <linux-kernel+bounces-345913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7BB98BCD1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9351C21ECE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE031C244E;
	Tue,  1 Oct 2024 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PShiBcAJ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE51C3F2C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787170; cv=none; b=glEnPfZiFulWlB53iuO0qRY6w+xHRaKmU8y7Jr7mOwiGbjTFTOc3InTHBKkr1lU8oG3cMGh48RMyHQ7mJ/nM2FamBnn82iEeQ3go7yFPyKy+bHaNXuGLMHRRYb1qVsawC32oviqCb51MRPgnUTU9z1V9fA0TKfDvz8BTYeATwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787170; c=relaxed/simple;
	bh=ETWbFL7P9mKDhnyvqRFa2P4dBmzjjbMZd/BAbyRinDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=B36urZ+GF74zIhvthI2XpRxAQDOi8Gaqqlm+4w8a2eKDfNCENMnr580Fr9Ra5A7umksKa6QrDzMR44U1quOsdG7VlV7WJfNrS0Sfyc91nNcTXvuIydSsFsi1sGtGDP+6zgKqA0UuhvO2vsEUmF9Nod3I25id0OCplZI+gxlf2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PShiBcAJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cdbdbbb1cso1897862f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727787166; x=1728391966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D77oab8ksLoAnmqxINtp3jlUWlLbi0Qd5k/MQLHxmcA=;
        b=PShiBcAJXxYvd+JiEiHlsm5pV0OE9R1wBj1AbvQa0e+R0O9Yk0/4+VuKjfsGlsO3k/
         XhbBAjb1E/p/9yWpydUCcc/8s5MpPcCBcVF43UXRkj0ilm8Zesuhn37sN2sunXrnDRgL
         Rw/MavbbxBdWf4+J90Ald3NRmAhr+dunOipmZRk5czTxOUIhgYQaakBhGJzhlFYAbw2E
         0QizAhR7D0GWFrA2JaGSiQWvLjrS1mfHiURfAvgXYt8ZY+xXhO5Ujsei18qrbopN8T70
         GO50pgl/yRtaukhJfqaeJGpCRQHmz4E9yGYo+hXVJONW6GhbyqbeO9lfkmfTyZ8NI2G0
         T0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727787166; x=1728391966;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D77oab8ksLoAnmqxINtp3jlUWlLbi0Qd5k/MQLHxmcA=;
        b=xJHn/ZQRNubLDDzR2omLv43cNXdvEo+7rign0NJZ1dZ96mXyIMBnwsYdU4sjc79eH9
         pRKkhPjBZWseD9L2NS7TtKKwUPZYWLDqac6ZKmtLWazXnDKYj38xLWR8CiFHexnfni6R
         UhrFwz2ZUyj9IZlnqHdjcQu3id3v0q4JKKwAPJnUeLRrJMoH1uwEoKC/RU6X3o3CRrcX
         FYzWFma0ePw13ZPZwxL4HUDCMuLUMRRXYWn1pymwLTi+2hi+CYZHr5qv8i3iL38tCJoI
         OItBebVARG9A9vAm94ZT/vlGS8ribG+Ok3rsz8eh/pKIr/Y0n3Y7INzGqTsH1lcgJqVR
         kToA==
X-Forwarded-Encrypted: i=1; AJvYcCUd/JCNZxeY3/uQLdu43DEgSaZNiUgg2ER2f+y/KNsw7IvtZYnLVqWJrz/5Aw7CiZMokeX8COxOUHQynY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GzoaAF1dwaMeCKo6+3Ksf4dJbSS3NEbLLfQ+ew2cKTACvCtx
	ZEVXj7b3/HDrJDMsj19zxZQajtslzcRNXKxiHNop5c9hd+wn2V5ghzDploO4UUs=
X-Google-Smtp-Source: AGHT+IFMeMdaNuiUyAJXpNRDOm3mNQFjc6pxWIoClyytjs7X7vyNrmpeK6Y3DMKJh1eE+zv6rFOP2w==
X-Received: by 2002:adf:fd12:0:b0:37c:d53d:cb63 with SMTP id ffacd0b85a97d-37cd5a9d8eamr8472276f8f.28.1727787166275;
        Tue, 01 Oct 2024 05:52:46 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d0a3sm11960259f8f.15.2024.10.01.05.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 05:52:45 -0700 (PDT)
Message-ID: <3820e6b6-5bda-4ab1-82fe-1b8001d2b810@linaro.org>
Date: Tue, 1 Oct 2024 13:52:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf python: Constify variables and parameters
To: Ian Rogers <irogers@google.com>
References: <20240918225418.166717-1-irogers@google.com>
 <20240918225418.166717-3-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 Andi Kleen <ak@linux.intel.com>, Zixian Cai <fzczx123@gmail.com>,
 Paran Lee <p4ranlee@gmail.com>, Ben Gainey <ben.gainey@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240918225418.166717-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/09/2024 11:54 pm, Ian Rogers wrote:
> Opportunistically constify variables and parameters when possible.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/util/python.c | 55 +++++++++++++++++++++-------------------
>   1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 02279ab4967c..13dad27169a0 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -62,7 +62,7 @@ struct pyrf_event {
>   	sample_member_def(sample_period, period, T_ULONGLONG, "event period"),		 \
>   	sample_member_def(sample_cpu, cpu, T_UINT, "event cpu"),
>   
> -static char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
> +static const char pyrf_mmap_event__doc[] = PyDoc_STR("perf mmap event object.");
>   
>   static PyMemberDef pyrf_mmap_event__members[] = {
>   	sample_members
> @@ -77,7 +77,7 @@ static PyMemberDef pyrf_mmap_event__members[] = {
>   	{ .name = NULL, },
>   };
>   
> -static PyObject *pyrf_mmap_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_mmap_event__repr(const struct pyrf_event *pevent)
>   {
>   	PyObject *ret;
>   	char *s;
> @@ -106,7 +106,7 @@ static PyTypeObject pyrf_mmap_event__type = {
>   	.tp_repr	= (reprfunc)pyrf_mmap_event__repr,
>   };
>   
> -static char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
> +static const char pyrf_task_event__doc[] = PyDoc_STR("perf task (fork/exit) event object.");
>   
>   static PyMemberDef pyrf_task_event__members[] = {
>   	sample_members
> @@ -119,7 +119,7 @@ static PyMemberDef pyrf_task_event__members[] = {
>   	{ .name = NULL, },
>   };
>   
> -static PyObject *pyrf_task_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_task_event__repr(const struct pyrf_event *pevent)
>   {
>   	return PyUnicode_FromFormat("{ type: %s, pid: %u, ppid: %u, tid: %u, "
>   				   "ptid: %u, time: %" PRI_lu64 "}",
> @@ -141,7 +141,7 @@ static PyTypeObject pyrf_task_event__type = {
>   	.tp_repr	= (reprfunc)pyrf_task_event__repr,
>   };
>   
> -static char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
> +static const char pyrf_comm_event__doc[] = PyDoc_STR("perf comm event object.");
>   
>   static PyMemberDef pyrf_comm_event__members[] = {
>   	sample_members
> @@ -152,7 +152,7 @@ static PyMemberDef pyrf_comm_event__members[] = {
>   	{ .name = NULL, },
>   };
>   
> -static PyObject *pyrf_comm_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_comm_event__repr(const struct pyrf_event *pevent)
>   {
>   	return PyUnicode_FromFormat("{ type: comm, pid: %u, tid: %u, comm: %s }",
>   				   pevent->event.comm.pid,
> @@ -170,7 +170,7 @@ static PyTypeObject pyrf_comm_event__type = {
>   	.tp_repr	= (reprfunc)pyrf_comm_event__repr,
>   };
>   
> -static char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
> +static const char pyrf_throttle_event__doc[] = PyDoc_STR("perf throttle event object.");
>   
>   static PyMemberDef pyrf_throttle_event__members[] = {
>   	sample_members
> @@ -181,9 +181,10 @@ static PyMemberDef pyrf_throttle_event__members[] = {
>   	{ .name = NULL, },
>   };
>   
> -static PyObject *pyrf_throttle_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_throttle_event__repr(const struct pyrf_event *pevent)
>   {
> -	struct perf_record_throttle *te = (struct perf_record_throttle *)(&pevent->event.header + 1);
> +	const struct perf_record_throttle *te = (const struct perf_record_throttle *)
> +		(&pevent->event.header + 1);
>   
>   	return PyUnicode_FromFormat("{ type: %sthrottle, time: %" PRI_lu64 ", id: %" PRI_lu64
>   				   ", stream_id: %" PRI_lu64 " }",
> @@ -201,7 +202,7 @@ static PyTypeObject pyrf_throttle_event__type = {
>   	.tp_repr	= (reprfunc)pyrf_throttle_event__repr,
>   };
>   
> -static char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
> +static const char pyrf_lost_event__doc[] = PyDoc_STR("perf lost event object.");
>   
>   static PyMemberDef pyrf_lost_event__members[] = {
>   	sample_members
> @@ -210,7 +211,7 @@ static PyMemberDef pyrf_lost_event__members[] = {
>   	{ .name = NULL, },
>   };
>   
> -static PyObject *pyrf_lost_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_lost_event__repr(const struct pyrf_event *pevent)
>   {
>   	PyObject *ret;
>   	char *s;
> @@ -236,7 +237,7 @@ static PyTypeObject pyrf_lost_event__type = {
>   	.tp_repr	= (reprfunc)pyrf_lost_event__repr,
>   };
>   
> -static char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
> +static const char pyrf_read_event__doc[] = PyDoc_STR("perf read event object.");
>   
>   static PyMemberDef pyrf_read_event__members[] = {
>   	sample_members
> @@ -245,7 +246,7 @@ static PyMemberDef pyrf_read_event__members[] = {
>   	{ .name = NULL, },
>   };
>   
> -static PyObject *pyrf_read_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_read_event__repr(const struct pyrf_event *pevent)
>   {
>   	return PyUnicode_FromFormat("{ type: read, pid: %u, tid: %u }",
>   				   pevent->event.read.pid,
> @@ -266,7 +267,7 @@ static PyTypeObject pyrf_read_event__type = {
>   	.tp_repr	= (reprfunc)pyrf_read_event__repr,
>   };
>   
> -static char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
> +static const char pyrf_sample_event__doc[] = PyDoc_STR("perf sample event object.");
>   
>   static PyMemberDef pyrf_sample_event__members[] = {
>   	sample_members
> @@ -274,7 +275,7 @@ static PyMemberDef pyrf_sample_event__members[] = {
>   	{ .name = NULL, },
>   };
>   
> -static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_sample_event__repr(const struct pyrf_event *pevent)
>   {
>   	PyObject *ret;
>   	char *s;
> @@ -289,13 +290,13 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
>   }
>   
>   #ifdef HAVE_LIBTRACEEVENT
> -static bool is_tracepoint(struct pyrf_event *pevent)
> +static bool is_tracepoint(const struct pyrf_event *pevent)
>   {
>   	return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
>   }
>   
>   static PyObject*
> -tracepoint_field(struct pyrf_event *pe, struct tep_format_field *field)
> +tracepoint_field(const struct pyrf_event *pe, struct tep_format_field *field)
>   {
>   	struct tep_handle *pevent = field->event->tep;
>   	void *data = pe->sample.raw_data;
> @@ -384,7 +385,7 @@ static PyTypeObject pyrf_sample_event__type = {
>   	.tp_getattro	= (getattrofunc) pyrf_sample_event__getattro,
>   };
>   
> -static char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
> +static const char pyrf_context_switch_event__doc[] = PyDoc_STR("perf context_switch event object.");
>   
>   static PyMemberDef pyrf_context_switch_event__members[] = {
>   	sample_members
> @@ -394,7 +395,7 @@ static PyMemberDef pyrf_context_switch_event__members[] = {
>   	{ .name = NULL, },
>   };
>   
> -static PyObject *pyrf_context_switch_event__repr(struct pyrf_event *pevent)
> +static PyObject *pyrf_context_switch_event__repr(const struct pyrf_event *pevent)
>   {
>   	PyObject *ret;
>   	char *s;
> @@ -474,7 +475,7 @@ static PyTypeObject *pyrf_event__type[] = {
>   	[PERF_RECORD_SWITCH_CPU_WIDE]  = &pyrf_context_switch_event__type,
>   };
>   
> -static PyObject *pyrf_event__new(union perf_event *event)
> +static PyObject *pyrf_event__new(const union perf_event *event)
>   {
>   	struct pyrf_event *pevent;
>   	PyTypeObject *ptype;
> @@ -542,7 +543,7 @@ static PySequenceMethods pyrf_cpu_map__sequence_methods = {
>   	.sq_item   = pyrf_cpu_map__item,
>   };
>   
> -static char pyrf_cpu_map__doc[] = PyDoc_STR("cpu map object.");
> +static const char pyrf_cpu_map__doc[] = PyDoc_STR("cpu map object.");
>   
>   static PyTypeObject pyrf_cpu_map__type = {
>   	PyVarObject_HEAD_INIT(NULL, 0)
> @@ -611,7 +612,7 @@ static PySequenceMethods pyrf_thread_map__sequence_methods = {
>   	.sq_item   = pyrf_thread_map__item,
>   };
>   
> -static char pyrf_thread_map__doc[] = PyDoc_STR("thread map object.");
> +static const char pyrf_thread_map__doc[] = PyDoc_STR("thread map object.");
>   
>   static PyTypeObject pyrf_thread_map__type = {
>   	PyVarObject_HEAD_INIT(NULL, 0)
> @@ -795,7 +796,7 @@ static PyMethodDef pyrf_evsel__methods[] = {
>   	{ .ml_name = NULL, }
>   };
>   
> -static char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
> +static const char pyrf_evsel__doc[] = PyDoc_STR("perf event selector list object.");
>   
>   static PyTypeObject pyrf_evsel__type = {
>   	PyVarObject_HEAD_INIT(NULL, 0)
> @@ -1078,7 +1079,7 @@ static PySequenceMethods pyrf_evlist__sequence_methods = {
>   	.sq_item   = pyrf_evlist__item,
>   };
>   
> -static char pyrf_evlist__doc[] = PyDoc_STR("perf event selector list object.");
> +static const char pyrf_evlist__doc[] = PyDoc_STR("perf event selector list object.");
>   
>   static PyTypeObject pyrf_evlist__type = {
>   	PyVarObject_HEAD_INIT(NULL, 0)
> @@ -1100,10 +1101,12 @@ static int pyrf_evlist__setup_types(void)
>   
>   #define PERF_CONST(name) { #name, PERF_##name }
>   
> -static struct {
> +struct perf_constant {
>   	const char *name;
>   	int	    value;
> -} perf__constants[] = {
> +};
> +
> +static const struct perf_constant perf__constants[] = {
>   	PERF_CONST(TYPE_HARDWARE),
>   	PERF_CONST(TYPE_SOFTWARE),
>   	PERF_CONST(TYPE_TRACEPOINT),


