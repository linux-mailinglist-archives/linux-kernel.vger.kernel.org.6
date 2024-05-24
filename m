Return-Path: <linux-kernel+bounces-188514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5028CE2EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62311F228ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF63B12B158;
	Fri, 24 May 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="voySdkSS"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5812AAC7
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541491; cv=none; b=RI2A4Wgr/nuJlcQ7rPxFHp/V/rGI2NpZzf4TCWzMrbJY3z2QI17hmjoYRg1ChtOPXKvlMoWOPplsC1wEY43FHSMYj/+ITCb+6YP3e2SQx6iBCTBC97KPYFJIMA/WZ1S2T5PrhoVZxTd5Z1RkrEs2192HJtUYuTUV6zLd6jDXzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541491; c=relaxed/simple;
	bh=hIvA39TYPLOif8A8RvknSlSb848U6P/fP6pMmPEKIo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nI3ECRMa//p2u3rALe3vwA6Ynn7CsEtnWlzmFreu3kOAehDuVI8pi9HEREXb2SvdbeaHoWxI/X1OoXGS7WYsBndXgj4oIhoNgTXClZ7oavS1VElOsh6IvWBaAQopM3oC3LIa7HjPj98jHIBuFsdTUDvoOr/aQnqLjX33n4v4Bzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=voySdkSS; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e52181c228so84244031fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716541487; x=1717146287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KPQvvAhw/QNVA2rWSAmQjx+yY2X/Ig4NrPz7gPkeZ8=;
        b=voySdkSSjbvvBIOM77jXndEujoM446FnngAJmGb3og33ig1ZUvDSUkeLErbLXsU8oH
         sP9qRy2qsbknMcOD9eZ5hI/hAFTiaO8IorjUqqI0cm7tcTyfRTopaW8LgqGpUMS/s9DZ
         qp5+6XcBoF8X0xap58woLEGuED8WM0MnUxKQs8G7qM4WwsGmnhsW3rboN/snYsIkggTP
         KHq0G9r4we/NyOqEu3hYfrYJe+Qa6AK/7Bq7W+gI/UM3dbnNAm0P0XGGl1lTlnKSEx6u
         by1EmHChpFryDRCkMBioT3giIH/FiWf7Flms88pSRrYdC2z/ODZFXqjJcwxM1EyW4Prh
         acgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541487; x=1717146287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KPQvvAhw/QNVA2rWSAmQjx+yY2X/Ig4NrPz7gPkeZ8=;
        b=bCs3QIa7F5/52ThkS0gmB1r9i59F02rN/JJgvPbP+lXLnOr3kU2kk0Q9xaWE9PkW6Y
         EhMFuG5s42O4MooNYemWYI8Z17r4GX0o1SoKAYjBn55/2foSc1fS4aR7gjubJgEu6m9m
         K/KhbK0TbxmoA3BmHC2imgJH+gYGxgXj9yAkEWrUiYJ/EvkwT0wKmtYkmWspgSer84+Y
         8Vwn1B2DOqUi6MCJIxbp9ASYdI9jzQ4bLxsX5AdFXWzPyjd9Y8CTFe9lGcI+bVnmrTBT
         +/4+TChnlDlwf8ZHhKJHIF9NwkXLs1fAOL7GoAefVfezlJatHeXJ8BeNbtd4V8B/fDBd
         7UcA==
X-Forwarded-Encrypted: i=1; AJvYcCW4MwYAcRWnSMwwfM3k/UxS0wRqoMWj+qfXtu2udn8uH/XPDaNvnH6yMTQ89AJsbNCN7KxyLHRS6bbxJ5lWS4jCX5ccO2h+2gqpj/AX
X-Gm-Message-State: AOJu0YyNM1ExcS89GPhCGKodQbAD72hPfIQLPTkQL7J7PXpyD2ve6X0g
	RaK18xyhZkUcDEy6/YC+QtFiGZrL5WWH9WAVNi55247EK0qW8+PLWXcC0GDYbdo=
X-Google-Smtp-Source: AGHT+IG4ZPvP3zyMcIIsqJRNHq2zKeq8gVeaCSSEPAEcrdFwonBn4Mlo37q4NLlAbVPyD1pqqDJuSw==
X-Received: by 2002:a2e:9c8f:0:b0:2e6:f59e:226f with SMTP id 38308e7fff4ca-2e95b0bce90mr9581401fa.5.1716541487399;
        Fri, 24 May 2024 02:04:47 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f163a8sm47273045e9.13.2024.05.24.02.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:04:46 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Fri, 24 May 2024 11:04:36 +0200
Subject: [PATCH v5 3/6] arm64: dts: mediatek: mt8186: add lvts definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-mtk-thermal-mt818x-dtsi-v5-3-56f8579820e7@baylibre.com>
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
In-Reply-To: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-pm@vger.kernel.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541478; l=1717;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=ZXPmUPXXFa1JCVfBMk9FrptEjzZlcdWN0z1cSMSnOwA=;
 b=DnxRTjxW9wcR2LDOBi5XDgQoQhBL6Qg8MGh6B91uPvtLP04Jw+un7gLHna5Fd+Gap9ino5nx7
 0fkow0NZ0Q1B2HcwWjk8f3uOiSg6Yj45Xh3lrEEqW62m2BKow3pSlc7
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


