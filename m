Return-Path: <linux-kernel+bounces-368806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 848359A1523
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF0A1F21CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA011D4615;
	Wed, 16 Oct 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yxBxVH8i"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00511D4359
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115524; cv=none; b=DkJM2LWJ/1yP3sVxChEDcB73E1pz7D4V8Ric6b2hiLmBMnkOhu/UDfXhwJUCNDbMy8otxz6CVZk9QwLD9eCW0LHJFybpJjNaMm87P0IDK4wdXpRhtgf5FswG7zov9jiZxlKpJCrNVlog9Qfw0oVZfK2EuBbnhIyFWQlGjn8spZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115524; c=relaxed/simple;
	bh=tWKJqnfBwSOmrMspZ2sdkDVmtmOQkJadh5Otwb2PTrM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XTMD/ex63gOyFHnK1mejK2PJaaP/gw+oYfNPf2jSk8dBFFNxaRf0RoUS+CNiZRnbXW9pR4zXqifQB0/CrH4O1BLnedd8t5ykcGDYWuuwTKh6eK5muunnqkwcI8aQTrC2M1Ek4GykgoJGeypfcxITxzM0XvfCO5jCstx7/HQG/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yxBxVH8i; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290947f6f8so533541276.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729115522; x=1729720322; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=yxBxVH8i3u+xGNDryIDhYNLmlk2A3zJZUg/ImHsTvkb2e76g1NRuc5r2BWS1/CRPdh
         yMm4REhPLHFweKGNw7JoWvznT1mIRUpOdA8Y4TtI0Ej1Klc3+ZC9bGyYUd3VyYs3/5Gb
         F/QryG5TlU840j3aDBzF5g9OHMJZXTGKRfMsQPI/bHvgdxxcbAr2lLkSGzVfe20ErJM9
         Cm/SIyvWBcnPgQMGCaW1dw0p+K7zLeLXsqWXtkzJDppNBVJ5q40WFTO7zqRGCzJ8dKIX
         TISWi0R84jOMhNqkaAbSUaM0l2pM5qfqQtnIlIoaJyU2t5uUxwMgJj1JQNIx9JqnNmCK
         nKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115522; x=1729720322;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2/oyoGU6HrX/Xxl9SMoDXlcRLOo1IYbCdJ0T7Dlej0=;
        b=QYllCId+EmBgrdlv35Vza/ajIvivbKwnhF6k+70NgFE/FBCkX5XxE+t4yhkH7FsQaz
         Y91iP12ntsm5ohtfhygHw6joGFmvikoOfkq6MbOxNw8yEMCmC+X/kVosS/py+3dVXYMw
         8jbFmsupdCZye8MzqxD5iRlYgfvGdILFd+mj/EngU5RvrRiKJ4aRUe5/ksrrez5B+3+T
         DzlTTrznVtm+DtRMaGCZw0Sm72wEby9cjYFcsuEWGzd/EjUpxxsgBNIf6tVtiMyEY3l4
         f+QLbRTqf7DeiWXwNATzzuEALL5iascYHIb1OKxbjKIfQzWPPDWRafTgBRisSbqy6fo1
         ntjg==
X-Forwarded-Encrypted: i=1; AJvYcCWldxHpAfrsxt673/jXH/l9iEXZirPDLrZX60ifitP1XH/hfxw5RmoPPFWRezfrwu1OLryBZfDoeGqQCPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPbZfm/2lTaNjKm7oFOH2wlsHjjAbw9QWAdUyuN1YzhMi7Ye3
	MSFdKZr/zmVuujbATRosB2Xw773l8renxfYXJPiVIi2S0ll5SeLvhXgk4Fg7FRvHzFdB8FZnO7m
	2U5YicA==
X-Google-Smtp-Source: AGHT+IFCBcL2WI1OJ/qL8tTsZfu56WPN4fK7Lp+XqvP5F6nW8xQvXYG5rGEA97JIV3Z+cvI8Pf9Ow7NrHkAi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:b204:0:b0:e25:cea9:b0e with SMTP id
 3f1490d57ef6-e2978594b05mr2587276.9.1729115521830; Wed, 16 Oct 2024 14:52:01
 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:51:35 -0700
In-Reply-To: <20241016215139.212939-1-irogers@google.com>
Message-Id: <20241016215139.212939-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016215139.212939-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v4 4/7] perf stat: Drop metric-unit if unit is NULL
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

Avoid cases like:
```
$ perf stat -a -M topdownl1 -j -I 1000
...
{"interval" : 11.127757275, "counter-value" : "85715898.000000", "unit" : "", "event" : "IDQ.MITE_UOPS", "event-runtime" : 988376123, "pcnt-running" : 100.00, "metric-value" : "0.000000", "metric-unit" : "(null)"}
...
```

If there is no unit then drop the metric-value too as:
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a137b377efa4..c6d33010ed22 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -471,8 +471,8 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	fprintf(out, "\"metric-value\" : \"%f\", ", val);
-	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
+	if (unit)
+		fprintf(out, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.105.g07ac214952-goog


