Return-Path: <linux-kernel+bounces-537720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00692A48FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A38188896C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E09192B8C;
	Fri, 28 Feb 2025 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROLMc5DE"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6713213E;
	Fri, 28 Feb 2025 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740714032; cv=none; b=ZSPiinVrS7hRYi9q0CJfONaq+XtFggjf9sGNZJXlPjheoBVO/u87bDUxHR7E8kd7tkv4izc44RXYt8V5uexyiHzAuBkXlBchcO4aMOajyxLwZrH0xWwLTMBYphIoQaEoBtJ7n+DeNNuUH6fKlVyL1MHe4FIqCgg9mKM57tZCsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740714032; c=relaxed/simple;
	bh=nGH8rvuuV5YTeJBxNVwgLjv9Y8DsGwNpyNl4n8u/Lok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D8e5Lag4WZH6ruwd7NnnfXj27KSi2MSr/BEB6AwQyj5hq7IQsc3dwKkMUgrY4oJXF9OwZodblAWRu7SifDCgqhR8BQbcqtYeZ9rNaEgwX2xFnJeiK4pd8jGvH568sFJwg0MOeze7l8LNHDC3O7DIiNYcQQne74E9/4qpVvgfMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROLMc5DE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22128b7d587so32781075ad.3;
        Thu, 27 Feb 2025 19:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740714030; x=1741318830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OoJ4GCtBW9r4R7yZx4mj/bfDelbtr4R+xivfqBWQxIE=;
        b=ROLMc5DExLFiBgkUS+McYIOw2MkkUfg8leIlDr15/jODcZJL8HoGFWmPyckzwt5ysu
         e0Hd5WaUENg5+MK5oc77iY1/hC3pYi854zKmFXDrtK7dTA9tWFGUgkwqrszK1PEZayZu
         7LFBSDVdrIf0h/WcvbTxSXvhOOtPf8h+2mLCJaKTdwXHgaiKkJMwR3A2KdQE8DXhQbcA
         qZbxLzMGpdyD+J+rJ9dtdCJ/3JvNh0w02jgFw+Ha8LB0FwAwEgUXaMMVGdCbblIyYiV3
         gTGPza8wew2zLkk7GJh27JUkHGvci6NQPWZOGZhu5iT+BFO9r35LeM/UuMkefMZcKTgz
         RTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740714030; x=1741318830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoJ4GCtBW9r4R7yZx4mj/bfDelbtr4R+xivfqBWQxIE=;
        b=a9aZ6c0oUrQqmq6Q1YVFTP3a8BtH1F+25K3m/XygNy3UCvmOrQlLe7U97tnTaJjLTr
         5q6WlYss/jqbr0V1EWFTyKq+TlkGSmhAvdc8TxnUsYQ8HWPhp/xCVfXCbg679D0yJLaJ
         7H4N0IJDNpjWzU8XobKQk50E1IpDf27EH0EAwhkoWent3rqipG4AcfIb3EGmdiFiRJ8K
         mSW3E6HsQJKlMitShL24PUefxRG/aI4/pa3CmaoZO5/C3vw3It/aGDD98bkhbuB10Pdu
         fifPWLgyjEMT+ydAKfWG/vhEIVrsq+G968pKwFKWb0T6TQEeH/X4aCqLaHESrmRkilTg
         Ognw==
X-Forwarded-Encrypted: i=1; AJvYcCUJhouVwVKtSi273yIlxuvRPWEqx1xsg3PWGwUCUOWyyW6/7cLExkmOljUxcbQY+0OYVxFOmRzabYgL@vger.kernel.org, AJvYcCWYM/wWCbrTtW6yD2DD5SXfzGUJklsD//fWjJGJfIqYT3N4T3826o9n9sM6xGiizvbUxR6q7dxca3KFVHr4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HoLI6BXIqwX3yxDOfH6xyAsbjF2UKO9xApotilhucAKjjigc
	z7QLWCO5ANOOO/2WZmQAzuJcSirsy2nqBH508gytfsEC3fJ3M5/Un7MpBY7lYrM=
X-Gm-Gg: ASbGncttSZhGRetDxLEKyyxWY71E6+VnGMmZqIqVher5QPD33yy0njDkREnO1TScecU
	e54+MQi4POSnJaFJRMqrSdeTAt7+OTtBz8HCxuqneVLujpZJ5IgA9hKOVTkFsZ1CL6VAd1Q8WfU
	imgG3Z6sEZrDKGNGZWq2uq51u4Ixus+npSMSovUP49wvhGGWyj0re3YnmAeFZk5gH+hLqqtl+MZ
	qO+J1hFxHXef0jU3Yjw1WjcuHbFCzcnqWja8P21pt/LClFxBiKds3jwgbboVMGecTPmVCHyUJWU
	uqb6oWPjl/bvHwXOFgnmOw==
X-Google-Smtp-Source: AGHT+IH8IRF4VtWIAu215SqkW3dsnhcfHiZAYpXMpzyjCCocGLr1qeuz/Fh1SLUNWxkfkaZmflD9Vw==
X-Received: by 2002:a17:902:ce12:b0:21f:93f8:ce16 with SMTP id d9443c01a7336-223690e6183mr30302895ad.31.1740714030246;
        Thu, 27 Feb 2025 19:40:30 -0800 (PST)
Received: from dev.. ([2804:14d:887:95a9:accf:4797:5e54:f1d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c67sm23593755ad.135.2025.02.27.19.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 19:40:29 -0800 (PST)
From: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
To: tglx@linutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vz@mleia.com
Cc: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] dt-bindings: interrupt-controller: Convert nxp,lpc3220-mic.txt to yaml format
Date: Fri, 28 Feb 2025 00:39:15 -0300
Message-ID: <20250228034021.607135-1-leo.fthirata@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert NXP LPC3220-MIC to DT schema.

Signed-off-by: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
---
Changes in v3:
 - Add interrupts property description
 - Fix interrupts items descriptions
 - Remove else condition
---
 .../interrupt-controller/nxp,lpc3220-mic.txt  | 58 ----------------
 .../interrupt-controller/nxp,lpc3220-mic.yaml | 69 +++++++++++++++++++
 2 files changed, 69 insertions(+), 58 deletions(-)
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
index 000000000000..59e8814a15b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
@@ -0,0 +1,69 @@
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
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    items:
+      - description: Regular interrupt request
+      - description: Fast interrupt request
+    description: IRQ and FIQ outputs of SIC1/SIC2 to the MIC.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nxp,lpc3220-sic
+    then:
+      required:
+        - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mic: interrupt-controller@40008000 {
+        compatible = "nxp,lpc3220-mic";
+        reg = <0x40008000 0x4000>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };
+
+    sic1: interrupt-controller@4000c000 {
+        compatible = "nxp,lpc3220-sic";
+        reg = <0x4000c000 0x4000>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupt-parent = <&mic>;
+        interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
+                    <30 IRQ_TYPE_LEVEL_LOW>;
+    };
-- 
2.43.0


