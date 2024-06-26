Return-Path: <linux-kernel+bounces-231499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9E9919948
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D881F22330
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461CB19882E;
	Wed, 26 Jun 2024 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhTj+lrK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED9197A67
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434252; cv=none; b=VZ6uu1PfzULa0DXa6JHj90rg7jf5sxI+qu/VXWcFLRG8gZEJvuAj/bx7rzRA3+1AdBOJymkc6v+uztStoPt8KuxoqOzTLtF67TYtATHm0ZrCOVfI7hpW6MBs8bHP3p6H1jMIvuyqnc7GcQRU0bUHLIldZ8OSEcitq927c5OCjDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434252; c=relaxed/simple;
	bh=dyBAFLuB77d4FySD0MlGoqSmYtedpVSJiMTBSe2shXk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U1dVG+66P9M/JHUlPqNgY77pc9zaww2XNXn67Bcml63RXBvgU5Mh6p/gNTxApjN+zFejYidycmKGGjmiWMR1pd44MYlgb5zhiweaafrqiZO+sp9WD3WG+ajAozg9zWZnemZBHK/HlGMcDFrNh2+mGjQCDl7eFya8jVniTxfQVcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhTj+lrK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bab20bf5fso164083697b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434250; x=1720039050; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAjCLL/ftZfBFw5cOoLeSIWi0+JxdIhk3yYIclIyM/M=;
        b=hhTj+lrKi3vUuWI2us2XzINk8TWvxDAHYTXFGaNBD8/wV3uikx+j2UY9sgZv5YALhr
         xaT3CtBq/xD3w60si67MpNJgGXqiBD9A3bJ8G9t9ukagSmvOM0GsIMA4n7I5dDArLZrp
         vz2VNdi513c9jtsaL8XY1k+A9qxSBFEzO6uFycV1x43CfQqjezX6ZOWxnPM2FCkQlPK8
         RRt8ITaGQ0M9Oc5xQBKxJXnbMC27m7nstVgYlTOLzx5NzH7Wlu6RwM/kpwfM3YDPWH9A
         J4+b9z+vEQEhRRfO472AQK8hscUbMZe7Y2VDe+TAgfTC+WTUyEzFMTuPfBKCE8IvPyrs
         mvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434250; x=1720039050;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAjCLL/ftZfBFw5cOoLeSIWi0+JxdIhk3yYIclIyM/M=;
        b=HGK7CsI90zJybsfyrQlDWMF6OcDCrghs+aUAEKwqj8MtZxZcj0qh1P0Usw7NFAfm2x
         Kbc2xpMSWZKCfUDsm7ZM2tAQftV4M5bNfF1iO4d0Zguq044RcQmbadcsiYlFbThhbcyu
         lPcV0G8HmwJ9CDuoHhmtKaieJblWUZXVwcnXYzHWa/gdno65zaOF+K7pBor4ErGmrWLW
         uRGK1ODRJv6JEzRbFCaZlVZD5XclK25A2e03m5fawK29fISt4rwSq8+I8odbXv4H80Wf
         iKAAS/msfkDF76g+8N8bSdH1cZKW7Jk3iDPn7ERBrRyhFxN3UiwQDjOGmQ8Jm0cvolb5
         cdbw==
X-Forwarded-Encrypted: i=1; AJvYcCUYyirW3K9kl71Hhdr8CH3bQdFfLCuBK6Czex/WLB3iiOnTdiNzNPz+hhplUeRRnbfGXYgCwcwBAW6Fp+oc0JAxnYHgWcgXaqU6KEFQ
X-Gm-Message-State: AOJu0YyYgNFEvyF/cdl1MYxJ6qFfzvIvPH0wg8mKFpqRPRnkuubCbRcq
	2J9HESFGxATomWtqNAdD92MnpCXbvJJN0yHiFwNoXX7gmjp7s0/HlH5MGtpufyG0W9LM/Po/0r2
	mz3sIrQ==
X-Google-Smtp-Source: AGHT+IGGXFqJD9r3IWjKrWLtrm1hPrgKca2MTAugIoYfk8/8JWlFTTbqc90peurLEErApNOT4jS+EyUzw51J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:74c9:b0:648:db87:13d8 with SMTP
 id 00721157ae682-648db8715ddmr35237b3.2.1719434250039; Wed, 26 Jun 2024
 13:37:30 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:24 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 22/27] perf data convert json: Use perf_tool__init
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
2.45.2.741.gdbec12cfda-goog


