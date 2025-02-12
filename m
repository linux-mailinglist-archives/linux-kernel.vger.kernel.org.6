Return-Path: <linux-kernel+bounces-511512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C892A32BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B7B188C03A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41CE20E01D;
	Wed, 12 Feb 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUYlGpuP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B371212B31
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378367; cv=none; b=aWPXqeg9DSt4NGaPkjlRpWvxvsoH3QI9lvDZnqaYsI7QTdkSlesCw82Wj4TBMQ3AmQI6fYGZba2b0jevpYJ1XheGAu5oEhTm4sXNTEMSb2jocN9yBq53qKZ37/i97eotGdtH3RWi4cI+i3atfftf1789VNRVSCYqcE4Dh/HMtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378367; c=relaxed/simple;
	bh=+eMDq7a1WASW1tK78E/Cqn+dmwMKWRI9Ii6VvIFaW+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FmQqlKae+QYUafHunfzZqwZKIjW+Pq28HhvtKuXJmqhhDwObrmHCYE+Q5boKfiMvNVjfGkxmFo9Ci6sltX3/2904b4xhS7NAdtmKKcRCb/8BJA7l/29Wr9D8pRbt4WYsKTrozPvtDQ9ZWOK1eWe69S4kRhXoSc6FrEr4UFPATJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YUYlGpuP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so27034205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739378363; x=1739983163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HuH5juQfbtVrRriQ2swAO0bGkJ18n/NWAw2oombbKL4=;
        b=YUYlGpuPIZoMa36IxXhXz7EFjODz9mylITVi9/gj5QVb5wBPTUbpyfzwZ9T8lewvoW
         ZSTY3ecZ71JOZID9OsE+SL3wybQ6yOnvAK8yhdp/d/OGTUQWDg38NMiDaIE0xZzlCVez
         xQYaSJXSEtn8gPCtIqZsCh/apTIs0ldo0Tl90yHgO0yNxoEMFe/+HQUC3cJKVRle4Bpf
         kRU2J1Ba4ik2w3UalQagxXj/wk32tW5gi/vbnDm7elWX8uWapcGHO0VGwS/xP0BLogGZ
         RxZofNEnpjFL/PguH1MyqRrV5lb35ghT3ZuSI5LMcKFV3Wd0WeTGDvlIsQEJOPM3rx8m
         yr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378363; x=1739983163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuH5juQfbtVrRriQ2swAO0bGkJ18n/NWAw2oombbKL4=;
        b=OKe0mkK2Q1Tquc5bLoS2+Bu+wdekBstxwtRRo0ByzW54EC24AO4+8wgxd7wuv6Mn44
         v+FcmdSRavWVlKWrgiPOGklbqjgnsD9ScIUug+BxcUfgFY+L0pMD1HYECWTr2KZZSIiS
         uzSWylsHbPQZi11PHBhqLtZ1vi3cA8A9Ybr/wYNZSLIrKGFELt+3SWiiPqGLtDjXj1gK
         CRse+tK0pEY939xPYQyfi+Id4r6dF/0IVdXFXoVFOSgUr6+gR9qkutWKVY9/T3R2joBb
         rP2UGV5i5LxCcg2g0t09UDCWP8fkbTwDbmKbJjUehBV+zK2GOmhzTBuMVwrDAhrPh7Kx
         Wplg==
X-Forwarded-Encrypted: i=1; AJvYcCUzBzX3Rlts+XqaWxEpwZ5+YfWY0xNPiqoezUbAlJyBrFLZaY4liO8s/wfIw96oBnuWagpjARzrJyAtRgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfsSvGdWwBJH0Ow2H5G/kXLIJ3drMIBrprTtyK8T+eT6eO+ev
	ftNYYvguZ9QjRtCLi3nCFZxct2s5SiYCytFfjHQ+2ymU6zt/UZPt+SaDnjPUba4=
X-Gm-Gg: ASbGncthPP3WiljUmz+7yS+rTLl8SlWX7VVJImW4QgLBTKIMoxvyzssNR0gQ/RF8jWi
	YnlafaMBpkeG150JMo7KIJWm+eH2J4Wj/t1oK5l3GdsyLi4jfe/a++NNHtDyByfgz8xSuxJ4Syc
	ms+QcGSJQDSupnDZedAIbgKnbBotdiTY4Vgnx/ByYGjOirhe5b+uUKfVbUpf7vFuP50D6deBTKp
	OD0m2Zcoa5Ip95zgcEzpl8CXtuN3JKmyqhMhDPud6Du2FxxWV/mMbM7QizxtuHF1ji56SL2TlJF
	NxKGUMz8McDMo6Y=
X-Google-Smtp-Source: AGHT+IFQkNgSgj+b+OY+U68LNI2iDcNuJlSGY5kCTa6FX0VTYZQH0d+xekmaicVjKu0OmPPm3D2EZA==
X-Received: by 2002:a05:600c:3b92:b0:439:35d2:ed1 with SMTP id 5b1f17b1804b1-43958173d7cmr41389945e9.7.1739378363549;
        Wed, 12 Feb 2025 08:39:23 -0800 (PST)
Received: from pop-os.. ([145.224.90.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a05392csm24519645e9.10.2025.02.12.08.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:39:23 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf tests: Fix Tool PMU test segfault
Date: Wed, 12 Feb 2025 16:38:56 +0000
Message-Id: <20250212163859.1489916-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tool_pmu__event_to_str() now handles skipped events by returning NULL,
so it's wrong to re-check for a skip on the resulting string. Calling
tool_pmu__skip_event() with a NULL string results in a segfault so
remove the unnecessary skip to fix it:

  $ perf test -vv "parsing with PMU name"

  12.2: Parsing with PMU name:
  ...
  ---- unexpected signal (11) ----
  12.2: Parsing with PMU name         : FAILED!

Fixes: ee8aef2d2321 ("perf tools: Add skip check in tool_pmu__event_to_str()")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/tool_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
index 187942b749b7..1e900ef92e37 100644
--- a/tools/perf/tests/tool_pmu.c
+++ b/tools/perf/tests/tool_pmu.c
@@ -27,7 +27,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, str, &err);
 	if (ret) {
-		if (tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
+		if (!tool_pmu__event_to_str(ev)) {
 			ret = TEST_OK;
 			goto out;
 		}
@@ -59,7 +59,7 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
 		}
 	}
 
-	if (!found && !tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
+	if (!found && tool_pmu__event_to_str(ev)) {
 		pr_debug("FAILED %s:%d Didn't find tool event '%s' in parsed evsels\n",
 			 __FILE__, __LINE__, str);
 		ret = TEST_FAIL;
-- 
2.34.1


