Return-Path: <linux-kernel+bounces-566524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF88A67959
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818D73BFAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C3F211A02;
	Tue, 18 Mar 2025 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYKZIDQf"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955D20F065
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314952; cv=none; b=T4QpmP2E8yJYk8iCllFhmOqKory410KB2Bk2bzIt1w/C0w6BLDvVkuWZvv/JKcOS9Kgg7xjgguIfpklmWK+PFajGMJInOGRlMdk3cp0aj/OCDaS520iAtt8QZsrX4imjPmB3F5oaG/Uxu3+wjcjabMdSpBQnN93N5HBKYM8qa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314952; c=relaxed/simple;
	bh=ur/F6z+BKpgcRzNZRwe4VqbsSZ4s7EzY/OzNV0qi5h0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twslIisJ0kf6nxvfeRJL75uJBkWIF1RFcMLqtwxNPIG9tAeU8g3LALU9f/uoiDEpuHHoQcZ+t6oa7kqLuYuEeWmNb6Pk3j9e5qz20r6iFuvJAfZtVBWoZKV2RzA/DjyX+qaqSrZjOMJH0yG1K31Mrg7bAf9PJypwHV30oergnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kYKZIDQf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39133f709f5so3650653f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742314948; x=1742919748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALchZOot//FGgxa5QWuInvWCPSBt1WNbqrc9Q6XX+5o=;
        b=kYKZIDQfkoLJVB2oUdKWCeHz3RnSURWJ0YF3Rg6vWDF6CPIIE3oPcyCQ5ZCT3r2jaI
         LJTEq5Jqr+iMilu6RMeMEf2KAQnBZqNmT6eUSiECOeS7s5zC9X9buHntTEE/PvPPKfWl
         772Slf7l94ek/UdYr+ELKREvMbUEwKhP/B3ZvO7zhA5oXkUOBv2Nmxkr4AdcKpkvd37V
         xk1BvzIw1F+nKxrmOa50xo7jYt8f8ikpgsnaD5bjyDVUAoM2tAsaXVFXunVK3IlMjY55
         Vwco1w5bn6uWb5tlT6zU4d6BkSXP8ofUPZU9Occ4d6QlE5NSAaMCBIwr6IRFYL8kmHN5
         WVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314948; x=1742919748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALchZOot//FGgxa5QWuInvWCPSBt1WNbqrc9Q6XX+5o=;
        b=LdqJRJjAzTbsDpTJa9Frkuf0j2la+tYrlhwY0zCDbso2r9n7QgOWoljK/LyqA1CxYL
         iUReDenjIf9mSD27DUZJUwVMmVs7ZGC7+Y4Qrrn6+fW4/62+vzEWcD8w8Te5MIEwv8yN
         sHeLqWjvAwmy9QD/IRIsNfBTrqcO8pGZAfUlpKtNBe4jagLnEj60xSnPQhoNO+UZ/6I4
         dH6W27coMAjf9tOI1a5/R+SyLEOLj4NI/8qn+3PzqDBTBywpndAdnxPULN15DqNkpmQL
         ihJIpTducoAxsrQRYa6wyGdz+NaU7T41cwIGZlO6lFpXQCNLy/M4aJI22bZZQKUnvng0
         QuvA==
X-Forwarded-Encrypted: i=1; AJvYcCXMbwMc5KNtpcNNryiBNDm/5RQVMehAHQU/HttdsDgBC8hfN6jlPQtCAOWv29XSFz7tXzLFjWs4o8aEnDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrm0bdWiEfI4Sjvp22s5I1BK0YnFrlnmkeV+RoBXluR/RfaxO9
	wyfgq2mbrbWHvcqNVBCqQoYjb0hnNVb6SJkCW9Q22XkzxhCXpUpBXKHtDw9Mkd0=
X-Gm-Gg: ASbGncsnjXZvmmVFVat89ONAtwopDeVI9OZsJNS8jxjVVRSCPac/zq3bljBnhwt4oO/
	wGbdsbl0XnQ1l3UOUQq0j7OTCd9BcAEhOi12PRIuBohEfxrwacdh7qGi29Cm+NVHKc5D6yWHaZ6
	t2/qnCOEG9lP958DT50+MlghJovMnip0MJXtF+rWuHqrNt+JHyM/tBbqLEcCOfMHqJ09pl1foQY
	jHcVHwbLHVLG99TVMWcN5Jy71MsGZhdi7ZQXZLaoGVmVl+uRsMS+x76vtZIAEtPJnPFX40en7nS
	2fD/2+4NklOdxIXn6HqENg5oFHk4ezJ24V6AY6OvgJUCV8PlxxyxWHgPEg==
X-Google-Smtp-Source: AGHT+IF4rGnbGHEoa5pDKJFwrg3P3FevDrpaRcIRwif399qLvhZbFXQMfBkg079H3FFpst3W+F7xmg==
X-Received: by 2002:a05:6000:2a7:b0:391:2e6a:30fe with SMTP id ffacd0b85a97d-3971f9e517bmr20040164f8f.39.1742314947911;
        Tue, 18 Mar 2025 09:22:27 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975ae2sm18914732f8f.51.2025.03.18.09.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:22:27 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 18 Mar 2025 16:21:57 +0000
Subject: [PATCH v2 3/8] coresight: Only check bottom two claim bits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-james-coresight-claim-tags-v2-3-e9c8a9cde84e@linaro.org>
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
index 9ff601e2415a..e39043a9551f 100644
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


