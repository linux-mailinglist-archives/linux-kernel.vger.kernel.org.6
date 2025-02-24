Return-Path: <linux-kernel+bounces-530078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCADA42E91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2773B34C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07DC1917D6;
	Mon, 24 Feb 2025 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT7LslJ+"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876201F5FA;
	Mon, 24 Feb 2025 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431084; cv=none; b=q+tWqnndBi8WiVMsd1+8XqlA40ceNoPeLAXwYo2V9QTu2gRp7H8tmBuGgh6xTrqTwNXtyAlqOgdRi4DrrMRpJ6opS7LM7JqNeHPh+2/y34hy04EEVniOoz+kVwZMim4H4qVtpUBOJ0ExesTqFBcWynz+RyjdpEQoTR2AF8aUOgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431084; c=relaxed/simple;
	bh=ZAgSBIx9SxOl5v8dCTR/pRxYY31jl7YM+ojkb+mkJmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxTUMQJVK1ycwm5G5iXrxsgE6V897d8bq8i9aeRoNwo7LHvDHAMU8YwExcZXFyeAYgWfwqFVH2+tSMIBWAdk1Y/9rP33Qdy5fEeJzASMxe8ynnMSEQQcfVhiBRqvZCuKh5u3oOBc8DgNN0omYTNj7vzgahTHRERGHbECa1+ptXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aT7LslJ+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220f4dd756eso101401935ad.3;
        Mon, 24 Feb 2025 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740431081; x=1741035881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrNIQyJ5Jhdx9yshPdJ0kSZ+7xfgRV78xd4HlJimuN8=;
        b=aT7LslJ+PvnAIUvpDsrhGxPH84fVZOdBOI1PFAHie7LXXcEU/sU6eNFFBZ1Mw1U1QO
         14fwQFDopR3eddLrOdWlLI40dlJGR4rrWUNDbL28qK2zGp7rZDjHRkrx3DrGmnER/h0R
         zKubJaduv98QwMurThC3wmtqKmtnrnF8W4GZZqi5QnfHtx1C81RA/uYH0eDUCpYiCZAX
         SKwNGL36uqkL3WRyR0rgMAV68a5R30D9IM/CcO7jgJ3RYvzQ4eV9sVyqX2M2nNJ0EQLw
         5q6f69q9isFgXuercB6QxDanFAACl/022yLbYDaWf2xtsSfDu2nT/Lf0y9cmuJH25bIw
         t4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431081; x=1741035881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrNIQyJ5Jhdx9yshPdJ0kSZ+7xfgRV78xd4HlJimuN8=;
        b=l15rYYiVgyU5lRTVd8dH6b77kaolbXFDih7jM2PX26cVqSL69MHcNDPxa1DTJdYZt2
         PlcyV9I/YHE+WtXgw4ZqQ8aqrVjm49/1CpGTpOmvASCgOWoVYC415DWzSZp3/AGB0Dfh
         X5fnkT8pkb03DdvSge05m625Lc1l9q24l3OUk6WtvByqWBayslE873tQtdetuOf5YwWj
         4CgNyzNArueNrrxj1+UsrLvUjN46en9eOPlBDG20bOqn//PT8U89ff7g2aSH+DSE+QKP
         IrUx5l6Q8RXxauXfAZWh0bxX2iKBR4caKGym1WGeFCgFImfIjbgr1FeZmCaiY1BvIymm
         9iqw==
X-Forwarded-Encrypted: i=1; AJvYcCVSD09y3zRpdHAXLcHPW9I+she+CRYmurd1ix2rz6/ID2wj/9jtgRN5r2GyGiCMWeQLj7fzmCosP58SYdEM@vger.kernel.org, AJvYcCVyFY8oKUJ3XsTVck7hMvA2s5oCZIWxp7099jUNdZbqlfHp3ilrInsQ2S16ochGRSWIQl2xzQpe+w3z@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyzPyE7iHiC3AqXCfqAFN/pDTC5d25q0sLD34EsuWxVGjFaqY
	4Ljlcwdsop0XUr8jbRJ3c+ozuxK4rYmKU4lP9fAih6Ge5UMnGmiO
X-Gm-Gg: ASbGnctjHv+bygqVTHeU3Xidtl+qSPEWbr9xIExsocPh27oduGXwr0u3wmdHMddLQs4
	njU/GuaTOmkMRA4hRjY30QjOHoN7Ng7YXKz+vPMN3eheBsdxWZVmVv7h3APhlNzseCOViy0FU6l
	gWe/F5OYwu//XAy9Xr2I+e1JBlXvvc71ERsLNcY/zE2cJgmYVa8s1YT3tn+1WhoPU65fQ5dtoLv
	LlVgkeSIagSLoZsboAaVjamIhvbsuCp1rASNMJx94W2pxQ2N2c8BzB+bVC6LnnUCbq2rUg+ePv1
	aqrxJt30Za7oi98yH1kJFA==
X-Google-Smtp-Source: AGHT+IHWTMwXTzcxOW9uoPlv1v7haW6uVtdozlUcfDrTOvTWlUsZytq0IAqBRViyK/ppP6mVQo6K3w==
X-Received: by 2002:a05:6a20:6a0d:b0:1ee:e808:732c with SMTP id adf61e73a8af0-1f0fc1394c6mr886008637.14.1740431080512;
        Mon, 24 Feb 2025 13:04:40 -0800 (PST)
Received: from dev.. ([2804:14d:887:95a9:4a24:9b21:53f4:4d40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aeda8574dbasm82562a12.42.2025.02.24.13.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:04:40 -0800 (PST)
From: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
X-Google-Original-From: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>
To: tglx@linutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vz@mleia.com
Cc: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] dt-bindings: interrupt-controller: Convert nxp,lpc3220-mic.txt to yaml format
Date: Mon, 24 Feb 2025 18:04:30 -0300
Message-ID: <20250224210432.94851-1-leofthirata@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NXP LPC3220-MIC to DT schema.

Signed-off-by: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>
---
 .../interrupt-controller/nxp,lpc3220-mic.txt  | 58 -------------
 .../interrupt-controller/nxp,lpc3220-mic.yaml | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
deleted file mode 100644
index 0bfb3ba55f4c..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
-
-Required properties:
-- compatible: "nxp,lpc3220-mic" or "nxp,lpc3220-sic".
-- reg: should contain IC registers location and length.
-- interrupt-controller: identifies the node as an interrupt controller.
-- #interrupt-cells: the number of cells to define an interrupt, should be 2.
-  The first cell is the IRQ number, the second cell is used to specify
-  one of the supported IRQ types:
-      IRQ_TYPE_EDGE_RISING = low-to-high edge triggered,
-      IRQ_TYPE_EDGE_FALLING = high-to-low edge triggered,
-      IRQ_TYPE_LEVEL_HIGH = active high level-sensitive,
-      IRQ_TYPE_LEVEL_LOW = active low level-sensitive.
-  Reset value is IRQ_TYPE_LEVEL_LOW.
-
-Optional properties:
-- interrupts: empty for MIC interrupt controller, cascaded MIC
-  hardware interrupts for SIC1 and SIC2
-
-Examples:
-
-	/* LPC32xx MIC, SIC1 and SIC2 interrupt controllers */
-	mic: interrupt-controller@40008000 {
-		compatible = "nxp,lpc3220-mic";
-		reg = <0x40008000 0x4000>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-	};
-
-	sic1: interrupt-controller@4000c000 {
-		compatible = "nxp,lpc3220-sic";
-		reg = <0x4000c000 0x4000>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		interrupt-parent = <&mic>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
-			     <30 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	sic2: interrupt-controller@40010000 {
-		compatible = "nxp,lpc3220-sic";
-		reg = <0x40010000 0x4000>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-
-		interrupt-parent = <&mic>;
-		interrupts = <1 IRQ_TYPE_LEVEL_LOW>,
-			     <31 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	/* ADC */
-	adc@40048000 {
-		compatible = "nxp,lpc3220-adc";
-		reg = <0x40048000 0x1000>;
-		interrupt-parent = <&sic1>;
-		interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
new file mode 100644
index 000000000000..c57478b8982f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/nxp,lpc3220-mic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
+
+maintainers:
+  - Vladimir Zapolskiy <vz@mleia.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,lpc3220-mic
+      - nxp,lpc3220-sic
+
+  reg:
+    description:
+      Should contain IC registers location and length.
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The number of cells to define an interrupt, should be 2.
+      The first cell is the IRQ number, the second cell is used to specify
+      one of the supported IRQ types.
+          IRQ_TYPE_EDGE_RISING = low-to-high edge triggered,
+          IRQ_TYPE_EDGE_FALLING = high-to-low edge triggered,
+          IRQ_TYPE_LEVEL_HIGH = active high level-sensitive,
+          IRQ_TYPE_LEVEL_LOW = active low level-sensitive.
+      Reset value is IRQ_TYPE_LEVEL_LOW.
+
+  interrupts:
+    description:
+      Empty for MIC interrupt controller, cascaded MIC hardware interrupts for
+      SIC1 and SIC2
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mic: interrupt-controller@40008000 {
+      compatible = "nxp,lpc3220-mic";
+      reg = <0x40008000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+    };
+
+    sic1: interrupt-controller@4000c000 {
+      compatible = "nxp,lpc3220-sic";
+      reg = <0x4000c000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      interrupt-parent = <&mic>;
+      interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
+                  <30 IRQ_TYPE_LEVEL_LOW>;
+    };
+
+    sic2: interrupt-controller@40010000 {
+      compatible = "nxp,lpc3220-sic";
+      reg = <0x40010000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <2>;
+      interrupt-parent = <&mic>;
+      interrupts = <1 IRQ_TYPE_LEVEL_LOW>,
+                  <31 IRQ_TYPE_LEVEL_LOW>;
+    };
+
+    adc@40048000 {
+      compatible = "nxp,lpc3220-adc";
+      reg = <0x40048000 0x1000>;
+      interrupt-parent = <&sic1>;
+      interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.43.0


