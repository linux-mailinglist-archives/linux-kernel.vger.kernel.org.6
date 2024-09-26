Return-Path: <linux-kernel+bounces-340886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FB19878B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FCA2824F5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970AE171088;
	Thu, 26 Sep 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wvhm/Fsf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735E216F839
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373078; cv=none; b=AxJquPWzqqNigJlc8gVkV0q4RsoEyGERo/vaq37me9TNli/Wru+8Uy31ESv2yxsDLFR9UDrTVMeAcW2RIMNINIylhQDzAW1jwrQcaqDS9YKDkVw3YqmXo/cWGBDcbr4pC04BpTlO2Vzqjfly07EBbLo2NfWk3SVspHkfGxfusFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373078; c=relaxed/simple;
	bh=a2C2DEYeeC0JRttDkbCQGloUW891/rcR9JHhku2TjOA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ODA8BrW13V+jPfAXSpJArDd3VAG9P33SYOcRVnfNTcbPVNtXu3Fh1Y1QLiexzRxwl+3f2yODOsBBSIvA3kxRrQ5pgMcH3YepNGIM/c+ljnJHp/2zISYOlfPXAWdxRIH1TWWKyAGT8cGFVSQ1NGmTrcBiJ51wKbDGyvDbq7ieuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wvhm/Fsf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25d494faa4so740259276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373076; x=1727977876; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTtHCqLrWS9wifwWZYlofn019VV7+dUOgk7GQL5znTY=;
        b=Wvhm/Fsf+Ar7P4eUJfSObFLU4tTDWyF8mUMLNoUaF0Ha06OvONPfbNn97cPw22pAeH
         vvIuYwx+/tbONkMqd+puv+VfqwxpBx9+Cw/7aYfMlUJMQ/Ryj/tbpPBWPd/JVuNsCduD
         tS7jGkC6PfxHrQEmf8QY+ICzUdLvPCoSTCJnBNvbDLMeHaTEi1QEjQuYw82hkmuJgp7T
         3VEyZzlGa53iqi2jx7d2mffnABLj0YpAj8YjpX4ebVvFkGpLqYOBhg67k6zs1zIojDYX
         nSu+EEjoKBfK0+TAPtXs0PLGN4GrvV49NXIpqD9bC+zIiNmfsgjasVax/fMeYWA93ptI
         i/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373076; x=1727977876;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTtHCqLrWS9wifwWZYlofn019VV7+dUOgk7GQL5znTY=;
        b=lD6eHqf/4vQ2n+cQ/nS25heSkp+FmRvQsi8LNnhDSS/EkkeEdnUjOWTMkJDF7yjLLR
         3x+XOEkAJB7NejChwkbyPwsSTVRhCVjtknR6/uVCxUIzZ3E0zJtptryg1+XLMOts9dO6
         uYYXzTr+xI6XiPtnUVqumTvgCBnPXF+70oLqg6fUvPP/am+jaIdyHqnqia/VflTWnNx7
         +azmSoXSQaR/vstd6fHFzx62IToa8k4SuiljLKJJTgbTc11Wgv6ix14Z1cggUHKuZcQ0
         OVUk4Qa9sCMqar1ZPvGlgH4iA40YgA54sOCnj7z9h4o13UGYJ3/h/VLRBF7s3luk+DJS
         P5yg==
X-Forwarded-Encrypted: i=1; AJvYcCURLNc+FWkeTehtvWMkpcUnjysW8ugkQJ3jzbYrd/KB6wbaTR0oSPBHB2OE8sZ5UIdNB+aZ8xB3FX9568M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtJVtGWmWYaJ7SwPVRP2HBKViSyS886QTSTEBNMD9gNyU5nzS
	vj0fZSDCFe1nDYpvnwrDd8DGdOYVB74tuWg0MBMUeYfH4dMYUXO8c0jTruONwa4lbjETp/IQTGV
	j6GFEwg==
X-Google-Smtp-Source: AGHT+IEhmvvlqELFMwtlv7WFBXlsutk/M7yr5CVNk/56bWPPeXVWPBKiG8rOsNY4PBMAfKgELecg5HFbD5x5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a25:a527:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e2604b45318mr289276.5.1727373076537; Thu, 26 Sep 2024 10:51:16
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:27 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 14/22] perf jevents: Add FPU metrics for Intel
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

Metrics break down of floating point operations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 90 ++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 7cd933a28cfd..dc14fff7abc3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -315,6 +315,95 @@ def IntelCtxSw() -> MetricGroup:
                                     "retired & core cycles between context switches"))
 
 
+def IntelFpu() -> Optional[MetricGroup]:
+  cyc = Event("cycles")
+  try:
+    s_64 = Event("FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
+                 "SIMD_INST_RETIRED.SCALAR_SINGLE")
+  except:
+    return None
+  d_64 = Event("FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
+               "SIMD_INST_RETIRED.SCALAR_DOUBLE")
+  s_128 = Event("FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
+                "SIMD_INST_RETIRED.PACKED_SINGLE")
+
+  flop = s_64 + d_64 + 4 * s_128
+
+  d_128 = None
+  s_256 = None
+  d_256 = None
+  s_512 = None
+  d_512 = None
+  try:
+    d_128 = Event("FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE")
+    flop += 2 * d_128
+    s_256 = Event("FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE")
+    flop += 8 * s_256
+    d_256 = Event("FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE")
+    flop += 4 * d_256
+    s_512 = Event("FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE")
+    flop += 16 * s_512
+    d_512 = Event("FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE")
+    flop += 8 * d_512
+  except:
+    pass
+
+  f_assist = Event("ASSISTS.FP", "FP_ASSIST.ANY", "FP_ASSIST.S")
+  if f_assist in [
+      "ASSISTS.FP",
+      "FP_ASSIST.S",
+  ]:
+    f_assist += "/cmask=1/"
+
+  flop_r = d_ratio(flop, interval_sec)
+  flop_c = d_ratio(flop, cyc)
+  nmi_constraint = MetricConstraint.GROUPED_EVENTS
+  if f_assist.name == "ASSISTS.FP": # Icelake+
+    nmi_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
+  def FpuMetrics(group: str, fl: Optional[Event], mult: int, desc: str) -> Optional[MetricGroup]:
+    if not fl:
+      return None
+
+    f = fl * mult
+    fl_r = d_ratio(f, interval_sec)
+    r_s = d_ratio(fl, interval_sec)
+    return MetricGroup(group, [
+        Metric(f"{group}_of_total", desc + " floating point operations per second",
+               d_ratio(f, flop), "100%"),
+        Metric(f"{group}_flops", desc + " floating point operations per second",
+               fl_r, "flops/s"),
+        Metric(f"{group}_ops", desc + " operations per second",
+               r_s, "ops/s"),
+    ])
+
+  return MetricGroup("fpu", [
+      MetricGroup("fpu_total", [
+          Metric("fpu_total_flops", "Floating point operations per second",
+                 flop_r, "flops/s"),
+          Metric("fpu_total_flopc", "Floating point operations per cycle",
+                 flop_c, "flops/cycle", constraint=nmi_constraint),
+      ]),
+      MetricGroup("fpu_64", [
+          FpuMetrics("fpu_64_single", s_64, 1, "64-bit single"),
+          FpuMetrics("fpu_64_double", d_64, 1, "64-bit double"),
+      ]),
+      MetricGroup("fpu_128", [
+          FpuMetrics("fpu_128_single", s_128, 4, "128-bit packed single"),
+          FpuMetrics("fpu_128_double", d_128, 2, "128-bit packed double"),
+      ]),
+      MetricGroup("fpu_256", [
+          FpuMetrics("fpu_256_single", s_256, 8, "128-bit packed single"),
+          FpuMetrics("fpu_256_double", d_256, 4, "128-bit packed double"),
+      ]),
+      MetricGroup("fpu_512", [
+          FpuMetrics("fpu_512_single", s_512, 16, "128-bit packed single"),
+          FpuMetrics("fpu_512_double", d_512, 8, "128-bit packed double"),
+      ]),
+      Metric("fpu_assists", "FP assists as a percentage of cycles",
+             d_ratio(f_assist, cyc), "100%"),
+  ])
+
+
 def IntelIlp() -> MetricGroup:
   tsc = Event("msr/tsc/")
   c0 = Event("msr/mperf/")
@@ -707,6 +796,7 @@ def main() -> None:
       Tsx(),
       IntelBr(),
       IntelCtxSw(),
+      IntelFpu(),
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
-- 
2.46.1.824.gd892dcdcdd-goog


