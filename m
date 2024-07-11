Return-Path: <linux-kernel+bounces-249649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A07892EE35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96E9281565
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790AE16F8EF;
	Thu, 11 Jul 2024 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cm8dn/NR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085416F830
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720835; cv=none; b=c4WYXuGz0+xaNzxQJQ5Zj7t7k/V+j8P1OIPqddWKfkZDELcHNOw+xDWsaInX4uUwg92z3JctJEL3h6Z8tMJwpF2Fk/Macz0Qk9bj0G/KMFf9LQY2xO4V42sbdR4CGG7B9pkv800AkRUbDrs3XSVITFvJbiK610VG5rQs0FXo/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720835; c=relaxed/simple;
	bh=R2cr19QUh/0PZGh9ohFFVIVNT0Cp0G9UBlrYuAQOwdI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lKJ3cXQ2Itz23nbldRgVDkVlWv6hfjKd/Pv7/ECmJwS/szVcT741Tqovkr7kTztN8xqLT0qXhfSPPxcNIjwJjXq09HVhvOvXjvQV6gO2ctdRRGVtTOLkEngjJtkqgkLdkHtPq6dKv3UdYAbIf8ht1njIS1lhH3USwNhjSThEaWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cm8dn/NR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05600ade22so2354172276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720833; x=1721325633; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byfF1KS0n4MzwFOMTsFSRoLAA/Zhxt2Mi8AKEzVn+O0=;
        b=Cm8dn/NRLfNcWn4wNBR7Izz67H3ZSekQlx3m89/DoRO84qqxByOiSluP4J7AAxskxp
         axpjKoCy1kvqBALMtEaX9TY7XALWqa/bLQ32yBerEaOsdDDrZlucZrnFYG3sBYXYSJSR
         vcMBgpcROEtxbQH4MugC74QZCEC2B1mSidJNRe7djNvjj9KJFXyHSo2mw5+mO3J+PT7r
         OZ/W1iEhuBSEBCKwfVq7B3bQrGY6b8cCQMEmYoXR65o3WK6sxwZx58Fv+hum+pCrElWR
         MeJNgcbzAm8oZrkoVOOxy3xZv14TTpCCo7meVQMHIZSfk5Lml71/HvorvPuKqOsW/w/Y
         XILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720833; x=1721325633;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byfF1KS0n4MzwFOMTsFSRoLAA/Zhxt2Mi8AKEzVn+O0=;
        b=ifaIWDRubXFLQ9huN3W2Q4rwJjvXn4wRlovejTQJHsaThwNyGHSNLA1eENF1BXFF3z
         M1opHo6ijSUcWza47YOf8YgG6K+vNoX/WkTChbKdgrN0WyoNNacYhgsKzTLHCLXqp4Oy
         FyDcDcWXLD8eaKI3Mh2sXfKP8WNWHJ9t48E23iZUfRU+KW7xAswvo4KJYR6NTeL/yVQb
         nFKhga1Uo01AozZg1LpumNymTzJpjSPfxUuOcdkUbdEq4BCBmYlIYjvZfI8I3xPhygbj
         03BiygFQxO3LFaG25iNgE+35y8K0iNpHTPztK/mDH4ztYbyPk100KeFEgLefWF0uVa9o
         CzdA==
X-Forwarded-Encrypted: i=1; AJvYcCUHXEs/vazR+zOdU4xOLC/qizdjba4PsEo06jWYQsUW3dgGBhiwfCZeDVjJNVJwdHKLn5qciHdTfDSBGwgfk6UwxlSijcIOq4IPi06S
X-Gm-Message-State: AOJu0YwInqLUUBOvLETwfGOO/qavRKuPDcFOHMmLUR2dQZV9Moays1+g
	ihcBaSjfT+HYeNbmbJURjIZdCaHm5Pryp4euZiUKHrkqycECnSlKOkO2YaKeEf0MLPZkkmYhmfh
	yHOXLHA==
X-Google-Smtp-Source: AGHT+IHr46EqKsmYnSPwqHtEtQqAbJbduJBfkql3qcbWmp+qi69+FUgSATsZrC/sYGw83ur4i+SBO0yT6dWE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1389:b0:e02:f35c:d398 with SMTP
 id 3f1490d57ef6-e058a707db8mr1062276.0.1720720833194; Thu, 11 Jul 2024
 11:00:33 -0700 (PDT)
Date: Thu, 11 Jul 2024 10:59:49 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 09/28] perf kvm: Use perf_tool__init
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
 tools/perf/builtin-kvm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index a3b903cf4311..692267b1b7e8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1603,19 +1603,17 @@ static int read_events(struct perf_kvm_stat *kvm)
 {
 	int ret;
 
-	struct perf_tool eops = {
-		.sample			= process_sample_event,
-		.comm			= perf_event__process_comm,
-		.namespaces		= perf_event__process_namespaces,
-		.ordered_events		= true,
-	};
 	struct perf_data file = {
 		.path  = kvm->file_name,
 		.mode  = PERF_DATA_MODE_READ,
 		.force = kvm->force,
 	};
 
-	kvm->tool = eops;
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
+	kvm->tool.sample	= process_sample_event;
+	kvm->tool.comm		= perf_event__process_comm;
+	kvm->tool.namespaces	= perf_event__process_namespaces;
+
 	kvm->session = perf_session__new(&file, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
 		pr_err("Initializing perf session failed\n");
@@ -1919,14 +1917,13 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 
 
 	/* event handling */
+	perf_tool__init(&kvm->tool, /*ordered_events=*/true);
 	kvm->tool.sample = process_sample_event;
 	kvm->tool.comm   = perf_event__process_comm;
 	kvm->tool.exit   = perf_event__process_exit;
 	kvm->tool.fork   = perf_event__process_fork;
 	kvm->tool.lost   = process_lost_event;
 	kvm->tool.namespaces  = perf_event__process_namespaces;
-	kvm->tool.ordered_events = true;
-	perf_tool__fill_defaults(&kvm->tool);
 
 	/* set defaults */
 	kvm->display_time = 1;
-- 
2.45.2.993.g49e7a77208-goog


