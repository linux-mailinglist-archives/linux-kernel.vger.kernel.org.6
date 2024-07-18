Return-Path: <linux-kernel+bounces-255833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0530F93458F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805FF1F260B5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D8C762D0;
	Thu, 18 Jul 2024 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="owFrbotK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3F7580D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264479; cv=none; b=HP4+v6Jdg9jwrOb4vDf2GJSWPlwyzqiZlhdWuAAocnPnVP5JT9O8X/g3zj0r4wp9KFoswmjkpHWJCND+PjnMHsbac/+NNDjXbdwbQHjNewuLNruBQpdjUy4pfnL+OsyHU1Q9M6QRy0nrG2qIbIboZ/SFdhdb+uf0c2iDfheSmI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264479; c=relaxed/simple;
	bh=36EenPax6vCtCaEhr/ZKn10gCViJORPj3sVD/7Dl8M4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mpbB2iAfzJ3WYCqTynWHFtsL2I7tjqQy+Vv6tjt/gFG9f4sVuCnPSPmjpl5yC1ix78E5pTxfgtabVka/pzCSAs99lwEui5lmw+IYQFGc+CT4e/u3gWvX/KVQVTQsoc6hUtrradfKF+CUAyANkwIab72JQElkIhX5/H4jFRzW9tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=owFrbotK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66480c1a6b5so7343487b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264476; x=1721869276; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4D79+IUkfPytCkqQCFYniN8I4X54SHHR0HOTbDEr6c=;
        b=owFrbotKuYZVS5q/z8RG5Cl79oaZKJl8N8uPnnk8UewP6fm0bVGerf/+/VS/otKrKS
         X0UqmX2GRi8FfRU8REMplH3AOcGUmx8Gt97PCEHAUS1Qeh4tED/aXV8XJn2o/XQKvxLn
         +8kAVkwqdt2LkjhuP12XQ88IvaQjSRDJrOXGvbOCanajQAtBp2Dr5bMcUdikQ1/iGyHc
         kQHhCLd5HGbsvAyOTe2HbW6eauAQb6COJ8Jo+n8qvqB+arJHVH8p4/3oLX+v5okJoYBp
         dCdEnUwFkareV6LEYEPWZUEZ5AYN/JGO20aHd1+YthVsW4ai355S4txqsW4EKYuEpqpJ
         7/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264476; x=1721869276;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4D79+IUkfPytCkqQCFYniN8I4X54SHHR0HOTbDEr6c=;
        b=V/ZHaJUj1c6882zzuDGyuDpEyr9fUrQ/IFzlrMKBqM7ef1kh1UjHD8N3QvATXKulKu
         OL5yX7mSjFS3T/ji+BRlnZ5Rdm+uARxUtRzjdg3Du2EnC2BeWnkHHnCodmlUAW2ihNHZ
         Tx3D6rGs+S3lbBF0QwCKGG+woHuxsj9/jPtmQOowLOsnbNF2eHfEfXc65rmQlkFaPa8a
         Pu3SsfXlwpoODjA6tPCv1WNzVFx7DnXnKyp+4d+5bQkuVNDzk+UaP+suM8B9yiTu9lj1
         6d+p6pmDQ/Uwgn+Z5PTFWQgmz3dTwDmCbP47kT1bJ4CZv9CpmaLMG7siskFJPZo2S5oB
         1NJA==
X-Forwarded-Encrypted: i=1; AJvYcCW+5TGcrIeGXAWsiQxJVtN2cxu3Yi8d9xhJSwOiJOt/9nkOwNhhb7XkAkJAOraO3wq5mQ6CsldD+z4dNoXLxIWQ4BLYUvBncc903gbw
X-Gm-Message-State: AOJu0YwnwpWAIMatlilok7XsZHwQZuU2J2PlJmjYQcjZYzeeS8QfDtPJ
	1dfzgatrXomis3RolMl/8po3X38P83saA0CRWjg3gilVaxT6fcmpHKfvRjNQhBxKDu8yxeuypqv
	Z2SzCCQ==
X-Google-Smtp-Source: AGHT+IFdcXueyp+PMAvktitAsznwCgBObp3v+ssLmbsVDVTn4IUrAVOTsIsjGyiwtSBsWfywOqLvQluTAWWt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b8e:b0:e03:62f0:a297 with SMTP
 id 3f1490d57ef6-e05fea28f01mr2107276.2.1721264476138; Wed, 17 Jul 2024
 18:01:16 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:13 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 17/27] perf annotate: Use perf_tool__init
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
 tools/perf/builtin-annotate.c | 42 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index c0685d2c8de1..598ab854b9f3 100644
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
2.45.2.1089.g2a221341d9-goog


