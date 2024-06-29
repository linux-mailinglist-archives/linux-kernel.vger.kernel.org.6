Return-Path: <linux-kernel+bounces-234812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A9191CB1B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FCE2820DF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95CB81ACB;
	Sat, 29 Jun 2024 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o0Z8V8PK"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163180624
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636893; cv=none; b=kXVRZooFW2gZXnaqf2e9docv2ENzKUz/ne9tG56Ap8lBKPVuqx0CL+OCkGqt/gXmR5xeoU0qhnvXU0+w54Vdbe6nnmVlsLKpdE/wKBRvt4JbOgx6A2DTnvXR/CbA9I2pwBQJBPfEYpJTXtO5TBerXHLq5cRXp9iPicTNcpyF1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636893; c=relaxed/simple;
	bh=5bGjenHzvkBdHGe1T3S6yuOWnmAgJsbPGbu6ZHogcQ4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=umJOORK/v/kSQLHT+TysY2lQvH63yHHdXcxClinhe2YYeZEWqkL5V+7CsksHY3ZeqA/fOprCTa82wYHare5t38+x+eWs++NoTpvoApZ7nkBGE4DC0Dm+yGVUFT9bChIlWWiVCq0kibi9lcy9wxhvyDegIReVEON5FONVfegBMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o0Z8V8PK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b70c4a269so17355057b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636891; x=1720241691; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xU2ePkaYwaxsMEC4nCf5nFkpnVScQ7Rq2Qy7spzAkPI=;
        b=o0Z8V8PKpsS5Z9zyTq7enMdY4wmZzRyA0rg38MgPNIo7XDYT3v3psjH9uiVJqweiWG
         ARE9h3IZWEeZXxAm5UVx6LK+ZwKMDxxGsIRu/cbEisrRljt6K96cxxjnGQGfLc58kkoW
         oMIhoCbTHAUe0rYoL8HLFGVHVEJuq6u1t6zoVpTa5YG8em2OGxK7T4DKXS2EZlGii/6z
         09UFrauQFyVoGZXkVrHpEU/AO5+tw8i/e+pksBxzwZTWXLQUCIJJR2NR4SJm4zQI/170
         sV2WxZS1pQizxlC1kr2suhxkq2MBOlYlZe+nESnUClOzms9mBK1CD2chuzLf+u0wu90u
         12yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636891; x=1720241691;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xU2ePkaYwaxsMEC4nCf5nFkpnVScQ7Rq2Qy7spzAkPI=;
        b=VBsjW4x4vFhC0gGnmL0TzmCy5hf2W3Npvu0tFUXpJGFUUWA+ttRdpvPSd2wNM+7AR9
         E8RJmKuzjczmQZZTbqdIZhYfg72cWxY+5G9+34ZHOP39mc7/yNnVcbbQsm+3b/ajddbl
         mehqa0O5n0L3N1UP5vpXYcb5FkDJd9882mY1S0AVmxwbEJceJ831J5R2FDpEFUeG/9M5
         SF6DrGlqaNFelgZWXX3TI6a1LjhHfunN/ixOFV/oD3MR+0RgY+p7QcUqBWUOiBO1j281
         rnm/aC0jo8c5PiqjPqYXUTVXI3XKUyVephtBqSvcBceKIxtJQsspAh0stPxu4YqvSSHm
         YXTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSdUSzvJvLvh5dVVaRxDKIhmAwGWhiTDFFgZ+9B2dz6+2bZt7Cq9njvD7KmpYcwmJxoUoWLnntlGGVMYCI09ZnUy+o8l4aydpEj17z
X-Gm-Message-State: AOJu0YxTm2SyxSQSqL7rayWXEeUDgaqGtijAzMllohs8ZvolaEAiY/es
	QPNaV84m6mH5Fze71mxH4G9skbpdEPrXF3r6IZZp1LAZ2tGoJkY9oOKoL2031il4i9qmfeunlk0
	VwcxRSg==
X-Google-Smtp-Source: AGHT+IEEzCHRAXRjWuifRznTNR+xXUr1B6FYJ/XrEjcgKBjsRIQ7SVEp4zOMvCJbSvzApWprz+jwV/4JbeL7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:e03:2bfe:40c9 with SMTP
 id 3f1490d57ef6-e036eadbdb8mr579276.3.1719636890559; Fri, 28 Jun 2024
 21:54:50 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:41 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 19/28] perf sched: Use perf_tool__init
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
index 2d24250f60fa..2b227b01d64b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3013,7 +3013,6 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	sched->tool.tracing_data = perf_event__process_tracing_data;
 	sched->tool.build_id	 = perf_event__process_build_id;
 
-	sched->tool.ordered_events = true;
 	sched->tool.ordering_requires_timestamps = true;
 
 	symbol_conf.use_callchain = sched->show_callchain;
@@ -3511,14 +3510,6 @@ int cmd_sched(int argc, const char **argv)
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
@@ -3635,6 +3626,13 @@ int cmd_sched(int argc, const char **argv)
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
2.45.2.803.g4e1b14247a-goog


