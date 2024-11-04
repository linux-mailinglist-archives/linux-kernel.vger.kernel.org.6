Return-Path: <linux-kernel+bounces-394750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316A49BB377
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BFD2846C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83EE1CC89A;
	Mon,  4 Nov 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1HJLf9jm"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EF61BE236;
	Mon,  4 Nov 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719775; cv=none; b=igtjxRHyL0BDcQgsxAiJHeIp9OI+acwryvuv3ZAotpbfzySDcnft+qJEPOYr5do8ewPbRVc2+T5VbhL4U9P4hebL9z6j9jLRN4o94wjxwLndW6rsv5Xo2Wyr9Nd28GmTmBXsNIofbz7crHmJaxnAy5+llKium+u57AKScYigTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719775; c=relaxed/simple;
	bh=TqYmO7TchpJni0BOJ4Ulic5D/k8PpVXj9oulp5vtLbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6bCIouC+9H34IOyQUOM95X9bAyTllYhjH/Hblf24CFhsCyO73IUs25bzxsN92YfJMEFXN/HNxm9FkhFfPobB2Y2xX/K94VqjsrUSHNEqO/I2yqTVZQQ8RK+Igbm2E+Cq8cHRg1KC/GhzZ22AHLXMXvoFs2WnWSTF+siRDO445c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1HJLf9jm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w7/g9Zj2Xo2MH4IP+M9trsnCfhBTMntQIjnavN8DZS0=; b=1HJLf9jmM9s95Zeo2dMrYuLuxI
	mRnZoHCiIAEKOYTTDGFkLsuzT124zTSYLTfHsyuBJrZBHM3J3mkviGV1JRedlt/rR6YPqFsVN3xZI
	qe5SNkeP/3QHB+RQA9e2uyOVVLrLT+P84ENu0Q4r1IO8CnYgdIsIaufybY5cxd1kQHDha19dwq9tY
	LGFndaYSdoT7qkJVkLdkKP/gyGK4AqOkpGIht3Avh8H/IoGnklhG766XWpwAy7qfIrVEI2M+N/89X
	3Zr1+hkeMuS2lj/ST8GWTydWHOrOyxyd+R5EtjX6GKZqyWB0okHXaAjS0jcvITcsJ7wQBsICICCf1
	413YuubA==;
Received: from i5e860cc9.versanet.de ([94.134.12.201] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t7uzy-0008Vi-Qx; Mon, 04 Nov 2024 12:11:54 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 1/2] dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY schema
Date: Mon,  4 Nov 2024 12:11:15 +0100
Message-ID: <20241104111121.99274-2-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104111121.99274-1-heiko@sntech.de>
References: <20241104111121.99274-1-heiko@sntech.de>
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


