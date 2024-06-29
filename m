Return-Path: <linux-kernel+bounces-234808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48291CB17
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C561C225E0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265C7691F;
	Sat, 29 Jun 2024 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hMAs4NG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4474E3D
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636884; cv=none; b=Bb7Q4iY/LDxe56w/Un5gjcWFX0CJrpxfdbpkS7rPBwmxunI79SEczIh/Rc4BK2fAtf3dbnCjczzfuOLBBG+AwqgGBcNngNsaAk4PDTPiyjKgq4Es8Hj4H0V1biEJ+5RdnSGBR5mVOCoKp994Lif4zdiVzKrgPTcIKF30qFIbPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636884; c=relaxed/simple;
	bh=ca+HULxiF5vB7VQT1dmpEIkO4ASjXSEGBqBgRy3Ekbs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GQVUSiAP1Hh2CKD5ufXVsXJKOEkYwpTD4E97dn+9K2ErFy04fBJcX8PaDnnoJMO+7ideefQvVta0HmwHd0KkyBE95e6UgeKchcrC2VvZlgo/HJeHV7+BR4/KgI59PYO7gPAOtCndSnjDZCFW9W1EgyaD6q7yMyh9B4qAPPkZQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hMAs4NG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso2232375276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636881; x=1720241681; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pl47ShAyi3UwZLaY95Gdqr35v3cT/0CCN4n04OcghVg=;
        b=3hMAs4NGDnspTtDnuCVmWXm30OmX+TI6uJtaCQ19cbf8PyKrABbNKhTU3oVEimmAUm
         /t538lXR7RY4wFo5clvDE76sHgqcMS5b1azdbj+aTeLkZI13rWPXT2puq04aUML4T5zq
         QlboivbEUT2qE9U2O9dFqMMS2yXNoch8tJ4Mytok1aiixuz4eFzfaeNKzK7DTVFKens+
         Qu7D1UQ0IbxWfSct5OU+/aeooYOsmRpmVGSl4CVHD+wRaDHXINf/AbNhMT+koiKe01Q+
         QowbcTZwnArArXcYx2YWusLjciWvXcZa/FBEB5FUmwrMQSgsOOpXZyEIXcK8UnDf2gRD
         NCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636881; x=1720241681;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl47ShAyi3UwZLaY95Gdqr35v3cT/0CCN4n04OcghVg=;
        b=XPy8BO44LRMLIe/orRtdW1DXsLjeKJ1hsCKOi7hyJ/B6zy8+I3Jg/XNPED5bcTzVyy
         YlUl9nGv3LFtDRnNk2czyaOBfG+iIofWhFENXkMnqvlVWpF74OyHyD4jP/zx9Djl3djq
         7QMUqVB6a7U0HwmgtaC5t8rm0HGO5jHx3ZEwQXRnewvsIT6/NLGmqLNRwzON0RK8vysE
         al4tC+ONtdIKSJ3VFxHa1INno5rxC7zKmWX9cBf71cvYNwRe5q6Dmppyeuwq88HbKuT5
         BoI+KaWTrO/EFMTFKHHS5+hxatMN2JqYi42ngzG0n7q2qe+LZXqAyN/eptc31mPQ8ZxV
         hO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+sN1SeBHJr79ZVa3kDhK49ZaPMsZ+f96T4m8YSV8lY2hTNVF0cYlHddnBnNusEexHgGkW9Q2eCyoMKVjuN4laxGi+NS24IY/dhV3K
X-Gm-Message-State: AOJu0YwfqRkX025rl9XHRPHVxKieDY6vquocvv52zdOXSZ7sgUyVWNLH
	Cj8bx+mX3xv0TBCGSmUohO92EHp0IW/DI/7Tcm5YcEee1UHfSK1jImGqkJBT5i0e6UgO3QozkC5
	MaiI7aQ==
X-Google-Smtp-Source: AGHT+IHUSHzhHT95HvJspWwoNtad+/Y39YtVY3w1Kv6aTvtwrcnux5QeomCYcV5ciUCF98rKk/ztWmncL1Gg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1009:b0:df4:d6ca:fed0 with SMTP
 id 3f1490d57ef6-e036eaf6cbemr523276.4.1719636881634; Fri, 28 Jun 2024
 21:54:41 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:37 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 15/28] perf inject: Use perf_tool__init
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
 tools/perf/builtin-inject.c | 89 +++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index be74e2bf1f00..2866756d5060 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2165,46 +2165,6 @@ static int __cmd_inject(struct perf_inject *inject)
 int cmd_inject(int argc, const char **argv)
 {
 	struct perf_inject inject = {
-		.tool = {
-			.sample		= perf_event__repipe_sample,
-			.read		= perf_event__repipe_sample,
-			.mmap		= perf_event__repipe,
-			.mmap2		= perf_event__repipe,
-			.comm		= perf_event__repipe,
-			.namespaces	= perf_event__repipe,
-			.cgroup		= perf_event__repipe,
-			.fork		= perf_event__repipe,
-			.exit		= perf_event__repipe,
-			.lost		= perf_event__repipe,
-			.lost_samples	= perf_event__repipe,
-			.aux		= perf_event__repipe,
-			.itrace_start	= perf_event__repipe,
-			.aux_output_hw_id = perf_event__repipe,
-			.context_switch	= perf_event__repipe,
-			.throttle	= perf_event__repipe,
-			.unthrottle	= perf_event__repipe,
-			.ksymbol	= perf_event__repipe,
-			.bpf		= perf_event__repipe,
-			.text_poke	= perf_event__repipe,
-			.attr		= perf_event__repipe_attr,
-			.event_update	= perf_event__repipe_event_update,
-			.tracing_data	= perf_event__repipe_op2_synth,
-			.finished_round	= perf_event__repipe_oe_synth,
-			.build_id	= perf_event__repipe_op2_synth,
-			.id_index	= perf_event__repipe_op2_synth,
-			.auxtrace_info	= perf_event__repipe_op2_synth,
-			.auxtrace_error	= perf_event__repipe_op2_synth,
-			.time_conv	= perf_event__repipe_op2_synth,
-			.thread_map	= perf_event__repipe_op2_synth,
-			.cpu_map	= perf_event__repipe_op2_synth,
-			.stat_config	= perf_event__repipe_op2_synth,
-			.stat		= perf_event__repipe_op2_synth,
-			.stat_round	= perf_event__repipe_op2_synth,
-			.feature	= perf_event__repipe_op2_synth,
-			.finished_init	= perf_event__repipe_op2_synth,
-			.compressed	= perf_event__repipe_op4_synth,
-			.auxtrace	= perf_event__repipe_auxtrace,
-		},
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
 		.output = {
@@ -2269,6 +2229,7 @@ int cmd_inject(int argc, const char **argv)
 		"perf inject [<options>]",
 		NULL
 	};
+	bool ordered_events;
 
 	if (!inject.itrace_synth_opts.set) {
 		/* Disable eager loading of kernel symbols that adds overhead to perf inject. */
@@ -2333,7 +2294,47 @@ int cmd_inject(int argc, const char **argv)
 		if (strcmp(inject.input_name, "-"))
 			repipe = false;
 	}
-
+	ordered_events = inject.jit_mode || inject.sched_stat ||
+		(inject.build_ids && !inject.build_id_all);
+	perf_tool__init(&inject.tool, ordered_events);
+	inject.tool.sample		= perf_event__repipe_sample;
+	inject.tool.read		= perf_event__repipe_sample;
+	inject.tool.mmap		= perf_event__repipe;
+	inject.tool.mmap2		= perf_event__repipe;
+	inject.tool.comm		= perf_event__repipe;
+	inject.tool.namespaces		= perf_event__repipe;
+	inject.tool.cgroup		= perf_event__repipe;
+	inject.tool.fork		= perf_event__repipe;
+	inject.tool.exit		= perf_event__repipe;
+	inject.tool.lost		= perf_event__repipe;
+	inject.tool.lost_samples	= perf_event__repipe;
+	inject.tool.aux			= perf_event__repipe;
+	inject.tool.itrace_start	= perf_event__repipe;
+	inject.tool.aux_output_hw_id	= perf_event__repipe;
+	inject.tool.context_switch	= perf_event__repipe;
+	inject.tool.throttle		= perf_event__repipe;
+	inject.tool.unthrottle		= perf_event__repipe;
+	inject.tool.ksymbol		= perf_event__repipe;
+	inject.tool.bpf			= perf_event__repipe;
+	inject.tool.text_poke		= perf_event__repipe;
+	inject.tool.attr		= perf_event__repipe_attr;
+	inject.tool.event_update	= perf_event__repipe_event_update;
+	inject.tool.tracing_data	= perf_event__repipe_op2_synth;
+	inject.tool.finished_round	= perf_event__repipe_oe_synth;
+	inject.tool.build_id		= perf_event__repipe_op2_synth;
+	inject.tool.id_index		= perf_event__repipe_op2_synth;
+	inject.tool.auxtrace_info	= perf_event__repipe_op2_synth;
+	inject.tool.auxtrace_error	= perf_event__repipe_op2_synth;
+	inject.tool.time_conv		= perf_event__repipe_op2_synth;
+	inject.tool.thread_map		= perf_event__repipe_op2_synth;
+	inject.tool.cpu_map		= perf_event__repipe_op2_synth;
+	inject.tool.stat_config		= perf_event__repipe_op2_synth;
+	inject.tool.stat		= perf_event__repipe_op2_synth;
+	inject.tool.stat_round		= perf_event__repipe_op2_synth;
+	inject.tool.feature		= perf_event__repipe_op2_synth;
+	inject.tool.finished_init	= perf_event__repipe_op2_synth;
+	inject.tool.compressed		= perf_event__repipe_op4_synth;
+	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
 	inject.session = __perf_session__new(&data, repipe,
 					     output_fd(&inject),
 					     &inject.tool);
@@ -2372,7 +2373,6 @@ int cmd_inject(int argc, const char **argv)
 		 * mmaps. We cannot generate the buildid hit list and
 		 * inject the jit mmaps at the same time for now.
 		 */
-		inject.tool.ordered_events = true;
 		inject.tool.ordering_requires_timestamps = true;
 		if (known_build_ids != NULL) {
 			inject.known_build_ids =
@@ -2385,15 +2385,10 @@ int cmd_inject(int argc, const char **argv)
 		}
 	}
 
-	if (inject.sched_stat) {
-		inject.tool.ordered_events = true;
-	}
-
 #ifdef HAVE_JITDUMP
 	if (inject.jit_mode) {
 		inject.tool.mmap2	   = perf_event__jit_repipe_mmap2;
 		inject.tool.mmap	   = perf_event__jit_repipe_mmap;
-		inject.tool.ordered_events = true;
 		inject.tool.ordering_requires_timestamps = true;
 		/*
 		 * JIT MMAP injection injects all MMAP events in one go, so it
-- 
2.45.2.803.g4e1b14247a-goog


