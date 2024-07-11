Return-Path: <linux-kernel+bounces-249650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D492EE36
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA1F281CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03D6170855;
	Thu, 11 Jul 2024 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vd2oRw2J"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C616F8E5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720838; cv=none; b=NkItfuApjXHwm75Q4EWWZrFHIXfMEWNX5QTpZI28PcsJjfolte7OrfF7l7P2AKqrRWjBbzvnyEPUtSJ0ukhkFAQb04nLyj9k7KnUSSoNlT+oqPvZaMDoxXZ2YwVlgYNxdzzmu2Clm+XmZ06cFWQIoO6JfB4ows6i5LozoKEbrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720838; c=relaxed/simple;
	bh=LWeT84SQaD/ZqxsdujULbunWNxfNaZERjhKf3ganreg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=azZ6/uPWJt1V3/LyFaUa7GZLjJH9AAC2sQs6zJi10MmnNkr06wA9WzAu/yZzAg6aGp8kxSPpTcJ6pPZ5cogtCvpeER3SsznlenLDxXiCSpJZtIoKwlhXCzjEkKUpC6bd1x2t7ggqmcuFgneQoKME8olhd86gbm35GASbCjS2jJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vd2oRw2J; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6525230ceeaso20906577b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720835; x=1721325635; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jf/366lvU4AUPtbGBpn9zhF7c/C+EcohgCe44YuCQ7Y=;
        b=vd2oRw2JzLJmuRlDZ82IACc+5+br3h1F6RVS8jTUeTpNzqNvo3bGRRMnsLdli4NyOS
         El4oSnXGv903vTqDlE2t+oTRF7htei4u3Ggd56xE/7rB5Xj7LFKyrAwnJyt2OgeODUT/
         pdg1fVE3zNxV/sSKDuJH8yX8yN3CY9SiR7DiRns8Mz3AlPknLBCWc4L0O3fUlNK2Clw4
         LmRa/gpKWXAbYmx/Qn5Qy3qs4T7C790/tc22//2BZHPa2qGDuWGxgODihyC1y/Ph+4Oc
         e+ZoAncAxreIql8dkH6Y77NW3rvxErflYdFhAUu201jbT2okBffKvbNLS6MWjpfgEAUS
         fIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720835; x=1721325635;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jf/366lvU4AUPtbGBpn9zhF7c/C+EcohgCe44YuCQ7Y=;
        b=QDbwRbhJP2Fh1aSvfrqn74MOOVXiUxqmDTT/pHaAowLqgtOffoE8rsCvF3seZo5x2d
         4b+ZX00I2dif+PiCbwwdfShtGxi8koACYlHEhT3JuqwLZk14Ew9fJDwHCVCWbXC6CkM0
         vS9mX7OFRWv0NEd/Zu7NxIKwEL3Y2Hka7wTaLZzFFMBjcOPOHKQEG1HwIn/dspFnHUWA
         CNuK6P1ChjbDcFpYmepdzc+mnwSzJRflKeslBn7MukjupYZZP3AFCgUuQfWk8apAZB66
         bCbeznbZlZ3YG4qFHWgCAGYbShC1V4YIpfYJDBpfXZ5YfFbtesH+sOkRc8RPabAQ/N45
         rClA==
X-Forwarded-Encrypted: i=1; AJvYcCUuRegHbqsubO9Ck3cw1z12w/Yrw6nfFNRRYgE8JrdxK6muQMhHYdr5irDsVDfFTjDTVeb21aNLq3VSbW1GKpI4zqB6uY/n3m1DW3c2
X-Gm-Message-State: AOJu0YxgFxUH1gAGsISzuE9UJ2zSfBEbps1xGcdnRX4C0wjut31TcqCz
	xpfT0awtnzrS3VaQzzFY7ibta0WqIlkrnLaJi7H69/5a5mwq7xYxjQCPE+QtqzWaVSI40igvgsu
	Vs3ZDog==
X-Google-Smtp-Source: AGHT+IHgRRHzENtJjdaIKJzPMb2H1HDZVK/Rf4u2rJiQyfph07pK93KyOLIPHnJjFuZcvCLU340y0vsp3u3Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:690c:3510:b0:64b:5dc3:e4fe with SMTP
 id 00721157ae682-658ee699c87mr1323597b3.1.1720720835320; Thu, 11 Jul 2024
 11:00:35 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:50 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 10/28] perf lock: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog


