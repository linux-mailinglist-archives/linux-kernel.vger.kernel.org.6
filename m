Return-Path: <linux-kernel+bounces-277782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B605E94A66B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8031F23B2B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBFB1E2138;
	Wed,  7 Aug 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVEJLaFb"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E31D416A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028146; cv=none; b=LL6XhWHXcwD8VBhcpBtchZqeYRjfENiqjDNgTxpDCfbrBtcIUlZz0FlHhP7VNjFOmnYxYR9hs/zbiG1/8Ki1F091fY1ITHKawhaxp52/M7jTmJgQnrGpvBkCMtHZYhJnwaYePJCv81ufCn5dAcxM4/kkiAglEuN0s2Z2qgFxUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028146; c=relaxed/simple;
	bh=4VeYB/5KjZu1xP4yhehU2c+3ldJcBRoEhBeRIzBgB1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y6IdrZ73tua7n8BFeFdSMsG/wa24f3wudP35ALwqFv6wXCNEN9l/d6NoGK6IlGaAQk6ESfUd+ipvqPuRzaJdk28lJbcMDUjFwGWbr+i8/45gCvunf6quYxSbK5Ep39n1LGa2B8J6haw7fAN4V/SzNYQiLKlXAvRcDMjsNvTdHgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UVEJLaFb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3685b9c8998so937116f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723028141; x=1723632941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g1CfpUgJXS7BrN7tAFA68qWsxl5eht2ofVsjd8s8rPw=;
        b=UVEJLaFbfMUwjaKEz2LQce5F3791HikaDXswCKrZ4hOJc8ztcyQ2E+WND5OYMbZyUL
         LsH8vnQwF43e4E0segbL4u9sF1imxeOHgWD2/Hznj4EhGssd/QdpGTYVNxM+nvcxlveL
         4R9Ufv+/6Dz8EZdQQhVsXNf3r3e3RbRYuxJN+NrXjWhe2I5v5Abx1tEywBF/AW4OiwOD
         fuRWHXgQMHgAvtfqmnnOuDM/+hU2aUPp+lWe9bcOFHd3zDSy7YiKqCAIS/zaKLdLjMpj
         I62lSoo0Z/LlKUAxDKHcl7DXySyVVT6ogZwshuwvIwjhyen37jBPOOzOhBhLmqDoW9Z0
         aIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723028141; x=1723632941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1CfpUgJXS7BrN7tAFA68qWsxl5eht2ofVsjd8s8rPw=;
        b=Z0Pscaqc1Xd10Qh+EL/3VMlD3b++BdVl0WcqpQTUpmmSMP25hKxHeBUf0Ir20X84Tz
         x9BI5qpvcnOZkmdkwWMcEP4zR9K9mCOPVV128th0rXIP+pzsfDPTdWlD9ieUXDJqT8I1
         RIUDarD0REOVoF637/t9IpZQQhgpUAeQHoihGQZZ3aST2sjyDplhETDOLd0EBJk9SG7n
         NAy9Rz6TCDYQ2iWbR1HfCyNmQ8IyfcgEqmusxJSzngvIJMFzOffJbhrR3Iy5BMvThbVW
         SC70yFUhXdHs3xCb7S22xpQFDUyJkzCBSJcyKRA/JKMguKr8eTZiWPU0j+XpbhyKGGBE
         Wgow==
X-Forwarded-Encrypted: i=1; AJvYcCXsMo7HMS4klmwBq0maB98VMdBYCt7IcS02xd3Cjj0badtBhDH+SID9DBzEFtWHJ8/y/KKg2BFFcOJF9NUwYdleWwCVB2xgRkf9tubV
X-Gm-Message-State: AOJu0YxP+ixnQ9knlCEGof/9mdsdwKjXyctPl0IIg7Q1cFclzt3erI7V
	Y8S/6sTFQ1nQCWIBhm1EQI5nRxM5ti9i+N4OJqNeGILEQOyV2efzLxDllj5EP30=
X-Google-Smtp-Source: AGHT+IGt+z3jjIQ5JZ71Sm7Hm7Y023gn/0oFOumyjerqnx97PjhdWlctYsTLYdnmPaqcAi0kbDv17g==
X-Received: by 2002:a05:6000:8:b0:368:747c:5a04 with SMTP id ffacd0b85a97d-36bbc10f6c5mr9798605f8f.25.1723028141352;
        Wed, 07 Aug 2024 03:55:41 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd059891sm15644743f8f.73.2024.08.07.03.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:55:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: James Clark <james.clark@linaro.org>,
	Al Grant <al.grant@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] drivers/perf: arm_spe: Use perf_allow_kernel() for permissions
Date: Wed,  7 Aug 2024 11:54:41 +0100
Message-Id: <20240807105441.2156738-1-james.clark@linaro.org>
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
 drivers/perf/arm_spe_pmu.c | 9 ++++-----
 kernel/events/core.c       | 1 +
 security/security.c        | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

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
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..4a69583e329a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -417,6 +417,7 @@ static struct kmem_cache *perf_event_cache;
  *   2 - disallow kernel profiling for unpriv
  */
 int sysctl_perf_event_paranoid __read_mostly = 2;
+EXPORT_SYMBOL_GPL(sysctl_perf_event_paranoid);
 
 /* Minimum for 512 kiB + 1 user control page */
 int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024); /* 'free' kiB per user */
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..70cc9206e902 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5610,6 +5610,7 @@ int security_perf_event_open(struct perf_event_attr *attr, int type)
 {
 	return call_int_hook(perf_event_open, attr, type);
 }
+EXPORT_SYMBOL_GPL(security_perf_event_open);
 
 /**
  * security_perf_event_alloc() - Allocate a perf event LSM blob
-- 
2.34.1


