Return-Path: <linux-kernel+bounces-283743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8994F865
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EA91C222A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4328198A0E;
	Mon, 12 Aug 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0BzHPOV"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D3197A92
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495660; cv=none; b=WhBbN3C2Qqh7Yf0G7aB6DV7kSKq6xCo+sPkcOvg3kUz1LPL44nJX/NjWvy2BiNU9LPofxX3BO48bU+j4jP5O8u/asbpv+YzUQ8jou4mYH2/8KFNMz7rZMk5Up9iOdykt2WtqrZl2tchsNQ6THnX0xBKO3I7PDeweQmGeg1DEsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495660; c=relaxed/simple;
	bh=kZ7cYYe44uih2DKNAfDOwvKjwiQuD8132impVjdxqZo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QAdoRb3Dt7TQm0E6dDCOkwfltlc0nSSQs1O/hbaG90nLANQomFubftDv7XaAbblHHGSNlbJeh/ASkRe94A0494bITxRVJ57YoFejmaMfItbVo1ueJb7XLB5Hj7l2K6eycfGTmG/oOe6CNEjG/nF+6X/vHlR4KyixrNQJ6lS1Ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0BzHPOV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64c3f08ca52so101326487b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495656; x=1724100456; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5QskrwEwgJh1SEHBPySv+b4dUG/k47lipRxRjevwjg=;
        b=M0BzHPOVUko4vFNzWDpOqf2l5RSL7blj9v4Hxif8rLRQ5wnY6HhooiiG5BWLXvSfzN
         6oZw3KitJlXy1orbOm8oo3kwwhjEoZWwJhSTrpIpnZXu9pnsVbfu3roEhWizkCGrLaDx
         3tVRCzYshXAH6ItwwYxGzIdSAHpZNNTHGnk02ZTa3m40onBsxCX9zSHo1jpoSYGL1DdW
         gKE+H/3XIfmfE3mV4LcQMQm20c+tma3cYDQQjT7A2ZjFU0GFiBAYG9h+yuIgEM58KNzc
         UcbPQA1LtE1ThuJ+7Oysw9LyVtS8sPiKxVgp6qLczPTnNXIApPPo0O7tXIR23hTIq1Ov
         jOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495656; x=1724100456;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5QskrwEwgJh1SEHBPySv+b4dUG/k47lipRxRjevwjg=;
        b=WEMB8C6bcksZcGqwjjanI+2OAdX1/9iP/QjC0rvIfl8mo3xTy0xi5XTE0PG0PqBMsL
         6VbMzM9Y01exu1e8iwYEpIsmt+Hn5VxhQ8xGHIhNPA6Isn6lQEfgHVtFdJeTEYBm7tHm
         BL8cGyP31zYA1pOXMR93WHzhCCD0Oq61hd9C8zON1RQEWFtMfXaSsK+Z4T5Uoj4iYgcX
         tUPVKwi121yZo2MIFI0i0YzNA4pgdIw5inN0P2zW9MoOeujJ2YyZRMSsWzmWS/S2bvRE
         jHLrO/9x+Iut65ImQm7Ypyw9QBux1BG/bI8mK6X+H3GI7MLSSzu5FMxcXuVpo6Jwq0kd
         I9pg==
X-Forwarded-Encrypted: i=1; AJvYcCWSfRWf2d18hEK42Q5PJVYZCIG/nACRTHfJtCSCoByFk/Lx0BBSWUukLgKGjfUN2wOVseuPxtSQtN0KrP9K1FQe3tMZ6Bn/HDoDWgQ9
X-Gm-Message-State: AOJu0YyLzA3LmNUI//XPOAs0K5zpc5ucU6qdE08emeFv9UJbXzmN3UzG
	U6jrEgHwj4ph/ZhZeNEXWA8upsMW5/7rX0sbXM+ejv7g1FfFYupTBuosr204Sm3jn9sVNFK0NqT
	kdhskVw==
X-Google-Smtp-Source: AGHT+IGYzX4ib/mbR9sRiEgZk4S2Ro0LhXD3PEY8JFZJzNim6QhGI9Yre46z0AplBbBDzJBKz1DXJDGI2in6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a0d:e4c1:0:b0:615:32e1:d82c with SMTP id
 00721157ae682-6a97732c587mr106997b3.6.1723495656210; Mon, 12 Aug 2024
 13:47:36 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:46:57 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 05/27] perf tool: Add perf_tool__init
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
index b917b1fa6204..7c7ce395e573 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -89,6 +89,7 @@ struct perf_tool {
 	enum show_feature_header show_feat_hdr;
 };
 
+void perf_tool__init(struct perf_tool *tool, bool ordered_events);
 void perf_tool__fill_defaults(struct perf_tool *tool);
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
-- 
2.46.0.76.ge559c4bf1a-goog


