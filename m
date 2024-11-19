Return-Path: <linux-kernel+bounces-413685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 688C09D1D29
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174781F2267A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89A195F28;
	Tue, 19 Nov 2024 01:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecgQ2sRQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF51957FC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979112; cv=none; b=s3Lmhkch50BDZNer0AkRlEJz07rzfZLqxS3Bcm52h1NtLwNLfzrrbDSDxrYMpYiQRNsZRaISsfJznBwnR7GRNJGs+nUN4cnsdOL79irKg53hbZk5nqmvmtjmzgtmivUrkv216m0gJ04WCERQUOX/CybY+jysxViZDw9zqJggmj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979112; c=relaxed/simple;
	bh=qNHR5Z1taMUuo089XQ85xElyxUlkv0ZkzX40B+6d4Ls=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=XC67Xw1tZtuMNrY3Ms8Q4zSWM9nJrLRhkpccrIaUBl4CnHYFxeY+hreKGfYn4zb8PRqyyutWBIuya9iCC7tJxU7hs3ap8UqTpaQtkiFirGKJplX9FJLOQQMlYfvkEbFUzOUz4cCO8MGR0iWfJNktgd5HaanNlqa/r3VKUuSDgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ecgQ2sRQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eea70c89cbso8570147b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979110; x=1732583910; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0TlmDbRtQCgRVuOOv2LFWC25wlWVgj89vAp1aG6rmOk=;
        b=ecgQ2sRQMZAM5Q0L3Cmq7nGnJgugOQ7sjqAUGS6GYPr+vKDJeLfBk5+eso0Z7QTLKM
         gjU5wBQDxM3G+rsNDCsRCgLQ4YcYUJTu/k6GkvQuOIuaIWxaiHlwsVgKyJYUpOWfYr9H
         zE2i33X6bh3toPL2axWfLN5OjcYlewNTeecLY1MzjRxfnxSFu8Zt1jRcELE/v4i9XlE+
         ZXnm1IqmBR9tdh4UDcCV3xjZjdqTflr+Pf113n/xlRKVW6E0QihzarJ+hJWA4ACcxiqS
         ShAdHGMqgy/81L7lT/vDKT9L+OKM+iUy9jMU/uDBWLfvFkUpShqMA8/LrsAtwp5Qe9R8
         Nv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979110; x=1732583910;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TlmDbRtQCgRVuOOv2LFWC25wlWVgj89vAp1aG6rmOk=;
        b=QvANexxh7Nf3g6cKnYJ5+z/bTVFiDGaDfcNeaAMlVPE5eb9q0delai0eVqiyj/Nik7
         A0RPMqMSYB4X7Lg6w2Qit8OcxHz/LjiSa7544RYFQJKXpmdel5jcN3PKqiEGJjKTVHBw
         FqK2SSsxm8nH98HyGC4ZMHg25NUuBHDswY3OyxJTZkB9tIKu9eVYj2FLKVwzManuk1kW
         wIMrmZ20wnX5Nx4wIxtpABldd2P2nI4+eAnqrm2jBWf33oOe5gLHThFpltyXOGz6thoI
         rK20OuKPlxdDSXp3TAQMjFS6OsCB517NamHWTsYF3OGhLGLOuzzsfNw0U8s7exEngQV7
         sZTg==
X-Forwarded-Encrypted: i=1; AJvYcCUm8O0e8dlqwYSUKX4MO67+nr7CpnIL+jPy54mZQyHafGtMRk+1IUwcPT0kstP329er+Bht3IDjAgF1gyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfZC3JUU4Fjaf6xqrUejaxt5fawqpSRq2kjPr4v/+4UsolhkG
	1FQtcMhrGVnTPlEb5gqrjkDmGlAZNyrBhpk3smQbL8sYbSEfJVSstjPICdlxtxdHq43rVBYJPAz
	stD+gRw==
X-Google-Smtp-Source: AGHT+IHr2CghJCzDEwgXBNpiOzi0hjXzKde/6Z3FZ8YQO8FElmB+t+txNjDfedjSK5sz4oA0+9wbjZpYGzUt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:498a:b0:6ee:a2b0:a803 with SMTP
 id 00721157ae682-6eeaa2e70femr62167b3.1.1731979110361; Mon, 18 Nov 2024
 17:18:30 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:42 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 20/22] perf python: Add __str__ and __repr__ functions to evlist
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

This allows the values in the evlist to be shown in the REPL like:
```
Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path.insert(0,'/tmp/perf/python')
>>> import perf
>>> perf.parse_events('cycles,data_read')
evlist([cycles,uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/])
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index c84c912874b7..c556cbc582ae 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1069,6 +1069,30 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
 	return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, evsel));
 }
 
+static PyObject *pyrf_evlist__str(PyObject *self)
+{
+	struct pyrf_evlist *pevlist = (void *)self;
+	struct evsel *pos;
+	struct strbuf sb = STRBUF_INIT;
+	bool first = true;
+	PyObject *result;
+
+	strbuf_addstr(&sb, "evlist([");
+	evlist__for_each_entry(&pevlist->evlist, pos) {
+		if (!first)
+			strbuf_addch(&sb, ',');
+		if (!pos->pmu)
+			strbuf_addstr(&sb, evsel__name(pos));
+		else
+			strbuf_addf(&sb, "%s/%s/", pos->pmu->name, evsel__name(pos));
+		first = false;
+	}
+	strbuf_addstr(&sb, "])");
+	result = PyUnicode_FromString(sb.buf);
+	strbuf_release(&sb);
+	return result;
+}
+
 static PySequenceMethods pyrf_evlist__sequence_methods = {
 	.sq_length = pyrf_evlist__length,
 	.sq_item   = pyrf_evlist__item,
@@ -1086,6 +1110,8 @@ static PyTypeObject pyrf_evlist__type = {
 	.tp_doc		= pyrf_evlist__doc,
 	.tp_methods	= pyrf_evlist__methods,
 	.tp_init	= (initproc)pyrf_evlist__init,
+	.tp_repr        = pyrf_evlist__str,
+	.tp_str         = pyrf_evlist__str,
 };
 
 static int pyrf_evlist__setup_types(void)
-- 
2.47.0.338.g60cca15819-goog


