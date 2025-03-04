Return-Path: <linux-kernel+bounces-543896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AD1A4DB34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80B51889377
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7CD1FFC6E;
	Tue,  4 Mar 2025 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jB+NySUc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDC1FDA86
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084929; cv=none; b=G7Fq7csz8ZgnZ2K5yVRWonYbF9XLm/ENh1XkWPj5xoG4HQmKoBy6GNY2k99IYgeq5mhMQhk7ou0RV6clVTTbpo4yAnsB7uAxkHuN69ATJBnYQf5LFCXJ7a1uESlpf2dk4k9OQsbf8gDq4e1CetHF9LcveOuo4gXpkXQHc5tJTqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084929; c=relaxed/simple;
	bh=lj+LKYBIbZHMRgSOHlWkhtGfvLPPYNRUo3TcX1HTbxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Edye56t8PCNynnQsKA4yfiOqkjJ2Wwo4E9MeuqpNW2OShPjRaLfSAj6OWgeLYufYINcaYqnmIZKochS0us1pE+tIBTtTDJdB3Ehx7kfnYTnigxckrzKEuNUiWAXtVE/Jn/UaXdyYb1DzxvQKRHUvOfuWnYnMKCcwheMuZX49sFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jB+NySUc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ba8bbeae2so4930795e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741084925; x=1741689725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDxLGGq40mrprdt8U26xMTW1xjWdDPFqwzgumK7bnvA=;
        b=jB+NySUcTT6dUHfnGaqdiGBjze25TFujdi0TPrmY+th5Kkt+YL476VNg55mX6MRTtg
         CpuzeTg33b2YD2vLWBDG4UMpUlGU7lfpeQhkkH7nifTVykKyOybE8dFwm3Twxd1arwbI
         rSkAuEBMi5LBWU3k5GlWutLACDVm2tXANfwL/WAkETP+lR1YcfGCW/or5UD9i6zxkX3P
         4yTZHrZWgEkGjUgDSDmZIKwMzbJ90KSHHZjeHthSDSApiSsjg5EQsZgL9KfnlUMfDZ2s
         +zApmqQYLA+PzYptsPJXfkRRE9NzsFnZIx0sUkC+2BZXFlTjISwiF2iQ6w8HcF8nFgCJ
         WBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084925; x=1741689725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDxLGGq40mrprdt8U26xMTW1xjWdDPFqwzgumK7bnvA=;
        b=rGb30QS4pXH9nOeqUqMMsJKJbfUtmizLR3M5hoxEBf85k5JawHJpgR7Bw/96oZh6yz
         KwJMcQkcq4M1YLWGUwuvR3ihX4CppaTcRZC9X7GE/hNdeM3e9ym+LGfD9fsC4NXphDsF
         feqqDeHP+0gbboTsGuYnq7xTenfQrJtx9fQRrju98CtOrz0yjJ0mpd4i6NFDXssLa2ar
         Tt6gSKjixVZ4NIiInnFfmWm2fjPXQZCoSYv7VYngocojAkCz4+CsN+vMn6jaa7DrFExq
         Z3h4rQgwhrKUO3ZyCk3IMnKpbghmP4cDGR0/3mxp3gG2Uu6PszPlAfm18Auv2w2qtygv
         pcCA==
X-Forwarded-Encrypted: i=1; AJvYcCW/CSFaPKhixNXjODaWd2LHqaWiS8wShQTCs1n5l04/+IWIyymMcLttbPLpCrW/VudWMGGFxpb7ZkH53AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDxD5zq+lQrETPTJORNLSsc2I9cLuwFTOkRg3xrgFNrOhWpOcf
	iWEV4rgkDmIAMsciEBco0tG1utB1PnBeWEDaoYw3IPgFZd6a5FItj787BlpANuk=
X-Gm-Gg: ASbGncu0V4orF/EEnwvqXpsPSJ6edwzKmThkH9xyH5Q73BHQ62OMJc1WTgAeqRHErQJ
	tdffewB8KDrxgXtUjsCkQUX+A5+C+7ORt9sCm7MwJSFVLkRk/wjDL4XNDrluxHEKGcsLNKPOCVt
	b6vutY0tlFhXHoSgHZW31wHp8mSOWFHfhGLpedLqf9MyvDmC+DEY+t0E2PxXXGQB2d8sNuUVT15
	B7wInGO8i5J3S1h4CLIRzWzJFbx3jsJq6kyNX9xGu+lQMp3PyqiKI7pCMEo7BgFa3OjTgBQvKoQ
	NYu0sCOS1wwjexJgR7arhGFW0KLhkw1oKWcxAL/O2fWAy4ZMfyuK0jhpI38=
X-Google-Smtp-Source: AGHT+IEBaeeS+ss4bvkyeewcMs2ci2tWe2j9anwRxAUmA/kmrMhdWw1KWJLeZhb3ucTu5owhQtYxHA==
X-Received: by 2002:a05:600c:3b8e:b0:43b:c228:1ee0 with SMTP id 5b1f17b1804b1-43bc2282147mr23743515e9.7.1741084924557;
        Tue, 04 Mar 2025 02:42:04 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b792asm17202257f8f.53.2025.03.04.02.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:42:04 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: rockchip: Add ES8388 audio codec fallback on RK3588 boards
Date: Tue,  4 Mar 2025 11:42:00 +0100
Message-ID: <20250304104200.76178-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304104200.76178-1-krzysztof.kozlowski@linaro.org>
References: <20250304104200.76178-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devicetree bindings for ES8388 audio codec expect the device to be
marked as compatible with ES8328.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changeset depends on bindings patch being accepted to ASoC:
https://lore.kernel.org/all/20250304103808.75236-1-krzysztof.kozlowski@linaro.org/

Please take it to the same or next merge cycle as above ASoC binding.
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts         | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi      | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts      | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts        | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts   | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index 27a7895595ee..e77a38d726e0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -472,7 +472,7 @@ &i2c7 {
 	status = "okay";
 
 	es8388: audio-codec@11 {
-		compatible = "everest,es8388";
+		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x11>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
index a98e804a0949..81031b99c9b9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5.dtsi
@@ -276,7 +276,7 @@ &i2c7 {
 
 	/* PLDO2 vcca 1.8V, BUCK8 gated by PLDO2 being enabled */
 	es8388: audio-codec@11 {
-		compatible = "everest,es8388";
+		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x11>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
 		AVDD-supply = <&vcc_3v3_s0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index 088cfade6f6f..e07888c9948f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -311,7 +311,7 @@ &i2c7 {
 	status = "okay";
 
 	es8388: audio-codec@11 {
-		compatible = "everest,es8388";
+		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x11>;
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
 		assigned-clock-rates = <12288000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
index bc4077575beb..7c948b2653da 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
@@ -242,7 +242,7 @@ &i2c3 {
 	status = "okay";
 
 	es8388: audio-codec@11 {
-		compatible = "everest,es8388";
+		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x11>;
 		clocks = <&cru I2S0_8CH_MCLKOUT>;
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
index 812bba0aef1a..b79ce3ec1186 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-gameforce-ace.dts
@@ -611,7 +611,7 @@ &i2c7 {
 	status = "okay";
 
 	es8388: audio-codec@11 {
-		compatible = "everest,es8388";
+		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x11>;
 		assigned-clock-rates = <12288000>;
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
index 74a4f03e05e3..73042e7416bc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -412,7 +412,7 @@ &i2c7 {
 	status = "okay";
 
 	es8388: audio-codec@11 {
-		compatible = "everest,es8388";
+		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x11>;
 		assigned-clock-rates = <12288000>;
 		assigned-clocks = <&cru I2S0_8CH_MCLKOUT>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
index 9e16960b8705..a48bcb6b6a91 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
@@ -268,7 +268,7 @@ &i2c6 {
 	status = "okay";
 
 	es8388: audio-codec@10 {
-		compatible = "everest,es8388";
+		compatible = "everest,es8388", "everest,es8328";
 		reg = <0x10>;
 		clocks = <&cru I2S1_8CH_MCLKOUT>;
 		AVDD-supply = <&vcc_3v3_s0>;
-- 
2.43.0


