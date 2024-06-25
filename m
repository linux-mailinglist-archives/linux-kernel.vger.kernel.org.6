Return-Path: <linux-kernel+bounces-229404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01A2916F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F3AB22922
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4169717E904;
	Tue, 25 Jun 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4u/I7CeO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07D17E8E0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336408; cv=none; b=KmJELQ0Ucxw2s2Xg7Dr0BjvGoBVHC2evdcGnm5yVkT+iCBzMyESbORJvMYlIL9+AbQ+3bxavI+aTXisDht2M1Y0CuQdj1BRFNNjjYVWBldZHiJR11DtpbVjwAYtgQejLiANiYNVjEP/rnmJiOQzV83nLWGcwReVyjyhEWTNutxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336408; c=relaxed/simple;
	bh=L5+qi8RxZ+t+xnykVP/RV3pn8WQq68NW1vIVlrz7BB4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cS8rrpqtgcRrL3B+lqmPuS6SGSr5PgCymmFO2YpyFaGm0V/0thtuDyKhHpGTgIxcYyy4/ef92H+sjveCSJZveuK2yQjA7ZqgocWPo+k+1VdsKdVHGQNqpZ+DTn3s+I4nafTO3w9HS6Z6HNodmYhysAdObonBbm4U6+XBZUXzZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4u/I7CeO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-646f6df9683so21172707b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336406; x=1719941206; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFS5Ls/8uEdl/uKj99agh7Vw5SW/HlvZFMCUW5Ei1+o=;
        b=4u/I7CeObDvTnNvS08XzYDJyaGUOAtF4L0NkgTsG1O4DNh+r49IW3ppLAxKfSxqNWD
         XRinY0iKNoWttqNDDNyp1e6+6iK48jaShIWqcmu76QqsCbh7nZffL07vlxcCtgryRU9+
         93bGA1SCKYvgwKHYRIcnZTZFQDTwor1LfMVitJ5OMd54+mHriCIKZMub9jx7ib2r6/rR
         LoFFt/DCMxvtEpT3yq5hpod3R+og/XBnvhaHGUVZnB75X2skDTOh3u3w+onMLlHlaPNq
         FwQPxofESGwngroJj/VSbBbfkC4ugRljn/avXaYGkRAU6imvSjGM3X4xeRpQ1iKrwN7w
         pZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336406; x=1719941206;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFS5Ls/8uEdl/uKj99agh7Vw5SW/HlvZFMCUW5Ei1+o=;
        b=Yo7aV+TV898OHLcuHSES+6mE1qwaWmsemMejMD+CQd0yOADJQKuzM3T6saDE9v+0md
         sDcaeMQePZt/c+2GeNDDVl6kF7DIYuChDsbxlqFmGnsf9VjQae3w5RBhe3dK9QhL8ufL
         qhalhLVeIESUDfISEGN0Ek+M3GltkPIKhD6zq9aFQgrhynaRZuuq0q6DbTyGodISMaIH
         LJpxUYt8zil22Viizzr11WtyBHlloVtaz38YqqoRCzUFe+9IdUL0VfBN5KZPr9AJazx0
         3o0XeRvVtSTNb/Bj/DJvM3mgSCQloTqTIoFQgkrP6yus3sTN0D4QNcMW6otjClCz19ln
         StYg==
X-Forwarded-Encrypted: i=1; AJvYcCUfuN5VahrNwqjr7EYYzVLaxxOXPLEUkVfXT7HwT6DE7Kfjj1QA52+Mnn6Qt04wVuB7P3BIji3X7edXUSh3IPKipa+z4J9zX6fKnUTn
X-Gm-Message-State: AOJu0YzPrXsgHj4lL6KJEkJM+4i8+/jx131UHuxBk7ObHKe2ZVDZQbT5
	QOvDjA8zRsUuZAIHFOfo8fLLWVuon8Zzbxp2cxysSm+TY9RPat3k6ZlAkIWUV1eOFjIyPGWYFag
	PXSIuYQ==
X-Google-Smtp-Source: AGHT+IF2BBEzG8n4Im5E24amspFsISbhyUmDqM3EEW8J7qrGP6Z7MGgO5UpQnw4ikMBEFLJs2umKcM9K/jt4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:7201:b0:62d:a29:537e with SMTP id
 00721157ae682-643abe4101fmr5489867b3.4.1719336406177; Tue, 25 Jun 2024
 10:26:46 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:53 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 16/26] perf sched: Use perf_tool__init
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
index ad6c6d2ce149..84cd6a013e42 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3010,7 +3010,6 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	sched->tool.tracing_data = perf_event__process_tracing_data;
 	sched->tool.build_id	 = perf_event__process_build_id;
 
-	sched->tool.ordered_events = true;
 	sched->tool.ordering_requires_timestamps = true;
 
 	symbol_conf.use_callchain = sched->show_callchain;
@@ -3508,14 +3507,6 @@ int cmd_sched(int argc, const char **argv)
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
@@ -3632,6 +3623,13 @@ int cmd_sched(int argc, const char **argv)
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


