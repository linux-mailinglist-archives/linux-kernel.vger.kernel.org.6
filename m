Return-Path: <linux-kernel+bounces-340880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042919878AB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A50B1F22DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E915FCE5;
	Thu, 26 Sep 2024 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8ATJ+kL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E303E184545
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373065; cv=none; b=sxCglTVxisZyklEnE2fT32R2LVTonSD8KM9MjvCxgOJcju090mraDmCchvAMQ3IbIXTAtAJA2/YTgmnoi5Nen6iNkKtr0TsICQ5dVzF+k5tS7S7rkcjcntsGqMhw6PVMSGQ/SN9YMvQH05+aJWSQQ055qwQx1BIRNVY/3I/lu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373065; c=relaxed/simple;
	bh=31f8Yn/eH35gJOA1WoSL/vLUefq6U+ZrMOBE1Vfo1c4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=O3gX8Rn3c+MdJHoIlqcOzLz3gTQsv1KMfCioetxNosESpFzBsWKvWsIdXLQdIxRsExeliryTeNtqOxkN08o2+1EX90x+y62SOt0L99BeyCx8zmdtcQxEIO80PNstWlaqzFMGnspRQ5d/RQHH7Bu+6Ditlaib9g8UVxq89HaAhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8ATJ+kL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-69a0536b23aso30641227b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373062; x=1727977862; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7MPwk0xrq2ytWuACw1JGtjRht0m9lFik9PWCPhm5zw=;
        b=Y8ATJ+kLuDu4xi9rR0W6XCwKyjrXBtUyu/BnflPUfVCvGnPUqeWENBBU9xd7+145+T
         2a5mrfS5maxYDKBW8sIXHAnzt8JWUF2v1tzSbVNOBUsSbVTe+LqnNNPAzUsEJNuZy9z8
         joJsnODAHpL1JQ0F4JQbgj/r8L5aVpJeE9S4zdhmZ0BjASs8zObNWSCR24gQnUGHT7oY
         oABe0FBdIRnFrx2XOa3e1xplmZopDf7VpX5hshZBgjdyZoZ/JPMlrpYd1AUVJLKfgYNg
         TED5roJt3WkyQN/+ovV7lE6EaACVCbNpYdarK84bdLQJQwGmc2kZ0nNlFojmleKdpkjN
         BRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373062; x=1727977862;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7MPwk0xrq2ytWuACw1JGtjRht0m9lFik9PWCPhm5zw=;
        b=fKWn9sSKC2oOaOeI9GkTHhxP2SH0TmaCCyDX1PHryRR3FG/RehhmDCyxl9Sg2G/81f
         ZP1Uspg3/3IhZ+bQgTq7XQtoPS2Ef135kfSqmKMws/uhCD/2fyTs/FyMiB3EtfA/EaXp
         GEkfxObgfv3pdd6w3cAGlCfkxnC078bO5XimBnvq3c4rg2ZTEQC90eKiSPV6js+xmJjS
         +5resWodqmUmXsUB5IpNyXwjALCej1d8CAQbiwjj1jncrwI/IdwSsTxCcX75UhketdOZ
         otoDoaMCyKlYaHMp2cNz32RXXBuBX5DjVD5KXvea0ctl0yorlGFcPutG2yIbtbscKyje
         XPAw==
X-Forwarded-Encrypted: i=1; AJvYcCXb4daJucIHOohhLIgd9OCE7C24O3cMryrmoqvdqsHcwC3lOr5+3TOQt4yZ/2hqKD8Dsq74S183gkGU/+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytu1gzslpZcfDlA7LeaowQDqJ+VMDeX/RS+CX64yqdBRSUaQp/
	UTs2y3hx564+DYjW8duPPEAdxXnLzzZSK124D8l+CklDlKh3sXUx6MInnTzQ+FUm6ciYAIGLxNX
	B0lAgnQ==
X-Google-Smtp-Source: AGHT+IHNk76QKSnZUXPxgHza2gJOP+DOgOGOrNseya7y6/YLAm6TyJ3yml9Onq8MbRGrlTjekM2OEFxh3CFT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:6902:3d2:b0:e1a:6bf9:aa83 with SMTP id
 3f1490d57ef6-e2604b33cc4mr306276.3.1727373061843; Thu, 26 Sep 2024 10:51:01
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:21 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 08/22] perf jevents: Add software prefetch (swpf) metric
 group for Intel
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

Add metrics that breakdown software prefetch instruction use.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 09f7b7159e7c..f4707e964f75 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -260,6 +260,70 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelSwpf() -> Optional[MetricGroup]:
+  ins = Event("instructions")
+  try:
+    s_ld = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    s_nta = Event("SW_PREFETCH_ACCESS.NTA")
+    s_t0 = Event("SW_PREFETCH_ACCESS.T0")
+    s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
+    s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
+  except:
+    return None
+
+  all_sw = s_nta + s_t0 + s_t1 + s_w
+  swp_r = d_ratio(all_sw, interval_sec)
+  ins_r = d_ratio(ins, all_sw)
+  ld_r = d_ratio(s_ld, all_sw)
+
+  return MetricGroup("swpf", [
+      MetricGroup("swpf_totals", [
+          Metric("swpf_totals_exec", "Software prefetch instructions per second",
+                swp_r, "swpf/s"),
+          Metric("swpf_totals_insn_per_pf",
+                 "Average number of instructions between software prefetches",
+                 ins_r, "insn/swpf"),
+          Metric("swpf_totals_loads_per_pf",
+                 "Average number of loads between software prefetches",
+                 ld_r, "loads/swpf"),
+      ]),
+      MetricGroup("swpf_bkdwn", [
+          MetricGroup("swpf_bkdwn_nta", [
+              Metric("swpf_bkdwn_nta_per_swpf",
+                     "Software prefetch NTA instructions as a percent of all prefetch instructions",
+                     d_ratio(s_nta, all_sw), "100%"),
+              Metric("swpf_bkdwn_nta_rate",
+                     "Software prefetch NTA instructions per second",
+                     d_ratio(s_nta, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_t0", [
+              Metric("swpf_bkdwn_t0_per_swpf",
+                     "Software prefetch T0 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t0, all_sw), "100%"),
+              Metric("swpf_bkdwn_t0_rate",
+                     "Software prefetch T0 instructions per second",
+                     d_ratio(s_t0, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_t1_t2", [
+              Metric("swpf_bkdwn_t1_t2_per_swpf",
+                     "Software prefetch T1 or T2 instructions as a percent of all prefetch instructions",
+                     d_ratio(s_t1, all_sw), "100%"),
+              Metric("swpf_bkdwn_t1_t2_rate",
+                     "Software prefetch T1 or T2 instructions per second",
+                     d_ratio(s_t1, interval_sec), "insn/s"),
+          ]),
+          MetricGroup("swpf_bkdwn_w", [
+              Metric("swpf_bkdwn_w_per_swpf",
+                     "Software prefetch W instructions as a percent of all prefetch instructions",
+                     d_ratio(s_w, all_sw), "100%"),
+              Metric("swpf_bkdwn_w_rate",
+                     "Software prefetch W instructions per second",
+                     d_ratio(s_w, interval_sec), "insn/s"),
+          ]),
+      ]),
+  ], description="Software prefetch instruction breakdown")
+
+
 def main() -> None:
   global _args
 
@@ -288,6 +352,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelSwpf(),
   ])
 
 
-- 
2.46.1.824.gd892dcdcdd-goog


