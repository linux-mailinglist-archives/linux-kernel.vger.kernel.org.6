Return-Path: <linux-kernel+bounces-241545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E9927C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24054B243A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADE673442;
	Thu,  4 Jul 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4DsgEov"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A140BF5;
	Thu,  4 Jul 2024 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114943; cv=none; b=GPHCc+vsdFVoDHynLGPhMLFd5RWkFRiEvyN31v/0Udd2m+So3vXTzQQFtaNiPM+E06r6M9mWL9TRMdLyRgJH+P9XSP4yca96JgsvjbcC2L8toG9dM9pjwNKd5eoMxll/lVq10kq5kIstkZ5msVgpztszld5a/M6xT70EEf5WSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114943; c=relaxed/simple;
	bh=SfTt+NBuVrVtPOpSZ07yog9q01tmg9ZnlppWLbsDaWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO/EdRHWYc9QVEIgeraYAkmaMqVx5sVHF0q3UaX7KQ8qMuwCFjc8d38Xkg2Amu/Z2usG3qIybRASupOxvELGI+9Ydatg/GhwO+p0XG8vGynv/K9gZGv7iINj0apGHivz137wTucgbREYMOWKl8iUeju6ArPvtjfoQoUqkDZCLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4DsgEov; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42648961d7aso5893295e9.0;
        Thu, 04 Jul 2024 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114940; x=1720719740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DO7q/NGNcPdvMIxjhvqwBYf8uSmJ6wXA8Ckn0WCsX4c=;
        b=g4DsgEov/BWUoUoZe2sjPeLPqOueTbh/hA+ouxDTtA+Lr9vpQvXBK10UqQD3o6NYz6
         4PIJpgT8/ywsXZwBw+buSXC8Drg+CLKAWy2VaIyfCbQO8MltcqnAbhEch9gQ0uA8754P
         NxiA2M/xAXmuHHxSXRmG3q7+TfbCFPp1VD4SlMCCEbjjhiv/cunjTgy3aE7JiTiBEbpR
         o9KMCXB2EnKTw5ixKBiC2assc1h5z0CM5moKO8NXINJydo7f6BYzQ6Ja84RNdJETpLLR
         +X/ge4BlnjTtfsUF+kh8fBBHWiOPPt2J4oi0rS33ALJ9aW5/r0DwE1VHocCofs3xrMak
         UqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114940; x=1720719740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO7q/NGNcPdvMIxjhvqwBYf8uSmJ6wXA8Ckn0WCsX4c=;
        b=oXPH37RmsWrKow7fES5ujyF54RIuyNd/WojTsns9a+j5lG01fFOpRWvlVZxOOIRpD+
         Vj9Q4C2vu2FyVcuZ+3n0hqe7OuMOn4502J7XJJrOl8vs25CWivUS4+vX+9NZej/Gknuv
         +8EKwDoKJoNbflnW1rWpa354oVjUfWp5HxTRZaWvX88E9gtfNTUoEPSlFgSHuQpWo3yt
         TlwYDP0FnljypTdydfVHvevhgD1ZiETvZWgzxcLcL1SDt9y2CIx5gyB6oMuFsEmv/buQ
         TpIMyM+M1kIgrWd2p1A6D/JwEUN82mr0pfJU2vojmlAq/oCBPXAqmZO11hX+mWSFoHLx
         RUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCURdPSSrdlbed5ZhNzmvFXhFm/sPFMAiQbIjjxZzuhBXILHrB0EjTcpFA26CSBtpHuAoqytGI5QB+gVyIPzhUQ+P5ZhciN6J9X+ycbK
X-Gm-Message-State: AOJu0Yxvq2uPYt8XYUTtmjrs0wLMPYvqqUtdUZr2LM/vsZG7n1nSkRf0
	o5UxCtf6JC9/EaSGt9YwIV947uPM4xdOJXH2S1BrPnH6r8ttYM1g
X-Google-Smtp-Source: AGHT+IFCwuIDDla90x+4B9eGYmM36tynt3nGQCnGhZ+87WBaBNnvKSxXhQRuFh4TsAVnci4xfZkbPg==
X-Received: by 2002:a05:600c:5126:b0:424:bb93:7aad with SMTP id 5b1f17b1804b1-4264a36eebbmr19192325e9.0.1720114940403;
        Thu, 04 Jul 2024 10:42:20 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca4c2sm32598535e9.36.2024.07.04.10.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:42:20 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:42:18 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: sprd: reorder clock-names after clocks
Message-ID: <9623744b096c026f481fc5d03ba8f1643e487534.1720112081.git.stano.jakubek@gmail.com>
References: <cover.1720112081.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720112081.git.stano.jakubek@gmail.com>

DT convention is to have property-names after property.
While at it, cleanup indentation for some clocks.
No functional change.

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


