Return-Path: <linux-kernel+bounces-575254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37211A6FAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A1B189DECA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C59F259C89;
	Tue, 25 Mar 2025 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZvewrcL2"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA45257424
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903953; cv=none; b=LHdXFzb22ePz9J9bqnVkgRC+9WiNNJzvzD7O3X9yzFM5m9RosR/bUYjqcu0yzbsHKFQ5RTgy496dVBB+w7gU0sfK0Ob0oS/j93EtVn+Mm299ZeQHRFtWzil0FGB8su8cF5qoBVrfPTKklu6/6C/VicQ07JXZEWMX1AgjIVKa4Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903953; c=relaxed/simple;
	bh=Di5ojDK3+/nIIbjWSHMQ9f6vtRhv4L9ofiGBkef3f58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJttAGv9l0LKqu/u4GseAIEqpAquBEqeN4jQmPtZhM9MWswJj8VImvrWZGPlE06deBbdpNJtQ01t9Qk82wsKW38ORwuXmc1MRygaSyS2hc/Q0heLsd+1BZC/yVJxizKG6XrQqLYA7Jp80vxGsuY0rHo4d2TsDdFaEah6JnecX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZvewrcL2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0618746bso37428175e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742903949; x=1743508749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpLFATDWKZO90jD7k6C19hhyGuSC5NA6ygL5CbsK9zY=;
        b=ZvewrcL24x2svx9JBWoiFrOkX2h4wwU63sYTxkVy6rSGpAiVmrA74ZmtWX8nZWMpJg
         mwohXGXc5pQMlIDV8haqcD9rIRtKhE3KkZtcrAlAOhyAVY+Te++rKWERl2H53g/jpLns
         V3YhJeVanHWbm9GcjgoUE5tbugw/STpa9n7ZJ2rb7bqF2iQ+mknC2XXnoUO5ve/ZJGuV
         eRqoiKSpgRQNNZMCVk03vTnWbvfpCbnRYFrbpjmQ4quYSb2XWifVc5crrdOeSbqQARuD
         hLT2ilZ/YE47BcTpdg+UljMKvKaT0mrwkhjp67ekkapjXcjUrOSqkgDMYxOVV/oGe1pO
         Yx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903949; x=1743508749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpLFATDWKZO90jD7k6C19hhyGuSC5NA6ygL5CbsK9zY=;
        b=rm0Xxvcaq471vUG8ubbQw8ZmfGsIL6WYq+LLltmf93pwgtQJaORH1mkuuKChAGv3aI
         iIrUwItPYGU9r6DSiq5wlpeYkJlS5s7vHiFqyCfj7ZV18oxmDlQXfoiTSCtCcR8k6Y8p
         W8sQGu//hzPeVIZVUtxxFoGNjYMdlK8HGvz88XVK7WNXybIUicUA/4D/1j5rjlFu37ZV
         T9J/FLxx7nCQNZyo9rfzDQzy9cJiecmD6suZHOAdNfyYUiayns+ILzIyhxsen+FIqmE+
         mqTyIWb3gSUkqEE1StNPWPIFhjENz4gqdO4044qmp7J5grGvLscwFYLb9K9SEeGRU1Mr
         +cVA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Il/CEmmLyrNcEG0dXsLMoL4kFQCJPeX345KhYBIFkVy/TlzekZOZ4rjFgETxmshXu1VEZ6JcX3IRXrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX2P/y/7r8mme0/Y1dRroWgZjSq+4Sd3/4Q5XdB4MIGfdKCC+A
	3G0s8W8QEmL7OmU6fH2b4eYBhWPHk6gHUZfHklDpUrhDJM4s8xUx/hPiVeanBFA=
X-Gm-Gg: ASbGncufa+6q8mXHKqFa6LPJ5DkZiZ5yxCpK8ZiMqQ3WEwpsyCFc0AVT2klD1nW8DRn
	gPlw9dY0gDGuJrHfdKjS2JRmUMoLffiDiqAaaUXGY2BxKBfdv/TTJ4k/8OysRVUGO18BsQP7Cje
	WUllOQxJYEXoo9Ze6NsL/baqHFeL7CBlsEHR6swe9E6pJ/3nIUqhL0A5yqXn+jWjk4JygKO4P6n
	4R2aKnCfIJAdCSxURyYnqchuYlH9/w27N0zpv3vkN1pYoC1lSrp4AgTTjWtJ7sKWBbN68bfqmlq
	cKLI1HiBQekgJIYPiBQwk5t+OQQgOeydyp5wBEglL7qzwMdq
X-Google-Smtp-Source: AGHT+IGQRLjfoklE/nAi3keHa2krGni8a8quLIKCujHbsRuNFsPx1OQ7JeezjpcD78ucuIM5tbYduA==
X-Received: by 2002:a5d:5f92:0:b0:391:4389:f363 with SMTP id ffacd0b85a97d-3997f91bc76mr13237990f8f.21.1742903948838;
        Tue, 25 Mar 2025 04:59:08 -0700 (PDT)
Received: from [10.42.0.1] ([145.224.90.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6676sm13687169f8f.62.2025.03.25.04.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:59:08 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 25 Mar 2025 11:58:48 +0000
Subject: [PATCH v4 3/7] coresight: Add claim tag warnings and debug
 messages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-james-coresight-claim-tags-v4-3-dfbd3822b2e5@linaro.org>
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

Add a dev_dbg() message so that external debugger conflicts are more
visible. There are multiple reasons for -EBUSY so a message for this
particular one could be helpful. Add errors for and enumerate all the
other cases that are impossible.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 51 +++++++++++++++++-----------
 drivers/hwtracing/coresight/coresight-priv.h |  5 ++-
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index e0638e5de0e0..33824f4a631d 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -135,16 +135,6 @@ static inline u32 coresight_read_claim_tags_unlocked(struct coresight_device *cs
 			 csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR));
 }
 
-static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
-{
-	return coresight_read_claim_tags_unlocked(csdev) == CORESIGHT_CLAIM_SELF_HOSTED;
-}
-
-static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
-{
-	return coresight_read_claim_tags_unlocked(csdev) != 0;
-}
-
 static inline void coresight_set_self_claim_tag_unlocked(struct coresight_device *csdev)
 {
 	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
@@ -182,18 +172,41 @@ EXPORT_SYMBOL_GPL(coresight_clear_self_claim_tag_unlocked);
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
+	tag = coresight_read_claim_tags_unlocked(csdev);
+
+	switch (tag) {
+	case CORESIGHT_CLAIM_FREE:
+		coresight_set_self_claim_tag_unlocked(csdev);
+		if (coresight_read_claim_tags_unlocked(csdev) == CORESIGHT_CLAIM_SELF_HOSTED)
+			return 0;
+
+		/* There was a race setting the tag, clean up and fail */
+		coresight_clear_self_claim_tag_unlocked(csa);
+		dev_dbg(&csdev->dev, "Busy: Couldn't set self claim tag");
 		return -EBUSY;
 
-	coresight_set_self_claim_tag_unlocked(csdev);
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
 
@@ -222,7 +235,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
 	if (WARN_ON(!csdev))
 		return;
 
-	if (coresight_is_claimed_self_hosted(csdev))
+	if (coresight_read_claim_tags_unlocked(csdev) == CORESIGHT_CLAIM_SELF_HOSTED)
 		coresight_clear_self_claim_tag_unlocked(&csdev->access);
 	else
 		/*
@@ -230,7 +243,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
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


