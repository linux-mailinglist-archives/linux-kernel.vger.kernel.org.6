Return-Path: <linux-kernel+bounces-283747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11694F86A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1E21F212C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA500194A51;
	Mon, 12 Aug 2024 20:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AwPm+EHH"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0541991AD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495668; cv=none; b=ZYulvUZ5iC2fq/TeAQqhEKttFeHsnMs2LYhLtnidRvouWRUihQf/4925NWPj5mpi77thDDQKf5WORVijrZzt5TddG6zymM00k0R2Aa1ziFvrNYq8e8WgPUL9932UFdOWc6wI6rPGwjKXaBAedJ2sVs1sUWgLszMon9HpK5v6U0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495668; c=relaxed/simple;
	bh=Qrok1azG7UxnWaLySV6ZsE5DB8YS3BiC3PmFMnVvQAA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BRzzp7vif1WeSRzmyYijlszpZgFW9J7KIn7tPrPzZSYrfJjXyTaaYLbJZW8Tgz49T/tQMyZQ0835yYD5yg3oQE+1PKEz5Z7rLGqorSGTEP3+g2G28rWN2El4WLyBUorfNhi06gaaLzpaGomz209ki2VZGZvqfoI8SGErTOFFa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AwPm+EHH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-692aa9db2d5so96227827b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495665; x=1724100465; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gibdVPBI4QwODB2QVabO7wcogY6JGDVcaHEIkpe2Azo=;
        b=AwPm+EHHOIl64NO3n+8ug+lvDBjwVMerhy508QgjaFdHjzCHmzOUBnzqvKrq4nONuV
         MjLY4xAA1uRcitkBE37n+Zvi9M1xKyCOtjJlJaeHNtBSjL4tpcMCnqwpCEilzZwoL3SP
         ebt7aKgabkMDwttrTSvvhYKMrSRwafUdwL6SbWxJXknGy3OTvonSGRzWaW/USQ3R6EM/
         nuyvxS5hG6zUGcc/cSJEH6ZzaEYXv8+pwi0w0y+TWB5xf7zEN5ShUWptzvFOBrU9v8b1
         U2rkwk8c7DmHX7/6tFUyVutC2JeRHtFXG5eEC7vlMJJRmEZqLaPc+YIeZR57QYzUzHJ3
         S5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495665; x=1724100465;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gibdVPBI4QwODB2QVabO7wcogY6JGDVcaHEIkpe2Azo=;
        b=IZ0jYVHm61h8rYKqyBugCmsFJKtPb7kUv5E/GTWaVDlTuQJdUhMxhxkwXnkD/ON+sy
         QQIvUGMlLFYUtoTf2x+29jzHmVIMkcleNeeh3N90JscMQ3SmnXxG9Kn03ckN3gmNFyoD
         QOG4r9MCNA8+4/CxCAXNCrPeyISQYzXXzNux9ZNbhnFsRO5DZXIz1GNJSDyd1pmHFC+K
         VSn71NOy+smDMLX45dFjSiFWtNWjKcXyn7DsMN1+ppcS7WC1gidQplpMJLF4l9Rbgzkq
         b4L6fVfcrMq9x3GvwnEuVUEbHuY8vyOcljPTGsAoF5UDntBmsyJT1XwURz0wXbjVQciw
         6qow==
X-Forwarded-Encrypted: i=1; AJvYcCVKQdczj8mv76TVEaX119Zj39OFv7rFwJLAiByJZdwYbExD53Pw7hVzDeHmEpcYgr8UrZc/HINGlWoqrKhNfzUbEVGRrTNA3feDcX0x
X-Gm-Message-State: AOJu0Yw4/TdHehCRCTCY3AkMAhQ8oKm4zu5mCQXqkLwzDXVfYtRxnuUS
	Bkb5V7GRYVFfPP6RbVZQH/18KJhKTU5EQLEHlhajO9aEP/SrDviDidXSZLz0Afc8H/6HZeLVcco
	WfHyFYA==
X-Google-Smtp-Source: AGHT+IGcoDxlV6ReTDwa/pGeVDkEANIGIX3sSvxNGP6KX8/qg5oXdLKJGk56Ow4wd4MdzjIcDYZvPHQNsid+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:c303:0:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-6a96c6090efmr432737b3.0.1723495665556; Mon, 12 Aug 2024
 13:47:45 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:01 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 09/27] perf lock: Use perf_tool__init
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
2.46.0.76.ge559c4bf1a-goog


