Return-Path: <linux-kernel+bounces-572218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6811AA6C7F3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFD01890822
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FE81F6667;
	Sat, 22 Mar 2025 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5nw0xk1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074CC1D5CC6
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625356; cv=none; b=gfimEAxj7EIis2gFXFxDFwFI5zNJeIkrueXOw4IKncpF7y49NCy/4fRhxyyOxWPJOcz69Eymfc6T6aZ34JVbGAJoekEWmPI9WOU8rumLVY3V7P5RxvfUqsyreQJRidcM7ftwRmaY+a/gGcvka3dqt7Ge3yI33iTILcMQdqRps5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625356; c=relaxed/simple;
	bh=ldgIIS6qJKA4PqUti5NYcAmN4SsICYce46h1OQ5emEo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=A76MObDxxgaY4OlKOZTcXq9/wAw/2VD33btpgjBDJcdwYGf/UIuWG9wokSaXnXeZb8T7CzpyR8wAO6Ul8geTc2MMi6HqTBlnDW/hjnuBCPNeJ/djgj0DdwkeJOTn3zvW6sO/fDshdH7DfY+PXzLyMOHahTthgTPlIaWET1IzKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5nw0xk1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f27dd44f86so35987127b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625353; x=1743230153; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XET9HH8V4TfXAFNsd7WcnaOZ0oJ/0MNCJs/F3W4WSf4=;
        b=B5nw0xk1NhEUnN0T2zfqw82Ef0lk4CN54vcwSPP86OTTFp/z2KFPZzvADQprYz0IC3
         HpZmHacjLUIkxF1KofChB0f1zyUIVyw6DV/0dnKSHArxoDg3xpYyAXaeinRpGTEj79hR
         fy2J5gXnPu42qt2yPT7qyTkbM0/6ghuKxH3qOoFUwgzFMqKtFw3IiJrCOy38pakgsil7
         Y1M9flUlCoSYPLjmshuLAToLGV97N78N7gOUWxp7ntWoB0tI1WO8UYJSbDnYTOVV/rz1
         521EJEDbf7abujjCTmP8SSHpNDsJNVEMt4VWVmsmNsxPMNLvGqou45Cx558ODMZToM4z
         E5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625353; x=1743230153;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XET9HH8V4TfXAFNsd7WcnaOZ0oJ/0MNCJs/F3W4WSf4=;
        b=AROigSAJXuXFUmPO4YDrv2XrRBbYTAYr1AuoL8iEdvyHMLBfhD19W64AJhQvKH/V/p
         PytENbMFaL0KNdA+ddW2fCF5J7BAu7klQ1DLuF2I7Q5NuiB/OL6ALWaPM3TOrS21saFa
         4yYjUPOsFEQOP9sZydEz1xyed3PStz7nhBM8YEdbEohf4DVa/Ew6cpjMGbb/TgR76prU
         RuaZxkznKu1MfuB/Go9QyT3ZGCMN0pwj0A5PE1IxJYDX4iDaQEdCUztrQ478o5N+fGWE
         qPRgIflTFAWs/3lfREZl9QwlGy0/VXw96jqzJgCt3zOOwJUGx6r+M+Y33oaaij/XwV6s
         Sl6w==
X-Forwarded-Encrypted: i=1; AJvYcCX/5h4Zy4M3hxzuz3ZWPmIqOsMitJjbM84xxsXuOMXiqerzJxSKrcRxqIawPbefoSifUgc0vGvw8ARpD1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFvXJOKiP6Z9H2npOQoJ+W6AB501NhKvTqr8VM+N45g6btCYJ
	x6Ub1MxZPIuJztNa99dee3Vge9MhXr5W5d71LV2HdD+2MLyerSYhz8YRLtNwJoUjYfe8g1lqkUP
	i955UzA==
X-Google-Smtp-Source: AGHT+IGE6LS58FWTpcecky7/duYOa1d0qwi4FZCOOefSBHXHy8h+SSHpUy73+FcIPAjAWWsHQb5Fobqeqm8T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a25:9090:0:b0:e64:3d36:bea5 with SMTP id
 3f1490d57ef6-e66a4ff61efmr5909276.9.1742625352664; Fri, 21 Mar 2025 23:35:52
 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:34:03 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-36-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 35/35] perf vendor events: Update westmereep-dp events
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
 .../pmu-events/arch/x86/westmereex/cache.json | 32 +++++++++++++++
 .../pmu-events/arch/x86/westmereex/other.json | 40 -------------------
 .../arch/x86/westmereex/virtual-memory.json   |  8 ++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/westmereex/cache.json b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
index 9f922370ee8b..2a677d10f688 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/cache.json
@@ -119,6 +119,38 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/other.json b/tools/perf/pmu-events/arch/x86/westmereex/other.json
index bcf5bcf637c0..c0cf8bae8074 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/other.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/other.json
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
         "BriefDescription": "Loads that partially overlap an earlier store",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
index 0c3501e6e5a3..1800c6ecbf80 100644
--- a/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
@@ -152,6 +152,14 @@
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


