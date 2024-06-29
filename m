Return-Path: <linux-kernel+bounces-234820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0490C91CB23
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 07:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCDB1F23598
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C019222F1E;
	Sat, 29 Jun 2024 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvvTKFNF"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D513D880
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636910; cv=none; b=McSxcAniqWIeEPoeTGUPAcMAQr+lRYHMuvCwbqmbBGKecpqM5lzKGT+jh1l+PpV8IMUjFK5+RvqA+Qw6BKHGPxcOBLr4iXlOKhVfMOiofxMXrjMf/q2BqQqY488zz/mGYIxoB7qTCHNjVPd0UVhmIZYss8PgVfVUCm6lug7p+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636910; c=relaxed/simple;
	bh=mIWU7IzZZQPEq4YeWIDCuW1Y/Tbek1DD/Kq21Hw01w8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=g3TCadh9Sa0NnqkvFSToD5fbMksDwvOuqQDGsMcpCMH6CXrwvYkQivYMbrECaoYPHWyB7erEhSc3WGdwb8/qKbC5Cn9QgcTMf2/I1AYlwDFXkYBcJlJe82q67TGViCrckPahKHuOr6TLZ5blxfaeuy34/JOIwFFWNWOTwB+wrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvvTKFNF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03623b24ddso1776546276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636908; x=1720241708; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzceA3PnZIITcf46Xf33bNMRePSLAdcPAZsGB0bFPNM=;
        b=CvvTKFNFRu/9ewCi7WwfRS6M6NNBKv/qVj6G9jgnmFVCUUYIgz2CN+bn1IJo8kFNGm
         K4AO0bRFPN2jnqlDT+BdsgioxvXnMxCES59jiyf0XpfgT+dENuzvmS3O8s/63mG/EWBd
         AmkeCg+nInNzrNeZGciQbLNgKsdGSuJ2sqDinXoj1ZvtBIFrrHYfGBxFRzpa6OXxzroc
         K8pzMExHgshx7BKDmeGCMSVnmcgWO8fa6Ii1i3KDpxRc4StLQoi88CLY2AXA+kb0nGZC
         T6RxXxDRfE0vac2YbLkk0FGsfbltCvPKk1DU4c9XFEbHGk4jeuzxbNUDuiiKuxKQIFLv
         6h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636908; x=1720241708;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzceA3PnZIITcf46Xf33bNMRePSLAdcPAZsGB0bFPNM=;
        b=RbS7H1GXUeDtlvy4ABCqlsnZnU5OEo965GCeJQNHViYg/l+nvtDWA26KzmOMi8jL2z
         XADBVxyjS8MZsP6YF1p6ALtUHrGL1taw/evsjCG7ht003hoY2in183354SgzFEIuNVUy
         7LdVSzhlqukeC4Wf2ds/tzVNhJj0L+hP/GctPLQUIOU4s+kadwz6v5XKYMN76T1fDbTJ
         T8lI5fx1ZQgo3zf5gnhMn96cnTE/h+JFw34hsAeh3dZ9kygRwNOOLWWPPRarrUHalm0S
         id3amghGDL/0wCnSPS+T3cy7VW3ZMV6iWDv0oU3F0/vMpYYvbk8rHlrj5+n0GHbWgBeH
         nS7g==
X-Forwarded-Encrypted: i=1; AJvYcCUasKZ/ptUW5O1VEM3vKZLGFPVXAhSArXjDA7uL4k9ymuku2SDSy2ZvFNBvxC9kSb6Uk3WtBJucfM0gIAQtlIGqkYwE4ULikL6mVu/d
X-Gm-Message-State: AOJu0YxekNDR0jsDCDNHfj2pjViur8uFkj4j6uKZVa+C7CWqOo/poYNH
	DSa5u/KTy72UVQSj0vV1nOtYcyhYXhjkCCzeK4Va9h6iH8QvJWGz6qTQvdItgY3mFyNlt6rQ4yQ
	U8XHRFQ==
X-Google-Smtp-Source: AGHT+IGF/SJXJ/sR+JmKyUtE7KPOf5EJWXpjDLqKIoIjmwh6hh573ZiZG4/nnUrG20dJHib8/wRPscsvi5Mh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:102f:b0:dfa:6ea5:c8d5 with SMTP
 id 3f1490d57ef6-e036ec36959mr14094276.10.1719636908382; Fri, 28 Jun 2024
 21:55:08 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:49 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 27/28] perf tool: Remove perf_tool__fill_defaults
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
index 1490d33eab2b..6f5692902892 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1780,8 +1780,6 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	ssize_t err;
 	void *p;
 
-	perf_tool__fill_defaults(tool);
-
 	head = 0;
 	cur_size = sizeof(union perf_event);
 
@@ -2189,8 +2187,6 @@ static int __perf_session__process_events(struct perf_session *session)
 	struct ui_progress prog;
 	int err;
 
-	perf_tool__fill_defaults(tool);
-
 	if (rd.data_size == 0)
 		return -1;
 
@@ -2243,8 +2239,6 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 	u64 total_size = perf_data__size(session->data);
 	struct reader *rd;
 
-	perf_tool__fill_defaults(tool);
-
 	ui_progress__init_size(&prog, total_size, "Sorting events...");
 
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
2.45.2.803.g4e1b14247a-goog


