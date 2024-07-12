Return-Path: <linux-kernel+bounces-251077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20BC93005D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E391C226AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36C17E901;
	Fri, 12 Jul 2024 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlrBGB07"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2B17E8E7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807984; cv=none; b=PLD2Rb3rX7XodMD9ymGGjPu82k86zISZ1eEfOIXtVQprY6uarzqWSvZikwIsxK0waKXiieB3mmnTdROzKVkSXmWpV0vJqbWopeCirM5HCujYI4BnSjXkIByAbX5A+uQqN06HPa+Zb9uaw+bmce6svFv9IgdpkU5Wffz8WHJcj5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807984; c=relaxed/simple;
	bh=IiOUbHu6Xz1VISLL+B0ayGxLanWqPidsSe75Qtiw59I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TXvAsPTDSSLDcgKR29OD70pINWf7SSODnOflwGqtRSG/Jh8y+sNueXKnaEBJSNqCFpe9wsy9jHt7nkutgDUq2ofdkA+tocebZqDF2AsOvLa3H+gx/MBj9I28fsC6JxqGMlXL1iRD2mehOqYmvc6Km+gheaPHbQ7uWTMnyDE7q78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlrBGB07; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-654d96c2bb5so38505127b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807981; x=1721412781; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9Nrbi73tEJWZxPfyj1GxchBACZKBze8WVP6UfEoRnc=;
        b=rlrBGB07ulbu38xgl3cGaQeG9QqD1iHSJBKuxu1e6/yw9E+xSDkoP3McAA+VD3sFFP
         3sT7TDEisyHiglyNfTGNzMc3HEnKEokO/FiJSj1gB+j5LVbNs2pCVMU/m9N6phRqqU2R
         sPADzogBaXBnk2yqY+l5tZarWHR8uOZilBqy50DPbWSDs4Hn5GhBmfI6okx8PEjljbnh
         6894QmX/uUN/o6IDh5Udp5AN/eZEdcioEwp2d4n7ersmdfgYGk1YEKeumtsHPKXAWvA9
         CTT54B98ulcuyrkZum3m7hvVtjK7AkiCRyd1EVkkCsS6tYupLm0kW9m5Flg6T1lGOe/R
         cpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807981; x=1721412781;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9Nrbi73tEJWZxPfyj1GxchBACZKBze8WVP6UfEoRnc=;
        b=YztraMvt0KUrZJmUXpp6T9l8oDPqrluyLZbGC6jtLd+qwMWLtV+05B2+5tzOdxkEOs
         G13oTm5mcLHU/QKCF0UQBhhVHqn6dkyODR5KrchhPe2MOeKdTzu5OpT64HAtwrNB1Ij+
         1u2/JuvWBe4F+h7Eh4u4LWvJriz+b41mDerhCGxjeduB1ffqPxYbaN7KUL7t1e6utdRj
         ge/N4eAG+8oQJso8DkoHYPxeGN2FEDpSi74jp0o6NUC08CQ9DXEhPlzBJvc4I5mrG3SG
         AA1KszpU/7RGWmL9CSkVX+xt/5ah9PxEk0XmncBFoSiMhkFRlyXyuOljtrQmRSJ63yuq
         mm4A==
X-Forwarded-Encrypted: i=1; AJvYcCVgFxuqQnlmFWuzj1Gq8jpooEQ7FsA8jM1mGZqfkqELSFSKgUj7eXNukBNCt13L/2UHoU+WX4K0NSZ46ZDGv6BnqPB9mxlAhQ1imWeq
X-Gm-Message-State: AOJu0Yy5FZRtNtFG9NKWc2glmR0iqQlTVE10IfLQebzL9ivpPJysckrh
	HRO4ORKppYZ4Wt1uyxl9JNams8f010elkx6745Qn5jhg1Aa9JbohJvA0858ppmNBU5dKZEEb6cT
	R37JTOg==
X-Google-Smtp-Source: AGHT+IHbbwHCzdchAfHj2SPmGVg9X+8SLDnkVDWoP3VU6MRCDTDk07UDfpwPw7rKkSi8K/BWJzAXGMd4QWb8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b0d:b0:dda:d7cf:5c2c with SMTP
 id 3f1490d57ef6-e041b17798cmr23901276.13.1720807981253; Fri, 12 Jul 2024
 11:13:01 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:04 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 23/27] perf data convert ctf: Use perf_tool__init
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
 tools/perf/util/data-convert-bt.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 9e2170604b66..021e9b1d5cc5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1607,25 +1607,23 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = opts->force,
 	};
-	struct convert c = {
-		.tool = {
-			.sample          = process_sample_event,
-			.mmap            = perf_event__process_mmap,
-			.mmap2           = perf_event__process_mmap2,
-			.comm            = perf_event__process_comm,
-			.exit            = perf_event__process_exit,
-			.fork            = perf_event__process_fork,
-			.lost            = perf_event__process_lost,
-			.tracing_data    = perf_event__process_tracing_data,
-			.build_id        = perf_event__process_build_id,
-			.namespaces      = perf_event__process_namespaces,
-			.ordered_events  = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct convert c = {};
 	struct ctf_writer *cw = &c.writer;
 	int err;
 
+	perf_tool__init(&c.tool, /*ordered_events=*/true);
+	c.tool.sample          = process_sample_event;
+	c.tool.mmap            = perf_event__process_mmap;
+	c.tool.mmap2           = perf_event__process_mmap2;
+	c.tool.comm            = perf_event__process_comm;
+	c.tool.exit            = perf_event__process_exit;
+	c.tool.fork            = perf_event__process_fork;
+	c.tool.lost            = perf_event__process_lost;
+	c.tool.tracing_data    = perf_event__process_tracing_data;
+	c.tool.build_id        = perf_event__process_build_id;
+	c.tool.namespaces      = perf_event__process_namespaces;
+	c.tool.ordering_requires_timestamps = true;
+
 	if (opts->all) {
 		c.tool.comm = process_comm_event;
 		c.tool.exit = process_exit_event;
-- 
2.45.2.993.g49e7a77208-goog


