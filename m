Return-Path: <linux-kernel+bounces-251066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E05930047
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818192856C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30C17C9F6;
	Fri, 12 Jul 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cjU+BudP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C214A17C7C4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807972; cv=none; b=TM+aUTwnnMG1AaMEVRo93pRGU5y67LMl1GcStyhv6cUoAikXHAqwOWl4RlMoa5Pkx3rMvkvHHbSprJmEGlXFfOcnEG3eIzaiwkgd66yc/82FSc5yxFnd/q1rg26ZnYGZb6+v0zuh8+X1VOqJS6Xv1txlmybx0sfHjFEh3FP4o7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807972; c=relaxed/simple;
	bh=D3YBUpPEwBmyis+zCkqbR93QP3d0FEANSJQVPRT7Pgk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dUDQL2hEOuDqTqjc853/XHwX190vW4amruIIJRfo2v4zu1mAYBGGwoOlYrqJ2ceztS8cpoJV7mBwQZW4b7NJCYunQk/2Zapy0BkqCmDpof9bwvC3eKa/JVSdQvMUzHoccWnfZTzRZBB88d3cRXdewr82ktWVpO9FtvyhTAEywc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cjU+BudP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-654d96c2bb5so38502287b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807970; x=1721412770; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZfGB4qYIWwtakjvzGQZNS3+imagxPcgxRVJoCFymO4s=;
        b=cjU+BudPbZsBUSeaGHx5zaJTmI1KeNJHyNvyR9kWfrKnaDL+LwD5INDi3e2Qpt/Gr2
         CB3WEPaG0k9tCCNXJ+NwPKv1qkogToVagt3/bBcZZHvxsJqN5B4MGz3BnTqgoQETyPv0
         4vJypz5IUuuYGIdvqpgR3ohHHm05w2UDgwI0+vbe73eX/5r3hPUKpVV/4MXIsXxXRvZ3
         Uft3Aez9mMFo5U5264xkTza2/3thRI+n6qmlNe+WJdA5GN8p8OKgh/BKMN2u/ttQoPPZ
         gdOfF7I7n7coxJeAWXF3Yrbt2PxR6ZfcGPwx5xjts1xnuerL32rXTOoT4yKdreJpBAYC
         hZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807970; x=1721412770;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfGB4qYIWwtakjvzGQZNS3+imagxPcgxRVJoCFymO4s=;
        b=giXsHmsiW2EwXEXJ7kbWc5xh7Ju2G84MrD6c79dPvkPeETsfbMKZijuVmsASQq1MQK
         /jUeifOs9UDzYPwa1SsqEBRw5Vvk6++p8Bu7jK/bF+U41x6442iYhZKH3z3GFuuEZ7l1
         gqNE/g6SRCc5TkK5Umi/YOm1YHq2Pd9uTDo6Kr6nyyWacpt0rkJ3YsHxtPX31z2eVTP1
         hqiqsWBAJiUep0dZEkFBjBXh3yL6iNUWkzCaFH8NxtmWIcoRQg5d6vXeGukmpymu2rHi
         MHbD77R40OkAj7X9OktKowbfeFt8wzYZyqYWKJuixiuZ66IRo2weC96NTwX1UuIlLRc5
         KTdg==
X-Forwarded-Encrypted: i=1; AJvYcCUzmvySl97DM7zWVws8kj5NiN7KMdVPe+g6X5uhvG6uZ/dby9NRdK8lqMEGj9VViYc3Xzhylh8STCAfLP9yDROcyS5OSI+14BZKtcmb
X-Gm-Message-State: AOJu0YzLD9+fAbC/kgp3pSAnChhqQfOeO7UyvzHcx3LYqbTv4mDyBltJ
	3YSe9NuuyyjO3Qv+6ivqA3qA+ZH1BzbNnL22TVb+35+P2oMVTw9Ivs+r3uVcOiExNppxhlrfl1T
	iTxMUaw==
X-Google-Smtp-Source: AGHT+IGwm97iX/hGe03hY3o8dBT3RVSvlUNVeKVGrABZ6gQou1GSxK9awtmr+31vBv1Cj2NXc9MdjmjFPQQ1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:690c:fc4:b0:61b:e103:804d with SMTP id
 00721157ae682-658ebbb801cmr734427b3.0.1720807969781; Fri, 12 Jul 2024
 11:12:49 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:59 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 18/27] perf sched: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog


