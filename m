Return-Path: <linux-kernel+bounces-553142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC840A58475
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C2B3AD007
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BCB1F4CA9;
	Sun,  9 Mar 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM9v8yh7"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408441F099F;
	Sun,  9 Mar 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527057; cv=none; b=Zhk0OFFs6O1IdpsLpBlWQcbkd3ZhacOZiHM+gdPY1ren4aKEqIZZ64zPulir9j2VtHA0uajHInaixnOgyCaZ7jOFHirgLR/JQu5GiuHBhDnXKZir84dr0hDrzrX1UHSISLurn3OPbcBhBmh16tYsZUiODZcMLbbmDuN3rM/fO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527057; c=relaxed/simple;
	bh=Z0XKnTc4JlMHJKgXDJ9vWf7zYgHFG4SJ/S4ViwY/9CQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeyD6mH5lFI962NHizDVV0B9OSohAt7Zr8tReCNQOVW4WYiiQQygFMJ7oTXu3ozxUrAo16O5AxRl2RtJMR4IogPScG5pjQjRdxtAiKEpIuzAJv/jMnEtSOmOC/p7AY7wEM115EMUsZJylKk0L9AV/Ro/zBxv3W+eiloyhLT4DMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DM9v8yh7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948021a45so28847415e9.1;
        Sun, 09 Mar 2025 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527053; x=1742131853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuJuN5e8INaAlM6qxY9WAob6GPx4Mq94a1xQWHzf+1M=;
        b=DM9v8yh7vQcSu9aJnHbN5wDM5VXUOxEPPZ1RLL/LmcRSAERNREkHnBeLgat/kpqQ8T
         yvWZ80tE+GQy2WQ1t+pwb8huO2pyecSj2gBTC3tMYaEnQfjRUpnjm6KMDFUXZggOk2M0
         0kAIB0p9FV/d+woYDk6JA76w3aGVTB9ec2HWT0hm2aOK9yzauSn0a7YzasV/6+2Ab6XX
         AzAtnWQ9uqGCCTqLoi7ub4N9+SDE4acCedaVXdFJMKfnJcUt5QAJ9SJX5bN2we1feIaU
         vE602/sWFMQaaWS23h3tATXvk3l+63tZ94T2vBcSIEBTRIRq5SrFMIVYijVLVgEa3VTY
         NUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527053; x=1742131853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuJuN5e8INaAlM6qxY9WAob6GPx4Mq94a1xQWHzf+1M=;
        b=byj+1/ILCTaL6B6lg/HmQrxaJagTliGdi4f7s08/GCmFZRN9LOCtZULH0FXjta2cqj
         Lcki3LU/djYPTAR2INyhQ0NSd55614euVZTPV5FChGn97y2qHof8XuJyQBYa+Frpz+NL
         dZAsAeBesbFkxXqz0fRe0LpdKCIyfRHIDYZr9UaQW0t4iJr+AkpHdlqsgcaVgM8lgpt8
         wOUhGwGmZEtHD1jld8latoQzLO8/U9WDfF4UGL5IJKFYG3RSi4OwzTltRGkWjOV0e1DT
         ZCeOLWcH+W8D8EapbBET/3uVhlbXyw9Fs3SW7JTZkdIbvH68JL63OSeAOWHG6pspezUe
         PwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHdaUbl2QLlMjHj/6kV1I2rtViD4OTAMPbeukOIJ3BkqTW/Ht2QlxXEuWToCmIHXWRW6rFvb63+rai@vger.kernel.org, AJvYcCUoal1SIoLTKIh7ttmDeOQvfQu3AJAlwT2UubjTqINrzwYSO4p3iVhr3xOubcrwFKb1l+n84fOT5b01qgKE@vger.kernel.org, AJvYcCV6/l696jLzzsY6Fpktt4HvjI42jPZyKYiSkp16mb/0zYkHHnB90ob3lno9rJZOyJHJDyjneLJd2Ek1@vger.kernel.org, AJvYcCW4Wv0raxr0EMgLNCyG0p5vMEfM01Bp4LfwK3urAQfzMElzoy6c8msfG70o8SwtSFfjjmJNLt/q0IPo@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNtZj867nZTy4h07dXrvqUUQhe8aW5EsJPStyTYpar4gFCNWs
	JXUykcQBU/BqT7ZjHerXNk3+VDCJXjYaNiH58Qqn/fudxKGXilCr
X-Gm-Gg: ASbGncvlZDJ3Dfkz/bfgK6q7vHORh8jXXQxnVmFAx7FnxCXR+mppsnLc9sOgN0o0VqQ
	4hKIZviofgAEPGgxhw9W6H7phkAb+J7vRCul+N0NvPnDwiYFdJsutA7bCm+gE7N6w7rZLkvDL+d
	er4WnnqSeu1QFyOInwqEMCqoJRP2RviHU/4X0pq4Z5Js+WcHbeJdXcVRwHJqkJvbRMrXSxJAzve
	mEJcoZ4jBuOUXa3Vpf+mY7Ue6lo0BE5MYURiJ5F1tw6stL/KdY4LarTM7G9xNY05Ib59LsQ5hPE
	X5cKxkadqx3itZCLgbY1O/RZ4uQYVZzYiy8wHckeO+5OkVPGK9xq0tx4vzKAtVZ5Zlfgj91H+cr
	h/JW9+bwwDEFL7g==
X-Google-Smtp-Source: AGHT+IFGo9ofFT7kEEvkQR0bhsGyGhheZZrnScLSJMBE5tOsiIR0FkCqZHSoqIPzYPa4wsJvnG0KVA==
X-Received: by 2002:a05:600c:1553:b0:43c:eacc:9d8c with SMTP id 5b1f17b1804b1-43ceacca0f7mr22400025e9.24.1741527052936;
        Sun, 09 Mar 2025 06:30:52 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:52 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
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
Subject: [PATCH 09/13] dt-bindings: phy: Add documentation for Airoha AN7581 USB PHY
Date: Sun,  9 Mar 2025 14:29:40 +0100
Message-ID: <20250309132959.19045-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
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
mode currently configured on the system for the USB port. If USB 3.0 node
is defined, then airoha,scu-ssr property is required for Serdes mode
validation.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/phy/airoha,an7581-usb-phy.yaml   | 106 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
new file mode 100644
index 000000000000..39127cfb63a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
@@ -0,0 +1,106 @@
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
+  mode currently configured on the system for the USB port. If USB 3.0 node
+  is defined, then airoha,scu-ssr property is required for Serdes mode
+  validation.
+
+properties:
+  compatible:
+    const: airoha,an7581-usb-phy
+
+  reg:
+    maxItems: 1
+
+  airoha,port-id:
+    description: Describe the physical port this USB PHY refer to. A dedicated
+      osciallator is used for each port for the USB 2.0 Slew Rate calibration.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  airoha,scu-ssr:
+    description: Phandle to the SCU SSR node for USB 3.0 Serdes mode validation.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  usb2-phy:
+    type: object
+
+    properties:
+      '#phy-cells':
+        const: 1
+
+    required:
+      - '#phy-cells'
+
+    additionalProperties: false
+
+  usb3-phy:
+    type: object
+
+    properties:
+      '#phy-cells':
+        const: 1
+
+    required:
+      - '#phy-cells'
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - airoha,port-id
+  - usb2-phy
+
+if:
+  required:
+    - usb3-phy
+then:
+  required:
+    - airoha,scu-ssr
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@1fac0000 {
+        compatible = "airoha,an7581-usb-phy";
+        reg = <0x1fac0000 0x10000>;
+
+        airoha,port-id = <0>;
+        airoha,scu-ssr = <&scu_ssr>;
+
+        usb0_u2: usb2-phy {
+            #phy-cells = <1>;
+        };
+
+        usb0_u3: usb3-phy {
+            #phy-cells = <1>;
+        };
+    };
+
+  - |
+    phy@1fae0000 {
+        compatible = "airoha,an7581-usb-phy";
+        reg = <0x1fae0000 0x10000>;
+
+        airoha,port-id = <1>;
+
+        usb1_u2: usb2-phy {
+            #phy-cells = <1>;
+        };
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index fe34c80b8d52..c2dd385e9165 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -753,6 +753,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
 F:	drivers/spi/spi-airoha-snfi.c
 
+AIROHA USB PHY DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yam
+
 AIRSPY MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.48.1


