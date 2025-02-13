Return-Path: <linux-kernel+bounces-513912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 400CBA35027
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2737A454D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A0269816;
	Thu, 13 Feb 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="UyWQrri0"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0E266B78;
	Thu, 13 Feb 2025 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480788; cv=none; b=iIPlBM3iNAz27UB4alZsXma1SnA+EUPGa/YfuiDr5ekmzMprpyZvacTgu+IuempaQGH5r1IkI8LQRLeqyyI8SpuQUodCLTy/xZBbEpck45/GJuhC9yQ0HSC3sw9W0lndvSKEEkvYJFB2vcsufU7QLy8rJSNKyq2DRIqHpqoCnrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480788; c=relaxed/simple;
	bh=3tFaTvFQTkwIx9h7jpRjIoSdngbdR6x/1hAEEFdKF6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PK8/104WfTepem1pP/IvzXBxvatGTlq55oF4IAsGlhXmF9SK7A9CP+9Ol6kkd02TQRrdROpeOSrnWOlkkMGkYYxJuBJhf3sLvYo4F5TD1HNAXPOsXrneJFbzRU7z4YpscQvPZvmU1a0T0fTS0vcU7rxeQSkM5MWfROUYALVHjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=UyWQrri0; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BsG0d/imTYQP9d0JqoCLk7g5rxR8R590EgJ5QvdKLdI=; b=UyWQrri0zUMR9lDhNQsvt/azJI
	2CITNHmRV/+cuqTK42hNM9ncsE9O4F4CDPRB6KdRMACnFSG54xM/V71fYNnkpNFWTiy7PpYxnwFUx
	XtAGr9tfb8s70MNaecdycwxPcep9Qp8x49xibhQD7vUPLOaOYrAMlpsE4RmKaBekJGQ38ySvLMSNU
	pKWBO2pC+Nodbs1J27xmWIieZecrbYmvA27K9rfDKPVNHVGfpFxmnALHUxCJW1ZqEd2SKlKiYimeu
	+ITGretgdOUTgeKv2CkLeyjH9QLD+9oHpscAggwyOIsiw4UPkU7bZtjwibC07eNkdoD94eGajhBe6
	us85BrmQ==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tigPZ-0006WG-KN; Thu, 13 Feb 2025 22:06:17 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com,
	heiko@sntech.de,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dse@thaumatec.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 1/2] dt-bindings: phy: Add Rockchip MIPI C-/D-PHY schema
Date: Thu, 13 Feb 2025 22:05:47 +0100
Message-ID: <20250213210554.1645755-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213210554.1645755-1-heiko@sntech.de>
References: <20250213210554.1645755-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Add dt-binding schema for the MIPI C-/D-PHY found on
Rockchip RK3588 SoCs.

Tested-by: Daniel Semkowicz <dse@thaumatec.com>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../phy/rockchip,rk3588-mipi-dcphy.yaml       | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
new file mode 100644
index 000000000000..c8ff5ba22a86
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,rk3588-mipi-dcphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip MIPI D-/C-PHY with Samsung IP block
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
+    const: 1
+    description: |
+      Argument is mode to operate in. Supported modes are:
+        - PHY_TYPE_DPHY
+        - PHY_TYPE_CPHY
+      See include/dt-bindings/phy/phy.h for constants.
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
+        #phy-cells = <1>;
+      };
+    };
-- 
2.47.2


