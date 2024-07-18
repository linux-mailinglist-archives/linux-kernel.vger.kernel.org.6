Return-Path: <linux-kernel+bounces-255839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD803934595
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A941C21404
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16867FBB7;
	Thu, 18 Jul 2024 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZDBiD/jT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB073466
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264490; cv=none; b=OuEh2JHiZiR2Cg5Ob7K8hGOyb0grqmzRkK7Lrt+RKz72qWhZBZQn8ncL4cKTr2kxQphOGZXZKt0i4AADZ4eqoT/0yYb+T74ZfjZxCDBhHIMmptDBO07qhZZEubsGQx+VwAZ6bu+yqblSDEs8yb4tWo6CjyXJAi7S7c8y3oQ2NCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264490; c=relaxed/simple;
	bh=kfJ6tvBAsXsU6JLfCYIrLBwtKah2svTIRlLfKRZG1DY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uBzYPt0AQdS2c6nVXtxXgljFZbdxmnOB8MJ6ADPwW8H3ck+hKD+9teZFijfndFmnu5C0xSRDFCOQtJAQzAuPWF3sQr6po44pjE/Rmj8lQGTLukSpGnRax29Mb4+KvDohesiZRc2XfsW/fdYPbGJqEawrLPTfdCdGzkI4ZmGzq1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZDBiD/jT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-666010fb35cso5203217b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264488; x=1721869288; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZ3Drtsbb7xK9GFR3k7+K4AhjLYb+mQoMq9GLVm8nd8=;
        b=ZDBiD/jTG8uTOomUobjsCAcsTfZJKCSZgkhhtI4hqF1/OvSGE1Yrr1hcwHfQvSPXF2
         pUV1p4fE6YphoEiv7qkkXZrLHje/rG4XUjrGOSEMzZcdapD2Odmbz5qE77sj6rrVguPA
         4aU3UuJRLhlMfc9PNDj8lPqthaPfVQU0odfpZ40encLBYfvz+u4O0ufRmiraFPj3vDu/
         sTFqJ/zva95UJYbUT12x0Yr4QJtPm4vT88jQOa+PFSVW45gujh7G/0SnmimPEg0NN51k
         +Pkz5Z8iU19htzWNuZUibFh3/88QJ9j/JXH6G08rsrp2kvX6feK0SVppO+lHFYHVlm1y
         5w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264488; x=1721869288;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ3Drtsbb7xK9GFR3k7+K4AhjLYb+mQoMq9GLVm8nd8=;
        b=Fmj54ffJwl690Kj5CMZSqzC8e1oe153HcwMORdtI4vg2NfE52LjhJQoe7YQ+m2KOpF
         RfgHmzll7xZG8b/yEKiLjUnK755J5tfQZ3m9qisTdaR5nsnjDH9ChqbhJuJTKp5p+tir
         DvYisfXuO1kT/RrbcahuAPG95srGAZ5lpoXIxtQXagFjm2iLY/uULB5BVI3HthzuCiSH
         1iBVcqJNKnrXfjpajEQMoJOj79BrFWcau3tFbxj2bECQO2ZaVwpNs8YOHmMyPp6FfHsj
         kv26N1kHne7PFd7bBwOz8UsumswLAF3MQmBvuiSPR14r1emrOuFFUOitRSGyKz/irf7j
         LatQ==
X-Forwarded-Encrypted: i=1; AJvYcCXThuWU0sA5lpuOzAUYorZpRS9ihq79B6BKkiIAsypr2AMQCw5hLQMQyVa+fs4Lxrfec66t4+AaxqozEygiTcOKsaxhkX7ZnJvMAtp9
X-Gm-Message-State: AOJu0Yy0/5oHTF4wHY2s5uXdd3H/VheOPfkbjr8lPged47CU7xKSI08J
	zmcpnSmtuKJKuhsP9IxTuY0lmnzf18jsRLtxCE5soXul3EAwgi4o/pcWDD0UueOS99rZvWTr9Xl
	Ms0l9TQ==
X-Google-Smtp-Source: AGHT+IEMIegm6jNE4CQClsw7GOzZrobtpwCpbE8HwTGUbjxQR6jEtSbn4ARwhdR3fei25wrA9LB/QeoUjXvX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:385:b0:620:32ea:e1d4 with SMTP id
 00721157ae682-6660af16a6fmr758457b3.0.1721264487742; Wed, 17 Jul 2024
 18:01:27 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:18 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 22/27] perf data convert json: Use perf_tool__init
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
 tools/perf/util/data-convert-json.c | 43 ++++++++++++++---------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 905ea9823f9d..20bfb0884e9e 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -316,39 +316,36 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	struct perf_session *session;
 	int fd;
 	int ret = -1;
-
 	struct convert_json c = {
-		.tool = {
-			.sample         = process_sample_event,
-			.mmap           = perf_event__process_mmap,
-			.mmap2          = perf_event__process_mmap2,
-			.comm           = perf_event__process_comm,
-			.namespaces     = perf_event__process_namespaces,
-			.cgroup         = perf_event__process_cgroup,
-			.exit           = perf_event__process_exit,
-			.fork           = perf_event__process_fork,
-			.lost           = perf_event__process_lost,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data   = perf_event__process_tracing_data,
-#endif
-			.build_id       = perf_event__process_build_id,
-			.id_index       = perf_event__process_id_index,
-			.auxtrace_info  = perf_event__process_auxtrace_info,
-			.auxtrace       = perf_event__process_auxtrace,
-			.event_update   = perf_event__process_event_update,
-			.ordered_events = true,
-			.ordering_requires_timestamps = true,
-		},
 		.first = true,
 		.events_count = 0,
 	};
-
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = input_name,
 		.force = opts->force,
 	};
 
+	perf_tool__init(&c.tool, /*ordered_events=*/true);
+	c.tool.sample         = process_sample_event;
+	c.tool.mmap           = perf_event__process_mmap;
+	c.tool.mmap2          = perf_event__process_mmap2;
+	c.tool.comm           = perf_event__process_comm;
+	c.tool.namespaces     = perf_event__process_namespaces;
+	c.tool.cgroup         = perf_event__process_cgroup;
+	c.tool.exit           = perf_event__process_exit;
+	c.tool.fork           = perf_event__process_fork;
+	c.tool.lost           = perf_event__process_lost;
+#ifdef HAVE_LIBTRACEEVENT
+	c.tool.tracing_data   = perf_event__process_tracing_data;
+#endif
+	c.tool.build_id       = perf_event__process_build_id;
+	c.tool.id_index       = perf_event__process_id_index;
+	c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c.tool.auxtrace       = perf_event__process_auxtrace;
+	c.tool.event_update   = perf_event__process_event_update;
+	c.tool.ordering_requires_timestamps = true;
+
 	if (opts->all) {
 		pr_err("--all is currently unsupported for JSON output.\n");
 		goto err;
-- 
2.45.2.1089.g2a221341d9-goog


