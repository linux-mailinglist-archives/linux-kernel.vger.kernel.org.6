Return-Path: <linux-kernel+bounces-255834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF0C934590
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068631F26275
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E540770F3;
	Thu, 18 Jul 2024 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWZK5MFG"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F87581A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264480; cv=none; b=i8KpKHGpkRF3P1jhqD1sgOJiXC8inJhXbodvaeP46GQ9Tvzx5vPVsyVQC31vMmVFAuh5rp4SVFfFw6YS6TApc9SIYWe4BfT58WBglLxf8VSDC+zZ6IdqD2eEADP4kBopuKUxricqvQsGn/oxZ0oELNNrBUMZO000NiKRS3mnzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264480; c=relaxed/simple;
	bh=6n88zCXwG9bSPE66xVrogeJqWiH/mhJHqZDV/21qFRs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k8YISckYJsSDAU+sHa0oCXMo9kOphbNqva+dmZXsZRA/oRlkoVuDjqIL4TtAPNq0Vd78yAWavZXSrpT6Zmhl0ADPVKxmjb1Xx7ePi/IceQGlyctqwoZgBpF2wPr+m2ngCdnWsiRPBFpehj+NeWorX3iw3OrD24+z1Mjw4PR+OhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWZK5MFG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-65fdbfb8fe9so6128117b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264474; x=1721869274; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AE1o9GzylDTNU/tj+neWnduRfzORtFIhqRzpNenF16s=;
        b=WWZK5MFGOscimF/pHy7HO3SHDrp65DK2CYqUmZybdyIHSQRdUmNTKo7e1QcI35wveu
         3d95JicckjFaUAZzcJd2O8zhFW0Ql+HTMEYrvsuN3VfuXmwxUKYwnj0xOTqKR1Z3X+wb
         jlQAbS8gDD8IVecWbSoQi/MrYwNLx43i69Ni8FA2YV7FGhtw21zVCMwjPEtNf/ZDZlNI
         2FtZg8tbnDHRyfPidxqKuheIZsS010VDneP4HiUKOI6z4iNxFmk34Jjuljb3GIjCrUyJ
         YYnENLXzb7hBQzdswvLs+dmLktH2j51WS0CcCASrDoNY9DdVXn1RPWloG00MdLKpUMh5
         3+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264474; x=1721869274;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AE1o9GzylDTNU/tj+neWnduRfzORtFIhqRzpNenF16s=;
        b=gCIkU0HWVe1GjWtNvHdx3dIQYrc6y5iTp4j+SytSfNiDMDZebrFbodVuILBTsqoCsq
         frTZ74QDaXojynCWWKXKmlYLuQvPcUvI5Athd4hgB7vPc1z4aVBmzhe4ox7S62+s7BrE
         /DVCFOTvL0/yZH52EMlJugtDZsBcqYcQnpRyRoEsb8u6Xk/jh1oKOjUghm/SN7dNrUAN
         MEHAl+l6PukapLNQqMQTkQZnuSh/bKOLeKZynYiEGCH/X1+KCqjP1LMXNkHg4XexYf/B
         bS4lslx3RTqjq3yrYysp8DTDXcozzLVbLIn3qFyCm5cE5Kvj2PdM0Kph/NBeyGIBazuh
         J1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVrDmMLR1Vs2tpvfhHKgk7AJL7YXhsgwNK+98hClvdgPGKkqyxExp3vpYYXEmq+4uh+qkJV7eNRrr3/Lw8lQueu4OlqBHmDuuGozBFb
X-Gm-Message-State: AOJu0Yw8HAY05qPG9BK0ywecwL0G6uSrk0NcTMuPAthiQQAoVCQGJqMR
	GHnxHkg1w6bPsXrdx0lJqZxiiulBMvGZffvnF8Fp2wyi9wTbpDXvqXWVHk40J+4/0jbpKqjOWvW
	ZfjNvEw==
X-Google-Smtp-Source: AGHT+IGgBhJ/vZuBVSyFSptR6UrX0xinXo4sb/hBXkBYSLP3hMqMO6tKzBxK9aNEcm7jyYNyXiyoQrcO72E7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:1245:b0:e03:a0dd:43c1 with SMTP
 id 3f1490d57ef6-e05fe74c656mr10367276.0.1721264473975; Wed, 17 Jul 2024
 18:01:13 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:12 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 16/27] perf stat: Use perf_tool__init
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
2.45.2.1089.g2a221341d9-goog


