Return-Path: <linux-kernel+bounces-283760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA25894F879
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD40D1C21BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95C19D896;
	Mon, 12 Aug 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhEXD9iA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451A19D08A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495695; cv=none; b=gEejiUpKkfYFUBuZ3XubFWDQdasrAVr5TmqDNftp+G9RuW1aaSOhqGijX60RDJExwNNWNP7TyWaVPQDNy2faKfxJnmVe96kkzVCSnaT577ChTK3Uw1RJ/aJR1jH3ufI3ipFviuOa4yPcTSHqDPG7U7pO+mBXV3oftOovvjHrEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495695; c=relaxed/simple;
	bh=XlcqevKdj6BLHmNjROXVEGuOGInw+XfJV/IBonZ+eeU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qOJv9trdIkDFBhZF/FeaWfFescQqXnlxj5SarhgSkPhd3hjVwLMn7/eV3QnsngSBsUlAVvLL7+Am58fsc3uwhBA2616gdVzSi67B9LgeM1gxc5rXl+FpRbnK0obkaUBjbC45qGINnbFBl5bkMrKXo4UYMSrbOINE5LUizz2z8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AhEXD9iA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664aa55c690so110237757b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495693; x=1724100493; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRgA1lihGvLTddTTZqgJ/lO6lNaMhGJCMkfVsAIf/yU=;
        b=AhEXD9iA2FQRLIaWzXaU3K65MjF/dVFf6PJHcBaV4BOG4IEpGKMxNpfZjq7jmULAzC
         I8xNovosWAWkO6x+Md4XmnKG1rCKt1/vNKtBKLmb3kj3Pl0t5tzQi2aIi+0dtDC7FPok
         jNvSpaLmql6VGyWZzPKay0eSmeHNaZw9CFoH6bvy9KDsyC41JxzlsDZc2eAd90hd8v76
         RzpEiaC3KGMlzX+H5NZdvD2LzIVnHjB0UibaKhh+c6lqrPv0eW3AfiAxF9cJc55zW/d/
         /2US9gaUSQ38VhkjILKyu+YBhdwWfX+oiNbY6geECKK8pJePQRagq/aTYiD64vt6N9cd
         l5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495693; x=1724100493;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRgA1lihGvLTddTTZqgJ/lO6lNaMhGJCMkfVsAIf/yU=;
        b=t9rUm3gOJfU8SVwy6zPfJ6G80ZZn8Diecr14VHXK6RC8BxaQTn64ozXcDR6H1cJ13X
         YMgM9AepCFW6yi35Rf++VWjNKZ3TbOTDl2flJyBGxN15QmjasRpTgTC6pBYfFBcw7JJ/
         ymX2ndKyJXP3iuoY86f03A3QCmAFxDb7kUaWnT5LZkFv0Sd29GUyLIm7kQtexllyPrOx
         36VfCStV3jmOgJMrXXnsVgvG5xZ4hFOoj6yGH5yzLzC5bUWioBCiB4srOIOO6qGh3ZwZ
         C8fLZ1hDvy2aN15yRWWFeUINpjuOCAP0UnRwOps1ix8T/VXScrtlZ9g9JvbKLBAbZSFm
         9l5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbgA6H4/agf/41iPJF1+ZGol9lWyhrmthjSmKNuG8PURYjBWOu/dm8NB6gjsYhCWKgNLCKRMCy0wwiuMj2XxPg1ga3lRublMD0PH1Q
X-Gm-Message-State: AOJu0YyTvEnSfLbIVaCBaPVtskU9Ue+bIID1hmJg5GezpjAUR/rSf2Pf
	gABgZRQ1ISQcGhTu7dKTcAeGoxiU1E1s9HTyaXybBbVsZNDFIpH2XyJ5W81AazWiQuTQDEa9hBV
	YTxyKbw==
X-Google-Smtp-Source: AGHT+IEjWqSzzD91sKJHefl74i8oWqMBx/tc3sJORhlRuDuK0H0B0q25A5wWaABqAWkAEbCkS0GPuVGqJKBv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a05:690c:2fc4:b0:673:b39a:9291 with SMTP
 id 00721157ae682-6a9720a3717mr260267b3.3.1723495693016; Mon, 12 Aug 2024
 13:48:13 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:13 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 21/27] perf diff: Use perf_tool__init
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
2.46.0.76.ge559c4bf1a-goog


