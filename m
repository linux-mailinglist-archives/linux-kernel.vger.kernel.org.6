Return-Path: <linux-kernel+bounces-569731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09B4A6A6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6857B165C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A71029A5;
	Thu, 20 Mar 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7m4GsLf"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E89215F49;
	Thu, 20 Mar 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475707; cv=none; b=PCDnWC8sDvlNAjQCiFIKJZEWISOHtvPAcVq9Xa+vA10YkQ5bH5hAbxUcHZ6zcrL+KbqCoE7m/m2rB0ORUTq2TLDJLDaGfzDNle4pPtzUZHzWVbZa8xCJIpRCsiHPEeT8LfpRIfhlCrMQJTe+1O1bISBogcaO0OQUEjeOEBb775U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475707; c=relaxed/simple;
	bh=SSozAsF/5m7XLQJyMeCRrbZnfi5DVNHjPizHjjVGrl8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLFMr6nb2ja0keg3pSafTQNeaY84VPumimXsAS1nJBLU2mgDtacrtKMAem/Lo5beoJKjcG4WhTWckTVowdsDad9wogAXd3nQc3qwdQeusyefXGLe6gvHR5ox3vwBx4CJWtoqWldKU8xtiF0KHQYzk4bsn3Z5XpceEelevKXnkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7m4GsLf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-394780e98easo444446f8f.1;
        Thu, 20 Mar 2025 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475704; x=1743080504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vc3dKjde0rLVyDC0QPLc/14aVKYKizi/3+LepGRxWFU=;
        b=A7m4GsLfXnsL/v+ynQSycdAzvKJyIgF72GtuFMNbmGUedoQJ1pk/yV2oHaD6XoFg8D
         L7JWvC9jkGSxqGQViLTDqnKvmgEGoUmttQGiX2kY2Lw9ktJuWIzdUSsthPDo3BuVgyzo
         7/qrhlf+0H0WaM3P3seITkuJwMqljp04eorXc5pR5rCyWUB7s67zm4ezF7wE7jBeijZM
         andNi9ZaCVLbBlnSYSawXo3i+E9IfYwaMs0mOmIgIbd+kf1nRjtNv6Lde0IFSyPmk6RJ
         gMlZMEkb4vvQ1/uZqcSvLcrEssXmrvaph54kgfyIO6lI/TSFbojU/OuFleBDyUZBkd1P
         F8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475704; x=1743080504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vc3dKjde0rLVyDC0QPLc/14aVKYKizi/3+LepGRxWFU=;
        b=F9Fny0gSJvBCEIwGcLJRSCNZcQ2MaUnU6dJJ5dx85IDUBPOUb/8uJdr75YfTMBqqEm
         QPHvuHxwEj9p8uWJRUo/kHwJU6tXsvnMHR+GIiljKQmNSJiOXE2xHKpXxJHEiAq0+MVu
         +kkIZiMn9VzirukpLZC5kc0THdo3457SmdoIE+eB0y/c0lFk8GGbk/tzmMA1R8Ld87vN
         tL1ZBzFxHkwpC794+f0YQUhY0vElTIfA3bN8GkLwcVn145/ZZ9O0LbqjFaU78s09ScNy
         BuiPDWvX40Z+A+Kk5qivNlz5U7i99TjBkDmlTjNr9DFgsRieDSn81KP3aMVWypu1sC50
         inCw==
X-Forwarded-Encrypted: i=1; AJvYcCUu/Ij/xJWVPva0a/aWNf7D4fGP7TSZGgJX3M41LPaaR2MHTw/tJtZHTgNJzjs0JpagJYYA8MHMxXL3@vger.kernel.org, AJvYcCUx4Q87R2u/CwD7fu55fElG2GgAi7jfVlF/sYY+4+UxfXEBVfMvnM145F4+1e16YxGfJ0M8QVpsOUUe@vger.kernel.org, AJvYcCVMpZQKz/xjsb9cNVOZmD7Too+xIMiUszKT7N7SwKn4qkwNutVCvxfNohrTwaSLrCEG35omjsgERSeX@vger.kernel.org, AJvYcCWWxhqH/Jdpi72zUj39mAqmU3vUu5F5QUo4fpdv8p9ytZC62Nbf4/kOs7yunMo+TXXt2F7evgQzyOxVU9q4@vger.kernel.org
X-Gm-Message-State: AOJu0YznkTxTGcPHuSpEUS//zR5E2KHn+3BRcKrcMzjHKzZI0jGP8vwY
	wy35mfNDNkp+Y+1RJG1CF692Nj6xlBu2T5ErChlsW7PGSdDFrSg5
X-Gm-Gg: ASbGncvcnMXlFlOpmZ8lQ4FAOsWaXyLblogMAZBapJMUDW3E0UYvn1X/g48TNRstRXJ
	DpAmM0tl5L9SCC+L1H0tmhNWt81RMLePibzW0z/SSWp/aRKqtbbnTw7lxHYr+31WT7WaFSde73q
	eQVV1gkt3p59nC2LdeSTFiLGbITy4K0i99GGFIUY8awL+wNiiFTNdzczYroBgeq0SRCPZ0SmoR7
	iXzfAA/GPjG9eyFTisl7iGZL89x4Qh1BRym06D3JTrYP0yYn1TSDtJ+S1siK2oxi55qnJxvVqIr
	F43AplgfYX0yGfZce4/wf2MmSpnVLPhzEEaLWUxJmbBOqSBDOtMxVxoiFOBJtAg+XQJFaxZRCJL
	PZkr0JMxTqO+D7A==
X-Google-Smtp-Source: AGHT+IF/l6XMrjHci+BW3RGcUAaz5jM7jX2EkvkrL4ZuF2YFu9cX6Xupx/UFNRAGRB5FWZYiIkaFbw==
X-Received: by 2002:a5d:6d07:0:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-39973b32cf5mr5739209f8f.42.1742475701698;
        Thu, 20 Mar 2025 06:01:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm18492328f8f.97.2025.03.20.06.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:01:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 07/11] dt-bindings: phy: Add documentation for Airoha AN7581 USB PHY
Date: Thu, 20 Mar 2025 14:00:30 +0100
Message-ID: <20250320130054.4804-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320130054.4804-1-ansuelsmth@gmail.com>
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for Airoha AN7581 USB PHY that describe the USB PHY
for the USB controller.

Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
always supported. The USB 3.0 mode is optional and depends on the Serdes
mode currently configured on the system for the USB port.

If the airoha,serdes-port property is not declared, it's assumed USB 3.0
mode is not supported, as the Serdes mode can't be validated.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/phy/airoha,an7581-usb-phy.yaml   | 83 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 .../dt-bindings/phy/airoha,an7581-usb-phy.h   | 11 +++
 3 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
 create mode 100644 include/dt-bindings/phy/airoha,an7581-usb-phy.h

diff --git a/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
new file mode 100644
index 000000000000..39ceaded5d0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/airoha,an7581-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN7581 SoC USB PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  The Airoha AN7581 SoC USB PHY describes the USB PHY for the USB controller.
+
+  Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
+  always supported. The USB 3.0 mode is optional and depends on the Serdes
+  mode currently configured on the system for the USB port.
+
+  If the airoha,serdes-port property is not declared, it's assumed USB 3.0
+  mode is not supported, as the Serdes mode can't be validated.
+
+properties:
+  compatible:
+    const: airoha,an7581-usb-phy
+
+  reg:
+    maxItems: 1
+
+
+  airoha,usb2-monitor-clk-sel:
+    description: Describe what oscillator across the available 4
+      should be selected for USB 2.0 Slew Rate calibration.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  airoha,serdes-port:
+    description: Describe what Serdes Port is attached to the USB 3.0 port.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  airoha,scu:
+    description: Phandle to the SCU node for USB 3.0 Serdes mode validation.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  '#phy-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - airoha,usb2-monitor-clk-sel
+  - '#phy-cells'
+
+dependentRequired:
+  airoha,serdes-port: [ 'airoha,scu' ]
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/phy/airoha,an7581-usb-phy.h>
+    #include <dt-bindings/soc/airoha,scu-ssr.h>
+
+    phy@1fac0000 {
+        compatible = "airoha,an7581-usb-phy";
+        reg = <0x1fac0000 0x10000>;
+
+        airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL1>;
+        airoha,scu = <&scu>;
+        airoha,serdes-port = <AIROHA_SCU_SERDES_USB1>;
+
+        #phy-cells = <1>;
+    };
+
+    phy@1fae0000 {
+        compatible = "airoha,an7581-usb-phy";
+        reg = <0x1fae0000 0x10000>;
+
+        airoha,usb2-monitor-clk-sel = <AIROHA_USB2_MONCLK_SEL2>;
+
+        #phy-cells = <1>;
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 7cd54c70aeed..c4a374da2b12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -754,6 +754,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
 F:	drivers/spi/spi-airoha-snfi.c
 
+AIROHA USB PHY DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
+F:	include/dt-bindings/phy/airoha,an7581-usb-phy.h
+
 AIRSPY MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
diff --git a/include/dt-bindings/phy/airoha,an7581-usb-phy.h b/include/dt-bindings/phy/airoha,an7581-usb-phy.h
new file mode 100644
index 000000000000..efbb0ae75e3a
--- /dev/null
+++ b/include/dt-bindings/phy/airoha,an7581-usb-phy.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_AIROHA_AN7581_USB_PHY_H_
+#define _DT_BINDINGS_AIROHA_AN7581_USB_PHY_H_
+
+#define AIROHA_USB2_MONCLK_SEL0                 0
+#define AIROHA_USB2_MONCLK_SEL1                 1
+#define AIROHA_USB2_MONCLK_SEL2                 2
+#define AIROHA_USB2_MONCLK_SEL3                 3
+
+#endif
-- 
2.48.1


