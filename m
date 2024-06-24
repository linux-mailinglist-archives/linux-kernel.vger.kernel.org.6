Return-Path: <linux-kernel+bounces-226561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077BC91405F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435E8B2145D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A208310A1F;
	Mon, 24 Jun 2024 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="BIpP+Q3L"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A1079F6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719195350; cv=none; b=jc8H+fhxWsOp/YQeUktQNcQoiKzGHjBYODplgI8cHmveXzviIJEKz7DHoMB9zex4bYyK8Rx4cClwUzsMMJYvNjLXT3NvUS6xw95oZ14ABfTBcr2Ki2TX0W1ge7UyJA7NSJR7dGZA2kLc/dfttvU6csmoW9sEINGxFOGg1kT//90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719195350; c=relaxed/simple;
	bh=auGSbMjsRld4SLXQydJm42vMc+m34WENWJOd8P1SjjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPqf3nslCKZFBpLTJZhl9zIO4kBvAf0GpvETvZmO/Pq0bVjHSubtwk9c2+IOpM1G8M/6JklgClTcgWg3RaAMnWnI/4/k0ARLT5vzyGPl410CArG43Ck4+3mL6nd02h8wSCgreHd0K2EWWnOpUpwSWHcACl4TYfuLfxAf6sWJWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=BIpP+Q3L; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d21e00d9cfso2239001b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1719195348; x=1719800148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFm3u6ML7G4PG1gj6FcitJqB9L+KS2ySDE6qewIEN3w=;
        b=BIpP+Q3LCtLpIwoubX6Q+ZIukl6voa9rLGb3daPd/1q3gpeNoiiLp/fg06Q3mAX2ex
         Wf0tB7ByNwWmg7nmVWWSr9nP1YVQ0Vy91AjrCT+Lanz0m545AHzD2EvuKLmHVcl8Jev3
         jqU8CbgRsRquP49yLNpkvqPU7skGVtfdkXRuyodXcwSyPhDDOpDcEl4V7BtpV87ssq8P
         YTayD/Q0BczHy9P0IMEHrTjbpktCXcLqe9wTgjGPbMNm13SSGUMbT7CzoKWRGbbUztcw
         jxfkgd5PtU/Fn6axybk/BrJyaiTBHhwi7joCidDuNhXSVwSEQUcq4ok1mTTHogLlh+qJ
         C7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719195348; x=1719800148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFm3u6ML7G4PG1gj6FcitJqB9L+KS2ySDE6qewIEN3w=;
        b=tBKgFHy+F6ANli9CYqyLvX3ingOaBeppe2RXlNEBPic7F1wHA8pHIcF8kzz+YFYucA
         /qekRGotkLeKB2PT3fmsej/W7dgRXJyuCwwjTmyHybjYM2+4YW7MWpO/lQ073vH0K3lg
         LT80dR1WXIkP0YmEf6ViD00jPNtZeGjQ3k54pVOrbT9OXJqiYZjuviVpglJSViMQqpb4
         MSXcWmPJngMIHeVzgbi3gvHZ97AXe9B+iz+6xudmhBCtioUTJ/FoFK5g1xbJQHBdwSHR
         zyPeAbzFXiLfNib3shRC5oN2zABAN5xHPZwXuG2TfRmyahZZLLt41hrsqRrruzRWRdXm
         /+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVmQG/BnjefrlmWorQB9r3Ffp0c1LUY7Di55+dCN439TgaT5LhBu92wZvVJdW/kUkL8BEUw/g1A57BQKtf7bFluRyQ/OwZuaJbegOoe
X-Gm-Message-State: AOJu0Yw8QZAkXWqbE2uCLM3smO9ZKz7NjNDEJPIt31MfdcaI3BpfTvuE
	bDf/8+aOt8RDIvKbXna5vyCNVmHQ45DKg7J8fcNQLPvtbQ8qn2TV+80YYsi+pso=
X-Google-Smtp-Source: AGHT+IFUzfbgxvwH4VOVegrFzzsc8yaS4VxOK7U6G2QebVVyB5Ne/z9N9N1PVfhT9YhUV1ODV6qhMA==
X-Received: by 2002:a05:6808:1156:b0:3d2:243e:e4b7 with SMTP id 5614622812f47-3d5459799bemr4779175b6e.23.1719195348044;
        Sun, 23 Jun 2024 19:15:48 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:1584:936e:5eb0:fab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511b137csm5071770b3a.86.2024.06.23.19.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 19:15:47 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sun, 23 Jun 2024 19:12:34 -0700
Subject: [PATCH v2 4/7] riscv: dts: thead: change TH1520 uart nodes to use
 clock controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-th1520-clk-v2-4-ad8d6432d9fb@tenstorrent.com>
References: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
In-Reply-To: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719195343; l=4110;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=auGSbMjsRld4SLXQydJm42vMc+m34WENWJOd8P1SjjI=;
 b=3eVam+1jlNyHHZSlI8nSDB4WHMB+sYoN7SK+tbRvC/FEfFfUGRXFLTp1g/HkUJ3oBhXKOc/78
 K0J5eZxyEIoB264vRv0lqXTXewTuxOqn9JjwBYHq0ewVxivrvf5Q8yK
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Change the clock property in TH1520 uart nodes to a clock provided by
AP_SUBSYS clock controller.

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  4 ----
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |  4 ----
 arch/riscv/boot/dts/thead/th1520.dtsi              | 24 +++++++++++-----------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index d9b4de9e4757..164afd18b56c 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -52,10 +52,6 @@ &sdhci_clk {
 	clock-frequency = <198000000>;
 };
 
-&uart_sclk {
-	clock-frequency = <100000000>;
-};
-
 &dmac0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index 1365d3a512a3..1b7ede570994 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -33,10 +33,6 @@ &sdhci_clk {
 	clock-frequency = <198000000>;
 };
 
-&uart_sclk {
-	clock-frequency = <100000000>;
-};
-
 &dmac0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 10a38ed55658..66df04ceb3e4 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -141,12 +141,6 @@ apb_clk: apb-clk-clock {
 		#clock-cells = <0>;
 	};
 
-	uart_sclk: uart-sclk-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "uart_sclk";
-		#clock-cells = <0>;
-	};
-
 	sdhci_clk: sdhci-clock {
 		compatible = "fixed-clock";
 		clock-frequency = <198000000>;
@@ -195,7 +189,8 @@ uart0: serial@ffe7014000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xe7014000 0x0 0x100>;
 			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_sclk>;
+			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART0_PCLK>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -232,7 +227,8 @@ uart1: serial@ffe7f00000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xe7f00000 0x0 0x100>;
 			interrupts = <37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_sclk>;
+			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART1_PCLK>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -242,7 +238,8 @@ uart3: serial@ffe7f04000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xe7f04000 0x0 0x100>;
 			interrupts = <39 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_sclk>;
+			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART3_PCLK>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -324,7 +321,8 @@ uart2: serial@ffec010000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xec010000 0x0 0x4000>;
 			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_sclk>;
+			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART2_PCLK>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -386,7 +384,8 @@ uart4: serial@fff7f08000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xf7f08000 0x0 0x4000>;
 			interrupts = <40 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_sclk>;
+			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART4_PCLK>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";
@@ -396,7 +395,8 @@ uart5: serial@fff7f0c000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xf7f0c000 0x0 0x4000>;
 			interrupts = <41 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&uart_sclk>;
+			clocks = <&clk CLK_UART_SCLK>, <&clk CLK_UART5_PCLK>;
+			clock-names = "baudclk", "apb_pclk";
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			status = "disabled";

-- 
2.34.1


