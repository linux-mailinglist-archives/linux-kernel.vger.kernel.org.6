Return-Path: <linux-kernel+bounces-340879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB9C9878AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDB71C2033D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55FF1779BC;
	Thu, 26 Sep 2024 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLYe09xZ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59F8183CBC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373062; cv=none; b=Rwm5sNGZaLz+SPk8qW0p9S36R1Ci/U6mKe9DLjAC3PbXwy4dgR72VaI2IHBrJcgIF397Yr+GlPvnBvs3m2Sc33jFUQfz41t8Aa+PPHnUtvQhJGq1K8hsNvT3VPFrGJg8PKpvleNznYrlJpREugbnBanXtdItWxwzG+0FiKGj3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373062; c=relaxed/simple;
	bh=WRG26UolNI3eAQ1/IExBOEAbZGEqObSefqeahUG4NTo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iKBgvtOq2A/YNfv2XPy05JOAuCJ3ls/UpCqIkPSM/u+2MSdIdyz9toPKPpEIXiSstwTcL/NmarJTlVwZm/U/zsj0X2bpU3FJ4Zs2Cs7q3Wdzji9NFvfEUlJtANqKEmwXj1vPEmGLajjsaSBcL4SlY20gBPnYAJLdLIy0aBrO54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLYe09xZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so2014151276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373060; x=1727977860; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOPZJZE57IMCcyt+nGiK9z91olZDkPDca+05FDhUtQc=;
        b=RLYe09xZhlAvSJPPrRQzpK0TYjKsTxNryVf6ybw0+IWanm6kDq+nYiqgMaZvQrUjnV
         JcQ5bPjXvuy0rQw3W0OVAdDqOm6JWRDt60fTbftjdyphAcRIlt18rYROS4Q0yzMqELQT
         sLKDZmDdxP4DI66uHVq8fNwS+d9zFNvzSt2IK6LFcSgjJ0O5hXIUiPxUje/A6K210D96
         Jn6pSH+xtijgXPqLxhuHrlvNss4IOYLgzLGt+bQKnYTTLoh7y6h+whBD/1QA3awpUxTX
         HC1wzCdXgnBR/To/0OqR8jKJoEA9Y8pU/Wl+hv48k/sJ98ngeGlDVMaCxk+Ahy5b4PzI
         Qf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373060; x=1727977860;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOPZJZE57IMCcyt+nGiK9z91olZDkPDca+05FDhUtQc=;
        b=JoAQ/feTqx7cNmhGTZHC1nLWNSOz8GZrXuDhtcyrqOmnz665j8Rr/sGPy+THBheK44
         qZ3eB/COlj/M5yfpFOcEIbDyqeL4pN6lVrNbdacDkh5F4wwBPaKiOSDjxC3xUD6EzAoc
         4Hur9vsluB6p1CiBBP1hYLZXfwxMG93ZfvgF70AZjQ7oiIihsSJuLCbHwmduiO0XWyMM
         6oYRJvjHtoDoPAl8Z74Z5OOYczmRxmeTQMux0SzCP9zOGELcWlM3Dhhbo27esOAaPJXK
         vNkTCrjmieNCn37mntCh1VLkbEMSziyyxd/Ls+YlogXbonnSIT7gyEJgTOTEIodzbL81
         NMcA==
X-Forwarded-Encrypted: i=1; AJvYcCWZuAKLjn0/BSRzzGhRs/tz2RidpBX8ZkrRtT6dAOyNwfpl4iJtZJIMBnHT1+x7Gub6cyfnsN1a4HcBHtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyidvkEA99FIQ87ltPvXEDLfDmaFzdULzKY8cUVHcC7YxrPE2bI
	p2MC6+2z/utCv+6rA8taTJedDtzytOO3Yzyiflkx5/UclC8OeXekjElT7TImj3ljNjiIklZNWPX
	TL5pu3w==
X-Google-Smtp-Source: AGHT+IEJwjm+BcnpbRABaB1e+69eKV4Gk4sVgTf582woRm14JxLYKLCfSPWRX8bFjucXwLrcGBwJa++4jDOf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:6902:1363:b0:e0b:fe07:1e22 with SMTP
 id 3f1490d57ef6-e2604b109cdmr221276.1.1727373059729; Thu, 26 Sep 2024
 10:50:59 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:20 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 07/22] perf jevents: Add br metric group for branch
 statistics on Intel
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. Conditional taken and not taken metrics are specific to
Icelake and later generations, so the presence of the event is used to
determine whether the metric should exist.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 138 +++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 58e243695f0a..09f7b7159e7c 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -123,6 +123,143 @@ def Tsx() -> Optional[MetricGroup]:
   ], description="Breakdown of transactional memory statistics")
 
 
+def IntelBr():
+  ins = Event("instructions")
+
+  def Total() -> MetricGroup:
+    br_all = Event ("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+    br_m_all = Event("BR_MISP_RETIRED.ALL_BRANCHES",
+                     "BR_INST_RETIRED.MISPRED",
+                     "BR_MISP_EXEC.ANY")
+    br_clr = None
+    try:
+      br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
+    except:
+      pass
+
+    br_r = d_ratio(br_all, interval_sec)
+    ins_r = d_ratio(ins, br_all)
+    misp_r = d_ratio(br_m_all, br_all)
+    clr_r = d_ratio(br_clr, interval_sec) if br_clr else None
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
+               "The number of resync branches per second.", clr_r, "req/s"
+               ) if clr_r else None
+    ])
+
+  def Taken() -> MetricGroup:
+    br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+    br_m_tk = None
+    try:
+      br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
+                      "BR_MISP_RETIRED.TAKEN_JCC",
+                      "BR_INST_RETIRED.MISPRED_TAKEN")
+    except:
+      pass
+    br_r = d_ratio(br_all, interval_sec)
+    ins_r = d_ratio(ins, br_all)
+    misp_r = d_ratio(br_m_tk, br_all) if br_m_tk else None
+    return MetricGroup("br_taken", [
+        Metric("br_taken_retired",
+               "The number of taken branches that were retired per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_taken_mispred",
+            "The number of retired taken branch instructions that were "
+            "mispredicted as a percentage of all taken branches.", misp_r,
+            "100%") if misp_r else None,
+        Metric(
+            "br_taken_insn_between_branches",
+            "The number of instructions divided by the number of taken branches.",
+            ins_r, "insn"),
+    ])
+
+  def Conditional() -> Optional[MetricGroup]:
+    try:
+      br_cond = Event("BR_INST_RETIRED.COND",
+                      "BR_INST_RETIRED.CONDITIONAL",
+                      "BR_INST_RETIRED.TAKEN_JCC")
+      br_m_cond = Event("BR_MISP_RETIRED.COND",
+                        "BR_MISP_RETIRED.CONDITIONAL",
+                        "BR_MISP_RETIRED.TAKEN_JCC")
+    except:
+      return None
+
+    br_cond_nt = None
+    br_m_cond_nt = None
+    try:
+      br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
+      br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
+    except:
+      pass
+    br_r = d_ratio(br_cond, interval_sec)
+    ins_r = d_ratio(ins, br_cond)
+    misp_r = d_ratio(br_m_cond, br_cond)
+    taken_metrics = [
+        Metric("br_cond_retired", "Retired conditional branch instructions.",
+               br_r, "insn/s"),
+        Metric("br_cond_insn_between_branches",
+               "The number of instructions divided by the number of conditional "
+               "branches.", ins_r, "insn"),
+        Metric("br_cond_mispred",
+               "Retired conditional branch instructions mispredicted as a "
+               "percentage of all conditional branches.", misp_r, "100%"),
+    ]
+    if not br_m_cond_nt:
+      return MetricGroup("br_cond", taken_metrics)
+
+    br_r = d_ratio(br_cond_nt, interval_sec)
+    ins_r = d_ratio(ins, br_cond_nt)
+    misp_r = d_ratio(br_m_cond_nt, br_cond_nt)
+
+    not_taken_metrics = [
+        Metric("br_cond_retired", "Retired conditional not taken branch instructions.",
+               br_r, "insn/s"),
+        Metric("br_cond_insn_between_branches",
+               "The number of instructions divided by the number of not taken conditional "
+               "branches.", ins_r, "insn"),
+        Metric("br_cond_mispred",
+               "Retired not taken conditional branch instructions mispredicted as a "
+               "percentage of all not taken conditional branches.", misp_r, "100%"),
+    ]
+    return MetricGroup("br_cond", [
+        MetricGroup("br_cond_nt", not_taken_metrics),
+        MetricGroup("br_cond_tkn", taken_metrics),
+    ])
+
+  def Far() -> Optional[MetricGroup]:
+    try:
+      br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
+    except:
+      return None
+
+    br_r = d_ratio(br_far, interval_sec)
+    ins_r = d_ratio(ins, br_far)
+    return MetricGroup("br_far", [
+        Metric("br_far_retired", "Retired far control transfers per second.",
+               br_r, "insn/s"),
+        Metric(
+            "br_far_insn_between_branches",
+            "The number of instructions divided by the number of far branches.",
+            ins_r, "insn"),
+    ])
+
+  return MetricGroup("br", [Total(), Taken(), Conditional(), Far()],
+                     description="breakdown of retired branch instructions")
+
+
 def main() -> None:
   global _args
 
@@ -150,6 +287,7 @@ def main() -> None:
       Rapl(),
       Smi(),
       Tsx(),
+      IntelBr(),
   ])
 
 
-- 
2.46.1.824.gd892dcdcdd-goog


