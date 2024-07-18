Return-Path: <linux-kernel+bounces-255826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE609934587
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCF71C214A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171E9446AB;
	Thu, 18 Jul 2024 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnuQ5RtU"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E0440848
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264460; cv=none; b=n6VYD1sjGCqha3zNlfSnQtn9IBpya+cJjiyPT3F5pDoZba/vyNAIisfvX8e40wC/Wep79G1NE8LAtjP+XcJFO9AbO+ZCFLaBqH3sdVF15f9fRyKP8zw5WReE6EwL1a0utyezbGx1L//5EVGwFWyTWtSbojgDTwjQH6tNRJ4bRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264460; c=relaxed/simple;
	bh=5NLo6mkryom4NhvGMJNdBdDiyvx9A0lIz7/wg34r5RE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=RvIZc+uwW3X91LiPzQGtTC21k8kYHPH1q/7rMJp/RCcuXWUAn1breSY7+rejXl1FUVO3oNR9NNJyymzJ+JMEViqcQU+RXxFcvHfVlhBf5xx3y2nVyxsjUa4k8cW+gQJeHCu9Z8VFpwUOgOZg8PZGNe2vr1/Y6Gw3ulzR/+wjgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnuQ5RtU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65194ea3d4dso7041907b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264458; x=1721869258; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bihPZPBGJ6d8qN0fHDZAaoj4FmhnLovUYATiB5ueYI=;
        b=KnuQ5RtUL+jK4ahi/lEVK7dAoT+nuaImkVUZpffMvld/Uqkukc6eVSGRm3UizBpfDP
         Yaq/NnXYYAAFXKOhtmGQ57z4g6w+AcrJ63a1YCjZmFMj3CNwerObgbDyA1RzT6MwgMWV
         VaQcU6sZHsBYSpQkCAdvmHzk7sCbZTVo/IBFsSpHnDg2+xiBSgRKcA04D8jmxI9XG7sl
         tO+S1gzjvaAlufi+oahOmBbm5t8wjnAUZZGv1d1b2W3aCQqtRFyRmS9PuJ3COeBim25N
         ALN+HkTkC/LiFkKvdf0PkTHSiET/SpRaHjl6Q8tg61HDTZVxMpDMojnV8aAOzrsYrkAJ
         EIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264458; x=1721869258;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bihPZPBGJ6d8qN0fHDZAaoj4FmhnLovUYATiB5ueYI=;
        b=Ru+4E+n46dH0horEllngc8PlLoqsrtyajXbC5SgxgEcFeiuKDTXe+5ozYsEkLF6tDt
         IC5asgXuA1AqgkalIf6iG+ZaaKlW07CGKatHErbpO5euXxZSxm/ZNGBuEaWTrgwe8xPr
         FLDIwMjSC97SSpYH+5QeU7tYPbdTv3O0Pgp77jb6ZIHseHoc/HgiR69FTRr8/yVVVECq
         NX+tN3fTZaq20i9z3AHcqtMvaHXlETk8EQkapJTHKpXJcA3AAn7pgozNdn0/WPNvDMrH
         3MQHZ9UNo6zkHjgUNDKGXodVHe1det0bC/eGoDJ52ur9v+g/fQKDnh8hnD303/vXbjXQ
         M7qw==
X-Forwarded-Encrypted: i=1; AJvYcCVy+mjenjCsxUcx/g006FiCJsLnCRebOPyPfIU59fadIV5iaKtDBamZmT+/UtzK7g8PLGiZLc4A6pRDZ6EH40mP/kRy0z4kvzXMEqqM
X-Gm-Message-State: AOJu0Yyaunb/LrgF2gaSiEQ3T6A10pUGBRuPGi3cSCGMdnbGBcxaeXWs
	Adyps8sUEzXXehCgoVFp71/StEVaC+q0L/DwnHJH0mXYt9RnH/hwjSPFk1kGWIiGiBUMZJhKZ9Q
	3+ADHHQ==
X-Google-Smtp-Source: AGHT+IGDEF3uZXg4slq61N/gjbSuBnIZfH69MFL5bkSpRqZ+m4jNhYliSi0lDnLt9dM73d7tpplzPVLMX02w
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a81:ae04:0:b0:64b:a85:e2c5 with SMTP id
 00721157ae682-666019e3b2amr337027b3.3.1721264457820; Wed, 17 Jul 2024
 18:00:57 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:05 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 09/27] perf lock: Use perf_tool__init
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-lock.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 6efa9d646637..2c216427e929 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1933,22 +1933,21 @@ static bool force;
 static int __cmd_report(bool display_info)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.namespaces	 = perf_event__process_namespaces,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = force,
 	};
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.namespaces		 = perf_event__process_namespaces;
+	eops.tracing_data	 = perf_event__process_tracing_data;
 	session = perf_session__new(&data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
@@ -2069,15 +2068,7 @@ static int check_lock_contention_options(const struct option *options,
 static int __cmd_contention(int argc, const char **argv)
 {
 	int err = -EINVAL;
-	struct perf_tool eops = {
-		.attr		 = perf_event__process_attr,
-		.event_update	 = process_event_update,
-		.sample		 = process_sample_event,
-		.comm		 = perf_event__process_comm,
-		.mmap		 = perf_event__process_mmap,
-		.tracing_data	 = perf_event__process_tracing_data,
-		.ordered_events	 = true,
-	};
+	struct perf_tool eops;
 	struct perf_data data = {
 		.path  = input_name,
 		.mode  = PERF_DATA_MODE_READ,
@@ -2100,6 +2091,14 @@ static int __cmd_contention(int argc, const char **argv)
 
 	con.result = &lockhash_table[0];
 
+	perf_tool__init(&eops, /*ordered_events=*/true);
+	eops.attr		 = perf_event__process_attr;
+	eops.event_update	 = process_event_update;
+	eops.sample		 = process_sample_event;
+	eops.comm		 = perf_event__process_comm;
+	eops.mmap		 = perf_event__process_mmap;
+	eops.tracing_data	 = perf_event__process_tracing_data;
+
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
 	if (IS_ERR(session)) {
 		pr_err("Initializing perf session failed\n");
-- 
2.45.2.1089.g2a221341d9-goog


