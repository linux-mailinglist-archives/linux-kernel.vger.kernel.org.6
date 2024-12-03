Return-Path: <linux-kernel+bounces-429892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE639E2849
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA9E287F12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2701F9EAD;
	Tue,  3 Dec 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="NR7QKOKy"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05D1304BA;
	Tue,  3 Dec 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244931; cv=none; b=IUucy++ciweyicPDt58Ls/dnmQGV2QTGUHXTk/ijFIgosM5has/nuRrSv3t/MofSd+JawMTUnMykn+7vpz9PoPfX0zSoDJhCecsX17Y253D0qteNCCw2n62kh6YgVTSzliMjmy75VIabmm4E+fqyRo/RAuRMPkiZSKS5iweRXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244931; c=relaxed/simple;
	bh=F0zC5lXTXkp7mhj/Yg346cmJRUfGg/TlUROcXVuQpVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYDMby3eERIx8iOy/QZKLH7o3ro00DITXiejMZBDzDdQGJzMtE8htPeIfnoVQrfiq/9LdFVnnkN1CifJKKUJuGcfJLctjXfoBeI6e33B15K+RqFqge/FFv+ceiQUPi0hGYoOxr5/YPTWQlfkVaUeq+v3xZ6xAIITDgP3SyLyGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NR7QKOKy; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s19kKZqorMy12heyo9Mo4URGtpRMRR7jickGZdEr+sg=; b=NR7QKOKyQ0EODJyKCo+dGdN4fi
	e7iGa16VK0TW7qN4hXtNO31qUpmAl1Qmkx97rGSo13DIW1jGTOTNnmvbDUu1chr8T+Tw/LXNJpUjL
	/MwaTXKz5/nObhrV2kOgWL3TP+7FdaAdeXupsUyEwgJB50yC0XAW1tz/o+ktyyMYFKL0gSazf+b0X
	w/1QCSXup8C9yxNGwVxmVLQQBkcubeP0WFhM2KFh8DA+7pPo6W8n/36IZmZUDcQ4/7BSiyD8ozrEn
	NVzbUeUBPoJ6Jx+6eiAwFqlKCVb6TnnqFXB2jqMYiJV9XIyHuPQl9BbqCwpaGh2vJtWhQlvhqtvg6
	V8mqK90Q==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tIWAv-0003jl-4g; Tue, 03 Dec 2024 17:55:01 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3 2/3] dt-bindings: display: rockchip: Add schema for RK3588 DW DSI2 controller
Date: Tue,  3 Dec 2024 17:54:48 +0100
Message-ID: <20241203165450.1501219-3-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203165450.1501219-1-heiko@sntech.de>
References: <20241203165450.1501219-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The Display Serial Interface 2 (DSI-2) is part of a group of communication
protocols defined by the MIPI Alliance. The RK3588 implements this
specification in its two MIPI DSI-2 Host Controllers that are based on a
new Synopsis IP.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../rockchip/rockchip,rk3588-mipi-dsi2.yaml   | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
new file mode 100644
index 000000000000..7c017e927223
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip specific extensions to the Synopsys Designware MIPI DSI2
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3588-mipi-dsi2
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
+      - const: pclk
+      - const: sys
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      This SoC uses GRF regs to switch between vopl/vopb.
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: dcphy
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: apb
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Input node to receive pixel data.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: DSI output node to panel.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - rockchip,grf
+  - phys
+  - phy-names
+  - ports
+  - reg
+
+allOf:
+  - $ref: /schemas/display/dsi-controller.yaml#
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
+      dsi@fde20000 {
+        compatible = "rockchip,rk3588-mipi-dsi2";
+        reg = <0x0 0xfde20000 0x0 0x10000>;
+        interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&cru PCLK_DSIHOST0>, <&cru CLK_DSIHOST0>;
+        clock-names = "pclk", "sys";
+        resets = <&cru SRST_P_DSIHOST0>;
+        reset-names = "apb";
+        power-domains = <&power RK3588_PD_VOP>;
+        phys = <&mipidcphy0>;
+        phy-names = "dcphy";
+        rockchip,grf = <&vop_grf>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          dsi0_in: port@0 {
+            reg = <0>;
+          };
+
+          dsi0_out: port@1 {
+            reg = <1>;
+          };
+        };
+      };
+    };
-- 
2.45.2


