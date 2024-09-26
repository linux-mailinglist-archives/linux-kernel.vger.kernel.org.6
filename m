Return-Path: <linux-kernel+bounces-340882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6369878AD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1E8B24160
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD11186298;
	Thu, 26 Sep 2024 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luNO/fFn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B820185B4B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373069; cv=none; b=jd2q9KT5bbUE10sIqy9hqy/UH8d39XR18zACM6B9qTjorNq2c6lThuljH3oQlZ3F8PUMBLFKz+MInTrDHAR3VPG1G408d0x3bipx+glY+2/WW3iUB7jLlAS1sesuWSqtk8Et+DVBtKNqsd58SkUu/3x68VhWTKwfr8X2GV75aPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373069; c=relaxed/simple;
	bh=RuDW7FiE0OMZyj6nWprJw9uFRox8tje7lp4b53p5Sdc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UDeO2MZg55A9y2dieBIAgiGrxkcQWdjsPu1T4XsCY4Ex7IhllRXckM34AIR6TuFOQGgIQ2jkO+kMwoEJWDvur3ka7BP8L1Fmb4OD6RFGjXddYAScaJxzBbOP1Nm+9EfNUAwBIFZnCRqQYkwMAfjyPxFFqRH89sLAITemnjRfI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luNO/fFn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e230808388so19506007b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373067; x=1727977867; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbgNpANwdm5lKdZzY9o3WtnKK/j4c+9HGEwsUFYZj60=;
        b=luNO/fFnCvCvqLmYVX2NVz/B33YagmmqNVpEmdksoQJJEbQ7z5pn4eCLJnC7v66LGH
         w4vpTz+U8diBDv/HCSq7qddPJ3Z/6tkY9ttqaedDWfSQ6i6NhgoxP4nWi+hnSckC8pWy
         gzi7Tjdw5i5z83893AFLU2kcrJxa7FeYuY8WdDKAA6H/jAL/GcgRi5xNBVhmRSwDkPQf
         Mgv8Q3mcx3xqBcvSTEzR5M+0BcfRa4EVm6jrEl5T2ocJbHg0EFloW5ErOko3jA5Vx255
         0gmBkl3fEu22375GxL7+xTNlw6c2KVNWJ9BFknRrShGC1zKjeWFdodpopGMKoW9hjEnU
         kCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373067; x=1727977867;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbgNpANwdm5lKdZzY9o3WtnKK/j4c+9HGEwsUFYZj60=;
        b=l5nu6KbrGbDbBZbV+V2UBOvrXAPhI8nFq3KaiGV7nJU2S7XYjFCVnWn+ji3JrygfBW
         oMyqpPFZXIgvAVeY6RE82MoWD6FfhvzuYzxMSS2wWjXYJYvf2nSvuDYW7EUkQ7qX8uKC
         SD5Q2bL6XKprGnKOUHXXyLJ8Ni/IeddD1wt+mIaMUbxvAQ1sgvZXnNrpe6JyBEaymsx7
         pxcoUM/FVnKWBAnmR92/MEx0MkwinBsDGMBH52/wjtRm7QSBK8SOSSVjaARjZLoG6rNc
         ZFmygiFFJ41GhAxAKVuHgS16SLVXAYRlOlp3A4YnNByR6L3X45/9doE980va2BFbLRJW
         3ozg==
X-Forwarded-Encrypted: i=1; AJvYcCXh8bmVMpV7HnG3YU7oyAdPiu5cinkbzlJnQvgDEjXNGTXTHXZxHkk6yIxwXfySdtglxs0gG3ZkQ9jbQ9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSSbOMQtdTpFOUJhX8CE649boQ1JZ3Bn4EvBju6eQFBkYmO2/
	dRbb1uXD+wjj/oOH58IA6Tz9tMslDSNjso6UuLjjjwqKKFqakrBtsN4ewnAWduNsRhYJL+OKcCG
	LcN1pkg==
X-Google-Smtp-Source: AGHT+IHE5b1m0Oy7UCkQ1tN1YFMWXUV7WsLd4vGOaO+6z9UIwccSPCJl4WGSsjGnWO3QD09D/2ORkHL9dY4u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b93:b0:6dd:bf69:7e06 with SMTP
 id 00721157ae682-6e247618d37mr9997b3.7.1727373066809; Thu, 26 Sep 2024
 10:51:06 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:23 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 10/22] perf jevents: Add L2 metrics for Intel
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

Give a breakdown of various L2 counters as metrics, including totals,
reads, hardware prefetcher, RFO, code and evictions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 158 +++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 3ef4eb868580..4ddc68006b10 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -261,6 +261,163 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelL2() -> Optional[MetricGroup]:
+  try:
+    DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
+  except:
+    return None
+  try:
+    DC_MISS = Event("L2_RQSTS.DEMAND_DATA_RD_MISS")
+    l2_dmnd_miss = DC_MISS
+    l2_dmnd_rd_all = DC_MISS + DC_HIT
+  except:
+    DC_ALL = Event("L2_RQSTS.ALL_DEMAND_DATA_RD")
+    l2_dmnd_miss = DC_ALL - DC_HIT
+    l2_dmnd_rd_all = DC_ALL
+  l2_dmnd_mrate = d_ratio(l2_dmnd_miss, interval_sec)
+  l2_dmnd_rrate = d_ratio(l2_dmnd_rd_all, interval_sec)
+
+  DC_PFH = None
+  DC_PFM = None
+  l2_pf_all = None
+  l2_pf_mrate = None
+  l2_pf_rrate = None
+  try:
+    DC_PFH = Event("L2_RQSTS.PF_HIT")
+    DC_PFM = Event("L2_RQSTS.PF_MISS")
+    l2_pf_all = DC_PFH + DC_PFM
+    l2_pf_mrate = d_ratio(DC_PFM, interval_sec)
+    l2_pf_rrate = d_ratio(l2_pf_all, interval_sec)
+  except:
+    pass
+
+  DC_RFOH = Event("L2_RQSTS.RFO_HIT")
+  DC_RFOM = Event("L2_RQSTS.RFO_MISS")
+  l2_rfo_all = DC_RFOH + DC_RFOM
+  l2_rfo_mrate  = d_ratio(DC_RFOM, interval_sec)
+  l2_rfo_rrate  = d_ratio(l2_rfo_all, interval_sec)
+
+  DC_CH = Event("L2_RQSTS.CODE_RD_HIT")
+  DC_CM = Event("L2_RQSTS.CODE_RD_MISS")
+  DC_IN = Event("L2_LINES_IN.ALL")
+  DC_OUT_NS = None
+  DC_OUT_S = None
+  l2_lines_out = None
+  l2_out_rate = None
+  wbn = None
+  isd = None
+  try:
+    DC_OUT_NS = Event("L2_LINES_OUT.NON_SILENT",
+                      "L2_LINES_OUT.DEMAND_DIRTY",
+                      "L2_LINES_IN.S")
+    DC_OUT_S = Event("L2_LINES_OUT.SILENT",
+                     "L2_LINES_OUT.DEMAND_CLEAN",
+                     "L2_LINES_IN.I")
+    if DC_OUT_S.name == "L2_LINES_OUT.SILENT" and (
+        args.model.startswith("skylake") or
+        args.model == "cascadelakex"):
+      DC_OUT_S.name = "L2_LINES_OUT.SILENT/any/"
+    # bring is back to per-CPU
+    l2_s  = Select(DC_OUT_S / 2, Literal("#smt_on"), DC_OUT_S)
+    l2_ns = DC_OUT_NS
+    l2_lines_out = l2_s + l2_ns;
+    l2_out_rate = d_ratio(l2_lines_out, interval_sec);
+    nlr = max(l2_ns - DC_WB_U - DC_WB_D, 0)
+    wbn = d_ratio(nlr, interval_sec)
+    isd = d_ratio(l2_s, interval_sec)
+  except:
+    pass
+  DC_OUT_U = None
+  l2_pf_useless = None
+  l2_useless_rate = None
+  try:
+    DC_OUT_U = Event("L2_LINES_OUT.USELESS_HWPF")
+    l2_pf_useless = DC_OUT_U
+    l2_useless_rate = d_ratio(l2_pf_useless, interval_sec)
+  except:
+    pass
+  DC_WB_U = None
+  DC_WB_D = None
+  wbu = None
+  wbd = None
+  try:
+    DC_WB_U = Event("IDI_MISC.WB_UPGRADE")
+    DC_WB_D = Event("IDI_MISC.WB_DOWNGRADE")
+    wbu = d_ratio(DC_WB_U, interval_sec)
+    wbd = d_ratio(DC_WB_D, interval_sec)
+  except:
+    pass
+
+  l2_lines_in = DC_IN
+  l2_code_all = DC_CH + DC_CM
+  l2_code_rate = d_ratio(l2_code_all, interval_sec)
+  l2_code_miss_rate = d_ratio(DC_CM, interval_sec)
+  l2_in_rate = d_ratio(l2_lines_in, interval_sec)
+
+  return MetricGroup("l2", [
+    MetricGroup("l2_totals", [
+      Metric("l2_totals_in", "L2 cache total in per second",
+             l2_in_rate, "In/s"),
+      Metric("l2_totals_out", "L2 cache total out per second",
+             l2_out_rate, "Out/s") if l2_out_rate else None,
+    ]),
+    MetricGroup("l2_rd", [
+      Metric("l2_rd_hits", "L2 cache data read hits",
+             d_ratio(DC_HIT, l2_dmnd_rd_all), "100%"),
+      Metric("l2_rd_hits", "L2 cache data read hits",
+             d_ratio(l2_dmnd_miss, l2_dmnd_rd_all), "100%"),
+      Metric("l2_rd_requests", "L2 cache data read requests per second",
+             l2_dmnd_rrate, "requests/s"),
+      Metric("l2_rd_misses", "L2 cache data read misses per second",
+             l2_dmnd_mrate, "misses/s"),
+    ]),
+    MetricGroup("l2_hwpf", [
+      Metric("l2_hwpf_hits", "L2 cache hardware prefetcher hits",
+             d_ratio(DC_PFH, l2_pf_all), "100%"),
+      Metric("l2_hwpf_misses", "L2 cache hardware prefetcher misses",
+             d_ratio(DC_PFM, l2_pf_all), "100%"),
+      Metric("l2_hwpf_useless", "L2 cache hardware prefetcher useless prefetches per second",
+             l2_useless_rate, "100%") if l2_useless_rate else None,
+      Metric("l2_hwpf_requests", "L2 cache hardware prefetcher requests per second",
+             l2_pf_rrate, "100%"),
+      Metric("l2_hwpf_misses", "L2 cache hardware prefetcher misses per second",
+             l2_pf_mrate, "100%"),
+    ]) if DC_PFH else None,
+    MetricGroup("l2_rfo", [
+      Metric("l2_rfo_hits", "L2 cache request for ownership (RFO) hits",
+             d_ratio(DC_RFOH, l2_rfo_all), "100%"),
+      Metric("l2_rfo_misses", "L2 cache request for ownership (RFO) misses",
+             d_ratio(DC_RFOM, l2_rfo_all), "100%"),
+      Metric("l2_rfo_requests", "L2 cache request for ownership (RFO) requests per second",
+             l2_rfo_rrate, "requests/s"),
+      Metric("l2_rfo_misses", "L2 cache request for ownership (RFO) misses per second",
+             l2_rfo_mrate, "misses/s"),
+    ]),
+    MetricGroup("l2_code", [
+      Metric("l2_code_hits", "L2 cache code hits",
+             d_ratio(DC_CH, l2_code_all), "100%"),
+      Metric("l2_code_misses", "L2 cache code misses",
+             d_ratio(DC_CM, l2_code_all), "100%"),
+      Metric("l2_code_requests", "L2 cache code requests per second",
+             l2_code_rate, "requests/s"),
+      Metric("l2_code_misses", "L2 cache code misses per second",
+             l2_code_miss_rate, "misses/s"),
+    ]),
+    MetricGroup("l2_evict", [
+      MetricGroup("l2_evict_mef_lines", [
+        Metric("l2_evict_mef_lines_l3_hot_lru", "L2 evictions M/E/F lines L3 hot LRU per second",
+               wbu, "HotLRU/s") if wbu else None,
+        Metric("l2_evict_mef_lines_l3_norm_lru", "L2 evictions M/E/F lines L3 normal LRU per second",
+               wbn, "NormLRU/s") if wbn else None,
+        Metric("l2_evict_mef_lines_dropped", "L2 evictions M/E/F lines dropped per second",
+               wbd, "dropped/s") if wbd else None,
+        Metric("l2_evict_is_lines_dropped", "L2 evictions I/S lines dropped per second",
+               isd, "dropped/s") if isd else None,
+      ]),
+    ]),
+  ], description = "L2 data cache analysis")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
   pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
 
@@ -380,6 +537,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelL2(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.46.1.824.gd892dcdcdd-goog


