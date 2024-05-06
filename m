Return-Path: <linux-kernel+bounces-170097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7CA8BD1D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAA81C20E87
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B29155A39;
	Mon,  6 May 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je99TRQE"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931D15574C;
	Mon,  6 May 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010677; cv=none; b=jdDqXsOXUpPxvI37y9rBTYzRthvrhKF74lMJ43id6k4+Bsf1Iomv64tQooDyG3xSM6F9bjhNdYN4ECI8dzrHplSLrETX8d1rfS2Z5C6qse85sZE5MOMDJCFl5oEiRIYjJc4RKxFVCp5NFXFCcSrkAuJOdq6B5eS9HVa3llxmRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010677; c=relaxed/simple;
	bh=l+qZMYrdurl4avrrEcTL2oFOjsHe/N8umyoH/UJ9VHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3qOuWPAKGKByLgEUeFZhroU4LULJ9AuMiSxsAw0rYqtchw4FkjRoo9QCJYTPsN9nrrn3fSaRMquL/iw3AZ1QOUXvPgrDQjQ3IqINlHc0uETCj1a8DgTv6DW37bxTYMqvFzAihzZ9D4U2/ZbRxXtl2MaEGYxn2UK1oMG+6kGe3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je99TRQE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59b58fe083so264241866b.0;
        Mon, 06 May 2024 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715010674; x=1715615474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6WL+utsI5ALbgqCnqncesAytLi3m+WaTzt+MUlSYpc=;
        b=je99TRQEtysOadM8bb1VWWl2IyM82HBV7/GdMCk1AYKY03+IdWuSDTckxCAU6Q1hj4
         eHHSyvlJ3Egi7S1gZmhDvdyf3VY4pGIBAljzpFv2/Q5rSFlXGd+68NvUMCzRTgCYc8Ld
         0WKBaekicy2ivgCFuG/xgAALXzCZN1CNwNjeZYfCbdrK/kYvEn3OWoK85JLaN6nUujEa
         noBjG1M18H0QDu2Ty2yIAlYpHm+C4bUyJoPWxUAyzOgItGR3H6Fmk7VIm3EMYH5pS26x
         ej1KWTVAkZANy5UHyzs6CBdYHO66lvWhHf+upMv7iSZMdgIKD+7SIVxrqX2D2m4VtszR
         rdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010674; x=1715615474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6WL+utsI5ALbgqCnqncesAytLi3m+WaTzt+MUlSYpc=;
        b=gm35BpXuCU3IuvxDNqo9bOqPLILaI52Q0aEOCkiGJPFWgwSaukmQe26r0EV5dE7aLW
         5zH81q6UDWNXr0BmfOckvQMh9Lls9HbGpo13MJ/7fwI2UdWnAUrfY0r94wGolF15mhi+
         /mOKQdwhGuGMwzNU+9d8s8mJjMA6RkQeoBGznhFUhVx7hLQ7/qbV6R4em+m0Kmn3BwaL
         W/Prtxtq7WxsTDXpHMID+V14X2stXD5Q/Wlkh5HEIPtWc40E2zc4R4EpMGB2DXDjcm+7
         QcWWv4InlnaQB9UA9XSPglwt/XQVAfNFHi+gyniOynErVC2JTxLa1DRIDKhzoPYXLYJL
         zm/w==
X-Forwarded-Encrypted: i=1; AJvYcCVAsIaXlT6YfPCnTBBqAnKykbPayDdrdhZn2v7M/7pEG5egxwi9cePRDAvowsITg63DUPLUosmagEnlbwwriOOUaZT3GqFN0v5iKluX
X-Gm-Message-State: AOJu0YxZEdw1N0M7WRQYvbKhkLXVlcViq37eaNhO2Lowog7OV8rHs6eb
	H1yHZS/eJ7h9kMbOYrmyMEsXFAzuUcLh/752JtCnWQOVOfI3vWU=
X-Google-Smtp-Source: AGHT+IHhmPeJC0I0evCo/zPiqGgGGWlw4mGMDbzXZO590N8dUNiAb2cYXbXPNJmb8x7X0qmUdBjj5g==
X-Received: by 2002:a17:906:787:b0:a59:9e01:e784 with SMTP id l7-20020a170906078700b00a599e01e784mr4665005ejc.5.1715010673882;
        Mon, 06 May 2024 08:51:13 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906071800b00a59cec38bf3sm1356230ejb.52.2024.05.06.08.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:51:13 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 1/2] ARM: dts: rockchip: Add i2s nodes for RK3128
Date: Mon,  6 May 2024 17:51:02 +0200
Message-ID: <20240506155103.206592-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506155103.206592-1-knaerzche@gmail.com>
References: <20240506155103.206592-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3128 SoCs have two i2s controllers. i2s_8ch has 8 tx and 2 rx channels
and is internally hard-wired to the hdmi-controller respectivly the SoC's
analog codec. i2s_2ch has 2 tx and 2 rx channels and can also be used
externally as it's pins are exposed though pinctrl.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index fb98873fd94e..d0d1d7c2ab2f 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -360,6 +360,18 @@ usb_host_ohci: usb@101e0000 {
 		status = "disabled";
 	};
 
+	i2s_8ch: i2s@10200000 {
+		compatible = "rockchip,rk3128-i2s", "rockchip,rk3066-i2s";
+		reg = <0x10200000 0x1000>;
+		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_I2S0>, <&cru HCLK_I2S_8CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		dmas = <&pdma 14>, <&pdma 15>;
+		dma-names = "tx", "rx";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	sdmmc: mmc@10214000 {
 		compatible = "rockchip,rk3128-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x10214000 0x4000>;
@@ -408,6 +420,21 @@ emmc: mmc@1021c000 {
 		status = "disabled";
 	};
 
+	i2s_2ch: i2s@10220000 {
+		compatible = "rockchip,rk3128-i2s", "rockchip,rk3066-i2s";
+		reg = <0x10220000 0x1000>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_I2S1>, <&cru HCLK_I2S_2CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		dmas = <&pdma 0>, <&pdma 1>;
+		dma-names = "tx", "rx";
+		rockchip,playback-channels = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s_bus>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	nfc: nand-controller@10500000 {
 		compatible = "rockchip,rk3128-nfc", "rockchip,rk2928-nfc";
 		reg = <0x10500000 0x4000>;
-- 
2.43.2


