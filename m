Return-Path: <linux-kernel+bounces-230997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A39184B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8528F28B5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2381862BB;
	Wed, 26 Jun 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1JcKeTo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C445C07;
	Wed, 26 Jun 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413093; cv=none; b=OJhEkMxItve24g1AGfEKBSzjXYRWP4W2oT3oj2juMQOalML8W/GNN5tHNmoJNtpsunAd87J2evZJLOCcYYgZ6DdC4ptAX8/4gzHn5QLD0YZeJFhZV7PRtH79NCB6Hbvsa8n5XZY6fO8RZs22xiyF37xuA1u+iJwI7gjLHwc1cXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413093; c=relaxed/simple;
	bh=xnV4Pwafjm1hCV6mupvMtuQXDRG+XuPAPy/PDaxveGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NknFpUjfEy2JnEUE53RDQsi0qFbUT42WgIkyw+xFKD3tiLZ1Zd4u1OZO2xUvkHZ+nu8iZc5/ghGKhN4l4NlO6c22h4vYqeLilRr36/UMTd3TCok6dSs/TyHIiJ7TLlIGC8g4qGURt8SnptLsHJM3yZOkxjwbuDlVUe/UNq3TxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1JcKeTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3CEC2BD10;
	Wed, 26 Jun 2024 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719413092;
	bh=xnV4Pwafjm1hCV6mupvMtuQXDRG+XuPAPy/PDaxveGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1JcKeToG5KR1/yhW8dEprMC2HxFwdHvHHCJSdExMf1AYNgc6QrKAVQgHpH1WGnNF
	 X5ZEg3YDJ1T+pfj3lH8j02yrrJKEYDRu5AjFRz2/GmOxCsMPrs8M0repQb0nT8pGg8
	 8Qv1AGSp4zyA7+McQrSLTPk5glQ9ltwKr5seGZrBD5gzWCowIeL/kAztZpsxQs2ZcD
	 ao1oTA5uDMCQwFEIrS0oMYHlczk1Hln6yXG/EcSw8u66B6jb3GLhCKgeLpIsGC4E/H
	 aq4oo/ghzInpSGxtkXvOoMZh6f6upjGmCKC9cpmrDvo3iM1LZ1lgQ1iFbTs9yNgvxg
	 t72AAIKLAUsxg==
From: Michael Walle <mwalle@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: display: panel: add Ilitek ili9806e panel controller
Date: Wed, 26 Jun 2024 16:44:32 +0200
Message-Id: <20240626144433.3097793-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626144433.3097793-1-mwalle@kernel.org>
References: <20240626144433.3097793-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device tree binding for the Ilitek ILI9806E controller which can
be found on the Ortustech COME35H3P70ULC DSI display panel.

There are no peculiarities except for two different power signals.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 .../display/panel/ilitek,ili9806e.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
new file mode 100644
index 000000000000..cfd7cc9c8725
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9806e.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9806E based MIPI-DSI panels
+
+maintainers:
+  - Michael Walle <mwalle@kernel.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ortustech,com35h3p70ulc
+      - const: ilitek,ili9806e
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vccio-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vccio-supply
+  - reset-gpios
+  - backlight
+  - port
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
+            compatible = "ortustech,com35h3p70ulc", "ilitek,ili9806e";
+            reg = <0>;
+            vdd-supply = <&reg_vdd_panel>;
+            vccio-supply = <&reg_vccio_panel>;
+            reset-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
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
2.39.2


