Return-Path: <linux-kernel+bounces-416724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F619D493D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DA2B21064
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DB41CD207;
	Thu, 21 Nov 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2SWW/CPf"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EEE1C9DC9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179203; cv=none; b=Sl/Ei5rkZ2RSANgYwf9BdpCqBCzn2pgK8ruEfWK26V65acBnPpJJzHhqt8fh0vOveSlWj1WqrLTpRikQ92ET802+rsJmgYdVqZD6RTl3GnfUAkldWhWzDJHAAocr6SsHxbEcjediaIWJxpJXQqsJ0p7V4D5YoiHq0fAvn1wNcRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179203; c=relaxed/simple;
	bh=0rkB4/JpaPliiwIivH9y29TzVUpUltIbQ7I+cmLdwJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwH06mLnGeSnZ9PI6l567XoAliq5mgOfJQtSs1bCuub7GdgujRxYJj9rlN10HN4eu9cSyPuBTRB10nvap5qSI5CWQQFL7u7rBRYhP3eiTbkfE4/9Hkma4mWu5mY1oHrQWpiS+qQZBiyRc/lOhOLZyUSvVkxbUR9JEid+YgoPsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2SWW/CPf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so374546f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732179198; x=1732783998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MCyWyyuLRYxP0oH9ltkOsqfvK0CBscNjWxECImzBCc=;
        b=2SWW/CPfWhoYVi1cSbqP5KTtPiWS3Oru45+H2ENNxMQBTPf+9SMs4m+dRpk66OnLQO
         E6NNH4WHU6F9XdnpqbIstrWHyqXxfYRFF1wF4syoWYd1CC/GwZYUQqN3oCIIcITO3bln
         5C/2sHAyTB9ImDKb/OAPevbEasPWDgM7nBBkmaX7O0e1pwRhcOV5PJIIXMcX/n8Zgdk8
         Xr/8mdVb3wcie4616WY8CaC9iMQnbLTmFurOVYumtdV4aV0eGSqw78SWwcvYuzh78YXo
         l0vpgrIgfqmZ/GkHI3yYXo+krBC/eMX6ij/BRV2kPNVYo8juqh4IVhkNmKrjd00aLiTj
         mU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732179198; x=1732783998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MCyWyyuLRYxP0oH9ltkOsqfvK0CBscNjWxECImzBCc=;
        b=bwxgKFC5MUweIor45nx3hPR8llNwewR2jwULBCTG+VkUwtTRbMPX5qaUSg5O+Is9rC
         sH2M9q1kd/jAIx6y28v+oXUVlbuNzCeC2BvApuw9+k28fW287h/AjV6CdwAhoIdbNaWO
         cOhFZHxmwkY85qFrv1QtTJyapdKVwlJtHNxQUcv/3Tiju1tom5UEnbcHwVpvXQpDme96
         ag0PMuYfaAxmS4dGlm/UmIVIDBlE60ESCwmgIkZl689TfAaJFIlSbS/AhFB46DNP80UR
         hCPClucIyIvBL2XBS0FoNKfr+50s54VEUYSM7jxX0/jddhqhMylSEtvVhWLuxaUMVuaS
         Yl9A==
X-Forwarded-Encrypted: i=1; AJvYcCUXNNiq0ogZFnnBuhd71gEr+Ds/hGFUXtgepPsRPvA+XTqdjnWdqqEfAnjJagAvFyMI3XjV7aLi8cBeKak=@vger.kernel.org
X-Gm-Message-State: AOJu0YydK82L9ONNxD4lU/gXHF7MvXSwGO8WmMKmpj1hjk5alplnOREU
	8q70VmlipHHsZqRj67OIa9dNyES/0CbzwSNspMV+xpBA3hCK5SI1b0M3DB9tM24=
X-Gm-Gg: ASbGncsxPI4ZU0GHX1RHFFFfMpxx6wwjhAqRDf1MqJOWo+k7s3k6OjSweGgWAwKBFGs
	TPFFxb2y4M1pArZNVnN91xwse4Hm79JjIY3LSndkMFNnw1aPImm6PITCDrOXFAmYfrxoZrlI1Xy
	BsCKhEBq2zEXy5sKFdI3VSPhWk2DRh4vmRh289v5CsdmvTI9M6wRXvH7SfwjqJvdmry6NIX1g+V
	7iNDlM2QRL+9HEXwnUuU5Asm1bq5RFRRQsquUqGIJYC1EmiYxY+PprLIKwjU2kJF80dSBTuTRLe
	sq1/1jSx2Hy8V8XCPH+zx2qdzNL+rI/zOW5mDjqUZqw=
X-Google-Smtp-Source: AGHT+IEMIkoLdPBEX/9Nv5t80VVjflIxCN9/zIPP7NEINBt57fCC+7zzZNTiyW6G4qkMw3XegNJTaQ==
X-Received: by 2002:a5d:5985:0:b0:382:4a80:a616 with SMTP id ffacd0b85a97d-38254ae0006mr4981983f8f.9.1732179197597;
        Thu, 21 Nov 2024 00:53:17 -0800 (PST)
Received: from [192.168.42.0] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382549111fdsm4219900f8f.58.2024.11.21.00.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:53:17 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 21 Nov 2024 09:53:15 +0100
Subject: [PATCH v7 1/5] dt-bindings: media: add mediatek ISP3.0 sensor
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-add-mtk-isp-3-0-support-v7-1-b04dc9610619@baylibre.com>
References: <20241121-add-mtk-isp-3-0-support-v7-0-b04dc9610619@baylibre.com>
In-Reply-To: <20241121-add-mtk-isp-3-0-support-v7-0-b04dc9610619@baylibre.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Andy Hsieh <andy.hsieh@mediatek.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Julien Stephan <jstephan@baylibre.com>, 
 Louis Kuo <louis.kuo@mediatek.com>, Phi-Bang Nguyen <pnguyen@baylibre.com>
X-Mailer: b4 0.14.2

From: Louis Kuo <louis.kuo@mediatek.com>

This adds the bindings, for the mediatek ISP3.0 SENINF module embedded in
some Mediatek SoC, such as the mt8365

Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
Signed-off-by: Phi-Bang Nguyen <pnguyen@baylibre.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../bindings/media/mediatek,mt8365-seninf.yaml     | 259 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 266 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8bd78ef424acf1ec207b527b4a84b6a535f37593
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
@@ -0,0 +1,259 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 MediaTek, BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt8365-seninf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Sensor Interface 3.0
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+  - Julien Stephan <jstephan@baylibre.com>
+  - Andy Hsieh <andy.hsieh@mediatek.com>
+
+description:
+  The ISP3.0 SENINF is the CSI-2 and parallel camera sensor interface found in
+  multiple MediaTek SoCs. It can support up to three physical CSI-2 input ports,
+  configured in DPHY (2 or 4 data lanes) or CPHY depending on the SoC.
+  On the output side, SENINF can be connected either to CAMSV instance or
+  to the internal ISP. CAMSV is used to bypass the internal ISP processing
+  in order to connect either an external ISP, or a sensor (RAW, YUV).
+
+properties:
+  compatible:
+    const: mediatek,mt8365-seninf
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Seninf camsys clock
+      - description: Seninf top mux clock
+
+  clock-names:
+    items:
+      - const: camsys
+      - const: top_mux
+
+  phys:
+    minItems: 2
+    maxItems: 2
+    description:
+      phandle to the PHYs connected to CSI0/A, CSI1, CSI0B
+
+  phy-names:
+    description:
+      list of PHYs names
+    minItems: 2
+    maxItems: 2
+    items:
+      enum: [ csi0, csi1, csi0b]
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI0 or CSI0A port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI1 port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@2:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI2 port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@3:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI0B port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 2
+
+      port@4:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for cam0
+
+      port@5:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for cam1
+
+      port@6:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv0
+
+      port@7:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv1
+
+      port@8:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv2
+
+      port@9:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv3
+
+    required:
+      - port@0
+      - port@1
+      - port@2
+      - port@3
+      - port@4
+      - port@5
+      - port@6
+      - port@7
+      - port@8
+      - port@9
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/mediatek,mt8365-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        csi@15040000 {
+            compatible = "mediatek,mt8365-seninf";
+            reg = <0 0x15040000 0 0x6000>;
+            interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
+            clocks = <&camsys CLK_CAM_SENIF>,
+                     <&topckgen CLK_TOP_SENIF_SEL>;
+            clock-names = "camsys", "top_mux";
+
+            power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+
+            phys = <&mipi_csi0 PHY_TYPE_DPHY>, <&mipi_csi1>;
+            phy-names = "csi0", "csi1";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    seninf_in1: endpoint {
+                        clock-lanes = <2>;
+                        data-lanes = <1 3 0 4>;
+                        remote-endpoint = <&isp1_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                };
+
+                port@2 {
+                    reg = <2>;
+                };
+
+                port@3 {
+                    reg = <3>;
+                };
+
+                port@4 {
+                    reg = <4>;
+                    seninf_camsv1_endpoint: endpoint {
+                        remote-endpoint = <&camsv1_endpoint>;
+                    };
+                };
+
+                port@5 {
+                    reg = <5>;
+                    seninf_camsv2_endpoint: endpoint {
+                        remote-endpoint = <&camsv2_endpoint>;
+                    };
+                };
+
+                port@6 {
+                    reg = <6>;
+                };
+
+                port@7 {
+                    reg = <7>;
+                };
+
+                port@8 {
+                    reg = <8>;
+                };
+
+                port@9 {
+                    reg = <9>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 4c7f9e37c5653664a11a2cb36aba942830b5a8d1..242c54c88a4a22fc0cbe5c4fc5d7b0d0f84b329e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14565,6 +14565,13 @@ M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
 F:	drivers/char/hw_random/mtk-rng.c
 
+MEDIATEK ISP3.0 DRIVER
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Julien Stephan <jstephan@baylibre.com>
+M:	Andy Hsieh <andy.hsieh@mediatek.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
+
 MEDIATEK SMI DRIVER
 M:	Yong Wu <yong.wu@mediatek.com>
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)

-- 
2.47.0


