Return-Path: <linux-kernel+bounces-370357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA669A2B79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F011C2664F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0281DFD99;
	Thu, 17 Oct 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtXbRUDC"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D061E008D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187650; cv=none; b=aeZl0PpeFsfKXCDyUgfnvHl33O+AoYOPTjMPErirR7xupSYcBRe94j79wr9yxO4gMatn4YlzdilCJwmIXJtFDxqNgWY1yf+uNclFNn2s+8tLjz6rXQYzjG2TWMIlc4jXlHc/NyyNimtCIUjCa2BC5ZLtg/wg+gsACfN3qCBFde8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187650; c=relaxed/simple;
	bh=d4p2SSC+jRmzGX9QPS6kNxF3hzHXI6/kfpx81KrMoUw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KC0R3iOVttbeIiqATHz21qt/cGf3rXN3TCloPqZw3l/+v6ZtSXwiM0Ds3E4eEO16+GqwK0/c7gi2Aq3JrKbu3JO31ng6F49CBrbFqcqGpMMsloNZb3ho3KQMhnB/d/Iar5emzs9P+I9fJlTpUyNpiQ9S7ikdjiR8g+pWr6gH+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UtXbRUDC; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31e5d1739so21682827b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187648; x=1729792448; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82hKZR8Ty5xgYC+xyYfKClAaNBzZJMlhS4+fNhwIq44=;
        b=UtXbRUDC+PD/2L1h69b6UO3C7Arl5kBYSbI6DP5EQb2f4Hf7Hn9aAVUOJp0mcxU2n7
         FELYmGdDFyxea8EyxdXslbt/ZLS6qBIOIyUoiqGjpUrat8Yr8gJWQsjMjkN7uvptiA3M
         ze/uXusPm+Xr7FC8Nx91ek/R6X8v3fH5lNzJtPjLQ3t4kSnLQJW5T13e9DVyVKSPMHIW
         4mUJqYXHcHfc9gmuq5wozX7AxFZyOcm2bgkB4/1kHuZWRTEc2/kqE+T6nh7XC92mGdPD
         m0AU+JSOuNbUZ1Q4Et4bbLO4DZFXbnZhWgSdUZ289ME9dI5DNGNe+k5L2DXOMQjU4dWE
         6Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187648; x=1729792448;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82hKZR8Ty5xgYC+xyYfKClAaNBzZJMlhS4+fNhwIq44=;
        b=a+h0kwlThloY/3VsyzIpdihuB+MF9YfTAziGEVDaHrbaCO0ozJmzfjhqbbaA7fGewg
         OLop3T2g+fdRS0PzJ+PKEZ5OVoLtT2ieCKPch431S9ELFM4CCZpDmboWlrKpTJl3Wg2g
         Gm3T9Dgz5n7o3ehuGopvEJlvbFUVXGpyXqNzw9utkAV0MQV8dEX9XksU8y+UOmGMPmxz
         DB/g8qn1RE6J2/sP5H5BdPwqtPZgNVEfGF47FZLkhkUM4nR/cbYIQsyEiq8CJ7bQ1vzX
         W8R5senPgxg8fNMFvPOkYElRZs8BIvGwYHUrjawFl03xis6syqqPt8geOWAoVCRN+uv8
         1yVg==
X-Forwarded-Encrypted: i=1; AJvYcCXcwAGfo9PauKGRISBVTFm6IDcM8ago//zcNhj1eE8kcPoW7XlUmKVQvcINe2ppnqDkVCqjvbvY/fVpDQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pv8Qdhgbh/y7yeKloqw5E83EJzjC3wLeuqaXBdmOnl662zxj
	Bjw5t3oGb21DNRFCdRbxtmCdiw1Jbb+A8ZCH/4Sh3V2gsEWiAHB7Xb+2lGjiOYTxDH43GtK9Ehb
	pI20giQ==
X-Google-Smtp-Source: AGHT+IFWI153JAZftkTDRK4H3G+AWk03BVP1rqIrqsWHYCRDtPZDe81i5SeYYAG+nYoX4BSvPym+jcuhv3xr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:4d04:b0:6db:c34f:9e4f with SMTP
 id 00721157ae682-6e3d4213b28mr1776457b3.8.1729187648222; Thu, 17 Oct 2024
 10:54:08 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:52 -0700
In-Reply-To: <20241017175356.783793-1-irogers@google.com>
Message-Id: <20241017175356.783793-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017175356.783793-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 3/7] perf stat: Display "none" for NaN with metric only json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
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


