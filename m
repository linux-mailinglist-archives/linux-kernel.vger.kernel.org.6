Return-Path: <linux-kernel+bounces-231490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74E91993A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBCFB23C09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43821953AD;
	Wed, 26 Jun 2024 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxJCnQ/Z"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C9194083
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434232; cv=none; b=GoicuPIlcL2XKe0NOlPQXzyVkB5Bg81/lF9L0E/nZRx3sK6Hkii7wxySmyaE5wvrlx6lzNzin6SokV3m6f0j5h40Ern3UIvo/AbNteBzPhvnvvSkFvxbpBCcOD/E77QNOdRxQ604XFriWEyB0ySgEomhSa3Ghakbn2hQwmwxtvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434232; c=relaxed/simple;
	bh=WRHMheJp7s0UW+rmOQwKCmWPOpwEdqZ0h0girqg29wc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dobOhsJPP17SYPTw9Rdh5PYeRTNWHKHcSx+WVzleTlf0iMW3v9ssHAedhwHFASJFe2T4hawjbn7I49aXZkXFxsTHUxwlwSrLjGIsOa6yzAOHJk3/VTtZ3LKBAiIFh26WTTDzqSzLCm19AJoP0fE002G0zXKpc+qL0gDzN3rGqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxJCnQ/Z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f46f56353so123318327b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434229; x=1720039029; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrweehdAa2tkZxz5Zxp9wFN4gNwYxCO/FheTIJk34FQ=;
        b=VxJCnQ/ZnkxvM3BTZKrUvE29My1KiTQ81qn5b8rKsmM2nfmrlXdIRVh0T6RuseK9SJ
         XG84I1xefDMLVeK/nisRJNvyqRgtrkrRuQ8cwIz7fdPRLzT28qOxNXr3AyFf8zsqtqhT
         VfQzo7txoRLaATCFmbs8yuXrOFQ41vBrWROklToKuvjgVGsAVkbSucvBG0JJFVb3gZqu
         f+eF2g4J90HiZgvt+VuRhGb4EN/ONsjEvWdJXS8KkrTHDgyES454XuML1HFXXcQ3xgbo
         JLtt12odBfQvPhm61zCHwYGBa22w6wwY1510o9/6JkUIpKNv9y5sDfqR2EIp8btYD2xZ
         wRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434229; x=1720039029;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrweehdAa2tkZxz5Zxp9wFN4gNwYxCO/FheTIJk34FQ=;
        b=rCwfr0mpfm0H71wbBqBIkQuK26lbMW8x52B7UKQRrspuC+2Gee+LZw4HIeANObgn0h
         vHl560QId9p875liDA8ZAAqEMvg0WuPfzYCvrdIu/RstOLp5tLPJPnajMAbrw2RswF2P
         iTnAseMzWTEn3i5rb2xe6DBE5oBkuY+taLQ7kLZbETwpMQSM6s/LqwQGTSt+p2/8AY3V
         5dFIvRhavA1vlBQXbrqBHxT/JoLY6ILWBPMOtG/FBvLBlc40vQw0FLECBzxCwTlla8/f
         FBfrhlN2RRFmihVOunNsisSSPwVqpe/XI1LZA2R1A3o6FLX4EY5nUuWhvnootJO8HO2T
         q1Og==
X-Forwarded-Encrypted: i=1; AJvYcCXcy7btNCsska+Wt72UBSCqU7WTqX49Z/oLpvCmonv0Zz1uulBBKk66Nv3knXOhEbecyVkIGmUJ6tvddpF7+Vm7GRQtcZSrLJUtyOSg
X-Gm-Message-State: AOJu0Ywog890wIsi9BLDB5QxH7bxnXGd2kO/pMmpXludEI+vNz0KLJOq
	C2d+jqTwZDhaLGbP+/FyDnsmHfaxWFrYBT2r9oNI4cRKxf/iabDWFolatwvIqYu6o+NLcc8QWNJ
	ax4qdEQ==
X-Google-Smtp-Source: AGHT+IH1b3uFlZAh7FTc/51pAkYfxg51uKntN5OfGNVc33hFT9YDlTkQu0cV0WTSjlTWeCeXHSLPMoyx/Wog
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:6ac2:b0:627:a961:caee with SMTP
 id 00721157ae682-6433f0e2122mr405277b3.4.1719434228939; Wed, 26 Jun 2024
 13:37:08 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:15 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 13/27] perf script: Use perf_tool__init
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
 tools/perf/builtin-script.c | 65 +++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 394bce9f5338..b4fc2971335b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3899,38 +3899,7 @@ int cmd_script(int argc, const char **argv)
 	const char *dlfilter_file = NULL;
 	const char **__argv;
 	int i, j, err = 0;
-	struct perf_script script = {
-		.tool = {
-			.sample		 = process_sample_event,
-			.mmap		 = perf_event__process_mmap,
-			.mmap2		 = perf_event__process_mmap2,
-			.comm		 = perf_event__process_comm,
-			.namespaces	 = perf_event__process_namespaces,
-			.cgroup		 = perf_event__process_cgroup,
-			.exit		 = perf_event__process_exit,
-			.fork		 = perf_event__process_fork,
-			.attr		 = process_attr,
-			.event_update   = perf_event__process_event_update,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data	 = perf_event__process_tracing_data,
-#endif
-			.feature	 = process_feature_event,
-			.build_id	 = perf_event__process_build_id,
-			.id_index	 = perf_event__process_id_index,
-			.auxtrace_info	 = perf_script__process_auxtrace_info,
-			.auxtrace	 = perf_event__process_auxtrace,
-			.auxtrace_error	 = perf_event__process_auxtrace_error,
-			.stat		 = perf_event__process_stat_event,
-			.stat_round	 = process_stat_round_event,
-			.stat_config	 = process_stat_config_event,
-			.thread_map	 = process_thread_map_event,
-			.cpu_map	 = process_cpu_map_event,
-			.throttle	 = process_throttle_event,
-			.unthrottle	 = process_throttle_event,
-			.ordered_events	 = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct perf_script script = {};
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 	};
@@ -4102,10 +4071,8 @@ int cmd_script(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
-	if (unsorted_dump) {
+	if (unsorted_dump)
 		dump_trace = true;
-		script.tool.ordered_events = false;
-	}
 
 	if (symbol__validate_sym_arguments())
 		return -1;
@@ -4296,6 +4263,34 @@ int cmd_script(int argc, const char **argv)
 		use_browser = 0;
 	}
 
+	perf_tool__init(&script.tool, !unsorted_dump);
+	script.tool.sample		 = process_sample_event;
+	script.tool.mmap		 = perf_event__process_mmap;
+	script.tool.mmap2		 = perf_event__process_mmap2;
+	script.tool.comm		 = perf_event__process_comm;
+	script.tool.namespaces		 = perf_event__process_namespaces;
+	script.tool.cgroup		 = perf_event__process_cgroup;
+	script.tool.exit		 = perf_event__process_exit;
+	script.tool.fork		 = perf_event__process_fork;
+	script.tool.attr		 = process_attr;
+	script.tool.event_update	 = perf_event__process_event_update;
+#ifdef HAVE_LIBTRACEEVENT
+	script.tool.tracing_data	 = perf_event__process_tracing_data;
+#endif
+	script.tool.feature		 = process_feature_event;
+	script.tool.build_id		 = perf_event__process_build_id;
+	script.tool.id_index		 = perf_event__process_id_index;
+	script.tool.auxtrace_info	 = perf_script__process_auxtrace_info;
+	script.tool.auxtrace		 = perf_event__process_auxtrace;
+	script.tool.auxtrace_error	 = perf_event__process_auxtrace_error;
+	script.tool.stat		 = perf_event__process_stat_event;
+	script.tool.stat_round		 = process_stat_round_event;
+	script.tool.stat_config		 = process_stat_config_event;
+	script.tool.thread_map		 = process_thread_map_event;
+	script.tool.cpu_map		 = process_cpu_map_event;
+	script.tool.throttle		 = process_throttle_event;
+	script.tool.unthrottle		 = process_throttle_event;
+	script.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &script.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog


