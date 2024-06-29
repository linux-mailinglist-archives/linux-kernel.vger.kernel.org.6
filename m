Return-Path: <linux-kernel+bounces-234802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7391CB10
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F274284501
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7466F47772;
	Sat, 29 Jun 2024 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTB+JR1F"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64F433C4
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636871; cv=none; b=Nbfy63YOU//RnSvvm4U7yrYlGd2OrTHXuShuazz5GPaDcMqJCWja/An3KFqQLUWtZQ2D90sgXGVprL5ZHf8rIGviSXp+932xFWrNkawakTEmznP6UcNDLBusFqWMtXWjkd9s0sFRBI/OLny4MODWB2+5VbPeilRaYt3dMc1vRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636871; c=relaxed/simple;
	bh=d+IjtHFeEb8npFCJ/NtiuIpVzuhLm20iCj0wlduMmkk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=I0MODdSJEqebppm1BHmZa+rwfRs6a4Ty1NjxyRHLWvpu507+H/4kzVxbJRvcdXXk7Ei0XNlxb1tvzhkXOyKzmh1uoZ1xKRO1wyzwna6W2A85xulGqZcB8lIXJd9sGPgTuOPbA/CXl430mxkGb1wTp+C6w3rYVtRPkHZfcmZHHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cTB+JR1F; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f3c5f5bf7so21124597b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636868; x=1720241668; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpdjN8s5wB9rzl2Ip7o2ZK0FxU3Lu7ldCcmvQXtJM2M=;
        b=cTB+JR1FKT05C1tIeKWyEBJnmyfgYTDgj5yebawysQFBMld1/YNuFfwPb6MS+uJAtg
         Q5MbRUNoaomFDmlRyPsWfe8U/ez9JRK5iz/W2q1mtPKpkBZ/w7xC1LitAq3MoVHnF8bj
         5Z8+WIzivPb66zQS1hi2RWW3vvnzZb6ly0vaM+Et/HZFP1yym6rSGyGKTAgFIxcdt7Mu
         eg7sNH+fQDE7lkUGByJNOdT0SLSxxjwtfGpYvlBa5h29eS+DPQ2V8Qd33mhGg66pkJZz
         56QyytK5f6TpjQORtI6rgtJ7MkBenw6hbK/uyL66Z0LmIMo0P8NRYLci6cECFGGHZ6nu
         lBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636868; x=1720241668;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpdjN8s5wB9rzl2Ip7o2ZK0FxU3Lu7ldCcmvQXtJM2M=;
        b=r2tH1LWqOz0SgFNNL+Pd3sSADr/E9ID+10LWOwEjPefb9J6vIrk51+59mIdLiP/ksL
         yQCTfVw6XjNMQnHcFgQvX1X+W0UCsAhlySQ2mmpNEJBzoEWDOJaF9yUiceXIWpefVygu
         86VK/+6vfZiqMDFoRbTO/v1GaifPJzwE8klCwrs7mnXeteMKGn6JXk2bR74322qe7dYX
         Xw0WFkRR/tPv8ChPWNR6zLlv/H1tICDy8ictiPP/4H8z8VbIV9t6ekcDfQnsDJLf+hHf
         DZJUtatfylv4AH3letbYrmJ1ubQCLGdi54SZIr87z7eS+2JXxHJLxgyGHvOeswE9Gshm
         eYmg==
X-Forwarded-Encrypted: i=1; AJvYcCV7KjQXJ56mW0yhxyNCS1iWeMa5HLVCYIFFdoqXSUnzE7uys+PMMr9M9dyrpew2DGSPa6txxspdeCTemMC+784/4e2RhSWOs/US8coH
X-Gm-Message-State: AOJu0Yw3dmqb9kDp70BoQzUmfbmo2ZnyPFOeEbDDXBjA5IysNkkUVhjB
	A3Pb2Uzt0E6Idt4UvoUBHRfyTe8UBzEMq43KVL7Pb8Z+4wmF+QOArvoaaMw0pmnvMrd5tAxI1Su
	6hpT6tQ==
X-Google-Smtp-Source: AGHT+IGOKM+g4XrnJTUAvGw3TmUrRS3o4+KVzhyYtt6vHOujwVUTKi9JPoVkhRp1pYVkidwItBHibGKxyLKg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a0d:ea54:0:b0:62a:4932:68de with SMTP id
 00721157ae682-64c7360704dmr34117b3.8.1719636868301; Fri, 28 Jun 2024 21:54:28
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:31 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 09/28] perf kvm: Use perf_tool__init
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
2.45.2.803.g4e1b14247a-goog


