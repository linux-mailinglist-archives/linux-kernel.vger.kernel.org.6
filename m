Return-Path: <linux-kernel+bounces-364193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A97199CC8A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436E91F23A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7D817C8D;
	Mon, 14 Oct 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZt3Ldo3"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166D79C4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915308; cv=none; b=niQODiiGEBczoHEyy30i+XgfP0KJ7ahooygad3XwEHNgjDFfBro+qhYXKuNCkUhAWuI0rtAIpHGNSU8ZzLzsYhPlfEUUu3AhCldjKQPpPPPcS/Y0vL/KxP+32a5Z5RnC3eIGaP7cHhyLrhrgIqQxychNq6hZrWq9nY+cqnWsUCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915308; c=relaxed/simple;
	bh=K0bOWEC+HE1kkNV0lJmyf9eNjeLakCtO0ersbpJzOt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A+bUIraBPAwn5xTZtLU+XzHnmhLP2wXsI1gMg6mMwW+qryCb8vTHq9shOLF2iFHSEA1v9DBHyst4dcZ0GJsRV/nCbDB+GtG1BrG1xA+leJvaI4R+MsrgC4vAVKvw+kE2DtFmI04cJXR18evSLPYBILNO1/SevYhJhj+MDPyttE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZt3Ldo3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d50fad249so2763122f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728915304; x=1729520104; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mW2Gu00UK++/xXWN5E2WTl/GlqCg0a99qal31mqPqL4=;
        b=pZt3Ldo3Q5igYGdD5d6kOkQM4YgHnT/yMpn/afw4SfpNWRzgvmU+DbW5ijw2iIdpbd
         p2R1yIn+M1pL5iu888FjcDT6bDQTFrmjf0mZzDHef9phcchrfrdWHcfNu+toKvlsOXFe
         13JXSHfY8D6wV6uuxb4bhHPYwj1zSoLxqMJBu0GZYhIjnmyvRiQuqFQCpBlVuTn4k1Oq
         nvaoSSeyWLuhBTR3j1IxvQ8NfhOrVSC6S+LQztfK+Gb5k4wh9i0N94WvRDwuZ76Zcvz3
         ZXDJhLtBs8NvpPz/SK9LQMoo+faHOYAJIXV4k+P717yMEuRYJu52gA9B2qnMJ2bOJd69
         n2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728915304; x=1729520104;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mW2Gu00UK++/xXWN5E2WTl/GlqCg0a99qal31mqPqL4=;
        b=Ehp207W6FH+p0M43DrCAZm4+jljhkbDK8O9hNQebzWZ4hzBOUbUokb/Gi6TlACBY4L
         1IpohF36r0NmQZoaxuciD/pscScRS2umU2fos3FMb9uAGqt39uHzLFuAqJHJ6BetuLUk
         HjZLEUxpt+PB4mzLSW/M+moXidxiGYNWZVb4dp7vU+h4fOLSjjpWbntu/uNSPr2a/5oH
         Gg2bnY6Re4Q3DwX+ConMx9lx+sYXaysPGgGOgvxLEW9z0M2y7UZwuIuZlAZlpIIqLdcq
         Ia5Ed8gT3/3RNzkwot9WKUpP8HlQl5yanMaPUz089fIZBoct93gwCri/6GY2TnbtSgjr
         HX5g==
X-Forwarded-Encrypted: i=1; AJvYcCXNs68IbGqxqqo6uIVCSa26fe00GFgQGVwtKErX0x2r3SSBeblVQqchx6wH/sKOK5FoJPGVu8t11tNTrP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJb/YxkOjhqA0cs77KZXjf0f8yMn90mDAg4o6Kzp4gQlJTSyG4
	jCuHUaNn6T+68RYahUswZrfqpADbiuNoqg9IytqCckXMaB47TVwr+kj2uGEy+TA=
X-Google-Smtp-Source: AGHT+IH842xmdL5bgstxtrmHRDZldATMix1NsKVGEEADafMqa0y/TCecTEVTp7Q6EJfpih1E+b+IEw==
X-Received: by 2002:a5d:67d2:0:b0:37d:492c:4f54 with SMTP id ffacd0b85a97d-37d5518e02fmr8134392f8f.3.1728915304493;
        Mon, 14 Oct 2024 07:15:04 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf45d49sm154135035e9.12.2024.10.14.07.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:15:04 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 14 Oct 2024 17:14:51 +0300
Subject: [PATCH] arm64: dts: qcom: x1e80100: Force host dr_mode for usb_2
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-x1e80100-usb2-dwc3-set-dr-mode-host-v1-1-3baab3ad17d8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFonDWcC/x3NQQ6CQAxA0auQrm3SdiAxXsW4EFqkCxkzRSQh3
 N0Jy7f5f4ew4hZwa3Yotnp4niv40sAwPeeXoWs1CEnLxC1ubFdiIvxGL6i/IWHYglrwndVwyrF
 g6hKLskrXC9TSp9jo23m5P47jD07N0Bh1AAAA
X-Change-ID: 20241014-x1e80100-usb2-dwc3-set-dr-mode-host-35312d1d25b2
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=K0bOWEC+HE1kkNV0lJmyf9eNjeLakCtO0ersbpJzOt8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnDSdhH2/cZLsXmymGJqy7UxGVRgwXHjFlNiBcS
 P0vJuqejsuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZw0nYQAKCRAbX0TJAJUV
 Vt0+D/90zb+NBqLdICEDlaiQgWoO6WnVto3rxw2B497MTfOCFvx4cnqbaoEGTM9o3NC85DvL1ht
 0TG/+CA0kqqkUdFggDHf5RuF+xc87v0sVQrkL2kqV3iFLlXgpcNXWirQHeWyAMNj66EVMh0KuUt
 1xCU7Rk2OyamOSAz+58yRhqBs5zEX0gksWOFL4+9bf2EJeJuQu2E2NdIYxBGFtUBvL45PuZYEf6
 E0d1Bocj0eHvKsaw93fVhQ+4LAPvddYhYb1Ilcf5Lz0Z6hHtBk5tBua8pBlPkYabhT61Lu5Ljx7
 Tp1B7RTq7kzgMRl8NXTzZ5P0aBPHhqaG2tUdULxkrG5y0M91/v/0FWkG0hocnm7Qz0JntSWSaDO
 yElIkHDnD5lUUjXcPcAFbbRrYPW7fXv3PoOjCTWAVwSIs2a/x8MhAkZjGhsjqjJS/VSPlYzzvsq
 SZLAEL19dkuaRoHSB4jeFTwshdMp3Gmd6uAvrcbjKhpTJ18LeCbawVbVjpeWfTzKZ5Wajoqwe0A
 qQw8sa3iXWujHWHVMUYvfrRFU0uwGVAS/OSt8FAqJJTjzpKEfSt25mLSj4PL6vtW/7EqdNNZZXm
 jZEAolQB+IoD/dxNm11eUsbkuu0mUiMtr8sM9ORb6k/GLZJAdBVL4IbicJ3M2H/KMbWkXRmGndl
 091ciVll+DrEpQQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The usb_2 controller has only a USB 2.0 PHY connected to it. There is no
USB 3.x PHY fot it. So since dual-role is not an option, explicitly set
the dr_mode to host to match the hardware.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 0e6802c1d2d8375987c614ec69c440e2f38d25c6..4da13c8472392d842442193dc740027fa011ee1f 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4143,6 +4143,7 @@ usb_2_dwc3: usb@a200000 {
 				iommus = <&apps_smmu 0x14e0 0x0>;
 				phys = <&usb_2_hsphy>;
 				phy-names = "usb2-phy";
+				dr_mode = "host";
 				maximum-speed = "high-speed";
 
 				ports {

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241014-x1e80100-usb2-dwc3-set-dr-mode-host-35312d1d25b2

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


