Return-Path: <linux-kernel+bounces-358092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A827997A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5272282FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BA0188938;
	Thu, 10 Oct 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHNU6si7"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97D16A92E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523309; cv=none; b=JQsMtRbIIxt1HrrVo63DW67tCvtjDf3y83wa1j3NhwaaiKaup5XDTbngnIVVREkFSyXyjicunE7bNf5TKds+eBBC+cK95MRcVDcdTbgzS2xMpf0GOU675pZOinipH/C6ClmkxlnweaEtMZTcA6PUfFm01c9ddn2kotTJ/cojKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523309; c=relaxed/simple;
	bh=1azV7E7FNm5ZgpAvEIdQ64JI8F44TJjzhA8h4p43pa4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=P/Dls/SdVcY3a/MjX9IoCdpTNa1syv9pnxVzI0/y0e+AMsISJ9OL0A/ubJIe3PnYDquLFjjHCLRbjwRh/9eXuyL5fFz0wOU+053SwciMN7xkwKc0pAzGyyzLwbFu3QLOh7RbGD3WWi27NEr/yvA38ID5ymsEYkrROI76XN4rhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hHNU6si7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3245ed6b8so11161917b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 18:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523307; x=1729128107; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1XFcCPRE5WoawTRbLhb/GdnJyywM9jpDE6V/JQJDp0=;
        b=hHNU6si7JZaoWpjrzgyWVMduBBudici6tiIky+NZGGCK4jqEKwDbks83xHRwNe6KKX
         DuGTk4zp4WeQeIV9lzVCjZx0fIFTL6oluhsIpXir1dahKOxOaEWD3LAeRVdEx2ZSBTS9
         Y77A8jEmGS4mlbPjfDTI6RhpXePH7yRkxf5Yho2QSK35ECvVnzVU9+ZgG7kLmh3h3ya9
         SDgUDstNPxSyW8G7xCzkrTh4G22floj4GqGvWsBF3jbzC3QANe12bmug4eTM/F2WbW1H
         5qrIb+gePXe/nPuJG8d3ZHdjmDkC8P/39JAEkL/aWvmdEp6GBKFrlyj7292hksgFln3C
         tK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523307; x=1729128107;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1XFcCPRE5WoawTRbLhb/GdnJyywM9jpDE6V/JQJDp0=;
        b=i5vm5idqyrhncUEK4LRUtcJ8FW/WaglmXZ9iqNRnZmxzWG4bWNLZUseia/FpGTMcip
         8btreWFQ27k7rhpEW9Q+8qlXqitTar8clumWvYBKmwmKe+B8YTpQqkUZjYRserh1QFo5
         Z1fSihZYyo3lRF8z2gkpY32OhLv3z4+0KDHSiXo14GTO9Lk+dwz1rcbOLvBa8zt2mQ7f
         kR5vZcINm5kQquBYPyjeGdJ9mhmnwIP3R6zO2KxL6UvKOe7cnHNJVRm8nDp5aTDnSPOY
         qwzCrGd9bNsNW0SCl2njTzeyMIQoN9jm+AuphSycWCgqBCIwmjTam/Ayelqpcaot4dX1
         0UJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU5rmNqKbmioqt1k8cQlNc+9tufUHG5kJcrntrfdX15okyAXwMS2guNkTeGB4HTIlJCQqwYfsdM/vmogo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmlSJVuiRADnXe9LXsYw7PSQgU0zNd87MPc76EdHGPk6CMSb8t
	Cdk5PWEZRq/aQ1fFm32KZKcZDeg2ZQW7rLg2U9ORhCSGy5xrPa1gwYtyn58a5aSx3tHIMp7Na0n
	7ZVJBZA==
X-Google-Smtp-Source: AGHT+IH/Ad5uqCUblxRnAXog3BTfXT0jL5Xh0TWAOrvBEeg9poXkASqKARbLzbeTDuRshUQbzG1dEiobfRav
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a05:690c:2511:b0:6e2:b263:103f with SMTP
 id 00721157ae682-6e3220e2a8bmr549377b3.0.1728523307301; Wed, 09 Oct 2024
 18:21:47 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:30 -0700
In-Reply-To: <20241010012135.1272535-1-irogers@google.com>
Message-Id: <20241010012135.1272535-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010012135.1272535-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 4/8] perf stat: Drop metric-unit if unit is NULL
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
index e392ee5efb45..6bb048fefe9d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -470,8 +470,8 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
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
2.47.0.rc1.288.g06298d1525-goog


