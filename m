Return-Path: <linux-kernel+bounces-234819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8833591CB22
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 07:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A67E1F236A7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF2513D89D;
	Sat, 29 Jun 2024 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SW+t2fLP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192BF13B597
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636908; cv=none; b=Hpp4RwKpTt5Kc56KcJUgo+P1eP6TC3AMBJq6P7PPKDL7iIYgilGbNyZd7OYytmKK4eWn22/CWuXcPVQs1WHufolgS4qILQxX2NEhN/zOnW7cVUx+aiNxMkPFbfeWyT8bTB+ictFl4KeGS41X/rD6WCIeGyAgvMJRdT8WEfVGmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636908; c=relaxed/simple;
	bh=aFN9NmprvYHspsTPeJICCEg1vuQoansQ66d71bQRhwM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FFR5Piekb+mB33Ggw/D44VEnareBLIeUJ/19/O5DME4P8wThxGsAFAAOP4pZRx9QeMpf/IsIbeBYz+Kah+nWHvGCI5KySM9egddsbQ97MCTnnvl0SihZ5shdZxJz+x7usQGbEizLDTkozHxN2kSLhCypA3lCmKLmzghsS5F/X7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SW+t2fLP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64ad9545c5cso22730817b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636906; x=1720241706; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXeNLLIjOusU04UE8Hy39/PSXCvPCHHaHA66oarVl78=;
        b=SW+t2fLPwqZCvKPCUWh/CgKjoWPpxvT/8fAiNHJBHm9gJt8gyycOLa2HzYsNc8DBfy
         2uccHuyKh0UxEvolOAbEfmbPIWgPAnEYWVtna1DTNMKdrJ6hpsASfFQ7rlA2tbZumwa/
         miSIsqqtwER+PbwKfNDEg2HdAl3w5j/WXY13hhoD20DV+nNrtdxaA0150zA/xBHh2Ljt
         fAY85PrQSBX779X+Flep+vMVZQdSO6+nqtFbwIoLEAT4jznE1StmjbtMVT+97eA34bTu
         zsUF0+MEyZ5tdHBCdbK+GVgXRyk3KkCDnAI8q8zgPYjADpAU7mc4/LpFUph5fSpvnSTC
         3arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636906; x=1720241706;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXeNLLIjOusU04UE8Hy39/PSXCvPCHHaHA66oarVl78=;
        b=S4waGK3szt0sExungRZhAOm7+MIxDBEp9qG+oYyYDCxRL/7NqORV+TGrzzqn/fpDcY
         QfBkE//KAMmmNKaKpjCYsU7f0kZ4W0o7YC2fHKP3RFk+OWAdubsLALg8XRZrDSOoX7XA
         7nrFh9azmOPrxm7svc8YRReeQ8UkowyQWnsHhkD2E7YlEz8LK+joMLN8WirxKPunx1vL
         B1eCQ7t9Kv9o2PwLCOpYpS3QYOaqkVDg45K9QaBezGAdd2eHHQVZrIL35GuPu1EEPCV8
         9VZJ/bP04eyfyLFcTKM3Fv4gjUNX/ZOnbtBgEKYInzJlFh1bllTIwdUPap6b4pahMs9s
         qSGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmvnmHwahrDUb3hpC55/QO/hETDGUNN/42Sr3Y6gAFFIK9VgqLBdB1+7JnudG5Z+vHMAlnb8oDy3Aq/ZxP3uJBkFJz9wOqofUJGz45
X-Gm-Message-State: AOJu0Yw0W3ols0kJXnTKqpi/EoDAeViyPq9ULs8jkQtCnrsBPYqHG1nY
	IPPeBF4a7Xnt33atetzDGqd30I4h7+YLzR7qaqdJg1Tbk5IcUxXpHrwKiKV7u0UmtSSK73DrudF
	4hs3s4Q==
X-Google-Smtp-Source: AGHT+IElgs2HpFD5MWivgPA3hytPYyiaidrhsD3Cfduya8NVonmx78LKxebOFss3pklN6AQYkFlKfBM0tJNk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a25:4a41:0:b0:e03:5050:acc5 with SMTP id
 3f1490d57ef6-e036eb5cfc0mr1539276.7.1719636906221; Fri, 28 Jun 2024 21:55:06
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:48 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 26/28] perf kwork: Use perf_tool__init
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
2.45.2.803.g4e1b14247a-goog


