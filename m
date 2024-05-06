Return-Path: <linux-kernel+bounces-169586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029958BCAD8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4121C21E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BB21428FC;
	Mon,  6 May 2024 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYroXZrC"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0911D143874;
	Mon,  6 May 2024 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988246; cv=none; b=VBEpuwSpXqzkHoiyptkBbhAXRV8ogdH2z282uf4BlYox8jaWVihTk1aPwc4yKvcB303RxBWVdE2EPgE5dq/SXstemjF+yIGs5ScXMxMakWFKLp5eSTRJvpnEg36q2wYdiSU+XJaeJfYRaOD92zJTzOa6z7y7hqqQcdL+eqIi+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988246; c=relaxed/simple;
	bh=M2euxf6Q8SBg4Hukc8wh3jha9LlUxWfNoH85/fD9b74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmfQtk+QLjg5aEY9HNOq2KwoQn6OJsRqgk/kfv25G6rdlX3R+H7rZybUXeE6zWpdiJXGOMHvsCtDi/j1uhIcb2BS4nrvv4sI8wpkQXI/6rOAeg0AtAsvPrT0VKpQyOUn6so4rzARmxROcH8RdZDhYR3K+Z6HQphIxAtzKXMR+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYroXZrC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59cf0bda27so73010266b.0;
        Mon, 06 May 2024 02:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988243; x=1715593043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IN8AzJhjBwWtAAosg/wWfPeK9DB1fotvNa0tcVkBcLc=;
        b=QYroXZrC7fLlziWNuCoEMV5+0cGIZerqp2JHAo8FqaL+ZJeqvGqoAlkbEcrKNDNN99
         KAXxBNMuDNRxl8zaBD1mnLiTkQzoCOWvIjNNNK+1OeFo94VmiR+V94mtwWe6llYYdXlM
         TD7TIljIqkHchTnWqyVX6pjFFNZwyqtrUCHAHI/oTG/vLepA0WRAJIDEcTbNmpJ7qps/
         LuF9w4g7poh741qCMGDz5iz9H0sWk6id5KhM7c2IBBc0w6dDH90DhGC7iyxLQaJlZr94
         uqUCeIbVwx3e2vMABfS6uJawXKxO1/kR2fZ1oKOfT6UbcjW7NCPQQmOb3/8gzpEnh6R6
         fQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988243; x=1715593043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN8AzJhjBwWtAAosg/wWfPeK9DB1fotvNa0tcVkBcLc=;
        b=dVnslx0+y6NW5QppjXBDtj4gUyCY/iD3h5sZQjdL2lzOU9d8UxLR4//ICwxAzudRXi
         1diMv9T29QHJfWTMO5oJiDdxo7kc0NfnRnoygfdUSxbCNmts8dlUCrRN2SxotHxX8YDE
         ijUC/smrpxRKnDmryjwp2Y7sNgCAWpibB8nuL4FC8OtLCmyisGweDw1KgEQ7hwsEZPKR
         l6jDmR4kW6zcuqaODUsO0Hl0VUaddQLEcZ9nO027CPY79xiyEfgNG68aE6B2WWdVRWGu
         FYPOAQurIGvUkEqrideIDv7zB135cngY2RXDRRVeI0yuyLo60XEGP6gfKC0AmIyX9Aig
         lckg==
X-Forwarded-Encrypted: i=1; AJvYcCWAlD6IhMg4CSflQTYFkkUHBYr3s7L+UReCHY2TYZjpCU8FN1m5qxmaxPNcgfIPcRaUiNZ4IJ4LW39PFGPVR1/zMwb3VY5bEvHu0A+oJm8oya7/VJnNYVC7bKmoe/BdZoyLRIJ5vgMvnA==
X-Gm-Message-State: AOJu0Yw8w6qyj3QZCcxRjnrHBLp73p6LAvPuLBh4wHOa2kRMyD9qhqjI
	7c5g+/ObRzcnvGZtWXBPxh3QLZESUv0FpWluC087XDhzzzuetuhF
X-Google-Smtp-Source: AGHT+IGcY5JPNQmvChpfcdsIQTFh32yMe02GUq9RVZ7zy32Rbqb4gkVD+R9OuRJFJ0k/WupnQcSi9g==
X-Received: by 2002:a05:6402:7cb:b0:572:d4fc:cc7 with SMTP id u11-20020a05640207cb00b00572d4fc0cc7mr6753577edy.12.1714988243075;
        Mon, 06 May 2024 02:37:23 -0700 (PDT)
Received: from [172.30.32.119] ([2001:8f8:183b:f2c::d35])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402160600b005722ce89ae2sm4983647edv.38.2024.05.06.02.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:37:22 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 06 May 2024 13:36:35 +0400
Subject: [PATCH v4 4/6] arm64: dts: rockchip: enable automatic fan control
 on Rock 5B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-rk-dts-additions-v4-4-271023ddfd40@gmail.com>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
In-Reply-To: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714988224; l=1732;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=M2euxf6Q8SBg4Hukc8wh3jha9LlUxWfNoH85/fD9b74=;
 b=MahjJ0I2pQJ4AW3JzNQC9fccwUyhos/l9FLjyPDexr0mdVocKlMIJIoQ564q3b6hHPkFvMV06
 d43aMKeL9/xCskjRFLK+lSYGdbjw526FpglZ7y4rHmfArWI/C/9Otwf
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
index 21e96c212dd8..b70313643af8 100644
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
@@ -279,6 +279,34 @@ i2s0_8ch_p0_0: endpoint {
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
2.45.0


