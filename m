Return-Path: <linux-kernel+bounces-368947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40FC9A16EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F5C1F26C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518DF17C68;
	Thu, 17 Oct 2024 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJBV1mmR"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A1B660
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124732; cv=none; b=ad2rgnieRj9N8d/qpm9wy9hXerVi1DMqSAnNm4Ileg5NgWhSA7/ylnKBJzSlPT1UlnXoaIpsRJjh7125jIlF9E4Ry8U2GZwo3KspIOSGdg4J8wSZHsP8Hw991Sa706QeHE+FGBTki5AjqRio29kMLG5qP4IwQszGLrWtkgciqS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124732; c=relaxed/simple;
	bh=A0HGbonvRUijYxz4QecnqBWvuj6TXKdy2v5D53nEWTY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U4HVV2iz83oBNw7J1G9nQbt+a//cZV7+6cGD/OpUsgvabfHuuoeYttRonZxf0vFQEpIG1feOFJMO3t3ZepGDfdyxRXNfHhaqxTzf8liyRE8fjlcTVpcS77gquBtIXbEYbSjsx2veahk+72nitr8T2FNx6qCl6F7eiCf2+69LpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJBV1mmR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2a8355786dso663395276.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124730; x=1729729530; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFoNBRLqrUgqoIcVjkPQD2Pr1/YcjMFPTvmF3zk2fK4=;
        b=IJBV1mmRbXwq/81wfFaBTzWI5361cww8jZ7+vLKT8Vm63Ysijbs+P06OfgkYuf4Lvs
         efNspy+yzjddlcyGDg2WUyv6qUmVTSPC0nLHtsOC+tQO9ETZTEUHli9dqf2F5XDh9Eov
         5liCRIarBvF1alCl6OxmMBUTzH4T0J2fEcDczXC081cIUUWllI+oat3QX8Q/R0cpekFh
         7co2KjnLatg00R4VVq/gfBOOhP6fEXzQGPoW2gfTHkF0Csl6leLxuiZiqWPQUV8pKzDc
         3GOlEGkGwdKKuRfhCYGfIeNI4wGfLCMmkCFHVFzltPnvE6EKualmOIwH7ckOVBkIBQuH
         UGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124730; x=1729729530;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFoNBRLqrUgqoIcVjkPQD2Pr1/YcjMFPTvmF3zk2fK4=;
        b=Rv+X/++ezfFGwe/WTk/3DPq1s3ntmHcaIAlFgAejj+rt/qjjB/kLkUowOnX6AXC7Ak
         2AUFQIR5qac/MNw7b4jYJwU9dqRTUiiO2nQBfun7EFJi7KmZi5XtqIxZ+TCECbbcKBT9
         601x/yxvr2U0KJcrpf9GsaxJYjwrNNWUgV2Jj5ORIeElflaQ//v4xTeIvLYdwwy8Z+6/
         fMpCPpcpOVyKb7WTBJUc3giQ17amp+gYOHfudnIXjm1uuViS+SHzK4x3IMITFaa0GZ5N
         U0J14DS7fB04OhpwtgLCS+V90pLASfzzlH3vRQGfXdS2e6xTqXvgNY6O8yLghIbui1J1
         zYrA==
X-Forwarded-Encrypted: i=1; AJvYcCVowGUba56rYDPvj+fmjYfxnfp4ufGk6OLYcQiZ8wzkPrxLhBrFNsz21xKikXj/su8Wy7gj0FxbQPuRIZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaHRVTyB5xhTSgq7TGD4C+PWpJMAuejP7ic7SvDy/RdQzfI3rm
	jt5marLCIYak6aURHGuK53AWJ06Hb96EVuAzJdzwffA2QKXySGJdCA3DQ2kU/g4qb2stjcCj9rq
	hHA15qw==
X-Google-Smtp-Source: AGHT+IH7A47NlLkmI7JyY+lLOU6RNU024zTixWHwEAwzVgMoGJoUi31CPQwu7Zqb3utm3XVl/ZEc2m8pfELj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:6902:50d:b0:e28:eee0:aaa1 with SMTP id
 3f1490d57ef6-e29782e9f6fmr3106276.4.1729124729872; Wed, 16 Oct 2024 17:25:29
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:01 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 01/20] perf bpf-prologue: Remove unused file
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Commit 4a73fca22692 ("perf bpf-prologue: Remove unused file") missed
cleaning up the header file. The code was unnecessary as Commit
3d6dfae88917 ("perf parse-events: Remove BPF event support") removed
building bpf-prologue.c.

Fixes: 4a73fca22692 ("perf bpf-prologue: Remove unused file")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-prologue.h | 37 ----------------------------------
 1 file changed, 37 deletions(-)
 delete mode 100644 tools/perf/util/bpf-prologue.h

diff --git a/tools/perf/util/bpf-prologue.h b/tools/perf/util/bpf-prologue.h
deleted file mode 100644
index 66dcf751ef65..000000000000
--- a/tools/perf/util/bpf-prologue.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2015, He Kuang <hekuang@huawei.com>
- * Copyright (C) 2015, Huawei Inc.
- */
-#ifndef __BPF_PROLOGUE_H
-#define __BPF_PROLOGUE_H
-
-struct probe_trace_arg;
-struct bpf_insn;
-
-#define BPF_PROLOGUE_MAX_ARGS 3
-#define BPF_PROLOGUE_START_ARG_REG BPF_REG_3
-#define BPF_PROLOGUE_FETCH_RESULT_REG BPF_REG_2
-
-#ifdef HAVE_BPF_PROLOGUE
-int bpf__gen_prologue(struct probe_trace_arg *args, int nargs,
-		      struct bpf_insn *new_prog, size_t *new_cnt,
-		      size_t cnt_space);
-#else
-#include <linux/compiler.h>
-#include <errno.h>
-
-static inline int
-bpf__gen_prologue(struct probe_trace_arg *args __maybe_unused,
-		  int nargs __maybe_unused,
-		  struct bpf_insn *new_prog __maybe_unused,
-		  size_t *new_cnt,
-		  size_t cnt_space __maybe_unused)
-{
-	if (!new_cnt)
-		return -EINVAL;
-	*new_cnt = 0;
-	return -ENOTSUP;
-}
-#endif
-#endif /* __BPF_PROLOGUE_H */
-- 
2.47.0.105.g07ac214952-goog


