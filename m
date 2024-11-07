Return-Path: <linux-kernel+bounces-399444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFA29BFEEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1294F2828B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84A1DFE28;
	Thu,  7 Nov 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2L0//W6C"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754121DF96A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963775; cv=none; b=qbSlbciG/8Gxd+Bxnra3FJTvZpKarB5aw51wmEzFt0hWdjd0c5rxOXaRdqIt8FJ566GVORX+foi+mKkM2/H+mPW7JD3jI9u4uK6z6OLLjhCurCTceXwgro8vwiYB+U8OHKBLmvgzbQhYPiEAJ+A7EMI88QVWIyKPOusxL4eEqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963775; c=relaxed/simple;
	bh=Y+vKqYUCxSTt4LSzTKZWPT5tUEvVlBLoT2ItWD2c1T0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FGQeFdx4FdaqXyw5TjhpA97Rs7rDLH17ZNoChAQmn3ipt5W86EAESySaA605/tg/kSC4Fz0hekAxlYEEdJqQ4Mex0xJYJLtwPWbxuVIENKbHLdb0oXR/j87ONg3SEmdkuZQJgtMJwzem3vVzYUwKsH+xJ01I1jD5mpGnLnuaADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2L0//W6C; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea7c5805ccso11355467b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 23:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730963772; x=1731568572; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JtSX1ivElzP67Gy896L9Ack6oYznxDX7izzc96bZIU=;
        b=2L0//W6C6v6WJQ9QtLDCW3jCP59/rGYz1ugpp7IhRfoHPSn4DbG7JZKu9JPnULVy5t
         yPWsfuoiJUb1M+C/fB32qB8ZqasoL7Wqv+3YFMTGovON5SmGhwOgpzDqaL9sqsHquEhs
         nxjlAiA/GLm7GV/1RJMo4YyEtvc5n1zD62IVupUzrKcHEEpGsRlpq0dF4DoAIIiwW6x3
         wzMnop52jfYj18sSUzIzesFekizChz7n07m2V7MpoA81tyRbHIlKERh11C4CfOpvPqSR
         +mujjZTKAg7DYXpI02vC2snegUutLUI4AxmEY7SYR4l6NTOk4BuUbtgQYFA04kNWbfTF
         cIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963772; x=1731568572;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0JtSX1ivElzP67Gy896L9Ack6oYznxDX7izzc96bZIU=;
        b=uw2h5Yhs3bW1lBqBPCzCJkan8SQLmTJcrD6LR7ckpC1V29ZkU5dT7mVPh4tv8SQzYY
         KzJ4AluIgSu7+9Dd38RffgOA6cykmeRcc6BrZApZojbryPlqoYZhrdokp42sYuxYNVej
         NYid03oh6dh+CGm7oO8TmYvZgSrgOWrXyyUx9IWkkIsuLF4m67354jxodi+0qPKuGynM
         hB1G+3PbxPOMhQV4PMrRZVxWk/CPa15MUcR3H57pLE1yJlxe7TRk9uIm17Z7UbowdWYe
         n/KRA2DkRXZHQ6hTdmEdJRNZw/kV3wf3kMiP7MeA29RXbSuLTJIXZtOVGqCXDPnbAZWh
         i9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXTAM2fLTtujS4+tt3mEXqsqCTXVVBuPO2hYuHPJxtVmRbTYjMVfjl3G/cUa5izXjIjxsRCrLaNIN/4wEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdxKWvnUvJO5r2g+a44OFMFF5nvvCIm/JqLRPSzO0OfPCECWco
	RQx87H2fd7Xu1dm22aafZDOfFwRhaGkIgdE+o3lDbj+Laeq2phU4y7/qwCHHWgupAixLKtz4h7U
	U15yChA==
X-Google-Smtp-Source: AGHT+IHo4j7jX9RyogLzkobNcoqsPX4PHdOeTPc0u8XD0m/LH7jjhm2PFEQw7af1FfiKXF3NPlnJLAyyNQZP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a05:690c:60c6:b0:6ea:71c3:6cc3 with SMTP
 id 00721157ae682-6ead60ddc27mr1107b3.8.1730963772515; Wed, 06 Nov 2024
 23:16:12 -0800 (PST)
Date: Wed,  6 Nov 2024 23:15:57 -0800
In-Reply-To: <20241107071600.9082-1-irogers@google.com>
Message-Id: <20241107071600.9082-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107071600.9082-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 4/7] perf header: Avoid transitive PMU includes
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Currently satisfied via header.h. Note, pmu.h includes parse-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 2 ++
 tools/perf/util/env.c         | 1 +
 tools/perf/util/probe-event.c | 1 +
 3 files changed, 4 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index e3aa9d4fcf3a..d60f1ac1d720 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -4,6 +4,8 @@
 #include "util/expr.h"
 #include "util/hashmap.h"
 #include "util/header.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
 #include "util/smt.h"
 #include "tests.h"
 #include <math.h>
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 93cabdd7ff43..e2843ca2edd9 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -12,6 +12,7 @@
 #include <sys/utsname.h>
 #include <stdlib.h>
 #include <string.h>
+#include "pmu.h"
 #include "pmus.h"
 #include "strbuf.h"
 #include "trace/beauty/beauty.h"
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a580aa2cd512..d399c7e03341 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -40,6 +40,7 @@
 #include "session.h"
 #include "string2.h"
 #include "strbuf.h"
+#include "parse-events.h"
 
 #include <subcmd/pager.h>
 #include <linux/ctype.h>
-- 
2.47.0.199.ga7371fff76-goog


