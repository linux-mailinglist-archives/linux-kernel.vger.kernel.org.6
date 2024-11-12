Return-Path: <linux-kernel+bounces-406272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22359C5CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424F51F23750
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457F921314D;
	Tue, 12 Nov 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7I7C9T7"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3654212F03
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427297; cv=none; b=q0vITaoHPYfFGI0pTI0tkDXk223kj/gB6y4RWxv5aYX0YU49kE/BHMdquOWxMx5nnxQbXBRPBwEaBHBn8xilC2EWfH92Ha2zNaH/0UXCUDZ8WHyCqSqO4tXUqRBNw88y2N0bn/OI+ZXMbA+XtjveQSvgLFuOfQ8ndHCnBd49/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427297; c=relaxed/simple;
	bh=E1GO+wXsMoWY5kN68+eZphs4BdgOqmXVnV4f83AYM5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFxVHhEe3PGT6A20JYccIw/zMdBpBiOUP5o0TdAodaOT0X7PUfQZdG/wH7DGfgRSYqwbxYPxe0kN+vSzkGypvyBvaetQEHcguihWMGro6oDXkYVl08WIrancsLycgCtG9T5hAM3+E5/aJ8Ji2PMoImy0plcmzmj9mbA74CoMbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V7I7C9T7; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so51261181fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427294; x=1732032094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1wxrEwtrIa/6tacdYcY+vjRhcRt6Rg8gQj+1ymAPK8=;
        b=V7I7C9T7l8uAfgfrw/Jpzivwl6SINQPxC+NgLuScQHz36ztp80mDLqOgi6jbLxa6wv
         0KCCgxpuAm4QOFyDT4XRA/5IwNShlvGa3Mvy5zYx+Vqu4mm6fAaC5nwvso4wwcGspaGq
         ebBhBOy0wtxxhw89OZz/bLX7t3mvzKm4YmBxLqJvp1Pj1jRe4zO95x3L9of9t/iIuvRU
         O/BYz6NcnuDhkwGP2Q4/QzIVegQxvNh9nK/blQPTTSfhhDcmDV7rJoRDzCHIDncmq/sa
         SZWShz9QhsUBt/pICrNYu3GAkNGPhKDe01DZliuYWRPb2hW/AqqnWbhYxG+SXksYe4oM
         v4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427294; x=1732032094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1wxrEwtrIa/6tacdYcY+vjRhcRt6Rg8gQj+1ymAPK8=;
        b=XV0OxG2pC/cmFyiDIgxLYrXG7KMa3KS0Q2cnrSR9zDGooDjkAxedbhHjbRZA7jkvDZ
         buWc2WzgjwTxX4yKz4IMoIUZeH75Tb0dkzSIFjocI/LrpfcZkXsVTGi7yXYNRvzif9ps
         KjTXGTRvUF/Ljzaou0+UYo2OoDt5u2YavyjQW0v/wqT3GcfUaua8oSHPUf19qImyJNLn
         sNkePYxqCjc9p1FrsIojtDVpKnIfyprIChqBY7w6e6+Eo6PdJqC3dt8jZlU1y2itFLif
         tTW5qOsTl+FWnIhmCpwgRVRT75tckhH4v5y2nHGRfr+EUd2EcnF5peYLCRhve9Evd3MT
         s+wA==
X-Forwarded-Encrypted: i=1; AJvYcCX6f8AvjSoXHQmnDqflc0tv3xc0+M0ylhWL3h56opp6cm9Pv5XnzQ6QGZ34z31dspVCXG2dXpoIXF6Ueys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw3n8PvgIKawG61rYsk5m7ZDZajlhAlx90JbBmZmxqCKgQXCCo
	5VHLIhg1mG22/MWiR/WxcJDitFkxPJfegnWPMNrYiVM4tIAWEvqSSMC4tTtGWjk=
X-Google-Smtp-Source: AGHT+IGx3RVHA4+byL2YTLnZZ+/5E8G3YY8XlVAXe4mp3PgtfDZjahR2xR/tDM+pFFm2RtkJYAlNcQ==
X-Received: by 2002:a2e:a99c:0:b0:2fa:d534:3ee7 with SMTP id 38308e7fff4ca-2ff2027d94emr81313131fa.35.1731427293638;
        Tue, 12 Nov 2024 08:01:33 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb760fsm6148172a12.47.2024.11.12.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:01:33 -0800 (PST)
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
Subject: [PATCH v3 5/5] perf stat: Document and clarify outstate members
Date: Tue, 12 Nov 2024 16:00:45 +0000
Message-Id: <20241112160048.951213-6-james.clark@linaro.org>
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

Not all of these are "state" so separate them into two sections. Rename
and document to make all clearer.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/stat-display.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 8377e24602dd..ba79f73e1cf5 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -115,15 +115,29 @@ static void print_running_csv(struct perf_stat_config *config, u64 run, u64 ena)
 		config->csv_sep, run, config->csv_sep, enabled_percent);
 }
 struct outstate {
-	FILE *fh;
+	/* Std mode: insert a newline before the next metric */
 	bool newline;
+	/* JSON mode: track need for comma for a previous field or not */
 	bool first;
+	/* Num CSV separators remaining to pad out when not all fields are printed */
+	int  csv_col_pad;
+
+	/*
+	 * The following don't track state across fields, but are here as a shortcut to
+	 * pass data to the print functions. The alternative would be to update the
+	 * function signatures of the entire print stack to pass them through.
+	 */
+	/* Place to output to */
+	FILE * const fh;
 	/* Lines are timestamped in --interval-print mode */
 	char timestamp[64];
-	int  nfields;
-	int  aggr_nr;
+	/* Num items aggregated in current line. See struct perf_stat_aggr.nr */
+	int aggr_nr;
+	/* Core/socket/die etc ID for the current line */
 	struct aggr_cpu_id id;
+	/* Event for current line */
 	struct evsel *evsel;
+	/* Cgroup for current line */
 	struct cgroup *cgrp;
 };
 
@@ -473,7 +487,7 @@ static void new_line_csv(struct perf_stat_config *config, void *ctx)
 	int i;
 
 	__new_line_std_csv(config, os);
-	for (i = 0; i < os->nfields; i++)
+	for (i = 0; i < os->csv_col_pad; i++)
 		fputs(config->csv_sep, os->fh);
 }
 
@@ -550,12 +564,12 @@ static void print_metricgroup_header_csv(struct perf_stat_config *config,
 
 	if (!metricgroup_name) {
 		/* Leave space for running and enabling */
-		for (i = 0; i < os->nfields - 2; i++)
+		for (i = 0; i < os->csv_col_pad - 2; i++)
 			fputs(config->csv_sep, os->fh);
 		return;
 	}
 
-	for (i = 0; i < os->nfields; i++)
+	for (i = 0; i < os->csv_col_pad; i++)
 		fputs(config->csv_sep, os->fh);
 	fprintf(config->output, "%s", metricgroup_name);
 	new_line_csv(config, ctx);
@@ -837,7 +851,7 @@ static void printout(struct perf_stat_config *config, struct outstate *os,
 		pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
 		nl = config->metric_only ? NULL : new_line_csv;
 		pmh = print_metricgroup_header_csv;
-		os->nfields = 4 + (counter->cgrp ? 1 : 0);
+		os->csv_col_pad = 4 + (counter->cgrp ? 1 : 0);
 	} else if (config->json_output) {
 		pm = config->metric_only ? print_metric_only_json : print_metric_json;
 		nl = config->metric_only ? NULL : new_line_json;
-- 
2.34.1


