Return-Path: <linux-kernel+bounces-234342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2715D91C574
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17791F24EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A5E1CE0B6;
	Fri, 28 Jun 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVQXm983"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EE1CD5CF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598148; cv=none; b=bqFKZWEPXh0LtG6cZdY4zx+bds9R7YGih1ymqC/oHeUoUhPuUnrOSiblA5yMayVKCppZdZHD3bohJxJi/f4evrvRke2PbRAqh59TTH1+JKNHMvh4rHDxrW3Q70NKRLJY5zInpUU+EyXlO5XajTMCz0Il5K0KP8PuY6iONUXH8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598148; c=relaxed/simple;
	bh=YTPcsjJK2fRTzATLl7n4i9oWkpdpTCcSR1oKY0zflQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPirdbHz/1AeCC5WRJfDlfpxGcfz99oK9gy0l1+KliyEAMAmYtQWgR0F8wwm0tJUin8GH44nLwSSqRTpSAEgRS/Vz4DEoGjfliVcpHnRKPlzXiXkxTdzU1z9+/gvJCJVltXCl5z+wNbQL3zO6abQ4nRVx+21reEoiHfe1icpNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVQXm983; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7066c9741fbso772939b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719598146; x=1720202946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmoY9MC+b9hOZcGZXOQJ0Uh4Gl8qIWXCfwHUYEIgVNk=;
        b=bVQXm983T2pD7OYAgzbGfMQq/P7z4ThQCtOCSt9iuqsuPwWK8Krel/NJ8/K4slEs00
         mOhIGhf28psh9YBLWcFi+3wNbfYPbgaBbgTFa5ke6kc2lQWm75wSOezu3LxXpuTm5zSw
         mf72L9EfxgY8FQpaFGSpdPpsSEh+dQG5+LzeKtfLV5iwqWxpb2tRkickpB1v2h9QfV+M
         WyZx1zPq3XI1LsTA/IZHyBVlGGKOv2VgLjHL7SBnblTeE8NpIWXtDVCisS547QVRtzWi
         JgxVo9aT4TXCxkwvgYSbWo7xX1ZdPzMPDpwkr4TFn7DiyozzUffc4a6F/pXcia+ZZQpM
         tmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598146; x=1720202946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmoY9MC+b9hOZcGZXOQJ0Uh4Gl8qIWXCfwHUYEIgVNk=;
        b=Z4JcAGNUJlOmf67VSwnDm+I7DhBB1ixOYrU9vY1OC05zw7PAhcGSQZahj0FK1XpjTF
         4zJdyT/Gp1K4ljS+Cuc3Sf3ZIYUVI1l9xXRmnS9/qePvSrAdf+FkEyB/FpGMcPbPGsp5
         vA9MckDpo3sCJgZv5r0ZuTmn5VOtUgBuUsNHsTtkqFK/kJv0wVbZRmRcruO8hKsl1QVZ
         fHuY1kDg5IK6enn0iNE3QUHIuyPIdk8h5exhIMv4+SHinNikpYe2o7YCcZwhcIKUKV9m
         6o6aQskshOI8JIcVVJ6Kkra7Huvi4/fpqMcw3VtE2N/ZX980Gn0ZjXyCftMMIRa5r9P/
         Qyrg==
X-Forwarded-Encrypted: i=1; AJvYcCWVgS6kj0Gfeyo1ixY68zdBqPAd75yXmAxVua61vtzWL3zjyHQuvaX34hCCGxo2u/ZNAMGrolNUqRU8Ez1iW2JMq6td0N5Q0pS1oket
X-Gm-Message-State: AOJu0YzHo/XDIe47XZ7ZdVbTUcvfhKvMeW1nAUwqTcXuRYk/zrPgNhCF
	xTz619A4jGS/bP6KCZsaB41s/9x5hB/hwXKqYUBXWdrcHfruUWym
X-Google-Smtp-Source: AGHT+IFym5PAI16Os9Hfp7AYeddl0ojmEh3aJykbFJxWnw9ufaFP8zsIAOZN9UfNjvXStDqZSy006Q==
X-Received: by 2002:a05:6a00:b91:b0:705:b81b:6ee2 with SMTP id d2e1a72fcca58-706745e809bmr23126817b3a.19.1719598146472;
        Fri, 28 Jun 2024 11:09:06 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:c929:2998:720d:a104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295d1f4sm1982911b3a.91.2024.06.28.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:09:06 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] ARM: spitz: Simplify instantiating SPI controller
Date: Fri, 28 Jun 2024 11:08:44 -0700
Message-ID: <20240628180852.1738922-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_device_register_full() to instantiate SPI controller in one go
instead of allocating it, creating a software node, and registering the
platform device as separate steps.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 10ab16dcd827..b14eb2a54f80 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -580,14 +580,16 @@ static const struct property_entry spitz_spi_properties[] = {
 	{ }
 };
 
-static const struct software_node spitz_spi_node = {
+static const struct platform_device_info spitz_spi_device_info = {
+	.name = "pxa2xx-spi",
+	/* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1 */
+	.id = 2,
 	.properties = spitz_spi_properties,
 };
 
 static void __init spitz_spi_init(void)
 {
 	struct platform_device *pd;
-	int id = 2;
 	int err;
 
 	if (machine_is_akita())
@@ -598,19 +600,11 @@ static void __init spitz_spi_init(void)
 	gpiod_add_lookup_table(&spitz_ads7846_gpio_table);
 	gpiod_add_lookup_table(&spitz_spi_gpio_table);
 
-	/* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1 */
-	pd = platform_device_alloc("pxa2xx-spi", id);
-	if (pd == NULL) {
-		pr_err("pxa2xx-spi: failed to allocate device id %d\n", id);
-	} else {
-		err = device_add_software_node(&pd->dev, &spitz_spi_node);
-		if (err) {
-			platform_device_put(pd);
-			pr_err("pxa2xx-spi: failed to add software node\n");
-		} else {
-			platform_device_add(pd);
-		}
-	}
+	pd = platform_device_register_full(&spitz_spi_device_info);
+	err = PTR_ERR_OR_ZERO(pd);
+	if (err)
+		pr_err("pxa2xx-spi: failed to instantiate SPI controller: %d\n",
+		       err);
 
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
 }
-- 
2.45.2.803.g4e1b14247a-goog


