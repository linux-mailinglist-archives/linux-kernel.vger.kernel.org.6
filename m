Return-Path: <linux-kernel+bounces-573687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1DAA6DAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5592E16DC33
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9AB25F786;
	Mon, 24 Mar 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRAI2wTX"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A625F979
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821282; cv=none; b=TKghxURor67UEeFB9ehoLDCXrMhuk9eS7Kn+g55P19ZvMK6ICt7R72MaM5v/z7nvL0n5e/IdtpCJ+MCB5pcZBGBPnHMgTYaUU7OuJUpUxfoY1RLesxvZhi17daspJ65DYBC/q3gAJxbARFC6X/ZJT+leb09GpVjHevcGG23Gq5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821282; c=relaxed/simple;
	bh=4hK5NwvGZj3PELV41E3//V4IRXz5oGNBj9IGYps+vOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BMYSBKfO8NRtgpKwOit5qA+MDg40YjzBXZAUJSwisFYXw9GWVXkiO0r0iXge8hWhLva9+oSZ0RCXoZ7NqDO48HyUI1s5NALborndho1kdyHzFyCAMT+arqVZ9OAuhcalPNTtXPdWOgm80vxzYkIprZafb4krfeeHL4eIuWtt+/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iRAI2wTX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso37375485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742821278; x=1743426078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHH3q92f3jVI2cl1PwT0LmA+qhtDvCooULm9gmNkwck=;
        b=iRAI2wTXwQekaj2V+pggqBWyNZbmDmo02NcC/LH48s0NJ0MvLKaaXPG3yeytoQesbn
         gf3eS8bm/FL+sn3pY+1BONPOKWujgvTo/zcVH01GICelXncSgJZJP4AhukCh8GuPQ+WA
         JqjRTCn3ZHz2FgZ5TiZaQsAzFSoVJXAixF4rKxh0SOaMi53LC3orTGh/C/INHmV7kc6v
         7TKma8jDrobsu4fC7HpC83dNA0/46PMt5hZ7eb/TEnYzOC/ZWB++Ngzkm7nPaBNGqqc2
         /D36mjPdzy9+h1R+HJN00joBmdwgMF9TopFHY6rxsoKdvwwJpc6hysIUxXdvGaUxfxfl
         dciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742821278; x=1743426078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHH3q92f3jVI2cl1PwT0LmA+qhtDvCooULm9gmNkwck=;
        b=b9vDdnpjfEznhhyxRQfiWO5vS4zxgpk7uwK7QvoabZ7lZwTqi5piudfn4SiXeFctAk
         d9Ki0LtXs2TBy5GEwIr8WssaOxfmPGyP3SY//PPKh3dP7Ye/pKFReoGZYmAklBhpNMcd
         VSaAFH+ZvRLgvi2xKfoFhpjHk+gAXBfMQ2SuBP6jX+Y4o2tD77+r6h702weaQf3ufoy4
         iqCQQl/Sg/5aEqxjWqP1ptvLobeScDJfhmDWz6xTUcQ97CVCjz3N8UVBWxyzUI7dTLSy
         MIJeP66aJlayE1dk/kfwvpQRsp3VIZYWn0Cy/9x0N0RMS/eoAr0s3DzVo+iP1rvgW6at
         DNXg==
X-Forwarded-Encrypted: i=1; AJvYcCWfwEPS/LeOklPI1CVzKd3+s2umYI50s1pVUbtfaxZFlLdJ38i0dCA54FsinPNFvuJOkm8iu5kvRjwR7E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxASukZZFccJqXPwgraWDk3YA5mFv0S81K13BNqJnMo9EyCWuGA
	Pt6Sm6YbH8X/lajobs8V1xny9bA5PUkD2wFcyJlzhtVi32NjACwQ9YSICgr90AM=
X-Gm-Gg: ASbGnctCsJ9qXbn2Q66aMnwEwV3xI1R/TsRdqqXnfkAFf2wkE2K+UnbVTv0etindnQh
	ZqwKIq2c4ificVwku8K+nRmzW0Cus4nhDKFXrYtqrcf8z3nXtpgtLd/l6ijXKtM4TwX+7CBdMU0
	mCpDqwSSHuZVwbu9oIMbIEpmlxP2WPissxRkvPREpuhgga0l0QWuMAgTMb1LaCNvIKAHLgrovWW
	7rrVzLadp88wmtMoTsxngXVrxKUUvVsvTH3hUFQhTCCs+hlJobrbHZ+D3Wkg/ZSET+8R10ClR3O
	Wn8LrPfllURopHSuY5Ho68L7Weev0hvfUyQsonMyIW8gDiw+8D6f8OpU0IcjeFpvH827Pg==
X-Google-Smtp-Source: AGHT+IGeenGXBUxGWQuSKN6iBis1h2PL0x44PYgwRi+E3q/OLy/gfMO1oiAs9uaXyCp/vP0FDPrvPw==
X-Received: by 2002:a05:600c:3110:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-43d509e3394mr108748655e9.2.1742821272912;
        Mon, 24 Mar 2025 06:01:12 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd1c7sm122275975e9.40.2025.03.24.06.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:01:11 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: peda@axentia.se,
	broonie@kernel.org,
	andersson@kernel.org,
	krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	paulha@opensource.cirrus.com,
	lgirdwood@gmail.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	johan+linaro@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Christopher Obbard <christopher.obbard@linaro.org>
Subject: [PATCH v4 6/6] arm64: dts: qcom: x1e78100-t14s: Enable audio headset support
Date: Mon, 24 Mar 2025 13:00:57 +0000
Message-Id: <20250324130057.4855-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
References: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Lenovo ThinkPad T14s, the headset is connected via a HiFi mux to
support CTIA and OMTP headsets. This switch is used to minimise pop and
click during headset type switching.

Enable the mux controls required to power this switch along with wiring up
gpio that control the headset switching.

Without this, headset audio will be very noisy and might see headset
detection errors.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dtsi   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index afea82616bc4..34d1d8927484 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -41,6 +41,7 @@ wcd938x: audio-codec {
 		qcom,tx-device = <&wcd_tx>;
 
 		reset-gpios = <&tlmm 191 GPIO_ACTIVE_LOW>;
+		mux-controls = <&us_euro_mux_ctrl>;
 
 		vdd-buck-supply = <&vreg_l15b_1p8>;
 		vdd-rxtx-supply = <&vreg_l15b_1p8>;
@@ -149,6 +150,16 @@ pmic_glink_ss1_con_sbu_in: endpoint {
 		};
 	};
 
+	/* two muxes together support CTIA and OMTP switching */
+	us_euro_mux_ctrl: mux-controller {
+		compatible = "gpio-mux";
+		pinctrl-0 = <&us_euro_hs_sel>;
+		pinctrl-names = "default";
+		mux-supply = <&vreg_l16b_2p5>;
+		#mux-control-cells = <0>;
+		mux-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
+	};
+
 	reserved-memory {
 		linux,cma {
 			compatible = "shared-dma-pool";
@@ -604,6 +615,13 @@ vreg_l15b_1p8: ldo15 {
 			regulator-always-on;
 		};
 
+		vreg_l16b_2p5: ldo16 {
+			regulator-name = "vreg_l16b_2p5";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l17b_2p5: ldo17 {
 			regulator-name = "vreg_l17b_2p5";
 			regulator-min-microvolt = <2504000>;
@@ -1461,6 +1479,13 @@ rtmr1_default: rtmr1-reset-n-active-state {
 		bias-disable;
 	};
 
+	us_euro_hs_sel: us-euro-hs-sel-state {
+		pins = "gpio68";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
 	usb1_pwr_1p15_reg_en: usb1-pwr-1p15-reg-en-state {
 		pins = "gpio188";
 		function = "gpio";
-- 
2.39.5


