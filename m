Return-Path: <linux-kernel+bounces-575634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F10A704FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643CF16761A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E64825BACE;
	Tue, 25 Mar 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q991Rvwb"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D73253B68
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916487; cv=none; b=R/5w2/aIZ6ywE+B8Tc8e3OPb/HO7OcoADNnYPjH25jnyHuvaP9zuELw42KBHUF97gSj213kaOxOgeBK1gerhUy3rD5GDCgla9tJf+l0xfP4LNYcfKuf3AbRHJPo4stJAcXLmQpO4P6/PxGNdjHyVKMSoBE8gyYpTckXwV5yE1iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916487; c=relaxed/simple;
	bh=gzOhUwuk6PRtqJT004lFT8JmHmf233ItpyrfAz7UByY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=po6s3uWhm8qI+EMgtclf8MOClz06LZ6OisIRmIkF9G0egoxpNb3yZ/lgoGwNfoi1GNhjHoqYO2iiG+5NhgtJmmqVbHvxqz2c3YOe6M23XK5eRv19v6tWsg6JP0UAM1wksDB5rbDUrVZUa19DeX3ldpQWCQWzXDtpUMTY6XOHYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q991Rvwb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e63533f0a65so6873899276.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742916485; x=1743521285; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=Q991Rvwbh25QFVgJjw5d6el5tFvf17PgGBBePQ7w/ggPUWQ3//5tGUADxKh6M5OWfc
         KV7MzgzZtLY2ajrvmjJQF2jD9O/2mybWNg1qWpUWYB3wFL/T3yc1MnnBaPStcigin0y7
         7mErtx4xgYzfFuUcNK//kxe23rCpcb/oGB9ZfO5lbCuHUnD2AmhC+HJSbeMvB/AsUe3U
         l0VK4bLemrqARpd4ASpFmQuX8WzHV/bVpR1VFGJ0asPoHyVrTdvxNqJjA7yybqICZpXf
         rWPGEL+TRurQnbYe2TvCqDvBxk/zFRL/e/jaBldv4bguqoZYtyHxIQpRA960t0YiXIG2
         4mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916485; x=1743521285;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RXv0a2X2Eq8/LheD1NmgszijzevuXG/6uAHQeKi4nU=;
        b=CkQpwwDRMkf1vVWwGIf3PozGBVMAlIIOCsJ4qlnyTZGjoyEhPbHBrU9Jd5UetSzYXY
         PQv1vQ5XBrTvQCej9GaCdqrmULDH10afMt+W/SebvLdzp0eQ6XrxkVs4lHT9NG4nDMDT
         nsoyvOEK9X4GvzuJxGxIdoehN0XoRVm3U1tZySRzq7+0ddAgGXQMMsAGfs0Jp0P7Ml47
         jDjXc7HwT0H9GEsX0fQZPwqYNLifL2WJaCGjiqxeoWh3TbEipPtlpm0ZvPdcQEN0dzAY
         t6fQll1Rhc7ZUdZlnv9NVAdDKfYdBLMZi0txzhQhi/dF1vqu7l6CvfEuMIVz8RVV/Dh0
         naeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWntT2Z15t+LvCXAx5U7qCoJPi04tMGQV/IfJzCTd04wBXq7+sv2y4AnqzJNpkgEUOk8gsLINSkHomc4jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1nx3tSRy7rfQUop6QRinmttkkcLE1lqkWi7s8TIlAvaT5OiB
	OuT5eCDImRqwoqJJ+FADb1lTYXsM2MdoPTFaApjzGCNjyjfjq4yXu+mpiQmCRh/4i3my0aQ+HaQ
	56t/r8Q==
X-Google-Smtp-Source: AGHT+IFNKlPlr6QJNBf6YwQVspG1dIg92Bw2dzwvSp/kTGzaBXAZO3vYnmXcfexGP2GQWw+OsyByv+E60KnY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a05:6902:4e6:b0:e60:90de:3f4e with SMTP id
 3f1490d57ef6-e692ef28b8dmr51276.5.1742916484884; Tue, 25 Mar 2025 08:28:04
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:14:40 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 04/35] perf vendor events: Update bonnell events
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


