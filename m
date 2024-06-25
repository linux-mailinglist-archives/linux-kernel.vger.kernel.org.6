Return-Path: <linux-kernel+bounces-228829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8403C916798
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65D61C21323
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C3A16A37C;
	Tue, 25 Jun 2024 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShNtah6U"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79905169AE6;
	Tue, 25 Jun 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318058; cv=none; b=p2zx94K91UjGmcOOwbRU3co3NQd3L+oiK/DlyleV7YUM25F0zIcmAK61MG3uV/dx6bNIh4INaq9fevs7l3aQF+h+CSRNjIFCKYBYIZFS5+OGoszxm7ziiZdaC57s/tZXplb8z02Sg9qeSLcwd2nFhogKcybfgOqBT3gYpBXCbL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318058; c=relaxed/simple;
	bh=Loo7splg/KNNpjHn+lJnYsdwbg5CLqgzTf6nd3xkuqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Blovkmv7a1rRNG+h+Z/iLZtfLckAejSQ1t1NSBrY9vyBxX7wHywtZO5SJfXBuMK+71+hiLdHCvcNj6FDm+F8Doib0QH98rxNh63+aykKQvLBep7deqWEJnDoYejW7bppm9qMkRL1Hj/e5NIMEd1cM4dHjsC2mHoodI0ShOCvwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShNtah6U; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-706642b4403so2177701b3a.1;
        Tue, 25 Jun 2024 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318057; x=1719922857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdBPhx+OovP/ovtJQtq4zDvnsEmSZc35AhCTNpmRrOg=;
        b=ShNtah6Ui7HBte+qT9xQyz4w2/ESFaymcwNZgvqK2tQgDRz82t7cQNM3S0eAOBrrrV
         7X44aCBbg2tAjFyEMg3Oj2UJ1vjvjEIK4oB8nZUNfByXIteb45UM2FzUDigx3X3qiedk
         enT8v/yfUEJjoyv1Hdgj4yUMtFuh8ljRGaIwavN2zdVFxeKlXEntuX2HGMExBs8dhqHR
         UOGS+1GmKFnqdKpArScpAD/1iPP56DaEl8e9/zQf+ZJwwQP5PQm1Z54Y8aN8dExV91Mg
         lOlHKyJGymF6bJ4h+G4OZvuhxqSFt7Lc5JL7n4qwrLCKUi3gEr7csCaiWVOZbOnD8N5y
         I7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318057; x=1719922857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdBPhx+OovP/ovtJQtq4zDvnsEmSZc35AhCTNpmRrOg=;
        b=DS+56vucgD3qT44SrzWuN80nOmP4yH7Ym88pI5zC9g3hYAmBhn4fsHt0QAHY6hURLo
         T5FaB7NrwlgVYSSY6bmlzpVjrn7/hcsfOq81mAzBDKDW/jkSreyGZOHhv3ffZEhAairg
         fOm6pGHvOBj85u4Nia2PSkDTNN1ta94YFQ52sDWm8/eMn3g4eaMb4PYPfnsLmZ6isIpv
         A3Gynrkd+k3hnshLl3ysFlluLXjyMrHgAXmLAwtihqFOLgd0csU7+U8qHRqQYw+HozFd
         CSvpt07rPknj0/2MUNdJD3QFYyLBStrb5vkyJ+43+H4ThLhSSL0JzwGI3jiEyLXRZbg6
         TDiw==
X-Forwarded-Encrypted: i=1; AJvYcCWk+PIRZC7s2WJQ45NdOHwTOnP9Nl5UDl5Cai4QM8VIpl0orCRXAwLK3fdv5HwqqManyBHL4zO85wjRnqmAjLEjUJiQTsrtNyjb6Lxr4B2U78E5mnycQCt5og/42YKrnqDjQIef97+tCQ==
X-Gm-Message-State: AOJu0YwIQkBZGxHOF6NCAAGxQ5YHb2FBg6e2WqhseZI1UV6axlSffIHa
	UqViI2f2MXgVSIJatWOQhpS+co61XYfS1SvicWTAlVShnjKBoES9IOeKUEQh
X-Google-Smtp-Source: AGHT+IET4IPVYeOD3BB8CFBKQsqIv79DMcHv+zGwNeMOfbYW+uYOV+eps3+r6O3SeM+QR5TKqc6iuQ==
X-Received: by 2002:a05:6a20:5a91:b0:1bc:baef:63c3 with SMTP id adf61e73a8af0-1bcec92bf92mr8939905637.9.1719318056759;
        Tue, 25 Jun 2024 05:20:56 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:20:56 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH 08/17] ARM: dts: aspeed: minerva: Define the LEDs node name
Date: Tue, 25 Jun 2024 20:18:26 +0800
Message-Id: <20240625121835.751013-9-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Define the LEDs node name.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index a80c46c1962d..bea389d1e90b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -46,11 +46,35 @@ iio-hwmon {
 	leds {
 		compatible = "gpio-leds";
 
-		led-fan-fault {
-			label = "led-fan-fault";
+		led-0 {
+			label = "bmc_heartbeat_amber";
+			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			label = "fp_id_amber";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-2 {
+			label = "power_blue";
+			default-state = "off";
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
+		};
+
+		led-3 {
+			label = "fan_status_led";
 			gpios = <&leds_gpio 9 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
+
+		led-4 {
+			label = "fan_fault_led_n";
+			gpios = <&leds_gpio 10 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
 	};
 
 	spi_gpio: spi-gpio {
-- 
2.34.1


