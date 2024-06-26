Return-Path: <linux-kernel+bounces-231496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1553919945
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499461F22954
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48127196D8F;
	Wed, 26 Jun 2024 20:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCACnffO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C7196C68
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434245; cv=none; b=SkUOd7kDQdKESHgZFfMkjf6Yu/nNYum9lr7OY2Mj2qCSmThhz66McHPNn5YKyD8GyoNL3SrNTpX3TqUw5pa8xdfYEhiMt0Y+oyQMaRIEhhfPimCUNib7IENLhj1AhZ2maBqY1WgrwPSgYuIDtSivnmhXyPYtlkWfLmtWuUNL3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434245; c=relaxed/simple;
	bh=NNpDhvLM21Dx7gpxRlWCOf8pWQqxyB122lzmpjrWI8Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ilsPDKCC+vryVgzaHbRXGBhzjkMIflz7spFjOHG15k/byzIrGT268+j1RKc9yJyFG4ko4ClRwuC7xupd12ZjrbOinM6cuqR1z2/ROma4I4S/j5E255a64p9HpL1VPEAEGyVt994t271D20DWNJPE8OCfthzntnykix/kvxquDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCACnffO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63bb7fb3229so153581737b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434243; x=1720039043; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FKqc617GU6y9EZBzym/gHkh1HBEMH2nzxihyAHq3eE=;
        b=NCACnffOyIe9SiAUIgK4LEqNZlZ+RpHGbzPtywgL0L/ttgTQ+6BQnrBY1nxsRX9VUv
         0DeWTJZ3ig9ffNfuDAYaSFQCi0ccFiBkzrO8Dz72cn4mQ21uc0Z7qXCI4zJMyYhqIvcv
         InVb+f9RDAIUz5/YSgjPsxqYOgw+Agjyg64OQaYN4hWFIXbxX7kpmvZFTXMHrjQfk89u
         sJLCCA/DXcOWFYZWTSjF9SHeOUkElu9u9TEYhOa3MNfpcP9T847eEM4D5anWMM7jOe/k
         sNR5T9JuZrzClU6DtZoZVgb/r247253dbPg1+uFD3oQITjUYlvFJyUiR7yEevvxehrkz
         IYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434243; x=1720039043;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FKqc617GU6y9EZBzym/gHkh1HBEMH2nzxihyAHq3eE=;
        b=vUe/QoGNx3i75ApMnwBf7vM8pfB3Zy8K2bjZlt+qIsye6nQotVws2Y1wq9i2ljrkfI
         N9S5HIyb5+3TWSduRh5rc9bYCey5gBkner+nFi5GR31dlx6+wIZCaWOQvnAIzeNnjNSh
         Cq6RF/6cBMmEyr6dmdliuL/S986gWb2/0Sd6iv5qE4Xrpusj+Yuq0e6s5QqXysVo+uf2
         yO162jPucYagjdEFiGGZPKMIZrymfgqewihORmSwMfp+j0sIURl4qWqsKX7D5vvAugqg
         sP92Bi2HC0vHQS3GKULzL7re5YZpNhkyzzPd4cwUe1k05Vn3oOPv9rkwBffN3Q8BYpCH
         4qUw==
X-Forwarded-Encrypted: i=1; AJvYcCVsAB2IqgZxPps2L8hznBL73DCEkAhuX3YILBkTlGpgWsF76TBoUJCuB2zwF9w+rdaMBB7jMY8dSKTxpilGRNbSZoamZ9CzcWRUxLGw
X-Gm-Message-State: AOJu0YzMYCaESBSmn4Rs7dYC90TatT/UY8QMnDYfoWmCKmONCXwLsroB
	4uy1z41aWlgLUIIXRW9Zoux+vpX4+t2rLkWg0CHoAYHbalzZakx9qGy+5Z61HooH8LgMG7ZO85o
	PgQmMVA==
X-Google-Smtp-Source: AGHT+IGZ2cbOs+APOfGf2ySj3i2AIMZztj3b6qdJV0HjjCy2lYFBRVoy2+uVDxJhN+goCOCz1d2W7vXHAT/x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:704:b0:dfb:22ca:1efd with SMTP id
 3f1490d57ef6-e0303fce998mr564006276.9.1719434243104; Wed, 26 Jun 2024
 13:37:23 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:21 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 19/27] perf mem: Use perf_tool__init
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
2.45.2.741.gdbec12cfda-goog


