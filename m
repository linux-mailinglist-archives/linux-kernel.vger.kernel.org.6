Return-Path: <linux-kernel+bounces-255842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A707934598
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81F51F26B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9DC2E62D;
	Thu, 18 Jul 2024 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvDvZhK1"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF52BD05
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264500; cv=none; b=P0t9txvWty3Yd2nSsNH9rJAU0kaJtsy9DzxSTek/WsNAXy7YDWr05wMbHT3f8BATmvAlQb0XY0/uZFV4wRr3E2stdcIGRFNkwF2ft8XxDleoMp8aEfFDCosxmKyI9iae0w4Q2on2oXaVFE04T8q236TbFqWevBXtqzcKjyVeN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264500; c=relaxed/simple;
	bh=smgrs6vq+/EnN03NBWT8R6qmohPEAkYKFjCcTcvoAz8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XcGN5dSJfZdW2eBnqf3g8Y/R8LvjaJDAJsgRAe+QQNYDDyWApJKfhNdfm1dwpRjygWjIO9Z/fpZ6vufD92shdpCm9GIrX+eh0Op0w0287RKLTA1pNsnX0Gv9KuynqrPleIcJx6Ldd1+0zikWs6ttn2E3ofU83DkC76z/+OibTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvDvZhK1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03fe45dc0bso831077276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264494; x=1721869294; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CK59PJHvthhN1XqhU8dM7HWi+8LWSLWxbFsmB17zlH0=;
        b=IvDvZhK1hu+SeitPWTOeYxi0QFNA9A3hGz9UQS9A3j+V90p8BPkxrb1o3g4oy4YGrq
         S6HJn6h4iEiNFhXd/yBsV3gdlNbGVRcgvsMg1RaTX01oLvAv4y5ByLhQOZqZDKdJyyi0
         L9n7p1uEFSfKaTIFQVxhG/qmJ1b2PZ6ULH5B8MHbqJY9DfsA89D6Fm+mDKwGY7BBkVie
         X3cuo9/dxXgE9oii7udIanE2Mb/kAMOZV6YUCzJBfIURe8YIoqvY5Adr5BxZL9Ry7F8t
         AM4xfs2ru+IOzXdTFeYGpBrQtbqvsAMfPpgks5eV/0oJbpoFD4bEWmYjNo01NyGhim+6
         zcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264494; x=1721869294;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CK59PJHvthhN1XqhU8dM7HWi+8LWSLWxbFsmB17zlH0=;
        b=kkrnNfuS90o5x7brBA7bPUoe/hSbUaKDNd/fsywQh5j1hSWMkRu3LXFw1c1BK5p/7g
         WIzXEELYtNC/Rnh/ZImkRPfpDYf2EhOQor7rpJWaQiGKVvqTUXlac8NQBVQR6aWeCu70
         0GbazB4URg6MdtxAtjpJrqmdFS4E0UCbVhsHe46azl1S+bRz+w705ptDmLYuhImuGqu+
         FYpJtlVeOtvCgB1mxAOWnixh6OUVhyXR4ZnUzFWWtQz8rVYPGIOiJwVqeSk8t3Ms87jG
         pZluML1P8cjjRh3Dvam6OXIWUt65L8+prlq4K8it3Nm/Gdj66cmGN/WEX/VmiPU+uNil
         hLsg==
X-Forwarded-Encrypted: i=1; AJvYcCWFnh9LwLOXBQTAXVqR5hrj7nHxMwL6nARIu0nSC70apchmpga0qyFS3DBu9DVcDTNOwbIbAwrfcmOWob+JC0T0zI9kOBT+Zso+QvOB
X-Gm-Message-State: AOJu0YzaL/OB/SxMfxhj6aBhp6A35FhdVyPuD0R+wL2D+VlSMKMIlQdt
	KYxvKqgfhh77VPmEuBaVESo1KquVmdW8StiF8rXsTwZJzrhMLlQaIgzaV1q8u59Y4g0CQlQH8Ck
	FF6ZQfw==
X-Google-Smtp-Source: AGHT+IF0zgfiI7337Gx4Yjc5WQ+vYPQsx4H9UggbKoSxg5u9Xfw8UkV6hdUgp0OEYyULUUoe/l5TQODhg0kQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a5b:8c5:0:b0:e05:b006:9e12 with SMTP id
 3f1490d57ef6-e05fed6ced8mr7959276.11.1721264494077; Wed, 17 Jul 2024 18:01:34
 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:21 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 25/27] perf kwork: Use perf_tool__init
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
2.45.2.1089.g2a221341d9-goog


