Return-Path: <linux-kernel+bounces-223217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA0B910FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48EDD1F22E92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24B31BD916;
	Thu, 20 Jun 2024 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6Ax8TWK"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9DB1B4C3B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906253; cv=none; b=Qu5sRwoQc2KLFUYwXu1HhMy4yBVSQsWG6ThcyfPYnLs3J4TEvHUbiDPe5B6mam+/K64X90ikNvtrfuCdr35RfN+pMWzXPpzL5nxsMg1dshZJ6JMeDxsbHUaKihl8MMaYqJqPgVWsvCoiFMG1hqdbfJXEHFnzY0HUdBQVz9WU22w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906253; c=relaxed/simple;
	bh=1N1SZwR+ksGwCPMDZYiDQ+lz9Ae8zgclHhUvA9YDZ20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtXgYyjkBBcj69xisbMKGXGYOb6p3Bg5exRrk2qm447AytwDU3+JBCUN06hdRtSeOk5BX/XcoSWVzP08smCzHiMSheL/DWIG5phfzEpOO/xv9FSf1V7iw33r30NJ69vzv+p9E6N9BvZS051g36dkkKp1zYh6+r4Zw3f34csDcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6Ax8TWK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c80637d8adso437377a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906251; x=1719511051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bzcYC+7QMJSAq6nbwz/pdTxPIFYLtbDE2ea+6aoErY=;
        b=N6Ax8TWK/5S7LFzNubmvjXIcFaltUm246RwutTt8uHNolawsptLejpXv1wJNVcH7hi
         KtU7lYy7vHO89A4F3nsYvoIQws8gZtFISVipwoEstwMIf9ZqeLx1RFbE+0GtejXiiO+K
         LhKmOhM2rJxJi8XazSM93P+6VQ5/sgkEFvqYWjMsYohuO3Ru1IMCBAhZ7AMPOso5dwDl
         e/csIfKmJn3PltsOYLUvZ+RmjZuExUbN0hu/UOsnsRbnCf8OBYXiXkCJGtQnifNWcFOb
         pIrdnchl1EmsqcUUSVWrjBc6DV3nXu2uum/e32jAth3tSFT3MeGDGljCYKNZmbj5R+OB
         5eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906251; x=1719511051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bzcYC+7QMJSAq6nbwz/pdTxPIFYLtbDE2ea+6aoErY=;
        b=gHjqF/iQzF4fu6vwdPhvGpvf87Dm/HIxUiPHAb5UysLOUEjmPWTWd5UUv/HtkPApoM
         D2FZc+3OfwJblVA8M8CNYIqW1R+F4qd0yYQ9KnjwpHH0V3zrUTYF/43VLjFb5e/s6Q+H
         +wLoh6wheKitjf3tSPKG/INSatTnghnk9e5DL7TLOAdevmDe+yofRP1g7TsrvY4/PlPL
         PDsJBa/NlfHd1QhV3ZjlHezNoTvjqJZoXu1uzUr9C31Iw66C6duER98VCZmCUEJpk85x
         hTwPe5ngleB9V7TiHq/EenXsrl2gPk7Vt+ON7Te/XK2ufYoOqfTSsb9gA1fcaIkN1zNB
         NlUw==
X-Gm-Message-State: AOJu0YwSS/o0sDcwL5I3rSpcFTXMnZpKPNQDPzLguy+nh2QYVParbgsl
	E5BhtJcfINA2s1eaFrkMWgGKdIAS5+eFRmKfFOjrNcq4phw674lpWx23IBR3OBg=
X-Google-Smtp-Source: AGHT+IGzyYHmrHK4/S/CrwdNkwiA+pUDJ3yDivu3+UrGd8HpzK6oOgREUf8KUPo9rqfklDv5mSyQmQ==
X-Received: by 2002:a17:90b:4d8a:b0:2c8:84b:8286 with SMTP id 98e67ed59e1d1-2c8084b834dmr1256023a91.37.1718906251564;
        Thu, 20 Jun 2024 10:57:31 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e0743sm2004328a91.15.2024.06.20.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:31 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 08/40] perf/arm: use atomic find_bit() API
Date: Thu, 20 Jun 2024 10:56:31 -0700
Message-ID: <20240620175703.605111-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify subsystem by use atomic find_bit() or atomic API where
applicable.

CC: Will Deacon <will@kernel.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/perf/arm-cci.c        | 25 +++++++------------------
 drivers/perf/arm-ccn.c        | 11 +++--------
 drivers/perf/arm_dmc620_pmu.c | 10 +++-------
 drivers/perf/arm_pmuv3.c      |  9 +++------
 4 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index c76bac668dea..4c5d23942352 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -4,6 +4,7 @@
 // Author: Punit Agrawal <punit.agrawal@arm.com>, Suzuki Poulose <suzuki.poulose@arm.com>
 
 #include <linux/arm-cci.h>
+#include <linux/find_atomic.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -318,12 +319,9 @@ static int cci400_get_event_idx(struct cci_pmu *cci_pmu,
 		return CCI400_PMU_CYCLE_CNTR_IDX;
 	}
 
-	for (idx = CCI400_PMU_CNTR0_IDX; idx <= CCI_PMU_CNTR_LAST(cci_pmu); ++idx)
-		if (!test_and_set_bit(idx, hw->used_mask))
-			return idx;
-
-	/* No counters available */
-	return -EAGAIN;
+	idx = find_and_set_next_bit(hw->used_mask, CCI_PMU_CNTR_LAST(cci_pmu) + 1,
+							CCI400_PMU_CNTR0_IDX);
+	return idx < CCI_PMU_CNTR_LAST(cci_pmu) + 1 ? idx : -EAGAIN;
 }
 
 static int cci400_validate_hw_event(struct cci_pmu *cci_pmu, unsigned long hw_event)
@@ -792,13 +790,8 @@ static int pmu_get_event_idx(struct cci_pmu_hw_events *hw, struct perf_event *ev
 	if (cci_pmu->model->get_event_idx)
 		return cci_pmu->model->get_event_idx(cci_pmu, hw, cci_event);
 
-	/* Generic code to find an unused idx from the mask */
-	for (idx = 0; idx <= CCI_PMU_CNTR_LAST(cci_pmu); idx++)
-		if (!test_and_set_bit(idx, hw->used_mask))
-			return idx;
-
-	/* No counters available */
-	return -EAGAIN;
+	idx = find_and_set_bit(hw->used_mask, CCI_PMU_CNTR_LAST(cci_pmu) + 1);
+	return idx < CCI_PMU_CNTR_LAST(cci_pmu) + 1 ? idx : -EAGAIN;
 }
 
 static int pmu_map_event(struct perf_event *event)
@@ -851,12 +844,8 @@ static void pmu_free_irq(struct cci_pmu *cci_pmu)
 {
 	int i;
 
-	for (i = 0; i < cci_pmu->nr_irqs; i++) {
-		if (!test_and_clear_bit(i, &cci_pmu->active_irqs))
-			continue;
-
+	for_each_test_and_clear_bit(i, &cci_pmu->active_irqs, cci_pmu->nr_irqs)
 		free_irq(cci_pmu->irqs[i], cci_pmu);
-	}
 }
 
 static u32 pmu_read_counter(struct perf_event *event)
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 86ef31ac7503..bd66d90dfda6 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/ctype.h>
+#include <linux/find_atomic.h>
 #include <linux/hrtimer.h>
 #include <linux/idr.h>
 #include <linux/interrupt.h>
@@ -580,15 +581,9 @@ static const struct attribute_group *arm_ccn_pmu_attr_groups[] = {
 
 static int arm_ccn_pmu_alloc_bit(unsigned long *bitmap, unsigned long size)
 {
-	int bit;
-
-	do {
-		bit = find_first_zero_bit(bitmap, size);
-		if (bit >= size)
-			return -EAGAIN;
-	} while (test_and_set_bit(bit, bitmap));
+	int bit = find_and_set_bit(bitmap, size);
 
-	return bit;
+	return bit < size ? bit : -EAGAIN;
 }
 
 /* All RN-I and RN-D nodes have identical PMUs */
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 7e5f1d4fca0f..f41cc2ee9564 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -16,6 +16,7 @@
 #include <linux/cpumask.h>
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/find_atomic.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -303,13 +304,8 @@ static int dmc620_get_event_idx(struct perf_event *event)
 		end_idx = DMC620_PMU_MAX_COUNTERS;
 	}
 
-	for (idx = start_idx; idx < end_idx; ++idx) {
-		if (!test_and_set_bit(idx, dmc620_pmu->used_mask))
-			return idx;
-	}
-
-	/* The counters are all in use. */
-	return -EAGAIN;
+	idx = find_and_set_next_bit(dmc620_pmu->used_mask, end_idx, start_idx);
+	return idx < end_idx ? idx : -EAGAIN;
 }
 
 static inline
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 23fa6c5da82c..f3b20a3b1d9c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -17,6 +17,7 @@
 #include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/clocksource.h>
+#include <linux/find_atomic.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/perf/arm_pmuv3.h>
@@ -903,13 +904,9 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 static int armv8pmu_get_single_idx(struct pmu_hw_events *cpuc,
 				    struct arm_pmu *cpu_pmu)
 {
-	int idx;
+	int idx = find_and_set_next_bit(cpuc->used_mask, cpu_pmu->num_events, ARMV8_IDX_COUNTER0);
 
-	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; idx++) {
-		if (!test_and_set_bit(idx, cpuc->used_mask))
-			return idx;
-	}
-	return -EAGAIN;
+	return idx < cpu_pmu->num_events ? idx : -EAGAIN;
 }
 
 static int armv8pmu_get_chain_idx(struct pmu_hw_events *cpuc,
-- 
2.43.0


