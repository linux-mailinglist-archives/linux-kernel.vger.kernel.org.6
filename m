Return-Path: <linux-kernel+bounces-572188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112D1A6C7CC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359B71B60AC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7208118C006;
	Sat, 22 Mar 2025 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sv6SlrbF"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669C18DF62
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625275; cv=none; b=ROzbpEtK72RcHaJRaabBrX0g/NggsddC/XXvF3ZWIjv5KBP1KXmq0PRuL+NWVO5NwxIeQyiDAS/Fer+bgQ/UkWpwE7noJB9IDh5VcAZsX294Rd3y5zOaQL5fWeFA25a4A6So/ZR2RcuwKkKQEsn2vUAIg0+F19Kx2su68TbgoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625275; c=relaxed/simple;
	bh=gzOhUwuk6PRtqJT004lFT8JmHmf233ItpyrfAz7UByY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k10YtizsLseBMWYVU5qwdCCZPvup3TrEWf9LsmoWsXn0lD/tBfPdPUpxaQT61Tso/kxaLwrx/7VmE2D8JCxdZReeA0qf4o8FPWMnEQYFWrCKGNtc8oKpRGXFBNYD6e/0Hi3iTrI/tAfFeJ6EiqqAOmTNu1R9k7XNfIEYHXxpFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sv6SlrbF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2737d115eso32913647b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625273; x=1743230073; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=sv6SlrbFrg8iuKV2ImtsDiRkbo5I0frBUahs3rqDpU//h9PfU79oH+njG7RjVXHVoQ
         wiLIMEJYhOn6KKhv5oQDSa/erO3gkWoDZF0YOJhQ8OggUlOjOqJK0Kd6hMuMbtKCyEHk
         b2sS4ALe7vzj/OirNchS4NyKBMm17VvnaAPJ43ZQ4eZjCwtvVJfGG6P1MMObAMy27lDI
         BDa2tbBdIv6peaRLl8w3tuxfQhckaeCm9E67a8jKTfo0Ziqy1B8wY4TvpiMfUpJ9SaU9
         osjGK6/DRMto1ohTVxp+P8iegL2EUIQcJQMTmukPHK6dwIxLP973KHvvFyjv8AoNmmvs
         8Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625273; x=1743230073;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=h1po94KTiBSKKidWcoXUxPbGCTnBfahJPdz3LVFMTM0QuSEUGd5Cn7PGMLIdxJiTzr
         4Hn7pS0pUgcUtSO+0mWrp7hVuO7nITczy9Ff6sEDqg7vLBMfg2MNszW3DLitfwe0k+nf
         qjyOjJvBWSA+GFsOD3M4JMoPS6r59drakf/4sLfgQPY9QQVsMeHAeI/9D7OynUM/oZoH
         ExjTeZDkHcaT/YAaQoHNbLrQzxD9HSwYUS4q9rFA/H388l9l5OHCwBTtW/z9tYoWhU+D
         Lvl6NgjXghlpVQ3W2Ax0hIu2P1aRATfygVtD6tIxhAzjVu7AWvuh4f161D7yo6YAFYce
         ei6w==
X-Forwarded-Encrypted: i=1; AJvYcCWXeluIs0zxDSX0RYQszqyoJeDcWKBzBRuXqgYovSo5nGYl87y/7v7076rYdE+lrweDg1KLGYGaljAzAw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1f0msGtc+eT//YW3Xcr82YNxckho+yUUB7Zos+VZp27deK+tX
	l7/KrX2YDajT9el/CSO+QrsefEy0pT11IAEtn3MQVqRFgprjIizYpuxpoLt3bVVE/vh13UimTwM
	8avb5Ag==
X-Google-Smtp-Source: AGHT+IGoRZBLAATkk6CrzIJdrb/6KBcOQJLgFpEERB3mzffVqwH52k6KG5j1d1MvINvdpWH0bTkiN2xUQGvg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a81:a844:0:b0:6f9:8797:a245 with SMTP id
 00721157ae682-700baced0a6mr29167b3.3.1742625272412; Fri, 21 Mar 2025 23:34:32
 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:33:32 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 04/35] perf vendor events: Update bonnell events
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


