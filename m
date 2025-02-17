Return-Path: <linux-kernel+bounces-517793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69D6A385AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887BD166D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA435222580;
	Mon, 17 Feb 2025 14:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJkIrOvY"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C37221727;
	Mon, 17 Feb 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801370; cv=none; b=I/oXIWU1ibuaYD9QW4GaJ2LXFTVef1vjdLs27Yipart6vv/4J34FCiadbygU1jQx6NO89CfbLHwtiBzmIMjvdRCpeyP8f7scOaGr1kLAN5eAzgJqnbwIH/+Rgpxnqxmae8MX0wfrgi0i1B5cEnf/HuQFaYxsc7cHh+CFCjO6Z9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801370; c=relaxed/simple;
	bh=S+HfPGi/6ba6d0UDLExm1JLQtrRLOt9XJJit5Kyy3RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJ8sxSWKb7PaZo/rQVcARMTTdAknKLvD0VlpFyFy8D46AsdnIWKEGN/IcXJsLROncjP9CgpdMNdT/bf7OIBLjCaZ/TPf6lmAYVGsuOI103urjxUlkzwEZv5gqClNWYnUoZ9ZM0tmnn07W14dluujeZ4pFiRqrRNU4TiHU0VT5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJkIrOvY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-546202d633dso1104713e87.2;
        Mon, 17 Feb 2025 06:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739801366; x=1740406166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBvpaDEnRYexWP0/rCT65mQ1l4vlz411qKmQ+5kOMDY=;
        b=hJkIrOvYP1lqumE9DGc7B9OZd32z6yXXhml7uAU0tuuocDpdaLdkgU21FeWvtyI3iV
         Vp9TwYhRhqz6CZYO/B0aLBBfcqITgdUbrGiR0ACZRT2chqoHZkNyTxqiem2FISOY6B3s
         5VH7TxM9kqEvgfVfpwlChxHJL+Rml+vnl2E2EpJMiFv08lzLsA3lX1Esq4gNICnNr8Sy
         u9AeYe0V+tEdcIHybbfquG8zSrYf8dBbIZGzfbHjFIHIPXCn5OR69Z4tsae1lFUEvnWv
         bX2+ioOgdLyhPbF+7ymzmmzgifVxRLNgukT8Nl7AHwvmJmMsMzvRj+2/q1ogHHnnfeTd
         ZMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801366; x=1740406166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBvpaDEnRYexWP0/rCT65mQ1l4vlz411qKmQ+5kOMDY=;
        b=M51Qpue/d4UIDR2gMaCQmjMUFEA0ILp4LUQubyhZlpo6/dMPeSfXyIxCFJ5sABKex/
         oeuGP+00Y93Ncw1vGHeJb2zYTtjhRu2R9W9UWQImbVvT1+LRiKqEdYmzFONfq2bXEgqc
         YffKKihy3k5ZhzdCbjiEDCEXJh2R4zwQIhPHuNFLcsHNEbO4kQMc4RnQcR4NrRSPWiZ2
         +czQsp0bWA/ywRHQnF1lLsxSNq3hNnsfW8DiydXnm4H3Hd4tyf06Vj/9OR5EaZuV7FyU
         ZxIc7pDg+jvnO4C99imYCyHozW4DVDawwabsOQ/TLcP44pT5B3nGep2hJJXCpoaZGQBx
         VaQw==
X-Forwarded-Encrypted: i=1; AJvYcCWgKrXuwQNqm5i5FRXYjJuaN47kmlbPVT8E4o0OwVGB0u/1JaYa4IGWgNXOpoRKD1bGJUTc1He1qUfR@vger.kernel.org, AJvYcCWzcx2lk3DYsAYDeSMAqR1yULxVqgYsEO1B/npNNrDrMQ8cJcDyd6rP9sLFz6mOsLCsh8uOsOctY6XaoZcO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+lPwjsZ2LuhMe9TuAf4UpglqpJKyPCzpDP/TJvVTvWcbLnudJ
	y3dOezX3+tRSZ9dsSOQX8THiwJcuhWxWf02BtkwZ9eIRQKl4LGpl
X-Gm-Gg: ASbGncss8+6pWtzuRkFBpVUJVMvSINpE1dKq3+B9Qyz0Y+T6QoUEwaE4aZkbRs0zgbi
	RTdW+OTdVCWm7S5hv+FvY0qsLCDWlJtJJoV7/oI3CSjtY5hHjDesSsLtCKtCiSTPVFe72zQHq6O
	mRr8AQANVEU82e/NdzQnF0/1OtTaIpLNt2BHT3SSMX3RM3I4VzYOqOc+vxeKkLMk0XjIXRh1Wyk
	1Ndp4bpV9MMyz/mESLCHURfD1QmZouQEZ4Mf+4D/1Rj6xhUExSdX30LEcBR2LdAaG2BZxDsoCXR
	zNBYyg==
X-Google-Smtp-Source: AGHT+IFxia5DKdKWgX6hkQJUH6EY+CAt795XfnBfkMfO9oSW6FA40NQb9/QyEftvaXCvsImNdilT9A==
X-Received: by 2002:a05:6512:3a91:b0:545:b89:30a4 with SMTP id 2adb3069b0e04-5452fe6369fmr2389050e87.29.1739801364482;
        Mon, 17 Feb 2025 06:09:24 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54531b8ac1dsm866855e87.75.2025.02.17.06.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:09:23 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: display: bridge: Document Solomon SSD2825
Date: Mon, 17 Feb 2025 16:09:09 +0200
Message-ID: <20250217140910.108175-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217140910.108175-1-clamor95@gmail.com>
References: <20250217140910.108175-1-clamor95@gmail.com>
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


