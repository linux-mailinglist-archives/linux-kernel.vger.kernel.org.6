Return-Path: <linux-kernel+bounces-402704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDE39C2A9A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420AE282FFA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B6E146D53;
	Sat,  9 Nov 2024 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vlwx+UF6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21944198E93
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133151; cv=none; b=sFaYOr7pQKfqAksvJv4rqw064yg+kZXjm22OdXxhup4CEI1/aH7h5ZmboNJ3+Y5Tzp33p775GFOXP7J8YaRgcAH+K7/7QeOgX9vcsyvr/ovlOde9/Rkzy7vDMdSwIBHJl+zYiqcvDqpFu7VbSnY2k3POOBirlAwJKYAJEKOO50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133151; c=relaxed/simple;
	bh=MCTzfXp2410npPWMxPnIy//KFfI1FnSlwqErfN8AdVw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=uHF7rFPNqM0nMH4QkVN1wU0Dif1IJKJ/qpY5Z9UiFlsBiJIwJ8WMtlbjlXIrORZZhShlqOR7dTB0vvw+XS2dYa3m2wbXPtXK+ssJ8CD68se1H6va3677rLV4yg08ZpQgim91sok2I7n2Hs++wvZWuNjaTnQ4EGUEu0alNMHBr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vlwx+UF6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eaa08a6fdbso52466047b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133149; x=1731737949; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQC+nYVZnsSIPtVomujUJB9/ZDMtc8fpB8iG7KWs9rs=;
        b=Vlwx+UF6Og1P1ohXLNFHkKtMyIAUHT79LeNk9pPckNTWLiwPqXCfe64X/WrIyhHp1x
         M3OIIaQyFCT7jKM9GcW5EuAL3JqoWteU2D98/4wIpBsg3D4FuIxDnffjUVlq0bJpkAGw
         +QWZArYxdJlFOxDgzpG0OEv1GU1wowea/4WRp6ltcyTTcqbo9tB24n7nJNz47zzEM49z
         ZHP+YhpjyGz9GQwLiMgvcFU0uHNbglWXL4D6vRt7MgxjFunlqvXCDplQa4sfhMY/iYaU
         xRuDaHSnmCGU+GKem+KeKRJrJ30hCbb8nHzXE+m5gxqH//FcPbklIGwGnTyMAgXu8MQW
         5fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133149; x=1731737949;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQC+nYVZnsSIPtVomujUJB9/ZDMtc8fpB8iG7KWs9rs=;
        b=rZPJR/DtILjAYBbt8OIlA8/mEQMnMfMxRhWMYkFKTMXf/OaH0eAwD+2LsFShsL9RZQ
         R3ytm4HeuQiDYH6BBPrgjfsWUz1b/oOVcY2kyPLkP3rIYH1YZup/ENBV7QZteCvYcSoy
         CF1duV7JZ2RlJ7K4C+uJdz0GKv5KOFXBjzFFwc3KwSWRGpcn6pHMs8Bg9f0rqiJ12SfR
         YPgHYemDchVdA0lWU9eKpBIPIkgs9bjiSvNZ3y5MJGmGMIUU4i5qUeNthtDw9z1YfyTi
         b1njRVqSC/rE9pN35JmFU7oaMF0/B3biScSe1ogDSwIa0TjZSWcnGSROldYUTPJbjneq
         G2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcjVpaPyIZMm64u3IJVTcG9tBYNuF3eDzR9Emzq7RgD7t8VkwJXEd/7mK4AlKsdN4x7vt7boWP77JQe94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUa33a1Dgr9QvDLJTQz+xUWKgmnMbTzVkitrrUiaLBcii43tO8
	UveR3HYS+du0hCY490GH/LF9ptOlcQ2hso+hKkUbhx/bnV5612nztclOVvq9irZKn61VBl+4Sgz
	cfmP4SA==
X-Google-Smtp-Source: AGHT+IG2J8xhYT2nRn4RChEQkkMF8wDYoMqfx5nMQX1zyrXP8KIbZkwthsd8g0UJFa4g+kK5T8mO25tIMjc9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a05:690c:620a:b0:6ea:e559:d69c with SMTP
 id 00721157ae682-6eae559d710mr212777b3.5.1731133149313; Fri, 08 Nov 2024
 22:19:09 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:08 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 21/22] perf python: Add __str__ and __repr__ functions to evsel
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

This allows evsel to be shown in the REPL like:
```
Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path.insert(0, '/tmp/perf/python')
>>> import perf
>>> x=perf.parse_events('cycles,data_read')
>>> print(x)
evlist([cycles,uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/])
>>> x[0]
evsel(cycles)
>>> x[1]
evsel(uncore_imc_free_running_0/data_read/)
>>> x[2]
evsel(uncore_imc_free_running_1/data_read/)
```

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index a71bad3418da..0d71ec673aa3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -781,6 +781,17 @@ static PyObject *pyrf_evsel__open(struct pyrf_evsel *pevsel,
 	return Py_None;
 }
 
+static PyObject *pyrf_evsel__str(PyObject *self)
+{
+	struct pyrf_evsel *pevsel = (void *)self;
+	struct evsel *evsel = &pevsel->evsel;
+
+	if (!evsel->pmu)
+		return PyUnicode_FromFormat("evsel(%s)", evsel__name(evsel));
+
+	return PyUnicode_FromFormat("evsel(%s/%s/)", evsel->pmu->name, evsel__name(evsel));
+}
+
 static PyMethodDef pyrf_evsel__methods[] = {
 	{
 		.ml_name  = "open",
@@ -802,6 +813,8 @@ static PyTypeObject pyrf_evsel__type = {
 	.tp_doc		= pyrf_evsel__doc,
 	.tp_methods	= pyrf_evsel__methods,
 	.tp_init	= (initproc)pyrf_evsel__init,
+	.tp_str         = pyrf_evsel__str,
+	.tp_repr        = pyrf_evsel__str,
 };
 
 static int pyrf_evsel__setup_types(void)
-- 
2.47.0.277.g8800431eea-goog


