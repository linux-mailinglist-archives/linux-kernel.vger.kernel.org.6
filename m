Return-Path: <linux-kernel+bounces-565705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3585A66DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26A717367E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC62066D4;
	Tue, 18 Mar 2025 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXG6ZO/7"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01C205E16;
	Tue, 18 Mar 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285619; cv=none; b=DdQwG6e14voiNO5UqqFwkZGXrsSrrtmDa2e92+jzup9yI4l+23lS/cGWwigAZiSCCgUOKgFbePoCi2n7DEcAiSsDluy7IRS98yCbX2Zlq7KRdT+dI/aYkiizyum5V+kwnx+3fztVdHu9n+OkD6SPYr8g2BpAlB7smt9S2SkRsS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285619; c=relaxed/simple;
	bh=lkgx5tjva54MPvYJRtgqKAg6w12FDRdT4V2P6cC89yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GBf8Ujk2ILA6MLN7ZM3tNsiF9SUSVJAMjVWT1HXjiRAVIcSYAu76DakPDgAnXxBog++gapmFg/zo2ldoFmzm8VQ3e8i0xIiNltMB0/QCziGhq8syi567DotbNF+EdIRAljy8jrnOOQ0E/VWJhSD032TT61/TbKJ9UStKytrIOEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXG6ZO/7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso5311723a12.0;
        Tue, 18 Mar 2025 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742285615; x=1742890415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXGrYGERCV5neQEtozh2CEkbJpcfvYvlgtYXjRuhq9M=;
        b=SXG6ZO/7KVbrAz5eNvK7xEbZzT5CNkVGHFxIgivA4PavnJg9OtrH2lcG9kL6lto/Lf
         K21+DXNwngTM0jYbHFd0hxfCCbU8XuNivx8jIFgxnshkdpEziRkIloxFnU8tU5snqLuE
         hva8O5mKGSBYmQ8CWPtr21sIj0yLPibtSYG4hABN+TsiEmXp6YbILaOESgnLCxdgJexD
         N9z7CxCCI66hkQXLeI6D6dqQbjeER1W1Mw80i8V+FRDu73Ah9f4wLlebnoIOJLOHIeW5
         e7KJYikNmAEWM47j9SoRKgm7wds5Owi9gDZH1K2ejENO+/j/UaPtJjuPTr7O9sn/Rws5
         PJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285615; x=1742890415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXGrYGERCV5neQEtozh2CEkbJpcfvYvlgtYXjRuhq9M=;
        b=bX28Cs56GKBzF51+TlMW/hIUeLd4qv++1MXwP4rkbXa/gd83EjeInTsb85q1T6svcO
         BEpHQ609kMbP8LY1Nmc3bUCtx/K6bGxUBs+WJ0b2A33bpJxVzO1iNomEhjpT6rt+60wy
         7yNUxb0P0KLC2b6M8sLiULjoTvtqful51CVRifcJuvnCClgqPu3I3rK6laGhwN/bElYL
         x8X6oXBYsjAtcZ9IQKuZh0ocr3uBYYV52vWWpU2evNflghZg17D+KT7o7/+k0YzR0KRl
         RjHk2DgazMD1IweZEoJpwAGYvKAVP33hswm9vvXr54Yy9QgOAeF53ryerzFajWDtnVmt
         YItQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4s7QEsYS2dYLf5YebFbHaVsqP0+D6rKIC7/tKq1CT9+4Ga8w1kYEI6LT+Pn2h+ablWS3S8L0xnf/F@vger.kernel.org, AJvYcCWoqi+/8tcAWk7gbCJ743f6PH2ruBgOQRNodgDwvvvO3K07JuNEal0jUe7Iw4SBdePWKeu6EvIe//uUydV1@vger.kernel.org, AJvYcCXcPLdKp/g7ox9o2bnvVrLgM2r46KyJw5WyeGYNEgHuo2gQ2BZ/N1Ch37A+lNBulo4GF8z8g5uCP3M3@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLk7ajfv/urGm1kPuJWiC/cZcdCnzifTHsQ38RJpWnTvPx9JE
	jrHcMEB351xzJHePLVJhs40Ry+mONVkgojQ7edoWKqgz2cRuYgq0dwc62w==
X-Gm-Gg: ASbGncthhzM+zRUru8Mwo/O62xaircGqYU9T7bZ6BmhvioxJAqHnKLQ4TXoT0BErzwF
	8ujJ9/H8jWEfMhThkhQLYMSFAVf2C3VeR/WiJqW1bG85gWOy2m4am47WouugUHhUPHpdFt+t5d6
	cbhDf6rNlED66ez7cAGaDEOAoVcc4kbUhEkZUHZMwFmofhlkavlvxdJe7W5xSaWAgaK8p6JPj9s
	SUSwBjIMsATGXySd7t1AgvACR4dv2T+BS+ysceYeO7hv0xwYUG4OO0PbOK1owBhf/3eP9NBawXb
	9Z9ArY4IS8vH/DV80WeQlplhJOWf2ViPVe2mYiVFzJG3HWkocURsPxwFnJ99OWqeUKSahUB79Qw
	RrLaxIIM/QVuXDMt7dg==
X-Google-Smtp-Source: AGHT+IHAe6a3kp1j4boZWEZUDFV+64ShjglSD87Dhg4Qgt/Buj1UV8gOW1r5BOVftBpbhb7Oty4gIQ==
X-Received: by 2002:a05:6402:354d:b0:5e5:bdfe:6c16 with SMTP id 4fb4d7f45d1cf-5eb1deab100mr2336978a12.3.1742285615338;
        Tue, 18 Mar 2025 01:13:35 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad392csm7176097a12.53.2025.03.18.01.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:13:35 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Tue, 18 Mar 2025 09:13:29 +0100
Subject: [PATCH v4 7/8] ARM: dts: bcm2166x-common: Add matching bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-kona-bus-clock-v4-7-f54416e8328f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742285605; l=2451;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=lkgx5tjva54MPvYJRtgqKAg6w12FDRdT4V2P6cC89yA=;
 b=LmqMgtcw1BeQoVUvjYRoeONFGR69TtPuc8CFq+f1QqJLPvIZYjD47VB6/NReo+M2Miw6hx3y8
 KPNTTDdbXFJDJOJTnPNoFmBebEXs1LHQEzBf5CXkG+DDaDRKHDiosq3
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Following changes in the clock driver, add bus clocks for timer, SDIO,
BSC and UART to the DTS clock output names. Replace the usb_otg_ahb
fixed clock with the real bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Change commit summary to match equivalent BCM281xx commit
---
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi | 28 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
index 87180b7fd695e65b52c52743e6315cbcca385fba..ab6ad8c6d326171a6da1762ecd839bd82e9da482 100644
--- a/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
@@ -143,7 +143,7 @@ usbotg: usb@e20000 {
 			compatible = "snps,dwc2";
 			reg = <0x00e20000 0x10000>;
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&usb_otg_ahb_clk>;
+			clocks = <&master_ccu BCM21664_MASTER_CCU_USB_OTG_AHB>;
 			clock-names = "otg";
 			phys = <&usbphy>;
 			phy-names = "usb2-phy";
@@ -248,12 +248,6 @@ var_52m_clk: var_52m {
 			clock-frequency = <52000000>;
 		};
 
-		usb_otg_ahb_clk: usb_otg_ahb {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-		};
-
 		ref_96m_clk: ref_96m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -301,7 +295,8 @@ aon_ccu: aon_ccu@35002000 {
 			compatible = "brcm,bcm21664-aon-ccu";
 			reg = <0x35002000 0x0f00>;
 			#clock-cells = <1>;
-			clock-output-names = "hub_timer";
+			clock-output-names = "hub_timer",
+					     "hub_timer_apb";
 		};
 
 		slave_ccu: slave_ccu@3e011000 {
@@ -314,7 +309,15 @@ slave_ccu: slave_ccu@3e011000 {
 					     "bsc1",
 					     "bsc2",
 					     "bsc3",
-					     "bsc4";
+					     "bsc4",
+					     "uartb_apb",
+					     "uartb2_apb",
+					     "uartb3_apb",
+					     "bsc1_apb",
+					     "bsc2_apb",
+					     "bsc3_apb",
+					     "bsc4_apb";
+
 		};
 
 		master_ccu: master_ccu@3f001000 {
@@ -328,7 +331,12 @@ master_ccu: master_ccu@3f001000 {
 					     "sdio1_sleep",
 					     "sdio2_sleep",
 					     "sdio3_sleep",
-					     "sdio4_sleep";
+					     "sdio4_sleep",
+					     "sdio1_ahb",
+					     "sdio2_ahb",
+					     "sdio3_ahb",
+					     "sdio4_ahb",
+					     "usb_otg_ahb";
 		};
 	};
 };

-- 
2.48.1


