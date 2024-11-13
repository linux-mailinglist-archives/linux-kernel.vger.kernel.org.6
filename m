Return-Path: <linux-kernel+bounces-408383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E002D9C7E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 23:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A661F2318D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595518C33A;
	Wed, 13 Nov 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="NJHZH0y4"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4918BBB7;
	Wed, 13 Nov 2024 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731535831; cv=none; b=OVtvxKDn9lHQayJdc5BkOlPi7/TB4AeJkX2p+MrpKucClHgJJPwvcwSAj2TjrzkdD0B+QjGNhCZWjfKAi/zP8Wxv7zD9p3mmAYAY5fDXt7gRuY0J+vA4OtNQ35lQVyAI6DUDr66eOU1C5sH5/WiRztm2e0lu/hy0aRQFsHfFuag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731535831; c=relaxed/simple;
	bh=lv5E6FmjTpbPjzeER9vodiPPQ8V3wI732JaaScBljCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4rAuZlVgCr2CJkji9lPokghg8ve34jSi7+fvjRoELK00dPN8nYxbRKzlD8z1s/vdMO9e8ife/Sv1DqJLlkwGWvtz/DHqa/Rdc/pbNl14SAAyq7bhgq1VpVGfpw3tzejgJD8C1dZWrNetcwQ96yLbR5gAJBP7mNoMpkIXOFcz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NJHZH0y4; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H7ufa8mWeHH7kIJ/+EFeOv+w26AWVh4SfYJF48wu07Y=; b=NJHZH0y4M4/90TkIfJ0QWgqXxs
	JBTZI0oJvmxqnzyt70gebAYNhDWTXunl2kQqzKX8mF7yhS4p8C3BMHZHuxVJFs1hbmhZSWz1r0QOw
	0XatlTMkoJwkXCVuTOeDqgJHHThQ3Q4BneQV+2MySN5p8Q8fTcwQDQmoaAOVaP6kQa66cEzZkyxqs
	AQsdzqzmBDL1l9FEsVOAdJASPVy7yN61HpyRTBqNOyj6TOGwSf2Kqca32sHuym7kscRmgNMd7iYaW
	TkH+Eeawp8Irt0AhATv5HznwD49lVWP3bZjqQ8tdsi70Mp9YwUDHnY2DiOTDNTEzfKKaeVDlZ3d6M
	+i4If9Zg==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tBLZ9-00069a-Aq; Wed, 13 Nov 2024 23:10:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sebastian.reichel@collabora.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY schema
Date: Wed, 13 Nov 2024 23:10:17 +0100
Message-ID: <20241113221018.62150-2-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113221018.62150-1-heiko@sntech.de>
References: <20241113221018.62150-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Add dt-binding schema for the MIPI CSI/DSI PHY found on
Rockchip RK3588 SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
new file mode 100644
index 000000000000..5ee8d7246fa0
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,rk3588-mipi-dcphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip MIPI CSI/DSI PHY with Samsung IP block
+
+maintainers:
+  - Guochun Huang <hero.huang@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3576-mipi-dcphy
+      - rockchip,rk3588-mipi-dcphy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: ref
+
+  resets:
+    maxItems: 4
+
+  reset-names:
+    items:
+      - const: m_phy
+      - const: apb
+      - const: grf
+      - const: s_phy
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the syscon managing the 'mipi dcphy general register files'.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      phy@feda0000 {
+        compatible = "rockchip,rk3588-mipi-dcphy";
+        reg = <0x0 0xfeda0000 0x0 0x10000>;
+        clocks = <&cru PCLK_MIPI_DCPHY0>,
+                 <&cru CLK_USBDPPHY_MIPIDCPPHY_REF>;
+        clock-names = "pclk", "ref";
+        resets = <&cru SRST_M_MIPI_DCPHY0>,
+                 <&cru SRST_P_MIPI_DCPHY0>,
+                 <&cru SRST_P_MIPI_DCPHY0_GRF>,
+                 <&cru SRST_S_MIPI_DCPHY0>;
+        reset-names = "m_phy", "apb", "grf", "s_phy";
+        rockchip,grf = <&mipidcphy0_grf>;
+        #phy-cells = <0>;
+      };
+    };
-- 
2.45.2


