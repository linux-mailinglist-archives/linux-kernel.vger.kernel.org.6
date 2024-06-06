Return-Path: <linux-kernel+bounces-204457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF10F8FEF6B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E834289016
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864851A3BBA;
	Thu,  6 Jun 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5enY7g2"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676CA196434
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683921; cv=none; b=oQ5v0zCZS8C2sihh2baGPLDy9T08+ZZNMMHqojtmx7BB3aMfkaQ8iOc4jLYHRG+0pEiZz7wA3NU9WLcLsQ+rEK21QcRx/tHtB+ycRbX8dtdgkdBRDbk0ekU/oWEB9+S6MM6oCGxQP2eZF1wlbNS9GpIr3ceW5Ph9yH6njdbjM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683921; c=relaxed/simple;
	bh=0wQW0SytZFHqZu9CzAw3kJQX9/NII/M1iP5Xd7waWCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADTG54iRF4NlvYOUcZSm1YHiLDB21WRN3Fxkag1V2nztVJeIwSYL5XZwP1LBdXHg2Lq8q/lU1ny/g/iiGbaXgrZahb/j1SRoEBBDzT5H2IqHis8MioJJe8Tw+KAv9wBffxk0nQUv6ppVwfbfafhj0HwPfgMT/KykEmlj+FILc6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O5enY7g2; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso8421891fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717683919; x=1718288719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5pCK3r9E2RWz6TR4ZIewd3qMgy92mHcIUo3XGpYyAQ4=;
        b=O5enY7g2yVl3zmaw6tqbg3jo2npAQRpwhXiCBx582RvjlJQxe8VMvU0EM9ILD5Mu+f
         HuSolOjnKQURKRCCw/pfXv7mVxNwkp02Oqu0JB4V1j4da06tSG2Y53xwu/0XXTuvp4m4
         ksN9JWgSlgQdAdexzgkYDOL5NcVJzDapjCanTOzONRGwMRkDU2fICjflFdtJf/oM2458
         69K4FqYU7KwsxmuAUHDNWkJXUUP1YuOgSV+Mk9kuRsmFufCamTLEHrqGCvy/OmgwlhWP
         PpGbPPYWtG0gpNwb1zoenVx1m8S5okdapIwo298508QM2lkBE9KiD5XJuYE+/rgaqUsU
         QkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683919; x=1718288719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pCK3r9E2RWz6TR4ZIewd3qMgy92mHcIUo3XGpYyAQ4=;
        b=OokK9U5BG2+gQjU+SEjc49D5Hr4YQ2eyAKYUUpJhQZ81XCcVLEFpkvCs0hgZpgl1eL
         2yP8A3OjcuVbuQ/JIVQCdYIQxwn8pGVyj+BhN81S4y1OR2fmxRpGimgeLXw4U9IBtOle
         /Mt2EpA0WrNjHd3mPbKnRERP4i59sSwjr7Btv2rK2hLaPI7BBJ6EgXXQFiWNcvmPaF3t
         ugxLYJofGER/g+201YymUUe4ThXsr/CbGskO0JnffJKJGbWRYYPznzK/efNXvDy/UT9H
         5RVUwkff6OfsraUFYDahsCm2CwXbVJKOxjLqpuXAkJ8sRojMruweV9FQr1+ojgbu9gy2
         CqYg==
X-Forwarded-Encrypted: i=1; AJvYcCXd2ggDpCjjxZCIMxy0aQnXRKogjWU34d6+wC/x4LKoyilnlL8Q6bIZtDQOl8+ZbQoYp4+uRStG3VNQC6ZRZZ+otrMLEx6FZjRqG83X
X-Gm-Message-State: AOJu0YzpizxMyWJGzEJSLRrvQNh1L+VtTJ6rWhewm5yLPctZ0EFS2HIT
	lbesl4LuRpFlEZIGvAwfVHmEvwxHbm+kufecnbrEA2S+X9nMr6iRNbPr7R3wu28=
X-Google-Smtp-Source: AGHT+IGtLyF57Vmt6WZUTtXsspsBnLOJcZhvNhVu8VzggNj5mSsgsdeLLvuunFnpANoExVoW9/fzWw==
X-Received: by 2002:a2e:9c46:0:b0:2ea:bca0:8e23 with SMTP id 38308e7fff4ca-2eac7a986edmr31587991fa.43.1717683918722;
        Thu, 06 Jun 2024 07:25:18 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead41b0590sm2149511fa.89.2024.06.06.07.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:25:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] hwmon: lm70: simplify with spi_get_device_match_data()
Date: Thu,  6 Jun 2024 16:25:15 +0200
Message-ID: <20240606142515.132504-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use spi_get_device_match_data() helper to simplify a bit the driver.
Also kernel_ulong_t type is preferred for kernel code over uintptr_t
(needed for the cast).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/lm70.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 481e4e1f8f4f..0d5a250cb672 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -169,11 +169,7 @@ static int lm70_probe(struct spi_device *spi)
 	struct lm70 *p_lm70;
 	int chip;
 
-	if (dev_fwnode(&spi->dev))
-		chip = (int)(uintptr_t)device_get_match_data(&spi->dev);
-	else
-		chip = spi_get_device_id(spi)->driver_data;
-
+	chip = (kernel_ulong_t)spi_get_device_match_data(spi);
 
 	/* signaling is SPI_MODE_0 */
 	if ((spi->mode & SPI_MODE_X_MASK) != SPI_MODE_0)
-- 
2.43.0


