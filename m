Return-Path: <linux-kernel+bounces-340899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB99878C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B59281E57
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77C170A19;
	Thu, 26 Sep 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3YyGpck"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42F166F1B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373440; cv=none; b=c1T4ru61VwRcHe0uXtKbPpJ8Zo9K62yTozM90QxerXG8XIfhsGWTQ8dlG3uOe70Qoj5nV8yi5wMM+9Cb0RWjHq/8I1BxChVzBKR5x0sQOsKUIersokKmnm6EvfA3MOdfRsJGc8iWE55O7PEk/DHm15N0wGwMqvzpehEB+Z5A7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373440; c=relaxed/simple;
	bh=9uLixQhexYEA6imqXEa3v4X6fXleSF9FIhDBjlnEiJ4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pYtaevbAA1Z6f2vb1O6U7N83itFlfGOEC766c3LqGT644zR7942bxcfqF7v/hG7bkgUO0OEhIZZ+lw7oqocp7rPvV7bKSKfHvC8/rbVTIgqjjQ43rmpuJ64mwhoAZXn9UDlrNDBwuG5YdUAocZnhdIaN5VObEYig8ZF7Wc66PFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3YyGpck; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e230808455so14729247b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373438; x=1727978238; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udFo6E/pju3YHoUulyNZnzXK1RrI5OJb+7o1iUmnadQ=;
        b=k3YyGpckjph3wR8HQZSk6fyt/iVe+8D/T0JAKxZ0w3YlfDJaXllwaVYpVJwBbfWBYa
         iiNW2r/a0yHLudhm1Wuitd9Uqjuyue1Nt9dKJanLAQcVPt0QC2EwWUfF1z7PiXBFGchk
         hXOu58keEegPIfZAyLjSXsrTLULLgMC08hvlMuAUJ1Z7bQ4z2CGRR7rHOUE1OrLzxzgi
         vEea8NcV4TV2HoIbsH3Cf9okljyx514PGk4E3rxNrja9OZ4lR1BAtwd/0LYWuK+fYb4B
         F3dGXAw90wqjRM00SrZDt3T8xXfttB/4IUuZm/+0MIoqGbbqEoWb1s3nA9HeYpqUPfXi
         wpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373438; x=1727978238;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udFo6E/pju3YHoUulyNZnzXK1RrI5OJb+7o1iUmnadQ=;
        b=mX5NjeIXW3KKKNWOaLvYiZrU0PSIuxoo3tudZPYjxMBw4t/MOQ9v8L5d/Bpf5GMeah
         QvZ6OdJ1RTkCtzqqD5niVjFWKzDtIWsCAo+FAXXdWABcwxtF0aVpYSgMe5pPDsaQpP1K
         VgHT/Tr5xcWXDbf5XSnJx7bkBcfyOwz2RiKktyq26jZ2p2LPYX6shLHi1L4ITD5Fl5VW
         AAZ4fNBicTE4Xf352U7+5za0Va8COOEgy6SNvGr16wOILCFJYQlV+sEknObJVYxM61zP
         i7GmMUVnTMLfUL4V7QkgiZpvisnwKjpNpBuIW7ju8R7zIXFg+VlPgsEDgfup9VtcXpdC
         r1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUGqvJ+BBGhramhiBSnFYPT9tANCUgwc6rpqkg9CMEpBdXnpzHFVD9rlNh+X1du8PIKl4Am6V8ncIwrz7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyReUx1cMRLGkqu4HVAyHyVxy9KL9LbbbRTBuEg431taYHH66JU
	2MsFMTeXsQyAZDDN9oHRNXiRf/Q2KSxQaW5bcvxQR03hQ7OsdkRkDUP4DitDsheyGbl7Cy5QhwU
	GkNAdMQ==
X-Google-Smtp-Source: AGHT+IHVi8yqvGa9OfUAU8KennDk5wmSVWUPULKomoZMuYsMwCOzwW97W3TFRD+WKn9uZQgvDMqzdCTX9AoE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a81:ad08:0:b0:6b0:57ec:c5f9 with SMTP id
 00721157ae682-6e2473aae6emr47347b3.0.1727373438299; Thu, 26 Sep 2024 10:57:18
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:57:09 -0700
In-Reply-To: <20240926175709.410022-1-irogers@google.com>
Message-Id: <20240926175709.410022-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175709.410022-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 2/2] perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Breakdown cycles to user, kernel and guest. Add a common_metrics.py
file for such metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build             |  2 +-
 tools/perf/pmu-events/amd_metrics.py    |  3 +++
 tools/perf/pmu-events/arm64_metrics.py  |  2 ++
 tools/perf/pmu-events/common_metrics.py | 18 ++++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py  |  2 ++
 5 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index f3bc6c093360..91b6837e32c9 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -37,7 +37,7 @@ $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 
-GEN_METRIC_DEPS := pmu-events/metric.py
+GEN_METRIC_DEPS := pmu-events/metric.py pmu-events/common_metrics.py
 
 # Generate AMD Json
 ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 422b119553ff..ccc8ebf13e08 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -4,6 +4,7 @@ from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
                     Metric, MetricGroup, Select)
 import argparse
+from common_metrics import Cycles
 import json
 import math
 import os
@@ -571,6 +572,7 @@ def AmdUpc() -> Metric:
   return Metric("upc", "Micro-ops retired per core cycle (higher is better)",
                 upc, "uops/cycle")
 
+
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
   tsc = Event("msr/tsc/")
@@ -652,6 +654,7 @@ def main() -> None:
       AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
+      Cycles(),
       Idle(),
       Rapl(),
       UncoreL3(),
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index bfac570600d9..5285a22ff0c8 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -3,6 +3,7 @@
 from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
                     LoadEvents, Metric, MetricGroup)
 import argparse
+from common_metrics import Cycles
 import json
 import os
 from typing import Optional
@@ -171,6 +172,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("",[
       Arm64Topdown(),
+      Cycles(),
   ])
 
   if _args.metricgroups:
diff --git a/tools/perf/pmu-events/common_metrics.py b/tools/perf/pmu-events/common_metrics.py
new file mode 100644
index 000000000000..74c58f9ab020
--- /dev/null
+++ b/tools/perf/pmu-events/common_metrics.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (d_ratio, Event, Metric, MetricGroup)
+
+def Cycles() -> MetricGroup:
+  cyc_k = Event("cycles:kHh")
+  cyc_g = Event("cycles:G")
+  cyc_u = Event("cycles:uH")
+  cyc = cyc_k + cyc_g + cyc_u
+
+  return MetricGroup("cycles", [
+      Metric("cycles_total", "Total number of cycles", cyc, "cycles"),
+      Metric("cycles_user", "User cycles as a percentage of all cycles",
+             d_ratio(cyc_u, cyc), "100%"),
+      Metric("cycles_kernel", "Kernel cycles as a percentage of all cycles",
+             d_ratio(cyc_k, cyc), "100%"),
+      Metric("cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
+             d_ratio(cyc_g, cyc), "100%"),
+  ], description = "cycles breakdown per privilege level (users, kernel, guest)")
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index a3a317d13841..4b7668e25e54 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -5,6 +5,7 @@ from metric import (d_ratio, has_event, max, source_count, CheckPmu, Event,
                     Literal, LoadEvents, Metric, MetricConstraint, MetricGroup,
                     MetricRef, Select)
 import argparse
+from common_metrics import Cycles
 import json
 import math
 import os
@@ -1050,6 +1051,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Cycles(),
       Idle(),
       Rapl(),
       Smi(),
-- 
2.46.1.824.gd892dcdcdd-goog


