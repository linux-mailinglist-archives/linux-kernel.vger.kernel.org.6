Return-Path: <linux-kernel+bounces-575736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD4FA70699
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F064175E96
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33E525D202;
	Tue, 25 Mar 2025 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqZu5Uob"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8E61FFE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919436; cv=none; b=n0D5yR2FNBI6pFi2lLMZW7O0oAppnspFvg51mkE6AOrweclUX37DkaZPXMWx/BKQmWl9LfAmjK4Y7cAHSsY36SN0Q+4LEgkObrxu208KwXPdkw2RwYOFRXVdD/IL0BQFhcopj4r5l8uIUAPjYWzkog2SueoDkJjGirCNp7dG6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919436; c=relaxed/simple;
	bh=Zy0jRafJxRLJGt4ZHFy+/ySVLU1klhzlJJANwxxpiE0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fj4WYmgWUJ1bHQ9oYtvTKxOJ0OzA+QZusFKh/1c1USGZ6txKwLT6CDj45OqzthpDgObTdhVwlzvRrEv30zc2GHgT6qpL/NeP0twt8cSF+Xp+JTTRwhvC72/LIZxZt6asGcDNn+lHugpy2GGJn8hNI81iTDHc3s/RhNhLv59VdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqZu5Uob; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fed889e353so83477867b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742919434; x=1743524234; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWTSLGRSQc6JnxhtpbR0m8qTat7TUVK+43G8X5ABzRg=;
        b=VqZu5UobEhVSfBSrl15mJIOjb9/LNXoEY7qDiUVb2O7E5oCcCA6BwGn6mH9HU7selT
         2Fj7ByuxupwCMngL0pY56WH039RzX0DC9DA6o8Jc2IVCpemQriiX6wtilGa7reCglFjj
         rC/FERusXsJLkDvZ1urbPGWJVlYWqiGlY+VycLRhAreMo8KPVqFKM/SJr+yCqGCmVK+D
         Qzuzg9kR4WjzAUGi1wdJ96Q+4kylZ79M008efkok1LIBPkEje8oLmUgxgmz+NZfjo9uK
         whBAW+dQLXO/xiL38VCPhBhgTaW/v2PC8PgeVzNY92IpfJ3Y4rW4dHnGHu8B0crRztHb
         JgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919434; x=1743524234;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWTSLGRSQc6JnxhtpbR0m8qTat7TUVK+43G8X5ABzRg=;
        b=DTVIh8AYa3Os6aylPstxbWvtjFNzYRHI66Ekt9mbQ1zxrmubMYfOpvBXT4ah/Wh38q
         NDvDoZV6FY/9ikpVttV8/P5NoOz4Wxp/jY1c5lnGvvrBXjOCl345avE82xUtRsaCjS9v
         e5dFpFnkJaNJYBwQW9JFabDJAmEP2K7ui1P5vJgUZFn5S0CRrQBA7qc/4aPgh87TYt8y
         vua+qowLJhrvAE8tv8DkCvzRNMg2NoX5eZ4kphwD6leYQh71fNUI55hgSVw4GExScwRZ
         vCefCvAiWjrRQQWSE7f9edNuvCjcl9Z4Hp9vdxZjmTk817Wjgra8jLTI1Q8qfGNBT5sQ
         NrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5oJPH/UwR+3tRg4feEqM6iNd2UtF4PbzJbu+aNE1tGmQ8e6OesFbBO1+s3pIsRwnM45uXDvQzTkuz3FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLbEYlqTy7uKLfmOaFIdMKNOYt26QbF7zwuZqFwbIiP9wX4kd
	8EYrDtw33Z3pjhvvTmfqyFEPMMK1hJy/fY44MyySnTRH+xDJEj9v7bQSduCpOZMOlplT2nctGkX
	kDBZ2mQ==
X-Google-Smtp-Source: AGHT+IEcIafZTeM8RtrSrfxRcrnBbWhlzqvUzwtQ8SLqh5V/te2Nwg7m+oI+ftjZA4tKxki+TX94s1aDpvRP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a0d:d2c1:0:b0:6fd:2fb9:f109 with SMTP id
 00721157ae682-700bad107f9mr94147b3.7.1742919433646; Tue, 25 Mar 2025 09:17:13
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:15:00 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 24/35] perf vendor events: Update nehalemex events
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

Update event topic moving other topic events to cache and virtual
memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/nehalemex/cache.json  | 32 +++++++++++++++
 .../pmu-events/arch/x86/nehalemex/other.json  | 40 -------------------
 .../arch/x86/nehalemex/virtual-memory.json    |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
index 2c0ea6f8c4e0..b6c6b22a3188 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/cache.json
@@ -239,6 +239,38 @@
         "SampleAfterValue": "100000",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "L1I instruction fetch stall cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.CYCLES_STALLED",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "L1I instruction fetch hits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.HITS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "L1I instruction fetch misses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.MISSES",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "L1I Instruction fetches",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "L1I.READS",
+        "SampleAfterValue": "2000000",
+        "UMask": "0x3"
+    },
     {
         "BriefDescription": "All L2 data requests",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/other.json b/tools/perf/pmu-events/arch/x86/nehalemex/other.json
index f6887b234b0e..5fe5ca778e9f 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/other.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/other.json
@@ -15,46 +15,6 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "L1I instruction fetch stall cycles",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.CYCLES_STALLED",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x4"
-    },
-    {
-        "BriefDescription": "L1I instruction fetch hits",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.HITS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "L1I instruction fetch misses",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.MISSES",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "L1I Instruction fetches",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x80",
-        "EventName": "L1I.READS",
-        "SampleAfterValue": "2000000",
-        "UMask": "0x3"
-    },
-    {
-        "BriefDescription": "Large ITLB hit",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x82",
-        "EventName": "LARGE_ITLB.HIT",
-        "SampleAfterValue": "200000",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "All loads dispatched",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
index e88c0802e679..accd263cfbfd 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
@@ -88,6 +88,14 @@
         "SampleAfterValue": "200000",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Large ITLB hit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "LARGE_ITLB.HIT",
+        "SampleAfterValue": "200000",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Retired loads that miss the DTLB (Precise Event)",
         "Counter": "0,1,2,3",
-- 
2.49.0.395.g12beb8f557-goog


