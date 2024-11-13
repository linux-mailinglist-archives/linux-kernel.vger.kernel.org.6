Return-Path: <linux-kernel+bounces-407687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1209C7116
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F281C1F28D66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B16213ECC;
	Wed, 13 Nov 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nZpcV6Yn"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66A20FAA0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504991; cv=none; b=OQsYXfqduWc6lYHqqaBNgwM62uvH/BYx43Dl5dgIXYObWp67nAI9UsmqYa2hdPDW/NieOBdCBL54XhbaAQOtly6JNYbtV49MsjOCVHS73OjCSgnyrdrOfUKEh75QT0MUKqAqU38rQ0j5qeUHKKepffiUVVeTCAObAXKxDIKZqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504991; c=relaxed/simple;
	bh=klKnW6pY9VR3FhQEQZTBaAipu8lgL9Qjmb9S0O/TpTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3hBBCepsPvFYjThbGgbbxS7tDt0QYY5M/iti4OYcfCgZ6TOUqGGWT+GrdsDCeWVvziY7gH1lWRrmYrDk6XcbmHY5AR3BUeadT7vnLQy6ElUxAWapJgPUfCHR1gasDQEV6iphb5/9orRVK1ej4QT3D3oLjDnC+tCVPF6bBwrjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nZpcV6Yn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43152b79d25so58055985e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731504987; x=1732109787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B83X34gMDf64A3uVR3n446BkoMV/V6kVlrm1DB9I7pQ=;
        b=nZpcV6YnciWXOiNhvF53uqK8lKxVPbwKYIl2yP+YT6wNSfWRhoCk+73hu2Yls4vqkn
         DpPU2V3kyHRjbaZ750t7BMSJ7paJKS0leH1ulr+EFE0W1CTuIlGTmlMefPfoi8V2b0ht
         ncRdsScHgoSxK2chpKMnIqMpaeEhitqU1UnxBe3TsZe6vj5BTtoYf2bB8JHLJQ6mzVik
         0v0FhA06UUtQakgbtREcmhLO2hZ0b+YM5VZ3DbstGgrpM+tDe1mZh4CJZNz42fELd7IT
         zl+6ljN1panoueoY6XJ4j44SJlvwcAOtr4Z7oxnvXN1lKraLVGRxQp+8t7ZGx10DBfws
         75Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504987; x=1732109787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B83X34gMDf64A3uVR3n446BkoMV/V6kVlrm1DB9I7pQ=;
        b=Pa8uFUoRd0yaEqH8T/YGklJOUe7lxUvvTnm0PpLOGbhSnaxRaECE0jlpA3XouMNCMu
         1fHj/f+9wALsMLRQVCjTc+q96swvMLcezwofbLFL6yGgwod7TS2rnNBWXokS10Aly2uS
         vG0qUJIviPsFZlf552iD/M5/bWb4P6DLLRGIcDcxE0Ek6nMH75pKQCZscd/rt9k9XFEf
         Re14Qvami8QvG63NjP2NuYJEIBqXnV+yoG1kgMWTwJp/FLEnlWlFQqkiLV97ufbQz2ms
         g9o91q59zgNxrXG6VDq8y8/pYymzk++OzsCUWqCFE2SlT7P0DWF7OEk3d7gsQQmOgBg+
         FWoA==
X-Forwarded-Encrypted: i=1; AJvYcCUTbsZh0hl0ApFxR8g11cZir3rcmnxvBWmpuSnph5fZMNLWUVSaJeqvlWyFEkq9RTUGo6/itiYRQhJ/I9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsLZo0sjMCF1r7tzKKXdgUloYZyIybYmpXyYPtN+R0+spyyqG/
	cboHtsLJ8xJmnNQ1ZcrtbFCG71LOVPuMASWO4ONzU/HnHETJ5Zwi/Fd6cPuTraA=
X-Google-Smtp-Source: AGHT+IFTYauwCX+TC+dM+tJXScGC+NRGKDxfQYhWwC0Yq9o+VfhKItRyTz7escVpGORNAfY3vPX6Rg==
X-Received: by 2002:a05:600c:b95:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-432d4ad3329mr24823125e9.26.1731504987299;
        Wed, 13 Nov 2024 05:36:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e2f2esm25664165e9.1.2024.11.13.05.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 05:36:26 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	magnus.damm@gmail.com,
	linus.walleij@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 21/25] arm64: dts: renesas: r9a08g045: Add SSI nodes
Date: Wed, 13 Nov 2024 15:35:36 +0200
Message-Id: <20241113133540.2005850-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241113133540.2005850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241113133540.2005850-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add DT nodes for the SSI IPs available on the Renesas RZ/G3S SoC. Along
with it external audio clocks were added. Board device tree could use it
and update the frequencies.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index be8a0a768c65..24c6388cd0d5 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -14,6 +14,22 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	audio_clk1: audio-clk1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by boards that provide it. */
+		clock-frequency = <0>;
+		status = "disabled";
+	};
+
+	audio_clk2: audio-clk2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by boards that provide it. */
+		clock-frequency = <0>;
+		status = "disabled";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -187,6 +203,86 @@ i2c3: i2c@10090c00 {
 			status = "disabled";
 		};
 
+		ssi0: ssi@100a8000 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8000 0 0x400>;
+			interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 242 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI0_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI0_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI0_RST_M2_REG>;
+			dmas = <&dmac 0x2665>, <&dmac 0x2666>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi1: ssi@100a8400 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8400 0 0x400>;
+			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 244 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 245 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI1_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI1_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI1_RST_M2_REG>;
+			dmas = <&dmac 0x2669>, <&dmac 0x266a>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi2: ssi@100a8800 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8800 0 0x400>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 248 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI2_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI2_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI2_RST_M2_REG>;
+			dmas = <&dmac 0x266d>, <&dmac 0x266e>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ssi3: ssi@100a8c00 {
+			compatible = "renesas,r9a08g045-ssi",
+				     "renesas,rz-ssi";
+			reg = <0 0x100a8c00 0 0x400>;
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 251 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
+			clocks = <&cpg CPG_MOD R9A08G045_SSI3_PCLK2>,
+				 <&cpg CPG_MOD R9A08G045_SSI3_PCLK_SFR>,
+				 <&audio_clk1>, <&audio_clk2>;
+			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
+			resets = <&cpg R9A08G045_SSI3_RST_M2_REG>;
+			dmas = <&dmac 0x2671>, <&dmac 0x2672>;
+			dma-names = "tx", "rx";
+			power-domains = <&cpg>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a08g045-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.39.2


