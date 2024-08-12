Return-Path: <linux-kernel+bounces-283761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9CF94F87A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7ED3282637
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253216B725;
	Mon, 12 Aug 2024 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJ1e0fQP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0619D894
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495697; cv=none; b=cHwOql6eypOGPccyvOiOtoUJtdEXzsRuw1tJ9yTJhszPQc6qeNlD61z+lalmNLcVW16TIE5AAa8KkgiHdmXQh9Qj1XdDKPXUyqbVqIYnnJcZrxiyapRqEZyfbVEuF0VRcwGct1s940SgrNXV5kmnYHDJtvWiDZNe2ZtsTOB+1Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495697; c=relaxed/simple;
	bh=B2/PUnnFEkgGzs20puhL/HN4AsJUmb7HRfSa/UkrbmU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=myZk9AiTLpiNpQsx7wuhAeWoGtDJL7sYQlqJFRTU0NCSjU8EhX2WLYXa44ZM+kcisgqNNmRgb3vGkrCZmyGTuIiDJjuQDpiNrVJQHklgHSyVCdESLM7z4YbwGkYhpaB6mX3ry3BOuOhhIDTJU9wr/CEWP7vlGpOb4mhMaI08euI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GJ1e0fQP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so8607624276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495695; x=1724100495; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbSuls1koziHCu+Zgk0ioXEnPdjQxeNgIBorrGo8zG0=;
        b=GJ1e0fQPhefxJPmgw6ZPBo23+nlOI6T/3k3JGwnEZviIwJpU5jYOi14r6O1honn3OD
         6pxrwGooD87RLRYesJac/5eZDk+FSuGGhq/A9Jx3+G/0t70jAP1vRaEjKqPXdGAC3zFX
         fOviq/fZ0xaGo+bbHhL+Z2qGRZFMF9aAvzssixwZKyLm005Hj+0RgZP4g5etZ4/UCGBo
         3TBNSv38xYRC8+BHanU3EN9DyW3drX+fLtBcpum8pW7F7JwwDeSNzOV4AiI8e+hIggPM
         AzifTuWIXc/wm2Gmbjb9URpqvlOUKoqbIlNi+01hIAP2oODPct69JcaE/RUJ3UV8gQDL
         tHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495695; x=1724100495;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbSuls1koziHCu+Zgk0ioXEnPdjQxeNgIBorrGo8zG0=;
        b=ASUEAOLvZNoqd/7XXdtXg15DBRHBwBpqctzDWKui7wUmKpWoLqW9N8eIXBM6GC5Ctq
         t/sRrDnUG0UsOsiT6bSAZlxad1JcrXIQazOrktAG/j206BDZ/TGE9x5vfnQWCv3ibRdm
         zNbr3y5xqpDLahjBmJeK3KwniO0XdDZh6YcV86wausFaGuxaeGPpVKtY7rK4MZnQGDrD
         ymzTEjw1AtoCYp0cPr7Hsej4VwyXB+VkZ22DW3n9hKJSMUmIV6abHZ5YuDM1tqGlpQTU
         9eXbCNpTHjLSeRYEEjibuNCISIv5k1XZ1ooGRhXX+Mfi8dCI3fqT8bDHHQnfLXDucoKh
         pdgw==
X-Forwarded-Encrypted: i=1; AJvYcCVQOrEvDbQgxQLwox6cqAK224Z1zIi+zAg+RcX3n2Rw+DSB5+MztWFcYcbaZuEJFWrIQ2jChXjYp1M41ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqJ3+mWwJPrzd4J8oQQFShTvEH/Wa+6Asq4fIcrprqIGBhllL
	D1OlyvIoYFLDh6gAnW+zcJdQjrYSHCK4knB7yohVIu3ZFWuWJafVOsMBM9NM6MAVLUu0Mh0vjgi
	edrFwbw==
X-Google-Smtp-Source: AGHT+IGKJ+9oWMNqxHbfR8xASqbD92WuYLWcfVYrMvX7Qri5bDa2vpoBKzYqnCKUn0C5AVvaDA3aVfY+pTnG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:eb09:0:b0:e0e:3f14:c29d with SMTP id
 3f1490d57ef6-e113ce83143mr78677276.4.1723495695218; Mon, 12 Aug 2024 13:48:15
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:14 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 22/27] perf data convert json: Use perf_tool__init
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
2.46.0.76.ge559c4bf1a-goog


