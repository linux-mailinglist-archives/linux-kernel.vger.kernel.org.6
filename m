Return-Path: <linux-kernel+bounces-231497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BA5919946
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9624B220E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E10A197A6B;
	Wed, 26 Jun 2024 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8kZYEJ3"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A8197543
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434248; cv=none; b=DegAjawTi3ABJ9BfzN+E+xApwYAfQHXKplJy6XX+xsXrYfb0DJhHsTxT+jrEatCvyMgc+rsfLR5UwuQvkMZC4ceIGQZ4P1hP/16xCTvYVDC/v4UWqQna3B8JT33M68z4hsRi1VanU5EbsCfT0DCS7gbS8AtXQf30uXHnXa/Ojs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434248; c=relaxed/simple;
	bh=wyJ+MS1hXvC6jnjDEgOqcoNvRhtG2Ev85ERR2gsbIdw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=umLsjVua0if/2R5g+PU2qXUHJgc3jDsQAEynJRB5lRJ6lkhrcha8Qzo3VGxNEu8MQ8dDjXFaGvdBhBSpfUNSchvLuFXtwAGlWi9G+xl4+mp5XKyYIq0cXfx/BjvKKx2NpbjHMqIkAknoGxg0FfAm9Hzkf1loxMdypkDKZZy+p18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8kZYEJ3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df771b5e942so13633814276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434245; x=1720039045; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ygd9VSeBzmgIFn0KNDzBnTE+heYOe9Db6FtOSFvMpYw=;
        b=t8kZYEJ3Dp7rq+wqrkUv1eoQoRlmB7Y5UGfdOUoVUP0M/e+C9pAp023YchDFEs+QP3
         Qq1dx3bI5eU9B1UM6QAArDrX+rPdWl9k0uw/3vVhB45FWZcmeP36b2SLbogJx956NHj7
         0jicq/1SYjEzxl/BxLcUJFLWOKBMKyp611r8J/IZ56QgfF+qr9ve74Bv/EU9BCWYT2Ww
         eYy1REbmJmRY8T/rn6FowF3AVtybPweef/HOQ8NCrCKdPBAvftmgfARFwAcUj3GJiw5u
         6ms9OThTKyonxSo60ZAX9j2g4J4ORnX2cCtRxBMwls6ajDmaRODhHHdCPq+1KcFQl2+v
         tn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434245; x=1720039045;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygd9VSeBzmgIFn0KNDzBnTE+heYOe9Db6FtOSFvMpYw=;
        b=Db6gk+2K1iGJAiFbqm4hUt+LxCvGfCO1aMmjqgl0nYFcbD6XPR29ijt83mNcyh8SOW
         81iPN07jW6MWT9xSZdM+gOQ0fR25ajrmIcGDMLE4Eg5MsbjXdd9XahNSRylnD8L0k9Rv
         8rZnJfGL/1FrRoO0hygxilsQtm339RwFtdSQ5RmqwvUn47Y2ylykGvqY7Mt7KoLG5gcQ
         OQQ0LTGM4Ocjc1op0y7vLv0f/sR+CDXRyfxjJbOFjJ69AeHrru2lnt61J4VxNHSz7HZL
         XyTu2WTebPwtSDnzJtJtfTQqfpz9SFNIvKsJCqf2kWgvsCjOpuYxiG6iqAVqbV0IkvgU
         IcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ifkEgEofr1TCS1MAN0XHGHgKnD/0Gw6Xb4RymDK8vtwWaSd9a3+wF1uaJTv88AsFpGLAhn+n9nJEbly4hohZ7YbO0U4997ZN2mYu
X-Gm-Message-State: AOJu0YzivbdYQxDQ1J7bQA+e28t3qeO+NAVjNcYJYuIEyiy6EK1E+317
	llvLAqp1cjvBVQnRd0unvWGaeC5uTbSaWXsifAoAxAA0zQhg7Cub1Ovgr/HAA6HvZsp1uwzXwPo
	OPD14OA==
X-Google-Smtp-Source: AGHT+IF/vcrraNGO8BvvwHEaNEI4MnPwEjIw3svMWd/uO2vmBwnso/c7O4FDmbKBdx/YPU/OIZxWVyD57VYv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:1009:b0:e03:252a:f931 with SMTP
 id 3f1490d57ef6-e03252afca1mr11973276.1.1719434245280; Wed, 26 Jun 2024
 13:37:25 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:22 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 20/27] perf timechart: Use perf_tool__init
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
 tools/perf/builtin-timechart.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 5bf818baa662..218c8b44d7be 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1606,10 +1606,16 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = tchart->force,
 	};
-
-	struct perf_session *session = perf_session__new(&data, &tchart->tool);
+	struct perf_session *session;
 	int ret = -EINVAL;
 
+	perf_tool__init(&tchart->tool, /*ordered_events=*/true);
+	tchart->tool.comm		 = process_comm_event;
+	tchart->tool.fork		 = process_fork_event;
+	tchart->tool.exit		 = process_exit_event;
+	tchart->tool.sample		 = process_sample_event;
+
+	session = perf_session__new(&data, &tchart->tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
@@ -1924,13 +1930,6 @@ parse_time(const struct option *opt, const char *arg, int __maybe_unused unset)
 int cmd_timechart(int argc, const char **argv)
 {
 	struct timechart tchart = {
-		.tool = {
-			.comm		 = process_comm_event,
-			.fork		 = process_fork_event,
-			.exit		 = process_exit_event,
-			.sample		 = process_sample_event,
-			.ordered_events	 = true,
-		},
 		.proc_num = 15,
 		.min_time = NSEC_PER_MSEC,
 		.merge_dist = 1000,
-- 
2.45.2.741.gdbec12cfda-goog


