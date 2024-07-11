Return-Path: <linux-kernel+bounces-249651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A146592EE37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EDF1C21AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219417106F;
	Thu, 11 Jul 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbunmfsA"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343FE16FF4E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720839; cv=none; b=PEDCiVbUPgDZNDBFY6jCa5qs+mzWK1DkYbJQwmwgyEphtniAGhb1ILtZs4GTNAtmLD0cFkn4OndRkN26yBkMJ/AhHtRttAwyYaGVUCBBESYlXLx0nDgJi1cygkvYi5XnvN/8Fx/umWF3ZZl9zNJwuf/7lLsoGk0h0OAH9X9CpWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720839; c=relaxed/simple;
	bh=5L2/QmV0UtQIb+mYzp5cKQ3gtaLl7JsRv/EFzdZAMCU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LZ4e2Fulal4tP2BP0TMVC40ukgsuDxEo5inQYZgoya9LBZyfUZgZaXsbgjdUJgP/uxBfeq/58lAPb48f9clJ8XooTqqIEkZZqvtCzG2AfFu9O0Ai9rY6gi8D7B4v49UZAjv1q4lMEbB28eLueBd9Egz1H+E6LT/WjEmcMOkOsC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbunmfsA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e039fe0346eso2148274276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720837; x=1721325637; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8vxN+BliJztZySzkr/g5CS+2PgB0g7RSTmLzIMrgEM=;
        b=WbunmfsAH7SzMxu+o9d2M0xyzLO5sflMfJAipcsGaKFf/pZkx67eYFqm42TR42x7Mv
         ERv86jbSKBylN3Ybqq88RQj4/r8v/ihvhynz/TFy5olu2IJE0yTLpsvSLgFjGZxOlet2
         dq9YIQS43eiEz9Kp0gvC/42krwzfMGiWAiIpfUmrG5UojObr3tj6ByvnTbIlhfGKpb7q
         65pbQEMvhk3XnUt6o47TepdZ3BQD+vZWYKEcaI3Um5RTeoVAHm5tsVBsxUz+kQjHosr5
         s+Mb5tV7gLaAzxlN3TTfDXyEs3NQUmhJln8+ToUF838M7Hmu/IawX0uINyEECyxLhwsv
         dumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720837; x=1721325637;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8vxN+BliJztZySzkr/g5CS+2PgB0g7RSTmLzIMrgEM=;
        b=O1TLGTpePrmOA/leEgGLG5fe5Qvfg9Ho5Pds9KP0ltlorSyGTmQMzgnH7rr6G90ftm
         +m8mXVyjOl1EZ5zxUlmHBODYdaoSQg9SMpBxbMso9msbEFww0KnWDLAfOxyuq8GA2vtt
         oT/sWh72fxmB7KQDvc+o8oJ+skNP8FrtNfaZ7V8nhR6nIHnTntk/MX1z3entfSrYl+mU
         uXs9GF5MZzwEsvjTJqhLMsiH7sUclwgBGR/58KA4dSbxtW0jtRt6fUsoAYdPS41UMnvu
         ByAmyp5LFoXPqak4O1ihkOIDvazPrDoRgtuu6gkridOYbKhzKU4GCpIAw8yNgPbAjy3N
         LCHw==
X-Forwarded-Encrypted: i=1; AJvYcCVWX/Qf2yD9si5KBsNiPB32WwKM2EXha1ul2SUh54FYte7OOYVSImwZzdX0Zri2Gu6chNgVXTVYUoRDc+aqxPx6v2dY0CEzCwFwDooI
X-Gm-Message-State: AOJu0YwFyCzFc/KZtmvxX6EaCponDWJNT0U4EoiUn0T5R1fuicBLWT4w
	Eh63pMKHpAovKVriJHumB2ifB9vXQ/Yb9ceC6739awnvLNjodPOwl22fEX/r4GVGL960+zf1ib+
	AFV9y8w==
X-Google-Smtp-Source: AGHT+IHI3dipL7Tp3GQH7MxH3mucgQeoKyx/ymoTPxvLOSdOaV57AwCmKrqrRNCKs1TjxRfG+nIlfE0jSUsa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:2089:b0:e03:2bfe:40c9 with SMTP
 id 3f1490d57ef6-e041b032f48mr17980276.3.1720720837264; Thu, 11 Jul 2024
 11:00:37 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:51 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 11/28] perf evlist: Use perf_tool__init
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
 tools/perf/builtin-evlist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 7117656939e7..818ab21c3f73 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -35,13 +35,13 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = details->force,
 	};
-	struct perf_tool tool = {
-		/* only needed for pipe mode */
-		.attr = perf_event__process_attr,
-		.feature = process_header_feature,
-	};
+	struct perf_tool tool;
 	bool has_tracepoint = false;
 
+	perf_tool__init(&tool, /*ordered_events=*/false);
+	/* only needed for pipe mode */
+	tool.attr = perf_event__process_attr;
+	tool.feature = process_header_feature;
 	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.993.g49e7a77208-goog


