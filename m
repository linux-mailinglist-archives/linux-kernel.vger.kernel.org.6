Return-Path: <linux-kernel+bounces-569879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F865A6A8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3E6982ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFBB1E32D9;
	Thu, 20 Mar 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rc0KDaXC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305D01DE89B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481315; cv=none; b=LjIBt1VOtnn3xIUwZd9CeL7hU7LanYPu2wMztXUqxkR9nRkfW/oWxfn+Vb4xRcJq4AH1POpDuGVS9J6mzY813X8YVgs/enPCqWeAdmreovNf+gluXypks9ZNJVYKwT3oFdPdJQn32uX6zGWH03kAiYBd5alTzmJlnsj+2q1ce3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481315; c=relaxed/simple;
	bh=/TQi9hGIwczvXOfFuna/JuZiQ3jncdRoqDy2i+Hebio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBxgzXHn1pSx71+agreMf2pT3GRPjKta2VuPepEoU/wXMafIKZ9PmdOm+38nZSl130XQSVikoKlqzAmK2rcmTP0hL+AipSJ5vrNpucCbIYY4yqZCpo+jdBpLnbD+Xw/HGMbPgAgIPcbIANozIIXnrpGpe9QOICukwzStvycLJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rc0KDaXC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so5464635e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742481311; x=1743086111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwLrnZ7veEKh9dgDPH9OcYYObOhDGXo4oYTlew/IRG4=;
        b=Rc0KDaXC1I7qVgotF3mzGTOuzZY9awhe/OG51VOUuIbIAcs9HFgGbVD8wt9+2pU7VL
         eBUq6ptWXTwuk9KfU2PEjndzDkE7/h/CGO9H5OtzFQzrMHOrNtA+esKGv63PecMX4rBR
         jhhg3hFD6wOWetLv0Tuitd/OobZGNgwOkyYuplRLSIf+2pD4fCyBliYImlJAB4iM3pOk
         Vez7aaAajYJo/vNUrlbdtVpDlzY0mZF8WHKL1U0RZF5h9eJ8CuJNqmV+53T7vmvGuczl
         2phJG/Yz6wcZYxRNNZIZIv4XTsWZ+yKQl5ceI1h5k/LIFEF4gGgpF6DiOR0sNRxFUus8
         5fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481311; x=1743086111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwLrnZ7veEKh9dgDPH9OcYYObOhDGXo4oYTlew/IRG4=;
        b=qYkRkJrSX5ppNykRRQgyUwOf9pkOnNxKMrVNmFYJ+S14kygTgEbTnyqUBC7xFXULFa
         UbvkXXXLgP4mIEO9+7Jpf5yYW4ryQZHR5umJMnnyTJQK1a2QxmqvVr0UMdhlUY4iOxof
         NiJZG/mPas3EO+m0YYy+AlfXVEKD826CtGOqc3q9+Gb28YwxQMc0jL1b+/btrRzscHYU
         yQM5wTwEux//St0LC43C3OVZAVhhj8FNmGbTSJi35id8HwMXRdpKmVsfATHvo7wVLwkW
         jrgK2XH6HnmI5vGbN2ox8JLUwzsuKyKoMIeIQVOUAawgGirerkmf6JPTf4nImTNbtYNc
         1v1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEGsqodvi2XSP6K3ddpapR4gKu8YKOHNW+SaZS6867Hqn0xHvVHabikYDFE7ty41HOLVgsb9sTuY/Fm5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAas5LZ4Iu6icmwLZMxM9mBTRrQamorxHSmfit+JUHZouQs+Ba
	EBjcdH8epyPxtH/9nkPHWAXr5cvpjjSW7Lc5spwgIyLjOreSuaY3AI25Pvu7WBY=
X-Gm-Gg: ASbGncsMwsEOA6soFo9cV6xtpiWI0qTg8gW4tw91KbomF8vfrlf3Tryo36WhMGPtCw3
	+ke8tTD58mR1gy6mdx1XYV1+1t/2hV+HG7eM1/iXOH04pK95mYodobJEhS9/KBhOLnwK0Da2dc8
	MqvhNh9OjNrLG7rjZm3/9zff3bqMu/soOn1IsQ0y/PYn//6fNzDTZCCN+T0AW3wNAJgxcZhWMAK
	wuxH1UnFk2xk07eb4cUNFrigGVa/fEBZPqy1zO2Kz5l/uxa/4D/L1faQlvbjvD5qwlGUSKA5nV/
	oH0/IM61XdGWhs2HXqokdndDDF8GrHxExaz1fVxiI2guhX4=
X-Google-Smtp-Source: AGHT+IHwP3zwF5MimE9Q6RcdnULD6yCEU4RZj5mW35Mho0ZLiaj7qqK35hnHeoXoBUJLCg626reWtw==
X-Received: by 2002:a05:600c:3c8b:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-43d4917b597mr32574525e9.9.1742481311313;
        Thu, 20 Mar 2025 07:35:11 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a27sm24238187f8f.31.2025.03.20.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:35:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 20 Mar 2025 14:34:12 +0000
Subject: [PATCH v3 3/7] coresight: Add claim tag warnings and debug
 messages
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-james-coresight-claim-tags-v3-3-d3145c153820@linaro.org>
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

Add a dev_dbg() message so that external debugger conflicts are more
visible. There are multiple reasons for -EBUSY so a message for this
particular one could be helpful. Add errors for and enumerate all the
other cases that are impossible.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 51 +++++++++++++++++-----------
 drivers/hwtracing/coresight/coresight-priv.h |  5 ++-
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 26d149a4c579..2b5a7cceb719 100644
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
 
@@ -222,7 +235,7 @@ void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
 	if (WARN_ON(!csdev))
 		return;
 
-	if (coresight_is_claimed_self_hosted(csdev))
+	if (coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED)
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


