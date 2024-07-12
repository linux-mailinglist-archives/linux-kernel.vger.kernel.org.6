Return-Path: <linux-kernel+bounces-251060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F1F93003F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D710D1F22491
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4DA17B510;
	Fri, 12 Jul 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sm1y1/AX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFB17B4ED
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807959; cv=none; b=d6l4aATQOI3gZOMaN4FBak4xzw98ogWLi7iwd3St7/B/i3IVphxi5nOHo1RlYHxGv6+Q+qOnqKWEEcYpeuTZU9ok1FWmsLZH9egUpEDiw/V8xZ9313TiyPx20uvseabQd+f94wsyQmha6yTIBE/74Ak+QpZ4mn/F6yYCJuKUDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807959; c=relaxed/simple;
	bh=QyWrdcj/7yIk1kCDwEAAgyYccYi84Zy4FDV3Stu0DB8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=flRO4+vsTdPpZVL5U0pdKYcEzxXIhtxCfjrWtIaNLhGj8jOcSUz1Mp0QwZX5Fu7ht/EbK655ovQE4CkeJYvz75kcWYEVxDjw7dsL3cmvkogVcmeuzEBVY7aLrFpsixNBnVs92YzkVDlvivxuPEmuz/gYzym8mqKIO479B6bBPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sm1y1/AX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64c3f08ca52so34518357b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807957; x=1721412757; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLiukIuXpfj1RuwI+7tVJ3j4buaKUCfjcNd2gIIAnuE=;
        b=Sm1y1/AXL5FUzoJAYL23KIr4Hm3zGbeSjA8xgo/yb03vyoe8AVxlVzxypDj+VfPe5B
         oVlH4lHmHLVoMXmkX5kBV9vbRSQEY27XfAD9r3yhWUzeXwkBEStDnl5Xr7a14rKLTzcS
         uCDx/xcSrBglEYP2H7fa/W5FxYYjMpdvdRvC/tNyFqAsx7LPcNt+hlH5wTXLx2ft3qTH
         DH9qBNkZMHFxaoxpqxT9kXiVa4aBlN1tyhQHqMCp2seTbvNa8H4eep8BJRDZXI1cq+i/
         UKmFBjGCoHdzRL9WILUcwmt2+NqngWJApzmAJUy7uNsZ9l672HlFq6FBZiVQ9lQeO1p9
         I/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807957; x=1721412757;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLiukIuXpfj1RuwI+7tVJ3j4buaKUCfjcNd2gIIAnuE=;
        b=PdfxanvhRGuoRF8B0D2tTpkfvAg+JTrHbyZr3rSyc4q1v/jsu8c48frUCf3/Hh6/h5
         +9We3FsZHyL+KnHGz+1Qe3ZrfquXWMWu566xO4dbHK1enANERtTaeQz0UAu3lP4cwnZP
         UG9piVLwiROcR3JW7fVtIikGL8/YhcEZvslSZanpQTmXOMmHbfofvQv6UdzWNynZ51u9
         PyrlenR1c6HomaeRgsTfdHwyA8esZAAKmvKdXcHgynuCKL7MVHltKNU7fNLgtjG0O2C5
         XlHuWSwsDdOY7dYYk96qROI+Irpmf8mTScm+F//bz8E4vkPG3a7HV5GIKZj8ws3Io47g
         3hkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVrQ173qFvZMpD9TvMHM5d9zjk17TgrweLODeSPpu8yqCOtFmPrivO6WU6gIPvaUoqyAjHcvDSLQunNlAhFUGpH+Y4H8uPviH2d2Lo
X-Gm-Message-State: AOJu0YxZGo88WvmVfsJ9xsQnOv87p9qf2Ss8UeSmO5OsuMbN5rzHi6qf
	oREADtsblXxCkHT1V8zwee6aj007fJ/XTMUHQBgUT47VzFYdEvdqEY+FRJmrqG+azef5uxp7Bvv
	cHD1tCQ==
X-Google-Smtp-Source: AGHT+IH4uAq+0GE3bX9Ncu3ZBlmhnrDD+38cgOfHCMtyr/CPZ8u/8k78H/BkrIM5m6XYB9naIU9QLIw6gVAU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:690c:660a:b0:64b:683f:795e with SMTP
 id 00721157ae682-658ee5a10abmr2551797b3.2.1720807957092; Fri, 12 Jul 2024
 11:12:37 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:10:53 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 12/27] perf c2c: Use perf_tool__init
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
 tools/perf/builtin-c2c.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 88c131d05186..cd2bd573bfc3 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -385,24 +385,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	goto out;
 }
 
-static struct perf_c2c c2c = {
-	.tool = {
-		.sample		= process_sample_event,
-		.mmap		= perf_event__process_mmap,
-		.mmap2		= perf_event__process_mmap2,
-		.comm		= perf_event__process_comm,
-		.exit		= perf_event__process_exit,
-		.fork		= perf_event__process_fork,
-		.lost		= perf_event__process_lost,
-		.attr		= perf_event__process_attr,
-		.auxtrace_info  = perf_event__process_auxtrace_info,
-		.auxtrace       = perf_event__process_auxtrace,
-		.auxtrace_error = perf_event__process_auxtrace_error,
-		.ordered_events	= true,
-		.ordering_requires_timestamps = true,
-	},
-};
-
 static const char * const c2c_usage[] = {
 	"perf c2c {record|report}",
 	NULL
@@ -3070,6 +3052,19 @@ static int perf_c2c__report(int argc, const char **argv)
 	data.path  = input_name;
 	data.force = symbol_conf.force;
 
+	perf_tool__init(&c2c.tool, /*ordered_events=*/true);
+	c2c.tool.sample		= process_sample_event;
+	c2c.tool.mmap		= perf_event__process_mmap;
+	c2c.tool.mmap2		= perf_event__process_mmap2;
+	c2c.tool.comm		= perf_event__process_comm;
+	c2c.tool.exit		= perf_event__process_exit;
+	c2c.tool.fork		= perf_event__process_fork;
+	c2c.tool.lost		= perf_event__process_lost;
+	c2c.tool.attr		= perf_event__process_attr;
+	c2c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
+	c2c.tool.auxtrace       = perf_event__process_auxtrace;
+	c2c.tool.auxtrace_error = perf_event__process_auxtrace_error;
+	c2c.tool.ordering_requires_timestamps = true;
 	session = perf_session__new(&data, &c2c.tool);
 	if (IS_ERR(session)) {
 		err = PTR_ERR(session);
-- 
2.45.2.993.g49e7a77208-goog


