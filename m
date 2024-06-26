Return-Path: <linux-kernel+bounces-231502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C091994B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8511CB23409
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A491C198E6D;
	Wed, 26 Jun 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzcfUK3s"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D69198A28
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434259; cv=none; b=u71ctjW2A1fztBa1qw4G6Xb40kQSXbvYplnItF3ciotGCm4YUuyZ3BPq1LojhYDMPhI/dSelTzs4A3S9TytvuKi17iZ+U+rlS708p5L94dPl7q+Gnq3oStlXPm2Jj/+o/6o2gUJui3X83F3YjknIHdnineJmgOKdYYWiB2HnUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434259; c=relaxed/simple;
	bh=k7QXVgVjC5ziryU8iqEZw+jIGB8CNwx93bpexssSTVM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=i7SE6h9oBr+f496aAMaMuyG68sDOTv/1j0N0L/YbuPHRBXtcPyqS+0iWUhaAIYbkzN1LeAdab9OaOCLT7tANkhaHpHwEq26SYv8r2SXl6p/wOzhtbhE6tW/N+map5jJGI9zMZcDWcLD/iSQT5bmWlAJIHG5wPmkIs/+h6MIz3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzcfUK3s; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dff4a650404so13945788276.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434256; x=1720039056; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAL+qN5eeqrm/YV9CC2nA0bNTj605bqM/+2MNtl5Dek=;
        b=JzcfUK3sUNepxqarsISAZwjLZ1X0ZIztuQIeLhyOpBQiFLidZT7wqpBHRN5pB/QMoX
         ZKcrX1vXSOuX2iCq4T39zhyN4xGU0eXcqoITSSvFGW0gQh8VOjll59+mdcN2yrUBGxbE
         vuf8ZfT/DOkJMaya2qOD6rQ0RRntzUSfiWGc66fGwxOrxQj4TuJJ7PyOU32T9BUjWaAo
         t+5oiK/FZKNWrYLpISYksJn8ksPgWUGwizDt36dfJ7bs5ThSMFY4aOmamH+U7pPRZZ+y
         /I0FBbLVqVHEdhBEzpHzzqnGCOzcd3pzOnynSb6n7uM+SGFPt+2zdYEVQ9QrMJX7PerE
         a+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434257; x=1720039057;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAL+qN5eeqrm/YV9CC2nA0bNTj605bqM/+2MNtl5Dek=;
        b=E1JdETFurSTYJCHY1j6xmNaazN2bu6veg0/McFx/5bje6UNJ8fnKpZHE9e4pbwu+OU
         XcQ9rKBhBN+peZUpgmKA7vTtPI2HBV6Mh45h9zWG5hRJgYRbOMC7lLOo0E1Wc5G8k4Z/
         avNbLx7H7hQRbN4LkE1EAlWoa5oWEuVshKoKpAIdEBpSDn9Eq8N7cJTzuZ9qoYxORfRX
         kS589HKLiFNrz5Bzmw8EGHW1YVG3dYy3ITHPI/JsnCNtAzABP5L8bynJPVA29WrMuhYA
         +K8jDPq6Uh7SXs2pi53IQX1Rrv0XXPOrF67pm8ospqQZkw2lMOlIl86BjBWcVYtf3Nwa
         bU3w==
X-Forwarded-Encrypted: i=1; AJvYcCVyrTLYNOQw6hvl7lEgNvfuTYDwNv0bs0nSKu4XAH972PQQjnPsBUsuZJHhibjZUcOuvbpnnEXLl/+QWsXG/m3NGcM0NuolwbwmBffH
X-Gm-Message-State: AOJu0YyQQQYZkzLN4daENGK69nNjsJmYIrqq/WIsxgDjZXseKg2A3SqG
	97MsIPAPQGCZz/D9Xig1MKfeByCNMbgwgzu2Fj+R0s8l6zohXhOVrMP0Dmaus/8WgZLcLP5b+Vz
	nBBVXMA==
X-Google-Smtp-Source: AGHT+IFNDgaSsvKWEhCLp/cJqqx8LLIcQIa91shbF03zPhK2DmfMDZISVjpcNxywqGfQrHzWLCzDwMoXnqBo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:dcd3:0:b0:e03:40f0:bdcd with SMTP id
 3f1490d57ef6-e0340f0bf60mr1486276.4.1719434256549; Wed, 26 Jun 2024 13:37:36
 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:27 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 25/27] perf kwork: Use perf_tool__init
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
 tools/perf/builtin-kwork.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8ffaa80a2d1d..6a4281b8fd10 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2322,12 +2322,6 @@ int cmd_kwork(int argc, const char **argv)
 {
 	static struct perf_kwork kwork = {
 		.class_list          = LIST_HEAD_INIT(kwork.class_list),
-		.tool = {
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.sample		= perf_kwork__process_tracepoint_sample,
-			.ordered_events = true,
-		},
 		.atom_page_list      = LIST_HEAD_INIT(kwork.atom_page_list),
 		.sort_list           = LIST_HEAD_INIT(kwork.sort_list),
 		.cmp_id              = LIST_HEAD_INIT(kwork.cmp_id),
@@ -2462,6 +2456,11 @@ int cmd_kwork(int argc, const char **argv)
 		"record", "report", "latency", "timehist", "top", NULL
 	};
 
+	perf_tool__init(&kwork.tool, /*ordered_events=*/true);
+	kwork.tool.mmap	  = perf_event__process_mmap;
+	kwork.tool.mmap2  = perf_event__process_mmap2;
+	kwork.tool.sample = perf_kwork__process_tracepoint_sample;
+
 	argc = parse_options_subcommand(argc, argv, kwork_options,
 					kwork_subcommands, kwork_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.45.2.741.gdbec12cfda-goog


