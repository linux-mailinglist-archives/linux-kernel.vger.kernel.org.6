Return-Path: <linux-kernel+bounces-230776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F99181CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 780EFB2176C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E3A187544;
	Wed, 26 Jun 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdJVL7qY"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691018734F;
	Wed, 26 Jun 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407157; cv=none; b=Bz1wo9AYUzPhUX2Km6VREJh3zShWLHupqZh4iJCAicBhRHSqFSyvz8Ez7OltVNkfk9zr0EywnXSih+NvFJNgLuG/E1B6ElkwjqkLvIdp0Nf2faWNBpjZ67sKVGm3rJrFEYtyzc73cRzi+PcQzni6/xoLpnOQ83qaxF28C5ensqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407157; c=relaxed/simple;
	bh=NCe4Tnc9Gl3Yaa78tFal/B94TAIv3wlb+cJhYfxWyLs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eAqUL5N/z7vqYLvJcyWYdSELPfVQlSIFduuaF4zmFo17ckiuDNgNx/yHHNHExsdHnOIyCd/XCCJUR6KwK7GtAUBLOalUTV0cetjgZtE/Mkv/l0CYnp8TMmmzzad0q6aHU6PhIlHBP6vIb5NBV9KjAuTymg0rtv1+1JbMmlvQaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdJVL7qY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9d9b57b90so44891045ad.0;
        Wed, 26 Jun 2024 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407155; x=1720011955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bV2dcDDnQmUqF9lNzCGX3CGaBRrLRWxvY3uAb50Y988=;
        b=AdJVL7qYWdqz7wFByJ617ISq25eCgI4MQXHqLGdL1h+eni6GVZTwZz1iS6uNm3HhzS
         krztbZxSsU3ekQxfwBISIb4o89CY+ykiUzWLaEmBTgU1U3SHhU4LABdHCd9ikjLF6uhq
         VtsdQrLUGbyz33v8g97YJ8qJgpQ8jF0ClT9vdU41Aabjl4ciAh0VXKRzJ5X2EhOrlT+A
         pUCtvn5usQPasbRKrPlPx+yuXtJoZc4FHFEHXZNomlgFS4CMlXVBWrxmuXSmuA7G2OjN
         A+RiSbrxaTYJGWQ5wVQ+RsLNjGXNzqL+nA58kyDCtKzGigbM/ddIX3EMsALxTpCnWxZC
         HexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407155; x=1720011955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bV2dcDDnQmUqF9lNzCGX3CGaBRrLRWxvY3uAb50Y988=;
        b=HXsfG0RezNrDds+oLdRZeCguilCYsZ6brUAWxst5hkmg4Ap7PKfEr/arrgpXm5E6uY
         NB6CZV/LKr1hhZ2/ARLrdCPE0KYOv4IwUbQTvFZnZBbMe/THHc3CqHkqrJU8DH9f0G+z
         vmLMwuNa4Ywrqc1JG7O5M2tvyDCqgLrzv3lF1qH6ut8rUHS6GKyxWtzBw918LdJXhOwd
         Mi2w6Bim09rZIjJNFvl6QbkglZXBVXivT0O2HsTyGrSOrr7OInWPXtKrdyncRlplR72b
         eirkWmMYkjWLz2nSRbO5C3/JZozZYSe9d3y9ggKaMioe5JjXKbbG/2XKJM1AyT1x33g/
         xOjw==
X-Forwarded-Encrypted: i=1; AJvYcCWPub0x4iQRmKn3iFg9FVbgr3v29ayRSqh9/shQrWaL0R/3zE3ReOJCo3bVtOrM8hORO85wJyO+9sDVX9w1koTy8vTvzKFQ1AkfS3rRLjQEoESrqGitqwNl+nCJgC/3/AdkIrZeHbWw1g==
X-Gm-Message-State: AOJu0YzUAyqXMBznRj8ANYwotYkeLUTd3Il7u56/eKDeTu3GLD5X9Jh5
	WT4fF7MaJtcE9NwfS6mTkiLDQo6NpiMnblswrg2FLaMo/7nF84ok
X-Google-Smtp-Source: AGHT+IFKyKanqJegFloDMjHf3mrlG0KpLvhC+Rc/rVahResBIQAyJt4ZieC+JHHGb5NG5e5vfa/y9w==
X-Received: by 2002:a17:902:ce90:b0:1f7:1706:2596 with SMTP id d9443c01a7336-1fa23f4a1d7mr138232585ad.67.1719407154441;
        Wed, 26 Jun 2024 06:05:54 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb7cf885sm99112395ad.224.2024.06.26.06.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:54 -0700 (PDT)
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
Subject: [PATCH v1 07/17] ARM: dts: aspeed: minerva: Define the LEDs node name
Date: Wed, 26 Jun 2024 21:03:22 +0800
Message-Id: <20240626130332.929534-8-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
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
index bc323bfbe514..dfea0025e6ce 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -44,11 +44,35 @@ iio-hwmon {
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
 };
 
-- 
2.34.1


