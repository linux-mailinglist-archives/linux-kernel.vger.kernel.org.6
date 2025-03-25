Return-Path: <linux-kernel+bounces-575921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A120A708EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877F21751D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E472AD2D;
	Tue, 25 Mar 2025 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUycgX3W"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AD2628C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742926619; cv=none; b=MvFGukj0R14xpp7dMBxAON1LO0NJ/VNr12q+u+vDFKOyg6YR2KcJhpWiG1gllEloHk+xOAYieKHSBn4zVhJRe5SiIRgj0cLhfxPhJxgKcdZlTPvwPih81lP/flJNZrweB38LRRX4KxuM68C1aBOZAKTxrtYY6c2xrKcEcuXKjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742926619; c=relaxed/simple;
	bh=jj7cgVY1dHCdbl7CToIOpx+DtAOgzXi+ZwBseYtASCc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=brgjhoGjXaCrrE9AY8bxHo1i3dg9LYxdv8H/1Q3QMVo/+r0VtzzBE/9N9kfJewBtdZQw3QDG5B+sbt4ptE+J+h62mFKpNAQe9o592FvfR9Tnz5F8BqKvrZGKISKFiRcDUhHY+0AIx7M+UDrWjcWsXFNmb2pzKteEP/EY4WBbA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUycgX3W; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a109984a5so6781568276.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742926616; x=1743531416; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6tXKzMdne0PcZ1yEwuy/OWzqt9sFMlDxjtYmEokV0uc=;
        b=uUycgX3WfflT9XTA4Kgel4i2N6CiYWRstxKroxgRLoKJ+C59kojuTh3XFH9GAvgIrm
         cnrDFtzoy0OxOVdodWquIg/tabYy7gLE5r55TD/KlAGj7eXVR2n1coT7xJ8prDWqK+zu
         VpQIdiJVaychtmUnlBNFcMQv+cCXfWNpPEhoSO6Vf11aYOLgGSAsQ4GUwlKSSWvNMX3+
         wraoZ1cDsTjPvqunI5MqRBRRc1SIam9c4hYkwAvxTh0t0zvcO7b/ole1RSptkbPzsSPu
         pRpyNTk8iL0a7rdCsXAPF67FB3fs1nnNwhy+EUe5S79cbleIC1uer0RyK9lwRjRnbANl
         KRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742926616; x=1743531416;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tXKzMdne0PcZ1yEwuy/OWzqt9sFMlDxjtYmEokV0uc=;
        b=rxLe7te+8c4K/BWTG4O1iNdKg1qahSFaDoRCYyRpi8w2zxITRwx3kgVp19tUhMl7MC
         vsOde/mp+EEohttdu2P7gVO4mOTwgxGyf5IO5XavTtZqcTK6UYMeW59xRE2s/jvrR0k5
         1BvfRPjy8PMyiuKp+OVw8QXmg6YD2Ly+UE8La4GTeScWxdLvou2F9wzA8Iy9g9V/KwvW
         LQvPL2hWxABifrosioNDRhPsiK2hOkA7Fj4N3QHIOy3k3H6tx1OYGkOfgjtfUwcQcqkg
         gZv/cDULjYxwNUPmn+CSVEQaAnUXKsNLadHtF2ASaueR9w2hSGC47FKProUY/yc8C3R3
         UlGA==
X-Forwarded-Encrypted: i=1; AJvYcCUr0IuiXPjDjF40ltHoW0ewnBOe/Oz61vLTEKTBKm345rMbhjSDT2k0j8JHuJE4hpOTev/L+XsJ1+XoPUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7yseiy9fpxhbx8l1XUXTsf+xfUPna8p7J8A7I0zUZsLsVq5w5
	J2+F6nnMKCTPs+N435Plf+W4lCMk4KsJBiCVpHLIMgadYoeO3fUeK9ls+na7EPM7fjivRHqWOO3
	JbQmX6w==
X-Google-Smtp-Source: AGHT+IFvLLsK4KC0ct58SxVAaFtE2FzD8ofvOiBc1gHzSrMXgPaM8r3bU2jjLFu+52AW4OcEO49TsDpetcf6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a25:d696:0:b0:e63:699a:4e6b with SMTP id
 3f1490d57ef6-e66a4f691acmr6922276.4.1742926616637; Tue, 25 Mar 2025 11:16:56
 -0700 (PDT)
Date: Tue, 25 Mar 2025 10:52:11 -0700
In-Reply-To: <20250325175238.50097-1-irogers@google.com>
Message-Id: <20250325175238.50097-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325175238.50097-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v3 09/35] perf vendor events: Update clearwaterforest events
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


