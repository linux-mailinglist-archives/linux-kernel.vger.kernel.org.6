Return-Path: <linux-kernel+bounces-396348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EC49BCBFA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1A11C23A63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619DB1D5154;
	Tue,  5 Nov 2024 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0hbudfR"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C701D4351
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806676; cv=none; b=brd7ze9D90v1MosXYPJ72++A8Zbl1JCLSfMfEHnZcYVFi6pI6Fk1XkKUJ1CbcLaC9jfOdNtVFuTCKh1S7RvdAclWnUqZZ+bNfDAORQh7lfOeraKrCk1wpO99vJsYSTkaJquNkxYvQirP/Jv0ODR+NV+bbWXR5iXh1/a9WwQPZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806676; c=relaxed/simple;
	bh=BI2meJHmLKjzFcCEJbF3FZiDFGsMfh8n4PIbpBn3g40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTjCGL9sFwnO2ERgdPSUXs+kPns4tvkTPNTkdFUFrT3csY9KO7RH9pvMpQLM9YFxJlCXoTiIVtFVxIU9GpNpCYjaZ5xWfA9FOmDqa5UCIly2cIt5nU6eRafGlXovtTmpib8c1ksFsotBWCniOri2SGdPvzCIRdH/Gi5LYUePJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R0hbudfR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431616c23b5so33313175e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730806673; x=1731411473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGRDtmGmJ05hRR3sHi8vRL9my5VuOnWy1BIiW+Rka1k=;
        b=R0hbudfRMIE9u+yH1dW1vF13D118eGpUuFmg2uJtUimBNBehJK9+DdDVpNjWRjfOZU
         fbd408NMDpqYviuN92BzaMZ3eEjQsaosCxvRnQlkVVB4B5pFVN92lJ2NY6AeN/xLmDi+
         m2vwQDD36Vrt7YdzqkQU2wqbaONmMi5Ax5CeGIdfj9ilDEhRzTW9KWq/3RnXtb8oBNkB
         L+P5qo4R27+Of0Y4sXAuO3wjJOFyJUYk+qwIeH9IJ7O4XC0Z5snwjr2WYlrgKnPl+R27
         TA/lT2OmVsWCb9segEEy8U/9496sZaIE5E7Bz8DbFt2Uxxcp1OjoA/tO7mS7zSlIwezS
         BJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730806673; x=1731411473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGRDtmGmJ05hRR3sHi8vRL9my5VuOnWy1BIiW+Rka1k=;
        b=t2qHS/Y/NVfOG28OEojGFH8CUDSJjOOSgqR6A3JDbiaBGSN5fN6kFtGsDGpCHfCzYN
         ordtbH+b9/QV63Q3NVGxawfJq92WmUGQZZCA9gmtWG9JsiFCSH0E3ahvLDAKFm1tGiAm
         y3XAOyiCMEXqHbxN/Bwn+OMsKph6uzEYXXOoUnkjOrh55AEGILaMCI555IVgU3qmAQc2
         Kn7oNy0rest2QVW54AyBpWsrQ67y2MGHMmmmdZxtFuukzDollitdX6/n5QEgZtbAOb6F
         GtXFzULgeKaJTMRaS8zKSv7vH57KybL93VAY2CW4ZRxWUndd/Vzu4IwJBjl835nQ4j+8
         Jb0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUigMEaJo5P4toHXlD4oAOhmRDpvywbpWhKXx+aWVcUNewrkbg3SE0sema+/8pnIB8g+2ZdapMuq/7SInM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn1V5JPsqmc+1kY0Idww33ZcvrpiPjjJVG82luq1CFM/dQDzwb
	ODCymoVPDRytVv5ovxG5TTxjPun/1K1z+tEIsyeRehgsTE5G70Aqq2CAa7LNBW4=
X-Google-Smtp-Source: AGHT+IE81YKlOns7i42CHTSYaGb0+1UFP7sHMyU2PQ99F7+WEjSLj0cDi/OZZLEIMlnlZi4TCOq86A==
X-Received: by 2002:a05:600c:4f41:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-4327dabab21mr145555935e9.10.1730806673276;
        Tue, 05 Nov 2024 03:37:53 -0800 (PST)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm181816845e9.12.2024.11.05.03.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:37:52 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 05 Nov 2024 13:37:32 +0200
Subject: [PATCH 1/2] arm64: dts: qcom: x1e78100-t14s: Enable support for
 both Type-A USB ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-x1e80100-qcp-t14-enable-usb-type-a-ports-v1-1-b4386def91d8@linaro.org>
References: <20241105-x1e80100-qcp-t14-enable-usb-type-a-ports-v1-0-b4386def91d8@linaro.org>
In-Reply-To: <20241105-x1e80100-qcp-t14-enable-usb-type-a-ports-v1-0-b4386def91d8@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2944; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=BI2meJHmLKjzFcCEJbF3FZiDFGsMfh8n4PIbpBn3g40=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnKgOLIpSv5JBaRVz6XBqLSJriFTe3SxvLD5UJ/
 bf/fRgDQWaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZyoDiwAKCRAbX0TJAJUV
 VtA9D/9x1ZSaQL5feSqCuTudCVxG12kqI8XdrPT0D7JFyO1tMZIDzw04peaycMo+V9h7kEhCFn7
 6LUH77SCsKrv1X7Ufpoxx69WbMaeolnxIHetGbWHsOW0CgZWvLSD9vaGQUg3D+o5siDQig87iOi
 zYpe4dBY2OaQi42+9d9wqrn4kmHJTSzuiolGvQnqWzaqA9R0UgMnV5G68p9dsqdJGaSakYYWAPt
 dkioSSi1Uk+FLdsshe266fhrhp+/hP1Wz6osHyLGyPWK8/PDEvXQAIbn9EQZ+PYKHtmwRJFgx0n
 mvjMyLw6rlylhHoHGlmALy5Deck3I6KCKV1lM/7ThmGZ9Bawv70TWIv75XkCu2SkC0Z4OJ1Qahu
 lerbGDAq6VgP4mdPSFmEM3Qy0cPJvALo9aaryLW+mMfm++mnsB027/W+th64abMTIoX9gyhNhcJ
 +L85VGhDI5HDr3XMeQMxV59Fc5j1XRnq3rIwBRafcNw8Z0jdjuR3TEUo8p1UFCEmfWMXiJAWJbD
 RAsZu6WuKxphzi11WFpZEUhhciBHlRJPR5cgGdE/Aqq76p6e6dXW41ycecTRbEeJM4n9jiAdUxn
 oAPVHLMUUEd1pdv4r4m899Carwujbz2TNp0+REqt5yuS3JL/jGX4WtShvoyl4VX6UyeZzk/dAZ8
 CSpAbyWLmz0d5Sw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Thinkpad T14s has 2 USB-A ports, both connected to the USB
multiport controller, each one via a separate NXP PTN3222 eUSB2-to-USB2
redriver to the eUSB2 PHY for High-Speed support, with a dedicated QMP
PHY for SuperSpeed support.

Describe each redriver and then enable each pair of PHYs and the
USB controller itself, in order to enable support for the 2 USB-A ports.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index 975550139e1024420ed335a2a46e4d54df7ee423..7468ae443ecdac28fa0c0a42e72454907935a5a9 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -495,6 +495,40 @@ keyboard@3a {
 	};
 };
 
+&i2c5 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	eusb3_repeater: redriver@47 {
+		compatible = "nxp,ptn3222";
+		reg = <0x47>;
+		#phy-cells = <0>;
+
+		vdd3v3-supply = <&vreg_l13b_3p0>;
+		vdd1v8-supply = <&vreg_l4b_1p8>;
+
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&eusb3_reset_n>;
+		pinctrl-names = "default";
+	};
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
 
@@ -651,6 +685,22 @@ &tlmm {
 			       <72 2>, /* Secure EC I2C connection (?) */
 			       <238 1>; /* UFS Reset */
 
+	eusb3_reset_n: eusb3-reset-n-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	eusb6_reset_n: eusb6-reset-n-state {
+		pins = "gpio184";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	tpad_default: tpad-default-state {
 		pins = "gpio3";
 		function = "gpio";
@@ -808,3 +858,39 @@ &usb_1_ss1_dwc3_hs {
 &usb_1_ss1_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss1_ss_in>;
 };
+
+&usb_mp {
+	status = "okay";
+};
+
+&usb_mp_hsphy0 {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	phys = <&eusb6_repeater>;
+
+	status = "okay";
+};
+
+&usb_mp_qmpphy0 {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l3c_0p8>;
+
+	status = "okay";
+};
+
+&usb_mp_hsphy1 {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	phys = <&eusb3_repeater>;
+
+	status = "okay";
+};
+
+&usb_mp_qmpphy1 {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l3c_0p8>;
+
+	status = "okay";
+};

-- 
2.34.1


