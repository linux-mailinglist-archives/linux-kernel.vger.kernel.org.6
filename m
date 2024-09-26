Return-Path: <linux-kernel+bounces-340853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA2A98787C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3431C210DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351C3FF1;
	Thu, 26 Sep 2024 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKOGfK3n"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53EF1494AC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372473; cv=none; b=hpXC71mCEc+sxz5V4aTOOzoW/kz1ojA9I9mqcFc1HFZs8goH23ybJA+Xde6PKkTBzP62ETzeZe0jZksSRaAJOs0UdGgA3T71HKdXXyJPq9CWgsoC91GaurHER4ZH23lJLE2yNaMmWNDl3x2zd3r2B7JjPfXteiclbs5ZiupwE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372473; c=relaxed/simple;
	bh=mFTVg8j/2TtNOjQAzKLb7iKFXXB4OcAiF3vc13n5L/U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U3TQYsML50aJIBomNUelwDQxga9dw6kn3bTuF55/DKuEHhBoVyavU3ZuQkCL2i/UzKfCREYn36U7v2qNK9t5ROf0ZIn6s99pl9Qq6CbPEHxYhtyc1j47IOvVll4y1f6i/Kl0oWMcA2JnQW7Zq+HQho6jAO4aGxvg8wG3DTmoSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKOGfK3n; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20993a03dso19287567b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372471; x=1727977271; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkBPEGtCIqqpDTU10F4DiWYCLZlPnDuDYEfthWZqk8w=;
        b=VKOGfK3nbJ7kiHyGDrbvJp4kNLMXgZsMCBtQna0cZUy8GcTuhc3isduvQTxcf9xpbd
         QJWwXifL+stCW67Y/MunYMH24A31RFuM7ZYr8GTHreyOD0SQWjLf/BJTdF/Tisgd5hgu
         CPxeqcFo5M7qclPZLYywo+Zr9s4tKxX128JicfFkXWvuhvhj1SJeTJJN5EKd/77V4h52
         qxrs8Z/TMykV8VxqYyNW8Q/cYN+RswvBJGgs/29Hja2NSKV+IEbrb6i6+k+/i2ntEeQj
         WUDrosVJ+4BR7BsS1ekDlkgPTe5ObHWCq869c2tSk4zL5eBPrsVFqrHZ6JN2zgBoK4YS
         ILuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372471; x=1727977271;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkBPEGtCIqqpDTU10F4DiWYCLZlPnDuDYEfthWZqk8w=;
        b=bUs6Eos4+weg/VneqHS5XyJ5gKXQsZlGyESkmW0269Sdnaxu4TvSq6pl21GsROiO4P
         dR4Wxx9GYy6r61NfvW0uHCdIB4gFyHwc3dBSNWIPYs5f8aH7xeeKNHjRS4dUaG/oBgTN
         SqkUUR62RWKeQfnPXKNI/rf5u2kzLYlwmbdwVV9+uSx+sSBjxsmLn9K/Vw68Uev9scHs
         vMq0GzLTFrY5gnd5qTigG2xgka6S8Pp3lRkMLiQ6wd5B3WG0QiH52p2w94ca48YZNC4f
         NT7I4KAEbAaasu/MJqU4Jmih5M690b4zP8y9mtNVsAPZXWE/ZO8wy72zwk8gqvB5//mR
         arXg==
X-Forwarded-Encrypted: i=1; AJvYcCUciuF8MCSgmy9XpqLGGVNyMBCnoi9436bdcR7HDWN0QqTbgg0ln8Vx45UGck9jNzZ0dBvKDAkLbOE/fbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1fqRH9AgDJofVfedFwaKQJpDEOssvELlIFIN06dAb8GUKUorv
	Xc+trCA5y1ZY4E9nUBajNFbms7PRHsgqE7NrAR71TlHsRikX9MLCCd4pC2K87ZrXNSF9m4y9jdX
	9PszNBw==
X-Google-Smtp-Source: AGHT+IEsDmssvQzOzmmDQdM5hEeFK3/Hl8Kz/QYxQji/WFLMpyjk+anR4B/fLMlnQmOaBrUNCkDYFubVGPsv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:690c:6892:b0:6db:89f0:b897 with SMTP
 id 00721157ae682-6e2475a33eemr24147b3.4.1727372470702; Thu, 26 Sep 2024
 10:41:10 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:50 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 01/12] perf jevents: Add RAPL event metric for AMD zen models
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

Add power per second metrics based on RAPL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 31 +++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 4f728e7aae4a..fd420466b999 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,14 +1,37 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup, Select)
 import argparse
 import json
+import math
 import os
 
 # Global command line arguments.
 _args = None
 
+interval_sec = Event("duration_time")
+
+def Rapl() -> MetricGroup:
+  """Processor socket power consumption estimate.
+
+  Use events from the running average power limit (RAPL) driver.
+  """
+  # Watts = joules/second
+  # Currently only energy-pkg is supported by AMD:
+  # https://lore.kernel.org/lkml/20220105185659.643355-1-eranian@google.com/
+  pkg = Event("power/energy\-pkg/")
+  cond_pkg = Select(pkg, has_event(pkg), math.nan)
+  scale = 2.3283064365386962890625e-10
+  metrics = [
+      Metric("cpu_power_pkg", "",
+             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+  ]
+
+  return MetricGroup("cpu_power", metrics,
+                     description="Processor socket power consumption estimates")
+
+
 def main() -> None:
   global _args
 
@@ -31,7 +54,9 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
-  all_metrics = MetricGroup("",[])
+  all_metrics = MetricGroup("", [
+      Rapl(),
+  ])
 
   if _args.metricgroups:
     print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.46.1.824.gd892dcdcdd-goog


