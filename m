Return-Path: <linux-kernel+bounces-368805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3909A1522
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D291B22EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C11D4352;
	Wed, 16 Oct 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOmWYb97"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57F1D415B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115522; cv=none; b=L6kFXbmTkgjNUTX84E5stQJZOKk/Ily6TQcTSKHwnanp20kiuz0/luYCzrqAAVntQ/bDjq1kMDYd8SI/xHWM4W9qe6GCXKtJUwN2Hj1Y/7uj/uOaDw7zW2z2cdq5ksxUbTUZ0DT7qMnDQkEIglUiPUhwh1g9vSaErVDuVUv6SOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115522; c=relaxed/simple;
	bh=d4p2SSC+jRmzGX9QPS6kNxF3hzHXI6/kfpx81KrMoUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=F3SGNYMzXIXJteQc5aBm39IIfEGRvKHCPsIl0gWVSFvddo4N638aYKwLKZNjMgw/6ix+CWiUS0TjH1pAsgsH5a/X3BA1ln8L89R+rg2eEIcC+8qAz4oXxbADaaUnCnf3hXiidk9bIH8+ngZLY0uKjh1bBh1l7+C7NQ64NOQq7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOmWYb97; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so7690297b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729115520; x=1729720320; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82hKZR8Ty5xgYC+xyYfKClAaNBzZJMlhS4+fNhwIq44=;
        b=nOmWYb97tgLhVRST7jIFxiX6+3C11QzzV9uORvsOUqmziOGWLnzrWTz9n+cAi0HxSM
         a70pLA5I7JyZmPbfvupyfJ3LIKtXYhjRw+ihZCudA8DjGja/fy6OvgcHIu96AZSTkjhD
         StnhIaBzSkhmwld1t0ltbj9ChjUkoN6zx8+dCTQBv8Vq+ioJzTWiIN3WolWMCDbLPTc0
         yW5hgjP1KuxZujHyVO688tEt3WD0tPbgk5dkFzUScVEs8IBQEsrqtBeaAqizjK/L+LuP
         bZFLq/RupkEyCOWE0DD4uZMwosJfok6iKNB2k4Xv2HjRAaEUMbh/NswMjw3mjjwRvbsN
         kGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729115520; x=1729720320;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82hKZR8Ty5xgYC+xyYfKClAaNBzZJMlhS4+fNhwIq44=;
        b=CoxhKxgzPsqYbQsvxoPweyEyrBfBOkv3+5IAvNE/Rxafh2e6SRA16JBKbfKpJZCsa4
         bPt7hSoDLdK+1pciYLIbPUiZPLiRR0ECtPCPbiRz7fegS6ZJPgp2Vby4MxQSG/0Q14QX
         JtxtSI7aoSd8pdGJ0rcCQIrlsKgguAdVn5kdXweosR7gLG8WTAFtFLLMFcLrIgZCRucJ
         AOHiY+QF5grGrIe+0bWjWBD/wCcQfWdwW4xuzdhfEadbkQHVgRVAYihmKTPcsk9Fv2vG
         q6KuaIIQUGYACCBpMfx+wHaPBVOFRFA8kVFBd1Z8SN6zZbg9PJl3X6nPNlux71CMiTKW
         vXRg==
X-Forwarded-Encrypted: i=1; AJvYcCWjpCV3NixQaZlfyT/r4YDdgonxPUG940sTEM7iJ5tyr7bPCdk3qovuIEkuGQHYakkDEt4I2ZnM13tEtB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfM3vP8jzWDnOcM/BrrEkKpc1XhGxE+d7WDY1Ns7BvvLGT8Ybp
	p/pfSn5Pjq5vztzu09m/M+hl+mWNfBDvNwdis5hPshHQKhQIMhe82FlvOgDMiIMXhgywjGCgx1Y
	curhX+Q==
X-Google-Smtp-Source: AGHT+IHYLGCrAS7wsnpPLNLCwRIdj/82Nvg4w9FR5SgswF7g/KhN9wQduXAv8HJvlw2EV2tnrt3IkAKSmr9M
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:4b12:b0:62c:f6fd:5401 with SMTP
 id 00721157ae682-6e3d41ca698mr818757b3.6.1729115519815; Wed, 16 Oct 2024
 14:51:59 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:51:34 -0700
In-Reply-To: <20241016215139.212939-1-irogers@google.com>
Message-Id: <20241016215139.212939-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016215139.212939-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v4 3/7] perf stat: Display "none" for NaN with metric only json
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


