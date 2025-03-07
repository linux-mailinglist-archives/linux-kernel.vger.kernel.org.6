Return-Path: <linux-kernel+bounces-550309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E86FA55DBE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E1B174687
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8BD18E368;
	Fri,  7 Mar 2025 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1a9Nwdp3"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1F18C337
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315159; cv=none; b=CRPWGhwtheWyR5L1Bz/B4FiDW1JuUtklX2QPHJil7ndq2ROgEAog8k+sg9VNeMVYsC4CdCHpcWgoi0f/Miw308GVz0TQ9p4ycBEzJn0h9c6U0FET98gjYivHKQB3Wxmxcv0tujUrTmGW+GrHDX1ReBztlFncxizjtRMbYaS/rfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315159; c=relaxed/simple;
	bh=iqG3XkWRBPttmCCbkNtgJ25Z4WythQO6E5K24EXEX3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iw6zO4DZpvBjjuIUNWsOX7Dxbcn5pnwSXCvcJhicnkm6Y7yov+ZOObaUWtx0RRLSTmXHai9feH9zh3618gZXbquoeKKmbzQi2oPhDSi+IJrI9os5QmDYaXcaoBfcza5nsO1VnAANkdhI+WY53XuIFiG0jPInLfk1DF8OB5Vg2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1a9Nwdp3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2feb47c6757so2366137a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 18:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741315157; x=1741919957; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KPBN3yXUjkpdSLG1dni/WGsuJHBEZ19aO4r2Wk7bmj0=;
        b=1a9Nwdp3RNDeMa1v8lI8a0TLMDHGfbh75kulSknTlRuVllvBylQSJH46EzQkII9JGj
         jjIv68m6QtEy1/dI54woUZfLEhLrK75P+Y6DALGzJS7oAbgFuara9YAl/U5j3r1OMWai
         6TR5Mj/CMgJ5mtaH/AU7Hb1/jd7kJt6fZ/Gd22uSGg+iLA5uc0hUoUwaF5RP/c+bxCkQ
         1JgyKUCvgvoCnpQEMktjAN8Bf4M1fkCPn76MHydlfB5CneNt6Ye232SxVJBhRQFEANQ6
         sstHDU/1OnvIVP6l+nz8WSdgcuqGAH4bXIt1uhPmTjbV46FBv9hqfTvSBp9TefPqAhLD
         wnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315157; x=1741919957;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPBN3yXUjkpdSLG1dni/WGsuJHBEZ19aO4r2Wk7bmj0=;
        b=VPfYrpnXa563LENs8vNo8PfL9PEq35RIh0094a6CmhwMaA/D7d/H4BYIBffF6DeVP7
         P6TnMtWLpNZVlet8AIrvnjWhX1jStEj9IxvwAmcpk538I+WnNWsG/6Bk7duzlibEq/JL
         LciW5yQo+QfmorGAw55YOQvxSoeazzOg3Ks3bAZph6OsMj3qvfoxDVeaEGE0fyUtkJVG
         E3956G94zFR9bH7yfAd8FPS6RlQPWlmMoJrmp5pG/53ntMIZfPo9tnI3zNROCbYThJ6k
         5fPl0PSM4tDRCKuKWA8W90mpWU2yyn+4MyHQaM/17RJCfjIy+9erH2fS8cde5ccvc5+8
         XlSA==
X-Forwarded-Encrypted: i=1; AJvYcCXGlJ0dLAFhRo0ueNl9G49cB3F0YvaS1u1zGLZt9OQogroyvf3M9pZP0B2884bnOBGGWtkEpi+QYMpY63k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxip/C3H/YUbeITbE1DVo2phDmz1mEhDm/SSolIbtimW1BKOJah
	NRZP7hyHhNN7MlUzSL01kg09a2VrwSDeeKxUZvtGQMVRQl+6AUXV5Ny37J4c4zRiVAwtLefNbTY
	7sgm6UA==
X-Google-Smtp-Source: AGHT+IG/b0hXfWY5ZRlwruhM4tAtMOk8s3jJ+EevpJ3fgIu+EuawoslSbZhkRzSkJ/I8qE89wS6GDaFWoThH
X-Received: from pji13.prod.google.com ([2002:a17:90b:3fcd:b0:2ff:4ba2:f3a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e86:b0:2fe:8f9f:e5f0
 with SMTP id 98e67ed59e1d1-2ff7cea0212mr2324134a91.19.1741315157159; Thu, 06
 Mar 2025 18:39:17 -0800 (PST)
Date: Thu,  6 Mar 2025 18:39:05 -0800
In-Reply-To: <20250307023906.1135613-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307023906.1135613-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307023906.1135613-4-irogers@google.com>
Subject: [PATCH v2 4/5] perf x86 evlist: Update comments on topdown regrouping
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Update to remove comments about groupings not working and with the:
```
perf stat -e "{instructions,slots},{cycles,topdown-retiring}"
```
case that now works.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index ed205d1b207d..7905a28d7734 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -39,28 +39,13 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 	 *         26,319,024      slots
 	 *          2,427,791      instructions
 	 *          2,683,508      topdown-retiring
-	 *
-	 * If slots event and topdown metrics events are not in same group, the
-	 * topdown metrics events must be first event after the slots event group,
-	 * otherwise topdown metrics events can't be regrouped correctly, e.g.
-	 *
-	 * a. perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
-	 *    WARNING: events were regrouped to match PMUs
-	 *     Performance counter stats for 'CPU(s) 0':
-	 *         17,923,134      slots
-	 *          2,154,855      instructions
-	 *          3,015,058      cycles
-	 *    <not supported>      topdown-retiring
-	 *
-	 * If slots event and topdown metrics events are in two groups, the group which
-	 * has topdown metrics events must contain only the topdown metrics event,
-	 * otherwise topdown metrics event can't be regrouped correctly as well, e.g.
-	 *
-	 * a. perf stat -e "{instructions,slots},{topdown-retiring,cycles}" -C0 sleep 1
+	 * e. slots event and metrics event are in a group and not adjacent
+	 *    perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
 	 *    WARNING: events were regrouped to match PMUs
-	 *    Error:
-	 *    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
-	 *    event (topdown-retiring)
+	 *         68,433,522      slots
+	 *          8,856,102      topdown-retiring
+	 *          7,791,494      instructions
+	 *         11,469,513      cycles
 	 */
 	if (topdown_sys_has_perf_metrics() &&
 	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


