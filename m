Return-Path: <linux-kernel+bounces-572193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B65DA6C7D3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B33B17FBEE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A21D2F53;
	Sat, 22 Mar 2025 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xn3hfFLM"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B951D1C84D6
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625288; cv=none; b=NZL3yergvBDa/mj6NCjwX1dPKavJ//4mCrQw5ZQ4OLxV2sOFY1DfH8kO7+nlMnopvVxoXqur5hYT7OiH5dn9cNmZrbAIfh/DyLTqhoJ18AHGeHA8DC6vBSal+v7wLKz3aFXN1uvFNluRy15RZGaT4EE7torLLBLkFK+hmM/lYug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625288; c=relaxed/simple;
	bh=jj7cgVY1dHCdbl7CToIOpx+DtAOgzXi+ZwBseYtASCc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bXawRuBru/ljEGJ7iq7fN1drpXLogDjsIDBYBmxSnhJyiPZ94K2Q+99v9TA4oBRw/lWlxi2H/nxaEqrQcW22FFrn4DKuRhs2J8N05Zqg9lC3CwNHGBMmjs8b7z8R5jzjteMCcVj3xssocCqf5/L/KTX0tX5GLp1GJ7aVV0hSXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xn3hfFLM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fedcc61536so52225237b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625286; x=1743230086; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tXKzMdne0PcZ1yEwuy/OWzqt9sFMlDxjtYmEokV0uc=;
        b=xn3hfFLMXuPpfentevtXwmKXhrVoReKOrymP9vLt970GSO8cl4NUYJOEVwJ/B/AxAg
         buFxOtFG43DYu21WnJWcAKDkkvw4VlN9ShWKOeorey1VEvMoyS6Sr9HE3DMryurGbntY
         LM3a83svUNi3ug6EhjFHszQx0x3EVY8i2n835MbxdtkrEvNxGncsTHdeQTJk6Dd8pFNp
         ON3Krt4wJP9TRE/1ZsP8t1lRQ+ac9/KD+nJ2DpGtobbGjUViybzhZvRJDirTiCt9GFZj
         27b+/hi8pMPrGvXes1aVP+bmiQMfZellLisyBN0YRgHMVkBJP80ZTeiXVAKGDPi7Yfec
         IlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625286; x=1743230086;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tXKzMdne0PcZ1yEwuy/OWzqt9sFMlDxjtYmEokV0uc=;
        b=An5ZQPTFrcQGe50AT9LErJQFVjoUmn4i2dccoMEpCLQwU0k9S9I/VckuYFXB7trkG/
         4BtgAEjAO2kdrkQHkQhZW4MBPj74q7klCrnCrqii2vF1yCaBtjf5skHu00wAGgdcwcTe
         /VFZf2QeYPNuwYj1yX6At/ns6fFpHsf8elyKItARN/nuL6php1zHbC8BUHsamHojq6VF
         WU0+3g0X3xTE5H3k/ezuczRMEmdGO5pEjgpjDSRw71O+MfgYz6uQhGCxDmCQRGdBTS7M
         pRZlwTpO2I1WzMtcMtGI7NGKo0go38ZC6AdQWOIZhPtjf4DbyqtUlttWvorbwvrWZp6R
         yMVA==
X-Forwarded-Encrypted: i=1; AJvYcCU9JG1UnC/FX2+HZa0ZqIxnt5Vwz+qlZxMFLPA37/6Ser9jvl6PQ+z/AycUor/eD81FquQ8ekpvbcfABZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8GsybHJWmH0wt3la67fM0jN2E5RydSajEiVCb0pgVIMjK9O4
	QYhBinyfCkyFxaBIFSuZ97kvv0hL0m1CVdww5UMIwYg8bcVkpXbaKA/Bxq8wKrvqszJm/bKdcYs
	YLA3xew==
X-Google-Smtp-Source: AGHT+IHyfRIfybU/LYQBgz4YWsHHUZmvz79hZv83aHpwxbCiQUr7lQ3Mqf02d36mp+6b81C+v+/67SiWoESp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a05:6902:150:b0:e5b:33d1:cbf7 with SMTP id
 3f1490d57ef6-e6690eed614mr18568276.4.1742625285656; Fri, 21 Mar 2025 23:34:45
 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:33:37 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 09/35] perf vendor events: Update clearwaterforest events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update event topic of OCR.DEMAND_DATA_RD.ANY_RESPONSE and
OCR.DEMAND_RFO.ANY_RESPONSE to be cache.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/clearwaterforest/cache.json      | 20 +++++++++++++++++
 .../arch/x86/clearwaterforest/other.json      | 22 -------------------
 2 files changed, 20 insertions(+), 22 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json

diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
index 875361b30f1d..17f8bfba56bc 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
@@ -140,5 +140,25 @@
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
deleted file mode 100644
index 80454e497f83..000000000000
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
+++ /dev/null
@@ -1,22 +0,0 @@
-[
-    {
-        "BriefDescription": "Counts demand data reads that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    }
-]
-- 
2.49.0.395.g12beb8f557-goog


