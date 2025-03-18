Return-Path: <linux-kernel+bounces-566522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF7A67943
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA5419C2AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2D9211297;
	Tue, 18 Mar 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhRDCvlq"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138720E033
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314950; cv=none; b=bouibz0jghENQw1GLOQbPja+KXp2tnXdyEG5AYwipc0rL3c5Ua/NsAa4EYek19rJXQ3Wta88FhRjf/gw1hFmfuKi11Jvgw8ByYTmy5ysvIt10aI7OzrqXRyI12WSg/W9yv53rXdDMAaHae10odWEKVOu0IR5MjXD+/GGoSl/hD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314950; c=relaxed/simple;
	bh=w6qDgm2qrNSc2HRhU9eJf1Db93YMXx0Hv8DHqS3OMnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxJt4nXIhQfhjaHnda9fqvT1vDOhflmSkdoPaDy8MV4O3H3QvgC+EPpYw7rwqmJRkrCB2a1FSaAvHCrVX3nx+zE2LZ++IlwP1mSmUal+58RXjkQiMXjhB/YjB8dtcvOgNyfrqf7lKMnDCIRZCHszcs63mrXTky4ej1z9tXKWGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MhRDCvlq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so26161175e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742314946; x=1742919746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30vcmK8Kb7EgO69NndpoCL59432NFZcGkb09xNX7nz0=;
        b=MhRDCvlqK/gPQ4tBH1hE9LA6Vrvq6iC1yU1i18Tw9wym1PRjtro0KRLX/Fize+u97E
         qBrijRHUwss0U5LlHSD7oyf1lrrR8plbCh6FJiSbUsGfm17ZNVwjbtI2OJPKyAS0NfEn
         prHQ1DwziTcOyMzd3/n0xqCAvaC/IW+HEirSEb5kMi/B5Nar5QxZP1yQ/ydR8KA/vgPq
         B3Dr2ClNK5TZj2lW/TsZLm70wcFwIboV1ahHDrR+/pXPcLWNxkGMliIWq6420ml/7C+Q
         uaUHyC+hLNCtZs8BSWzQycYuwmWss+ZiOI5z94cuSSsYSHTrYDAl8qiyvfD3TXkdS56o
         06bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314946; x=1742919746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30vcmK8Kb7EgO69NndpoCL59432NFZcGkb09xNX7nz0=;
        b=dU5wTwN6mwDWPdtdK9cnkxW6ZboXvQ+zyA1MB24NPmFaVa9KKw+sSrb/8bw+4um2C1
         AAhsdT5k8WxEPzwc+c6+RY3c/p45r32yEE97ZTvKOtJqGBIiyHM14D/NvWKIi/vr1kvY
         2kUUMrlcfgGe5io8ARKJfO366B+Gu8mtN8YcD+L4DQMCQyrtCRMSFElCZ7PCmIotX/1Y
         707Q/in2PpFfZe+9it66i80rvn6NnKUW0e0RpFhLB5mScSR5fLTCE5xo2z/VUg7VKr7c
         2tzuLCvwQMwcj8vNUAKCyAWsq5GRioSxw3XiH098d25xqyMMM7h1Qjty4pX2uEjRcXtP
         b/7g==
X-Forwarded-Encrypted: i=1; AJvYcCWyA7LwnkMQ5BpTaR8wKdznPq3z388LwBUL81uFhn+1QBEfJkHdmM+hlm69SZkoo7N2C4nFrJpUH3fCyls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeYIunIdnTELwkkfWWTBANr23BIIuqJRZTclOd0awsJw1BmHCU
	OnueM5fboOLaQxfl6UrAZjWWm6D0yQIec5B4CGdN0poQL60uP3FqZBGin+3nEjs=
X-Gm-Gg: ASbGncsITL6AU7IQmyNOcurj1v5KceMSL4Ai8BH4iVY2qIJcZ99vmjSIQ5PWsWPd7hp
	Yi9npDOWrek1He6/SS/8J6BdYH2Q6dHnq7v31z8grBvqbPx0bbzpkmKP21YAdutkjEIMl6j3QuW
	vcVzQQFYxvbAz4Dxxi58m8O5JwNyBlxmnuvS5JsDxFXZ++qsOp7kdwFdcHl5sHhXj5GVgOOr6rC
	U8BJ2qynaWq8SW0dfBr3Zu3SKGwBrLDg8+hBe0dmpeNCBn/z9MSdxbZaFAKRoTxZTxw7ha29eKF
	XoVTTRRGT0EGyrpxewOkjZ+Q1ZnEzdofZkFH5cGtFX8i9cQ=
X-Google-Smtp-Source: AGHT+IETiy237nAdexxdqvMHP+odcdjCXjFhjN9Ayys4lYn4AXHoxQDsgrwFoHMV7AdF0nuLdpHD2g==
X-Received: by 2002:a5d:47ac:0:b0:391:13d6:c9f0 with SMTP id ffacd0b85a97d-3971f9e7813mr16838898f8f.47.1742314946529;
        Tue, 18 Mar 2025 09:22:26 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975ae2sm18914732f8f.51.2025.03.18.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:22:26 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 18 Mar 2025 16:21:56 +0000
Subject: [PATCH v2 2/8] coresight: Convert tag clear function to take a
 struct cs_access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-james-coresight-claim-tags-v2-2-e9c8a9cde84e@linaro.org>
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

The self hosted claim tag will be reset on device probe in a later
commit. We'll want to do this before coresight_register() is called so
won't have a coresight_device and have to use cs_access instead.

Also make them public and create locked and unlocked versions for
later use.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 17 +++++++++++++----
 include/linux/coresight.h                    |  3 ++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 3f1c996d668a..9ff601e2415a 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -151,12 +151,21 @@ static inline void coresight_set_self_claim_tag(struct coresight_device *csdev)
 	isb();
 }
 
-static inline void coresight_clear_self_claim_tag(struct coresight_device *csdev)
+void coresight_clear_self_claim_tag(struct csdev_access *csa)
 {
-	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
+	CS_UNLOCK(csa->base);
+	coresight_clear_self_claim_tag_unlocked(csa);
+	CS_LOCK(csa->base);
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
@@ -180,7 +189,7 @@ int coresight_claim_device_unlocked(struct coresight_device *csdev)
 	if (coresight_is_claimed_self_hosted(csdev))
 		return 0;
 	/* There was a race setting the tag, clean up and fail */
-	coresight_clear_self_claim_tag(csdev);
+	coresight_clear_self_claim_tag_unlocked(&csdev->access);
 	return -EBUSY;
 }
 EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
@@ -211,7 +220,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
 		return;
 
 	if (coresight_is_claimed_self_hosted(csdev))
-		coresight_clear_self_claim_tag(csdev);
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


