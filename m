Return-Path: <linux-kernel+bounces-234810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A591CB19
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75B6282645
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B5D7E782;
	Sat, 29 Jun 2024 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMeohwKn"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1A78C88
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636888; cv=none; b=r1Bg1yuPHaRkFuUKLDzpDiorH7jgDdSYl6RHlZu8PR22ytTh53+z4YEO1AxYSsfxtYOBgG3wrsnKhvGYOWSMw45SGGUg/zhpWN5fsx1a5i6vko1C151aEYIQb+u0gRuD1HUx36ULhjAWOoD1zkIouSP78Fxu5inMvgtxrN7hprk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636888; c=relaxed/simple;
	bh=+24dvcFrcSdrBB3CeoNAqsNzoNbKm0Su7a/aysFcikU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=r3XuTE6H2vdO8h+6WtUieTTvQorOWjMLi2AY7Bt3DE6sO2OTcOJfk3VH5HUdQQHkJ+u3EYtqhynbIuchPHu/c4sPXhA2WLGsCC+flS4Zj5uwh/Yh4s8x3ZFgqpGGFTBJ0eAiDLBlerPjfCw/VPqgOIGpkjQpEuvKvAc4yG9fQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMeohwKn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035d85f403so2076722276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636886; x=1720241686; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tYlBTwPn3+TIMd7izcUiVni6qR00lCI2TQ4vp279eEY=;
        b=rMeohwKnuvTjJmh7vG8kt1AiwnG959sJakSDz6OM0qX5RfwbopPZJroQSEqkX5d2GP
         kQRfZTpK0+eC8JeVqyuPdCruUYhDkypqgcDBX2Y1AgRTTZjeRKz9C0i5Q5u2OHl82tNo
         8hYutm22XToMyUiDmufZUeSwaRSzMWep3KojH2lBys/JAG9EQUYj5aTlP20k6DbU3fE8
         8THsSM5IlC9cIL5KhFSmdUBTUkvrWOCOcUsQuuQOn2OyUfSCe672FYwktU165Gi9iHH8
         KCUl7S6Ge4djT7FFhxRbfyLInLwiboKIbOnEZi0SDkBSE13u7cn6EPxfJ2/n7ytIlBcn
         juoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636886; x=1720241686;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYlBTwPn3+TIMd7izcUiVni6qR00lCI2TQ4vp279eEY=;
        b=eP1ioKrMXuB7UwSCimb09IBHFTMGQEvOEcrHiRtxZtMFG+k9iFX8GhXIgc44RI3jNs
         lUwPlxqWBR3gDeDt5Jr9wE4+2UwipjfOpem7OTuFB5sEl/MQNOcyR5FYDEzt/pwY8aXx
         JBUTyr4sJOQfpLW9VQzG9rIAS76YEzq/beXJsRvZmLPUVMLnEIXaseyGr+NwCXENcFZj
         HNxZIMi5G39HekzDIQRsbiNfLt2kHXIDRe2JAue9e0pzAX2rr8Pw0TRg+A4lMR7wZMnp
         BI+sUzeFv9N9tgV5RmJc0OYFvFxKT162vadkmWtNq1OMXnfvWDe6EaT8ioLAXuwQdtN8
         DBUw==
X-Forwarded-Encrypted: i=1; AJvYcCUPpkOr+aeZ6ELEn1JiwAQU5fLldAWySVWGkY5pb42j03JkeWkwNG/I1OLiGQyR5/Z6qnz8xxxI5E3rhF4HaFgAgK2Y15LY5e3/SnRc
X-Gm-Message-State: AOJu0YyJ6vxZXWpYAmbsyJLSwE7o4fg6+XNpsCUT5YyPU24EBa4cLisq
	vLa5myGkHRwbujxoLJ9XPJpd1H0zAGDweVuMO5cBVWwNzcv0C3eXq02aJKWcSEv/lE8B/o7Y/gM
	vKBEbtA==
X-Google-Smtp-Source: AGHT+IHlQ3lGTncxadGi4dpG3dzFKLZlZ5PNCPROQuxBGCgOp2Nj4DS8VTLWK+y0KutvPgqptznFewhLK3SB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:e03:2bfe:40c9 with SMTP
 id 3f1490d57ef6-e036eadbdb8mr577276.3.1719636886110; Fri, 28 Jun 2024
 21:54:46 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:39 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 17/28] perf stat: Use perf_tool__init
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
2.45.2.803.g4e1b14247a-goog


