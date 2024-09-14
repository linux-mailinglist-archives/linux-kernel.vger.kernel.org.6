Return-Path: <linux-kernel+bounces-329117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CCA978DA7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858B9B2474D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9518E126BF0;
	Sat, 14 Sep 2024 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVoJ8qtR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFB449649;
	Sat, 14 Sep 2024 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726291532; cv=none; b=YmB0yJ4H4bPS3hoxHpf9RFPWt6FdrxVnp0PzDigf2HsflKHTwGVRz3R1lxe2T3ay7UagAEtzAH8uZeTVDSyxBD0R479LRPk2MV6y1WNzxoHFWyVZ0EZtAUxaD1lkadP7GAeLMNmwXD3FZshrMNp9LzesAzTdtbsmJNsrnAJUMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726291532; c=relaxed/simple;
	bh=XxOwoFH80Bhk5qESbi1I1pviMO4Ixnnb+WUrAi02KNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ixz9zKq/bvOC38mQ7z0o4KeYBuHYfiz9KWdcWz4j1dH3txe2GtTiJe68IvWIjmfY0Rlt6oXNiBbUESQlXTmn14otAzNr+xJ7TDZJbcW3xdRsiOZI+byommG4dZ81ZqvSNqMv1MHYJtlBY8bhBD/+UQ3CcUt3VBmlMpDouIx3xQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVoJ8qtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 698BCC4CEC6;
	Sat, 14 Sep 2024 05:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726291532;
	bh=XxOwoFH80Bhk5qESbi1I1pviMO4Ixnnb+WUrAi02KNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EVoJ8qtRaS2sV7hcYyvvwwk6rXga7bS2sH7cy7Q0+1RgFgAoilX0oHnaYM4zNpbmy
	 lMe0wIf6DMAWOtr8SE+CNWnnMyPESAqc6XL4E80RhVtgq7kKd4m9rcoZ+bh2SxI2xK
	 jse4DcplsIx7ESdnA9KpShWDum9ib2ZRMvd5CN+WpEhd5Glh+sLmt38bbe0BDdfCr1
	 DPcKCICjoEbO2KujWaXbj/86zIkx2KhBxVF2SWb08rToxLt0UnBVCTzSi2tuveYpfj
	 vvZtg73TN1JHWKELvoe2tfPbvzdo6v0pFloezMoqOFb+PpEVOGOReVb693NMe+V9HX
	 0gg0xOC7eS+vA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563C6FC618E;
	Sat, 14 Sep 2024 05:25:32 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Sat, 14 Sep 2024 13:25:23 +0800
Subject: [PATCH 1/5] dt-bindings: clock: add Amlogic A5 PLL clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-a5-clk-v1-1-5ee2c4f1b08c@amlogic.com>
References: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
In-Reply-To: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuan Liu <chuan.liu@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726291530; l=3134;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=lsom9knZP0lHkNe6jVzPiJ0BTgKhyMmo+ZKlPTInwcA=;
 b=yS6oZdIBel/t0WlOzbHPs8yDp55NT8uCAIH90lPpC1SKuLiNj9Pbfo9I1AFRulbMfX01vw5oT
 F2ERa6kW2UIBRQaj8an7TTI67sJqClsKT+CDUPc4/aV8C/Ae9DqH1FQ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the PLL clock controller dt-bindings for Amlogic A5 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 .../bindings/clock/amlogic,a5-pll-clkc.yaml        | 62 ++++++++++++++++++++++
 include/dt-bindings/clock/amlogic,a5-pll-clkc.h    | 24 +++++++++
 2 files changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a5-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a5-pll-clkc.yaml
new file mode 100644
index 000000000000..ef9e40193a1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,a5-pll-clkc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/amlogic,a5-pll-clkc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic A5 series PLL Clock Controller
+
+maintainers:
+  - Chuan Liu <chuan.liu@amlogic.com>
+  - Xianwei Zhao <xianwei.zhao@amlogic.com>
+
+properties:
+  compatible:
+    const: amlogic,a5-pll-clkc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: input oscillator (usually at 24MHz)
+      - description: input fix pll dco
+      - description: input fix pll
+
+  clock-names:
+    items:
+      - const: xtal_24m
+      - const: fix_dco
+      - const: fix
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@8000 {
+            compatible = "amlogic,a5-pll-clkc";
+            reg = <0x0 0x8000 0x0 0x1a4>;
+            clocks = <&xtal_24m>,
+                     <&scmi_clk 6>,
+                     <&scmi_clk 7>;
+            clock-names = "xtal_24m",
+                          "fix_dco",
+                          "fix";
+            #clock-cells = <1>;
+        };
+    };
diff --git a/include/dt-bindings/clock/amlogic,a5-pll-clkc.h b/include/dt-bindings/clock/amlogic,a5-pll-clkc.h
new file mode 100644
index 000000000000..a74c448a8d8a
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a5-pll-clkc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AMLOGIC_A5_PLL_CLKC_H
+#define _DT_BINDINGS_CLOCK_AMLOGIC_A5_PLL_CLKC_H
+
+#define CLKID_MPLL_PREDIV			0
+#define CLKID_MPLL0_DIV				1
+#define CLKID_MPLL0				2
+#define CLKID_MPLL1_DIV				3
+#define CLKID_MPLL1				4
+#define CLKID_MPLL2_DIV				5
+#define CLKID_MPLL2				6
+#define CLKID_MPLL3_DIV				7
+#define CLKID_MPLL3				8
+#define CLKID_GP0_PLL_DCO			9
+#define CLKID_GP0_PLL				10
+#define CLKID_HIFI_PLL_DCO			11
+#define CLKID_HIFI_PLL				12
+
+#endif  /* _DT_BINDINGS_CLOCK_AMLOGIC_A5_PLL_CLKC_H */

-- 
2.37.1



