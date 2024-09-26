Return-Path: <linux-kernel+bounces-340891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79059878B7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8557C283024
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F296E188711;
	Thu, 26 Sep 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TchAf/p4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FA1885B8
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373091; cv=none; b=cxVFkxgVkJcmHlvhhkNIaOJyhy6v/mEBwyytotPyXuguPbtZj6WK+1uwkmECeSk4X6BIN/5nZ5Y5CGnQrx/QXbVayys8kmJ5Vvlr8jb5hY+qM7y8YgjYTrc+27Nq53U1xRX2+l9OKigttZdaGFC+31P3P1UnaU3gbrgvL4zfLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373091; c=relaxed/simple;
	bh=RD7smdhxhARGJwlGqEZPttCgmCZjWX1IAxKRHA1VzSQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=M9io4KYxpRQuaZjq08S3yu4RBQnB8PQAGg8cUiKaGQsNY+oczoQaPvu9ujNREeR6zNyms2Dn9EAkdSHy5+v1+w3hdeON2bKFIuQHQBVjRKhyaApU/Q2VY67aGsRhf2jrh3BvPoVWlXIS38IHSOk810TRe4K20mtXshbRG+7qGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TchAf/p4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3e062dbeeso16128617b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373089; x=1727977889; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCPmhXbs6UurYY4SAgoEfBkNgHp5uen66R7vZaPPnuo=;
        b=TchAf/p4Be588ZhwZUkbADI3VnIUm3VyP+ZeLz2xilwVqEWojTCD6sZwG1w0KxD2WI
         KduBka5TgXeykQ999tsKeQlrUoq8cbfDlkSZ+URuA5UtxZg36bU4p7h6+3s9ARO9FTAg
         hE85GP1M5av5E/Wk6o+heLXKBEnyEj+8f8VjArFj0/tg1JU5ppxSCaVrp7h87EOaqXXK
         AkEMJC2NFWL82qYQJsCWWtjNfPELZhwLL9+06APXsIs9vjvmWdlCkZUcciyB7x+2SugH
         YPvf0Nxnf7tFdnM0Ohm0x/1TvPml7ULSgKW/1IhuI27FO3TILjTRkCkTMmXaBjKOefZ4
         pvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373089; x=1727977889;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCPmhXbs6UurYY4SAgoEfBkNgHp5uen66R7vZaPPnuo=;
        b=o2zsXldFSIfX2+61/ZF1yd3bJXr4s8HdgjNTCW/4z0lYLxDIAfgtw3fcCoYIhqaNOA
         oODTpuBZPX3xTXqPfJgd3kU8ymqkSMfGJ1PNpMkf7Akq3lgQvQMJSxjsufgbnlxDAcRu
         dAi6InhetIZiHAQw+uVBwI9JIQXBYdIqB2M72JiZoP/d+aCFo8F2trGqaz+gzCBgquOh
         4SHCKxlzwbA0ESSSg5V7S1TRVy7cJc/NI2imeBn0kbibbD53b0D0QJI1DsCNdRsNCaT0
         fThCcFm/2hZ0cMhGKHoIclWYKkyf2HImH+scZb6g4FQGfw1sp3ADfFZ+GlbI2APY0bub
         C1kA==
X-Forwarded-Encrypted: i=1; AJvYcCWjkM6xBa9lCwYWU+i/YaB5+pm7xRNeKr/1R+XmP5fgcogrjFC0h8aW9VMnhhc7SiKKcE8t1WqjIcZ+6hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqV3IK7eIkvOYt1bKETi4WM4phivDpeLnCikPcoahOjYi7kZZQ
	OfFW+wIyKCx6j7x2L5elrV657pjVS+kpuMM8f8vmX33CMT52Q+r+KbuWb/mFK5hER+zdHWh/CYc
	AVIakFg==
X-Google-Smtp-Source: AGHT+IHXi/eqyHm4wlwY4vFGhinHvdSusE4pL2PPakXEDaWnBlMu2TBEz4bPL+jycMBAtm9IYXT3+xeE4zz5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:690c:3405:b0:6d9:d865:46c7 with SMTP
 id 00721157ae682-6e22eddb5d4mr337317b3.2.1727373089000; Thu, 26 Sep 2024
 10:51:29 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:32 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 19/22] perf jevents: Add C-State metrics from the PCU PMU
 for Intel
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

Use occupancy events fixed in:
https://lore.kernel.org/lkml/20240226201517.3540187-1-irogers@google.com/

Metrics are at the socket level referring to cores, not hyperthreads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 77ac048c5451..5668128273b3 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -781,6 +781,32 @@ def IntelLdSt() -> Optional[MetricGroup]:
   ], description = "Breakdown of load/store instructions")
 
 
+def UncoreCState() -> Optional[MetricGroup]:
+  try:
+    pcu_ticks = Event("UNC_P_CLOCKTICKS")
+    c0 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C0")
+    c3 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C3")
+    c6 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
+  except:
+    return None
+
+  num_cores = Literal("#num_cores") / Literal("#num_packages")
+
+  max_cycles   = pcu_ticks * num_cores;
+  total_cycles = c0 + c3 + c6
+
+  # remove fused-off cores which show up in C6/C7.
+  c6 = Select(max(c6 - (total_cycles - max_cycles), 0),
+              total_cycles > max_cycles,
+              c6)
+
+  return MetricGroup("cstate", [
+      Metric("cstate_c0", "C-State cores in C0/C1", d_ratio(c0, pcu_ticks), "cores"),
+      Metric("cstate_c3", "C-State cores in C3", d_ratio(c3, pcu_ticks), "cores"),
+      Metric("cstate_c6", "C-State cores in C6/C7", d_ratio(c6, pcu_ticks), "cores"),
+  ])
+
+
 def UncoreDir() -> Optional[MetricGroup]:
   try:
     m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
@@ -939,6 +965,7 @@ def main() -> None:
       IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
+      UncoreCState(),
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
-- 
2.46.1.824.gd892dcdcdd-goog


