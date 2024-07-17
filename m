Return-Path: <linux-kernel+bounces-255360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0757933FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D481F2171A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621F181CF4;
	Wed, 17 Jul 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUZhooUM"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41232181D0B;
	Wed, 17 Jul 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230090; cv=none; b=R1owtQC8OqUMSnyv947FQfBwKjkx1Sye1WVTgfDlsch5AqV5r9p4Rs+sBcXih6wfNU8PKTv+BOQhh0pXdcJ/bdewlwyba9FX6bwawKzWgT4Nw8PIJFPhCD97mFXpm5rLiXWcSMyZc53U3cZqTkDNsIHe9GfdEQ/4boTNwvUQ3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230090; c=relaxed/simple;
	bh=qqKHG/Uy5cH7+DH5QFqsdylDvTqWfKKgXY/fImeU5Vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHv26YbYWRgMDlnQG7kf6lawAYwc+3ALuJWsdZR1QkykYE+crZ+rEEWnKFwWP5anXWEszILddJzBEx72riR1hhOqNOww9w9K9ftwihEXLAOFNIqTQvIekNXgxeckH7RgUXeTTed8bQwvlG5Bj4xTIL9W74ml1xwlogXizAMrMnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUZhooUM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ed741fe46so4426320e87.0;
        Wed, 17 Jul 2024 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721230085; x=1721834885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URdCsVRYzMoEYdKLFQaW58axjPYYNSSxXjeC0AG6T+M=;
        b=cUZhooUMspUQNiS7KstfjYx4ejy8OLZkYceA61sjHon19xfN/oFGBMvgc/7jdzcBhJ
         iXWhvK3S5bzWIdDRayXSrdXPMPXePIi5lnKD0+9+YZIxQhf92nx8PpNZuiLxRqDZrH5N
         tV2swEXIboVbi7pPEARRSN6ljM7zKi+TogsmLY4fatBO1v8wei9ZJagJ4EpVTL2kuxru
         T+EtP4ABalrXKnFTRSaBhyTZHQodY6PmNnxdXHi7CQaRwMWeFYjNrlTzALrwfJAQEw7a
         ydemNtMwkFtvPsxJwN1sC1RndotQzGYNWevExcK+nHOXvjFDANkHlndcKyjPVvO6Rczh
         wMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721230085; x=1721834885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URdCsVRYzMoEYdKLFQaW58axjPYYNSSxXjeC0AG6T+M=;
        b=X3dNOsTug1gIPia2tbNOac8FgNTY0m2HUiphaycLwzyNkpD1TLbjkxLQHn+UmkEKue
         eKEAqxgFAmmrkxtxgxELm+lkt9K+OD+Jglr3ze1Ts8A/sAl84Xvpvs13dUblylXlLMD9
         DY/wKW/XEZEnVvvXmfTD0s9KPtzx5CIUgu7L9GYjON4zxy4f/+bLEDIHSvjiTVQ63Ig1
         bJ0fjQ1gaOSYclikKYZSHul6vrwye7xvWR4lXuZlWfwkb8zZBLoxpMfwtVySfvaQeyTF
         1SzziDWsxq0Q1/QsHrUKILOuWWF1LsjxmBWiCjiwYS+abOSjFj1psjGlAiCReaRDoH1l
         bUuw==
X-Forwarded-Encrypted: i=1; AJvYcCWuLsfhsPQTfiM1XhEdpQ9atQxzKlH6P70YDy9NTJPFtSmsklhXz5F8dpzm5uOau6Vwh3r/SiYCdm+fXFsBNwXx1Q7MDhVPKQdZ2rMkPcCO9r0EZOriPY6c9uWHTypKNfkzMq/iZo+9Rw==
X-Gm-Message-State: AOJu0YxiFSXZh9JV7oLnwyPT9lYa1Fq/WIzGNvCtwY07vqfZiQAYK8U+
	m4+RiTjZBxc+VTFjUVXMOEpQX+VexSsx7ICOCJc+Yk5zv3mYBO1S
X-Google-Smtp-Source: AGHT+IGTUYz1C2IDhVZsX9cMAtIKHFUgITjSdtqa1toWRDJY5ikyOtTnyVSg8uYhjRrjmWz9C1fB+Q==
X-Received: by 2002:a05:6512:2253:b0:52c:e0ce:2d32 with SMTP id 2adb3069b0e04-52ee53dcf4bmr1673340e87.36.1721230084957;
        Wed, 17 Jul 2024 08:28:04 -0700 (PDT)
Received: from tablet.my.domain (ip-5-172-234-79.multi.internet.cyfrowypolsat.pl. [5.172.234.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff780sm456378766b.169.2024.07.17.08.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:28:04 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 17 Jul 2024 17:27:55 +0200
Subject: [PATCH v2 2/2] ARM: dts: bcm-mobile: Split out nodes used by both
 BCM21664 and BCM23550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-bcm21664-common-v2-2-e9bd6cf435e4@gmail.com>
References: <20240717-bcm21664-common-v2-0-e9bd6cf435e4@gmail.com>
In-Reply-To: <20240717-bcm21664-common-v2-0-e9bd6cf435e4@gmail.com>
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
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBml+L++2QeaHLcNJiAuk0DttEx1F0tPqHVtmw6K
 g++oZ0fVjmJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCZpfi/gAKCRCzu/ihE6BR
 aNjFD/wO6Fag0ua8DJ1Fzy9OZ2o7AmSR+MCKXw8LkdZAwmlTACSFCHFXLIop+usKs5c44ugCye2
 TbcZjKgFgP/uYdUSh1/sk4qeH0mh8oWxhg4uPVcJ9P+vUIsv3d/9GAM2NzIeZXT0K4yuH9j/gmw
 yn3b464YGZalItJS4MAuy3swzH+z1k3HBKaM5Mr5wrr73cjjx/mPvmvvyY9UrPknbijUJtiZZxS
 TOLMwFjq7tkumxDeDvZl8nDDGPwa0GUj5XgwndJTbtYmts2/Do2tGGnyU22TLax7sBw2ah3WV0N
 AGSmgSfVu4S94JNpHjqnp7dzxyTGalUzoV3wy+pstDwWKPs09xV7IB3aOYYVgoOi3joHSIgBxVX
 VacxLPpCcGG3t1+8mjeTsYpENOF3BNodmYX5RH0cGhZFDli1AsUHGEz9YWbrrNNXGt6iP3OBw+Y
 /dTYYPXMpwy/j9ArCtqXgizmt7VnM9sXAd9H86smcCW86F6X5vQC3pOWeHLjKlOyEt3fy6q8t/6
 je8cHJ0Z9qnqig30Me33L6LXgaZ8AEzn2GQV0Nwh9vCh3/oQ6yfsnczFpf/yWCZR7gZ7+g6O8mP
 mOR37DN+oFxAnLrq7wuI7buuuxwlpoD78wmijItpVDaA7fHgMKkQOVU1JrWP2GSOVmNEzmBbif3
 j18STjJ4YljocBg==
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


