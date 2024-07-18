Return-Path: <linux-kernel+bounces-255837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6725B934593
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E6A1C218A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDAD7C6DF;
	Thu, 18 Jul 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKkev3AH"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A57581A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264485; cv=none; b=WbqxkWHNl0JBOvxmC1a1CvrTRqoBNLaoDdLuhCef7qOLgKaLdMFnJExmLgQsUtXnlLu6qEEp39JEvAqrJKCa/9rjEXHc5EN/kWnBNpwhAe5RSDT0MA4idFe49fsJTACxnQC/KYogrnvTskzVMdCs2gHoDSDi818aQvlhtwofdas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264485; c=relaxed/simple;
	bh=5n56mjuu2839fDPcAxqZPMwy+ARy/VmiiiMQ5jI5utQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TJQLfcG4if4cut9a6OPlBBmhthe97Pm2wc7pkzVJ+xR0ZeN4f2E+OrBJ7TxbW6ZZIYuigsJYDGkIVGCqGgd/WWfIDhVRXh+k/38lPCL7qW/EfJUU/ibhMdOZat7LWGdMbZtYUN5qCjo55pY/xN8HAUdnGO4KILYamjHpdYhmrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKkev3AH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05f9611400so633047276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264483; x=1721869283; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnEjjhiFWiWK1ZjHSoRI+4nKrjjHTPs3eA/kl5KV2XA=;
        b=qKkev3AHRMGFTYcPszyImhUit9bS01+xVUrJp1r8wDqpBZuqYLMOC9OfaoShQh+1Uk
         fQxqLC1BuftAWVIQjEtQs2FLTL0ZOtWUK/r9Y3sxw0mcEiM0VW+Lg9MlpVZXrHonFQ7B
         O/Bbu09/SGq5vYQmUQg/Hehht2/YTglioRhPuxH6/pGXjHPu4g+3y01DaQrujfcNCzL1
         uIECVrv7Homtr0taq6wgY18mBquBMlXj2r0Q88dbYOu4MoYdqV9IbzRg3doOPIOP3RSp
         imckauG5tHX6B/+E8kV/T4avJrn1Oed6APuoR9fvtZTGGVPOYTO8mf1NmcLKZCuNassi
         uakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264483; x=1721869283;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnEjjhiFWiWK1ZjHSoRI+4nKrjjHTPs3eA/kl5KV2XA=;
        b=UqtQB8xXI7eH10zqxiWGuqesgCM56HzaOu0kbiG3/oOvpphYSln58fK2sHKSqj6YVL
         eurpfaT77FJIsPMZ8uy5PwViVZeGBLAVvsyZnJmNCTSR4vucN//6iEJz5dEabQtCYJbh
         3ny74zHXV7SvyNC3d3h7n27nqXqhUHZaAJZFVQSOvANoKtURqz/668z+1Ey+6VQNkMkj
         c+skI4XdZnsAObvJkwsFV4f8kqJXWdijnjb/ADGoS62j2BpuhtSUzs3XSANhRllIUaNz
         OF3xnLFdGxcIYK1eUy6dU3I+K6jooPGxPx9nobGVIw9QEbkkgAkhmG5RuMDKn9JCx3ni
         VnSw==
X-Forwarded-Encrypted: i=1; AJvYcCU8RnRQL9ZiiySWuOgXAt7x28uUPpUjkcP0ZO36diuD4WnFusEs7+7rO9ENod4sjTe6MHDFrp4pqnZ/Twh+4K5AjhdlxL6xtxvSBlsq
X-Gm-Message-State: AOJu0YziNthNJFHv3aiwlUhbJF7ow4di+olp5nYeIGis3QXsgnm8RqgH
	/0crofvtRN77AXf74qbb/WK3ftC9i4hvlFQlgxeD2n9HXTsm0/wN3YV04YyhS+1EPtZf78YFZON
	/Al+/Rg==
X-Google-Smtp-Source: AGHT+IGc02dcns067S/+Js+jqFzEtFv/PZyENgn6kRY6kp4H5xE8Md1QOSwjwqbLR9srevWvPq7mRSuwgOSG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a5b:885:0:b0:e03:5a51:382f with SMTP id
 3f1490d57ef6-e05fed80951mr2244276.8.1721264483228; Wed, 17 Jul 2024 18:01:23
 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:16 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 20/27] perf timechart: Use perf_tool__init
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
 tools/perf/builtin-timechart.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 5bf818baa662..218c8b44d7be 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1606,10 +1606,16 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = tchart->force,
 	};
-
-	struct perf_session *session = perf_session__new(&data, &tchart->tool);
+	struct perf_session *session;
 	int ret = -EINVAL;
 
+	perf_tool__init(&tchart->tool, /*ordered_events=*/true);
+	tchart->tool.comm		 = process_comm_event;
+	tchart->tool.fork		 = process_fork_event;
+	tchart->tool.exit		 = process_exit_event;
+	tchart->tool.sample		 = process_sample_event;
+
+	session = perf_session__new(&data, &tchart->tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
@@ -1924,13 +1930,6 @@ parse_time(const struct option *opt, const char *arg, int __maybe_unused unset)
 int cmd_timechart(int argc, const char **argv)
 {
 	struct timechart tchart = {
-		.tool = {
-			.comm		 = process_comm_event,
-			.fork		 = process_fork_event,
-			.exit		 = process_exit_event,
-			.sample		 = process_sample_event,
-			.ordered_events	 = true,
-		},
 		.proc_num = 15,
 		.min_time = NSEC_PER_MSEC,
 		.merge_dist = 1000,
-- 
2.45.2.1089.g2a221341d9-goog


