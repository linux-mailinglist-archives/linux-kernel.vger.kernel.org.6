Return-Path: <linux-kernel+bounces-413686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581489D1D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128B71F225F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6EC19ABBB;
	Tue, 19 Nov 2024 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Natkp/kE"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444119750B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979117; cv=none; b=h2wHUmn3xcpgGiF2Pg6a+ZB+PQVe9srNx1gmNACgj8KY+ECoZrwnhYPXqtbTHHkXg6bG6fy0ZI5vaQvUDTbWu7PKZfLc7L7/xWpNuN2W9VMEwtMb7XEV03E4bdp+hn7A0ycxWQCPUxYRhg986uwMncyREICx4Ox3jr/TYXUWWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979117; c=relaxed/simple;
	bh=1/uQjVUHeicVOsHf6JAkjbXnJL4QBfvJdjKE/VYq2Hg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=YrqNSuq2E7L1PPlbiZL7D6gyJ7UjHNLO0+mV7fiyvc3UmubOF4hyIKnFpICJb9aX1XceBI8elOZXVSf/7o44nTT/l1TseTpE8YzyHRbATYxjkYrtF0VkxwGgWfq2lSe8FmGlmhln+wIaSi+pDDMCI8+GE5QjAxJ2v5GRYkgf5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Natkp/kE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e388f173db4so2471747276.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731979115; x=1732583915; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEXus1VjTmWCZL7mZtlARX6uzWRhwXwnNIhwzEO1AVg=;
        b=Natkp/kE8Dmhqggeb6AEydmCmUZgTOw2lX5mvAZR0q5od587mzi2ZaVtdOgSU3hqxQ
         mHJ8e/BjQ9r0W3zSFKV0VeUydXLBGzqbj2ng8vhUX+CqBSw4i9l1QhawLgJy/D1Q0Hie
         3AMiRGymkQRzrTjLkiCkZ0gyXazFsb5rMKQ4E8njB3aFxk6WCJVaafLZ5RwOU+vCrge/
         isk5VVI3HWOUFB8h1zIGuU6g4fVap/Bu33boE50H0wn9EJxZCKvrHO1mbN/RMgMRNiL4
         c0WP7hb7RZdUy6Qw8KaFIasOsFN7n5wnYNheiJ69EoCC2hhCiUR54GDLARxVI014QuFk
         fsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731979115; x=1732583915;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEXus1VjTmWCZL7mZtlARX6uzWRhwXwnNIhwzEO1AVg=;
        b=rNjBtXoj+IkQDiQhbKJUSycnIIU9te/SoZwCWLfI3XQCfylbO+IRnIcWpsWv2v/bIY
         dWh2bFVCAVdxsUTEcDnDMSnor0Ac8YEtjl4xRfEzUxtlcwa3iqeXyPDvyY7DFDo3q35t
         O5dbi4Kqjxo+GNzftfItnbX2T1srxDFVBM8/ehDB4PVpEaPxNPjwsswp8l906pg92iSs
         BguDkQPIzqmzMqMr/ImkOXmZDoBo7DP8izIOSmOX3BiKr3Rk2PYGeAG6J54Cn7+2Gxqf
         ozZZ7mSK4AmbsdUitAr1oMnVN4QEILv/bbb9pSQscM4TNh8XzTky7eoDF9wCG6J+OOJz
         VuAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDpBxO/xdKSoBmBuhBZBkmBWvTHaHzqRqC/z0PMCT75FtwRgadMFZ54UjBYpOOP9Blh8TJBvZRDIrqwSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcgRIik0/R549wjKAlwC2kqY7CFz25a1Bn/Z/Pq1kjJTgt3fK
	duY3XOVPNwOPu9H7/U4Bdavb8eBFXyIONINQVAiFpDAXw382Mj2ev4oV+HePF6iZUIqBiS4l5wd
	88wkXog==
X-Google-Smtp-Source: AGHT+IE0l/lVCzoB/5F9kgHVNu1aiAHNnvrmyEJm8D2E0OtwOFxbGmgFNGiM7iavdjs0oCGKa1aaFQLcNqOp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a25:d092:0:b0:e2b:cd96:67a6 with SMTP id
 3f1490d57ef6-e38263954femr9475276.5.1731979115075; Mon, 18 Nov 2024 17:18:35
 -0800 (PST)
Date: Mon, 18 Nov 2024 17:16:43 -0800
In-Reply-To: <20241119011644.971342-1-irogers@google.com>
Message-Id: <20241119011644.971342-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241119011644.971342-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v7 21/22] perf python: Add __str__ and __repr__ functions to evsel
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
index c556cbc582ae..893aa4185c03 100644
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
2.47.0.338.g60cca15819-goog


