Return-Path: <linux-kernel+bounces-572207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F15A6C7E4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FB9189068A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887F61F1302;
	Sat, 22 Mar 2025 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7aLPiRu"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13981EF0AD
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625328; cv=none; b=YeSlleAZHE0/JMJdoD5Nh2PpLxyLs7AZgO/cJVCAlxCRK6855pkSwSJV8GhHwkFT7Nf3fbFurkEioxovwA0PXu/nVivntTRpJeDf36iXtKKoshxhQfqmEfM90CBlu0D7kdZfqRzueVToGJqIaIy+xUA37UqRxTPO7opShc4inBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625328; c=relaxed/simple;
	bh=Zy0jRafJxRLJGt4ZHFy+/ySVLU1klhzlJJANwxxpiE0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HdmiA/fYFk1HjW7dufqgkUvwSByLSOKJAKEDuSWYmA4+qfeLqCvMilO6qjEaBbBNKeLCbhYGKZwt9ciYun7+t7UDEBP5xPnOdyHjkIEGfOt/YUZmzU9QMrnh7Y9jyoibA5Kr13aj9KDy7y99F0D75YuP2A1DFWqBmkHI+twuM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7aLPiRu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e63533f0a65so3286059276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625322; x=1743230122; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWTSLGRSQc6JnxhtpbR0m8qTat7TUVK+43G8X5ABzRg=;
        b=K7aLPiRuMuUhzssm/055SjpA5uiYdUJtr2U5C3wZxDf61G/e6npE/59NdHki9f7QvG
         q5sUoyFJVU8L/GSDMnoxLMOX0oikKZj63Dfpm44Ql8ga3O5U1T/vyYkljLzSoyTOQb9q
         jajPtlcnYg1km6oI+Llz3m/4ur1MMmlpJ840D7XdQIPFuYOg+KlQKSgB4TjaVjfXrf2O
         l8RC/6gG0QMNTU3bKVpKp/qzAmZTGWMfxgpIgTb2rCSUc1l8prP++K9NVqS21faK9Tf1
         /HcK5Gn0r/5nIdBYAH8cPtd74x64tGnODzlmaPBWONJDx+sQw7LibR8KmF7QeMROyXeV
         HYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625322; x=1743230122;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWTSLGRSQc6JnxhtpbR0m8qTat7TUVK+43G8X5ABzRg=;
        b=Ovpp4UtCzxFi7tBV6+FN5M1W5FIu7VLDRSFKVeAUbagCs4vSKF3IFEO5qoxw5C1XTW
         jKUQj/CY3jjo1Ar7JybG01p9IrWyXSAyUdtBNZJ3onJ5eZiK+YUbLA0eA3G3oGmyUZjP
         m+/KA3qq8sTIwePGD0qnX8TQwyZNRv2I1eQOnEvKysgQp6iMIQB9gmVnNXEghtzUlYib
         aCF3kEjciMf/jhsLxd9co0ycSIzTLoVMcHVmI+LLMluHRS7cyVp+N6mUzKxYJmYwmJL1
         ZaRIHryDsPMRvcgNiqV68cXX1jfqAhrk8bz+Mh1F4Im3XD0c9I2t290o0C5mAFKdxg8G
         Oa5w==
X-Forwarded-Encrypted: i=1; AJvYcCXu5znJO+uHXFTYzztHckBAEmhvKriXVxSNtkn55SXSQAJ7DdeFQrfqqbHtOgEj9aPLcmoALKudWpTcQho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXS469xmqE4lktbZQTByr/2TVR8mwIU9HLo0EVoGZDy9cHRkx6
	7dvxs7Hco8mOnEMJH9ThbUDPduLTgFiKq4ivbQ84/BAYPWJqv39k/TlHeRVkycUwWxP/JL1fPUR
	zyiRESA==
X-Google-Smtp-Source: AGHT+IGSbm8DZTNj2tJOV8rbZgMWyrPfl+jo6jeiPT8Kbr8VSUps3O4D1Bq9dlrB4SH+pQQcwHWPvmEz+w+2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a25:9108:0:b0:e60:90e0:fa83 with SMTP id
 3f1490d57ef6-e66a31a5fb5mr11276276.1.1742625322493; Fri, 21 Mar 2025 23:35:22
 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:33:52 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 24/35] perf vendor events: Update nehalemex events
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


