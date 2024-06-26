Return-Path: <linux-kernel+bounces-231495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D48919943
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E961C20818
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEEE196438;
	Wed, 26 Jun 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AK6+App9"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F7F195FE5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434244; cv=none; b=J25pjiMVGzPwN5fB+cPEiZ0xHp/EzeiZcFd1JEFYFPAgBv38Lek6qBKDk2BrVVCIjc3Z4E7GWZYzT9G4lFPbeft0AQjkvidA/OP38lDbPhlTf013olalTGE4tn228qwJfK0nCCrxm8T4oZdhDUIZHw3DRaitc+exT6hC2R++nO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434244; c=relaxed/simple;
	bh=p9FimwsA8nPd48DhGiskfbVWvAqnuMjqgwp7sG3YyCI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GStzWcWdCOY+ZhKboUXR7XivCti/psG+RzhCRsG1xc+F+ajUvwkdypX7Kl44gHN+P0Z0Q2Jaa/1pty2CgZSuNCH0fQaRz1xv0AIPU6f8cbtFJy1uzih6JlQJWXyC2N+SELkBGETNj3DIrttzC0T/vrkH4WM14svxuPRt4E+Wjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AK6+App9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0322e5d0daso1888628276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434241; x=1720039041; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noJh/0tjGkNOuuOrbqQtPJsWH5lRqwZr7bjDIe61TeY=;
        b=AK6+App9LxqCSmvmlt+bwOtcZbat2YFXee4EKciOtTUtNj1y3iX2PxJ4EeOiFD1QRP
         PBGE7DI0LJl7y6vEiMitudAOXs235jADAFWKBBF2Q7WzvUyALstI088IuYaNskPGCphF
         VhGsWt5jsgXe86Bb97A1/tX0Y+U7crJMfWLMGQln60PttIUyP7M3T6q1LGCMPnVx01a9
         PwvwtKW8Toz0uzSlCJ2hSY3x2kO3y29oLk1L6sRSx/RqOIUAFZOELsYrSpcft8cEm9CJ
         LXkOz54mndP0bqlsvTNm0zwnzkTk6cuygpj26VYvfXCFelgPG/30hLEuTWzc1pxTi1Hv
         AjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434241; x=1720039041;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noJh/0tjGkNOuuOrbqQtPJsWH5lRqwZr7bjDIe61TeY=;
        b=AaeP0TZkschwLmu7Rz9bLza+eSx9WTRMTarB6/mHrOjZPSZtWQXLXCXnYkbJ/pDI9o
         cEYwP2w9PluYEPHbwwHX7WRbUP+6NLMelOuj+Zs2mL5Xq5IF/cCO0r0IN2J3LgH3v/0j
         3v4Vm38TLfV67i9cojS6CHsTq4eJE9Lb5pMZSWFHUYeAxnIYzAkCv9E3jChZTvnIcjoR
         4Ur9DiiOSYR7PLdtnKmHzMl6Rf2EuxPeF5HpzHDywSPy47W4LD4XO3tDh/XWYZPD2mxn
         PMb4RBqVKrQu55hv+1sSfQXZKqScKnEocI1FteC+3kRn+KsdoD9RzrfLDrAa21ylj2gT
         JHCA==
X-Forwarded-Encrypted: i=1; AJvYcCX2125y2+fF+dHwJDd/DvEe+mvnYpOy8oMnTBvl/G1oLnMyYFAj/WRJRzAvW8+Jx/L8ZqAJV6kNW87jE53/SbuIVw7Kq18/cdsf9b7o
X-Gm-Message-State: AOJu0YwHb1UhHKQOKfQ9vpFNMStoQ+/w/VO2yUB48hy/F7f1JLkpIE9N
	eP8CpGD0HdOc6L8umYViQzLF8369wNMQRXovUv3RwIoPkxJXK/Q3pw7UkN/GBmx/XxEwgPxk4xd
	fdsVcGA==
X-Google-Smtp-Source: AGHT+IGiGW+2TJjLsVxDfeBzcOXXY+C6/W3uoEMYOZ3zt3pmoGji/Ifg/sPaursww2GTCUQox0G8p7+0iMLD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:ad0b:0:b0:e02:7c5f:e0d5 with SMTP id
 3f1490d57ef6-e03451b46ccmr89276.4.1719434240611; Wed, 26 Jun 2024 13:37:20
 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:20 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 18/27] perf sched: Use perf_tool__init
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
2.45.2.741.gdbec12cfda-goog


