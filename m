Return-Path: <linux-kernel+bounces-201818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BD8FC3DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4B6288D17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DB218C334;
	Wed,  5 Jun 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Atgna41h"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3874190482;
	Wed,  5 Jun 2024 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569629; cv=none; b=pm/crIqSCmN7AzZHTPg6c+7Hs5R0endFzrNWobhl9NzBdZIfVfeybpPyXlaXMPcN0JSatZG812N8BgVwx4eFnCKPyqlZe79hpXTB83LshniNx9YqAuh2/buDgub5GFGyMd0C2tKgFR/lXpu5vadEoodpYsQalOGwvRnKyH6ciZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569629; c=relaxed/simple;
	bh=BQ4tSva1zNrjSygPvKnA9sRhSbYMdlDq5Sn3/8Jdcno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M90H2G039OakW/5xaqz3ZWy6AkthXdrHnbkSEE5daHLcjSxa6pFrqyb14pBt801JRavNpi5Vmr4h7ivxU2uytOgt4QkbHy2eEGyIIgdxOcaTN+uo9oLOIPQE23kpw/O6Eeth83DsZcoAkwB0MzdVat/KBNr8eU/xf3rwG3+YzU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Atgna41h; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so1078222a12.0;
        Tue, 04 Jun 2024 23:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717569625; x=1718174425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nd73aXYUVtbFE1Ud3Hq1iCxcPOnVa/Poq92CQVoTAGM=;
        b=Atgna41hmRE/IrO0z2TPS7tDWfLGMZCXU9v61HCumHgJW8S/BWMiqSy+fZU5TSSIXd
         jrU8aE+mjsgtlTUXEQa1EPZbbDBjjJ+Oh/psZPtU6ytB21bSJAkhkl3ILne7gicuRjr1
         OX+I2E9hKgPu30b4oMwwW6HIGv1IqFtz4diteGueV6LtOGbnS/8cs++yOeeoAP1e8Sh1
         Tn8sUj4XdXZX64YeWbX2h2zi9RWSV+lehnU2E8ZBDaUV9oyLXOjQAoZwc9KRiVN1bev8
         MST/itx4ZuyDngMOodpaNUt39dbJ8duZPRlSdORLLRn77zUMF1vLCK0iz3riD3lGYrkB
         bveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717569625; x=1718174425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nd73aXYUVtbFE1Ud3Hq1iCxcPOnVa/Poq92CQVoTAGM=;
        b=hBkPkaEkSAzGFoiyuEU+z8eSjf1AprMIxjiXUW8gEatApDgfxFLIuoLcNAatR01lPC
         Y/GlEBjb9lbXU5zbX6eT27Ah/xcixMOU3vne47lsP+XTtRivM2U/MIox/WmHCAgYdwS/
         i88g+MpI4jqcxlZpHJkOy0jQvRrfHsfgj2izjIgLZN8sYsitGx5kAV7nwMZObBbNEsfr
         mcEIxHOPWnAb86tU6etwd9OqNWIFZ7W1kfS8UYuADYDkFkabFQsHVZz/zNMGGUFcMyXv
         T4LOkzqeO71L8p8eD69f8dV2BnxhEhNp0w60Uh6RyLJS5i1frnoa9Fzv72RbKMeBdFe8
         RsCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVPi9CUa8DvDJcNjF52QUyAN6C1pIJGn72+JT9WpculugyeEVJOXE+qhspfu87xYetjx3QmXdNTz2DT9FVdwrHOKR4gr+UP4nO09fhlBf7sLWx8mitWhE+tv+ox3Ev7pmVEY4Tg2LCJw==
X-Gm-Message-State: AOJu0YylFOiIpr1D7pJiMFr8luOA4BPPuMbDgBLmzjNZPRSlkT4bzohQ
	B+I+PA9aIFcO/h14rB8b4sOiZZSUgFcN5SYRB+JbK17TWWVRMtiO
X-Google-Smtp-Source: AGHT+IGIo9cFQjdf1f7qtQukArYnakMRP43ooxT5jwmp/Zs7v715gCmUJvR1CbRKCMP3Kx9VO/LamA==
X-Received: by 2002:a50:cddb:0:b0:578:62f7:2881 with SMTP id 4fb4d7f45d1cf-57a7a52c025mr3793234a12.0.1717569625040;
        Tue, 04 Jun 2024 23:40:25 -0700 (PDT)
Received: from hex.my.domain (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99445sm8665505a12.18.2024.06.04.23.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 23:40:24 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 05 Jun 2024 08:40:13 +0200
Subject: [PATCH 2/2] ARM: dts: bcm-mobile: Split out nodes used by both
 BCM21664 and BCM23550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-bcm21664-common-v1-2-6386e9141eb6@gmail.com>
References: <20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com>
In-Reply-To: <20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717569621; l=30364;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=BQ4tSva1zNrjSygPvKnA9sRhSbYMdlDq5Sn3/8Jdcno=;
 b=ypCjD3VHm4n8Wvj1VV+abzgbMZ7ks0SIE/orYfMFuQZ2MD1fdfV/9hd2xcwGjoNQV7N3Jt5U1
 rWrGfhCWICYBANri02yGn08ICCt7dmGVnSypKCU7CSt/+iJEv5w8nPf
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM21664 is nearly identical in terms of register layout to the
BCM23550. Move the shared nodes into a new file, bcm21664-common.dtsi,
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
 .../{bcm23550.dtsi => bcm21664-common.dtsi}        | 109 +----
 arch/arm/boot/dts/broadcom/bcm21664.dtsi           | 388 ++---------------
 arch/arm/boot/dts/broadcom/bcm23550.dtsi           | 482 +++------------------
 3 files changed, 131 insertions(+), 848 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm23550.dtsi b/arch/arm/boot/dts/broadcom/bcm21664-common.dtsi
similarity index 68%
copy from arch/arm/boot/dts/broadcom/bcm23550.dtsi
copy to arch/arm/boot/dts/broadcom/bcm21664-common.dtsi
index 50ebe93d6bd0..44978a459d32 100644
--- a/arch/arm/boot/dts/broadcom/bcm23550.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm21664-common.dtsi
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
 
 		smc@4e000 {
-			compatible = "brcm,bcm23550-smc", "brcm,kona-smc";
+			compatible = "brcm,bcm21664-smc", "brcm,kona-smc";
 			reg = <0x0004e000 0x400>; /* 1 KiB in SRAM */
 		};
 
@@ -99,7 +34,7 @@ resetmgr: reset-controller@1001f00 {
 		};
 
 		gpio: gpio@1003000 {
-			compatible = "brcm,bcm23550-gpio", "brcm,kona-gpio";
+			compatible = "brcm,bcm21664-gpio", "brcm,kona-gpio";
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
+			compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
 			reg = <0x00016000 0x70>;
 			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -167,7 +102,7 @@ bsc1: i2c@16000 {
 		};
 
 		bsc2: i2c@17000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+			compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
 			reg = <0x00017000 0x70>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -177,7 +112,7 @@ bsc2: i2c@17000 {
 		};
 
 		bsc3: i2c@18000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+			compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
 			reg = <0x00018000 0x70>;
 			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
@@ -187,7 +122,7 @@ bsc3: i2c@18000 {
 		};
 
 		bsc4: i2c@1c000 {
-			compatible = "brcm,bcm23550-i2c", "brcm,kona-i2c";
+			compatible = "brcm,bcm21664-i2c", "brcm,kona-i2c";
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
diff --git a/arch/arm/boot/dts/broadcom/bcm21664.dtsi b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
dissimilarity index 93%
index c1ad5123bad4..a868f09e8930 100644
--- a/arch/arm/boot/dts/broadcom/bcm21664.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm21664.dtsi
@@ -1,341 +1,47 @@
-// SPDX-License-Identifier: GPL-2.0-only
-// Copyright (C) 2014 Broadcom Corporation
-
-#include <dt-bindings/clock/bcm21664.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	model = "BCM21664 SoC";
-	compatible = "brcm,bcm21664";
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			reg = <0>;
-		};
-
-		cpu1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a9";
-			enable-method = "brcm,bcm11351-cpu-method";
-			secondary-boot-reg = <0x35004178>;
-			reg = <1>;
-		};
-	};
-
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
-		};
-
-		var_156m_clk: var_156m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <156000000>;
-		};
-
-		root_ccu: root_ccu@35001000 {
-			compatible = "brcm,bcm21664-root-ccu";
-			reg = <0x35001000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "frac_1m";
-		};
-
-		aon_ccu: aon_ccu@35002000 {
-			compatible = "brcm,bcm21664-aon-ccu";
-			reg = <0x35002000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "hub_timer";
-		};
-
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
-
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
-
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
-
-	usbphy: usb-phy@3f130000 {
-		compatible = "brcm,kona-usb2-phy";
-		reg = <0x3f130000 0x28>;
-		#phy-cells = <0>;
-		status = "disabled";
-	};
-};
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2014 Broadcom Corporation
+
+#include "bcm21664-common.dtsi"
+
+/ {
+	model = "BCM21664 SoC";
+	compatible = "brcm,bcm21664";
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			enable-method = "brcm,bcm11351-cpu-method";
+			secondary-boot-reg = <0x35004178>;
+			reg = <1>;
+		};
+	};
+
+	apps: apps-bus@3e300000 {
+		gic: interrupt-controller@1c00100 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x01c01000 0x1000>,
+			      <0x01c00100 0x100>;
+		};
+
+		L2: cache-controller@1c20000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x01c20000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/broadcom/bcm23550.dtsi b/arch/arm/boot/dts/broadcom/bcm23550.dtsi
dissimilarity index 88%
index 50ebe93d6bd0..bb5ae970816b 100644
--- a/arch/arm/boot/dts/broadcom/bcm23550.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm23550.dtsi
@@ -1,413 +1,69 @@
-/*
- *  BSD LICENSE
- *
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
- */
-
-/* BCM23550 and BCM21664 have almost identical clocks */
-#include <dt-bindings/clock/bcm21664.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
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
-
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
-		};
-
-		var_156m_clk: var_156m {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <156000000>;
-		};
-
-		root_ccu: root_ccu@35001000 {
-			compatible = "brcm,bcm21664-root-ccu";
-			reg = <0x35001000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "frac_1m";
-		};
-
-		aon_ccu: aon_ccu@35002000 {
-			compatible = "brcm,bcm21664-aon-ccu";
-			reg = <0x35002000 0x0f00>;
-			#clock-cells = <1>;
-			clock-output-names = "hub_timer";
-		};
-
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
-
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
-};
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Device tree for the BCM23550 SoC.
+ *
+ * Copyright (C) 2016 Broadcom
+ */
+
+#include "bcm21664-common.dtsi"
+
+/ {
+	model = "BCM23550 SoC";
+	compatible = "brcm,bcm23550";
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0>;
+			clock-frequency = <1000000000>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			enable-method = "brcm,bcm23550";
+			secondary-boot-reg = <0x35004178>;
+			reg = <1>;
+			clock-frequency = <1000000000>;
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			enable-method = "brcm,bcm23550";
+			secondary-boot-reg = <0x35004178>;
+			reg = <2>;
+			clock-frequency = <1000000000>;
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			enable-method = "brcm,bcm23550";
+			secondary-boot-reg = <0x35004178>;
+			reg = <3>;
+			clock-frequency = <1000000000>;
+		};
+	};
+
+	apps: apps-bus@3e300000 {
+		cdc: cdc@1b0e000 {
+			compatible = "brcm,bcm23550-cdc";
+			reg = <0x01b0e000 0x78>;
+		};
+
+		gic: interrupt-controller@1b21000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x01b21000 0x1000>,
+			      <0x01b22000 0x1000>;
+		};
+	};
+};

-- 
2.45.1


