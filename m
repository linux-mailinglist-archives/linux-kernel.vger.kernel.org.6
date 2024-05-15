Return-Path: <linux-kernel+bounces-180319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB7E8C6CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2398E2848CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5615B0F3;
	Wed, 15 May 2024 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+HFtJ5/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891D159598
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801790; cv=none; b=MoHNkhwU+7PP7kKuHlTKPvVGLfdC33Rqfo6ATrmDNawyuhpQ25uHf6A0WHwTs1vA5sqixHugvEAMrNbA691mA+uE0114IhcQ+tpATheZSAnhXu/K/QpKxgYJHgG+AUBR9GfMbWTRNwJ4rs1uDBvlFH33HNSrlffwJP9oYRBDAEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801790; c=relaxed/simple;
	bh=EbuXkutu4SiTY7XkcXY+EZ/i0vH1OfoP6NR93JYJ3KY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kBKFV2fG1MA/B3YzhH2x8SmQCDX1bYrpbZ+BhpG6klWr9FtqcuY+0Lt+0nm/peXy1RB0wTS/ZsZjUpBklzl+imW/r2+cyAvNNZHMEx/WU3M7C2fA+9RRXAhTISRp0c/kEUKrKPsUnnq63qu9/2fqmo0fpBDOK+y3TVlANF1cdsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+HFtJ5/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6204c4f4240so113864347b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715801787; x=1716406587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fXwOZAIdSfp5mZkveOIuW8YalkQhwYauV3LK0Wa4qgM=;
        b=z+HFtJ5/XGGXdtid/MQl/UdDr6JOHrSR9A+ToALPSWn4D6mnCl1MYla4zQUU40FMrI
         O03ScbCMr7AQw5JLRTqErY5UrSnOuP++PZWlGWxrVkohJpx+PDRtQLOPCE8Rj9YZbjel
         gvfRzyfReeyJRtxutoS0vi8bSv1pQgcTELVltJvvVn3gVtP8C+Xpl4h5sEjfovLv6Q25
         cjVKYTYODcRrym+oesy9DevKgaf60jQyjASSXdRbQ4w991H6mp7rKurzSv7RIDY6Tey5
         EOQA6HNFrPfuPSolnGNFQ3ImUiXU2dQ/W9gOoiZuXawubeyQeEJkeKf+JYMjKE6npfZX
         Pbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801787; x=1716406587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXwOZAIdSfp5mZkveOIuW8YalkQhwYauV3LK0Wa4qgM=;
        b=PHGUBAiZUQU3edS/Gbkc09wV/PeYzOTa4jdIzql9bCqLJiGp/LjS3OUmJPCK308l3X
         VIC8+LMfAO4CT6675WWU6eqPcGtWXHCD0O4EphEMSWJef84YPz9jXSdW3EauWzebraw8
         9PLLLUJchXgXRcCfAeL0bmCmgvaK68I4djipo5O17CU5a4o2DaJE/0mLH2I0qW7Zy8pr
         mSFB5+136/1taCerycCNE0vQZ2ZR5bOlZ7P8Kw+dxuT4RFIscZjs+d8fvUzTktMikXDf
         sfmfj8HMKwvh75erkZ28YKfPMinXf3u8xbS4jncEJczEs7zEIHrW+KxHJeJ6NCJae1Qi
         Yaqw==
X-Forwarded-Encrypted: i=1; AJvYcCWElaHZnUPA41MB8jLWNvkVPfmhWnv9CXnj4IT26DyYSXtCxj6K6WjiJL9fFoOldF4FdUFGVKj/5H9G5VPuXl1GdZ8YJQn8bKhw1riI
X-Gm-Message-State: AOJu0Yzy66E+5gB1W5ElSVVb2hPX6oILz/zpFZXE/dEeSgQi8IoHHMuG
	bmxTcR0Rbp3D9rVCVbj7qe5kvMkYEXYmxwW11jJ/NUD/x2W1G9qrnge1dMjuc7S0JoyXr7peBGu
	m
X-Google-Smtp-Source: AGHT+IGzo1N8KtCx5N6jvWrTB8oDA5Ct6uYEeZeEijzfl2sTvDtmFEz2XqRAbCQe/iFUSRDGRG0s2JUqckM=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:6e4e:954d:1e49:f87c])
 (user=yabinc job=sendgmr) by 2002:a81:6d97:0:b0:627:3c45:4a90 with SMTP id
 00721157ae682-6273c454b1emr3280237b3.4.1715801787120; Wed, 15 May 2024
 12:36:27 -0700 (PDT)
Date: Wed, 15 May 2024 12:36:07 -0700
In-Reply-To: <20240515193610.2350456-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515193610.2350456-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515193610.2350456-2-yabinc@google.com>
Subject: [PATCH v5 1/3] perf/core: Save raw sample data conditionally based on
 sample type
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, space for raw sample data is always allocated within sample
records for both BPF output and tracepoint events. This leads to unused
space in sample records when raw sample data is not requested.

This patch enforces checking sample type of an event in
perf_sample_save_raw_data(). So raw sample data will only be saved if
explicitly requested, reducing overhead when it is not needed.

Fixes: 0a9081cf0a11 ("perf/core: Add perf_sample_save_raw_data() helper")
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 arch/s390/kernel/perf_cpum_cf.c    |  2 +-
 arch/s390/kernel/perf_pai_crypto.c |  2 +-
 arch/s390/kernel/perf_pai_ext.c    |  2 +-
 arch/x86/events/amd/ibs.c          |  2 +-
 include/linux/perf_event.h         |  6 +++++
 kernel/events/core.c               | 35 +++++++++++++++---------------
 kernel/trace/bpf_trace.c           | 11 +++++-----
 7 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 1434642e9cba..9bf9464109e9 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -971,7 +971,7 @@ static int cfdiag_push_sample(struct perf_event *event,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = cpuhw->usedss;
 		raw.frag.data = cpuhw->stop;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 4ad472d130a3..2fb8aeba4872 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -444,7 +444,7 @@ static int paicrypt_push_sample(size_t rawsize, struct paicrypt_map *cpump,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index a6da7e0cc7a6..b2914df2107a 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -458,7 +458,7 @@ static int paiext_push_sample(size_t rawsize, struct paiext_map *cpump,
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw.frag.size = rawsize;
 		raw.frag.data = cpump->save;
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e91970b01d62..c3a2f6f57770 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1118,7 +1118,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 				.data = ibs_data.data,
 			},
 		};
-		perf_sample_save_raw_data(&data, &raw);
+		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
 	if (perf_ibs == &perf_ibs_op)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a5304ae8c654..fefac1a57b56 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1243,12 +1243,18 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 }
 
 static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
+					     struct perf_event *event,
 					     struct perf_raw_record *raw)
 {
 	struct perf_raw_frag *frag = &raw->frag;
 	u32 sum = 0;
 	int size;
 
+	if (!(event->attr.sample_type & PERF_SAMPLE_RAW))
+		return;
+	if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_RAW))
+		return;
+
 	do {
 		sum += frag->size;
 		if (perf_raw_frag_last(frag))
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6b0a66ed2ae3..28e4e777e82a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10228,9 +10228,9 @@ static struct pmu perf_tracepoint = {
 };
 
 static int perf_tp_filter_match(struct perf_event *event,
-				struct perf_sample_data *data)
+				struct perf_raw_record *raw)
 {
-	void *record = data->raw->frag.data;
+	void *record = raw->frag.data;
 
 	/* only top level events have filters set */
 	if (event->parent)
@@ -10242,7 +10242,7 @@ static int perf_tp_filter_match(struct perf_event *event,
 }
 
 static int perf_tp_event_match(struct perf_event *event,
-				struct perf_sample_data *data,
+				struct perf_raw_record *raw,
 				struct pt_regs *regs)
 {
 	if (event->hw.state & PERF_HES_STOPPED)
@@ -10253,7 +10253,7 @@ static int perf_tp_event_match(struct perf_event *event,
 	if (event->attr.exclude_kernel && !user_mode(regs))
 		return 0;
 
-	if (!perf_tp_filter_match(event, data))
+	if (!perf_tp_filter_match(event, raw))
 		return 0;
 
 	return 1;
@@ -10279,6 +10279,7 @@ EXPORT_SYMBOL_GPL(perf_trace_run_bpf_submit);
 static void __perf_tp_event_target_task(u64 count, void *record,
 					struct pt_regs *regs,
 					struct perf_sample_data *data,
+					struct perf_raw_record *raw,
 					struct perf_event *event)
 {
 	struct trace_entry *entry = record;
@@ -10288,13 +10289,17 @@ static void __perf_tp_event_target_task(u64 count, void *record,
 	/* Cannot deliver synchronous signal to other task. */
 	if (event->attr.sigtrap)
 		return;
-	if (perf_tp_event_match(event, data, regs))
+	if (perf_tp_event_match(event, raw, regs)) {
+		perf_sample_data_init(data, 0, 0);
+		perf_sample_save_raw_data(data, event, raw);
 		perf_swevent_event(event, count, data, regs);
+	}
 }
 
 static void perf_tp_event_target_task(u64 count, void *record,
 				      struct pt_regs *regs,
 				      struct perf_sample_data *data,
+				      struct perf_raw_record *raw,
 				      struct perf_event_context *ctx)
 {
 	unsigned int cpu = smp_processor_id();
@@ -10302,15 +10307,15 @@ static void perf_tp_event_target_task(u64 count, void *record,
 	struct perf_event *event, *sibling;
 
 	perf_event_groups_for_cpu_pmu(event, &ctx->pinned_groups, cpu, pmu) {
-		__perf_tp_event_target_task(count, record, regs, data, event);
+		__perf_tp_event_target_task(count, record, regs, data, raw, event);
 		for_each_sibling_event(sibling, event)
-			__perf_tp_event_target_task(count, record, regs, data, sibling);
+			__perf_tp_event_target_task(count, record, regs, data, raw, sibling);
 	}
 
 	perf_event_groups_for_cpu_pmu(event, &ctx->flexible_groups, cpu, pmu) {
-		__perf_tp_event_target_task(count, record, regs, data, event);
+		__perf_tp_event_target_task(count, record, regs, data, raw, event);
 		for_each_sibling_event(sibling, event)
-			__perf_tp_event_target_task(count, record, regs, data, sibling);
+			__perf_tp_event_target_task(count, record, regs, data, raw, sibling);
 	}
 }
 
@@ -10328,15 +10333,10 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 		},
 	};
 
-	perf_sample_data_init(&data, 0, 0);
-	perf_sample_save_raw_data(&data, &raw);
-
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
-		if (perf_tp_event_match(event, &data, regs)) {
-			perf_swevent_event(event, count, &data, regs);
-
+		if (perf_tp_event_match(event, &raw, regs)) {
 			/*
 			 * Here use the same on-stack perf_sample_data,
 			 * some members in data are event-specific and
@@ -10346,7 +10346,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			 * because data->sample_flags is set.
 			 */
 			perf_sample_data_init(&data, 0, 0);
-			perf_sample_save_raw_data(&data, &raw);
+			perf_sample_save_raw_data(&data, event, &raw);
+			perf_swevent_event(event, count, &data, regs);
 		}
 	}
 
@@ -10363,7 +10364,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 			goto unlock;
 
 		raw_spin_lock(&ctx->lock);
-		perf_tp_event_target_task(count, record, regs, &data, ctx);
+		perf_tp_event_target_task(count, record, regs, &data, &raw, ctx);
 		raw_spin_unlock(&ctx->lock);
 unlock:
 		rcu_read_unlock();
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f5154c051d2c..a7ec7a3eb7e1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -620,7 +620,8 @@ static const struct bpf_func_proto bpf_perf_event_read_value_proto = {
 
 static __always_inline u64
 __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
-			u64 flags, struct perf_sample_data *sd)
+			u64 flags, struct perf_raw_record *raw,
+			struct perf_sample_data *sd)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	unsigned int cpu = smp_processor_id();
@@ -645,6 +646,8 @@ __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
 	if (unlikely(event->oncpu != cpu))
 		return -EOPNOTSUPP;
 
+	perf_sample_save_raw_data(sd, event, raw);
+
 	return perf_event_output(event, sd, regs);
 }
 
@@ -688,9 +691,8 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
 	}
 
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	err = __bpf_perf_event_output(regs, map, flags, sd);
+	err = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_trace_nest_level);
 	preempt_enable();
@@ -749,9 +751,8 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
 
 	perf_fetch_caller_regs(regs);
 	perf_sample_data_init(sd, 0, 0);
-	perf_sample_save_raw_data(sd, &raw);
 
-	ret = __bpf_perf_event_output(regs, map, flags, sd);
+	ret = __bpf_perf_event_output(regs, map, flags, &raw, sd);
 out:
 	this_cpu_dec(bpf_event_output_nest_level);
 	preempt_enable();
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


