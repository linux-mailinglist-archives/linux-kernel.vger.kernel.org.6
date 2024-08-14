Return-Path: <linux-kernel+bounces-287106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4ED9522FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D661F1F21404
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8270D1C230A;
	Wed, 14 Aug 2024 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lo/7IS+e"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8441BF315
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665512; cv=none; b=V1jXjAMmvOUPpuHL0uVRGiW38vm+23Uuyvgbe2iJyV7Oe4W8MkqDEyi4BAyWIh2m+tj6tXIZQ8twsU+YAgKSJBdCQh639j1mCn00HYV5uKHtVvlofMGw5XQqyNkHY+ZXBdD+m419F1nROJ93tSbvVRgzBjpGZ8Hm6GIgpPaKsCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665512; c=relaxed/simple;
	bh=DrwiAoxoyEqBFQNKyiASdBbPbGDrpRDECmNJiSspMII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnQNmxojoCilEvGuXSV9p5vryTjOnJPsECmWGroeL3eeuJM0OWUXAoTLdirc/NItuXpRKMh8/Jw1SrwwD5kmd1Y2tPThXNu3m1u9HWkBKw4daQTTBpDAQNsFljGkSothGnZQtadMyufaUKBilsIlqq5SB2BxiZzOB/Q315bwvds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lo/7IS+e; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-369c609d0c7so178205f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723665509; x=1724270309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb257pBqZhP6UYLMmFTbQ8fmxgCfB52QrCQL5eJC8t4=;
        b=lo/7IS+ey3auZSvDTSEb9NhSRN8yGfx0CVjtG4SKmKZ8W6r6XQNu5suG7g6u3/CrwW
         5/HIGUctPpX8SKRjxLSGAF3FWYfbQzGCy+vFpll9WchS7tdOrYU5/fJsbA0rqxNrPLXM
         C5PI6BVuITA/chhTXiBmjBEaKmEpJKsDA2CYrQGpUwQ3VdVxEcJu5vGmP4PWBK3OcVa0
         TEvL3iU76aMx7QvmJ++zdnv+xlFrrUtjwusZowOSAOTDYIh/4cgX9tjCkXl6GX5KFAtt
         lruq7iZE3BgY3zO3Mq1Urct5Hj094ZXY5yXgI/ls3mbd2CPR1bhVvPlwyHHiUqC39Xb2
         /eYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723665509; x=1724270309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb257pBqZhP6UYLMmFTbQ8fmxgCfB52QrCQL5eJC8t4=;
        b=oLhMMztFJ9e+vJP29TyvGn5EXA1z7FRtRPQ7GXIgXey5yE2k1f3Y8iyDOd2v2JIEf5
         I/h6T8i0osGNyTgmROYhWw7b4QiM1gHY8V3re+5ZO7jSYH+zdbbUQpNC/Vms2Y5VGI6k
         7S2ljQTkZPCd1EexVUpV+DQcR93VHB9DIh5OR4kZWQ/gDrL0WO2JM68WCD0HKwvsjWxg
         SnihrrKTah9livJE23eWS0tr0ZerHcVPTghXuKdpeWQCze82WHp1VOzrcEro/YYHKzZf
         Mr2HCbrcoJNK/Y9fcXdSB6hgo1wXM9h3RbIG/XEy6x8xRgIC665BJp88rOrH6k7UZDTQ
         TnVw==
X-Forwarded-Encrypted: i=1; AJvYcCU+vvvddpS2NPSFpS7qxCW9qvktY3PKUEDTEAL+zwYQ9ipKGpSRAY8jIW3c1eeY0R4vM8VXpcmnXilSIwpntw8uC3xskwGkrY9uSPwl
X-Gm-Message-State: AOJu0YwVljU6OFx9btQxvnReUfOdICuXkLavHmxduKFpPS0N7nivgWdM
	Sc8Wu3aJw1QJ/SJEBwWM7WrLtj0H/YjpmhlWccHtOPxIFWZotNVQoSVuzMBgt3Y=
X-Google-Smtp-Source: AGHT+IG88V2hU+EgJ7Lr0puPbxnLdAZ2m99QYLzaH5h8aG7w+H+SP6z/ChwWFYdSv8IxFj+SArDOkg==
X-Received: by 2002:a5d:4ad0:0:b0:368:6606:bd01 with SMTP id ffacd0b85a97d-371777fe399mr3092052f8f.55.1723665509278;
        Wed, 14 Aug 2024 12:58:29 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeef76sm13482263f8f.59.2024.08.14.12.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:58:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] thermal: of: Fix OF node leak in thermal_of_zone_register()
Date: Wed, 14 Aug 2024 21:58:22 +0200
Message-ID: <20240814195823.437597-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

thermal_of_zone_register() calls of_thermal_zone_find() which will
iterate over OF nodes with for_each_available_child_of_node() to find
matching thermal zone node.  When it finds such, it exits the loop and
returns the node.  Prematurely ending for_each_available_child_of_node()
loops requires dropping OF node reference, thus success of
of_thermal_zone_find() means that caller must drop the reference.

Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initialization")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal_of.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 30f8d6e70484..b08a9b64718d 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -491,7 +491,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		return ERR_CAST(trips);
+		ret = PTR_ERR(trips);
+		goto out_of_node_put;
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -519,6 +520,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		goto out_kfree_trips;
 	}
 
+	of_node_put(np);
 	kfree(trips);
 
 	ret = thermal_zone_device_enable(tz);
@@ -533,6 +535,8 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 
 out_kfree_trips:
 	kfree(trips);
+out_of_node_put:
+	of_node_put(np);
 
 	return ERR_PTR(ret);
 }
-- 
2.43.0


