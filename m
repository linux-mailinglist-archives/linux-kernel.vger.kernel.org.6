Return-Path: <linux-kernel+bounces-340884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF149878AF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54ACD1C2232F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5464186612;
	Thu, 26 Sep 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkyhaYbv"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323518660B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373074; cv=none; b=o79NKrbqfdQUnUM112wHl5Sht/Hz40WLRrY9YL/OydcThD9p2YjAUl2IWZulgoSGUpcUGj1VWqP/eFi51KySOrnAbmNHcJDCa+VgGyc6+aXRWfVG5kTsJj0pi5NLrHZnayZaKdJAZp5brhDvtRLMQIDdaLZpGAGs2vgtYOJ9mD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373074; c=relaxed/simple;
	bh=Yyj0GIVG7Btdq261OcM9WJhUCkMkWFIlKXW8/KZ+Elc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oJIjtx6mmfR08pvHHI5fhS5QDHB37OsJm4zB0kUBlmuEhFs00OupzRBwuUcueaVnbNfP4AUCPEDm4ATfzjShbKOnFYeE3ru7bmErcJYZlh6ZrgD2Y0IutsDT5RSUwTJ3dag1ZjaFw0o73nb2+cjlv8qNUhdyASS19Fcv65TsGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkyhaYbv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e163641feb9so2853649276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373072; x=1727977872; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dNhC2MaO4Q9A/bYMW1pTZX+2eqf/jsB+p99hSKBipU=;
        b=RkyhaYbvqcE8aAJIZEYSbMhxUq4HkELD8xW0+ngzNcmmMSO7/LwNyyNDyilIloEW9b
         xRG04eEMtMu5tOfo/Ro85joEo1UJRi8Tbyp1Fmf/2gxMI6vfdXF1G0TKONKRAJyG++9z
         b0pNcjdwi9Ubv1fZttmWv4a8AAEfQPi1u+nl8OdiADTZqUjya6iUU1oHBPqQkJ8LEyTt
         J1Xc/S1ZfgEVg7lahsjMoKtHu9LksVHOPuL+S3vJdsWGBw1f0ZFdg3lC+HkDJzvWMdbQ
         FgrdoFryu7Sb91seucKQWx/tnguxWY2AMTxX8FzN11noIjTvYuBSO4dNJKwuKvFZ80bJ
         gHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373072; x=1727977872;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dNhC2MaO4Q9A/bYMW1pTZX+2eqf/jsB+p99hSKBipU=;
        b=S6HNYaWHj90Q2k8Hpe45cvKIIp3GdFNyQBTEF/BfjoxbHco/ilGoYaUCLQ6rN5iT/j
         cXJdRHaWCBPhdlpBOaBKtdwPh+wQqd8bmoSO6WX2XzRBZZOGXov/oteO4/5mmfDnDrLE
         X5ZJ/aCzvWTdnc6Nwc+Hzd19lcVreuV+ifgGDoiBpWp6tI2IYnv21UxL56y5GYYVcuYT
         00CGe0KtpPKd9Y6tLqY51lEY2tn3bNIELR+dFJz2XwUwlUHkEUv9H2SlIonCmK7d5HHf
         nqL+vmPxyI2ZtATWYuqBp/fy3J9rg3XB6thWV3x1KOIUtUHChDxgHx/ScW1bK1QbBWEa
         hF6w==
X-Forwarded-Encrypted: i=1; AJvYcCUYsUt5AfQuJ8+6HkiXd1Xy5yJlkjNStSObbWs5IUpPg7Q9w/xRyVlcwIVkfD3QD6K/Vnz07/7Ly66lYUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXdtlE4Udc4rlGbgCxCRbsT2vvaoIOFuB64aSNv4+vwi1TWEl
	iWD3GqR53skmiqyrczGaaZCS7+HjOrj8XbDTFQHqU4PwECT0YhDrNO0BbOgW2C/oxTfSTvF3RG3
	+jrJ01g==
X-Google-Smtp-Source: AGHT+IG916HuXUlpzabsqD8Z29NkhI0OxRlRMpUszj4JfZR+Tnn7zG9VDUjQgAwf8Q8suCBAAxvxCDZja5hc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a5b:c48:0:b0:e11:593b:b8e7 with SMTP id
 3f1490d57ef6-e25e5da579amr10305276.3.1727373071728; Thu, 26 Sep 2024 10:51:11
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:25 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 12/22] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index d528b97e8822..1d886e416e7f 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -261,6 +261,38 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+  tsc = Event("msr/tsc/")
+  c0 = Event("msr/mperf/")
+  low = tsc - c0
+  inst_ret = Event("INST_RETIRED.ANY_P")
+  inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                      "CPU_CLK_UNHALTED.DISTRIBUTED",
+                      "cycles")
+  ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles) for x in range(0, 4)]
+  ilp.append(d_ratio(inst_ret_c[4], core_cycles))
+  ilp0 = 1
+  for x in ilp:
+    ilp0 -= x
+  return MetricGroup("ilp", [
+      Metric("ilp_idle", "Lower power cycles as a percentage of all cycles",
+             d_ratio(low, tsc), "100%"),
+      Metric("ilp_inst_ret_0", "Instructions retired in 0 cycles as a percentage of all cycles",
+             ilp0, "100%"),
+      Metric("ilp_inst_ret_1", "Instructions retired in 1 cycles as a percentage of all cycles",
+             ilp[0], "100%"),
+      Metric("ilp_inst_ret_2", "Instructions retired in 2 cycles as a percentage of all cycles",
+             ilp[1], "100%"),
+      Metric("ilp_inst_ret_3", "Instructions retired in 3 cycles as a percentage of all cycles",
+             ilp[2], "100%"),
+      Metric("ilp_inst_ret_4", "Instructions retired in 4 cycles as a percentage of all cycles",
+             ilp[3], "100%"),
+      Metric("ilp_inst_ret_5", "Instructions retired in 5 or more cycles as a percentage of all cycles",
+             ilp[4], "100%"),
+  ])
+
+
 def IntelL2() -> Optional[MetricGroup]:
   try:
     DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -620,6 +652,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelIlp(),
       IntelL2(),
       IntelLdSt(),
       IntelPorts(),
-- 
2.46.1.824.gd892dcdcdd-goog


