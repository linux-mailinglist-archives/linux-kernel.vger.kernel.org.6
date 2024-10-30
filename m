Return-Path: <linux-kernel+bounces-389629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0999B6F19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65F51F263CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8494721B447;
	Wed, 30 Oct 2024 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZJCEDOIY"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05032219CA8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324046; cv=none; b=pzTtFdPgEX2SjEXoQZheimfooyJyTbXWFArt9xCD1+t54CXnE4J5bP/Djnd1sfnNcqrmg/3Cq5tVlBC48dkqkrZINEMuRU/XsfPUguWhLfNFuP2kgxf1nfvq87a9Hmvz6p8ZrmTGBp6OPjhVs69XU06WB3Z4PR4jANdgPqiVD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324046; c=relaxed/simple;
	bh=hYyZJq9oegGh1gji0dswxl0W9BlepU403UQ8GeaqBPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iXcVUMekHCfP6P4xfZxkxivSXnuGIc8Rrb42xscBKnXPpwxc8h8oyy8zARnH7nEb7ZzpIPiFHpqAFjp6G3TJ4VUuNYK77j/61VHU7zzCjmoEf5LK5/yiy42yH+x+GO9b9vUus72pgi1sO3KGXdx7Xj9hxGTHQmwz2sFoNMcstEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZJCEDOIY; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e60f6ea262so216401b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730324043; x=1730928843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9eg9vuR4Uxr9JzqBV7RypmQQey5/UtVCVxr39TgYik=;
        b=ZJCEDOIYR4Dr5ZEAbq2019ShiHdrZc7x/SusNcfJ/pB04dRUr+waUIR4e3FdZ2MEN1
         x9rlmmR1bDLsRK80AJ8cFXs2buju91n7Xnh8MOevxdUxAa63zALhs76hgboO2ok8dgLB
         oulPO030b73g/LEz4XRgVrfg00mSoR/qoOIocR9YcpWyQYMIJboseWd6YXnliYLwvHD8
         bZdO7Sib5Po+rpPwVg+6uPbOG+CkkYn0upOzQ/7A5w7CrfBvAL+M7d/LC08jwJ+oox17
         L2SFUcvjqQG1jk13awxyRd8V9MBnuT3vF9YZQdcuvuEqjTTjvz/j9TbG44Qh4zMBwLw6
         42hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730324043; x=1730928843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9eg9vuR4Uxr9JzqBV7RypmQQey5/UtVCVxr39TgYik=;
        b=R666oMdM7LEE0XyaIVGcPtT9Q3daQ/aNndKHreU3eCfnFLQlAtCmGBlu3imkoaEfyZ
         yjwdQJv+WjPfXHvgRfFvvFfYv3QautG7/jBxkkzTXmD2TgI/IFaC76UhaN6XEWhSfddo
         xnRQkfitUiUSzgJ8+GazqQXhBjtx0uVUuRetXgQUziCqthkXHiHT8G+A8WKYjZG/qgpy
         kFlEFJ3MStO/+YYQDZluoZRv+z3QKlpvBDDT6CIq3ZQheCnQZPLNiBONLjio+bPR/GAc
         ZyMvuwAjla0hK0Sf6uB54L+j+XvS4MVR9CKQz6bb0AINf7ti364bXG/yNAdO2Cqw6GTb
         ZuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlw7XGzbMw2QUdSMGiiT7eH8eWISnzD7YKsG8roTrl8mEzfhKP5R/tosgtq9/CzqmHIon0by4sZL+vBPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSvwK7JdAsqfYGV16+wY69oTLyKZ+V8lV38VARMaFI/iCfL+Yd
	PkSLX4JDuOMsdeooK7QtiMdfMJhbTU5JOtKZJlU6jG+4HuYnAHJBVDoY5Aq4S+0=
X-Google-Smtp-Source: AGHT+IEmM0uB7n+flkzd/FD/2PnqS/GZwABtKjuSILLoSXeuIU9tJloICmHLLOFmnM46RDzFy76pSQ==
X-Received: by 2002:a05:6808:13c8:b0:3e6:2348:e6e8 with SMTP id 5614622812f47-3e6384d4ad7mr16240031b6e.38.1730324043038;
        Wed, 30 Oct 2024 14:34:03 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6611a661dsm52127b6e.14.2024.10.30.14.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:34:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 30 Oct 2024 16:33:56 -0500
Subject: [PATCH v3 1/2] dt-bindings: dma: adi,axi-dmac: convert to yaml
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-axi-dma-dt-yaml-v3-1-d3a9b506f96c@baylibre.com>
References: <20241030-axi-dma-dt-yaml-v3-0-d3a9b506f96c@baylibre.com>
In-Reply-To: <20241030-axi-dma-dt-yaml-v3-0-d3a9b506f96c@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Convert the AXI DMAC bindings from .txt to .yaml.

Acked-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

For the maintainer, Lars is the original author, but isn't really
active with ADI anymore, so I have added Nuno instead since he is the
most active ADI representative currently and is knowledgeable about this
hardware.

As in v1, the rob-bot is likely to complain with the following:

	Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml: properties:adi,channels:type: 'boolean' was expected
		hint: A vendor boolean property can use "type: boolean"
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	DTC [C] Documentation/devicetree/bindings/dma/adi,axi-dmac.example.dtb

This is due to the fact that we have a vendor prefix on an object node.
We can't change that since it is an existing binding. Rob said he will
fix this in dtschema.
---
 .../devicetree/bindings/dma/adi,axi-dmac.txt       |  61 ---------
 .../devicetree/bindings/dma/adi,axi-dmac.yaml      | 139 +++++++++++++++++++++
 2 files changed, 139 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt b/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
deleted file mode 100644
index cd17684aaab5..000000000000
--- a/Documentation/devicetree/bindings/dma/adi,axi-dmac.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-Analog Devices AXI-DMAC DMA controller
-
-Required properties:
- - compatible: Must be "adi,axi-dmac-1.00.a".
- - reg: Specification for the controllers memory mapped register map.
- - interrupts: Specification for the controllers interrupt.
- - clocks: Phandle and specifier to the controllers AXI interface clock
- - #dma-cells: Must be 1.
-
-Required sub-nodes:
- - adi,channels: This sub-node must contain a sub-node for each DMA channel. For
-   the channel sub-nodes the following bindings apply. They must match the
-   configuration options of the peripheral as it was instantiated.
-
-Required properties for adi,channels sub-node:
- - #size-cells: Must be 0
- - #address-cells: Must be 1
-
-Required channel sub-node properties:
- - reg: Which channel this node refers to.
- - adi,source-bus-width,
-   adi,destination-bus-width: Width of the source or destination bus in bits.
- - adi,source-bus-type,
-   adi,destination-bus-type: Type of the source or destination bus. Must be one
-   of the following:
-	0 (AXI_DMAC_TYPE_AXI_MM): Memory mapped AXI interface
-	1 (AXI_DMAC_TYPE_AXI_STREAM): Streaming AXI interface
-	2 (AXI_DMAC_TYPE_AXI_FIFO): FIFO interface
-
-Deprecated optional channel properties:
- - adi,length-width: Width of the DMA transfer length register.
- - adi,cyclic: Must be set if the channel supports hardware cyclic DMA
-   transfers.
- - adi,2d: Must be set if the channel supports hardware 2D DMA transfers.
-
-DMA clients connected to the AXI-DMAC DMA controller must use the format
-described in the dma.txt file using a one-cell specifier. The value of the
-specifier refers to the DMA channel index.
-
-Example:
-
-dma: dma@7c420000 {
-	compatible = "adi,axi-dmac-1.00.a";
-	reg = <0x7c420000 0x10000>;
-	interrupts = <0 57 0>;
-	clocks = <&clkc 16>;
-	#dma-cells = <1>;
-
-	adi,channels {
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		dma-channel@0 {
-			reg = <0>;
-			adi,source-bus-width = <32>;
-			adi,source-bus-type = <ADI_AXI_DMAC_TYPE_MM_AXI>;
-			adi,destination-bus-width = <64>;
-			adi,destination-bus-type = <ADI_AXI_DMAC_TYPE_FIFO>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
new file mode 100644
index 000000000000..b1f4bdcab4fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/adi,axi-dmac.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/adi,axi-dmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI-DMAC DMA controller
+
+description: |
+  FPGA-based DMA controller designed for use with high-speed converter hardware.
+
+  http://analogdevicesinc.github.io/hdl/library/axi_dmac/index.html
+
+maintainers:
+  - Nuno Sa <nuno.sa@analog.com>
+
+additionalProperties: false
+
+properties:
+  compatible:
+    const: adi,axi-dmac-1.00.a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#dma-cells":
+    const: 1
+
+  adi,channels:
+    type: object
+    description: This sub-node must contain a sub-node for each DMA channel.
+    additionalProperties: false
+
+    properties:
+      "#size-cells":
+        const: 0
+      "#address-cells":
+        const: 1
+
+    patternProperties:
+      "^dma-channel@[0-9a-f]+$":
+        type: object
+        description:
+          DMA channel properties based on HDL compile-time configuration.
+        additionalProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
+          adi,source-bus-width:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Width of the source bus in bits.
+            enum: [8, 16, 32, 64, 128]
+
+          adi,destination-bus-width:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Width of the destination bus in bits.
+            enum: [8, 16, 32, 64, 128]
+
+          adi,source-bus-type:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Type of the source bus.
+
+              0: Memory mapped AXI interface
+              1: Streaming AXI interface
+              2: FIFO interface
+            enum: [0, 1, 2]
+
+          adi,destination-bus-type:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Type of the destination bus (see adi,source-bus-type).
+            enum: [0, 1, 2]
+
+          adi,length-width:
+            deprecated: true
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Width of the DMA transfer length register.
+
+          adi,cyclic:
+            deprecated: true
+            type: boolean
+            description:
+              Must be set if the channel supports hardware cyclic DMA transfers.
+
+          adi,2d:
+            deprecated: true
+            type: boolean
+            description:
+              Must be set if the channel supports hardware 2D DMA transfers.
+
+        required:
+          - reg
+          - adi,source-bus-width
+          - adi,destination-bus-width
+          - adi,source-bus-type
+          - adi,destination-bus-type
+
+    required:
+      - "#size-cells"
+      - "#address-cells"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - "#dma-cells"
+  - adi,channels
+
+examples:
+  - |
+    dma-controller@7c420000 {
+        compatible = "adi,axi-dmac-1.00.a";
+        reg = <0x7c420000 0x10000>;
+        interrupts = <0 57 0>;
+        clocks = <&clkc 16>;
+        #dma-cells = <1>;
+
+        adi,channels {
+            #size-cells = <0>;
+            #address-cells = <1>;
+
+            dma-channel@0 {
+                reg = <0>;
+                adi,source-bus-width = <32>;
+                adi,source-bus-type = <0>; /* Memory mapped */
+                adi,destination-bus-width = <64>;
+                adi,destination-bus-type = <2>; /* FIFO */
+            };
+        };
+    };

-- 
2.43.0


