Return-Path: <linux-kernel+bounces-340861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18B0987884
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD241F23522
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CCB15DBD5;
	Thu, 26 Sep 2024 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gaB6eSBg"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F751607AA
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372493; cv=none; b=Jr9sKhgVgKLM/CMLBeoK9ID75RligegLDJZxuIWeBmSWcMjoCn0ImGviKkqeDkJQ4l9WCe5dAV9deUNFMBdUoMwruF20lcMmDINRnyajFs7v05B4kZEy4MLY9mT64uiUrlBO2SLXYVaXK88cZJLElGwP49wg0pBaCtdTMNoGRek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372493; c=relaxed/simple;
	bh=wxD4M1wPspGNj1qN0DEx2BRkbiGnY9hTYJu4rALfML4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=u1V3hheOoO0H4JaMC9kja4GETqziykQADtCTrKNFUb26RnkcjlRIJLbMMFHJ65bsd7d11RxFAgwOy9+gea2nO81zfm/YPcwpmweSGg1weFDWDpDD9l+LSA0cB0oFzGVRK9U9plNI82NQIn2R9KpNAwGVc66DIZBI04H8II1Uikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gaB6eSBg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e163641feb9so2835175276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372490; x=1727977290; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jDTPq4kmT2pQ8DOcWhgozy3EZjkzPK6ybUm5utWhT9Y=;
        b=gaB6eSBguKaZJ5/IAoJKoLpUrMoYMqbUew8+g42/qgAW6q92ZaAZrqrO1fbZQ4JoXm
         7qVXeqGBq0kkmbPQd7wHKREgUdApuhiRFYSk5Xvkn6OlcVxOsl/WI03LgrhF4A7o4DdP
         WzUEVQEZsXjcp+YBaoZgQ/Jh9z0ibfd0yp9omZOEdgsz0N1fVWIA8VsLA0O3QGv2RSuk
         DG8366mbCVk+wWWJsOJnMDqZikgBYqHRnCfoKuOVVyFBY58VtwIHZ7L9j1/bD5Kfy3PK
         caKQ533qTBUcfd0wZV8bgsoZO1Pagiqvwzdqlv/Dk7kyYZwiJ47PEtkDNg02nzwP1Wtq
         tZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372490; x=1727977290;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDTPq4kmT2pQ8DOcWhgozy3EZjkzPK6ybUm5utWhT9Y=;
        b=FBUCa4aWTzNyxOjey3TzKr0iZf72j5dyL0fKhOzGO3A3Bd8GPE3uH8Yt77C6js/P2f
         pL4pTjfpe/yFGsqc150sOriBxYU3cpxx8Z4Dz3BcqVZyMHre4RV+IzdUGyC6lcRnUOUR
         XwYEWEAKG9taTPxgfG+Em9xGRINeqFcg5XT2OKaDPeZtTELItI5DLVqnj8SPoh5Ln5S/
         /tKPwDtav7WY8+M9bLpHp/LMPHfMx7Mq1BKid1+8gALTyIi24MP82xwZvUFEjz4GkQOT
         Y0d/qHZ7orJjeA9pZwqVgektmcpUmkRmgArVowawoZlozUow0RFAFkeuys+PCvXSXqWH
         jiog==
X-Forwarded-Encrypted: i=1; AJvYcCWoPoeP6gIbRTrFogx0J09HL658kwjNStXmoVZJpNW3jduN8f998ud1b+z/THItDFF4k3e1Ix3TxxJobdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB85TmrD6u0ix4s6JglwiAMElsbNYue7cozwqyp4Uj/YNK9Msm
	Cf5J+xt5lojXj9fr5885gb2rIT9IS10d8f9GOic44gJPPgKJY75+TOEUfg1oLCx/HfnbI07rzpr
	EdoeJiQ==
X-Google-Smtp-Source: AGHT+IFvUuajtOumWhVZBRqwt3ETVpuf6+/75RE11AuIl6HqgI7V9ZkjPH3FWJbB232qX6+AiGM0F2y6e1Ra
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:a283:0:b0:e24:b971:c4cb with SMTP id
 3f1490d57ef6-e25e4c0eb81mr9080276.2.1727372489479; Thu, 26 Sep 2024 10:41:29
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:58 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 09/12] perf jevents: Add uncore l3 metric group for AMD
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics use the amd_l3 PMU for access/miss/hit information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 7fd2139766f9..af99da14d946 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -466,6 +466,22 @@ def Rapl() -> MetricGroup:
   return MetricGroup("cpu_power", metrics,
                      description="Processor socket power consumption estimates")
 
+def UncoreL3():
+  acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+              "l3_lookup_state.all_l3_req_typs")
+  miss = Event("l3_lookup_state.l3_miss",
+               "l3_comb_clstr_state.request_miss")
+  acc = max(acc, miss)
+  hits = acc - miss
+
+  return MetricGroup("l3", [
+      Metric("l3_accesses", "L3 victim cache accesses",
+             d_ratio(acc, interval_sec), "accesses/sec"),
+      Metric("l3_hits", "L3 victim cache hit rate", d_ratio(hits, acc), "100%"),
+      Metric("l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+             "100%"),
+  ], description="L3 cache breakdown per CCX")
+
 
 def main() -> None:
   global _args
@@ -501,6 +517,7 @@ def main() -> None:
       AmdUpc(),
       Idle(),
       Rapl(),
+      UncoreL3(),
   ])
 
   if _args.metricgroups:
-- 
2.46.1.824.gd892dcdcdd-goog


