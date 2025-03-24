Return-Path: <linux-kernel+bounces-574024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B5A6DFB7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2287A168EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628F5263F2F;
	Mon, 24 Mar 2025 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS7R0/r3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6842641D5;
	Mon, 24 Mar 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833814; cv=none; b=B91zTJipPvklh2Op5kZMtfF3+2i3sE9U2j/GPDtKBNuS4idPv+1TbETuYZ3f4GQPFDscIigkR3aTtdSubxJ1tXA8oIG3UaGoSfkSV8M0Kcl2tAoRpx+eMPByFub5a4feQm5cdWXXV4sAHA+NgXeI8/En5Nez0qBKDv7heMeuWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833814; c=relaxed/simple;
	bh=nLJKxHm70qEycVny3nLFOeSNXCPfDqcDcghcDIodiCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acR5pZDBn2ImVXaMbvBMtaRgNiyllcNvDI4gTu5r/jMuR73/x2E1sdLGhRZKfwzJSoefunHEzCLp/ACnkW9aMFRqoKofEllQbjswq+Qx4ddUPv+79udzwuNCWXofoeKtUF5LVZA4lKv36x560CHrNzMSZEYLBEu0cRbsJN1HFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS7R0/r3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso49795925e9.3;
        Mon, 24 Mar 2025 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742833811; x=1743438611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MydIHs3qFCXYHM7b0s9l0s9CjimN0OE0vCb1xP0k2Sk=;
        b=ZS7R0/r3xVOaFz5wB96jLjN1tXal+Y6cA1VEj6RkvqlcmcGM2zLsrhpzf/cIbhhCHe
         tXhoh05O3Jit2NW1RQnmUD0kasf3mKgFxcx9I5Xn82Gc9uaPWAOZqfZ+KxFsU0MgpN8h
         OhLquueSadzLQEOPZ7FL2UvDJtwMxvGa2WqEiohk5CQKbWB4nyhlANnxGhd4rTFkSz6y
         X9bNmWeE4qm1ze+6ipm0usFSaVEyl8T2XOmYm0xGDrITxkXeYQ5YutBu7lEQBy/euVGE
         6cZ+3jax1sr9DxZC2+JmCutmmpWr/B9W4lMCQBLq+y5icOLdi6nb+BfFSEx/K2CNF+I4
         sCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833811; x=1743438611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MydIHs3qFCXYHM7b0s9l0s9CjimN0OE0vCb1xP0k2Sk=;
        b=spK1t3ZU+FfJEsxHxMPPwpBR0DnTIoO6cjW+axUNDdRtABUk2PHKCWDbT5iJl8F2/4
         C8JlzoNv8/6vCWH408Mb2mw3uD96lzeVpN9D5V/Bk3JyOWZb4sFo9F2Wnt7FhjRXOz3F
         eARKQln4CZAn+qSxVjp+6UpfcvGrEcH6Vat46En+yYk+b8mtefrhm5PbhXN7fTVwdnrh
         RaCLAbbwGjbD3+cuORf4JzBkk8QOyqIbCSPgm9T79uU4nHMnsOg+btV/W6fPAqPE8/RH
         4/ti8pRgdsghW+nG/9vVF4EwP2w1StvxjUjVhlXlmsykAFaA9qe/NdUS81OjgqSONcoY
         lGaw==
X-Forwarded-Encrypted: i=1; AJvYcCWuadL+3LoRJNiMbVfdWMPuYE+xIO0EKXpu567NjZEEWEYKoCWZ3wKnk+nC9czwQvwOfAj5TfnEjoNYKm7l@vger.kernel.org, AJvYcCWwZZohmCzGq56krNQMX/EGJAfoHtHGfYGlvknygvT9Wum/5FtGVA/DZVn9hIq4nccp8R2juBsikygE@vger.kernel.org
X-Gm-Message-State: AOJu0YxVswZ7p8sK+qPw0OWpuROb0Iu0Yy2nh4Sxc2SlnM0CXuaQO1Wa
	syik21S00fo4nC0naDFJkuNeEBeReA1loXaO2aYt94nL/KBVrlUY
X-Gm-Gg: ASbGncvKcNj9E8SJuX+hlidT6Gdepe9BiqLe7Y/kN9BMD/xrl2W04JfYhwyYNWhS+TM
	/o10UthX6fz907uZvc3OFS0wLWC6/NqKDKkO7riEv6Gp6J7ZWfh309XrZeGpcW0E2igAk1EAv1a
	IohtPaoBUZbD7rMG+5L20Gj3lXO4W3D/yZVvvQpu5BVRel3PE009K/W1EZTAJAGf/4YezFTh2RW
	B6MMhKy7bP51sAI5q0bKHDlfZgZF7mscl2gze2pseZsh1rG80byBjCDKZGqq9L3rk69SHDV8AYb
	C/7UdG5cU67dpQmc9Kqpo7D1uM4IUk2u6Hp6ulQv2b7lZQ5/oke23yrXA9lkBdr1vHHYyF+6Xwc
	2mDMNj2E=
X-Google-Smtp-Source: AGHT+IGxi6nV2n7varj0qhe6d2tnIqqhV16RoNl0Qc8fSY/LOPv+JoBGfDdaLR/jA9RX2SzmSWv2Dg==
X-Received: by 2002:a05:600c:5849:b0:43c:f81d:f with SMTP id 5b1f17b1804b1-43d52a2068emr83255765e9.8.1742833810655;
        Mon, 24 Mar 2025 09:30:10 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb0669sm124106765e9.34.2025.03.24.09.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:30:10 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: bus: add documentation for the IMX AIPSTZ bridge
Date: Mon, 24 Mar 2025 12:25:52 -0400
Message-Id: <20250324162556.30972-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
References: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add documentation for IMX AIPSTZ bridge.

Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/bus/fsl,imx8mp-aipstz.yaml       | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml

diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
new file mode 100644
index 000000000000..c0427dfcdaca
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/fsl,imx8mp-aipstz.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Secure AHB to IP Slave bus (AIPSTZ) bridge
+
+description:
+  The secure AIPS bridge (AIPSTZ) acts as a bridge for AHB masters
+  issuing transactions to IP Slave peripherals. Additionally, this module
+  offers access control configurations meant to restrict which peripherals
+  a master can access.
+
+maintainers:
+  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8mp-aipstz
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: bus
+      - const: ac
+
+  power-domains:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  "#access-controller-cells":
+    const: 0
+
+  ranges: true
+
+# borrowed from simple-bus.yaml, no additional requirements for children
+patternProperties:
+  "@(0|[1-9a-f][0-9a-f]*)$":
+    type: object
+    additionalProperties: true
+    properties:
+      reg:
+        items:
+          minItems: 2
+          maxItems: 4
+        minItems: 1
+        maxItems: 1024
+      ranges:
+        oneOf:
+          - items:
+              minItems: 3
+              maxItems: 7
+            minItems: 1
+            maxItems: 1024
+          - $ref: /schemas/types.yaml#/definitions/flag
+    anyOf:
+      - required:
+          - reg
+      - required:
+          - ranges
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - power-domains
+  - "#address-cells"
+  - "#size-cells"
+  - "#access-controller-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mp-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus@30c00000 {
+        compatible = "fsl,imx8mp-aipstz";
+        reg = <0x30c00000 0x400000>, <0x30df0000 0x10000>;
+        reg-names = "bus", "ac";
+        power-domains = <&pgc_audio>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        #access-controller-cells = <0>;
+        ranges;
+
+        dma-controller@30e00000 {
+            compatible = "fsl,imx8mp-sdma", "fsl,imx8mq-sdma";
+            reg = <0x30e00000 0x10000>;
+            #dma-cells = <3>;
+            clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SDMA3_ROOT>,
+                     <&clk IMX8MP_CLK_AUDIO_ROOT>;
+            clock-names = "ipg", "ahb";
+            interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+            fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
+        };
+    };
-- 
2.34.1


