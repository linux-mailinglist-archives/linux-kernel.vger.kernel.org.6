Return-Path: <linux-kernel+bounces-249669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4015592EE59
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717FE1C209D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F517CA04;
	Thu, 11 Jul 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xUqBDCG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02617C21B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720873; cv=none; b=doyBkGCdJUC/U6cPRQQLyhulJfk2XpSY5aWBRVi/mtq03IZATJHQ+fraCNA2fcthRttJyHaoDgFjHPBXv5px5EVNDIre3+MHDVAAh62WhLeD3hvXMh8ppYk+/RWf2Q+9TnGh5C+ZsGLG3FbpONY8E35Nj+8+QCyndJ2h6dv2r9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720873; c=relaxed/simple;
	bh=Vut48/dGoEfPl82dZRBs1EiuBD2BZmTC7MWAiL1FIkY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=i4lrlHUSpai/5SGsJrXkP/PmORqFKmy8JNHB6o+MLVo37aZw6tQyiw5K9zw919BSxlAwqE4U6MWOtP16T8Z+My7KCHnX84IN/ws9vWs6nPVUgoGC8oPGCEoeSbEwfzbYZj19/B6E9Ob75GYlNHbMrqJz5wudUZ2GYu6sN3xdvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xUqBDCG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05600ade22so2355458276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720871; x=1721325671; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phxqvYyYZFcsS+fO7HmN6BaHRpzOxQeFfvDLLgr+3hE=;
        b=0xUqBDCGfyuwy8qpZpVlBqmQVconYW645bN8exRhjwVOWu3WDrrzfXJOR9HD1en6Dw
         9FPkwG7/Gv/KSEmtCri8dhMGLzd/AGLke6btrFcpUaHYwPpY3O1rMZ+3w/L6ZXR6ruw/
         U8z1gM26CUfkSaVWqEBOWhFpbP1p1Be8Ovb0r+AHsErlTd74MAqNatVx/RAJRfa6rFkH
         uWZfRVBPyQX9CwSp666FSPluE4BuxnGeVqjTQo7YL+dAw9venK9O0o8pLeqFHg0kH9wp
         ZWzNgDINgQ3C+rauH9s1i1v6NN/yFROvCZAp99pmirNeOhOeb5QQRO1OEDC8JneclWKH
         3Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720871; x=1721325671;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phxqvYyYZFcsS+fO7HmN6BaHRpzOxQeFfvDLLgr+3hE=;
        b=FZySGItYG4t2X+zUul7EHLS0z/CSNRMr4bP/biJ1yxWocoAY9363HM44Je17BYrOaL
         aCJjDTClod2rPc4RE90F9j1zxV4mAyYkty1SB3ACxtvtsMUjm1rs86irh/3W8i22Auaq
         5AWejEfeTyIeFZVp0TwcWr+JhbjM1wSDS5elA5uEGPaVQYu5I59U9OsakKN6cfaAX0SL
         xlrmRaVi6gzqAv8GrS8DdjtsEdUCdwkyBHLhuXMZ67G5k46EjEGpyY1R7jOcKwnVM47H
         zcfa655FCdM6JL5oMCWL4/sh5pGJL0z3G/XPyWEQXNZEdPJSJ1npTOpaly0B50SaLt6r
         bf1A==
X-Forwarded-Encrypted: i=1; AJvYcCWCQOHhA+oR1luMufpmSpK//+7JS6X/p2VyoNTb7E+eRG/paZHownG2Pb3euatRUx2Jxr2srIF3CwSdMx7F1vHiPZVm0G1gBSx9hOGK
X-Gm-Message-State: AOJu0YzzcxaSRtDGBSOE3TTACfHVrW4PHLFSbjcMCNUVKp1SE/prgLfA
	M0+DN/FeWbcf3AFjUFdsu/4zxkwlu0iHvJG8KksxujnzqEgyOove4q7B2s+bCGG7az96DnVmZ3d
	NQbg75w==
X-Google-Smtp-Source: AGHT+IHZsWRlk2KFoxmTrNHpb3twRLUr9YEReI+JPWVj//rgcz8mi631WHmc5+OCJP04cre0HLmnLn54Z7fH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1389:b0:e02:f35c:d398 with SMTP
 id 3f1490d57ef6-e058a707db8mr1072276.0.1720720870908; Thu, 11 Jul 2024
 11:01:10 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:06 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 26/28] perf kwork: Use perf_tool__init
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
 tools/perf/builtin-kwork.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 8ffaa80a2d1d..6a4281b8fd10 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2322,12 +2322,6 @@ int cmd_kwork(int argc, const char **argv)
 {
 	static struct perf_kwork kwork = {
 		.class_list          = LIST_HEAD_INIT(kwork.class_list),
-		.tool = {
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.sample		= perf_kwork__process_tracepoint_sample,
-			.ordered_events = true,
-		},
 		.atom_page_list      = LIST_HEAD_INIT(kwork.atom_page_list),
 		.sort_list           = LIST_HEAD_INIT(kwork.sort_list),
 		.cmp_id              = LIST_HEAD_INIT(kwork.cmp_id),
@@ -2462,6 +2456,11 @@ int cmd_kwork(int argc, const char **argv)
 		"record", "report", "latency", "timehist", "top", NULL
 	};
 
+	perf_tool__init(&kwork.tool, /*ordered_events=*/true);
+	kwork.tool.mmap	  = perf_event__process_mmap;
+	kwork.tool.mmap2  = perf_event__process_mmap2;
+	kwork.tool.sample = perf_kwork__process_tracepoint_sample;
+
 	argc = parse_options_subcommand(argc, argv, kwork_options,
 					kwork_subcommands, kwork_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.45.2.993.g49e7a77208-goog


