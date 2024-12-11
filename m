Return-Path: <linux-kernel+bounces-440917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540B39EC66C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C8E281F92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADE41D86CE;
	Wed, 11 Dec 2024 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtT1HajO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211541C5CD6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904204; cv=none; b=LZqbYC59LT5VgIqHRUrCwnR4UXTqz344i9l4b65ZwRK1XABi+c9sYKcIeDzP3YR+WwpbFupmbLa35RgtuZH8693dw75V9Rtmv7r3+STKBtaWYrrYOKYv0yO+x4LardAEKVIqhUV0xfjCUjbL8Ne7dgfjxzx93o5qGgD9ESxPzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904204; c=relaxed/simple;
	bh=iFi/F/6SDkMbs3FLKC847CfXuURF9MluQ2AJKvuBTQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZzlozKemPkIgTDN4d0kPawcomqk/Vlb1i+y30ZldQW9fOswqttw4qbZByTKy/6nYc6te9ZDa6F0MbQs2uGFVCkD0qF+ly7LEX6lGPov2Ll03pc7nzz9Tj56hBeZRaj6V6CjN6qIyA1/7V6ZwXxzzu7fJaQHDrsvSw3DsDAxOUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JtT1HajO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434ab114753so42454675e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904201; x=1734509001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PiNaI+58XsVknLA1Lj1zNnrtDeSnTdMypwBV7C0twA=;
        b=JtT1HajO83tgaj/ndl5R4IMresL5lZDf51MLeY/dn+0I/lBwjhx98R2vfrmRl8YPVr
         mhWT3jbEt/pSvT8eTUPaPu1AEq2eLXv13fUlLkh/G0XX4E5/NVimaWdvnsHcQm5+ELL7
         8t8bLjXEAbpD9frzLZyXS3Het3QKJ/XlseWyETzuUzEz0I2plfv+h55aaiI9Ga9BIuvi
         iFsYFT+JWcHqe8eGnakOBHth3GKMPioyXyRCP30svGxqhZxqfiTCQDvOf3ESreJXAZFx
         LVu4oiBqPlDjLW6Mbp+lyJvIMy3w5z+E2bXfwvUqZDQtAI87igSiEUwPI0Kf6k3UoiT8
         xzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904201; x=1734509001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PiNaI+58XsVknLA1Lj1zNnrtDeSnTdMypwBV7C0twA=;
        b=Ae1xoPbuqX8Wnh5mEmw49dGfw+Z+EL6TgkTUmBUSr/kMJ2OFbZGO99JtbK+/lF8zYy
         +9GxFR+o9dTtE2jE59d+8Tzmik59ZYdrM3eo3sQYAI/wcTG71D6+BRg2IICcPZv9C6pV
         m4990muuXLAO82OofFbVPuuP9VHi7x5mWgGBL1EVB8yQXQHKvnlC+rsRwAJ/dMcbEVpa
         cWqswWejenxkkzYDqBD6mHWjNLXRKKkAvQPcgJe3BphdBAt722BG6JQXB0aQuGx8heDa
         J8pDewLBRNLaAPs8ZBxwQRQM9unaChA1JfYmvpJxI2m33bajLRdxLwV+uWO2gayV+csX
         7DGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV95vSFGRThXEEqBlraA+ufeSxrWM1naP/rNbY+Rtpgz90eJXZONBGQa4o0tqOySJWk712rgO3K9JWsZPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Dm7GBtT0tCopA23dSD2UmDbD0+VBri3rPXpT9JbBGRnv3/t8
	DnfG4+2YvjB05AGNjiX/piDgyPbf+EZo/yfXlw00vY5HfcaHgyWr283pPwKCd/A=
X-Gm-Gg: ASbGncub2YN0gg/DMNOK9eLva4IFiOUtaP2qKtv7lH1QhWVJeAmCVvoNm4ihXJ0dYqH
	0SVxfKQwLwjbMNHo6AeuXe7Tlzm7CXi+O6YFVY7sxt8fqWZAXH/UtGVyrvKX47U92HDLb8ZEJtD
	npi/MAmTNy2Z4jmHrx0AbTr2G4j98kYBGDAcIvjb7sc5DoiqhhJ42aa3Igayo12U73srpJSW+4U
	OE9k5aA+KkVTVWjHWnXN1nQCZPWlRqdCYyYPiU6v7hFbtA4H/GYG2a50GFqyjPjN8Rg3GJKO9c=
X-Google-Smtp-Source: AGHT+IFIa9K2ooKH+yf4pub3tf6FgNzwViaCApX/+vCKr6Tt4XxCLq5NTkvMegbLDdl/2ZN1vO3KXg==
X-Received: by 2002:a05:600c:1c87:b0:434:fd41:171e with SMTP id 5b1f17b1804b1-4361c4413ddmr11315085e9.33.1733904201397;
        Wed, 11 Dec 2024 00:03:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361b09fec0sm24205795e9.4.2024.12.11.00.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:03:20 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Dec 2024 09:03:10 +0100
Subject: [PATCH v3 2/6] arm64: dts: qcom:
 sdm845-db845c-navigation-mezzanine: remove disabled ov7251 camera
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-topic-misc-dt-fixes-v3-2-010ac10529b1@linaro.org>
References: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
In-Reply-To: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Felipe Balbi <felipe.balbi@microsoft.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=iFi/F/6SDkMbs3FLKC847CfXuURF9MluQ2AJKvuBTQs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnWUdCfhdQiroFOvy+y31ac8RVVLabbSYAOj9jMrbv
 q96YI9qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1lHQgAKCRB33NvayMhJ0aXJD/
 9k/7j0u28Jl6jK55IAEpmJk/vGMP5yFpyF99ERXabLhb+zAw4pv14CV39wgzXojFsS4QcAGDfws928
 OVhsDN/sISlR1PRtinEIZ2rp5Cc1uueKI/HGjiojf/WMfkzo4RjMbtHo/orZVHQVoo0Oc3V168Lg7n
 PRRmpjMcaRw0UqW0grWKQRCfFF3eRnJjbAlgSzMS2f9rEOsuGrEeGAMZkO62Uo7qGWI74XLpV5sUa7
 9/Y/0XDNBi/8tAvpZdcNze/fxJqJ+u6B1PcS4PDAPejlK87qHZ6SNtGDODAAaMgevcrk7gRHT1fY4Z
 FR1fbztTfuIzIHOovBhhunQx/9AZKJ9GTlo7rmQxiLat6DvO0Axiw2IYqpMMAT74WsRSYBQVOv0Gan
 MwTSvNGYvmHqZbHJG8sWMkREjHdydlRUWJvkOEtJlYDkUeC5attdk6wOdlxuOH3WaS2w1hXbSnKPRO
 ifBSkRDjYYJDLKMmvhPEZbLsEsR6JI5mmmktFuiDmuX3qm0DXs88CdNUeR/+HaLdlD7Cb888C66rdA
 YequJT5ZhnZskcPVSKgA5TDb4GLezK7kBfVFyl5EMvBSlY+M1twOgsnbQxFJJ3lvP3S5VBa629+ykw
 LlrFUlMaXndugOg45lG/3hxW/ol15VDTR+Ah28FG04Is86kSQPvizp0BKBxA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The ov7251node has bindings check errors in the endpoint, and the
camera node was disabled since the beginning. Even when switching the
node to okay, the endpoint description to the csiphy is missing along
with the csiphy parameters.

Drop the ov7251 camera entirely until it's properly described.

This obviously fixes:
sdm845-db845c-navigation-mezzanine.dtso: camera@60: port:endpoint:data-lanes: [0, 1] is too long
	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../qcom/sdm845-db845c-navigation-mezzanine.dtso   | 42 ----------------------
 1 file changed, 42 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
index 0a87df806cafc8e726aacc07a772ca478d0ee3df..59970082da45203311146cc5249298f6188bf67a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
@@ -79,45 +79,3 @@ ov8856_ep: endpoint {
 		};
 	};
 };
-
-&cci_i2c1 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	camera@60 {
-		compatible = "ovti,ov7251";
-
-		/* I2C address as per ov7251.txt linux documentation */
-		reg = <0x60>;
-
-		/* CAM3_RST_N */
-		enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&cam3_default>;
-
-		clocks = <&clock_camcc CAM_CC_MCLK3_CLK>;
-		clock-names = "xclk";
-		clock-frequency = <24000000>;
-
-		/*
-		 * The &vreg_s4a_1p8 trace always powered on.
-		 *
-		 * The 2.8V vdda-supply regulator is enabled when the
-		 * vreg_s4a_1p8 trace is pulled high.
-		 * It too is represented by a fixed regulator.
-		 *
-		 * No 1.2V vddd-supply regulator is used.
-		 */
-		vdddo-supply = <&vreg_lvs1a_1p8>;
-		vdda-supply = <&cam3_avdd_2v8>;
-
-		status = "disabled";
-
-		port {
-			ov7251_ep: endpoint {
-				data-lanes = <0 1>;
-/*				remote-endpoint = <&csiphy3_ep>; */
-			};
-		};
-	};
-};

-- 
2.34.1


