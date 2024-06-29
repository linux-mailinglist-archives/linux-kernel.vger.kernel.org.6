Return-Path: <linux-kernel+bounces-234816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1184891CB1F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916731F235BC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E6E13212C;
	Sat, 29 Jun 2024 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJOWTvfx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617C12FB27
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636901; cv=none; b=WpQy0zg3VQwJL/Zt2/pUn3Vq+jAnSa7XplV/c9MatUNAITUEqwuZ1xfP8zLLZAL2NYU9sLh6Y4jXFCW7KPHjsqpcHHaB27/LC5DSetX1/V4KC1BHE6l/NgAti/yiwQz4cr8hAB/qZeoEdtXp/mCYfZzaEm7Pe4QMNAvH9GAHmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636901; c=relaxed/simple;
	bh=Q8fXrFHhOeJZyCMZE0c09JJrKg9nIIrKFbU/Ag12mZc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=J8BPoNhuVAeoRJJqr2QcW1otaEux3xz7ddHGMzq4gXoFVWOhj1XqIkmlAucouAq5svciFgqz/VgkxIRzAUsmPmQKYXfSsG++NGSKSNPtRVqdavhiZTEX1ymqXnq8vGQlgrio8oRlQ6TDVJ/UWmcaNSOwN0gjXZM1fXFJmSKxyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJOWTvfx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64507372362so24644317b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636899; x=1720241699; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6yEyi/glyHe8pWjJ+W5oLG0v6fQ7RZJQWnowp0gj9s=;
        b=SJOWTvfxY+UPNEwjhoynDXeZOgFcRBUmz2xaTxum3ax0lNr9Fj/ZQ7tWNBsEtSdIiP
         7q1qA7yhsDkbGksvcWD3XWFshhEAXUV7NpsuGAKebBjJ60SLdokVrmixju5Ls6IBFgl3
         qIGTM7Jdw4jnbPOyVKvrWzIIEU2R85azQRl8+ggDnbrf2CsPN94jjJBF6WLMPNUZ5Xrn
         CHhpYvgCtjPO3QoR9bjfy24mscs8PVHnWQme7SwrxCh57VgkwuQGd7Lah5ERGsQn3ogm
         XrZHomCykLB/uitbzVKAXcXOQxIszEpOFCWLhI4Wi9wcLVycwMZSKNMYCu1mqpuSLaUr
         xTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636899; x=1720241699;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6yEyi/glyHe8pWjJ+W5oLG0v6fQ7RZJQWnowp0gj9s=;
        b=ceYGdv6FrzikCtxVNz6Si4xCnDMReoCa6UUJv9UXSwsjYOUH7T+VlRRyaX5thQIoIf
         D4T8h7DfvDasQ6nOxCzolKbRfMRdI6zYHTQtWywTceSFKOnKYSb3DXBpULhqpOVqPhKX
         i2sokX4kXcokHKAgVRp5Xi3A4D2K9CqZluhvO1NLFFm9fsvvvdlOf3I2yp8WXs+ueRI0
         H0kg1k26Q2uDzw9mmVdrCFfICLBbmliBMrWwVYoK6vD4ZWsdz7HoLOz6OrHqsq5OQkjn
         Ef5nSxrTpgimtZtDtbjYgFl0kKTYoU9pvJM/aRM/XFNO74G3OfdyvbnVhZhT6X/ijXbC
         BBtg==
X-Forwarded-Encrypted: i=1; AJvYcCXoamocytP3OiIza+CwTwUZVetspl55R2JL9ebkNy35bOcRMFhCtE6kbYuRWQZ+iWqnVYNKUKSb1GDW7lFe+onYgdKsnK8faBiOmkej
X-Gm-Message-State: AOJu0YxEw8e65i4pT6nDsIHMiMBkDHiw+b6JU/hQoZW3m0tOKxeJWRRu
	vS+XTDK7wV4DvxgFrJ8CIyp1jcyUoRaG4WrONmsl1bUVcVLjSdphmK9Ay+8Vx/9Arl0hK6LoFip
	efD3PPQ==
X-Google-Smtp-Source: AGHT+IGtfrZeP5PYTGGfKv+9uFwUUxybvKRI3Ehr0XzH84CTB3D94s32GM5l3MralwINvpyEQI0nBApiDALo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1142:b0:e03:3cfa:1aa7 with SMTP
 id 3f1490d57ef6-e036eabf996mr430276.1.1719636899526; Fri, 28 Jun 2024
 21:54:59 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:45 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 23/28] perf data convert json: Use perf_tool__init
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
 tools/perf/util/data-convert-json.c | 43 ++++++++++++++---------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 905ea9823f9d..20bfb0884e9e 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -316,39 +316,36 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	struct perf_session *session;
 	int fd;
 	int ret = -1;
-
 	struct convert_json c = {
-		.tool = {
-			.sample         = process_sample_event,
-			.mmap           = perf_event__process_mmap,
-			.mmap2          = perf_event__process_mmap2,
-			.comm           = perf_event__process_comm,
-			.namespaces     = perf_event__process_namespaces,
-			.cgroup         = perf_event__process_cgroup,
-			.exit           = perf_event__process_exit,
-			.fork           = perf_event__process_fork,
-			.lost           = perf_event__process_lost,
-#ifdef HAVE_LIBTRACEEVENT
-			.tracing_data   = perf_event__process_tracing_data,
-#endif
-			.build_id       = perf_event__process_build_id,
-			.id_index       = perf_event__process_id_index,
-			.auxtrace_info  = perf_event__process_auxtrace_info,
-			.auxtrace       = perf_event__process_auxtrace,
-			.event_update   = perf_event__process_event_update,
-			.ordered_events = true,
-			.ordering_requires_timestamps = true,
-		},
 		.first = true,
 		.events_count = 0,
 	};
-
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
 		.path = input_name,
 		.force = opts->force,
 	};
 
+	perf_tool__init(&c.tool, /*ordered_events=*/true);
+	c.tool.sample         = process_sample_event;
+	c.tool.mmap           = perf_event__process_mmap;
+	c.tool.mmap2          = perf_event__process_mmap2;
+	c.tool.comm           = perf_event__process_comm;
+	c.tool.namespaces     = perf_event__process_namespaces;
+	c.tool.cgroup         = perf_event__process_cgroup;
+	c.tool.exit           = perf_event__process_exit;
+	c.tool.fork           = perf_event__process_fork;
+	c.tool.lost           = perf_event__process_lost;
+#ifdef HAVE_LIBTRACEEVENT
+	c.tool.tracing_data   = perf_event__process_tracing_data;
+#endif
+	c.tool.build_id       = perf_event__process_build_id;
+	c.tool.id_index       = perf_event__process_id_index;
+	c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c.tool.auxtrace       = perf_event__process_auxtrace;
+	c.tool.event_update   = perf_event__process_event_update;
+	c.tool.ordering_requires_timestamps = true;
+
 	if (opts->all) {
 		pr_err("--all is currently unsupported for JSON output.\n");
 		goto err;
-- 
2.45.2.803.g4e1b14247a-goog


