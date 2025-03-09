Return-Path: <linux-kernel+bounces-553137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C32A58461
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DD2188C14D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934C1E5205;
	Sun,  9 Mar 2025 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqGOZNFC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E51DE3A9;
	Sun,  9 Mar 2025 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527048; cv=none; b=f8tn7qdjIGZlO1j9ofMbbJ+9cabpywmR33Qrq9q4VAOl8v0cTyI7UIXB9CK6AxvKUYoYKQmvIhSQ+gq8u1/m94xzCBpO8ObHTzHHOnQDIL7V9t3tPwN6Cxpk+x+AIUy6+5fWA2a7aUfLsjCA/rhKIl1BhXiVmc2GppSQ4n6DzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527048; c=relaxed/simple;
	bh=N6fTVaKuSmGlZLYP76QgkEgoA1lQ16P73v1QI/K94NE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoQYg8itH57OUfB7HSWG2CB0aji3Cl9HOuoeIvmkEVxe71DWQE2pinhvxua0Lq61lntbFxdWUfjIL7EmupYoxGEUSnk+/t0cprGESfe5yECw12csPp4al4zRAvIqI18p0/p/27Ev0rgY2DS3Gk+Z7uukA/31NGxseLenGeUl7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqGOZNFC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf680d351so952285e9.0;
        Sun, 09 Mar 2025 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527044; x=1742131844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7rAztQuL1fqEwNhgIxMbKU2YwJ5HINRdQASSAMKL28=;
        b=mqGOZNFC/Xzui3OP15AnSb5QLZZE1xYm0qiSEcQDimgbz+89Pxa1YEv8odbSAyXret
         NW76TIgduiuoHfmlEvnKmIcxtab+IKgdGiBaqdIu5PkWGVqRDkEZCQpGKaUFX2BnXqBl
         qrs29u7gLYYS7H78Kk+7aXtYYOvyNzPQz/ZY3zkrKlkXTwFCHZNhn/PbY6fZ+P3Ks2jF
         0cZWqJm6rlmC/Jt20G2ovUGtXup+THiu8f/DToHDUgphvLHSKSxv7cLiZanWawEbUtrA
         +tgMHT2NlPqZ710VSBSd1xWvjTO+uNr2stuJtSqxu+tlN8YZ3A+vhSgvNL0VtP6b3vf6
         9HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527044; x=1742131844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7rAztQuL1fqEwNhgIxMbKU2YwJ5HINRdQASSAMKL28=;
        b=cv381egsN9XoAVVy91aNOXdSGjger+YFH1EXBVjD0k7ucpFfQq78cJuHw4gwZGAcW3
         RVyzMrZwuYVQhZAB6noAvGHjDiI4mXa57UxhtKF2BzhW7TuwMe1w3Yi3sHfvvZbZk5n/
         Ejr1pQ5bb5ftF67RorD8xTyLhhCFoRKZkMBxbTWWtzc5LKFOdCKnsB2dPxMBmxOcNCNI
         9fJ0kCdi4/nZHF/+9pnnYU93h5lePEM1Zt9/UzBDmd1mqI9Dgx63dc101+YGSQkFlLii
         283jvR0CsVuJa1X6oHFXfo658eZuP0GQpLGdFhCSolYX3lbseJcRSBZZ3k5ap2jqUX2t
         NJqw==
X-Forwarded-Encrypted: i=1; AJvYcCV3/w8LaZU2B8drJz++CmgBm/05nEa083NxaxBBfnwJx8We9lxSFDqJoRALHM/ZwdA3gAGWNnkV3wUP@vger.kernel.org, AJvYcCVJZk6mT//7aXzLG9HuGWAaspaNi9V7O5LXHDPMXB0vqS0xGSqRigvgGXfT2CixJcAxtS1eYYhj9Frv@vger.kernel.org, AJvYcCVfVzCMQH3GFYaobyp9e53S9Jf+nzpCCM0L1z1/jPyC9ADpEb1y+9HHOMCgInGMsB2AhBI4hv8N0MMO@vger.kernel.org, AJvYcCVqade5nxDmOD1fx0v1to87vRk5QX9Va5H6M5gQRDAjWIknxW4vK3R+gMvxNXPz+DVw9mBzLmnOG9wkMewg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/BLWioMEgP0glU3rp2pwpWNr20G0H6X6/vLiEYjEF8aNa90eE
	xZXJGLpGTDtcLRRsNqz0oHiXiGnsUVStH2er0gdKw6th4RRkLbHI
X-Gm-Gg: ASbGncssgz5GEAw96UxSH+nmR/wQeGP3A7vZePXB/1FHc+xt51TP0NZkgCTCH3LSsJu
	iaf4CSyYHrGTqpQl3hhaF4TxxJYKSY1O8lE0wpuXoASnwayK6zJs2tBo8B/CF0on+PE8Zsypljf
	84AeMc+e1/z9Ir40HisnADS06Ldhcew7Opb9OcEQ8AjvW6lTwG1zYRLJvxBz3Ghxrc/o0Vf+PSO
	8/qvz9659b6Aseonsov5YeYczSkSNHKpenQDw0G3uIv6X2CFCDk0QYERK0OH+zR0J6QEwFcZqKK
	9PGuijdkNPWB69Jzn/RQP2stlJIG+4q3MPSgr30Qj703pfaSx3TIuHDmZ618djYn5EUx6x5TKkF
	t75NOH6qEqyFi8g==
X-Google-Smtp-Source: AGHT+IEuhfvObU9vao062mg4FvmF1NzkPbIvIIx2h56yBlcCJSeWP0LGYj1OCWvIasRINrETP+XnDA==
X-Received: by 2002:a05:6000:1842:b0:390:f116:d220 with SMTP id ffacd0b85a97d-3913af09864mr3103348f8f.17.1741527044465;
        Sun, 09 Mar 2025 06:30:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:44 -0700 (PDT)
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
Subject: [PATCH 04/13] dt-bindings: soc: airoha: add Documentation for Airoha AN7581 SCU SSR
Date: Sun,  9 Mar 2025 14:29:35 +0100
Message-ID: <20250309132959.19045-5-ansuelsmth@gmail.com>
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

The Airoha AN7581 SoC have in the SCU register space particular
address that control how some peripheral are configured.

These are toggeled in the System Status Register and are used to
toggle Serdes port for USB 3.0 mode or HSGMII, USB 3.0 mode or PCIe2
or setup port for PCIe mode or Ethrnet mode (HSGMII/USXGMII).

Modes are mutually exclusive and selecting one mode cause the
other feature to not work (example a mode in USB 3.0 cause PCIe
port 2 to not work) This depends also on what is physically
connected to the Hardware and needs to correctly reflect the
System Status Register bits.

Special care is needed for PCIe port 0 in 2 line mode that
requires both WiFi1 and WiFi2 Serdes port set to PCIe0 2 Line
mode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../soc/airoha/airoha,an7581-scu-ssr.yaml     | 106 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml

diff --git a/Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml b/Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
new file mode 100644
index 000000000000..4bbf6e3b79a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/airoha/airoha,an7581-scu-ssr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN7581 SCU System Status Register
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  The Airoha AN7581 SoC have in the SCU register space particular
+  address that control how some peripheral are configured.
+
+  These are toggeled in the System Status Register and are used to
+  toggle Serdes port for USB 3.0 mode or HSGMII, USB 3.0 mode or PCIe2
+  or setup port for PCIe mode or Ethrnet mode (HSGMII/USXGMII).
+
+  Modes are mutually exclusive and selecting one mode cause the
+  other feature to not work (example a mode in USB 3.0 cause PCIe
+  port 2 to not work) This depends also on what is physically
+  connected to the Hardware and needs to correctly reflect the
+  System Status Register bits.
+
+  Special care is needed for PCIe port 0 in 2 line mode that
+  requires both WiFi1 and WiFi2 Serdes port set to PCIe0 2 Line
+  mode.
+
+properties:
+  compatible:
+    const: airoha,an7581-scu-ssr
+
+  airoha,serdes-wifi1:
+    description: |
+      Configure the Wifi1 Serdes port for:
+      - 0: PCIe0 2 Line
+      - 1: PCIe0 1 Line
+      - 2: Ethernet modes (HSGMII/USXGMII)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 1
+
+  airoha,serdes-wifi2:
+    description: |
+      Configure the Wifi2 Serdes port for:
+      - 0: PCIe0 2 Line
+      - 1: PCIe1 1 Line
+      - 2: Ethernet modes (HSGMII/USXGMII)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 1
+
+  airoha,serdes-usb1:
+    description: |
+      Configure the USB1 Serdes port for:
+      - 0: USB 3.0
+      - 1: Ethernet modes (HSGMII)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+
+  airoha,serdes-usb2:
+    description: |
+      Configure the USB2 Serdes port for:
+      - 0: USB 3.0
+      - 1: PCIe2 1 Line
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+
+required:
+  - compatible
+
+allOf:
+  - if:
+      properties:
+        airoha,serdes-wifi1:
+          const: 0
+    then:
+      properties:
+        airoha,serdes-wifi2:
+          const: 0
+
+  - if:
+      properties:
+        airoha,serdes-wifi2:
+          const: 0
+    then:
+      properties:
+        airoha,serdes-wifi1:
+          const: 0
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/airoha,scu-ssr.h>
+
+    system-controller {
+      compatible = "airoha,an7581-scu-ssr";
+
+      airoha,serdes-wifi1 = <AIROHA_SCU_SSR_WIFI1_PCIE0_2LINE>;
+      airoha,serdes-wifi2 = <AIROHA_SCU_SSR_WIFI2_PCIE0_2LINE>;
+      airoha,serdes-usb2 = <AIROHA_SCU_SSR_USB2_PCIE2>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d3125268d63f..9944845ae9f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -740,6 +740,7 @@ AIROHA SCU SSR DRIVER
 M:	Christian Marangi <ansuelsmth@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
 F:	include/dt-bindings/soc/airoha,scu-ssr.h
 
 AIROHA SPI SNFI DRIVER
-- 
2.48.1


