Return-Path: <linux-kernel+bounces-291257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD2A955FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3ECB21A76
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5022015852A;
	Sun, 18 Aug 2024 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="Znqqz5Aw"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE835156F4A;
	Sun, 18 Aug 2024 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724020269; cv=pass; b=JMV4QYLkOhYATIpYEQTOhdpj8KXj8tGukwXqLMyvHaj4GTPvjdq7hFYRdoJM3GZ2/idwYVmnLFlCAaK+uVPecih6zxJ7fOzE7VSA07IWE+5A3oA02xRvxzmLtnVYDksnMzN3n7P05ArLDRqvHgGGIvKKuO7Q1VdTnKStWbY5kfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724020269; c=relaxed/simple;
	bh=tQ3lNr2mG3JnRRohNEObxb7z/SzxMh3D5B/fTZ5Zi8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fxsjqj475lNE2VnlBSawo02CEtA95UF1IkuSX1G93uLXP1QOUOMK9djVWq3Bz7liNx+xlGlANPBu5ZG+j/5g6DFCeIbxBcGcOG7ceMN+CHIj6lKa1PU91OMoRaKQ5VlWIoB0LuNUFNM1YMML+z/+KaRh16L90s03iPDtx3/0aK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=Znqqz5Aw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724020233; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SgPUgQf/UeZhJoLzRBfRb9laTIXYL1ab21hdlE6uWK7m1G/lYhb15V9LXdpDEwb0Q3YNiadYs7Lz6mZMJa6c5qXv5fsL0qXiiZt7RE3UrQudsqb1PPGqwO3OOULQEOHQDJS9ujW4STSr+mL3QRBUGUBR67uUjvXBkE5W6hTGTHk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724020233; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nC/oZKMdw3WsQfvOo0pfA0p0EDcHkRUTBPsDBOGiS2k=; 
	b=I1WauR6INSgkFFu6e06RcKedWkred8CKlvQNe43lTbt31PE3RfDq0eFhfPBLictvMTWPud0FR8rXMZoQlJWlTZMToiRNhCKjOYSd5GMP90/0vE8aVzcv4vbMATzOYUQ0qS608aobGW/9N56q2TsJwVWwp6E673oJCcDliWHT+Ck=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724020233;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=nC/oZKMdw3WsQfvOo0pfA0p0EDcHkRUTBPsDBOGiS2k=;
	b=Znqqz5AwbhXI3+V7IIj51r14zumYxYKRGW17DRkWhwG3cmXCFtWtFzup82L8Pc8R
	GEPwhL52U/Beq1VN36HMgp3pyCoPzM9i8zQNOftKLIwpyStUkz0zbXaH4joHYeCFrFj
	a/9mTPdh/dpEC2gt6U8p0NKkAOFEWFdiK9CWgy7Q=
Received: by mx.zohomail.com with SMTPS id 1724020232556475.6936891079573;
	Sun, 18 Aug 2024 15:30:32 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 19 Aug 2024 01:29:30 +0300
Subject: [PATCH v4 3/4] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-b4-rk3588-bridge-upstream-v4-3-6417c72a2749@collabora.com>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
In-Reply-To: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI 2.1
Quad-Pixel (QP) TX controller IP.

Since this is a new IP block, quite different from those used in the
previous generations of Rockchip SoCs, add a dedicated binding file.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../display/rockchip/rockchip,dw-hdmi-qp.yaml      | 170 +++++++++++++++++++++
 1 file changed, 170 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi-qp.yaml
new file mode 100644
index 000000000000..de470923d823
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi-qp.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip,dw-hdmi-qp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip DW HDMI QP TX Encoder
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
+
+description:
+  Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI QP TX controller
+  IP and a HDMI/eDP TX Combo PHY based on a Samsung IP block.
+
+allOf:
+  - $ref: /schemas/display/bridge/synopsys,dw-hdmi-qp.yaml#
+  - $ref: /schemas/sound/dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3588-dw-hdmi-qp
+
+  clocks:
+    minItems: 4
+    items:
+      - {}
+      - {}
+      - {}
+      - {}
+      # The next clocks are optional, but shall be specified in this
+      # order when present.
+      - description: TMDS/FRL link clock
+      - description: Video datapath clock
+
+  clock-names:
+    minItems: 4
+    items:
+      - {}
+      - {}
+      - {}
+      - {}
+      - enum: [hdp, hclk_vo1]
+      - const: hclk_vo1
+
+  interrupts:
+    items:
+      - {}
+      - {}
+      - {}
+      - {}
+      - description: HPD interrupt
+
+  interrupt-names:
+    items:
+      - {}
+      - {}
+      - {}
+      - {}
+      - const: hpd
+
+  phys:
+    maxItems: 1
+    description: The HDMI/eDP PHY.
+
+  phy-names:
+    const: hdmi
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    minItems: 2
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: ref
+      - const: hdp
+
+  "#sound-dai-cells":
+    const: 0
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Most HDMI QP related data is accessed through SYS GRF regs.
+
+  rockchip,vo1-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Additional HDMI QP related data is accessed through VO1 GRF regs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phys
+  - phy-names
+  - ports
+  - resets
+  - reset-names
+  - rockchip,grf
+  - rockchip,vo1-grf
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/rk3588-power.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      hdmi@fde80000 {
+        compatible = "rockchip,rk3588-dw-hdmi-qp";
+        reg = <0x0 0xfde80000 0x0 0x20000>;
+        clocks = <&cru PCLK_HDMITX0>,
+                 <&cru CLK_HDMITX0_EARC>,
+                 <&cru CLK_HDMITX0_REF>,
+                 <&cru MCLK_I2S5_8CH_TX>,
+                 <&cru CLK_HDMIHDP0>,
+                 <&cru HCLK_VO1>;
+        clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
+        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "avp", "cec", "earc", "main", "hpd";
+        phys = <&hdptxphy_hdmi0>;
+        phy-names = "hdmi";
+        power-domains = <&power RK3588_PD_VO1>;
+        resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
+        reset-names = "ref", "hdp";
+        rockchip,grf = <&sys_grf>;
+        rockchip,vo1-grf = <&vo1_grf>;
+        #sound-dai-cells = <0>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+
+            hdmi0_in_vp0: endpoint {
+                remote-endpoint = <&vp0_out_hdmi0>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+
+            hdmi0_out_con0: endpoint {
+                remote-endpoint = <&hdmi_con0_in>;
+            };
+          };
+        };
+      };
+    };

-- 
2.46.0


