Return-Path: <linux-kernel+bounces-251075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACD593005B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F28B22743
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44FF17D898;
	Fri, 12 Jul 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjxIIe6J"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED7F17DA13
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807979; cv=none; b=dxTSi4s15S2EVl4ksDKGS7i5E9bDaWzNvNh3SSTXszrNgERmbdkFSISDP+j6YG7wYt1tR+1WeArLZdfByuzwD9erHLQLGGKAgTvDQ5AJJKmxeq3rIY832FdOfyPPBNrRe4g5rYo39ILyusJjdjsvryXj/clM2P2x5ZhognQ6ED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807979; c=relaxed/simple;
	bh=voKswfKfj3xVUdanTG/Vv01I1kScl7Vgd1gUmqiYueA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cRWWixUOFXFg/r4zLP90gouj0fkPMsXvINjfVK+EXy2fayoD7ZTaUxbkV390o/hd2ZQmhoCsBlW/i6QrpazZdBH82Z9Pjj7BoT9VgDePahy6+l2BZRPP1aVvRryaPquntRmnZjr24Tz1uiX35VgsP1bWrIm+YTNXQjDZ7ggbzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjxIIe6J; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64f30b1f8ecso35116377b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807976; x=1721412776; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yt616h8hRCivHeAdqJzIY5ztVTyVV8Crah5Wq3Zf1UM=;
        b=RjxIIe6JK8aIiU3xHoxlAVKgHnwARDfDy1PlfDqsfzO0n3dnwEMVTOeZHEEEX9pZZG
         sfnzHVdndapFTlgzCTuSWtsES++yoWMC9SXgvBVEEVyzs+sdeMeauvCesUFDw2cviV+e
         4LSms1R6mmxCNN6XcW0BgTo6FNBgqGU1FXEKxmWLjYI52iguvbhT96JBFAUjN+/QGpVP
         FbhPytkPZLsU55NpCfY+C1ywH0C2bgbKys07/Jyql+OKOoGxHXbN8F/sV2CvSvzR5r3M
         eyCMUn1g+iP3npgApJtJMD7FLHVFeRE5Y68DPC+gT0s0Hm8ho3WWciwcbt2t6lYD+Y2i
         2qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807976; x=1721412776;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt616h8hRCivHeAdqJzIY5ztVTyVV8Crah5Wq3Zf1UM=;
        b=mgHs1CZVL2TWIByC6q6ALsAwYY4nX528EwjNx4hjD0oQ5m2jnBvtVRNz8P8sbbA82J
         flvbYF31Bc49eKUd1wpmiD6RY6SXna5k9phICGq0ombJwTfavrHFmf3dPDOdur2YFkJf
         rGmCkMw5EabI5v1f3lasnRgmj/SjyXH5H88P0AsECAg50/7e5LrARPsMeL2f4ai1PaTS
         a4ZO0W5F/37h1PoO66WzXmPCA86G3qgr4dNLj806c2kC3ZPDwbrr+63RO03a3uLHUFD+
         JCRWG8D++wCMifcy1FebHp4jAw0VpCvAv9ogFpRpQga5cGCNIxDxROV6cr7sp8LBppzK
         4jHQ==
X-Forwarded-Encrypted: i=1; AJvYcCViE4sfL+u+2oUKVs3RauOl3ymummUnaSesYVYKHlH3lPnLnJU4d9k9pQ+bIw6hxJWEEeFnzi6a0Kxt5c0x6+8vh79DOOnizs6PyJQv
X-Gm-Message-State: AOJu0YxWE4iN+FIS+SOg9fNswplbnO9FTihF6Y7L69y90tlIFrZVF3nU
	HPrl2qvtTpEwKM+5Yr5Z2pXB2JQyAEh4V136mOjphFJNoWvqqkj7YjhjHrXx8ttL8K9aJh/zBfv
	OFdjGeQ==
X-Google-Smtp-Source: AGHT+IEoiv7jL/sMkb1DG/QD598pjkLvo+odw5YGkLQIBl/s8wzmd3RFOvk+HEu5aaX3z2x7O3Zr1FccgHT0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:690c:67c5:b0:627:dad9:bf54 with SMTP
 id 00721157ae682-658f10b0c9emr1670067b3.10.1720807976515; Fri, 12 Jul 2024
 11:12:56 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:02 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 21/27] perf diff: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog


