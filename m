Return-Path: <linux-kernel+bounces-340862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBD987885
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB78D2840DA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F97185628;
	Thu, 26 Sep 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aid6H5If"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3B184536
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372495; cv=none; b=VQ2SyhIkkvYSx/ev2gZLrOj25hVvP5Rg8kYoz3bDlwyTR3JG8c2x2Xj06n/026sWq64XI9VrLdFfO5cd9AalVJqjpG7pw1sAllpXlLu4qpHYiXyxf48dhqHOSpXm0fmyr7tDDJG/8gAlpkZnh6oMu4PQ+SWF9h71r8ONKpvgVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372495; c=relaxed/simple;
	bh=K/jiKAwRweoGx0aTcBHH9j1TH/iJEAjDKpYsOlwIc9Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=anWhT7NSIMaE92kgtPdV1RA8J5L+NmemosOb7TGwy29Uh2jpYb/CwrnerH2eA46pvnP6cM94O7dX2lMIDK/S7jDYtD44XQQzwlGfnXi3b3ggmwDASI4RgREtzWwWFPFjlsOdSbsK/Jo2RrgcOQiCp2q+Y/s/K2m/wJlRfik8Jtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aid6H5If; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e22f8dc491so24011317b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372492; x=1727977292; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cf7ix5Y+Lag3VYllVRhzhpidoquSyLIg5S10xVo9qlg=;
        b=Aid6H5IfqJwolpznK1DTVPJgqFPYIJu516W2a4DZGS/VzUWm/gTnJk3QgsRnHm+xMK
         uuVuny32ozB4kAXFY9OtLTcty7sAzfh7RL5mptoCwfFnbmgxTdp1eoq0p9Dvkn2BI/Sz
         pSCirxXxRjnNlmK0o+CxZhnaL9yev/nx74Aimu+8LUPk04exDitblt5ilDW18NiNlnog
         aZoIwVg9qsEpS54kMYlhPgfSUY3hdnWpHg5D8o50mPwIMJRXC54LU9rhz6mYus5r5jGw
         SmhcwFlVII5IxNT2DJibcQrOFAGBtNr7fJah2UIp3ohtbCQZHivqEL4TAc7g359r/CyO
         wLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372492; x=1727977292;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cf7ix5Y+Lag3VYllVRhzhpidoquSyLIg5S10xVo9qlg=;
        b=Et5WQf5gCBo+0lCXs0IVx/RQZRnvYr8O/eLRoJ9qk6Cvihs8QjYGZoEVeC0H2JrLnr
         Eq3Nn29Tjw19BiOQaICU1Pt1i9dxdGq2zM+I+uej1V+B5S+iwNdqKxLfVygough6jiih
         RRjbftRf3dKen+xXaXAoi9IEKbTn/QNS8jOMlDk5SjRHCANOlOqBNFFpP37r1e88Zv3t
         yZEEItBTCe2mp5E209FhSB+27/eGo2pYjAdvrTSvvc/Z959HUYjrMRtLX0dYGgn6Yfs7
         qcsR0L/rRZVL2ThsfaHPpLwOcNqdnjJvPrkATE60X4gs8MUJrHiQ9Jk23jeMD0FJX3LF
         123A==
X-Forwarded-Encrypted: i=1; AJvYcCUDKt6eV8AQcw2p6tTxorGNDy67Ag7HuOCXiHXeXMzI4GDG2wd+KUDVIlIoK4CJ4iWw+36Lau+DO5JxVjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMpCULJ0EQx0s8ioUxtsnIXyvTOX0o8gH2wZYGmQruwMOQnxW
	00ZLlek8TAgjpQhzOOzNhXkJoL3L2OWIhPShEtdnZreKFnUSHbA4Z2xtmoqcgplTWPqfm9T1pdp
	fttWlMw==
X-Google-Smtp-Source: AGHT+IFuG1pb+eKRdisndlRJxT2BMDa2/AOVyyR83C/baLsHv4Icy8axfNvP6jDE2JYM0D1Qmi6ktjq7wC1f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:68d1:0:b0:e25:d202:d376 with SMTP id
 3f1490d57ef6-e2604b851e8mr76276.6.1727372492118; Thu, 26 Sep 2024 10:41:32
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:59 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 10/12] perf jevents: Add load store breakdown metrics ldst
 for AMD
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index af99da14d946..3f77d1bbf1c9 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -275,6 +275,80 @@ def AmdItlb():
   ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+  ldst_ld = Event("ls_dispatch.ld_dispatch")
+  ldst_st = Event("ls_dispatch.store_dispatch")
+  ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
+  ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
+  ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
+  ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
+  ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
+  ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
+  ldst_cyc = Event("ls_not_halted_cyc")
+
+  ld_rate = d_ratio(ldst_ld, interval_sec)
+  st_rate = d_ratio(ldst_st, interval_sec)
+
+  ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
+  ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
+  ld_v3 = ldst_ldc3
+
+  st_v1 = max(ldst_stc1 - ldst_stc2, 0)
+  st_v2 = max(ldst_stc2 - ldst_stc3, 0)
+  st_v3 = ldst_stc3
+
+  return MetricGroup("ldst", [
+      MetricGroup("ldst_total", [
+          Metric("ldst_total_ld", "Number of loads dispatched per second.",
+                 ld_rate, "insns/sec"),
+          Metric("ldst_total_st", "Number of stores dispatched per second.",
+                 st_rate, "insns/sec"),
+      ]),
+      MetricGroup("ldst_percent_insn", [
+          Metric("ldst_percent_insn_ld",
+                 "Load instructions as a percentage of all instructions.",
+                 d_ratio(ldst_ld, ins), "100%"),
+          Metric("ldst_percent_insn_st",
+                 "Store instructions as a percentage of all instructions.",
+                 d_ratio(ldst_st, ins), "100%"),
+      ]),
+      MetricGroup("ldst_ret_loads_per_cycle", [
+          Metric(
+              "ldst_ret_loads_per_cycle_1",
+              "Load instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_loads_per_cycle_2",
+              "Load instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_loads_per_cycle_3",
+              "Load instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("ldst_ret_stores_per_cycle", [
+          Metric(
+              "ldst_ret_stores_per_cycle_1",
+              "Store instructions retiring in 1 cycle as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_stores_per_cycle_2",
+              "Store instructions retiring in 2 cycles as a percentage of all "
+              "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
+          Metric(
+              "ldst_ret_stores_per_cycle_3",
+              "Store instructions retiring in 3 or more cycles as a percentage"
+              "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
+      ]),
+      MetricGroup("ldst_insn_bt", [
+          Metric("ldst_insn_bt_ld", "Number of instructions between loads.",
+                 d_ratio(ins, ldst_ld), "insns"),
+          Metric("ldst_insn_bt_st", "Number of instructions between stores.",
+                 d_ratio(ins, ldst_st), "insns"),
+      ])
+  ], description="Breakdown of load/store instructions")
+
+
 def AmdHwpf():
   """Returns a MetricGroup representing AMD hardware prefetch metrics."""
   global _zen_model
@@ -512,6 +586,7 @@ def main() -> None:
       AmdBr(),
       AmdDtlb(),
       AmdItlb(),
+      AmdLdSt(),
       AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
-- 
2.46.1.824.gd892dcdcdd-goog


