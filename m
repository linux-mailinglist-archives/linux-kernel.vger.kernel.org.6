Return-Path: <linux-kernel+bounces-358091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27CA997A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476BD283622
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE491714AC;
	Thu, 10 Oct 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x5xIBqVF"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C4139D07
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523307; cv=none; b=ASCq9q1eDG6BAQ7KsVe9LYw/C+nqZ/AJ2VRNKmzoF1hSW71+Gi3xdDOj5G0vPXgqnWY2ffoqUhFpxIdo1IgbFVyojMwerOWClObwDE/SpzSOYjQ7gqblWyRX2VDFdP4bbM5UxQ2aBGb0lacIwIsxwD9qUENIiK5UYrC8f1IOPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523307; c=relaxed/simple;
	bh=K+iLRNmPq7pFFzgCwk+WDV1uDJdmXtPtLhF5jSJiB/Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rtogEZ5MhyFjVjfO1+4HpBeh0yty0fgazyWbJwLvxmVXLbqOnLo9M+yNKR3JoUQ58Nkvfuza5M22halFyggHGrnId4x0RcaGJ6w7+U8UVvBUMrKTCfozf54KUo+4FPr9DBF5TcPQcpdg+UUVLk/XXssqmQtG7ByKsucWeG6TqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x5xIBqVF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e28d223794so9563997b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 18:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523305; x=1729128105; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJ1kKijNUBB3h6Uf74qin1j8xVsGkQayF3LcGNTjFTk=;
        b=x5xIBqVFeBxtBJdwdHQEq+nnoA5B3ufa8P1FP9ZvPFNTVXl+b6KcLx4l4DBH4imNYk
         pUcmXtztjwyByctOxmWsEPHnh2u2ArBUC6lJAeGBvHw2VIE90WxFsumojuKwHQPv81hU
         ALrvS8gaH3zpHvo6oqwkWs6hFTfkwn2TfQhlg7+0HmN6lvNWngadZtxr6soXUXS0qJUc
         KOGJneq7rQC9neCi1Qvx7ohl30emiIgNfX9Y61mCoqNMJXhYSNSQg8KnFD2MAxkeWf1C
         oQ5r7DEvYWk2mAFPfNHXuIrjXMgaseVyJddUUoPU2h2i0aSS2WV+4yZ+mLFFuqEHy4p+
         vcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523305; x=1729128105;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ1kKijNUBB3h6Uf74qin1j8xVsGkQayF3LcGNTjFTk=;
        b=eOcwCtGD/wAfdnU7dVGoi79agkBepikOmiN5m5hVyRpoD/8e96yryHAjsxmDvHggYV
         pjel9cXWogI99rtGJPY1uu0nYGSDVM+aW0FAFdHu0+U0hSEaspwGm80C6hpjFaQzpmin
         oUi4djsjuuI4QBegV4oWbyyKt4Q2k+bdAdWxZFCeiMyoHpxMRo8ogDAzZudGP3/A1JFZ
         KyR9FnkoMAA0ufLYQ1HhJ0uFUCAGHZJGvq72gSUZc5x8tdlayK3ZWJXZUl/RnW7Ma4pI
         E79FaOJJ80cvC2idQJvxTy69XkeiiecrVR3bvnR/9o/XMCxE2otnE7VEnpPo7DyhgjFG
         Z2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWAjOOLLvoIMNl5yv7FQz4Kd0xhcI/sEWXEBwtQIJJmJDbzHLEy72awb+wc0PS1EjNBMnqfrQ+6eJjiauw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT90DcPQK6hSd1qvSjASvAba0HS2qbhbCuN45wXNDYeNBkl0UI
	pMg7ppp8ifBbYqyImaCax89PunnZm5aXNHdGdcR99YxVQ6mFRjCTeUUsmieUuyoMcSxH3HtyxPT
	ulppLXg==
X-Google-Smtp-Source: AGHT+IEJypg576UbQ5VaDO0MPAIHZNmppJpIj8JxQULvGLPW7W7ttj6J21OnaqDWDcmGmHFVb5umycK+sA+N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a05:6902:4ac:b0:e28:fe07:e7d8 with SMTP id
 3f1490d57ef6-e28fe439b20mr61632276.10.1728523304658; Wed, 09 Oct 2024
 18:21:44 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:21:29 -0700
In-Reply-To: <20241010012135.1272535-1-irogers@google.com>
Message-Id: <20241010012135.1272535-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010012135.1272535-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 3/8] perf stat: Display "none" for NaN with metric only json
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
2.47.0.rc1.288.g06298d1525-goog


