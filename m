Return-Path: <linux-kernel+bounces-576330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CE5A70DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599AD3B971E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C513777E;
	Wed, 26 Mar 2025 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvrG82UN"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14018376
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947668; cv=none; b=OWu+/98tlNoguusam5McixPjuSn9kBTOWDSgc1N6TaztVk6HJ63KAaAq4t/vbb2IoCBDzE1ryrBUNxLh/kdroRKcCeL6pBzOlNnYq48BAMoaVbaf9KD4v9X05ERbPvkegdNy96KSxGkvYVJsYeAEPWj3npTUDNXbPJFA4LKM0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947668; c=relaxed/simple;
	bh=VCgSUoDyn8HKLqzmgh7KL88mTyxyID3ZHa2mEWl9iLg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PZNEoncN/nJYaAo65gALPUrfVnuUbR+XIsc8KQuB+kdRzlDy4cX6P5BTQlOCzTn+wbp+QGNvEoVogSeFpuJYNqbwajq/0FwIbf4A5Z5P5fKmK7Gq9rl3/z+aGR8ebshIQo5be5JI6Ucmp9v5F40HLQiUJKsP718Kcyt1Uhywuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvrG82UN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2241e7e3addso91365185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947664; x=1743552464; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ni4SJHLrRP3Qlhbq7D+TPU+znQiai8CoM4wEG4fVdKI=;
        b=EvrG82UNObNX22YiHtVu4QLuOcplnSGOmeFEHhSgVv9UCCGBusj/Wzv0kYr5tw/ubO
         Xdav7zXrnVi9V8l0Epueh31WKap5UYUtKHFh06LbkrpH55XW+oD7Iw6oWNexNCWWPdVn
         fdIDOcubVVclu5WSxAXu4+29jRj3xPY+DGJNhmuzXh8D5N5SQdIM4+NPa2n3jE2hQVTm
         SACe+udcF2WaOhPvML74otOxnyc57VJMg1N/bElhjZJBLSbO9wK0ZrK4MdJ/MRzsnmEJ
         YbuvcpA+defj/3pJIsw0zqkS1gPz2bIMRdSBwyZDQqgPCqz0sWqPM41LQDMXMet2H5Z3
         EC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947664; x=1743552464;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ni4SJHLrRP3Qlhbq7D+TPU+znQiai8CoM4wEG4fVdKI=;
        b=ZN+nWq0slhSRTknrncs1sUSbUvouYe85LNsQIkkAII9GyJjid7q/8Aes7CWckiU7Vf
         PV+xDy9D6kstgQ/RLAAZ9ir52Kg/9Oz4DJZInudy8fsB/KckCzqeWASjVK+qxxRKgAQC
         Q/qv/ORCyKeY9EPtaSivY5qY0DnBraY46+tWNgHZ5M45kMZY3ENwh31QbqWfvZfxLFvN
         oJCWFCuuRCcuIrjgkdm2Eaa5+x8l3gQjeLRzeRK2OxtN6UFw8kn47XxvdRBNm2kL5ZKc
         N0iKD8OdQwKAFprZoLueOnXGWbW4qMMs6oxGTXYiRHCuKqwO9oYdtM5KFwA+R8Ss6bF6
         3saw==
X-Forwarded-Encrypted: i=1; AJvYcCUtQEKWx7y1nT94BFzA4Uc2/ZoOR19GUR26nfRoiba7SqBMsA4+TpvBTiNUERzeEmn6URTXoZvN6o9JPys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXiy8LmWvG+SrPyWV8JqmRf4sW5X2Ot2td33IRJZkkQ+9g+E87
	aJa0cMiwB1qhj1hJaWBziGhiYXIVc/3RXKnKfiSMliiDLMsjDLUpxoibn1RRHeUPFqyvhMcDyND
	PZvD/+Q==
X-Google-Smtp-Source: AGHT+IE0yvE5R8zS++QQwXmgFe9oEWEr63eqK9HNjwtMO4jIRQ9T3a/sgvCXuGeOd9MwabBUfpz9fRzAV7Bp
X-Received: from pffa21.prod.google.com ([2002:a62:bd15:0:b0:736:6224:4b5b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:80e:b0:730:79bf:c893
 with SMTP id d2e1a72fcca58-7390593d618mr25933695b3a.4.1742947664522; Tue, 25
 Mar 2025 17:07:44 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:16 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-19-irogers@google.com>
Subject: [PATCH v3 18/35] perf vendor events: Update ivybridge metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update TMA metrics from 4.8 to 5.02.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/ivybridge/ivb-metrics.json       | 76 +++++++++++++------
 .../arch/x86/ivybridge/metricgroups.json      |  5 ++
 2 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json b/to=
ols/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
index 77d37db98b70..de651ff9f846 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
@@ -151,7 +151,7 @@
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(60 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM * (1=
 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD=
_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_MISS + M=
EM_LOAD_UOPS_RETIRED.LLC_MISS))) + 43 * (MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP=
_MISS * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT =
+ MEM_LOAD_UOPS_RETIRED.LLC_HIT + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT + =
MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSN=
P_MISS + MEM_LOAD_UOPS_RETIRED.LLC_MISS)))) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_l3_bound_group",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. Re=
lated metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma=
_remote_cache",
@@ -184,7 +184,7 @@
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_UOPS",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
         "ScaleUnit": "100%"
     },
     {
@@ -236,7 +236,7 @@
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
         "MetricExpr": "60 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER=
_CORE / tma_info_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_store_bound_group",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM. Related=
 metrics: tma_contested_accesses, tma_data_sharing, tma_machine_clears, tma=
_remote_cache",
@@ -246,7 +246,7 @@
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.FB_FULL\\,cmask\\=3D1@ / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
         "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_ba=
ndwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
@@ -305,7 +305,7 @@
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
         "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -314,7 +314,7 @@
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
         "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -334,7 +334,7 @@
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. ([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+] .)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences.([ICL+] Note this may overcoun=
t due to approximation using indirect events; [ADL+])",
         "ScaleUnit": "100%"
     },
     {
@@ -346,7 +346,7 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
         "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * BR_MISP_EXEC.INDIRECT)",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
@@ -397,6 +397,12 @@
         "MetricGroup": "Fed",
         "MetricName": "tma_info_frontend_ipunknown_branch"
     },
+    {
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "BR_INST_RETIRED.NEAR_TAKEN / tma_info_thread_clks",
+        "MetricGroup": "Branches;FetchBW",
+        "MetricName": "tma_info_frontend_tbpc"
+    },
     {
         "BriefDescription": "Branch instructions per taken branch.",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
@@ -474,7 +480,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw"
     },
@@ -486,7 +492,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l2_cache_fill_bw"
     },
@@ -504,7 +510,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / tma_info_system=
_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l3_cache_fill_bw"
     },
@@ -523,7 +529,7 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricGroup": "LockCont;Memory_Lat;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_miss_latency"
     },
     {
@@ -555,7 +561,7 @@
         "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
+        "BriefDescription": "",
         "MetricExpr": "UOPS_EXECUTED.THREAD / (cpu@UOPS_EXECUTED.CORE\\,cm=
ask\\=3D1@ / 2 if #SMT_on else UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
@@ -568,7 +574,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -586,14 +592,14 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / duration_time / 1e3",
+        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_RE=
QUESTS.ALL) / 1e6 / tma_info_system_time / 1e3",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
         "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth,=
 tma_sq_full"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / duration_time",
+        "MetricExpr": "(FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE + FP_COMP_OPS_EX=
E.SSE_SCALAR_DOUBLE + 2 * FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE + 4 * (FP_COMP_=
OPS_EXE.SSE_PACKED_SINGLE + SIMD_FP_256.PACKED_DOUBLE) + 8 * SIMD_FP_256.PA=
CKED_SINGLE) / 1e9 / tma_info_system_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width"
@@ -618,6 +624,19 @@
         "MetricName": "tma_info_system_kernel_utilization",
         "MetricThreshold": "tma_info_system_kernel_utilization > 0.05"
     },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P / CPU_CLK_UNHALTED.THREAD=
",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9"
+    },
+    {
+        "BriefDescription": "Total package Power in Watts",
+        "MetricExpr": "power@energy\\-pkg@ * 15.6 / (tma_info_system_time =
* 1e6)",
+        "MetricGroup": "Power;SoC",
+        "MetricName": "tma_info_system_power"
+    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
@@ -630,6 +649,13 @@
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_socket_clks"
     },
+    {
+        "BriefDescription": "Run duration time in seconds",
+        "MetricExpr": "duration_time",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_time",
+        "MetricThreshold": "tma_info_system_time < 1"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
@@ -691,12 +717,12 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 Data (L1D) cache",
         "MetricExpr": "max((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.ST=
ALLS_LDM_PENDING) - CYCLE_ACTIVITY.STALLS_L1D_PENDING) / tma_info_thread_cl=
ks, 0)",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
         "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_UOPS_RETIRED.L1_HIT_PS;MEM_LOAD_UOPS_=
RETIRED.HIT_LFB_PS. Related metrics: tma_clears_resteers, tma_machine_clear=
s, tma_microcode_sequencer, tma_ms_switches, tma_ports_utilized_1",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_UOPS_RETIRED.L1_HIT_PS. Related me=
trics: tma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tm=
a_ms_switches, tma_ports_utilized_1",
         "ScaleUnit": "100%"
     },
     {
@@ -761,7 +787,7 @@
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRED.ALL_=
STORES * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTANDING.CYCLES_W=
ITH_DEMAND_RFO) / tma_info_thread_clks",
-        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
+        "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_UOPS_RETIRED.LOCK_LOA=
DS_PS. Related metrics: tma_store_latency",
@@ -781,7 +807,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_fb_full, tma_info_system_dram_bw_u=
se, tma_sq_full",
@@ -840,7 +866,7 @@
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED_PORT.PORT_0. Related metrics: tma_fp_=
scalar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vecto=
r_512b, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -849,7 +875,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED_PORT.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vect=
or_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_5, tm=
a_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_5, tma_por=
t_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -949,7 +975,7 @@
         "MetricExpr": "13 * LD_BLOCKS.NO_SR / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
-        "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_split_loads > 0.3",
         "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_UOPS_RETIRED.SPLIT_LOADS_PS",
         "ScaleUnit": "100%"
     },
@@ -965,7 +991,7 @@
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
         "MetricExpr": "(OFFCORE_REQUESTS_BUFFER.SQ_FULL / 2 if #SMT_on els=
e OFFCORE_REQUESTS_BUFFER.SQ_FULL) / tma_info_core_core_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_system_dram_bw_use, tma_mem_bandwidth",
@@ -993,7 +1019,7 @@
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(L2_RQSTS.RFO_HIT * 9 * (1 - MEM_UOPS_RETIRED.LOCK_=
LOADS / MEM_UOPS_RETIRED.ALL_STORES) + (1 - MEM_UOPS_RETIRED.LOCK_LOADS / M=
EM_UOPS_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS=
_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
-        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
issueRFO;tma_issueSL;tma_store_bound_group",
+        "MetricGroup": "BvML;LockCont;MemoryLat;Offcore;TopdownL4;tma_L4_g=
roup;tma_issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/metricgroups.json b/t=
ools/perf/pmu-events/arch/x86/ivybridge/metricgroups.json
index 4193c90c3459..0863375bdead 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/metricgroups.json
@@ -9,6 +9,7 @@
     "BvCB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvFB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvIO": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvML": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvMP": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "BvMS": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
@@ -34,6 +35,7 @@
     "InsType": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "LockCont": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "MachineClears": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
     "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -51,6 +53,7 @@
     "Pipeline": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "PortsUtil": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
     "Power": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "Prefetches": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
     "Ret": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "Retire": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
     "SMT": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -78,6 +81,7 @@
     "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
     "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
     "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
+    "tma_divider_group": "Metrics contributing to tma_divider category",
     "tma_dram_bound_group": "Metrics contributing to tma_dram_bound catego=
ry",
     "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load category=
",
     "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store catego=
ry",
@@ -103,6 +107,7 @@
     "tma_issueSpSt": "Metrics related by the issue $issueSpSt",
     "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
     "tma_issueTLB": "Metrics related by the issue $issueTLB",
+    "tma_itlb_misses_group": "Metrics contributing to tma_itlb_misses cate=
gory",
     "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
     "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
--=20
2.49.0.395.g12beb8f557-goog


