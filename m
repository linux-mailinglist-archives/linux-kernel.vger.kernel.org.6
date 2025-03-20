Return-Path: <linux-kernel+bounces-569878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEDDA6A8AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B89825E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DE41E0DDC;
	Thu, 20 Mar 2025 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J1w+7ufV"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053411DE2CE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481313; cv=none; b=cXpEElyouR1msSQMt6U5Qa7dEdImSYrmP/0BSLOaOxAmaBV83wsoSc2gzD/J+13FK0K2MvABBadY5zIjb8b87rIYUaO9pgi9Hw44gB9f4i5gBxCe4tAb8/zyxC5U0N2Wk1z+x3WYwKq+8BqQsuNb6r0RS0eoNCk4m2BW8HymXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481313; c=relaxed/simple;
	bh=Z5Da+F6VkyhHflUT0KEZm2iJfb1CQUcHgPNwJvyDzEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xxfz+iJFwLL7/lmn+zzVbf+68W7WHanRTgnGdj/A1/OmXNQ9h36k9iYxiXzifBiWQrsQKKwfmh/Bn2g295g6EADDYVY25oMy+HoBoWnix3NCDnYbnNP9ZlU/ojPYqCJ0V1g654MmK+2uykMnZov0PaMphhVkojCtrSL6g2jor04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J1w+7ufV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3995ff6b066so503611f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742481310; x=1743086110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYUfMkztXKy34QMNU5C7rZSoh6cruK9lZLqrSczib9I=;
        b=J1w+7ufVA7Sn4zE2K3ATOTBy5sdWIb9QNGRHRTJTktJVOESbfDfJZeA7EOU6/U7Dgy
         wNPtpNXvatMQziLrnp5XpzwYUgI+0uHAGeel0aCLmivPLG1l3aI91JfZ3j1wvXqbS8sD
         tqQAud9y03pdTeh14tIwrBVw4A7OAW07i6LGCfjeoKUDfqMQ6Hdbqc/2wbf3PaOHT5xX
         rBgXZ/q7vvbHHMXbg3uRrs5VWViYxRfouBmujBB09hqClIxit9IwxS4hx7MQArHooMuv
         ir5ng9VlxVnySnZgtScq+uNlnlOaunKsDuJFBlq1CdhmGibHdA1MWzPoA8PkkjK2EJ7U
         jvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481310; x=1743086110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYUfMkztXKy34QMNU5C7rZSoh6cruK9lZLqrSczib9I=;
        b=CZnZm9mjkqpl8dr3+3EpQwtoEK4oKdVHES3x8dTWezMgcVpya5JTXBZ9imvin2dNwx
         F6d1pi6VyHLi6XLzlaaJx+0GXAQOSAkLyJijpLvgmKi0CYsdyOgRspBeSYnVqvlOfqBI
         4FS0gHN3NPXkFdpmtnqKQ497f1jNOMEQxZLtlcbFRu8zIwM9xUwS1XQFLa3RRA4wleXF
         I1wa/X/1EkjORTpY6Dnai/TECDUDRw7mbLZaSkKgJGZYuSsYio3/EcFRu5sHrMd7ushx
         GBaO1rdsSZ+9YFCu3mFBkgKIHiqoF8MJZU604+OFZ4ZIp+3uhuQimDQD5WLtFR1C5Qq+
         XhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkq+cfr9w9zt4fS+6t+DRTNOirJxFyb/jviEoHIiplbM9wHmqkhyKqtwX+MmjZHgsvGICN8Q20eAFD3t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWx6i2JRfICPpM13J8nSXqlohB6n/arkraHJ73bRah4sLdoROv
	AJIJqN99KiQ1RD5sQDeW9I8YRGxk7tp42jq2cDTPOZQTGpaoNMegtvw4J+q4LkQ=
X-Gm-Gg: ASbGnctEv2J/EeSS477l37Ve/bYa08saX/XSxRF+lXL8nuFPGg542tQ1z0AkD5IOkKm
	cOjrh6vpsrLmM3098xxoOadXoITPBL5Yva+aTVR8goD1kio4dmVxC/QxQlisO4U4GNBAowOrFs2
	Q/qFfkNMhFEvAZNgjWq/ZNwttH3YyfHQOa5G244gMsFbnkeZlXfdM/u0pJ9GlrIUbtzn6Kz3S6O
	BCJGbezL6vJ8i7H+EfpdMKxpf492+PZDerP1FcPkBDo7ISsouuvHMrQUmZVNS/s0BHkgCtJjM5k
	hh2CqUUCzqin0/zeNp9MtG5eVk88F5zPic0nbibk5FnCAyU=
X-Google-Smtp-Source: AGHT+IFvAZmo6NQ5OijrhciMN1Nhf7aIP4JbKjIelwmleIylRhiLnS3xjpZn3CfOBVpMLOLSS5GLhA==
X-Received: by 2002:a05:6000:1889:b0:391:a74:d7dc with SMTP id ffacd0b85a97d-39973b048fcmr4580230f8f.50.1742481310086;
        Thu, 20 Mar 2025 07:35:10 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a27sm24238187f8f.31.2025.03.20.07.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:35:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 20 Mar 2025 14:34:11 +0000
Subject: [PATCH v3 2/7] coresight: Only check bottom two claim bits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-james-coresight-claim-tags-v3-2-d3145c153820@linaro.org>
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

The use of the whole register and == could break the claim mechanism if
any of the other bits are used in the future. The referenced doc "PSCI -
ARM DEN 0022D" also says to only read and clear the bottom two bits.

Use FIELD_GET() to extract only the relevant part.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 3 ++-
 drivers/hwtracing/coresight/coresight-priv.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 8471aefeac76..26d149a4c579 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -131,7 +131,8 @@ coresight_find_out_connection(struct coresight_device *csdev,
 
 static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
 {
-	return csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR);
+	return FIELD_GET(CORESIGHT_CLAIM_MASK,
+			 csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR));
 }
 
 static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 82644aff8d2b..38bb4e8b50ef 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -35,6 +35,7 @@ extern const struct device_type coresight_dev_type[];
  * Coresight device CLAIM protocol.
  * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
  */
+#define CORESIGHT_CLAIM_MASK		GENMASK(1, 0)
 #define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)
 
 #define TIMEOUT_US		100

-- 
2.34.1


