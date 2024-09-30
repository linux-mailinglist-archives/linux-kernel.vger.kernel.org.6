Return-Path: <linux-kernel+bounces-344902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0084498AF71
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F291C20A48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3686188925;
	Mon, 30 Sep 2024 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nN98jtTC"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFF18454E;
	Mon, 30 Sep 2024 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733010; cv=none; b=qqoPm2llcAQeiejHUpFtdfQaPPn+O4FfqTAUItEsRcNAxf01EHPeutTSJhRNQpBLPn3Ve5N5DsdnbKJ4mVWTM3VH4Mu7VIbuiQr/swnGeWlwdia7fMWG8Vty/LytDjUnk+bX97S9YcZmX7/b3lsWC47WqtTEgV3Kdip5Cx+OHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733010; c=relaxed/simple;
	bh=GnyvN13QXknxV4Cd2rfU762ru5Lqfx9k/fzK6jNUkY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5+GkU68Om5TIgpwL8FGuEXpBreJuCvEj+tJUe3pTs7h1fsqd5CwosdPuABowlgccB0iB/Xlx+D5J641ecBpOZ8TbmZjyp5j5sCToqx7YcamPoFuq0pvarV6M21N3SxVegfeUhJDh4DIv4V8biAzfTfm8fHVAaUjc+2ZjmjIU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nN98jtTC; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IV3S3N6JchgjR+3Hvyobg+DmDYydj+06VEKK0P502y4=; b=nN98jtTCPJq+9YSJ9wIQl+1Psg
	Zs3kXZK+HBffSlmvbjCNQc8GAyukgTreU46MPbrs1QKUb5UKTXt0v3mc8pexG3G40tU4oHMo3NVk9
	pJfjfATWEDRICMrmxd7enhRZtR1SR3FyUC5LpA23BMeFZBJWus1kzcOYOjPK90ZXkSDAWHUW6zaYW
	2kH9TFMLa6qqdaRr12LQQEwBmrBFcC25RfrZHjcIVW8Q9vlD1rlJuqMSxmV16eM54aUt/llKbsaIz
	tdJT6njEYL184II7KJpFwry0PCB5LQk5wRC6AQyM0ZDdkp7aDqDqZ5CGaq88CjOUw55YxlQ5UL8dz
	JsIG8A6g==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svOHL-0008So-Io; Mon, 30 Sep 2024 23:50:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jbx6244@gmail.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: clock: convert rockchip,rk3328-cru.txt to YAML
Date: Mon, 30 Sep 2024 23:49:59 +0200
Message-ID: <20240930215001.1999212-2-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930215001.1999212-1-heiko@sntech.de>
References: <20240930215001.1999212-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Jonker <jbx6244@gmail.com>

Convert RK3328 clock controller bindings to DT schema

Changes against original bindings:
 - Add clocks and clock-names as the device has at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
[add Krzysztof's review from v1, shorten commit description]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/clock/rockchip,rk3328-cru.txt    | 58 ---------------
 .../bindings/clock/rockchip,rk3328-cru.yaml   | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
deleted file mode 100644
index 904ae682ea90..000000000000
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Rockchip RK3328 Clock and Reset Unit
-
-The RK3328 clock controller generates and supplies clock to various
-controllers within the SoC and also implements a reset controller for SoC
-peripherals.
-
-Required Properties:
-
-- compatible: should be "rockchip,rk3328-cru"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Optional Properties:
-
-- rockchip,grf: phandle to the syscon managing the "general register files"
-  If missing pll rates are not changeable, due to the missing pll lock status.
-
-Each clock is assigned an identifier and client nodes can use this identifier
-to specify the clock which they consume. All available clocks are defined as
-preprocessor macros in the dt-bindings/clock/rk3328-cru.h headers and can be
-used in device tree sources. Similar macros exist for the reset sources in
-these files.
-
-External clocks:
-
-There are several clocks that are generated outside the SoC. It is expected
-that they are defined using standard clock bindings with following
-clock-output-names:
- - "xin24m" - crystal input - required,
- - "clkin_i2s" - external I2S clock - optional,
- - "gmac_clkin" - external GMAC clock - optional
- - "phy_50m_out" - output clock of the pll in the mac phy
- - "hdmi_phy" - output clock of the hdmi phy pll - optional
-
-Example: Clock controller node:
-
-	cru: clock-controller@ff440000 {
-		compatible = "rockchip,rk3328-cru";
-		reg = <0x0 0xff440000 0x0 0x1000>;
-		rockchip,grf = <&grf>;
-
-		#clock-cells = <1>;
-		#reset-cells = <1>;
-	};
-
-Example: UART controller node that consumes the clock generated by the clock
-  controller:
-
-	uart0: serial@ff120000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0xff120000 0x100>;
-		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		clocks = <&cru SCLK_UART0>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml
new file mode 100644
index 000000000000..f079c7a2559b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3328-cru.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/rockchip,rk3328-cru.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3328 Clock and Reset Unit (CRU)
+
+maintainers:
+  - Elaine Zhang <zhangqing@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  The RK3328 clock controller generates and supplies clocks to various
+  controllers within the SoC and also implements a reset controller for SoC
+  peripherals.
+  Each clock is assigned an identifier and client nodes can use this identifier
+  to specify the clock which they consume. All available clocks are defined as
+  preprocessor macros in the dt-bindings/clock/rk3328-cru.h headers and can be
+  used in device tree sources. Similar macros exist for the reset sources in
+  these files.
+  There are several clocks that are generated outside the SoC. It is expected
+  that they are defined using standard clock bindings with following
+  clock-output-names:
+    - "xin24m"      - crystal input                          - required,
+    - "clkin_i2s"   - external I2S clock                     - optional,
+    - "gmac_clkin"  - external GMAC clock                    - optional
+    - "phy_50m_out" - output clock of the pll in the mac phy
+    - "hdmi_phy"    - output clock of the hdmi phy pll       - optional
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3328-cru
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+
+  "#reset-cells":
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: xin24m
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the "general register files" (GRF),
+      if missing pll rates are not changeable, due to the missing pll
+      lock status.
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    cru: clock-controller@ff440000 {
+      compatible = "rockchip,rk3328-cru";
+      reg = <0xff440000 0x1000>;
+      rockchip,grf = <&grf>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+    };
-- 
2.43.0


