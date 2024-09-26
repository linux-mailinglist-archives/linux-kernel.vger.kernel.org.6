Return-Path: <linux-kernel+bounces-340878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBFF9878A8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51D01C20A25
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE2183CAF;
	Thu, 26 Sep 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4pgAXbHG"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392651779BC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373059; cv=none; b=F+GiR1U15Ac8QcaFWVtEBmkSND+0EKOIKzkpQkcwTBWUUwOl5rk1y6ySpYYB3UucWgK0ggrwFBzi8TrRgl8dxPSNCZn3l+/77/uPYFBo7icpt/okxxOfCqD09BSpAFGz0w95zT5vOZ/PBxjmXEkfTPtV2WRjmTfki2VaVsI+TLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373059; c=relaxed/simple;
	bh=URHp/eVr0IFpLIfbP+qP759oBFQfHvW0X/+lRmQPJ70=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gBboc+bi9O4CAtVpnH8PwZWHPWr+S5XxKDqFrKbzBdVxYFJXzC/EYmW3aNmH8qJjtQesJNaZtCbJ64lsPTxTWk0rJClUiFdAha3GE5cxCZ/N/2dYem0KTp7yGhRIZsPEDSExcClGhUx3eJnFMVP2C3Ta5Yfn9yNVnKgoWzjnoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4pgAXbHG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-690404fd230so22400067b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373057; x=1727977857; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fa0UU65XkvI3xLAuaBWW48yjVonj7PnPiZA6S98A0a0=;
        b=4pgAXbHGTaxA05xkwfXfYb/OKez9daD1FrlT9sBHSCF616PWI+C1FEx+T6W+2NxrLa
         TOiW3a2QhiQRdKP9j++lOjOu7R80GNepH60W1AkN/lFIKCUnylTZVIx8xoySfwtBM9Ch
         MD4GnWq1Vn6BjwtN98Pa8weBHKCXkBiF8sRu2KFFPbK44nu6CmAQvRj2YWBsUsGSH7M5
         6J+yMjKX3cCJYMm2q5GJi4B2JjuMieUv+6s5pdnLd0OUE9KdmifQxPtOKSIU3CQRI5Mq
         dXdh5iYXFvXCldBh4MCgRjO5/VjV7DV+48gAGAjn7tNlvOPaFGVj2NyZp/CXcC2uRY+Q
         XFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373057; x=1727977857;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fa0UU65XkvI3xLAuaBWW48yjVonj7PnPiZA6S98A0a0=;
        b=OIkBWitc1uEiJnHBnVyyyA8q4R3MFiN5HC0/5BiwK7sjaa4Ho812tClkP1uwDaNXve
         YgGIJhp8X6C+rSpTHYm9Tz6n9/rxRsweoez5O9vrgVWGSP93NUO32qcD1a4WY56ZanH4
         KnGkktXC905ki8Qgwms7yoEYpvRhHdt9V7qqhiyK24/X7zN7cFnimySTXQ/ovhkbR0SV
         gijNPXP/xtyAn+ePecLrjx1Pm+FiJmZmuInDCVoL3kNeZ9vJTIWZ23G02t4DnU0pBZK8
         KiK4VlyRR2yBgIxQfv8cYZK1Z+LqnOGTg5iYNh+CHg70N9qpHbtKuqTm+o7rcfpO/gUN
         Hfqw==
X-Forwarded-Encrypted: i=1; AJvYcCVlWNlH6bfiU1CJEwlh9g25Pg6XPmtCVU1YqWROqZYr7hpjpdsWTBGvT15WXugfP7YnI3mSIDrv5HnXPLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0OO+IPVhXyOwXQzcrpoSxOl1UbI5BvMRNTK9OkwY0GHIDzNbb
	RqVZlsgzOfz1rbfSwytkyZK4m2TgG19vJbDoMNGNMRmC60WJt53Ekl9geA2evURYyRsrc9iOJCK
	rC2wsbA==
X-Google-Smtp-Source: AGHT+IGcz5TtaF6GZtWTpew/CQQp//GrncLvgAcSgMmxC++oh/oBgRb905x9SowNglc8qt16hYxFE4dsxfCB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:b19b:0:b0:e16:67c4:5cd4 with SMTP id
 3f1490d57ef6-e2604b2b0f1mr155276.4.1727373057093; Thu, 26 Sep 2024 10:50:57
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:19 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 06/22] perf jevents: Add tsx metric group for Intel models
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

Allow duplicated metric to be dropped from json files. Detect when TSX
is supported by a model by using the json events, use sysfs events at
runtime as hypervisors, etc. may disable TSX.

Add CheckPmu to metric to determine if which PMUs have been associated
with the loaded events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 52 +++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f34b4230a4ee..58e243695f0a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,13 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
                     MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
@@ -74,6 +75,54 @@ def Smi() -> MetricGroup:
     ], description = 'System Management Interrupt metrics')
 
 
+def Tsx() -> Optional[MetricGroup]:
+  pmu = "cpu_core" if CheckPmu("cpu_core") else "cpu"
+  cycles = Event('cycles')
+  cycles_in_tx = Event(f'{pmu}/cycles\-t/')
+  cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
+  try:
+    # Test if the tsx event is present in the json, prefer the
+    # sysfs version so that we can detect its presence at runtime.
+    transaction_start = Event("RTM_RETIRED.START")
+    transaction_start = Event(f'{pmu}/tx\-start/')
+  except:
+    return None
+
+  elision_start = None
+  try:
+    # Elision start isn't supported by all models, but we'll not
+    # generate the tsx_cycles_per_elision metric in that
+    # case. Again, prefer the sysfs encoding of the event.
+    elision_start = Event("HLE_RETIRED.START")
+    elision_start = Event(f'{pmu}/el\-start/')
+  except:
+    pass
+
+  return MetricGroup('transaction', [
+      Metric('tsx_transactional_cycles',
+             'Percentage of cycles within a transaction region.',
+             Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
+             '100%'),
+      Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
+             Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
+                    has_event(cycles_in_tx),
+                    0),
+             '100%'),
+      Metric('tsx_cycles_per_transaction',
+             'Number of cycles within a transaction divided by the number of transactions.',
+             Select(cycles_in_tx / transaction_start,
+                    has_event(cycles_in_tx),
+                    0),
+             "cycles / transaction"),
+      Metric('tsx_cycles_per_elision',
+             'Number of cycles within a transaction divided by the number of elisions.',
+             Select(cycles_in_tx / elision_start,
+                    has_event(elision_start),
+                    0),
+             "cycles / elision") if elision_start else None,
+  ], description="Breakdown of transactional memory statistics")
+
+
 def main() -> None:
   global _args
 
@@ -100,6 +149,7 @@ def main() -> None:
       Idle(),
       Rapl(),
       Smi(),
+      Tsx(),
   ])
 
 
-- 
2.46.1.824.gd892dcdcdd-goog


