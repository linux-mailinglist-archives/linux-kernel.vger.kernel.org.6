Return-Path: <linux-kernel+bounces-231493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3B091993E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2441B23E87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47991195B04;
	Wed, 26 Jun 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jp84zSvE"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E111957ED
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434238; cv=none; b=JtCXc8/VGP6QsWpRTHGF+OTzakYOtFcmSLghUM/GkrWvAZj8fJhhfU4zZi4btys+h6jHMRG8BvWn1HIxa4BQuOUkhy2UQE/BLi3njhEZkEjyyZTsIGDr6abTsp6A+edgxyZ+004eH6rbiHsUSGdyAOafPRXdslRzyrOTmqM7ipI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434238; c=relaxed/simple;
	bh=4w87sKvNwVN1XhdwrvqeSGrSkFFASpDkmJtJS5HZHW4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=biYsGOwMMk8HEWkYpbwjQKRK7F6tqZjv3rA66S0VGMZ7cq5TMpr7/dAcCJ3JzpDlh3Ny0/npoqb2Oq4pBV872GS3DL3k8pSeoX8NAHI0sSxC42WLeEn4tgJypOr15N89ezD5OTjExjxxO41hy2nRcP2CEasdJZikjK+sIzuq3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jp84zSvE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02ba91b9f4so1270294276.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434236; x=1720039036; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m0zVM37WL2jQNln7xrBKCslp+8pFTT04OTNtW91i/Qc=;
        b=Jp84zSvED2CJ4/tOzX6r8XMAqb8eMoBjdRCwRdsyvjZUWB57Zafuui0R30ulaBQbeZ
         2NTYZQyanKraXN5ykDKiseZ3G6IPnsyuh208IJNPITyAWgdhXfbCHzRgI+k9SNaQs2bd
         rnWWyee5q3ZMrJby/Z9gaYOQLUKn/DxpVLgxJ0oHQJ3kXBIiAkZFdDJscZnVR2bxBQ1V
         606YmSMfTfdNnxEdmSLvL7mxH8lUVxG47+oyP5sGw1qSDBUIFkuDniyONretOr8gi3kb
         8x+XAQw+ZZ7FQZ4T+LgR3FdV8T+DklKpR7HRntSzVSJxnwbx1AC04wPJTkEr/stId6g5
         iuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434236; x=1720039036;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0zVM37WL2jQNln7xrBKCslp+8pFTT04OTNtW91i/Qc=;
        b=UxE6t/sdarxQMumwd6thbSMFqOC27zpnipdSkn3OfV4hwgNaD99dTlbAf2sK9eU8/1
         WlP0ra/r337XVvh/duAZtHpq8rG4eXU4QjwE6Ze6H1XRRo1R+PFJznct+r97NIZ+vqrJ
         335jsr1OTXuqeHNj8Ky3K6AVRzHbDH7JEiddEjsYNvvchOigXrhIBHYUdiUEJSnfVs3w
         6QthYHGSsnmLCQ5mdJdhvuVyxKAy58XL6aifiMoURARXWUN2gbR9KioAa0zYk6OyFEXr
         rwr8gza5BEgh4Y+dj66NpUL3ROUnoQoWp+gZW+Boluzd5nrA591S5IZSw8eNwlIqbr9s
         2DMg==
X-Forwarded-Encrypted: i=1; AJvYcCV/GbIEj9Hej9ypB4K2PoFGVFlgxebidVVPZIzTVWh1oNDEw8kifKj+cklbuLlj1SA9Ys91g0vbXi7u5Ja/c7e/vcdqF04VVKYNc8bW
X-Gm-Message-State: AOJu0Yyd8COv7fRMhVrotAuPT5W5wLwb0kha7jExrVg7XewY8iBvpSZL
	H9zvhE2UAdCX0qi8r8092Wk3NkT3wDQw8yPln3zeBpPeo+qBhXGfAww1XJP4xif2k1CFuqAgrZo
	edsLUbg==
X-Google-Smtp-Source: AGHT+IEdvjzHXQRmiTPCVocpPSkdF6uIWaJjq0GRNCNUep0zQF7CpSWTKGCjbHc0CcZZYOIBveH+JUOt7qyE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:727:b0:dfb:b1d:a16f with SMTP id
 3f1490d57ef6-e03423f3a92mr38602276.3.1719434236037; Wed, 26 Jun 2024 13:37:16
 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:18 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 16/27] perf stat: Use perf_tool__init
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
 tools/perf/builtin-stat.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d460c46f15fd..a3d77a55d17f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2271,15 +2271,6 @@ static const char * const stat_report_usage[] = {
 };
 
 static struct perf_stat perf_stat = {
-	.tool = {
-		.attr		= perf_event__process_attr,
-		.event_update	= perf_event__process_event_update,
-		.thread_map	= process_thread_map_event,
-		.cpu_map	= process_cpu_map_event,
-		.stat_config	= process_stat_config_event,
-		.stat		= perf_event__process_stat_event,
-		.stat_round	= process_stat_round_event,
-	},
 	.aggr_mode	= AGGR_UNSET,
 	.aggr_level	= 0,
 };
@@ -2322,6 +2313,15 @@ static int __cmd_report(int argc, const char **argv)
 	perf_stat.data.path = input_name;
 	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
+	perf_tool__init(&perf_stat.tool, /*ordered_events=*/false);
+	perf_stat.tool.attr		= perf_event__process_attr;
+	perf_stat.tool.event_update	= perf_event__process_event_update;
+	perf_stat.tool.thread_map	= process_thread_map_event;
+	perf_stat.tool.cpu_map		= process_cpu_map_event;
+	perf_stat.tool.stat_config	= process_stat_config_event;
+	perf_stat.tool.stat		= perf_event__process_stat_event;
+	perf_stat.tool.stat_round	= process_stat_round_event;
+
 	session = perf_session__new(&perf_stat.data, &perf_stat.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog


