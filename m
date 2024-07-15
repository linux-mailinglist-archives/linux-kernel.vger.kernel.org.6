Return-Path: <linux-kernel+bounces-252562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB0993153F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B663A281E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0BB18EA7F;
	Mon, 15 Jul 2024 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMwMrnUk"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC1018EA72
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048239; cv=none; b=Arun7jbFv20QCwFi3j8/ITN2x/IXtwe1QMQYqbDo0sIiL5jIxoVWwwhzexuep/23b35hq1/ouKLZr2+KF8y/W8ute0fithc6+L/II/C9fFdQ0q2HGdy3pC08XmS2FUK6BO17q9tIeooorVEetbZ7gmoQwgKTfu5E707XmmutWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048239; c=relaxed/simple;
	bh=+4kd2F1VnGUNVU9oW0bAD/syychtxHxo8PxEX9mf8lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VXqWqYFGbk6lN1qx8y5MNTf6H5YI7TDxvwoCp3fcniv1A3YYewnpdJaRkl0EJA1c+4mLdn1zUfeOugnllF2FJoIrQhkM0tHMDdRAkL2mTVf/qZnePBtePHT5kdZphjUwKDOjaSRIC9GMfUVPA/x1mYJiqgRJxh9yrxDeWAHEGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMwMrnUk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4265c2b602aso28386725e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721048235; x=1721653035; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnmqxlBPCkR2j92uKnpeN2blqkcOYQP6/xqO49jA5GI=;
        b=wMwMrnUkfken2fQXhlgBbdj049YdQTIKy+L3xRPZ9cm2yNfJQ2+OZR+QI6Zz460zrs
         MvDFUQ0BdVsc6Ie202x7OJ0yFbwfz8VS1QNQFk0lfNKZYKWD8D+03MQeNH6gfDRJJK2R
         BE409ukhmVBbmABeih2W6umtsY1xbumVgxvWzv8lhQck4MuMnsKwp5fHQws3jDn4qorJ
         /5q8JG9sR3TUiFdhRUW6u2xY8nXzM7WwlWlr9Z9cvt/35OHnd73RS3qEuYwsRFXlMH18
         K1bxOaHFW1pdYBO8lOlNtdpSrZjlu6kSgj+jq+tqNXgU8QNjRoXI2PuTnqVs00Mwt9Qx
         C1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048235; x=1721653035;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnmqxlBPCkR2j92uKnpeN2blqkcOYQP6/xqO49jA5GI=;
        b=lAXqqGD7bFzTqhEDdSYXBmwI35aBOqKqIup7514g8Tu5VfPoEfveEmf9kOKpuMZDQD
         ZNplkSdi6gDETssxcyWNjD2iaphX8WJa/j4bxi5xtzhSiWT7cnFbs+sbElgZ2RmaCaW6
         sZe9B6cg8JakiipgqdtZFS2G0BWF/LWusylDGcie2YXCISZZ9elG2o7Npfh5MssbZLug
         OE8KjYxbiFrz7pMoVV/2NCTHII0usY0YvictVziDHEyPB90wJc3qHsktbCU8eK80wfyy
         3VosVvEoCqvUz0YNvzNa96wz1NNbE9RpXtkg6EsmsfJ2OojVOn/Vt4PQu5Ze1ilw/9sZ
         aa2A==
X-Forwarded-Encrypted: i=1; AJvYcCWkEnCeWIwC6n+XOZz59lCjBpIw2dv4xtmUPGpOogZ9y0rRF/mLiO4LqXNrhVhd6mWZpAnOSwgXna3MYsKanHHnuiujuOPkeoEQjCnj
X-Gm-Message-State: AOJu0Yx/KGXOtbqdbj3RCTBx1q6ttPsryzZJ9QuvjM7gWfB4YfB8o0C9
	7qv2QRH63LzSCWJ48l9cLSqa+ryrmsH2J/zgotS/SmGPR6SxX9sK6bxHaF2OOmg=
X-Google-Smtp-Source: AGHT+IESyZ4Z7rBrd/pjuZAtkysmd8HKrQLlJxI1+a1THWh40nxYbZNSoSFDLdkyn5qOYjRQF4e3JA==
X-Received: by 2002:a5d:4ed2:0:b0:35f:28e1:5028 with SMTP id ffacd0b85a97d-367cea67f26mr12074672f8f.15.1721048232708;
        Mon, 15 Jul 2024 05:57:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm6303018f8f.68.2024.07.15.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 05:57:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 15 Jul 2024 14:57:06 +0200
Subject: [PATCH] power: supply: qcom_battmgr: return EAGAIN when firmware
 service is not up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-v1-1-16e842ccead7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKEclWYC/x2NQQrCMBAAv1L27EIaGq1+RTzEZFv3kDRsVi0t/
 bvB48Aws0MlYapw63YQ+nDlJTfoTx2El88zIcfGYI0dzKV3qEvhgDWNqzP4LlWFfMKJV3x61TQ
 LKqWCuuHXS8bgvJ2u7hztGKFFi1Bz/8P74zh+jUtAj4AAAAA=
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2617;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+4kd2F1VnGUNVU9oW0bAD/syychtxHxo8PxEX9mf8lU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmlRyn4WsgPHsjeq6W3RktjkoSu9goVIP+o9UE2tCo
 gJLzYGqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZpUcpwAKCRB33NvayMhJ0cfoEA
 CquF4UV2qZzHb9lnIWqRh/BggKsTGggRpl2qQU8AW8IAZIIqFTV/h+dHY3jwIFkIS8tVYGZii7glFg
 6WXp6wQkX9hHlGA08zmW0aJhIgNVS3aQ8jmeInD/IBPj/m059AxH44FSqjjWrZdKXMTn6UjXqMa2d1
 lgX0bANe2yZjzmhOuIxAaPiBTKwjSJeyM8q6kGT0j0bAA+YYpfHv+D04H+d1RGy57NWrjlaberAi15
 3Yby5R+veUvn5wb6xbTM0rlNht37iM+KrrZKiSweiNm3xgDbnJS7xWourNCOH9rMDFFahz24AsfiP0
 f6RupQTTErVSjadBOTzjECgcz0KZ/iLMpcL/EBqrko5vFh08xaH1426wBGsReEOTz4b2MeJXvrnnED
 nsHV6wXUw7PZehBKgjIZF+eLOfarMsPgu3vSkU8QAydZN9yPzLo/HNzFXasgA2r50bKSOViemKxUiu
 pjSyuUCCUJpjtUVSbxh5zOgniFxeULOgkH8au11Oq1LMTtkfdCPbi6Tb3GROP1KEOl/Yil52iiQZUr
 PpjgM7rM5EAF564IgwfGiIW0Pi1ujP3FPx+18XJyihMcnhydjZEM5rn8z8jnnN7fGxJaBr8Gy9RPtI
 x0kipwe/6gUtT4AM4bmiRu8wcQ/yOkI1cWaTp7KKWiFzjpS4dUIqnIu46RGw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The driver returns -ENODEV when the firmware battmrg service hasn't
started yet, while per-se -ENODEV is fine, we usually use -EAGAIN to
tell the user to retry again later. And the power supply core uses
-EGAIN when the device isn't initialized, let's use the same return.

This notably causes an infinite spam of:
thermal thermal_zoneXX: failed to read out thermal zone (-19)
because the thermal core doesn't understand -ENODEV, but only
considers -EAGAIN as a non-fatal error.

While it didn't appear until now, commit [1] fixes thermal core
and no more ignores thermal zones returning an error at first
temperature update.

[1] 5725f40698b9 ("thermal: core: Call monitor_thermal_zone() if zone temperature is invalid")

Link: https://lore.kernel.org/all/2ed4c630-204a-4f80-a37f-f2ca838eb455@linaro.org/
Cc: stable@vger.kernel.org
Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/power/supply/qcom_battmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 46f36dcb185c..bde874b5e0e7 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -486,7 +486,7 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 	int ret;
 
 	if (!battmgr->service_up)
-		return -ENODEV;
+		return -EAGAIN;
 
 	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
 		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
@@ -683,7 +683,7 @@ static int qcom_battmgr_ac_get_property(struct power_supply *psy,
 	int ret;
 
 	if (!battmgr->service_up)
-		return -ENODEV;
+		return -EAGAIN;
 
 	ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
 	if (ret)
@@ -748,7 +748,7 @@ static int qcom_battmgr_usb_get_property(struct power_supply *psy,
 	int ret;
 
 	if (!battmgr->service_up)
-		return -ENODEV;
+		return -EAGAIN;
 
 	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
 		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
@@ -867,7 +867,7 @@ static int qcom_battmgr_wls_get_property(struct power_supply *psy,
 	int ret;
 
 	if (!battmgr->service_up)
-		return -ENODEV;
+		return -EAGAIN;
 
 	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
 		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);

---
base-commit: 91e3b24eb7d297d9d99030800ed96944b8652eaf
change-id: 20240715-topic-sm8x50-upstream-fix-battmgr-temp-tz-warn-c5a2f956d28d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


