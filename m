Return-Path: <linux-kernel+bounces-542710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B445A4CCBD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352C83AC483
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8623C388;
	Mon,  3 Mar 2025 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlTt5QHD"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE3235C1D;
	Mon,  3 Mar 2025 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033691; cv=none; b=BApV44aTVW3MXyxX5DZCArPQ3GJC4BkPT90MqsmxAxoqo6irq6jPyojr0DX1nqEFwhGrBFEkWEILpwuZWCZv1R91+NjaRnQ2UCWAiniyOhkTf7fPEMXbUxSF2f7qv5pAE9aAzhU/jX+5WLi15lW1Mzx8onIgVjr6XjjpihaNYbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033691; c=relaxed/simple;
	bh=6WL3+gww7pwy7HeSxhHT435XK+Ky7XngeaLYGMY0ueU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixYuEVVjLskyfgZXTkURJwKzAi2Dsh6qG+FUnT1t7y4CKStxBNMrOIEADV/bEUo7fnkqMlIKkYX1rB+aJSYAcOdRpfvGPY0K6Lwe5f0kvIiF4y12y5ryZTrQACd9w+/RxMWoO4MS3C7t7Khi8fEz95+EVKanCMKE8lXQipaKZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlTt5QHD; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeec07b705so782405966b.2;
        Mon, 03 Mar 2025 12:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033688; x=1741638488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mUS3JAucq16wAF6W5pFtM5mAxXgdUK4IDJ6WzSb7Xo=;
        b=XlTt5QHD/036Y/EvQMbXJavmG1faoZbGk7GajTVGV/Uum7FsveeBmFBE8V4JkRR8tW
         6QFiR1YzRh0y6Kgfuj7fB2AoSASPYgMNsXIATVOPRNjIYLBQRy/jBZdgjCUDQze8WP+w
         NaWdL9zhLjR0SnaBdAYHXB4YuHL6uVVdwzSLKqeWRnsf43iTfuuEu1TxBWXJNpmeUhZZ
         nY+XlksL9jSZNm5TE2kC90hLielDvhL8q8Y4jlyRfmrfKONB8q2N7sy3QaxKr+9oit8q
         4kA7RNh9CnXvq6XuPO+rDF6tJi27ubyXVWwqpQQ57m3w1845WspzvzebeyMVrZOIv7jW
         et+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033688; x=1741638488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mUS3JAucq16wAF6W5pFtM5mAxXgdUK4IDJ6WzSb7Xo=;
        b=iEteXGWNBjSItbITE5168yP7ctEstuPtn33hWx9uPSSHCG7y+nfnrLC/u666izXEwH
         zEC+XUH2R9YJ1ejrVkno3iypLApOkI1ReOI5A0nOs8qCAczsQAbl4jOjDVJ45PJy7Sop
         55tCJHWBAeDVhi9EsnWiT9ls/W1BTy0XXK+ekx38bIXjpz0c9YOXJwconpa9VqKilCj2
         rh7pkWKs3zq9+o7WTMUhiKUlV6ZDXMxpFGudn6iqEQVRmgfIrXf6PU41e7fZJLbyh7VN
         TlgEe6wAcntg5x/tH1ewbGWyJmqc4YGc+DNU6mX9TkF0JinPLa0xtm0l86/4VsEUEJin
         kMFw==
X-Forwarded-Encrypted: i=1; AJvYcCUJqA68rT5sUs1kqvDpdOfyc1TGr2lNTf+1DMFvdyoQDAJ7J+oNrVLHIDiF6K6qm3umyW9qtO6TZel/W3ng@vger.kernel.org, AJvYcCVXlVvKjNfigSZevbIpq8D4k1IxHjkeNXogSJDOkkB6A2/hquFsg6hZ9GXKiXOpFdhcduUVIMdN8x1k@vger.kernel.org, AJvYcCX8x2HV5XvRjAV6d44EyY128DPEBmi0aTdjXU2fabyWoK+EhGw0bNgxcEFRH9KANzi0Rfv+LDEoNtNt@vger.kernel.org
X-Gm-Message-State: AOJu0YwB9hGHvst6L5X4Ic4zGBOqFkYxDRwWjjWa+CkO/ACIZBKO0D38
	wXAbmvVWOvG+ppNOpmO9R/E9R0dqjWS3XVzx9ByzqpP2bDdvn3ug
X-Gm-Gg: ASbGncuUAp9QwvEGh27my86qkGKjuNgU1+/kIy9AMBp9hk9ulLUwlNi9D2ZZ3r1kCmt
	5veXnt5OjT3ase6JTBdPcy/eYHRKDVTYnz2OyFXsLhcdfS7h9U4h93pxyoZYybnLW32SJgCi60Z
	fs7zA66T495Cjcdra92hjzxPBZF00HAOaH7go48j52Ktg+me2Umt26AWW1yQB2bVqrRY3adI2td
	pW6jDof8sb0mLk9j/JkPZtQR5QKjZr8yHdTAQ1yJG+joEZ/YwMJ0Y1yM6viTVbzjzuXhcPl04R7
	aypRG8RsNwoZjTcjT1PuwSpdGnbnHi8vdwlJIF5BTMCO5C0jvzwTh1v1OGxTRI8+KmV6xJRebng
	KEP0wmRU4H1hXr58=
X-Google-Smtp-Source: AGHT+IFVp/KeMVcrH5wtWWq6qXRVuys4s6zh1IG4Std3sZ5UncuOsGDVsCK+FtLJALUPefTCPbjmwQ==
X-Received: by 2002:a17:907:1c28:b0:abb:e7b0:5453 with SMTP id a640c23a62f3a-abf261fae86mr1798482666b.12.1741033687882;
        Mon, 03 Mar 2025 12:28:07 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf64dd565dsm389222166b.101.2025.03.03.12.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:28:04 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 03 Mar 2025 21:27:55 +0100
Subject: [PATCH v2 7/7] ARM: dts: bcm11351: Add corresponding bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kona-bus-clock-v2-7-a363c6a6b798@gmail.com>
References: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
In-Reply-To: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741033671; l=2485;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=6WL3+gww7pwy7HeSxhHT435XK+Ky7XngeaLYGMY0ueU=;
 b=VXAGORhDaWxXb847EqZoFtRva0y9l4g4B7YmCVKZNUAkDve22tgY2lHrpkBK5L7Pg24OQ1Kg+
 h0wO1xGP5yRAA4Dqe56IFBivb3VdGWg2VwVnY2T3/BidFY/KivG/eAP
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Following changes in the clock driver, add matching bus clocks for
existing peripheral clocks. Replace the usb_otg_ahb fixed clock with
the real bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v2:
- Add this patch (BCM281xx bus clocks)
---
 arch/arm/boot/dts/broadcom/bcm11351.dtsi | 33 ++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm11351.dtsi b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
index 53857e572080d752732c512ed27f942756d59c46..fac5cf5a46bd9a4b7e09a2e65c3e807d1b4ef960 100644
--- a/arch/arm/boot/dts/broadcom/bcm11351.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm11351.dtsi
@@ -233,7 +233,9 @@ aon_ccu: aon_ccu@35002000 {
 			#clock-cells = <1>;
 			clock-output-names = "hub_timer",
 					     "pmu_bsc",
-					     "pmu_bsc_var";
+					     "pmu_bsc_var",
+					     "hub_timer_apb",
+					     "pmu_bsc_apb";
 		};
 
 		master_ccu: master_ccu@3f001000 {
@@ -246,7 +248,14 @@ master_ccu: master_ccu@3f001000 {
 					     "sdio4",
 					     "usb_ic",
 					     "hsic2_48m",
-					     "hsic2_12m";
+					     "hsic2_12m",
+					     "sdio1_ahb",
+					     "sdio2_ahb",
+					     "sdio3_ahb",
+					     "sdio4_ahb",
+					     "usb_ic_ahb",
+					     "hsic2_ahb",
+					     "usb_otg_ahb";
 		};
 
 		slave_ccu: slave_ccu@3e011000 {
@@ -262,7 +271,17 @@ slave_ccu: slave_ccu@3e011000 {
 					     "bsc1",
 					     "bsc2",
 					     "bsc3",
-					     "pwm";
+					     "pwm",
+					     "uartb_apb",
+					     "uartb2_apb",
+					     "uartb3_apb",
+					     "uartb4_apb",
+					     "ssp0_apb",
+					     "ssp2_apb",
+					     "bsc1_apb",
+					     "bsc2_apb",
+					     "bsc3_apb",
+					     "pwm_apb";
 		};
 
 		ref_1m_clk: ref_1m {
@@ -325,12 +344,6 @@ var_52m_clk: var_52m {
 			clock-frequency = <52000000>;
 		};
 
-		usb_otg_ahb_clk: usb_otg_ahb {
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-			#clock-cells = <0>;
-		};
-
 		ref_96m_clk: ref_96m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -396,7 +409,7 @@ usbotg: usb@3f120000 {
 		compatible = "snps,dwc2";
 		reg = <0x3f120000 0x10000>;
 		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&usb_otg_ahb_clk>;
+		clocks = <&master_ccu BCM281XX_MASTER_CCU_USB_OTG_AHB>;
 		clock-names = "otg";
 		phys = <&usbphy>;
 		phy-names = "usb2-phy";

-- 
2.48.1


