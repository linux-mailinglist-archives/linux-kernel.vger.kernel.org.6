Return-Path: <linux-kernel+bounces-229403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9D916F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817F52827D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3A17E8E4;
	Tue, 25 Jun 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iotnGEH3"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136DE17E45E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336406; cv=none; b=CRxg7D77aPFEARplKpbB24XvqmKVwYN8lbWW3Q9eGHxi0Kw5LsIK7dfnokTAygZpKeAyS7TiHe4/8G0Rw5APQvVSXs2TFMpUwbaQmfnc8/G4hzt7pn7gUVTeBY8f4iL1dHSq7oBQSFeQIVwzCB0hp4sdfWtJE5GEDwv9oBVUvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336406; c=relaxed/simple;
	bh=RFO7PSbSKcfjn2e7ecGFImKzioMgq51018O+b5jRqoA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=R/P+QzQv4LMkM7trfLdooHAkImWkVlz6XqdJqOviU/WkUwU3cfOVIAg/B2eu7q6jl7zjBoJ7n/3t2qdHM67UJyn6K/DinJ5pRDk2I9dHJtXr4I7axtha5oH0Uttb7N6tBiaoSNxBX4gZDiFDDptUVgxVoojkwUHppv0FBLhge+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iotnGEH3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f43c95de4so132229197b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336404; x=1719941204; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMpGpliqYqiRoqn4cN7c6adPMyNbVkdw3pW74xYyguE=;
        b=iotnGEH3ppKuTJ8SGpiPDjiQ7TY1jTmCZM0wMIEazJgB5qulXOauIWyFdRgBaOyORl
         CIBPO6pcxeWF4suqdAqzdZ/czmZehW+YD+JoEgko8Ld0wZgogNP3lipPgLxdp0nAH9KP
         VxBM77qnSZldmEPLQb70v2F00g+NKjzTIHUgXyZk1q3Hj904H3cvk6/kHPn2x7Rd+idz
         Cp6d4GqNcIW7rFDbLj8MEAs1CzAmlyTOFeMdVBWjweD8KpavFlgxiwq9bgug8P3xG2qA
         mPK20zWOmrLgmazh3iLsc+NKYq+KNTZz4bamrHEH3TZvdeidqpuIiydXT8V32ViqZAAI
         PBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336404; x=1719941204;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMpGpliqYqiRoqn4cN7c6adPMyNbVkdw3pW74xYyguE=;
        b=o6saJc30k1whGspsilI6KWjQMJR1WnF4O9oHm9Nu8hsH57B+f/GhkzS3fjxS9eTiSI
         iczlkXKh5+8TPUKwCrNPgW4JVutPf5PeV89iPv8djCtOMbCgeFDO2U/BqrHGnkkovbWL
         +5NiCUHEA4LzBv7fYWPWLqMEMuQGR9BkZdfqBBNNamyz1B2YPkLVVHmFoU6V/695lXVA
         Z8zuiakNBT55nRyr0AKIHaA7/a54Nnybz2/2ctqOMJuvvVKqn+/F15BlQm5/hN3/Q/nO
         zXxzCXZS7G9bd5YOE0XBjuwtXq5nA4oicIc3j9TJvuHUZatvtTuuLDCj25WuXpf64EIM
         4vuw==
X-Forwarded-Encrypted: i=1; AJvYcCWEzzrA+zRxHahc+wLOg/L4t3WklkpOKOi5FH3umvzEjFvGtUhjDFecSrYR2DiQUyBzQhjt43b0+ukbB2VClLz8tGnOpMq26XOicXgL
X-Gm-Message-State: AOJu0Yxw45S9TQ2hEu+LrXiqwiPgheeBpq8UOoucGrcRTI93TpxuucDV
	mri8xta29ZUY/PXv9NWmo2yYIPKsUCAPf+pNjcMdrNL/KHbjklLIecmY3ACKv/URGFQLzyhCyoo
	XL4fpjw==
X-Google-Smtp-Source: AGHT+IH7+5ZWTBKKbbXiYf9Ov/UKvq0gkd8VKcekY3d+qTX2IBw8lJ9SfVOmE3ieuJ+wxA4bu4ed7gUqIOcD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:ec4:b0:61b:e689:7347 with SMTP id
 00721157ae682-64298a5efd3mr300097b3.2.1719336404050; Tue, 25 Jun 2024
 10:26:44 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:52 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 15/26] perf annotate: Use perf_tool__init
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
 tools/perf/builtin-annotate.c | 42 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index e2d784c5fdd6..0a96656fee46 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -686,28 +686,7 @@ static const char * const annotate_usage[] = {
 
 int cmd_annotate(int argc, const char **argv)
 {
-	struct perf_annotate annotate = {
-		.tool = {
-			.sample	= process_sample_event,
-			.mmap	= perf_event__process_mmap,
-			.mmap2	= perf_event__process_mmap2,
-			.comm	= perf_event__process_comm,
-			.exit	= perf_event__process_exit,
-			.fork	= perf_event__process_fork,
-			.namespaces = perf_event__process_namespaces,
-			.attr	= perf_event__process_attr,
-			.build_id = perf_event__process_build_id,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data   = perf_event__process_tracing_data,
-#endif
-			.id_index	= perf_event__process_id_index,
-			.auxtrace_info	= perf_event__process_auxtrace_info,
-			.auxtrace	= perf_event__process_auxtrace,
-			.feature	= process_feature_event,
-			.ordered_events = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct perf_annotate annotate = {};
 	struct perf_data data = {
 		.mode  = PERF_DATA_MODE_READ,
 	};
@@ -864,6 +843,25 @@ int cmd_annotate(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&annotate.tool, /*ordered_events=*/true);
+	annotate.tool.sample	= process_sample_event;
+	annotate.tool.mmap	= perf_event__process_mmap;
+	annotate.tool.mmap2	= perf_event__process_mmap2;
+	annotate.tool.comm	= perf_event__process_comm;
+	annotate.tool.exit	= perf_event__process_exit;
+	annotate.tool.fork	= perf_event__process_fork;
+	annotate.tool.namespaces = perf_event__process_namespaces;
+	annotate.tool.attr	= perf_event__process_attr;
+	annotate.tool.build_id = perf_event__process_build_id;
+#ifdef HAVE_LIBTRACEEVENT
+	annotate.tool.tracing_data   = perf_event__process_tracing_data;
+#endif
+	annotate.tool.id_index	= perf_event__process_id_index;
+	annotate.tool.auxtrace_info	= perf_event__process_auxtrace_info;
+	annotate.tool.auxtrace	= perf_event__process_auxtrace;
+	annotate.tool.feature	= process_feature_event;
+	annotate.tool.ordering_requires_timestamps = true;
+
 	annotate.session = perf_session__new(&data, &annotate.tool);
 	if (IS_ERR(annotate.session))
 		return PTR_ERR(annotate.session);
-- 
2.45.2.741.gdbec12cfda-goog


