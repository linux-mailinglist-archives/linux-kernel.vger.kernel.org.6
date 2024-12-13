Return-Path: <linux-kernel+bounces-444283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183DB9F0411
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254D116A114
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732E18859A;
	Fri, 13 Dec 2024 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkhxM+gA"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE2187555;
	Fri, 13 Dec 2024 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734066999; cv=none; b=ZkRoKoTEByeUjvFBpdkvv5a+sOWBheZWN8bXmjWIDUTC3os/l+WqL/qJ4Ok+wK1h4noZkr1cK6Rj0m9H9hPFlasohzpMLZQ9h58oAvoW5D/MduIqdDkUWBsTGf/ukfzl3ctGsBRhvUBKTnLCCmgt+opvxuW1Basy6NQZqRc4Xug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734066999; c=relaxed/simple;
	bh=1rsc7fW/DcL37vNJsBlJAPYnU57zvw2XgJMTITFpGz0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WuiDA0wyYCfdJSwUL0yjAoLrlb16ADrp2FkxhAz3LCh8i4mKIJoG/4PafufwNWqlrVgdVl0ajQtsEWQMSOwNIjM2W1+JfiYj9GtwLnU4mrXtH7btmEggfm/lLepePBoDg0nIadctmA5ziKpQFcbMuP9yDy423O/PpYbG0voTphk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkhxM+gA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725eff44ba5so99873b3a.2;
        Thu, 12 Dec 2024 21:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734066997; x=1734671797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H86v53hVC/MSheWi92plk7akkZTe1OQ4u5ChEyoup1E=;
        b=DkhxM+gAbSZPNCIRxEOPn4tYjvOSJuZhQmoLqAEnU0MsQhoW9meYG++n+Ltov6QliM
         gqAmEZUrjYpBK7OsY17yeo14DvWjAi341m+QBx8Pqye3/lgO+mj0l5xPNSFBXgZKrJsX
         hEwXUIbH7fdUYQzlaqH+7Zso9v27ukPTkrGrRm/U+p8sLUMOCi+Bh0nPGSZR/NUG88YC
         /SO3B9hpMYunCP+du2kSTDntUzzPGIQB47xjMFX3FREOFHLXorOpJLsUTjUHEXnyWvdM
         8NDGi4Can1/rysm8dAj2PkQwFal+Q6AkUFw5OE+2AMBeqoVMdRg8DASXZY5+sbik4eNN
         2A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734066997; x=1734671797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H86v53hVC/MSheWi92plk7akkZTe1OQ4u5ChEyoup1E=;
        b=Cje/q5CzFSq9h1dqVC8x6mMOR+8M+Vlxh8skFTO8cr6q9pLoa1/TI3eWRUf8BlPU1Z
         HA7Ic1/+3WdpE8rHQon0CTo/6IpdsrIa8xoOHTZ9xBDsn4MKIcXDoVJwBOHE+Tm+3FSi
         GT47zjY0ACH9Ie7VkAst513Kchjx3EhyOlHJmO2sMgBh4nBdshgIr02WiwrPwjilmHUU
         NN803r6Mf/Efmenxg2YTwrgpqtWFeN1KFdroQFtNCrckXNenrewOBQ45dzoQjjG91wcU
         IyuUa07UxBOoSHZ19k0X7Shi/AcjvynpsPUDyCkRps/8AEEZhaU4Xxavxh7S9zvQmlvV
         eHWA==
X-Forwarded-Encrypted: i=1; AJvYcCVSVhmTYEhXjENSQBgeMbQszwZvIUbW0B0d9BBUSC2tsr0NUk6BdKuTjXQnFvkrR3+QLKgCrpeShFOG@vger.kernel.org, AJvYcCWnYJVyupASGCCrL0dS0eB9lVqY+tq+p8hJcepXaj7oKd8NbQKd0Gfd+7Bv5ZyG8zbzXZqrRAtc7cU4@vger.kernel.org, AJvYcCXaBnObo5YHUiH63JIxEh/F+WjnPDLDUUQ2BIjQvVxlGRQDFaSYx0ziUgQlrxxGC7XzxPUNKcWHVCRdMjoP@vger.kernel.org
X-Gm-Message-State: AOJu0YxqznQBAwXs7LniAUajYPOo2GZtHMXkE/xpeoon45pLmnsgKBuy
	SyrayJtDfMTqLGdFNQjRBASEDbp/fNCmpr9oXUOkhwAOH3Us9w/Y
X-Gm-Gg: ASbGncuZDvSBcnElwX56uCR+r5YS1b99EqvwXZyhbUk0935JL2sKf/eoBOBp4RcZTrG
	I9m+GoIozriLf+sF7udmc9wdEeZIXGcb+1K5NBpayYh9KTfbCMoF2YCMRr637n3o/RnP8BK2hQs
	RphcWfRzX9zI2WphlLzXwqC7JYKWhYxGE+rGhquFSAIgpSmlr6Pq9THvDC+qko/qjUK36mBzeJ3
	jLZEnfbknlOuBnixgA/Xu18NuiJz+Ms5kblUby1rMctJkK6MRlaUvsP1DoEXPe8ak3d+A1dflSH
	y7MBlrdd0A==
X-Google-Smtp-Source: AGHT+IEbiRXrfJYyiA8RFucB09CjaqfhTKCHdvMMODzj+3i/Tzn/2xdpcIPwvQWXg+SGjDM5seiq9w==
X-Received: by 2002:a05:6a00:3e29:b0:725:1257:bbc with SMTP id d2e1a72fcca58-7290c2a2693mr743260b3a.7.1734066996901;
        Thu, 12 Dec 2024 21:16:36 -0800 (PST)
Received: from localhost.localdomain (p67.ucndns.in. [103.187.249.67])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725eeed027csm7982326b3a.131.2024.12.12.21.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 21:16:36 -0800 (PST)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Carvalho Chehab <mchehab@kernel.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: dwc3-st: convert to dt schema
Date: Fri, 13 Dec 2024 10:45:55 +0530
Message-Id: <20241213051559.6066-1-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ST DWC3 glue logic bindings to DT schema. Added missing includes
in example, modified the example to be similar to the actual .dts file
and removed st,syscon from the required property, added st,syscfg
property.

Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
 .../devicetree/bindings/usb/dwc3-st.txt       |  66 ----------
 .../bindings/usb/st,stih407-dwc3.yaml         | 123 ++++++++++++++++++
 2 files changed, 123 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/dwc3-st.txt
 create mode 100644 Documentation/devicetree/bindings/usb/st,stih407-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/dwc3-st.txt b/Documentation/devicetree/bindings/usb/dwc3-st.txt
deleted file mode 100644
index 4aa368447b1e..000000000000
--- a/Documentation/devicetree/bindings/usb/dwc3-st.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-ST DWC3 glue logic
-
-This file documents the parameters for the dwc3-st driver.
-This driver controls the glue logic used to configure the dwc3 core on
-STiH407 based platforms.
-
-Required properties:
- - compatible	: must be "st,stih407-dwc3"
- - reg		: glue logic base address and USB syscfg ctrl register offset
- - reg-names	: should be "reg-glue" and "syscfg-reg"
- - st,syscon	: should be phandle to system configuration node which
-		  encompasses the glue registers
- - resets	: list of phandle and reset specifier pairs. There should be two entries, one
-		  for the powerdown and softreset lines of the usb3 IP
- - reset-names	: list of reset signal names. Names should be "powerdown" and "softreset"
-See: Documentation/devicetree/bindings/reset/st,stih407-powerdown.yaml
-See: Documentation/devicetree/bindings/reset/reset.txt
-
- - #address-cells, #size-cells : should be '1' if the device has sub-nodes
-   with 'reg' property
-
- - pinctl-names	: A pinctrl state named "default" must be defined
-See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
- - pinctrl-0	: Pin control group
-See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
- - ranges	: allows valid 1:1 translation between child's address space and
-		  parent's address space
-
-Sub-nodes:
-The dwc3 core should be added as subnode to ST DWC3 glue as shown in the
-example below. The DT binding details of dwc3 can be found in:
-Documentation/devicetree/bindings/usb/snps,dwc3.yaml
-
-NB: The dr_mode property described in [1] is NOT optional for this driver, as the default value
-is "otg", which isn't supported by this SoC. Valid dr_mode values for dwc3-st are either "host"
-or "device".
-
-[1] Documentation/devicetree/bindings/usb/usb-drd.yaml
-
-Example:
-
-st_dwc3: dwc3@8f94000 {
-	compatible	= "st,stih407-dwc3";
-	reg		= <0x08f94000 0x1000>, <0x110 0x4>;
-	reg-names	= "reg-glue", "syscfg-reg";
-	st,syscfg	= <&syscfg_core>;
-	resets		= <&powerdown STIH407_USB3_POWERDOWN>,
-			  <&softreset STIH407_MIPHY2_SOFTRESET>;
-	reset-names	= "powerdown", "softreset";
-	#address-cells	= <1>;
-	#size-cells	= <1>;
-	pinctrl-names	= "default";
-	pinctrl-0	= <&pinctrl_usb3>;
-	ranges;
-
-	dwc3: dwc3@9900000 {
-		compatible	= "snps,dwc3";
-		reg		= <0x09900000 0x100000>;
-		interrupts	= <GIC_SPI 155 IRQ_TYPE_NONE>;
-		dr_mode		= "host";
-		phy-names	= "usb2-phy", "usb3-phy";
-		phys		= <&usb2_picophy2>, <&phy_port2 PHY_TYPE_USB3>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/usb/st,stih407-dwc3.yaml b/Documentation/devicetree/bindings/usb/st,stih407-dwc3.yaml
new file mode 100644
index 000000000000..709cdb17f28d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/st,stih407-dwc3.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/st,stih407-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST DWC3 glue logic
+
+description:
+  This binding describes the parameters for the dwc3-st driver,
+  which controls the glue logic used to configure the DWC3 core on
+  STiH407-based platforms.
+
+maintainers:
+  - Mauro Carvalho Chehab <mchehab@kernel.org>
+
+properties:
+  compatible:
+    const: st,stih407-dwc3
+
+  reg:
+    # minItems: 2
+    items:
+      - description: Glue logic base address.
+      - description: USB syscfg ctrl register offset.
+
+  reg-names:
+    # minItems: 2
+    items:
+      - const: reg-glue
+      - const: syscfg-reg
+
+  st,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to system configuration node which.
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: powerdown
+      - const: softreset
+
+  st,syscfg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  pinctrl-names:
+    items:
+      - const: default
+
+  pinctrl-0:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Pin control group
+      See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+
+  ranges:
+    description: Valid 1:1 translation between child's and parent's address space.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+  - pinctrl-names
+  - pinctrl-0
+  - ranges
+
+additionalProperties: false
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    type: object
+    description: DWC3 core sub-node
+    $ref: snps,dwc3.yaml#
+    unevaluatedProperties: false
+    properties:
+      dr_mode:
+        enum:
+          - host
+          - device
+        description: |
+          Specifies the operating mode. The default value "otg" is not
+          supported by this SoC. Valid values are "host" or "device".
+          See: Documentation/devicetree/bindings/usb/usb-drd.yaml
+
+examples:
+  - |
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/reset/stih407-resets.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    st_dwc3: dwc3@8f94000 {
+        compatible	= "st,stih407-dwc3";
+        reg		= <0x08f94000 0x1000>, <0x110 0x4>;
+        reg-names	= "reg-glue", "syscfg-reg";
+        st,syscfg	= <&syscfg_core>;
+        resets		= <&powerdown STIH407_USB3_POWERDOWN>,
+              <&softreset STIH407_MIPHY2_SOFTRESET>;
+        reset-names	= "powerdown", "softreset";
+        #address-cells	= <1>;
+        #size-cells	= <1>;
+        pinctrl-names	= "default";
+        pinctrl-0	= <&pinctrl_usb3>;
+        ranges;
+
+        dwc3: usb@9900000 {
+            compatible	= "snps,dwc3";
+            reg		= <0x09900000 0x100000>;
+            interrupts	= <GIC_SPI 155 IRQ_TYPE_NONE>;
+            dr_mode		= "host";
+            phy-names	= "usb2-phy", "usb3-phy";
+            phys		= <&usb2_picophy2>, <&phy_port2 PHY_TYPE_USB3>;
+        };
+    };
-- 
2.34.1


