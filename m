Return-Path: <linux-kernel+bounces-575503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28829A7036D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB971888A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469E259CAE;
	Tue, 25 Mar 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rRi9JkbY"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40981DE3D9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912009; cv=none; b=bhvTO1DGuIbdW6Np+ykSo+8tdavEZHlTJ1Dw07j4+YnmKdKjKz3QfzSjmKeqAk0lSAzc73l3/wvfUSI8M9lkxK2z4ZHTmhBHHV/ivQnRDz4adRbDAeZOnKi5P8l0D4iLCnjWnFuYS5KBWW4iBjNal7+bJs/TDd657CMO5347z5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912009; c=relaxed/simple;
	bh=3yXpnSWDBQq0p64UvqJmPhV+biVOzsfuFqv9izqoaNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYQT5Oa8TAssKh91hSUkF1HSWW1Bvu2ap+qln8QxAW+lOy/jLtgl7/eSwZ9yh0phAjNIS+Wowvqrr6OmmNnIkuVeLMSQ9vNgxWTj/bhX6O4suegDacioBbB1+99ful0wfyxtqe2K59e693dKWQLDsXJeOIEjFcxW3kNtvxLdMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rRi9JkbY; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F11F402F6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742911997;
	bh=dQe7H9U1jfXffyxDZew1boCw61jbY/93ewTdhDfN7Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=rRi9JkbYyMtQl0nXEyv/Oy7YHG+lmnYAzqSZmmnXK1VKqpVy8vqdDh/Q08ZmyebJb
	 Wbh5xh7UccHJ3C0yl1/53u97qKXPkptWx9kCncGpX+221Op6qI1Dpc/2mRi+EodWq4
	 FXY/1q0wEvhh1dFEjlmO8idYh2UXh+xc9yhMSeqKAkwkvdQrWfDCu8MPkCWns5juHO
	 6yrk1hJ3y0YbzUxVCx9MvxfmVQIIkBGhiM5XkcZPnh18keQkORBm2SLvLTNSi7fy1y
	 q5mYutz3UaJ9tR7RTVyudCf6dgOGtTfMOf74FEBRtjMiyj94wjcnzHzkiX1W4sdbsE
	 /vL7bII4Oqecw==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-394bbefc98cso3358641f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911995; x=1743516795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQe7H9U1jfXffyxDZew1boCw61jbY/93ewTdhDfN7Fg=;
        b=b+7QxX6uUs0ipPNdCiuQBXUzhBpDFK86uAOKtVerSHguOWyE8GlcfvRtQhFSi5hfhs
         iSG/VwK8qigHgq6zmdBC7gkba7tNOm3ZSmy4L3NzRbj7UMUpYtg4BypLVHDlAxzcmigu
         XzbeHHOJhFNSyovhRqKO2yy7Z1gH5t0Cvfi0Ub5wtKMrgjC+nGXoarJDeLblkr9T9D7l
         Wyne0vk3Ofkz4D0VRStY66uuPbKeFugDCD+B4sDUg8MQOq2ze6KbPlIYNHSfmeiK0GuN
         pyq1rk85LmS26uBHK8BXo10LdGK0nB9ntcSqgEAkLXnPc+PGC0dYVMVulE3kdRKQb0C+
         1EUw==
X-Forwarded-Encrypted: i=1; AJvYcCU8rYl31/FX5XcRfKjOR/msEcT2fbX+the5NLfjR4iBLqTj9+enAOYcG3cCmJhO9B1/Q+K9WksKSoRmoWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSXBUZwkMoZBqvPkcJuZksKvDXiglg//9UZvp4iPw7jwKaumxI
	aErTvtEOAzWGe5eU24Q4z9NlseO3Qa0+ylpTO1puOyTtLPmvl6+VyhuIHzhQQ2QHuST0zhxtjdJ
	Z7/0xibwpaywscZvp6nEDlM4IjstSYwA0/Z0IN+pmeOlJbSzpUwQ40qXpQqDErB9/QfdC5U6Oqb
	+9BQ==
X-Gm-Gg: ASbGncuaNcRfmiwQPIzXR6UNuXBEwH0vlKcvmpL49wTlwqrA+R5gD/RJkOXJ0VRnsnR
	a2Ws/vy22sjflDBl8rWFA6ct+9ZzLtMv8UkVvawej3TY9YJdVol9Ru5gxN6IDmcfUu/yf+jegUU
	Be9xkqOhLJ3QziKRN+kpstGA+NMoGMg16RcYMYgJzLNoxKshy1nZUq1xpKiobJXzs3XrCcphR8O
	s9FkcO83BGRTBGL3oNoixHnfWA4wqFTX8Mgim8ktzAbqzozhU19hKXcBDIon0suwtAqnRhqPbgy
	oxYGqSHep/yorIPKs2mBotw2iPP+zQ==
X-Received: by 2002:a05:6000:2a6:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-3997f9404aemr17107081f8f.48.1742911995085;
        Tue, 25 Mar 2025 07:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE78N/yKFkd5sACTOi600OYQuNXlhXVEUf7SmL8hC+Ivi0buOCNdKaf2rmPFabBaYZo9IAMmQ==
X-Received: by 2002:a05:6000:2a6:b0:391:2c67:7999 with SMTP id ffacd0b85a97d-3997f9404aemr17106995f8f.48.1742911994481;
        Tue, 25 Mar 2025 07:13:14 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm13532091f8f.29.2025.03.25.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:13:14 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>,
	Min Lin <linmin@eswincomputing.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [RFC PATCH 1/4] dt-bindings: pinctrl: Add eswin,eic7700-pinctrl binding
Date: Tue, 25 Mar 2025 15:13:03 +0100
Message-ID: <20250325141311.758787-2-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325141311.758787-1-emil.renner.berthing@canonical.com>
References: <20250325141311.758787-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree binding for the pin controller on the ESWIN EIC7700
RISC-V SoC.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 .../pinctrl/eswin,eic7700-pinctrl.yaml        | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/eswin,eic7700-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/eswin,eic7700-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/eswin,eic7700-pinctrl.yaml
new file mode 100644
index 000000000000..8ef966cebc5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/eswin,eic7700-pinctrl.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/eswin,eic7700-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESWIN EIC7700 SoC pin controller
+
+maintainers:
+  - Emil Renner Berthing <emil.renner.berthing@canonical.com>
+
+description: |
+  Pinmux and pinconf controller in the ESWIN EIC7700 RISC-V SoC.
+
+properties:
+  compatible:
+    enum:
+      - eswin,eic7700-pinctrl
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  '-[0-9]+$':
+    type: object
+    additionalProperties: false
+
+    patternProperties:
+      '-pins$':
+        type: object
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml#
+          - $ref: /schemas/pinctrl/pinmux-node.yaml#
+
+        additionalProperties: false
+
+        description:
+          A pinctrl node should contain at least one subnode describing one
+          or more pads and their associated pinmux and pinconf settings.
+
+        properties:
+          pins:
+            items:
+              enum: [ CHIP_MODE, MODE_SET0, MODE_SET1, MODE_SET2, MODE_SET3,
+                      XIN, RTC_XIN, RST_OUT_N, KEY_RESET_N, GPIO0, POR_SEL,
+                      JTAG0_TCK, JTAG0_TMS, JTAG0_TDI, JTAG0_TDO, GPIO5, SPI2_CS0_N,
+                      JTAG1_TCK, JTAG1_TMS, JTAG1_TDI, JTAG1_TDO, GPIO11, SPI2_CS1_N,
+                      PCIE_CLKREQ_N, PCIE_WAKE_N, PCIE_PERST_N, HDMI_SCL, HDMI_SDA,
+                      HDMI_CEC, JTAG2_TRST, RGMII0_CLK_125, RGMII0_TXEN,
+                      RGMII0_TXCLK, RGMII0_TXD0, RGMII0_TXD1, RGMII0_TXD2,
+                      RGMII0_TXD3, I2S0_BCLK, I2S0_WCLK, I2S0_SDI, I2S0_SDO,
+                      I2S_MCLK, RGMII0_RXCLK, RGMII0_RXDV, RGMII0_RXD0, RGMII0_RXD1,
+                      RGMII0_RXD2, RGMII0_RXD3, I2S2_BCLK, I2S2_WCLK, I2S2_SDI,
+                      I2S2_SDO, GPIO27, GPIO28, GPIO29, RGMII0_MDC, RGMII0_MDIO,
+                      RGMII0_INTB, RGMII1_CLK_125, RGMII1_TXEN, RGMII1_TXCLK,
+                      RGMII1_TXD0, RGMII1_TXD1, RGMII1_TXD2, RGMII1_TXD3, I2S1_BCLK,
+                      I2S1_WCLK, I2S1_SDI, I2S1_SDO, GPIO34, RGMII1_RXCLK,
+                      RGMII2_RXDV, RGMII2_RXD0, RGMII2_RXD1, RGMII2_RXD2,
+                      RGMII2_RXD3, SPI1_CS0_N, SPI1_CLK, SPI1_D0, SPI1_D1, SPI1_D2,
+                      SPI1_D3, SPI1_CS1_N, RGMII1_MDC, RGMII1_MDIO, RGMII1_INTB,
+                      USB0_PWREN, USB1_PWREN, I2C0_SCL, I2C0_SDA, I2C1_SCL, I2C1_SDA,
+                      I2C2_SCL, I2C2_SDA, I2C3_SCL, I2C3_SDA, I2C4_SCL, I2C4_SDA,
+                      I2C5_SCL, I2C5_SDA, UART0_TX, UART0_RX, UART1_TX, UART1_RX,
+                      UART1_CTS, UART1_RTS, UART2_TX, UART2_RX, JTAG2_TCK, JTAG2_TMS,
+                      JTAG2_TDI, JTAG2_TDO, FAN_PWM, FAN_TACH, MIPI_CSI0_XVS,
+                      MIPI_CSI0_XHS, MIPI_CSI0_MCLK, MIPI_CSI1_XVS, MIPI_CSI1_XHS,
+                      MIPI_CSI1_MCLK, MIPI_CSI2_XVS, MIPI_CSI2_XHS, MIPI_CSI2_MCLK,
+                      MIPI_CSI3_XVS, MIPI_CSI3_XHS, MIPI_CSI3_MCLK, MIPI_CSI4_XVS,
+                      MIPI_CSI4_XHS, MIPI_CSI4_MCLK, MIPI_CSI5_XVS, MIPI_CSI5_XHS,
+                      MIPI_CSI5_MCLK, SPI3_CS_N, SPI3_CLK, SPI3_DI, SPI3_DO, GPIO92,
+                      GPIO93, S_MODE, GPIO95, SPI0_CS_N, SPI0_CLK, SPI0_D0, SPI0_D1,
+                      SPI0_D2, SPI0_D3, I2C10_SCL, I2C10_SDA, I2C11_SCL, I2C11_SDA,
+                      GPIO106, BOOT_SEL0, BOOT_SEL1, BOOT_SEL2, BOOT_SEL3, GPIO111,
+                      LPDDR_REF_CLK ]
+            description: List of pads that properties in the node apply to.
+
+          function:
+            enum: [ csi, debug, ddr, fan, gpio, hdmi, i2c, i2s, jtag, mipi,
+                    mode, oscillator, pci, pwm, rgmii, reset, sata, spi, sdio,
+                    uart, usb ]
+            description: The mux function to select for the given pins.
+
+          bias-disable: true
+
+          bias-pull-up:
+            oneOf:
+              - type: boolean
+              - const: 25000
+            description: Enable internal 25kOhm pull-up
+
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+              - const: 22000
+            description: Enable internal 22kOhm pull-down
+
+          drive-strength-microamp:
+            enum: [ 3100, 6700, 9600, 12900, 18000, 20900, 23200, 25900 ]
+
+          input-enable: true
+
+          input-disable: true
+
+          input-schmitt-enable: true
+
+          input-schmitt-disable: true
+
+        required:
+          - pins
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl: pinctrl@51600080 {
+        compatible = "eswin,eic7700-pinctrl";
+        reg = <0x51600080 0xff80>;
+
+        uart0_pins: uart0-0 {
+            tx-pins {
+                pins = "UART0_TX";
+                function = "uart";
+                bias-disable;
+                drive-strength-microamp = <6700>;
+                input-disable;
+                input-schmitt-disable;
+            };
+
+            rx-pins {
+                pins = "UART0_RX";
+                function = "uart";
+                bias-pull-up;
+                drive-strength-microamp = <6700>;
+                input-enable;
+                input-schmitt-enable;
+            };
+        };
+    };
-- 
2.43.0


