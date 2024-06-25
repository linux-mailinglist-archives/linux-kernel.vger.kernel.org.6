Return-Path: <linux-kernel+bounces-229405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6C0916F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8C21F2187B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6364417F369;
	Tue, 25 Jun 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUsXmK/g"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE217E8E7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336410; cv=none; b=YyCZlEs2L9WWOA2pGH5wSn1lV10DCUHabvnAfCf9JaJfrEznQcvb1naAcVDG4b537DCBcWvnPMZvWkuacBIV3o8JHTvYAVHUozZKbRg7XYO9gOy4VoZYoyCKOaZx2WsRiZhFV9z2Dvmbix9AIwaym3qY5NaD6nL/XzlGpN9H02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336410; c=relaxed/simple;
	bh=NNpDhvLM21Dx7gpxRlWCOf8pWQqxyB122lzmpjrWI8Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eD/2lGagsD31yKLUaptad9IyUumG0ysp0V+cwiSDepalosJIPozPcfUESMSJTKM9mUMdbKLPxauKKQkaOz4Gg3n30avEe/6EM0K09ftbpPS94AarpMEKtC92OOfMpHSPsE7GC5ETFgVcIY5NTQgayoigZzAS+NOVw+cuKBJRD6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUsXmK/g; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-643f57e2f0fso72141047b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336408; x=1719941208; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FKqc617GU6y9EZBzym/gHkh1HBEMH2nzxihyAHq3eE=;
        b=FUsXmK/gfTKJLh9BaL/WoKmOvbB0+U/Mhr4wmsIpgTXyiTKByBbNOpoP1Bc8poTIjX
         D3DW0uUt/sK8xY7jwiYLwlfaYjBGzO6mmpVuGjjtwp3tAMMytwlFR2ioe7SYdqer+lnf
         xBarM/uNv/AKI0QO8vrLEiuyXYVLNbPt7SfRvR1708SBr5zJaWY44haMrNrsWINQk8nP
         eNi/fQqB2hcdQ/eqY7larPtH+jzvHuTzBBymihZXqZbgfXW2xfozDuR72aLjqAWsMKQl
         0wfNyJXfSi0KCYgCGQ2uoPGsj4eHoOV6KnehZXKsQGnstOK83FBzU7TzuhzX/7C+wf30
         UUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336408; x=1719941208;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FKqc617GU6y9EZBzym/gHkh1HBEMH2nzxihyAHq3eE=;
        b=PH+K6XcbJGKZoraU91PLSdEX/4mppCNlkW87plKyXh2g3DAqboO1ms203g4bOGDECn
         pV0Ai3LZ8n7la7D0x7lW3q1+IXcB+TLzluHBxCvCcs2ILfj0FjRZAvVd5E2VlKJ/z1IK
         ej/0DilItvsE4h5dJf6rxNRZcsmlCjfMdrAnEe45swp0ee900Ip6dpRcyE0Iyvdv8RmN
         8NRx0z51izsD+ZD47P6TIi+5h9/bhPQ20BMTXTsvw59I5Kd5HVJD+GApGYtEplpwfs+r
         EolOy/mEkHt0Ru663K08t8L3Y7fW8BzMu6eI+cDMB973U0CjCTQDjGobdmBqaA1EI/4o
         1JwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf9rFLo/58laHAwvdJCepXygJbkLnQoAJDTV1ep3LGliGiVuGGX71JOxUoJYWVAAQTEC8g32V2R/qUOSK2TYegYipCDBK6pE/Kad0m
X-Gm-Message-State: AOJu0Yzu/6xq+9PQg3LtZokd7uIJbaAnOVPKQV5zIowgAWvKcK16hAF6
	8IUT2J00vEw5nrQbz/GNPLvSpk5XR2nofUT5BvjKJS5dIFXgdVIClcnKyyfbQaSznCMxOCUuibc
	TcPCKuw==
X-Google-Smtp-Source: AGHT+IHvID5MqiYuIdDZtsB0PM+VSxrqQRo84zi8LvlxFkQG16oOJVmUwBr7Nyqswk+S8IE/3vFBpBPetX8T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:6086:b0:62c:fa1a:21e7 with SMTP
 id 00721157ae682-643adb94892mr2966057b3.6.1719336408291; Tue, 25 Jun 2024
 10:26:48 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:54 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 17/26] perf mem: Use perf_tool__init
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

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-mem.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index c2038a32543c..c12ca0ec1237 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -285,7 +285,23 @@ static int report_raw_events(struct perf_mem *mem)
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
@@ -449,21 +465,6 @@ int cmd_mem(int argc, const char **argv)
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
2.45.2.741.gdbec12cfda-goog


