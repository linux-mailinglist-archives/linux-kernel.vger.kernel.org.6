Return-Path: <linux-kernel+bounces-519656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 998ECA3A056
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40E617881E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4064C26B94B;
	Tue, 18 Feb 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZoAkcpcR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53892698AD;
	Tue, 18 Feb 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889605; cv=none; b=A3K5MRtXie5fn9+M/8vBwns34Uhw+ZXSNrFUxVHn/YqjcIN8Q1aQEgWB10btYw8nWSdLL0VXR4nSdRDUsBKU0lyDjMLfcPRNtfPPgOl6h/gGUnBBDRPrUJiYPNFudkYHBELCeQi16rmWc42+wlwuve0ceqe+nCdLrHFixCXOWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889605; c=relaxed/simple;
	bh=ER6W0b2g/2UyJF4xz5QxxKZrGpaDX+db+NCwoIJ25Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6/6NYfkVtILo2z2wrC5ui9UB0sQo3VWTz05LvqCfG7nT3KifLg7FYeb4He2WWwAfJPr1H0bTpeiJW8MP5AhUJcv0F7vCrQT3AvvyMxLGGzQFKCGcdFM6hQaZDKchBdC067Ph1QZsc3WG1nAuP1HCoVKNhRrDBw+NqLwXN8IjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZoAkcpcR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739889599;
	bh=ER6W0b2g/2UyJF4xz5QxxKZrGpaDX+db+NCwoIJ25Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZoAkcpcRui2PWffSNXX42wMnSf0D2kVlNRAd4NeVspxV+/Z1ZcsDqiuSr43/g9+xU
	 xHqHmbRX9rihQyqCSaEGTRSaFgZM1Dwr7TdYe32ekbLwNVJJ4xL0l6fIgRereB0eDP
	 f46sKAZbB5Bsfh+cbfRvSqgoS5TSyuZVRJDx/otEirS6AN4LpxLDKYHNlzwUF9gwnf
	 /CV9kYTgslrscbcAE6O55GoTg7+wKO5/zksHh+s6fWkwIwINNX3CYwtBzTxgX6csha
	 kMBSaQcfYe6FjHi8W2re1E7fbA1ytmcwL4RLw6rdUTHfw3SkZmMakPCp7OxiXL2x5b
	 NLlaQFvLrCgPg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2666417E0657;
	Tue, 18 Feb 2025 15:39:58 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com,
	christophe.jaillet@wanadoo.fr,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add Himax HX8279/HX8279-D
Date: Tue, 18 Feb 2025 15:39:51 +0100
Message-ID: <20250218143952.84261-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218143952.84261-1-angelogioacchino.delregno@collabora.com>
References: <20250218143952.84261-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Himax HX8279 is a Display DriverIC suitable for driving LCD
MIPI-DSI panels.

Describe this DriverIC and the Startek KD070FHFID078 panel found
on newer revisions of the MediaTek Genio 510/700/1200 Evaluation
Kits (EVK).

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/display/panel/himax,hx8279.yaml  | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml
new file mode 100644
index 000000000000..d66191398f50
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/himax,hx8279.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax HX8279/HX8279-D based MIPI-DSI panels
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  The Himax HX8279 is a 1803 channel outputs source driver with MIPI
+  TCON, which generates the horizontal and vertical control timing to
+  the source and gate drivers.
+  This DriverIC is most suitable for 1200x1920, 1080x1920, 1200x1600,
+  and 600x1024 panels and outputs full RGB888 over two or four lanes,
+  single or dual, MIPI-DSI video interface.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - startek,kd070fhfid078
+      - const: himax,hx8279
+
+  reg:
+    maxItems: 1
+
+  iovcc-supply:
+    description: I/O voltage supply
+
+  vdd-supply:
+    description: Panel power supply
+
+required:
+  - compatible
+  - reg
+  - backlight
+  - reset-gpios
+  - iovcc-supply
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "startek,kd070fhfid078", "himax,hx8279";
+            reg = <0>;
+            backlight = <&backlight>;
+            enable-gpios = <&pio 25 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
+            iovcc-supply = <&vreg_lcm_vio>;
+            vdd-supply = <&vreg_lcm_vdd>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.48.1


