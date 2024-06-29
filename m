Return-Path: <linux-kernel+bounces-234815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ED191CB1E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37170282FE2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7531304AD;
	Sat, 29 Jun 2024 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qRN7+nv"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F6986126
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636900; cv=none; b=okmzc9DhO15xE+2elgaXPmECWz1XU/rQOVpK6UuXWOfU7CVxY7OoAHuXOFso+22u5MYcq6MmQ+xqkkEfVRuN1NdGjn87f56oGjsneApDYIXgXVTbd6ZyZ5MYrqqdFzWsI72s12cdbTi7YGlT8Y4TCaHaQJq6rF3FC23cWq6cgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636900; c=relaxed/simple;
	bh=gy8GNA9gy1ZCTINiybTx/C9ke2pX0ptvQ1WPaWEqBVA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cMabtZ71wIQvz1Ie5DOH/T+vy6eIrQ96Ru2hn/PvQaE+pQ1SJX1bBzU/2qLNKHZcQpe/V22acz8EHYdOGdqggSdv1dmt5N7Bt95C8tQKgsD48fYCudqc3JBeh2naA4SCr3ZM6v3s+gfstmcNseCnynZSpcsKyUm81B8T2ZiBSNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qRN7+nv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e032d4cf26aso2460550276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636897; x=1720241697; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0v3fokev8dqp3wp/KzvIIEo7fWRsPgHRVVSDRon34u4=;
        b=1qRN7+nv8eQRrS6T1oS39W0CDdSDY97p+XM0q6PvdSH9z0XNotEVlo600ljk9v4Amm
         lm6lZ0sugn6DHtV9GtCIRwGWCbVNSBdn/UMH1Um6jJX7mJc5Y7KRfFsAVoMRGJQguWbJ
         6k25lpWP6+KBpu/q/Rc7/urCsn3bLrsvLWl8QQAkmXqaPRLSkDiVbLHAAkZHLWxattTL
         BB6rd8ugieU4cs7RefK0HPYXLxlCJHPMN1HSi3n3NsOYU7WYXEx60yoi53rilBx44Klt
         2KGhbVIFcliN5mKH+Xbi6CjLCK6MdVYmFNCic6V85/0MeEiHsqTqVGgkV9pSGl1ZKFAD
         94+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636897; x=1720241697;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0v3fokev8dqp3wp/KzvIIEo7fWRsPgHRVVSDRon34u4=;
        b=XrFjo4F8x/w1XBiLjOm4Y9RyVw+OheaPdkowCJcTRL0683eId8HNTf44XoCyMAn0YQ
         H5jljHfSDAEo5gDh3qTd7L/LvLCZN5m/CofMZlyktEb5ejl1JwFnZ3vMqnhTMCQSPfxm
         oXIlFyhfsenkjPLv3IrjVUXOl2l6O0oQCDHAhKHU6YDqameZvegktDkdSwqHaafG/x4u
         tul5yTuCtn0Dt1bXZkMFr1//cbd8TU0XdvP6rIp5wyD9MPhTONs+g0pldlotP65SOeV4
         itix06dgOb+IpTxQaBzTDE7WFAM4jGDH19JTJ87PTpDA3dyTG/E6hSuwvCBZWxepNZ1H
         hw+g==
X-Forwarded-Encrypted: i=1; AJvYcCVvQKQd7FMgK8xQgjIhwWUrMHyTd9O6yXBsYp71hkvvjpRIndNT0c/5WbWKS4dCkuJfG3+JlWhnQP8rhsL9e9TKWwpXOnD8sYtnyt9h
X-Gm-Message-State: AOJu0YwJSoNfEsnWaLScy7f4k1+EJTrZDsP19d34uBAkXqwh21r8zqGf
	mSChuRKmoF9P1E9Rgug20XnovXX3UpECJ8B9Q17k/9SGeym94S+UOt+iQ4bN/1fTQoWSQJAkHz5
	PwF54mQ==
X-Google-Smtp-Source: AGHT+IFebbTbrBD46jrbbAKmEiQhr8CIpwzw2fa35jGiBLO5MmgTjOTYHAA/dOn6kgN3PXW8P1kNAUf1baWR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:724:b0:e03:31ec:8a24 with SMTP id
 3f1490d57ef6-e036ec2e117mr860276.8.1719636897584; Fri, 28 Jun 2024 21:54:57
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:44 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 22/28] perf diff: Use perf_tool__init
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
 tools/perf/builtin-diff.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 4c0567882a7a..28c5208fcdc9 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -467,21 +467,7 @@ static int diff__process_sample_event(const struct perf_tool *tool,
 	return ret;
 }
 
-static struct perf_diff pdiff = {
-	.tool = {
-		.sample	= diff__process_sample_event,
-		.mmap	= perf_event__process_mmap,
-		.mmap2	= perf_event__process_mmap2,
-		.comm	= perf_event__process_comm,
-		.exit	= perf_event__process_exit,
-		.fork	= perf_event__process_fork,
-		.lost	= perf_event__process_lost,
-		.namespaces = perf_event__process_namespaces,
-		.cgroup = perf_event__process_cgroup,
-		.ordered_events = true,
-		.ordering_requires_timestamps = true,
-	},
-};
+static struct perf_diff pdiff;
 
 static struct evsel *evsel_match(struct evsel *evsel,
 				      struct evlist *evlist)
@@ -1959,6 +1945,18 @@ int cmd_diff(int argc, const char **argv)
 	if (ret < 0)
 		return ret;
 
+	perf_tool__init(&pdiff.tool, /*ordered_events=*/true);
+	pdiff.tool.sample	= diff__process_sample_event;
+	pdiff.tool.mmap	= perf_event__process_mmap;
+	pdiff.tool.mmap2	= perf_event__process_mmap2;
+	pdiff.tool.comm	= perf_event__process_comm;
+	pdiff.tool.exit	= perf_event__process_exit;
+	pdiff.tool.fork	= perf_event__process_fork;
+	pdiff.tool.lost	= perf_event__process_lost;
+	pdiff.tool.namespaces = perf_event__process_namespaces;
+	pdiff.tool.cgroup = perf_event__process_cgroup;
+	pdiff.tool.ordering_requires_timestamps = true;
+
 	perf_config(diff__config, NULL);
 
 	argc = parse_options(argc, argv, options, diff_usage, 0);
-- 
2.45.2.803.g4e1b14247a-goog


