Return-Path: <linux-kernel+bounces-228811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47830916756
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADF41C248A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA616D4CA;
	Tue, 25 Jun 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MPdjVFL8"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85516D303
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317683; cv=none; b=PKsMcEpF6JTA5pR32gAkPktsGHYpa9FFiJxx13WD69KlEtXNGWHvf12gLADmgxEWWZ03a4IROMMd+yLpQOdfZl+z/XyYFD/rFa0s9DF8uK35AMdfRAOP7eslDbPswrsp6fjAW8TsKqKXcUcmTV2sjEwcKTIQPAjTfGeKe8VlQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317683; c=relaxed/simple;
	bh=lsfBNFQ9DmRpBMeKzNXKtURy1leztUKXyhzbvbyq2bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fqjbNJepVrzDq/dyRSJSOjcz9/vlhaPSBqJzvc5goVzp4BAipjsNaxGt8wS/D7Tc6tFtFzAZmniPU8mcM02quPcyCKHOjjqVWSUwwdF/HgXfNi9P415x1QWccabfVtnGHucx4fUfkPKYz8I7LT/0EQfq0qjK1XMxMcKaM9RBcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MPdjVFL8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cdcd26d61so3524114e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1719317680; x=1719922480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGa2XEUZ3aGMxNf/RbkZrRoN3t//RPW1fRR4sB6rLbI=;
        b=MPdjVFL8+GclraT31nyS5OkJ6RgFqAxJj/Jfy+w/4gWIla8KBAxCKwquSi3isW1a53
         RMDdhC4Llyo2aeOT+N0y8yFU/L2SOLaPJqNntZMx36e64Qgw+VMgScU2uz4NmMMmRdE7
         OFlTOd0PRNBODsnEfQx6mtYNwlReBTEmsNMIkR7KVvY97CK1jtIXlgVmdc1EO/ispJUS
         /nGFwranqjM5fYO8wTAuTfSRQfKx6B9yAkX6bAmwC0YqXgs95n7+lp2zwaFHcOSQw5c+
         U7onbKjp/XYMuzcL1ytXZCaYLNthWZCYfV61HuzbTE5zViK9mqreFjRy5UMEdeCU67cy
         53Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719317680; x=1719922480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGa2XEUZ3aGMxNf/RbkZrRoN3t//RPW1fRR4sB6rLbI=;
        b=eVQfaDi8r1FEFlMF94m/JTsZceVKrAfN4Yv/BPpXMr0G5fSXdlq/opfRxHlPNup5I8
         SCGj3gE9Nx6lHIq9FBDt/XyDHfTnpOdc6TU4iYywE4cl8Y5J33Q5J5wv6YQlaWyJPWJd
         Z/oAQgyF/6px20w1qgWZ6Ir8eBpSLqjwW5lRv4JqVdO/qNYPuS4hSI1HIoRX78AH17CP
         LxJQ3dS8i77qB9shFhKEsijwGDbLa6kx4UMsiQk+N/CnKVtUPffnpjjZvJl1mfpmchKD
         P8bfon0qpsRMiVHQSThZTCgW8VYdnvCtTiSYtYbL3RvUPbSfFWK+uOUcwdlp0sAfOajX
         xdfg==
X-Forwarded-Encrypted: i=1; AJvYcCUPrR+9dQBMDZUo+E/UUBjg+al6IF5taHQralgoV9VY9U5DgOjqJgNFqnBXqHd+Rqas0hwhFOP+7Wzvpn+NvKz+o+WaVU7yBNud1AJm
X-Gm-Message-State: AOJu0YxYz74DrG48tsuDUM4McvlSIyvzo18HW1RAvainWtLhmJrqiwGU
	K4MYV86MAobcP8y10Qdg+JWONY52jpILjxZwcx0U3l2PjowACw6koscDyuotnPY=
X-Google-Smtp-Source: AGHT+IG7qwUVXtOpVeWmNHvAVr0+00yi4DiXEY92run2OPUw5io4ErYjJwJWFwRWIN5UafV00vAnuA==
X-Received: by 2002:ac2:5b4c:0:b0:52c:dcd4:8953 with SMTP id 2adb3069b0e04-52ce1839881mr4175573e87.36.1719317680669;
        Tue, 25 Jun 2024 05:14:40 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8b32sm12798437f8f.92.2024.06.25.05.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:14:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	wsa+renesas@sang-engineering.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 10/12] arm64: dts: renesas: r9a08g045: Add I2C nodes
Date: Tue, 25 Jun 2024 15:13:56 +0300
Message-Id: <20240625121358.590547-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240625121358.590547-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S has 4 I2C channels. Add DT nodes for it.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- dropped renesas,riic-no-fast-mode-plus

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 2162c247d6de..387d74a163ee 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -72,6 +72,94 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@10090000 {
+			compatible = "renesas,riic-r9a08g045", "renesas,riic-r9a09g057";
+			reg = <0 0x10090000 0 0x400>;
+			interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 263 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G045_I2C0_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G045_I2C0_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@10090400 {
+			compatible = "renesas,riic-r9a08g045", "renesas,riic-r9a09g057";
+			reg = <0 0x10090400 0 0x400>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 272 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G045_I2C1_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G045_I2C1_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@10090800 {
+			compatible = "renesas,riic-r9a08g045", "renesas,riic-r9a09g057";
+			reg = <0 0x10090800 0 0x400>;
+			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 279 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 280 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G045_I2C2_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G045_I2C2_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@10090c00 {
+			compatible = "renesas,riic-r9a08g045", "renesas,riic-r9a09g057";
+			reg = <0 0x10090c00 0 0x400>;
+			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 287 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 288 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tei", "ri", "ti", "spi", "sti",
+					  "naki", "ali", "tmoi";
+			clocks = <&cpg CPG_MOD R9A08G045_I2C3_PCLK>;
+			clock-frequency = <100000>;
+			resets = <&cpg R9A08G045_I2C3_MRST>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a08g045-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.39.2


