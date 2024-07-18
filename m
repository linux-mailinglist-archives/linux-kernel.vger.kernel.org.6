Return-Path: <linux-kernel+bounces-255823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B0C934583
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E981C2101E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E542B9D4;
	Thu, 18 Jul 2024 01:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzTS2RmD"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E841FB5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264454; cv=none; b=tsEcFC9fiVoAU5Enhjxc6QINJ3ERgsq3lq9UZ7mo9w6k71ujDLflUMbi/akA6Iear4vMM2whABi+sL2dKP3D8pyxcom+Do7Otogit03wMngiTBJCllmIvB+8nSlv6KPg/eu+Jtr9liRuWqbMLxWO49ufmcwGaYAtbf1d+2u+h6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264454; c=relaxed/simple;
	bh=0BXDyWwgS7S79iHuJLErgWNfQ21DsHxf96EgsvxViOQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H8Kdt9utB7T8inTPIQ8rVPu3KQjyY8JRWuh9nWjX4wPKxuMAsS6PlYv6hluMOtGs9hAzIICW6PIcv76p7RXuWEzlX4UEeX1ecqitcYtJyCsv6fn8HNLchuaB1fCGmyJnKn/8RGgWwWpbuWHr0qXKaUUTKEIMtSBiPaMoMiW5UNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzTS2RmD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6525230ceeaso6066987b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264448; x=1721869248; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnSPlghBx3VkMv83qbGk/P7jIBEF9LRODtE5BbjiJPc=;
        b=qzTS2RmDKJyFvLCmshMsIiJdqV/oMTdC+c32o586AkXa9huq07cDkxDteocs3tvB6S
         MVh1vsA758cZdEiw6vG0A3XWFMbbG7vWJwCexglb/s24/aczuvqwACP6+9L92Dez/BkB
         kV/nPMMPalL+hC/5wsKtDxHxKXsp096uaut0FjnhzlBcKJf/NQCtlxVhEITeLGomx6gh
         wVLJeMlYi+gQ8QzVVjjl6DMWmhqjxLiTmcmvcgKpEZNNR4jSU0dbCzRSxWtDWCzz03NW
         Ss2Io0EVRv9yWSJcCGPL3+X8eKRW9Scz9LXke302jAGK6h0cvzlUUDHhAI2u0dmAWcFY
         vVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264448; x=1721869248;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnSPlghBx3VkMv83qbGk/P7jIBEF9LRODtE5BbjiJPc=;
        b=csfMVEiMolQrMtFxfDNtWMujcOr8BpDgP34EcHaQ2tGcQde34d+EPW1oZMIEYWPHx2
         S3OWx2ZpowuwMafr6gCOFrg7QYvfPhZK3PB2+6c7AK5XzJJ8c6+VBwl9p2mvd2H1JZaP
         Oh+xJedicoj6BsFq020TJxvZ//YSp0MjzTWOkoM3biSac+BGzcnIfOYZHbj6cUn33Mwx
         AlPnG/FFFfgF3C7ABTIvZax0UjPstByOJRBbbWq3qfZqCqodl8y/pa5SY//r8dT2OvAk
         RE89hxzEiHzN0VfgFc7SFUlKpwhMhUxDR5oJUEG0LOnbRmXR4im+b3Sop7hRi1Op7LaK
         bHAg==
X-Forwarded-Encrypted: i=1; AJvYcCVmZD8ncmngIeZXsavMgOVmIm3YTjWDqrHjfCiiIZz4Sxn0UWW73EQpcZqcgN/Z5Gkm3crQVDZHYVZ4AHL9XQ9TyS/KGEPNWxqXGHaR
X-Gm-Message-State: AOJu0YwEfN6U9DulWp7s89hg5Ok33hnFtkWQHWHEPjNnc/1+24cahTz8
	CraAXID9A4btKyeWxWzGzPGrCkQD2xDdGfIlrhENWQSvdDpzhBe0swhQnru+ev7IAreFcOkWvAU
	BMuXoQw==
X-Google-Smtp-Source: AGHT+IEtJVGPJ7X377yE2YXSNRqiPai0lkaBu0kyQ7M1ExKy3MUuhJpxePliNSESNkfKYo7HPJkc1WZwBgQJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:690c:110:b0:65c:1db1:9235 with SMTP id
 00721157ae682-666005395bbmr263657b3.0.1721264447940; Wed, 17 Jul 2024
 18:00:47 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:01 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 05/27] perf tool: Add perf_tool__init
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.45.2.1089.g2a221341d9-goog


