Return-Path: <linux-kernel+bounces-351573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73760991338
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3AEB23F44
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7AB158870;
	Fri,  4 Oct 2024 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsUjdMx7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1569215572E
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085292; cv=none; b=mAGo7qj2KBphqEScqpz83fDieeijvbzDUJEO5GfNtgaXQV7xgtCCvVCcrd8YqVWZv26xCqLaTe2l1vftBDMyF+vQ3DUT/sc4O5xuC5toB9VwH8k3vYrZkuA3q2NEjPO2YF0KGJRhUbVznyWyk0+CGWYIP9MDF0vaFKZMRQDr2gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085292; c=relaxed/simple;
	bh=582DRnB5Pp2nT0TmmUs1PKu6Q4ckzT+k5c03nxLaKLU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kbnDusnuhDwNlsnqR9j3gZ61WgByEFfAN+WIwQMPoNhWka17ywFLAWrdD3/LqplcJsxCFVdtEP9GuYOxqGvPGs5Dw4/js2+dJFaXRibUOhXG0R6Y5OWXm2DWv4xMNE5urzGh72BTNA97eTuaSSjI5kNjU3iX4mKeA+61HT68xPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsUjdMx7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e288a73e967so3028264276.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 16:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085290; x=1728690090; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKmYAtBHo12nlkSZDOvO0LdX2ud+8CKD/pmfUApXbfo=;
        b=KsUjdMx7fWtf4NOksTLfaumdkjdkiS2dIxKe6zQmKfMbSyc0EnLR4Q/h7ZBB5oQijs
         zeVVnluVzDRv8Pa8Yby6jy9tNs1+5+35UisgJQ9dbAnpeVteoQdqjL14RnvQqa5vx1lt
         TFW8FbZwXIFLWRJHbJIZ2dGIiZ5f8W5JHMcYlRmBO9v3bcRcVJqmIea32GceEanCLSas
         PPSPQszjuRjJ1qwv0F3lzmPYFgC9SzeBcxceGbnN9l/QrfRfyt0ym2NJpexElfd4Yv1T
         7ceZsOBv36ryjdd8esy8iDdTxOwox3cvhOiwNs19k8Ax6RHzSDuepMxmMk4Abr/DWzTd
         jsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085290; x=1728690090;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKmYAtBHo12nlkSZDOvO0LdX2ud+8CKD/pmfUApXbfo=;
        b=NDrqGpefdCy+CCRV0Mv6oMsmkJTQarzzUv8VcWJGPT4U8zbuPlRG3Dokf107PW2j3q
         8RgCU+WNQ2Rjq8AFq7fciaD56E6vRLL4OnwVeShXncBFPSVvbrDDZu09dBRR+bQ5RPyI
         g/vKl3UYU0lUXZmMXEOwmgXhr+muGLv06ewOm1br/0aUoUYS9oaopG8aedBB711s4U/O
         oDHxHWm38L8XerIOtm1vBn1SQakGSQr6egxksMIaZFg1DZ1sA7fVudjAhbsqpnWLDr99
         /9ZDOhYR/dfyG1P+CKvd4kDlIWrMv0u5ddBIvBbvbHyOVIXKZ/UNu06+GrSimWaR2r96
         awPw==
X-Forwarded-Encrypted: i=1; AJvYcCWzr75qdymvtWF6ECKi/FvA6YIHvdGlvuwEbxjT5xyeWBVwMEZDS28yLoOwW/53pvnDwC8D0y/Hgz0V7C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYyw9yopDflR7X9ZXK0MT3lMr0ZZU3AGU1DGRh342qEjeJnwf
	65NHrZXckifvjM1kYVUpRLjntJF8QCEWh5gj8VxfK3gtwb2rwbVvldlyI4DlX+N7WUChr92zgRb
	R6wUjGA==
X-Google-Smtp-Source: AGHT+IFIP1vxomIUR1izckKXkT0KBqdFIx8rKTHDFttFm5UhBt8Cz3r+IBAR/Uuku6pVTLADgrA8Md0dEdz5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a25:ce88:0:b0:e25:d596:4847 with SMTP id
 3f1490d57ef6-e28939190b5mr10441276.6.1728085290158; Fri, 04 Oct 2024 16:41:30
 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:15 -0700
In-Reply-To: <20241004234120.1495209-1-irogers@google.com>
Message-Id: <20241004234120.1495209-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 3/8] perf stat: Display "none" for NaN with metric only json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Return earlier for an empty unit case. If snprintf of the fmt doesn't
produce digits between vals and ends, as happens with NaN, make the
value "none" as happens in print_metric_end.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 5402998881c4..e392ee5efb45 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -609,19 +609,22 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
-	char buf[64], *vals, *ends;
+	char buf[64], *ends;
 	char tbuf[1024];
+	const char *vals;
 
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
+	if (!unit[0])
+		return;
 	snprintf(buf, sizeof(buf), fmt ?: "", val);
-	ends = vals = skip_spaces(buf);
+	vals = ends = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
 	*ends = 0;
-	if (!unit[0] || !vals[0])
-		return;
+	if (!vals[0])
+		vals = "none";
 	fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, vals);
 	os->first = false;
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


