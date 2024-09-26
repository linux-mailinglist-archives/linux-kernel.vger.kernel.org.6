Return-Path: <linux-kernel+bounces-340885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3BA9878B0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3B6B25BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E83187344;
	Thu, 26 Sep 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ywc2YsXR"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C9186E58
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373076; cv=none; b=NTu/f376OunYOhbkPmrm3pr2V/yaYKixFi5tl7gy620Ld7FjjnVpVbcAAxhIPBNFBa+N3tzGLWRc2yBAnS1o127GDyfbMLuW0q/mFXPAhbFjcuKB/jLw6ro7bsyqyIRBokff/9H4JdeDEkceny83DdJmm+5loix3+rG9goCp20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373076; c=relaxed/simple;
	bh=OVuuPRjb69PsU2GEA4QRsWMC/YqRdddGfs3QwpuJ66Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HQSzpgTWh5jeoaz2tYCWR0vRY7F33aBAu6k85YoFErqIb2FfmgvImDVN2sWnTMyhflMuLhY//71x4zAHAb0U0Kt3Gh3av9DVEwqLOt2AGCBDfsV0mMW9bHhj7DRyGRPq+w2LGw8Z9fQHBfgIpQz1qBMCd69ZQyEgPRHK+0bEF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ywc2YsXR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159159528so3323916276.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373074; x=1727977874; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLwPHCG8saDDUd/5iw+opj8b4ooD/vOwAIEG3wxjNFc=;
        b=Ywc2YsXRMb+uHaA+FOrASsLTu/BcaChv42oa1IAUnD1/5s54E19GGvbhAgkmTm9Nyi
         L5wAaX+bVG7jjHmQDicGnyO7BhtO+PM+7WgGPhOUd9h4LOCk1G870dVEhMCn1/Nseepo
         BXWWE+4RF2im6R9nDnQu9haLsoX4bm6Aj59SzYYQ4AOqhWEz4RvCP0Ub494WxgccLttl
         FPPHg+jZk4wq/dzIPa1CN5xbfQCgdssNnr4fiq4tukk/0H9RaFm1lmRKn5ZDiSKinooX
         V/cklqYFSi5utqHDluUAtkZK22tR6ilVzkfEeVQslJL7hHnh88rEIpQ1F9uLDNMByMUR
         PD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373074; x=1727977874;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLwPHCG8saDDUd/5iw+opj8b4ooD/vOwAIEG3wxjNFc=;
        b=qDr6ax2hZ/aRyvx4aJYSlVFIFSU1bAgkU5kH65UE/yQ6L1YcUzEr9b27qrOe59gP+Y
         dx+EphOt3Bkg9LvmspwnChJnBBTcWe82qBhooAf54vrWwlRKJ6CoPPAXICBDBdQ0s2r8
         YUma3WTs82ZR1XN4c3fBXP99GdsmbVr78SCveRUlfuxLJp09TaEZ0y3dcRCO37IgA8gY
         3WG06z4I+aYWKZQjx5OnCFzAUf51R94zPJINhUQqNXvzsfuzn01ahmNacr9fh3xSAZU8
         LMCU3hL+ZUKUkMYZ1dhYAm3vWpJK+uCyGfhrdpTZ0sNo2/bXkH348x3UzkfYeFpVeDUr
         gCeg==
X-Forwarded-Encrypted: i=1; AJvYcCXR5DM7tLiLISxWLWqVHu7OUnDWj7FMSfK+JK2SRbPOUn4JonsIVY2Qc83Qet6j6kJmdNNnR4qRzaEeAbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJhbiUriy/xR37+vwjhnTeIoZcKyCgSTbgMwKC0kTNxxX+OIo
	w9n0VN0ats8aFrEMda3hUQ1hw3q5s1FSNWk86G8WX9hTyw8BT2vcS5XrRQBzqt7fwB9hKQY2Imp
	ZwSTVlg==
X-Google-Smtp-Source: AGHT+IGonUkUdI41tBPX/DtmAGGPzqe/htwaseu3ls3WBiJqGtAam44JAbuDYNMXPw+eHqfCDgMgeDtmWf9T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a25:3628:0:b0:e22:5313:fb31 with SMTP id
 3f1490d57ef6-e25ca8b1151mr55548276.1.1727373074089; Thu, 26 Sep 2024 10:51:14
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:26 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 13/22] perf jevents: Add context switch metrics for Intel
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 1d886e416e7f..7cd933a28cfd 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -261,6 +261,60 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelCtxSw() -> MetricGroup:
+  cs = Event("context\-switches")
+  metrics = [
+      Metric("cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  try:
+    ev = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    metrics.append(Metric("cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+  except:
+    pass
+
+  try:
+    ev = Event("MEM_INST_RETIRED.ALL_STORES", "MEM_UOPS_RETIRED.ALL_STORES")
+    metrics.append(Metric("cs_stores", "Stores per context switch",
+                          d_ratio(ev, cs), "stores/cs"))
+  except:
+    pass
+
+  try:
+    ev = Event("BR_INST_RETIRED.NEAR_TAKEN", "BR_INST_RETIRED.TAKEN_JCC")
+    metrics.append(Metric("cs_br_taken", "Branches taken per context switch",
+                          d_ratio(ev, cs), "br_taken/cs"))
+  except:
+    pass
+
+  try:
+    l2_misses = (Event("L2_RQSTS.DEMAND_DATA_RD_MISS") +
+                 Event("L2_RQSTS.RFO_MISS") +
+                 Event("L2_RQSTS.CODE_RD_MISS"))
+    try:
+      l2_misses += Event("L2_RQSTS.HWPF_MISS", "L2_RQSTS.L2_PF_MISS", "L2_RQSTS.PF_MISS")
+    except:
+      pass
+
+    metrics.append(Metric("cs_l2_misses", "L2 misses per context switch",
+                          d_ratio(l2_misses, cs), "l2_misses/cs"))
+  except:
+    pass
+
+  return MetricGroup("cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def IntelIlp() -> MetricGroup:
   tsc = Event("msr/tsc/")
   c0 = Event("msr/mperf/")
@@ -652,6 +706,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelCtxSw(),
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
-- 
2.46.1.824.gd892dcdcdd-goog


