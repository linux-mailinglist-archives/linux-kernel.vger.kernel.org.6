Return-Path: <linux-kernel+bounces-231500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CA7919949
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CEB285688
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6AF198830;
	Wed, 26 Jun 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3NGhoZgj"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9719882B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434254; cv=none; b=RSGOVZ9HhCT7hKFzVjNOnDulYyVjVE10zD44kprCuXmLgv1dS5qvL7d+rM/NqxuuAymMDd+wX1rm4LiU+NTGGvZyxaZs0JYNKMlx/i3WAkPwIWMVkYAecJycWnIyGQ7TbE/jk+W8ATZJ0vkWHWsECBmmxsuoj6qGvTmPFPQFjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434254; c=relaxed/simple;
	bh=4hregmkychdDNk+jks/Rw8XVYDtpylXDSeaooVz7NiM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aaJ3bFOBJEUmHEmKEPiPl5l3i3mVfGD4Wa8ERFXu3W1NRG4Y7BUuS3kNxj8aaEAme/00BAEQv0yPqhW2bl8S5C5oiCySfVVZdV6gOfPJ8M+6aMHkHWyXfx+ugkS9YYUIYXpU07hvWZB0hIis+N0ZQFfomgy5g1UF9CnmPX2Jxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3NGhoZgj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62d054b1ceeso146328317b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434252; x=1720039052; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHFcPRP+yhEWi0robOtIeOpLSabhSBGQ4xXRLMmGCaI=;
        b=3NGhoZgjQqk4W2wO9UoDeg9Z4eZuv2ksqQ36zy/zczw0KWTg3MSVqn9ocB7luMuLow
         qDiEdCRSBnIIkBnGNIsp5kFKnKiO6xnyasCC34kUhdxBLL6R4arje4VEL8p1Wx2lUvDv
         JldMvLUiyFIjQwAzph0xjCZln6VWWQOkksYIS7mBLLTyg5ShV0fmcqq9fE4qEBhV+Sec
         mM87bWICpGEn1y6mnU90k3HAzE+SbY2la3mMM3APFzJBxp0/vWKF+X9Q6nAIovBrCQA4
         uVh2Ql7UcoeZ65tmla25Zs/NuWRcoq3adYgGohnkRXIlGd19Ja40fyaGIivITL7Qyyxq
         G8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434252; x=1720039052;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHFcPRP+yhEWi0robOtIeOpLSabhSBGQ4xXRLMmGCaI=;
        b=SbV1v1B76bZ+0kBXZUSa5dPtILqM9CKVz/uxBs95hMehPaQ049nDxml2RspR8sFCzQ
         bMgSSRfxsZfe5raWcyuuDkVibzPCN7GhOtkvGo0TWhhywFCQmaOq3IHzzTOR0DzCDSLx
         iYtba/TNwFRDqdTEnPy+AK2hHKu/rTe0h5d/esA0IuNSEzLAUPKSAXBFrpzmC9YddacG
         AFfQ6JXng9QQ6gTgcBjm/XEtU495yf7TJMsYKbEdHgfh17jhGSBscQWfjggYCLgMfS5K
         afmUbYLGiHTbO9HXS+VN0cqfO4YNAILsFEHsdHYRDXVAsRryNMxkI3DP1ym/QoM6C5Zo
         T3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgbVFqkGQLLwEOR++7Ql/bXDgQAsnMBO1j8SabeqUQbozSCY6nDkGUy3Dbk1akei0te2JPhGsciW16lw3sAXSuNla23oqpsiT/6ntk
X-Gm-Message-State: AOJu0YyDch/TrtajZCBZxgqujipoY1HG5r3qj7EnXhcePiEmBaewzxcj
	i8EOSfB6I9eAEBFSGZWQQ4/lG4sDuX7yEOXEZZFCKlbKl3u6myqgS53ZZUmfe83DeuJLKaFGmXp
	uCL4teA==
X-Google-Smtp-Source: AGHT+IFJh90xA5zR81k/YAgHE8/x6XRCvuJUZgC/JjDthtGxwm0XkkDH8GPDxtXF5TzDpmTRTDcsIafOISw2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b12:b0:e02:ce2f:cf07 with SMTP
 id 3f1490d57ef6-e0303f2a6a8mr38528276.5.1719434252090; Wed, 26 Jun 2024
 13:37:32 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:25 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 23/27] perf data convert ctf: Use perf_tool__init
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
 tools/perf/util/data-convert-bt.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 9e2170604b66..021e9b1d5cc5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1607,25 +1607,23 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = opts->force,
 	};
-	struct convert c = {
-		.tool = {
-			.sample          = process_sample_event,
-			.mmap            = perf_event__process_mmap,
-			.mmap2           = perf_event__process_mmap2,
-			.comm            = perf_event__process_comm,
-			.exit            = perf_event__process_exit,
-			.fork            = perf_event__process_fork,
-			.lost            = perf_event__process_lost,
-			.tracing_data    = perf_event__process_tracing_data,
-			.build_id        = perf_event__process_build_id,
-			.namespaces      = perf_event__process_namespaces,
-			.ordered_events  = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct convert c = {};
 	struct ctf_writer *cw = &c.writer;
 	int err;
 
+	perf_tool__init(&c.tool, /*ordered_events=*/true);
+	c.tool.sample          = process_sample_event;
+	c.tool.mmap            = perf_event__process_mmap;
+	c.tool.mmap2           = perf_event__process_mmap2;
+	c.tool.comm            = perf_event__process_comm;
+	c.tool.exit            = perf_event__process_exit;
+	c.tool.fork            = perf_event__process_fork;
+	c.tool.lost            = perf_event__process_lost;
+	c.tool.tracing_data    = perf_event__process_tracing_data;
+	c.tool.build_id        = perf_event__process_build_id;
+	c.tool.namespaces      = perf_event__process_namespaces;
+	c.tool.ordering_requires_timestamps = true;
+
 	if (opts->all) {
 		c.tool.comm = process_comm_event;
 		c.tool.exit = process_exit_event;
-- 
2.45.2.741.gdbec12cfda-goog


