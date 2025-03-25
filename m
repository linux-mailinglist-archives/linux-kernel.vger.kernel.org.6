Return-Path: <linux-kernel+bounces-575732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99922A70693
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51323BF2EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026F1A5BA0;
	Tue, 25 Mar 2025 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Byo+DRg/"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C38257ADE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919310; cv=none; b=HGbcG5Aly5yvJ0l3gIxNKAWnxl7aVsMzDC0tF60I/NMOJwxGWjJTxW/8NtJ0/l35g6KfPappIw1pw2//mfQyc8jQR3k+ZDmI/FQo2AY2b7ZTXFpTzYjqzytGdjBSWmCgjVc5wf80/79+UzsECKrosC/elGGsFPQJep1eu5iGTKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919310; c=relaxed/simple;
	bh=8ECLI9MH8G6GS+TQuT+0Q+DWep0ey0sdDAegVmCJBw4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DXSDuA9jsyvTuc1D4KwdwEOZxc6j9vCoTO40VlhrHTTdcTEnUc7zWv6m66K4LEakFDwDBNBH5ECKnFZSOfDJ9tFJRr331r8fvhAbtc4h7n7uDwZzJh/RwD7M5IGslOnL6IzB+Cpw77YRVEw20NiXlerYiSXscNatX7hB3+E5jyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Byo+DRg/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e6432a0dab8so7603892276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742919306; x=1743524106; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NTidQqUKCPDZIA1M8BUtNh4exn5q3fZouzrUCwjO3OM=;
        b=Byo+DRg/Jpf01yN+mYcEidE3s1iwNH8GET5e8JWKEBBRFBC9o80R+jrn8H0C0MU6ly
         +8Taos0utPzT7LRAeDBfDVmR/XBF++KZbINJq7K/u9lkShj7mh+s9WRZKgZkibISeNOG
         FR26FbUOrXHYev9aWSdA5adNuzUx+JocQBlGFuuZ5Kj+W3cKHqat2qbCspGwNQBWKDrv
         L5WGdlkQZx+EToLF527DZPxZdyO/SNwY6NUmCxRBPtWcOMogOHJ0GVXMKuqO41xdMiS+
         yobtSGXk3REnXqp4niOrQ8O4zpKyjkgySWB7uV4I/wATURP/6E3LNQJPQJHHr5A7vzbM
         qLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919306; x=1743524106;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTidQqUKCPDZIA1M8BUtNh4exn5q3fZouzrUCwjO3OM=;
        b=EZq/m9vj/yrhCIO4hUenBxWzF/YQjqNqJK9qAIGBJ8cL0Wv0pMzXnB+ren+Z7Cz2Rt
         BaK1OVM5YIfDogvBi8pObF5nRrwDVmHiHk1ZJXmTBw5ghTktoZSM0XBy/RH9gjtdXwKS
         taMZ9fzh9PFLxH7n7OUl0lovDjgzmDyc4zJF8XR6hMjItptQt3/tBAYgFVXxtQ470gN2
         kjSwhLGiCH0/tRlQrgqRYTGzOwB4yl8o1M1BluEUODXXbfvI5VlQv7Uqxq1Tgp4Q1F3v
         53UdmP60ti6cHwrK9QARc++ouqNTph6JADlkmjwmp/iT46sNLIVqrJAzfEHjMWQSFg0e
         34Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUBaw3Lau+Xdptr9ro9On9ot2jT05o9AUZY20Pfm3AgVEphxe7dTYABiNQZ5IZhGuPYx5s37X550uSsqUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPEsslSbMhr9RwWOhkGMc/nJHmBW5KX4iLDCJXGq9RBz1Mgv37
	3+PzSu/dps7o/Q4QUSf7nTj09TzvXPjZb0xJ5UrDZABJLh68toRz77JperMK+M1L3fvYbPs0e9M
	4VoLOzQ==
X-Google-Smtp-Source: AGHT+IEtNXoWv6KEYbtcWvBOYeitom4UseomuszLQnbKoqHGGFQS9wpHj+8nfZZBN2w/KekwxeFfPG0+e8Yf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a25:260e:0:b0:e60:89be:bc51 with SMTP id
 3f1490d57ef6-e66a4a7aed5mr10977276.0.1742919306235; Tue, 25 Mar 2025 09:15:06
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:14:59 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 23/35] perf vendor events: Update nehalemep events
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


