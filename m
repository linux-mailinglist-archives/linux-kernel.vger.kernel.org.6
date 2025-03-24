Return-Path: <linux-kernel+bounces-573800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201C4A6DC9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77859169A11
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE0B25F7BE;
	Mon, 24 Mar 2025 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Id7Qyvyw"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6825E476
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825317; cv=none; b=ByTyShbK9pHh0Dp2ppkqW3hEQ+3uxiPngQbGRW7WSBvuf30lyyX0LwjPTwdW6/qozWCdIqydBhzdfcJgpbfdm9AryixqXn4lHg7RCzFB6KdJYAjI054TBfNwiEnMqVMXqnAwlhCtMFRmEfnDuBWjqdza2qSl6gPbP9psJdZl6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825317; c=relaxed/simple;
	bh=k9auSPKt0xDsiEz8cyRI0UCs31hNeF6aYfn1A9QhgOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M3bffIfpVGhkVOnpyiaNsydRqMTWMomj+gSR6TcC68qwsMNZg/HGSbfe2mJezLN8ggj6iF2zF67IQQwxBCqoKFD+P+ki845SoPq8SmsZbmW8tIuTMfTkeWqGYZbeCYPspZ1vXWBSury6ITcVs6pbVwyuu+Q/FxrGx5aRWDgUd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Id7Qyvyw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac297cbe017so982314666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742825314; x=1743430114; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTS81nyVkU32wlX4TnObp+0zngaZswbVsK7/OVV7Vtw=;
        b=Id7Qyvyw9KnqSa+jTLthIgiUDfC4Ws6i5ZHQ2V0A5dlbx/fHOlcRwKO5OzESlEr1JB
         0xZ5tAWjBA0eGXcnVlbJkLbQnIMvQCgKcQJYcGQ+s5XqWTLSJABTLTRtc/ARNpuyN1cZ
         ciNwoqTOUva7wRjeGRHd11wnFX1Yr9OBGsuxGZpoOp2Gjl1uouj38TK0NLrFX9CURDOE
         39kyAcYv560FpYJwPJl57k4VKjN+yLOGzimAOGpQUfcUZI4yv2M8fAtY8hD/KX/Jnb23
         XBjEX5mHW1ndtcED0iBIWzUICrb/KcUPfgrxNgOYVHrJE0uU/JbQJYoF+HpmnNvp3S85
         6Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825314; x=1743430114;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTS81nyVkU32wlX4TnObp+0zngaZswbVsK7/OVV7Vtw=;
        b=k9Eytjy6GhbVVsDbF9FRrhHm2bqw2MI3PksFmae7VsgqJrc5vThU//P9FvBDjQaLPv
         gkUEzK/mNeYOFstX6z2h5aqgWCaDQLRFn0i1Bt9Vc+/afs9Dlts1E7TFloJiSWULKF1+
         KaSm6+wobF9+rtOzFZMlXcOTbES2gzKyijqyMj05yqPagqY1gMjzWJA8ryzsKW2ih1l0
         lZqEu/u8ERBL+Jw5ZQxfR/kRlmt0TCxU8oayXuLR6sp73/8U1aJrHeFsNE2BA0RFaG0l
         MNdyjVkMr0xOFUJwmw5BZaACxlhwPw0qGPv77pNs/PUO1WorbZLrWYzPJ+pKzMIOOb2v
         5PIg==
X-Forwarded-Encrypted: i=1; AJvYcCUoflG5vqadQAoEjDRO6L82ss46rjL5R1MDgp9DSJ+I29flwAgeithuLERnNr6HW+9OI0r0/mV/MW2KrOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznhwR8LbaG2Ts3uCiuhnGNBuaGJYIBPDOljJXMTMIQ1meDpEYk
	nsMnvwzUecWZqRVkgcwq9nlPHHKf8lWtIKbhdNBzWKOubfnUV1oBHWlmFM4GHos=
X-Gm-Gg: ASbGncufcg+1pwBDq5J8voXvEQm1UAUEJa4GMHq7CuQKDao9IE4EwNadcEU8Z2BJSSB
	zwpGfTKgy/czpffE4dYGH6IV8UFh+m79kPZKb/1DjBrPnF1w3h+0FSYb6zK4K+tzxdkKK6X2D9a
	pXY2z+KKnIF2swcFPwlLZt/IT4sBEiCxYKLR6HpLGeKEOtAPzcRQhXK6i7fPsbXJun1f6Y50fD3
	2uN4t72NygdlHc0tbN57AQZON1tRSNbVFcMnEnVXW3nBvxHGDJn7umsP9bCJBxRMDG+8UO2vcjS
	Z3atxemiX3by9Pva67TOdvjotlewuSe2EfqniqrJSdQ=
X-Google-Smtp-Source: AGHT+IFqz3+P/LzojKK63DKoN5LiDg2sAGczirpJQaykGYju35Pl96ChoHFNJWnrKSlYuL1pdxITnQ==
X-Received: by 2002:a17:907:958a:b0:ac1:e45f:9c71 with SMTP id a640c23a62f3a-ac3f00b7260mr1203497566b.1.1742825313578;
        Mon, 24 Mar 2025 07:08:33 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efda474bsm682381066b.183.2025.03.24.07.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:08:32 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 24 Mar 2025 16:08:19 +0200
Subject: [PATCH] arm64: dts: qcom: x1e001de-devkit: Enable support for both
 Type-A USB ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-x1e001de-devkit-dts-enable-usb-a-ports-v1-1-81153b2d1edf@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFJn4WcC/x2NwQqDMBAFf0X23IUkphb7K6WHxH1tl5YoiRVB/
 HeDx5nDzEYFWVHo3myUsWjRMVWwl4aGT0hvsEplcsZdTes8rxbGWAELlq/OLHNhpBB/4H+JHHg
 ac1WddPB964fY36jGpoyXrufo8dz3A4lU1W14AAAA
X-Change-ID: 20250324-x1e001de-devkit-dts-enable-usb-a-ports-6d6e4934cb97
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=k9auSPKt0xDsiEz8cyRI0UCs31hNeF6aYfn1A9QhgOg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBn4Wda/npmRyJzqsiQLvERIxYU+ZFunlFl8/clm
 am7qA1/oNGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ+FnWgAKCRAbX0TJAJUV
 VpQ/EACl6/HG8ZoSuTu/f5fQ9UpouXKp+0BZNsYTrlPiAlfni/n5A3sulz9mZa4JzmmzvR74vOT
 tkpYbvh2JqGZSNvQaGe4zhoRPuAu3Vt+ZEzqiKczPJtM7B3GplN+KMTdQfp/chpibwbc9TponPM
 qcm1P+XjkY3mSirvzOYO53lu4cjKIcxBFEVj+iLMgJLWn65hmHXuBv4jUx+4Epe3fTiwDaLoaqP
 6hJabslNejFMTEnpQMHik5PUrz/lPKctbcxhVQaOgkVlMYhEo6hmwUp+KIlzG0n8dq+uOZMUpLs
 ea/IICQr0BjESSzEGt6wBp1fYy+UW+/24TT9ewmumQz3nqGH1cud24arriyJc3W06YhvnqBHDwM
 g0Mm7bcsX5sOMsWvhJsTHAVl5LS2bbOVHMVMj8Kdy4pg0WW7UyZ7TICFkKmT78VvS1zZ1moG9j0
 eCuLY3SXfdGRxY/JAdDSZgy6JckPKgV5oESRtUS0Mae1ovFlgijSFhwfwT49BKXKemi8ZjqA1wv
 D7Az4vIKoaqhwZ4XXO5Uaa6dN5wRsgSDS2YFJbCnbGE36OQuxPK29bf3Kwvm8wF1+IfUceqgYwU
 Kfly5+HyrYMjGM7oaaRV6M9oOa9RzmbAv130wpQBum6DLZLAAg8cnTTNHB9NrQ/+vfJHL/OUm/z
 FoQE8qqrqpbo93A==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Qualcomm X Elite Devkit has 2 USB-A ports, both connected to the USB
multiport controller, each one via a separate NXP PTN3222 eUSB2-to-USB2
redriver to the eUSB2 PHY for High-Speed support, with a dedicated QMP
PHY for SuperSpeed support.

Describe each redriver and then enable each pair of PHYs and the
USB controller itself, in order to enable support for the 2 USB-A ports.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 86 ++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 74911861a3bf2606add8cf4aaa3816542e837513..643ab2876222b00bfd60b74b20dd79f105a43143 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -877,6 +877,40 @@ retimer_ss0_con_sbu_out: endpoint {
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
 &i2c7 {
 	clock-frequency = <400000>;
 
@@ -1129,6 +1163,22 @@ wcd_tx: codec@0,3 {
 &tlmm {
 	gpio-reserved-ranges = <44 4>; /* SPI (TPM) */
 
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
 	nvme_reg_en: nvme-reg-en-state {
 		pins = "gpio18";
 		function = "gpio";
@@ -1371,3 +1421,39 @@ &usb_1_ss2_dwc3_hs {
 &usb_1_ss2_qmpphy_out {
 	remote-endpoint = <&retimer_ss2_ss_in>;
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
+&usb_mp_hsphy1 {
+	vdd-supply = <&vreg_l2e_0p8>;
+	vdda12-supply = <&vreg_l3e_1p2>;
+
+	phys = <&eusb3_repeater>;
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
+&usb_mp_qmpphy1 {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l3c_0p8>;
+
+	status = "okay";
+};

---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250324-x1e001de-devkit-dts-enable-usb-a-ports-6d6e4934cb97

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


