Return-Path: <linux-kernel+bounces-340854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDB098787D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E183280AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2A6165EE3;
	Thu, 26 Sep 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALJyv47Y"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616D158210
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372475; cv=none; b=W8Pj0u6jYvOGMxL9BpAwCBoHa49PSyE8QaOYc0AsZsMxrwB5S3NkqwxyEcCvQG5pPgkBQuwyvXZddw0jPe9p67EqZMzzx+NhuoMtfEtSj4u92qdV98uVsa9eshUNao0m0fkWh7x7M9zM1T+PQOZ5wx6PCapTtEb9BLPVTA1mvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372475; c=relaxed/simple;
	bh=dZK8r+8VpwvFwBOZ5Q4FjoB9cAMBGUuaJhkGwdfIufU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=blItKuQO7Tkqk2fP1FvUPJUDNUh+hO6y6+e9t2In0ydX/wH0m2NDNi6BzoXN2Q05bTmzERHR5hl7XdFanZB1ucd90F7wibPz+ZWPV0UESpilozbhv1E1hm8dpJ7prnpBSwb6oR/M7qttsXz9RzmFQCpFCunFblmxVSpMUNIrCCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALJyv47Y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e24a0daf98eso1516956276.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372473; x=1727977273; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LeLbC6ngW+YwAc8n3COozCri4F3yDzkCov4vOyjgH9M=;
        b=ALJyv47YMLLnwPjD0TJEie8xDMCi3F0t5KgqJX45fm6jvhWzqdpywIYITS7GTEODZx
         0vQFimYzugY7FEucXhGlLgEkx+qXq8t/goGQCSaIbOk7tYY3SNrx8679tbqYLpoHpLWC
         NzCwU3PJxV1KuxMU/jEoTNHIgeVHyoWPaB1OHLPqPkG1wgYSa/kZtsQfT4xD2+GImCV1
         pCNk7cYCsti7g2Tcp0fivN0kF+L6w5sQ8XqkXZrvs1GG/IQ42rNmBvgVleBkKYK75j55
         Xag/DuCOIjciAp8To4Fg/zG99i+UA6OYcqxRcVBfkJ0EK8fR2YwyqIB6Y6O0i5vXkkHg
         uv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372473; x=1727977273;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeLbC6ngW+YwAc8n3COozCri4F3yDzkCov4vOyjgH9M=;
        b=FAsqI1oFeeqsw3we639F7QOYGok6Fs0f6zUtcT54jCKiZSV6C1zSMpZcWI+36/S3df
         f1tI9EXCYo4jtXG2Ly3+DpKVo+pDMDYYflkliIl6peAZHA5vcuhKabRKOsT3lbwTNBsB
         gR20oH1TdGFliSweAIek6UBiRoPZm2aCqYa5s98pNGFOugvihklR54szF0PkDZboouDI
         x4O7cX2ywCXzGeqNVpapnPdyUp6yXYwTIiXV/NjqEKiRmKmxMJ8lmS1vGmMdR+ODg0E8
         vc3eWKOMZ8epynMYh3r4kGUaQeTx0PR69y778EoHDMggQZQd4AcM24z+wQvVObDMMAms
         E8lw==
X-Forwarded-Encrypted: i=1; AJvYcCXrQ8NBZM5MaxBuIQyjITZiMAxSlc2AuokXVEL0FxCv6OFWJN3aaQuqYvhK6vKnjgQETDLBTK/ukJTGJCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUFK1rWaJGyOINaA0B38jcVj5dsqOavDjeBuq5B/ONIjeuQ1O
	bn3wQPeJsKI845VXd8ZE4SDO3uTLcCCg1GTHb3P73BaIfs0ih1hXkq2yiYf8tXNv+IY7VkuDw9d
	ySbAd9w==
X-Google-Smtp-Source: AGHT+IGHg+8J053EMKRlTlQaUqe1XlRMxH6yHtQnTgDBgMMWyTkOxoqh0n3EGcw6O93r9/52E5DY+auweCuK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:8605:0:b0:e0b:ea2e:7b00 with SMTP id
 3f1490d57ef6-e2604b45de0mr125276.5.1727372473074; Thu, 26 Sep 2024 10:41:13
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:51 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 02/12] perf jevents: Add idle metric for AMD zen models
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index fd420466b999..e069b95d6470 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,7 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
-                    LoadEvents, Metric, MetricGroup, Select)
+from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
+                    MetricGroup, Select)
 import argparse
 import json
 import math
@@ -12,6 +13,16 @@ _args = None
 
 interval_sec = Event("duration_time")
 
+def Idle() -> Metric:
+  cyc = Event("msr/mperf/")
+  tsc = Event("msr/tsc/")
+  low = max(tsc - cyc, 0)
+  return Metric(
+      "idle",
+      "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
+      d_ratio(low, tsc), "100%")
+
+
 def Rapl() -> MetricGroup:
   """Processor socket power consumption estimate.
 
@@ -55,6 +66,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Idle(),
       Rapl(),
   ])
 
-- 
2.46.1.824.gd892dcdcdd-goog


