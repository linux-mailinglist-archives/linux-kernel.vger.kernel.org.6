Return-Path: <linux-kernel+bounces-231482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA5D919930
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4161F233FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6AA194149;
	Wed, 26 Jun 2024 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g68d2k08"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E4E193061
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434213; cv=none; b=scV/R6BmpskEDqKvQ+h71QpuYLxWGQYzJbIfoWFVjSLkXpuvKw5FiW6Crbpm3elj8Z5FMr5ldvOdwCpKmKjYNDTvCTTiC70qp2jK7FWSZrNipPOTwBThJw732S0Tig9sTWztPDoZXPl+9lv7pCjeSs/Cz4iCoZNIB90vqXhoflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434213; c=relaxed/simple;
	bh=0aVHJrC08XhbCG4RutjMTYNM2P5O2raGsxoyhdcFWYM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kb1UlYsJ+spTnhjxp0ueUDevKBaJNgaY7t5iF9XbL0Falc7wD4kAXsiq+2deL5zKJLtFtZKBaw2ykr0j7qfiTZeaDHkcgI0/3QdNSln7ILBfmu2v8Lax7I5L/X8Oa/hjJtAPpJdf7ZE4xyl3iKNsgw/1SJim+jSMxX2FxlQdyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g68d2k08; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfe4f388d33so15128423276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434210; x=1720039010; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFiPugBk+wYhM4/j4Jlr9h9+wpX8LHXAYZExjKx1mqU=;
        b=g68d2k08wLKCiAVA2EbKSanwRlGf3uWpplqRU32d2aizqzDl+O6P5Js9quWWcmRafh
         j/BRdRl7nHIiJ7dQjvnT0a7Zu0C6p4XLWUQ1pIoSp1AgXsRZEwMnv1Ip7lz4Hlo9rCT+
         SRisur0NMDRhG2Fegh6aXSvN/zhCen57GBSQTiZX5u0/ZrnUjVVLFI5kyY7MaXctaaoC
         eGmhGoAtCjxsOE+6z7dgNGjiSXWmUg0dVT8wPL5KYVwYq8j3eqJF04bxnyVbjBDaJNy0
         SJPCx7kJ/tQw/AmvvDLqZMvzYYXlmAxm5gxroQbFpavqh4hK4w02bTelOAuKpGzSDAPr
         8RtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434210; x=1720039010;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFiPugBk+wYhM4/j4Jlr9h9+wpX8LHXAYZExjKx1mqU=;
        b=Pe9Mj/rXWQ4Z/qOhYr6wYfcSKCH83cZ3zThP7mSEuBgcLfzN2CPhVbnj3Q1cYijh74
         7Ao1twLl0+PXPxP5L+e9JTdvBGRHb0qWZqiPccFmnUryZKKDFPKwgt2KNmp20+g1XtrJ
         cieu+9+x3HKZkdCP8kPClrRg6QTgJ+6FKcHzTE5t7JDF1pbduBoUWqeyshzogaKaqH5a
         /GeGKLMvuxsuLOS7ispvi1K8/NuLyMaMRdPd7JUjZP7AtEjt7YzfEnTUtQeValvozzFP
         4t9/qxgfC3ioftoeJn9+rrWsZ2UpAh6HSGZ3KyqoSvmy7dRWxFQOwXTeV5ZJzr8vAwVi
         Uh+g==
X-Forwarded-Encrypted: i=1; AJvYcCUxcJQ9oNPLKfXyKXdebf639hieK5OFy03lyZ0K3xQMztC21G7DlkU2apmvYWj6k7qYuJJXw6wBcQBk+2p1kc+jX32Y9D9FER4/dBJm
X-Gm-Message-State: AOJu0YzhBlDOZ3UPQaFVTh77aDXIPkpids+5v/yO3gdmXLZmNMbnx46O
	f8RlSFhmlSl78fBStH9tnoyhF0zNTipMVrob5bjZxlHxafMHQaG5BwRSKMArTWMXhKACr2cxzYn
	1MBrRFg==
X-Google-Smtp-Source: AGHT+IHT6UsLLgb3WeR5Tle1hXNSZKCOcstdTB0LxqaxWb7lVdJw/IMWJFFV90Y6uJl5XDW/2Jn5RtufdKfJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:154b:b0:dff:12d0:2072 with SMTP
 id 3f1490d57ef6-e0303fd4396mr704257276.2.1719434210053; Wed, 26 Jun 2024
 13:36:50 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:07 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 05/27] perf tool: Add perf_tool__init
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

Add init function that behaves like perf_tool__fill_defaults but
assumes all values haven't been initialized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tool.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/tool.h |  1 +
 2 files changed, 59 insertions(+)

diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 17219ecb8fa6..cbd9b888bd73 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -230,6 +230,64 @@ static int perf_session__process_compressed_event_stub(struct perf_session *sess
 	return 0;
 }
 
+void perf_tool__init(struct perf_tool *tool, bool ordered_events)
+{
+	tool->ordered_events = ordered_events;
+	tool->ordering_requires_timestamps = false;
+	tool->namespace_events = false;
+	tool->cgroup_events = false;
+	tool->no_warn = false;
+	tool->show_feat_hdr = SHOW_FEAT_NO_HEADER;
+
+	tool->sample = process_event_sample_stub;
+	tool->mmap = process_event_stub;
+	tool->mmap2 = process_event_stub;
+	tool->comm = process_event_stub;
+	tool->namespaces = process_event_stub;
+	tool->cgroup = process_event_stub;
+	tool->fork = process_event_stub;
+	tool->exit = process_event_stub;
+	tool->lost = perf_event__process_lost;
+	tool->lost_samples = perf_event__process_lost_samples;
+	tool->aux = perf_event__process_aux;
+	tool->itrace_start = perf_event__process_itrace_start;
+	tool->context_switch = perf_event__process_switch;
+	tool->ksymbol = perf_event__process_ksymbol;
+	tool->bpf = perf_event__process_bpf;
+	tool->text_poke = perf_event__process_text_poke;
+	tool->aux_output_hw_id = perf_event__process_aux_output_hw_id;
+	tool->read = process_event_sample_stub;
+	tool->throttle = process_event_stub;
+	tool->unthrottle = process_event_stub;
+	tool->attr = process_event_synth_attr_stub;
+	tool->event_update = process_event_synth_event_update_stub;
+	tool->tracing_data = process_event_synth_tracing_data_stub;
+	tool->build_id = process_event_op2_stub;
+
+	if (ordered_events)
+		tool->finished_round = perf_event__process_finished_round;
+	else
+		tool->finished_round = process_finished_round_stub;
+
+	tool->id_index = process_event_op2_stub;
+	tool->auxtrace_info = process_event_op2_stub;
+	tool->auxtrace = process_event_auxtrace_stub;
+	tool->auxtrace_error = process_event_op2_stub;
+	tool->thread_map = process_event_thread_map_stub;
+	tool->cpu_map = process_event_cpu_map_stub;
+	tool->stat_config = process_event_stat_config_stub;
+	tool->stat = process_stat_stub;
+	tool->stat_round = process_stat_round_stub;
+	tool->time_conv = process_event_time_conv_stub;
+	tool->feature = process_event_op2_stub;
+#ifdef HAVE_ZSTD_SUPPORT
+	tool->compressed = perf_session__process_compressed_event;
+#else
+	tool->compressed = perf_session__process_compressed_event_stub;
+#endif
+	tool->finished_init = process_event_op2_stub;
+}
+
 void perf_tool__fill_defaults(struct perf_tool *tool)
 {
 	if (tool->sample == NULL)
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 7913b698033a..897c6c44b6b2 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -88,6 +88,7 @@ struct perf_tool {
 	enum show_feature_header show_feat_hdr;
 };
 
+void perf_tool__init(struct perf_tool *tool, bool ordered_events);
 void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
-- 
2.45.2.741.gdbec12cfda-goog


