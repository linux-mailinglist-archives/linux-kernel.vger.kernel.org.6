Return-Path: <linux-kernel+bounces-575252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EBAA6FA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635D61725C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750CA2571AD;
	Tue, 25 Mar 2025 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lXn1so6B"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C972566E7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903949; cv=none; b=lRSXjt9qEMICvJrnDXiPAlfaF84TV1NiGb/LxgZq+vLmCGWRAASE8xZ7uqxnhc0hu8IjFs7Ii3xwDpxAS/g1AX7W12BuWCuhc2c/Tecr5fuYSFM6sZhPO/fxR9t13UQKgr5ntnILyiU6C1IQyfVZhIh53gYkHEHfVIyGL74mvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903949; c=relaxed/simple;
	bh=k93sEyYmH9ZyJ3a6Iuop3GXKG2L1PYmzMpkRYM4o0iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r+HHgdY/aIoQ1BFCbd1h/kTF9QngqvZn5cPnZr+aHfDTjv4DrvRgle9NOJFrx4naTakFXZtNGHIreX60Rg0dmR3hcnUaKqsARIyTpoFY9noN0Bey1Pu7Gdzbso3mRqBQxYHHAH1EWyPIfQRtlVJrVyHG+71QS0Rm6T9vjFPqBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lXn1so6B; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912c09be7dso3675354f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742903946; x=1743508746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+T3WQyKZjc+sTss9oWTNDsgD0VLz9miuiujDFgPAAiM=;
        b=lXn1so6B72KO1OaafAoTs6V/RxEK72J7KNdVKUT7w5KLMABb2ryVv2hteyMifQRyNP
         So5oruFff8KY5e69LneK8PQXM00UMp1xhWFuKC85gQuQ5MNbAMRH9Hk/nTwg6Mugerh3
         OWZF5kaAKX45ZFf6E0sdyUu60S44OuS+XXLBq0e7cV1ofKhnX/lI/gIuLnj1qq+AJV5k
         sT9RtdknH2Cpatqm1gyru0+aq0Z7RnHVu1MA6KFC1vYw1Yo0WlPy8jO3zRT1VIDnVN85
         G7wGpTeWN5NqYRUVr8rBmZU4H/uhmLoOe7KWzs5YgimuE55mdZZlDk0WcNxjy78gKhxP
         /f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903946; x=1743508746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+T3WQyKZjc+sTss9oWTNDsgD0VLz9miuiujDFgPAAiM=;
        b=jboUdmdFyNj1TCiVLDKUZqzRRCFYisrsX3NoKra09vboufSgvzXbPj+KgqBH8RxZ7x
         /Q4pVQx/zrJlyECZ7Llvv1giVMjPV0Oq3e9RFLOzezHdEMmgmgFg/vLLzeKNHWrPjLmw
         4wBatEBM426OV058MZR8hFb8zNbLDn3LLbayZqjzsKnM0XFH2Is7SmYUFvfb+ADn0gIv
         dFYmsBWZG27hvY/hGnrH3L9vCECArwhKP18ix8JfcjxTBDEm7MGRnyHxifcuoBdkCnRX
         0JEBviMJ1hYAPFs/Xw+N2AzgKk/N4V+lD7Ax0+/sRQ3g9lrgv8v5nvgVkZ27L+RZFYMx
         uVtA==
X-Forwarded-Encrypted: i=1; AJvYcCV2KEAlKXGwg9QGVVIvNwriSvvvZsiyjHJHUWvTwaeiXh8ZWx2vhMJyDWQc+T0PZCC5p+iu3tjO9xwEBJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpyaH0ujQ8+1kfnVZfU6eF7PXn4WPIFEI7+r6TNWK0As3GHKEl
	MZpnkXBmiZNDWWCKKXrAhMls7ah00wnWAtmpi+sWO97bhqjiCrD2nY2kzn0OElg=
X-Gm-Gg: ASbGncuCLsl4YmbqUe0yZbpgKgcEbEI3DuQJOrCm1QgoHDBMgsPEU4j1cglt1x1Nqqh
	vj9kUejQITGOYqGpF2laG168HfMO4ezO2tnxnkJ7WQ8QLtqJPQs+0S2+9SyqJ2GgogJ3xqcVMkT
	x+/SJPiZCuyH3I+nPVPGWBCa74AoBz8LesO2zL9PqjXs48IDqsgX3ayBkF4vqv52urkNdJ5rRIx
	eS94FJFt8Qn+Rzd/Or2A1nkdD9Rc2q9Gdq7gObYCFKxMxLk0PY751ZhHmB59QTuy9sou3/0bavn
	S11lQ7zjyFKKDj+fVaqvUxUZcBw0edOKEbLkilw79ZuBxll+
X-Google-Smtp-Source: AGHT+IFPGy9vum6o+O8NH5bMurCGa+Js6mdtnSW1DTWQ2JGk0tgT1DLh6k91VuQbSdSQx9wfiBlcYg==
X-Received: by 2002:a5d:5885:0:b0:391:29f:4f87 with SMTP id ffacd0b85a97d-3997f93c495mr13090045f8f.49.1742903945954;
        Tue, 25 Mar 2025 04:59:05 -0700 (PDT)
Received: from [10.42.0.1] ([145.224.90.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6676sm13687169f8f.62.2025.03.25.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:59:05 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 25 Mar 2025 11:58:46 +0000
Subject: [PATCH v4 1/7] coresight: Convert tag clear function to take a
 struct csdev_access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-james-coresight-claim-tags-v4-1-dfbd3822b2e5@linaro.org>
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

The self hosted claim tag will be reset on device probe in a later
commit. We'll want to do this before coresight_register() is called so
won't have a coresight_device and have to use csdev_access instead.

Also make them public and create locked and unlocked versions for
later use.

These look functions look like they set the whole tags register as one
value, but they only set and clear the self hosted bit using a SET/CLR
bits mechanism so also rename the functions to reflect this better.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 33 ++++++++++++++++++----------
 include/linux/coresight.h                    |  3 ++-
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index fb43ef6a3b1f..d895815dee1d 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -129,34 +129,45 @@ coresight_find_out_connection(struct coresight_device *csdev,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
+static inline u32 coresight_read_claim_tags_unlocked(struct coresight_device *csdev)
 {
 	return csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR);
 }
 
 static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
 {
-	return coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED;
+	return coresight_read_claim_tags_unlocked(csdev) == CORESIGHT_CLAIM_SELF_HOSTED;
 }
 
 static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
 {
-	return coresight_read_claim_tags(csdev) != 0;
+	return coresight_read_claim_tags_unlocked(csdev) != 0;
 }
 
-static inline void coresight_set_claim_tags(struct coresight_device *csdev)
+static inline void coresight_set_self_claim_tag_unlocked(struct coresight_device *csdev)
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
+	coresight_set_self_claim_tag_unlocked(csdev);
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


