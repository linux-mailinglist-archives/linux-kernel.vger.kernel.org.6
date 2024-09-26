Return-Path: <linux-kernel+bounces-340863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F8987886
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDCF1F23720
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11AB185B51;
	Thu, 26 Sep 2024 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyMtgV6i"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE310185925
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372497; cv=none; b=ahXpFRv8uK35n1dtEt4wIJJL527ck+28eRzTZBVDBguEPsv8BriHKukKj3zDF6Ukm64rMufUNmT7pIuCMrLUInKllTtQVyQMfSKCQmtMyFRdtYeZ+uEkIdMd/vzWWZIK6/QWw8pq7ZMHRGINnyoIuZ55jZPHrhdVkhxDbGhSHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372497; c=relaxed/simple;
	bh=+Q3cbKNi7CEZJd4qRakVA6jInS3YI+E4It9MVNRWSIo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MfrJXQDXsQU8LOZAJEfMPi/asu9h70ykJlmNcjs6yqOgbIBfHlGoHBhYdztZu0lZMCopY9KKeJynVxyVHgzK/x/AxjFQN0oB2z/LAw8sKZccR+VDvg3Lsm7FzkueZdclr/RNuIFvQTkSbv6CGTaH/EYUv17KvSxBO8YxKI1EXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyMtgV6i; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20e4e55bbso22623327b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372495; x=1727977295; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSHlWju2oAL0LCcuFkRJ4m32w4WUZhr6tiZ6pN0TU5I=;
        b=YyMtgV6iJ2yNH1SYLaALBUJWAfiI6NbYltnSHgwj3cT1pyGwBemPWpG0i2o5HaIH8y
         X5jYQ52xDzSiqiVT1RvymAtTxHOl+w+ddper7jsB7KA0TzDBa02apyGOo9jJULG6eRJm
         IxAQLOY7nUPent7Oa/SsI+hGaAXfF2kNzsb+Cmf2xOhsZl1x6+UCYq8PE50cwf2Hutg4
         EQKImVIa23LG3dmofFth6SkoG9r8HTCXejm4IS1WkiKL5/wJnJgv5gqixX6ieSCZGdxB
         BR89f4eRvyFJaDprZ3AnIhb8EnFGlHvckXzLBMjqQFHT2rxiWdSLQ80wkPnrQKfV2FaM
         t6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372495; x=1727977295;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSHlWju2oAL0LCcuFkRJ4m32w4WUZhr6tiZ6pN0TU5I=;
        b=tStpZ6qtm11Fppo6nA7VwqMxBQ0evFkYmFhmwm1rQiAH5ze416GoEENwiaiqZs6P48
         y1JBEqiHNEKZ3mPN9IyJuiz9kOZLlGawyYRxRXOHvgzmtxO89rgXZtXPYps3GgOihM+t
         6IebowHkl3REYPGRH3/5kn3oOs89i8wYNR2FDAchrub91vQGLTn+Y5KtQ3uR+TJbioAe
         nR7/0QCrg+LgYtnghy09IiyndFrhn+0Wvit/WxvXfaCga11XK3mqb7oZNyv+0BpCBtHT
         3kO7lV1RKDHFr24YaLsHHHddUjis7X6JKj3r7A2mUzo95sU9kJWfBJFwcGJsSkWmRMG3
         BPMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7CjD7rWNIrSLejXLoIXir5bQnJ55uRMoagF0+S8CnWb3uO1e6VSRdYFCdLpNgTdmEba32GKsCZbXuuS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu4BU/RZuhXUV0gVsAwg5Y/tzBaTPH4Nw2XQSnPud6KQzyaNtL
	s7cQMGbciEpV0eczfrw/rGdF45znaxYJn1dUAf4M6a78ABAQL8q/8KJSBdQA40Pf/XNfGHlNa2u
	zCM4Edg==
X-Google-Smtp-Source: AGHT+IFDUL+7JDuzTMzLrC1nWh5fpw56+P5b5tUK4uo6Euvq44oXgWaMPC3K9jHFqcCfbkwUKyaMkBzBmkhn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:690c:6303:b0:6db:b2ed:7625 with SMTP
 id 00721157ae682-6e2473a2687mr63517b3.0.1727372494806; Thu, 26 Sep 2024
 10:41:34 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:41:00 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 11/12] perf jevents: Add ILP metrics for AMD
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 3f77d1bbf1c9..157fa4fa3d62 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,35 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("ex_ret_instr")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles) for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], cycles))
+    ilp0 = 1
+    for x in ilp:
+        ilp0 -= x
+    return MetricGroup("ilp", [
+        Metric("ilp_idle", "Lower power cycles as a percentage of all cycles",
+               d_ratio(low, tsc), "100%"),
+        Metric("ilp_inst_ret_0", "Instructions retired in 0 cycles as a percentage of all cycles",
+               ilp0, "100%"),
+        Metric("ilp_inst_ret_1", "Instructions retired in 1 cycles as a percentage of all cycles",
+               ilp[0], "100%"),
+        Metric("ilp_inst_ret_2", "Instructions retired in 2 cycles as a percentage of all cycles",
+               ilp[1], "100%"),
+        Metric("ilp_inst_ret_3", "Instructions retired in 3 cycles as a percentage of all cycles",
+               ilp[2], "100%"),
+        Metric("ilp_inst_ret_4", "Instructions retired in 4 cycles as a percentage of all cycles",
+               ilp[3], "100%"),
+        Metric("ilp_inst_ret_5", "Instructions retired in 5 or more cycles as a percentage of all cycles",
+               ilp[4], "100%"),
+    ])
+
+
 def AmdDtlb() -> Optional[MetricGroup]:
   global _zen_model
   if _zen_model >= 4:
@@ -584,6 +613,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
       AmdLdSt(),
-- 
2.46.1.824.gd892dcdcdd-goog


