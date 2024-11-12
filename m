Return-Path: <linux-kernel+bounces-406269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA79C5CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1732807BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6E206965;
	Tue, 12 Nov 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQcPztln"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207272038B2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427288; cv=none; b=H0rfhb8TQA6n105EQCNbJDuohuha0urgjikFC29lVPFU7bFCi3x6EN4br6XHpmxJJyByuGS/Gc0V8FwrKnh/6suTNTyrY8Tee55feF9xOrTseV0qFyCKC7d/oxlReGtd8h2AeMfHfPcLz+ea2drg806/KyJyIQkciiiHwOBbtSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427288; c=relaxed/simple;
	bh=1rzp7Xl7P06k2CmvvFaVmBBb4PRTEjX38R5QLmMlCTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=naULUF12rQVY72Jy/j/5NHMkghDE/CC8MZKGDlwMyllEoY/szSuLrVXE/3mzjPPEp3+Q+N+uEuYeISpYt9T0s5znkW0fIHOOGKKrJQvtacM/l+V2R/LVSLUIBniNrT278zYjFHSXXyPxzRykQbd2UH3s1fZHrC6mCp63pEN++VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SQcPztln; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso43249761fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427284; x=1732032084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISx4HBtk0wLWMcNI0N/GFnJvPZUjZ9eymzjpVwEnOrg=;
        b=SQcPztlnbSGOMkTrOcZ0d/HVkF0rrOVzVjmkdcQRAyqErhqfukMj0KyDH64JVw2gmB
         NZDLubopxO9Y7ecxgtga9BGSy5TajHHc2h+LUyxQ//MaeuP8C4wiM3QCP1McrEI3FIcb
         vleF1PFp5LFE+CT7ZjoH+ZD9Mkmn1kWrUn6llyP08DG6JwDlENtzxwJz8WPzFRX2I1QQ
         8pq8Z5m4FZd/ivtYw3bsX5Jeg0VDDBkxvH4Gd1Xv+i0hCOWKd4ZGwuECzrdcfD6cJaaC
         70bJCmjIheYLmkn0WljPSRvNbv6rbSFaT9qhEmcPka2KlvrGEL6puycATPAsEvTAUDcs
         oDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427284; x=1732032084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISx4HBtk0wLWMcNI0N/GFnJvPZUjZ9eymzjpVwEnOrg=;
        b=ljg3Yj8ynYbkDQM+kR44uV6r1CoDvk3cA5FJiBa9oVpXo3iE1/MPlP51vOpBPrZzcx
         EC4gFxhF12sZ8dQEso5uieE+Nlr46swB6rSCw9X+501843E9AKiNGPSeE3gIRj2/wUMt
         6t13DwJ5u9EhZL7Yd9hrojqU3VKhhd8Ub0CGBRl3J8v5uZhtIzZt7htb8GkNX8h5qtq1
         KDwgYcPez1YRzejBOjn3C+pjMkGztUD1ZU2X6/25U1nBT4GirCDGB2zP2Mh1gAw566/u
         E/K3hEWNgCNYyWKMR1UAGDuGFXVpbsqLGsN5gAt9L2WAsf+S23lnlzQSYwV5WSsCWKV3
         feiA==
X-Forwarded-Encrypted: i=1; AJvYcCUIb5UAOZ2UvLK3jm5ft52x66oAFZnUxft/gd1g8fyAEneBaM3K/lUcglSeMgz560ELuK0QKfoRZMaSOAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/c5j+dirnC1SqnOEOmKOFGlykk9UR5YE1EzpaSRrIbB1jrCCw
	Y0RhmRKFGA7ejEydb+KBRwMMjkpD5RrIrF61mUVcJ5TuOwr+lUjWTvEjiUK/44g=
X-Google-Smtp-Source: AGHT+IHgpDbdyzkDT/BkZIl2yFqZeTww3F6522828HUJTjSk4nrZ91f4e8V+Rz4bFuQLgoFWQ6mAHg==
X-Received: by 2002:a05:651c:881:b0:2fb:628c:2580 with SMTP id 38308e7fff4ca-2ff201e6d03mr90939261fa.2.1731427283738;
        Tue, 12 Nov 2024 08:01:23 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb760fsm6148172a12.47.2024.11.12.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:01:23 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] perf stat: Remove empty new_line_metric function
Date: Tue, 12 Nov 2024 16:00:43 +0000
Message-Id: <20241112160048.951213-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112160048.951213-1-james.clark@linaro.org>
References: <20241112160048.951213-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Despite the name new_line_metric doesn't make a new line, it actually
does nothing. Change it to NULL to avoid confusion.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/stat-display.c | 13 ++++---------
 tools/perf/util/stat-shadow.c  |  5 +++--
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 0e16eecfbad8..aa74543ae298 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -673,11 +673,6 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 	json_out(os, "\"%s\" : \"%s\"", unit, vals);
 }
 
-static void new_line_metric(struct perf_stat_config *config __maybe_unused,
-			    void *ctx __maybe_unused)
-{
-}
-
 static void print_metric_header(struct perf_stat_config *config,
 				void *ctx,
 				enum metric_threshold_classify thresh __maybe_unused,
@@ -839,16 +834,16 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 
 	if (config->csv_output) {
 		pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
-		nl = config->metric_only ? new_line_metric : new_line_csv;
+		nl = config->metric_only ? NULL : new_line_csv;
 		pmh = print_metricgroup_header_csv;
 		os->nfields = 4 + (counter->cgrp ? 1 : 0);
 	} else if (config->json_output) {
 		pm = config->metric_only ? print_metric_only_json : print_metric_json;
-		nl = config->metric_only ? new_line_metric : new_line_json;
+		nl = config->metric_only ? NULL : new_line_json;
 		pmh = print_metricgroup_header_json;
 	} else {
 		pm = config->metric_only ? print_metric_only : print_metric_std;
-		nl = config->metric_only ? new_line_metric : new_line_std;
+		nl = config->metric_only ? NULL : new_line_std;
 		pmh = print_metricgroup_header_std;
 	}
 
@@ -1319,7 +1314,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 	struct perf_stat_output_ctx out = {
 		.ctx = &os,
 		.print_metric = print_metric_header,
-		.new_line = new_line_metric,
+		.new_line = NULL,
 		.force_header = true,
 	};
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 47718610d5d8..fa8b2a1048ff 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -327,7 +327,8 @@ static void print_instructions(struct perf_stat_config *config,
 			     "insn per cycle", 0);
 	}
 	if (max_stalled && instructions) {
-		out->new_line(config, ctxp);
+		if (out->new_line)
+			out->new_line(config, ctxp);
 		print_metric(config, ctxp, METRIC_THRESHOLD_UNKNOWN, "%7.2f ",
 			     "stalled cycles per insn", max_stalled / instructions);
 	}
@@ -670,7 +671,7 @@ void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 			}
 		}
 
-		if ((*num)++ > 0)
+		if ((*num)++ > 0 && out->new_line)
 			out->new_line(config, ctxp);
 		generic_metric(config, mexp, evsel, aggr_idx, out);
 	}
-- 
2.34.1


