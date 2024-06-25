Return-Path: <linux-kernel+bounces-229397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C481916F33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BFE1F21856
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E331117D36F;
	Tue, 25 Jun 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DiLmLMc5"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804ED17D348
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336392; cv=none; b=kj/etfa2mjdzICXX6U42cN/4CNZ8n1rWlhbkxAeSBDYVsZnWOlABBzFJdR3IZ9U2D6xL1o8RRnD5DjKFwbQXAC+YTqsKe/pnnjKIg1/njI9doazTkkQB93L32adGouNI4t6+5ZCOBM2zH2PCzHSLaIj8JKZ3FR/gp4xvdoff7Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336392; c=relaxed/simple;
	bh=8Hq3zfWNmFy7ujf6Oj9PHVWmQvnmRoATsLJbSGLqdT4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=apKasaFe+AmS44PiPp07EO8u0qfCuRin0cpNvbZOIogv3zKduhTuNfxSlPPWV9lYnT59MsPLzvN8Tjdljnm9bYKUxbO18Ox4qC4N4KH2nN/GpYIlEHBaC0YPLc5pt1DSu1d0tcYgVPa+v+Rr76T9S3h/LOBhpeHBgVQ4NjwYcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DiLmLMc5; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e032d4cf26aso871809276.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336390; x=1719941190; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0i4pVqwbk0skHdH7qbkMIerLJTSVfnhcqEk1r/vEHks=;
        b=DiLmLMc5wEFjMfjK1eEGVdlsrc9KB8TkvrY11FD0+0zbl2JrmJcviU9BC5corvWCUL
         8XAxQFJJv5nUa9Quws5xlBG5U01tuUoBQb4BExO4FOahwm5M38CAXY46qEgjwsC1qdho
         1ibCikVqzulDXHVdUJbD5mQDzlTjsxAXVjJB0WME5HyWHMSvdPiajX7+cNcTshtd52Fl
         WuWbhwLDKtufBwBZzsToHJ0zPUMTIjBk/h0QkmOozIcBrKDXea65FDpJoAee8NrNYOGH
         9me9gxg+/KoyTzgblKlbGZgJCJIdtDEvVBAGDReA5BwqKRgLAGCeXLe7IkIXjacrph/r
         EkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336390; x=1719941190;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0i4pVqwbk0skHdH7qbkMIerLJTSVfnhcqEk1r/vEHks=;
        b=q9IWl32NtzSrTQzlwa9eQq8GNQxc6a+fboNmGnvH002c2bsxRKLga8WgI7z03efn5y
         OLXfJMaCvYmdgbJB9QLpFa3O1JFP63kkdtsgQ3lgCiI+WM/agjCniLTmX9pzZdINgdPG
         hQdITvgwEyyIfjc9CJsDqBpeP0wAojUz1VikON+K7RzC2uWhPlZ84paGzY74HSThh9Ny
         +iMZcbBnSyDPQ6jlMy1rbUISWg7pfYd4iDAzPRqg1jg+QhAfffTmW3LDv75NskY33Sk4
         mEN597R3HgMmu3IbS1vjrglqAfDj6OODY8kUBQHM2nM1NHZTOcs62IOQP8ReqaCkG0dT
         igEw==
X-Forwarded-Encrypted: i=1; AJvYcCXJdCv30TunsvWRbKUYzPm3oS8WkKlvzqfJHZegrWhSofqk3pE1El65XHpGTaZSMtUcU1ki0jStkRXZtpMp1OHg0SauUNr1ye+sPYMP
X-Gm-Message-State: AOJu0YwhyqyEneMBSJl7MAd3LMeHppCzKGf+wc9bLZE1WSIo3apEC6ya
	md68zXE6HVD1pr+108aje8iqnuM6EAhLCrk43oRwhbnGbV2D5VhQNS1OyhKbehQSIpx8idIqB9f
	wh4vuPQ==
X-Google-Smtp-Source: AGHT+IHNZBdjbRKy77cEdS+R0hAtjYvzJglBq5vgHL8qU1wiMivtXiT+B4vfJOWsL+Br8ihI8B+CKHjdllSj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b8d:b0:e02:c619:73d with SMTP id
 3f1490d57ef6-e030403de41mr241333276.5.1719336389625; Tue, 25 Jun 2024
 10:26:29 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:46 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 09/26] perf record: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 33 ++++++++++++++++++++-------------
 tools/perf/util/tool.c      | 10 +++++-----
 tools/perf/util/tool.h      |  6 ++++++
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 21793c170dbf..f7db7be562b0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -193,6 +193,15 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
 	"SYS", "NODE", "CPU"
 };
 
+static int build_id__process_mmap(const struct perf_tool *tool, union perf_event *event,
+				  struct perf_sample *sample, struct machine *machine);
+static int build_id__process_mmap2(const struct perf_tool *tool, union perf_event *event,
+				   struct perf_sample *sample, struct machine *machine);
+static int process_timestamp_boundary(const struct perf_tool *tool,
+				      union perf_event *event,
+				      struct perf_sample *sample,
+				      struct machine *machine);
+
 #ifndef HAVE_GETTID
 static inline pid_t gettid(void)
 {
@@ -1458,7 +1467,7 @@ static int process_buildids(struct record *rec)
 	 * first/last samples.
 	 */
 	if (rec->buildid_all && !rec->timestamp_boundary)
-		rec->tool.sample = NULL;
+		rec->tool.sample = process_event_sample_stub;
 
 	return perf_session__process_events(session);
 }
@@ -2402,6 +2411,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		signal(SIGUSR2, SIG_IGN);
 	}
 
+	perf_tool__init(tool, /*ordered_events=*/true);
+	tool->sample		= process_sample_event;
+	tool->fork		= perf_event__process_fork;
+	tool->exit		= perf_event__process_exit;
+	tool->comm		= perf_event__process_comm;
+	tool->namespaces	= perf_event__process_namespaces;
+	tool->mmap		= build_id__process_mmap;
+	tool->mmap2		= build_id__process_mmap2;
+	tool->itrace_start	= process_timestamp_boundary;
+	tool->aux		= process_timestamp_boundary;
 	session = perf_session__new(data, tool);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
@@ -3342,18 +3361,6 @@ static struct record record = {
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
 	},
-	.tool = {
-		.sample		= process_sample_event,
-		.fork		= perf_event__process_fork,
-		.exit		= perf_event__process_exit,
-		.comm		= perf_event__process_comm,
-		.namespaces	= perf_event__process_namespaces,
-		.mmap		= build_id__process_mmap,
-		.mmap2		= build_id__process_mmap2,
-		.itrace_start	= process_timestamp_boundary,
-		.aux		= process_timestamp_boundary,
-		.ordered_events	= true,
-	},
 };
 
 const char record_callchain_help[] = CALLCHAIN_RECORD_HELP
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index cbd9b888bd73..a4ca16e5eefe 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -99,11 +99,11 @@ static int process_event_synth_event_update_stub(const struct perf_tool *tool __
 	return 0;
 }
 
-static int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
-				     union perf_event *event __maybe_unused,
-				     struct perf_sample *sample __maybe_unused,
-				     struct evsel *evsel __maybe_unused,
-				     struct machine *machine __maybe_unused)
+int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
+			      union perf_event *event __maybe_unused,
+			      struct perf_sample *sample __maybe_unused,
+			      struct evsel *evsel __maybe_unused,
+			      struct machine *machine __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
 	return 0;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 897c6c44b6b2..fb7e32d98dda 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -93,4 +93,10 @@ void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
 
+int process_event_sample_stub(const struct perf_tool *tool,
+			      union perf_event *event,
+			      struct perf_sample *sample,
+			      struct evsel *evsel,
+			      struct machine *machine);
+
 #endif /* __PERF_TOOL_H */
-- 
2.45.2.741.gdbec12cfda-goog


