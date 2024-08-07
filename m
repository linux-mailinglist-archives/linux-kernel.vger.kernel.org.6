Return-Path: <linux-kernel+bounces-278202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2855094AD60
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2301281031
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9812D1E9;
	Wed,  7 Aug 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HvejrY7s"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42D12A14C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045934; cv=none; b=MyXKQFLdwjQeouBL/SwK6j+wtxyt5CdRYp6bsgf28XAAE7P0EHfgdG1OInNhiCCQqjrdxRQJoAwv74nqvX4fajQx4iyqckVPPVFJcafLdXeMgtM5YznihQ/+nMLB15uG/iDpthGdBRjCksHVui83olZ7IEs/+d45KeK5pI0KveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045934; c=relaxed/simple;
	bh=MTxacAatWTOpYma2qqk2MFtnl6sscbXpCf0B0L3Rvxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Avaef9wSOgC4JKHBNTF066lxl0Jk6z8qHsfix8uJo5aXWv51edoXaVBWfBTEluf1qGSTPp5lnOZNS7LJDjKpnoKaYSwp4GPrLpUH6g4JuvkOuL/VF2nnSATJ8gHCc+54eG8iQWUihO0wI+BacNQ2N3BVP8aR+KCtynsdK+g1Rh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HvejrY7s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4281c164408so174975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723045931; x=1723650731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRFdCUk81EgAuZOPUgff1QAMGIx+EiDXi2BrG6XIJyg=;
        b=HvejrY7sgXAnhuLCIQPlpnwzfvgUxoE4fAKrn5gBhx3/pYp9DtIQ3JJzzcdGhfIM4K
         1U3eu9asMhoNrqLetT0J5G6H9Mmz41HEsYA4vCjBbt2ySoW8CNUDido7hkaoR/y+gksg
         B7gJfGuDGIi3Q/mn9Nq6Lkm7QS83zDnh+nHG4Ft4Uz6mRNQxhgBLeU5Z0o+xptQ/2Rur
         NqugPv9DXMzSMgY4MO9ByoXF8N8gN4UpcOdR1iJtM0xxSt30HMK1D02TflZHAjVJ/hDJ
         9YuZQ+twqMfPkcymJ+vQ/aWXyn3PJ2jE7pMGMZudhiIrIFUtfmDexiVExIWjgifo2wFt
         fmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723045931; x=1723650731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRFdCUk81EgAuZOPUgff1QAMGIx+EiDXi2BrG6XIJyg=;
        b=PTxvDXuNre4t3d6+wlomoj2LLKdSbSlDJ9BEQbLM0gSoxqq00CzbttVf0bQ4LbPYzC
         vkiUvs6Qqr5iXKiJUVzyIB4Xx3obgDfNBw6W++6Lcy/UVB0vypOavT14WGmqKohY4sKu
         B3pYbHDUD7Wegrm22pTyVIj+1hskoR/G4BDLhPHFBJ4Gr3nkJTRm2cFcGZrn9aqxW8zJ
         wS/qEM2RE3AnqgaIjm50m/zgDrYPO/K/iVXAK9E3ItfMIEB048GBBoMZRW66dUJkilUR
         nZcUQMpq34Xa4nC+0WdiqKk/AyLLP9TNGRGHMDDy35CsFfGQjbp4rpRLVFY4oL/3TCH0
         UDFA==
X-Forwarded-Encrypted: i=1; AJvYcCWYamaYXX46Dkd3pjTWxGA5Nh4JHnUGeg38JkuEdpVnlNz+FYRAz1Acd9aSc8oLnVvHalpQ47E/jMM2LPaI3J495w1rjMPtALqh6zzA
X-Gm-Message-State: AOJu0YzL2NI6BLbhnd3CXjd6pxWELHAOUiARkAHgZqMQekjZkQTbfrBB
	LCPDKGVmSRrTqv2IbYNRQn/wwajmmR3JVwou/xeadoQX6fgZTvtfgs2WZDUAHOg=
X-Google-Smtp-Source: AGHT+IEEeoPN6j8nzeZeQO+PeuL8PISW2uSCLYbhFOCXh07DB880ZpSmwybG7OY/YQmH+1Lm/6eO9A==
X-Received: by 2002:a5d:4e90:0:b0:368:591:9bc1 with SMTP id ffacd0b85a97d-36bbc1bd311mr11569869f8f.46.1723045930947;
        Wed, 07 Aug 2024 08:52:10 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0261c2sm16428839f8f.57.2024.08.07.08.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:52:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	peterz@infradead.org
Cc: James Clark <james.clark@linaro.org>,
	Al Grant <al.grant@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2] drivers/perf: arm_spe: Use perf_allow_kernel() for permissions
Date: Wed,  7 Aug 2024 16:51:53 +0100
Message-Id: <20240807155153.2714025-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For other PMUs, PERF_SAMPLE_PHYS_ADDR requires perf_allow_kernel()
rather than just perfmon_capable(). Because PMSCR_EL1_PA is another form
of physical address, make it consistent and use perf_allow_kernel() for
SPE as well. PMSCR_EL1_PCT and PMSCR_EL1_CX also get the same change.

This improves consistency and indirectly fixes the following error
message which is misleading because perf_event_paranoid is not taken
into account by perfmon_capable():

  $ perf record -e arm_spe/pa_enable/

  Error:
  Access to performance monitoring and observability operations is
  limited. Consider adjusting /proc/sys/kernel/perf_event_paranoid
  setting ...

Suggested-by: Al Grant <al.grant@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes since v1:

  * Export perf_allow_kernel() instead of sysctl_perf_event_paranoid

 drivers/perf/arm_spe_pmu.c | 9 ++++-----
 include/linux/perf_event.h | 8 +-------
 kernel/events/core.c       | 9 +++++++++
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 9100d82bfabc..3569050f9cf3 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -41,7 +41,7 @@
 
 /*
  * Cache if the event is allowed to trace Context information.
- * This allows us to perform the check, i.e, perfmon_capable(),
+ * This allows us to perform the check, i.e, perf_allow_kernel(),
  * in the context of the event owner, once, during the event_init().
  */
 #define SPE_PMU_HW_FLAGS_CX			0x00001
@@ -50,7 +50,7 @@ static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_C
 
 static void set_spe_event_has_cx(struct perf_event *event)
 {
-	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
+	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel(&event->attr))
 		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
 }
 
@@ -745,9 +745,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 
 	set_spe_event_has_cx(event);
 	reg = arm_spe_event_to_pmscr(event);
-	if (!perfmon_capable() &&
-	    (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT)))
-		return -EACCES;
+	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
+		return perf_allow_kernel(&event->attr);
 
 	return 0;
 }
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1a8942277dda..e336306b8c08 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1602,13 +1602,7 @@ static inline int perf_is_paranoid(void)
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline int perf_allow_kernel(struct perf_event_attr *attr)
-{
-	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
-		return -EACCES;
-
-	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
-}
+int perf_allow_kernel(struct perf_event_attr *attr);
 
 static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..ae7d63c0c593 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13351,6 +13351,15 @@ const struct perf_event_attr *perf_event_attrs(struct perf_event *event)
 	return &event->attr;
 }
 
+int perf_allow_kernel(struct perf_event_attr *attr)
+{
+	if (sysctl_perf_event_paranoid > 1 && !perfmon_capable())
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
+}
+EXPORT_SYMBOL_GPL(perf_allow_kernel);
+
 /*
  * Inherit an event from parent task to child task.
  *
-- 
2.34.1


