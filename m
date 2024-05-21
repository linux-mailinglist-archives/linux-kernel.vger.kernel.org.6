Return-Path: <linux-kernel+bounces-185059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DFF8CAFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7233B2484F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDBB7F7C6;
	Tue, 21 May 2024 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iQhDJkMO"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60377112
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300353; cv=none; b=LVqmFlmtM2MqvBWGqJ33B+TEe8NegnY3OZIzlzqGXEavWO9BKKJhS5M7YSZNBhtTf6QClnVTlw2Gf/GamtLF8nV4LJoJr76KTLonmDriEXJ2g/6rN/ZcDePBWZtMRIQjTfmAUUe/WoGcnyCF0tf8oWxL1+Wr8wr/5o7Hkhr3d8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300353; c=relaxed/simple;
	bh=hIvA39TYPLOif8A8RvknSlSb848U6P/fP6pMmPEKIo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cc3uaO3FJGZCY20eajERhky8rwuL7XDyLDDFITRBnJNUthFPZZtH3B6qjmaF3DPQefmkZUfFaJGNbCeuo1dGnUf2gOBMKRLnqwLdOYPb5Qc+z+n6q7WZlvkJmtzE0ZgvD45m2fCFDL874oF2tyf4FshPTVwMMtE71CLiTZwpvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iQhDJkMO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4200ee78f35so23426325e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716300349; x=1716905149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KPQvvAhw/QNVA2rWSAmQjx+yY2X/Ig4NrPz7gPkeZ8=;
        b=iQhDJkMOk25DJ8MJX3KofUYOhrZ9SyNT7an67JaGtoJr2sU+sXdgShEnJI+0vggz8K
         podEJoz7jBRRA/qLIxAK3IG6Go1oi/bzRO2qSVmJgM5CO2bZy4QeLPQlQ4Us01aEUVOP
         zrvjLqyK3q2e6IYcU0kVYxx1Hm5NNchLZsuJ2wgrsDviyMIYv53hIWqaLvCdtSHGQMA9
         84BaGdF3zrKgAKuXSVApFRPS0q29zUz1UMTg/oFtZdnGyynVngHzNgRbCaLpmGDppyaM
         0S3Lj8C8dx05ErUb0hVItbHAGDg9EClwtrKgM9DLuA6R+C27QBgXjuT1VzhP5UxwH/bB
         8VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300349; x=1716905149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KPQvvAhw/QNVA2rWSAmQjx+yY2X/Ig4NrPz7gPkeZ8=;
        b=bhjI0KhWrJvrnS9qpN/TL/olupAYqotTUjbUAzslj0/vPA+fCeZzwRqQLcu95k32Ra
         481CicN+RbvK+pUu2dBvZ8fQnleytQDY+4NEuPEZJdA+9zNORQ5++39Tm0wmUVzAF69W
         IFWOVxEq6v42Xd7CE3wQ/B4rt7Z9sGXaRaYpFJrQ08KSD2lL/Qy94d4R9bum8H3afU72
         ca6cIrehJirjXPYQ9nfgR/Jo13k2Zr5kMVxcESxh8X/JOIzsmBbiXdXaRjdQ3st3Twi/
         mq9FprCfWGW/G+CeC2Qfz+ogew/rIS7ZLkOl1gpSRgfU+lr/FjaGZ0zM3oiy3eAsmuFG
         NRCg==
X-Forwarded-Encrypted: i=1; AJvYcCVgzhwxrR194fdOdM6KCwZaa5gyO+dQiP5sMD195ZszZuWV3TnliXfMMpzd2g4aQ03Q1Wt1ic0IT0risnwapS58qTHMgVkP0yTrnYAr
X-Gm-Message-State: AOJu0Yypr7E0ap85s/39yoqIpDFqY/4jWiuXl55EPCr40o0L70BlT6xI
	t29gayKZS5QDpPPqR0wSW8xnlt24MsiNPl/cHrRkvy77Yq9f0uD3PO7T4xmni30JKPLSzEmPjLx
	Q
X-Google-Smtp-Source: AGHT+IEa++vEX6S0j4Qn/W6RWxeUoiqgzZ7i5R9ToZMW8f9WDpRB2jx7hqSqjlNUMUX/xfHdMq+oGA==
X-Received: by 2002:a7b:ce0e:0:b0:41f:bcd7:303f with SMTP id 5b1f17b1804b1-41feaa38a8emr336486565e9.16.1716300349354;
        Tue, 21 May 2024 07:05:49 -0700 (PDT)
Received: from [127.0.1.1] (abordeaux-651-1-78-161.w90-5.abo.wanadoo.fr. [90.5.97.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42015deac1asm342085945e9.17.2024.05.21.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:05:48 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Tue, 21 May 2024 16:05:35 +0200
Subject: [PATCH v4 1/4] arm64: dts: mediatek: mt8186: add lvts definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-mtk-thermal-mt818x-dtsi-v4-1-b91ee678411c@baylibre.com>
References: <20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com>
In-Reply-To: <20240521-mtk-thermal-mt818x-dtsi-v4-0-b91ee678411c@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716300346; l=1717;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=ZXPmUPXXFa1JCVfBMk9FrptEjzZlcdWN0z1cSMSnOwA=;
 b=rHnbnAL2mPLXp0uO4yIwYFoqu+Y2g1UyXC2LBLUx32VUK6RlUWIUCjZvwl1P1UCGxTrtDtI6J
 XYPKEf3F01NA7jUuR/3F2HrthlbW2N+RFTutwMV4M5HM++ukraBP8m1
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

From: Nicolas Pitre <npitre@baylibre.com>

Values extracted from vendor source tree.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Link: https://lore.kernel.org/r/20240402032729.2736685-8-nico@fluxnic.net
[Angelo: Fixed validation and quality issues]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 4763ed5dc86c..caec83f5eece 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1361,6 +1361,17 @@ spi0: spi@1100a000 {
 			status = "disabled";
 		};
 
+		lvts: thermal-sensor@1100b000 {
+			compatible = "mediatek,mt8186-lvts";
+			reg = <0 0x1100b000 0 0x1000>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
+			resets = <&infracfg_ao MT8186_INFRA_THERMAL_CTRL_RST>;
+			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
+			nvmem-cell-names = "lvts-calib-data-1", "lvts-calib-data-2";
+			#thermal-sensor-cells = <1>;
+		};
+
 		pwm0: pwm@1100e000 {
 			compatible = "mediatek,mt8186-disp-pwm", "mediatek,mt8183-disp-pwm";
 			reg = <0 0x1100e000 0 0x1000>;
@@ -1676,6 +1687,14 @@ efuse: efuse@11cb0000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
+			lvts_efuse_data1: lvts1-calib@1cc {
+				reg = <0x1cc 0x14>;
+			};
+
+			lvts_efuse_data2: lvts2-calib@2f8 {
+				reg = <0x2f8 0x14>;
+			};
+
 			gpu_speedbin: gpu-speedbin@59c {
 				reg = <0x59c 0x4>;
 				bits = <0 3>;

-- 
2.37.3


