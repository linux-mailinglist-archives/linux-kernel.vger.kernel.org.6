Return-Path: <linux-kernel+bounces-565706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE3A66DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF4216D46A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E36A1FE460;
	Tue, 18 Mar 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di12JRSN"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16C2063E3;
	Tue, 18 Mar 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285620; cv=none; b=Mad/3hL9Y+H0/wVPpLptQ6ApHKShsaGOv38RMpxKQXAGyNwIN8Y6+mh59HH9GBQqn/awcVvEOrm1AqmYehTDfnPrahqIdh7JTuV3VkhegLDGv6i4XEpNb7KYWY5eZYCOG8OEXykXcIYCCuF8ZzEqNDAJeAzhWU20LN/4nUOnV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285620; c=relaxed/simple;
	bh=6WL3+gww7pwy7HeSxhHT435XK+Ky7XngeaLYGMY0ueU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3H4Sj3hjjy1z1s2MSfbIBd4nnC4VVoKmyXzLmzs6oYEmaZVx4vk9NZJ79DEGw1SPKFZSfTJG1qBCBmrG6jb7/RsXCNnMIn3ibzE/AW1kp5Gt6FEXa/hUG9thyWvn+VRcGhkNMv9aOXgxU8VwwR8FwgJt+cHN9VDYbwSkUlPNbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di12JRSN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so9200068a12.1;
        Tue, 18 Mar 2025 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742285617; x=1742890417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mUS3JAucq16wAF6W5pFtM5mAxXgdUK4IDJ6WzSb7Xo=;
        b=Di12JRSN0AT4SIrNX0AKeB9yzSSB2/Guo6FykYLIAsKwrYC1qGOaTZ8TYWF4N6bisS
         B10/ijhkGO6eQVT4yzv056Cr+rnNcDUS0F37zoDdwltPddC54GeqWziAMi6rR4vKkr98
         DdzOs9rt7Awer9UsoDZ3fCXeMlcrzfCFkoGZY3ErYDr+DfIF7DO5mxpUjgzYoFY1g56i
         TtJH4fH4m9Irmlcr4xVDJNPggVBZlrgpow4frWFdxTMQ7VGszM3UrJEdfUCTbtxLufUh
         LMdaM0DLxpqSYwBJLLiJqa/aG3DqFB756pBOn7HxQR+dbFyFEuiYRxQcONngFCJXsoQd
         HW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285617; x=1742890417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mUS3JAucq16wAF6W5pFtM5mAxXgdUK4IDJ6WzSb7Xo=;
        b=RUqE0JFiitufSDui78YcWW+jFpjiPPR432ydygOi4s5aAf5yDcSYOQl6PGUi1JLUYG
         l5jOlBRqelYdDwib/f6pM1+jp6GZYrHDuXWxlWGkIOkHtOQlZ+l7+A2rvB6u0N8whqUJ
         EZcix1OM8ydacs9oOaPlVe0c3CyBC1mKa00AbwmK0V70qrd3vboTelJngmJzVZssBTgx
         yfEvGdklTjfaZerFS7XS1HGrdmlo3iHYHzebx890gQsbJACLYG6kAPNP26DV/sVBBmJa
         cD18vWpBz7lBlcVU+A231s8v8mnuZhMJ+4pGBINwYuBcsqHAEXKZpMS5muEJ0RdOQiju
         Qs2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNngeteyUtg4wK8Huc6ujgMjX5v3uB/0qVUmll28oiJMfqKFWwAHXiuLnhqsHA2DJJl4AWSEmXM7ma@vger.kernel.org, AJvYcCXEXC2qNh1PwgVk6gGhbJtQb5q8nWT/IVxTdx0OOSKzv0S43ezlIsCGw352HDE9WvGSuZc1OqDUI7ci07ZD@vger.kernel.org, AJvYcCXSx09joYWvscOFRoMedRHE8yglIR4e0i2gaF3WCXYGz5gD9btewh6dNMkKS/l7RpMRfKz7CmFTsree@vger.kernel.org
X-Gm-Message-State: AOJu0YwPCREYcsjJhBitQr9sTJJnvramiaGaJVoL9mLNm1MYxHL/FZeL
	pyYiMhZlOTCFAeSBIy4RYdOn+8MqCcnSnXOrQR00mD/stoYm2Fpv
X-Gm-Gg: ASbGncvvGzUdr8Cq5t3gStKEPih7by+R3Q5rUhRwXcS6THtQEhRAV8owmdojpVMKWzL
	d5Tnammi3DXYPlCZug1uTJ8+TiEZoAmqZoQR4bvZBtRJ04Rkp4Kf4hp6e5xpDJo31BwmFcl8MtT
	OGZ6zcAXB7x4IecULXqkhRXOxWYS5q45JjN33OKABtEJDFZ4npPnbVfZB5k4B8I935uIBzlnmmh
	lrhTf18XMK/1Uvj4e3xeISnsF+lRRFGu/qcvs+8PySAdrQp3IF8uY98hs1TpOep+0H8nBoe6mRq
	JzwicDKd35+Bxi4q+rHpHiWBDNiOllLPbu3gz79wCNZSXq+LWHPsw9LMfL1f0+x3OP+vDV0EHKu
	GWOAmqrNpW0WhIR2eoQ==
X-Google-Smtp-Source: AGHT+IHguCtlnxkHiNo/LyNZv4MThAa+WXO4laFW2uDrRo5fbMll8lYZlNYvGqgv1r34Zeq2kgws3A==
X-Received: by 2002:a05:6402:5210:b0:5e5:bde4:7575 with SMTP id 4fb4d7f45d1cf-5e89f24e3b1mr14905806a12.1.1742285616556;
        Tue, 18 Mar 2025 01:13:36 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad392csm7176097a12.53.2025.03.18.01.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:13:36 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 18 Mar 2025 09:13:30 +0100
Subject: [PATCH v4 8/8] ARM: dts: bcm11351: Add corresponding bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-kona-bus-clock-v4-8-f54416e8328f@gmail.com>
References: <20250318-kona-bus-clock-v4-0-f54416e8328f@gmail.com>
In-Reply-To: <20250318-kona-bus-clock-v4-0-f54416e8328f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742285605; l=2485;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=6WL3+gww7pwy7HeSxhHT435XK+Ky7XngeaLYGMY0ueU=;
 b=W/JceGIDNDhwEVuscrhu90/ZiCaH04Ss2onsKkxqu4vh7HfxA4xXCBUf4O8PqzrjSHwmLHBHv
 eR6GoOLgyrrDhKiZ3cfHW5AdyynwBMthDt8jI2Dgqig2pNjDlELbUZJ
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


