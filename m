Return-Path: <linux-kernel+bounces-283766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE3394F880
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E481C20D63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA3D19E819;
	Mon, 12 Aug 2024 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQ8vjPi6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6019E7E8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495706; cv=none; b=AoJErTmuCyo3NdklJXxAYZrb2J/uUfGiPSQA01eZsquQ96LoY2H1joZZWv28NC1xO0O40oYOQH7M1b2xURI9rYHxTsFXK9/uKguyIrCaCIcSTY+0fCqie00k0MFQt3P2aHShz6LfVBTUQgwgl42d6Qweh9PZEMVojfJ3/Sa8uxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495706; c=relaxed/simple;
	bh=rK6gkGo9GgTELivuAc4AXwSkX1abYEDMRCaMnWGvK1Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nvVGIB2UNe3uzFViSk/10XqoGuu+gxLOjVLF6OvuSkqgbSmGAcTDHiqwGaP0hjUwtxJWLBWYyBDqXZ7fGpJjbPw48mPc+jomh4qenq/gLDzxfjTvXi22pXhEZUeXSPog8vSJ8OygQW8IPmzDe+Wd/IjFVfapalMJmvkIOVJ2IGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQ8vjPi6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0ba4d19585so8084337276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495704; x=1724100504; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/PW497Hbxz+K6ERVzgwnz8NGkRpB4aRXVX3N8aWF4E=;
        b=uQ8vjPi6X+LQ2okOXeRS1e+PcGxh9QSeVjVR591cepUx+EI2uOZdMbs/+74cPUUVgK
         96g+bn7soS7ushG9NcT4tdr3N8O8iKvhAphKTPJGUqNJRJhdQ6ts1Iv//6cU3hRS3QNT
         uTK21yBNhj8VWkPZLaNDH1gGPhpxes7I6g6TkAcEBuRSdBGPqUDezR7aMiHh3eQ4L1eL
         6yS+0xXnG43sS+DGXtRt8Y0hRoDtrnHxZlxHx+gcoqleBwRvlwOpEQg52o1+TXQQoKle
         dv99ox8w3JCgX5Lj6zG1jcXvyWrQD3uEz7h5NuHHg90OCHQ5Cnx78QHHHCrXkY6f2wHp
         i3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495704; x=1724100504;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/PW497Hbxz+K6ERVzgwnz8NGkRpB4aRXVX3N8aWF4E=;
        b=FvDzmZDV/DYxtSNPFrwq2kFrkOP5y+diRZE42WgKyHHl1PTGz5vGn6QiynFXzlFwAV
         HZaaYio0zjZfUG/ZRXNgipvL6I6/iPe6ulaceotdwEKEwoCB7h88Ns3QK6UvNiQrTurT
         H7I7wBADiGlzH4EY9mgMKDhfyTpRvrtFbEuaio9o8um8tf8Ho7YF0rHugV6tHwq4Jgup
         Lu9I/z0Z07WNGbQ9QLyK9awFJo27dHc1DcrtsM2Q3TpUxjCVYWcVkpTisxe8nYyTTBQe
         P/dM9kiYailcAly3hlZ7cPPCPsx6VakN2WZ0ot0NBAVbLEFaLjUkSBHIT+eR/Pe3LI17
         r4lw==
X-Forwarded-Encrypted: i=1; AJvYcCXqGso5qy7qiJX3a6MRQafWfetDwVQFTrijXM3eTWdUOfic1NHJJkJq+4U1oM6lskG9pamoDWL2wJhv+SAOo3yMlRen+FRtLZ5DHSAh
X-Gm-Message-State: AOJu0YzKQ3Z7B19TNzy7UUoBvm6oSHVCTjTMpp9CODQ8k8sa/UXo+Hf6
	lSz/ZHUDXsoJ4xrG1Ljl+ekfU+lI0MmreVmhpwv/+ZVsqhIcTvweEMg9BOenwjmeKZ/2zJJdpQW
	Cve4VMg==
X-Google-Smtp-Source: AGHT+IHz+OIR3uPEMJrYUYVFCp+CEdR1jvMSTlm/KPD5+ygMtWmiw1Qa9JNuPjCJbkE3PhW6bzE9s9yYXJ4I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:6fc5:0:b0:e0b:ab63:b9c7 with SMTP id
 3f1490d57ef6-e113cf5e921mr2109276.7.1723495704095; Mon, 12 Aug 2024 13:48:24
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:18 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 26/27] perf tool: Remove perf_tool__fill_defaults
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
---
 tools/perf/util/session.c |  6 ---
 tools/perf/util/tool.c    | 89 ---------------------------------------
 tools/perf/util/tool.h    |  1 -
 3 files changed, 96 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5c0e0341d39e..a8404cc99cfc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1781,8 +1781,6 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	void *p;
 	bool update_prog = false;
 
-	perf_tool__fill_defaults(tool);
-
 	/*
 	 * If it's from a file saving pipe data (by redirection), it would have
 	 * a file name other than "-".  Then we can get the total size and show
@@ -2206,8 +2204,6 @@ static int __perf_session__process_events(struct perf_session *session)
 	struct ui_progress prog;
 	int err;
 
-	perf_tool__fill_defaults(tool);
-
 	if (rd.data_size == 0)
 		return -1;
 
@@ -2260,8 +2256,6 @@ static int __perf_session__process_dir_events(struct perf_session *session)
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
index c7fea58729a5..db1c7642b0d1 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -90,7 +90,6 @@ struct perf_tool {
 };
 
 void perf_tool__init(struct perf_tool *tool, bool ordered_events);
-void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
 
-- 
2.46.0.76.ge559c4bf1a-goog


