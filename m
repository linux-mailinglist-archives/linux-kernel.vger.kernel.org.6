Return-Path: <linux-kernel+bounces-340881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2AA9878AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A0BB22973
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97A9185B4C;
	Thu, 26 Sep 2024 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Hot7qag"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BB18455A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373067; cv=none; b=rnhTlTMTEQh0fivBSnWiqPinq9MbickZZuKC67J2U/3mU48Glb0Q1cJjLF7x7ceNMwJ0NxlUdBDS92NSbmZUcbkbZ5payfNvT+16J/FF400d9nuoW9KfLWbRxsb5T6vZEIpXP6Cluds5oxFPTFkmpq/c8CEbExzBP2bw0sSZRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373067; c=relaxed/simple;
	bh=hAqjOE9fp1rQtl23ZWK4iSTnmzGmv+G1FolxnETIgtc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bMglvoqrE/9kqgmI3dbIOheftpLx2MWefRzzbohpdq4pJQbM90qRoNy9AvJ+AJpdUEDotYmqeuVR5AP9zuC19hHDzyhAJE1g1f8QW8BvggYhuolzt7KGiUL3A+MI2RzKh5WqFHkfFOQfIiWYFGODWCDyg7mfv5tRdrE1Sn2EB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Hot7qag; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1d10fde51cso2111978276.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373064; x=1727977864; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PriJ3iDjrb1t84/uD8+PU7R2OVSzSS6eZhq1WFLdxrk=;
        b=1Hot7qagEud5mR+y1ZrnnIMU3UWO3iAgOsnppjl3OPl9OBTF9e6vC+ZT9zxY7AVuMS
         /JURgR8FXoZyEhFemTuLuAmHpcfR5Kce2GYwV9+TD+7Wx7CEyjkzqmavFLh6toA+21WC
         Kmoas3UQJ/skX0xmVhZWNHSjv29/YHgE0fzw/10LZcxjsqQctuTkWTpJzeminxvJaIpk
         +IRwYhEGPCH3vvgScS18SdwWx8b7HVAHGHPDCiG1Fw0hXa+yRaqLCwmyk+hClihkuQFH
         azWwS77+Rom9t4ch9mcQCn3a199udrYbkhYbq5Bd23McwYpFHH5+VK4qip/xuPLe+5hc
         ERrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373064; x=1727977864;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PriJ3iDjrb1t84/uD8+PU7R2OVSzSS6eZhq1WFLdxrk=;
        b=giI7YonbKtxuGNQ7xHcH08kmWqhoX6osVHaxRbCKpYQMRm+3BWEBudyjl5jpEU6JIm
         AQ9hHLLBXAONV7sCiJBNYJBkUljrosbEJSWQH+Ic4ezhMbo+VxRNJVm1nuryJ3F6mJFy
         O4vZV3OJoalGgXHcpw+4dlsv8kiCRTLA8eoPRsgNSBDEWxDcmJMGLYfIwwP23hiM9TUj
         mMEWUT1M8m7SknDkC9rLvr+p+3xixF53yTcjJ7D3YA5TuoOe9buuSnDFsvdYc09lmm3l
         8OyHrVVGav8rX+sUBeStDoxCEd+noAXuQKd9+33y60iVBigI1bguWAnAfqPUzAkLnW6E
         BJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjjlgHVr+7GDNjDW34odi0laBIuahDEAP/G3Oxgf0KuV8WmlJHid0PgANC7etrwYDC9UIr0g3EQZnfcdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HFxZ1SHq42oEPssQP0cBYzWYtGnXngHh0S0M/ZwxCnCtRrHq
	C38/ngZ6DKRNZUMzKpPmGoAciXGtDTnVcfB/cj53j/D6J8WrbiqGtPUq8jlJTfcT2L40GgZkmob
	xHcwXGw==
X-Google-Smtp-Source: AGHT+IH1UoCPcntcxKzFTLtNyoMoMgupg2AvFuCO5KDj2u2ml5VTxvE+NPilqqp4dhs2PjPWORTGnL0lp5Pp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:6902:504:b0:e17:8e4f:981a with SMTP id
 3f1490d57ef6-e2604c8fd7emr174276.11.1727373064233; Thu, 26 Sep 2024 10:51:04
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:22 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 09/22] perf jevents: Add ports metric group giving
 utilization on Intel
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

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f4707e964f75..3ef4eb868580 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,13 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, MetricRef, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
 import os
+import re
 from typing import Optional
 
 # Global command line arguments.
@@ -260,6 +261,33 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelPorts() -> Optional[MetricGroup]:
+  pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
+
+  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                      "CPU_CLK_UNHALTED.DISTRIBUTED",
+                      "cycles")
+  # Number of CPU cycles scaled for SMT.
+  smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
+
+  metrics = []
+  for x in pipeline_events:
+    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
+      name = x["EventName"]
+      port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
+      if name.endswith("_CORE"):
+        cyc = core_cycles
+      else:
+        cyc = smt_cycles
+      metrics.append(Metric(port, f"{port} utilization (higher is better)",
+                            d_ratio(Event(name), cyc), "100%"))
+  if len(metrics) == 0:
+    return None
+
+  return MetricGroup("ports", metrics, "functional unit (port) utilization -- "
+                     "fraction of cycles each port is utilized (higher is better)")
+
+
 def IntelSwpf() -> Optional[MetricGroup]:
   ins = Event("instructions")
   try:
@@ -352,6 +380,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelPorts(),
       IntelSwpf(),
   ])
 
-- 
2.46.1.824.gd892dcdcdd-goog


