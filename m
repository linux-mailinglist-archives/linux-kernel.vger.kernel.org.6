Return-Path: <linux-kernel+bounces-283754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F594F871
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043041F21C86
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A5C19A298;
	Mon, 12 Aug 2024 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqNMxQ4u"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BBC1953B9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495684; cv=none; b=ZithI2cAavB+NSK3O3FzW3jvH1Hzp+QyuSZJEUwsDYijWZJdQzzEvYU+drMUIbxbYfsQmuRT8FStc9xlBf2UPoy5IyFvaRZU85wlrlE60eozKSJq/4T4JY13jPm43TeKOMaRwA6zHoW5qPy2M2jM5j8LseqPRvnz7z/RcZteVYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495684; c=relaxed/simple;
	bh=DVFtISnKDKLkZ8m8k8gpqNMjmA6vTiMl2KwGVOg3XK0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dJHAy2nm7poIm0phPsJkoK6AuvJvM+tNPQJQRuDhmw5/PHjcixqMCopXk5NTonmP9HpwcM8P3UBrdD7LqrvJB48k6gwTlzVHTcT50dT4GOWwzNQHwduWJ4nfjAm/iwtHeP5wUipSF3c7RmusRD3Ci8KC9Pd9SJu3rc46cYILP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqNMxQ4u; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0872023b7dso7659939276.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495682; x=1724100482; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSz3KLOdrMthwKDpYtohwO+EbRwfCbBekFhX3ull1Hw=;
        b=sqNMxQ4uQxIN99iX4OizcCv8z5RvtZwcFTNReHXfDG7BsJWMxXhMlciDLm/zTRTzXw
         bWsNTK0Pqez/9T3C4g5Lo6MWRmqP8Bzxm8YmtOspoecE9PpSbvNfaToEL0Ha7sgh6edA
         2P8mCWClOBgDRIBA+AkoE0llZUKzTmSJG2nyiWFpVEb1ZXr5iieJHLVFl9lI5JwQp08Y
         P31WsPqNSSx15zQhOKVLUkxfZh70jLLbGxI+XxE2jqoMorxJuH5Xddu2u/uTFdos5tal
         BKVyvqNloPzQv2SbKUA7KsqBM4htzb+nD7IJZqFX+nLH/Lo6RVE8M5N7Wu1LJmE95erU
         +JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495682; x=1724100482;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSz3KLOdrMthwKDpYtohwO+EbRwfCbBekFhX3ull1Hw=;
        b=vnhm/a50uz2WlD0spZkZ3rYVkAGX2UeuEOY3I0FUzRhP2Gva4vSN7BiVgIcGfiiMzG
         znf1WT/8V6ErgWg+GtosZPFYgslM9RLsq3JQNT55yDIh/ULCuii/oZkNDZkDRI665Aa2
         2RAXoGxf0BJ9mgBYz+TQ4Jq6gucREQkXeS7OngDceOtcvvI5vzChFX51ZMFXg9G+tuXf
         5tMEqkYEaPRf4Lwi0hNETFiDpr64V26EgyEoGAulMl56q+8BgEB0X0rU6z0TE9ZqCH6y
         eJr11hKNi9VwOUbyVL2ogiuKD9ATp4/IbyH5J8JKv+NWhqdfY19r5DsyKzVJXbuWW5jO
         VdDA==
X-Forwarded-Encrypted: i=1; AJvYcCX1a4whJYhBdVRPSlDLWBuV41K+X9AuXdmd9iWiMFylw42+tyGQtOdry2+EuiqpyuAAoyvFPsJcBhZdUhimVjLEmz30zswMbcSF0xuh
X-Gm-Message-State: AOJu0YxMLFMKCyj31x2vtDZr/Fb0/0cmPMt/tvitP5ZzZPBQrw8xRcbV
	h5+KSjtahYDW8f9FnylrciKKSuXXmh1tt3eNN/m1afJ3Y031FqOU79MEXNUTlu2I74OKpIeyapg
	PSAIX1Q==
X-Google-Smtp-Source: AGHT+IHuR7xHxfAp/zgJIBrSuShCMuj6OT04czAqkESnYImrj7+2RFVRHK/QMzpEWRcnE8XzpfcpAWdR/JcN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:8407:0:b0:e05:faf5:a19e with SMTP id
 3f1490d57ef6-e113ce7249fmr2863276.6.1723495681908; Mon, 12 Aug 2024 13:48:01
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:08 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 16/27] perf stat: Use perf_tool__init
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
index d44e708f8a44..487eff9a8582 100644
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
2.46.0.76.ge559c4bf1a-goog


