Return-Path: <linux-kernel+bounces-274276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB949475FA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0030128104A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B350D1494D6;
	Mon,  5 Aug 2024 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZk7uoi/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222541448C1;
	Mon,  5 Aug 2024 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842680; cv=none; b=AfuvvJctKYhbkB6/yJZ82qjs+hfsbttjtUJqQYlEMNHNuHzF4Gph4VWaD8qjaYOFCVDcqDj1f8NQUrX88QjIB3XF/3lDn6o14l2KoY3jCgvmeMwDKQXCW0/eDndLCHzyoMg0Pozx/pxCbtS8Yj7E0lWOIavTylcEqRfDmqBvKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842680; c=relaxed/simple;
	bh=bcoo1V5Lh2z0xHRz4QHfgtHgBYifRuIbEhGT+EmO3DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOPI36Ri1sraEoW2DlGYs0NZPR0C1qFHc/6f20aOih5I0AThAl1yTuYioloq8YkMFe1F6gge79Mm55ZUZPtDYg7ucyWM0n/q/9+66mAC6UIS0Ue1DtWFfyUVW6qmD21W7/2QDPsVRAsQu1noR3yu5t1L7gsTdiLlYxDlvifvcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZk7uoi/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3685a5e7d3cso6190342f8f.1;
        Mon, 05 Aug 2024 00:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722842677; x=1723447477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXjqaIKyj7IX12p7vaYq4Nq/31JWzkaHK9RWGWBCRUA=;
        b=LZk7uoi/9SCgQRM1uUPiKVijNHOci7tIZCRW2f18i5oQ4inAJ1sc03tRfInwcY4ufg
         FWQbEkaE8+89kkdVFteQ0NrZo7OG+TwrZogk4a7XEZJiVXovUEbDCkmKF5GV+2uSZPeq
         rJLkn87otM0ASA78AYB2JC/te0pILWJVLx/0u8Pmdfam31eIJgqJPuMLhiWhoCVx0/3k
         nGS7yG2XPl0HYh03SewBaOivrD0l2++ZuHS6WsWWjmIQu/LTnMC48YlvNBK/4k/WEDa/
         3/YPJ9nsUN6BUXLNuXDivkyD8lIZLx5x3VYpn9PsW5uxHdqi6q2VHEhqWSI79hhN2q8O
         ugNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842677; x=1723447477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXjqaIKyj7IX12p7vaYq4Nq/31JWzkaHK9RWGWBCRUA=;
        b=BShiwmB5FiXqJzH1mZUCE5LrUALzNP3QHdJvzmmIpcBMF5zNx3urKkHQesvCl1AFM2
         cv9nZRJ3R4uF6TrveJ08K7L1GM29qOlpToNVA/W2Xn8ebA9heDaS94J7ojcVG3EvEG9+
         u8ofeADI2I7lwJQ8i4lzPr+v+tmwzvcAsQdfRpVwdUsPHWD6RmC5QFwCojMh8gpi4MCP
         ZjtLr91DiDRdad5KsYRn300q0YYZvq5dbJDIyQEA9RxrSXR+1GSgGU2Hd1xco7JWyCWZ
         ez8AhcsLxhkvN3BEsaVSkT790Qxi3mZHh/nUyOLmjnLtApaeZc1HOSTHmkqatHvWfuI1
         BWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAi2anAl3Iz9IA2MOb7PTPfWWTtTHvsvl5N4Fmk8kCQRsnG15V6YLTOYNcWBlpnOP+dwZqx8toQewvwHj6LMU9uepQ8pqFeT/FYt2N
X-Gm-Message-State: AOJu0YzHdT/d4RwQ1F1MbOiM+lDipDUN/cdsu4xiyc8YZ5bb7HPz6QBj
	iCEk8W78HHv+Pa0OgZ3VYBLj7t87yFKuI2OzIvGaf5TM2TpyaXBv
X-Google-Smtp-Source: AGHT+IHAcgyhD4dmsR0AChh9uYGwbpeDLD37EIXsBLBrXazHRhm3Xg5xJVG6vvmo3R+Qbu+U5pn1wA==
X-Received: by 2002:adf:e644:0:b0:367:8f29:f7b6 with SMTP id ffacd0b85a97d-36bbc1c0bc3mr8270739f8f.51.1722842677096;
        Mon, 05 Aug 2024 00:24:37 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06dfb4sm8904169f8f.103.2024.08.05.00.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:24:36 -0700 (PDT)
Date: Mon, 5 Aug 2024 09:24:35 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: dts: sprd: reorder clock-names after clocks
Message-ID: <13ea4a27f0d1428a925a6f817f9370673eaec938.1722842067.git.stano.jakubek@gmail.com>
References: <cover.1722842066.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722842066.git.stano.jakubek@gmail.com>

DT convention is to have property-names after property.
While at it, cleanup indentation for some clocks.
No functional change.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm64/boot/dts/sprd/sc9863a.dtsi |  4 +--
 arch/arm64/boot/dts/sprd/ums512.dtsi  |  4 +--
 arch/arm64/boot/dts/sprd/whale2.dtsi  | 38 +++++++++++++++------------
 3 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index a7b897966882..e5a2857721e2 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -556,9 +556,9 @@ sdio0: mmc@20300000 {
 				reg = <0 0x20300000 0 0x1000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 
-				clock-names = "sdio", "enable";
 				clocks = <&aon_clk CLK_SDIO0_2X>,
 					 <&apahb_gate CLK_SDIO0_EB>;
+				clock-names = "sdio", "enable";
 				assigned-clocks = <&aon_clk CLK_SDIO0_2X>;
 				assigned-clock-parents = <&rpll CLK_RPLL_390M>;
 
@@ -572,9 +572,9 @@ sdio3: mmc@20600000 {
 				reg = <0 0x20600000 0 0x1000>;
 				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 
-				clock-names = "sdio", "enable";
 				clocks = <&aon_clk CLK_EMMC_2X>,
 					 <&apahb_gate CLK_EMMC_EB>;
+				clock-names = "sdio", "enable";
 				assigned-clocks = <&aon_clk CLK_EMMC_2X>;
 				assigned-clock-parents = <&rpll CLK_RPLL_390M>;
 
diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index 4c080df48724..efa14309cc4e 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -849,9 +849,9 @@ sdio0: mmc@1100000 {
 				compatible = "sprd,sdhci-r11";
 				reg = <0x1100000 0x1000>;
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-				clock-names = "sdio", "enable";
 				clocks = <&ap_clk CLK_SDIO0_2X>,
 					 <&apapb_gate CLK_SDIO0_EB>;
+				clock-names = "sdio", "enable";
 				assigned-clocks = <&ap_clk CLK_SDIO0_2X>;
 				assigned-clock-parents = <&pll1 CLK_RPLL>;
 				status = "disabled";
@@ -861,9 +861,9 @@ sdio3: mmc@1400000 {
 				compatible = "sprd,sdhci-r11";
 				reg = <0x1400000 0x1000>;
 				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-				clock-names = "sdio", "enable";
 				clocks = <&ap_clk CLK_EMMC_2X>,
 					 <&apapb_gate CLK_EMMC_EB>;
+				clock-names = "sdio", "enable";
 				assigned-clocks = <&ap_clk CLK_EMMC_2X>;
 				assigned-clock-parents = <&pll1 CLK_RPLL>;
 				status = "disabled";
diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index cdf52fd78ee4..a28f995fb3ff 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -75,9 +75,10 @@ uart0: serial@0 {
 					     "sprd,sc9836-uart";
 				reg = <0x0 0x100>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-				clock-names = "enable", "uart", "source";
 				clocks = <&apapb_gate CLK_UART0_EB>,
-				       <&ap_clk CLK_UART0>, <&ext_26m>;
+					 <&ap_clk CLK_UART0>,
+					 <&ext_26m>;
+				clock-names = "enable", "uart", "source";
 				status = "disabled";
 			};
 
@@ -86,9 +87,10 @@ uart1: serial@100000 {
 					     "sprd,sc9836-uart";
 				reg = <0x100000 0x100>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-				clock-names = "enable", "uart", "source";
 				clocks = <&apapb_gate CLK_UART1_EB>,
-				       <&ap_clk CLK_UART1>, <&ext_26m>;
+					 <&ap_clk CLK_UART1>,
+					 <&ext_26m>;
+				clock-names = "enable", "uart", "source";
 				status = "disabled";
 			};
 
@@ -97,9 +99,10 @@ uart2: serial@200000 {
 					     "sprd,sc9836-uart";
 				reg = <0x200000 0x100>;
 				interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-				clock-names = "enable", "uart", "source";
 				clocks = <&apapb_gate CLK_UART2_EB>,
-				       <&ap_clk CLK_UART2>, <&ext_26m>;
+					 <&ap_clk CLK_UART2>,
+					 <&ext_26m>;
+				clock-names = "enable", "uart", "source";
 				status = "disabled";
 			};
 
@@ -108,9 +111,10 @@ uart3: serial@300000 {
 					     "sprd,sc9836-uart";
 				reg = <0x300000 0x100>;
 				interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-				clock-names = "enable", "uart", "source";
 				clocks = <&apapb_gate CLK_UART3_EB>,
-				       <&ap_clk CLK_UART3>, <&ext_26m>;
+					 <&ap_clk CLK_UART3>,
+					 <&ext_26m>;
+				clock-names = "enable", "uart", "source";
 				status = "disabled";
 			};
 		};
@@ -129,8 +133,8 @@ ap_dma: dma-controller@20100000 {
 				/* For backwards compatibility: */
 				#dma-channels = <32>;
 				dma-channels = <32>;
-				clock-names = "enable";
 				clocks = <&apahb_gate CLK_DMA_EB>;
+				clock-names = "enable";
 			};
 
 			sdio3: mmc@50430000 {
@@ -138,10 +142,10 @@ sdio3: mmc@50430000 {
 				reg = <0 0x50430000 0 0x1000>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 
-				clock-names = "sdio", "enable", "2x_enable";
 				clocks = <&aon_prediv CLK_EMMC_2X>,
-				       <&apahb_gate CLK_EMMC_EB>,
-				       <&aon_gate CLK_EMMC_2X_EN>;
+					 <&apahb_gate CLK_EMMC_EB>,
+					 <&aon_gate CLK_EMMC_2X_EN>;
+				clock-names = "sdio", "enable", "2x_enable";
 				assigned-clocks = <&aon_prediv CLK_EMMC_2X>;
 				assigned-clock-parents = <&clk_l0_409m6>;
 
@@ -194,8 +198,8 @@ hwlock: hwspinlock@40500000 {
 				compatible = "sprd,hwspinlock-r3p0";
 				reg = <0 0x40500000 0 0x1000>;
 				#hwlock-cells = <1>;
-				clock-names = "enable";
 				clocks = <&aon_gate CLK_SPLK_EB>;
+				clock-names = "enable";
 			};
 
 			eic_debounce: gpio@40210000 {
@@ -258,9 +262,9 @@ watchdog@40310000 {
 				reg = <0 0x40310000 0 0x1000>;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 				timeout-sec = <12>;
-				clock-names = "enable", "rtc_enable";
 				clocks = <&aon_gate CLK_APCPU_WDG_EB>,
-				       <&aon_gate CLK_AP_WDG_RTC_EB>;
+					 <&aon_gate CLK_AP_WDG_RTC_EB>;
+				clock-names = "enable", "rtc_enable";
 			};
 		};
 
@@ -277,9 +281,9 @@ agcp_dma: dma-controller@41580000 {
 				/* For backwards compatibility: */
 				#dma-channels = <32>;
 				dma-channels = <32>;
-				clock-names = "enable", "ashb_eb";
 				clocks = <&agcp_gate CLK_AGCP_DMAAP_EB>,
-				       <&agcp_gate CLK_AGCP_AP_ASHB_EB>;
+					 <&agcp_gate CLK_AGCP_AP_ASHB_EB>;
+				clock-names = "enable", "ashb_eb";
 			};
 		};
 	};
-- 
2.34.1


