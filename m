Return-Path: <linux-kernel+bounces-204455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6D8FEF69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0B72854D4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03391A38DB;
	Thu,  6 Jun 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRrvJRWk"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0580197A81
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683904; cv=none; b=cBi/4dlR0FPtfwOR5EUrkhD/c2aYo3CyaEN6l8zohxYwO4aoMpXejmWqLHUaBzmZhX0tIAMSrtVNS7AcQ8T+0r+ts8uY4GZWf8X/+a0YPrYmqbaNV+jYmZd1CDbFOXG6JBa78cIcnh4PpIMDEObr45S4Gdc3as5txO9lxvoBFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683904; c=relaxed/simple;
	bh=xJku9zrC1AGBM4qIss9yGk4RWlUTIUI3bVn4WgsRBgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOcUGGu4pR4ozHi3975GYkr8tzs3BE9khHvuiy20AMAFzdMH1QXERMY+NTNCHBqpLI3/nUECT489ezH0VAeSibi8SExshUZHN4njUKr2mWNoDtZvJxBsgR2MiTXa29frwh3DRDG0MlchQZeEvhWK1PAuq46oqlTp3/hEz9lHUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oRrvJRWk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68ee841138so127602066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717683901; x=1718288701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVtqnXLiuL7l3W2O7J4uf50LECKlp3bPPW+XuGMKMgU=;
        b=oRrvJRWke4JT84U/lD+FVypxXgB2t9Il85RAeG6ePgzeaAlxlSbhlWdzqu9cWS1/wK
         /zPeemmw0dOa93mKNmgnCcxMawauflLL7SXhvbog0+EPZljuJ0kc6bCsKNJRpdTChbb1
         o7Gb1GDTna3v+xfSn1vlTtbo0SGCs7DKyCZ+QYHuJx460FOokxh3nYf7QOgpky6JKIWX
         lrtpy27Jo+YOuU7muwZmrOZJ9uBpftJHdligPwVl2SrKw7lgGej0MZ5xyuYAWKxigK+M
         2X/+eXewxjGOJ0bGDJjwq3YvkOAhywtkeggh1A4HmrAH981mU4RwypXPkTSL3RUSyq6U
         ZEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683901; x=1718288701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVtqnXLiuL7l3W2O7J4uf50LECKlp3bPPW+XuGMKMgU=;
        b=vyWEvuIuRRkZSa7JZJ9RseXXjvMpPA4HSz2e7czKD7c5Ak1ZqmxXSAsmDzNcTIkZlX
         OtspaylLOAnbWJKvoNRAybRGmIu2hjp6kJhpmC/KUiJR5Arvm3YITDRR384Dbab3zmfR
         RHufrdZgQBx4RpFNcB0D8mSVvuVwkunOFk7sBRcHvdFVpOl/tYBz0n1XXJWw0qhz4D0d
         RirsLQ+QSQQCAkfqo1yVim1neOk9O9VqhdD3nrMkjlYtsBInvPALryqWnwUCshxfKaLI
         C3mFbYx6Fi7ljr3Qi3u7Neie1zJkiEgm7FbP0Kx7r4WD66tlaWWsTnhh69a1WJnR6LgH
         xe8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM1h4zAiu4Xs/WgabmlPBjWRbw51mptVzYCGZ+/txaXzhFyYCwGJjyvNB3EZFfxHiivj8zCqHQhlwjn39XFMt6adxv2KB5hxNXMEJ6
X-Gm-Message-State: AOJu0YyQBH94n9XCA8ltn0ZpzPsS3SBJCTanJn2KRiTRoVNuMGwIIr7z
	Luy0h7AoydZKuEh9ALiCRZD+88qc5ke4bLYcGJs8qb4z/76YG5CCcsYahlPr/EvR3udOPofRzVd
	YgJI7Zw==
X-Google-Smtp-Source: AGHT+IEO/my6BpSvTRKxq1xS59je88+5g73ZUGox37kyzNUmrfjMY4VeX3kfUHK+a9QRzvx7ruZs5Q==
X-Received: by 2002:a17:906:840a:b0:a68:e1a8:9d2b with SMTP id a640c23a62f3a-a69a024f584mr362648366b.68.1717683901196;
        Thu, 06 Jun 2024 07:25:01 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80582110sm104953466b.32.2024.06.06.07.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:25:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] mfd: madera: Simplify with spi_get_device_match_data()
Date: Thu,  6 Jun 2024 16:24:57 +0200
Message-ID: <20240606142457.130553-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606142457.130553-1-krzysztof.kozlowski@linaro.org>
References: <20240606142457.130553-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/madera-spi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/mfd/madera-spi.c b/drivers/mfd/madera-spi.c
index ad07ebe29e59..ce9e90322c9c 100644
--- a/drivers/mfd/madera-spi.c
+++ b/drivers/mfd/madera-spi.c
@@ -18,21 +18,14 @@
 
 static int madera_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct madera *madera;
 	const struct regmap_config *regmap_16bit_config = NULL;
 	const struct regmap_config *regmap_32bit_config = NULL;
-	const void *of_data;
 	unsigned long type;
 	const char *name;
 	int ret;
 
-	of_data = of_device_get_match_data(&spi->dev);
-	if (of_data)
-		type = (unsigned long)of_data;
-	else
-		type = id->driver_data;
-
+	type = (unsigned long)spi_get_device_match_data(spi);
 	switch (type) {
 	case CS47L15:
 		if (IS_ENABLED(CONFIG_MFD_CS47L15)) {
-- 
2.43.0


