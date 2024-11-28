Return-Path: <linux-kernel+bounces-424857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E909DBA59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F217B22755
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE041B6CE1;
	Thu, 28 Nov 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nktGNZIY"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8351BD9C7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807015; cv=none; b=F9S+CFpCH24dMIfHOU2Kc+/b3+xGUniBRc9U9JCPP+TTQEbUBlmDYqtdYijsWd/wn84gK6ix2WP7tm4AlCghRfcpeymL0K8v9RNm5ewqWfybvTl3uxXOBLTxOut9ZclGNwAu+/hPaurWjKYwXLATDRCLoFT55xpEfYdBm1HWiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807015; c=relaxed/simple;
	bh=EyHdKYQSzhp6Q5IckerUZg/bcUhVWP1QC3wdvMtdE4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkP3XMzVpnBn4xo+pebmkTEaZG51O7Lx6/Puif8CR1LDN0Ks/xaxBWKWoSCChVubo+ISzMxzERZBHlGp1y6uh7Gs1crfmIplOjPKcPm6hjMuWNv4I4N6l9xP2lxnba6w88iTujs0TNdSkWGazXl3VGAcv1V5BW4y2oj8shmaYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nktGNZIY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434ab938e37so5994225e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732807012; x=1733411812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzpFYlwmRDjUdywRFCwk3EMOwG1W4Bvy7VRMs6AVjzU=;
        b=nktGNZIYAxR7N0RpoNTV/b7UVj0G+NbbNf4HWCA/S84MSEW6LSdG08quZL0zVVEIIP
         KDhB+Lne0aRt4yNkbnXLyMLqZw9AJAVpt0xz8s/2qP57BcSh9U2WQw6nZZDV1av6V4XE
         0yJd1BGzpriC5oxXI/VAtJcH3j5sQJtgQWq/HKrK3i32dDOUGe7UX/G/nV7HgnQdNQx/
         utIsf63kYCqc5E9rDkZLyl/RC9dBAn/tqTRLJI+N3heRrpOrGkeOvtrRx26vEu8rnH2m
         J5YpVvZ1o4DS2c3HGwgsNH+muNtDsu5s145SUlx6UAwIzT1YPF4blNagiyo+NPyrxhM2
         CRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807012; x=1733411812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzpFYlwmRDjUdywRFCwk3EMOwG1W4Bvy7VRMs6AVjzU=;
        b=OnZmBVinfCV0wuNpVfxt1yILzg+sUQCBW5xhimfhXFzfqoCGbv80n0lhWfYHXBZoVT
         1w9bSvhM0ga7zR2B9lYIrdOCmHsUfPRKG4e6P9uUIKs35hsGb4PfU27VlwzhLeCCEx0R
         Id0uadyYhWC2eB5Bf3mx6iO9PT0SZK9G9xO+jwVK8bYIjB+bisYbqHP6NVMDaHE/HGSP
         jw9YGt8UdolJdnQRlWSUYdEzRf3nbcs8LWScVCbpnz3g+Hz5SEoshaYI2MvMd6Yc/Q7o
         E0VosfumoVrGR/1Je/uuV06aPfxjLngn1ta55qzmkG8ra++d6ctXhAwuIcj3GXPPGJVk
         Ckhw==
X-Forwarded-Encrypted: i=1; AJvYcCX8ONjqcxLCIgIdqroRW2Q+Xf+wzuxflThkcYR2fGAoRUI7dSlMSyjMuNTjvwG5hsQy+npttzXyZ2pkTbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpo7jhRMOcwO36nrrgf53srK0xni0vD146j68tE9CyoURJY0md
	/FsoK8wBIZnyL6H7uEoU6HmzUnOVs/kcHMxCjvgjM1SpL3aY1Q7VrxlQvtX3MlE=
X-Gm-Gg: ASbGncvoxmIdmIAvClvLzoCu9vqx3lGcr8Boqok/wfdS0LYUirrBK4dq3bbF4/BNmuj
	DiGqAIluD7rJz3Uc8RSMr1zlE3Qa4knO9k+mtXXx9ABwyuW1tBJ9NQcWVzRLRWpb5JK5Lic9YUD
	iZgf9iUR8FIGcfNTYjigQ8HnoV8dD3Phwlgei/tVaQO92ObSPzpZ58pyi/2dCLKhbhIL9ctVCaV
	3K09dYBxvlLxAlr5bQ+Hy+eh46KTcLGBe5N0cADqe1XDaC6pUaenFnMA8rC3R2Q69Bz398=
X-Google-Smtp-Source: AGHT+IH4AIKDNQTGuzrRL5OCcaR5+oCwqwuiQGkqb+Yio/Cxxa2N2THu7Mb64eFoUBklqJHWFxGrjw==
X-Received: by 2002:a05:6000:1846:b0:382:4d6e:9f3f with SMTP id ffacd0b85a97d-385c6ec0b9dmr6474374f8f.34.1732807011807;
        Thu, 28 Nov 2024 07:16:51 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4fe1sm55867025e9.38.2024.11.28.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 07:16:51 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 28 Nov 2024 16:16:45 +0100
Subject: [PATCH v4 5/5] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt
 to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-5-11d9f9200a59@linaro.org>
References: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
In-Reply-To: <20241128-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v4-0-11d9f9200a59@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5272;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=EyHdKYQSzhp6Q5IckerUZg/bcUhVWP1QC3wdvMtdE4Y=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnSIldLzAfDGWjxNDmzJ2/2WMIp1sGGnOvNvp6JCAp
 myNjCKKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0iJXQAKCRB33NvayMhJ0azxEA
 C0McuYqWQAYwfk2xajPs3bcX+BmlzuLuas2bMzBD/me9jZu2mkdUG1VEwoolEX0gCO6JlqxaxQJ4WM
 wL5TOWyl98rq7QvpGteUK8etgNs2ID4qhKX5hsWLrDH4oFKHIg776KlZ16WwFxrM9zotbWNMva+AMr
 PN2wCcOX42276Z2sU+fwg0/lzdd9L6FPWHRy5eEpK0aQHmiDQj+xWmpVF02Rpy5PZfZLrrFk0JKfYn
 kMwv8pGldajb1UUUNMVjgVjW3nCPo6TR2mKVgq07cyTxpi/BpzMzsx7mKZyQRV1wIhs/0vaSqGGoR8
 PtPicnej6Zrj/gBQ0Rx41nTgYe1ymgeHaeu7hTpaGuswR1U4Yst4g4st1a9VRP+Z3+aHaE9G68NBGW
 EFEGhsTm7hiRiOpOm/e4mIwZNv8BHi2KP+D8nWhyGQaMZQNCOoFsYII+g1gTq+O57co/vJIJGoPCS7
 HiFh3roegB3Z1kHpgZfMy+n26Nq6UgphQZK9vM8DIcEtNg+hpAvS+D2SArm9nd7UVMq3GLHcRwABCo
 znU/pLdQSIlPfCbgFBobDgij0o20asawXWTryI8DjRMq5MWYv1IFkyqg1upLB3lmE/KKIGgVc+oyRs
 rKG7qfGo4UICqZfJVFM5ejB7HSDuzO9FBcPhkyYtfPmmG3r90+p5BpLOl+yw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
bindings to dt-schema.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/mmc/amlogic,meson-mx-sdio.txt         | 54 -------------
 .../bindings/mmc/amlogic,meson-mx-sdio.yaml        | 94 ++++++++++++++++++++++
 2 files changed, 94 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
deleted file mode 100644
index 8765c605e6bc761db2923ad748b5bb70d40ea830..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-* Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
-
-The highspeed MMC host controller on Amlogic SoCs provides an interface
-for MMC, SD, SDIO and SDHC types of memory cards.
-
-Supported maximum speeds are the ones of the eMMC standard 4.41 as well
-as the speed of SD standard 2.0.
-
-The hardware provides an internal "mux" which allows up to three slots
-to be controlled. Only one slot can be accessed at a time.
-
-Required properties:
- - compatible : must be one of
-	- "amlogic,meson8-sdio"
-	- "amlogic,meson8b-sdio"
-	along with the generic "amlogic,meson-mx-sdio"
- - reg : mmc controller base registers
- - interrupts : mmc controller interrupt
- - #address-cells : must be 1
- - size-cells : must be 0
- - clocks : phandle to clock providers
- - clock-names : must contain "core" and "clkin"
-
-Required child nodes:
-A node for each slot provided by the MMC controller is required.
-NOTE: due to a driver limitation currently only one slot (= child node)
-      is supported!
-
-Required properties on each child node (= slot):
- - compatible : must be "mmc-slot" (see mmc.txt within this directory)
- - reg : the slot (or "port") ID
-
-Optional properties on each child node (= slot):
- - bus-width : must be 1 or 4 (8-bit bus is not supported)
- - for cd and all other additional generic mmc parameters
-   please refer to mmc.txt within this directory
-
-Examples:
-	mmc@c1108c20 {
-		compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
-		reg = <0xc1108c20 0x20>;
-		interrupts = <0 28 1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&clkc CLKID_SDIO>, <&clkc CLKID_CLK81>;
-		clock-names = "core", "clkin";
-
-		slot@1 {
-			compatible = "mmc-slot";
-			reg = <1>;
-
-			bus-width = <4>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..022682a977c6d347c36279f958dcd6f53d385b71
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/amlogic,meson-mx-sdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
+
+description: |
+  The highspeed MMC host controller on Amlogic SoCs provides an interface
+  for MMC, SD, SDIO and SDHC types of memory cards.
+
+  Supported maximum speeds are the ones of the eMMC standard 4.41 as well
+  as the speed of SD standard 2.0.
+
+  The hardware provides an internal "mux" which allows up to three slots
+  to be controlled. Only one slot can be accessed at a time.
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - amlogic,meson8-sdio
+          - amlogic,meson8b-sdio
+      - const: amlogic,meson-mx-sdio
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: clkin
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "slot@[0-2]$":
+    $ref: mmc-slot.yaml#
+    description:
+      A node for each slot provided by the MMC controller
+
+    properties:
+      reg:
+        enum: [0, 1, 2]
+
+      bus-width:
+        enum: [1, 4]
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mmc@c1108c20 {
+        compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
+        reg = <0xc1108c20 0x20>;
+        interrupts = <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clk_core>, <&clk_in>;
+        clock-names = "core", "clkin";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        slot@1 {
+            compatible = "mmc-slot";
+            reg = <1>;
+            bus-width = <4>;
+        };
+    };

-- 
2.34.1


