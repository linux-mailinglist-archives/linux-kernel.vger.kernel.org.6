Return-Path: <linux-kernel+bounces-234814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6376291CB1D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034F8B23017
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685A286255;
	Sat, 29 Jun 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="azipCkGd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BEB81AC8
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636897; cv=none; b=VfX6TLt1AkddddTMw+NsWBpj2WlZO2J13BmoP8/Bno58cyqWu936nuc47y91ht3rE+9jVUuhsqz8DIcQ5HiKYQQCRZPYdcuZrGnWTp0ptF5pjdcpL4qerBR/pgvix88tZws59P0YRLRSgG0sXAJihUgE2H7nD3OscSu2PqfPlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636897; c=relaxed/simple;
	bh=n6vmiL6wUTg0nPW7WZYagl0XLU4DbMO5fUh9FPhC+jY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GUEHkpcjYBqoJIc/lS4KYWN38+KEgmEHlXxI6MCxyV499CM8WSSaxX2E7PBooYgfeYMNHO5T6aqB/cHJ6sL62HLFYh537ikkeXAkO1RRv0z2XuyOkBy1t6EgKaEehAIW+i8dcbNxgSttvNlPLC1sSMqu80Rpnc5gZsicgcYcCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=azipCkGd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64a7d2dc2a9so22499017b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636895; x=1720241695; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D520IbA5iH9wzM7pzjt2vV2BsWgfCNVquMDfYzdLQl0=;
        b=azipCkGdO7COcIpCEqS6o0srEDunArd/OP0YcjKBXGfwimwPpBw2QYp05j3Mx7cfGK
         c58MQEsgxIWgJI/uLjK31cKOCWBkIFkjDMUfbIj7BslBWF+7UoMCLnJKSX2vNnPSqxNZ
         ktN1TpCsJ9Rphfme9OknKt/xt5zGOH1+YepEr/1cQTvnpdrYdyhgVuyIyJLQRE8IZCSS
         hl9GCbDz0PU/WWzyPWxJuOjvtIRHABOykMcJhgqq/6jyFUrYWHRaoAElFZ3eiUSKEuii
         vNQPE24LjQw4WiZYXVH6fwAn/3IIoIhJvFWQ32VMUjSTAFGQCmsmoo0VmNPv1JKxqUAa
         JJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636895; x=1720241695;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D520IbA5iH9wzM7pzjt2vV2BsWgfCNVquMDfYzdLQl0=;
        b=FGFb0dTYY72HWy8DDHtOVJJM+ofp8G4z8TVU55wfcOyZ4Bg8sozd2AFKT2sgtGtxkn
         fPJu3KQR6oSWlFiOdbMXxM3BtM8JO+UX2eC1lri5EwK2iWvb1OCM9nLZUupcUADs4Da2
         OoK9SmIhTiLqvqKqUP3NS3SRMRDTDd1bqKiJKDPoioK9joWw1q/z2cRwnrNb9t/6X8Cc
         A6fLBL0C5ZQ2+81FR6TWzVQaTJxG5t0BjMRwc54WDskIZ4GCvThhL6hSFcd7YwwfNas3
         Zz2ZsEVLv3vJAkEZvwhz+tC+tXx//oKwquxyGuTgAJeAbCrggjpOSSGlIEhmn6JizrTR
         O6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVUOw++ZHz/K9LqZBzoPCftk5N1VrkrcWHwUSPwqrdrxEjoVLAc0/kItcs9E8oAgGwDwcQT49APdgWmJaK2lEL9nyYfGHV1LgaYuIVi
X-Gm-Message-State: AOJu0YzoeF9uuNsEY1o9CONSIH+HpWIpcwIOS68xFP3L8w0k982meazo
	UOy/UZhyYEs7FvqoY+Z5W8sPc4hjdjfNWJx984GtNXFYTWr02upL6GpCrW1VPTNPJ+jOja7mKGp
	fpcqWzg==
X-Google-Smtp-Source: AGHT+IHjGkctfrVaKHMf/S834AX9dLiEQUic95O2Gv5HigiTwS0uZAB3cdGsyXp40ykIKZIfie25wbvv2JJg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a0d:e885:0:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-64c72b5434amr127907b3.0.1719636895234; Fri, 28 Jun 2024
 21:54:55 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:43 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 21/28] perf timechart: Use perf_tool__init
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
2.45.2.803.g4e1b14247a-goog


