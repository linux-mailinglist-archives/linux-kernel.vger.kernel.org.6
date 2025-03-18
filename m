Return-Path: <linux-kernel+bounces-566521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE5DA67951
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3373B9FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BC720F098;
	Tue, 18 Mar 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dS4SvI06"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381720DD59
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314949; cv=none; b=JifWDCK5ETqiqERcy83luhE3ID6Y6ek/934LtSHRnFXc+Bh8xc0/wKZIQB0A2b/cdjzVqBPCDBDh4wnz9svptyx8THULKPF9Ro5BNBkexs8WhDNPvxt/G8TCIjOy8/eKt6K6v76K7y+QCZzrR2HDtR+Jcwkgyy8m2NqYJbLlK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314949; c=relaxed/simple;
	bh=SEMH+EZvpTvBx2rTYWaS2mDsWnRSEL7Gw5dgEemJN4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJPSSHOAE8qN8A5/wYHgEtI7UhNqXV1U4uPPjDIyMldn9cXCDF/za+UuGp4slH7+ExozXlnLQNx8W/B8ihIYaExEQ+MNXB4bbE7zIk9T0Xt6cxRNAR3v3SPFqjGyAgJMN3wjYIcQE5CHG35KCXhUFnWfSaipGy4BoXKlYN3m4Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dS4SvI06; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912baafc58so5045024f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742314945; x=1742919745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gOSFN/1KIzpDFDMtVSThY4tdpbBGk9qFEr0fShnj6c=;
        b=dS4SvI06FuhwZ1oO+KkLwdodyRzXfnvxDyeeLcfPciV7X7g7cJZW4NpNapZ1KTij5Y
         eIx8gyy0Tn/ZUm2dYL5WQbX07Ng5kXmqAtCSGxJNgcQyP2X+zwt3S0CHNP0xmBJentNP
         PJRTsZzFVMNIGj8E9uv3F6OwCe1/qMbvnF7xajGqiP0iCX+Zl3kOxPZg0FlSyTLv7oXQ
         ajD4Z0JoQG40FsXLgNFvzVmetU0kUG8VJebS5E8gh6eNjUNrDbVV1n1DFrQhfvV8CzmI
         MYreYNAoj1XcgvKAa1+3Mzl85gC9rtiiITO84QoU9OmOXnIfkyBHckup7j1Wj6dYbD3F
         Vw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314945; x=1742919745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gOSFN/1KIzpDFDMtVSThY4tdpbBGk9qFEr0fShnj6c=;
        b=Mjy9A154mXuMyFJ2cBfK1suLnFqFa+hSViuXx/TcnEqRddTrTC1PvF2MuC+SQMU+mX
         gQ2d48lt2dNBmcgSf+VxU4i7H3JOt7H5lYEKaYE11SLsULLfz8jwuFZONZQetVqvKSy1
         SwAdsAIJwp0wcdYYGSzrbqD848NMV3SKo8+IylsuH+Kr5ksQGfnT6zvoZ2iwRwjGCIGK
         AIvfyiVVaxyLZdcHlcq9gEXTU3hRKuC8FvHkxdVk+m1bSo8BlLo38Z7O2BLIylN0WqEO
         u2YYtrLP/zzB4LbCAWRdbvj//HK1BYs2SEaT8bO6pdPjvUvWC39KyZAmruF9j3EoLjC4
         3sdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKRwvhLy5pbovMrnA/OKt+kbHPm5JUYRKMxNDUV4QyL71jmWHVtWWH3uI85+8PmIKNUnlzXRLS5WAY3u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjrSZSzOezpYdCDdBCr2H8TSHXB5L8HELrDY+l+q6kgvJqfu4x
	pVgYe2UXAjZ3CbvkYaotQnHig0v9iq+kpnbYKvrVIvuMjvo+BwJ3Co42JGRnXjE=
X-Gm-Gg: ASbGncuCKgToyyOlA3VnCK2rbenFo9Q11K2kN54NHfqyI1dqeJj0I/me1BzSK8X3x3V
	ErWbI9LJJMYMsq190GzAVmj9MejE8B3i9GJMK4b8xcCMQ18sBTOVL/BW3vofkvJ2JtxcxLwALzN
	r7MuUwmvtHNK4k9KDuMPJrdDaFw1uWcC3TW+HG1/ASlibyqCquFQF29GniV1IfVWEgdOB6uzTav
	T/RL2g4H+0jCLWU5pzDb6pjecHuYVp9CG6yd4xZeOzz4D8OFNSPl/r1wwcbINtK/HYv/ulnYsU6
	TZ4C5fp7G/rAKt12D9VF2hvs5TltDN+pgV8AXmCvlsHwPVc=
X-Google-Smtp-Source: AGHT+IHHZ/8jKdHrmeWg2W9ew9ZgBKl+G80VmK6gRjbRZx2tpx7r9TxqGynoIPH3wrYx9//VdC/l2w==
X-Received: by 2002:a5d:47ac:0:b0:391:13d6:c9f0 with SMTP id ffacd0b85a97d-3971f9e7813mr16838834f8f.47.1742314945185;
        Tue, 18 Mar 2025 09:22:25 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975ae2sm18914732f8f.51.2025.03.18.09.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:22:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 18 Mar 2025 16:21:55 +0000
Subject: [PATCH v2 1/8] coresight: Rename
 coresight_{set,clear}_claim_tags()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-james-coresight-claim-tags-v2-1-e9c8a9cde84e@linaro.org>
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

These look like they set the whole tags register as one value, but they
only set and clear the self hosted bit using a SET/CLR bits mechanism.
Rename the functions to reflect this better.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index fb43ef6a3b1f..3f1c996d668a 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -144,14 +144,14 @@ static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
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
+static inline void coresight_clear_self_claim_tag(struct coresight_device *csdev)
 {
 	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
 				     CORESIGHT_CLAIMCLR);
@@ -176,11 +176,11 @@ int coresight_claim_device_unlocked(struct coresight_device *csdev)
 	if (coresight_is_claimed_any(csdev))
 		return -EBUSY;
 
-	coresight_set_claim_tags(csdev);
+	coresight_set_self_claim_tag(csdev);
 	if (coresight_is_claimed_self_hosted(csdev))
 		return 0;
-	/* There was a race setting the tags, clean up and fail */
-	coresight_clear_claim_tags(csdev);
+	/* There was a race setting the tag, clean up and fail */
+	coresight_clear_self_claim_tag(csdev);
 	return -EBUSY;
 }
 EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
@@ -201,7 +201,7 @@ int coresight_claim_device(struct coresight_device *csdev)
 EXPORT_SYMBOL_GPL(coresight_claim_device);
 
 /*
- * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
+ * coresight_disclaim_device_unlocked : Clear the claim tag for the device.
  * Called with CS_UNLOCKed for the component.
  */
 void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
@@ -211,7 +211,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
 		return;
 
 	if (coresight_is_claimed_self_hosted(csdev))
-		coresight_clear_claim_tags(csdev);
+		coresight_clear_self_claim_tag(csdev);
 	else
 		/*
 		 * The external agent may have not honoured our claim

-- 
2.34.1


