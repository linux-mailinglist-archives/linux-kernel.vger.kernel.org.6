Return-Path: <linux-kernel+bounces-575905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD3A708C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E203ADE12
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E73263F59;
	Tue, 25 Mar 2025 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTQY09sk"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B112641DB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925865; cv=none; b=dJlU191cua0nJ+hAQ2GnnNkPhm3m0VuFnDoBoPujLxq7S/L82ZxX58/GH51ovzTEiwzQA2JwSNquH5JlD5ZqpEa7hAglfr+udDA+GPLqwKoo1OECwt17Q6UHgIlV4RxbtuaoM/WPtLPQhTog6TiarNPkeFN3k4M0mktZslIImQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925865; c=relaxed/simple;
	bh=gzOhUwuk6PRtqJT004lFT8JmHmf233ItpyrfAz7UByY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=K6lEbH47sS6trd7+I0jYj58fai9E/hX47trtdSHQ+Tu3elQbM+zwnxYiN4YWL/3IrqUrmLAaSZnFUGMcNOy1lLxfuDlXhtMVn8RCRxlT56y34tAviqrt10RZUTwLFcW4nA0equXbir8/qX7BDIZOj3QLlbcwEO82PbqYymwv01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTQY09sk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fef68b65c7so85934917b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742925862; x=1743530662; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=OTQY09skPOgs/OZ+dqEFTUqb/7FFv9tEDewY9sU/ay5HVhIwVEV+HBbOe33VcgOabG
         9ZLGu5e3wTvTLPvaQ3H9/jmxqZvxXdcDW/BiINQr9mi+jUctL1DqN2/n6SBsUzRQK8Nm
         3bEyk/1yFQWDbB02K5War90HtEDn05LntOwDo0fiWVKaqJMVWCKBqdoOeqCnzdeSq4eF
         4rb+95cukMv9fgUJmTisJDJ3pdWxeOyvSY/NLyOCGJ3VZFB5EhdenJr4leFjS+ojjCz4
         XNuZFVHPrdbzD+RMeVx2WfdbZJyb/wSVm0EC3dBBA8itvz1hcQ8Iqxmg95Iq5tHO9Ktj
         JPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925862; x=1743530662;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=jVhPnsNhpGCL5ltyGBd3Yn9YQUvD/qlwtfKvQWMj32I2mRvxqyCQXMVlHMTkectPac
         6rYpbKXW1J8UD/pC7+xzLwbYbx+DscbBr3mqkhITKtBlKZzjh4OB28CLpClPIyIHtwIb
         UyP8JnelK5E2etLP+aThWZAsTzenBw/YhNOarRdMUSO8XpkxvAGg7rZpmiGLtbXHh/lW
         B9YktcHGMDr48AKX+V+6CDTFL5HKzhZmS7VH+RfCEFwwbhPmbTgbr6nyyiNCpBJv7wlk
         EHIlqr4iWtLP8gEaNMoe7LFz4eCq7FPvCUSSzbOUWZ/Ceubdy6Fjsmj1W6fTTvoyB7PW
         gvig==
X-Forwarded-Encrypted: i=1; AJvYcCVCizRU4aA5VF4ataw5gmgZJDUbVfwXWq3W7hivK9wIzCB0RHBqds7hcjhCl73iG4tFY+JFCaCgFdDrFCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwipUpbdD4LsIhOKctfr3CbbeYjYZ3uy3rXcSP1dKcw5ya9xG
	r4Ddm4s6eBHpxrY5zPbEmDNFYrQjHOQHXMp1vwb7IQGuanE9Fnkg/HoeeXCXVSqoKfuu53fzbdc
	Gf0+FJw==
X-Google-Smtp-Source: AGHT+IF9YyhxapdXHQGbuCilvl5dw4vLR/qivzVgJCU64mtJ0pTHlLiz6AT33fpup5E3o2UqI4xlMfSVJqTk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a05:690c:62c7:b0:6ee:3fb4:45b9 with SMTP
 id 00721157ae682-700bad0e08amr891617b3.4.1742925862538; Tue, 25 Mar 2025
 11:04:22 -0700 (PDT)
Date: Tue, 25 Mar 2025 10:52:06 -0700
In-Reply-To: <20250325175238.50097-1-irogers@google.com>
Message-Id: <20250325175238.50097-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325175238.50097-1-irogers@google.com>
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


