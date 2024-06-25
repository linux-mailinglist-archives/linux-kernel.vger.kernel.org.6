Return-Path: <linux-kernel+bounces-228958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB1A916918
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CED28418B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064916C866;
	Tue, 25 Jun 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEZN9HxK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30D1607A7;
	Tue, 25 Jun 2024 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322551; cv=none; b=WpNcG7kSjOPMAwLlNvvW7EEwt+3f4tRHUXK4EQdOlJi5XHDERlSU1e7YtHezfIsv71tiChvo3ZFQBzDuZJxVVHoW9VI0B0YV76T7X9Gt6uw0yqX5MjDF9GiOyuuMNMCOjw07nMTqN4ES5i3k/GGFVz6YhrStbPQaT9Q6HQwHA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322551; c=relaxed/simple;
	bh=hFHJZXKSTG17Rci0rZLgXpOiNQhILWLQK5z+5zpVtz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/JuQIx9qnlTVEAobsddYw6yS8oq2vEytQ13D5I7u8qdQufASEVAsREl6DMhjiA96u5pkJvPGAjQ8ZRxFO7G9smsjbU73cL/pv08dFiXefchOUkN+Vd6zykN2jgjLZSHIov61BCANsZzBCPojC/3lPx2zb2FtSRk1dxWEct5QDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEZN9HxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73C2C4AF07;
	Tue, 25 Jun 2024 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719322550;
	bh=hFHJZXKSTG17Rci0rZLgXpOiNQhILWLQK5z+5zpVtz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LEZN9HxKdfEtPICg65kW787I2HzhJebVwq6++/HfTZRNvCIch7ClHN3fz+HNNlFo+
	 EOvFlqT+j2375a8TFqBVPKujP7h6/lfz2/fr2zVxYD4YjgNBfZYGftLpibUKWQSuLm
	 r/7RCxvTQP9WgOtjtMDFuf+GyUvZu59qp+b+SGg8eaOyad6G21447B1nZQlrUh+uLd
	 o1pG+6iHmk7vdDBnY0P5NnSDoewIU0V+FWB6L94z0xhBav2ZWa5BaOzXHnjQHR6zuf
	 iJTKybRxNi7QVHP4MVWri4kQuFF7kJ+HHxoADbVrBHtf6xNSvhJuG1aUJrqPXo8Ng9
	 C/yahg121WQXA==
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
	Michael Walle <mwalle@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gunnar Dibbern <gunnar.dibbern@lht.dlh.de>
Subject: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ili9806e panel controller
Date: Tue, 25 Jun 2024 15:33:16 +0200
Message-Id: <20240625133317.2869038-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625133317.2869038-1-mwalle@kernel.org>
References: <20240625133317.2869038-1-mwalle@kernel.org>
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


