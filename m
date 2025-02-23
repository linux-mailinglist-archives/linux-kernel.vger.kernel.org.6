Return-Path: <linux-kernel+bounces-527787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C45A40F7A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CDA16E879
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AFF20B807;
	Sun, 23 Feb 2025 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF8SI+e5"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD10F273FD;
	Sun, 23 Feb 2025 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740324800; cv=none; b=Eef1lBHWDQNuxiS2MlitsEdQh5kWnoT26eNKZ66SfEnHXbL5g5p2gfhXLTV8pLNZZgAxiwrvF1cl2lSDsAqLHf9J09uori3vAM7z4H48tH4kWWTmdQBvvwD2/+lTUpuSwMJ4w8QcWK7TktjEXVTfaxdi2UB/Dxq8GxJhi48Xzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740324800; c=relaxed/simple;
	bh=96RxRdOC2EGilyMcMYEekHxN8zBGjgz/rtOQwzl0mF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVcsOI8UolwqPNQa9GCj1k6MdIB6WzKqmDtUFpaANfAXNAk//4lLUy6DJ4/fiXhy3I5ye+q6JiLjBHbdLUrpi8fzS5Qj5JO53vHimpF7voziBtzVwjDyCQo2MSHywS1b8DfvtKLFSFMmkKzftTKE8cP5RsVSEk0oQ7v7X41Mxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XF8SI+e5; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5461f2ca386so3195743e87.1;
        Sun, 23 Feb 2025 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740324796; x=1740929596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xNQ5jZiYHJ7mGqPVKrUERwUHV0d9NVp53zY7eeij3s=;
        b=XF8SI+e512ftyFyn2oDO91CTFzUiCRXOJRJxOVjPnOmnGkUqZ0r5YZOl9ssf6MS0eQ
         jxHYHHuXbGmQzIu5QjWV4ofYcawP6TBCEyyuUFBQwp1vn+GbnFQr1+vYVF0IixLJK3Yq
         /xdCCRvPOEByuSedPfSJ8KuRvAR8LeYRJJfa9aXuEWQaFU1yK5zRMeWzkD8ujaMtkAtC
         a+zU7j2lvEHUGdznJMGI/054Y71npLDfXmsfIy1r75ehbkSVxAZZzi9D1McOegM+MC1Q
         MnLeIJ/N8eijQ9XiF2KetoIqGAcs84GTAPoBg4KQnX79V7AsTnT8zPscZSABdk6meKXL
         81HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740324796; x=1740929596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xNQ5jZiYHJ7mGqPVKrUERwUHV0d9NVp53zY7eeij3s=;
        b=ZbLHTvmXY12LTOmYqp/fRqDtb4XypaAax7RpGNHHYOCZCjVhk3wv6GdMdl/5ASFiAr
         E8s1a9Mt7jjcy6od4Qp3dbIkFxw1JjZOh1XOfFB40EutlYv5lO0NAXv6rDK6rW4P2Me9
         SjoSGpyLbDl3cTWTYgD0S8OKaf8q3zN79gzam0n4FlAV6dmOcA90Jd2mUFRJy056+Sa5
         cSbXCVql4Mj/ICjqg9tGo/hWBkMfic7U3WdUItwjerZn4MNbxKF6blbD6gzns3GF6Bet
         9d7bHj4yvLcmvnVMPhE0TfZSkINxKubPfQuXOMYCwrym1pEIbus1YBSKm29HZUw/1SAC
         9+MA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ciWDbYlz54ia9yPd8icUQW3HV2gqr+WLIllfLiklowdtZIyvX5Cxbh1/YIWKTYlirLIGT1tXuJr8rSbq@vger.kernel.org, AJvYcCU9Rv4cHLjMMayuYIfhJZ9AY1ZlD4S2anGxC9lDXPl2THFp2Aaf4f4Stb3cWVV4f/oikNfImGHt451T@vger.kernel.org
X-Gm-Message-State: AOJu0YxUC+bXrCcvQ6PxOMMaQRrHwpPbfjFC2JR4RPLrEa3IA5DkUaug
	qOk/KFbVXAlu2tL0+mTKcEjC1PMMlqoWQH46xGLEYCEfFvY8HZu6
X-Gm-Gg: ASbGnctlaY09ulFoDZu4eFETXIYyZFWaft62EJlPzlBNpwf4CTCCrMggmebB+gM4n+F
	dl8LKDT0hEwNfxzp5lf6SIrIRv5Jji0YKgy+VsjmTRI9NLb1PQYGee9zuoVIGABd8jVVV3oh8dD
	vORDpQIS4PeKl0bZqIl6ssFZ7Ch661O63tk3BxrdlICDkKtgvXwABDx2q0/quK37WGtxxNi1z42
	Vr6vG4cQPvnxqDADGNBG5D4lp7VOaS3Z6naAqZGkvnYoVT/ZUtXh1a0B+UrKwCepkSutw3y2g2U
	Jo0lzRSkw4oc1p07
X-Google-Smtp-Source: AGHT+IGhZKv66hyZd+R0sYrlUmONkzFhnHU8cGFVJ23YKzN8ubomX18t1RVBEPxkcZ1puaxhe+enHw==
X-Received: by 2002:a05:6512:2391:b0:545:cd5:84c9 with SMTP id 2adb3069b0e04-5483912fd22mr3448281e87.10.1740324795595;
        Sun, 23 Feb 2025 07:33:15 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54523dd8ca3sm3025569e87.181.2025.02.23.07.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 07:33:15 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: display: bridge: Document Solomon SSD2825
Date: Sun, 23 Feb 2025 17:32:43 +0200
Message-ID: <20250223153244.149102-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223153244.149102-1-clamor95@gmail.com>
References: <20250223153244.149102-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Solomon SSD2825 MIPI master bridge chip that connects an
application processor with traditional parallel LCD interface and an LCD
driver with MIPI slave interface. The SSD2825 supports both parallel RGB
interface and serial SPI interface.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../display/bridge/solomon,ssd2825.yaml       | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
new file mode 100644
index 000000000000..e2d293d623b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/solomon,ssd2825.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon SSD2825 RGB to MIPI-DSI bridge
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: solomon,ssd2825
+
+  reg:
+    maxItems: 1
+
+  reset-gpios: true
+
+  dvdd-supply:
+    description: Regulator for 1.2V digital power supply.
+
+  avdd-supply:
+    description: Regulator for 1.2V analog power supply.
+
+  vddio-supply:
+    description: Regulator for 1.8V IO power supply.
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  spi-cpha: true
+  spi-cpol: true
+
+  clocks:
+    maxItems: 1
+    description: Reference TX_CLK used before PLL is locked.
+
+  solomon,hs-zero-delay-ns:
+    description:
+      HS zero delay period
+    minimum: 0
+    maximum: 1700
+    default: 133
+
+  solomon,hs-prep-delay-ns:
+    description:
+      HS prep delay period
+    minimum: 0
+    maximum: 1728
+    default: 40
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Video port for RGB input
+
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+            properties:
+              bus-width:
+                enum: [ 16, 18, 24 ]
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for DSI output (panel or connector)
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dsi@2 {
+            compatible = "solomon,ssd2825";
+            reg = <2>;
+
+            spi-max-frequency = <1000000>;
+
+            spi-cpha;
+            spi-cpol;
+
+            reset-gpios = <&gpio 114 GPIO_ACTIVE_LOW>;
+
+            dvdd-supply = <&vdd_1v2>;
+            avdd-supply = <&vdd_1v2>;
+            vddio-supply = <&vdd_1v8_io>;
+
+            solomon,hs-zero-delay-ns = <300>;
+            solomon,hs-prep-delay-ns = <65>;
+
+            clocks = <&ssd2825_tx_clk>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    bridge_input: endpoint {
+                        remote-endpoint = <&dpi_output>;
+                        bus-width = <24>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    bridge_output: endpoint {
+                        remote-endpoint = <&panel_input>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.43.0


