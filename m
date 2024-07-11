Return-Path: <linux-kernel+bounces-249559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DADEE92ED49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FF91F21F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D29416EBF9;
	Thu, 11 Jul 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="ckve2K7m"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CBC16EB55
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716998; cv=none; b=Gl2MYmpLlSiBZpLkP1Vr20VWsY1TQx5R3iRyo4WTK4p9+cW9oj8P4TkkRabx+T0Zn6lGHiM+hFqQxiYwNVAncR26r9AUMr5QhBR3wpUr2AunmIucH7ZTN5cY3H51eBC0iqnmrZ63GtvehCowt6793r8Yl23nKcrMXD7xzrRh4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716998; c=relaxed/simple;
	bh=SbrKbjP9HrE9knhFbrY+EYErtsxWNVunfI1xMyBiezU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+V7/ZGBFWB0nBhfgHEm3zqWEkeX09e2wsF2zLAeLqBK1IlI2MIwFlBOOM7y8dRITwGUlHRnHzF16ZytQzcKxKabCqtEqNUcQ+TmbO6RUM8wNI1zMxlHspUHsp/gldEu/G2G2nDEYZMq2G5Rhd7eDY7jvvoz2zhUFWaWS5HkM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=ckve2K7m; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-704473c0698so542018a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1720716996; x=1721321796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xP2OaE3Tmwgvn0E4Ola04pPSwphXRoqY7WXxjCPr0EA=;
        b=ckve2K7mbwTK/Xvtywlung2L53JWOvVr3J3Gja9FiV+KEs/N39rlC/lqY6qMyg70lx
         nsPR4Tqs2CBVh10KE+ylJG1OkMsHYnD3cwtvZkCB0pQx6SpdIFuAzfI5qH2dp22ikPBt
         5W2QZryKu3kWdn2aDPHTSdFQgcfCvjHA8D/pmXyM5r1DorunYuRh59B9nQRHipWSlggM
         5XtTmfLzAbTAbqgLK8XCeSIA1Rc1Z62koWMm3qsBBclN+6U352wQdawBywmMjtnloqeS
         /3uPE3vosgka6EUIAHp1SXd8fBBUdGyABGygYqrlNNSC+m71spw1k39rK8Qg4R3vDnAx
         aZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716996; x=1721321796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xP2OaE3Tmwgvn0E4Ola04pPSwphXRoqY7WXxjCPr0EA=;
        b=f6IDSUrRhEIF6FP9MQ3nRg3MQQsGK/T5m9jAbmZy0lGop6xmu7HbBDuAVP5dE5YFgF
         XBpqPKQusfGdlON5QVbbALxE907EslLE+cNTnx3RDJ3NAdOBGPE8qrUr2wqsrNRsWjcv
         q2jijRzZ8l6wqzzVj5uT83c4NVOxjS+/8wVKQyLhHLHKYCZZ639EROyrsMvv5u3IulAI
         7by0HPNGdPxtsPyz6lf4MCfCJZmZo+RGDtePPx46s4Vkw9pQBBfkM/GrNvsSRRFF+UeP
         4lAFVM4MZno9fvNjFBGCTGeDrNwg3zmMkkSxQ+SYBe2X08X/PAWpWl14HG3dnP14tcWz
         eAIw==
X-Forwarded-Encrypted: i=1; AJvYcCXEFJpZ+hS9vz98PMYksLy73fyCd9np2QmAIvkynashMzlU6INObRxXDtZ4Y6j0saTGpzaQnoj+gvx3ep87UEgpr6OdU8fK+eCjD3iV
X-Gm-Message-State: AOJu0Yy+zjSJf5swvQCAYNwYsu0OWTmWQqsI97oGbs/71HWFrg5VylVj
	YIvG7vhO+UshylShqhMWMFBCXbVIFdIENF0vxffUi5qT65mzNYQelagct1IbqFo=
X-Google-Smtp-Source: AGHT+IFpjkCHBHOqJ28iyDK9YRSjs6qFqsZuEPtegvqPUiJkgrWahk2gMval4RPQxaSagii6iKO6gQ==
X-Received: by 2002:a05:6359:b93:b0:1a4:1351:9c9c with SMTP id e5c5f4694b2df-1aade1271camr695279455d.29.1720716995711;
        Thu, 11 Jul 2024 09:56:35 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:5ee9:fea0:d9de:cee8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-787089bc5f6sm1360038a12.92.2024.07.11.09.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:56:35 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Thu, 11 Jul 2024 09:56:24 -0700
Subject: [PATCH v3 6/7] riscv: dts: thead: update TH1520 dma and timer
 nodes to use clock controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-th1520-clk-v3-6-6ff17bb318fb@tenstorrent.com>
References: <20240711-th1520-clk-v3-0-6ff17bb318fb@tenstorrent.com>
In-Reply-To: <20240711-th1520-clk-v3-0-6ff17bb318fb@tenstorrent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720716985; l=4931;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=SbrKbjP9HrE9knhFbrY+EYErtsxWNVunfI1xMyBiezU=;
 b=WDiLeijUC5umVxfBGXR8J6mW5IaQwccj+b6cXnR4L6231y11sre+HIcgSdKtTfvk8kgao1XQ9
 y/Bzm08N9tfCpF+3+z6JAXh8vLKuANz2ymtNrfobAeO5J0C9YkBDhd1
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Change the dma-controller and timer nodes to use the APB clock provided
by the AP_SUBSYS clock controller.

Remove apb_clk reference from BeagleV Ahead and LPI4a dts.

Link: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  4 ----
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |  4 ----
 arch/riscv/boot/dts/thead/th1520.dtsi              | 24 ++++++++--------------
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 55f1ed0cb433..1180e41c7b07 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -44,10 +44,6 @@ &osc_32k {
 	clock-frequency = <32768>;
 };
 
-&apb_clk {
-	clock-frequency = <62500000>;
-};
-
 &dmac0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index 762eceb415f8..78977bdbbe3d 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -25,10 +25,6 @@ &osc_32k {
 	clock-frequency = <32768>;
 };
 
-&apb_clk {
-	clock-frequency = <62500000>;
-};
-
 &dmac0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ce3a0847aa9c..d05002ad7c96 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -135,12 +135,6 @@ osc_32k: 32k-oscillator {
 		#clock-cells = <0>;
 	};
 
-	apb_clk: apb-clk-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "apb_clk";
-		#clock-cells = <0>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -325,7 +319,7 @@ dmac0: dma-controller@ffefc00000 {
 			compatible = "snps,axi-dma-1.01a";
 			reg = <0xff 0xefc00000 0x0 0x1000>;
 			interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb_clk>, <&apb_clk>;
+			clocks = <&clk CLK_PERI_APB_PCLK>, <&clk CLK_PERI_APB_PCLK>;
 			clock-names = "core-clk", "cfgr-clk";
 			#dma-cells = <1>;
 			dma-channels = <4>;
@@ -340,7 +334,7 @@ dmac0: dma-controller@ffefc00000 {
 		timer0: timer@ffefc32000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32000 0x0 0x14>;
-			clocks = <&apb_clk>;
+			clocks = <&clk CLK_PERI_APB_PCLK>;
 			clock-names = "timer";
 			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -349,7 +343,7 @@ timer0: timer@ffefc32000 {
 		timer1: timer@ffefc32014 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32014 0x0 0x14>;
-			clocks = <&apb_clk>;
+			clocks = <&clk CLK_PERI_APB_PCLK>;
 			clock-names = "timer";
 			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -358,7 +352,7 @@ timer1: timer@ffefc32014 {
 		timer2: timer@ffefc32028 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc32028 0x0 0x14>;
-			clocks = <&apb_clk>;
+			clocks = <&clk CLK_PERI_APB_PCLK>;
 			clock-names = "timer";
 			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -367,7 +361,7 @@ timer2: timer@ffefc32028 {
 		timer3: timer@ffefc3203c {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xefc3203c 0x0 0x14>;
-			clocks = <&apb_clk>;
+			clocks = <&clk CLK_PERI_APB_PCLK>;
 			clock-names = "timer";
 			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -398,7 +392,7 @@ uart5: serial@fff7f0c000 {
 		timer4: timer@ffffc33000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xffc33000 0x0 0x14>;
-			clocks = <&apb_clk>;
+			clocks = <&clk CLK_PERI_APB_PCLK>;
 			clock-names = "timer";
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -407,7 +401,7 @@ timer4: timer@ffffc33000 {
 		timer5: timer@ffffc33014 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xffc33014 0x0 0x14>;
-			clocks = <&apb_clk>;
+			clocks = <&clk CLK_PERI_APB_PCLK>;
 			clock-names = "timer";
 			interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -416,7 +410,7 @@ timer5: timer@ffffc33014 {
 		timer6: timer@ffffc33028 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xffc33028 0x0 0x14>;
-			clocks = <&apb_clk>;
+			clocks = <&clk CLK_PERI_APB_PCLK>;
 			clock-names = "timer";
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -425,7 +419,7 @@ timer6: timer@ffffc33028 {
 		timer7: timer@ffffc3303c {
 			compatible = "snps,dw-apb-timer";
 			reg = <0xff 0xffc3303c 0x0 0x14>;
-			clocks = <&apb_clk>;
+			clocks = <&clk CLK_PERI_APB_PCLK>;
 			clock-names = "timer";
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";

-- 
2.34.1


