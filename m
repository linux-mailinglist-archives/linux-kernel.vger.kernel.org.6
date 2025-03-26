Return-Path: <linux-kernel+bounces-576347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D6A70E16
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB031884787
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B53F19D8A2;
	Wed, 26 Mar 2025 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0llqRrk"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405EF19D09C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947827; cv=none; b=DHwYOhQpSPVQe5nMYqpYqMEqRz8cF2mPSFg3QkfZZhP4fTilErCO+2bWBI/aCmlAlt1efpofslDjNCvXzbDmu2dNmw0hj7xH4r25nb6f1vvz5wr0EaegpfR4tKMidsYl33+KZN+jnfB30fGs9m/9mdkhJFBucWDfTcSK+UIMiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947827; c=relaxed/simple;
	bh=ldgIIS6qJKA4PqUti5NYcAmN4SsICYce46h1OQ5emEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FgPflTM7ybLYSKXR8PtIuU6bpauBbShhKnvhLDpEUvlR0uvZIYeo0r2EFd3KajAnVeddz3bDzG+5x8KX7JTvP/wJBs03TXquaGqRK2rKCl4ZvJgjqs9EnMwlLn7jxZZm1ODYwUAgNtIo3grv4dkT1Tu/2IiiSSbWJV+I/Z2Kc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0llqRrk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4eacd8so5812254a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947825; x=1743552625; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XET9HH8V4TfXAFNsd7WcnaOZ0oJ/0MNCJs/F3W4WSf4=;
        b=G0llqRrkEjceaPgc7p+IXGUFW5jg1xOl36LeV4GzMA0EOefln0xvIFbAzKor1mLsy8
         UlDWsvsE4J9ZRAQ0ypTe/tve6FK0blZVIh8eyhSMapCcLR+DadmitAfj+d+fB9m+wLLs
         x6vNw4ayD2+eM7GfXm7xTkdOQvg9xaKTha2qyJQZuouBmXo+jSak/JW8MxOA/cdQ9UJ9
         5es7ySPLKmb2bUb7mIsc606bOFAfScn/Rg0UKUzB20soP+Xc967yogwvX/oTJjDSPZ0H
         Fk9P+kasGh9UKkxBMM7+SLQi2cC8wzj45FPHp8I0DES2s2UWP8eVqu4BXaTJ5pNodOun
         d5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947825; x=1743552625;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XET9HH8V4TfXAFNsd7WcnaOZ0oJ/0MNCJs/F3W4WSf4=;
        b=X/PdbBl9ZO3kjl51+b4IsAKWIl3FRvbbOKYwfCW8Rn6isejl+rksSoDCJqaomYrvjV
         8Nkw3M2loR2hzOYtfLTc2in8JfgoWPYtFNtCcKrswB5btKqGtN0o1sNEpG1F/TZNnJzD
         uDbKTwmKSQUb1xb5GIpoAiggWhZQ5NZZ5NXYK1QbajbIC7ImBzK7hy6hqoWpMm/CX5uh
         tz1XYg/A5NKA4s0VIu1l4SeB3iGxbO4oNFEu14RmJ7gTC8YgBjDQwYk4tSyDsLT6hok8
         X7uc8bvxK9NigiY83Hu5I8RIoRLhqpmPHhDkW26ICIBS4pOf9i3G5GtA4d0096yjqiHR
         79eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDpf6eaUzendriEWDmIYX5umL7uki/ngLOcxcWf1OIi3ViXNFPH3U+nO91BuMwiR7PCOXQyDs/VfhDaUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFku/wkhbYyTkPEqXC0nElQIQngf2y53XYzFhaYXLPOX2paEAa
	NUigu+F2jweTbaplpVpU0/f76oXu8W7FMmdN6bvi7S5a1ontALkI3yZ2q/FIe7rIgATF53zlLtF
	7y7goFg==
X-Google-Smtp-Source: AGHT+IHFG8eaTHAVrj6Wv9IPR8ViyWjLI07OlR/vqWh01D836EQzijuXH0iKYW8evnBwhKcdgQRbtEFSW0HL
X-Received: from pjbsc11.prod.google.com ([2002:a17:90b:510b:b0:2f9:dc36:b11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:350d:b0:2ee:c2b5:97a0
 with SMTP id 98e67ed59e1d1-3030fefe3cemr25488985a91.25.1742947825624; Tue, 25
 Mar 2025 17:10:25 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:33 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-36-irogers@google.com>
Subject: [PATCH v3 35/35] perf vendor events: Update westmereep-dp events
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


