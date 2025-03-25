Return-Path: <linux-kernel+bounces-575651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04FA70542
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059961885C86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC92C1F3FF3;
	Tue, 25 Mar 2025 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpQ7wBMM"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41981A2387
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917231; cv=none; b=B8Yxc6sqsOEXLkLosDO4vAU1CxiqJTyYnkY8c8YSCNgQUN1NUXXYy3MkJ/kfl5G8/X/+AhB9K8v7bBw5HnMBRTdKPPXCyn4PlJsFSoGvPkZVwkoOhgX+qDrUZc0quQ68dNLmohamKZV9Uz7CHw+O8L/Iy2nTXC6HWtK3FWog6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917231; c=relaxed/simple;
	bh=jj7cgVY1dHCdbl7CToIOpx+DtAOgzXi+ZwBseYtASCc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CrSJTTdKAiytxRNO/xEkct8Np/R3QcBAOihlLkMfe9rKKUC6689OPqTl0+XhnMk1YPAcnWZdTmiU3cYCNOerMDEC5nLa56vZNbBWcG+T11ehbyIkfHhNjLdghMjpl9+RjJSKqpXjWRSui9s2ibU7Tn6SiWxTqMRgU3QZ9GCJ4Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpQ7wBMM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e643f233fbeso8007417276.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742917228; x=1743522028; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tXKzMdne0PcZ1yEwuy/OWzqt9sFMlDxjtYmEokV0uc=;
        b=DpQ7wBMM/xjZv2pAOc16Cnkt2IO8LMQEjL0Md/kXqHhCHRPQvefY3LvkC1P3jbbFlG
         NhmAnDrzw4wBS4J2yCAVr0ktn1Hj5U99Dgr0YgFGWcgsi2qBMt5Cdu5kUjOZ3lzTAW87
         WTZG7T1ABnvQ4NoGrM1mCT8XO1S1TrswZlWWOal2mqgmzEJ/IHwxDtsO/ylCWt1HMvDl
         Kev+vWUZNxmUfmSFr1EmDpI2P/q+46prOyvsCZTOa++FEZKvf2HCaiRu5uClmfMbu7yo
         hETJeQbHPfatAvKscJB6bzKjLunE2JNiICXIVwFqTsoZEfEbgmFpHPztQqyLYTUk+/Nt
         4N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917228; x=1743522028;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tXKzMdne0PcZ1yEwuy/OWzqt9sFMlDxjtYmEokV0uc=;
        b=jjiMbPx9GF14ITPXiKSa71BlrFS6iwZfhWMLNAjFVodVzq8DyjZSffXyCt9af3jff1
         uO0+aeFvGFitXcib1n4BGfQVmBmLrLVQqEPsgRGP5nw17X5ddxH/8dewm9Xjv3/oELtt
         UDrgr75ifLcQLaE01Rhbr1Xpl9SyoufFY1xk679A/kYH46cI4vfIAvIBH4psh7Qu3k8y
         9n53JDHPiVUx5kHOMMScbbNRnvhxwdp00AFlKXZUlUlDOiKIO3+37/S8pkMZHucwEBe5
         CumhGRZbpgbcIJ8YoyXZRv9fhJfgbniBkugBXCXXMHFfEbJCxROnBF0bUABmAxDyq3GC
         I8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVIoJ24B6HMc9ur262bEzHHAiTVos71+2jVX23InD2d6vQh9jSncFJzLXGQhWzh5uY9fFgTKY5Vtyq7wfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCizZuEPWE1UjUwPRILNhGPa0fuiVMj+I+sPJ2OEcZIhXU+bNK
	LSv0jmxwjp0fakWv6BVJ37epfkZcpJ4M7gP52MjDble5YkEARhyfL9LMDUtsH/zyhN7RqrCQcUH
	dwQkiWw==
X-Google-Smtp-Source: AGHT+IG17UaE2XcNrnu+hPwcqCVZ+jD94deum5JjXJ3TZYsixDPJKOzrUExsSkGWbiNP+AoVE5xx2LFFnzZW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a25:2d18:0:b0:e63:5e65:658f with SMTP id
 3f1490d57ef6-e692eb8fe70mr100276.2.1742917228428; Tue, 25 Mar 2025 08:40:28
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:14:45 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 09/35] perf vendor events: Update clearwaterforest events
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


