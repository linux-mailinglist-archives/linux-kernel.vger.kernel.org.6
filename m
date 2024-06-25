Return-Path: <linux-kernel+bounces-229401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A80916F39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB351F21B30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785D17DE3A;
	Tue, 25 Jun 2024 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MShDCt7+"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AF17D8AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336402; cv=none; b=ZZJINJkxRaVHtZwnaIQSevz4D0l0I9jS7Qljr01QIEN652bayAFsNj4RWV5glsBi4v57EUInNWe1WqyQtqhmecX3bnviV0TQfoV87CJVX3nMq6XJVDerJA8rJzpMVbhfMu+cZxxKs7PH6OLirgddXVP4bBUpX9uPUKdvsAR7Ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336402; c=relaxed/simple;
	bh=SsGbey/lX0PF3u/QexDBtDo9aclN8M23kQ3F/liEyeY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VmqurCYfk3mfxOGEIm6SVGKLgeEasFtYmMgmGge8o1LjML24vZ/Z9aZOIh1oUhDLgncL3saClIouswejc7bJn4JVGyXQ0yHFXqf/rnpC3G7xCbHCs2+3WSenRECaOVhDs9Dj2BZLbXslMbYYi5Eg7+YH55iFihpL44NlbuGipYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MShDCt7+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02bb412435so12327345276.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336399; x=1719941199; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5w4cInp1XYHivC3iE3132v8D/BZptpjRVHJFu6J7bU=;
        b=MShDCt7+QiQVl5fgi8dsITRDPiPjyYKsUhYcgqD0tIEwsf/ITA2rJVIax2CF2H5OMw
         WLnzKE8bHqBgXVD1D1r5g1rvzC/7csV2NEVlq0+mFmDLhOdZH8tqk/Kc2D5yN8qrkYNH
         TcfkynBXhlWWQQmxOPigPJoccnXpRipXQmhNsZljr9MTqgM9ASZEr10DHwjhCqSrkcGA
         nuCTZCjHGGoNKkO6DB3+3ST2JyZp3IWElZnfic//bnha4dUUqgY/5FBC+3MPtzNGydiM
         xyMAhfsIhncMhKkBjbFhdOK5u0vBqvclIVajmGZLAoVGz4XD0Qy6RogULYOjT+xVoAyk
         jqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336399; x=1719941199;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5w4cInp1XYHivC3iE3132v8D/BZptpjRVHJFu6J7bU=;
        b=abrnkumdmQJ7CmJWJw1EC6kVcR3mtO39KyQUhPaTTOQWfa9+NzET0utWCItPSinbix
         uWhoXnCnFq1LJqBUHo4cB7XzdzzMPiQU8tm7rUPUAZaVleKRZn/jf1pL4f+AACse4LHi
         a/81Y4gocl5nJXEelRhkWsXN10Z5CFiT99HlMaZY/zl/DWyf8Xdv4uto76d9UMxh7hZU
         kfVt+2BiH7Oisg3v5KHgoklIL34KoEWKG7QQMUai67/i1H86eJtgErpbeqnKQKn69Uoc
         OdEuT39MzVwKzUDpqGE5i/du5PolCavUnm9Ue0ZyLEAuBKc1IJ5sMpJqmg6jqs/w0aem
         lkxg==
X-Forwarded-Encrypted: i=1; AJvYcCW+21pvVT5kZTDOjwqBkXHiYCQd4AZaAi2tABx6QeKICi3TvB02b0tHGV2RIS9tti6tPwFKYlfS2bOPeu6DTHjWRTtbN7iHi4rENCL7
X-Gm-Message-State: AOJu0YzSiWBKmNrp4mj0mU74KVOtz0i384aP9Qt8ESaHbDCX3S1Ep6LX
	bu275z8YlntZIlSMP7j2PI3KeO2S/6JLyaj3Zh64zSvW8xNrlskk4LFEcaB4zrJYEAVAHqmUPiA
	FXdsHwA==
X-Google-Smtp-Source: AGHT+IGkNnzupWAe2VlADESO5lg2+CTiWH+MH2liE+/EBrEEqIPx7BnFuqYzgLszQiwG21XCiljDeffYYpww
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:1885:b0:dff:49d2:ac42 with SMTP
 id 3f1490d57ef6-e03040be235mr417284276.8.1719336399148; Tue, 25 Jun 2024
 10:26:39 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:50 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 13/26] perf report: Use perf_tool__init
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
 tools/perf/builtin-report.c | 55 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 947d4a9c9f66..029e5c35632f 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -799,7 +799,7 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 
 static void stats_setup(struct report *rep)
 {
-	memset(&rep->tool, 0, sizeof(rep->tool));
+	perf_tool__init(&rep->tool, /*ordered_events=*/false);
 	rep->tool.attr = process_attr;
 	rep->tool.sample = count_sample_event;
 	rep->tool.lost_samples = count_lost_samples_event;
@@ -817,8 +817,7 @@ static int stats_print(struct report *rep)
 
 static void tasks_setup(struct report *rep)
 {
-	memset(&rep->tool, 0, sizeof(rep->tool));
-	rep->tool.ordered_events = true;
+	perf_tool__init(&rep->tool, /*ordered_events=*/true);
 	if (rep->mmaps_mode) {
 		rep->tool.mmap = perf_event__process_mmap;
 		rep->tool.mmap2 = perf_event__process_mmap2;
@@ -1275,30 +1274,6 @@ int cmd_report(int argc, const char **argv)
 		NULL
 	};
 	struct report report = {
-		.tool = {
-			.sample		 = process_sample_event,
-			.mmap		 = perf_event__process_mmap,
-			.mmap2		 = perf_event__process_mmap2,
-			.comm		 = perf_event__process_comm,
-			.namespaces	 = perf_event__process_namespaces,
-			.cgroup		 = perf_event__process_cgroup,
-			.exit		 = perf_event__process_exit,
-			.fork		 = perf_event__process_fork,
-			.lost		 = perf_event__process_lost,
-			.read		 = process_read_event,
-			.attr		 = process_attr,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data	 = perf_event__process_tracing_data,
-#endif
-			.build_id	 = perf_event__process_build_id,
-			.id_index	 = perf_event__process_id_index,
-			.auxtrace_info	 = perf_event__process_auxtrace_info,
-			.auxtrace	 = perf_event__process_auxtrace,
-			.event_update	 = perf_event__process_event_update,
-			.feature	 = process_feature_event,
-			.ordered_events	 = true,
-			.ordering_requires_timestamps = true,
-		},
 		.max_stack		 = PERF_MAX_STACK_DEPTH,
 		.pretty_printing_style	 = "normal",
 		.socket_filter		 = -1,
@@ -1480,6 +1455,7 @@ int cmd_report(int argc, const char **argv)
 	};
 	int ret = hists__init();
 	char sort_tmp[128];
+	bool ordered_events = true;
 
 	if (ret < 0)
 		goto exit;
@@ -1534,7 +1510,7 @@ int cmd_report(int argc, const char **argv)
 		report.tasks_mode = true;
 
 	if (dump_trace && report.disable_order)
-		report.tool.ordered_events = false;
+		ordered_events = false;
 
 	if (quiet)
 		perf_quiet_option();
@@ -1563,6 +1539,29 @@ int cmd_report(int argc, const char **argv)
 	data.force = symbol_conf.force;
 
 repeat:
+	perf_tool__init(&report.tool, ordered_events);
+	report.tool.sample		 = process_sample_event;
+	report.tool.mmap		 = perf_event__process_mmap;
+	report.tool.mmap2		 = perf_event__process_mmap2;
+	report.tool.comm		 = perf_event__process_comm;
+	report.tool.namespaces		 = perf_event__process_namespaces;
+	report.tool.cgroup		 = perf_event__process_cgroup;
+	report.tool.exit		 = perf_event__process_exit;
+	report.tool.fork		 = perf_event__process_fork;
+	report.tool.lost		 = perf_event__process_lost;
+	report.tool.read		 = process_read_event;
+	report.tool.attr		 = process_attr;
+#ifdef HAVE_LIBTRACEEVENT
+	report.tool.tracing_data	 = perf_event__process_tracing_data;
+#endif
+	report.tool.build_id		 = perf_event__process_build_id;
+	report.tool.id_index		 = perf_event__process_id_index;
+	report.tool.auxtrace_info	 = perf_event__process_auxtrace_info;
+	report.tool.auxtrace		 = perf_event__process_auxtrace;
+	report.tool.event_update	 = perf_event__process_event_update;
+	report.tool.feature		 = process_feature_event;
+	report.tool.ordering_requires_timestamps = true;
+
 	session = perf_session__new(&data, &report.tool);
 	if (IS_ERR(session)) {
 		ret = PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog


