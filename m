Return-Path: <linux-kernel+bounces-251079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C587493005F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473531F22D24
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58317967F;
	Fri, 12 Jul 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVyQYX1S"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703417E91D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807988; cv=none; b=PXh+IlU75t6I+nziVYpChx4xvIUGZ04C8K/mydDmo5/okR1eOaNp5OotC+otfDbXPGC5swHQREStXf2jyAIo1gN1WyUdTMaftoGE0745zQzt0eFATVM5KWUO34oLLI2/wpelXdtIlsbWgwhEdJ0Jwft5ZoQy5jn18nsPJsnr2QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807988; c=relaxed/simple;
	bh=Vut48/dGoEfPl82dZRBs1EiuBD2BZmTC7MWAiL1FIkY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=l8Vqt8qfOYu7Fo8Akh/5LQCgHGUIS4wOio9JBMio7DfyUNFUNg/tx04gYzvaDf2t1OaOEjVjh/cHLVseTWFmyh9SCJGGO2pxlS+WaGEcQERWTztuV3Aq0DhlN2KY/t5fMa73dlg1KK78Q16CSPOibF11H3wOEeK0MQDqJn5SseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVyQYX1S; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03641334e0so3751691276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807986; x=1721412786; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phxqvYyYZFcsS+fO7HmN6BaHRpzOxQeFfvDLLgr+3hE=;
        b=YVyQYX1S3LMTGLFTT5Y3VofmBblpBhm40WZsFqC0DhUR+YCrormI6gn17OAEveBj7A
         e8TqMKC50XcDb6pJ4Jt64k3XN/4OP53GfroTcB8+6X+sJzMXcgrvzvCy2ODo4TuWTwrJ
         OwMbD6S4pQLBph4IHIYqHINMGJkvzLplMBMMufplUOnYYx5zQKiUrMmuRiLC3O/lJlJA
         HlILyqc4/ZS1at0nwlk/285wsL+MuyZGR+5newwO2UpPx6KLjYzbkZ+1QjgC67n68S88
         IYpb7CRi3qNd1OykG7141ASiobJLzeXSJoEQd9zGbOK4dDKYACpHa2TjXjnrLXDEgJez
         gLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807986; x=1721412786;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phxqvYyYZFcsS+fO7HmN6BaHRpzOxQeFfvDLLgr+3hE=;
        b=ajrtE6r2uDf7w0Sxa1JHkw+a/8xwIRVbj1KWcC9HEvmjGqu7mjlC+5kdB4jrvXyd9i
         H7+YC0pZ3o5nd13riAC9r6rwWY41B8fsc/QZiF3mJChczsPgHpjGeItCAeN1G/clhXBj
         mnB/JsKRmPUHCqEc4/4DprVRO3pBp4M1DIa2L4ECzvWPFqvH6r3D652gHkW9km2l75H+
         QW6WHDGdYsR/LZUysA+F1NL9NyVbpJhtrMEooWdE6eV7arSkRo+WG6ZeCGSNtRvfBx0/
         qerHDyN1zW5LOXlSUudEOqWtUAIM2+aCM5dH4AJX3gQoKf+X+M4n6u4grPoAgXGIzKDq
         B1NA==
X-Forwarded-Encrypted: i=1; AJvYcCWH5HcPvTCHxlXKfkE2H7sOjNhHQyV2swynhjqaBpkW/l5AJmkOjGsxBsA87yPSWjK5jJSDqIA6/hmJn9bKSHKrTTO+7/TjfE4Y1oSt
X-Gm-Message-State: AOJu0YxTQrCPwj39IMwh1IiF+r3KceYEMhGeyg0IfIjGGW4nWOpcy7de
	iqC+HOr9CQhDdDBydozgS7J/IvLmOQa/IeDlWRcZP42NPcGyeekoLErebOUxqTWytYzHM/w6BNC
	jqqwlvw==
X-Google-Smtp-Source: AGHT+IH55ouNUARRkV/7vwiojtMsBJqnZMjnyHFWfmbeG3E2oRRjNgYMj3GXuyIvTVcz6xeK7mzL5W5Xp8yA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b0c:b0:dff:396c:c457 with SMTP
 id 3f1490d57ef6-e041b0364b6mr21640276.3.1720807985767; Fri, 12 Jul 2024
 11:13:05 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:06 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 25/27] perf kwork: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog


