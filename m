Return-Path: <linux-kernel+bounces-387787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEDB9B5602
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7F1B22A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240AB20F5BB;
	Tue, 29 Oct 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMtZx3By"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098720F5B8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241919; cv=none; b=sWSUY6FUov27sfvjsvziL4gAESqk40HumuyLzAh5BBH2X7ppZnPM33B7/I0gpthKCd45fKKkr5a6MkzXSXGKHcySJ4kNTzONL12RZy4a4D+rF9cpoMTKmpy6aO3gSLWTdZ7aWyq5nw7CpU0pUiwh3vwUKY4sCIZu/X4iwzdrR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241919; c=relaxed/simple;
	bh=8nfaXceOAmgiqk2t3wMeEWNA4KSjqafBiascjUECmpw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MRGDWV7ktLD8++q/GlZ8Tdus1lfFjBkqg3T7lfQfqCsSuTQZ8bZFip6qVh4/WebZSQyMGdc1jpElNuyg4G1efSIEciYVzGNPK9+XlRxhJfFyK4GGvnVJTlMEXy11IYp1/UKfMN6PiGKydxFR0R1osxLV4smFgh8yUnbzPGlFTVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMtZx3By; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32b43e053so89921977b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241917; x=1730846717; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dis7RmFKQzQzt6CCLpk0OQW/Lncdns24hHlJR2bLa6w=;
        b=JMtZx3ByDfCcrjnRCuT0Ed/BoikpbyYICxgdUDfgxnoTzZ2DOBWObv6XlPNpORrhIC
         8/UAWwwmemBFJsz7j9jG2pKUadBhbpkpKTYWA9/cn6T8WfjEcgQETwkyycs7xT66Xb2+
         EDVk+fd/sPA56hc7qFXyKDq+bNoPwr0cdLMUopeYfef1c2DIn5VpUYM6h55ExPDXvYo2
         qMg4UM/OD+cFSwx8pxnRDrKYLJCQl0luZCtCtAuf5blahFwAei9QZpR5+SsT9ELljzZ9
         hBx4sgUqaaWOtTxF+JfjJnJnE/Uz73NTS2o9Wegc2eBcFcLdya+TrOyL8nbzoGigOFH8
         c7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241917; x=1730846717;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dis7RmFKQzQzt6CCLpk0OQW/Lncdns24hHlJR2bLa6w=;
        b=v5o1VTQsQQKwLgGoof5D1Y2Ls4t0Qly2aJVTF0I1W785vibEc9KYE9qvUx1XP2P3eE
         D0Ja8EfL56DfRd55AMK6iDLotezik7XeTjhXk7TkSCfYCVqr/9Xp/FOk8ztpaeqZFidR
         FJzC24RKI9YhkLKn4PcsVg8cATypF0eqly5GqwM3DAXwHFuAnZ64sX7RukZ08AYzUKB+
         hK9PHX1TPExmDnG02L2V+isSkcWfhXTI0VPodOXdhMAtBvjkWh9bx4gHAIIqoQVH7pEX
         jmwJ7uNz8OBx00VeUkXybuLc9ALXdpls2pCr/kWc8mnFab+xwLBcAfmTh0vpbP0q3eUS
         GPrw==
X-Forwarded-Encrypted: i=1; AJvYcCUj2nxjpkMs8Br0bfxoy51+wZ1jf/6SdZSmSLwjgfDRiOCIcex6vKQR3XXNDcNHGgexLG0ohzzBJdg5B/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSE1z9QWfLYoZSidqLqrg/FCW/g0hApgcIGbYF+QWTQJSzOkd
	pBqpp/9ixk0GMrwPqPPUA3GkrMkPzm+EhryQJaHxAKPUjxtFDNxBC+p4txnDmAzMNxF13G/nQQg
	0GQkYKg==
X-Google-Smtp-Source: AGHT+IGYQb3NSPl3DR97IU9T7cti91p37aPy5/ZWo/WZtAv7Pe5mvapiQjRvDTW00VykvHHfDTyVqK+CdDi+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:690c:7092:b0:6ea:1f5b:1f54 with SMTP
 id 00721157ae682-6ea1f5b2d06mr3253077b3.0.1730241916675; Tue, 29 Oct 2024
 15:45:16 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:29 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 17/19] perf python: Add __str__ and __repr__ functions to evlist
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


