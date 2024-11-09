Return-Path: <linux-kernel+bounces-402703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532139C2A99
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5871F21FC3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A31198E8C;
	Sat,  9 Nov 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9FpMQe2"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096FC198853
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133149; cv=none; b=RuaZbg8ZbLOLxAaozCXd/gxDQd1orzR/tmAUfLmto3AOuzsR5936BSv6I1fA/Fc+84n3Dv3iG5rLi0qe+mQQWTFBNKtkhxK4EhdmR7HHb0TGzwgikZ9gTkjruSuYKLUrQgXAZpK/7IpHBHYd0DEqaLSJD36SD9mhLUbOHm8baI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133149; c=relaxed/simple;
	bh=lo8v/8lzKi2C37iCsrx8frWOHW56Z3pjRjxD2LGxcBk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=iOAVULEGtTNyeibsz8jJBDjy2DXZEEeYQSoInPSfqwhNNJCK2+uTvZcDEgRtVL1ke0LhOfmCWNnsGu4yiBsi5sSCXzHqPbrtqZ7Bqc5ChWg2Wkt8v8wt1Pbfl8MZd81WDp6/TVPesHb7xTJ+fnSDxL8PJB1uQyCc7f7QdaVX7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9FpMQe2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29142c79d6so4458887276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133147; x=1731737947; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcNbzzRS5VSvLqueZ2osfH4cEHyPpkywFOwBXdLSQFY=;
        b=I9FpMQe2pyHsb/CNCIjalnEQ1Zc3BEbSJ3vYug9zZSpT5zE0BVqBujrOxFAGyfwIS6
         3GPRVi0SI5uAhCr2Y61IzBmpuPo6Z1pF+3iBGiVHzNRUoJ8YqPaFJfCNLQZ4z/SqYSW/
         PNG5/ZP2d9gK7JAkYn0rhcIWy0wuWCEQrh0fSJ2DgB+iPiOmfxuOVfSrI3C8AXNVZ7Ef
         nEJY4ptMNEzx5TjpIDHwEXuE03f/tLChh7VfaSx0mrtOngVVX8ZmWlIO/uga4P66uwVJ
         P77nzC9NUa5Nta8vfGsn9oUZQxm77ZXSFlBi0TgtiFgZRdpuVgdpRIgZuz/sV9o56qQF
         Y1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133147; x=1731737947;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcNbzzRS5VSvLqueZ2osfH4cEHyPpkywFOwBXdLSQFY=;
        b=A71C1+SsAiIYKc1mKKRPri22Gg8OTlIgal3rcBYxDpITAXQVx2opjun0mEJUQw3ZfY
         bNfL7oI0SV/cVNHPgnAhSZQohZacBSAWfejoCukmxCWeo5hmyqCsJ8Nm2VyE0L4l0KoJ
         Nfy8E057ZG67sW2sDf5uw7QWzu7X1MM32xehaXgoOaK0n3d4QPkdIql7P9lfwj48gqS/
         cdp6no2Q57Wm6c8BoHhddwPO4oakj9SGmq+PQacR4Sr7OYOX5bprrJu86UQFjYmy/s8z
         K3N95giEdrWfbzA7w9xi07GYoNh7uBL71meAxawNtoIT2/4meb+cjqQmXe+8oeUPaV4U
         31TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfYj32W4BwMdPGJjl/hdj2ok4UmrHHKeA3Y+/Jhh37AP6Vn+KHQmX0YHwFAZ7slCKeiyDr24db/4IsAOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd7FQUVRPI/8z9DtepML7xgwSMWERjhlE1kbafQnmRD5Tfsp9o
	DthzWj5+czepZDtx/oXlCMuYe827Eore279zeNYgI5WRBM6+pi91m6JFJUuRTT76rtTG8XgJ71L
	I8/0uuw==
X-Google-Smtp-Source: AGHT+IEKaG3zlJt89Q/3pdQFukKpZBajf0ZNkUqR0ExiOk8/EXoIs6qi0VEv8zHURZeQDLRlnyhNsZA6ER1Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:3355:0:b0:e2b:cd96:67a6 with SMTP id
 3f1490d57ef6-e337f8c133dmr3846276.5.1731133146758; Fri, 08 Nov 2024 22:19:06
 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:07 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 20/22] perf python: Add __str__ and __repr__ functions to evlist
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
index 1a53a97c513d..a71bad3418da 100644
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
2.47.0.277.g8800431eea-goog


