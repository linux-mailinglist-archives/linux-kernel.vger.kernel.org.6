Return-Path: <linux-kernel+bounces-234804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B091CB13
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583F61F2332E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91CF54750;
	Sat, 29 Jun 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UowK8gqr"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B807A4AEF7
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636875; cv=none; b=rMWzGfa7XKVdYAlAHGDjk510Fk00SRl3dlW2fMyHrSPnG9/ICpulvDRu2VAkxpJqKm8P+Ha30PmEZ0RDrDCXXcAiSG7xKS4XIyu7jFDtht7aXE+hMAv1D7MsLM4CAXZWwd/JBlShDg0Z47h59dd3LL8tyZyMvrQGXv/gauMcEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636875; c=relaxed/simple;
	bh=X9Z2kNLXWNvCUsSUfNxJSkHFuSsUQbOh8Fkf4jkYl1g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fZGZcNzy7yt8cT4rMtYG4LTrPCEZPK2b/BafyDelmaWqdaj4VIyvo0/qCTpdp49AdDCu98Pnm7fka0CWd53fKPWT/NsogIcx2GpaCy7qXbWySJoWUr3apI+GCm8fTmHQyDjAn5P5CpPSi3gMaToOJYVl/+xk2zxnq8sGt+pjR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UowK8gqr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f46f56353so19834057b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636872; x=1720241672; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nt9mZXAuqIiRG3JkoyTKDkuyzTJ4dFDHgxDpLqHy/YM=;
        b=UowK8gqrWYc/ryYCzOydVe94TiQas/skFb/wF7uVUZszEqJ3aHIshTzSAybzEWg6Kh
         V2DqliobMzxpyMvb4/OrjNDSi/UKOo0C8JDrK5lg7vYUZzkiucvPJaMph5NFHyu9rVty
         yxiFDtTWUzN0VzQ5ILBhPtyHBtye3+Zpykl4SD9H/76rL2HNHNScQDw7pRoiDm9CRDG1
         oN3B/pyyHS95M9M1cjY0b4Oz9davnavm4v4ccxwldO0Xg+letnRWgQ5/LWJKZFpMRTFt
         8OUOIeN0GV15HS1i4CaYStxlYUMBjTtie7X0OhJCT022Rmr+9g4he6gzB0n+A05ZhO5Q
         N7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636872; x=1720241672;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt9mZXAuqIiRG3JkoyTKDkuyzTJ4dFDHgxDpLqHy/YM=;
        b=nUo02uGbaxkiA6ahuHeuFybMcjY63sfSw4CRNIMo0mZeQJ77OZM27qnOBF8CWm7s1s
         dsPSQD1ZdvkAgBM7ed/nwn6m6tjLpGYb+lyk8ab0e7Z5X7tzr6zssiI1B7eFrtiXZls/
         YDr6YIKUolR3DfXmTolHLNpcm6VZQbfocmEtHTZ8/03JXWHjwXHRSiWp8AEMlWEePcLo
         v4ve7zzDZg7oQBVlrffOc7R4UG8vdDO8m51Y5zBSGFQmVD35lUm4u1O0RvXhV1ddJH5s
         Jz2OzoijfqLUuHT262fWsXWpxizD+0V35Jjhq3KxoaYQjrjtmko0eBs4M57g9rS6bqxD
         iKsw==
X-Forwarded-Encrypted: i=1; AJvYcCVkBZLKcbLNazhu/cBO1vpYT05LbfaIv+fuL5cJ5cEVuX9rFNQpQqiw2uM+x1L0YD8vv9OZiDwijz31upQPEADckO7BS4Hut67D8yY6
X-Gm-Message-State: AOJu0YzeX3TauKkr30Qpgw268+JJhHT+Tr9Ot4P2bWWuTOUxer9cn0r4
	PIfWN0CUjjdmuEqVQDzvUr0uBfk/xVTfn1EoBnEMZpi2wuG2PB/xuNDf5EkEubpIXL4xKn4WJnl
	nNdzEvw==
X-Google-Smtp-Source: AGHT+IG/i/nGorsDZPqwpN3jkDdzpKa0IkTfmGtlPZ9QyQPVv+PDNAraaATyncwHa7O+QG6cNNBWowsK6XZn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a0d:ea83:0:b0:64b:7f7e:910f with SMTP id
 00721157ae682-64c77cb5cbbmr5307b3.7.1719636872623; Fri, 28 Jun 2024 21:54:32
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:33 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 11/28] perf evlist: Use perf_tool__init
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
 tools/perf/builtin-evlist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 7117656939e7..818ab21c3f73 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -35,13 +35,13 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = details->force,
 	};
-	struct perf_tool tool = {
-		/* only needed for pipe mode */
-		.attr = perf_event__process_attr,
-		.feature = process_header_feature,
-	};
+	struct perf_tool tool;
 	bool has_tracepoint = false;
 
+	perf_tool__init(&tool, /*ordered_events=*/false);
+	/* only needed for pipe mode */
+	tool.attr = perf_event__process_attr;
+	tool.feature = process_header_feature;
 	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.803.g4e1b14247a-goog


