Return-Path: <linux-kernel+bounces-229395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 166CE916F31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC471C22BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF7017CA04;
	Tue, 25 Jun 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYKvrcbk"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446D17C7DB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336387; cv=none; b=m8xUbAAKyOmETT9dw1RD2JX6i7oP/z8qGjBx+y9gqVv2yOsLuX4Q8IZvf4ZCcSk1kFQhIGJYZ/TfoT7du68VOJb9TnR+3FMGdRz7iKMtnDbfmcE95ISNlQWRd37BYD4TcrRKEINWeSOemkU2Dd8ZSxlnYD+0aG8dEcmHdLL5UvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336387; c=relaxed/simple;
	bh=RFTmrZzGTM9IWPWjHq70q/GKoQrds29ugAT8XNOZor0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ex8DpQJb1f+kOT389CUkVhJ2XvlKXfZEf0TXgLEpzhgWVpe9CzKrfzhRGJYs59EyRabHp4kmU5dJgSwtDenIRAXqCLbIHk0DadR6zjbymWFJSKBLZeHGgGs32ctMAieLuZq2HfRrDJ6+tgiMA+Bl+3MiSAECfxbs0ycZZeaDO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYKvrcbk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f9a6356a02so65324415ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336385; x=1719941185; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+G0HGMTQoy+2+TKDBA5eg+niEy3wMk5iRiA3dPthGE=;
        b=DYKvrcbkLVfT7YE6/SuQFjy9C5tgkoMk6XnsXvfZUXbYH8TKYnKq1bYTX1ABxn+gaf
         r6pVjPwgipxMPL+fGypU4AZi4LwFEERuSR5BMmUpTsqJbtCYKAR+Szcev9tvdlw5uG5u
         VMGZxiBTenfYUTcVY1jaPG7u2RhiJe9hHVgqdFk8kmEuPqWxl3ExFQMqxNzPCtRZIPiD
         zt6EOqgDQ78oeTph8Ytshn2rtyrhYL+FBUdGq1jMsZpLxRBa4fTXtcD92IEDYC5OA/W3
         yke3/bAl8SFy8adaLgTQmnJ00wKsHkPL9Sr0v8mOcXi3Lw6FoHfNMCUMwsDZ2kdpQnLx
         F2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336385; x=1719941185;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+G0HGMTQoy+2+TKDBA5eg+niEy3wMk5iRiA3dPthGE=;
        b=GRO2c/BV19PRjJHB+hUnwIzKko0TwBHFnJqAiDDjzkmhbkdnXb+ewKipSb68eGGLrC
         KdkvWGTNbwxfQ5/9N5z31G8C7mNufeiruL0DA6sYbRwEm/ohZS2M2u/x4n4bVT5jsMOK
         l9WTs4ZpTse8Xh59RN/Qq73p2xMMXGBATyHJNz+NdiXZrachO/FUNDEA8EnvrsQDjMcA
         YQ0iDI00HJyUK1Nb3svt2pMaccBn0BWxSTYfQ/yo81i0S7MDOqqe1Df8XAfvMW+zecD2
         5gUCN5upMD7CMVqtsRq6vVuwljcZF1pdFOCaIDmoLOLflHFecSHQ2gpPRykDquMQ0pU1
         MpAA==
X-Forwarded-Encrypted: i=1; AJvYcCX5Muax5PfGZkRMFjbOX59cPDt1OQuzwHShdNzcpE/PyjpXTlNQ1sLDhO9JVOkMe2Pt/65DaV2B9QPKgCbgZmt8cYnA2YOD/2Hllv1o
X-Gm-Message-State: AOJu0YxPi0Hd3UXvNPddo06I7OlR1punqiOpyOMu3ZecOdRZcws7fVtg
	Th7ewzwLE4ytvJGbwHz0cs7AhxPbgeULafFJ5uauYwG+NjjVJ4troVQ3hzOYIZB81hahMOnMxYu
	4uo6IAQ==
X-Google-Smtp-Source: AGHT+IHOTIs1TEWUF2nY5PaBtklSJ7BTMufz9SMTvG0c7ZGwua7i2kerndcI2mz9IJ9qz0PZ44pVysp4aUve
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a17:902:ea11:b0:1f7:2f46:8bfa with SMTP id
 d9443c01a7336-1fa23f00860mr2545505ad.9.1719336384865; Tue, 25 Jun 2024
 10:26:24 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:44 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 07/26] perf lock: Use perf_tool__init
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
 tools/perf/builtin-lock.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 6efa9d646637..2c216427e929 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1933,22 +1933,21 @@ static bool force;
 static int __cmd_report(bool display_info)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.namespaces	 = perf_event__process_namespaces,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.namespaces		 = perf_event__process_namespaces;
+	eops.tracing_data	 = perf_event__process_tracing_data;
 	session = perf_session__new(&data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
@@ -2069,15 +2068,7 @@ static int check_lock_contention_options(const struct option *options,
 static int __cmd_contention(int argc, const char **argv)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -2100,6 +2091,14 @@ static int __cmd_contention(int argc, const char **argv)
 
 	con.result = &lockhash_table[0];
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.tracing_data	 = perf_event__process_tracing_data;
+
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-- 
2.45.2.741.gdbec12cfda-goog


