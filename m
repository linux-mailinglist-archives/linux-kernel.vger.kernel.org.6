Return-Path: <linux-kernel+bounces-569727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF87A6A6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A048A1BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1202D2222A0;
	Thu, 20 Mar 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPRP3Wed"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF121D5B0;
	Thu, 20 Mar 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475696; cv=none; b=Iw3XnCB9U4xPK3uDPLZnOF4+4N9gDbrBZHc+1/W6mnVyHOdSbhtIvQNnOWwq5sJeDuYbVCIv/HD9L367JGqoN9ngYX4bM28EEWOej5H5SNlgOgSmAFmT0Af9McnRlY7FwhshOvB6riTb8T2noVml9olJKC6OGTNl7NHlcxc7JnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475696; c=relaxed/simple;
	bh=ayTqdfJD8FvvPK2vkym7GynT/nxfZuiU22hCU6AFgRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAb1Pg5g6Me+j6ZAE3JOU23tuCenshcVVMXe5RCHFLJ0yXRa3RqlR8nhyxSYlof26pKsIow/pXpvIfSEHfsGDeLUZAkX1BkBLcauuh2DNDkB++llqKI2708GlMsIx3YnNpcMkPsq1vwDnWIv/94rdlmbgjfgpMGSC7j5WOEtxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPRP3Wed; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913d45a148so621121f8f.3;
        Thu, 20 Mar 2025 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475692; x=1743080492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9NDCwlC9t4pV6apOxhp/Woh5xsA/boRS4RgotHWwmw=;
        b=fPRP3WedaHxTBp01Upz0mC77ZEVDc06shrxxqfpOzh2sq/DW29lpW0exXb36adIBxs
         PIYE90PBlwaWxh/+j0wu/I7UBG0SvCwNuDm4KAjqSrK+q3PjeYcfwWsspwmAaSNFFqyV
         UYcdWzPn0qa/aCl2iyQ6nP7xJ8Nbo+c8lcWbWfqhLxyrsl09OZEfgEe7Tqsb8QdZbDXE
         1ZkYDUbVoDU9qvgaGDYTP49SQo3tvg4IIPD1imoSCpTVQ4iKRxZ29D3ZdEXSAiTP5gB3
         Pdgfo/M6IhioctssQZ481qQcLG+VSbLaJeEixin0NrIUEn22VQv0c5oYM7EzX7LQGyMO
         mP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475692; x=1743080492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9NDCwlC9t4pV6apOxhp/Woh5xsA/boRS4RgotHWwmw=;
        b=tDN/B7Yd2QzviS0epV4MurWZNUz6d3mcMrg2R49GFqDCz7CX9RCR5EVkqEXtpDUAwL
         VDbl7lxBISmR1X2czOqLcCykjO+BBhQ6B7fxES3WX583IYKUU9Zwx2uscEGLSwVGbOGp
         cGGrCOxYhTam+ZZlUCOWQts8LUIXU1BKj+rjt7J+ykq//Hw0HokYf5DwDsiB9jyUzDHr
         0vA5u7mmNCwzpOiVyfK7ajXXz5BTC/VKQQBAVnMStO3aPoC7mCf1VJDv55mvp1yydQbe
         ZvEHHY1X4HXQnNPlyU7K6flDiwcwE4WCyUs3s02PS1RsRLTnzHJobxv27vQWMMjIJXR9
         oEHw==
X-Forwarded-Encrypted: i=1; AJvYcCU1OWJR1gKJvoWbP8vo5s9uMFB6AkLGkPOfLnYpl8ozkA3h2J4NBm4BXA1YPiEZYlIHO8P7ZonJQdRJ@vger.kernel.org, AJvYcCUOvtudFcVB0beBal9a1y6tnXTukCdxLkEvcIlxVowUXQcQqOcGAz0D4PKkVKmZyGW2HufixUE591mB@vger.kernel.org, AJvYcCViLHpS42/4BNg5BaldvIjHp9GTKpYuzU7/Kc6ZAH+BKcI6lQDZ/pbcaVi5Z11uYZk7lMyhKnzGHNrz@vger.kernel.org, AJvYcCVj69hjrXjVoiRBPfUoO5QPPLlG/FFCij/6uM8eTdeWLxgID5Ux/DRfSrxcJ2zGcAZGwtmgXK4VIk4DwoWl@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQF5iP1wLiz7gs/STntvI1fVT//Mt0/aJZ9bcJ1YoJr+OcT0T
	iAMYjaJXkXwGr51aR4TBKSJxHhdS1ARDdQpxBZ1Y7Kzuu3clMRjN
X-Gm-Gg: ASbGncsvEsRYgumwZgefGhaZ/PLMt1UOrCOyxT3duzNOf4xFERR31clgyG8i8d11WOR
	3XOPb79ZyJCX7abkB/nzvgFtanPbickGik4j4D3FqrQ9YEjJzqp8oqifxLvqK4UXfwxdHFkcnAC
	jHy2Jof8XoT6Qt+REGqIzVQ3zBg2nooiWQfusbqtIA74IH+2PuVeEeHPTNvkgBAPCXHc0YKn3ed
	JwKaW9aolljyrFUOEFUzNLycd+9LAwg9ImAPMOnPYtY9GpIQuM+97uGKZmpUmxoUte2Yvd+a3mR
	/ikG+ESQVWEvpacUKTDvL5ujlc/FRa47pD7212fCvj+1Otni6pF15VpLOX2shJgsR2kle4LGcmm
	lFOgyfpxQOM7BAw==
X-Google-Smtp-Source: AGHT+IHeiWUjZYzxtkXpntYYlsW6atQC3N/FUEVhxccbCxLV+C3rtXXpoHMzxMjkwdKTi2hGl7WWew==
X-Received: by 2002:a05:6000:21c4:b0:399:795e:d899 with SMTP id ffacd0b85a97d-399795ed8b6mr2509291f8f.14.1742475691925;
        Thu, 20 Mar 2025 06:01:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm18492328f8f.97.2025.03.20.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:01:31 -0700 (PDT)
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
Subject: [PATCH v2 03/11] dt-bindings: clock: en7523: add Documentation for Airoha AN7581 SCU SSR
Date: Thu, 20 Mar 2025 14:00:26 +0100
Message-ID: <20250320130054.4804-4-ansuelsmth@gmail.com>
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

Expose these configuration as an enum of strings in the SCU node and
also add dt-bindings header to reference each serdes port in DT.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/clock/airoha,en7523-scu.yaml     | 101 ++++++++++++++++--
 MAINTAINERS                                   |   7 ++
 include/dt-bindings/soc/airoha,scu-ssr.h      |  11 ++
 3 files changed, 110 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h

diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
index fe2c5c1baf43..637ce0e06619 100644
--- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
+++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
@@ -9,6 +9,7 @@ title: EN7523 Clock
 maintainers:
   - Felix Fietkau <nbd@nbd.name>
   - John Crispin <nbd@nbd.name>
+  - Christian Marangi <ansuelsmth@gmail.com>
 
 description: |
   This node defines the System Control Unit of the EN7523 SoC,
@@ -26,6 +27,23 @@ description: |
 
   The clocks are provided inside a system controller node.
 
+  The System Control Unit may also set different mode for the Serdes ports
+  present on the SoC.
+
+  These are toggeled in the System Status Register and are used to
+  toggle Serdes port for USB 3.0 mode or HSGMII, USB 3.0 mode or PCIe2
+  or setup port for PCIe mode or Ethernet mode (HSGMII/USXGMII).
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
 properties:
   compatible:
     items:
@@ -49,6 +67,40 @@ properties:
     description: ID of the controller reset line
     const: 1
 
+  airoha,serdes-wifi1:
+    description: Configure the WiFi1 Serdes port
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - pcie0_x2
+      - pcie0_x1
+      - ethernet
+    default: pcie0_x1
+
+  airoha,serdes-wifi2:
+    description: Configure the WiFi2 Serdes port
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - pcie0_x2
+      - pcie1_x1
+      - ethernet
+    default: pcie1_x1
+
+  airoha,serdes-usb1:
+    description: Configure the USB1 Serdes port
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - usb3
+      - ethernet
+    default: usb3
+
+  airoha,serdes-usb2:
+    description: Configure the USB2 Serdes port
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - usb3
+      - pcie2_x1
+    default: usb3
+
 required:
   - compatible
   - reg
@@ -64,6 +116,12 @@ allOf:
         reg:
           minItems: 2
 
+        airoha,serdes-wifi1: false
+        airoha,serdes-wifi2: false
+
+        airoha,serdes-usb1: false
+        airoha,serdes-usb2: false
+
         '#reset-cells': false
 
   - if:
@@ -75,6 +133,24 @@ allOf:
         reg:
           maxItems: 1
 
+  - if:
+      properties:
+        airoha,serdes-wifi1:
+          const: pcie0_x2
+    then:
+      properties:
+        airoha,serdes-wifi2:
+          const: pcie0_x2
+
+  - if:
+      properties:
+        airoha,serdes-wifi2:
+          const: pcie0_x2
+    then:
+      properties:
+        airoha,serdes-wifi1:
+          const: pcie0_x2
+
 additionalProperties: false
 
 examples:
@@ -87,15 +163,22 @@ examples:
       #clock-cells = <1>;
     };
 
+  # Example SCU node with Serdes set to PCIe0 to x2 mode
+  # and USB2 set to PCIe2 to x1 mode
   - |
     soc {
-      #address-cells = <2>;
-      #size-cells = <2>;
-
-      scuclk: clock-controller@1fb00000 {
-        compatible = "airoha,en7581-scu";
-        reg = <0x0 0x1fb00000 0x0 0x970>;
-              #clock-cells = <1>;
-              #reset-cells = <1>;
-      };
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        scuclk: clock-controller@1fb00000 {
+            compatible = "airoha,en7581-scu";
+            reg = <0x0 0x1fb00000 0x0 0x970>;
+
+            airoha,serdes-wifi1 = "pcie0_x2";
+            airoha,serdes-wifi2 = "pcie0_x2";
+            airoha,serdes-usb2 = "pcie2_x1";
+
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+        };
     };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3eee238c2ea2..9944845ae9f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -736,6 +736,13 @@ F:	Documentation/devicetree/bindings/phy/airoha,en7581-pcie-phy.yaml
 F:	drivers/phy/phy-airoha-pcie-regs.h
 F:	drivers/phy/phy-airoha-pcie.c
 
+AIROHA SCU SSR DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
+F:	include/dt-bindings/soc/airoha,scu-ssr.h
+
 AIROHA SPI SNFI DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 M:	Ray Liu <ray.liu@airoha.com>
diff --git a/include/dt-bindings/soc/airoha,scu-ssr.h b/include/dt-bindings/soc/airoha,scu-ssr.h
new file mode 100644
index 000000000000..915f3cde7c1a
--- /dev/null
+++ b/include/dt-bindings/soc/airoha,scu-ssr.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_AIROHA_SCU_SSR_H
+#define __DT_BINDINGS_AIROHA_SCU_SSR_H
+
+#define AIROHA_SCU_SERDES_WIFI1		0
+#define AIROHA_SCU_SERDES_WIFI2		1
+#define AIROHA_SCU_SERDES_USB1		2
+#define AIROHA_SCU_SERDES_USB2		3
+
+#endif /* __DT_BINDINGS_AIROHA_SCU_SSR_H */
-- 
2.48.1


