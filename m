Return-Path: <linux-kernel+bounces-367250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DE89A002F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CDABB23057
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0B71BAEDC;
	Wed, 16 Oct 2024 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QOvH27j"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5381B393A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052714; cv=none; b=F2PjbpaFW92AtvexZxoZ4fQQ4drMO5wVUR2Kxneak9GIORmlS9UjtxJZD68bZ6yIbZ3JHHpe4d1J5sKr8SEoB8BvNeI7dwoEpczRG6wn1U2l19GvzD+mutieGhF0BXD2h0q1ZtlPyi9VZXxSNCIjWiVgBVseV6iTydM+b4cYXXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052714; c=relaxed/simple;
	bh=YTJsvsOE8a25R1DD/RA8PVQLNC4Uq1qBnyneB6eRW0g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QrABTsx0qJbYxSpfIJiD0zsqYiR21irPdS31Nlu2dGqJuYX5GMkBsanqTUjOaFYWxNwcRhg+reeCdIrhwpJG/xkTL/VWdDN/obWIC151Bb9loh+1SYGDceGpOh7IKk6klKfxq+JW0DYa+zOh4Ma+RTRTfeOKsmdzJA4H85CD8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QOvH27j; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e376aa4586so58379987b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052711; x=1729657511; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hqYrLnfi6pZq/dyjCorwIaw7kfTRCdabnWEBnJH4emk=;
        b=2QOvH27juX3O1CUWCYYRMXX63kUlQW+wG/6I08/H4Qnu1YZxB5TgWDHdNKPemN4//I
         9iAMI4pQdbrIGDvUHxHkuz3spcdON6iQNtU2ch4Wgrrg8eTn0p92vZHa67g7Ch83JrUP
         SSbAP9DHR/0vFD6ShuIoWZYinJw5yTUW639WYUYT4mB5ZIhUYgGGHcRF9p6U9ckxYSqE
         SXhzNn8snQJOFt3ogz/5jNpH0CeGwfdPRQQLnQ35RLXSR1phAS9MT7rxD7E8+q+pEK9q
         a1d+UWXwfATn7Mfm39dFHXnjxsIrNx/FvaAmODOkl1dq4sruJ2AzW/AkDiN9RzsP2erR
         V5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052711; x=1729657511;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqYrLnfi6pZq/dyjCorwIaw7kfTRCdabnWEBnJH4emk=;
        b=tU5S5RvwISUHUDr1s3GdaWK1J1Y5ELUvXGMi5AvSa9wDf3FNBlX3lSsLbXZcR6mA/t
         VEaidKQKCm2qbM6rnC/DGdpm4fqvHKhLmV+rpAZ8+pIleyCqUBrEA/wAokxxXyIgEjGT
         og2CvRQsyyPP5Ss8now1divJ3S52z6mCqnLLO/Jl5ug8Ro/Qkf6G5+QBapbm3Kpxlg1c
         gQsbDS9V50tYa+dxzNKg0tX+WBkoOJyc1a+iMbG2fwHW9xwxBGcjbFUJ+QdIIFUpBWLs
         b8O7/D9FFoXY/w4k4zUIeGcfzXm+xi3HiMsWim9ojkdg5UsQ0tTBHUD6U2BsD9ey5M51
         U/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUA2P0D3q3CsJfpwpbnxA3NQtvx/T+NqFsrMNXQLH/UiCqzKciOMR6dzfYlfN/zQhVfAG03Wh6EpNRsNtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHK6tUMBkoGRa91Mh2i75OX2rghhJDHRis3rRbcLLFNKztwYsW
	zEhAZvcCMlW0J+Ppuo+4hemeOxsbZwdvenI7bu1IZBw6yesjSYLEagOsO6AaK3Q9qJWZWm/R4G9
	PK0J72Q==
X-Google-Smtp-Source: AGHT+IGPhS0PoOQUoVyeqB2Lwq/bFZXE1TdnwJnJCsevOVA+4Nsjgul44oYsbPNu44WV2uFZF8Ik9X8Hed4D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:3610:b0:6e3:3407:8575 with SMTP
 id 00721157ae682-6e3d41e809bmr691907b3.8.1729052711513; Tue, 15 Oct 2024
 21:25:11 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:15 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 16/16] perf python: Add parse_events function
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

Add basic parse_events function that takes a string and returns an
evlist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6e2ff0076daa..ec37f887db43 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1201,6 +1201,30 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 #endif // HAVE_LIBTRACEEVENT
 }
 
+static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
+{
+	const char *input;
+	struct pyrf_evlist *pevlist;
+	struct parse_events_error err;
+
+	if (!PyArg_ParseTuple(args, "s", &input))
+		return NULL;
+
+	pevlist = PyObject_New(struct pyrf_evlist, &pyrf_evlist__type);
+	if (!pevlist)
+		return NULL;
+
+	parse_events_error__init(&err);
+	memset(&pevlist->evlist, 0, sizeof(pevlist->evlist));
+	evlist__init(&pevlist->evlist, NULL, NULL);
+	if (parse_events(&pevlist->evlist, input, &err)) {
+		parse_events_error__print(&err, input);
+		PyErr_SetFromErrno(PyExc_OSError);
+		return NULL;
+	}
+	return (PyObject *)pevlist;
+}
+
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "tracepoint",
@@ -1208,6 +1232,12 @@ static PyMethodDef perf__methods[] = {
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
2.47.0.rc1.288.g06298d1525-goog


