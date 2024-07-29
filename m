Return-Path: <linux-kernel+bounces-265748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AD193F583
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710E1282DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED1014A4F5;
	Mon, 29 Jul 2024 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca2yArAx"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77731148856;
	Mon, 29 Jul 2024 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256473; cv=none; b=ROc45xtnFkVtStwuyv6bkA0ySvJ9f0IQtgPsgYtVSO7E/lTGzIvyJ0OUZcK4c3S5csfQNxEgPN6OzLqECTCyK74XRHtikTD36rKk6nvNI8hmnvd+CTDoxlTshzhsRr/WF1Mox+JtwcOo9rkkknTF9UCwOJXqWkCMrqh1irqX/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256473; c=relaxed/simple;
	bh=qqKHG/Uy5cH7+DH5QFqsdylDvTqWfKKgXY/fImeU5Vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQA0VItVt2sv0h3imsFAJ/qo7o+aaUqo2ev2sA/oyhWMBva7Q1abit3WW7jM/o54JoNQiX+2IVv2uAJCb86WtnoLZwURk6/7jnC9K8z6VsKpkM1J6H/dwZe151QMKnYdmfLLqJVP2yqXnfUBCcaSNYZK0u+aZFXS8pYMZyjRchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca2yArAx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so483893166b.2;
        Mon, 29 Jul 2024 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722256469; x=1722861269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URdCsVRYzMoEYdKLFQaW58axjPYYNSSxXjeC0AG6T+M=;
        b=Ca2yArAx2C76HnnxrQCadLhDD+L1H53y1bFzhV5NfuPhFbyohZk99faFmRzAbaCjU0
         hmxudHJuQrVhAiiCaMINTyZr/h2svH5GxC/ZhaTnpM+MnB1QLz8wpr18OcQ540lQ8kGl
         5Lg1r/whxMMib36+ogpM2fzSf7xA5R7FhTI+LZ8BqnRA7gZr4gNTT2XIYfxEUMrc/uwg
         cIi6Cj9EiT1LFdTOZIX5RwQAvQhvUFhFhJmQBpBpm0DOx3XXqnsY9G0kYlGbcd9VXk2P
         ljYgJ+HmljbYU03svdmamtlK81Iua4aHH5DQQHfPeB0KmsvlJyiIxL7azRIJRjVuDu0j
         9/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256469; x=1722861269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URdCsVRYzMoEYdKLFQaW58axjPYYNSSxXjeC0AG6T+M=;
        b=OY89S0uo5kPAFl4riuo6U4nzIR6k0qgITm5n7QtUX6gSoqug3NeUIeg7qw7T41HWV+
         /ThIosmJSU4c7i7bzAaGOd7QuqeFDmiK4xfoGN5qQUmmVTyx4GpIJlbJpdBXtV7jsn4l
         tEB59YSS1jQEvyFR6N123pcX1GFLRK67kLsTfh32Sel7SrDi2Z9MnQ+FE1LmM6xI7hAo
         /ZTe86VapamBdAtym9c1L2YWE1QeB7M2afVtna+d2OtnytUOUFwgemOgJVCBv5mMRLyE
         b9h2yZC6IED9jeX3AEm4zu4n6i76BORIKUXlWTmB4WFroVtO5/+BvX/Ky3LxKvkFN21a
         gD4A==
X-Forwarded-Encrypted: i=1; AJvYcCVT/r2m9/CiYVf6WV0k6BU42AkZMcFj988VTJLy17SxDe4oYgUSMHdiwYrHhbGfIe+fcJ7/qIzQchxHvvcViHA2nH4S4xgT815xPvZ9XJCeykTBPjP96Qdn03RscOBkylj6EN8DbCKkBw==
X-Gm-Message-State: AOJu0YwEyRLJCG3INSWjE2U56cbi31/D5nLXI0FwqViz+f6qp/zYDh76
	Pby8v992C/mc+42woMEXskYBaL9ia6mYD8t10aWcnhnovhQhfgjpO9bXYQ==
X-Google-Smtp-Source: AGHT+IGWOq/ranKxk8evo1CIUvA7oA0apBLFisTn+0vSn2aJVBWfUN+9nKsEKYp28d0oQAd92Rs6Nw==
X-Received: by 2002:a17:906:c10f:b0:a7a:a33e:47cc with SMTP id a640c23a62f3a-a7d40185a3emr543302766b.59.1722256468620;
        Mon, 29 Jul 2024 05:34:28 -0700 (PDT)
Received: from tablet.my.domain (ip-37-248-159-154.multi.internet.cyfrowypolsat.pl. [37.248.159.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadbb910sm505313366b.225.2024.07.29.05.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:34:28 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 29 Jul 2024 14:34:21 +0200
Subject: [PATCH RESEND v2 2/2] ARM: dts: bcm-mobile: Split out nodes used
 by both BCM21664 and BCM23550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-bcm21664-common-v2-2-ebc21a89bf63@gmail.com>
References: <20240729-bcm21664-common-v2-0-ebc21a89bf63@gmail.com>
In-Reply-To: <20240729-bcm21664-common-v2-0-ebc21a89bf63@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28224;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=qqKHG/Uy5cH7+DH5QFqsdylDvTqWfKKgXY/fImeU5Vw=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBmp4xOqWhH5LDo8033MegIvBgWNhqnqiPUl4rgD
 xpOzY5huCyJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZqeMTgAKCRCzu/ihE6BR
 aJfWD/9pt165GKyMLEP8oKDTswRnG9IDJZr3pAMEGtJvN6itD1PogJrlZm0G1qR1Bb45gfJA4Cf
 ysChgSd+l3c3gjSyULXGs17noL9OveQyD2FgR9E82RpwocL0/uYfJacGtA//3R2zBX+9TFTjm5c
 HODcoFAuNw5l0o93MqnS7zWb+IqUgCRd0QT3con7s1mPq6xAfybrwgEC9m520Nh9tDNO7tkj6N4
 3w7ivu0JKW7IpM0n4Wj7jLUF/DI/ZKO6Z3yjf3ahZr65fxviPqeBFO+Aw8EwuJ7HcgUDPO9c7Qc
 XqziYjFLnqRm5e4d37qDfhy9592h+PlZiWtWs5Wn3Ay8MX8d7/84TFlpS9r6TsTGiAAqKJ94Gu0
 OpvE/4jbKJJULvfpeXOYDLQ0fWC5K+SeCWCITScmsu7sZEj42goFeYQa6R5NPe/dsPrSOSarlJ1
 XPXo4C95XN8n6YK/i3SR7VmFSm3sabwnli2NycIzRavFJWA7CEf51GkQm0DZprFqO8njEhlT/Hx
 UvYdS9nB64oZOZcTWbU1YmVAvZcE8dxAWHMKv2HyMdma9//yLMykv58mm8k4QxXfe3gkhtGaO+I
 VcG037FRMUK/yRDFyg5Bsvclm1lCWw5Rndng63Ftfi2wI6Xxsg1h4g7+3QrRcx8ioPDvimsmEut
 G+LZ8BnB2QutliQ==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

The BCM21664 is nearly identical in terms of register layout to the
BCM23550. Move the shared nodes into a new file, bcm2166x-common.dtsi,
and make both bcm21664.dtsi and bcm23550.dtsi include it. This new
common file is based on the former bcm23550.dtsi file, and inherits
its licensing.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
As for other uses - the BCM21654 (not in mainline) appears to be fairly
similar in a few ways to the BCM21664 as well; the BCM21855/BCM11531 has
a similar layout of registers, but there are much more differences.
We could potentially further split more nodes into a single common
Broadcom Kona DTSI, then make sub-DTSIs to just change the compatibles,
but that's a task for another patch.
---
Changes in v2:
- Renamed bcm21664-common.dtsi to bcm2166x-common.dtsi
- Dropped model/compatible from SoC DTSIs
- Moved apps bus peripherals in SoC DTSIs under "&apps"
- Re-added SoC-specific compatibles into SoC DTSIs
- Fixed warning regarding address in GIC node name
---
 arch/arm/boot/dts/broadcom/bcm21664.dtsi           | 338 ++-----------------
 .../{bcm23550.dtsi => bcm2166x-common.dtsi}        | 111 +------
 arch/arm/boot/dts/broadcom/bcm23550.dtsi           | 370 ++-------------------
 3 files changed, 73 insertions(+), 746 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm21664.dtsi b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
index c1ad5123bad4..f0d0300079b6 100644
--- a/arch/arm/boot/dts/broadcom/bcm21664.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
@@ -1,15 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (C) 2014 Broadcom Corporation
 
-#include <dt-bindings/clock/bcm21664.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
+#include "bcm2166x-common.dtsi"
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	model = "BCM21664 SoC";
-	compatible = "brcm,bcm21664";
 	interrupt-parent = <&gic>;
 
 	cpus {
@@ -30,312 +24,46 @@ cpu1: cpu@1 {
 			reg = <1>;
 		};
 	};
+};
 
-	gic: interrupt-controller@3ff00100 {
-		compatible = "arm,cortex-a9-gic";
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-		interrupt-controller;
-		reg = <0x3ff01000 0x1000>,
-		      <0x3ff00100 0x100>;
-	};
-
-	smc@3404e000 {
-		compatible = "brcm,bcm21664-smc", "brcm,kona-smc";
-		reg = <0x3404e000 0x400>; /* 1 KiB in SRAM */
-	};
-
-	uartb: serial@3e000000 {
-		compatible = "brcm,bcm21664-dw-apb-uart", "snps,dw-apb-uart";
-		reg = <0x3e000000 0x118>;
-		clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB>;
-		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		status = "disabled";
-	};
-
-	uartb2: serial@3e001000 {
-		compatible = "brcm,bcm21664-dw-apb-uart", "snps,dw-apb-uart";
-		reg = <0x3e001000 0x118>;
-		clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB2>;
-		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		status = "disabled";
-	};
-
-	uartb3: serial@3e002000 {
-		compatible = "brcm,bcm21664-dw-apb-uart", "snps,dw-apb-uart";
-		reg = <0x3e002000 0x118>;
-		clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB3>;
-		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		status = "disabled";
-	};
-
-	L2: cache-controller@3ff20000 {
-		compatible = "arm,pl310-cache";
-		reg = <0x3ff20000 0x1000>;
-		cache-unified;
-		cache-level = <2>;
-	};
-
-	brcm,resetmgr@35001f00 {
-		compatible = "brcm,bcm21664-resetmgr";
-		reg = <0x35001f00 0x24>;
-	};
-
-	timer@35006000 {
-		compatible = "brcm,kona-timer";
-		reg = <0x35006000 0x1c>;
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&aon_ccu BCM21664_AON_CCU_HUB_TIMER>;
-	};
-
-	gpio: gpio@35003000 {
-		compatible = "brcm,bcm21664-gpio", "brcm,kona-gpio";
-		reg = <0x35003000 0x524>;
-		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-		#gpio-cells = <2>;
-		#interrupt-cells = <2>;
-		gpio-controller;
-		interrupt-controller;
-	};
-
-	sdio1: mmc@3f180000 {
-		compatible = "brcm,kona-sdhci";
-		reg = <0x3f180000 0x801c>;
-		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO1>;
-		status = "disabled";
-	};
-
-	sdio2: mmc@3f190000 {
-		compatible = "brcm,kona-sdhci";
-		reg = <0x3f190000 0x801c>;
-		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO2>;
-		status = "disabled";
-	};
-
-	sdio3: mmc@3f1a0000 {
-		compatible = "brcm,kona-sdhci";
-		reg = <0x3f1a0000 0x801c>;
-		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO3>;
-		status = "disabled";
-	};
-
-	sdio4: mmc@3f1b0000 {
-		compatible = "brcm,kona-sdhci";
-		reg = <0x3f1b0000 0x801c>;
-		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO4>;
-		status = "disabled";
-	};
-
-	bsc1: i2c@3e016000 {
-		compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
-		reg = <0x3e016000 0x70>;
-		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC1>;
-		status = "disabled";
-	};
-
-	bsc2: i2c@3e017000 {
-		compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
-		reg = <0x3e017000 0x70>;
-		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC2>;
-		status = "disabled";
-	};
-
-	bsc3: i2c@3e018000 {
-		compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
-		reg = <0x3e018000 0x70>;
-		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC3>;
-		status = "disabled";
-	};
-
-	bsc4: i2c@3e01c000 {
-		compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
-		reg = <0x3e01c000 0x70>;
-		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC4>;
-		status = "disabled";
-	};
-
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		/*
-		 * Fixed clocks are defined before CCUs whose
-		 * clocks may depend on them.
-		 */
-
-		ref_32k_clk: ref_32k {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-		};
-
-		bbl_32k_clk: bbl_32k {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-		};
-
-		ref_13m_clk: ref_13m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <13000000>;
-		};
-
-		var_13m_clk: var_13m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <13000000>;
-		};
-
-		dft_19_5m_clk: dft_19_5m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <19500000>;
-		};
-
-		ref_crystal_clk: ref_crystal {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <26000000>;
-		};
-
-		ref_52m_clk: ref_52m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-		};
-
-		var_52m_clk: var_52m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-		};
-
-		usb_otg_ahb_clk: usb_otg_ahb {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-		};
-
-		ref_96m_clk: ref_96m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <96000000>;
-		};
-
-		var_96m_clk: var_96m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <96000000>;
-		};
-
-		ref_104m_clk: ref_104m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <104000000>;
-		};
-
-		var_104m_clk: var_104m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <104000000>;
-		};
-
-		ref_156m_clk: ref_156m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <156000000>;
+&apps {
+		gic: interrupt-controller@1c01000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x01c01000 0x1000>,
+				  <0x01c00100 0x100>;
 		};
 
-		var_156m_clk: var_156m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <156000000>;
+		L2: cache-controller@1c20000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x01c20000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
 		};
+};
 
-		root_ccu: root_ccu@35001000 {
-			compatible = "brcm,bcm21664-root-ccu";
-			reg = <0x35001000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "frac_1m";
-		};
+&bsc1 {
+	compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
+};
 
-		aon_ccu: aon_ccu@35002000 {
-			compatible = "brcm,bcm21664-aon-ccu";
-			reg = <0x35002000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "hub_timer";
-		};
+&bsc2 {
+	compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
+};
 
-		master_ccu: master_ccu@3f001000 {
-			compatible = "brcm,bcm21664-master-ccu";
-			reg = <0x3f001000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "sdio1",
-					     "sdio2",
-					     "sdio3",
-					     "sdio4",
-					     "sdio1_sleep",
-					     "sdio2_sleep",
-					     "sdio3_sleep",
-					     "sdio4_sleep";
-		};
+&bsc3 {
+	compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
+};
 
-		slave_ccu: slave_ccu@3e011000 {
-			compatible = "brcm,bcm21664-slave-ccu";
-			reg = <0x3e011000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "uartb",
-					     "uartb2",
-					     "uartb3",
-					     "bsc1",
-					     "bsc2",
-					     "bsc3",
-					     "bsc4";
-		};
-	};
+&bsc4 {
+	compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
+};
 
-	usbotg: usb@3f120000 {
-		compatible = "snps,dwc2";
-		reg = <0x3f120000 0x10000>;
-		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&usb_otg_ahb_clk>;
-		clock-names = "otg";
-		phys = <&usbphy>;
-		phy-names = "usb2-phy";
-		status = "disabled";
-	};
+&gpio {
+	compatible = "brcm,bcm21664-gpio", "brcm,kona-gpio";
+};
 
-	usbphy: usb-phy@3f130000 {
-		compatible = "brcm,kona-usb2-phy";
-		reg = <0x3f130000 0x28>;
-		#phy-cells = <0>;
-		status = "disabled";
-	};
+&smc {
+	compatible = "brcm,bcm21664-smc", "brcm,kona-smc";
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm23550.dtsi b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
similarity index 68%
copy from arch/arm/boot/dts/broadcom/bcm23550.dtsi
copy to arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
index 50ebe93d6bd0..049e18b61ccd 100644
--- a/arch/arm/boot/dts/broadcom/bcm23550.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
@@ -1,36 +1,13 @@
+// SPDX-License-Identifier: BSD-3-Clause
 /*
- *  BSD LICENSE
+ * Common device tree for components shared between the BCM21664 and BCM23550
+ * SoCs.
  *
- *  Copyright(c) 2016 Broadcom.  All rights reserved.
- *
- *  Redistribution and use in source and binary forms, with or without
- *  modification, are permitted provided that the following conditions
- *  are met:
- *
- *    * Redistributions of source code must retain the above copyright
- *      notice, this list of conditions and the following disclaimer.
- *    * Redistributions in binary form must reproduce the above copyright
- *      notice, this list of conditions and the following disclaimer in
- *      the documentation and/or other materials provided with the
- *      distribution.
- *    * Neither the name of Broadcom Corporation nor the names of its
- *      contributors may be used to endorse or promote products derived
- *      from this software without specific prior written permission.
- *
- *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (C) 2016 Broadcom
  */
 
-/* BCM23550 and BCM21664 have almost identical clocks */
+/dts-v1/;
+
 #include <dt-bindings/clock/bcm21664.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -38,58 +15,16 @@
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
-	model = "BCM23550 SoC";
-	compatible = "brcm,bcm23550";
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0>;
-			clock-frequency = <1000000000>;
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			enable-method = "brcm,bcm23550";
-			secondary-boot-reg = <0x35004178>;
-			reg = <1>;
-			clock-frequency = <1000000000>;
-		};
-
-		cpu2: cpu@2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			enable-method = "brcm,bcm23550";
-			secondary-boot-reg = <0x35004178>;
-			reg = <2>;
-			clock-frequency = <1000000000>;
-		};
-
-		cpu3: cpu@3 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			enable-method = "brcm,bcm23550";
-			secondary-boot-reg = <0x35004178>;
-			reg = <3>;
-			clock-frequency = <1000000000>;
-		};
-	};
 
 	/* Hub bus */
-	hub@34000000 {
+	hub: hub-bus@34000000 {
 		compatible = "simple-bus";
 		ranges = <0 0x34000000 0x102f83ac>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		smc@4e000 {
-			compatible = "brcm,bcm23550-smc", "brcm,kona-smc";
+		smc: smc@4e000 {
+			/* Compatible filled by SoC DTSI */
 			reg = <0x0004e000 0x400>; /* 1 KiB in SRAM */
 		};
 
@@ -99,7 +34,7 @@ resetmgr: reset-controller@1001f00 {
 		};
 
 		gpio: gpio@1003000 {
-			compatible = "brcm,bcm23550-gpio", "brcm,kona-gpio";
+			/* Compatible filled by SoC DTSI */
 			reg = <0x01003000 0x524>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
@@ -120,7 +55,7 @@ timer@1006000 {
 	};
 
 	/* Slaves bus */
-	slaves@3e000000 {
+	slaves: slaves-bus@3e000000 {
 		compatible = "simple-bus";
 		ranges = <0 0x3e000000 0x0001c070>;
 		#address-cells = <1>;
@@ -157,7 +92,7 @@ uartb3: serial@2000 {
 		};
 
 		bsc1: i2c@16000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+			/* Compatible filled by SoC DTSI */
 			reg = <0x00016000 0x70>;
 			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -167,7 +102,7 @@ bsc1: i2c@16000 {
 		};
 
 		bsc2: i2c@17000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+			/* Compatible filled by SoC DTSI */
 			reg = <0x00017000 0x70>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -177,7 +112,7 @@ bsc2: i2c@17000 {
 		};
 
 		bsc3: i2c@18000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+			/* Compatible filled by SoC DTSI */
 			reg = <0x00018000 0x70>;
 			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -187,7 +122,7 @@ bsc3: i2c@18000 {
 		};
 
 		bsc4: i2c@1c000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+			/* Compatible filled by SoC DTSI */
 			reg = <0x0001c000 0x70>;
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -198,7 +133,7 @@ bsc4: i2c@1c000 {
 	};
 
 	/* Apps bus */
-	apps@3e300000 {
+	apps: apps-bus@3e300000 {
 		compatible = "simple-bus";
 		ranges = <0 0x3e300000 0x01b77000>;
 		#address-cells = <1>;
@@ -253,20 +188,6 @@ sdio4: mmc@eb0000 {
 			clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO4>;
 			status = "disabled";
 		};
-
-		cdc: cdc@1b0e000 {
-			compatible = "brcm,bcm23550-cdc";
-			reg = <0x01b0e000 0x78>;
-		};
-
-		gic: interrupt-controller@1b21000 {
-			compatible = "arm,cortex-a9-gic";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x01b21000 0x1000>,
-			      <0x01b22000 0x1000>;
-		};
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/broadcom/bcm23550.dtsi b/arch/arm/boot/dts/broadcom/bcm23550.dtsi
index 50ebe93d6bd0..c1c69381286b 100644
--- a/arch/arm/boot/dts/broadcom/bcm23550.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm23550.dtsi
@@ -1,45 +1,13 @@
+// SPDX-License-Identifier: BSD-3-Clause
 /*
- *  BSD LICENSE
+ * Device tree for the BCM23550 SoC.
  *
- *  Copyright(c) 2016 Broadcom.  All rights reserved.
- *
- *  Redistribution and use in source and binary forms, with or without
- *  modification, are permitted provided that the following conditions
- *  are met:
- *
- *    * Redistributions of source code must retain the above copyright
- *      notice, this list of conditions and the following disclaimer.
- *    * Redistributions in binary form must reproduce the above copyright
- *      notice, this list of conditions and the following disclaimer in
- *      the documentation and/or other materials provided with the
- *      distribution.
- *    * Neither the name of Broadcom Corporation nor the names of its
- *      contributors may be used to endorse or promote products derived
- *      from this software without specific prior written permission.
- *
- *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ * Copyright (C) 2016 Broadcom
  */
 
-/* BCM23550 and BCM21664 have almost identical clocks */
-#include <dt-bindings/clock/bcm21664.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
+#include "bcm2166x-common.dtsi"
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	model = "BCM23550 SoC";
-	compatible = "brcm,bcm23550";
 	interrupt-parent = <&gic>;
 
 	cpus {
@@ -80,180 +48,9 @@ cpu3: cpu@3 {
 			clock-frequency = <1000000000>;
 		};
 	};
+};
 
-	/* Hub bus */
-	hub@34000000 {
-		compatible = "simple-bus";
-		ranges = <0 0x34000000 0x102f83ac>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		smc@4e000 {
-			compatible = "brcm,bcm23550-smc", "brcm,kona-smc";
-			reg = <0x0004e000 0x400>; /* 1 KiB in SRAM */
-		};
-
-		resetmgr: reset-controller@1001f00 {
-			compatible = "brcm,bcm21664-resetmgr";
-			reg = <0x01001f00 0x24>;
-		};
-
-		gpio: gpio@1003000 {
-			compatible = "brcm,bcm23550-gpio", "brcm,kona-gpio";
-			reg = <0x01003000 0x524>;
-			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-			#gpio-cells = <2>;
-			#interrupt-cells = <2>;
-			gpio-controller;
-			interrupt-controller;
-		};
-
-		timer@1006000 {
-			compatible = "brcm,kona-timer";
-			reg = <0x01006000 0x1c>;
-			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&aon_ccu BCM21664_AON_CCU_HUB_TIMER>;
-		};
-	};
-
-	/* Slaves bus */
-	slaves@3e000000 {
-		compatible = "simple-bus";
-		ranges = <0 0x3e000000 0x0001c070>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		uartb: serial@0 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x00000000 0x118>;
-			clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB>;
-			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uartb2: serial@1000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x00001000 0x118>;
-			clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB2>;
-			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		uartb3: serial@2000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x00002000 0x118>;
-			clocks = <&slave_ccu BCM21664_SLAVE_CCU_UARTB3>;
-			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			status = "disabled";
-		};
-
-		bsc1: i2c@16000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
-			reg = <0x00016000 0x70>;
-			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC1>;
-			status = "disabled";
-		};
-
-		bsc2: i2c@17000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
-			reg = <0x00017000 0x70>;
-			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC2>;
-			status = "disabled";
-		};
-
-		bsc3: i2c@18000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
-			reg = <0x00018000 0x70>;
-			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC3>;
-			status = "disabled";
-		};
-
-		bsc4: i2c@1c000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
-			reg = <0x0001c000 0x70>;
-			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&slave_ccu BCM21664_SLAVE_CCU_BSC4>;
-			status = "disabled";
-		};
-	};
-
-	/* Apps bus */
-	apps@3e300000 {
-		compatible = "simple-bus";
-		ranges = <0 0x3e300000 0x01b77000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		usbotg: usb@e20000 {
-			compatible = "snps,dwc2";
-			reg = <0x00e20000 0x10000>;
-			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&usb_otg_ahb_clk>;
-			clock-names = "otg";
-			phys = <&usbphy>;
-			phy-names = "usb2-phy";
-			status = "disabled";
-		};
-
-		usbphy: usb-phy@e30000 {
-			compatible = "brcm,kona-usb2-phy";
-			reg = <0x00e30000 0x28>;
-			#phy-cells = <0>;
-			status = "disabled";
-		};
-
-		sdio1: mmc@e80000 {
-			compatible = "brcm,kona-sdhci";
-			reg = <0x00e80000 0x801c>;
-			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO1>;
-			status = "disabled";
-		};
-
-		sdio2: mmc@e90000 {
-			compatible = "brcm,kona-sdhci";
-			reg = <0x00e90000 0x801c>;
-			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO2>;
-			status = "disabled";
-		};
-
-		sdio3: mmc@ea0000 {
-			compatible = "brcm,kona-sdhci";
-			reg = <0x00ea0000 0x801c>;
-			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO3>;
-			status = "disabled";
-		};
-
-		sdio4: mmc@eb0000 {
-			compatible = "brcm,kona-sdhci";
-			reg = <0x00eb0000 0x801c>;
-			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&master_ccu BCM21664_MASTER_CCU_SDIO4>;
-			status = "disabled";
-		};
-
+&apps {
 		cdc: cdc@1b0e000 {
 			compatible = "brcm,bcm23550-cdc";
 			reg = <0x01b0e000 0x78>;
@@ -267,147 +64,28 @@ gic: interrupt-controller@1b21000 {
 			reg = <0x01b21000 0x1000>,
 			      <0x01b22000 0x1000>;
 		};
-	};
-
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		/*
-		 * Fixed clocks are defined before CCUs whose
-		 * clocks may depend on them.
-		 */
-
-		ref_32k_clk: ref_32k {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-		};
-
-		bbl_32k_clk: bbl_32k {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-		};
-
-		ref_13m_clk: ref_13m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <13000000>;
-		};
-
-		var_13m_clk: var_13m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <13000000>;
-		};
-
-		dft_19_5m_clk: dft_19_5m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <19500000>;
-		};
-
-		ref_crystal_clk: ref_crystal {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <26000000>;
-		};
-
-		ref_52m_clk: ref_52m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-		};
-
-		var_52m_clk: var_52m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-		};
-
-		usb_otg_ahb_clk: usb_otg_ahb {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-		};
-
-		ref_96m_clk: ref_96m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <96000000>;
-		};
-
-		var_96m_clk: var_96m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <96000000>;
-		};
-
-		ref_104m_clk: ref_104m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <104000000>;
-		};
-
-		var_104m_clk: var_104m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <104000000>;
-		};
+};
 
-		ref_156m_clk: ref_156m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <156000000>;
-		};
+&bsc1 {
+	compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+};
 
-		var_156m_clk: var_156m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <156000000>;
-		};
+&bsc2 {
+	compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+};
 
-		root_ccu: root_ccu@35001000 {
-			compatible = "brcm,bcm21664-root-ccu";
-			reg = <0x35001000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "frac_1m";
-		};
+&bsc3 {
+	compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+};
 
-		aon_ccu: aon_ccu@35002000 {
-			compatible = "brcm,bcm21664-aon-ccu";
-			reg = <0x35002000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "hub_timer";
-		};
+&bsc4 {
+	compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+};
 
-		slave_ccu: slave_ccu@3e011000 {
-			compatible = "brcm,bcm21664-slave-ccu";
-			reg = <0x3e011000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "uartb",
-					     "uartb2",
-					     "uartb3",
-					     "bsc1",
-					     "bsc2",
-					     "bsc3",
-					     "bsc4";
-		};
+&gpio {
+	compatible = "brcm,bcm23550-gpio", "brcm,kona-gpio";
+};
 
-		master_ccu: master_ccu@3f001000 {
-			compatible = "brcm,bcm21664-master-ccu";
-			reg = <0x3f001000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "sdio1",
-					     "sdio2",
-					     "sdio3",
-					     "sdio4",
-					     "sdio1_sleep",
-					     "sdio2_sleep",
-					     "sdio3_sleep",
-					     "sdio4_sleep";
-		};
-	};
+&smc {
+	compatible = "brcm,bcm23550-smc", "brcm,kona-smc";
 };

-- 
2.45.2


