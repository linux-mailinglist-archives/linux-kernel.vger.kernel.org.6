Return-Path: <linux-kernel+bounces-368534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA6F9A10FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB342832CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C292139CF;
	Wed, 16 Oct 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkB0J/f2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B752141C7
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101243; cv=none; b=sWSVdDEOey51AIOLhp/noFg5NNie+n6KLYofh3CwYVUvTNkKY6cvdTQQY6gkUt0QsFVWKd/gY0H6ycWyQ0/ruDnBhJaVpCGbsIGO73uBnZbWxC9nHkWIWDU1vV8K5rpyyi5W2iI+gXhyj20ceMkgD3BcZs52eFfGGY6qOF2IS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101243; c=relaxed/simple;
	bh=d4p2SSC+jRmzGX9QPS6kNxF3hzHXI6/kfpx81KrMoUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kzz924P1YpDFpSpaHDvbQJQu6yxYHTpQ2JwjEwO+LuOs3XX47PXMlVj/flGcMitLy0LQ06CHR1NFq7i5K4PDapVpWHlF2uM13lza6h7IvsSbNkeGdKhooys6DoVx93FAQc6tL9JkBZfW8pnz6VdiSo/s/f984JbMVf2Zw1v0Lu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OkB0J/f2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e376aa4586so3341197b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729101241; x=1729706041; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82hKZR8Ty5xgYC+xyYfKClAaNBzZJMlhS4+fNhwIq44=;
        b=OkB0J/f2hP9TFV7P62zun8ZB0OuWZEPuVPtCU3UYh2Eal0/ZyFLfyTec4jSYx8Atru
         jrePS5Ta9uQGL5gYxSy6QIEAAmGNY4Stvw2OOYOYM5s8f4Ec8hy80s2XvcGftyRpuMi5
         LFl/cK6EgnulqgSUxMBMs8/SHeM/1kkgnDpSKmJQDHcawq1LI40nMeNQpJ+u6YpmGeSl
         j9lBiSLGXVNAGyRaTWIv8unVz6JgPxfdefk/5diag7COe6tinlnaZWliJsiaWQNt4gCl
         8AZqBwDLW20zA89+kBgHk3nDNqvLOrYUewYciqHj3JeF5oq0u3oZTRxq9zY4C1YP077J
         lq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101241; x=1729706041;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82hKZR8Ty5xgYC+xyYfKClAaNBzZJMlhS4+fNhwIq44=;
        b=h2xx5YOoH0JxC4sjlMVMQZzIXM3cUMjIceCySCN3Xe2bKP/T15nR8V8p1yaxKv4Oyg
         UnxedkxoN1FN7MbfJJ9Pa7ju927Pyi7g+LGivoBQBXwcqd4aZsmA9ohfU5GDiFByydCC
         J5Vf/gP0pjSIAupfTrNsB+LVyX3D7V0DMEMPychRrG+xh/Q2b10V6vF0xU4TXcPcuMpR
         ntpij8TakpI6HcQK+YKA27LHp3wHcob5i27Bvs8LY+PTjj6MsXVd03yZLzlWBBj59VVu
         tx/CjV43Ii0PYJ+v7cDhwnwwbxquEAVzX2d3b7UScQ371adtTC7R2tR++19aNORt1Dkl
         WFhg==
X-Forwarded-Encrypted: i=1; AJvYcCXtyEHgrC8KU3UhzCKch60WbCOqj3rjfE8wbZ19hXdDVM7ldHRQzfnDsuop4wG/FZOcWgPRuvMm5mSXrHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxnpI9YXVtA4rVHGAfmt1h+JhK4S6doS6aU6Ain1nUmWwc0T8
	k6Y6ognRxOnBOUOd8DatIbULWVKqMzskaY7dcS3yOHl/fCqoVGxNykp+Xf9YfZJLb1TFBfWX8Yq
	51eE0EA==
X-Google-Smtp-Source: AGHT+IELo/jxtpIhUM+zuErAUU16bxjwCcPutOaOC6eTpP+GPy7PKQPs4wQx1eWp+F3YHF1VSqeKWTcYrvVB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:a227:0:b0:e29:1864:5215 with SMTP id
 3f1490d57ef6-e29782d1629mr2522276.1.1729101241059; Wed, 16 Oct 2024 10:54:01
 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:53:45 -0700
In-Reply-To: <20241016175350.116227-1-irogers@google.com>
Message-Id: <20241016175350.116227-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016175350.116227-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 3/8] perf stat: Display "none" for NaN with metric only json
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
index ef0ca8cd802d..a137b377efa4 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -610,19 +610,22 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
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
2.47.0.105.g07ac214952-goog


