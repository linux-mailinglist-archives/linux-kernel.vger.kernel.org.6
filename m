Return-Path: <linux-kernel+bounces-255835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB86934591
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E2F1C21871
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B37F79949;
	Thu, 18 Jul 2024 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/XKBBRl"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E99F770EF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264484; cv=none; b=GZgqGfACCrsuYqjO48OLcHVTJ61LV+RNv5l1EhtVHZz8e3VRQOSCiEoRPP8PgunTu/WnSdfaSFEvP38QU1hhIH1omJFRZGmtLGZxfoOj1sTTInZSKYYfZzN6mf5zOp32bHOsT0S7PY+1uCRlSQZfzgyLWpLLBjdfjX0GcXo9pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264484; c=relaxed/simple;
	bh=saQni68YvlpfViCBo0RhoTj4uuiKa0zwMYVCAC4XijY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QYL1AFI7hYhsrfDocHJDdnrw+tKZLyWYb/FOgOUJ4O+QPSMWI9VYZvSKE0I8Y24QzHawqOaTCnQHs/ulXpj1OvU/jFGIqDM0r3PiMs8ZZ/zMonanPO8ENnxXEHDyAI8pfzgMLZvlAXTl5P3PAUOS4rMe1NrCycc5bPAedcxw+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/XKBBRl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66480c1a6b5so7346967b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264481; x=1721869281; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m98Flvn2VBr3LNYvnCJEqVyEBIqxTtcaN90lyN420CY=;
        b=x/XKBBRlOJNjMa4IhpORe3yWMmfUCeA/AVMwVIJBzv1H8lcCoYfZtjaa7+Asa6F/9R
         Pfv6fa4ZuibamAHiDiWvS/xBfxn82nl7WI+Yjan4awUiLeH0K7CVXG6ZFJ0wiyD3tX+A
         Qhf1mE/zXMApXHZVD7gTH2BXF1Kr9MC49JpCAVm1duTGclAQTwneeBOl/GVGQIG9ITW6
         07dI9xjUWqDhtOGMvXLfXo4gLCH/gKgmpnNahRv57kgqLx3blaweCr3GN+0NLxtiJ9ZW
         8oGPSukXLAVaPgzbTy0YUPudnoaVXz14/tWvPGwx7FTrth60fsVinkb1ooTZTgUOklTj
         1UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264481; x=1721869281;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m98Flvn2VBr3LNYvnCJEqVyEBIqxTtcaN90lyN420CY=;
        b=So0m5IiwL6FD3fpf7BWLYUBTdzaN+sSfYkKKgypPp2SJjgrxRT33sAg2G18jYvMfOV
         Ge5Lb8VKXvqBCyrpuRJ1iiAngsnycNA1/0dEOdylEyMqiUvkezeRFG5p73YBIEZf5/cG
         3txxSodzZoBMPvCAum817KRb10Z7B3BvxhjUe1OayibuhlWcYsV975vA9mMgQ9Sak7MQ
         vi4w+7jlkx1cP0JcuJ/XWlw0p/1XdBOb56mv9QlQcpSGF/O4Ql4vtx8DoQ6rd4wh+Q0g
         /1dMHK3yowJXleneHMctPEkeBz+buO9ATZTBXTuPaVkrVMl2roo7zU9EqTKpdlhY4t9v
         XVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUSNkQ6086kDPVlQn56lCCEpUaaAJKpxV5C20igTIzcZ4XV4+zdtbeuQqtdGyskRYyZM/SKDJddhUjaTLYERFnDfAx2FjBnKN3MWQju
X-Gm-Message-State: AOJu0YyAVYxc5nQfYYajNlwIqL3yH69EErkzBPhHLmSa1y+UMm8mwbTr
	eht/DOEW7kwqcSuE+x1qoagm7Z5aD818dmQdLRRPxhT0Qm2fGx6mXoF5LQ/4uC/jb062PGGz/Mb
	1VoJEoA==
X-Google-Smtp-Source: AGHT+IEWEjgKHZq/295YiLw+T2zNbbynCG/+Of132DZ6uzEmgnVr1Fi3xV7AcLhcv2Pa2K2jMXGhS06h3I/A
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:fce:b0:666:e184:4dfe with SMTP id
 00721157ae682-666e1845003mr139337b3.6.1721264481114; Wed, 17 Jul 2024
 18:01:21 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:15 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 19/27] perf mem: Use perf_tool__init
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
 tools/perf/builtin-mem.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index c2038a32543c..c12ca0ec1237 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -285,7 +285,23 @@ static int report_raw_events(struct perf_mem *mem)
 		.force = mem->force,
 	};
 	int ret;
-	struct perf_session *session = perf_session__new(&data, &mem->tool);
+	struct perf_session *session;
+
+	perf_tool__init(&mem->tool, /*ordered_events=*/true);
+	mem->tool.sample		= process_sample_event;
+	mem->tool.mmap		= perf_event__process_mmap;
+	mem->tool.mmap2		= perf_event__process_mmap2;
+	mem->tool.comm		= perf_event__process_comm;
+	mem->tool.lost		= perf_event__process_lost;
+	mem->tool.fork		= perf_event__process_fork;
+	mem->tool.attr		= perf_event__process_attr;
+	mem->tool.build_id	= perf_event__process_build_id;
+	mem->tool.namespaces	= perf_event__process_namespaces;
+	mem->tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	mem->tool.auxtrace       = perf_event__process_auxtrace;
+	mem->tool.auxtrace_error = perf_event__process_auxtrace_error;
+
+	session = perf_session__new(&data, &mem->tool);
 
 	if (IS_ERR(session))
 		return PTR_ERR(session);
@@ -449,21 +465,6 @@ int cmd_mem(int argc, const char **argv)
 {
 	struct stat st;
 	struct perf_mem mem = {
-		.tool = {
-			.sample		= process_sample_event,
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.comm		= perf_event__process_comm,
-			.lost		= perf_event__process_lost,
-			.fork		= perf_event__process_fork,
-			.attr		= perf_event__process_attr,
-			.build_id	= perf_event__process_build_id,
-			.namespaces	= perf_event__process_namespaces,
-			.auxtrace_info  = perf_event__process_auxtrace_info,
-			.auxtrace       = perf_event__process_auxtrace,
-			.auxtrace_error = perf_event__process_auxtrace_error,
-			.ordered_events	= true,
-		},
 		.input_name		 = "perf.data",
 		/*
 		 * default to both load an store sampling
-- 
2.45.2.1089.g2a221341d9-goog


