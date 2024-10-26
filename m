Return-Path: <linux-kernel+bounces-383156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C29B17E5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9C21F21E51
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A052F1D5CFB;
	Sat, 26 Oct 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTbgIa5h"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC211D5146
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945089; cv=none; b=fiyWhCoSy+QPy+/lIkMvF9VAyaSLnN4NuZKtQ3ghlYzHQp9U8+YMBBsqA8IHd9n9DSr0kaN/C1RbW5MOA2H+EkbojBp+IzEX9RM5boisPQsZ2RovZnD3yIW7EmX9fJo7VsZHKKEqfeyncQVNOegf19MHZm5lWsmzXhPEp0rObpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945089; c=relaxed/simple;
	bh=vZB35SPaUV/ecna2U9vXm56Rzj4+ti0U2yyXIsnH7v4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sdDT80PgEuuqt9GFUYxOr7KaLugkkx0qwOjRnTMduT8yyCNrDJy9K/mrPNMffwmr9y56/UVHEH/U5cFMrrPESuyijHYd3qlj4FvBzbI/hGEnubOPWabs+/3D7wvoC0hWltRJdlcxbzEyKrFCl58NlTCLtVUp2d9MmwDeAj34XFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pTbgIa5h; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d6713619so42448087b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729945086; x=1730549886; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdNDvzlbuJZcRwH/3AdtbsrZFMtP+MFgk5KWwVeQrN0=;
        b=pTbgIa5hI2IAgriHGqHyJlxkOz0rUChEhig5H0wFI+JpUKXabEfmJ+5zk8C12Sh1pi
         Rg7las5fOC8LkWvEttwDIQ2iFQUFieExDNSsi9W9aPMnoTy23zTgNFvguPkmP5a+uYWL
         BiyXpltetJeuXW7hyZb8S5Jqp6srD7xQIxPWFzosmJGKAd72IWHvX6PJteDPEpyLXu9l
         dlrUAAbR2doiFK2tGrcfhtetpTesBUuG9gQ4YHPYMh4EwDcOk4sMJyXY5MW2AOT+8If9
         uzoLTuinaZGMNd8NjBoCDrfCcQYND3Z8M+P8BfFij2ioA+0/rqtHxSlykL9A+mejQPnY
         w+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729945086; x=1730549886;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdNDvzlbuJZcRwH/3AdtbsrZFMtP+MFgk5KWwVeQrN0=;
        b=Y1IJYS+LaxoCYta5eTl/tcH9VmaHHgEIjHD5VIK1c7NsrYfz7KChTjrf7wAILb9mSS
         hjBREOB1ObDjJbr3ZtEAWf3Lskux8d34jYbnFse1BBCyCAZ6evR7v1q/oTv3pBJh9USg
         mT9Gt1fZGUkFLlnODhVl7FGJPu7BYb+Vjae9Ww/iss6v/G60raS1NJSpySNgQnycAS2O
         fXEjXEWTzhHxlqa1sbDFVrmlx/TMJawY+mZwXEh4fb71bLT1Nl6q4eLe/0IOJ42noEkm
         KyKURCSgv0G/Ww2Io7HmFZ8ox3DZiLSnn5HieRHD/c0ZwI+Afz8xCGeq3ckzOhiUosva
         sROg==
X-Forwarded-Encrypted: i=1; AJvYcCXOOaPylY3NakKFqqrsVuURndBeaN9jkOfHIfKzRGrAUBgKiIphqb+EtqLCJQxqpj87SiC5iVfkI6Dwpho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJl6sOD/5EiJ60N7SEJCUCLybGFKMu4lkFLJWWGoYQnBw0AdxT
	O4R1jhDYG9Wa2dpSmnSiYMx8shvWKthiFKwtDfuMY7Dp0MtQzJex8R6Sj29Y6/CzWCV7esNRX8J
	RQEK/6w==
X-Google-Smtp-Source: AGHT+IFOl40mvdVs5SQR71bN1+vwfDx/yPB8F4Q/dtZHVs4/wMyo+J/RvfVAtx7pjhDNaEO8viHyeAKpEpqm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:4bc4:f7cc:83b4:dece])
 (user=irogers job=sendgmr) by 2002:a05:690c:6ac6:b0:6e3:2f0b:b595 with SMTP
 id 00721157ae682-6e9d8b171afmr600867b3.5.1729945086125; Sat, 26 Oct 2024
 05:18:06 -0700 (PDT)
Date: Sat, 26 Oct 2024 05:17:55 -0700
In-Reply-To: <20241026121758.143259-1-irogers@google.com>
Message-Id: <20241026121758.143259-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 1/4] perf evsel: Add pmu_name helper
From: Ian Rogers <irogers@google.com>
To: Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add helper to get the name of the evsel's PMU. This handles the case
where there's no sysfs PMU via parse_events event_type helper.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 10 ++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f780e30aa259..87ed417df133 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -236,6 +236,16 @@ int evsel__object_config(size_t object_size, int (*init)(struct evsel *evsel),
 	return 0;
 }
 
+const char *evsel__pmu_name(const struct evsel *evsel)
+{
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
+
+	if (pmu)
+		return pmu->name;
+
+	return event_type(evsel->core.attr.type);
+}
+
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
 int __evsel__sample_size(u64 sample_type)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 04934a7af174..5774a9d4d725 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -232,6 +232,7 @@ int evsel__object_config(size_t object_size,
 			 void (*fini)(struct evsel *evsel));
 
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel);
+const char *evsel__pmu_name(const struct evsel *evsel);
 bool evsel__is_aux_event(const struct evsel *evsel);
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx);
-- 
2.47.0.163.g1226f6d8fa-goog


