Return-Path: <linux-kernel+bounces-203873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7233D8FE186
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03E81F223E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F98F144D02;
	Thu,  6 Jun 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/UmiHiC"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8613CA93
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663704; cv=none; b=rZ+NRs/hGeNTjtUU7ZrhIFieYkvdtvJkIhQhbPi9pdVUrozi/wEZX47r5iiShAWEnZgavTpgV5dgyklSM02w1hpVk9IHx8QYiaUTGd9X6jAu7AyJs0RbC+1jddx9I9CgjnKwEScDI7Jje/T3tNiNFcdbXQGzZ3Y5wr4tDFIQkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663704; c=relaxed/simple;
	bh=0TohGnuQeBHNDJwQSEZKdG+a4qamZCrJvgFKppueMTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIoblBrx5jT8lKVdkKx4pyfAUi6RvbxDyR+i+vkf5IsVoEngZVaiH0Kk2wO2U7uVCsTBYMxxt1Bcx06Wf7QoXPvq4QiUTm+BrwzXJiEyF00lO1KX23myLfqodVpOZiMxQRFw5rd/L3uIFWC45NsjwDXEOk1sli/TfUUDGCHhqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/UmiHiC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b8d483a08so870020e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717663699; x=1718268499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAnDJiP7cTVeCPXJfvrA1fpwOyQJAjUS/6zRfn4q49o=;
        b=Z/UmiHiCq9cNfuDpdUuMDCAs9+6SQeXCcbUMPIEPzsUFt0x82v+ZoOpV/o47WJEdfC
         8fTtNsBq/lQd1RgzUhKs7EnUqY5+xfvEXMp6nauO5K7Z6RjyMZ0YfheR2fsM/MU9aMBa
         CHKlEHkGU18GjSEdPbvnsq9/54bwfBCHivST+Dlcbk5YKL6Tp0Jfoxotbe8q1keSqtkk
         hk8hMoq77wLxmvDeQA80uO7KbQaV1tVi0NNAb+tPd7UJuN7j30OYtY60ydhxnnZBQbBy
         E7drQhhhgs1x96Vl4JoDrPtDEj7zEF1l/1YgsY3Uegz70ey32cPyn2aD4UjiTF6lnLf2
         ml6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663699; x=1718268499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAnDJiP7cTVeCPXJfvrA1fpwOyQJAjUS/6zRfn4q49o=;
        b=uKADjcHsbZ/ZdixGQDZ/jLgA2MhXO0FraaROEIpaMmhOaIUNagavxBTq0KWo+/Os/G
         volc8GCs600wOV3qmfRWuTOlO9zk7cCzklTjsPh866fPyRsxN7713awqaYaqPZ6+Eg7e
         lc48OANSxApZi4UPiItR7T1S1hYq6EqZW0cIsNG/G8pr+HG6mQ0lXxNFDNmps1tNVkT3
         k+IDHobtwQjtQGqsTVaCUWWTcg9lSQAkzMfIxbtNxQnmwLk6ZadIaLSCzThTucN/OPuq
         h0lDyqHUxuBza6PiNJIjFRsiyRtpjfEAx/tGeRMD996oLE3xfKtiHjEOuLae1rOW3r7x
         hEew==
X-Forwarded-Encrypted: i=1; AJvYcCXO509QS2GcOd32yeJo6ght9btp+gXnYzkR8hbXMK2g3Xw3d3lnZBkFfViQbJASbbyuE2Q4Oa/HQ4GtvMcjhgFr8cmcQnCAJu1EIrEl
X-Gm-Message-State: AOJu0YxznjwruxL3jW1ZqKkEYnQdebS/L3lChs0bGWPhEdEXbYT4N8bh
	SPAgwz86NvFIt2IVlIHe8L9eRHS765r8EnFWiQu/1r4YmitnBrA+1/55N21mSUXPlQs/23ZbB+H
	s
X-Google-Smtp-Source: AGHT+IFRdLts4Tbq85Qu00ekuZ3qTqx8v4ZNG1T6UCMGiruAFL1iJTMynZkOqCsvxFMkpK+HvrQUcQ==
X-Received: by 2002:a05:6512:1598:b0:52b:ad6e:87ac with SMTP id 2adb3069b0e04-52bad6e8912mr2863100e87.41.1717663698626;
        Thu, 06 Jun 2024 01:48:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c690dsm14227445e9.34.2024.06.06.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:48:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 10:48:10 +0200
Subject: [PATCH 03/12] arm64: dts: amlogic: move assigned-clocks* from
 sound to clkc_audio node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-3-62e812729541@linaro.org>
References: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
In-Reply-To: <20240606-topic-amlogic-upstream-bindings-fixes-dts-v1-0-62e812729541@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=55250;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=0TohGnuQeBHNDJwQSEZKdG+a4qamZCrJvgFKppueMTc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYXfL0V08Uu3pLm2cryN0HUB3gT2wLUfJrAjuuPgM
 k4MPVtyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmF3ywAKCRB33NvayMhJ0WP0D/
 99y1E9Acq0tGA2CVzCjQgX4SWbAZKDhiyMFSOyMpTCVmNuBfSts7dHN5lozt4IPTfdxrV5/IY/3LdN
 W8qRdXc+Tc9xSqFbfAuGRhhSAp2VnUxn/PA0ltHZhjOm6k5VHZkhd3v24pgNl5leFefHGi1s3gBAe+
 bV7ZtYRnaPEfq68pRF+Alazw8jF2m295RWJ4uZFuDKPcAXN9Fw47Te1yRqWQJtTPoNe98fcmSUTEAs
 7u96cC8MOhcW6S6yS9c1ohCoFllXv8UXuAz2M0ptNFVx0JhcCdZZKejkCx/E0TQtm/jXWyg5aNf1Ry
 HiEjlqP78dTfLESYkrleUHexjMavuTeyFhD0usUR3X7PzvoTkAIFFuJsl3RvNUlyN939wLk7zA1WGm
 I8+1lKACIyMaYjTqzJi8RqeWsXXtJNdt5mB54Ftp3b1rSn1vptX0GN/fLr5Y7gWpObtWhL6udWr0nr
 qm8WdmxHM4LlV1QWADO3uTUOYHjklFzU5Q/5dlICxS/WSPJBWifitMALgk5HdOz5mqvxAZBewtwB8Q
 3a1XZCdyNBSiBw8VNJw/OhjkoCNQBXAmdhSRMKbSROmVIlvMZLakTC4EQn+zshD9L03D7MoHwvT3WO
 S6jiz9sDp0ZYnz4GQYkvcs965elF19Wq6Cny3LVmOuFQy57A+qmd+NE3xcRA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The assigne-clocks* properties should be used in nodes depending or sharing
those clocks, so move tose properties from the sound node to either:
- clkc on GX* SoCs
- clkc_audio on AXG/G12*/SM1 SoCs

This fixes all the following errors:
sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-sound-card.yaml#
sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/amlogic,gx-sound-card.yaml#
sound: 'anyOf' conditional failed, one must be fixed:
	'clocks' is a required property
	'#clock-cells' is a required property
	from schema $id: http://devicetree.org/schemas/clock/clock.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts         | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts      | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts  | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts      | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts        | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts     | 16 ++++++++--------
 .../boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts | 18 ++++++++++--------
 .../amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts    | 18 ++++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi   | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts    | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts  | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts      | 16 ++++++++--------
 .../boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts    | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi  | 18 ++++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts  | 18 ++++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts   | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi    | 18 +++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts     | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts   | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts    | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts        | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts        | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi   | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts   | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts | 17 ++++++++++-------
 .../boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts  | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts   | 17 ++++++++++-------
 .../boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts    | 17 ++++++++++-------
 .../dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts    | 17 ++++++++++-------
 .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts  | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts   | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts  | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts    | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts     | 17 ++++++++++-------
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi     | 16 ++++++++--------
 .../boot/dts/amlogic/meson-libretech-cottonwood.dtsi   | 16 ++++++++--------
 .../boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts     | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts   | 16 ++++++++--------
 .../boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts     | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts  | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts      | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi      | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts       | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts | 16 ++++++++--------
 arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts      | 16 ++++++++--------
 48 files changed, 435 insertions(+), 363 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 7ed526f45175..b2ff20737914 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -268,13 +268,6 @@ sound {
 				"Speaker1 Right", "SPK1 OUT_D",
 				"Linein AINL", "Linein",
 				"Linein AINR", "Linein";
-		assigned-clocks = <&clkc CLKID_HIFI_PLL>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <589824000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
@@ -354,6 +347,16 @@ wifi32k: wifi32k {
 	};
 };
 
+&clkc_audio {
+	assigned-clocks = <&clkc CLKID_HIFI_PLL>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <589824000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rgmii_y_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts
index af211d8f3952..6b2e4cf52ca9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts
@@ -176,14 +176,6 @@ sound {
 				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
 				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -256,6 +248,14 @@ &cecb_AO {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
index 15b9bc280706..0c1cf498e9de 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
@@ -138,14 +138,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -209,6 +201,14 @@ &cecb_AO {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 61cb8135a392..bb30e087b7e1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -201,14 +201,6 @@ sound {
 				"TODDR_B IN 1", "TDMIN_B OUT",
 				"TODDR_C IN 1", "TDMIN_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -303,6 +295,14 @@ &cecb_AO {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 3da7922d83f1..17c38bb3368c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -239,14 +239,6 @@ sound {
 				"Lineout", "10U2 OUTL",
 				"Lineout", "10U2 OUTR";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -396,6 +388,14 @@ &cecb_AO {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 05c7a1e3f1b7..f7deeac4fe1a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -158,14 +158,6 @@ sound {
 				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
 				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -252,6 +244,14 @@ &cecb_AO {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
index 13d478f9c891..18085a5bf065 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
@@ -70,14 +70,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -120,6 +112,16 @@ &cecb_AO {
 	status = "okay";
 };
 
+&clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts
index 003efed529ba..a53d30692842 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-mnt-reform2.dts
@@ -79,14 +79,6 @@ sound {
 				"LINPUT1", "Mic Jack",
 				"Mic Jack", "MICB";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-					<&clkc CLKID_MPLL0>,
-					<&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -253,6 +245,16 @@ &cecb_AO {
 	status = "okay";
 };
 
+&clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
index 6a346cb86a53..f6615e5c8d92 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
@@ -194,14 +194,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -245,6 +237,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
index bb73e10b5e74..c7cd7894239c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
@@ -48,14 +48,6 @@ sound {
 				"TDMOUT_A IN 2", "FRDDR_C OUT 1",
 				"TDM_A Playback", "TDMOUT_A OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -98,6 +90,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
index 6eeedd54ab91..8257a4e2b0f4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
@@ -49,14 +49,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -99,6 +91,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
index 0da386cabe1a..3dbd42f13fb3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
@@ -37,14 +37,6 @@ sound {
 				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
 				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -110,6 +102,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
index eed2a23047ca..b05d6a5fe15d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
@@ -234,14 +234,6 @@ sound {
 				"Internal Speakers", "Speaker Amplifier OUTL",
 				"Internal Speakers", "Speaker Amplifier OUTR";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -608,6 +600,14 @@ regulator-state-mem {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index d80dd9a3da31..2d341c256d7a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -71,14 +71,6 @@ sound {
 				"Lineout", "U19 OUTL",
 				"Lineout", "U19 OUTR";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -163,6 +155,16 @@ &acodec {
 	status = "okay";
 };
 
+&clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	pinctrl-0 = <&eth_pins>, <&eth_rgmii_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
index e26f3e3258e1..9fed17bec9ea 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
@@ -39,14 +39,6 @@ sound {
 				"TODDR_B IN 6", "TDMIN_LB OUT",
 				"TODDR_C IN 6", "TDMIN_LB OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -97,6 +89,16 @@ codec {
 	};
 };
 
+&clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &eth_phy {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
index 890f5bfebb03..aeb288aaf27a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
@@ -169,14 +169,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -241,6 +233,14 @@ &cecb_AO {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
index 6396f190d703..81ba35e4bd7c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
@@ -32,14 +32,6 @@ sound {
 				"SPDIFOUT_A IN 1", "FRDDR_B OUT 3",
 				"SPDIFOUT_A IN 2", "FRDDR_C OUT 3";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -105,6 +97,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
index efd662a452e8..d7b95d9f8bcd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
@@ -194,13 +194,6 @@ sound {
 				"AU2 INR", "ACODEC LORN",
 				"7J4-14 LEFT", "AU2 OUTL",
 				"7J4-11 RIGHT", "AU2 OUTR";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -254,6 +247,16 @@ &cec_AO {
 	status = "okay";
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 08d6b69ba469..4206bf1baddd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -129,13 +129,7 @@ sound {
 				"AU2 INR", "ACODEC LORN",
 				"Lineout", "AU2 OUTL",
 				"Lineout", "AU2 OUTR";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
+
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
 		};
@@ -203,6 +197,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index f28452b9f00f..1da38008241a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -45,13 +45,6 @@ button-reset {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "KII-PRO";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -95,6 +88,16 @@ &aiu {
 	pinctrl-names = "default";
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rmii_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 1fd2e56e6b08..5c7f78e011f9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -135,13 +135,6 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "NANOPI-K2";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -178,6 +171,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index cca129ce2c58..79d87943b2b6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -142,13 +142,6 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "NEXBOX-A95X";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -178,6 +171,16 @@ &aiu {
 	status = "okay";
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index c431986e6a33..d4e5c960d4cd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -177,13 +177,6 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "ODROID-C2";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -220,6 +213,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rgmii_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 7f94716876d3..d00a579be5d1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -68,13 +68,6 @@ button-menu {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "P200";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -118,6 +111,16 @@ &aiu {
 	pinctrl-names = "default";
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rgmii_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
index 6f81eed83bec..b5bce8b56022 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts
@@ -17,13 +17,6 @@ / {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "P201";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -53,6 +46,16 @@ &aiu {
 	status = "okay";
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rmii_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 255e93a0b36d..87d639c06b3b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -108,13 +108,6 @@ sdio_pwrseq: sdio-pwrseq {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "VEGA-S95";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -165,6 +158,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rgmii_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index af9ea32a2876..0bcca84e85e2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -16,13 +16,6 @@ / {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "WETEK-HUB";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -52,6 +45,16 @@ &aiu {
 	status = "okay";
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ir {
 	linux,rc-map-name = "rc-wetek-hub";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index 376760d86766..72b2937e291f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -48,13 +48,6 @@ button {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "WETEK-PLAY2";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -98,6 +91,16 @@ &aiu {
 	pinctrl-names = "default";
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &i2c_A {
 	status = "okay";
 	pinctrl-0 = <&i2c_a_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
index 90ef9c17d80b..cad577f7c9c6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
@@ -123,13 +123,6 @@ sound {
 				"Speaker", "9J5-2 RIGHT";
 		audio-routing = "9J5-3 LEFT", "ACODEC LOLN",
 				"9J5-2 RIGHT", "ACODEC LORN";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -183,6 +176,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
index 08a4718219b1..a08f3555ac4a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
@@ -128,13 +128,6 @@ sound {
 				"AU2 INR", "ACODEC LORN",
 				"Lineout", "AU2 OUTL",
 				"Lineout", "AU2 OUTR";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -188,6 +181,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index fea65f20523a..9625111b8517 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -67,13 +67,6 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "KHADAS-VIM";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -110,6 +103,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
index 63b20860067c..5c2a2b55506f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
@@ -160,13 +160,6 @@ vcc_1v8: regulator-vcc-1v8 {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "LIBRETECH-CC-V2";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -203,6 +196,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 8b26c9661be1..4f4d1546fa05 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -142,13 +142,6 @@ sound {
 				"AU2 INR", "ACODEC LORN",
 				"Lineout", "AU2 OUTL",
 				"Lineout", "AU2 OUTR";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -202,6 +195,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index 9b4ea6a49398..c8c7d9d2a020 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -50,13 +50,6 @@ sound {
 				"AU2 INR", "ACODEC LORN",
 				"Lineout", "AU2 OUTL",
 				"Lineout", "AU2 OUTR";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
 		};
@@ -109,6 +102,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 07e7c3bedea0..b5e925b212ce 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -150,13 +150,6 @@ wifi32k: wifi32k {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "KHADAS-VIM2";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -193,6 +186,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &cpu_cooling_maps {
 	map0 {
 		cooling-device = <&gpio_fan THERMAL_NO_LIMIT 1>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index ad2dd4ad0a31..73248cc4edde 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -86,13 +86,6 @@ hdmi_connector_in: endpoint {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "NEXBOX-A1";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -143,6 +136,16 @@ &cec_AO {
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &cvbs_vdac_port {
 	cvbs_vdac_out: endpoint {
 		remote-endpoint = <&cvbs_connector_in>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index d05dde8da5c5..a126fb057e0f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -101,13 +101,6 @@ sdio_pwrseq: sdio-pwrseq {
 	sound {
 		compatible = "amlogic,gx-sound-card";
 		model = "RBOX-PRO";
-		assigned-clocks = <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>,
-				  <&clkc CLKID_MPLL2>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
 
 		dai-link-0 {
 			sound-dai = <&aiu AIU_CPU CPU_I2S_FIFO>;
@@ -151,6 +144,16 @@ &aiu {
 	pinctrl-names = "default";
 };
 
+&clkc {
+	assigned-clocks = <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>,
+			  <&clkc CLKID_MPLL2>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+};
+
 &ethmac {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index e78cc9b577a0..028d58702003 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -182,14 +182,6 @@ sound {
 				"TODDR_B IN 0", "TDMIN_A OUT",
 				"TODDR_C IN 0", "TDMIN_A OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -252,6 +244,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
index 082b72703cdf..784b816f7ef8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-libretech-cottonwood.dtsi
@@ -200,14 +200,6 @@ sound {
 				 <&tdmin_a>, <&tdmin_b>, <&tdmin_c>,
 				 <&dioo2133>;
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -353,6 +345,14 @@ &cecb_AO {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
index 9b2eb6e42651..72319430737b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dts
@@ -22,14 +22,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -73,6 +65,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
index 6e34fd80ed71..b42bcfae43b9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dts
@@ -22,14 +22,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -73,6 +65,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
index 586034316ec3..f98953340645 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m2-pro.dts
@@ -22,14 +22,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -69,6 +61,14 @@ codec {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
index f045bf851638..a1dfee63e158 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -57,14 +57,6 @@ sound {
 				"Lineout", "ACODEC LOLP",
 				"Lineout", "ACODEC LORP";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -151,6 +143,14 @@ &acodec {
 
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
index e6e9410d40cb..de7ee1d2d911 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dts
@@ -22,14 +22,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -73,6 +65,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index 951eb8e3f0c0..b3b30041324f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -174,14 +174,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -239,6 +231,14 @@ &cecb_AO {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 3581e14cbf18..27e480873767 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -239,14 +239,6 @@ sound {
 				"TODDR_B IN 1", "TDMIN_B OUT",
 				"TODDR_C IN 1", "TDMIN_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -348,6 +340,14 @@ &cecb_AO {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
index fc9b961133cd..50c4c56f6359 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dts
@@ -22,14 +22,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -73,6 +65,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
index 9ea969255b4f..59269dcd47e0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dts
@@ -22,14 +22,6 @@ sound {
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
 				"TDM_B Playback", "TDMOUT_B OUT";
 
-		assigned-clocks = <&clkc CLKID_MPLL2>,
-				  <&clkc CLKID_MPLL0>,
-				  <&clkc CLKID_MPLL1>;
-		assigned-clock-parents = <0>, <0>, <0>;
-		assigned-clock-rates = <294912000>,
-				       <270950400>,
-				       <393216000>;
-
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
 		};
@@ -73,6 +65,14 @@ &arb {
 };
 
 &clkc_audio {
+	assigned-clocks = <&clkc CLKID_MPLL2>,
+			  <&clkc CLKID_MPLL0>,
+			  <&clkc CLKID_MPLL1>;
+	assigned-clock-parents = <0>, <0>, <0>;
+	assigned-clock-rates = <294912000>,
+			       <270950400>,
+			       <393216000>;
+
 	status = "okay";
 };
 

-- 
2.34.1


