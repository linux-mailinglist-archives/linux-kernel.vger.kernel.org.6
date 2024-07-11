Return-Path: <linux-kernel+bounces-249644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B409792EE30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2C41F2283F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B616EC13;
	Thu, 11 Jul 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YIjD2bRQ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837416EBE0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720827; cv=none; b=K9K8d/7mDpdFFrGhugWEAfKHMfXxLjZx9Dvlux39YHiTTMR2Q/z5oia3JNppOVm7DIHU+6TjT0xe5Ap1uYbARr6KJ1yv8WtmeROqrzfQ8Y6hpjadWmfU2Y27zm0XVcKeyLN0oPrkHJldoRA2EjXaUmaouMBKWUKGk8G19GRFkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720827; c=relaxed/simple;
	bh=PtBRXc0c+0allU3O64DiNYmraKLIDmcwEXLGEG6EUWQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jEQuIMTnJT/U/yCQxWVW0pnIVUV4mX0IeFpiuGhHTzKftJxNpvtQ/+5TyUfAx6ZBUkABGFrw8RWkK1VQ/cb1U4b6rZ41jK7+94vGEJYvvpSFGwn7ffdh+eBHBhBVstIVRCVccOmLV8Mc7BqnIaMiPRdoppq+MqfbTW6gFB1s+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YIjD2bRQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso1992236276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720825; x=1721325625; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7irtahaUgZZ2kadtdQTAIVJwXhey7Hso05gQMGn03JQ=;
        b=YIjD2bRQife26ofr3m5uxiuibNXv6NUgdxztknnwRjtfcMcOmMk/l2wLXA/NPdDszT
         xT0UehaNSZcEoE/7M0QEIWldlOOaRlSvP8r0engcxbh79IdAiPyJ5gdPSdsDSRE9jhaC
         m3cei+7qJUMLzebkToILXbCItf4cTW4F8vnBEqyP7vzGDDheZv0GTcLLtmVTE3CuARNo
         A3R6rd6OJ3ZFL/NtbpvCY2YzmMDfG1bE8Q+KZbh1PPostzydE3qJMwTCI9y1DEfaah8A
         zDa2ln8GuAKMoh3LkKosgtEsru5uvLm31EkYDIFNn9XmRX0gZ9337rg4NHga8NOG+LtA
         0+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720825; x=1721325625;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7irtahaUgZZ2kadtdQTAIVJwXhey7Hso05gQMGn03JQ=;
        b=EJUgaDWEbKRVvl705cKuzFxJm1uIgdFYD1Q6s1YYMl+TBkatFOsCJwJRjTaOZ3l9eH
         CEZx7VMyn4n24Is8YN2cCR2ojmdiJJRZZQTuGIhq4xK2dO4C6TvelcJjzvmsUk1Q6sCx
         9WJqcQaq1m7Y9N2ZsE/BqtcZf5OJsJVmTWUg6+JnJnKjaJkzogpHPE/BiGs1zTYQgVCF
         pCxINmYnXxl19UhFJWgQEZuKOVaY4/uJJbDuLHsxd1tikY1mHIe+p/EsLiYCcgsZp5lP
         4sd1zfSOZIM8rUXL8P7BMPeTQY4bRNKAw3S+ieh3t5BNte6cJCHBp2zxchFZkiiqe8uV
         64uA==
X-Forwarded-Encrypted: i=1; AJvYcCVxEzlJfS1RKb8vMDTzQY1GxeBLwbv/DXbCvcb393UeuYAl8hVUkKNFzI9oBb3EqgLQ3Dig1kpKYMHAIUWq2P1xqYsIsWfVCDwN3hG8
X-Gm-Message-State: AOJu0Yy7CR7500cNTEIU3xaGF7BfNP+hXNWO5wCUMOM7pl32qJxCBrS9
	jNCTSznxaxhwT4zqK9H11e/AWxL7h0z5Z77jyVO+PzGl7GajsR08PDkgfuNGentWUEu4K3OSS8d
	3yrSCKQ==
X-Google-Smtp-Source: AGHT+IGMj2daCCdfqUIMVyxFiaBOl2uNvUMGL0sEZfXJ00x70OsfOTwTplPhBU9/aZ/vlnQv3brgWNx7JDSm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:248e:b0:e03:3cfa:1aa7 with SMTP
 id 3f1490d57ef6-e041b03709dmr19480276.1.1720720824552; Thu, 11 Jul 2024
 11:00:24 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:45 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 05/28] perf tool: Move fill defaults into tool.c
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

The aim here is to eventually make perf_tool__fill_defaults an init
function so that the tools struct is more const.

Create a tool.c to go along with tool.h. Move perf_tool__fill_defaults
out of session.c into tool.c along with the default stub values. Add
perf_tool__compressed_is_stub for a test in
perf_session__process_user_event.

perf_session__process_compressed_event is only used from being default
initialized so migrate into tool.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build     |   1 +
 tools/perf/util/session.c | 310 +-----------------------------------
 tools/perf/util/session.h |   2 -
 tools/perf/util/tool.c    | 325 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/tool.h    |   4 +
 5 files changed, 331 insertions(+), 311 deletions(-)
 create mode 100644 tools/perf/util/tool.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0f18fe81ef0b..f3633342374a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -65,6 +65,7 @@ perf-util-y += map.o
 perf-util-y += maps.o
 perf-util-y += pstack.o
 perf-util-y += session.o
+perf-util-y += tool.o
 perf-util-y += sample-raw.o
 perf-util-y += s390-sample-raw.o
 perf-util-y += amd-sample-raw.o
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7e9827e61d1b..5359ee055c85 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -38,68 +38,6 @@
 #include "units.h"
 #include <internal/lib.h>
 
-#ifdef HAVE_ZSTD_SUPPORT
-static int perf_session__process_compressed_event(struct perf_session *session,
-						  union perf_event *event, u64 file_offset,
-						  const char *file_path)
-{
-	void *src;
-	size_t decomp_size, src_size;
-	u64 decomp_last_rem = 0;
-	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
-	struct decomp *decomp, *decomp_last = session->active_decomp->decomp_last;
-
-	if (decomp_last) {
-		decomp_last_rem = decomp_last->size - decomp_last->head;
-		decomp_len += decomp_last_rem;
-	}
-
-	mmap_len = sizeof(struct decomp) + decomp_len;
-	decomp = mmap(NULL, mmap_len, PROT_READ|PROT_WRITE,
-		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-	if (decomp == MAP_FAILED) {
-		pr_err("Couldn't allocate memory for decompression\n");
-		return -1;
-	}
-
-	decomp->file_pos = file_offset;
-	decomp->file_path = file_path;
-	decomp->mmap_len = mmap_len;
-	decomp->head = 0;
-
-	if (decomp_last_rem) {
-		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
-		decomp->size = decomp_last_rem;
-	}
-
-	src = (void *)event + sizeof(struct perf_record_compressed);
-	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
-
-	decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
-				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
-	if (!decomp_size) {
-		munmap(decomp, mmap_len);
-		pr_err("Couldn't decompress data\n");
-		return -1;
-	}
-
-	decomp->size += decomp_size;
-
-	if (session->active_decomp->decomp == NULL)
-		session->active_decomp->decomp = decomp;
-	else
-		session->active_decomp->decomp_last->next = decomp;
-
-	session->active_decomp->decomp_last = decomp;
-
-	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
-
-	return 0;
-}
-#else /* !HAVE_ZSTD_SUPPORT */
-#define perf_session__process_compressed_event perf_session__process_compressed_event_stub
-#endif
-
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
 				       const struct perf_tool *tool,
@@ -319,251 +257,6 @@ void perf_session__delete(struct perf_session *session)
 	free(session);
 }
 
-static int process_event_synth_tracing_data_stub(struct perf_session *session
-						 __maybe_unused,
-						 union perf_event *event
-						 __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_event_synth_attr_stub(const struct perf_tool *tool __maybe_unused,
-					 union perf_event *event __maybe_unused,
-					 struct evlist **pevlist
-					 __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_event_synth_event_update_stub(const struct perf_tool *tool __maybe_unused,
-						 union perf_event *event __maybe_unused,
-						 struct evlist **pevlist
-						 __maybe_unused)
-{
-	if (dump_trace)
-		perf_event__fprintf_event_update(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
-				     union perf_event *event __maybe_unused,
-				     struct perf_sample *sample __maybe_unused,
-				     struct evsel *evsel __maybe_unused,
-				     struct machine *machine __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_event_stub(const struct perf_tool *tool __maybe_unused,
-			      union perf_event *event __maybe_unused,
-			      struct perf_sample *sample __maybe_unused,
-			      struct machine *machine __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_finished_round_stub(const struct perf_tool *tool __maybe_unused,
-				       union perf_event *event __maybe_unused,
-				       struct ordered_events *oe __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int skipn(int fd, off_t n)
-{
-	char buf[4096];
-	ssize_t ret;
-
-	while (n > 0) {
-		ret = read(fd, buf, min(n, (off_t)sizeof(buf)));
-		if (ret <= 0)
-			return ret;
-		n -= ret;
-	}
-
-	return 0;
-}
-
-static s64 process_event_auxtrace_stub(struct perf_session *session __maybe_unused,
-				       union perf_event *event)
-{
-	dump_printf(": unhandled!\n");
-	if (perf_data__is_pipe(session->data))
-		skipn(perf_data__fd(session->data), event->auxtrace.size);
-	return event->auxtrace.size;
-}
-
-static int process_event_op2_stub(struct perf_session *session __maybe_unused,
-				  union perf_event *event __maybe_unused)
-{
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-
-static
-int process_event_thread_map_stub(struct perf_session *session __maybe_unused,
-				  union perf_event *event __maybe_unused)
-{
-	if (dump_trace)
-		perf_event__fprintf_thread_map(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static
-int process_event_cpu_map_stub(struct perf_session *session __maybe_unused,
-			       union perf_event *event __maybe_unused)
-{
-	if (dump_trace)
-		perf_event__fprintf_cpu_map(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static
-int process_event_stat_config_stub(struct perf_session *session __maybe_unused,
-				   union perf_event *event __maybe_unused)
-{
-	if (dump_trace)
-		perf_event__fprintf_stat_config(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_stat_stub(struct perf_session *perf_session __maybe_unused,
-			     union perf_event *event)
-{
-	if (dump_trace)
-		perf_event__fprintf_stat(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_stat_round_stub(struct perf_session *perf_session __maybe_unused,
-				   union perf_event *event)
-{
-	if (dump_trace)
-		perf_event__fprintf_stat_round(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int process_event_time_conv_stub(struct perf_session *perf_session __maybe_unused,
-					union perf_event *event)
-{
-	if (dump_trace)
-		perf_event__fprintf_time_conv(event, stdout);
-
-	dump_printf(": unhandled!\n");
-	return 0;
-}
-
-static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
-						       union perf_event *event __maybe_unused,
-						       u64 file_offset __maybe_unused,
-						       const char *file_path __maybe_unused)
-{
-       dump_printf(": unhandled!\n");
-       return 0;
-}
-
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
-	if (tool->compressed == NULL)
-		tool->compressed = perf_session__process_compressed_event;
-	if (tool->finished_init == NULL)
-		tool->finished_init = process_event_op2_stub;
-}
-
 static void swap_sample_id_all(union perf_event *event, void *data)
 {
 	void *end = (void *) event + event->header.size;
@@ -1672,8 +1365,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	int fd = perf_data__fd(session->data);
 	int err;
 
-	if (event->header.type != PERF_RECORD_COMPRESSED ||
-	    tool->compressed == perf_session__process_compressed_event_stub)
+	if (event->header.type != PERF_RECORD_COMPRESSED || perf_tool__compressed_is_stub(tool))
 		dump_event(session->evlist, event, file_offset, &sample, file_path);
 
 	/* These events are processed right away */
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 6886cc85600f..7f69baeae7fb 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -92,8 +92,6 @@ int perf_session__process_events(struct perf_session *session);
 int perf_session__queue_event(struct perf_session *s, union perf_event *event,
 			      u64 timestamp, u64 file_offset, const char *file_path);
 
-void perf_tool__fill_defaults(struct perf_tool *tool);
-
 int perf_session__resolve_callchain(struct perf_session *session,
 				    struct evsel *evsel,
 				    struct thread *thread,
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
new file mode 100644
index 000000000000..17219ecb8fa6
--- /dev/null
+++ b/tools/perf/util/tool.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "data.h"
+#include "debug.h"
+#include "header.h"
+#include "session.h"
+#include "stat.h"
+#include "tool.h"
+#include "tsc.h"
+#include <sys/mman.h>
+#include <unistd.h>
+
+#ifdef HAVE_ZSTD_SUPPORT
+static int perf_session__process_compressed_event(struct perf_session *session,
+						  union perf_event *event, u64 file_offset,
+						  const char *file_path)
+{
+	void *src;
+	size_t decomp_size, src_size;
+	u64 decomp_last_rem = 0;
+	size_t mmap_len, decomp_len = session->header.env.comp_mmap_len;
+	struct decomp *decomp, *decomp_last = session->active_decomp->decomp_last;
+
+	if (decomp_last) {
+		decomp_last_rem = decomp_last->size - decomp_last->head;
+		decomp_len += decomp_last_rem;
+	}
+
+	mmap_len = sizeof(struct decomp) + decomp_len;
+	decomp = mmap(NULL, mmap_len, PROT_READ|PROT_WRITE,
+		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (decomp == MAP_FAILED) {
+		pr_err("Couldn't allocate memory for decompression\n");
+		return -1;
+	}
+
+	decomp->file_pos = file_offset;
+	decomp->file_path = file_path;
+	decomp->mmap_len = mmap_len;
+	decomp->head = 0;
+
+	if (decomp_last_rem) {
+		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
+		decomp->size = decomp_last_rem;
+	}
+
+	src = (void *)event + sizeof(struct perf_record_compressed);
+	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
+
+	decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
+				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
+	if (!decomp_size) {
+		munmap(decomp, mmap_len);
+		pr_err("Couldn't decompress data\n");
+		return -1;
+	}
+
+	decomp->size += decomp_size;
+
+	if (session->active_decomp->decomp == NULL)
+		session->active_decomp->decomp = decomp;
+	else
+		session->active_decomp->decomp_last->next = decomp;
+
+	session->active_decomp->decomp_last = decomp;
+
+	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
+
+	return 0;
+}
+#endif
+
+static int process_event_synth_tracing_data_stub(struct perf_session *session
+						 __maybe_unused,
+						 union perf_event *event
+						 __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_event_synth_attr_stub(const struct perf_tool *tool __maybe_unused,
+					 union perf_event *event __maybe_unused,
+					 struct evlist **pevlist
+					 __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_event_synth_event_update_stub(const struct perf_tool *tool __maybe_unused,
+						 union perf_event *event __maybe_unused,
+						 struct evlist **pevlist
+						 __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_event_update(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
+				     union perf_event *event __maybe_unused,
+				     struct perf_sample *sample __maybe_unused,
+				     struct evsel *evsel __maybe_unused,
+				     struct machine *machine __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_event_stub(const struct perf_tool *tool __maybe_unused,
+			      union perf_event *event __maybe_unused,
+			      struct perf_sample *sample __maybe_unused,
+			      struct machine *machine __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_finished_round_stub(const struct perf_tool *tool __maybe_unused,
+				       union perf_event *event __maybe_unused,
+				       struct ordered_events *oe __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int skipn(int fd, off_t n)
+{
+	char buf[4096];
+	ssize_t ret;
+
+	while (n > 0) {
+		ret = read(fd, buf, min(n, (off_t)sizeof(buf)));
+		if (ret <= 0)
+			return ret;
+		n -= ret;
+	}
+
+	return 0;
+}
+
+static s64 process_event_auxtrace_stub(struct perf_session *session __maybe_unused,
+				       union perf_event *event)
+{
+	dump_printf(": unhandled!\n");
+	if (perf_data__is_pipe(session->data))
+		skipn(perf_data__fd(session->data), event->auxtrace.size);
+	return event->auxtrace.size;
+}
+
+static int process_event_op2_stub(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+
+static
+int process_event_thread_map_stub(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_thread_map(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static
+int process_event_cpu_map_stub(struct perf_session *session __maybe_unused,
+			       union perf_event *event __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_cpu_map(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static
+int process_event_stat_config_stub(struct perf_session *session __maybe_unused,
+				   union perf_event *event __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_stat_config(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_stat_stub(struct perf_session *perf_session __maybe_unused,
+			     union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_stat(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_stat_round_stub(struct perf_session *perf_session __maybe_unused,
+				   union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_stat_round(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_event_time_conv_stub(struct perf_session *perf_session __maybe_unused,
+					union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_time_conv(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
+						       union perf_event *event __maybe_unused,
+						       u64 file_offset __maybe_unused,
+						       const char *file_path __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+void perf_tool__fill_defaults(struct perf_tool *tool)
+{
+	if (tool->sample == NULL)
+		tool->sample = process_event_sample_stub;
+	if (tool->mmap == NULL)
+		tool->mmap = process_event_stub;
+	if (tool->mmap2 == NULL)
+		tool->mmap2 = process_event_stub;
+	if (tool->comm == NULL)
+		tool->comm = process_event_stub;
+	if (tool->namespaces == NULL)
+		tool->namespaces = process_event_stub;
+	if (tool->cgroup == NULL)
+		tool->cgroup = process_event_stub;
+	if (tool->fork == NULL)
+		tool->fork = process_event_stub;
+	if (tool->exit == NULL)
+		tool->exit = process_event_stub;
+	if (tool->lost == NULL)
+		tool->lost = perf_event__process_lost;
+	if (tool->lost_samples == NULL)
+		tool->lost_samples = perf_event__process_lost_samples;
+	if (tool->aux == NULL)
+		tool->aux = perf_event__process_aux;
+	if (tool->itrace_start == NULL)
+		tool->itrace_start = perf_event__process_itrace_start;
+	if (tool->context_switch == NULL)
+		tool->context_switch = perf_event__process_switch;
+	if (tool->ksymbol == NULL)
+		tool->ksymbol = perf_event__process_ksymbol;
+	if (tool->bpf == NULL)
+		tool->bpf = perf_event__process_bpf;
+	if (tool->text_poke == NULL)
+		tool->text_poke = perf_event__process_text_poke;
+	if (tool->aux_output_hw_id == NULL)
+		tool->aux_output_hw_id = perf_event__process_aux_output_hw_id;
+	if (tool->read == NULL)
+		tool->read = process_event_sample_stub;
+	if (tool->throttle == NULL)
+		tool->throttle = process_event_stub;
+	if (tool->unthrottle == NULL)
+		tool->unthrottle = process_event_stub;
+	if (tool->attr == NULL)
+		tool->attr = process_event_synth_attr_stub;
+	if (tool->event_update == NULL)
+		tool->event_update = process_event_synth_event_update_stub;
+	if (tool->tracing_data == NULL)
+		tool->tracing_data = process_event_synth_tracing_data_stub;
+	if (tool->build_id == NULL)
+		tool->build_id = process_event_op2_stub;
+	if (tool->finished_round == NULL) {
+		if (tool->ordered_events)
+			tool->finished_round = perf_event__process_finished_round;
+		else
+			tool->finished_round = process_finished_round_stub;
+	}
+	if (tool->id_index == NULL)
+		tool->id_index = process_event_op2_stub;
+	if (tool->auxtrace_info == NULL)
+		tool->auxtrace_info = process_event_op2_stub;
+	if (tool->auxtrace == NULL)
+		tool->auxtrace = process_event_auxtrace_stub;
+	if (tool->auxtrace_error == NULL)
+		tool->auxtrace_error = process_event_op2_stub;
+	if (tool->thread_map == NULL)
+		tool->thread_map = process_event_thread_map_stub;
+	if (tool->cpu_map == NULL)
+		tool->cpu_map = process_event_cpu_map_stub;
+	if (tool->stat_config == NULL)
+		tool->stat_config = process_event_stat_config_stub;
+	if (tool->stat == NULL)
+		tool->stat = process_stat_stub;
+	if (tool->stat_round == NULL)
+		tool->stat_round = process_stat_round_stub;
+	if (tool->time_conv == NULL)
+		tool->time_conv = process_event_time_conv_stub;
+	if (tool->feature == NULL)
+		tool->feature = process_event_op2_stub;
+	if (tool->compressed == NULL) {
+#ifdef HAVE_ZSTD_SUPPORT
+		tool->compressed = perf_session__process_compressed_event;
+#else
+		tool->compressed = perf_session__process_compressed_event_stub;
+#endif
+	}
+	if (tool->finished_init == NULL)
+		tool->finished_init = process_event_op2_stub;
+}
+
+bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
+{
+	return tool->compressed == perf_session__process_compressed_event_stub;
+}
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index b192d44fe91f..7913b698033a 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -88,4 +88,8 @@ struct perf_tool {
 	enum show_feature_header show_feat_hdr;
 };
 
+void perf_tool__fill_defaults(struct perf_tool *tool);
+
+bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
+
 #endif /* __PERF_TOOL_H */
-- 
2.45.2.993.g49e7a77208-goog


