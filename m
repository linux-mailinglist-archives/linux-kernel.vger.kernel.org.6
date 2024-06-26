Return-Path: <linux-kernel+bounces-231498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4661B919947
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A9D1F21092
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F98E196C68;
	Wed, 26 Jun 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/LYpcN/"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B2197A65
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434250; cv=none; b=WEA8UfEhMOcOS2dTa3riAYohMda58v2TMAn96LlOxrPhP9Qu/Ua5VmAh3W/rHtxg5M2rM/eemItWFfLR38WGLuRtdXvTWBWP2DvL5wGpAeor4wQeFLpdAEOo9bA7KqN6HIk7iZ9yhaQ8kn/YI7qc6SoSm8N1ebumnhcHjxFKa1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434250; c=relaxed/simple;
	bh=76f5hIdhPASzAgHsGB/OHAjt6PyB0XUm4Scq3YWqa1Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=de+vnD5K8cMK3AZEL4zF3AOPighJdCDj1HMKK61h1ZXbWDP3MWGtGfzWyfk+KEzMUPr4sk5qqKF/8Bnn775R8geF9ZUsM9JHBX6HvarCdhrZJk2zS+zIuaZ1/f22WdDLJRbKnb4crvV9XTBH1ewKfohFk/8BYoBsBqx6lvAzDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/LYpcN/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03356970faso1734604276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434248; x=1720039048; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+eUWDVM6QBZsAa2Jo8FHym45eB780ogdLDPw0XzQlM=;
        b=B/LYpcN/fViwIGxr50Qem/TbICEM+qRsV8+UgzQs2Sx7POUn/s4dm9eDlZCPKTIjyD
         BY5h98rFHlT2d3nR6KKgEoDIAKG+JvMo/xOkOl5w14OZ8lNxmhfi9EhvZx3FiSr0x/Vg
         pEOn3P6QTJ+CcFUZR2I3yeWPhxsz2XdCovdmByjdHihV3oTZsbBY8rN7cNWfyoJs8TZc
         skwVhg97sa1EUP9D23Q3IjmPOQuooVToT2qo9Ocx14jev3soOFG0X9SP/I2XO1sSaUuJ
         MbgJr6jPRzXRDruyYZ2ftGzSRodmR6LQxVUX0VEjdbVQT8PTvi1ww/+tv++tFlsOlivA
         x1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434248; x=1720039048;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+eUWDVM6QBZsAa2Jo8FHym45eB780ogdLDPw0XzQlM=;
        b=n4ic0TGr0OlPUIpO2/dNr9oVTmqWZPap6378Wgs1IBDblWmxN4Qn8Eg7ViqbKMkPTV
         BmiDynrHQxceFUoDcXw+yZ+Xy+ffoGqG3PA02hBumEiaFDV3w/kChlXbAoyUI4AiSLIg
         ufrnHVW7n4KlsdjihWRCImjyIIHz896qw/9+fKQzjZTchuy2J2qj0O63QTJ6Ynn+52JK
         oV1E583DDtYC9BUyPodNksWngPFrg288htdPaubqh+hkNdAjsgvIOdpxReIpo+bq8ZTA
         uI6CaciWt9xkjKAjhC+sIKnX/seMMTJ4bNvaRiezkJcozzpM4AQFlibYX3/FVVMCC4Df
         3syA==
X-Forwarded-Encrypted: i=1; AJvYcCWKtGHNF+VKREVQ3MaYSxYImDFpmSkmyAN9J/41rmY4TEL6b3Bwct9KC9Vq+damgS0+JtYeHuqiMvyfqD5NQ7dn8jEkkGiCZixRve7r
X-Gm-Message-State: AOJu0YyQEvdxMJlftt5kfXtZm2NKLBfMDrcSJ5qj9gqtd/5GzcViS/Ar
	1dGncREPkOx4fRYviEYIopZjoCPNJ469l/ls/HhOzX/X7prJ7fun8fd/UEe6To/uta5mCo1RcTE
	8vvjbcQ==
X-Google-Smtp-Source: AGHT+IGK7lEMZbXEloyFcWkWnNtovrkJgcXd3lNq1ruLQ78TDJ2ALy68c+95Mra/WGL6eiCxX23BeAO5lDBd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a25:dc84:0:b0:e02:e1c7:6943 with SMTP id
 3f1490d57ef6-e030400522emr31542276.12.1719434247639; Wed, 26 Jun 2024
 13:37:27 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:23 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 21/27] perf diff: Use perf_tool__init
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
2.45.2.741.gdbec12cfda-goog


