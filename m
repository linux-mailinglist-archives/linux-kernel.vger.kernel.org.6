Return-Path: <linux-kernel+bounces-576032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D3A70A24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BD4189ACF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD071EA7C7;
	Tue, 25 Mar 2025 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5NNWKX1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A691C6FEC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930301; cv=none; b=nyngmIhq41ItjfYFdOK392aRCI3iWtR3zporICmDsgnFfNJsMUf/6raCSEryUXlKu2LXD+PLaZgt2poUDhUIqyTBZh7IVR7RiRKqUy+i46DaMyKJeayWvaPXKecGM1cyce2TG67BgoUOTLQgfb6F3IiZMrHs9LzvPjz6m77Jneg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930301; c=relaxed/simple;
	bh=gzOhUwuk6PRtqJT004lFT8JmHmf233ItpyrfAz7UByY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=r+erZ4QL5Dlhf7t9DFrqhh7oWBvRAN1NJpInd96ZAqIZqN0kyRIiyJ38v5kjzoQ4tpqaw3xEb+Cx5I8WIbQVdyHAZKziDa1CSQOEMGvWZp1LDnXeLbsMwpHr82vki1w7FpwNd3uBPa9tFC/6vnEcAJ9Yyg5YPOEDhXOC/eHBSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5NNWKX1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f6d40a61e7so89996017b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742930299; x=1743535099; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=S5NNWKX1oAkTzUNk2JpjwzQZjElniubd/TFcu5X2Gf6GWSISwfaS/qvrwRkWpRlyDN
         swfCldb3Pa2Zgpgfz/lnkaVsRJ2bJBcnfyUj7Ao4ndbgbGnWjrK3u3fcrWrS7b/MmMA3
         jB5u2U1V8IZlC7jAGj48lei6FFQGUjGPs2zN0wT/Q4zPXGT74qQK/M1iVWWwRbF0bjl1
         511baivNq8dyuOx91C5ROQ9UVFMskMqL+BX8zl6bHrvMOXmcNLEuOjwQGUDxJJsomZlp
         v0ahWl2+8aSEtf6FVsnBU9QIn9Bk8jdN6Z6cRL+t6vJHmxv+ENZMIQcXg1iNN/EH1qLR
         mZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742930299; x=1743535099;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=ghX+CYR+YxpjXFs9GV2E0SaE5eUcSdkCtEw2R9ZrwOG2QZ9b+4BtQcKfXJLhcYOESk
         TGgw8l6oxIFaiDEj8wmdFP+sxxf+9ZsDKwqiVsj+lNbmdZq6Gk38F40sySryRl8i72Hi
         X/14DYuCPFZlZ4veo0OvGmNY4w3pz8pVL0VTk9nEmmTdgtH89LbkqxlhnCjyzG2MxXZA
         789U8dt7oXKLbkgn71TH9Hx5V0zGMcGaVv4dzOVTEISN9/fiTZK8G7iCeoMk+aBXbwEs
         6Miih2gOgIGOUUzE+PDRD6enhNd4bu9RFZbFi58yhXSperMBGloS7F2YDSHPtEPgN0x1
         voZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxlgpL5Kj0oNY9kJsQuHNj+7GyfgIjmtn4ux03Fnc3xwIH8kB3tTDtkYSvWS3AuXy58+X7XZL/X9euhb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZ8GkcGxUIvdmcjkssKGi5iD4xi7MdIS9hZ9ZLlX22VtybyUh
	iGE3UsekvexYeIGX8ydWchL9ubiLp1UA04vXgyI2sT/dk9lcNQp/hru59dcXnMr70x7FILzXY8C
	gUv2sjQ==
X-Google-Smtp-Source: AGHT+IHG6EbMLgHhgV3KGXgXmrIM18FNa02aejF2j8HY3sgrmGHd3s8xloMIuaepYOznr1nEt/KGfkpZgz6b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:3b0c:e5d7:4752:a58])
 (user=irogers job=sendgmr) by 2002:a0d:e546:0:b0:6fd:2b82:af09 with SMTP id
 00721157ae682-700bad0a95bmr128807b3.8.1742930299148; Tue, 25 Mar 2025
 12:18:19 -0700 (PDT)
Date: Tue, 25 Mar 2025 12:03:20 -0700
In-Reply-To: <20250325190352.59241-1-irogers@google.com>
Message-Id: <20250325190352.59241-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325190352.59241-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v3 04/35] perf vendor events: Update bonnell events
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

Move DISPATCH_BLOCKED.ANY to the pipeline topic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/bonnell/other.json    | 8 --------
 tools/perf/pmu-events/arch/x86/bonnell/pipeline.json | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/bonnell/other.json b/tools/perf/pmu-events/arch/x86/bonnell/other.json
index 3a55c101fbf7..6e6f64b96834 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/other.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/other.json
@@ -323,14 +323,6 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x2"
     },
-    {
-        "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason",
-        "Counter": "0,1",
-        "EventCode": "0x9",
-        "EventName": "DISPATCH_BLOCKED.ANY",
-        "SampleAfterValue": "200000",
-        "UMask": "0x20"
-    },
     {
         "BriefDescription": "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
         "Counter": "0,1",
diff --git a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
index 9ff032ab11e2..48d3d053a369 100644
--- a/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
@@ -211,6 +211,14 @@
         "SampleAfterValue": "2000000",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason",
+        "Counter": "0,1",
+        "EventCode": "0x9",
+        "EventName": "DISPATCH_BLOCKED.ANY",
+        "SampleAfterValue": "200000",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Divide operations retired",
         "Counter": "0,1",
-- 
2.49.0.395.g12beb8f557-goog


