Return-Path: <linux-kernel+bounces-249661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A190D92EE46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8ACB22424
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF61179949;
	Thu, 11 Jul 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhzsTlIG"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2CC178397
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720859; cv=none; b=j2SuvQC1fv9CF3H8lGVALz6nmtRIDJJoRr5cqUiwp56edNXM8hdBRqo5HjziLZ+N0MMJW6xz57dFrUxl15Tm31IcdaZMUJTNQiJ3Qnd9oh4sjSh4vahnubXFt9zQsGM5+gvKaHGO5fqcPjw+1GmgjxegP3BzLL/cc8fysWyMeL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720859; c=relaxed/simple;
	bh=PQFAc94b+3E6J2xiJdbKRsuyLtZHAm+NZj3v+mP90Hc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MaheY1iyCdqjCEjgdRP132LM7EA4j2TxrmDzlpOqU8oIyQ9by62wE82D4I4phS1I8CPs+ZdspDD0MmHeDMH4yyIX+NUTzt/te0Wc46OP+lEggbymri7+eTjS5OUFf+/qlexJjSRF0qd8kggzyA0ZV3NFx6bZCb5gZ59rGk4Eq2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhzsTlIG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650f5b28822so20060277b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720857; x=1721325657; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dI8yaROyMxBgkl/C6HStDZ1DbB4Rpu7ZnQVumFggSVU=;
        b=YhzsTlIG4ABnF3bTg2LroNQPualviC4lcq/b373kK66v/F5DHwjQ5CwDliKgSKmf9q
         v3zBBJArimfiD/U6UCHtyOoKaBAw6uIPdN/zo1RiCOfChCjDKW0V4KClmqC9vkdRof+U
         3EBUOcILho5Ji6g7C6F49dmIqQDd0HlkHIrojhbBVd/H3kYll5Em4RMNbBjZKRJBy4Lt
         iW7SRb8GpuCVCbMxXwt2IMwC5O0fo9UVRW+IW+dyc3Z+pomVLbjpU4LcO635HxiodFn5
         Ras+foFVUtswXL/he5H0QqLVkGqcK51yvNAu2oZF3+oXj2Vdne9rIl1D/ycxEDk3OUSH
         zT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720857; x=1721325657;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dI8yaROyMxBgkl/C6HStDZ1DbB4Rpu7ZnQVumFggSVU=;
        b=nLSCy25GH+KjBopLL4bgN+uMhrsTvLA0BWwS8w5GPizJHzE49L7V+TT2WPX6XBohkX
         nHRe4Vwq51wPznNBolmD+cyT7Dl1sFMkcEPddWELftNP65dcU+vFpw33G9CXsNyYwP50
         i9IpfLP2ma9SmCW+u8P/mf+3/pF0d+eJBtAUdKyPAkmQHtOX3GkVAs9MZ0qp3NX8vjcU
         w7b2R5KjIcCbOYw4BZTOr1PmNW5gyjl+IQA0qKGm2yBhr3skpUI/Y5VdQ7oFepENbprC
         e70r+7zMrIHJk0Fpi0ElzFfV0JEIW64NJ9oP2EnC1jk7uw8VsgeaF5ODOMKnN6/0uUQb
         +bng==
X-Forwarded-Encrypted: i=1; AJvYcCXlEg1xmhfu2CVa3Hcx0kDdjvkRIhoWjNe/VcjU0HoNhinWTzIC5+xPjm5Wascl6IwVuiWFNoBap/MhRk475OyIi1635zB42g1pbPf6
X-Gm-Message-State: AOJu0YxHUx1SCljKNJvuSGGV8t5Uh0WqCxwmdCd+iEoRvZzCCyTWu4hV
	hMuFcubeDl2H4vJfAObA23vkzfLH5yTDB134Us3fPTW6DwLYgqfvo6yQmZIz61dSIsmW60bMqG+
	GM5criQ==
X-Google-Smtp-Source: AGHT+IGlvSq0w61dchsRb8EQOsbrRTrATl43/YP+LZQ7kANYJWmfCN5j/cK30JXClPJuEw9Y52zfl0N/IRks
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:124a:b0:dff:4c99:915 with SMTP id
 3f1490d57ef6-e041b1134a3mr494223276.10.1720720857211; Thu, 11 Jul 2024
 11:00:57 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:00 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 20/28] perf mem: Use perf_tool__init
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
2.45.2.993.g49e7a77208-goog


