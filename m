Return-Path: <linux-kernel+bounces-340888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1759878B3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 610FDB298BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436D188003;
	Thu, 26 Sep 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DscxZ0AK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A92018787C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373083; cv=none; b=RafY2Jl59eZJ5A2aCk/LlYUK+iPv4J1W/pss+x2PMJ/ESm4SE3hcmxY9BmhvbNZAQU6J0QRO4N31Gbfy8vxQnAsOj+1x6camIMjqrQg47DF8UYpDJjRaxiWQzMfZJ6GHN0gHXRvqu/GphIJyilIYk1bbPoiyt2MPgnZKKBITuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373083; c=relaxed/simple;
	bh=fwA4mSBzJz+3PRENvM2QfgAEltHmgn55JmhkR1PWDNo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qm8zPduNdVwoKpkUzF/CZ12mrATakaxuGA9lrlglnhZPELb1m1cxp+vl4JXhwMPXteGkT3O05aDc7zM/m0U5f/nusvw/HlZK/glcx726obLV7XIqdxUWJsVZfviAlj4NYvQFhJ8SLXCxKsVz3dZQTYaLIrej3wKdy36VWpnpB5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DscxZ0AK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ddbcc96a5fso29311847b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373081; x=1727977881; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKlA4KppkW0S/dSvWIDSo0Avdp5xMimIpQwDxo8bezQ=;
        b=DscxZ0AK9TiAYgnB31pLOhupwAxdQLEoa8nyz9HnGrnKR0go9ykX6XkAAiucsZdoWv
         afgQs8zuPXnHodSotuzWQzKps0RRPXGgBBQk8SpPJaa/yRRuaSuxgJqWhcLCllGYlzSs
         qIDdivWZ9cUAwViw6dHeCPCgAz4bW+AC8w/PNGMejlVMAIlJD8xNUwb6gMdyKjgXyT4w
         VFVAMWMW9GQ1RbfndCq6u+eRCCTFy3dXUkWRU/bgeW3YkMF8N+864wErIhuMEmpoX6SP
         LedRXr7jhCjOCbYw4MjS0TRTqa/qoK85fU2TKpg1c49gTh3sz3GHgVlR+nLRRaYUq8UM
         4G0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373081; x=1727977881;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKlA4KppkW0S/dSvWIDSo0Avdp5xMimIpQwDxo8bezQ=;
        b=sKXqQqVFwihXzI4kFiF8rojUp6//U7qjI79FQPJKvaxb8M47MRZMmLp74zd8hI1BiE
         PhQBOHB3MsrYHCKCq258VEqY5jknX9i6yEfzaw3GgqggOr3uwdKS61LhPRJ2DnDXgNUX
         8acRnzdy29QPfGO1Zzx9qqVGem5O5JkH/ojz/aQ7nZYSJvkWsyeaNHL15X0N5LWTEa+B
         VzmceTzwCDS9ZwIGUXUy5Jecwzrc3IDYGTEglIXR+CzL0bmh/gFIhwXEE3QZOj+F/Axl
         zyFl8FvyI9CeZAlDPZwElMbnFKiB51kMu+DoYIakfnRNNe1KnqKHu7cbF7UZXIZwp6aw
         WuHw==
X-Forwarded-Encrypted: i=1; AJvYcCXZpek++Tzi+1ULHO5FPUmuDWYz/v1oE9SCHS6YyP1EtEFNQGoPyOQTVx+f5NToOoCehE8m53oL+AAvlOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDs25VRjm5S8NKqNTeElQpKjPNa9EtYC8cQIYXvMcHbc1ZpI3
	tFRbU+No0RH33NQyLl+4DNJVc7edDXGdBGxaTnqTwJJ8sRL9SLR25qhbxgtLsVv5CJDDFWnyI45
	Co2ksdw==
X-Google-Smtp-Source: AGHT+IEvPAJzPmEevw42+uIqouK8BRqYvJdqqThpQsSaDxNqbmfPpnmFQ4jEv2xBtVvIcWQLwJpuL1Q4+C3h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:690c:d8c:b0:663:ddc1:eab8 with SMTP id
 00721157ae682-6e2475a8a5cmr24807b3.4.1727373081524; Thu, 26 Sep 2024 10:51:21
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:29 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 16/22] perf jevents: Add mem_bw metric for Intel
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

Break down memory bandwidth using uncore counters. For many models
this matches the memory_bandwidth_* metrics, but these metrics aren't
made available on all models. Add support for free running counters.
Query the event json when determining which what events/counters are
available.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 8c6be9e1883f..05e803286f29 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -781,6 +781,67 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreMemBw() -> Optional[MetricGroup]:
+  mem_events = []
+  try:
+    mem_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                                f"/arch/x86/{args.model}/uncore-memory.json"))
+  except:
+    pass
+
+  ddr_rds = 0
+  ddr_wrs = 0
+  ddr_total = 0
+  for x in mem_events:
+    if "EventName" in x:
+      name = x["EventName"]
+      if re.search("^UNC_MC[0-9]+_RDCAS_COUNT_FREERUN", name):
+        ddr_rds += Event(name)
+      elif re.search("^UNC_MC[0-9]+_WRCAS_COUNT_FREERUN", name):
+        ddr_wrs += Event(name)
+      #elif re.search("^UNC_MC[0-9]+_TOTAL_REQCOUNT_FREERUN", name):
+      #  ddr_total += Event(name)
+
+  if ddr_rds == 0:
+    try:
+      ddr_rds = Event("UNC_M_CAS_COUNT.RD")
+      ddr_wrs = Event("UNC_M_CAS_COUNT.WR")
+    except:
+      return None
+
+  ddr_total = ddr_rds + ddr_wrs
+
+  pmm_rds = 0
+  pmm_wrs = 0
+  try:
+    pmm_rds = Event("UNC_M_PMM_RPQ_INSERTS")
+    pmm_wrs = Event("UNC_M_PMM_WPQ_INSERTS")
+  except:
+    pass
+
+  pmm_total = pmm_rds + pmm_wrs
+
+  scale = 64 / 1_000_000
+  return MetricGroup("mem_bw", [
+      MetricGroup("mem_bw_ddr", [
+          Metric("mem_bw_ddr_read", "DDR memory read bandwidth",
+                 d_ratio(ddr_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_ddr_write", "DDR memory write bandwidth",
+                 d_ratio(ddr_wrs, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_ddr_total", "DDR memory write bandwidth",
+                 d_ratio(ddr_total, interval_sec), f"{scale}MB/s"),
+      ], description = "DDR Memory Bandwidth"),
+      MetricGroup("mem_bw_pmm", [
+          Metric("mem_bw_pmm_read", "PMM memory read bandwidth",
+                 d_ratio(pmm_rds, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_pmm_write", "PMM memory write bandwidth",
+                 d_ratio(pmm_wrs, interval_sec), f"{scale}MB/s"),
+          Metric("mem_bw_pmm_total", "PMM memory write bandwidth",
+                 d_ratio(pmm_total, interval_sec), f"{scale}MB/s"),
+      ], description = "PMM Memory Bandwidth") if pmm_rds != 0 else None,
+  ], description = "Memory Bandwidth")
+
+
 def main() -> None:
   global _args
 
@@ -817,6 +878,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreMemBw(),
   ])
 
 
-- 
2.46.1.824.gd892dcdcdd-goog


