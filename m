Return-Path: <linux-kernel+bounces-231485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C7E919935
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22DB1C2282C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F70194A57;
	Wed, 26 Jun 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8nQ9t2K"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298A1946CA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434219; cv=none; b=glemYNdJEoBy9HI5XFIBpyrWLjhxftvZXCiGUfHssMQuy1kTiHOCj18w89jXX52grs+JW5nNaR0/KilJaKj1OdldlWQYec9GiwPnzd5LhM/GYRJqhfk/R/ABGBdnrB0sr1/0pu0drMUKc0IEPRVAhXyhndw5lbPt+Uy5197eT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434219; c=relaxed/simple;
	bh=4f3xu/fTKlsZKLAxp35O5+huY8NAWRnMLMbKlqWg7eI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U3N5WTMLqL6kzRB5GU/WIkBAsT+3R/TvVwxuC0nZTcHZsjlmCQWCAefPK12PL8JOqAQrVDxXwXlKbhKDtkq60ARsJKKxKex+5VKnvlGFjU6Hr1t0o2qQ58AP7BwYLZBgMmKs2Xc/KMZxZ9FmXR/Vc6ClcfK7Yt46bpsiVH4mqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8nQ9t2K; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bab20bf5fso164075377b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434217; x=1720039017; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0D3Ll4YJxFSzRg0DxL5KKZwtYxMwAkaxOfW7jAWfCz0=;
        b=D8nQ9t2KlplFxvgJ8GJC/4h+pfRCxk+rOQxuOQ+/3ctJfIocoRLgsq6e3L3jR+cqX9
         HZpuDmwpaDwHAwvbZgfPmo4CANnfihgoRPN0+mL5JVdMq1nJGkjViHvdMM+O4+QPQeld
         Uwvd+pPU8e0rcvaFeDO6EnGS1qYzpnnvMaEMW516KLbozmmOXjwrj4unUqc2Wl9LwoqW
         duLevl4i4NxDmlM1viLqmfuoj+5PDUbpu54rgD9CofkiNnSysPCw7bgfQfUbXEZn/nS6
         NBkvfd9o9PGWtSnLf/PR3SrMBgCitghoEfydEIv+/l+tbdX7JlxtwHH1kBQkLRAOER56
         XLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434217; x=1720039017;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0D3Ll4YJxFSzRg0DxL5KKZwtYxMwAkaxOfW7jAWfCz0=;
        b=IyrffJguN9P++sl9LoTZnOiCNERq6mGYGzcXLkrRPsOxsL26hUuQ3BrtM/a0AEA/Tn
         W/GUUvALDUVyfNX/1q0Treh5kQqvW1o6zb3QVieM+aby3pX0cnFma8mQvJmgNj7wrLPh
         yCg2VG5ZaAYB9Eo8hRra/xc7ht34s6dE0HQe7+Lb2n+Tf2RRbx+rtGyq5A1JKcAnvbvn
         FlSrJkmchV/aP0o+lylobUK/mS3QPHdS/bLT3/UzGkbzcXy9mueHGeGK8KcGWrXmb4G2
         i0z45QGHvO+K6bBawivBVL/YYrmuafZMWLlM8YJAYkJ1ltD6g29w+WCbFVn3zB1CiXCS
         M+tA==
X-Forwarded-Encrypted: i=1; AJvYcCWsQBPxhZ3oineGqY89upw5o36OWVxv/aeSrD8m39bZy3poc8rJSnrq2bvcsdJt2gxuU4vga6jX/cFlwkLoiFXPK5RSq3x15nvpxkiC
X-Gm-Message-State: AOJu0Yw4FFpV2LH1I7lXe0KcLx0WOaaIK9vf7i7w9qdu+1dDcNxLpCYu
	AYpLoXPiIBd5Nl0TsIZZp9GlSvDpGtdvYWKDLwFMA9AEf3bIWVK4f2t31gHKm//tFSeTi8d40B2
	48e5iGQ==
X-Google-Smtp-Source: AGHT+IFuUkZI1xUb4dQtuVFreG6sSaXi+9c/mJnE0USxl2dca1+VIZOjUXTn6HLYlU8i1RaN2vfEqGJqEkiE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:3602:b0:62d:a29:53a0 with SMTP id
 00721157ae682-6434041982bmr1581297b3.7.1719434217307; Wed, 26 Jun 2024
 13:36:57 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:10 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 08/27] perf kvm: Use perf_tool__init
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
2.45.2.741.gdbec12cfda-goog


