Return-Path: <linux-kernel+bounces-255843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A01934599
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831631F26B51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4E84FAD;
	Thu, 18 Jul 2024 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDbHt2VD"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FF880C13
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264502; cv=none; b=CRS59/f/rlqAamJItDuC+vIvZvZM/TSvzwIPK/i8O57D/znlfkGWV1G3eXrtfe5ztE+MpXiHMMO4gQyRCstzbuvIMQZ7Uc/eUxkqz5uGR4EXRceRr5AzMIRii/7xv/WCuRYf5jHSvMTyBlaUiHlPwAy2Maqq2GuH/hEYSxzo7HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264502; c=relaxed/simple;
	bh=Bx08tB6feHERnMdXGNueKGNYplrQpkF4l9BhuiL3bjY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SDjNSIk6T9cdvAOz+eW5ufmMG6Y/TZOMfcEtkMZfju8vAmmO2vQ/dmIBsGG7FlqOYr/atz7gegLQr2q5aeup5AOyYMk1eRYliCaCbi30J3zY6eBYv1Z+WFv8FAhb2TPAIIhrscMH/1TbMBGYoIYJHKnQXUxoZ2yOabke5jXtCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xDbHt2VD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0335450936so714218276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264496; x=1721869296; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsqa4ji/Kru2TpTCpzQSXPab7IPwWK5YnC4MrN+9OsY=;
        b=xDbHt2VDZvuYdJrQVNz/b7VwTcLVlCp9pm3X0zLdxRLSbVmCG74XjJDTZG3902+7x1
         3YKGDADQSMHSB6Td3chwiYK6n3Wv+UBq17yTKGkNgTsvsk/KVJEVG6ndideXqvf6oTv4
         90XRxCRVhW5w+oBwq93QWiQ8lEBWCaDFoCODnqdL6cwDWgl01dOq0UEShHFP+/yMkcNQ
         nWqxJYsQssWVZEQFRkOPf1x6KEd66C+Dr6EpsqOSO29jL0YlAaDhxcDZMV99czkZE1Xt
         6X7BEUwQZw+Z+p0JnhpnMFSiIxVi8KTn/vhQzXJwy4S+deLdjQ061yS2sv+8VQNYd2+K
         efMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264496; x=1721869296;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsqa4ji/Kru2TpTCpzQSXPab7IPwWK5YnC4MrN+9OsY=;
        b=UVY1j+a6/fCmnNwEsSdGX26fr/wTkTDXJdM0VgrwK4cXDL0KLr4PmT+RgybaLmfAN8
         0qWSD97kkO7eIJL8uvzOw/aNokdqYN+HWwqK9y9kaWdHX4SPVw42WJYAvlPpirBXxmZz
         D+1WtriPPzdkCJQOJq6B9y3KfioVd/yMhzskT2Wp6s9Wv9Y4ljRZVsmKy/Vu8gxwy7bk
         EWXCjczWI+36A9BzYIuQtQYdOPv574SLfbxv5MWorCMDRGrr2W5cMU6x0TzKK3ozDbWx
         TNmpGlrxWTQWC4qi/nAjg5e3CSvY8kcLRwC37sbH+Lqi2Y85fUcLJW/iPPARtQKBGvjW
         Q2eg==
X-Forwarded-Encrypted: i=1; AJvYcCVrFxfZOXyb/B8V6VCtmnKD//uRwrVmY7opO4M4VLuV6odCLMtdD1M9cGKU4mzfgsQdk74Y/enmpHS69snxuQdzCD5y/r0ChjW4SIwg
X-Gm-Message-State: AOJu0Yybnjwco6wEMH9ltgZhl8Tvov9Wl8hQY6wx4NAJIUUjscbjBozs
	fskZCNpR51Q0XbHQKe9txWDGboESZ1wsQ9skn4p5/49x/3i6R5eSTglm7gGhmre8hIjIJciJ2S/
	ZT1/byw==
X-Google-Smtp-Source: AGHT+IHCN1faAO+r6hnMX5BHhvSYi2L3MP7xyujmm2Mr7VslcsQx4zStBqwTrKdnZw0UNaH7Tqzijy2cur+u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c6:b0:e05:aba2:43e9 with SMTP
 id 3f1490d57ef6-e05fea8a868mr2200276.5.1721264496521; Wed, 17 Jul 2024
 18:01:36 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:22 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 26/27] perf tool: Remove perf_tool__fill_defaults
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

Now all tools are fully initialized prior to use it has no use so
remove.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/session.c |  6 ---
 tools/perf/util/tool.c    | 89 ---------------------------------------
 tools/perf/util/tool.h    |  1 -
 3 files changed, 96 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5359ee055c85..ad5da61d2330 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1776,8 +1776,6 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	void *p;
 	bool update_prog = false;
 
-	perf_tool__fill_defaults(tool);
-
 	/*
 	 * If it's from a file saving pipe data (by redirection), it would have
 	 * a file name other than "-".  Then we can get the total size and show
@@ -2201,8 +2199,6 @@ static int __perf_session__process_events(struct perf_session *session)
 	struct ui_progress prog;
 	int err;
 
-	perf_tool__fill_defaults(tool);
-
 	if (rd.data_size == 0)
 		return -1;
 
@@ -2255,8 +2251,6 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 	u64 total_size = perf_data__size(session->data);
 	struct reader *rd;
 
-	perf_tool__fill_defaults(tool);
-
 	ui_progress__init_size(&prog, total_size, "Processing events...");
 
 	nr_readers = 1;
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index a4ca16e5eefe..3b7f390f26eb 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -288,95 +288,6 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->finished_init = process_event_op2_stub;
 }
 
-void perf_tool__fill_defaults(struct perf_tool *tool)
-{
-	if (tool->sample == NULL)
-		tool->sample = process_event_sample_stub;
-	if (tool->mmap == NULL)
-		tool->mmap = process_event_stub;
-	if (tool->mmap2 == NULL)
-		tool->mmap2 = process_event_stub;
-	if (tool->comm == NULL)
-		tool->comm = process_event_stub;
-	if (tool->namespaces == NULL)
-		tool->namespaces = process_event_stub;
-	if (tool->cgroup == NULL)
-		tool->cgroup = process_event_stub;
-	if (tool->fork == NULL)
-		tool->fork = process_event_stub;
-	if (tool->exit == NULL)
-		tool->exit = process_event_stub;
-	if (tool->lost == NULL)
-		tool->lost = perf_event__process_lost;
-	if (tool->lost_samples == NULL)
-		tool->lost_samples = perf_event__process_lost_samples;
-	if (tool->aux == NULL)
-		tool->aux = perf_event__process_aux;
-	if (tool->itrace_start == NULL)
-		tool->itrace_start = perf_event__process_itrace_start;
-	if (tool->context_switch == NULL)
-		tool->context_switch = perf_event__process_switch;
-	if (tool->ksymbol == NULL)
-		tool->ksymbol = perf_event__process_ksymbol;
-	if (tool->bpf == NULL)
-		tool->bpf = perf_event__process_bpf;
-	if (tool->text_poke == NULL)
-		tool->text_poke = perf_event__process_text_poke;
-	if (tool->aux_output_hw_id == NULL)
-		tool->aux_output_hw_id = perf_event__process_aux_output_hw_id;
-	if (tool->read == NULL)
-		tool->read = process_event_sample_stub;
-	if (tool->throttle == NULL)
-		tool->throttle = process_event_stub;
-	if (tool->unthrottle == NULL)
-		tool->unthrottle = process_event_stub;
-	if (tool->attr == NULL)
-		tool->attr = process_event_synth_attr_stub;
-	if (tool->event_update == NULL)
-		tool->event_update = process_event_synth_event_update_stub;
-	if (tool->tracing_data == NULL)
-		tool->tracing_data = process_event_synth_tracing_data_stub;
-	if (tool->build_id == NULL)
-		tool->build_id = process_event_op2_stub;
-	if (tool->finished_round == NULL) {
-		if (tool->ordered_events)
-			tool->finished_round = perf_event__process_finished_round;
-		else
-			tool->finished_round = process_finished_round_stub;
-	}
-	if (tool->id_index == NULL)
-		tool->id_index = process_event_op2_stub;
-	if (tool->auxtrace_info == NULL)
-		tool->auxtrace_info = process_event_op2_stub;
-	if (tool->auxtrace == NULL)
-		tool->auxtrace = process_event_auxtrace_stub;
-	if (tool->auxtrace_error == NULL)
-		tool->auxtrace_error = process_event_op2_stub;
-	if (tool->thread_map == NULL)
-		tool->thread_map = process_event_thread_map_stub;
-	if (tool->cpu_map == NULL)
-		tool->cpu_map = process_event_cpu_map_stub;
-	if (tool->stat_config == NULL)
-		tool->stat_config = process_event_stat_config_stub;
-	if (tool->stat == NULL)
-		tool->stat = process_stat_stub;
-	if (tool->stat_round == NULL)
-		tool->stat_round = process_stat_round_stub;
-	if (tool->time_conv == NULL)
-		tool->time_conv = process_event_time_conv_stub;
-	if (tool->feature == NULL)
-		tool->feature = process_event_op2_stub;
-	if (tool->compressed == NULL) {
-#ifdef HAVE_ZSTD_SUPPORT
-		tool->compressed = perf_session__process_compressed_event;
-#else
-		tool->compressed = perf_session__process_compressed_event_stub;
-#endif
-	}
-	if (tool->finished_init == NULL)
-		tool->finished_init = process_event_op2_stub;
-}
-
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
 {
 	return tool->compressed == perf_session__process_compressed_event_stub;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index fb7e32d98dda..0874e7924687 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -89,7 +89,6 @@ struct perf_tool {
 };
 
 void perf_tool__init(struct perf_tool *tool, bool ordered_events);
-void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
 
-- 
2.45.2.1089.g2a221341d9-goog


