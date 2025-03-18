Return-Path: <linux-kernel+bounces-566527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F6A67939
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942DB7AC219
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C0212D6A;
	Tue, 18 Mar 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5PdGYf6"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3321147F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314957; cv=none; b=YntO130PjsGfojLlp4n8t5m4FOztnjX+okUHUdw/H4JrhS38X7NLsk8wUrOoJL5FYvaPqzmuttsPGCSn2UUc5VzxQAxj5jfLudG13ez9eRzoiZUeBYll3HAyXurRK77fQVLNnAjevdcIXflz+6ASFGoUP6QwJXCSti/E8knNeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314957; c=relaxed/simple;
	bh=VHfk7rPZPGNJSFGaFMuMN1uisblm084tl704VCyo+/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DvLmHR3nrP7mk5zYeH0NIkW/TCtBzE4+6RNGxsIE0/7dpyd1bKzGbegL9P+B+Jt15rhUK8YNxBLtgsKjVf+Xu/2XLcC3jIBvbVgQ3PTw/+ti3joZIDjQa6tV45ME8ndflvJK+9HYJTwYIih26G8XLEJz605t/tSJQr3eeyDcSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q5PdGYf6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so36273895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742314949; x=1742919749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGJ5zCEXGy4gA/KaDFLiaN40rMPxYRX5syJtqsz1eiI=;
        b=q5PdGYf6ASajl8Zmwr8Rs7e+ulaL47PUn6NL0MEdP0+44vlk1Awi6L8l52RcbuNN28
         tH/Z/cNWAeSGzkzvlXTaTwXwI+PX6Wf4kuWcTFGEG6MmnvVPW8seTqwCce3AQSvCMKng
         hjVnij9jL3KJFfakKrUIyxRzknx9ounFiZTWmuyq+T8eJxabZrUUuBFMqMlmigaE1Pq1
         jmROa1s5aohsGxCVdhg9WQ7CyyyBhbNqW3XyxOZm0qF1XoIidLYy4aaNQ94/PIpvi/rF
         m6ml9dOAdGvC8V48muxGB4NMNdAQCHiHuiE5oQtTwxT9fjT15B8GVxtyS4IyQJCdns+6
         LffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314949; x=1742919749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGJ5zCEXGy4gA/KaDFLiaN40rMPxYRX5syJtqsz1eiI=;
        b=dlMLjUv+CRcNYaXQPU/BOWSp14zba2TBKqhDq50ADCk4GEEjTHf+7pYtksjZgmeocX
         QYccHgIhYTUMa4FQe5Dkrn3WfmOO+PzaNxJ342akDqb+DuLxeF+zUWd+NHHI8VLcN5CD
         OtjD5qR9E6nmTNEGdQmoUnVAPwOvZ/dJXiwHDd/u3lioYr4w/IdAp9lPPZdT7wGfaKvB
         x7HJKDcnOdj5qAl74KKDbNn5r8MwY6+TJZvB4EgeBbrmDSJsNX6Se1wxW5jZgi7JdeRQ
         xXlyAqOD55GR7XXINvBjd8LWImyfPaZp9QGChIjJtco1dwmZdquo49cwoWjtPk9Snhlb
         z43A==
X-Forwarded-Encrypted: i=1; AJvYcCXTph7fHIHFhsIpaVarMOy+CZY88snu2x+55BSIdhKYrrhDRD6AT/l30e5BDhCDTAONx5kbZDjpvmrCl+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY1flvfFpvwsiWRDGg8vmaVXZ9hkMFo8i+vGgywM5CUu1CmWdD
	iy+jdigkWA18HDUrK6zfSV2pc4qHSRM5vcxCNpPF9Iidu4NRGSzrvLUv8K9/msA=
X-Gm-Gg: ASbGncugCDV2axF1eHMgN7bAsxj9M8oqkxpv304elpByb06WRym1CV3o1T/EJLA82bZ
	X4YrG04LuWchgIG3O0CYoo0prLJH7QekvAEeujLyLhlgkBvnLLKM2e60olUO4hpYvU1TMOjF2mI
	xv79sC5spQCtGjHdjL1QBY2Q9q1+gla2UZ/tmDXFXUjz1II9LDoLARDQW3sz4jLYbenb+jjejiy
	cvzaL6nDOtuv2sGRi2u97MITFAo4FOejiketuU27tt0iMo3RvGCbXRNbLCQvxV2IHnb2Btt6kW0
	MwXNwtaXl1f8v1NwOrh6OLC579OeJcghm1Z5mn8/2GsSbK8=
X-Google-Smtp-Source: AGHT+IGD5l1woUahupr3/UQIVjMPG5ye4Qvywoq72MhWarq/PntTcl1VjdMMAP0XoDz6JV4vEUnAmw==
X-Received: by 2002:a05:6000:400f:b0:390:d82d:6d4f with SMTP id ffacd0b85a97d-39720d47024mr12201789f8f.52.1742314949252;
        Tue, 18 Mar 2025 09:22:29 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975ae2sm18914732f8f.51.2025.03.18.09.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:22:28 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 18 Mar 2025 16:21:58 +0000
Subject: [PATCH v2 4/8] coresight: Add claim tag warnings and debug
 messages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-james-coresight-claim-tags-v2-4-e9c8a9cde84e@linaro.org>
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

Add a dev_dbg() message so that external debugger conflicts are more
visible. There are multiple reasons for -EBUSY so a message for this
particular one could be helpful. Add errors for and enumerate all the
other cases that are impossible.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 51 +++++++++++++++++-----------
 drivers/hwtracing/coresight/coresight-priv.h |  5 ++-
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index e39043a9551f..5f08845faf0d 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -135,16 +135,6 @@ static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
 			 csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR));
 }
 
-static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
-{
-	return coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED;
-}
-
-static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
-{
-	return coresight_read_claim_tags(csdev) != 0;
-}
-
 static inline void coresight_set_self_claim_tag(struct coresight_device *csdev)
 {
 	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
@@ -180,18 +170,41 @@ EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag_unlocked);
  */
 int coresight_claim_device_unlocked(struct coresight_device *csdev)
 {
+	int tag;
+	struct csdev_access *csa;
+
 	if (WARN_ON(!csdev))
 		return -EINVAL;
 
-	if (coresight_is_claimed_any(csdev))
+	csa = &csdev->access;
+	tag = coresight_read_claim_tags(csdev);
+
+	switch (tag) {
+	case CORESIGHT_CLAIM_FREE:
+		coresight_set_self_claim_tag(csdev);
+		if (coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED)
+			return 0;
+
+		/* There was a race setting the tag, clean up and fail */
+		coresight_clear_self_claim_tag_unlocked(csa);
+		dev_dbg(&csdev->dev, "Busy: Couldn't set self claim tag");
 		return -EBUSY;
 
-	coresight_set_self_claim_tag(csdev);
-	if (coresight_is_claimed_self_hosted(csdev))
-		return 0;
-	/* There was a race setting the tag, clean up and fail */
-	coresight_clear_self_claim_tag_unlocked(&csdev->access);
-	return -EBUSY;
+	case CORESIGHT_CLAIM_EXTERNAL:
+		/* External debug is an expected state, so log and report BUSY */
+		dev_dbg(&csdev->dev, "Busy: Claimed by external debugger");
+		return -EBUSY;
+
+	default:
+	case CORESIGHT_CLAIM_SELF_HOSTED:
+	case CORESIGHT_CLAIM_INVALID:
+		/*
+		 * Warn here because we clear a lingering self hosted tag
+		 * on probe, so other tag combinations are impossible.
+		 */
+		dev_err_once(&csdev->dev, "Invalid claim tag state: %x", tag);
+		return -EBUSY;
+	}
 }
 EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
 
@@ -220,7 +233,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
 	if (WARN_ON(!csdev))
 		return;
 
-	if (coresight_is_claimed_self_hosted(csdev))
+	if (coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED)
 		coresight_clear_self_claim_tag_unlocked(&csdev->access);
 	else
 		/*
@@ -228,7 +241,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
 		 * and has manipulated it. Or something else has seriously
 		 * gone wrong in our driver.
 		 */
-		WARN_ON_ONCE(1);
+		dev_WARN_ONCE(&csdev->dev, 1, "External agent took claim tag");
 }
 EXPORT_SYMBOL_GPL(coresight_disclaim_device_unlocked);
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 38bb4e8b50ef..6e8cf55aee0a 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -36,7 +36,10 @@ extern const struct device_type coresight_dev_type[];
  * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
  */
 #define CORESIGHT_CLAIM_MASK		GENMASK(1, 0)
-#define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)
+#define CORESIGHT_CLAIM_FREE		0
+#define CORESIGHT_CLAIM_EXTERNAL	1
+#define CORESIGHT_CLAIM_SELF_HOSTED	2
+#define CORESIGHT_CLAIM_INVALID		3
 
 #define TIMEOUT_US		100
 #define BMVAL(val, lsb, msb)	((val & GENMASK(msb, lsb)) >> lsb)

-- 
2.34.1


