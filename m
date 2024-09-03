Return-Path: <linux-kernel+bounces-312645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B290896993F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F08B2206E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FBD1C984B;
	Tue,  3 Sep 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3SA3FyRP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37001B983A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356204; cv=none; b=HvYVDxdOaNr/hDh5u0SzWkyUysvUo5MHYOqPlMgQdhR8a3MU3r7XfJGpqYska/CqlMubjI5vjqlz6KZBxfs60+DtNwk6OjIW8vC8dISB2H2H+Er4BkObB8dUx7+GRqh3WCQEhW6CUPjUK0eP899lrOktJx4DU44QBJ34hfmgpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356204; c=relaxed/simple;
	bh=togQe/GGq6SziZ6T0fB/y/Kop1Ebns5gKjzqMfo6/x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8MSBixtosuEsqcaHQ25c0LUKgdCABLHOm7IhkYaG4Yupf+ROt55uKrzGp4mmbNTse1Fa5Em1r1wETP78AdxFfurP1WZ9ljKEY5efg9uEoxuIwIsBECFfpcG3/dD40H4ZGraRYQj0eIpBtBkPOO2Dj1hG9EgABwc8X/vPvvdHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3SA3FyRP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374c5bab490so1308154f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725356201; x=1725961001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYq6vD5N4uatwT7apnc7QKBLGGoT0UMnQ2xnutkqvDU=;
        b=3SA3FyRPk65aXPzq+btZ6wdGOxbvQwhdRwcZFTy0bsBeVKrCs1mypMn7yLKtasVy8Q
         ZPdwLC5yr7ywwrotjyYvCwlT43Xh4auIx3JH0BnJHaGBukRDPAP8Rki3n5x0ahkVrfM2
         wDyStOE/sYFHSbp7mtYkLmE1kdOBgYBBSrO9eJHSH53K/m5kWzBFDLr6hcbRleVcYPPW
         lk7ogX55Upll8bwt3Si/Y8GHZ8vWnN7C4PvDY70bZqDIIYl5oGN8zsWIG981maS8emQy
         3NIwYspouBiswKeqbLGP394GHPmRteOnAomR6eGlfdywTyyD767nyWs5rkbaMz0MhM5B
         4Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356201; x=1725961001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYq6vD5N4uatwT7apnc7QKBLGGoT0UMnQ2xnutkqvDU=;
        b=hM8S4MQ4545BF5WRGoSiPAP+HHeb8cuCtQnCMPCJ0hV9IBx9DrCm9qPSyBjQBIfLEu
         OdKc4K3CNSXmnQ37wwwdh8KLiw4EZNC7X2PkjxDSlFIMq7ly3crUQxt4f3aezVQWsTWF
         h16SfX2gXJjkeolaMx7v2sXh7g9q4pnPo35dU0CY7PI2/gluWy94NmAVuv5c08GF/VfH
         0zGna//RvN919Ty14949By73kzrc0FfaVU4sCru4SWZ2/RZEA3cRGVplXVAa5m5vkZGX
         OV9lk4/q2Mt66gE5nGMCH7T3UxmwMfzCaQ9QdWZC2a7XZoIp96zC2DB7sHEdh8+gRfLm
         zaLw==
X-Forwarded-Encrypted: i=1; AJvYcCV4VnLqxdT3ywwenH5NedZQhGIKxrC4IJX3o9cYRN8lWyt8UFn9Dyn7l6EbqvhXv0wM3NwaRfyVxRaVHck=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4KyNYxAd5fbYp44WsOr6IjAGOkYwBLxkgoh/eFuhhqfZZzOS
	smDSN0cgGgWaikXwJhTm+eyfquO+5L6fm3qeiBc7+Wir3ZIb0RvoM+bel3mUg1g=
X-Google-Smtp-Source: AGHT+IFBqUWAg139WelJyM5R44QX5Qh0Z/xq+H7PA7Cur/H88ost1X+Rjoch/L1MyvyD7ispzQel/A==
X-Received: by 2002:a5d:6d06:0:b0:374:d24f:7a24 with SMTP id ffacd0b85a97d-374d24f7ae3mr2757756f8f.24.1725356200649;
        Tue, 03 Sep 2024 02:36:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e61d:37d0:a59f:d06f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-376914bfca1sm790793f8f.18.2024.09.03.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:36:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/3] arm64: dts: qcom: sc8280xp-crd: enable bluetooth
Date: Tue,  3 Sep 2024 11:36:27 +0200
Message-ID: <20240903093629.16242-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903093629.16242-1-brgl@bgdev.pl>
References: <20240903093629.16242-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the bluetooth node for sc8280xp-crd and make it consume the outputs
from the PMU as per the new DT bindings contract.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 59 ++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index ec6bed8395b1..eac3a6ce0b65 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -20,6 +20,7 @@ aliases {
 		i2c4 = &i2c4;
 		i2c21 = &i2c21;
 		serial0 = &uart17;
+		serial1 = &uart2;
 	};
 
 	backlight: backlight {
@@ -275,7 +276,7 @@ usb1_sbu_mux: endpoint {
 	wcn6855-pmu {
 		compatible = "qcom,wcn6855-pmu";
 
-		pinctrl-0 = <&wlan_en>;
+		pinctrl-0 = <&bt_en>, <&wlan_en>;
 		pinctrl-names = "default";
 
 		wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
@@ -746,6 +747,27 @@ &sdc2 {
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-0 = <&uart2_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn6855-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
+
 &uart17 {
 	compatible = "qcom,geni-debug-uart";
 
@@ -891,6 +913,13 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	bt_en: bt-en-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	edp_reg_en: edp-reg-en-state {
 		pins = "gpio25";
 		function = "gpio";
@@ -1090,6 +1119,34 @@ reset-n-pins {
 		};
 	};
 
+	uart2_default: uart2-default-state {
+		cts-pins {
+			pins = "gpio121";
+			function = "qup2";
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio122";
+			function = "qup2";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx-pins {
+			pins = "gpio124";
+			function = "qup2";
+			bias-pull-up;
+		};
+
+		tx-pins {
+			pins = "gpio123";
+			function = "qup2";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	usb0_sbu_default: usb0-sbu-state {
 		oe-n-pins {
 			pins = "gpio101";
-- 
2.43.0


