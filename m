Return-Path: <linux-kernel+bounces-255836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F636934592
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10F31F263CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532EBA46;
	Thu, 18 Jul 2024 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DxNbC8J"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315073466
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264485; cv=none; b=apmQxybeiX8kiZmL4pGHV3dTaAFHMjnhRrQf6cTLhmHL8VMbm9+XwOsIxxrjuXoMqJOaLUPj9bdXcmG2t2y6QYhrflK8sbhQsa9mK6faCBp9SHFLLya19khEiAxBknf/O+n14eW01YW7GFXUqRdoIh5syHjftA0CPmWf/83nc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264485; c=relaxed/simple;
	bh=33Aau11uuNpJ23sq1I4eyTYUefvdpQsh49HkERecgwM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ed/64a0mT3VVo09UVZHt5U8bs+CiRwlB9QXW/DJCVYwPtE3uEQri60t9E9dHrfEXkhN/7GAkrjUanFnG7b8UqMyGFHXwNamm5rRz9eTUCF6kvVVnNVYgWi/2juhucqr9hFqbv5QBRohpwLjgAacHik/FJXK6dVJHM3zp5ab7Q10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DxNbC8J; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65bbd01d146so6165867b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264479; x=1721869279; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIDIj8ohh0nflT4KD3kHem3lEjHwYWuoIZyNVV8EfDA=;
        b=0DxNbC8Jhto3QHlP1uXLFskjKmhzhO3EswqdpyEE8DreTRwj66V+b+SLmQ3y3P0BTu
         35SOpY13hULFbdDUZpg/7beWfdA+7uikFnAQgHWmLH9zTMuGU+4Iils0ru9DqdP3lGu9
         KktHTeLQkI/afRVvIEz+Vv2tLfl05Ud5/yG9i0KFL6+HwWgsC7l9swQagIHXyhXcizrr
         ESXkxfmpAgfpoL9w9HwU7SAgExcnpSXiuRSyUzTz0U0so35cLZLJ1htgdezlmx98cipN
         hp+jVqh1ONGg9o2cq92kPHKj6kfUnxR8pGHpN2XbUg1PcX6MZAoloZlh1PyVzcRYb9d6
         JHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264479; x=1721869279;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIDIj8ohh0nflT4KD3kHem3lEjHwYWuoIZyNVV8EfDA=;
        b=rpZzTKR/4g3LiIiwHzY4IwnOQD7iq03rpA5us4Yo50ku4uqUH+d52G449QkbRw220m
         h4ls4+x6UnFN61cplJXR6JDqu7DYqu1Q8xq3c0v6i0nBrX2M1qan5Yl1ccm7Lfs+fAeb
         aLKyiik9IrVW8gfRJEx0M88Grjfu44WS6KFJERFZBXQIfOnz8Xw//PRh4fsBDcOGaEyw
         +q9K2E/qNPzoNmTNcKoOU32vvDL8kiRmvoxNx1Br7iL7Jm0IgPkEyEmv+9T2R180hCpi
         oDQ4LAZXohTr30DzkiCGNGWzw4ZQCV0oYGtvQKDItCgz+e2IiXf9Abu23IUIo57He+mc
         zSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6oHDXMkRWyCdxXrsgyxn15iGmDQ1k4LqCly0yG1G/yWhPc0sp3B/veWykdXc54ecNSM9nvExMnAymAy13jyFdtAj8ncl5gaCIowid
X-Gm-Message-State: AOJu0YytE8L1zFv1/XXR09XtW+N0JEWJGftsSmEfIK7TTCeHPhULzbIx
	wSTL9V6OPYxNyvSJDavg6M3WpNRDlgqfihOZ56exw1n9Zli+fCBUP2N5hc1cb2rbCccZ9phGKmd
	5F6SOSQ==
X-Google-Smtp-Source: AGHT+IE7eyYkV30IAuJJyVKolxf68gGRG23Ds+4kcgr2lLuAa9Klg1hxPx68W8tgqNMyLyGzarxdoaI7qyDF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c6:b0:e05:a890:5abb with SMTP
 id 3f1490d57ef6-e05fea8885bmr27243276.1.1721264478691; Wed, 17 Jul 2024
 18:01:18 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:14 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 18/27] perf sched: Use perf_tool__init
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-sched.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2c60bd3a8149..34fe8e540c43 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3100,7 +3100,6 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	sched->tool.tracing_data = perf_event__process_tracing_data;
 	sched->tool.build_id	 = perf_event__process_build_id;
 
-	sched->tool.ordered_events = true;
 	sched->tool.ordering_requires_timestamps = true;
 
 	symbol_conf.use_callchain = sched->show_callchain;
@@ -3605,14 +3604,6 @@ int cmd_sched(int argc, const char **argv)
 {
 	static const char default_sort_order[] = "avg, max, switch, runtime";
 	struct perf_sched sched = {
-		.tool = {
-			.sample		 = perf_sched__process_tracepoint_sample,
-			.comm		 = perf_sched__process_comm,
-			.namespaces	 = perf_event__process_namespaces,
-			.lost		 = perf_event__process_lost,
-			.fork		 = perf_sched__process_fork_event,
-			.ordered_events = true,
-		},
 		.cmp_pid	      = LIST_HEAD_INIT(sched.cmp_pid),
 		.sort_list	      = LIST_HEAD_INIT(sched.sort_list),
 		.sort_order	      = default_sort_order,
@@ -3733,6 +3724,13 @@ int cmd_sched(int argc, const char **argv)
 	};
 	int ret;
 
+	perf_tool__init(&sched.tool, /*ordered_events=*/true);
+	sched.tool.sample	 = perf_sched__process_tracepoint_sample;
+	sched.tool.comm		 = perf_sched__process_comm;
+	sched.tool.namespaces	 = perf_event__process_namespaces;
+	sched.tool.lost		 = perf_event__process_lost;
+	sched.tool.fork		 = perf_sched__process_fork_event;
+
 	argc = parse_options_subcommand(argc, argv, sched_options, sched_subcommands,
 					sched_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 	if (!argc)
-- 
2.45.2.1089.g2a221341d9-goog


