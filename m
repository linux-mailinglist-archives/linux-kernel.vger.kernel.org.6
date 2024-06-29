Return-Path: <linux-kernel+bounces-234806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 184BE91CB15
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34391F232E5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5691E6F2E4;
	Sat, 29 Jun 2024 04:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5EldRgx"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19659162
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636879; cv=none; b=mX+kaxwEL5s1hCSLZ925mx70/0srS74fm8dIOOxnvOdhQu9KbRE8lXzzF1CDCLyep+RYhJM7oIaFcS+UlcpxMjuo7ohA+5/AYTdqaaoEhj0KgMJNqzTV7XTlyvsB/JgXzo8Zenvd4SX42RQtUqQAxYQqKQ5Ba8/rNyS0ZkEjjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636879; c=relaxed/simple;
	bh=+J9KeKqtV2XPUvsLrg++AjGhKh46jtE6y8z6U+SXFbs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MhYLpEHw4M5vQWWstsPzBHy0nYzXfYiZT7FwWfe4EiYfytWx7hp1bQdK8b/0iQUSD4IeT+VxdZ8+Nu3kzkhiljYQK8qLmV0KzQuUxywJVlKFFTNVbwx702W184OQe1M0ptXslvQD/69izNb9qiGcoegJYEi+6AuhGaW7g9lD0Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5EldRgx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-643acc141cbso14178577b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636877; x=1720241677; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0qUI05DiVrsf9AQoaH9ZN9+rApwsKt6AnCoI2o0Nog=;
        b=k5EldRgxrK2D2i1utB0OMQCpneN/kVLXXLgMvv6R0vRXrUr9BgfpFGCXLwhHY2JEwv
         xj515WYGvbOX0fT53zx1czz7XaZC+f0bG0J+u9BuV4EQ3gE92ULCvlFId56DXmO7bg+0
         3f9W227tSLFAZ10mhR0knHUnfWaPWWRr0r3TsF5AhQkcLF5sr7Y/O+lpQTd+EP7ExCWm
         Fonr/+2csO5mCZPTDr0CU+DpKzBvMxid4XBYomQZYasm6TL2A10ndpFVgv8eLEy1r1vv
         LKm4Ilx/P0/CSfBN4RMPf/5bin91vXKzH3fbzwlljksYgsL7UNtA8Ssq78nQ81bueozZ
         eNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636877; x=1720241677;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0qUI05DiVrsf9AQoaH9ZN9+rApwsKt6AnCoI2o0Nog=;
        b=PYX+4Of1RxEAyUfy6dNFxuJHGKncYMrhIWsNylm1MBf2CnJQUfKMfFGzgoe02GZRv1
         bLannhwjE7vXJHZRltHlJ/0zyLoFj6jy/ZUb++vK7etGqTuAL8TmOn7OAGupAbzBEMkX
         a9FmfEQn7NK3y5PKXk4qXWgz+iEOU1x1D/QiyPpSrVElHpL1jTU7Tgp8hu/tUy/DzRsw
         c8d2HH8tjS9C5O4THhPpe+FXE1BlECy+j1rRLhLc/LkqT/XpYnpU1nX7M5Vq6Sk3uPfh
         x7LP8F6zTucssvpSBeCTDThvxKYLC1zoOUVoFkf2Y6/WHcIQMkoRQEOwBbCX+9VVbiju
         k6+A==
X-Forwarded-Encrypted: i=1; AJvYcCWkahq6QPXn531MMsKEvxJd5pfU7E0EAwTaPAqATtEyODM+GlpuTc9p3jjKP+dIFpsPhCQTQByzOX+PcSTGCiwEh38JGjzcUEy7AJUg
X-Gm-Message-State: AOJu0YzC9LjFvdV7ZfWFkcKGU/4k7qmzkW2iqorPypTIaxHjfVUKVIJD
	tYY66hXYejiTpF4sRMF4r8ej5IfikRVzm2NyHfIRZ3iiUDOM8aQ+eWPN78W6khcAPuwEu/ayI8k
	ScWvUOw==
X-Google-Smtp-Source: AGHT+IF/g2y2CFTuVjyjJKWPg4736Q64H5sousGzfXa3I3niK2LPyw7/hWkFTWLh+pq/bXwvqFAwkFMX62vr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a81:8451:0:b0:627:edcb:cbe2 with SMTP id
 00721157ae682-64af5dfeb07mr303857b3.5.1719636877125; Fri, 28 Jun 2024
 21:54:37 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:35 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 13/28] perf c2c: Use perf_tool__init
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
 tools/perf/builtin-c2c.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 88c131d05186..cd2bd573bfc3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -385,24 +385,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	goto out;
 }
 
-static struct perf_c2c c2c = {
-	.tool = {
-		.sample		= process_sample_event,
-		.mmap		= perf_event__process_mmap,
-		.mmap2		= perf_event__process_mmap2,
-		.comm		= perf_event__process_comm,
-		.exit		= perf_event__process_exit,
-		.fork		= perf_event__process_fork,
-		.lost		= perf_event__process_lost,
-		.attr		= perf_event__process_attr,
-		.auxtrace_info  = perf_event__process_auxtrace_info,
-		.auxtrace       = perf_event__process_auxtrace,
-		.auxtrace_error = perf_event__process_auxtrace_error,
-		.ordered_events	= true,
-		.ordering_requires_timestamps = true,
-	},
-};
-
 static const char * const c2c_usage[] = {
 	"perf c2c {record|report}",
 	NULL
@@ -3070,6 +3052,19 @@ static int perf_c2c__report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
+	perf_tool__init(&c2c.tool, /*ordered_events=*/true);
+	c2c.tool.sample		= process_sample_event;
+	c2c.tool.mmap		= perf_event__process_mmap;
+	c2c.tool.mmap2		= perf_event__process_mmap2;
+	c2c.tool.comm		= perf_event__process_comm;
+	c2c.tool.exit		= perf_event__process_exit;
+	c2c.tool.fork		= perf_event__process_fork;
+	c2c.tool.lost		= perf_event__process_lost;
+	c2c.tool.attr		= perf_event__process_attr;
+	c2c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c2c.tool.auxtrace       = perf_event__process_auxtrace;
+	c2c.tool.auxtrace_error = perf_event__process_auxtrace_error;
+	c2c.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &c2c.tool);
 	if (IS_ERR(session)) {
 		err = PTR_ERR(session);
-- 
2.45.2.803.g4e1b14247a-goog


