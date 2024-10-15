Return-Path: <linux-kernel+bounces-365766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F299E9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A1228292C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEE31EBFFC;
	Tue, 15 Oct 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S29PHP+G"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA671EF0A8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995126; cv=none; b=jI3SQicvfe5faUaFcrvZWN2YUfeHctke/x77AflAyAHm6IzI/UWKxWOu1IqTIOJ1p3Vg8N00je4N77BeLnDlnJAPwmTqS5GLCdCg216WYCW8P36IUtDUq3XMEA1LUNCZNWfvAMXrRNpoDQDoqPmThwWuzGiQk1yS8wGj6stysFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995126; c=relaxed/simple;
	bh=8/dJqUKHoHiWpotdIPtckagmH6omzFbOZy15zNq6Fbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OHOwLn0EiYqFaCQHK3vwKsEyOuteLWIDBtbz9Q1lDbezAnyY4F4YTFLSBHScMlbGIiSVXHkHyBXdeLNq/vNv5TupDjSu+IFvQ3UGuT0BWvPuPus44kZ02nL5AWR6Kzw+wApVJ4/94+IO7UlUA7+O+vD3c3WU7F3puvJiJtNmwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S29PHP+G; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-430f6bc9ca6so41894355e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728995121; x=1729599921; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+gp4l/50SduzN/lmdO32dTYxyMF1YPRRneVVHTLVqg=;
        b=S29PHP+GvjHSDSU8A3LTSC2IJ77YRElE6UJSOfD2om+W4/F5q4Si4cXO7foTi2Q3Ym
         NPQpzcQrZH3sCzsuYzsEvaXf0VtY8RZ/TzYQiImEPHE6QB4W4XrPWQZhfeqlPvPD9TrE
         hw10eOVjIaR2NJg7I/LMWJM6FlT2XfgbhIBCymegx7fM7A7R/l9lbo6USEfAdSkQ1LaE
         WNqA2W4gCeVGshurT1wSHja3B3s6EjcyGonHcqCbbVOKBnXcithfRbprs9cT5JrbU3cO
         pTI4zFmsHpgXwXon9uY/wQIacGuycuyrv1WRSvMu5oyCI3U35EGr98EPijmT5WJ5IWkt
         znmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728995121; x=1729599921;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+gp4l/50SduzN/lmdO32dTYxyMF1YPRRneVVHTLVqg=;
        b=hLBCrPpGiqxWAWE3hvUqVpMF36cMatiZXNvVLs90PvGxpq1lxnJAFS9pN0jQ/+G9Qm
         WM+ctQYHxjiWjJ/751hpHBzkMi5ygKNyVXiz+pm/XB315tQYErIjjieiWVrR2/MRXssO
         KMx2qJXLPDq8rrFlRmTaNI+ALrMZCKC3nVljxmYOWMOSepq/ZRibxHlmsGu3f4NwjfXf
         eAloZBy9G0camfZo25p8DKcLcE6pD/E2mlktlj4GflrvtTh0j9jBE5up8vZ0HN2TZUFi
         4PWbaCyn/WB2KHYoswm6NovGinct2IfM69pfWPJFin55sLlWWMFE5wGwOL0Q6PrlKwBL
         v6CA==
X-Forwarded-Encrypted: i=1; AJvYcCWDHNNE8y8CCGNDGJDKtlJAtPIyunopJC/xmJ1dsbs4BI5zry2vzBOV+VVeXQEZ71E/tfOiA7QU/XJJ9Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEJ2wlTKzM58geX0+HlemcuNBw1+s+M32Kr+ljfm+ra+eazvu
	GUKJscCgOf5XfuA8GDjnpNj6YcR4KyYSyAfZ+rt45gXTln1Ib7HYM6WAOFV3wis=
X-Google-Smtp-Source: AGHT+IFlId/8agayFjLT3bFk0RAGaoAIUIY+X5SSXMtLCClm1D3EKBtuUnv1vBbE5WOeMrhSlBEt5Q==
X-Received: by 2002:a05:600c:1c9c:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-431255dc851mr98091695e9.11.1728995121341;
        Tue, 15 Oct 2024 05:25:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa90818sm1458517f8f.53.2024.10.15.05.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:25:20 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 15 Oct 2024 14:25:19 +0200
Subject: [PATCH] ARM: dts: amlogic: meson8/8b: remove invalid pinctrl reg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-amlogic-arm32-upstream-bindings-fixes-pinctrl-dtbs-v1-1-c7291f17063e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAC5fDmcC/x2MywrCMBAAf6Xs2YWm1kr9FfGQJtu40DzYjSKU/
 rvR0zAwzA5KwqRw63YQerNyTk3MqQP3tCkQsm8OQz+MpjcXrLmwQxu3HH6UeB7wVbQK2YgLJ88
 pKK78IcXCyVXZ0NdF0V/dPE+rH42ZoO2L0L9q9/vjOL40peVKigAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3733;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8/dJqUKHoHiWpotdIPtckagmH6omzFbOZy15zNq6Fbo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnDl8vgS5uSivFjIPnmceCyX/RG5XjB6Tqcmj1njr/
 HWof4xOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZw5fLwAKCRB33NvayMhJ0fIpEA
 CVZ4yqkZXYGGsOigVICNaTxWO54gBjqQaqa5C2fgKZpzNUQck2JSO+52stZxjGDUWOqAzGlEuf6PLW
 n4WMlZlvlnSHubd02tG5Bg8rdY0RPQeQCb8kip7x9MXTqGUwWrPeVMzihGjVp9RY41REs93QWdWjes
 BbqloJefnvEWvWikaFEL/nZ50DXARjDlG+OFxpWk9263zqZrXur76r2nOd0L/ouMc6RLQvlzjwahVW
 fLcS4IAAYG+QsXgaOHshvc4Kedc777jmpWSfZgPeL7diWB+dRZOaHHr9ziwsZo1ChPCaC2SPBY2nhk
 AdJPrdDNmJmcLV+uSMiP/uQOcdj+EC7ScTCqoA/QopyI1qt7tvXrlnuypQo/sZ6YKqD2JQ7uqn96Kf
 Ki+kp4JXZlNZBtHw+40bS7G7Es2UEnMTNM6Zb9fk+9EGVmSTNBUXFucqY9U20N/yU29rkUi/KWE0ns
 l0v4IW07sY6OqrYUXycole6vHmx0GTe9BJoF2ax1ngJT+W7sFclma5hZBZ6VB0u2ars1H2amu+ZoEL
 smOeAqwNhUdqnVge13EzJuGVb1+uf/NJd85uCj1M+ujNRmOem4eY0sLWRq6TSYxOrz7DmwSK/JLa69
 /greYJbS7PlEnCnOpL5r7si00kJyP+M2RZuAXaXrBkZoooLvzfBBCoC04Row==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The pinctrl aobus/cbus was originally here to configure the
GPIO interrupt, but it was a bad design and was moved to a
separate gpio_intc node because the GPIO interrupt is actually
separate from the pinctrl/gpio registers.

Drop this reg entry, and fix all the register offsets with a
proper range property.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson8.dtsi  | 28 +++++++++++++---------------
 arch/arm/boot/dts/amlogic/meson8b.dtsi | 28 +++++++++++++---------------
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
index 6c7596c8b96b..9ff142d9fe3f 100644
--- a/arch/arm/boot/dts/amlogic/meson8.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8.dtsi
@@ -346,17 +346,16 @@ pmu: pmu@e0 {
 		reg = <0xe0 0x18>;
 	};
 
-	pinctrl_aobus: pinctrl@84 {
+	pinctrl_aobus: pinctrl@14 {
 		compatible = "amlogic,meson8-aobus-pinctrl";
-		reg = <0x84 0xc>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges;
+		ranges = <0x0 0x14 0x1c>;
 
-		gpio_ao: bank@14 {
-			reg = <0x14 0x4>,
-			      <0x2c 0x4>,
-			      <0x24 0x8>;
+		gpio_ao: bank@0 {
+			reg = <0x0 0x4>,
+			      <0x18 0x4>,
+			      <0x10 0x8>;
 			reg-names = "mux", "pull", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -461,18 +460,17 @@ clock-measure@8758 {
 		reg = <0x8758 0x1c>;
 	};
 
-	pinctrl_cbus: pinctrl@9880 {
+	pinctrl_cbus: pinctrl@8030 {
 		compatible = "amlogic,meson8-cbus-pinctrl";
-		reg = <0x9880 0x10>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges;
+		ranges = <0x0 0x8030 0x108>;
 
-		gpio: bank@80b0 {
-			reg = <0x80b0 0x28>,
-			      <0x80e8 0x18>,
-			      <0x8120 0x18>,
-			      <0x8030 0x30>;
+		gpio: bank@80 {
+			reg = <0x80 0x28>,
+			      <0xb8 0x18>,
+			      <0xf0 0x18>,
+			      <0x00 0x30>;
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm/boot/dts/amlogic/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
index c8fbeede7e38..9e02a97f86a0 100644
--- a/arch/arm/boot/dts/amlogic/meson8b.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8b.dtsi
@@ -308,17 +308,16 @@ pmu: pmu@e0 {
 		reg = <0xe0 0x18>;
 	};
 
-	pinctrl_aobus: pinctrl@84 {
+	pinctrl_aobus: pinctrl@14 {
 		compatible = "amlogic,meson8b-aobus-pinctrl";
-		reg = <0x84 0xc>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges;
+		ranges = <0x0 0x14 0x1c>;
 
-		gpio_ao: bank@14 {
-			reg = <0x14 0x4>,
-				<0x2c 0x4>,
-				<0x24 0x8>;
+		gpio_ao: bank@0 {
+			reg = <0x0 0x4>,
+			      <0x18 0x4>,
+			      <0x10 0x8>;
 			reg-names = "mux", "pull", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -415,18 +414,17 @@ clock-measure@8758 {
 		reg = <0x8758 0x1c>;
 	};
 
-	pinctrl_cbus: pinctrl@9880 {
+	pinctrl_cbus: pinctrl@8030 {
 		compatible = "amlogic,meson8b-cbus-pinctrl";
-		reg = <0x9880 0x10>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges;
+		ranges = <0x0 0x8030 0x108>;
 
-		gpio: bank@80b0 {
-			reg = <0x80b0 0x28>,
-				<0x80e8 0x18>,
-				<0x8120 0x18>,
-				<0x8030 0x38>;
+		gpio: bank@80 {
+			reg = <0x80 0x28>,
+			      <0xb8 0x18>,
+			      <0xf0 0x18>,
+			      <0x00 0x38>;
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;

---
base-commit: b852e1e7a0389ed6168ef1d38eb0bad71a6b11e8
change-id: 20241015-topic-amlogic-arm32-upstream-bindings-fixes-pinctrl-dtbs-d7c996fd4116

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


