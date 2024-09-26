Return-Path: <linux-kernel+bounces-340875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A69878A2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E384DB27D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11664175D39;
	Thu, 26 Sep 2024 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3BS99bI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465316130C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373052; cv=none; b=C8tCZaeOI6o0e+PkUlaVTQLlDZU+fAHPMhMbNkh8210NGzge9Ec0JIsRVKhEQMGN4mPb4fcBuvEaaqcJd1vU+T1LgKJN53DYdW0Ui51FlHxdTcIxXb9dNKngT+R1qb6Q2r8fAw63W1cKlR8u6lZot3Alwfcc1EvV5KU09NOVgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373052; c=relaxed/simple;
	bh=egU+JRq5zJ/3JrO5ch0P/p+Vl0UFLJDwub0/CYxdYyQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XkQb+E4nSRRgKNtwrcbne+egViZ9B0t8x1356h28mW4Sk4Hxf2I2NsW2hRit+RboY4SEvrGL6BN4/seYQbjnFMPr7APhyM4ipwYRCPNvRlWPHD9ehCgCYKWMfrUqoc0uWlc/xn07FP3Ame31CGo2QMyjyf5HkNMPjZlnNGQl3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3BS99bI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1159159528so3323529276.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373050; x=1727977850; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWTw2m6OLTHCiq0NERonkl+tqkB/BNfoqUOBImnOSso=;
        b=w3BS99bIT1uVfzdaGXy9lgW2+JoK/2iAtn7/VJ69DTPDcLNT+kXE1NpLQCgeUKfyfP
         esPz9KGZ/oTYphI2KwmQwCA+cRTwnJFO1KtsXnr+RjrElsMXOWGMBt5JrWwQ97HB2o9j
         8vBdBc2SJk5GecVWXvCr1EI+TbHluVliGgyeAqGiwSN5DHB1oLNpHtR5zFF4St5Gg28D
         8odwUrvcJAOyn6jWfih6ukEsvJxhjAkw7WiwmZdi08INKb79t50ni5DgiehANfRhRbff
         royF9XhiWNjgRiAZ7nR+Pq6d49ZoKzr6X3qkT/zRBwXhW6bhBE3FzwRJw/oXcIiPIXfW
         9heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373050; x=1727977850;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWTw2m6OLTHCiq0NERonkl+tqkB/BNfoqUOBImnOSso=;
        b=Iu0uETHMYnTdSm2FcGka3LvxGPJ/KD0c+/xQhSv9CioeJcJ6Fqfva7KIIlduMYaNuJ
         H/ugGXrdGx3wmdJI4cKQ7/hf+tvzDKYRm/1b1/w7LDXxWOG/oNGPYrRGINqHuPVPm0PS
         kv27N0R7D1Jl6Cu5s01C7VFgQH0q+uDNLVmV7iUeQoXFyPg7ClqY+SUBEBBT7+Q7h4sn
         pDzE8yvpW8U8Y+OONbD1lfYq6+Iobr2bKdfM+HQHqSRC350jPOrmeDI820b2GDsCP4RD
         4BRDNVtgomq6UunilZzZ2vuL4nbBsa5qBVcLywwtPAkGmmQqB+HV8zPe6GqrDVfVaYxT
         F72g==
X-Forwarded-Encrypted: i=1; AJvYcCXfhkg8xyRbitiaVrGv3NYqQalTSLaF7xamwcKbSbZz4Ypz8nzo7l6R8k0Hhk1BsnkSQ0ceaK4CWC8+2Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQn8pso0hJxsI2e5ODVcF2xKgwcZhQBeDMLra/NVakvVvNTGb+
	SOB4yirnbkE/D0FiF5GbeWbSEdoHyY8yaVwyXvILsNBote7Ce/DElnqcJ2uKZ/8tbyUqbhw5bzT
	5C/qlwQ==
X-Google-Smtp-Source: AGHT+IG9cJRsAidTswzFIidnw/T9p9Qlh+fE6MW9b8dNL/qglttpAGie9Lu98APECpzvDjCNr63PJIhvPt57
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:6902:2:b0:e25:e2af:7e7b with SMTP id
 3f1490d57ef6-e25e2b00185mr20985276.0.1727373050001; Thu, 26 Sep 2024 10:50:50
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:16 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 03/22] perf jevents: Add smi metric group for Intel models
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

Allow duplicated metric to be dropped from json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f875eb844c78..f34b4230a4ee 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
@@ -56,6 +56,24 @@ def Rapl() -> MetricGroup:
                      description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
+def Smi() -> MetricGroup:
+    aperf = Event('msr/aperf/')
+    cycles = Event('cycles')
+    smi_num = Event('msr/smi/')
+    smi_cycles = Select(Select((aperf - cycles) / aperf, smi_num > 0, 0),
+                        has_event(aperf),
+                        0)
+    return MetricGroup('smi', [
+        Metric('smi_num', 'Number of SMI interrupts.',
+               Select(smi_num, has_event(smi_num), 0), 'SMI#'),
+        # Note, the smi_cycles "Event" is really a reference to the metric.
+        Metric('smi_cycles',
+               'Percentage of cycles spent in System Management Interrupts. '
+               'Requires /sys/devices/cpu/freeze_on_smi to be 1.',
+               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
+    ], description = 'System Management Interrupt metrics')
+
+
 def main() -> None:
   global _args
 
@@ -81,6 +99,7 @@ def main() -> None:
   all_metrics = MetricGroup("", [
       Idle(),
       Rapl(),
+      Smi(),
   ])
 
 
-- 
2.46.1.824.gd892dcdcdd-goog


