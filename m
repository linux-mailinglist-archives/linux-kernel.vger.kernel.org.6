Return-Path: <linux-kernel+bounces-215559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7481909475
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6B41F2120A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F379918C323;
	Fri, 14 Jun 2024 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1e08PiRL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30B218755A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406218; cv=none; b=ngmI2SZp4NjuRWoOJ/K2Ug+ZCcMsl213pd8X7TzP7GV9J/HcwHAL4cKfumKbpaxLEVAPhvIYuXR0knqYhJZV7MhJFmSSmGfTGdkPZdCYbUypo+JRKCYoCueu/vJb3rywsb47e0Xv2MM6mWVGO0jpj4N0DVC18zgj9P5nxoqmSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406218; c=relaxed/simple;
	bh=OFjf7JOJWY9rXqLOD83besecDRZUiNbd6AJ/eDYvotw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=YworenAL+aeFf/2Od1gtTXLCGew7mj0lsv6Q171Ok9p81q3UsoLb8yHfrMR6I2/29iAnn5tqX6jTAGUFi0/y+9lF9TxuWkxQ2rOixbZ59QsFAZ15XQWkIBSFAsqdB3+mIUGX4bO82Ui/PQBYHjXBf4o2vPaPVa3NnVXmbDM4dVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1e08PiRL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfec7058deeso5070243276.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718406194; x=1719010994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79nDwGUgwC1jT9YfE5WUHbJ4lOuARaznvk3UKvqKtk8=;
        b=1e08PiRLZO/S7CVCpQgK8aO0u18LIDw55q3OWswh0g6irwJuD8Q4HIvLUVSnY5Z7NV
         53DrpO3WMmdAZWzTf4ExP2hvJxN04qg5Mymf+jDo7TSEGNmREPyze/sl9X3Y2xQaPspR
         3MegByPRBFunInbxbsXmIRKmaD/ZtiqdV02gan5Ocb6yJWbxDFUJeDt2BrigAEpcm/SP
         8lgGKgxdlBu0U8QyjROsuTHxBfNubMxVOPh3iKkhyWzH04THMO8b+HNo3Bkeh/6I9r2h
         Z4u0hlGtcYmQI8OnYvktooXYx2+ATcE3hn5lc2CXoSazInlM4FkwfIEcxhR/B5NgyHwh
         N2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406194; x=1719010994;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=79nDwGUgwC1jT9YfE5WUHbJ4lOuARaznvk3UKvqKtk8=;
        b=KHnIdS4bVkYa+1mZwG36mlhYpNauu1GbnHlUmFMuIpMtz36sZ6JPTuHTzYYg/nkThs
         zEqk9SQk6KgEp2jaIA8ezWfSix348o3Fkmy5zBLI98EcmBRYNwFhJLiBtYn8rjrKI0id
         tCt/QceEy30WTLW6IodvM7bPlfWF9SpGt7x8mgAHiGXBbK7vyrFEi6dR3eNzDV3KM8Uz
         zc6qlltsD9+FJFC7amO7TtoUwodjQoQGmXw5urPKcNujzrKgO2u9/rntm9Cvyt1hhFZN
         gha2cRM4Vo2z67jxeVbbH3GY9UP7OVRobDGcuifDinRo/aU9DHMEqh6gKAKuztArl9iQ
         fkSg==
X-Forwarded-Encrypted: i=1; AJvYcCUhfYxY0VLF5Gx01TGx9dJfZn6AWI7z3QpHsfVtx+Jn5UEVw7mradGJbrI4nifbIUTdfhVVCVdl+BiEARq/03nMIPtShxeJRttsqu3I
X-Gm-Message-State: AOJu0YxaUsYMDQj8dpIBEQE0Xey325vp5RJBSQ9TzJCs4aX4WUN7K5gp
	YZKjRa8gqQp9s9egkRkTcW96F09H6Q9ijZmYZ/fUMu10bAGjurcVHEM1spYX9GxfWcsJ97gdmbK
	0/OoUHA==
X-Google-Smtp-Source: AGHT+IFac5HaTQcjjzYc5BZRrQq3LkqnqLmMaU0BTpSQytNqfo2KXfHEhFqGFLclUlEGx7LgRMWc31f3DdeI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:714a:5e65:12a1:603])
 (user=irogers job=sendgmr) by 2002:a05:6902:72a:b0:dfb:1147:cbaa with SMTP id
 3f1490d57ef6-dff154e527fmr1156301276.10.1718406193722; Fri, 14 Jun 2024
 16:03:13 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:01:20 -0700
In-Reply-To: <20240614230146.3783221-1-irogers@google.com>
Message-Id: <20240614230146.3783221-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614230146.3783221-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v1 12/37] perf vendor events: Update/add grandridge events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Weilin Wang <weilin.wang@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.02 to v1.03.
Add TMA metrics v4.8.

Bring in the event updates v1.03:
https://github.com/intel/perfmon/commit/5ec7a252d0f6ec461f80cc397c9ac25abcd=
9184f

The TMA 4.8 information was added in:
https://github.com/intel/perfmon/commit/59194d4d90ca50a3fcb2de0d82b9f6fc0c9=
a5736

New events are:
FP_INST_RETIRED.128B_DP,
FP_INST_RETIRED.128B_SP,
FP_INST_RETIRED.256B_DP,
FP_INST_RETIRED.32B_SP,
FP_INST_RETIRED.64B_DP,
OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM,
OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD,
OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM,
OCR.STREAMING_WR.ANY_RESPONSE.

Co-authored-by: Weilin Wang <weilin.wang@intel.com>
Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/grandridge/cache.json |  97 +-
 .../arch/x86/grandridge/counter.json          |  42 +
 .../arch/x86/grandridge/floating-point.json   |  54 +-
 .../arch/x86/grandridge/frontend.json         |   5 +-
 .../arch/x86/grandridge/grr-metrics.json      | 849 ++++++++++++++++++
 .../arch/x86/grandridge/memory.json           |  13 +-
 .../arch/x86/grandridge/metricgroups.json     |  23 +
 .../pmu-events/arch/x86/grandridge/other.json |  15 +-
 .../arch/x86/grandridge/pipeline.json         |  97 +-
 .../arch/x86/grandridge/uncore-cache.json     | 267 ++++++
 .../x86/grandridge/uncore-interconnect.json   |  30 +
 .../arch/x86/grandridge/uncore-io.json        | 181 ++++
 .../arch/x86/grandridge/uncore-memory.json    |  66 ++
 .../arch/x86/grandridge/uncore-power.json     |   1 +
 .../arch/x86/grandridge/virtual-memory.json   |  17 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 16 files changed, 1693 insertions(+), 66 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.j=
son
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/metricgroups.=
json

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/cache.json b/tools/p=
erf/pmu-events/arch/x86/grandridge/cache.json
index f937ba0e50e1..04802e254e51 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/cache.json
@@ -1,22 +1,25 @@
 [
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 =
cache. Counts on a per core basis.",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 core has access to an L3 cache, the LLC is the L3 cache, otherwise it is t=
he L2 cache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 c=
ache. Counts on a per core basis.",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
core has access to an L3 cache, the LLC is the L3 cache, otherwise it is th=
e L2 cache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x4f"
     },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an instruction cache or TLB miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x35",
         "EventName": "MEM_BOUND_STALLS_IFETCH.ALL",
         "SampleAfterValue": "1000003",
@@ -24,6 +27,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x35",
         "EventName": "MEM_BOUND_STALLS_IFETCH.L2_HIT",
         "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the L2 cache.",
@@ -32,6 +36,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an icache or itlb miss which hit in the LLC.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x35",
         "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_HIT",
         "SampleAfterValue": "1000003",
@@ -39,6 +44,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an icache or itlb miss which missed all the caches.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x35",
         "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_MISS",
         "SampleAfterValue": "1000003",
@@ -46,6 +52,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an L1 demand load miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS_LOAD.ALL",
         "SampleAfterValue": "1000003",
@@ -53,6 +60,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS_LOAD.L2_HIT",
         "PublicDescription": "Counts the number of cycles a core is stalle=
d due to a demand load which hit in the L2 cache.",
@@ -61,6 +69,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT",
         "SampleAfterValue": "1000003",
@@ -68,6 +77,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the local cache=
s.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS",
         "SampleAfterValue": "1000003",
@@ -75,62 +85,63 @@
     },
     {
         "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of load ops retired that hi=
t the L1 data cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of load ops retired that mi=
ss in the L1 data cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
     {
         "BriefDescription": "Counts the number of load ops retired that hi=
t in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of load ops retired that mi=
ss in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x1c"
     },
     {
         "BriefDescription": "Counts the number of loads that hit in a writ=
e combining buffer (WCB), excluding the first load that caused the WCB to a=
llocate.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.WCB_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.ALL",
         "SampleAfterValue": "20003",
@@ -138,6 +149,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a load buffer full condition.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
         "SampleAfterValue": "20003",
@@ -145,6 +157,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to an RSV full condition.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.RSV",
         "SampleAfterValue": "20003",
@@ -152,6 +165,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a store buffer full condition.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
         "SampleAfterValue": "20003",
@@ -159,179 +173,210 @@
     },
     {
         "BriefDescription": "Counts the number of load ops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x81"
     },
     {
         "BriefDescription": "Counts the number of store ops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x82"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x800",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
         "BriefDescription": "Counts the number of load uops retired that p=
erformed one or more locks",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
     {
         "BriefDescription": "Counts the number of memory uops retired that=
 were splits.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x43"
     },
     {
         "BriefDescription": "Counts the number of retired split load uops.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
     {
         "BriefDescription": "Counts the number of retired split store uops=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x42"
     },
     {
         "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
-        "PEBS": "2",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to an icache miss",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ICACHE",
         "SampleAfterValue": "1000003",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/counter.json b/tools=
/perf/pmu-events/arch/x86/grandridge/counter.json
new file mode 100644
index 000000000000..9fd5d8ad6d3b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/grandridge/counter.json
@@ -0,0 +1,42 @@
+[
+    {
+        "Unit": "core",
+        "CountersNumFixed": "3",
+        "CountersNumGeneric": "8"
+    },
+    {
+        "Unit": "B2CMI",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "CHA",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "IMC",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "IIO",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "IRP",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "PCU",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "CHACMS",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json =
b/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
index 00c9a8ae0f53..5266eed969be 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/floating-point.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of cycles when any of the f=
loating point dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xcd",
         "EventName": "ARITH.FPDIV_ACTIVE",
@@ -9,48 +10,89 @@
     },
     {
         "BriefDescription": "Counts the number of all types of floating po=
int operations per uop with all default weighting",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "FP_FLOPS_RETIRED.ALL",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to FP_FLOPS_RETIRED.FP64]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Deprecated": "1",
         "EventCode": "0xc8",
         "EventName": "FP_FLOPS_RETIRED.DP",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of floating point operation=
s that produce 32 bit single precision results [This event is alias to FP_F=
LOPS_RETIRED.SP]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "FP_FLOPS_RETIRED.FP32",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of floating point operation=
s that produce 64 bit double precision results [This event is alias to FP_F=
LOPS_RETIRED.DP]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc8",
         "EventName": "FP_FLOPS_RETIRED.FP64",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to FP_FLOPS_RETIRED.FP32]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Deprecated": "1",
         "EventCode": "0xc8",
         "EventName": "FP_FLOPS_RETIRED.SP",
-        "PEBS": "1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the total number of  floating point re=
tired instructions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.128B_DP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a packed 128 bit single precision floating point. This may b=
e SSE or AVX.128 operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.128B_SP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a packed 256 bit double precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.256B_DP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a scalar 32bit single precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.32B_SP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a scalar 64 bit double precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.64B_DP",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PublicDescription": "Counts the number of floating point operatio=
ns retired that required microcode assist, which is not a reflection of the=
 number of FP operations, instructions or uops.",
@@ -59,9 +101,9 @@
     },
     {
         "BriefDescription": "Counts the number of floating point divide uo=
ps retired (x87 and sse, including x87 sqrt).",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.FPDIV",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     }
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/frontend.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/frontend.json
index 356d36aecc81..7cdf611efb23 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/frontend.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the total number of BACLEARS due to al=
l branch types including conditional and unconditional jumps, returns, and =
indirect branches.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.ANY",
         "PublicDescription": "Counts the total number of BACLEARS, which o=
ccur when the Branch Target Buffer (BTB) prediction or lack thereof, was co=
rrected by a later branch predictor in the frontend.  Includes BACLEARS due=
 to all branch types including conditional and unconditional jumps, returns=
, and indirect branches.",
@@ -9,14 +10,15 @@
     },
     {
         "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "SampleAfterValue": "200003",
@@ -24,6 +26,7 @@
     },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump and the instruction cache registers bytes are not present=
. -",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "SampleAfterValue": "200003",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json b/t=
ools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
new file mode 100644
index 000000000000..07e542297e93
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
@@ -0,0 +1,849 @@
+[
+    {
+        "BriefDescription": "C1 residency percent per core",
+        "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C1_Core_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C6 residency percent per module",
+        "MetricExpr": "cstate_module@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Module_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C6 residency percent per package",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
+        "MetricName": "cpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "CPU operating frequency (in GHz)",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC =
* #SYSTEM_TSC_FREQ / 1e9",
+        "MetricName": "cpu_operating_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Percentage of time spent in the active CPU po=
wer state C0",
+        "MetricExpr": "tma_info_system_cpu_utilization",
+        "MetricName": "cpu_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte page sizes) caused by demand data loads to the total number of c=
ompleted instructions",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRE=
D.ANY",
+        "MetricName": "dtlb_2nd_level_2mb_large_page_load_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte page sizes) caused by demand data loads to the total number of =
completed instructions. This implies it missed in the Data Translation Look=
aside Buffer (DTLB) and further levels of TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
+        "MetricName": "dtlb_2nd_level_load_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricName": "dtlb_2nd_level_store_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e6 / durati=
on_time",
+        "MetricName": "io_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM + UNC_CHA_TOR_INSERTS.=
IO_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
+        "MetricName": "itlb_2nd_level_large_page_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
+        "MetricName": "itlb_2nd_level_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB.",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
+        "MetricExpr": "ICACHE.MISSES / INST_RETIRED.ANY",
+        "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L1_HIT / INST_RETIRED.ANY",
+        "MetricName": "l1d_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L2_HIT / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of requests missing L2 cache =
(includes code+data+rfo w/ prefetches) to the total number of completed ins=
tructions",
+        "MetricExpr": "LONGEST_LAT_CACHE.REFERENCE / INST_RETIRED.ANY",
+        "MetricName": "l2_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_CRD + UNC_CHA_TOR_INSE=
RTS.IA_MISS_CRD_PREF) / INST_RETIRED.ANY",
+        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT + UNC_CHA_TOR_=
INSERTS.IA_MISS_DRD_OPT_PREF + UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA) / I=
NST_RETIRED.ANY",
+        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) in nano seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_OPT) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_=
CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT) * #num_packages)) * duration_time",
+        "MetricName": "llc_demand_data_read_miss_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Load operations retired per instruction",
+        "MetricExpr": "MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
+        "MetricName": "loads_retired_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT_SCH0.RD + UNC_M_CAS_COUNT_SCH1.RD)=
 * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT_SCH0.RD + UNC_M_CAS_COUNT_SCH1.RD =
+ UNC_M_CAS_COUNT_SCH0.WR + UNC_M_CAS_COUNT_SCH1.WR) * 64 / 1e6 / duration_=
time",
+        "MetricName": "memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT_SCH0.WR + UNC_M_CAS_COUNT_SCH1.WR)=
 * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Percentage of cycles spent in System Manageme=
nt Interrupts.",
+        "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0=
 else 0)",
+        "MetricGroup": "smi",
+        "MetricName": "smi_cycles",
+        "MetricThreshold": "smi_cycles > 0.1",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Number of SMI interrupts.",
+        "MetricExpr": "msr@smi@",
+        "MetricGroup": "smi",
+        "MetricName": "smi_num",
+        "ScaleUnit": "1SMI#"
+    },
+    {
+        "BriefDescription": "Store operations retired per instruction",
+        "MetricExpr": "MEM_UOPS_RETIRED.ALL_STORES / INST_RETIRED.ANY",
+        "MetricName": "stores_retired_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to certain allocation restrictions",
+        "MetricExpr": "tma_core_bound",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricName": "tma_allocation_restriction",
+        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core_b=
ound > 0.1 & tma_backend_bound > 0.1)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend due to backend stalls",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_backend_bound",
+        "MetricThreshold": "tma_backend_bound > 0.1",
+        "MetricgroupNoGroup": "TopdownL1",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.ALL_P / (6 * CPU_CLK_UNHALT=
ED.CORE)",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_bad_speculation",
+        "MetricThreshold": "tma_bad_speculation > 0.15",
+        "MetricgroupNoGroup": "TopdownL1",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BACLEARS, which occurs when the Branch T=
arget Buffer (BTB) prediction or lack thereof, was corrected by a later bra=
nch predictor in the frontend",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / (6 * CPU_CLK_UNHAL=
TED.CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricName": "tma_branch_detect",
+        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
+        "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s.",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to branch mispredicts",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / (6 * CPU_CLK_U=
NHALTED.CORE)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricName": "tma_branch_mispredicts",
+        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
+        "MetricgroupNoGroup": "TopdownL2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BTCLEARS, which occurs when the Branch T=
arget Buffer (BTB) predicts a taken branch.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / (6 * CPU_CLK_UNHA=
LTED.CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricName": "tma_branch_resteer",
+        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS).",
+        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / (6 * CPU_CLK_UNHALTED.CORE)=
",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricName": "tma_cisc",
+        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are bounded by core restrictions and not attributed to an o=
utstanding load or stores, or resource limitation",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / (6 * CPU_CLK_=
UNHALTED.CORE)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricName": "tma_core_bound",
+        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
+        "MetricgroupNoGroup": "TopdownL2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / (6 * CPU_CLK_UNHALTED.COR=
E)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricName": "tma_decode",
+        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that does not require the =
use of microcode, classified as a fast nuke, due to memory ordering, memory=
 disambiguation and memory renaming",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / (6 * CPU_CLK_UNH=
ALTED.CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_fast_nuke",
+        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "MetricThreshold": "tma_frontend_bound > 0.2",
+        "MetricgroupNoGroup": "TopdownL1",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / (6 * CPU_CLK_UNHALTED.COR=
E)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricName": "tma_icache_misses",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / (6 * CPU_CLK_=
UNHALTED.CORE)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricName": "tma_ifetch_bandwidth",
+        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
+        "MetricgroupNoGroup": "TopdownL2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / (6 * CPU_CLK_UN=
HALTED.CORE)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricName": "tma_ifetch_latency",
+        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
+        "MetricgroupNoGroup": "TopdownL2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n",
+        "MetricExpr": "INST_RETIRED.ANY / FP_FLOPS_RETIRED.ALL",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_arith_inst_mix_ipflop"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_INST_RETIRED.128B_DP + FP_IN=
ST_RETIRED.128B_SP)",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_arith_inst_mix_ipfparith_avx128"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction",
+        "MetricExpr": "INST_RETIRED.ANY / FP_INST_RETIRED.64B_DP",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_arith_inst_mix_ipfparith_scalar_dp"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction",
+        "MetricExpr": "INST_RETIRED.ANY / FP_INST_RETIRED.32B_SP",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_arith_inst_mix_ipfparith_scalar_sp"
+    },
+    {
+        "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
+        "MetricExpr": "tma_info_bottleneck_dtlb_miss_bound_cycles",
+        "MetricName": "tma_info_bottleneck_%_dtlb_miss_bound_cycles"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation and retire=
ment is stalled by the Frontend Cluster due to an Ifetch Miss, either Icach=
e or ITLB Miss",
+        "MetricExpr": "tma_info_bottleneck_ifetch_miss_bound_cycles",
+        "MetricGroup": "Ifetch",
+        "MetricName": "tma_info_bottleneck_%_ifetch_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound"
+    },
+    {
+        "BriefDescription": "Percentage of time that retirement is stalled=
 due to an L1 miss",
+        "MetricExpr": "tma_info_bottleneck_load_miss_bound_cycles",
+        "MetricGroup": "Load_Store_Miss",
+        "MetricName": "tma_info_bottleneck_%_load_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound"
+    },
+    {
+        "BriefDescription": "Percentage of time that retirement is stalled=
 by the Memory Cluster due to a pipeline stall",
+        "MetricExpr": "tma_info_bottleneck_mem_exec_bound_cycles",
+        "MetricGroup": "Mem_Exec",
+        "MetricName": "tma_info_bottleneck_%_mem_exec_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound"
+    },
+    {
+        "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
+        "MetricExpr": "100 * (LD_HEAD.DTLB_MISS_AT_RET + LD_HEAD.PGWALK_AT=
_RET) / CPU_CLK_UNHALTED.CORE",
+        "MetricGroup": "Cycles",
+        "MetricName": "tma_info_bottleneck_dtlb_miss_bound_cycles",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation and retire=
ment is stalled by the Frontend Cluster due to an Ifetch Miss, either Icach=
e or ITLB Miss",
+        "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.ALL / CPU_CLK_UNHALTE=
D.CORE",
+        "MetricGroup": "Cycles;Ifetch",
+        "MetricName": "tma_info_bottleneck_ifetch_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of time that retirement is stalled=
 due to an L1 miss",
+        "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.ALL / CPU_CLK_UNHALTED.=
CORE",
+        "MetricGroup": "Cycles;Load_Store_Miss",
+        "MetricName": "tma_info_bottleneck_load_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of time that retirement is stalled=
 by the Memory Cluster due to a pipeline stall",
+        "MetricExpr": "100 * LD_HEAD.ANY_AT_RET / CPU_CLK_UNHALTED.CORE",
+        "MetricGroup": "Cycles;Mem_Exec",
+        "MetricName": "tma_info_bottleneck_mem_exec_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricName": "tma_info_br_inst_mix_ipbranch"
+    },
+    {
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "MetricName": "tma_info_br_inst_mix_ipcall"
+    },
+    {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricName": "tma_info_br_inst_mix_ipfarbranch"
+    },
+    {
+        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
+        "MetricExpr": "INST_RETIRED.ANY / (BR_MISP_RETIRED.COND - BR_MISP_=
RETIRED.COND_TAKEN)",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_ntaken"
+    },
+    {
+        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was taken",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_taken"
+    },
+    {
+        "BriefDescription": "Instructions per retired indirect call or jum=
p Branch Misprediction",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_indirect"
+    },
+    {
+        "BriefDescription": "Instructions per retired return Branch Mispre=
diction",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RETURN",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_ret"
+    },
+    {
+        "BriefDescription": "Instructions per retired Branch Misprediction=
",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricName": "tma_info_br_inst_mix_ipmispredict"
+    },
+    {
+        "BriefDescription": "Ratio of all branches which mispredict",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
+        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_rati=
o"
+    },
+    {
+        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
+        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_to_u=
nknown_branch_ratio"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
+        "MetricExpr": "tma_info_buffer_stalls_load_buffer_stall_cycles",
+        "MetricName": "tma_info_buffer_stalls_%_load_buffer_stall_cycles"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to memory reservation stations full",
+        "MetricExpr": "tma_info_buffer_stalls_mem_rsv_stall_cycles",
+        "MetricName": "tma_info_buffer_stalls_%_mem_rsv_stall_cycles"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to store buffer full",
+        "MetricExpr": "tma_info_buffer_stalls_store_buffer_stall_cycles",
+        "MetricName": "tma_info_buffer_stalls_%_store_buffer_stall_cycles"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
+        "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.LD_BUF / CPU_CLK_UNHALTED=
.CORE",
+        "MetricName": "tma_info_buffer_stalls_load_buffer_stall_cycles",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to memory reservation stations full",
+        "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.RSV / CPU_CLK_UNHALTED.CO=
RE",
+        "MetricName": "tma_info_buffer_stalls_mem_rsv_stall_cycles",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to store buffer full",
+        "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.ST_BUF / CPU_CLK_UNHALTED=
.CORE",
+        "MetricName": "tma_info_buffer_stalls_store_buffer_stall_cycles",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE / INST_RETIRED.ANY",
+        "MetricName": "tma_info_core_cpi"
+    },
+    {
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "FP_FLOPS_RETIRED.ALL / CPU_CLK_UNHALTED.CORE",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_core_flopc"
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle",
+        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.CORE",
+        "MetricName": "tma_info_core_ipc"
+    },
+    {
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "TOPDOWN_RETIRING.ALL_P / INST_RETIRED.ANY",
+        "MetricName": "tma_info_core_upi"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
+        "MetricExpr": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l2h=
it",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2hit"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
+        "MetricExpr": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l3h=
it",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3hit"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss subsequently misses in the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.LLC_MISS / MEM_BOUND_=
STALLS_IFETCH.ALL",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3miss"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
+        "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.L2_HIT / MEM_BOUND_ST=
ALLS_IFETCH.ALL",
+        "MetricName": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l2h=
it",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.LLC_HIT / MEM_BOUND_S=
TALLS_IFETCH.ALL",
+        "MetricName": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l3h=
it",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
+        "MetricExpr": "tma_info_load_miss_bound_loadmissbound_with_l2hit",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2hit=
"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
+        "MetricExpr": "tma_info_load_miss_bound_loadmissbound_with_l3hit",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3hit=
"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.LLC_MISS / MEM_BOUND_ST=
ALLS_LOAD.ALL",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3mis=
s"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
+        "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.L2_HIT / MEM_BOUND_STAL=
LS_LOAD.ALL",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_loadmissbound_with_l2hit",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.LLC_HIT / MEM_BOUND_STA=
LLS_LOAD.ALL",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_loadmissbound_with_l3hit",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a pipeline block",
+        "MetricExpr": "100 * LD_HEAD.L1_BOUND_AT_RET / CPU_CLK_UNHALTED.CO=
RE",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_l1_bound"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement",
+        "MetricExpr": "100 * (LD_HEAD.L1_BOUND_AT_RET + MEM_BOUND_STALLS_L=
OAD.ALL) / CPU_CLK_UNHALTED.CORE",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_load_bound"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full",
+        "MetricExpr": "100 * (MEM_SCHEDULER_BLOCK.ST_BUF / MEM_SCHEDULER_B=
LOCK.ALL) * tma_mem_scheduler",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_store_bound"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to floating point assists",
+        "MetricExpr": "1e3 * MACHINE_CLEARS.FP_ASSIST / INST_RETIRED.ANY",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_fp_assi=
st_pki"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to page faults",
+        "MetricExpr": "1e3 * MACHINE_CLEARS.PAGE_FAULT / INST_RETIRED.ANY"=
,
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_page_fa=
ult_pki"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to self-modifying code",
+        "MetricExpr": "1e3 * MACHINE_CLEARS.SMC / INST_RETIRED.ANY",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_smc_pki=
"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
+        "MetricExpr": "tma_info_mem_exec_blocks_loads_with_adressaliasing"=
,
+        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_adressaliasin=
g"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
+        "MetricExpr": "tma_info_mem_exec_blocks_loads_with_storefwdblk",
+        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_storefwdblk"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
+        "MetricExpr": "100 * LD_BLOCKS.ADDRESS_ALIAS / MEM_UOPS_RETIRED.AL=
L_LOADS",
+        "MetricName": "tma_info_mem_exec_blocks_loads_with_adressaliasing"=
,
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
+        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
+        "MetricName": "tma_info_mem_exec_blocks_loads_with_storefwdblk",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
+        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_l1miss",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_l1miss"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to o=
ther block cases, such as pipeline conflicts, fences, etc",
+        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_otherpipeline=
blks",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_otherpipeli=
neblks"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 pagewalk",
+        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_pagewalk",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_pagewalk"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 second level TLB miss",
+        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_stlbhit",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_stlbhit"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 store forward address match",
+        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_storefwding",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_storefwding=
"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
+        "MetricExpr": "100 * LD_HEAD.L1_MISS_AT_RET / LD_HEAD.ANY_AT_RET",
+        "MetricName": "tma_info_mem_exec_bound_loadhead_with_l1miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to o=
ther block cases, such as pipeline conflicts, fences, etc",
+        "MetricExpr": "100 * LD_HEAD.OTHER_AT_RET / LD_HEAD.ANY_AT_RET",
+        "MetricName": "tma_info_mem_exec_bound_loadhead_with_otherpipeline=
blks",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 pagewalk",
+        "MetricExpr": "100 * LD_HEAD.PGWALK_AT_RET / LD_HEAD.ANY_AT_RET",
+        "MetricName": "tma_info_mem_exec_bound_loadhead_with_pagewalk",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 second level TLB miss",
+        "MetricExpr": "100 * LD_HEAD.DTLB_MISS_AT_RET / LD_HEAD.ANY_AT_RET=
",
+        "MetricName": "tma_info_mem_exec_bound_loadhead_with_stlbhit",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 store forward address match",
+        "MetricExpr": "100 * LD_HEAD.ST_ADDR_AT_RET / LD_HEAD.ANY_AT_RET",
+        "MetricName": "tma_info_mem_exec_bound_loadhead_with_storefwding",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Instructions per Load",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "MetricName": "tma_info_mem_mix_ipload"
+    },
+    {
+        "BriefDescription": "Instructions per Store",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "MetricName": "tma_info_mem_mix_ipstore"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads tha=
t perform one or more locks",
+        "MetricExpr": "100 * MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRE=
D.ALL_LOADS",
+        "MetricName": "tma_info_mem_mix_load_locks_ratio"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
+        "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIR=
ED.ALL_LOADS",
+        "MetricName": "tma_info_mem_mix_load_splits_ratio"
+    },
+    {
+        "BriefDescription": "Ratio of mem load uops to all uops",
+        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / TOPDOWN_RETIRING=
.ALL_P",
+        "MetricName": "tma_info_mem_mix_memload_ratio"
+    },
+    {
+        "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
+        "MetricExpr": "tma_info_serialization_tpause_cycles",
+        "MetricName": "tma_info_serialization _%_tpause_cycles"
+    },
+    {
+        "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
+        "MetricExpr": "100 * SERIALIZATION.C01_MS_SCB / (6 * CPU_CLK_UNHAL=
TED.CORE)",
+        "MetricName": "tma_info_serialization_tpause_cycles",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
+        "MetricName": "tma_info_system_cpu_utilization"
+    },
+    {
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "FP_FLOPS_RETIRED.ALL / (duration_time * 1e9)",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_system_gflops",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width"
+    },
+    {
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE_P@k / CPU_CLK_UNHALTED.CO=
RE",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_kernel_utilization"
+    },
+    {
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_system_turbo_utilization"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are FPDiv uops",
+        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / TOPDOWN_RETIRING.ALL_P",
+        "MetricName": "tma_info_uop_mix_fpdiv_uop_ratio"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are IDiv uops",
+        "MetricExpr": "100 * UOPS_RETIRED.IDIV / TOPDOWN_RETIRING.ALL_P",
+        "MetricName": "tma_info_uop_mix_idiv_uop_ratio"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are microcode op=
s",
+        "MetricExpr": "100 * UOPS_RETIRED.MS / TOPDOWN_RETIRING.ALL_P",
+        "MetricName": "tma_info_uop_mix_microcode_uop_ratio"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are x87 uops",
+        "MetricExpr": "100 * UOPS_RETIRED.X87 / TOPDOWN_RETIRING.ALL_P",
+        "MetricName": "tma_info_uop_mix_x87_uop_ratio"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB_MISS / (6 * CPU_CLK_UNHALTED.=
CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricName": "tma_itlb_misses",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
 0.15 & tma_frontend_bound > 0.2)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / (6 * CPU_C=
LK_UNHALTED.CORE)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricName": "tma_machine_clears",
+        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
n > 0.15",
+        "MetricgroupNoGroup": "TopdownL2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to memory reservation stalls in which a sched=
uler is not able to accept uops",
+        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / (6 * CPU_CLK_UNHAL=
TED.CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_mem_scheduler",
+        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to IEC or FPC RAT stalls, which can be due to=
 FIQ or IEC reservation stalls in which the integer, floating point or SIMD=
 scheduler is not able to accept uops",
+        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / (6 * CPU_CLK_U=
NHALTED.CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_non_mem_scheduler",
+        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that requires the use of m=
icrocode (slow nuke)",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / (6 * CPU_CLK_UNHALTE=
D.CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_nuke",
+        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / (6 * CPU_CLK_UNHALTED.CORE=
)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricName": "tma_other_fb",
+        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / (6 * CPU_CLK_UNHALTED.=
CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricName": "tma_predecode",
+        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the physical register file unable to accep=
t an entry (marble stalls)",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / (6 * CPU_CLK_UNHALTED.C=
ORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_register",
+        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the reorder buffer being full (ROB stalls)=
",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / (6 * CPU_CLK_UNHA=
LTED.CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_reorder_buffer",
+        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a resource limitation",
+        "MetricExpr": "tma_backend_bound - tma_core_bound",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricName": "tma_resource_bound",
+        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
+        "MetricgroupNoGroup": "TopdownL2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that result =
in retirement slots",
+        "MetricExpr": "TOPDOWN_RETIRING.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_retiring",
+        "MetricThreshold": "tma_retiring > 0.75",
+        "MetricgroupNoGroup": "TopdownL1",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to scoreboards from the instruction queue (IQ=
), jump execution unit (JEU), or microcode sequencer (MS)",
+        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / (6 * CPU_CLK_UNHAL=
TED.CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_serialization",
+        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Uncore operating frequency in GHz",
+        "MetricExpr": "UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_CLOCKTIC=
KS) * #num_packages) / 1e9 / duration_time",
+        "MetricName": "uncore_frequency",
+        "ScaleUnit": "1GHz"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/memory.json b/tools/=
perf/pmu-events/arch/x86/grandridge/memory.json
index e0ce2decc805..22d23077618e 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/memory.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to any number of reasons, incl=
uding an L1 miss, WCB full, pagewalk, store address block or store data blo=
ck, on a load that retires.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.ANY_AT_RET",
         "SampleAfterValue": "1000003",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a core bound stall includin=
g a store address match, a DTLB miss or a page walk that detains the load f=
rom retiring.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.L1_BOUND_AT_RET",
         "SampleAfterValue": "1000003",
@@ -15,6 +17,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DL1 =
miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.L1_MISS_AT_RET",
         "SampleAfterValue": "1000003",
@@ -22,6 +25,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to other =
block cases.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.OTHER_AT_RET",
         "PublicDescription": "Counts the number of cycles that the head (o=
ldest load) of the load buffer and retirement are both stalled due to other=
 block cases such as pipeline conflicts, fences, etc.",
@@ -30,6 +34,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a page=
walk.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.PGWALK_AT_RET",
         "SampleAfterValue": "1000003",
@@ -37,6 +42,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a stor=
e address match.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.ST_ADDR_AT_RET",
         "SampleAfterValue": "1000003",
@@ -44,6 +50,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "SampleAfterValue": "20003",
@@ -51,22 +58,23 @@
     },
     {
         "BriefDescription": "Counts misaligned loads that are 4K page spli=
ts.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts misaligned stores that are 4K page spl=
its.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x13",
         "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -76,6 +84,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/metricgroups.json b/=
tools/perf/pmu-events/arch/x86/grandridge/metricgroups.json
new file mode 100644
index 000000000000..40984c23a6c9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/grandridge/metricgroups.json
@@ -0,0 +1,23 @@
+{
+    "Flops": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "Ifetch": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
+    "Load_Store_Miss": "Grouping from Top-down Microarchitecture Analysis =
Metrics spreadsheet",
+    "Mem_Exec": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "Power": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "Summary": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
+    "TopdownL1": "Metrics for top-down breakdown at level 1",
+    "TopdownL2": "Metrics for top-down breakdown at level 2",
+    "TopdownL3": "Metrics for top-down breakdown at level 3",
+    "load_store_bound": "Grouping from Top-down Microarchitecture Analysis=
 Metrics spreadsheet",
+    "tma_L1_group": "Metrics for top-down breakdown at level 1",
+    "tma_L2_group": "Metrics for top-down breakdown at level 2",
+    "tma_L3_group": "Metrics for top-down breakdown at level 3",
+    "tma_backend_bound_group": "Metrics contributing to tma_backend_bound =
category",
+    "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
+    "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
+    "tma_frontend_bound_group": "Metrics contributing to tma_frontend_boun=
d category",
+    "tma_ifetch_bandwidth_group": "Metrics contributing to tma_ifetch_band=
width category",
+    "tma_ifetch_latency_group": "Metrics contributing to tma_ifetch_latenc=
y category",
+    "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
+    "tma_resource_bound_group": "Metrics contributing to tma_resource_boun=
d category"
+}
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/other.json b/tools/p=
erf/pmu-events/arch/x86/grandridge/other.json
index 70a9da7e97df..28f9a4c3ea84 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/other.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/other.json
@@ -1,15 +1,16 @@
 [
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Deprecated": "1",
         "EventCode": "0xe4",
         "EventName": "LBR_INSERTS.ANY",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -19,6 +20,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -26,8 +28,19 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10800",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x75",
         "EventName": "SERIALIZATION.C01_MS_SCB",
         "SampleAfterValue": "200003",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/pipeline.json
index 90292dc03d33..b67c0c89054d 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of cycles when any of the d=
ividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xcd",
         "EventName": "ARITH.DIV_ACTIVE",
@@ -9,153 +10,157 @@
     },
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
     {
         "BriefDescription": "Counts the number of taken JCC (Jump on Condi=
tional Code) branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
     {
         "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xbf"
     },
     {
         "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
     {
         "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf9"
     },
     {
         "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
         "SampleAfterValue": "200003"
     },
     {
         "BriefDescription": "Counts the number of mispredicted JCC (Jump o=
n Conditional Code) branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
     {
         "BriefDescription": "Counts the number of mispredicted taken JCC (=
Jump on Conditional Code) branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
     {
         "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
     {
         "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RETURN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
@@ -164,18 +169,21 @@
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "SampleAfterValue": "2000003",
@@ -183,37 +191,38 @@
     },
     {
         "BriefDescription": "Counts the number of instructions retired",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
-        "PEBS": "1",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because its address partially overlapped with an older store.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
         "SampleAfterValue": "20003",
@@ -221,6 +230,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.PAGE_FAULT",
         "SampleAfterValue": "20003",
@@ -228,6 +238,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine with the use of microcode due to SMC=
, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUAL_=
TRAP.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SLOW",
         "SampleAfterValue": "20003",
@@ -235,6 +246,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (self modifying code) within 1K of a recently fetched =
code page.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
         "SampleAfterValue": "20003",
@@ -242,14 +254,15 @@
     },
     {
         "BriefDescription": "Counts the number of Last Branch Record (LBR)=
 entries. Requires LBRs to be enabled and configured in IA32_LBR_CTL. [This=
 event is alias to LBR_INSERTS.ANY]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
.ALL_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear. =
[This event is alias to TOPDOWN_BAD_SPECULATION.ALL_P]",
@@ -257,6 +270,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
.ALL]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL_P",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear. =
[This event is alias to TOPDOWN_BAD_SPECULATION.ALL]",
@@ -264,6 +278,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Fast Nukes such as  Memory Ord=
ering Machine clears and MRN nukes",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
         "SampleAfterValue": "1000003",
@@ -271,6 +286,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
         "SampleAfterValue": "1000003",
@@ -278,6 +294,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Branch Mispredict",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
         "SampleAfterValue": "1000003",
@@ -285,6 +302,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
         "SampleAfterValue": "1000003",
@@ -292,12 +310,14 @@
     },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL_P]=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
         "SampleAfterValue": "1000003"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to due to certain allocation rest=
rictions",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
         "SampleAfterValue": "1000003",
@@ -305,12 +325,14 @@
     },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls [This event is alias to TOPDOWN_BE_BOUND.ALL]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALL_P",
         "SampleAfterValue": "1000003"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stall (sche=
duler not being able to accept another uop).  This could be caused by RSV f=
ull or load/store buffer block.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
         "SampleAfterValue": "1000003",
@@ -318,6 +340,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC and FPC RAT stalls - which=
 can be due to the FIQ and IEC reservation station stall (integer, FP and S=
IMD scheduler not being able to accept another uop. )",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
         "SampleAfterValue": "1000003",
@@ -325,6 +348,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to mrbl stall.  A 'marble' refers=
 to a physical register file entry, also known as the physical destination =
(PDST).",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.REGISTER",
         "SampleAfterValue": "1000003",
@@ -332,6 +356,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to ROB full",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
         "SampleAfterValue": "1000003",
@@ -339,6 +364,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to iq/jeu scoreboards or ms scb",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
         "SampleAfterValue": "1000003",
@@ -346,18 +372,21 @@
     },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls [This event is alias to TOPDOWN_FE_BOUND.ALL_=
P]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003"
     },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls [This event is alias to TOPDOWN_FE_BOUND.ALL]=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ALL_P",
         "SampleAfterValue": "1000003"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BAClear",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
         "SampleAfterValue": "1000003",
@@ -365,6 +394,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTClear",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
         "SampleAfterValue": "1000003",
@@ -372,6 +402,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ms",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.CISC",
         "SampleAfterValue": "1000003",
@@ -379,6 +410,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stall",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.DECODE",
         "SampleAfterValue": "1000003",
@@ -386,6 +418,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to frontend bandwidth restricti=
ons due to decode, predecode, cisc, and other limitations.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
         "SampleAfterValue": "1000003",
@@ -393,6 +426,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to latency related stalls inclu=
ding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
         "SampleAfterValue": "1000003",
@@ -400,6 +434,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to TOPDOWN_FE_BOUND.ITLB_MISS]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Deprecated": "1",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ITLB",
@@ -408,6 +443,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to itlb miss [This event is ali=
as to TOPDOWN_FE_BOUND.ITLB]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ITLB_MISS",
         "SampleAfterValue": "1000003",
@@ -415,6 +451,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend that do not categorize into any oth=
er common frontend stall",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.OTHER",
         "SampleAfterValue": "1000003",
@@ -422,27 +459,29 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to predecode wrong",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL [This event is alias to TOPDOWN_RETIRING.AL=
L_P]",
+        "BriefDescription": "Counts the number of consumed retirement slot=
s. [This event is alias to TOPDOWN_RETIRING.ALL_P]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x72",
         "EventName": "TOPDOWN_RETIRING.ALL",
-        "PEBS": "1",
         "SampleAfterValue": "1000003"
     },
     {
-        "BriefDescription": "Counts the number of consumed retirement slot=
s.  Similar to UOPS_RETIRED.ALL [This event is alias to TOPDOWN_RETIRING.AL=
L]",
+        "BriefDescription": "Counts the number of consumed retirement slot=
s. [This event is alias to TOPDOWN_RETIRING.ALL]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x72",
         "EventName": "TOPDOWN_RETIRING.ALL_P",
-        "PEBS": "1",
         "SampleAfterValue": "1000003"
     },
     {
         "BriefDescription": "Counts the number of uops issued by the front=
 end every cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x0e",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "Counts the number of uops issued by the fron=
t end every cycle. When 4-uops are requested and only 2-uops are delivered,=
 the event counts 2.  Uops_issued correlates to the number of ROB entries. =
 If uop takes 2 ROB slots it counts as 2 uops_issued.",
@@ -450,32 +489,32 @@
     },
     {
         "BriefDescription": "Counts the total number of uops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.ALL",
-        "PEBS": "1",
         "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Counts the number of integer divide uops reti=
red.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.IDIV",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
     {
         "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS).  This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of x87 uops retired, includ=
es those in ms flows",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     }
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
index 36614429dd72..1eaf796601b1 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Clockticks for CMS units attached to CHA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_CHACMS_CLOCKTICKS",
         "PerPkg": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Number of CHA clock cycles while the event is=
 enabled",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_CHA_CLOCKTICKS",
         "PerPkg": "1",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in TOR o=
r IRQ (immediate cause for triggering).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x59",
         "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_ANY",
         "PerPkg": "1",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in IRQ (=
immediate cause for triggering).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x59",
         "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_IRQ",
         "PerPkg": "1",
@@ -34,6 +38,7 @@
     },
     {
         "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in TOR (=
immediate cause for triggering).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x59",
         "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_TOR",
         "PerPkg": "1",
@@ -42,40 +47,50 @@
     },
     {
         "BriefDescription": "Counts when a normal (Non-Isochronous) full l=
ine write is issued from the CHA to the any of the memory controller channe=
ls.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5b",
         "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Fu=
ll Line : Counts the total number of full line writes issued from the HA in=
to the memory controller.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5b",
         "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL_PRIORITY",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x4",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CHA to iMC Full Line Writes Issued : Partial =
Non-ISOCH : Counts the total number of full line writes issued from the HA =
into the memory controller.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5b",
         "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Pa=
rtial : Counts the total number of full line writes issued from the HA into=
 the memory controller.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x5b",
         "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL_PRIORITY",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x8",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Cache Lookups: CRd Requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.CODE",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : CRd Requests",
         "UMask": "0x1bd0ff",
@@ -83,8 +98,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Read Requests and Read Prefetc=
hes",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DATA_RD",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
         "UMask": "0x1bc1ff",
@@ -92,8 +109,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Read Requests, Read Prefetches=
, and Snoops",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_ALL",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Data Reads",
         "UMask": "0x1fc1ff",
@@ -101,8 +120,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Read Requests to Locally Homed=
 Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_LOCAL",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Demand Data Reads, Core and =
LLC prefetches",
         "UMask": "0x841ff",
@@ -110,8 +131,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Read Requests, Read Prefetches=
, and Snoops which miss the Cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_MISS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Data Read Misses",
         "UMask": "0x1fc101",
@@ -119,8 +142,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: All Requests to Locally Homed =
Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCALLY_HOMED_ADDRESS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Transactions homed locally",
         "UMask": "0xbdfff",
@@ -128,8 +153,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Code Read Requests and Code Re=
ad Prefetches to Locally Homed Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_CODE",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : CRd Requests",
         "UMask": "0x19d0ff",
@@ -137,8 +164,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Read Requests and Read Prefetc=
hes to Locally Homed Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DATA_RD",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
         "UMask": "0x19c1ff",
@@ -146,8 +175,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Code Read Requests to Locally =
Homed Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_CODE",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : CRd Requests",
         "UMask": "0x1850ff",
@@ -155,8 +186,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Read Requests to Locally Homed=
 Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_DATA_RD",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
         "UMask": "0x1841ff",
@@ -164,8 +197,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: RFO Requests to Locally Homed =
Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_RFO",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : RFO Requests",
         "UMask": "0x1848ff",
@@ -173,8 +208,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: LLC Prefetch Requests to Local=
ly Homed Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_LLC_PF",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
         "UMask": "0x189dff",
@@ -182,8 +219,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: All Prefetches to Locally Home=
d Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
         "UMask": "0x199dff",
@@ -191,8 +230,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Code Prefetches to Locally Hom=
ed Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_CODE",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : CRd Requests",
         "UMask": "0x1910ff",
@@ -200,8 +241,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Read Prefetches to Locally Hom=
ed Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_DATA_RD",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
         "UMask": "0x1981ff",
@@ -209,8 +252,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: RFO Prefetches to Locally Home=
d Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_RFO",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : RFO Requests",
         "UMask": "0x1908ff",
@@ -218,8 +263,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: RFO Requests and RFO Prefetche=
s to Locally Homed Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_RFO",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : RFO Requests",
         "UMask": "0x19c8ff",
@@ -227,8 +274,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: All RFO and RFO Prefetches",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.RFO",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : All RFOs - Demand and Prefet=
ches",
         "UMask": "0x1bc8ff",
@@ -236,8 +285,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: RFO Requests and RFO Prefetche=
s to Locally Homed Memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.RFO_LOCAL",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Locally HOMed RFOs - Demand =
and Prefetches",
         "UMask": "0x9c8ff",
@@ -245,8 +296,10 @@
     },
     {
         "BriefDescription": "Cache Lookups: Writes to Locally Homed Memory=
 (includes writebacks from L1/L2)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.WRITE_LOCAL",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Cache Lookups : Writes",
         "UMask": "0x842ff",
@@ -254,8 +307,10 @@
     },
     {
         "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.ALL",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : All Lines Victimized",
         "UMask": "0xf",
@@ -263,24 +318,30 @@
     },
     {
         "BriefDescription": "Lines Victimized : IA traffic : Counts the nu=
mber of lines that were victimized on a fill.  This can be filtered by the =
state that the line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.IA",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x20",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Lines Victimized : IO traffic : Counts the nu=
mber of lines that were victimized on a fill.  This can be filtered by the =
state that the line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.IO",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x10",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_ALL",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Local - All Lines",
         "UMask": "0x200f",
@@ -288,8 +349,10 @@
     },
     {
         "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_E",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Local - Lines in E State"=
,
         "UMask": "0x2002",
@@ -297,8 +360,10 @@
     },
     {
         "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_F",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Local - Lines in F State"=
,
         "UMask": "0x2008",
@@ -306,8 +371,10 @@
     },
     {
         "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_M",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Local - Lines in M State"=
,
         "UMask": "0x2001",
@@ -315,8 +382,10 @@
     },
     {
         "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_S",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Local - Lines in S State"=
,
         "UMask": "0x2004",
@@ -324,8 +393,10 @@
     },
     {
         "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Lines in E state",
         "UMask": "0x2",
@@ -333,8 +404,10 @@
     },
     {
         "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Lines in M state",
         "UMask": "0x1",
@@ -342,8 +415,10 @@
     },
     {
         "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x37",
         "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Lines Victimized : Lines in S State",
         "UMask": "0x4",
@@ -351,6 +426,7 @@
     },
     {
         "BriefDescription": "Counts when a RFO (the Read for Ownership iss=
ued before a  write) request hit a cacheline in the S (Shared) state.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x39",
         "EventName": "UNC_CHA_MISC.RFO_HIT_S",
         "PerPkg": "1",
@@ -360,30 +436,37 @@
     },
     {
         "BriefDescription": "OSB Snoop Broadcast : Local InvItoE : Count o=
f OSB snoop broadcasts. Counts by 1 per request causing OSB snoops to be br=
oadcast. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "UNC_CHA_OSB.LOCAL_INVITOE",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "OSB Snoop Broadcast : Local Rd : Count of OSB=
 snoop broadcasts. Counts by 1 per request causing OSB snoops to be broadca=
st. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "UNC_CHA_OSB.LOCAL_READ",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "OSB Snoop Broadcast : Off : Count of OSB snoo=
p broadcasts. Counts by 1 per request causing OSB snoops to be broadcast. D=
oes not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "UNC_CHA_OSB.OFF_PWRHEURISTIC",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x20",
         "Unit": "CHA"
     },
     {
         "BriefDescription": "OSB Snoop Broadcast : RFO HitS Snoop Broadcas=
t : Count of OSB snoop broadcasts. Counts by 1 per request causing OSB snoo=
ps to be broadcast. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x55",
         "EventName": "UNC_CHA_OSB.RFO_HITS_SNP_BCAST",
         "PerPkg": "1",
@@ -392,6 +475,7 @@
     },
     {
         "BriefDescription": "Counts the total number of requests coming fr=
om a unit on this socket for exclusive ownership of a cache line without re=
ceiving data (INVITOE) to the CHA.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.INVITOE",
         "PerPkg": "1",
@@ -401,6 +485,7 @@
     },
     {
         "BriefDescription": "Counts the total number of requests coming fr=
om a unit on this socket for exclusive ownership of a cache line without re=
ceiving data (INVITOE) to the CHA.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
         "PerPkg": "1",
@@ -409,6 +494,7 @@
     },
     {
         "BriefDescription": "Counts read requests made into this CHA. Read=
s include all read opcodes (including RFO: the Read for Ownership issued be=
fore a  write) .",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS",
         "PerPkg": "1",
@@ -418,6 +504,7 @@
     },
     {
         "BriefDescription": "Counts read requests coming from a unit on th=
is socket made into this CHA. Reads include all read opcodes (including RFO=
: the Read for Ownership issued before a  write).",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
         "PerPkg": "1",
@@ -426,6 +513,7 @@
     },
     {
         "BriefDescription": "Counts write requests made into the CHA, incl=
uding streaming, evictions, HitM (Reads from another core to a Modified cac=
heline), etc.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES",
         "PerPkg": "1",
@@ -435,6 +523,7 @@
     },
     {
         "BriefDescription": "Counts  write requests coming from a unit on =
this socket made into this CHA, including streaming, evictions, HitM (Reads=
 from another core to a Modified cacheline), etc.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x50",
         "EventName": "UNC_CHA_REQUESTS.WRITES_LOCAL",
         "PerPkg": "1",
@@ -443,8 +532,10 @@
     },
     {
         "BriefDescription": "All TOR Inserts",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.ALL",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : All",
         "UMask": "0xc001ffff",
@@ -452,8 +543,10 @@
     },
     {
         "BriefDescription": "All locally initiated requests from IA Cores"=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : All requests from iA Cores",
         "UMask": "0xc001ff01",
@@ -461,6 +554,7 @@
     },
     {
         "BriefDescription": "CLFlush events that are initiated from the Co=
re",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSH",
         "PerPkg": "1",
@@ -470,6 +564,7 @@
     },
     {
         "BriefDescription": "CLFlushOpt events that are initiated from the=
 Core",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSHOPT",
         "PerPkg": "1",
@@ -479,6 +574,7 @@
     },
     {
         "BriefDescription": "Code read from local IA that miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
         "PerPkg": "1",
@@ -488,6 +584,7 @@
     },
     {
         "BriefDescription": "Code read prefetch from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD_PREF",
         "PerPkg": "1",
@@ -497,6 +594,7 @@
     },
     {
         "BriefDescription": "Data read opt from local IA that miss the cac=
he",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT",
         "PerPkg": "1",
@@ -506,6 +604,7 @@
     },
     {
         "BriefDescription": "Data read opt prefetch from local IA that mis=
s the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
         "PerPkg": "1",
@@ -515,8 +614,10 @@
     },
     {
         "BriefDescription": "All locally initiated requests from IA Cores =
which hit the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Hit the LLC",
         "UMask": "0xc001fd01",
@@ -524,6 +625,7 @@
     },
     {
         "BriefDescription": "Code read from local IA that hit the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
         "PerPkg": "1",
@@ -533,6 +635,7 @@
     },
     {
         "BriefDescription": "Code read prefetch from local IA that hit the=
 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD_PREF",
         "PerPkg": "1",
@@ -542,6 +645,7 @@
     },
     {
         "BriefDescription": "Data read opt from local IA that hit the cach=
e",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT",
         "PerPkg": "1",
@@ -551,6 +655,7 @@
     },
     {
         "BriefDescription": "Data read opt prefetch from local IA that hit=
 the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT_PREF",
         "PerPkg": "1",
@@ -560,6 +665,7 @@
     },
     {
         "BriefDescription": "ItoM requests from local IA cores that hit th=
e cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_ITOM",
         "PerPkg": "1",
@@ -569,6 +675,7 @@
     },
     {
         "BriefDescription": "Last level cache prefetch code read from loca=
l IA that hit the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFCODE",
         "PerPkg": "1",
@@ -578,6 +685,7 @@
     },
     {
         "BriefDescription": "Last level cache prefetch data read from loca=
l IA that hit the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFDATA",
         "PerPkg": "1",
@@ -587,6 +695,7 @@
     },
     {
         "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that hit the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFRFO",
         "PerPkg": "1",
@@ -596,6 +705,7 @@
     },
     {
         "BriefDescription": "Read for ownership from local IA that hit the=
 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
         "PerPkg": "1",
@@ -605,6 +715,7 @@
     },
     {
         "BriefDescription": "Read for ownership prefetch from local IA tha=
t hit the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO_PREF",
         "PerPkg": "1",
@@ -614,6 +725,7 @@
     },
     {
         "BriefDescription": "ItoM events that are initiated from the Core"=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOM",
         "PerPkg": "1",
@@ -623,6 +735,7 @@
     },
     {
         "BriefDescription": "ItoMCacheNear requests from local IA cores",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -632,6 +745,7 @@
     },
     {
         "BriefDescription": "Last level cache prefetch code read from loca=
l IA.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFCODE",
         "PerPkg": "1",
@@ -641,6 +755,7 @@
     },
     {
         "BriefDescription": "Last level cache prefetch data read from loca=
l IA.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFDATA",
         "PerPkg": "1",
@@ -650,6 +765,7 @@
     },
     {
         "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFRFO",
         "PerPkg": "1",
@@ -659,6 +775,7 @@
     },
     {
         "BriefDescription": "All locally initiated requests from IA Cores =
which miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
         "PerPkg": "1",
@@ -668,6 +785,7 @@
     },
     {
         "BriefDescription": "Code read from local IA that miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
         "PerPkg": "1",
@@ -677,6 +795,7 @@
     },
     {
         "BriefDescription": "CRDs from local IA cores to locally homed mem=
ory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_LOCAL",
         "PerPkg": "1",
@@ -686,6 +805,7 @@
     },
     {
         "BriefDescription": "Code read prefetch from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
         "PerPkg": "1",
@@ -695,6 +815,7 @@
     },
     {
         "BriefDescription": "CRD Prefetches from local IA cores to locally=
 homed memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_LOCAL",
         "PerPkg": "1",
@@ -704,6 +825,7 @@
     },
     {
         "BriefDescription": "Data read opt from local IA that miss the cac=
he",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT",
         "PerPkg": "1",
@@ -713,6 +835,7 @@
     },
     {
         "BriefDescription": "Inserts into the TOR from local IA cores whic=
h miss the LLC and snoop filter with the opcode DRd_Opt, and which target l=
ocal memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_LOCAL",
         "PerPkg": "1",
@@ -722,6 +845,7 @@
     },
     {
         "BriefDescription": "Data read opt prefetch from local IA that mis=
s the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF",
         "PerPkg": "1",
@@ -731,6 +855,7 @@
     },
     {
         "BriefDescription": "Inserts into the TOR from local IA cores whic=
h miss the LLC and snoop filter with the opcode DRD_PREF_OPT, and target lo=
cal memory",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL",
         "PerPkg": "1",
@@ -740,6 +865,7 @@
     },
     {
         "BriefDescription": "ItoM requests from local IA cores that miss t=
he cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_ITOM",
         "PerPkg": "1",
@@ -749,6 +875,7 @@
     },
     {
         "BriefDescription": "Last level cache prefetch code read from loca=
l IA that miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFCODE",
         "PerPkg": "1",
@@ -758,6 +885,7 @@
     },
     {
         "BriefDescription": "Last level cache prefetch data read from loca=
l IA that miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA",
         "PerPkg": "1",
@@ -767,6 +895,7 @@
     },
     {
         "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO",
         "PerPkg": "1",
@@ -776,6 +905,7 @@
     },
     {
         "BriefDescription": "WCILF requests from local IA cores to locally=
 homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_DDR",
         "PerPkg": "1",
@@ -785,6 +915,7 @@
     },
     {
         "BriefDescription": "WCIL requests from local IA cores to locally =
homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_DDR",
         "PerPkg": "1",
@@ -794,6 +925,7 @@
     },
     {
         "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
         "PerPkg": "1",
@@ -803,6 +935,7 @@
     },
     {
         "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_LOCAL",
         "PerPkg": "1",
@@ -812,6 +945,7 @@
     },
     {
         "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
         "PerPkg": "1",
@@ -821,6 +955,7 @@
     },
     {
         "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_LOCAL",
         "PerPkg": "1",
@@ -830,6 +965,7 @@
     },
     {
         "BriefDescription": "UCRDF requests from local IA cores that miss =
the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_UCRDF",
         "PerPkg": "1",
@@ -839,6 +975,7 @@
     },
     {
         "BriefDescription": "WCIL requests from a local IA core that miss =
the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
         "PerPkg": "1",
@@ -848,6 +985,7 @@
     },
     {
         "BriefDescription": "WCILF requests from local IA core that miss t=
he cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
         "PerPkg": "1",
@@ -857,6 +995,7 @@
     },
     {
         "BriefDescription": "WCILF requests from local IA cores to DDR hom=
ed addresses which miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_DDR",
         "PerPkg": "1",
@@ -866,6 +1005,7 @@
     },
     {
         "BriefDescription": "WCIL requests from local IA cores to DDR home=
d addresses which miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_DDR",
         "PerPkg": "1",
@@ -875,6 +1015,7 @@
     },
     {
         "BriefDescription": "WIL requests from local IA cores that miss th=
e cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WIL",
         "PerPkg": "1",
@@ -884,6 +1025,7 @@
     },
     {
         "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
         "PerPkg": "1",
@@ -893,6 +1035,7 @@
     },
     {
         "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
         "PerPkg": "1",
@@ -902,6 +1045,7 @@
     },
     {
         "BriefDescription": "SpecItoM events that are initiated from the C=
ore",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_SPECITOM",
         "PerPkg": "1",
@@ -911,6 +1055,7 @@
     },
     {
         "BriefDescription": "WbEFtoEs issued by iA Cores.  (Non Modified W=
rite Backs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOE",
         "PerPkg": "1",
@@ -920,6 +1065,7 @@
     },
     {
         "BriefDescription": "WbEFtoIs issued by iA Cores .  (Non Modified =
Write Backs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOI",
         "PerPkg": "1",
@@ -929,6 +1075,7 @@
     },
     {
         "BriefDescription": "WbMtoEs issued by iA Cores .  (Modified Write=
 Backs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOE",
         "PerPkg": "1",
@@ -938,6 +1085,7 @@
     },
     {
         "BriefDescription": "WbMtoI requests from local IA cores",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOI",
         "PerPkg": "1",
@@ -947,6 +1095,7 @@
     },
     {
         "BriefDescription": "WbStoIs issued by iA Cores .  (Non Modified W=
rite Backs)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WBSTOI",
         "PerPkg": "1",
@@ -956,6 +1105,7 @@
     },
     {
         "BriefDescription": "WCIL requests from a local IA core",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WCIL",
         "PerPkg": "1",
@@ -965,6 +1115,7 @@
     },
     {
         "BriefDescription": "WCILF requests from local IA core",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_WCILF",
         "PerPkg": "1",
@@ -974,8 +1125,10 @@
     },
     {
         "BriefDescription": "All TOR inserts from local IO devices",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : All requests from IO Devices",
         "UMask": "0xc001ff04",
@@ -983,6 +1136,7 @@
     },
     {
         "BriefDescription": "CLFlush requests from IO devices",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_CLFLUSH",
         "PerPkg": "1",
@@ -992,8 +1146,10 @@
     },
     {
         "BriefDescription": "All TOR inserts from local IO devices which h=
it the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : All requests from IO Devices t=
hat hit the LLC",
         "UMask": "0xc001fd04",
@@ -1001,6 +1157,7 @@
     },
     {
         "BriefDescription": "ItoMs from local IO devices which hit the cac=
he",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOM",
         "PerPkg": "1",
@@ -1010,6 +1167,7 @@
     },
     {
         "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices that hit the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -1019,6 +1177,7 @@
     },
     {
         "BriefDescription": "PCIRDCURs issued by IO devices which hit the =
LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR",
         "PerPkg": "1",
@@ -1028,6 +1187,7 @@
     },
     {
         "BriefDescription": "RFOs from local IO devices which hit the cach=
e",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_RFO",
         "PerPkg": "1",
@@ -1037,6 +1197,7 @@
     },
     {
         "BriefDescription": "All TOR ItoM inserts from local IO devices",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM",
         "PerPkg": "1",
@@ -1046,6 +1207,7 @@
     },
     {
         "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -1055,8 +1217,10 @@
     },
     {
         "BriefDescription": "All TOR inserts from local IO devices which m=
iss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : All requests from IO Devices t=
hat missed the LLC",
         "UMask": "0xc001fe04",
@@ -1064,6 +1228,7 @@
     },
     {
         "BriefDescription": "All TOR ItoM inserts from local IO devices wh=
ich miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
         "PerPkg": "1",
@@ -1073,6 +1238,7 @@
     },
     {
         "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices that missed the LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -1082,6 +1248,7 @@
     },
     {
         "BriefDescription": "PCIRDCURs issued by IO devices which miss the=
 LLC",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR",
         "PerPkg": "1",
@@ -1091,6 +1258,7 @@
     },
     {
         "BriefDescription": "All TOR RFO inserts from local IO devices whi=
ch miss the cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
         "PerPkg": "1",
@@ -1100,6 +1268,7 @@
     },
     {
         "BriefDescription": "PCIRDCURs issued by IO devices",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR",
         "PerPkg": "1",
@@ -1109,6 +1278,7 @@
     },
     {
         "BriefDescription": "RFOs from local IO devices",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_RFO",
         "PerPkg": "1",
@@ -1118,6 +1288,7 @@
     },
     {
         "BriefDescription": "WBMtoI requests from IO devices",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_WBMTOI",
         "PerPkg": "1",
@@ -1127,6 +1298,7 @@
     },
     {
         "BriefDescription": "TOR Inserts for SF or LLC Evictions",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.LLC_OR_SF_EVICTIONS",
         "PerPkg": "1",
@@ -1136,8 +1308,10 @@
     },
     {
         "BriefDescription": "All locally initiated requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.LOC_ALL",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : All from Local iA and IO",
         "UMask": "0xc000ff05",
@@ -1145,8 +1319,10 @@
     },
     {
         "BriefDescription": "All from Local iA",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.LOC_IA",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : All from Local iA",
         "UMask": "0xc000ff01",
@@ -1154,8 +1330,10 @@
     },
     {
         "BriefDescription": "All from Local IO",
+        "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.LOC_IO",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : All from Local IO",
         "UMask": "0xc000ff04",
@@ -1163,8 +1341,10 @@
     },
     {
         "BriefDescription": "Occupancy for all TOR entries",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.ALL",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : All",
         "UMask": "0xc001ffff",
@@ -1172,8 +1352,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : All requests from iA Cores",
         "UMask": "0xc001ff01",
@@ -1181,6 +1363,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for CLFlush events that are ini=
tiated from the Core",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSH",
         "PerPkg": "1",
@@ -1190,6 +1373,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for CLFlushOpt events that are =
initiated from the Core",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSHOPT",
         "PerPkg": "1",
@@ -1199,6 +1383,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD",
         "PerPkg": "1",
@@ -1208,6 +1393,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD_PREF",
         "PerPkg": "1",
@@ -1217,8 +1403,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores"=
,
         "UMask": "0xc827ff01",
@@ -1226,8 +1414,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT_PREF",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores",
         "UMask": "0xc8a7ff01",
@@ -1235,8 +1425,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores which hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Hit the LLC",
         "UMask": "0xc001fd01",
@@ -1244,6 +1436,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
         "PerPkg": "1",
@@ -1253,6 +1446,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD_PREF",
         "PerPkg": "1",
@@ -1262,8 +1456,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores =
that hit the LLC",
         "UMask": "0xc827fd01",
@@ -1271,8 +1467,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT_PREF",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores that hit the LLC",
         "UMask": "0xc8a7fd01",
@@ -1280,6 +1478,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for ItoM requests from local IA=
 cores that hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_ITOM",
         "PerPkg": "1",
@@ -1289,6 +1488,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA that hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFCODE",
         "PerPkg": "1",
@@ -1298,6 +1498,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA that hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFDATA",
         "PerPkg": "1",
@@ -1307,6 +1508,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFRFO",
         "PerPkg": "1",
@@ -1316,6 +1518,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
         "PerPkg": "1",
@@ -1325,6 +1528,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO_PREF",
         "PerPkg": "1",
@@ -1334,6 +1538,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for ItoM events that are initia=
ted from the Core",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOM",
         "PerPkg": "1",
@@ -1343,6 +1548,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for ItoMCacheNear requests from=
 local IA cores",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -1352,6 +1558,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA.",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFCODE",
         "PerPkg": "1",
@@ -1361,6 +1568,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA.",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFDATA",
         "PerPkg": "1",
@@ -1370,6 +1578,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFRFO",
         "PerPkg": "1",
@@ -1379,8 +1588,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores which miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Missed the LLC",
         "UMask": "0xc001fe01",
@@ -1388,6 +1599,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
         "PerPkg": "1",
@@ -1397,6 +1609,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for CRDs from local IA cores to=
 locally homed memory",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_LOCAL",
         "PerPkg": "1",
@@ -1406,6 +1619,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF",
         "PerPkg": "1",
@@ -1415,6 +1629,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for CRD Prefetches from local I=
A cores to locally homed memory",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_LOCAL",
         "PerPkg": "1",
@@ -1424,8 +1639,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opt issued by iA Cores t=
hat missed the LLC",
         "UMask": "0xc827fe01",
@@ -1433,8 +1650,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores that missed the LLC",
         "UMask": "0xc8a7fe01",
@@ -1442,6 +1661,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for ItoM requests from local IA=
 cores that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_ITOM",
         "PerPkg": "1",
@@ -1451,6 +1671,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFCODE",
         "PerPkg": "1",
@@ -1460,6 +1681,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA",
         "PerPkg": "1",
@@ -1469,6 +1691,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO",
         "PerPkg": "1",
@@ -1478,6 +1701,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to locally homed DDR addresses that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_DDR",
         "PerPkg": "1",
@@ -1487,6 +1711,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to locally homed DDR addresses that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_DDR",
         "PerPkg": "1",
@@ -1496,6 +1721,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
         "PerPkg": "1",
@@ -1505,6 +1731,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_LOCAL",
         "PerPkg": "1",
@@ -1514,6 +1741,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF",
         "PerPkg": "1",
@@ -1523,6 +1751,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_LOCAL",
         "PerPkg": "1",
@@ -1532,6 +1761,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for UCRDF requests from local I=
A cores that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_UCRDF",
         "PerPkg": "1",
@@ -1541,6 +1771,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL",
         "PerPkg": "1",
@@ -1550,6 +1781,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A core that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF",
         "PerPkg": "1",
@@ -1559,6 +1791,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to DDR homed addresses which miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_DDR",
         "PerPkg": "1",
@@ -1568,6 +1801,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to DDR homed addresses which miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_DDR",
         "PerPkg": "1",
@@ -1577,6 +1811,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WIL requests from local IA =
cores that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WIL",
         "PerPkg": "1",
@@ -1586,6 +1821,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO",
         "PerPkg": "1",
@@ -1595,6 +1831,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO_PREF",
         "PerPkg": "1",
@@ -1604,6 +1841,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for SpecItoM events that are in=
itiated from the Core",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_SPECITOM",
         "PerPkg": "1",
@@ -1613,6 +1851,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WbMtoI requests from local =
IA cores",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WBMTOI",
         "PerPkg": "1",
@@ -1622,6 +1861,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCIL",
         "PerPkg": "1",
@@ -1631,6 +1871,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A core",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCILF",
         "PerPkg": "1",
@@ -1640,8 +1881,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : All requests from IO Devices=
",
         "UMask": "0xc001ff04",
@@ -1649,6 +1892,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for CLFlush requests from IO de=
vices",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_CLFLUSH",
         "PerPkg": "1",
@@ -1658,8 +1902,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices which hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that hit the LLC",
         "UMask": "0xc001fd04",
@@ -1667,6 +1913,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for ItoMs from local IO devices=
 which hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOM",
         "PerPkg": "1",
@@ -1676,6 +1923,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices that hit the LLC",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -1685,6 +1933,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces which hit the LLC",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_PCIRDCUR",
         "PerPkg": "1",
@@ -1694,6 +1943,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for RFOs from local IO devices =
which hit the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_RFO",
         "PerPkg": "1",
@@ -1703,6 +1953,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All TOR ItoM inserts from l=
ocal IO devices",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOM",
         "PerPkg": "1",
@@ -1712,6 +1963,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -1721,8 +1973,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices which miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that missed the LLC",
         "UMask": "0xc001fe04",
@@ -1730,6 +1984,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All TOR ItoM inserts from l=
ocal IO devices which miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
         "PerPkg": "1",
@@ -1739,6 +1994,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices that missed the LLC",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR",
         "PerPkg": "1",
@@ -1748,6 +2004,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces which miss the LLC",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR",
         "PerPkg": "1",
@@ -1757,6 +2014,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All TOR RFO inserts from lo=
cal IO devices which miss the cache",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
         "PerPkg": "1",
@@ -1766,6 +2024,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_PCIRDCUR",
         "PerPkg": "1",
@@ -1775,6 +2034,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for RFOs from local IO devices"=
,
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_RFO",
         "PerPkg": "1",
@@ -1784,6 +2044,7 @@
     },
     {
         "BriefDescription": "TOR Occupancy for WBMtoI requests from IO dev=
ices",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_WBMTOI",
         "PerPkg": "1",
@@ -1793,8 +2054,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_ALL",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : All from Local iA and IO",
         "UMask": "0xc000ff05",
@@ -1802,8 +2065,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All from Local iA",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IA",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : All from Local iA",
         "UMask": "0xc000ff01",
@@ -1811,8 +2076,10 @@
     },
     {
         "BriefDescription": "TOR Occupancy for All from Local IO",
+        "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IO",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : All from Local IO",
         "UMask": "0xc000ff04",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
index 9091f8fde51f..6aaca4039107 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-interconnect.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Clockticks of the mesh to memory (B2CMI)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_B2CMI_CLOCKTICKS",
         "PerPkg": "1",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Counts the number of times B2CMI egress did D=
2C (direct to core)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x16",
         "EventName": "UNC_B2CMI_DIRECT2CORE_TAKEN",
         "PerPkg": "1",
@@ -16,6 +18,7 @@
     },
     {
         "BriefDescription": "Counts the number of times D2C wasn't honoure=
d even though the incoming request had d2c set for non cisgress txn",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_B2CMI_DIRECT2CORE_TXN_OVERRIDE",
         "PerPkg": "1",
@@ -24,6 +27,7 @@
     },
     {
         "BriefDescription": "Counts any read",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_B2CMI_IMC_READS.ALL",
         "PerPkg": "1",
@@ -32,6 +36,7 @@
     },
     {
         "BriefDescription": "Counts normal reads issue to CMI",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_B2CMI_IMC_READS.NORMAL",
         "PerPkg": "1",
@@ -40,14 +45,17 @@
     },
     {
         "BriefDescription": "Counts reads to 1lm non persistent memory reg=
ions",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "UNC_B2CMI_IMC_READS.TO_DDR_AS_MEM",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x108",
         "Unit": "B2CMI"
     },
     {
         "BriefDescription": "All Writes - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_B2CMI_IMC_WRITES.ALL",
         "PerPkg": "1",
@@ -56,6 +64,7 @@
     },
     {
         "BriefDescription": "Full Non-ISOCH - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_B2CMI_IMC_WRITES.FULL",
         "PerPkg": "1",
@@ -64,6 +73,7 @@
     },
     {
         "BriefDescription": "Partial Non-ISOCH - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_B2CMI_IMC_WRITES.PARTIAL",
         "PerPkg": "1",
@@ -72,22 +82,27 @@
     },
     {
         "BriefDescription": "DDR - All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "UNC_B2CMI_IMC_WRITES.TO_DDR_AS_MEM",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x120",
         "Unit": "B2CMI"
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : XPT - Ch 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_B2CMI_PREFCAM_INSERTS.CH0_XPT",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "B2CMI"
     },
     {
         "BriefDescription": "Prefetch CAM Inserts : XPT -All Channels",
+        "Counter": "0,1,2,3",
         "EventCode": "0x56",
         "EventName": "UNC_B2CMI_PREFCAM_INSERTS.XPT_ALLCH",
         "PerPkg": "1",
@@ -97,14 +112,17 @@
     },
     {
         "BriefDescription": "Prefetch CAM Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x54",
         "EventName": "UNC_B2CMI_PREFCAM_OCCUPANCY.CH0",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "B2CMI"
     },
     {
         "BriefDescription": "Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x32",
         "EventName": "UNC_B2CMI_TRACKER_INSERTS.CH0",
         "PerPkg": "1",
@@ -113,6 +131,7 @@
     },
     {
         "BriefDescription": "Tracker Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x33",
         "EventName": "UNC_B2CMI_TRACKER_OCCUPANCY.CH0",
         "PerPkg": "1",
@@ -121,22 +140,27 @@
     },
     {
         "BriefDescription": "Write Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_B2CMI_WR_TRACKER_INSERTS.CH0",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "B2CMI"
     },
     {
         "BriefDescription": "Total Write Cache Occupancy : Mem",
+        "Counter": "0,1,2,3",
         "EventCode": "0x0F",
         "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.MEM",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x4",
         "Unit": "IRP"
     },
     {
         "BriefDescription": "IRP Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_I_CLOCKTICKS",
         "PerPkg": "1",
@@ -144,6 +168,7 @@
     },
     {
         "BriefDescription": "Inbound read requests received by the IRP and=
 inserted into the FAF queue",
+        "Counter": "0,1,2,3",
         "EventCode": "0x18",
         "EventName": "UNC_I_FAF_INSERTS",
         "PerPkg": "1",
@@ -151,21 +176,26 @@
     },
     {
         "BriefDescription": "FAF occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x19",
         "EventName": "UNC_I_FAF_OCCUPANCY",
+        "Experimental": "1",
         "PerPkg": "1",
         "Unit": "IRP"
     },
     {
         "BriefDescription": "Misc Events - Set 1 : Lost Forward : Snoop pu=
lled away ownership before a write was committed",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1F",
         "EventName": "UNC_I_MISC1.LOST_FWD",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x10",
         "Unit": "IRP"
     },
     {
         "BriefDescription": "Inbound write (fast path) requests to coheren=
t memory, received by the IRP resulting in write ownership requests issued =
by IRP to the mesh.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json b/too=
ls/perf/pmu-events/arch/x86/grandridge/uncore-io.json
index c301ef95ae8d..33fc7b835abf 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-io.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "IIO Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_IIO_CLOCKTICKS",
         "PerPkg": "1",
@@ -9,8 +10,10 @@
     },
     {
         "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.ALL_PARTS",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
@@ -19,8 +22,10 @@
     },
     {
         "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
@@ -29,8 +34,10 @@
     },
     {
         "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
@@ -39,8 +46,10 @@
     },
     {
         "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
@@ -49,8 +58,10 @@
     },
     {
         "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
@@ -59,8 +70,10 @@
     },
     {
         "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART4",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
@@ -69,8 +82,10 @@
     },
     {
         "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART5",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
@@ -79,8 +94,10 @@
     },
     {
         "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART6",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
@@ -89,8 +106,10 @@
     },
     {
         "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
         "EventCode": "0xC2",
         "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART7",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
@@ -99,8 +118,10 @@
     },
     {
         "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
@@ -109,8 +130,10 @@
     },
     {
         "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART0",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
@@ -119,8 +142,10 @@
     },
     {
         "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART1",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
@@ -129,8 +154,10 @@
     },
     {
         "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART2",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
@@ -139,8 +166,10 @@
     },
     {
         "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART3",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
@@ -149,8 +178,10 @@
     },
     {
         "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART4",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
@@ -159,8 +190,10 @@
     },
     {
         "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART5",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
@@ -169,8 +202,10 @@
     },
     {
         "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART6",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
@@ -179,8 +214,10 @@
     },
     {
         "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
         "EventCode": "0xD5",
         "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART7",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
@@ -189,6 +226,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.ALL_PARTS",
         "FCMask": "0x07",
@@ -199,8 +237,10 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
@@ -209,8 +249,10 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
@@ -219,8 +261,10 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
@@ -229,8 +273,10 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
@@ -239,8 +285,10 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART4",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
@@ -249,8 +297,10 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART5",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
@@ -259,8 +309,10 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART6",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
@@ -269,8 +321,10 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART7",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
@@ -279,6 +333,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.ALL_PARTS",
         "FCMask": "0x07",
@@ -289,6 +344,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
@@ -299,6 +355,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
@@ -309,6 +366,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
@@ -319,6 +377,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
@@ -329,6 +388,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART4",
         "FCMask": "0x07",
@@ -339,6 +399,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART5",
         "FCMask": "0x07",
@@ -349,6 +410,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART6",
         "FCMask": "0x07",
@@ -359,6 +421,7 @@
     },
     {
         "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC0",
         "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART7",
         "FCMask": "0x07",
@@ -369,6 +432,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
@@ -379,6 +443,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
@@ -389,6 +454,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
@@ -399,6 +465,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
@@ -409,6 +476,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
         "FCMask": "0x07",
@@ -419,6 +487,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
         "FCMask": "0x07",
@@ -429,6 +498,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
         "FCMask": "0x07",
@@ -439,6 +509,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
         "FCMask": "0x07",
@@ -449,6 +520,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
@@ -459,6 +531,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
@@ -469,6 +542,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
@@ -479,6 +553,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
@@ -489,6 +564,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
         "FCMask": "0x07",
@@ -499,6 +575,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
         "FCMask": "0x07",
@@ -509,6 +586,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
         "FCMask": "0x07",
@@ -519,6 +597,7 @@
     },
     {
         "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
         "FCMask": "0x07",
@@ -529,8 +608,10 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
@@ -539,8 +620,10 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
@@ -549,8 +632,10 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
@@ -559,8 +644,10 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
@@ -569,8 +656,10 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART4",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
@@ -579,8 +668,10 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART5",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
@@ -589,8 +680,10 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART6",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
@@ -599,8 +692,10 @@
     },
     {
         "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x83",
         "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART7",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
@@ -609,8 +704,10 @@
     },
     {
         "BriefDescription": "IOTLB Hits to a 1G Page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_IIO_IOMMU0.1G_HITS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0x10",
@@ -618,8 +715,10 @@
     },
     {
         "BriefDescription": "IOTLB Hits to a 2M Page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_IIO_IOMMU0.2M_HITS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0x8",
@@ -627,8 +726,10 @@
     },
     {
         "BriefDescription": "IOTLB Hits to a 4K Page",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_IIO_IOMMU0.4K_HITS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0x4",
@@ -636,8 +737,10 @@
     },
     {
         "BriefDescription": "Context cache hits",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_HITS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0x80",
@@ -645,8 +748,10 @@
     },
     {
         "BriefDescription": "Context cache lookups",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_LOOKUPS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0x40",
@@ -654,8 +759,10 @@
     },
     {
         "BriefDescription": "IOTLB lookups first",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_IIO_IOMMU0.FIRST_LOOKUPS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0x1",
@@ -663,8 +770,10 @@
     },
     {
         "BriefDescription": "IOTLB Fills (same as IOTLB miss)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "UNC_IIO_IOMMU0.MISSES",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0x20",
@@ -672,8 +781,10 @@
     },
     {
         "BriefDescription": "IOMMU memory access (both low and high priori=
ty)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0xc0",
@@ -681,8 +792,10 @@
     },
     {
         "BriefDescription": "Second Level Page Walk Cache Hit to a 1G page=
",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.SLPWC_1G_HITS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0x4",
@@ -690,8 +803,10 @@
     },
     {
         "BriefDescription": "Second Level Page Walk Cache Hit to a 256T pa=
ge",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.SLPWC_256T_HITS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0x10",
@@ -699,8 +814,10 @@
     },
     {
         "BriefDescription": "Second Level Page Walk Cache Hit to a 512G pa=
ge",
+        "Counter": "0,1,2,3",
         "EventCode": "0x41",
         "EventName": "UNC_IIO_IOMMU1.SLPWC_512G_HITS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "UMask": "0x8",
@@ -708,8 +825,10 @@
     },
     {
         "BriefDescription": "-",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.ABORT",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
@@ -718,8 +837,10 @@
     },
     {
         "BriefDescription": "-",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.CONFINED_P2P",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
@@ -728,8 +849,10 @@
     },
     {
         "BriefDescription": "-",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.LOC_P2P",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
@@ -738,8 +861,10 @@
     },
     {
         "BriefDescription": "-",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MCAST",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
@@ -748,8 +873,10 @@
     },
     {
         "BriefDescription": "-",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MEM",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
@@ -758,8 +885,10 @@
     },
     {
         "BriefDescription": "-",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MSGB",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
@@ -768,8 +897,10 @@
     },
     {
         "BriefDescription": "-",
+        "Counter": "0,1,2,3",
         "EventCode": "0x8e",
         "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
@@ -778,14 +909,17 @@
     },
     {
         "BriefDescription": "All 9 bits of Page Walk Tracker Occupancy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x42",
         "EventName": "UNC_IIO_PWT_OCCUPANCY",
+        "Experimental": "1",
         "PerPkg": "1",
         "PortMask": "0x000",
         "Unit": "IIO"
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
@@ -796,6 +930,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
@@ -806,6 +941,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
@@ -816,6 +952,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
@@ -826,6 +963,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART4",
         "FCMask": "0x07",
@@ -836,6 +974,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART5",
         "FCMask": "0x07",
@@ -846,6 +985,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART6",
         "FCMask": "0x07",
@@ -856,6 +996,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART7",
         "FCMask": "0x07",
@@ -866,6 +1007,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
@@ -876,6 +1018,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
@@ -886,6 +1029,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
@@ -896,6 +1040,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
@@ -906,6 +1051,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART4",
         "FCMask": "0x07",
@@ -916,6 +1062,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART5",
         "FCMask": "0x07",
@@ -926,6 +1073,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART6",
         "FCMask": "0x07",
@@ -936,6 +1084,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
         "EventCode": "0xC1",
         "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART7",
         "FCMask": "0x07",
@@ -946,6 +1095,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
         "FCMask": "0x07",
@@ -956,6 +1106,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
         "FCMask": "0x07",
@@ -966,6 +1117,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
         "FCMask": "0x07",
@@ -976,6 +1128,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
         "FCMask": "0x07",
@@ -986,6 +1139,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART4",
         "FCMask": "0x07",
@@ -996,6 +1150,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART5",
         "FCMask": "0x07",
@@ -1006,6 +1161,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART6",
         "FCMask": "0x07",
@@ -1016,6 +1172,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART7",
         "FCMask": "0x07",
@@ -1026,6 +1183,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
         "FCMask": "0x07",
@@ -1036,6 +1194,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
         "FCMask": "0x07",
@@ -1046,6 +1205,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
         "FCMask": "0x07",
@@ -1056,6 +1216,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
         "FCMask": "0x07",
@@ -1066,6 +1227,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART4",
         "FCMask": "0x07",
@@ -1076,6 +1238,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART5",
         "FCMask": "0x07",
@@ -1086,6 +1249,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART6",
         "FCMask": "0x07",
@@ -1096,6 +1260,7 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART7",
         "FCMask": "0x07",
@@ -1106,8 +1271,10 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
@@ -1116,8 +1283,10 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
@@ -1126,8 +1295,10 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
@@ -1136,8 +1307,10 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
@@ -1146,8 +1319,10 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART4",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
@@ -1156,8 +1331,10 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART5",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
@@ -1166,8 +1343,10 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART6",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
@@ -1176,8 +1355,10 @@
     },
     {
         "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART7",
+        "Experimental": "1",
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
index a2405ed640c9..7e6e6764f181 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "DRAM Activate Count : Counts the number of DR=
AM Activate commands sent on this channel.  Activate commands are issued to=
 open up a page on the DRAM devices so that it can be read or written to wi=
th a CAS.  One can calculate the number of Page Misses by subtracting the n=
umber of Page Miss precharges from the number of Activates.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_M_ACT_COUNT.ALL",
         "PerPkg": "1",
@@ -9,30 +10,37 @@
     },
     {
         "BriefDescription": "DRAM Activate Count : Read transaction on Pag=
e Empty or Page Miss : Counts the number of DRAM Activate commands sent on =
this channel.  Activate commands are issued to open up a page on the DRAM d=
evices so that it can be read or written to with a CAS.  One can calculate =
the number of Page Misses by subtracting the number of Page Miss precharges=
 from the number of Activates.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_M_ACT_COUNT.RD",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xf1",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "DRAM Activate Count : Underfill Read transact=
ion on Page Empty or Page Miss : Counts the number of DRAM Activate command=
s sent on this channel.  Activate commands are issued to open up a page on =
the DRAM devices so that it can be read or written to with a CAS.  One can =
calculate the number of Page Misses by subtracting the number of Page Miss =
precharges from the number of Activates.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_M_ACT_COUNT.UFILL",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xf4",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "DRAM Activate Count : Write transaction on Pa=
ge Empty or Page Miss : Counts the number of DRAM Activate commands sent on=
 this channel.  Activate commands are issued to open up a page on the DRAM =
devices so that it can be read or written to with a CAS.  One can calculate=
 the number of Page Misses by subtracting the number of Page Miss precharge=
s from the number of Activates.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_M_ACT_COUNT.WR",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xf2",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "CAS count for SubChannel 0, all CAS operation=
s",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT_SCH0.ALL",
         "PerPkg": "1",
@@ -41,6 +49,7 @@
     },
     {
         "BriefDescription": "CAS count for SubChannel 0, all reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT_SCH0.RD",
         "PerPkg": "1",
@@ -49,6 +58,7 @@
     },
     {
         "BriefDescription": "CAS count for SubChannel 0 regular reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT_SCH0.RD_REG",
         "PerPkg": "1",
@@ -57,6 +67,7 @@
     },
     {
         "BriefDescription": "CAS count for SubChannel 0 underfill reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT_SCH0.RD_UNDERFILL",
         "PerPkg": "1",
@@ -65,6 +76,7 @@
     },
     {
         "BriefDescription": "CAS count for SubChannel 0, all writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT_SCH0.WR",
         "PerPkg": "1",
@@ -73,22 +85,27 @@
     },
     {
         "BriefDescription": "CAS count for SubChannel 0 regular writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT_SCH0.WR_NONPRE",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xd0",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "CAS count for SubChannel 0 auto-precharge wri=
tes",
+        "Counter": "0,1,2,3",
         "EventCode": "0x05",
         "EventName": "UNC_M_CAS_COUNT_SCH0.WR_PRE",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xe0",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "CAS count for SubChannel 1, all CAS operation=
s",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_COUNT_SCH1.ALL",
         "PerPkg": "1",
@@ -97,6 +114,7 @@
     },
     {
         "BriefDescription": "CAS count for SubChannel 1, all reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_COUNT_SCH1.RD",
         "PerPkg": "1",
@@ -105,6 +123,7 @@
     },
     {
         "BriefDescription": "CAS count for SubChannel 1 regular reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_COUNT_SCH1.RD_REG",
         "PerPkg": "1",
@@ -113,6 +132,7 @@
     },
     {
         "BriefDescription": "CAS count for SubChannel 1 underfill reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_COUNT_SCH1.RD_UNDERFILL",
         "PerPkg": "1",
@@ -121,6 +141,7 @@
     },
     {
         "BriefDescription": "CAS count for SubChannel 1, all writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_COUNT_SCH1.WR",
         "PerPkg": "1",
@@ -129,22 +150,27 @@
     },
     {
         "BriefDescription": "CAS count for SubChannel 1 regular writes",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_COUNT_SCH1.WR_NONPRE",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xd0",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "CAS count for SubChannel 1 auto-precharge wri=
tes",
+        "Counter": "0,1,2,3",
         "EventCode": "0x06",
         "EventName": "UNC_M_CAS_COUNT_SCH1.WR_PRE",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xe0",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "Number of DRAM DCLK clock cycles while the ev=
ent is enabled",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
@@ -154,14 +180,17 @@
     },
     {
         "BriefDescription": "Number of DRAM HCLK clock cycles while the ev=
ent is enabled",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M_HCLOCKTICKS",
+        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "DRAM Clockticks",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.ALL",
         "PerPkg": "1",
@@ -170,6 +199,7 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands. : Precharge due to (=
?) : Counts the number of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.PGT",
         "PerPkg": "1",
@@ -178,46 +208,57 @@
     },
     {
         "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.RD",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xf1",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.UFILL",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xf4",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.WR",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xf2",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "Read buffer inserts on subchannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M_RDB_INSERTS.SCH0",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x40",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "Read buffer inserts on subchannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x17",
         "EventName": "UNC_M_RDB_INSERTS.SCH1",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x80",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "Read buffer occupancy on subchannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1a",
         "EventName": "UNC_M_RDB_OCCUPANCY_SCH0",
         "PerPkg": "1",
@@ -225,6 +266,7 @@
     },
     {
         "BriefDescription": "Read buffer occupancy on subchannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x1b",
         "EventName": "UNC_M_RDB_OCCUPANCY_SCH1",
         "PerPkg": "1",
@@ -232,22 +274,27 @@
     },
     {
         "BriefDescription": "Read Pending Queue Allocations : Counts the n=
umber of allocations into the Read Pending Queue.  This queue is used to sc=
hedule reads out to the memory controller and to track the requests.  Reque=
sts allocate into the RPQ soon after they enter the memory controller, and =
need credits for an entry in this buffer before being sent from the HA to t=
he iMC.  They deallocate after the CAS command has been issued to memory.  =
This includes both ISOCH and non-ISOCH requests.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS.PCH0",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x50",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "Read Pending Queue Allocations : Counts the n=
umber of allocations into the Read Pending Queue.  This queue is used to sc=
hedule reads out to the memory controller and to track the requests.  Reque=
sts allocate into the RPQ soon after they enter the memory controller, and =
need credits for an entry in this buffer before being sent from the HA to t=
he iMC.  They deallocate after the CAS command has been issued to memory.  =
This includes both ISOCH and non-ISOCH requests.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS.PCH1",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xa0",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "Read Pending Queue inserts for subchannel 0, =
pseudochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS.SCH0_PCH0",
         "PerPkg": "1",
@@ -256,6 +303,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue inserts for subchannel 0, =
pseudochannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS.SCH0_PCH1",
         "PerPkg": "1",
@@ -264,6 +312,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue inserts for subchannel 1, =
pseudochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS.SCH1_PCH0",
         "PerPkg": "1",
@@ -272,6 +321,7 @@
     },
     {
         "BriefDescription": "Read Pending Queue inserts for subchannel 1, =
pseudochannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x10",
         "EventName": "UNC_M_RPQ_INSERTS.SCH1_PCH1",
         "PerPkg": "1",
@@ -280,6 +330,7 @@
     },
     {
         "BriefDescription": "Read pending queue occupancy for subchannel 0=
, pseudochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "UNC_M_RPQ_OCCUPANCY_SCH0_PCH0",
         "PerPkg": "1",
@@ -287,6 +338,7 @@
     },
     {
         "BriefDescription": "Read pending queue occupancy for subchannel 0=
, pseudochannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "UNC_M_RPQ_OCCUPANCY_SCH0_PCH1",
         "PerPkg": "1",
@@ -294,6 +346,7 @@
     },
     {
         "BriefDescription": "Read pending queue occupancy for subchannel 1=
, pseudochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x82",
         "EventName": "UNC_M_RPQ_OCCUPANCY_SCH1_PCH0",
         "PerPkg": "1",
@@ -301,6 +354,7 @@
     },
     {
         "BriefDescription": "Read pending queue occupancy for subchannel 1=
, pseudochannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "UNC_M_RPQ_OCCUPANCY_SCH1_PCH1",
         "PerPkg": "1",
@@ -308,22 +362,27 @@
     },
     {
         "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M_WPQ_INSERTS.PCH0",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x50",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M_WPQ_INSERTS.PCH1",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0xa0",
         "Unit": "IMC"
     },
     {
         "BriefDescription": "Write Pending Queue inserts for subchannel 0,=
 pseudochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M_WPQ_INSERTS.SCH0_PCH0",
         "PerPkg": "1",
@@ -332,6 +391,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue inserts for subchannel 0,=
 pseudochannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M_WPQ_INSERTS.SCH0_PCH1",
         "PerPkg": "1",
@@ -340,6 +400,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue inserts for subchannel 1,=
 pseudochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M_WPQ_INSERTS.SCH1_PCH0",
         "PerPkg": "1",
@@ -348,6 +409,7 @@
     },
     {
         "BriefDescription": "Write Pending Queue inserts for subchannel 1,=
 pseudochannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x22",
         "EventName": "UNC_M_WPQ_INSERTS.SCH1_PCH1",
         "PerPkg": "1",
@@ -356,6 +418,7 @@
     },
     {
         "BriefDescription": "Write pending queue occupancy for subchannel =
0, pseudochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x84",
         "EventName": "UNC_M_WPQ_OCCUPANCY_SCH0_PCH0",
         "PerPkg": "1",
@@ -363,6 +426,7 @@
     },
     {
         "BriefDescription": "Write pending queue occupancy for subchannel =
0, pseudochannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "UNC_M_WPQ_OCCUPANCY_SCH0_PCH1",
         "PerPkg": "1",
@@ -370,6 +434,7 @@
     },
     {
         "BriefDescription": "Write pending queue occupancy for subchannel =
1, pseudochannel 0",
+        "Counter": "0,1,2,3",
         "EventCode": "0x86",
         "EventName": "UNC_M_WPQ_OCCUPANCY_SCH1_PCH0",
         "PerPkg": "1",
@@ -377,6 +442,7 @@
     },
     {
         "BriefDescription": "Write pending queue occupancy for subchannel =
1, pseudochannel 1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "UNC_M_WPQ_OCCUPANCY_SCH1_PCH1",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/grandridge/uncore-power.json
index e3a66166e28c..02e59f64a544 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-power.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "PCU Clockticks",
+        "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_P_CLOCKTICKS",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json
index 371974c6d6c3..35cc5b6d41f2 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/virtual-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccounts for all page sizes. Will result in a DTLB write from STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "SampleAfterValue": "200003",
@@ -8,6 +9,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "200003",
@@ -15,6 +17,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 2M or 4M page.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 2M or 4M pa=
ges. Includes page walks that page fault.",
@@ -23,6 +26,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 4K page.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 4K pages. I=
ncludes page walks that page fault.",
@@ -31,6 +35,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks outstanding f=
or Loads (demand or SW prefetch) in PMH every cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
         "PublicDescription": "Counts the number of page walks outstanding =
for Loads (demand or SW prefetch) in PMH every cycle.  A PMH page walk is o=
utstanding from page walk start till PMH becomes idle again (ready to serve=
 next walk). Includes EPT-walk intervals.",
@@ -39,6 +44,7 @@
     },
     {
         "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to stores that did not start a page walk. Accounts=
 for all pages sizes. Will result in a DTLB write from STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "SampleAfterValue": "2000003",
@@ -46,6 +52,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 1G page.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "SampleAfterValue": "2000003",
@@ -53,6 +60,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 2M or 4M page.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includes page walks=
 that page fault.",
@@ -61,6 +69,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 4K page.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 4K pages.  Includes page walks that =
page fault.",
@@ -69,6 +78,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks outstanding i=
n the page miss handler (PMH) for stores every cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
         "PublicDescription": "Counts the number of page walks outstanding =
in the page miss handler (PMH) for stores every cycle. A PMH page walk is o=
utstanding from page walk start till PMH becomes idle again (ready to serve=
 next walk). Includes EPT-walk intervals.",
@@ -77,6 +87,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks initiated by =
a instruction fetch that missed the first and second level TLBs.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
         "SampleAfterValue": "1000003",
@@ -84,6 +95,7 @@
     },
     {
         "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to an instruction fetch that did not start a page =
walk. Account for all pages sizes. Will result in an ITLB write from STLB."=
,
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT",
         "SampleAfterValue": "2000003",
@@ -91,6 +103,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
@@ -99,6 +112,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 2M or 4M page.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includ=
es page walks that page fault.",
@@ -107,6 +121,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 4K page.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 4K pages.  Includes pag=
e walks that page fault.",
@@ -115,6 +130,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks outstanding f=
or iside in PMH every cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_PENDING",
         "PublicDescription": "Counts the number of page walks outstanding =
for iside in PMH every cycle.  A PMH page walk is outstanding from page wal=
k start till PMH becomes idle again (ready to serve next walk). Includes EP=
T-walk intervals.  Walks could be counted by edge detecting on this event, =
but would count restarted suspended walks.",
@@ -123,6 +139,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DTLB=
 miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.DTLB_MISS_AT_RET",
         "SampleAfterValue": "1000003",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index a53b88154a58..53c16bb56fdf 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -10,7 +10,7 @@ GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.09,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-B6,v1.02,grandridge,core
+GenuineIntel-6-B6,v1.03,grandridge,core
 GenuineIntel-6-A[DE],v1.01,graniterapids,core
 GenuineIntel-6-(3C|45|46),v35,haswell,core
 GenuineIntel-6-3F,v28,haswellx,core
--=20
2.45.2.627.g7a2c4fd464-goog


