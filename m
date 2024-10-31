Return-Path: <linux-kernel+bounces-389857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E143A9B722C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44D6286ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535F153BE4;
	Thu, 31 Oct 2024 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h5tP0Zmh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA014EC5B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339044; cv=none; b=PnHRCV+AkWTKNcTUkpzEsLLRQw2oNq/ycHYe8EFhCBzCc8p0Kopx4V7Fety5DHG9ROyWpEeXG25t8ZlpDx8y5ok7HyxT/1pZbDBtMEBEJLfrtJ5nPtgRLJtyHsKvyh0Z4EZTtiBjrcHh2X+7qOYXt9rXwIMntHdH47pZSZ0ohuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339044; c=relaxed/simple;
	bh=8nfaXceOAmgiqk2t3wMeEWNA4KSjqafBiascjUECmpw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ei7IBzk/oygk04lKNGoTbHzdCiexmXoQgnEa2gq7n2DbRCXcIF9LzQxfDREv2PKPPGjKYZmJns7Bd5Z3FloTL7WyJndr0OuLn12JqUvLx+gIbzUx9TwvabTaMc6Zgy9SMVI8ZL4eNJR7XTrERhNSkKILhiJhAQ6parW87G3hmKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h5tP0Zmh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e36cfed818so6637517b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339040; x=1730943840; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dis7RmFKQzQzt6CCLpk0OQW/Lncdns24hHlJR2bLa6w=;
        b=h5tP0Zmhb4G/H07PxlHisuQxnQwgsBWqC3lgs0LEDkQljmGclh36pMKM5NlLoBBfX7
         k58QbPEdwHxzqubjNNuUY9L2SXVKvurcr/gQxNOhgFxFSfmUU+V35IOvWT1jYe6LwOrr
         YoJcbGL/f9PrEbiIoKwhDJz0+nBsv7QQ1eLW3MhUZjlZ2DsRQMXYoDKTXnDCA+1V6sQw
         lBm5Z/Iuzs6YCiU6Tfmcb6Rk+uBQv88jF/7QNaM0Xn0GWC+KqJOjTsAviaAZowrMY0dO
         /tBlI/YntEJsHDpV6A7/qHcd0uHGHqqbmHwTNMIKA/3Ks4UIVQBQL3cCRe9YP1oJ13NZ
         uQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339040; x=1730943840;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dis7RmFKQzQzt6CCLpk0OQW/Lncdns24hHlJR2bLa6w=;
        b=b3SZP7tp9ajzk6Lx1o6k9odJ2vwyZ/tiEa10nojzHBZpYp3q4RPE2qjS9TFqRvRxYa
         fU38AVZVHOGcmFb2Re49XEKsTjdnlAr0JjOHUYkCJ6zn+J8vOsLLyvZ7ObpPMbPv966B
         FnG6FZby4qTQK+7eE17WwKjRyNWOlId8LI1NXbA7VQ0Zg14+Fmdp5u30Upok+7VUjs2H
         OVtfiBVVaQbNhOEC0kxRCHBeesURcHNWgxCJNMh1Ep0pe/wSr+ZV1ALAICohQGVnaQVR
         m+07KwQ6kuOIrCYhx7nOuts/6NqzfBQdYse2qN5EeDZWNWfpeJAogzV/q2OCqlXRhy+r
         cCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAet1obKN5NZfC14ZbfVoAyXjs7rAWJcuxgYPrGkhpTsPXg4OOckH5Q84f6fh2GnyWmHNsRjaaHigTQhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykNK5kKbfvR1FFiRYrIBK3JL3qxz+Z+epnscHnw08wOzeO1S0y
	vqiFB/XPCEk2VFCQH3TcKGR29fPct5G2vqi/yJhAFHgjEyu2dF9XFeMC5VokDtr5SvwS3WbuNfU
	3GVIHIA==
X-Google-Smtp-Source: AGHT+IGQq3M4vfXsHI+Az7Xvrx0IFPhm3BfRkVi7rYd6AuYsG0RdG+quXrCLKrsw0ORuUqiPHTLwAqWA0VT3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a5b:18f:0:b0:e25:d46a:a6b6 with SMTP id
 3f1490d57ef6-e3087c07f8emr54926276.8.1730339039890; Wed, 30 Oct 2024 18:43:59
 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:50 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 19/21] perf python: Add __str__ and __repr__ functions to evlist
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
2.47.0.163.g1226f6d8fa-goog


