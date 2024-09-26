Return-Path: <linux-kernel+bounces-340856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DF598787F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC4A280AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FBD16EC19;
	Thu, 26 Sep 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJc6+4Cf"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF0165EFA
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372480; cv=none; b=C/R9nN7d50iU4wYnJh+V32i7Pa/cYciA00QmjkVtJuEWPxlkVXn+wHqtru9vlcRChm/bjr8JtZIdA/gau9BaUHug12gFfMpHrLqPER8QWta0mOQ2wAy9kqYtWA8+vY82zWz8+/ECr14n1gzZDQ/OJCkR78qDDc4J0I4nwAB9TvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372480; c=relaxed/simple;
	bh=9hrxWnZGip7MonPWzLEFlv+nIKvX8o60QS/IYvOdUl8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PTb9RlhDbs0bzTfRc3OK4x5AVQ0g2Cl5B3p7v+uHFo/PCCjAtd2MFSvumPESSIsG818p/chnqRTt2fNGq4FIEAT4wF+NNxTVqdx9Ghuq43z7TVJDIZzgUQT6J+JKZPT+O1ehUytSe8K+yHktLlsF1ICYei11attweB+tNDJRUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJc6+4Cf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2364f45a4so9853967b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372478; x=1727977278; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHSqYKjM7ByFs31IrmG73id5xHFbMBignLL1LQ8zJbM=;
        b=zJc6+4Cfh8+mlQebg63sCKV6zqBqiOj5A7em5mZjA8oGwb4fVvtK8L1g1jBx3IKzfx
         /0GR6n1fcwnISuaOV6S7+fSzHr7ZCpKlXi02Dk/3LmMsgRRQVsw/NDb5Jh/C0vZ7Nste
         W5S+b5hZkDsAfu2DWvHGWi6IvK+5/daD8kQqiBfLB00lVjPOQXPJbrJLUwyqR40HYQlb
         jDrg5ri7PVxAzPqUvl19EO0tsJRw5ArDz0I6tQLL6vpZsgHmsmIofdttfUh3sAJflxyt
         sfhisJmQ+vA8p1EJYLSZtQvLgQ7Vuyb/bIB6jkG5OOFo3YRqnCnlwI7t6HLWCSjCQYfj
         iSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372478; x=1727977278;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHSqYKjM7ByFs31IrmG73id5xHFbMBignLL1LQ8zJbM=;
        b=dV9Qt2kJxZJd1i0WxiNxWnOqB6Rs3J/riDbNrlFK+kzev4LDplMRmi4QBL9GTGKOu+
         3/FHX7HEqbwBAvAvgyXgyj0Ee8dvWCjPYopnUEJHwaDioKZWC4JCOwUKsTwXADeAnSgH
         mWtcILgNe9iURj5APydwGd391Hf5WqmVC1faRWKzyK+XNDWKAIoNNqHE1hySmczh6+ba
         Ain9aolAxVCZ4DycUvq9FKybYYShyz2sKPYexwfTl9doZ1cITXksy5hDFf3DQ5YlaDaI
         5CamUABZWQpTkfdHndBVUV17SosQpgXaFWL6Nuw0iF1qSQSTqa/ufG/tAZL+8cHwhpIz
         Nowg==
X-Forwarded-Encrypted: i=1; AJvYcCWVdRNgxRsFl84gxU11E830TZtXx4vK17djBUCK029IjGOUzVRJlmRfX1OjMUj8q+oXJr257fF134ar9jE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7klQ8Re7Xx66XwYt10Mq3k9iqrwlXyoJfoYbfeicFOcQt/QG9
	6fTtSqezXtZ+6UBwMqEuFLTJOJw72FJ7lVbzrY7kHIwMaMkzDZv10g0zICIZ4kAnnZvGcKiLTZH
	bhMwwnA==
X-Google-Smtp-Source: AGHT+IExpr5ovp4VlhNqf2cP6F5+j7pLD3Af3qh81ACc2fEJTcBdeZ/NEOEJv4QinX6x+LzZhDqY3xZvd+YP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:690c:700d:b0:6db:c3b8:c4ce with SMTP
 id 00721157ae682-6e24762237cmr56167b3.7.1727372477736; Thu, 26 Sep 2024
 10:41:17 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:53 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 04/12] perf jevents: Add br metric group for branch
 statistics on AMD
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. The lack of conditional events on anything but zen2 means this
category is lacking on zen1, zen3 and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 105 +++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index c64470d4822e..90545d4862a6 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -7,15 +7,119 @@ import argparse
 import json
 import math
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
 _zen_model: int = 1
 interval_sec = Event("duration_time")
+ins = Event("instructions")
 cycles = Event("cycles")
 # Number of CPU cycles scaled for SMT.
 smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
 
+def AmdBr():
+  def Total() -> MetricGroup:
+    br = Event("ex_ret_brn")
+    br_m_all = Event("ex_ret_brn_misp")
+    br_clr = Event("ex_ret_msprd_brnch_instr_dir_msmtch", "ex_ret_brn_resync")
+
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    misp_r = d_ratio(br_m_all, br)
+    clr_r = d_ratio(br_clr, interval_sec)
+
+    return MetricGroup("br_total", [
+        Metric("br_total_retired",
+               "The number of branch instructions retired per second.", br_r,
+               "insn/s"),
+        Metric(
+            "br_total_mispred",
+            "The number of branch instructions retired, of any type, that were "
+            "not correctly predicted as a percentage of all branch instrucions.",
+            misp_r, "100%"),
+        Metric("br_total_insn_between_branches",
+               "The number of instructions divided by the number of branches.",
+               ins_r, "insn"),
+        Metric("br_total_insn_fe_resteers",
+               "The number of resync branches per second.", clr_r, "req/s")
+    ])
+
+  def Taken() -> MetricGroup:
+    br = Event("ex_ret_brn_tkn")
+    br_m_tk = Event("ex_ret_brn_tkn_misp")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    misp_r = d_ratio(br_m_tk, br)
+    return MetricGroup("br_taken", [
+        Metric("br_taken_retired",
+               "The number of taken branches that were retired per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_taken_mispred",
+            "The number of retired taken branch instructions that were "
+            "mispredicted as a percentage of all taken branches.", misp_r,
+            "100%"),
+        Metric(
+            "br_taken_insn_between_branches",
+            "The number of instructions divided by the number of taken branches.",
+            ins_r, "insn"),
+    ])
+
+  def Conditional() -> Optional[MetricGroup]:
+    global _zen_model
+    br = Event("ex_ret_cond")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+
+    metrics = [
+        Metric("br_cond_retired", "Retired conditional branch instructions.",
+               br_r, "insn/s"),
+        Metric("br_cond_insn_between_branches",
+               "The number of instructions divided by the number of conditional "
+               "branches.", ins_r, "insn"),
+    ]
+    if _zen_model == 2:
+      br_m_cond = Event("ex_ret_cond_misp")
+      misp_r = d_ratio(br_m_cond, br)
+      metrics += [
+          Metric("br_cond_mispred",
+                 "Retired conditional branch instructions mispredicted as a "
+                 "percentage of all conditional branches.", misp_r, "100%"),
+      ]
+
+    return MetricGroup("br_cond", metrics)
+
+  def Fused() -> MetricGroup:
+    br = Event("ex_ret_fused_instr", "ex_ret_fus_brnch_inst")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    return MetricGroup("br_cond", [
+        Metric("br_fused_retired",
+               "Retired fused branch instructions per second.", br_r, "insn/s"),
+        Metric(
+            "br_fused_insn_between_branches",
+            "The number of instructions divided by the number of fused "
+            "branches.", ins_r, "insn"),
+    ])
+
+  def Far() -> MetricGroup:
+    br = Event("ex_ret_brn_far")
+    br_r = d_ratio(br, interval_sec)
+    ins_r = d_ratio(ins, br)
+    return MetricGroup("br_far", [
+        Metric("br_far_retired", "Retired far control transfers per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_far_insn_between_branches",
+            "The number of instructions divided by the number of far branches.",
+            ins_r, "insn"),
+    ])
+
+  return MetricGroup("br", [Total(), Taken(), Conditional(), Fused(), Far()],
+                     description="breakdown of retired branch instructions")
+
+
 def AmdUpc() -> Metric:
   ops = Event("ex_ret_ops", "ex_ret_cops")
   upc = d_ratio(ops, smt_cycles)
@@ -78,6 +182,7 @@ def main() -> None:
   _zen_model = int(_args.model[6:])
 
   all_metrics = MetricGroup("", [
+      AmdBr(),
       AmdUpc(),
       Idle(),
       Rapl(),
-- 
2.46.1.824.gd892dcdcdd-goog


