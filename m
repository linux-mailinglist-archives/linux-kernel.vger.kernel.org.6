Return-Path: <linux-kernel+bounces-530984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89239A43AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4CF188808B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48A5268C4F;
	Tue, 25 Feb 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e3pP5pA3"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DB6267F67
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477568; cv=none; b=rmnGdbV75nYthreWHZrw7mXghsypF/3ep1qGB7No/89QOZMFKgctJUOAGEyJvfFBpvQqfzzFCzecyHBLUQTA+oKStlCR0xlQX7r++fhzgJKLoNYIXpPic43t9gMmi4WqnBvbxgpHOb4BGCu6GJbeuT2yX91420LMb5/EZgXSrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477568; c=relaxed/simple;
	bh=YM3wZj7szvGEiuHc5bQulEC7XAoC7XKQ7uCp5X7vTVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iS5JxGlq8/jdXCeYmLeX1HSXM/MnzPMbaObBUMWWLnjHKn8OVVxJSuHle2iORH+pd60ZDiVffo+AZwVmxT6R3MbqaQqJZ3s0BxVXreEd8rWXxT3l5bX593laoDo+Y7KKLzlxSIegRTPAzm2qqCQkx6nqpXYJ50LNQz3n4GLOx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e3pP5pA3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb9c8c4e59so90935866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477564; x=1741082364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ad42Mr8MneFfIZGZ15zl82CRCD1+gqEoL4UfWT3f7L0=;
        b=e3pP5pA3wVH7R8xUSrSnyadT1bEeSqviNH1By5avsCXfq7zlYDq6ZMJSOeiUViWOEn
         mUVBbuT2qZIZF4C1S7RLgikvHHP1DnWXxGLBKDMQCNksdolWCuYK3ROEZBCqajfNGNDG
         4smObAUEX/6pqHK2XryYcExpqrqjr2VoF/jtuku6jNeMJE91ISwvasl8iAWlU1HsUtZf
         VJu4YWJbmKHfZALrBlPc2O9TADV5vJ77xpPoJizuukITqdFY5Mj1qgRdn2MAVxNIkqsu
         m409icJ7bpFnZ8tmhHdJsA03OCt0RvgIWMETs8Z1OaMjmqhsyT8g6uhN7fY7Q/cTeO4r
         mpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477564; x=1741082364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ad42Mr8MneFfIZGZ15zl82CRCD1+gqEoL4UfWT3f7L0=;
        b=V9bfdRi3hAd1jQ79a4LTd5jvvIvNzlWVfBATTb2sXSf63G+YICd/inw/ii2OJwgBje
         1Myq1EuHyDiqcHItCPtQAqHoMcDia/YX3tenWFZ/8NZXnfsVR6d3IvWn9CtLWOAHmXCy
         l9IqpiyCEi4ClYh3SP1c3eBPLa/4l0B0f9GObilxLFzDkRe85R+TldVJvWibC9DjKg9x
         0MGF/fUiDxirHJXFHQ3P8jMV7gFawIWXu1bVb+C1BdN0A3KvqwEiw9yth3OtvEAwlsIL
         h9JrsS8L389y5ic7MJxnp8EQ1BvHA915QZnMzVKgofQ6C3HKMUGnAi0kFrOX+FoaPZRl
         UjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3NrPW0a2gTXlEjDVtafojIHgnUbIItu4Kwq7IX38sS3D1IDcu7nUwlgkwKZx6oH1PVy0A5HGQKEq75Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO81tMvlQPV/HCiMxcYrLBVhxtIbXmaaimE/lGceZecZbdEGtB
	gDj/+EWC9ZxPAMlky+bQGi2SIZdt0Asbd9GNDMnLK/5r78AJu9InuLniqv5jU80=
X-Gm-Gg: ASbGnctj8M0a8jEQbix6PmAg2Feh5R9MVBpQzDxB8F1By7hpXdFvpPyYyeOZkpN7YIS
	U/+XlTlv5/f70n0WWVSljl30N/AGRuyBxOfVRAL02vE5Rd/dftSx9JOlQdk86gSFkznyYzKso98
	/Gj0RwCzWsRXbZkBNPoPpOjXGK5q1wVtnQrsGOCCnQqVuis83sQiDg8SpHtvPTFW+00ALxHEqFq
	V3hKvDX2sb53BG+1tJ3BkftTvVpTy+hZrI65ISAHIH/36Z30H19Y6WHcXN7ndlYCs4YxYT99MDs
	AHyRIXCDbX+BQLQsHLr3H4fTUV1/KZgEe69XmTZD9WDnV4RxnwIMbsxUE6jnpouXj7Zjpzq7UvL
	Z
X-Google-Smtp-Source: AGHT+IHvayvv2t5KTb4XQ+6lgbiRdjj6qFE0NJuTdFDuNXg/S40P4JULWHZDbqXnMPrkGyO+jGpjwg==
X-Received: by 2002:a17:907:86ab:b0:aa6:6792:8bce with SMTP id a640c23a62f3a-abc099c1e93mr593207266b.3.1740477564021;
        Tue, 25 Feb 2025 01:59:24 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm115164266b.56.2025.02.25.01.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:59:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:59:02 +0100
Subject: [PATCH RFC 05/13] arm64: dts: qcom: sc7180: Switch to undeprecated
 qcom,calibration-variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-dts-qcom-wifi-calibration-v1-5-347e9c72dcfc@linaro.org>
References: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
In-Reply-To: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4026;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YM3wZj7szvGEiuHc5bQulEC7XAoC7XKQ7uCp5X7vTVU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvZRrhL1Q1tHzW2qkS7fBA36zUOQKNAP8c2AUB
 n4zNOguwyqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72UawAKCRDBN2bmhouD
 14sKD/9IDQn1bdUV5sz50ndufgOTr4T0XY5WBYjyhJBMUkbsomlEbCCW46FAUluJ5xlcKyv0pe3
 +njbcalZn78OQtxfJX3YtTz4mCA941Vc3rvgl/cITZg5YySaibnizpP5yS1xS0cHLayxwcm6zJ8
 xj7SHSu7tzST3mkupkCXKvroCc7lR+gZV+CKiu/MLTC5cbE99NU4AaLQsBGRQTxC0Qee2r9iLBo
 UZ4VLGCDyWxN03AbZMZdVTWI2xQxyafqCCqjf/vj9TFi7uytRyxKYXYleM9JoUE8s/eN3T0ox1/
 Uf6NWlhdOeF3lbgmUWCa5IaqqzPzxH5e12zgqAxydjmGWXbX8rf5hSBACeNcJddh7cJp4zS8+Gp
 AofK16/LmuoAEEKFiYjo8x520rbYv7xVKM4od/zbS8Fj7lhwStgQo6w9mAsQ3sSbfR7H3hniyV8
 TNNi/rgtYsDKpkoyl4XkDxFGloM48p6QwXTWhN0RniK4Fy9vn9BIyKtPjV0oNz6/NS57ouBTa9w
 Ou7QeYudPLpTXAUQAIhvgplTy0MhhyuUl30Xp05VN3+MbFNk7lU9feaeNLemnpAmtpjdP1r8RHX
 /o/mKocY6lDGsCF0KEOnhZzQ4Ws/ZeUwsubaUd34HJN6trez+mWviqEfG8ZDVYMEW04tQim/21k
 85JmxCAXGmT/s4Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The property qcom,ath10k-calibration-variant was deprecated in favor of
recently introduced generic qcom,calibration-variant, common to all
Qualcomm Atheros WiFi bindings.

Change will affect out of tree users, like other projects, of this DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi    | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts   | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi       | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi  | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index f57976906d63040ee5aab7ea48702118f44824d2..8fee8d7a7d4cdc85bf7e8ec524dae5a6ec0d3e9a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -188,7 +188,7 @@ &sound_multimedia1_codec {
 };
 
 &wifi {
-	qcom,ath10k-calibration-variant = "GO_HOMESTAR";
+	qcom,calibration-variant = "GO_HOMESTAR";
 };
 
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
index 655bea928e52a42498a3e7a5ce7a2774160f3b04..26514640a1ae29e0541643b565d63ce6d5cf5396 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
@@ -79,7 +79,7 @@ &pp3300_dx_edp {
 };
 
 &wifi {
-	qcom,ath10k-calibration-variant = "GO_KINGOFTOWN";
+	qcom,calibration-variant = "GO_KINGOFTOWN";
 };
 
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index c3fd6760de7a8ef0ff0e7d5cd793cac358aba798..eb9c9e713a89656467724dd731507d484d7dc86b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -69,7 +69,7 @@ &trackpad {
 };
 
 &wifi {
-	qcom,ath10k-calibration-variant = "GO_LAZOR";
+	qcom,calibration-variant = "GO_LAZOR";
 };
 
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
index 89034b6702f4185d7bb20e2453b76ef65c40ccf6..a2224de841b1dcf4dad4bb8d6282abc730dbad7b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
@@ -59,5 +59,5 @@ CROS_STD_MAIN_KEYMAP
 };
 
 &wifi {
-	qcom,ath10k-calibration-variant = "GO_PAZQUEL360";
+	qcom,calibration-variant = "GO_PAZQUEL360";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index f7300ffbb4519a7973c74198fc0f9ca2d770bc3e..4f5ab378cf8e68ecca8152170af13200716bcda3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -181,7 +181,7 @@ &usb_c1 {
 };
 
 &wifi {
-	qcom,ath10k-calibration-variant = "GO_POMPOM";
+	qcom,calibration-variant = "GO_POMPOM";
 };
 
 /* PINCTRL - board-specific pinctrl */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index d4925be3b1fcf5219866f9754b5bff3e45d84c08..17908c93652011d69a2d04b980f45f6732f16977 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -196,7 +196,7 @@ &pp2800_wf_cam {
 };
 
 &wifi {
-	qcom,ath10k-calibration-variant = "GO_WORMDINGLER";
+	qcom,calibration-variant = "GO_WORMDINGLER";
 };
 
 /*

-- 
2.43.0


