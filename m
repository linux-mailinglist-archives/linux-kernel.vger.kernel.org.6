Return-Path: <linux-kernel+bounces-575744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26326A706AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250CC7A1890
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A02625A323;
	Tue, 25 Mar 2025 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrJujh16"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9C5383
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919764; cv=none; b=nGDLP62DVmLRkDfyE7e5U0a5RG7hYEXjyLP3dyLNqPzJqvikSWAWxNlknAcGfVctqBelRkl6bZGWvqaLwWyXj8A2mknAw+W+nMiko1ncY4kbdOqxCtvdCq0WFxPIqNzANf47WAd0rQmQQ5POdu/eksvzhi3GcmtRkE7ifY05AWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919764; c=relaxed/simple;
	bh=Lp8ulElygeIKQ2bznVf0xqu32MtL52Ef9WdWB4yntak=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HQU3Hf0RQuZabG5fqV89eNwKmuLanKcttv9qtbUgvNCzzNUO3sD6Uvrb3ktcD3gVjUAkoSWbrgv9/b/E9EDsHvu6f9thJcN+L7MY+nrPwhYBIXoyegyWTJDsm5b5drC9V5kJ1UEvBEe+z9ukORKvJ9vnr4bhvbeUeBBzzyEB3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrJujh16; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6feb1097d64so69551187b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742919761; x=1743524561; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rht91ZAFHO6cO1rQpcP3HoB9XpYfuaUL/MILI96bbSc=;
        b=GrJujh16+ElaYBbIINNwttEpTby1y0BVjXJlKTP1vhN5mMeEt5EURZdsxxxxOv7K4h
         ah8dhhLJa3a0BD84Fra+SO3J/ro+IUCxdFjhQkoJtiXPNQY/BH9Ir+x6PIHS1fk3UNmp
         Ff9ylMSw316Z5QaxPtkl1kOs+gn9fpWMc6TCmjr6wFxvQHKp9m7PS6yFsZ1VUn040Ry4
         6/f09+i9eBk4jxnH/fX2YRhbVQ+ouA2E0cLhjHUlSG5/bg6LSjlWyZOsmKGONpLNpG0Y
         EK46HkNa+sJv/6T11je3G3f5b2EModb0GXkJ6UzeW0+a96hIbwRwnTBTXpsaFmigAWiy
         IZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919761; x=1743524561;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rht91ZAFHO6cO1rQpcP3HoB9XpYfuaUL/MILI96bbSc=;
        b=TcO1pAyLRD/L/1vjQvh7gXq7XewYQQCM1gvxZ5Afc+sn7hofRQwnk6FaiKhIE2Mc6t
         b4XTof5PMn6R2T4ple7u5BOXWVFtHSQuP827ygbFzrhrsBL7Vf5ZhvnDvIia4Z46Q0br
         Fhv7n8n06R9VlRMw6bW1afPreajgq/jRmPqJ1JCjEy4hQXpQaSV9tpMV3gQnzF1lAaRv
         3hFtho9wEWP8xGlk7VS9b+lMbptHgMKoC8/p1vAk4VmXCoPyyvAZwvtuyatatyP3Qvk8
         vII2Gx5jVd40GW1N3JvqKbZeNcFOoIlUcw8TjN3miM+bLHZ38m4TzMkbH4TzBskRzvX5
         cx4g==
X-Forwarded-Encrypted: i=1; AJvYcCVjQOMvL+t69OayZehmtc0TGD8hquzdQFiEbSSAze+QKhw9oJMt/GwvwvN8Or8Tn+5E7dSbgCcO36C5ZO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDi8/yF+/HN2NMcT3PBUMHmttf2i4BgxwWew+mhhLPBcAtpF5
	DOWjN+s+UvnW9IuUGLbiIx3MGIX6Imqe15PLQlK3atnWgM9ET3HDjKxzZnmPZaEQyuKlD1/dVE8
	dplpEUA==
X-Google-Smtp-Source: AGHT+IHsVdjMuqVkK3GlpZMPU4yjfOrqA0C18J8csIwJ1Ze6DlspKZbMFBmlMBTbfIP5N5aqIWFlzEBGgXF4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6e0e:b0:6fb:9c08:4990 with SMTP
 id 00721157ae682-700bacbc2b7mr130817b3.4.1742919761336; Tue, 25 Mar 2025
 09:22:41 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:15:02 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-27-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 26/35] perf vendor events: Update sandybridge metrics
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

Update TMA metrics from 4.8 to 5.02. Move INSTS_WRITTEN_TO_IQ.INSTS to
the frontend topic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/sandybridge/frontend.json        |  8 +++++
 .../arch/x86/sandybridge/metricgroups.json    |  5 +++
 .../arch/x86/sandybridge/other.json           |  8 -----
 .../arch/x86/sandybridge/snb-metrics.json     | 36 ++++++++++++++-----
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json b/too=
ls/perf/pmu-events/arch/x86/sandybridge/frontend.json
index e95d1005e22f..5c9ab7680762 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
@@ -278,5 +278,13 @@
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_LE_3_UOP_DELIV.CORE",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Valid instructions written to IQ per cycle.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "INSTS_WRITTEN_TO_IQ.INSTS",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json b=
/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
index 7dc7eb0d3dd3..eb8fbd14138a 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/metricgroups.json
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
@@ -33,6 +34,7 @@
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
@@ -48,6 +50,7 @@
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
@@ -75,6 +78,7 @@
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
@@ -99,6 +103,7 @@
     "tma_issueSmSt": "Metrics related by the issue $issueSmSt",
     "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
     "tma_issueTLB": "Metrics related by the issue $issueTLB",
+    "tma_itlb_misses_group": "Metrics contributing to tma_itlb_misses cate=
gory",
     "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
     "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/other.json b/tools/=
perf/pmu-events/arch/x86/sandybridge/other.json
index 42692fa24b6c..970839a9c786 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/other.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/other.json
@@ -33,14 +33,6 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
-    {
-        "BriefDescription": "Valid instructions written to IQ per cycle.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x17",
-        "EventName": "INSTS_WRITTEN_TO_IQ.INSTS",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Cycles when L1 and L2 are locked due to UC or=
 split lock.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json b/=
tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
index ff2e515c744a..823d8b7c4224 100644
--- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
@@ -127,7 +127,7 @@
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
@@ -211,7 +211,7 @@
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
         "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_6, tma_ports=
_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -220,7 +220,7 @@
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
         "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_port_6, tma_ports=
_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -240,7 +240,7 @@
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
@@ -275,6 +275,12 @@
         "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 4 > 0.35",
         "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_lcp"
     },
+    {
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "BR_INST_RETIRED.NEAR_TAKEN / tma_info_thread_clks",
+        "MetricGroup": "Branches;FetchBW",
+        "MetricName": "tma_info_frontend_tbpc"
+    },
     {
         "BriefDescription": "Total number of retired Instructions",
         "MetricExpr": "INST_RETIRED.ANY",
@@ -290,7 +296,7 @@
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
@@ -308,14 +314,14 @@
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
ads and writes [GB / sec]. Related metrics: tma_mem_bandwidth"
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
@@ -340,6 +346,13 @@
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
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
@@ -352,6 +365,13 @@
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
@@ -448,7 +468,7 @@
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
counters for that). Related metrics: tma_info_system_dram_bw_use",
--=20
2.49.0.395.g12beb8f557-goog


