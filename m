Return-Path: <linux-kernel+bounces-340887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB939878B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F3EB273B7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F8187874;
	Thu, 26 Sep 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vo3jluPn"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE3C187852
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373081; cv=none; b=Lp9Ym1ZlFv6jitgM6SQTfQgd0UgTqU+1z1LOBZEgqJMglRIDi+4IYGn1abP9QS4jQPFL2OiSNbeXzhDqhOyKiiATNOeMiPk2itB4gfHmyB1B8eFcPQ5l/hv0ULtLz2Q1DlDeDmXkMhWliLit8ZdX0MqIj2+pfLDYp4HWUZDSFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373081; c=relaxed/simple;
	bh=hcyDyu2AAx2yOQxhwKjW3g3fWb2hZiCnyWRjsR0yqAg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gkg23MwYN3wVkml9LGtM43ZeimtCt9awO9RgGpPyN0Kop+58n+6ZpnQUgOWUIrLDfvP8ZRgYGq+1qRyhNmshV754CYrgChcxpv156BmJrSqBu5ZG0HkxgJ0UW/9i+L8ixtI2gimcNMKJ53fzZxJzVjkbKmFNteE6wnLo82NKTk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vo3jluPn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e163641feb9so2853893276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373079; x=1727977879; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3mEBXTFAkXOt/0jXmoHq8A5MThtzMol5vV0vNxrEOU=;
        b=Vo3jluPnG13vDWHxdPJOL+MqcX2tHa/Z3ozOAbrVzIbBtggeHqTUaQ7UP6OSzsX/8j
         nRsNR+d4yqCozoHsI6ykj0fUAcLxLHUQfRlx4MZnPz7OydqO10vsG7saHtIO6bBZ9l9V
         zMdW0lXgRi6flOtUvnIIVwcSPF1D0RQPKcQy8YG5LgK4Z+6Q6kh+0yIBzjxMVHLBjy/x
         BZtxWgYU8IAq3KBGrBcV2DGhcE4OH1XANo+GZF+42+G4WGpQFFT5yqnIoU8mt+HMafbq
         XPZfgE/8G85UWRRuloJFVO9aT05YGF8FauBpTb+E/bK/oTaKs1H4QzlcobtgqcfyBFZQ
         7+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373079; x=1727977879;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3mEBXTFAkXOt/0jXmoHq8A5MThtzMol5vV0vNxrEOU=;
        b=I+CebJwdNO9WIohnu4dtmbqFWf5b1vNegFWSeHcOxsiR+qqycJVUMD1Lmc7NOBcm/r
         Fa2ktlkTyYvypYwyED3CqInrFkKvAZHfTPU7c1pyE0v3n5C/jvp/9gZuYHbAu1VRj0GH
         FzY1FfTLCVqCLa2NaSw2TQtWgDjMwbTMtKqB6DbCve7+/Kug6o9cwO+oDWswTPOeYLg7
         OFfuuXvoEIgJCnk665n/BmBPwXcdwx1+l4xpfbWM0thHM+LTO6fRuDT0Gqa9lWbyWJRP
         9p98RqJvej2BpdiYd5BL1qeLf1n/0PkV/auI410FfiOwUyjMahzj5HfimTmreGubMLol
         VSlw==
X-Forwarded-Encrypted: i=1; AJvYcCWaZi+HXP84LH7GqJHcjE8tAPkQ+EGMVDavUTpbInQn8k4uXOjA/t/8GpfRkGWFjmYqZqbRlQtTYBD4r+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRiNyxER7izJ8KY0aT5xeSn9dsIga4BpVpS/FLRazLTEpB7nKL
	WzQMxKBMn8mJdSopXHJdyDos+gLxoieipoLvfWAXmdD0XEkhPj71H9NAIy0DoV0Uf8pAdFeszfO
	JkvcHMg==
X-Google-Smtp-Source: AGHT+IH1wggxrnaaQaP0ElwjeL2ieDZbEYnGxVFD3HNYP7DsBQRho+VQpaefMyIMeaodQTQJsttOfHgW47UU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a25:a409:0:b0:e20:2da6:ed77 with SMTP id
 3f1490d57ef6-e25e6295007mr5584276.5.1727373079014; Thu, 26 Sep 2024 10:51:19
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:28 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 15/22] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
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

Number of outstanding load misses per cycle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index dc14fff7abc3..8c6be9e1883f 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -593,6 +593,20 @@ def IntelL2() -> Optional[MetricGroup]:
   ], description = "L2 data cache analysis")
 
 
+def IntelMlp() -> Optional[Metric]:
+  try:
+    l1d = Event("L1D_PEND_MISS.PENDING")
+    l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
+  except:
+    return None
+
+  l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
+  ml = d_ratio(l1d, l1dc)
+  return Metric("mlp",
+                "Miss level parallelism - number of outstanding load misses per cycle (higher is better)",
+                ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
   pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
 
@@ -800,6 +814,7 @@ def main() -> None:
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
+      IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.46.1.824.gd892dcdcdd-goog


