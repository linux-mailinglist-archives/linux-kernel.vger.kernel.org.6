Return-Path: <linux-kernel+bounces-412756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D839D0ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80CEB30B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DC3197558;
	Mon, 18 Nov 2024 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQYO5aWb"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2446F19415D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926079; cv=none; b=nxWwJjUlqBwfQT7GJxdCoRHLzo2g+6pCeWNPFFBBnE1qaH+5d67secBE0x/sJcz6sjJ4jl8q1yXMPXd9XisHJc+oJ7Zh8vxGGio7qO2YQ6iYf6YrlvIB32pk1Fp1lFqOgq34zBMM1485tKfBiN/hoQeifI+q+jmWiiQAygF5Z5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926079; c=relaxed/simple;
	bh=5thSI/c+7QWY6iWfYvRFqJwPPVssjzSrSi0OiLmYH9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNN4FT1Zt86iZ6DwtrjmaMAiPsiYR4XuyDHlQ5wqV4/+b99JcH8I3siNejdsnnG8vJLOhL+cumtdrKpAn5bm2CA6INpFNhW4PJatUhtqs4kHMy/BkimG/TRri35zSNhonmSAVGmahNtoUmuKSrLhsE+jlFEOnlm0KTLJZaRtxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KQYO5aWb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315eac969aso22403065e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731926076; x=1732530876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yr1292EdCuKFfiA+4ZvZQTerR4Z3UgKV6lwrmxEoxeo=;
        b=KQYO5aWbQY/a9ge/YJ/80N2rNibzGaGArJLYJIJLdUpdxoU+eylLoQ40Sy/oXvMyM2
         2+RaIMUFBqiSDcrNq0q5RqLbCXJc7CRtmLXbZd75ty73C3FQbMF2PYDcWRt98nzOldHN
         bCBs3JKnFX7kehsgl5cgeu288FqemX76pBoA5JZPfXFqHVSKMH6wnhM4logJDrJ1Xqsw
         BSzks2+2aOL+SCxiTPuihQgu0ZUtohL9ROMORIubgd9aUdGopuOc+r2mts/VYfF1/paM
         dBtbTguSe9jQzr5W2znx0JBhoiELQ0/M/dzpH+yOvB8JHbU++rZbwTAdPIUnvIcEffGM
         8pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926076; x=1732530876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yr1292EdCuKFfiA+4ZvZQTerR4Z3UgKV6lwrmxEoxeo=;
        b=mzdvbwNT6VsejfkNYMUVkwBD6911kUnulNy5eZcNiz8pK/8t5wmEDY6sFCWCvGoqp1
         45DG7cAVvmL3mTgdriDTzRLdJVPfpRW/fov5pB+6ZRDEY7o52TzSd2eQCVPhJCQUL6Z6
         c0rKp5uwPRkFTp2nj3Z9KxWeA7HNN3eI8TYxl2tmugNaAlAfgZ9K5c64kUESx+u4HaXk
         N9YFTY1kHYt5o/0xlWwolb8Sfyi6tnxLF+pK0YE/vP/uata+SPvhS046MP/Zlp9qIwwH
         sXRGRtpXTr3nyO2uGecRdxiPstGnwxRRsn8a81Yn9qkMjcO5udv+PgI+WLX34syMd1TP
         56Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWyLVKnK5xM/kXTch4MtAhOYrnQgARNEUW7Jm9C+us3f28h+57yR6aJ/bJLtYn2TOW7sqlfnRjtsNg+9PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0YYrjLJ6LQuXQDQpPlEWe2ryNqUPP0uFU31uHvdF1OBRWHIiJ
	k1UMwyKHuywNWllNgyLiPJOXpPrj+irHVxkf3JnAhih2CMIcXyz9FfrwmqRKMKw=
X-Google-Smtp-Source: AGHT+IEpR027bQwqgL+gWsLc+SHyyXqlwdyiwrb5NhXy2pdUH//X/toKtnp1aDwfHxO74fzhk6rBZg==
X-Received: by 2002:a05:600c:1d1d:b0:431:3b80:6ca7 with SMTP id 5b1f17b1804b1-432d9767819mr147645655e9.13.1731926076147;
        Mon, 18 Nov 2024 02:34:36 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:5b7a:75b3:1e72:6e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38245e95925sm3162979f8f.111.2024.11.18.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 02:34:35 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 18 Nov 2024 11:34:29 +0100
Subject: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: Add USB multiport
 fingerprint reader
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-x1e80100-crd-fp-v1-1-ec6b553a2e53@linaro.org>
References: <20241118-x1e80100-crd-fp-v1-0-ec6b553a2e53@linaro.org>
In-Reply-To: <20241118-x1e80100-crd-fp-v1-0-ec6b553a2e53@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

The X1E80100 CRD has a Goodix fingerprint reader connected to the USB
multiport controller on eUSB6. All other ports (including USB super-speed
pins) are unused.

Set it up in the device tree together with the NXP PTN3222 repeater.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 48 +++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 39f9d9cdc10d..44942931c18f 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -735,6 +735,26 @@ keyboard@3a {
 	};
 };
 
+&i2c5 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	eusb6_repeater: redriver@4f {
+		compatible = "nxp,ptn3222";
+		reg = <0x4f>;
+		#phy-cells = <0>;
+
+		vdd3v3-supply = <&vreg_l13b_3p0>;
+		vdd1v8-supply = <&vreg_l4b_1p8>;
+
+		reset-gpios = <&tlmm 184 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&eusb6_reset_n>;
+		pinctrl-names = "default";
+	};
+};
+
 &i2c8 {
 	clock-frequency = <400000>;
 
@@ -1047,6 +1067,14 @@ edp_reg_en: edp-reg-en-state {
 		bias-disable;
 	};
 
+	eusb6_reset_n: eusb6-reset-n-state {
+		pins = "gpio184";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	hall_int_n_default: hall-int-n-state {
 		pins = "gpio92";
 		function = "gpio";
@@ -1260,3 +1288,23 @@ &usb_1_ss2_dwc3_hs {
 &usb_1_ss2_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss2_ss_in>;
 };
+
+&usb_mp {
+	status = "okay";
+};
+
+&usb_mp_dwc3 {
+	/* Limit to USB 2.0 and single port */
+	maximum-speed = "high-speed";
+	phys = <&usb_mp_hsphy1>;
+	phy-names = "usb2-1";
+};
+
+&usb_mp_hsphy1 {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	phys = <&eusb6_repeater>;
+
+	status = "okay";
+};

-- 
2.44.2


