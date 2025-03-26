Return-Path: <linux-kernel+bounces-576335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451CA70E01
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D43189FED3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40F29D19;
	Wed, 26 Mar 2025 00:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZfEbQwg"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6189475
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947712; cv=none; b=Q2oK0hKxBiLjE6wUlVEG6YC0SJY0yo+2zxn5ZrZCuKHUZVbDfCrk4DDoJPkrx8kuWC4cKOfngb1zvbYrrWYfDPAHxgvNoXeqCZhqrWdWlELd5ORyA5THUC1BeKF+ARwYxFcG251lJxYjvSaJTyiMPUpjn4w60Ban2RkwBDTksJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947712; c=relaxed/simple;
	bh=8ECLI9MH8G6GS+TQuT+0Q+DWep0ey0sdDAegVmCJBw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ePYuK75oBvg8VtllvQ50mj7931k8fKsS5CtLqDDGBmJO/YwtrE/Q+OXOSHnztHv7Bs7JtrRB84xSxDjVf32nLI//9RmXJVmb3rVDqvDpfqPRTpgTabt6Pk7C5mxc8lyPDrpbOGlsd29ThncRSMjulrZngM0jUpwz8P5Vl7Nz5L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZfEbQwg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso12032708a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947709; x=1743552509; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTidQqUKCPDZIA1M8BUtNh4exn5q3fZouzrUCwjO3OM=;
        b=sZfEbQwg9/rWEAMk55mHbrreSb5j/KD7k96TLJNcRkBz+LG0PpSYXNOB6OplnpDFYp
         pz0Ubecn6E52f6FiQBc4Vrh8MkkJ3b1ElJ5z8niSAasWGAPibO9OoN6cQGZyakXVLLi2
         bQaoAGbJRgV6obj5/a5rTuuLQP0ri8mz7WSvWp9uk89fAV106g/7vDdwE5Oe45KL7npT
         Fl4HUwv8thTq581UFLiePepgPBvl31hYwy88wnwnGaMDhBRZlz3N8DxFUQw9FshmNMnn
         3dXaMSujf3VmTN+IvDr3dlCQDbUk0XGBoVco2XSbCHjA/jZ4hD7KsLUAPKef8GLbOKqu
         PYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947709; x=1743552509;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTidQqUKCPDZIA1M8BUtNh4exn5q3fZouzrUCwjO3OM=;
        b=LVfB7fnFM+G0BF+HT6MhZhRfuEIRxMMygfVsXzr+FbSY6PKU7RjWV454uTdJPgrU5i
         jmdwHza3MCntncm9DQ5PMn61VpMVNu0O9afuSpfl8T4K6Be69rxaD/VIN9Kq5SZ097bL
         vjg+Jk4HzWec2wtuUmLjAFLp4J/9MHqISy/YznQVUlcSpl1sKcJFt/z/TnYWLFqhlY+o
         h06JGRMd8fpcIQbN6CpWXoTNg0gowSAmpn+GCD0wookQQLa4SgHL87c6ZkZura89CrCj
         ovKe41InRkJQ6n12w0lFIjM+rOW2bywYbgzUWpwmNdcsqBAO9ZAS+2Hhhwcd2dlNNETi
         W7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOXDBR4SE/Vi24CnJBg4Ddm+30SBgfNu5torS8h3Z08Hm3ooMWeUlztUJbFRBo34u90ZqTy6LEmEt+Iek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8aF85MMi5yDYLoeRUCEUQUj8nUL9h3x5OOtwl4J9X5HPuRe/
	GNV8A1Gl3q/0hjgih+afngeCgC2IXdtcU44RnX6riRiJyF1qOj/UhmvFlkerDTbIEdEC1e1mMHV
	MLNKcPw==
X-Google-Smtp-Source: AGHT+IHju4jV+R4MSc4FY1DMNx0mZaSamn1X9LuuzGH/pNZeR4xRlmoICP+RJ9tRjsBFyq2CAwPb/Hw0bheo
X-Received: from pjbsj16.prod.google.com ([2002:a17:90b:2d90:b0:301:a339:b558])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d88:b0:2ff:556f:be8
 with SMTP id 98e67ed59e1d1-3030fea91b0mr35591159a91.16.1742947709359; Tue, 25
 Mar 2025 17:08:29 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:21 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-24-irogers@google.com>
Subject: [PATCH v3 23/35] perf vendor events: Update nehalemep events
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
 .../pmu-events/arch/x86/nehalemep/cache.json  | 32 +++++++++++++++
 .../pmu-events/arch/x86/nehalemep/other.json  | 40 -------------------
 .../arch/x86/nehalemep/virtual-memory.json    |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
index b90026df2ce7..c9d154f1d09a 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/cache.json
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
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/other.json b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
index f6887b234b0e..5fe5ca778e9f 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/other.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/other.json
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
diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
index e88c0802e679..accd263cfbfd 100644
--- a/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
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


