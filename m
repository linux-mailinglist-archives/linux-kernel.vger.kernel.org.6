Return-Path: <linux-kernel+bounces-283749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F22B94F86C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840F11C223CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E958194AC7;
	Mon, 12 Aug 2024 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVCeOqgq"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAF199396
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495672; cv=none; b=hibDuEXcEMpISpyIAzjk6ey/VypYG3aQb0qCIgdcqUrwVn2YHC9XiIicsm3DKrvdGOD98g/NGTuGfFF7RzUbVm70BGIj0LaaXNdjm/k3P9ikats88kUOlYYaDf/Cgzu07kZtQQ/ho3jyhEVuy/i/YC5nFVY+9CXi80NGGuYGUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495672; c=relaxed/simple;
	bh=I11CbM64EgNF8ZIP9fzEzGgd+7qkMjOwAQdzvPNsQ7c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=izXws+UUYLwtEUFrVmcVBrbjVwdSt4D/fq7rtvJGdDltRNo9pfnA+b0ImnZ30gNmJKQIOkmPfnoVOShfJofGOTUdAiCbRagaF+QkXTXLTFErrRF1+MZmInPAeri6iqtTZX/wr+909IbqhoVw+d0wVMY16jMdr75EEM4/AFxQ3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CVCeOqgq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66a8ce9eecfso77887407b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495670; x=1724100470; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3jqi17epiT5W5NpHtjXH0dEG9gj5/vhoZ4ouw58D8Y=;
        b=CVCeOqgqZSAhha2b7kdPf27YQQQ8Dl7EEiCnBu2bVPsf9eqVQ0uoKd8w3RqdVizc/C
         coVFzO/pEGCBZ7dSYoz8VpsYyWvXIxEEr2i5OGPkqCX3y8gPnSrxjT9dZqiAKYl+rmxA
         xV8qa3baBKG1CkAu3wt8H4obBIhD5cH78jCSmljPFwwNoIZ3/xSexUy5NFVQtSZYyJv5
         02iTiDXXNthnNK6sjF774gV70nJAXq0OFPzTvb8+pl33x5oTjXvyL0jLFy0PG0b+UO8a
         6kX2QzcEMxQMFA4QMNnbjIyNae1ypmXG556sxvCKikjhxrkiZGR5I2XfqVtlrVpExIWc
         mbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495670; x=1724100470;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3jqi17epiT5W5NpHtjXH0dEG9gj5/vhoZ4ouw58D8Y=;
        b=NteQcBLbyl30yT4gMN4HDw5swEI9aON1rKi1X3JwE9KRfYI3tG0kzI7mylEM16steb
         1Nl7DpmV6TkDb1bCqcI5zbRHhRaokHVcfRHX3UDf+y+k6aK83nNiR0c2P4661F4S/ddX
         KUXTTdy8ukN8QiRT1p5CMmVhwacuy0J6lBzmMpZCmo7v4hhSiqK/9kDHrzbpOo28LViD
         uOFcWtc0h3J6xHwNUOT0TjdbbjHZDmtbz62q51mhqi1tjQt7yqc/SF1sfGgC7VwHEXCX
         dLgiMBUEbF0+/qla55gaCie1FAgYeqyWFV8Wy48rievV0gxfH7awE0sEUol/IMt0wR9W
         6DqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+EkkpN7KsLXKCvJTHhXObspGA+ahFb+01hD660RMbZfGJMOAQSYhujAjJSH4yoi6v0iYDbEujiM+C6eTf9TfoTgbr5LoIVxNJw/tS
X-Gm-Message-State: AOJu0YyEePkiLKD8M0P43oJ+F2GJRIgCZY2/7i8CRztst+dLqRm6TrQU
	I5jhcfKOWG5h25tLu5zGiXM7nDxvo/1bLgFtZln1QeyYZ6U1htGHJgR9uxLGfhjfZBwROs5txV1
	1e63iAg==
X-Google-Smtp-Source: AGHT+IEUTe+31u4c0XlLwpy08DjQKT6rgdB8gr9GGhJp2e2MdzhZe2ydsJffGE/8HlJ8ES1MJe7plUf+7SS6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:c6c3:0:b0:644:c4d6:add0 with SMTP id
 00721157ae682-6a9e4c87a4amr142227b3.1.1723495670221; Mon, 12 Aug 2024
 13:47:50 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:03 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 11/27] perf record: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
index 46410eb3a76b..39367709fd99 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -194,6 +194,15 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
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
@@ -1459,7 +1468,7 @@ static int process_buildids(struct record *rec)
 	 * first/last samples.
 	 */
 	if (rec->buildid_all && !rec->timestamp_boundary)
-		rec->tool.sample = NULL;
+		rec->tool.sample = process_event_sample_stub;
 
 	return perf_session__process_events(session);
 }
@@ -2387,6 +2396,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
@@ -3327,18 +3346,6 @@ static struct record record = {
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
index 7c7ce395e573..c7fea58729a5 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -94,4 +94,10 @@ void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
 
+int process_event_sample_stub(const struct perf_tool *tool,
+			      union perf_event *event,
+			      struct perf_sample *sample,
+			      struct evsel *evsel,
+			      struct machine *machine);
+
 #endif /* __PERF_TOOL_H */
-- 
2.46.0.76.ge559c4bf1a-goog


