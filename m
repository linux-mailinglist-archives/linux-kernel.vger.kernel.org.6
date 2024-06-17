Return-Path: <linux-kernel+bounces-218139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7790B9AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9006428490E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE11991CA;
	Mon, 17 Jun 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRQtJl4C"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1C51991A3;
	Mon, 17 Jun 2024 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648982; cv=none; b=flMGx7ajv36h6vmoDorz1tZuKWINqSuql5W5S2rXAhScDu0YTzpkwO/dT7xWGwv5tpGW2rfhLPWes0lX04ayE66iNu3dLxn2DCUVM3doYXSVXt0naUSIFgO5X8TjZYguLkCQmnhSrHXBk/4wJ5pBp1aA99VXtbMsU1pmb1LzRnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648982; c=relaxed/simple;
	bh=x+wPPy/GT45CFx+KMeVvr+U8rd4Mn9UoMyfj4WLHlu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lBzPcXQMCp2kpB/dP7iqMz48UPOWbMxTqz0L/o6pN75giP1FRGu8RCCJVqYwxgC3zw0lF9loh66/1B+wcSHgTZLO8z9wWgE1FCZlR2WWB+Pg9A/RggDYb5ntD/uRavTLgjNdC3EUDU4gSbMKafOSLi5cpTIBz8FS33w9gZiCugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRQtJl4C; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6269885572so972097366b.1;
        Mon, 17 Jun 2024 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648979; x=1719253779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxV0+CNtkdVYH1x9kSCG5RzOw/h70yxEWn9Ic920/Ik=;
        b=SRQtJl4CjAsVLj0FQR8hEVgwJE5YWbiY62NOfxSlYjNTaezxtVc0oyp/nuvrFE+LrD
         zUuILIzo+Rhuu7Y4DiUVQZp5QpU8O/Xxs5lRKtGoju+HRVdGeVTgkQzMdbpZsxOqryI1
         OyhaE5TJwo3ODLjrz3pv992uLc+3puEIS0kHGZUwgzp2V3Dh+cCnB3S6fnPXmRT3vJIr
         2+Gq6CIvIBXXrKG075B5xo5wG7lNmxswULhjzHz/un0E+y3dse1TBIKmiDSvbzKD3+o3
         oUUvDFjS5OypwH/HjVmUHNaRt8zPseWcRuYhnhZUsXrNP91bUWs8NEFK9liJhnirz7We
         YByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648979; x=1719253779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxV0+CNtkdVYH1x9kSCG5RzOw/h70yxEWn9Ic920/Ik=;
        b=aJyGa6QZ/2HHxJd5mSD0AMyeNDgo2/uZOKumzzbEy0UD+ir8CRj+j6BHu4QAUeJl91
         wwz/HsrbJ/w+Mk/z81teUGSzQVWKmcj4/p8STUhT+pDD5pxDLtGoQrYXFePjoWhyQzBV
         apD9n+GT9to0gE+ddn+YsbmjLiO7BUUnk+Yphq/O5gxYVIE/RPlVhRciFfMNbKjgMM+N
         IbromAxl/vjvKU+UxLQ3UUVS2T6tubxDbww6SRICHczoal2RfZGrEhUI3MP7yBm7HIhX
         ELHxFA/u0aflYvQRTHDver07JeiAM+ImZp3kgvuvqddGfRRb/WnBXRKk+14lVx4Ata6C
         db1w==
X-Forwarded-Encrypted: i=1; AJvYcCVXTvRoH7bLScv/OHzzGPrClkrBbjTkzAPA/W4pBPn4xP1y8eQG478jQB92sMkGtk1DdpCYiyCuHEWo5a+mlF4+R4S2p0g1Ei83RTnvtiXl4AH2spiaS3S+jZQP8/uZgcxFdGXNgovdxA==
X-Gm-Message-State: AOJu0YwYSRdmq35OemS0+tfciWWBh61WnrofbF5HqVB5FB2EPhaMZ+mO
	gnbzb9I2vwb8cRVf5eHb/lKzu5bqCjfVQteM86y21v9WbIMSWVGc
X-Google-Smtp-Source: AGHT+IEZlfgBaA7udUA6Yyx+6kNVUdF3NhrpH2DNXQq9GPGhbSiujY7u3ln3Ha5DervXVTuQnyQ12g==
X-Received: by 2002:a17:907:c00b:b0:a6f:9643:e8b8 with SMTP id a640c23a62f3a-a6f96444968mr13704466b.32.1718648979243;
        Mon, 17 Jun 2024 11:29:39 -0700 (PDT)
Received: from latitude-fedora.lan ([2001:8f8:183b:6864::d35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8a6e58bdsm115397666b.187.2024.06.17.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:29:38 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 17 Jun 2024 22:28:54 +0400
Subject: [PATCH v5 4/8] arm64: dts: rockchip: enable automatic fan control
 on Rock 5B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-rk-dts-additions-v5-4-c1f5f3267f1e@gmail.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
In-Reply-To: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718648960; l=1732;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=x+wPPy/GT45CFx+KMeVvr+U8rd4Mn9UoMyfj4WLHlu0=;
 b=NJUPm95L+pz2C2VM8nrMIvvzzMyFYQ0HF7Hm/4dFduLIvCnrJxE+w1acYjyMZ7+punC5bsaWC
 DP9TpxoR6b5DYXVG3Vb5k7kv4TVEehg2rEy4zUHGPGml6l+Dzux0cOv
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This links the PWM fan on Radxa Rock 5B as an active cooling device
managed automatically by the thermal subsystem, with a target SoC
temperature of 65C and a minimum-spin interval from 55C to 65C to
ensure airflow when the system gets warm

Helped-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 30 ++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index afcc38a5bed8..27dd95f92f33 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -52,7 +52,7 @@ led_rgb_b {
 
 	fan: pwm-fan {
 		compatible = "pwm-fan";
-		cooling-levels = <0 95 145 195 255>;
+		cooling-levels = <0 120 150 180 210 240 255>;
 		fan-supply = <&vcc5v0_sys>;
 		pwms = <&pwm1 0 50000 0>;
 		#cooling-cells = <2>;
@@ -286,6 +286,34 @@ i2s0_8ch_p0_0: endpoint {
 	};
 };
 
+&package_thermal {
+	polling-delay = <1000>;
+
+	trips {
+		package_fan0: package-fan0 {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+		package_fan1: package-fan1 {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map1 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+		map2 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &pcie2x1l0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie2_0_rst>;

-- 
2.45.2


