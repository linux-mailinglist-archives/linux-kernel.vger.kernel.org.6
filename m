Return-Path: <linux-kernel+bounces-510062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A06A317BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539CE3A293C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5512673BF;
	Tue, 11 Feb 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ayXgrumQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF5263F4C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309454; cv=none; b=qB2WeVlaNUGSThbukdCdR05+tyahX3G8XWlUGQ6JyH9JkcNfKbqOywdO/BU5woUkZ3rxfHTQbyVeNrkuYtXWw/skIkbMr05gF0vlGREyp0lXV7xzIjLeM5alJ36RRq/4Xwy5RxVjsVPXoPAjOx26t9F9HVf5YTSl3awWzmB12C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309454; c=relaxed/simple;
	bh=aku0a/+KoRPxNOvxg2NZSp+4Xl98RF0YVxzkX7uWuuU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WAvq2C9KYLPI0SFzYL+CibfRrwV74mV7OXIPNMy0qrxIW1Ub3p0GWYJ/rDzFwlxIUjnYxwDy9cMTEi+IURlRVrnL7Jdfqci/UMzGJzzmfZhYB1fIZdr+MlKN23vlQyp9TZlfKdMMmFVmJo9jXX3/b2S/pL+OmuazcnwOWX4FACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ayXgrumQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f9ac4488b7so48083117b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 13:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739309442; x=1739914242; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHQXqG+yuMQQ6Ysjd9QN/43BQOvzCDGtWQ9loXTvabc=;
        b=ayXgrumQgAlLt2BNZaZmFis2TRfOUf5oTB4k52Ug97Y/UA/SMZNnI9+GQE2yh7+8Sw
         3AHIdq1kSfdn9okROMgswWxpUSgCme/oi8KCeKYnDubgYAB2L2udl8ry3PAC6o1RvK6E
         tgdMF1SnpRhYkee08FowDuQnU7O6BwzaXn/Bg3CExL3aYQoMN/Injj/WWKOw1GeT7LIC
         GJ0hyGjh3XO/B8xdvFyNHsGz5PEM26q//1u9McO3/1R4aQBrapJVmFamgGiK5pG6CN++
         3r2/Ykr5hi5b7tCVTL7QO1hI54aSS3OqtjzK2uvjlaC2W4zn5GvfU2O84ZvtS8XN8rUO
         VO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739309442; x=1739914242;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cHQXqG+yuMQQ6Ysjd9QN/43BQOvzCDGtWQ9loXTvabc=;
        b=vrH6M+N254Ypxmb57p/oHmxOBEviqiV/nt2pJd0QQUgpaogbSLFjYYlnVEAWc1NJAI
         DEP/FVMr8A+nBdyDSE0MaeK2Fc5XFMgttZxRFlvO2PDz44aDGv5rkDTFRhhO9kVkgWmI
         FqSobbkVUO+qeyMG0WJ3SyHHMjxnWj0rz3NrKgDXEbo7Gll6JpmT9wXDIhVae1Y6A8N4
         zJuFzMOkvodjEyS5L/fX0nHcnGiKyAstL2pYQZN8GpLY5kLjDZ9UCw39Q0xFwCeK4uVZ
         PhXW3z6yuIhh1uKyUSW8C4jMEpI+HkvvBqLwMYoe65HUsWVlQ/8gDFJpVOqu4LGz9RDS
         Q+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWdypYGj7xsKUjH17/yDSHEnQ/oRZ9SMY/pXBS7jwrBTCquJl9iQYTzRXGxiz7VKBQfqY4Xw4PPs8WANjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyq6GiB81t54Yny4Bhv/CkzgyQmwq4di66Ym11h+BHidGKQ5Pm
	NelrmS+bbOzqN7Oy6xE0Zl6xg5q7bSLfVvVfgsvKoitRnmp9voZVgMN4bCdOcQxehzKbaHBXRdu
	R1NqX6A==
X-Google-Smtp-Source: AGHT+IFBQLK0K2mSqlQKI4vL88IlYHzuScmHs/G8zM9JMBMWPpoY3B9JHDhuZVSlFavknO5FFeruInGeo29j
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a24c:c86a:18a9:d15b])
 (user=irogers job=sendgmr) by 2002:a05:690c:f8e:b0:6f9:a023:5e17 with SMTP id
 00721157ae682-6fb1f2aa495mr102227b3.5.1739309441804; Tue, 11 Feb 2025
 13:30:41 -0800 (PST)
Date: Tue, 11 Feb 2025 13:30:08 -0800
In-Reply-To: <20250211213031.114209-1-irogers@google.com>
Message-Id: <20250211213031.114209-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211213031.114209-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v8 01/24] perf vendor events: Update Alderlake events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.27 to v1.28.
Update TMA metrics from 4.8 to 5.02.

Bring in the event updates v1.28:
https://github.com/intel/perfmon/commit/801f43f22ec6bd23fbb5d18860f395d61e7=
f4081

The TMA 5.02 update is from (with subsequent fixes):
https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5c2=
2d782

Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 914 +++++++++++-------
 .../pmu-events/arch/x86/alderlake/cache.json  | 292 +++++-
 .../arch/x86/alderlake/floating-point.json    |  19 +-
 .../arch/x86/alderlake/frontend.json          |  19 -
 .../pmu-events/arch/x86/alderlake/memory.json |  32 +-
 .../arch/x86/alderlake/metricgroups.json      |  10 +-
 .../pmu-events/arch/x86/alderlake/other.json  |  92 +-
 .../arch/x86/alderlake/pipeline.json          | 127 +--
 .../arch/x86/alderlake/virtual-memory.json    |  33 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 10 files changed, 1042 insertions(+), 498 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 8fdf4a4225de..147379cae37b 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -48,13 +48,6 @@
         "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Pkg_Residency",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "C8 residency percent per package",
         "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
@@ -62,13 +55,6 @@
         "MetricName": "C8_Pkg_Residency",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "C9 residency percent per package",
-        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C9_Pkg_Residency",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "Percentage of cycles spent in System Manageme=
nt Interrupts.",
         "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0=
 else 0)",
@@ -117,7 +103,7 @@
         "MetricExpr": "tma_core_bound",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_allocation_restriction",
-        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core_b=
ound > 0.1 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_allocation_restriction >0.10) & ((tma_cor=
e_bound >0.10) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -127,7 +113,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CPU_=
CLK_UNHALTED.CORE@)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
-        "MetricThreshold": "tma_backend_bound > 0.1",
+        "MetricThreshold": "(tma_backend_bound >0.10)",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
         "ScaleUnit": "100%",
@@ -139,7 +125,7 @@
         "MetricExpr": "(5 * cpu_atom@CPU_CLK_UNHALTED.CORE@ - (cpu_atom@TO=
PDOWN_FE_BOUND.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RET=
IRING.ALL@)) / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
-        "MetricThreshold": "tma_bad_speculation > 0.15",
+        "MetricThreshold": "(tma_bad_speculation >0.15)",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
         "ScaleUnit": "100%",
@@ -150,7 +136,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ / (5 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_detect",
-        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_branch_detect >0.05) & ((tma_ifetch_laten=
cy >0.15) & ((tma_frontend_bound >0.20)))",
         "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s.",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -160,7 +146,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / (5 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
-        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
+        "MetricThreshold": "(tma_branch_mispredicts >0.05) & ((tma_bad_spe=
culation >0.15))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -170,7 +156,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ / (5 * cp=
u_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_resteer",
-        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_branch_resteer >0.05) & ((tma_ifetch_late=
ncy >0.15) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -179,7 +165,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (5 * cpu_atom@CPU=
_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_cisc >0.05) & ((tma_ifetch_bandwidth >0.1=
0) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -188,7 +174,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (5 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_core_bound",
-        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
+        "MetricThreshold": "(tma_core_bound >0.10) & ((tma_backend_bound >=
0.10))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -198,7 +184,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / (5 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_decode",
-        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_decode >0.05) & ((tma_ifetch_bandwidth >0=
.10) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -207,7 +193,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / (5 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_fast_nuke",
-        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
+        "MetricThreshold": "(tma_fast_nuke >0.05) & ((tma_machine_clears >=
0.05) & ((tma_bad_speculation >0.15)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -217,7 +203,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_=
CLK_UNHALTED.CORE@)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
-        "MetricThreshold": "tma_frontend_bound > 0.2",
+        "MetricThreshold": "(tma_frontend_bound >0.20)",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -227,7 +213,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / (5 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_icache_misses >0.05) & ((tma_ifetch_laten=
cy >0.15) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -236,7 +222,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (5 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_ifetch_bandwidth",
-        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
+        "MetricThreshold": "(tma_ifetch_bandwidth >0.10) & ((tma_frontend_=
bound >0.20))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -246,7 +232,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (5 * =
cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_ifetch_latency",
-        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
+        "MetricThreshold": "(tma_ifetch_latency >0.15) & ((tma_frontend_bo=
und >0.20))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -383,6 +369,12 @@
         "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2hit",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss doesn't hit in the L2",
+        "MetricExpr": "100 * (cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ + =
cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@) / cpu_atom@MEM_BOUND_STALLS.IFE=
TCH@",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2miss",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
         "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ / c=
pu_atom@MEM_BOUND_STALLS.IFETCH@",
@@ -402,6 +394,13 @@
         "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2hit=
",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses in the L2",
+        "MetricExpr": "100 * (cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ + cp=
u_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@) / cpu_atom@MEM_BOUND_STALLS.LOAD@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2mis=
s",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
         "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / cpu=
_atom@MEM_BOUND_STALLS.LOAD@",
@@ -548,7 +547,7 @@
     {
         "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
         "MetricExpr": "100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (5 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricName": "tma_info_serialization _%_tpause_cycles",
+        "MetricName": "tma_info_serialization_%_tpause_cycles",
         "Unit": "cpu_atom"
     },
     {
@@ -564,6 +563,13 @@
         "MetricName": "tma_info_system_kernel_utilization",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE_P@ / cpu_atom@CPU_CL=
K_UNHALTED.CORE@",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "((tma_info_system_mux > 1.1)|(tma_info_system_=
mux < 0.9))",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@CPU_CLK_=
UNHALTED.REF_TSC@",
@@ -600,7 +606,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ITLB@ / (5 * cpu_atom@CPU=
_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
 0.15 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_itlb_misses >0.05) & ((tma_ifetch_latency=
 >0.15) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -609,7 +615,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@ / =
(5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_machine_clears",
-        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
n > 0.15",
+        "MetricThreshold": "(tma_machine_clears >0.05) & ((tma_bad_specula=
tion >0.15))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -619,7 +625,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ / (5 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_mem_scheduler",
-        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_mem_scheduler >0.10) & ((tma_resource_bou=
nd >0.20) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -628,7 +634,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER@ / (5 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_non_mem_scheduler",
-        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_non_mem_scheduler >0.10) & ((tma_resource=
_bound >0.20) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -637,7 +643,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.NUKE@ / (5 * cpu_a=
tom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_nuke",
-        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
+        "MetricThreshold": "(tma_nuke >0.05) & ((tma_machine_clears >0.05)=
 & ((tma_bad_speculation >0.15)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -646,7 +652,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.OTHER@ / (5 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_other_fb",
-        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_other_fb >0.05) & ((tma_ifetch_bandwidth =
>0.10) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -655,7 +661,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.PREDECODE@ / (5 * cpu_ato=
m@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_predecode",
-        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_predecode >0.05) & ((tma_ifetch_bandwidth=
 >0.10) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -664,7 +670,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REGISTER@ / (5 * cpu_atom=
@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_register",
-        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_register >0.10) & ((tma_resource_bound >0=
.20) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -673,7 +679,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REORDER_BUFFER@ / (5 * cp=
u_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_reorder_buffer",
-        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_reorder_buffer >0.10) & ((tma_resource_bo=
und >0.20) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -682,7 +688,7 @@
         "MetricExpr": "tma_backend_bound - tma_core_bound",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_resource_bound",
-        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
+        "MetricThreshold": "(tma_resource_bound >0.20) & ((tma_backend_bou=
nd >0.10))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -693,7 +699,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL@ / (5 * cpu_atom@CPU_=
CLK_UNHALTED.CORE@)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
-        "MetricThreshold": "tma_retiring > 0.75",
+        "MetricThreshold": "(tma_retiring >0.75)",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
@@ -703,7 +709,7 @@
         "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.SERIALIZATION@ / (5 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_serialization",
-        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_serialization >0.10) & ((tma_resource_bou=
nd >0.20) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -715,7 +721,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
         "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS_D=
ISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_DIS=
PATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -728,13 +734,13 @@
         "MetricExpr": "78 * cpu_core@ASSISTS.ANY@ / tma_info_thread_slots"=
,
         "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
-        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
+        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1",
         "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists.",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists",
         "MetricExpr": "63 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_threa=
d_slots",
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_avx_assists",
@@ -745,7 +751,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
         "MetricGroup": "BvOB;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -762,18 +768,123 @@
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misses =
+ tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
+        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
+        "MetricName": "tma_bottleneck_big_code",
+        "MetricThreshold": "tma_bottleneck_big_code > 20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
+        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ + 2 =
* cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRED.NOP@) / tma_i=
nfo_thread_slots)",
+        "MetricGroup": "BvBO;Ret",
+        "MetricName": "tma_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
+        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dr=
am_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_store_fwd_blk + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_fb_full)=
))",
+        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
+        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + =
tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_de=
pendency + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_=
bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_d=
ram_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_st=
ore_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_load=
s + tma_fb_full)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_=
l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_split_l=
oads / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_dependency + tma=
_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound * (tma_s=
tore_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_split_stores / (tma_store_latency + tma_false_sha=
ring + tma_split_stores + tma_streaming_stores + tma_dtlb_store)) + tma_mem=
ory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_dram_bound + tma_store_bound)) * (tma_store_latency / (tma_store_late=
ncy + tma_false_sharing + tma_split_stores + tma_streaming_stores + tma_dtl=
b_store)))",
+        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_bottleneck_cache_memory_latency",
+        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_serializing_operation + tma_ports_utilization) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_serializing_operation + tma_ports_=
utilization)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricGroup": "BvCB;Cor;tma_issueComp",
+        "MetricName": "tma_bottleneck_compute_bound_est",
+        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses + t=
ma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
0x1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_=
clears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_br=
anch_mispredicts) / (tma_mispredicts_resteers + tma_clears_resteers + tma_u=
nknown_branches)) / (tma_icache_misses + tma_itlb_misses + tma_branch_reste=
ers + tma_ms_switches + tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth *=
 tma_ms / (tma_mite + tma_dsb + tma_lsd + tma_ms))) - tma_bottleneck_big_co=
de",
+        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
+        "MetricName": "tma_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
+        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_fetch_latency * (tma_ms_s=
witches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_rest=
eers * tma_other_mispredicts / tma_branch_mispredicts) / (tma_mispredicts_r=
esteers + tma_clears_resteers + tma_unknown_branches)) / (tma_icache_misses=
 + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_=
dsb_switches) + tma_fetch_bandwidth * tma_ms / (tma_mite + tma_dsb + tma_ls=
d + tma_ms)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_b=
ranch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other=
_nukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + cp=
u_core@RS.EMPTY_RESOURCE@ / tma_info_thread_clks * tma_ports_utilized_0) / =
(tma_divider + tma_serializing_operation + tma_ports_utilization) + tma_mic=
rocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) * =
(tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
+        "MetricName": "tma_bottleneck_irregular_overhead",
+        "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
+        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_=
store_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_lo=
ads + tma_fb_full)) + tma_memory_bound * (tma_store_bound / (tma_l1_bound +=
 tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_dt=
lb_store / (tma_store_latency + tma_false_sharing + tma_split_stores + tma_=
streaming_stores + tma_dtlb_store)))",
+        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * =
tma_false_sharing / (tma_store_latency + tma_false_sharing + tma_split_stor=
es + tma_streaming_stores + tma_dtlb_store - tma_store_latency)) + tma_mach=
ine_clears * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
+        "MetricName": "tma_bottleneck_memory_synchronization",
+        "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
+        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_contested_accesses, tma_data_sharing, tma_false_s=
haring, tma_machine_clears",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses=
 + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
+        "MetricName": "tma_bottleneck_mispredictions",
+        "MetricThreshold": "tma_bottleneck_mispredictions > 20",
+        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
+        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_cache_me=
mory_bandwidth + tma_bottleneck_cache_memory_latency + tma_bottleneck_memor=
y_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottleneck_comput=
e_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_branching_=
overhead + tma_bottleneck_useful_work)",
+        "MetricGroup": "BvOB;Cor;Offcore",
+        "MetricName": "tma_bottleneck_other_bottlenecks",
+        "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead",
+        "MetricExpr": "100 * (tma_retiring - (cpu_core@BR_INST_RETIRED.ALL=
_BRANCHES@ + 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRE=
D.NOP@) / tma_info_thread_slots - tma_microcode_sequencer / (tma_few_uops_i=
nstructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_seque=
ncer) * tma_heavy_operations)",
+        "MetricGroup": "BvUW;Ret",
+        "MetricName": "tma_bottleneck_useful_work",
+        "MetricThreshold": "tma_bottleneck_useful_work > 20",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * sl=
ots",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: =
tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredict=
ions, tma_mispredicts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: =
tma_bottleneck_mispredictions, tma_info_bad_spec_branch_misprediction_cost,=
 tma_mispredicts_resteers",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -782,26 +893,26 @@
         "MetricExpr": "cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_=
thread_clks + tma_unknown_branches",
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings).",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings)",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C01@ / tma_info_thread_cl=
ks",
         "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
         "MetricName": "tma_c01_wait",
-        "MetricThreshold": "tma_c01_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_c01_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings).",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings)",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C02@ / tma_info_thread_cl=
ks",
         "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
         "MetricName": "tma_c02_wait",
-        "MetricThreshold": "tma_c02_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_c02_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -810,7 +921,7 @@
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
+        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources. Sample with: FRONTEND_RETIRE=
D.MS_FLOWS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -820,18 +931,72 @@
         "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
-        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_restee=
rs > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Sam=
ple with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, tma=
_machine_clears, tma_microcode_sequencer, tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache",
+        "MetricExpr": "max(0, tma_icache_misses - tma_code_l2_miss)",
+        "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
+        "MetricName": "tma_code_l2_hit",
+        "MetricThreshold": "tma_code_l2_hit > 0.05 & tma_icache_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_D=
EMAND_CODE_RD@ / tma_info_thread_clks",
+        "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
+        "MetricName": "tma_code_l2_miss",
+        "MetricThreshold": "tma_code_l2_miss > 0.05 & tma_icache_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) ITLB was missed by instructions fetches, th=
at later on hit in second-level TLB (STLB)",
+        "MetricExpr": "max(0, tma_itlb_misses - tma_code_stlb_miss)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
+        "MetricName": "tma_code_stlb_hit",
+        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by instruction fetches, perfor=
ming a hardware page walk",
+        "MetricExpr": "cpu_core@ITLB_MISSES.WALK_ACTIVE@ / tma_info_thread=
_clks",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
+        "MetricName": "tma_code_stlb_miss",
+        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses",
+        "MetricExpr": "tma_code_stlb_miss * cpu_core@ITLB_MISSES.WALK_COMP=
LETED_2M_4M@ / (cpu_core@ITLB_MISSES.WALK_COMPLETED_4K@ + cpu_core@ITLB_MIS=
SES.WALK_COMPLETED_2M_4M@)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_2m",
+        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses",
+        "MetricExpr": "tma_code_stlb_miss * cpu_core@ITLB_MISSES.WALK_COMP=
LETED_4K@ / (cpu_core@ITLB_MISSES.WALK_COMPLETED_4K@ + cpu_core@ITLB_MISSES=
.WALK_COMPLETED_2M_4M@)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_4k",
+        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "(25 * tma_info_system_core_frequency * (cpu_core@ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP=
_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEM=
AND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) + 24 * tma_info_system_core_frequ=
ency * cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@) * (1 + cpu_core@MEM_LOA=
D_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thre=
ad_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_l3_bound_group",
+        "MetricExpr": "((28 * tma_info_system_core_frequency - 3 * tma_inf=
o_system_core_frequency) * (cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (c=
pu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAND_DATA_R=
D.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FW=
D@))) + (27 * tma_info_system_core_frequency - 3 * tma_info_system_core_fre=
quency) * cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@) * (1 + cpu_core@MEM_=
LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_t=
hread_clks",
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
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related m=
etrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma_remote=
_cache",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related =
metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false=
_sharing, tma_machine_clears",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -842,26 +1007,26 @@
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "24 * tma_info_system_core_frequency * (cpu_core@MEM=
_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_F=
WD@ * (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.D=
EMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP=
_HIT_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_L=
OAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
+        "MetricExpr": "(27 * tma_info_system_core_frequency - 3 * tma_info=
_system_core_frequency) * (cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ + =
cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (1 - cpu_core@OCR.DEMAND_DATA_=
RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + c=
pu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) * (1 + cpu_core@ME=
M_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info=
_thread_clks",
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
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
+        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_synch=
ronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cp=
u_core@INST_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2"=
,
+        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - =
cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks =
/ 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & t=
ma_fetch_bandwidth > 0.2)",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & tma_mite > 0.1 & tm=
a_fetch_bandwidth > 0.2",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -871,7 +1036,7 @@
         "MetricExpr": "cpu_core@ARITH.DIV_ACTIVE@ / tma_info_thread_clks",
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
ith: ARITH.DIVIDER_ACTIVE",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -881,8 +1046,8 @@
         "MetricExpr": "cpu_core@MEMORY_ACTIVITY.STALLS_L3_MISS@ / tma_info=
_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS",
+        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -892,7 +1057,7 @@
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -901,48 +1066,48 @@
         "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / tma_in=
fo_thread_clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
-        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_ban=
dwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwi=
dth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_inf=
o_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "min(7 * cpu_core@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\=
\=3D1@ + cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@, max(cpu_core@CYCLE_ACTIVIT=
Y.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVITY.CYCLES_L1D_MISS@, 0)) / tma_in=
fo_thread_clks",
+        "MetricExpr": "min(7 * cpu_core@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\=
\=3D0x1@ + cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@, max(cpu_core@CYCLE_ACTIV=
ITY.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVITY.CYCLES_L1D_MISS@, 0)) / tma_=
info_thread_clks",
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
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_me=
mory_synchronization",
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
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS. Related metrics: tma_=
bottleneck_memory_data_tlbs, tma_dtlb_store",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * cpu_core@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=
=3D1@ + cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@) / tma_info_core_core_clks"=
,
+        "MetricExpr": "(7 * cpu_core@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=
=3D0x1@ + cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@) / tma_info_core_core_clk=
s",
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
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_memory_synchroniz=
ation",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.2 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES. Related metrics: tma_bottleneck_mem=
ory_data_tlbs, tma_dtlb_load",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
         "MetricExpr": "28 * tma_info_system_core_frequency * cpu_core@OCR.=
DEMAND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_thread_clks",
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
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_contested_accesses, tma_data_sharing=
, tma_machine_clears, tma_remote_cache",
+        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound > 0=
.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronization, t=
ma_contested_accesses, tma_data_sharing, tma_machine_clears",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricExpr": "cpu_core@L1D_PEND_MISS.FB_FULL@ / tma_info_thread_c=
lks",
-        "MetricGroup": "BvMS;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_bottleneck_cache_memory_bandwi=
dth, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store=
_latency, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_cache_memory_bandwidth, =
tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_late=
ncy, tma_streaming_stores",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -953,28 +1118,28 @@
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1, FRONTEND_RETIRED.LATE=
NCY_GE_1, FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches,=
 tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "cpu_core@topdown\\-fetch\\-lat@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / t=
ma_info_thread_slots",
+        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - cpu_core@I=
NT_MISC.UOP_DROPPING@ / tma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16, FRONTEND_RETIRED.LATENCY_GE_8",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or more =
uops",
         "MetricExpr": "max(0, tma_heavy_operations - tma_microcode_sequenc=
er)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_heavy_operations_group;=
tma_issueD0",
         "MetricName": "tma_few_uops_instructions",
         "MetricThreshold": "tma_few_uops_instructions > 0.05 & tma_heavy_o=
perations > 0.1",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or up t=
o ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number o=
f uops in such instructions. Related metrics: tma_decoder0_alone",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or more=
 uops. This highly-correlates with the number of uops in such instructions.=
 Related metrics: tma_decoder0_alone",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -984,7 +1149,7 @@
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
         "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
-        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -994,7 +1159,16 @@
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_fp_assists",
         "MetricThreshold": "tma_fp_assists > 0.1",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals).",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals)",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active",
+        "MetricExpr": "cpu_core@ARITH.FPDIV_ACTIVE@ / tma_info_thread_clks=
",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
+        "MetricName": "tma_fp_divider",
+        "MetricThreshold": "tma_fp_divider > 0.2 & tma_divider > 0.2 & tma=
_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1003,8 +1177,8 @@
         "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ / (tma_retir=
ing * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
-        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector_2=
56b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma=
_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1013,8 +1187,8 @@
         "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.VECTOR@ / (tma_retir=
ing * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
-        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized=
_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1023,8 +1197,8 @@
         "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
-        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_=
2",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1033,41 +1207,41 @@
         "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
-        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_=
2",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_int_vector_128b, tma_int_vector_256b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tm=
a_info_thread_slots",
+        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - cpu_core@IN=
T_MISC.UOP_DROPPING@ / tma_info_thread_slots",
         "MetricGroup": "BvFB;BvIO;Default;PGO;TmaL1;TopdownL1;tma_L1_group=
",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
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
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
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
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions , where one uop can represent mul=
tiple contiguous instructions",
         "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.MACRO_=
FUSED@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of =
legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Ot=
her_Light_Ops in MTL!)}",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions , where one uop can represent mu=
ltiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of l=
egacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Oth=
er_Light_Ops in MTL!)}",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
-        "MetricExpr": "cpu_core@topdown\\-heavy\\-ops@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. ([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+] .). Sample with: UOPS=
_RETIRED.HEAVY",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+]). Sample with: UOPS_RET=
IRED.HEAVY",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1076,21 +1250,21 @@
         "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / tma_info_thread_clks=
",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
+        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS, FRONTEND_RETIRED.L1I_MISS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": "tma_info_bottleneck_mispredictions * tma_info_threa=
d_slots / cpu_core@BR_MISP_RETIRED.ALL_BRANCHES@ / 100",
+        "BriefDescription": "Branch Misprediction Cost: Cycles representin=
g fraction of TMA slots wasted per non-speculative branch misprediction (re=
tired JEClear)",
+        "MetricExpr": "tma_bottleneck_mispredictions * tma_info_thread_slo=
ts / 6 / cpu_core@BR_MISP_RETIRED.ALL_BRANCHES@ / 100",
         "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
-        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers",
+        "PublicDescription": "Branch Misprediction Cost: Cycles representi=
ng fraction of TMA slots wasted per non-speculative branch misprediction (r=
etired JEClear). Related metrics: tma_bottleneck_mispredictions, tma_branch=
_mispredicts, tma_mispredicts_resteers",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate)",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.COND_NTAKEN@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
@@ -1098,7 +1272,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate)",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.COND_TAKEN@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
@@ -1106,15 +1280,15 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.INDIRECT@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
-        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate)",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.RET@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_ret",
@@ -1130,7 +1304,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing mispredicts and nukes)",
+        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing Mispredicts and nukes)",
         "MetricExpr": "cpu_core@INT_MISC.CLEARS_COUNT@ / (cpu_core@BR_MISP=
_RETIRED.ALL_BRANCHES@ + cpu_core@MACHINE_CLEARS.COUNT@)",
         "MetricGroup": "BrMispredicts",
         "MetricName": "tma_info_bad_spec_spec_clears_ratio",
@@ -1146,8 +1320,8 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_lsd =
+ tma_mite)))",
-        "MetricGroup": "DSB;FetchBW;tma_issueFB",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_dsb=
 + tma_lsd + tma_ms)))",
+        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
         "PublicDescription": "Total pipeline cost of DSB (uop cache) hits =
- subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb_s=
witches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_front=
end_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
@@ -1155,7 +1329,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + t=
ma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite + t=
ma_dsb + tma_lsd + tma_ms))",
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_misses",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
@@ -1164,116 +1338,10 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + =
tma_lcp + tma_dsb_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
         "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
-        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: ",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
-        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
-        "MetricName": "tma_info_bottleneck_big_code",
-        "MetricThreshold": "tma_info_bottleneck_big_code > 20",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
-        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ + 2 =
* cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRED.NOP@) / tma_i=
nfo_thread_slots)",
-        "MetricGroup": "BvBO;Ret",
-        "MetricName": "tma_info_bottleneck_branching_overhead",
-        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 5",
-        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_h=
it_latency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
-        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_bottleneck_cache_memory_bandwidth",
-        "MetricThreshold": "tma_info_bottleneck_cache_memory_bandwidth > 2=
0",
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_store_bound / (tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tm=
a_store_latency + tma_streaming_stores)) + tma_memory_bound * (tma_l1_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store=
_bound)) * (tma_l1_hit_latency / (tma_dtlb_load + tma_fb_full + tma_l1_hit_=
latency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
-        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_info_bottleneck_cache_memory_latency",
-        "MetricThreshold": "tma_info_bottleneck_cache_memory_latency > 20"=
,
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
-        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_ports_utilization + tma_serializing_operation) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_ports_utilization + tma_serializin=
g_operation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
-        "MetricGroup": "BvCB;Cor;tma_issueComp",
-        "MetricName": "tma_info_bottleneck_compute_bound_est",
-        "MetricThreshold": "tma_info_bottleneck_compute_bound_est > 20",
-        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: ",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
-        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_cl=
ears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_bran=
ch_mispredicts) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unk=
nown_branches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_miss=
es + tma_itlb_misses + tma_lcp + tma_ms_switches))) - tma_info_bottleneck_b=
ig_code",
-        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
-        "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
-        "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"=
,
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
-        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_swi=
tches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_restee=
rs * tma_other_mispredicts / tma_branch_mispredicts) / (tma_clears_resteers=
 + tma_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers=
 + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_m=
s_switches)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_b=
ranch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other=
_nukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + cp=
u_core@RS.EMPTY\\,umask\\=3D1@ / tma_info_thread_clks * tma_ports_utilized_=
0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) + tm=
a_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequence=
r) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
-        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
-        "MetricName": "tma_info_bottleneck_irregular_overhead",
-        "MetricThreshold": "tma_info_bottleneck_irregular_overhead > 10",
-        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_=
fb_full + tma_l1_hit_latency + tma_lock_latency + tma_split_loads + tma_sto=
re_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_dram_bound + tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_dtlb_stor=
e / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_late=
ncy + tma_streaming_stores)))",
-        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_bottleneck_memory_data_tlbs",
-        "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store, tma_info_bottleneck_memory_synchronization",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_stores =
+ tma_store_latency + tma_streaming_stores - tma_store_latency)) + tma_mach=
ine_clears * (1 - tma_other_nukes / tma_other_nukes))",
-        "MetricGroup": "BvMS;Mem;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_bottleneck_memory_synchronization",
-        "MetricThreshold": "tma_info_bottleneck_memory_synchronization > 1=
0",
-        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_dtlb_load, tma_dtlb_store, tma_info_bottleneck_me=
mory_data_tlbs",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
-        "MetricName": "tma_info_bottleneck_mispredictions",
-        "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
-        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
-        "MetricExpr": "100 - (tma_info_bottleneck_big_code + tma_info_bott=
leneck_instruction_fetch_bw + tma_info_bottleneck_mispredictions + tma_info=
_bottleneck_cache_memory_bandwidth + tma_info_bottleneck_cache_memory_laten=
cy + tma_info_bottleneck_memory_data_tlbs + tma_info_bottleneck_memory_sync=
hronization + tma_info_bottleneck_compute_bound_est + tma_info_bottleneck_i=
rregular_overhead + tma_info_bottleneck_branching_overhead + tma_info_bottl=
eneck_useful_work)",
-        "MetricGroup": "BvOB;Cor;Offcore",
-        "MetricName": "tma_info_bottleneck_other_bottlenecks",
-        "MetricThreshold": "tma_info_bottleneck_other_bottlenecks > 20",
-        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls.",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
-        "MetricExpr": "100 * (tma_retiring - (cpu_core@BR_INST_RETIRED.ALL=
_BRANCHES@ + 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRE=
D.NOP@) / tma_info_thread_slots - tma_microcode_sequencer / (tma_few_uops_i=
nstructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_seque=
ncer) * tma_heavy_operations)",
-        "MetricGroup": "BvUW;Ret",
-        "MetricName": "tma_info_bottleneck_useful_work",
-        "MetricThreshold": "tma_info_bottleneck_useful_work > 20",
         "Unit": "cpu_core"
     },
     {
@@ -1344,12 +1412,12 @@
         "MetricExpr": "(cpu_core@FP_ARITH_DISPATCHED.PORT_0@ + cpu_core@FP=
_ARITH_DISPATCHED.PORT_1@ + cpu_core@FP_ARITH_DISPATCHED.PORT_5@) / (2 * tm=
a_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n).",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
-        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_EXEC=
UTED.THREAD\\,cmask\\=3D1@",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_EXEC=
UTED.THREAD\\,cmask\\=3D0x1@",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp",
         "Unit": "cpu_core"
@@ -1364,22 +1432,22 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
-        "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / cpu_co=
re@DSB2MITE_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
",
+        "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / cpu_co=
re@DSB2MITE_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
         "MetricGroup": "DSBmiss",
         "MetricName": "tma_info_frontend_dsb_switch_cost",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "cpu_core@UOPS_ISSUED.ANY@ / cpu_core@UOPS_ISSUED.AN=
Y\\,cmask\\=3D1@",
+        "MetricExpr": "cpu_core@UOPS_ISSUED.ANY@ / cpu_core@UOPS_ISSUED.AN=
Y\\,cmask\\=3D0x1@",
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "tma_info_frontend_fetch_upc",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
-        "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / cpu_core@ICACHE_DATA=
.STALLS\\,cmask\\=3D1\\,edge@",
+        "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / cpu_core@ICACHE_DATA=
.STALLS\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
         "MetricGroup": "Fed;FetchLat;IcMiss",
         "MetricName": "tma_info_frontend_icache_miss_latency",
         "Unit": "cpu_core"
@@ -1420,16 +1488,23 @@
         "MetricName": "tma_info_frontend_lsd_coverage",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ / tma_info_thr=
ead_clks",
+        "MetricGroup": "Branches;FetchBW",
+        "MetricName": "tma_info_frontend_tbpc",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Average number of cycles the front-end was de=
layed due to an Unknown Branch detection",
-        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / cpu_core=
@INT_MISC.UNKNOWN_BRANCH_CYCLES\\,cmask\\=3D1\\,edge@",
+        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / cpu_core=
@INT_MISC.UNKNOWN_BRANCH_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
         "MetricGroup": "Fed",
         "MetricName": "tma_info_frontend_unknown_branch_cost",
-        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node.",
+        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
+        "BriefDescription": "Branch instructions per taken branch",
         "MetricExpr": "cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ / cpu_core@B=
R_INST_RETIRED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_bptkbranch",
@@ -1449,7 +1524,7 @@
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW.",
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW",
         "Unit": "cpu_core"
     },
     {
@@ -1458,7 +1533,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting",
         "Unit": "cpu_core"
     },
     {
@@ -1467,7 +1542,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting",
         "Unit": "cpu_core"
     },
     {
@@ -1476,7 +1551,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting",
         "Unit": "cpu_core"
     },
     {
@@ -1485,7 +1560,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting",
         "Unit": "cpu_core"
     },
     {
@@ -1537,7 +1612,7 @@
     },
     {
         "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@SW_PREFETCH_A=
CCESS.T0\\,umask\\=3D0xF@",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@SW_PREFETCH_A=
CCESS.ANY@",
         "MetricGroup": "Prefetches",
         "MetricName": "tma_info_inst_mix_ipswpf",
         "MetricThreshold": "tma_info_inst_mix_ipswpf < 100",
@@ -1548,7 +1623,7 @@
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
-        "MetricThreshold": "tma_info_inst_mix_iptb < 13",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 6 * 2 + 1",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp",
         "Unit": "cpu_core"
     },
@@ -1589,7 +1664,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / duration_tim=
e",
+        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / tma_info_sys=
tem_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw",
         "Unit": "cpu_core"
@@ -1610,7 +1685,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / duration_tim=
e",
+        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / tma_info_sys=
tem_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l2_cache_fill_bw",
         "Unit": "cpu_core"
@@ -1659,14 +1734,14 @@
     },
     {
         "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ duration_time",
+        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "tma_info_memory_l3_cache_access_bw",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / durat=
ion_time",
+        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / tma_i=
nfo_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l3_cache_fill_bw",
         "Unit": "cpu_core"
@@ -1688,13 +1763,13 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS.DEMAND_DATA_RD@",
-        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricGroup": "LockCont;Memory_Lat;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_miss_latency",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
-        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@"=
,
         "MetricGroup": "Memory_BW;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_mlp",
         "Unit": "cpu_core"
@@ -1735,6 +1810,14 @@
         "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Rate of L2 HW prefetched lines that were not =
used by demand accesses",
+        "MetricExpr": "cpu_core@L2_LINES_OUT.USELESS_HWPF@ / (cpu_core@L2_=
LINES_OUT.SILENT@ + cpu_core@L2_LINES_OUT.NON_SILENT@)",
+        "MetricGroup": "Prefetches",
+        "MetricName": "tma_info_memory_prefetches_useless_hwpf",
+        "MetricThreshold": "tma_info_memory_prefetches_useless_hwpf > 0.15=
",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
         "MetricExpr": "1e3 * cpu_core@ITLB_MISSES.WALK_COMPLETED@ / cpu_co=
re@INST_RETIRED.ANY@",
@@ -1765,8 +1848,8 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
-        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D1@)",
+        "BriefDescription": "",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D0x1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute",
         "Unit": "cpu_core"
@@ -1797,20 +1880,20 @@
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@ASSISTS.ANY@"=
,
         "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
         "MetricName": "tma_info_pipeline_ipassist",
-        "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
+        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
         "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D1@",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D0x1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
-        "MetricExpr": "cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D1@",
+        "MetricExpr": "cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D0x1@",
         "MetricGroup": "MicroSeq;Pipeline;Ret",
         "MetricName": "tma_info_pipeline_strings_cycles",
         "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1",
@@ -1826,7 +1909,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency",
         "Unit": "cpu_core"
@@ -1847,15 +1930,15 @@
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
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_cache_memory_bandwidth, tma_mem_bandwidth, tma_sq_full",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_ban=
dwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu_c=
ore@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INST_=
RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) =
/ 1e9 / duration_time",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu_c=
ore@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INST_=
RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) =
/ 1e9 / tma_info_system_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width",
@@ -1863,22 +1946,23 @@
     },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.FAR_BRANCH@u",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_INST_RETIRED.FAR_BR=
ANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_system_ipfarbranch",
-        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6",
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@k / cpu_core@INS=
T_RETIRED.ANY_P@k",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
         "MetricGroup": "OS",
         "MetricName": "tma_info_system_kernel_cpi",
+        "ScaleUnit": "1per_instr",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@k / cpu_core@CPU=
_CLK_UNHALTED.THREAD@",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / cpu_core@CPU_CLK_UNHA=
LTED.THREAD@",
         "MetricGroup": "OS",
         "MetricName": "tma_info_system_kernel_utilization",
         "MetricThreshold": "tma_info_system_kernel_utilization > 0.05",
@@ -1901,6 +1985,21 @@
         "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@ / cpu_core@CPU_=
CLK_UNHALTED.THREAD@",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total package Power in Watts",
+        "MetricExpr": "power@energy\\-pkg@ * 61 / (tma_info_system_time * =
1e6)",
+        "MetricGroup": "Power;SoC",
+        "MetricName": "tma_info_system_power",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - cpu_core@CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE@ /=
 cpu_core@CPU_CLK_UNHALTED.REF_DISTRIBUTED@ if #SMT_on else 0)",
@@ -1915,6 +2014,14 @@
         "MetricName": "tma_info_system_socket_clks",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Run duration time in seconds",
+        "MetricExpr": "duration_time",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_time",
+        "MetricThreshold": "tma_info_system_time < 1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "tma_info_thread_clks / cpu_core@CPU_CLK_UNHALTED.RE=
F_TSC@",
@@ -1923,7 +2030,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD@",
         "MetricGroup": "Pipeline",
         "MetricName": "tma_info_thread_clks",
@@ -1934,6 +2041,7 @@
         "MetricExpr": "1 / tma_info_thread_ipc",
         "MetricGroup": "Mem;Pipeline",
         "MetricName": "tma_info_thread_cpi",
+        "ScaleUnit": "1per_instr",
         "Unit": "cpu_core"
     },
     {
@@ -1941,7 +2049,7 @@
         "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_ISSU=
ED.ANY@",
         "MetricGroup": "Cor;Pipeline",
         "MetricName": "tma_info_thread_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage.",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage",
         "Unit": "cpu_core"
     },
     {
@@ -1953,14 +2061,14 @@
     },
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "cpu_core@TOPDOWN.SLOTS@",
+        "MetricExpr": "slots",
         "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(tma_info_thread_slots / (cpu_core@TOPDOWN.SLOTS@ /=
 2) if #SMT_on else 1)",
+        "MetricExpr": "(tma_info_thread_slots / (slots / 2) if #SMT_on els=
e 1)",
         "MetricGroup": "SMT;TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots_utilization",
         "Unit": "cpu_core"
@@ -1978,7 +2086,16 @@
         "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@BR_=
INST_RETIRED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
-        "MetricThreshold": "tma_info_thread_uptb < 9",
+        "MetricThreshold": "tma_info_thread_uptb < 6 * 1.5",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active",
+        "MetricExpr": "tma_divider - tma_fp_divider",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
+        "MetricName": "tma_int_divider",
+        "MetricThreshold": "tma_int_divider > 0.2 & tma_divider > 0.2 & tm=
a_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
@@ -1987,7 +2104,7 @@
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_int_operations",
         "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operation=
s > 0.6",
-        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain.",
+        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1996,8 +2113,8 @@
         "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_128@ + cpu_core@INT_V=
EC_RETIRED.VNNI_128@) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_128b",
-        "MetricThreshold": "tma_int_vector_128b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
-        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_256b, tma=
_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_int_vector_128b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_int_vector_256b, tma_port_0, tma_port_1,=
 tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2006,8 +2123,8 @@
         "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_256@ + cpu_core@INT_V=
EC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@) / (tma_retiring *=
 tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_256b",
-        "MetricThreshold": "tma_int_vector_256b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
-        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b,=
 tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_int_vector_256b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_port_0, tma_por=
t_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2016,28 +2133,28 @@
         "MetricExpr": "cpu_core@ICACHE_TAG.STALLS@ / tma_info_thread_clks"=
,
         "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS, FRONTEND_RETIRED.ITLB_MISS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 Data (L1D) cache",
         "MetricExpr": "max((cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L1D_MISS@) / tma_info_thread_clks, 0)",
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
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS. Related metrics: tma_clears_resteers, tma_machine_clears, tma_micr=
ocode_sequencer, tma_ms_switches, tma_ports_utilized_1",
+        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & =
tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics: t=
ma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_swi=
tches, tma_ports_utilized_1",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of cyc=
les with demand load accesses that hit the L1 cache",
+        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
         "MetricExpr": "min(2 * (cpu_core@MEM_INST_RETIRED.ALL_LOADS@ - cpu=
_core@MEM_LOAD_RETIRED.FB_HIT@ - cpu_core@MEM_LOAD_RETIRED.L1_MISS@) * 20 /=
 100, max(cpu_core@CYCLE_ACTIVITY.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVIT=
Y.CYCLES_L1D_MISS@, 0)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
-        "MetricName": "tma_l1_hit_latency",
-        "MetricThreshold": "tma_l1_hit_latency > 0.1 & (tma_l1_bound > 0.1=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles with demand load accesses that hit the L1 cache. The short latency of =
the L1 data cache may be exposed in pointer-chasing memory access patterns =
as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
+        "MetricName": "tma_l1_latency_dependency",
+        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & tma_l1_bound=
 > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache. The s=
hort latency of the L1D cache may be exposed in pointer-chasing memory acce=
ss patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2046,8 +2163,18 @@
         "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L1D_MISS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L2_MISS@) / tma_info_thread_clks",
         "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
+        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
+        "MetricExpr": "3 * tma_info_system_core_frequency * cpu_core@MEM_L=
OAD_RETIRED.L2_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM=
_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
+        "MetricName": "tma_l2_hit_latency",
+        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L2 cache under unloaded scenarios (pos=
sibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 hit=
s) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2056,18 +2183,18 @@
         "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L2_MISS@ - cpu_cor=
e@MEMORY_ACTIVITY.STALLS_L3_MISS@) / tma_info_thread_clks",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
+        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
-        "MetricExpr": "9 * tma_info_system_core_frequency * (cpu_core@MEM_=
LOAD_RETIRED.L3_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@ME=
M_LOAD_RETIRED.L1_MISS@ / 2)) / tma_info_thread_clks",
+        "MetricExpr": "(12 * tma_info_system_core_frequency - 3 * tma_info=
_system_core_frequency) * (cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * (1 + cpu_cor=
e@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2)) / tma=
_info_thread_clks",
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
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_info_bottleneck_cache_memory_latency, tma_mem_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.05=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT. Related metrics: tma_b=
ottleneck_cache_memory_latency, tma_branch_resteers, tma_mem_latency, tma_s=
tore_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2076,19 +2203,19 @@
         "MetricExpr": "cpu_core@DECODE.LCP@ / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
-        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & tma=
_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. Related metr=
ics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidt=
h, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_info_=
inst_mix_iptb",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations , instructions that require =
no more than one uop (micro-operation)",
         "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2107,7 +2234,7 @@
         "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_hit",
-        "MetricThreshold": "tma_load_stlb_hit > 0.05 & (tma_dtlb_load > 0.=
1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
+        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0.1=
 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2116,16 +2243,43 @@
         "MetricExpr": "cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@ / tma_info_t=
hread_clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_miss",
-        "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
+        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > 0.=
1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_1G@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_core@D=
TLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_COMP=
LETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_1g",
+        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_2M_4M@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_C=
OMPLETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_2m",
+        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_4K@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_core@D=
TLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_COMP=
LETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_4k",
+        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricExpr": "(16 * max(0, cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ =
- cpu_core@L2_RQSTS.ALL_RFO@) + cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu=
_core@MEM_INST_RETIRED.ALL_STORES@ * (10 * cpu_core@L2_RQSTS.RFO_HIT@ + min=
(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUESTS_OUTSTANDING.C=
YCLES_WITH_DEMAND_RFO@))) / tma_info_thread_clks",
-        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
+        "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
-        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 & =
tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2136,7 +2290,7 @@
         "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_lsd",
         "MetricThreshold": "tma_lsd > 0.15 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure.",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2147,17 +2301,17 @@
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
tma_bottleneck_memory_synchronization, tma_clears_resteers, tma_contested_a=
ccesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_s=
equencer, tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
-        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clk=
s",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_c=
lks",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
-        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_fb_full, tma_info_bottleneck_cache=
_memory_bandwidth, tma_info_system_dram_bw_use, tma_sq_full",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2166,34 +2320,34 @@
         "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_thread_clks - tm=
a_mem_bandwidth",
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
-        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_info_bottleneck_cache_memory_latency, tma_l3_hit_la=
tency",
+        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_latency=
",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "cpu_core@topdown\\-mem\\-bound@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * cpu_core@MISC2_RETIRED.LFENCE@ / tma_info_thre=
ad_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_memory_fence",
-        "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_memory_fence > 0.05 & tma_serializing_oper=
ation > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations , uops for memory load or store ac=
cesses",
         "MetricExpr": "tma_light_operations * cpu_core@MEM_UOP_RETIRED.ANY=
@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_memory_operations",
@@ -2207,7 +2361,7 @@
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
be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_clears_reste=
ers, tma_info_bottleneck_irregular_overhead, tma_l1_bound, tma_machine_clea=
rs, tma_ms_switches",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_bottleneck_i=
rregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clears, t=
ma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2216,8 +2370,8 @@
         "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * cpu_=
core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
-        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_bad_spec_branch_misprediction_cost=
, tma_info_bottleneck_mispredictions",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch_r=
esteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_bottleneck_mispredictions, tma_branch_mispredicts, tma_info_bad=
_spec_branch_misprediction_cost",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2232,22 +2386,31 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued -- the Count D=
omain; [ADL+] cycles)",
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued , the Count Do=
main; [ADL+] cycles)",
         "MetricExpr": "160 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_thre=
ad_clks",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
         "MetricName": "tma_mixing_vectors",
         "MetricThreshold": "tma_mixing_vectors > 0.05",
-        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued -- the Count =
Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investiga=
ting. Read more in Appendix B1 of the Optimizations Guide for this topic. R=
elated metrics: tma_ms_switches",
+        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued , the Count D=
omain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investigat=
ing. Read more in Appendix B1 of the Optimizations Guide for this topic. Re=
lated metrics: tma_ms_switches",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details",
+        "MetricExpr": "max(cpu_core@IDQ.MS_CYCLES_ANY@, cpu_core@UOPS_RETI=
RED.MS\\,cmask\\=3D0x1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISS=
UED.ANY@)) / tma_info_core_core_clks / 2",
+        "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
+        "MetricName": "tma_ms",
+        "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ =
/ (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUED.ANY@) / tma_info_thr=
ead_clks",
+        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge=
\\=3D0x1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUED.ANY@) / tm=
a_info_thread_clks",
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
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_clears_resteers, tma_info_bottleneck_irregular_overhead, tma_l1_bound, tm=
a_machine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializ=
ing_operation",
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
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_bottleneck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_mac=
hine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_o=
peration",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2257,7 +2420,7 @@
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2266,7 +2429,7 @@
         "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.NOP@ /=
 (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "BvBO;Pipeline;TopdownL4;tma_L4_group;tma_other_lig=
ht_ops_group",
         "MetricName": "tma_nop_instructions",
-        "MetricThreshold": "tma_nop_instructions > 0.1 & (tma_other_light_=
ops > 0.3 & tma_light_operations > 0.6)",
+        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_other_light_o=
ps > 0.3 & tma_light_operations > 0.6",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2282,20 +2445,20 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types)",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - cpu_core@BR_MISP_=
RETIRED.ALL_BRANCHES@ / (cpu_core@INT_MISC.CLEARS_COUNT@ - cpu_core@MACHINE=
_CLEARS.COUNT@)), 0.0001)",
         "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
-        "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_misp=
redicts > 0.1 & tma_bad_speculation > 0.15",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
         "MetricExpr": "max(tma_machine_clears * (1 - cpu_core@MACHINE_CLEA=
RS.MEMORY_ORDERING@ / cpu_core@MACHINE_CLEARS.COUNT@), 0.0001)",
         "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
-        "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
+        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears > =
0.1 & tma_bad_speculation > 0.15",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2305,7 +2468,7 @@
         "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_page_faults",
         "MetricThreshold": "tma_page_faults > 0.05",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost.",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2315,7 +2478,7 @@
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_int_vector_128b, tma_int_vector_256b, tma_port_1, tma_port_5, tma_po=
rt_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_12=
8b, tma_int_vector_256b, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2325,7 +2488,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_ve=
ctor_256b, tma_port_0, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_port_=
0, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2335,27 +2498,27 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_6. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_por=
t_5, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128=
b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (cp=
u_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_=
PORTS_UTIL\\,umask\\=3D0xc@)) / tma_info_thread_clks if cpu_core@ARITH.DIV_=
ACTIVE@ < cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOU=
ND_ON_LOADS@ else (cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu=
_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@) / tma_info_thread_clks)",
+        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (cp=
u_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_=
3_PORTS_UTIL@)) / tma_info_thread_clks if cpu_core@ARITH.DIV_ACTIVE@ < cpu_=
core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ e=
lse (cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTI=
VITY.2_3_PORTS_UTIL@) / tma_info_thread_clks)",
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + max(cpu=
_core@RS.EMPTY\\,umask\\=3D1@ - cpu_core@RESOURCE_STALLS.SCOREBOARD@, 0)) /=
 tma_info_thread_clks * (cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@E=
XE_ACTIVITY.BOUND_ON_LOADS@) / tma_info_thread_clks",
+        "MetricExpr": "(cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + max(cpu=
_core@RS.EMPTY_RESOURCE@ - cpu_core@RESOURCE_STALLS.SCOREBOARD@, 0)) / tma_=
info_thread_clks * (cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_AC=
TIVITY.BOUND_ON_LOADS@) / tma_info_thread_clks",
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2364,7 +2527,7 @@
         "MetricExpr": "cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ / tma_info_thre=
ad_clks",
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
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL. Related m=
etrics: tma_l1_bound",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2375,8 +2538,8 @@
         "MetricExpr": "cpu_core@EXE_ACTIVITY.2_PORTS_UTIL@ / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
-        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma=
_int_vector_256b, tma_port_0, tma_port_1, tma_port_6",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2386,7 +2549,7 @@
         "MetricExpr": "cpu_core@UOPS_EXECUTED.CYCLES_GE_3@ / tma_info_thre=
ad_clks",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2394,7 +2557,7 @@
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-=
fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@=
 + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
         "MetricGroup": "BvUW;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -2408,7 +2571,7 @@
         "MetricExpr": "cpu_core@RESOURCE_STALLS.SCOREBOARD@ / tma_info_thr=
ead_clks + tma_c02_wait",
         "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_bou=
nd_group;tma_issueSO",
         "MetricName": "tma_serializing_operation",
-        "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_bo=
und > 0.1 & tma_backend_bound > 0.2)",
+        "MetricThreshold": "tma_serializing_operation > 0.1 & tma_core_bou=
nd > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2418,8 +2581,8 @@
         "MetricExpr": "tma_light_operations * cpu_core@INT_VEC_RETIRED.SHU=
FFLES@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_other_ligh=
t_ops_group",
         "MetricName": "tma_shuffles_256b",
-        "MetricThreshold": "tma_shuffles_256b > 0.1 & (tma_other_light_ops=
 > 0.3 & tma_light_operations > 0.6)",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers.",
+        "MetricThreshold": "tma_shuffles_256b > 0.1 & tma_other_light_ops =
> 0.3 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2429,7 +2592,7 @@
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.PAUSE@ / tma_info_thread_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
-        "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_slow_pause > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2439,8 +2602,8 @@
         "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu_core@L=
D_BLOCKS.NO_SR@ / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
-        "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
+        "MetricThreshold": "tma_split_loads > 0.3",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2449,18 +2612,18 @@
         "MetricExpr": "cpu_core@MEM_INST_RETIRED.SPLIT_STORES@ / tma_info_=
core_core_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
-        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
+        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0.2=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
         "MetricExpr": "(cpu_core@XQ.FULL_CYCLES@ + cpu_core@L1D_PEND_MISS.=
L2_STALLS@) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
-        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_bottleneck_cache_memory_bandwidth, tma_info_system_dram_bw_use, =
tma_mem_bandwidth",
+        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tma_=
memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma_m=
em_bandwidth",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2469,8 +2632,8 @@
         "MetricExpr": "cpu_core@EXE_ACTIVITY.BOUND_ON_STORES@ / tma_info_t=
hread_clks",
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
 with: MEM_INST_RETIRED.ALL_STORES_PS",
+        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2479,18 +2642,18 @@
         "MetricExpr": "13 * cpu_core@LD_BLOCKS.STORE_FORWARD@ / tma_info_t=
hread_clks",
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricExpr": "(cpu_core@MEM_STORE_RETIRED.L2_HIT@ * 10 * (1 - cpu=
_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.ALL_STORES@)=
 + (1 - cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.A=
LL_STORES@) * min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO@)) / tma_info_thread_clks",
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
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2509,7 +2672,7 @@
         "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_hit",
-        "MetricThreshold": "tma_store_stlb_hit > 0.05 & (tma_dtlb_store > =
0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2)))",
+        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store > 0=
.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > =
0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2518,7 +2681,34 @@
         "MetricExpr": "cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@ / tma_info_=
core_core_clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_miss",
-        "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
+        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store > =
0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_1G@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.WALK=
_COMPLETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_1g",
+        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_2M_4M@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_=
core@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.W=
ALK_COMPLETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_2m",
+        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_4K@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.WALK=
_COMPLETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_4k",
+        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2527,7 +2717,7 @@
         "MetricExpr": "9 * cpu_core@OCR.STREAMING_WR.ANY_RESPONSE@ / tma_i=
nfo_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
         "MetricName": "tma_streaming_stores",
-        "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_streaming_stores > 0.2 & tma_store_bound >=
 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: tma=
_fb_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2537,7 +2727,7 @@
         "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / tma_info=
_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
         "MetricName": "tma_unknown_branches",
-        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_reste=
ers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2547,8 +2737,8 @@
         "MetricExpr": "tma_retiring * cpu_core@UOPS_EXECUTED.X87@ / cpu_co=
re@UOPS_EXECUTED.THREAD@",
         "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
         "MetricName": "tma_x87_use",
-        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
+        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma_l=
ight_operations > 0.6",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     }
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index 3f51686fe7a8..a20e19738046 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -91,6 +91,26 @@
         "UMask": "0x1f",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Modified cache lines that are evicted by L2 c=
ache when triggered by an L2 cache fill.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.NON_SILENT",
+        "PublicDescription": "Counts the number of lines that are evicted =
by L2 cache when triggered by an L2 cache fill. Those lines are in Modified=
 state. Modified lines are written back to L3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.SILENT",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
         "Counter": "0,1,2,3",
@@ -101,6 +121,15 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of L2 Cache accesses.=
 Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL",
+        "PublicDescription": "Counts the total number of L2 Cache Accesses=
, includes hits, misses, rejects  front door requests for CRd/DRd/RFO/ItoM/=
L2 Prefetches only.  Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES]",
         "Counter": "0,1,2,3",
@@ -111,6 +140,26 @@
         "UMask": "0xff",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of L2 Cache accesses that r=
esulted in a hit. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts the number of L2 Cache accesses that =
resulted in a hit from a front door request only (does not include rejects =
or recycles), Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 Cache accesses that r=
esulted in a miss. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "PublicDescription": "Counts the number of L2 Cache accesses that =
resulted in a miss from a front door request only (does not include rejects=
 or recycles). Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache. [Th=
is event is alias to L2_RQSTS.MISS]",
         "Counter": "0,1,2,3",
@@ -412,7 +461,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
         "SampleAfterValue": "1000003",
         "UMask": "0x81",
@@ -424,7 +472,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82",
@@ -436,7 +483,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
         "SampleAfterValue": "1000003",
         "UMask": "0x83",
@@ -448,7 +494,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with locked=
 access.",
         "SampleAfterValue": "100007",
         "UMask": "0x21",
@@ -460,7 +505,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x41",
@@ -472,7 +516,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
-        "PEBS": "1",
         "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x42",
@@ -484,7 +527,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x11",
@@ -496,7 +538,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
-        "PEBS": "1",
         "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x12",
@@ -518,7 +559,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
         "SampleAfterValue": "20011",
         "UMask": "0x4",
@@ -530,7 +570,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x2",
@@ -542,7 +581,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
         "SampleAfterValue": "20011",
         "UMask": "0x4",
@@ -554,7 +592,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
@@ -566,7 +603,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
@@ -578,7 +614,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x2",
@@ -590,7 +625,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
-        "PEBS": "1",
         "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -602,7 +636,6 @@
         "Data_LA": "1",
         "EventCode": "0xd4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
         "SampleAfterValue": "100007",
         "UMask": "0x4",
@@ -614,7 +647,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
@@ -626,7 +658,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
@@ -638,7 +669,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x8",
@@ -650,7 +680,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
@@ -662,7 +691,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
         "SampleAfterValue": "100021",
         "UMask": "0x10",
@@ -674,7 +702,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
         "SampleAfterValue": "100021",
         "UMask": "0x4",
@@ -686,7 +713,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
         "SampleAfterValue": "50021",
         "UMask": "0x20",
@@ -698,33 +724,90 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x80",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache, in which a snoop was required and modified data was for=
warded from another core or module.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
+        "SampleAfterValue": "200003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L1 data cache.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the L1 data cache.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L2 cache.",
         "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the L2 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache.",
         "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache, in which a snoop was required, and non-modified data wa=
s forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.HIT_E_F",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.L3_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
         "Counter": "0,1,2,3,4,5",
@@ -776,7 +859,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of load uops retired=
.",
         "SampleAfterValue": "200003",
         "UMask": "0x81",
@@ -788,7 +870,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of store uops retire=
d.",
         "SampleAfterValue": "200003",
         "UMask": "0x82",
@@ -802,7 +883,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 128 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
@@ -816,7 +896,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 16 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
@@ -830,7 +909,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 256 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
@@ -844,7 +922,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 32 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
@@ -858,7 +935,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 4 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
@@ -872,7 +948,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 512 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
@@ -886,7 +961,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 64 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
@@ -900,7 +974,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 8 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5",
@@ -912,7 +985,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x21",
         "Unit": "cpu_atom"
@@ -923,18 +995,46 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x41",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the total number of load and store uop=
s retired that missed in the second level TLB.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x13",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the second Level TLB.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x11",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of store ops retired that m=
iss in the second level TLB.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x12",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of stores uops retired. Cou=
nts with or without PEBS enabled.",
         "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of stores uops retired. Co=
unts with or without PEBS enabled. If PEBS is enabled and a PEBS record is =
generated, will populate PEBS Latency and PEBS Data Source fields according=
ly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
@@ -950,13 +1050,57 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and modified data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, but no data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and non-modified data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache.",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C0001",
+        "MSRValue": "0x1F803C0001",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1022,7 +1166,7 @@
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C0002",
+        "MSRValue": "0x1F803C0002",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1049,6 +1193,72 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, but no data was forwa=
rded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L3 =
cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C4000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L3 =
cache where a snoop was sent, the snoop hit, and modified data was forwarde=
d.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C4000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L3 =
cache where a snoop was sent, the snoop hit, but no data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C4000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L3 =
cache where a snoop was sent, the snoop hit, and non-modified data was forw=
arded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C4000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "OFFCORE_REQUESTS.ALL_REQUESTS",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json b=
/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
index b4621c221f58..62fd70f220e5 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
@@ -1,4 +1,13 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles the floating poin=
t divider is in the loop stage.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "ARITH.FPDIV_ACTIVE",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -9,6 +18,15 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of floating point divider u=
ops executed per cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts all microcode FP assists.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -187,7 +205,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.FPDIV",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/alderlake/frontend.json
index 66735a612ebd..c5b3818ad479 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
@@ -55,7 +55,6 @@
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x1",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -68,7 +67,6 @@
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x11",
-        "PEBS": "1",
         "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -81,7 +79,6 @@
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x14",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -94,7 +91,6 @@
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x12",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -107,7 +103,6 @@
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x13",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -120,7 +115,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600106",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -133,7 +127,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x608006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -146,7 +139,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x601006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -159,7 +151,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600206",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -172,7 +163,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x610006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -185,7 +175,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x100206",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -198,7 +187,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x602006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -211,7 +199,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600406",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -224,7 +211,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x620006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -237,7 +223,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x604006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -250,7 +235,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600806",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -263,7 +247,6 @@
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
-        "PEBS": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -275,7 +258,6 @@
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x15",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -288,7 +270,6 @@
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x17",
-        "PEBS": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
         "Unit": "cpu_core"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index 81a03f53aadc..fa15f5797bed 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -133,7 +133,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency.",
         "SampleAfterValue": "53",
         "UMask": "0x1",
@@ -147,7 +146,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "1009",
         "UMask": "0x1",
@@ -161,7 +159,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
@@ -175,7 +172,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "503",
         "UMask": "0x1",
@@ -189,7 +185,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -203,7 +198,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
@@ -217,7 +211,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "101",
         "UMask": "0x1",
@@ -231,7 +224,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "2003",
         "UMask": "0x1",
@@ -245,7 +237,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
         "UMask": "0x1",
@@ -257,12 +248,22 @@
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
-        "PEBS": "2",
         "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84400004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3,4,5",
@@ -329,6 +330,17 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were not supplied by the=
 L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84404000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json b/t=
ools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
index b54a5fc0861f..855585fe6fae 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
@@ -41,6 +41,7 @@
     "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "Load_Store_Miss": "Grouping from Top-down Microarchitecture Analysis =
Metrics spreadsheet",
+    "LockCont": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "MachineClears": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
     "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -89,7 +90,9 @@
     "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
     "tma_branch_mispredicts_group": "Metrics contributing to tma_branch_mi=
spredicts category",
     "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
+    "tma_code_stlb_miss_group": "Metrics contributing to tma_code_stlb_mis=
s category",
     "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
+    "tma_divider_group": "Metrics contributing to tma_divider category",
     "tma_dram_bound_group": "Metrics contributing to tma_dram_bound catego=
ry",
     "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load category=
",
     "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store catego=
ry",
@@ -99,6 +102,7 @@
     "tma_fp_vector_group": "Metrics contributing to tma_fp_vector category=
",
     "tma_frontend_bound_group": "Metrics contributing to tma_frontend_boun=
d category",
     "tma_heavy_operations_group": "Metrics contributing to tma_heavy_opera=
tions category",
+    "tma_icache_misses_group": "Metrics contributing to tma_icache_misses =
category",
     "tma_ifetch_bandwidth_group": "Metrics contributing to tma_ifetch_band=
width category",
     "tma_ifetch_latency_group": "Metrics contributing to tma_ifetch_latenc=
y category",
     "tma_int_operations_group": "Metrics contributing to tma_int_operation=
s category",
@@ -121,10 +125,13 @@
     "tma_issueSpSt": "Metrics related by the issue $issueSpSt",
     "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
     "tma_issueTLB": "Metrics related by the issue $issueTLB",
+    "tma_itlb_misses_group": "Metrics contributing to tma_itlb_misses cate=
gory",
     "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
+    "tma_l2_bound_group": "Metrics contributing to tma_l2_bound category",
     "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
     "tma_load_op_utilization_group": "Metrics contributing to tma_load_op_=
utilization category",
+    "tma_load_stlb_miss_group": "Metrics contributing to tma_load_stlb_mis=
s category",
     "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
     "tma_mem_latency_group": "Metrics contributing to tma_mem_latency cate=
gory",
     "tma_memory_bound_group": "Metrics contributing to tma_memory_bound ca=
tegory",
@@ -138,5 +145,6 @@
     "tma_retiring_group": "Metrics contributing to tma_retiring category",
     "tma_serializing_operation_group": "Metrics contributing to tma_serial=
izing_operation category",
     "tma_store_bound_group": "Metrics contributing to tma_store_bound cate=
gory",
-    "tma_store_op_utilization_group": "Metrics contributing to tma_store_o=
p_utilization category"
+    "tma_store_op_utilization_group": "Metrics contributing to tma_store_o=
p_utilization category",
+    "tma_store_stlb_miss_group": "Metrics contributing to tma_store_stlb_m=
iss category"
 }
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index f95e093f8fcf..a8b23e92408c 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -1,9 +1,10 @@
 [
     {
-        "BriefDescription": "ASSISTS.HARDWARE",
+        "BriefDescription": "Count all other hardware assists or traps tha=
t are not necessarily architecturally exposed (through a software handler) =
beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-eve=
nts. the event also counts for Machine Ordering count.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.HARDWARE",
+        "PublicDescription": "Count all other hardware assists or traps th=
at are not necessarily architecturally exposed (through a software handler)=
 beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-ev=
ents.  This includes, but not limited to, assists at EXE or MEM uop writeba=
ck like AVX* load/store/gather/scatter (non-FP GSSE-assist ) , assists gene=
rated by ROB like PEBS and RTIT, Uncore trap, RAR (Remote Action Request) a=
nd CET (Control flow Enforcement Technology) assists. the event also counts=
 for Machine Ordering count.",
         "SampleAfterValue": "100003",
         "UMask": "0x4",
         "Unit": "cpu_core"
@@ -50,7 +51,6 @@
         "Deprecated": "1",
         "EventCode": "0xe4",
         "EventName": "LBR_INSERTS.ANY",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -66,6 +66,28 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x784000004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
         "Counter": "0,1,2,3,4,5",
@@ -88,6 +110,17 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x784000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
         "Counter": "0,1,2,3",
@@ -121,6 +154,39 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x784000002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.FULL_STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x800000010000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.PARTIAL_STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x400000010000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3,4,5",
@@ -143,6 +209,28 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that have any type of respons=
e.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x14000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by DRAM.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x784004000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index b7656f77dee9..f5bf0816f190 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -10,6 +10,16 @@
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point or integer dividers are active.",
+        "Counter": "0,1,2,3,4,5",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -21,6 +31,24 @@
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of active floating point an=
d integer dividers per cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point and integ=
er divider uops executed per cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.FPDIV_ACTIVE",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -32,6 +60,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of cycles any of the two in=
teger dividers are active.",
+        "Counter": "0,1,2,3,4,5",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts the cycles the integer divi=
der is busy.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -42,6 +80,24 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of active integer dividers =
per cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of integer divider uops exe=
cuted per cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.IDIV_ACTIVE",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -68,7 +124,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
@@ -78,7 +133,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts all branch instructions retired.",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
@@ -89,7 +143,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf9",
         "Unit": "cpu_atom"
@@ -99,7 +152,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x7e",
         "Unit": "cpu_atom"
@@ -109,7 +161,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PEBS": "1",
         "PublicDescription": "Counts conditional branch instructions retir=
ed.",
         "SampleAfterValue": "400009",
         "UMask": "0x11",
@@ -120,7 +171,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts not taken branch instructions retired=
.",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
@@ -131,7 +181,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfe",
         "Unit": "cpu_atom"
@@ -141,7 +190,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
@@ -152,7 +200,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xbf",
         "Unit": "cpu_atom"
@@ -162,7 +209,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PEBS": "1",
         "PublicDescription": "Counts far branch instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
@@ -173,7 +219,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xeb",
         "Unit": "cpu_atom"
@@ -183,7 +228,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PEBS": "1",
         "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
@@ -194,7 +238,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb",
         "Unit": "cpu_atom"
@@ -205,7 +248,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb",
         "Unit": "cpu_atom"
@@ -216,7 +258,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.JCC",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x7e",
         "Unit": "cpu_atom"
@@ -226,7 +267,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf9",
         "Unit": "cpu_atom"
@@ -236,7 +276,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PEBS": "1",
         "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x2",
@@ -247,7 +286,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf7",
         "Unit": "cpu_atom"
@@ -257,7 +295,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PEBS": "1",
         "PublicDescription": "Counts return instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
@@ -268,7 +305,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xc0",
         "Unit": "cpu_atom"
@@ -278,7 +314,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken branch instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
@@ -290,7 +325,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xeb",
         "Unit": "cpu_atom"
@@ -300,7 +334,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfd",
         "Unit": "cpu_atom"
@@ -311,7 +344,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.RETURN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf7",
         "Unit": "cpu_atom"
@@ -322,7 +354,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfe",
         "Unit": "cpu_atom"
@@ -332,7 +363,6 @@
         "Counter": "0,1,2,3,4,5",
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
         "SampleAfterValue": "200003",
         "Unit": "cpu_atom"
@@ -342,7 +372,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
@@ -352,7 +381,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x7e",
         "Unit": "cpu_atom"
@@ -362,7 +390,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PEBS": "1",
         "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x11",
@@ -373,7 +400,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
@@ -384,7 +410,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfe",
         "Unit": "cpu_atom"
@@ -394,7 +419,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
@@ -405,7 +429,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xeb",
         "Unit": "cpu_atom"
@@ -415,7 +438,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PEBS": "1",
         "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
@@ -426,7 +448,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb",
         "Unit": "cpu_atom"
@@ -436,7 +457,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
         "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
         "SampleAfterValue": "400009",
         "UMask": "0x2",
@@ -448,7 +468,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb",
         "Unit": "cpu_atom"
@@ -459,7 +478,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.JCC",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x7e",
         "Unit": "cpu_atom"
@@ -469,7 +487,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x80",
         "Unit": "cpu_atom"
@@ -479,7 +496,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
@@ -491,7 +507,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xeb",
         "Unit": "cpu_atom"
@@ -501,7 +516,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PEBS": "1",
         "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
@@ -512,7 +526,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RETURN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf7",
         "Unit": "cpu_atom"
@@ -523,7 +536,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfe",
         "Unit": "cpu_atom"
@@ -616,6 +628,16 @@
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
CPU_CLK_UNHALTED.REF_TSC_P",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Core crystal clock cycles. Cycle counts are e=
venly distributed between active threads in the Core.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -854,7 +876,6 @@
         "BriefDescription": "Counts the total number of instructions retir=
ed. (Fixed event)",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses fixed counter 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
@@ -864,7 +885,6 @@
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
@@ -875,7 +895,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses a programmable general purpose performance counter.",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_atom"
@@ -885,7 +904,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
@@ -895,7 +913,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -905,7 +922,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired NOP or ENDBR32/64 instruc=
tions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
@@ -915,7 +931,6 @@
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
-        "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
@@ -926,7 +941,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PEBS": "1",
         "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
@@ -1065,7 +1079,6 @@
         "Deprecated": "1",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_atom"
@@ -1075,7 +1088,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x4",
         "Unit": "cpu_atom"
@@ -1095,7 +1107,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1244,7 +1255,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of LBR entries recorded. R=
equires LBRs to be enabled in IA32_LBR_CTL. This event is PDIR on GP0 and N=
PEBS on all other GPs [This event is alias to LBR_INSERTS.ANY]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
@@ -1551,7 +1561,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "TOPDOWN_RETIRING.ALL",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "Unit": "cpu_atom"
     },
@@ -1799,7 +1808,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.ALL",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_atom"
     },
@@ -1829,7 +1837,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.IDIV",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_atom"
@@ -1839,7 +1846,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of uops that are from comp=
lex flows issued by the Microcode Sequencer (MS). This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
@@ -1895,7 +1901,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
index e0d8f3070778..132ce48af6d9 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
@@ -258,5 +258,38 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x90",
         "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
MEM_UOPS_RETIRED.STLB_MISS",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "Deprecated": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x13",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "Deprecated": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x11",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "Deprecated": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x12",
+        "Unit": "cpu_atom"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index d503aa7e3594..d9538723927b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,5 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.27,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.28,alderlake,core
 GenuineIntel-6-BE,v1.27,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v29,broadwell,core
--=20
2.48.1.502.g6dc24dfdaf-goog


