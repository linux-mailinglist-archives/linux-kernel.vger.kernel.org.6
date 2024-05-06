Return-Path: <linux-kernel+bounces-170098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A968BD1D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 489B5B22038
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2695156640;
	Mon,  6 May 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj1uiXIR"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F7155A27;
	Mon,  6 May 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010678; cv=none; b=Hp2WzzDHJy6wUUDpJTRm89GHusYD67Y/xw2c79ZCw09sb5xJIf0/xvSEhZr41rZtuaTUFbfe37Fxy5NpTdo8+5cwxbclZYsCRMj0ux1j/5UMVuQss25vSJ+xvL3JZPpARKQrTU1XrfIPqbQ/doPdRFCQh77gcrtjejVXvttFs5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010678; c=relaxed/simple;
	bh=RevPtx03YmQ4ojv4DAFVID03tKsCKqI8IgeaIHhY58I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jmh9BNPdk9qM7nY2+BiKMlFdU3GuRcdHROn8QpnncreRkPP5L1av5SHAxDJJT3iT1Gh4T64/LjRln9tMdA6U7JFpifHxcooAt8Cw/ngVXLbPMXZ8S8XNKGAJEdSVOOX9vamE+GdIfAq7wj63Y6qLqvVjsulJrKr0mBusr4Zma9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj1uiXIR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5200afe39eso535258666b.1;
        Mon, 06 May 2024 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715010675; x=1715615475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I21WtsUZcdgpZuf38No+IlnE5W2vGDappaz3+ciLm0=;
        b=nj1uiXIRUcv5sWAWSLW8aNZPHAiCqrER8XS6wuyPc8XmKpD37bn5Psg7PYFYk/fEBt
         RY0dhS2exZ4Hbtwovpdprd3dwE3CwVpcYOf1IBOmPH8TEuDw5LPIzk+EK9rnAUjoa1ME
         uo99xOZl9JfPJugF1fK/NYPZOJwDLZRKM8Q+gPS+Q5w5R3l5sNgSz+d8621cKKVkepmX
         4mk+o5jC4C9G9kUsC8Y7fNjLYu9oKOB67Oyh95ZAglW4WcP8tyPYYGVDS9T/FkTp/X3F
         NR+lRKj6OwAnXT54Xy7d9RGgAREbUUije2qYi4In5tcqioPy/iNoGWGX3b3qW/U2xFTA
         5ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010675; x=1715615475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8I21WtsUZcdgpZuf38No+IlnE5W2vGDappaz3+ciLm0=;
        b=ua+hMwJxKTvl+CwZVOcPruBRoNPzwcdkiH2zqzxg5kwKlYik7hZyb1ApnL+xW0WPWe
         HU7NzcF+nTxZRBEhQfL6lrTxD3fF/Q7/pB8kKX6JFXxCTLRbeDWGjNxD7IGnVj+fFMJA
         fzlRC1JRM2J4RX/utpDjk99rwiXJo4Sd8nrQaonLKap/h0uIutOqhYnCfl2NJlyGufgd
         lytmHKBbSRVJ5XptBIdSTuJE8f1vgtyRw5cdL1rKg/9Ha5ab90pqQI+4IY3sQOjqFo9y
         UC4wGtjJDsJmkVhS28vUrmyshTAc+VI3QPG1YdubPW5nlAHnTzscwNMlplTZr5op4QdJ
         DvaA==
X-Forwarded-Encrypted: i=1; AJvYcCXDPO3FmCL+r4QOPCjxS2dRJMBbRvNDWVKC5ZqS4L3Po96/HBUcwRxBwtc67DMYSMPL/OT94okVMrUqKgr2aCCPDz70XKL8IhwL7HNg
X-Gm-Message-State: AOJu0YxpPaxeoeKPV5wgirzjYp/U/fhim57DRoJJlQStUJGn1fmxwBsG
	in1ylxBlKRyVRSxiYB57j828w5Mif3AT4NkvqXL3PZSUw8qBSVOAAQr0
X-Google-Smtp-Source: AGHT+IGUXcRYajK3MdV54mEIKa/3JOK3wciOaMvhxvgKosMw2KgO/7txS4O4aJlUGlkK5fzdsMOW2Q==
X-Received: by 2002:a17:907:7e97:b0:a59:b1cf:fea0 with SMTP id qb23-20020a1709077e9700b00a59b1cffea0mr6357081ejc.19.1715010674674;
        Mon, 06 May 2024 08:51:14 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:1c62:e77:6753:5729])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906071800b00a59cec38bf3sm1356230ejb.52.2024.05.06.08.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:51:14 -0700 (PDT)
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
Subject: [PATCH 2/2] ARM: dts: rockchip: Add spdif node for RK3128
Date: Mon,  6 May 2024 17:51:03 +0200
Message-ID: <20240506155103.206592-3-knaerzche@gmail.com>
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

The SoC has a S/PDIF TX controller which is fully compatible with older
generation Rockchip SoCs.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index d0d1d7c2ab2f..bf6e05503141 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -372,6 +372,20 @@ i2s_8ch: i2s@10200000 {
 		status = "disabled";
 	};
 
+	spdif: spdif@10204000 {
+		compatible = "rockchip,rk3128-spdif", "rockchip,rk3066-spdif";
+		reg = <0x10204000 0x1000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF>;
+		clock-names = "mclk", "hclk";
+		dmas = <&pdma 13>;
+		dma-names = "tx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spdif_tx>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	sdmmc: mmc@10214000 {
 		compatible = "rockchip,rk3128-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x10214000 0x4000>;
-- 
2.43.2


