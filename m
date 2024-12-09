Return-Path: <linux-kernel+bounces-438491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933089EA1DF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85CF1612B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35C19F11B;
	Mon,  9 Dec 2024 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXSDxTSA"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838D19E830
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783343; cv=none; b=TUggMNpCGIqPK5bJykRQIq1fQMEiUnBA7kWZ1c9vlvpAE7AWFSVFbxhh10HOuvlUft47Uv3cSgZAB1b3u7RTQmh2Skc694BF9tf7w89K+8+4LBZ+8OQfH4aDOQUKxKlo4APglpY+yURumnCYWmyJDYdeaJ25zqzss4Sa5YfFCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783343; c=relaxed/simple;
	bh=sSPgpyTCAiLPucTa4obuMMC4+qNlmoKnD0o/ckzsWlU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U7MT6TjcrlANUPnyVi5prleFGl4embSDyS8iFhd0eu6KqVM26psY/8tp8HNWTBnFBG9plGA35OJ8Wt2rI0QZZjXBqFntaQTJSBt70ZpUlgNDlU2qS79/7c+WEtVH5zW3TcetLRBJ5kpZVZWJUEjni7fUOjwH8tO5Ox4vtaF4UOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HXSDxTSA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ef4e426a3fso8622297b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 14:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733783317; x=1734388117; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Py+JhVWHoRj2WWldJqCyq0p8P5Al3/30p4SRpdI70Vo=;
        b=HXSDxTSAYi+wEh2MoNNncdFMPYv4oR/Upn3zSzsyk2VxKeBQ28ylvdUuubyL0GFTPR
         0hXymKyPnxgQIk3rGgTVlDwdCn25tHLKcTBo46AhaKRfU1cQS/g15lK7tS3hc2VKmqWD
         Ix2F4jNTxbfZdzjnd4RxK11UrCXLqp/IfqgHAZOBLNiR0HBkG8jyCHIxCQItIVSMYcpk
         wWhRevmT9ShimAeFgyoY8JyFKCWRk7/wf9xCALhgtjWPxMnxBiMD3iKfqWH54eQ+2nQd
         n43jik1CGHhS3APn8kZ+RDVCqMvuzqXeUYIHjPY8aRFZamyNMjqCujfG4N/Y3uWqyB6d
         ZMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733783317; x=1734388117;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Py+JhVWHoRj2WWldJqCyq0p8P5Al3/30p4SRpdI70Vo=;
        b=gU4QTRcNm8jbuNPrd7/wPYNXHHzMFmuXU2As6zafSmfAqNz5KhyjXEe4OjFq30CKNR
         lTrkBlVAu6jAlMeONl/DsVLu/2PsMtyrVA79MljJCbwmZ7mNlTZ1xMDkTCeoLX+Gu9gF
         2flN4YPsCeueGD8XfJ5bqvPxWtDU+I0GxTrwjVmQAjvP6bz05PglmaW2nzaKVtEVZd9M
         vND4/4VsVI/qDkOIF3G1UL6Xn/3TIcBm/7ty32LnMaBjAapC1TNvNYFUlSx5cSReKg85
         dk+U3L5LB19aE3GEnxInel3+9aH3zv5PWB8S0U+wim6xI4k/14YCE6lwphYy/MoRPYNs
         fpAg==
X-Forwarded-Encrypted: i=1; AJvYcCWUHgajjSVVrf5dem7JgYeai58p8jpgnXW9oKn5sqgNk/+pMI1EEp87O5vriF/SnYcEmmkhmdyWKtEMCew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv053m5LqJxTFJC09T3bs1c/lQixu7qVpF53KakI88JhiFPhPk
	wgIC+oVcGN3gConSMPhv3I0J7hI99Nl86/pnDErcyYuD54Zpxbq3u2pEj9cGDUB8rPslcjGdotR
	VGDpzHg==
X-Google-Smtp-Source: AGHT+IE2ghIb7NQvpOlk0r5umPIxrYotQeiXfMt4U5GmqzB5CitoxVB1mDohHazMpEnZ5dxUHWdIENH7KMl6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c8f1:280e:e8ad:32])
 (user=irogers job=sendgmr) by 2002:a05:690c:2f85:b0:6ea:1f5b:1f54 with SMTP
 id 00721157ae682-6efe3ac5ecbmr202277b3.0.1733783316897; Mon, 09 Dec 2024
 14:28:36 -0800 (PST)
Date: Mon,  9 Dec 2024 14:27:49 -0800
In-Reply-To: <20241209222800.296000-1-irogers@google.com>
Message-Id: <20241209222800.296000-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209222800.296000-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Subject: [PATCH v1 12/22] perf vendor events: Update HaswellX events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v28 to v29.
Update TMA metrics from 4.8 to 5.01.

Bring in the event updates v29:
https://github.com/intel/perfmon/commit/71dbf03aba964f79fb096c9ded385c8a486=
a99b3

The TMA 5.01 update is from (with subsequent fixes):
https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5c2=
2d782

Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/haswellx/hsx-metrics.json        | 296 ++++++++++--------
 .../arch/x86/haswellx/metricgroups.json       |   5 +
 .../arch/x86/haswellx/uncore-cache.json       |  28 +-
 .../x86/haswellx/uncore-interconnect.json     |  38 +--
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 5 files changed, 191 insertions(+), 178 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
index 8f2ba3391e35..1a05b74be575 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
@@ -55,7 +55,7 @@
         "MetricName": "UNCORE_FREQ"
     },
     {
-        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
         "MetricName": "cpi",
         "ScaleUnit": "1per_instr"
@@ -76,24 +76,24 @@
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
         "MetricName": "dtlb_load_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
         "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
         "MetricName": "dtlb_store_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB",
         "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU",
         "MetricExpr": "cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D0x19=
e@ * 64 / 1e6 / duration_time",
         "MetricName": "io_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU",
         "MetricExpr": "cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=3D0x1c=
8\\,filter_tid\\=3D0x3e@ * 64 / 1e6 / duration_time",
         "MetricName": "io_bandwidth_write",
         "ScaleUnit": "1MB/s"
@@ -102,14 +102,14 @@
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
         "MetricName": "itlb_large_page_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
         "MetricName": "itlb_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
@@ -209,13 +209,13 @@
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches",
         "MetricExpr": "cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE\\,filter_o=
pc\\=3D0x182@ / (cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE\\,filter_opc\\=3D=
0x182@ + cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE\\,filter_opc\\=3D0x182@)=
",
         "MetricName": "numa_reads_addressed_to_local_dram",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches",
         "MetricExpr": "cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE\\,filter_=
opc\\=3D0x182@ / (cbox@UNC_C_TOR_INSERTS.MISS_LOCAL_OPCODE\\,filter_opc\\=
=3D0x182@ + cbox@UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE\\,filter_opc\\=3D0x18=
2@)",
         "MetricName": "numa_reads_addressed_to_remote_dram",
         "ScaleUnit": "100%"
@@ -276,12 +276,12 @@
         "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
-        "MetricThreshold": "tma_4k_aliasing > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound).",
+        "MetricThreshold": "tma_4k_aliasing > 0.2 & tma_l1_bound > 0.1 & t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "(UOPS_DISPATCHED_PORT.PORT_0 + UOPS_DISPATCHED_PORT=
.PORT_1 + UOPS_DISPATCHED_PORT.PORT_5 + UOPS_DISPATCHED_PORT.PORT_6) / tma_=
info_thread_slots",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
@@ -294,8 +294,8 @@
         "MetricExpr": "66 * OTHER_ASSISTS.ANY_WB_ASSIST / tma_info_thread_=
slots",
         "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
-        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
-        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: OTHER_ASSISTS.AN=
Y",
+        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: OTHER_ASSISTS.AN=
Y_WB_ASSIST",
         "ScaleUnit": "100%"
     },
     {
@@ -306,7 +306,7 @@
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound.",
+        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound",
         "ScaleUnit": "100%"
     },
     {
@@ -316,7 +316,7 @@
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example",
         "ScaleUnit": "100%"
     },
     {
@@ -327,7 +327,7 @@
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_bad_spec_branch_misprediction_cost, tma_mispredicts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES",
         "ScaleUnit": "100%"
     },
     {
@@ -335,8 +335,8 @@
         "MetricExpr": "12 * (BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS=
.COUNT + BACLEARS.ANY) / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
-        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
+        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -345,18 +345,18 @@
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
+        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(60 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM * (1 =
+ MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS=
_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LO=
AD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_D=
RAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RET=
IRED.REMOTE_FWD))) + 43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS * (1 + ME=
M_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS=
_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_=
HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_U=
OPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM =
+ MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RETIRED=
.REMOTE_FWD)))) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_l3_bound_group",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
-        "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. Re=
lated metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma=
_remote_cache",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM, MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MIS=
S. Related metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears=
, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
@@ -367,7 +367,7 @@
         "MetricName": "tma_core_bound",
         "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations)",
         "ScaleUnit": "100%"
     },
     {
@@ -376,8 +376,8 @@
         "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + =
MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UO=
PS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L=
3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD=
_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRA=
M + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RETIR=
ED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
-        "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
+        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_UOPS_L3_HIT_RETIRED.XSNP_HIT. Related metrics: tma_contested_accesses, t=
ma_false_sharing, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
@@ -385,7 +385,7 @@
         "MetricExpr": "10 * ARITH.DIVIDER_UOPS / tma_info_core_core_clks",
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
-        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
+        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & tma=
_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_UOPS",
         "ScaleUnit": "100%"
     },
@@ -395,8 +395,8 @@
         "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_=
RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALL=
S_L2_PENDING / tma_info_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS_PS",
+        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_RE=
TIRED.L3_MISS",
         "ScaleUnit": "100%"
     },
     {
@@ -405,7 +405,7 @@
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
         "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here",
         "ScaleUnit": "100%"
     },
     {
@@ -413,7 +413,7 @@
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
-        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Related metrics: tma_fetch_bandw=
idth, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
@@ -422,8 +422,8 @@
         "MetricExpr": "(8 * DTLB_LOAD_MISSES.STLB_HIT + DTLB_LOAD_MISSES.W=
ALK_DURATION) / tma_info_thread_clks",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
-        "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_UOPS_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store",
+        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma=
_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_UOPS_RETIRED.STLB_MISS_LOADS. Related metrics: tma_=
dtlb_store",
         "ScaleUnit": "100%"
     },
     {
@@ -431,27 +431,27 @@
         "MetricExpr": "(8 * DTLB_STORE_MISSES.STLB_HIT + DTLB_STORE_MISSES=
.WALK_DURATION) / tma_info_thread_clks",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
-        "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_UOPS_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.2 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_UOPS_RETIRED.STLB_MISS_STORES. Related metrics: tma_dtlb_load",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
         "MetricExpr": "(200 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_MISS.REMOTE_=
HITM + 60 * OFFCORE_RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE) / tma_info=
_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_store_bound_group",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
-        "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_L3_HIT_=
RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM. Related=
 metrics: tma_contested_accesses, tma_data_sharing, tma_machine_clears, tma=
_remote_cache",
+        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound > 0=
.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: MEM_LOAD_UOPS_L3=
_HIT_RETIRED.XSNP_HITM, MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM, OFFCORE_=
RESPONSE.DEMAND_RFO.LLC_HIT.HITM_OTHER_CORE, OFFCORE_RESPONSE.DEMAND_RFO.LL=
C_MISS.REMOTE_HITM. Related metrics: tma_contested_accesses, tma_data_shari=
ng, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.REQUEST_FB_FULL\\,cmask\\=3D1@ / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu@L1D_PE=
ND_MISS.REQUEST_FB_FULL\\,cmask\\=3D0x1@ / tma_info_thread_clks",
+        "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_ba=
ndwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_ba=
ndwidth, tma_sq_full, tma_store_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -481,33 +481,33 @@
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound.",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
         "MetricExpr": "tma_microcode_sequencer",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. ([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+] .)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+])",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses.",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
         "MetricExpr": "ICACHE.IFDATA_STALL / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
+        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
         "MetricExpr": "tma_info_inst_mix_instructions / (UOPS_RETIRED.RETI=
RE_SLOTS / UOPS_ISSUED.ANY * BR_MISP_EXEC.INDIRECT)",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
-        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000"
     },
     {
         "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
@@ -518,7 +518,7 @@
     },
     {
         "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
-        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / 2 * (1 + CPU_CLK_UNHALTE=
D.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK) if #core_wide < 1 else (CP=
U_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tma_info_thread_clks))",
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD_ANY / 2 if #SMT_on else tm=
a_info_thread_clks)",
         "MetricGroup": "SMT",
         "MetricName": "tma_info_core_core_clks"
     },
@@ -530,7 +530,7 @@
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
-        "MetricExpr": "(UOPS_EXECUTED.CORE / 2 / (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D1@ / 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@) if=
 #SMT_on else UOPS_EXECUTED.CORE / (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ /=
 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@))",
+        "MetricExpr": "(UOPS_EXECUTED.CORE / 2 / (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D0x1@ / 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@=
) if #SMT_on else UOPS_EXECUTED.CORE / (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D=
0x1@ / 2 if #SMT_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@))",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp"
     },
@@ -549,7 +549,13 @@
         "MetricName": "tma_info_frontend_ipunknown_branch"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "BR_INST_RETIRED.NEAR_TAKEN / tma_info_thread_clks",
+        "MetricGroup": "Branches;FetchBW",
+        "MetricName": "tma_info_frontend_tbpc"
+    },
+    {
+        "BriefDescription": "Branch instructions per taken branch",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_bptkbranch"
@@ -594,7 +600,7 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
-        "MetricThreshold": "tma_info_inst_mix_iptb < 9",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 4 * 2 + 1",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, =
tma_lcp"
     },
     {
@@ -617,7 +623,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw"
     },
@@ -629,7 +635,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l2_cache_fill_bw"
     },
@@ -647,7 +653,7 @@
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
@@ -666,7 +672,7 @@
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
@@ -698,14 +704,14 @@
         "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D1@",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
+        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / cpu@UOPS_RETIRED.RETIRE=
_SLOTS\\,cmask\\=3D0x1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
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
@@ -723,7 +729,7 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / tma_info_system_time",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
         "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_mem_bandwidth,=
 tma_sq_full"
@@ -733,13 +739,14 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_system_ipfarbranch",
-        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
         "MetricGroup": "OS",
-        "MetricName": "tma_info_system_kernel_cpi"
+        "MetricName": "tma_info_system_kernel_cpi",
+        "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
@@ -750,18 +757,31 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
-        "MetricExpr": "UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x18=
2@ / UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=3D0x182\\,thresh\\=3D1@",
+        "MetricExpr": "cbox@UNC_C_TOR_OCCUPANCY.MISS_OPCODE\\,filter_opc\\=
=3D0x182@ / cbox@UNC_C_TOR_OCCUPANCY.MISS_OPCODE\\,filter_opc\\=3D0x182@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricExpr": "1e9 * (UNC_C_TOR_OCCUPANCY.MISS_OPCODE@filter_opc\\=
=3D0x182@ / UNC_C_TOR_INSERTS.MISS_OPCODE@filter_opc\\=3D0x182@) / (tma_inf=
o_system_socket_clks / duration_time)",
+        "MetricExpr": "1e9 * (cbox@UNC_C_TOR_OCCUPANCY.MISS_OPCODE\\,filte=
r_opc\\=3D0x182@ / cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=3D0x18=
2@) / (tma_info_system_socket_clks / tma_info_system_time)",
         "MetricGroup": "Mem;MemoryLat;SoC",
         "MetricName": "tma_info_system_mem_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
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
+        "MetricExpr": "(power@energy\\-pkg@ * 61 + 15.6 * power@energy\\-r=
am@) / (duration_time * 1e6)",
+        "MetricGroup": "Power;SoC",
+        "MetricName": "tma_info_system_power"
+    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / (CPU_CLK_=
UNHALTED.REF_XCLK_ANY / 2) if #SMT_on else 0)",
@@ -774,6 +794,13 @@
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
@@ -782,12 +809,12 @@
     },
     {
         "BriefDescription": "Measured Average Uncore Frequency for the SoC=
 [GHz]",
-        "MetricExpr": "tma_info_system_socket_clks / 1e9 / duration_time",
+        "MetricExpr": "tma_info_system_socket_clks / 1e9 / tma_info_system=
_time",
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_uncore_frequency"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Pipeline",
         "MetricName": "tma_info_thread_clks"
@@ -796,7 +823,8 @@
         "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
         "MetricExpr": "1 / tma_info_thread_ipc",
         "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_thread_cpi"
+        "MetricName": "tma_info_thread_cpi",
+        "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
@@ -822,24 +850,24 @@
         "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS / BR_INST_RETIRED.NEAR_TA=
KEN",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
-        "MetricThreshold": "tma_info_thread_uptb < 6"
+        "MetricThreshold": "tma_info_thread_uptb < 4 * 1.5"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "(14 * ITLB_MISSES.STLB_HIT + ITLB_MISSES.WALK_DURAT=
ION) / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: ITLB_M=
ISSES.WALK_COMPLETED",
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
-        "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
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
+        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & =
tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_UOPS_RETIRED.L1_HIT. Related metri=
cs: tma_machine_clears, tma_microcode_sequencer, tma_ms_switches, tma_ports=
_utilized_1",
         "ScaleUnit": "100%"
     },
     {
@@ -847,8 +875,8 @@
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L1D_PENDING - CYCLE_ACTIVITY=
.STALLS_L2_PENDING) / tma_info_thread_clks",
         "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_UOPS_RETIRED.L2_HIT_PS",
+        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_UOPS_RETIRED.L2_HIT",
         "ScaleUnit": "100%"
     },
     {
@@ -857,8 +885,8 @@
         "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIR=
ED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS) * CYCLE_ACTIVITY.STALLS_L2_P=
ENDING / tma_info_thread_clks",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
+        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT",
         "ScaleUnit": "100%"
     },
     {
@@ -867,8 +895,8 @@
         "MetricExpr": "41 * (MEM_LOAD_UOPS_RETIRED.L3_HIT * (1 + MEM_LOAD_=
UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIRE=
D.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RET=
IRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOPS_L3_=
MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM + MEM_L=
OAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE=
_FWD))) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
-        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related metric=
s: tma_mem_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.05=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT. Related metrics: =
tma_branch_resteers, tma_mem_latency, tma_store_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -876,18 +904,18 @@
         "MetricExpr": "ILD_STALL.LCP / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
-        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & tma=
_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. Related metr=
ics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage,=
 tma_info_inst_mix_iptb",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations , instructions that require =
no more than one uop (micro-operation)",
         "MetricExpr": "tma_retiring - tma_heavy_operations",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_light_operations",
         "MetricThreshold": "tma_light_operations > 0.6",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UopPI met=
ric) ratio of 1 or less should be expected for decently optimized code runn=
ing on Intel Core/Xeon products. While this often indicates efficient X86 i=
nstructions were executed; high value does not necessarily mean better perf=
ormance cannot be achieved. ([ICL+] Note this may undercount due to approxi=
mation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIS=
T",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations , instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UopPI metr=
ic) ratio of 1 or less should be expected for decently optimized code runni=
ng on Intel Core/Xeon products. While this often indicates efficient X86 in=
structions were executed; high value does not necessarily mean better perfo=
rmance cannot be achieved. ([ICL+] Note this may undercount due to approxim=
ation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIST=
",
         "ScaleUnit": "100%"
     },
     {
@@ -905,18 +933,18 @@
         "MetricExpr": "200 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM * (=
1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOA=
D_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UO=
PS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_=
LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE=
_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_R=
ETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_mem",
-        "MetricThreshold": "tma_local_mem > 0.1 & (tma_mem_latency > 0.1 &=
 (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2)=
))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_L3=
_MISS_RETIRED.LOCAL_DRAM_PS",
+        "MetricThreshold": "tma_local_mem > 0.1 & tma_mem_latency > 0.1 & =
tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_UOPS_L3=
_MISS_RETIRED.LOCAL_DRAM",
         "ScaleUnit": "100%"
     },
     {
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
-        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_UOPS_RETIRED.LOCK_LOA=
DS_PS. Related metrics: tma_store_latency",
+        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 & =
tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_UOPS_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -927,15 +955,15 @@
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sh=
aring, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_c=
ache",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, =
tma_microcode_sequencer, tma_ms_switches, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D6@) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D0x6@) / tma_info_thread_clks",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
-        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
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
         "ScaleUnit": "100%"
     },
@@ -944,19 +972,19 @@
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
-        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_l3_hit_latency",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALL=
S_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_=
ACTIVITY.CYCLES_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - (cpu=
@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else cpu@UO=
PS_EXECUTED.CORE\\,cmask\\=3D2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetc=
h_latency > 0.1 else 0) + RESOURCE_STALLS.SB) if #SMT_on else min(CPU_CLK_U=
NHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\=
\,cmask\\=3D1@ - (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_=
ipc > 1.8 else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CY=
CLES if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB) * tma_backend=
_bound",
+        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS=
_LDM_PENDING) + RESOURCE_STALLS.SB) / (min(CPU_CLK_UNHALTED.THREAD, CYCLE_A=
CTIVITY.CYCLES_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@ - (cp=
u@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@ if tma_info_thread_ipc > 1.8 else cpu=
@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma=
_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB if #SMT_on else min(CPU_C=
LK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.C=
ORE\\,cmask\\=3D0x1@ - (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@ if tma_info=
_thread_ipc > 1.8 else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@) - (RS_EVENT=
S.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB) * t=
ma_backend_bound",
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
",
         "ScaleUnit": "100%"
     },
     {
@@ -965,7 +993,7 @@
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
         "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS. Related metrics: tma_clears_resteers,=
 tma_l1_bound, tma_machine_clears, tma_ms_switches",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS. Related metrics: tma_l1_bound, tma_ma=
chine_clears, tma_ms_switches",
         "ScaleUnit": "100%"
     },
     {
@@ -974,7 +1002,7 @@
         "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch_b=
andwidth_group",
         "MetricName": "tma_mite",
         "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck.",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck",
         "ScaleUnit": "100%"
     },
     {
@@ -982,8 +1010,8 @@
         "MetricExpr": "2 * IDQ.MS_SWITCHES / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
-        "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_clears_r=
esteers, tma_l1_bound, tma_machine_clears, tma_microcode_sequencer, tma_mix=
ing_vectors, tma_serializing_operation",
+        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_l1_bound=
, tma_machine_clears, tma_microcode_sequencer",
         "ScaleUnit": "100%"
     },
     {
@@ -992,7 +1020,7 @@
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
branch). Sample with: UOPS_DISPATCHED_PORT.PORT_0. Related metrics: tma_por=
t_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1001,7 +1029,7 @@
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
HED_PORT.PORT_1. Related metrics: tma_port_0, tma_port_5, tma_port_6, tma_p=
orts_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1037,7 +1065,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_5",
         "MetricThreshold": "tma_port_5 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+]=
 ALU). Sample with: UOPS_DISPATCHED.PORT_5. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 5 ([SNB+] Branches and ALU; [HSW+]=
 ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_5. Related metrics: tma_port_=
0, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1046,7 +1074,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_6. Related metrics: tma_fp_s=
calar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector=
_512b, tma_port_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED_PORT.PORT_1. Related metrics: tma_port=
_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1061,46 +1089,46 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES=
_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - (cpu@UOPS_EXECUTED.=
CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1=
 else 0) + RESOURCE_STALLS.SB if #SMT_on else min(CPU_CLK_UNHALTED.THREAD, =
CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ -=
 (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ if tma_info_thread_ipc > 1.8 else c=
pu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) - (RS_EVENTS.EMPTY_CYCLES if tma_fetc=
h_latency > 0.1 else 0) + RESOURCE_STALLS.SB - RESOURCE_STALLS.SB - min(CPU=
_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS_LDM_PENDING)) / tma_info_thread=
_clks",
+        "MetricExpr": "((min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLE=
S_NO_EXECUTE) + (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@ - (cpu@UOPS_EXECUT=
ED.CORE\\,cmask\\=3D0x3@ if tma_info_thread_ipc > 1.8 else cpu@UOPS_EXECUTE=
D.CORE\\,cmask\\=3D0x2@)) / 2 - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latenc=
y > 0.1 else 0) + RESOURCE_STALLS.SB if #SMT_on else min(CPU_CLK_UNHALTED.T=
HREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUTE) + cpu@UOPS_EXECUTED.CORE\\,cmask\\=
=3D0x1@ - (cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@ if tma_info_thread_ipc >=
 1.8 else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@) - (RS_EVENTS.EMPTY_CYCLE=
S if tma_fetch_latency > 0.1 else 0) + RESOURCE_STALLS.SB) - RESOURCE_STALL=
S.SB - min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.STALLS_LDM_PENDING)) / t=
ma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
-        "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
+        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_bound =
> 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\,cmask\\=3D1@ / 2 if=
 #SMT_on else (min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_NO_EXECUT=
E) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) / tma_info=
_core_core_clks)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,inv\\=3D0x1\\,cmask\\=3D0=
x1@ / 2 if #SMT_on else min(CPU_CLK_UNHALTED.THREAD, CYCLE_ACTIVITY.CYCLES_=
NO_EXECUTE) - (RS_EVENTS.EMPTY_CYCLES if tma_fetch_latency > 0.1 else 0)) /=
 tma_info_core_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
-        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D1@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D2@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D1@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@) / tma_info_core_core=
_clks)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x1@ - cpu@UOP=
S_EXECUTED.CORE\\,cmask\\=3D0x2@) / 2 if #SMT_on else cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D0x1@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@) / tma_info_co=
re_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
-        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Related metrics: tma_l1_bound",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
-        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D2@ - cpu@UOPS_=
EXECUTED.CORE\\,cmask\\=3D3@) / 2 if #SMT_on else (cpu@UOPS_EXECUTED.CORE\\=
,cmask\\=3D2@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / tma_info_core_core=
_clks)",
+        "MetricExpr": "((cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x2@ - cpu@UOP=
S_EXECUTED.CORE\\,cmask\\=3D0x3@) / 2 if #SMT_on else cpu@UOPS_EXECUTED.COR=
E\\,cmask\\=3D0x2@ - cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@) / tma_info_co=
re_core_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
-        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. R=
elated metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_128b, tma_fp_ve=
ctor_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5, tma_port=
_6",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. R=
elated metrics: tma_port_0, tma_port_1, tma_port_5, tma_port_6",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise).",
-        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@ / 2 if #SMT_=
on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D3@) / tma_info_core_core_clks",
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "(cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@ / 2 if #SM=
T_on else cpu@UOPS_EXECUTED.CORE\\,cmask\\=3D0x3@) / tma_info_core_core_clk=
s",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%"
     },
     {
@@ -1109,8 +1137,8 @@
         "MetricExpr": "(200 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM *=
 (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_L=
OAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_=
UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + ME=
M_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMO=
TE_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS=
_RETIRED.REMOTE_FWD))) + 180 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD * =
(1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOT=
E_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_=
RETIRED.REMOTE_FWD)))) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
         "MetricName": "tma_remote_cache",
-        "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article. Sample with: MEM_LOAD_UOPS_L3_M=
ISS_RETIRED.REMOTE_HITM_PS;MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD_PS. Rel=
ated metrics: tma_contested_accesses, tma_data_sharing, tma_false_sharing, =
tma_machine_clears",
+        "MetricThreshold": "tma_remote_cache > 0.05 & tma_mem_latency > 0.=
1 & tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. Sample with: MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM=
, MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD. Related metrics: tma_contested_=
accesses, tma_data_sharing, tma_false_sharing, tma_machine_clears",
         "ScaleUnit": "100%"
     },
     {
@@ -1118,8 +1146,8 @@
         "MetricExpr": "310 * (MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM * =
(1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LO=
AD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_U=
OPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM=
_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOT=
E_DRAM + MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM + MEM_LOAD_UOPS_L3_MISS_=
RETIRED.REMOTE_FWD))) / tma_info_thread_clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_mem",
-        "MetricThreshold": "tma_remote_mem > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article. Sample=
 with: MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM_PS",
+        "MetricThreshold": "tma_remote_mem > 0.1 & tma_mem_latency > 0.1 &=
 tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. Sample with: MEM_LOAD_UOPS_L3=
_MISS_RETIRED.REMOTE_DRAM",
         "ScaleUnit": "100%"
     },
     {
@@ -1138,8 +1166,8 @@
         "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCKS.=
NO_SR / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
-        "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_UOPS_RETIRED.SPLIT_LOADS_PS",
+        "MetricThreshold": "tma_split_loads > 0.3",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_UOPS_RETIRED.SPLIT_LOADS",
         "ScaleUnit": "100%"
     },
     {
@@ -1147,16 +1175,16 @@
         "MetricExpr": "2 * MEM_UOPS_RETIRED.SPLIT_STORES / tma_info_core_c=
ore_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
-        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_UOPS_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
+        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0.2=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_UOPS_RETIRED.SPLIT_STORES. Related metrics: tma_port_4",
         "ScaleUnit": "100%"
     },
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
-        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tma_=
memory_bound > 0.2 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_system_dram_bw_use, tma_mem_bandwidth",
         "ScaleUnit": "100%"
     },
@@ -1165,8 +1193,8 @@
         "MetricExpr": "RESOURCE_STALLS.SB / tma_info_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
-        "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_UOPS_RETIRED.ALL_STORES_PS",
+        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_UOPS_RETIRED.ALL_STORES",
         "ScaleUnit": "100%"
     },
     {
@@ -1174,18 +1202,18 @@
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
-        "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
+        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading",
         "ScaleUnit": "100%"
     },
     {
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
-        "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
+        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma_l=
3_hit_latency, tma_lock_latency",
         "ScaleUnit": "100%"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/metricgroups.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/metricgroups.json
index 4193c90c3459..0863375bdead 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/metricgroups.json
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
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
index 3c23bafcba28..d664af16c1db 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
@@ -812,7 +812,7 @@
         "EventCode": "0x12",
         "EventName": "UNC_C_RxR_EXT_STARVED.IPQ",
         "PerPkg": "1",
-        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; IPQ is externally startved and therefore we are blocking the IRQ.",
+        "PublicDescription": "Counts cycles in external starvation.  This =
occurs when one of the ingress queues is being starved by the other queues.=
; IPQ is externally starved and therefore we are blocking the IRQ.",
         "UMask": "0x2",
         "Unit": "CBOX"
     },
@@ -1869,7 +1869,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_H_BYPASS_IMC.NOT_TAKEN",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filted =
by when the bypass was taken and when it was not.; Filter for transactions =
that could not take the bypass.",
+        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filtere=
d by when the bypass was taken and when it was not.; Filter for transaction=
s that could not take the bypass.",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -1879,7 +1879,7 @@
         "EventCode": "0x14",
         "EventName": "UNC_H_BYPASS_IMC.TAKEN",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filted =
by when the bypass was taken and when it was not.; Filter for transactions =
that succeeded in taking the bypass.",
+        "PublicDescription": "Counts the number of times when the HA was a=
ble to bypass was attempted.  This is a latency optimization for situations=
 when there is light loadings on the memory subsystem.  This can be filtere=
d by when the bypass was taken and when it was not.; Filter for transaction=
s that succeeded in taking the bypass.",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -2874,7 +2874,7 @@
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN0",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 0 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high bandwidth workloads should be able to make use of all of the regular =
buffers, but it will be difficult (and uncommon) to make use of both the re=
gular and special buffers at the same time.  One can filter based on the me=
mory controller channel.  One or more channels can be tracked at a given ti=
me.; Filter for memory controller channel 0 only.",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -2884,7 +2884,7 @@
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 1 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high bandwidth workloads should be able to make use of all of the regular =
buffers, but it will be difficult (and uncommon) to make use of both the re=
gular and special buffers at the same time.  One can filter based on the me=
mory controller channel.  One or more channels can be tracked at a given ti=
me.; Filter for memory controller channel 1 only.",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -2894,7 +2894,7 @@
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN2",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 2 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high bandwidth workloads should be able to make use of all of the regular =
buffers, but it will be difficult (and uncommon) to make use of both the re=
gular and special buffers at the same time.  One can filter based on the me=
mory controller channel.  One or more channels can be tracked at a given ti=
me.; Filter for memory controller channel 2 only.",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -2904,7 +2904,7 @@
         "EventCode": "0x15",
         "EventName": "UNC_H_RPQ_CYCLES_NO_REG_CREDITS.CHN3",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high banwidth workloads should be able to make use of all of the regular b=
uffers, but it will be difficult (and uncommon) to make use of both the reg=
ular and special buffers at the same time.  One can filter based on the mem=
ory controller channel.  One or more channels can be tracked at a given tim=
e.; Filter for memory controller channel 3 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting reads from the HA into the iMC.  In=
 order to send reads into the memory controller, the HA must first acquire =
a credit for the iMC's RPQ (read pending queue).  This queue is broken into=
 regular credits/buffers that are used by general reads, and special reques=
ts such as ISOCH reads.  This count only tracks the regular credits  Common=
 high bandwidth workloads should be able to make use of all of the regular =
buffers, but it will be difficult (and uncommon) to make use of both the re=
gular and special buffers at the same time.  One can filter based on the me=
mory controller channel.  One or more channels can be tracked at a given ti=
me.; Filter for memory controller channel 3 only.",
         "UMask": "0x8",
         "Unit": "HA"
     },
@@ -3438,7 +3438,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_H_TRACKER_CYCLES_NE.ALL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occpancy.  HA tra=
ckers are allocated as soon as a request enters the HA if an HT (Home Track=
er) entry is available and is released after the snoop response and data re=
turn (or post in the case of a write) and the response is returned on the r=
ing.; Requests coming from both local and remote sockets.",
+        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occupancy.  HA tr=
ackers are allocated as soon as a request enters the HA if an HT (Home Trac=
ker) entry is available and is released after the snoop response and data r=
eturn (or post in the case of a write) and the response is returned on the =
ring.; Requests coming from both local and remote sockets.",
         "UMask": "0x3",
         "Unit": "HA"
     },
@@ -3448,7 +3448,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_H_TRACKER_CYCLES_NE.LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occpancy.  HA tra=
ckers are allocated as soon as a request enters the HA if an HT (Home Track=
er) entry is available and is released after the snoop response and data re=
turn (or post in the case of a write) and the response is returned on the r=
ing.; This filter includes only requests coming from the local socket.",
+        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occupancy.  HA tr=
ackers are allocated as soon as a request enters the HA if an HT (Home Trac=
ker) entry is available and is released after the snoop response and data r=
eturn (or post in the case of a write) and the response is returned on the =
ring.; This filter includes only requests coming from the local socket.",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -3458,7 +3458,7 @@
         "EventCode": "0x3",
         "EventName": "UNC_H_TRACKER_CYCLES_NE.REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occpancy.  HA tra=
ckers are allocated as soon as a request enters the HA if an HT (Home Track=
er) entry is available and is released after the snoop response and data re=
turn (or post in the case of a write) and the response is returned on the r=
ing.; This filter includes only requests coming from remote sockets.",
+        "PublicDescription": "Counts the number of cycles when the local H=
A tracker pool is not empty.  This can be used with edge detect to identify=
 the number of situations when the pool became empty.  This should not be c=
onfused with RTID credit usage -- which must be tracked inside each cbo ind=
ividually -- but represents the actual tracker buffer structure.  In other =
words, this buffer could be completely empty, but there may still be credit=
s in use by the CBos.  This stat can be used in conjunction with the occupa=
ncy accumulation stat in order to calculate average queue occupancy.  HA tr=
ackers are allocated as soon as a request enters the HA if an HT (Home Trac=
ker) entry is available and is released after the snoop response and data r=
eturn (or post in the case of a write) and the response is returned on the =
ring.; This filter includes only requests coming from remote sockets.",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -3878,7 +3878,7 @@
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN0",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 0 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high bandwidth workloads should be able to make use of all of the reg=
ular buffers, but it will be difficult (and uncommon) to make use of both t=
he regular and special buffers at the same time.  One can filter based on t=
he memory controller channel.  One or more channels can be tracked at a giv=
en time.; Filter for memory controller channel 0 only.",
         "UMask": "0x1",
         "Unit": "HA"
     },
@@ -3888,7 +3888,7 @@
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN1",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 1 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high bandwidth workloads should be able to make use of all of the reg=
ular buffers, but it will be difficult (and uncommon) to make use of both t=
he regular and special buffers at the same time.  One can filter based on t=
he memory controller channel.  One or more channels can be tracked at a giv=
en time.; Filter for memory controller channel 1 only.",
         "UMask": "0x2",
         "Unit": "HA"
     },
@@ -3898,7 +3898,7 @@
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN2",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 2 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high bandwidth workloads should be able to make use of all of the reg=
ular buffers, but it will be difficult (and uncommon) to make use of both t=
he regular and special buffers at the same time.  One can filter based on t=
he memory controller channel.  One or more channels can be tracked at a giv=
en time.; Filter for memory controller channel 2 only.",
         "UMask": "0x4",
         "Unit": "HA"
     },
@@ -3908,7 +3908,7 @@
         "EventCode": "0x18",
         "EventName": "UNC_H_WPQ_CYCLES_NO_REG_CREDITS.CHN3",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high banwidth workloads should be able to make use of all of the regu=
lar buffers, but it will be difficult (and uncommon) to make use of both th=
e regular and special buffers at the same time.  One can filter based on th=
e memory controller channel.  One or more channels can be tracked at a give=
n time.; Filter for memory controller channel 3 only.",
+        "PublicDescription": "Counts the number of cycles when there are n=
o regular credits available for posting writes from the HA into the iMC.  I=
n order to send writes into the memory controller, the HA must first acquir=
e a credit for the iMC's WPQ (write pending queue).  This queue is broken i=
nto regular credits/buffers that are used by general writes, and special re=
quests such as ISOCH writes.  This count only tracks the regular credits  C=
ommon high bandwidth workloads should be able to make use of all of the reg=
ular buffers, but it will be difficult (and uncommon) to make use of both t=
he regular and special buffers at the same time.  One can filter based on t=
he memory controller channel.  One or more channels can be tracked at a giv=
en time.; Filter for memory controller channel 3 only.",
         "UMask": "0x8",
         "Unit": "HA"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.js=
on b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
index 121de411d312..8f73a8649b39 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
@@ -1,24 +1,4 @@
 [
-    {
-        "BriefDescription": "Number of non data (control) flits transmitte=
d . Derived from unc_q_txl_flits_g0.non_data",
-        "Counter": "0,1,2,3",
-        "EventName": "QPI_CTL_BANDWIDTH_TX",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NULL=
 non-data flits transmitted across QPI.  This basically tracks the protocol=
 overhead on the QPI link.  One can get a good picture of the QPI-link char=
acteristics by evaluating the protocol flits, data flits, and idle/null fli=
ts.  This includes the header flits for data packets.",
-        "ScaleUnit": "8Bytes",
-        "UMask": "0x4",
-        "Unit": "QPI"
-    },
-    {
-        "BriefDescription": "Number of data flits transmitted . Derived fr=
om unc_q_txl_flits_g0.data",
-        "Counter": "0,1,2,3",
-        "EventName": "QPI_DATA_BANDWIDTH_TX",
-        "PerPkg": "1",
-        "PublicDescription": "Counts the number of flits transmitted acros=
s the QPI Link.  It includes filters for Idle, protocol, and Data Flits.  E=
ach flit is made up of 80 bits of information (in addition to some ECC data=
).  In full-width (L0) mode, flits are made up of four fits, each of which =
contains 20 bits of data (along with some additional ECC data).   In half-w=
idth (L0p) mode, the fits are only 10 bits, and therefore it takes twice as=
 many fits to transmit a flit.  When one talks about QPI speed (for example=
, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the syste=
m will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcula=
te the bandwidth of the link by taking: flits*80b/time.  Note that this is =
not the same as data bandwidth.  For example, when we are transferring a 64=
B cacheline across QPI, we will break it into 9 flits -- 1 with header info=
rmation and 8 with 64 bits of actual data and an additional 16 bits of othe=
r information.  To calculate data bandwidth, one should therefore do: data =
flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data fli=
ts transmitted over QPI.  Each flit contains 64b of data.  This includes bo=
th DRS and NCB data flits (coherent and non-coherent).  This can be used to=
 calculate the data bandwidth of the QPI link.  One can get a good picture =
of the QPI-link characteristics by evaluating the protocol flits, data flit=
s, and idle/null flits.  This does not include the header flits that go in =
data packets.",
-        "ScaleUnit": "8Bytes",
-        "UMask": "0x2",
-        "Unit": "QPI"
-    },
     {
         "BriefDescription": "Total Write Cache Occupancy; Any Source",
         "Counter": "0,1",
@@ -53,7 +33,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x80",
         "Unit": "IRP"
     },
@@ -63,7 +43,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.CRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x2",
         "Unit": "IRP"
     },
@@ -73,7 +53,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.DRD",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x4",
         "Unit": "IRP"
     },
@@ -83,7 +63,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.PCIDCAHINT",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x20",
         "Unit": "IRP"
     },
@@ -93,7 +73,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.PCIRDCUR",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x1",
         "Unit": "IRP"
     },
@@ -103,7 +83,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.PCITOM",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x10",
         "Unit": "IRP"
     },
@@ -113,7 +93,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.RFO",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x8",
         "Unit": "IRP"
     },
@@ -123,7 +103,7 @@
         "EventCode": "0x13",
         "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of coherency related opera=
tions servied by the IRP",
+        "PublicDescription": "Counts the number of coherency related opera=
tions serviced by the IRP",
         "UMask": "0x40",
         "Unit": "IRP"
     },
@@ -493,7 +473,7 @@
         "EventCode": "0x16",
         "EventName": "UNC_I_TRANSACTIONS.WRITES",
         "PerPkg": "1",
-        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Trackes only write requests.=
  Each write request should have a prefetch, so there is no need to explici=
tly track these requests.  For writes that are tickled and have to retry, t=
he counter will be incremented for each retry.",
+        "PublicDescription": "Counts the number of Inbound transactions fr=
om the IRP to the Uncore.  This can be filtered based on request type in ad=
dition to the source queue.  Note the special filtering equation.  We do OR=
-reduction on the request type.  If the SOURCE bit is set, then we also do =
AND qualification based on the source portID.; Tracks only write requests. =
 Each write request should have a prefetch, so there is no need to explicit=
ly track these requests.  For writes that are tickled and have to retry, th=
e counter will be incremented for each retry.",
         "UMask": "0x2",
         "Unit": "IRP"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 903d6ada7060..71cf64060499 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -14,7 +14,7 @@ GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.05,grandridge,core
 GenuineIntel-6-A[DE],v1.04,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
-GenuineIntel-6-3F,v28,haswellx,core
+GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.22,icelake,core
 GenuineIntel-6-6[AC],v1.26,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
--=20
2.47.1.545.g3c1d2e2a6a-goog


