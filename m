Return-Path: <linux-kernel+bounces-175093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE7A8C1A38
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAF11F22FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D312E6A;
	Fri, 10 May 2024 00:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1GtDOigs"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D87F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299525; cv=none; b=ry6prbM59a3/nblrNGoz05E4waV9XbO90Ay/TIEi3UVgpU7XMcDp83W1TvWue1d+22dk7aign+hGmCKRzci5eYMrueASQr9Gn+jHA+9ZiYJ7CBgdY3J1ArSueNC61NW7b7OvyGSpG/c0/Wdi2o/Ntg51CrKFBSZLEuUWShHOUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299525; c=relaxed/simple;
	bh=cGpULC1B1HXkvRfCSn3TdeH+Xj5EwEpr4DGLnTg+pCQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TGeg8i5G+TbkNBFDOPnZ9DhVM2XiZWB99ZZNa18zRUMsIQdE41aSrbRqJE/cQvO4g2DIi4LudMbrFBVsxcdVR3gGDLSCauXxIlDr+heC0f3XOEEz+zcK3iLH0sHCXWw1PN5Y5rZRauDhp8RKIb4Q5vns7H4JBx12uEzsvhZooBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1GtDOigs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be8f7ed6eso17622397b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299523; x=1715904323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ot0TEs4BvD2J9QyiZT5bC39KllHj7+HFnRVXvIw7CTU=;
        b=1GtDOigsg5jSoXkWIBd0iOs/bvORgsA0dp9i8Pw9v6bPM3zeqJH0w94Q+/XodM3CT7
         q4SX4sjCybMXUdaTjgNlRUFYBfpyDFNxHgKjaMpNFpU6UcWIj0Pm1wFbfeYtZA7cJpMH
         jVuuTT6ZR5oSNuiDtBa98fqHK7zS2XPtiGlE70CPViVECq+MXsUrzx9aoFSD8ZW27y/z
         EM4dSqKAyBbHM3wgnnMp3s13c5nRD0y3bBkzLaVm31jAfA4DDndWfP0rs08CNbAreTuh
         EHL2HYRErZJB0+ZSLmJeBGAXXnwuZEyZAL97yB3hQoNG5Dsm9HEtUtcMxCIAUh6ZN7P3
         7W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299523; x=1715904323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ot0TEs4BvD2J9QyiZT5bC39KllHj7+HFnRVXvIw7CTU=;
        b=eTX8VB/M21mXjYrSd3KR+C2YUWzP152hUCK95xN9ORLHkR3FyXDSMMGWnJKZ9jCQ7Q
         q6XFnuSyLcY2LOA3hUxVA9YdVuFzQzdzBtnbKCvivR+lYun7no/hqWhz9fk57JzB/Q3l
         zb/Bv+ynNeFL5jn72uPmV3bUDUdr1aCTEI1sx62n8zg+g2lBK0/Oel0p8XblFk98Pa5n
         U4Ps+0RzLvIoXG1UP6t7PutPQlwgFCGGGQdMHLlh/HUE0/1T4w6ioYZYxsV1Hp5bn4hA
         6mPWwcz3QH+0bgPFppP6vNHEBH5UBu2F1gaAoCkDOh3tJXqGBrxq/nhjdqhhqiit9z4C
         P60w==
X-Forwarded-Encrypted: i=1; AJvYcCXwgI8syEN1d4kGcToPYOf1/vtz5ErqLT9lPXWo7zQgQsmUdUjRlpTV1WRvXF98bal+Vq0H3BlSXenMGkA/r4mc7/eFZQ+O/kpSAYBd
X-Gm-Message-State: AOJu0Yy6U+la79g0Av7EVZb53pz3Tx9S1O4dx4qcA9MDyreeslkZf7A4
	z5wc/VxLjgSWWbmwvIlfVNp5SUNSC3GU6J+rLdH97LX8pohln1Tn8uUGpNEUVjzv9BU3uoPneUh
	T
X-Google-Smtp-Source: AGHT+IEzy2h7K/VLaBZePrcCIRcOhw+P3u9Sa/loYEqzI4OLeWzMuuO/Li8UARzyxANE6fra/VW9xs+tfLs=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:1b7d:8132:c198:e24f])
 (user=yabinc job=sendgmr) by 2002:a05:690c:6904:b0:611:6f24:62b1 with SMTP id
 00721157ae682-622af7a98aamr3561297b3.1.1715299522736; Thu, 09 May 2024
 17:05:22 -0700 (PDT)
Date: Thu,  9 May 2024 17:05:02 -0700
In-Reply-To: <20240510000502.1257463-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000502.1257463-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000502.1257463-4-yabinc@google.com>
Subject: [PATCH v3 3/3] perf: core: Check sample_type in perf_sample_save_brstack
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Check sample_type in perf_sample_save_brstack() to prevent
saving branch stack data when it isn't required.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 arch/x86/events/amd/core.c | 3 +--
 arch/x86/events/core.c     | 3 +--
 arch/x86/events/intel/ds.c | 3 +--
 include/linux/perf_event.h | 3 +++
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 985ef3b47919..fb9bf3aa1b42 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -967,8 +967,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..ff5577315938 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1702,8 +1702,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c2b5585aa6d1..f25236ffa28f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1754,8 +1754,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	if (x86_pmu.intel_cap.pebs_format >= 3)
 		setup_pebs_time(event, data, pebs->tsc);
 
-	if (has_branch_stack(event))
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8617815456b0..8cff96782446 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1276,6 +1276,9 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 {
 	int size = sizeof(u64); /* nr */
 
+	if (!has_branch_stack(event))
+		return;
+
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
 	size += brs->nr * sizeof(struct perf_branch_entry);
-- 
2.45.0.118.g7fe29c98d7-goog


