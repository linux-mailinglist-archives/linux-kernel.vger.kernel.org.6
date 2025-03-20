Return-Path: <linux-kernel+bounces-569877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C3A6A8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1867982272
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29F1DED47;
	Thu, 20 Mar 2025 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhFd8+nj"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDA1D63E2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481312; cv=none; b=c9WHzSxcJZzdi5XLhNHNZ4if0Zfafmxu6k4BtJnAwcNYPDYt0ILD+Wt0Kx5oceuOGGfrOHUm43oGqVK71qPAn/2I+iLL0Ea4LDm3uhdG7e63ZR1vIPy0/zXLsOc6HEFSexbOvJuKnNdnW4/B5AzZy0wQ3kax/zy+Goiz412XWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481312; c=relaxed/simple;
	bh=qvcFjFw7MFlNJjzvTbuzZcRvtoDHxGiXBkoGFmb5UsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dI6v2vE96Y2LnqiNBz9U9/Oe02ydSWyMChi8dmIFBLwa/sUUWG3dDYM/V3VQnLg/nsYAYpa1PCQ1242rvo0kwbMZigFKU0cm7bjeJkK7T2n+ONdSNsVZgXRecHfoADwY3dipt28RSnK4dx1t9mOkDlxtxUsX0kI6+Y1JvrQcvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OhFd8+nj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913cf69784so715430f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742481309; x=1743086109; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZfzFRHbfXxXFspuQSyUelov0bU9Y998lI+AV7Y8adF0=;
        b=OhFd8+njTqysTucaDanosLzE8sO2hm7jXIsukEHcJfWk6VDuyCX1ROnHmzWio6DDHE
         suHiEGx4INVb5HdurHrhqjVHgLEwGFafAHTH9KSMrber/9LeimIipGxcUY7Hm08GxT5F
         btUckJk++olbfhoZ8rI6SyL/5YBYppPmjlRYw2c4ScxOS2sml9ihiReYyBusdLtocHO5
         S3AmW/s+ZOCU8bFHolIVID9ozUUmhb99tkZ5D1Ck+H59UynUOHrtyvWXFtXa/P2eLQX3
         X49OBE2sETQsdse2ojV5JhxttQfboLVjnFdY5Q9x10GygRCLgi/eLYwXPVYYXJ1tpOGz
         6iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481309; x=1743086109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfzFRHbfXxXFspuQSyUelov0bU9Y998lI+AV7Y8adF0=;
        b=TpbB+iYEZspJeF6tSLjjuUWJ/ozvPBPYA3khO5LasbSDbOtK78HrDwBtpxTmNNX7K6
         eboMbw9VqpA4pjhZQq1ideO7FbX9n59YPyuWo3uGWHc9X/J3QoBrl25xeoGnM8J/VKlk
         +KuTrR7rQXa9vlpT10/1TVYX5jQyGMTOgKF97ZLi3akTuTQwEqhw2FP8bX0fI2GQMkB1
         gQy7bBIQPdRQxrVhPbJbHYTRtgtkWG0gMnfws+RToYFyws19Xmc50ImfU0jVV0xk2QL7
         jH85OTNUfQKUEqnh9p0Z2CS/Rqxm6Ysi+qxNC893u/Kjf+dOBDNtpLh6Qlv3+PMuU9T9
         JNdA==
X-Forwarded-Encrypted: i=1; AJvYcCWhxGUGa9w+VsSnqBx+S4eBnTOB0EWvnSk4nH2GfQRtiqvrg7sEWk5KwybGL8KQ4TnELVatTW0whUHf+4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhV6yPECsD3VTIN4TvRIChb8CJjbJowN39UvJhpBrSoecxJcG
	bubFYDJImFzGF07O8aSN9VQsNeBMjrZz+iFnxzXD90du5mWRKBCah/sWHPnEslo=
X-Gm-Gg: ASbGncvgzTa75ElkJkAJkHUYlWIB3LN8Q6tvMms1ZSJbvpVEhCSc5+zu70EZAasAlvn
	Dgn8j2Bf+24bqw6e+zJBMFMNF9yxtHMMojw7R9uxBORqNbEzfzX/4oy2orPTcg0XABCfxYK3W9f
	av574HULJJeCzbvEztOaHbxOpBJeMIwztbRA2m1TJ10WsJnoTToXIYBHoMFHHCsWtQY8+OoE0Nx
	6/CDH6HZOjDWBgud5Gx+CYyk0jtLPgZo/eJBmFQyB5RkCfS2I1B33aTt6UskubbzUh9ITZA/zuS
	UmeFtGhzhKGxvYPgQeOoDmusXxw3EskCFUfykTBNwa2rKNc=
X-Google-Smtp-Source: AGHT+IF73C+sldZfp1EoaiTa2aCKKOCtDRpElINoDtMTnJAzYhWVerLTt8PUOTnbGm7i+dgQZml1yw==
X-Received: by 2002:a05:6000:2ad:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-39973b0befbmr7716072f8f.48.1742481308907;
        Thu, 20 Mar 2025 07:35:08 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a27sm24238187f8f.31.2025.03.20.07.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:35:08 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 20 Mar 2025 14:34:10 +0000
Subject: [PATCH v3 1/7] coresight: Convert tag clear function to take a
 struct cs_access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-james-coresight-claim-tags-v3-1-d3145c153820@linaro.org>
References: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
In-Reply-To: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.0

The self hosted claim tag will be reset on device probe in a later
commit. We'll want to do this before coresight_register() is called so
won't have a coresight_device and have to use cs_access instead.

Also make them public and create locked and unlocked versions for
later use.

These look functions look like they set the whole tags register as one
value, but they only set and clear the self hosted bit using a SET/CLR
bits mechanism so also rename the functions to reflect this better.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 27 +++++++++++++++++++--------
 include/linux/coresight.h                    |  3 ++-
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index fb43ef6a3b1f..8471aefeac76 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -144,19 +144,30 @@ static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
 	return coresight_read_claim_tags(csdev) != 0;
 }
 
-static inline void coresight_set_claim_tags(struct coresight_device *csdev)
+static inline void coresight_set_self_claim_tag(struct coresight_device *csdev)
 {
 	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
 				     CORESIGHT_CLAIMSET);
 	isb();
 }
 
-static inline void coresight_clear_claim_tags(struct coresight_device *csdev)
+void coresight_clear_self_claim_tag(struct csdev_access *csa)
 {
-	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
+	if (csa->io_mem)
+		CS_UNLOCK(csa->base);
+	coresight_clear_self_claim_tag_unlocked(csa);
+	if (csa->io_mem)
+		CS_LOCK(csa->base);
+}
+EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag);
+
+void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa)
+{
+	csdev_access_relaxed_write32(csa, CORESIGHT_CLAIM_SELF_HOSTED,
 				     CORESIGHT_CLAIMCLR);
 	isb();
 }
+EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag_unlocked);
 
 /*
  * coresight_claim_device_unlocked : Claim the device for self-hosted usage
@@ -176,11 +187,11 @@ int coresight_claim_device_unlocked(struct coresight_device *csdev)
 	if (coresight_is_claimed_any(csdev))
 		return -EBUSY;
 
-	coresight_set_claim_tags(csdev);
+	coresight_set_self_claim_tag(csdev);
 	if (coresight_is_claimed_self_hosted(csdev))
 		return 0;
-	/* There was a race setting the tags, clean up and fail */
-	coresight_clear_claim_tags(csdev);
+	/* There was a race setting the tag, clean up and fail */
+	coresight_clear_self_claim_tag_unlocked(&csdev->access);
 	return -EBUSY;
 }
 EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
@@ -201,7 +212,7 @@ int coresight_claim_device(struct coresight_device *csdev)
 EXPORT_SYMBOL_GPL(coresight_claim_device);
 
 /*
- * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
+ * coresight_disclaim_device_unlocked : Clear the claim tag for the device.
  * Called with CS_UNLOCKed for the component.
  */
 void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
@@ -211,7 +222,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
 		return;
 
 	if (coresight_is_claimed_self_hosted(csdev))
-		coresight_clear_claim_tags(csdev);
+		coresight_clear_self_claim_tag_unlocked(&csdev->access);
 	else
 		/*
 		 * The external agent may have not honoured our claim
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index d79a242b271d..00134a80d358 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -685,7 +685,8 @@ extern int coresight_timeout_action(struct csdev_access *csa, u32 offset,
 
 extern int coresight_claim_device(struct coresight_device *csdev);
 extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
-
+void coresight_clear_self_claim_tag(struct csdev_access *csa);
+void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa);
 extern void coresight_disclaim_device(struct coresight_device *csdev);
 extern void coresight_disclaim_device_unlocked(struct coresight_device *csdev);
 extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,

-- 
2.34.1


