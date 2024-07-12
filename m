Return-Path: <linux-kernel+bounces-251072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D81A4930055
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146FB1C20D98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D00017DA29;
	Fri, 12 Jul 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ClGWyWt"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E317D37B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807977; cv=none; b=A+AK2phVUQz/5IJCA9tl3+IwOiukxQrppaSdqYLWApAjPMOagK42iWuXmVK7BNpXBANYQeTgw1Wmk+XSJJCugThYeMO5vF6gSX55oKVtDPO7iYsBaKMuVBU/qALq6/91hP5nf479mlD+BOywQSaUEDX+kbkDVGw/m6ksHYoNeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807977; c=relaxed/simple;
	bh=ulxtdrULVFXHxSwGu1u6ejOo2/3AvfXoc6ANmm1gsuE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ic2iS1rMwqspgOF360Fuob29A0ZdMYoC9mGtzZaT21qyzgNHf+8RfK/j85yMgN/pkhA1XMsNrp39tz7O/P+4J+pdVaWjM76TTzffvWlFLWmdeHTcRzXBqVPCfV6wFufNpSS0Lf7HhzGLRrmd3RE76xVvfQE8tlqDL9LjnpXV60U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ClGWyWt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6533680c788so40099927b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807974; x=1721412774; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30wTiCp+NVIhDTuqUvYj4YUy4HL96R/Tpq22ji595AI=;
        b=1ClGWyWtTuFou/TpdBKtJAUT/Gc4d7WIjYbzoQqzWmGT8+HsobO0b5bO1JzZcybu8H
         L/0Erg9vcZFnIk0xBwJUvgKvADsKURtq2IvN0dYqo4jJh+9m1R9uPchCWhXTTzUZN9K7
         PU0wiCSFrLhElPUEgQSe0cQGPHBXN2FOJmFvDAP/H9tuS0+QBrBth7m8eDEcGW/bdyxb
         UAZfLDAi7CgAXR84OXrhK9TUFSCclEp8XFm21sIJ0/nDu0Ltn/TMOs8TEjw4D9bjTw2H
         JqVp7xHebye1xcfnnMfWftUZdgKaFL4f8Vk7YZ/pZ2ZQeXBosOdhlEOzqOerzmqLG0Sw
         c8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807974; x=1721412774;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30wTiCp+NVIhDTuqUvYj4YUy4HL96R/Tpq22ji595AI=;
        b=s7JtsWfc/uxzRo1zkTXFDasKqHM3ufUycGLSJeXfgzY2rAxNnCle13CCLly3NF0x53
         +W9wANJTWRmv3D1j0RTDJ9A1RDhHdLk2CCI095+BHLH02Dw+kgBBqV+By1O2ysr7h2Co
         qSWlWNHWBLBvYkFPBOrD/budeJMprQcTUJTfVbBiEeZ3mXpYvrbdYNBG7DwRvtGKKlvl
         7BrM3YLf716To+aDg9W+YXwvo/PgWJWwQNdnoQ8T9yAzSNtaFT1KGbIrm7S/Hzw+LRJc
         m6A3ghV1kyDmlVo533GgbG4KmD6dP9ZwD43SR5lQKFBM1UVPPD7xW/3LL15FV4qiJk7s
         8TIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmBFs10+FGqBJ0IADequu0D/gi94R1NGAOsxqMTMMZl1usquJMQyiUkfQFtO/tsVXb8LddRbc/z8mCWLlkSYPeuq5mzdeQ117/wbZO
X-Gm-Message-State: AOJu0YydJQXaDrfZ+fReNb/cDQQvhsoZA6vyUcwjT+sADlG8nkkGasWY
	XpUIpMpXZnG5/opOAfCwT5dhvMUxVT4gqDvPiqqDXqqrlYCf1ohkx416OnRfzOboxf509vPL2EU
	6jHi9RQ==
X-Google-Smtp-Source: AGHT+IGMtuukUah6sKAK0S8MwrL9axUruMElBWLKJaJXxc54g2LyjBNvkewqR7HlUBQ0L+JgA3dM6zS6xMnA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:690c:6404:b0:651:a724:dd0d with SMTP
 id 00721157ae682-658f06d9d6amr2241857b3.7.1720807974345; Fri, 12 Jul 2024
 11:12:54 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:01 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 20/27] perf timechart: Use perf_tool__init
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
 tools/perf/builtin-timechart.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 5bf818baa662..218c8b44d7be 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1606,10 +1606,16 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = tchart->force,
 	};
-
-	struct perf_session *session = perf_session__new(&data, &tchart->tool);
+	struct perf_session *session;
 	int ret = -EINVAL;
 
+	perf_tool__init(&tchart->tool, /*ordered_events=*/true);
+	tchart->tool.comm		 = process_comm_event;
+	tchart->tool.fork		 = process_fork_event;
+	tchart->tool.exit		 = process_exit_event;
+	tchart->tool.sample		 = process_sample_event;
+
+	session = perf_session__new(&data, &tchart->tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
@@ -1924,13 +1930,6 @@ parse_time(const struct option *opt, const char *arg, int __maybe_unused unset)
 int cmd_timechart(int argc, const char **argv)
 {
 	struct timechart tchart = {
-		.tool = {
-			.comm		 = process_comm_event,
-			.fork		 = process_fork_event,
-			.exit		 = process_exit_event,
-			.sample		 = process_sample_event,
-			.ordered_events	 = true,
-		},
 		.proc_num = 15,
 		.min_time = NSEC_PER_MSEC,
 		.merge_dist = 1000,
-- 
2.45.2.993.g49e7a77208-goog


