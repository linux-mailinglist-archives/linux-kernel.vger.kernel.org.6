Return-Path: <linux-kernel+bounces-566525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F319BA6795E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EC6883C52
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A95B211A38;
	Tue, 18 Mar 2025 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m/Kxaq+U"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F32116F6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314954; cv=none; b=eE/ZE+/B6HlEm2uzVrFYsMn0WnubwqnzS01Z8Yqtj7ma4/P3Y6eRHJvpRRMv8RXkriih9KvGqHQV0ihrQH/VQeBmiX8J0NfE9qJxOeRLsNqr3BKHq/aWGNmOvh7chqeF9DIVUSt+dUpl/bPCZJYN++Lm8erzV1Upj3xh4Al3kQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314954; c=relaxed/simple;
	bh=GhP/ni0vddk7+T0mcp24+VZH5EuVWjwHdqTUq/H5Zc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R11kLYhDcXiMSp9IT964fEUKW2Ch5td1TLH5S6c1++Ws3Glp37heIJcenUiV29b4aAmZdccqFQJLQgmamZawOu7j/awFNb+sxJIOyeVzWfXus/tDDvighO7/TigYHNZY/42dLGYqruDr25pHgfjcn7KTli5QxjgcUqHc+Zvn8Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m/Kxaq+U; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-394780e98easo3834756f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742314951; x=1742919751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRSIoJtQEht7L+lhpKZdRykVgJI6cMPKCHCjNInEcQk=;
        b=m/Kxaq+UjXkhi8o7EKuIxmkd68wZgWCkgmcGz6k0l9jw3IKqaJahm3j6jxDAZUlkxR
         cdvKMGWOtBgb1HO5K/fM1HworUzDd8KLl52iPGj0hJEj6CyfpeyNjRJwIlgox/20EqHV
         1UVLMrS1EFkio+cinnoIsonlzDQ3Pl88DgMbJQiH9KF1nUV6dZY4UdABlYKI4ui0DVKR
         CxeEmVCbPGuk6d8+ALG4ZrslM3kEIscuVkKbxyLEKf5c6zT67T6FcPCozU8dpvxwz7si
         zHAleC19nmMVxKntJpFsiupninoXCSsmZ1Fw0MyQ8K4wRSV83/sypuaFiBQPI1VN8t/5
         7SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314951; x=1742919751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRSIoJtQEht7L+lhpKZdRykVgJI6cMPKCHCjNInEcQk=;
        b=kVlnREuxC2Gp2G+LTf+RgGmasQ6gh9P6wtqF3TvqUrOYqJ/ZDofuN8h2tKmE/5FDXb
         GY2iM/D2p6+0GPDluhJwsaLk6sArlnjsTCMNf2xm6QEcI4ikFAooNAaWWZFrcrtBo4c5
         ICuWvmIUPDv0hwxFkhIlwjJL+ivpPmOCGMa/WFnLAHXu1jSEV4k8so7uJfjLWoeGyvQg
         EZIsk45lHXjQPAYS0hRXkFiUYat8tXQRcRMTF/B2XpbAiybwsUXkxAWYPpw9J3oJZrx+
         TTAvKd7RTANOr/CNZgu/vmDjapkjUjzAqeQPZvOrn1XjOHFG+HRO3bxmovFClOb8RAzB
         RJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHF1CUc52l0RbYqHi0uVLVLkwrvmcjJl2Ch72Z4PsUAsAwfMmb1STJCVQitSajU30V1HutdpVyCIW+mik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIiSF7dMPwj5eDKLt0RbzGMP9QVVkPVYPrtU/UYK/n6ME2QOV4
	uIXsF69mxJBmpONmpzb9YjgFuY+YXpQnIaSfxMIa3Zd58NYhUc1Q9YHfF2+CQxU=
X-Gm-Gg: ASbGncufFLk7IC7e5SPAsET2YJ8x/TP4g0AZ+LdSxtKR0cuWfrg+FO6IheZAAlr2zFx
	W+2SBp2dxxpcjCuENmKJhEjcD26vrkyIRTWgYy1OjiwPbWnhlURZJD6R2HCMqTQmY0zA3wFblIM
	zNf9D/p9KXsIUJHgYQddRWq1EUjdXRgRbhNq1dHk+OSbLxSH6Xc2bNJ+DhHuC89fNBQptts+q+R
	lk14mg/h8nLulQOBXkfc6PHmXGBNJVfGr7Rwdbpp8jmT+saFWyZIRc8ziGwJIY51lebnI6L10VE
	/C2axDJYucgGSBGn6/IZ+nGrdT8PqukFaWsDbVkWN1e6cSS2BmpqSH0PYQ==
X-Google-Smtp-Source: AGHT+IE9oZFsPwz083sEIt1xLxpkaeWDmU244cuNkbu74PheoYY6+y+/eO82rufHd0nZQ7vu7yeTIQ==
X-Received: by 2002:a5d:5f95:0:b0:38d:dffc:c133 with SMTP id ffacd0b85a97d-3996b49984dmr3916452f8f.44.1742314950657;
        Tue, 18 Mar 2025 09:22:30 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975ae2sm18914732f8f.51.2025.03.18.09.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:22:30 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 18 Mar 2025 16:21:59 +0000
Subject: [PATCH v2 5/8] coresight: etm3x: Convert raw base pointer to
 struct coresight access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-james-coresight-claim-tags-v2-5-e9c8a9cde84e@linaro.org>
References: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
In-Reply-To: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.0

This is so that etm3x can use the new claim tag functions which take a
csa pointer in a later commit.

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


