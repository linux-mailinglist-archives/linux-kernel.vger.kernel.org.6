Return-Path: <linux-kernel+bounces-575255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263DA6FAA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C1F3BA901
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2202259C91;
	Tue, 25 Mar 2025 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w/kncWZF"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C0257435
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903954; cv=none; b=FR5ersFtu8opeDQ4C+tkdMNHG1HsosVgrxJ9H2l8t60RYISYrC57bfeyPbNvUCYwbbxDEDhhHTEcEcIAYd/xf20YgfqwmQZ3q+5/cLUVT5aH6nEoI6Rekbq+PQAJ4OmtC8ks09EZJ3oar/Nj3i3P5g8U3e+s2ni6hndFuOBrVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903954; c=relaxed/simple;
	bh=RwmrX6xh4o8ZXCpXPteS1AEqEwZXQ2/GG/iu6R3L12I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ffVDTyA0+78W7UtrINHoRb+x2NYBJxQYgrj3p3X9OO+lEYg/UDqhXTG21+R2NO7tJIKkHiqZYo8yF/H9TN5jAYVLdAmcFkYczBePOOHijt305rFjDNsb2eEKUZblc24OyNJcTO5hdfxPEMVQm5nzYzQpZU9d78mZCxm9rfkvL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w/kncWZF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso3996149f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742903950; x=1743508750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0FL0/PaTjmurz0zokO5kHDNFvUG8fD8mEqSjB4BeZM=;
        b=w/kncWZFwoDdDmN2kA/zlQ6CJldN40wpC7z19Q1VRH9E8W6TknF+O0KEa59Rjfop6Z
         VyW7qGZ9bFHkVBLEc5Zh5kLLCj4uRfQNvlmTLqV+ItRoI313pEGGRjy6HbtYxqcbGUkI
         Ij08tBl5/rEy3jq9RMdtRySG8i0iaRjN64VEnwzUSwY4utajQXPB3zW48He01R860w0j
         tcwtIrYUWpP7G9CLphKTcKfUg6EJpdCrxz3RoNaQxAGiG97gYgS4ZJlByqVrSAcRZIsG
         /d5T5/vbNevDeQ4sYwsKdIqFXoi9A3pn/xnsnvm8j9ktwGjYZ3GPBRUwsDOUkhRcIv1X
         lMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903950; x=1743508750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0FL0/PaTjmurz0zokO5kHDNFvUG8fD8mEqSjB4BeZM=;
        b=KUP8A1Hqny8mkMs3sT9+BHMsYkIB2OIGJMWTfJhfsukjqUd3hzZaOKKfGXUUrYNfXW
         vvB4KVO8kJ3e/KDwaWTMyyy4S4ZuTCNQBP0ZOjSxaDGqjh3GrrcVKypk/WMIFtIfHXxx
         w1TpsZ5mSd02pSeHEXMZ2ZI/CniaXHeLGW8zAmp9HhGmmSk3gv7CZSDu1E5m1lQpe5Yl
         9N0Czrl9MsOPRil3A4lcFaHUljltHYHywKnILajOBe/l/EKrnW/JVqz49w596alBmUd/
         SUqlvYA41yo9dpgXyN0Bf0sQIAFdKul9NhkQrrPmJEii7F7fvbBZD8QMUDJAUQwbbaR9
         ArLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8rOD6W64xqmmro3tMKMgH4Rg0MFCKxCsCHmASLyehG5rD/r8z9cd/wMFRGhiJIn+EiDv2R9Pnfsq8wAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUtxQ4NG1H9dR+Rpbm7v6qnqeSNIhONJt8KhjhJ2fe3TItdTM
	tOb+mAAnBKztMihh1ALsaWZIzXBpMKFH+wWlencRqQrGoqsk+wgIPQBItjYxPcU=
X-Gm-Gg: ASbGncuW0zlIdWkLGPwYG3aGUlpwf2C+r/gQ5C8+SIVIXgJmiEgNlCkgwCs3pT+RKY0
	ZF2UFnTdsSjS59h3YrrpxZpqsSD1R6iRtXABTU3TM5CGKqLSbjKip3alyv6bc+PrkclhguTlmND
	RNOJ1sh6M5shRKYHtebmNaM/IUkfF3lktioB2ExjrE5wnnl0mmxfLj8OkFx8EbVB2eYiu3WtccK
	Z2Kgvc4uIWcwaRYYGHLLWhW+ZBmdXptCa1vE07dhBTlK6IktAj0gbsmUd56aFwHDCh+irQKhhzv
	zma1xFZTe8NMCG9weyxWth3OModAjzxC5Ev3EYOJetRigdQa
X-Google-Smtp-Source: AGHT+IG3tFFjhnsevfyoCp/QXQOdkd5Zu53HGqNY8KPYQg06rSyA9f19GT+bUi/B/0Mkzk8vLILsEQ==
X-Received: by 2002:adf:e846:0:b0:390:f0ff:2c10 with SMTP id ffacd0b85a97d-39979586da2mr14592665f8f.19.1742903950371;
        Tue, 25 Mar 2025 04:59:10 -0700 (PDT)
Received: from [10.42.0.1] ([145.224.90.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6676sm13687169f8f.62.2025.03.25.04.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:59:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 25 Mar 2025 11:58:49 +0000
Subject: [PATCH v4 4/7] coresight: etm3x: Convert raw base pointer to
 struct coresight access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-james-coresight-claim-tags-v4-4-dfbd3822b2e5@linaro.org>
References: <20250325-james-coresight-claim-tags-v4-0-dfbd3822b2e5@linaro.org>
In-Reply-To: <20250325-james-coresight-claim-tags-v4-0-dfbd3822b2e5@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.14.0

This is so that etm3x can use the new claim tag functions which take a
csa pointer in a later commit.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h        |  6 ++---
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 27 +++++++++++-----------
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  8 +++----
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 171f1384f7c0..1d753cca2943 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -229,7 +229,7 @@ struct etm_config {
  * @config:	structure holding configuration parameters.
  */
 struct etm_drvdata {
-	void __iomem			*base;
+	struct csdev_access		csa;
 	struct clk			*atclk;
 	struct coresight_device		*csdev;
 	spinlock_t			spinlock;
@@ -260,7 +260,7 @@ static inline void etm_writel(struct etm_drvdata *drvdata,
 				"invalid CP14 access to ETM reg: %#x", off);
 		}
 	} else {
-		writel_relaxed(val, drvdata->base + off);
+		writel_relaxed(val, drvdata->csa.base + off);
 	}
 }
 
@@ -274,7 +274,7 @@ static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
 				"invalid CP14 access to ETM reg: %#x", off);
 		}
 	} else {
-		val = readl_relaxed(drvdata->base + off);
+		val = readl_relaxed(drvdata->csa.base + off);
 	}
 
 	return val;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 8927bfaf3af2..cfd463ac715c 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -86,9 +86,9 @@ static void etm_set_pwrup(struct etm_drvdata *drvdata)
 {
 	u32 etmpdcr;
 
-	etmpdcr = readl_relaxed(drvdata->base + ETMPDCR);
+	etmpdcr = readl_relaxed(drvdata->csa.base + ETMPDCR);
 	etmpdcr |= ETMPDCR_PWD_UP;
-	writel_relaxed(etmpdcr, drvdata->base + ETMPDCR);
+	writel_relaxed(etmpdcr, drvdata->csa.base + ETMPDCR);
 	/* Ensure pwrup completes before subsequent cp14 accesses */
 	mb();
 	isb();
@@ -101,9 +101,9 @@ static void etm_clr_pwrup(struct etm_drvdata *drvdata)
 	/* Ensure pending cp14 accesses complete before clearing pwrup */
 	mb();
 	isb();
-	etmpdcr = readl_relaxed(drvdata->base + ETMPDCR);
+	etmpdcr = readl_relaxed(drvdata->csa.base + ETMPDCR);
 	etmpdcr &= ~ETMPDCR_PWD_UP;
-	writel_relaxed(etmpdcr, drvdata->base + ETMPDCR);
+	writel_relaxed(etmpdcr, drvdata->csa.base + ETMPDCR);
 }
 
 /**
@@ -365,7 +365,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	struct etm_config *config = &drvdata->config;
 	struct coresight_device *csdev = drvdata->csdev;
 
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(drvdata->csa.base);
 
 	rc = coresight_claim_device_unlocked(csdev);
 	if (rc)
@@ -427,7 +427,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etm_clr_prog(drvdata);
 
 done:
-	CS_LOCK(drvdata->base);
+	CS_LOCK(drvdata->csa.base);
 
 	dev_dbg(&drvdata->csdev->dev, "cpu: %d enable smp call done: %d\n",
 		drvdata->cpu, rc);
@@ -549,7 +549,7 @@ static void etm_disable_hw(void *info)
 	struct etm_config *config = &drvdata->config;
 	struct coresight_device *csdev = drvdata->csdev;
 
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(drvdata->csa.base);
 	etm_set_prog(drvdata);
 
 	/* Read back sequencer and counters for post trace analysis */
@@ -561,7 +561,7 @@ static void etm_disable_hw(void *info)
 	etm_set_pwrdwn(drvdata);
 	coresight_disclaim_device_unlocked(csdev);
 
-	CS_LOCK(drvdata->base);
+	CS_LOCK(drvdata->csa.base);
 
 	dev_dbg(&drvdata->csdev->dev,
 		"cpu: %d disable smp call done\n", drvdata->cpu);
@@ -574,7 +574,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
 		return;
 
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(drvdata->csa.base);
 
 	/* Setting the prog bit disables tracing immediately */
 	etm_set_prog(drvdata);
@@ -586,7 +586,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	etm_set_pwrdwn(drvdata);
 	coresight_disclaim_device_unlocked(csdev);
 
-	CS_LOCK(drvdata->base);
+	CS_LOCK(drvdata->csa.base);
 
 	/*
 	 * perf will release trace ids when _free_aux()
@@ -733,7 +733,7 @@ static void etm_init_arch_data(void *info)
 	/* Make sure all registers are accessible */
 	etm_os_unlock(drvdata);
 
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(drvdata->csa.base);
 
 	/* First dummy read */
 	(void)etm_readl(drvdata, ETMPDSR);
@@ -766,7 +766,7 @@ static void etm_init_arch_data(void *info)
 
 	etm_set_pwrdwn(drvdata);
 	etm_clr_pwrup(drvdata);
-	CS_LOCK(drvdata->base);
+	CS_LOCK(drvdata->csa.base);
 }
 
 static int __init etm_hp_setup(void)
@@ -827,8 +827,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	drvdata->base = base;
-	desc.access = CSDEV_ACCESS_IOMEM(base);
+	desc.access = drvdata->csa = CSDEV_ACCESS_IOMEM(base);
 
 	spin_lock_init(&drvdata->spinlock);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index b9006451f515..762109307b86 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -50,11 +50,11 @@ static ssize_t etmsr_show(struct device *dev,
 
 	pm_runtime_get_sync(dev->parent);
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(drvdata->csa.base);
 
 	val = etm_readl(drvdata, ETMSR);
 
-	CS_LOCK(drvdata->base);
+	CS_LOCK(drvdata->csa.base);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(dev->parent);
 
@@ -949,9 +949,9 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	pm_runtime_get_sync(dev->parent);
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(drvdata->csa.base);
 	val = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
-	CS_LOCK(drvdata->base);
+	CS_LOCK(drvdata->csa.base);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(dev->parent);

-- 
2.34.1


