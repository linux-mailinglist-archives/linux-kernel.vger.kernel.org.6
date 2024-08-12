Return-Path: <linux-kernel+bounces-283757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8994F874
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2B21F20C28
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F2319CD17;
	Mon, 12 Aug 2024 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbmqWTt5"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707A19B5A3
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495690; cv=none; b=t3Yg9yVhUFuV8gkEV+i3q38fX/8YHKXMcvl9Gj18wev7Gl3gn2GCvBBv3/KsPIXdOoEc5Nkk9wfvH0qCln7MR0jwbqvINVpCBKrfRYG430Bmg3HKscOGMbY775kCR+F6W6l+TteoIA1d6dHr39/hO0f82VzTmTn1I4tLpTOE+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495690; c=relaxed/simple;
	bh=uMeETZnKr9ceLX3mZKKN/OlGgP2NNBbj5KRHpf1r41o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EKrvgTDMcCVXHNz1jqUk/V4Fl5gze9VI/oxYBE++4wNpZ+MTlj7eOfjtwNQGz/Ukd/RLFfQyMHE2bvMGCk6T/R/mj3o/LblU0GOLECG9/oT9miT4ONeTGA0tDoAmmwClFUXtaR/MXedji+IoltRQxNV3gecLx9q/on+AIKozMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbmqWTt5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0e4cd64909so8234040276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495688; x=1724100488; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0Iqy/44loZSDwT/r8c2v4LhcCsuhaAB0dsDAg6CBI4=;
        b=VbmqWTt5zTGiat2HfBahE5++U7gJ2sCMfji52TxClUwn9g3dKDc4bnw2lWNWXEE0Pn
         /zMcnxcHmxhnhD3N2abo2LPBYlmMqgT41MnnAbJtIdgyyc/cmRjhMwIaLSsgoLlXEgSF
         UJitS9oTNvlSzh1t6lbiyfrXwAqmi2PAI+nr4Co66QvyMRphoJ6NfxY8W9QeEO4I3lPV
         ibfhdp+TjGZ7vj7yDNOxF7S2tUUEPLB9lZx9tOMytvaEyl2s7l3zqO8w0nkNqi2Vf9k+
         s6SAWtvRzIuU4rMsBoEV1o5Z1oj9cbnNu8pw0LMdrC5covuWZL4sG8yd/oVGKGei/1EA
         Cblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495688; x=1724100488;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0Iqy/44loZSDwT/r8c2v4LhcCsuhaAB0dsDAg6CBI4=;
        b=viTiuGZPJ2TKA4Wv1utRInobh0s+7qvPiBDQBhSWxNrJcS7zoydx9vHlI+PyFYKwZp
         pCnKJIP0DQFZ0DHRusbgr8DHfLPMc8cgNqfxgE2xg6aon4zDFA1XDG7qjH/DX6d6KB+J
         jO/avihVw8nbE/893VkA6qghnMrx+zYF2yk8E/j1GWy5mCiB5SWyjjwJJ1eQ/ATpFzgP
         2dls40JKM2Mx85OHK6tBhkL8ZnaZ7odL1f1AeB5wI+sYw3f9UV4s7GpD73gHv1GaQ4i6
         piRh+Kx7Zg/IkVNKHW335R9aN4N0KWnNF0xJwacoAkditH70JjsEVfS9HEAP25V3JMse
         2HSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvKIVON9jlFgcZQi9cAgK9nGmY91HhzOnMHs/JGMKjVwu/4zFkPtWKdp0XZNUFbgNkeofxdESF6WsxxzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+fVipa/YFkB6kZ7oSJ39PPqVagwjxbkTX3jyDRGOfuwpxUQa
	/1/WDMjbOvKIoAKtn4WNow/V6rvKj/23LgDDyJhE/8xjsz8v035myRiyGD8ThYs3+D5r8z3h36Y
	ph9uoYA==
X-Google-Smtp-Source: AGHT+IG/7kJRP8j4jNVxK+WTTnpF6wR6SbG8no+zediDqWUX8ohQa7y85641LKDUVIohBUMZwU7EgY1/qeBy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:3002:0:b0:e05:6e45:84b6 with SMTP id
 3f1490d57ef6-e113d176384mr2038276.8.1723495688336; Mon, 12 Aug 2024 13:48:08
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:11 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 19/27] perf mem: Use perf_tool__init
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
 tools/perf/builtin-mem.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 0fb4d75ab959..18e5f9a0ddc2 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -276,7 +276,23 @@ static int report_raw_events(struct perf_mem *mem)
 		.force = mem->force,
 	};
 	int ret;
-	struct perf_session *session = perf_session__new(&data, &mem->tool);
+	struct perf_session *session;
+
+	perf_tool__init(&mem->tool, /*ordered_events=*/true);
+	mem->tool.sample		= process_sample_event;
+	mem->tool.mmap		= perf_event__process_mmap;
+	mem->tool.mmap2		= perf_event__process_mmap2;
+	mem->tool.comm		= perf_event__process_comm;
+	mem->tool.lost		= perf_event__process_lost;
+	mem->tool.fork		= perf_event__process_fork;
+	mem->tool.attr		= perf_event__process_attr;
+	mem->tool.build_id	= perf_event__process_build_id;
+	mem->tool.namespaces	= perf_event__process_namespaces;
+	mem->tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	mem->tool.auxtrace       = perf_event__process_auxtrace;
+	mem->tool.auxtrace_error = perf_event__process_auxtrace_error;
+
+	session = perf_session__new(&data, &mem->tool);
 
 	if (IS_ERR(session))
 		return PTR_ERR(session);
@@ -458,21 +474,6 @@ int cmd_mem(int argc, const char **argv)
 {
 	struct stat st;
 	struct perf_mem mem = {
-		.tool = {
-			.sample		= process_sample_event,
-			.mmap		= perf_event__process_mmap,
-			.mmap2		= perf_event__process_mmap2,
-			.comm		= perf_event__process_comm,
-			.lost		= perf_event__process_lost,
-			.fork		= perf_event__process_fork,
-			.attr		= perf_event__process_attr,
-			.build_id	= perf_event__process_build_id,
-			.namespaces	= perf_event__process_namespaces,
-			.auxtrace_info  = perf_event__process_auxtrace_info,
-			.auxtrace       = perf_event__process_auxtrace,
-			.auxtrace_error = perf_event__process_auxtrace_error,
-			.ordered_events	= true,
-		},
 		.input_name		 = "perf.data",
 		/*
 		 * default to both load an store sampling
-- 
2.46.0.76.ge559c4bf1a-goog


