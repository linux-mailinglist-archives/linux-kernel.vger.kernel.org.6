Return-Path: <linux-kernel+bounces-325227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90766975674
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AF41F2267E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C158019FA6B;
	Wed, 11 Sep 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWV8Y27g"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92BF1EB2A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067355; cv=none; b=or9OiXHB2+QtgLRcmG8lnVwfWugs2bl0LSlq0p2DgSpNikA8pEBVZMTrfMJfaHEknBxJqcuw5mrqeJ4jbmAERECwy2ItTTq0F4QluRDLSlQra9gNK9NSkcyUx26Xso8CFuFZf0dFMr26q1TPmCDvb/AhdTEngf+sTWeZVr6hh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067355; c=relaxed/simple;
	bh=svPrUDRaKTqHQLVdWxyhvAXQB+X4yADudTbd99RZ0iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SBce3iiK7U6ibUgaMYnvz6hTE5iU+lvAGXWIGaH7B1VPxbXZjlSmyTiFLCk1ZduRwBjiHTcTmlE6G4NjSptTZtyjt7aoI2Ov7I1i7gpxqfQDMwCpcR7PBVYkP48WMhC+5AZNVpD1pMcgv4N8ZJjS1kP6omHFYL2eaxCq1sawrdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pWV8Y27g; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bbffe38e6so54030405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726067350; x=1726672150; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVkYHpudqLYcdqxUnypmWz6sNt1ioeqBftj88K8uSJM=;
        b=pWV8Y27g3170f5o5pW2e7rffqEEA8vGvOzrapUqpdS5G1Al/p3kjLyZIh+kHNc29E1
         j+LtGwq3M1P0tYdU9HwZsQiSssJOtctlhjV0zEguXBkMRrGNu59NSOYmdStGbv6vQmNe
         Bv2LYEU7+lAsxuOpAi46cI3hWHiZOfGWgmVnX3aNTW4M1+53kW8Buf3zha54d/0BV3z4
         yj1Foad88S07GTrjMrWw7NdRoQGuziw8BPTN6I0Eq+Y0KTDbRjfIDPCs2ECqirvhIvkJ
         7kxASHf4d/fRaxYHCpBu8QMNHQMmvKH/Ft1zWRX4ay8gh+v1zPYZTKy6VS0fLafQ+gPI
         FqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067350; x=1726672150;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVkYHpudqLYcdqxUnypmWz6sNt1ioeqBftj88K8uSJM=;
        b=v7hcSwsNUPGM4N7LluARAfT7vjlLg19sRWzSUE5BQ5LuFjCPJJX4Lu2jpkVcCx5HEF
         XW59dhrZ0VYCMQQGUADZpWVSjjcPYcI5/xv01NCCaLSwMylNz7OWf4mv/HAmHUp78vv/
         LVMqfHaJaugfQNgM62Br6J0zQZXhfhiq4B+3vgLp2VUPQOexmLvz7O8vIZLZ60Clp7+R
         0vkR9YFuFguiKxW9WGDZuGh7tK1dHov4V+5oKiSY+YEYw7zPA1fGgB11dlt23P5zPbP7
         hTuEyzQZhr+vpLNhYThOOK0ZkcWtHgGJwF/TOY/jBv8WtGooGNLo0zKE9aI8YLaLLQdJ
         3fCw==
X-Forwarded-Encrypted: i=1; AJvYcCUvjVjIFwfXbWOX4q4VwfOw3KYbOdiPAGtxODcIlhTEosGZMTdE9MdbyLqlp5LVKWZu12a0VqBeJGBJtMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74FlKQBVp2zsntVYOpp+oIJ3u/RS9mVDnQPdNxHI3aKLg47lW
	YFfjR90tT/+H1yrtG7o5+qKOXI2PMzOLwwrkA2FPuk2+R1/ioL3EFMgQqzVHfAQ=
X-Google-Smtp-Source: AGHT+IH022ElrpZNSsZueuLvqwSqa0DsURDewSDN/7/BlSUlDy3q43WfoF2DOa5dbvVyxrr6XGoQBw==
X-Received: by 2002:adf:a186:0:b0:371:8cc1:2028 with SMTP id ffacd0b85a97d-3789268edeamr8594650f8f.14.1726067349432;
        Wed, 11 Sep 2024 08:09:09 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564af1asm11823756f8f.18.2024.09.11.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:09:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Sep 2024 17:09:06 +0200
Subject: [PATCH] dt-bindings: clock: convert amlogic,meson8b-clkc.txt to
 dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson8-clkc-v1-1-e0b8623c090d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJGy4WYC/x2NywrCMBAAf6Xk7EISLT5+RXqIyTYuNg92YxFK/
 93oaRgYmE0JMqGo27ApxpWESu5iDoPyT5cjAoXuymp70ldjoJVKHlxaSvyR09HCu0pjdAkelAP
 lKDDTBwV8yStyg4RS8gX88vJwDujN6LQbZ636pTL+4z65T/v+BUUypTuRAAAA
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3984;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=svPrUDRaKTqHQLVdWxyhvAXQB+X4yADudTbd99RZ0iE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4bKTWdNSgq/DYRLr3ma+kl4WNK7Nd3+iJsaMzOD5
 CEo7ZdyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuGykwAKCRB33NvayMhJ0e0wD/
 oDpZ78Jn9TyUC6J2jSTfmVFEBJJtajhn5hTHTB7QZWRtuXk7SeaTYOGhD8gqgSZvL3huAqNBnB3FZ1
 IFPJRY5FUApWNMC1ArDXrjH3UIDWZbZZsTWnc+xInp6aiuEm4fEJvlbp8+rERZ/y+CbpeZseKZi1A1
 lRRqkDHfjhdau2kiKJ06xKGgBjBYNr1cTibv6OliiHwHx33wknl0gR2b4CT2kU+L4w+3RwjnHqRxyO
 cmPGTogM7D6Qnr2yQdvymgCLyPqu9HuaPXWH+hAcjr12kLj5iRxh5yoArUoYzARBfwxNxEPjvY4Kr1
 qcAB1AMGUZElNLvnp7gAVkIpsD1rCa92yrD2wkhNy6O59YI3XX/ziyn4IxeRqizOquxYpemosCv+an
 Xpobp5UpgT4rqaybTbAMrJvqloPVvXp56FXtj8qBVIAVqb8RfhutlP/Ro2X0BP5UphH5qsuwnaHajy
 epprp49pMOKwIeznTcyNOqeErQj2xiwtYY+Eq5xtj62ZqmfAx6G4fGKka+L9As0e4DZQAumbpwJL0k
 pITRIcuQYrHuNryR/ZLKdwPFpAB8Ne8egEvjA8I6glYIJA5LYO5RsO7p8emTWFa+M0r4WF3nzmi3xY
 TShErry4bkwzIFG2X5XcfWdszv4IhjJXPigldD5Hj32PKa2MUG8VYqgeeJYQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the Amlogic Meson8, Meson8b and Meson8m2 Clock and
Reset Controller to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/clock/amlogic,meson8-clkc.yaml        | 45 +++++++++++++++++++
 .../bindings/clock/amlogic,meson8b-clkc.txt        | 51 ----------------------
 2 files changed, 45 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,meson8-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,meson8-clkc.yaml
new file mode 100644
index 000000000000..ab73d4654171
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,meson8-clkc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,meson8-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson8, Meson8b and Meson8m2 Clock and Reset Controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - amlogic,meson8-clkc
+          - amlogic,meson8b-clkc
+      - items:
+          - const: amlogic,meson8m2-clkc
+          - const: amlogic,meson8-clkc
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: xtal
+      - const: ddr_pll
+      - const: clk_32k
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#reset-cells'
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
deleted file mode 100644
index cc51e4746b3b..000000000000
--- a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-* Amlogic Meson8, Meson8b and Meson8m2 Clock and Reset Unit
-
-The Amlogic Meson8 / Meson8b / Meson8m2 clock controller generates and
-supplies clock to various controllers within the SoC.
-
-Required Properties:
-
-- compatible: must be one of:
-	- "amlogic,meson8-clkc" for Meson8 (S802) SoCs
-	- "amlogic,meson8b-clkc" for Meson8 (S805) SoCs
-	- "amlogic,meson8m2-clkc" for Meson8m2 (S812) SoCs
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-- clocks: list of clock phandles, one for each entry in clock-names
-- clock-names: should contain the following:
-  * "xtal": the 24MHz system oscillator
-  * "ddr_pll": the DDR PLL clock
-  * "clk_32k": (if present) the 32kHz clock signal from GPIOAO_6 (CLK_32K_IN)
-
-Parent node should have the following properties :
-- compatible: "amlogic,meson-hhi-sysctrl", "simple-mfd", "syscon"
-- reg: base address and size of the HHI system control register space.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/meson8b-clkc.h header and can be
-used in device tree sources.
-
-Similarly a preprocessor macro for each reset line is defined in
-dt-bindings/reset/amlogic,meson8b-clkc-reset.h (which can be used from the
-device tree sources).
-
-
-Example: Clock controller node:
-
-	clkc: clock-controller {
-		compatible = "amlogic,meson8b-clkc";
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart_AO: serial@c81004c0 {
-		compatible = "amlogic,meson-uart";
-		reg = <0xc81004c0 0x14>;
-		interrupts = <0 90 1>;
-		clocks = <&clkc CLKID_CLK81>;
-	};

---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson8-clkc-7dec15a0a5f0

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


