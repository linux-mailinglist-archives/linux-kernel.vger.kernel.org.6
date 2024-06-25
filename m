Return-Path: <linux-kernel+bounces-229409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D551916F41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A9D1F21356
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14DA1802A1;
	Tue, 25 Jun 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUJJjSQT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C554917FAA7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336420; cv=none; b=Q5y7FNqvSFhvKPeIm6v2eHmRwUwHNA64uoaBnbxh65bZ6K764XL4UvgxzmH8CX/2yBRawGBAIGh+Qa/3HpgvaIsFkwkyoPXpnQd9nBknWy+4JvtL4fXql4g59utUYmuvbZcrCqgx+VwMMCNxc0Ysk4uPa40/cEHI5vBnPZYiwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336420; c=relaxed/simple;
	bh=4hregmkychdDNk+jks/Rw8XVYDtpylXDSeaooVz7NiM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CHVvMgCGMF+EtKwZwOh/ssRg14Lr5oz5U65jglWAm8E0q3GKdj7TXfHAv2vt3nGRdSCTTwdgJLV7ku0tbtREMOyGP5fU0bXj0G0D4bwhqZ6/rKXHZKelDKXtkq3l4u4THA67gbylHL/ZD5GXN5+v0VD6h4YXFHd9V7VwTIg0wIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUJJjSQT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-643acc141cbso32550127b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336418; x=1719941218; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHFcPRP+yhEWi0robOtIeOpLSabhSBGQ4xXRLMmGCaI=;
        b=QUJJjSQTRGaH8kLEMb0P8zFB2ZHrIoOkZmyaSjztNUhAiQ4ycXqvTCL1BetmRaUpyw
         AW70+Od8RusFnWsCl81aAL3IuZqxu+5sJrTZSzAQ4v39ww3GKpY8rXk/7StZGgaBPVBm
         P8qxf5i8ds9m+UnZUdUNB5ZYQokzV43pDY2mFLiKf8s+Az6AbORjOKsCH5Ewj9hu65TI
         ZrBV6NXa5xNFwNJolbweQkaaWAuVKQ4wWJ8u4PwNlsZ2Bkfx7kbDOpEj1eRhSaFyvCLm
         Xs1JrZ6OVHS4tU0TteYNwPXi4Bi+yW1v6PTwvgZg75bMeeYwt39p6GaWtXvF/ULQ+jhA
         ouYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336418; x=1719941218;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHFcPRP+yhEWi0robOtIeOpLSabhSBGQ4xXRLMmGCaI=;
        b=RPCKf57e/EbboLZLW3sWBKoTBZ0EtwCjRkfvVkva2dZHT705eG80dB7bxnBOBeg0EN
         XYVAlRwT4E47ldE0m+CMToXBMWJ9Ucq8RBHhiReDdJdiofxpgRP9S4TQAxmQS1diKR0g
         /J38gdNPPUlOpul3FEd6KKYWExwdJ8ubAn22KZLU7+NgJMJw90edl3SRospj14r2Gt7I
         SR4Hf4f9t1tMC6/Eor05/updIVPfEgg96+rHEsTpkgCCuUup0eWldrBfdiN2XubxkgRg
         yW58aPlxtkTrK3lHlsNpj+zuLkLJlKaiYLouVO5PlC5A9KSiKBgu4f+7pJT+J8tw6fir
         hbXw==
X-Forwarded-Encrypted: i=1; AJvYcCVo/w8oa31jTNFl+Ib74ueOqu7AspTdRogqr4XY5HTIjBemxu2tBSxLM1ndec+3AHXw5gr3gdGi1/Fge68lzxkq9h2xq9Ki12tV2x4N
X-Gm-Message-State: AOJu0Yw1Lr5T+tLsk0iCrC5/TK3112gMpzJ171TTW1EBwKoDmyzJei5N
	zjdHor2+fV81MOmuLTLXtRUL/kW2mZuEBjd78myAzidnwCjr0bpih7WNdKBzVwx/fOmsgSkB3jK
	6X56UpA==
X-Google-Smtp-Source: AGHT+IHvubIUZhjEok3/V/kgZ7MsIbdXa2+oaKX/HdJ6s7+Z2Phn78YjiEcP/gWbJXNedxraCdMON4nnJvNd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a81:ad12:0:b0:627:edcb:cbe2 with SMTP id
 00721157ae682-6424dc5e95emr531847b3.5.1719336417810; Tue, 25 Jun 2024
 10:26:57 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:58 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 21/26] perf data convert ctf: Use perf_tool__init
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
2.45.2.741.gdbec12cfda-goog


