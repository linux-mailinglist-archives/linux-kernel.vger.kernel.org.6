Return-Path: <linux-kernel+bounces-335923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6414197EC9B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190981F221CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEA619CC14;
	Mon, 23 Sep 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Pghwibwy"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84536BFC7;
	Mon, 23 Sep 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099882; cv=none; b=SXSkX9z9tXSaf6fKQj9Xk6Zn+BvkE3f1nQwOFQ+S967AMeuwK3Q5U1lY6+mSfDcAo7a7VFL25m0EndbErV5Tq7GexKyvqx8DdUi+JpYy9j4BD9WGtW33bZ+1/1G9V8lhzJkUDS3sL2zJFcEXX0ao/BnJsbBztpoJPDQBFTIbFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099882; c=relaxed/simple;
	bh=lIUOOaZTwcZr8QsP94GIOV28sHI8sFismN3IMmEQm8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LtHNkWFlTCnu5Odu5WNsFTo3LRQ4kG5qH6NeTALYpMznq0q1LYlbVZ7PKqZ7frChfruSM4YWhtLy4jO81hGbcnfSx+AnGUBGVackwkebR7uM/Bl+o0uQKt4GS5lJfuUJpSu1fDylJHBIDXMz7wl+EruJ8LVMc8uJH9WdySlpzXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Pghwibwy; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D803288AD7;
	Mon, 23 Sep 2024 15:57:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727099878;
	bh=L2NnDMl4BqxEyLz16GjGxVE+3eLoWwP7TkmLSj4ceLk=;
	h=From:To:Cc:Subject:Date:From;
	b=Pghwibwy9M+HwnP+9bt13d2G0/1BWvP9ybmFSiXz/mpt+XqCPfnl+XqvPdrCULF7p
	 6BC4tQHOZfx0+SxMZICkceABisnf8HgMj3OFddcKBU1994wtMBNWG8vaz9T0or1Qzf
	 lP2ou7QOICgJnI1Z2qp7XnFrJNAg/eNRhxeKqkGruvr44b+wre1vdpYHhYTo5+rSCY
	 w65K960ex4AF/bSf7X5c/eFs7R9Uv/2b14yz9M3raLq6qJHUKMSPUUQ3wQHkfJCuc1
	 dKesJMApjY8hO0KT8lRnajZCiyYRTDi3iKIoa4nL1Mzxjsdj9kdIzBeD/DmWX8fFNO
	 VEqENEQvZVQ4w==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stefan Agner <stefan@agner.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Fabio Estevam <festevam@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] dt-bindings: lcdif: Add support for specifying display with timings
Date: Mon, 23 Sep 2024 15:57:44 +0200
Message-Id: <20240923135744.2813712-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Up till now the fsl,lcdif.yaml was requiring the "port" property as a
must have to specify the display interface on iMX devices.

However, it shall also be possible to specify the display only with
passing its timing parameters (h* and v* ones) via "display" property:
(as in
Documentation/devicetree/bindings/display/panel/display-timings.yaml).

Such approach has already been used (also in the mainline) with several
imx28, imx5x and imx6q devices.

This change allows them to pass the DT_SCHEMA check without issues.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 .../bindings/display/fsl,lcdif.yaml           | 51 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index 8e3a98aeec32..14bb64b5b72d 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -50,6 +50,10 @@ properties:
       - const: disp_axi
     minItems: 1
 
+  display:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle for display timing information
+
   dmas:
     items:
       - description: DMA specifier for the RX DMA channel.
@@ -64,6 +68,9 @@ properties:
       - description: LCDIF Error interrupt
     minItems: 1
 
+  lcd-supply:
+    description: Regulator for LCD supply voltage.
+
   power-domains:
     maxItems: 1
 
@@ -76,7 +83,10 @@ required:
   - reg
   - clocks
   - interrupts
-  - port
+
+patternProperties:
+  'display([0-9])':
+    description: Node with display timing parameters
 
 additionalProperties: false
 
@@ -197,5 +207,42 @@ examples:
             };
         };
     };
-
+  - |
+    lcdif: lcdif@80030000 {
+        compatible = "fsl,imx28-lcdif";
+        reg = <0x80030000 0x2000>;
+        interrupts = <38>;
+        clocks = <&clks 55>;
+        dmas = <&dma_apbh 13>;
+        dma-names = "rx";
+        pinctrl-names = "default";
+        pinctrl-0 = <&lcdif_24bit_pins_a>, <&lcdif_sync_pins_bttc>,
+                 <&lcdif_reset_pins_bttc>;
+        lcd-supply = <&reg_3v3>;
+        display = <&display0>;
+        status = "okay";
+
+        display0: display0 {
+                bits-per-pixel = <32>;
+                bus-width = <24>;
+                display-timings {
+                        native-mode = <&timing0>;
+                        timing0: timing0 {
+                                clock-frequency = <6500000>;
+                                hactive = <320>;
+                                vactive = <240>;
+                                hfront-porch = <20>;
+                                hback-porch = <38>;
+                                hsync-len = <30>;
+                                vfront-porch = <4>;
+                                vback-porch = <14>;
+                                vsync-len = <4>;
+                                hsync-active = <0>;
+                                vsync-active = <0>;
+                                de-active = <0>;
+                                pixelclk-active = <1>;
+                        };
+                };
+        };
+    };
 ...
-- 
2.39.2


