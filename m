Return-Path: <linux-kernel+bounces-406270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC77D9C5CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD0D28141A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDE52123E1;
	Tue, 12 Nov 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmSQEVkv"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC07206972
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427293; cv=none; b=UnWxi8EevbJGGe4Q1Vkf+/FEeAa1WfdOYm6Dov3q4xD5hqkV8FwHtvw17LtX4gDOTBIzS8VO643UU+Rx79CskhThrGaqn1o9Y4pcWb3r2TWj2oBcIKJGmiNtdGqnvSAMUsnfp/KDH+EtnbPovhS+wi5ogtl/X8w8euObzya9KCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427293; c=relaxed/simple;
	bh=mrhDrysogUEw8xuWC9Qh+KgPy7ieZDHC7syB4M6VzD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEnf5z4YpRR8GdS1OBsDQP8y6PgzH0QCbZ87GrMrN5Qm+qAwkeO9C2+gFqj+Bq5bDvOOhJsbCaBBmTzGLzloRlpgxaHhzGewXD0MlPXxy/y/kpiBFFb8p33S9Oo0Z2RDMx4VzAxuf85FU2wDzK3a14EE7bYMmUtchDUVoH8PHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QmSQEVkv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4316cce103dso73487585e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427289; x=1732032089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfO6Uyp9GP4/3SEdOE/0i8GecViHiYr/MII+CIKx7yY=;
        b=QmSQEVkv5Dn0Cey4xAAC5JrxywXnPGHlI78Rzdm3WM3vsZLKrFAxHzF/OKGue+f0bY
         mhMyYuj3lgP/HpCW+TYc0foanrrAhZ6Kxxqj9tmu3aJAu8T9m5Zv0w3goC2PDqU+58HP
         A++q6gThSFhLqGdhXPz43v3PKDGUqrk+5G8/qTA834UXzxbhL4BCkP4BnDljUFuEjMpK
         ElQ5nOcqLRLf6rPNYRdHeZQD3z5+F11h9qwdNA3OYgfOhShU0FgfeDqaisuW9CFS3EZa
         +zSZqSbITr82nbczs/+hbUJCrtEoWcBnfWQOael94E1ILXip1L3G5LO4b8Egry6NnxuV
         yuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427289; x=1732032089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfO6Uyp9GP4/3SEdOE/0i8GecViHiYr/MII+CIKx7yY=;
        b=oVyc8m4mZM0AUiBdBSL5gLE+F5MhQu53O34g5vhGeIisfrHdiQ4tS5fo8ds9y8yH8C
         btzmCcjEWgBa3+5AqMgkS8MsLIlzhLC1ZI/JYeh6gbpPHAxSvv4PhWZ2bZ5BlgYEj9Bf
         Hsb5JmllLZPgzPepx/m14hgnXz3hr6PdikA+aTsmmT2EZ06XnVNMbPsB6qs2CkU9HQ17
         f14KXEUJbaP9hnkupWuA/fFdi4EvCl3vMZ6kPAtaAzEKOeTzQyUg09dh7D0fvwlozcN7
         kOLUJYHz3pGNBgRJJAuVr+qhu4FiW6vnn3q5poSTATCbxMUer8J47S6gd13cVa6yWczk
         8wcw==
X-Forwarded-Encrypted: i=1; AJvYcCUwoPzUd2rieln1FelhmXRU12kzsEADB5ptccVaWuX8xYneNbFZKAe3mTDo2S0fWv2c6xKs3gXfhUpI4MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMY3bQ7lloYUfakqRfjFEX101+khsBZrzz8O5fhtU7Rj6YJMoW
	caZJUqOHZYIV1UdYUOby2TDECLwSn3FQCcKrbiFu0L9R1IApiEh3srVTXb+5knY=
X-Google-Smtp-Source: AGHT+IEzdvzbbDL6tQ0phECIqPimyf6RH5DZGUQK/OwZ9Rj+vOSp2FXWGlTYc1iWIR9hSPusGLq2dw==
X-Received: by 2002:a5d:6da6:0:b0:37d:4b26:54ca with SMTP id ffacd0b85a97d-381f186bd00mr18450715f8f.14.1731427288640;
        Tue, 12 Nov 2024 08:01:28 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb760fsm6148172a12.47.2024.11.12.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:01:28 -0800 (PST)
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
Subject: [PATCH v3 4/5] perf stat: Document and simplify interval timestamps
Date: Tue, 12 Nov 2024 16:00:44 +0000
Message-Id: <20241112160048.951213-5-james.clark@linaro.org>
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

Rename 'prefix' to 'timestamp' because that's all it does, except in
iostat mode where it's slightly overloaded, but still includes a
timestamp. This reveals a problem with iostat and JSON mode so document
this.

Make it more explicit that these are printed in interval mode by
changing 'if (prefix)' to 'if (interval)' which reveals an unnecessary
'else if (... && !interval)' which can be removed.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/x86/util/iostat.c |  4 +++
 tools/perf/util/stat-display.c    | 45 +++++++++++++++----------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 366b44d0bb7e..00f645a0c18a 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -403,6 +403,10 @@ void iostat_prefix(struct evlist *evlist,
 	struct iio_root_port *rp = evlist->selected->priv;
 
 	if (rp) {
+		/*
+		 * TODO: This is the incorrect format in JSON mode.
+		 *       See prepare_timestamp()
+		 */
 		if (ts)
 			sprintf(prefix, "%6lu.%09lu%s%04x:%02x%s",
 				ts->tv_sec, ts->tv_nsec,
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index aa74543ae298..8377e24602dd 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -118,7 +118,8 @@ struct outstate {
 	FILE *fh;
 	bool newline;
 	bool first;
-	const char *prefix;
+	/* Lines are timestamped in --interval-print mode */
+	char timestamp[64];
 	int  nfields;
 	int  aggr_nr;
 	struct aggr_cpu_id id;
@@ -419,8 +420,8 @@ static inline void __new_line_std_csv(struct perf_stat_config *config,
 				      struct outstate *os)
 {
 	fputc('\n', os->fh);
-	if (os->prefix)
-		fputs(os->prefix, os->fh);
+	if (config->interval)
+		fputs(os->timestamp, os->fh);
 	aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
 }
 
@@ -523,8 +524,8 @@ static void new_line_json(struct perf_stat_config *config, void *ctx)
 
 	fputs("\n{", os->fh);
 	os->first = true;
-	if (os->prefix)
-		json_out(os, "%s", os->prefix);
+	if (config->interval)
+		json_out(os, "%s", os->timestamp);
 
 	aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
 }
@@ -1091,13 +1092,13 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 			os->first = true;
 			fputc('{', output);
 		}
-		if (os->prefix) {
+		if (config->interval) {
 			if (config->json_output)
-				json_out(os, "%s", os->prefix);
+				json_out(os, "%s", os->timestamp);
 			else
-				fprintf(output, "%s", os->prefix);
+				fprintf(output, "%s", os->timestamp);
 		} else if (config->summary && config->csv_output &&
-			   !config->no_csv_summary && !config->interval)
+			   !config->no_csv_summary)
 			fprintf(output, "%s%s", "summary", config->csv_sep);
 	}
 
@@ -1124,11 +1125,11 @@ static void print_metric_begin(struct perf_stat_config *config,
 	if (config->json_output)
 		fputc('{', config->output);
 
-	if (os->prefix) {
+	if (config->interval) {
 		if (config->json_output)
-			json_out(os, "%s", os->prefix);
+			json_out(os, "%s", os->timestamp);
 		else
-			fprintf(config->output, "%s", os->prefix);
+			fprintf(config->output, "%s", os->timestamp);
 	}
 	evsel = evlist__first(evlist);
 	id = config->aggr_map->map[aggr_idx];
@@ -1349,20 +1350,20 @@ static void print_metric_headers(struct perf_stat_config *config,
 		fputc('\n', config->output);
 }
 
-static void prepare_interval(struct perf_stat_config *config,
-			     char *prefix, size_t len, struct timespec *ts)
+static void prepare_timestamp(struct perf_stat_config *config,
+			      struct outstate *os, struct timespec *ts)
 {
 	if (config->iostat_run)
 		return;
 
 	if (config->json_output)
-		scnprintf(prefix, len, "\"interval\" : %lu.%09lu",
+		scnprintf(os->timestamp, sizeof(os->timestamp), "\"interval\" : %lu.%09lu",
 			  (unsigned long) ts->tv_sec, ts->tv_nsec);
 	else if (config->csv_output)
-		scnprintf(prefix, len, "%lu.%09lu%s",
+		scnprintf(os->timestamp, sizeof(os->timestamp), "%lu.%09lu%s",
 			  (unsigned long) ts->tv_sec, ts->tv_nsec, config->csv_sep);
 	else
-		scnprintf(prefix, len, "%6lu.%09lu ",
+		scnprintf(os->timestamp, sizeof(os->timestamp), "%6lu.%09lu ",
 			  (unsigned long) ts->tv_sec, ts->tv_nsec);
 }
 
@@ -1685,9 +1686,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			    int argc, const char **argv)
 {
 	bool metric_only = config->metric_only;
-	int interval = config->interval;
 	struct evsel *counter;
-	char buf[64];
 	struct outstate os = {
 		.fh = config->output,
 		.first = true,
@@ -1698,10 +1697,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	if (config->iostat_run)
 		evlist->selected = evlist__first(evlist);
 
-	if (interval) {
-		os.prefix = buf;
-		prepare_interval(config, buf, sizeof(buf), ts);
-	}
+	if (config->interval)
+		prepare_timestamp(config, &os, ts);
 
 	print_header(config, _target, evlist, argc, argv);
 
@@ -1720,7 +1717,7 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 	case AGGR_THREAD:
 	case AGGR_GLOBAL:
 		if (config->iostat_run) {
-			iostat_print_counters(evlist, config, ts, buf,
+			iostat_print_counters(evlist, config, ts, os.timestamp,
 					      (iostat_print_counter_t)print_counter, &os);
 		} else if (config->cgroup_list) {
 			print_cgroup_counter(config, evlist, &os);
-- 
2.34.1


