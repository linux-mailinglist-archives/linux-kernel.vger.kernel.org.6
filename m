Return-Path: <linux-kernel+bounces-340874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B9E9878A1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EDA283941
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81816630E;
	Thu, 26 Sep 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ppn5vRhe"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA62165F19
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373050; cv=none; b=t68K67kd3VcVIGpTn7JwPavIZgTd8H2pdLpQSbRhYDQWAExxjdON7LyErSNCeaRZk/IVg1yPET8tgI7rHqlL2U5pt1qE43OZ9rXtNJGLODYfivTrBfIUcEbaSiZ2+n4LEgTMWfBvAj3g5nj7+U33cXAtjcIuS7Pkpbs6uKvn7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373050; c=relaxed/simple;
	bh=GoLVkIx+SzX2cUWDFke+knoIag/HAuH/ce6K8ZgaVMU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IV5jHFsS2dL8J1Q4p4z6dpi9ofV6NFVLpOHfHdBJjeesNyaPYbuEvcMcTB6Fw0Rm0NMEBFxs8sMjDI9Btu2wz1a3H8BicVXDVU2jrYvBGIEjrdGZlC03OvF3r+MsDY3EAfv24P07Hb2HnwggNR0AlCZR2JQsnMXdtzZkWbKJ6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ppn5vRhe; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso1938916276.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373048; x=1727977848; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rFkxctB45cdt8HIui7pornPPb+0hhzmIGWxBDU/5fLw=;
        b=Ppn5vRheeHw2bJt7c63XdX85WA3VcaseWUkKj2JabiFFrS09SxnSJio9Nag62e1tWt
         De6938+OlLsOvaWFimCPU14x590YHuQzq1aEIITV/kJuUmtsUQVyiPdrEoEoAZFUTzks
         66AlSqj9uA54eeNA+aQ3LoddJ12hTpfMjWa7MM7oIRHNFERlyUG1zViCjFzrBp+ED7GW
         WZew1qfKEQZp79gYPQAH2ma39Qh9Keny+I5JAu1y9G9CuP/sdj/zI8bOBEXvQlgcRqyD
         7Z9HYiZPqyQ0dy285JrNn76fXhOouot1gSDbkuAL4IJ5E3rq82CsNY7aKAvdW3j4ug06
         E8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373048; x=1727977848;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFkxctB45cdt8HIui7pornPPb+0hhzmIGWxBDU/5fLw=;
        b=Kqr2LUXB4o2a8Z7fj0qyQ5DRXFnYK2CuYwR7JW40E1+iAranprQ/yX1SgxkAQfLVGZ
         6dFO+wCp+MBtJ3lMD985ea6peg9TP8xyXqDzCf0n7xsl1WvErWMVBbXWQIlWlPbho7vG
         HykgPbozCGOufH9o8LAa95jH3qdKKHn3WWtDJH/p1WgUlfjItZSTuyDbnBnerZ6KGnJp
         6aElAnmifKHc4iGn5RMtQ6mEZ0vJUtxt+LjJ6axjuzBkLiEfiIMW0lt5p8Loi1LvxGzW
         eEL8eCzggzn4c9XCXDojoNxYc16kV1Z1jgJuLjthDATac8bEPM7RChnQ0PcpBdnW6Z4W
         NUrw==
X-Forwarded-Encrypted: i=1; AJvYcCVbwNxnsBdzRS5fGuHb75TA8UDlIk5Sq2jQO2xWd9y4KETh9efKtbu9mCAir6+fwbRtafAkLr5zFDeG5l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLuhhH7Gy5fOD1IFQshonynJxefueSM0tQtAVFmkbUnezpEHU1
	t7LP4tXoHGoJPQF9PTP1zykGBM8AjoFAcKnHxHihzuxrV6LWgR8ichc37Ix7jDF+MQZq3977+PP
	0FR4Atw==
X-Google-Smtp-Source: AGHT+IHXDo5OBiwMUDxn8GrBoa7HgnHzyjrfsCqkYXGpxEcFumMeT1RMbqcPWRv0eUAt0mdHabZciV+nYCnR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:e906:0:b0:e25:e391:5739 with SMTP id
 3f1490d57ef6-e260495ec2amr367276.0.1727373047920; Thu, 26 Sep 2024 10:50:47
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:15 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 02/22] perf jevents: Add idle metric for Intel models
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 58e23eb48312..f875eb844c78 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
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
@@ -11,6 +12,16 @@ import os
 _args = None
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
   """Processor power consumption estimate.
 
@@ -68,6 +79,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Idle(),
       Rapl(),
   ])
 
-- 
2.46.1.824.gd892dcdcdd-goog


