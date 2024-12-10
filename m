Return-Path: <linux-kernel+bounces-439962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DDB9EB6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B48C18849B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0F2231C8A;
	Tue, 10 Dec 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XohQEmR5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031A41AA7A3;
	Tue, 10 Dec 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849021; cv=none; b=j6hQ3XKzfGtxGDDRPJRvkpWBGlko8aQxOBUFHYIO+lkfeFek70jmp/KIfHKhky0lmFoZCaGqZcHhn7tVf0Q++Ni0r9e8PgrwRZSVDsi379bmfw9i+1WRBSU+BpDDZtmuJUcnaJi0p8gsJqeFzpTV9ywlbj0q3L8fUbHcRrQEDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849021; c=relaxed/simple;
	bh=P6DWcP64YEGP5AhpEHJkbc/BzwjTPrNY96mOFNSx1tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGsXktrPLJo8/foc6LmuMSSdCwiAgy8siAlECQqIxSpjLYB0DuVLFXxQ4jTJKP+UJjuIYOUtmPCxcmbZ45831WBu0jblwxg1qU89W9MVoECf/TLKV8QfqCSTPxq+hP3jMGGOao2Pak6ssOKY4cX0XH5NPtixiavUzhc6huwL1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XohQEmR5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733849017;
	bh=P6DWcP64YEGP5AhpEHJkbc/BzwjTPrNY96mOFNSx1tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XohQEmR56poh8StU0tsC1qMwBw3P3zCVlqTxEMc+J3B3DH4YSOhtXVjse7bKrzHFS
	 kgNuAV7Qtsu3YAw7e49y7IVwmR1fIN1D35MpTVkvW4JUMyuAAowsHZCT6CvemFlwmI
	 gjaBF7xcUGOVPwwwUiQkNv47+vQgqrqXVxzyKUIezg2gRayp7IBAsNQEqEEiqyz7fN
	 lrBTUycTp9x+Fv/DbyN4qkNsoq6j1ogpQ5X+WvLUiwgbDx2sF4//A5XZK5R7SKhBjP
	 wl8i3Kdin9aEjvID8ACB49Hda3E/VJm7yLkFe60cvrr6InmFvKtDtOjOzJJZzidbFa
	 c4ZePtjV13ofA==
Received: from jupiter.universe (dyndsl-091-248-190-127.ewe-ip-backbone.de [91.248.190.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0597317E37B1;
	Tue, 10 Dec 2024 17:43:37 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 6A46748CC8B; Tue, 10 Dec 2024 17:43:36 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Andy Yan <andyshrk@163.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 1/2] dt-bindings: display: panel: Add Raydium RM67200
Date: Tue, 10 Dec 2024 17:41:30 +0100
Message-ID: <20241210164333.121253-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210164333.121253-1-sebastian.reichel@collabora.com>
References: <20241210164333.121253-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip W552793DBA-V10 display/touchscreen board contains a
Wanchanglong W552793BAA panel, which in turn is using a Raydium
RM67200 MIPI-DSI controller. Add a DT binding for the DSI panel.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../display/panel/raydium,rm67200.yaml        | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
new file mode 100644
index 000000000000..d0a6d3207811
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raydium,rm67200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raydium RM67200 based MIPI-DSI panels
+
+maintainers:
+  - Sebastian Reichel <sebastian.reichel@collabora.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - wanchanglong,w552793baa
+      - const: raydium,rm67200
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: 2.8V Logic voltage
+
+  iovcc-supply:
+    description: 1.8V IO voltage
+
+  vsp-supply:
+    description: positive 5.5V voltage
+
+  vsn-supply:
+    description: negative 5.5V voltage
+
+  backlight: true
+  port: true
+  reset-gpios: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - port
+  - reg
+  - reset-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "wanchanglong,w552793baa", "raydium,rm67200";
+            reg = <0>;
+
+            vdd-supply = <&regulator1>;
+            iovcc-supply = <&regulator2>;
+            vsp-supply = <&regulator3>;
+            vsn-supply = <&regulator4>;
+            reset-gpios = <&gpiobank 42 GPIO_ACTIVE_LOW>;
+
+            port {
+                panel0_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+...
-- 
2.45.2


