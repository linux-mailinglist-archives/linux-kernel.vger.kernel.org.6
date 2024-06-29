Return-Path: <linux-kernel+bounces-234807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A871191CB16
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F22B22F5F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775F56F2E7;
	Sat, 29 Jun 2024 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCMzCGJm"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD534CD8
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636881; cv=none; b=uwg5ByTPUYs/sbnTY6wyPlZRbOS/9yckC/r3FVgK5fIxk0OD3KkZQw1zA6CfbfvqmdfBt71eC28ckpAFpQjNTiXb856DKnLbOy502Xx/lwScfeeKm/2rzvR2tr5ROafRQuI6a9UgGp6rmYWT8BO5HkU4mm1Wvnzwj7NPtozCNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636881; c=relaxed/simple;
	bh=kNN3CUPXSjl2xIPMgo4FkJGf2UANBb6ZkWDeUOtqHnU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FHbuS3vDK9qsQYaHRGK+ykqH4+mWhsEc0AOe6aIpxmE62036oX01kEJapcdOCMniv1xIkPIMioJ62YyjvwADws2MCifQ1nOOdw6FoWoxvxV4vrfCg7okSJfYGzLMztdFPh8QdAVHXEFK6LRxJvnMe8R9+qWcs25fIESdDQXWjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RCMzCGJm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64adaf9ec5dso19223577b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636879; x=1720241679; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3MSmntjEyHp1VfXd+WDcjggsLDUpv4S+apWQbP8i85Y=;
        b=RCMzCGJmqspIPlh6T7jmFD1HC2hQH1osweMyNlPEIbN+c50MNZDY+ITh07JSapVLXe
         jB5Cu5kAzOnPvWFeaOlBQW2wTS4WXVgScPdypOISP8Asg8PrfM58ZuiG4EMnF7MoMapk
         dndZbMDLFkc7eMnWFgu0JiVxGbQrbVf6bgck8LmA+wNyXuMPHqA1vyjg7MlIH1Wb6zjB
         c6cW58IQQKCG8eTJVE52uCJ1q2HatlgXTW3UrcbBfVvbz6izW8PtU7S0xYpRpulQ5t84
         NsTMVNJrvdaeyRUmR+UDC+ApAomIh6LSgFw3EmlxfwYaX/Wdh4+YFVdtMR/6PSlO0Y34
         XBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636879; x=1720241679;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MSmntjEyHp1VfXd+WDcjggsLDUpv4S+apWQbP8i85Y=;
        b=Iahx3tQxjGMagZnny8K4MiZPwGWIOhopfPEEFkrsoEnU17Qau9CfKAL/v8Gwk3tyvG
         uKg5wvSCq/hwS2JRaXHVF5HnEmc0PiE5bA31TI36OIfyjvhGbOUQMtNf9MhNzG1eDrKW
         Ie6BnTyzeNoyY/9C24i21olC+iO+mX28ZYV+mJNPugQwpTD1QSZJKnAhNRXicDMy+e/m
         wOLdvyHSVfRBRkDSFXslHx9i0R9x6tTTv8lp8zwDgYbH5OLnpjK5cvZOKZwpI8ouiDeT
         VXxCVwOMr/LbDkktVLunqE4uCfyEPbDWQFqoJHJcvFB2PgviAki+E5/JwRv8ohxIMNVF
         H75Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdMUJAIRZwYYR0DwEdIG5S1bCJyTvujd34ar+6JrmKWXubX9W/egKe4L+UQC0yYoxVYtD3ox0WqL+n4fxYVzHkRM/lTmiP+TfrwiOI
X-Gm-Message-State: AOJu0YxiO/lQu7Ad78qUBBeSlxr7G6u6brZYTAUwhOX4PBI10cYcC4P1
	NbAG1K9ue3zkg2Uy1uXY/Si+dkk8Gtiojc23gPsDCnUXqYB2+cDQnYmbLGxdSVS+2eDpADQx8Fi
	vXpiGGg==
X-Google-Smtp-Source: AGHT+IHd5kE0IfP/nRLN2cbftjl35zvC0mgizfDEnWFch8Sz6HpMO2QkhZzdMmEc/7weRSowcQlHEmYb1JQS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a81:8485:0:b0:64a:8adc:f95c with SMTP id
 00721157ae682-64c77cb6557mr6117b3.8.1719636879333; Fri, 28 Jun 2024 21:54:39
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:36 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 14/28] perf script: Use perf_tool__init
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
2.45.2.803.g4e1b14247a-goog


