Return-Path: <linux-kernel+bounces-287006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5F395217E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1827CB23D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3B1BC09E;
	Wed, 14 Aug 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOn21kcP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3642566A;
	Wed, 14 Aug 2024 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657634; cv=none; b=SFOJLiPGNSUVkKJlIU7Gu1ioEHnWWLbshAiVaes+ANRhqYMGxPIxwXpt6U/tf5RJe6pm5M/T5uuuHKqdFLnugAU130pl1whEfKszFrrmQbK/2OanlXrZytpSBFuJPN2pOdXQXr/yRbNrQuroHiL/7MvO6wMQaWbJW2PvWePTG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657634; c=relaxed/simple;
	bh=Yoo9FBJSP7axuN9sa1Ucm4peAedaUR5Vk84TmmAO/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCVhZzUsSIYOdZipEwcKtuj96AiZHlcJegXKTN1Lg2ekEJSSKKyjA+mftb4wr7dVSDC176OJ2TZPWRuqZGFqGTYoWqi0tcGwBEP+yoxlp8tPTZXq/TGLS7bQkrRWtsudH7V0TBwHLgAsTJWK6P0BpeJtJ/Y8EcRm3ReUgrW6SMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOn21kcP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201e52ca0caso894945ad.3;
        Wed, 14 Aug 2024 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723657632; x=1724262432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyxtgWWB3KD9bQSN4qQJ6q5jA8qs58ZskqXBYA1R0bo=;
        b=OOn21kcPLryyMwdziSQfkPBoMhdZDLBQu2XasgKR7U0WJt4dhqkuzK5tcSHztsXXkq
         skfs0YeaHrsrxRB+5nodKf81Iyc04MS9d/RbbKfsMjXP+4C7aNnAk49V9Zgwv4rnIfJa
         ygJLKe4hfsP8c+rg9zOCnJtsEc0sPaS5q/SLqMgVMFGWiWQKZ9M+cgEma2P3BUEC7oGc
         DpkBwXAhgXVtZ5jXAnSIMCCSRd5WIS2DP9uW+EF0GRyAHkCOAgwsQ4vJzWxe7zonuRCi
         YQPlL3ZqGgYAUOCwgwCVLHu1n5IO2gE6r+j7E6D13EI5hJJpjmzZf8yzFFgsqF0KiHZx
         OR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657632; x=1724262432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyxtgWWB3KD9bQSN4qQJ6q5jA8qs58ZskqXBYA1R0bo=;
        b=FlwWWR17tgSyfq5AZCYkclwmuDxm9gjpG1Z7yW+KtUfz8RSl6ZFxqbvWNw5IuFU1v1
         Hf18qAVp1A8cfGxbnOGZpquAFJ1ChBj4N08y0wJiTTKWUXBpocQjCbCNpjnTog3M1qVU
         NrEqu2bwrQAWpzZU1N0cSDRTVTD1avGQql3Hay/61FuGZW+R/h6MjtDuzc4qG7FZIiJk
         tovmfeYGB9hY8B/ZLlrQJlTCzskrN38guYa1b7UHYD0RlG6WiEhceb1lWbIfendzMMbF
         R+nd3tketWybY2Rua8g2vAX+gqBk7j9BYyGDavBy+NTIvh7v+s0+vzfoMnzlzeiQvhp/
         sqnA==
X-Forwarded-Encrypted: i=1; AJvYcCUZnhVu2zfv8RzWUWzx0Wwof+MBmb1lTtlWv6YRC5aD/1mGyCiaKWwzXlavyOzEwR/UqKPuEM6v/K4FenGQcbgE66PPSmx5na6egu6puCszfLNJ7LQxy1ZJ5Yk54j7cw3lkKhFYIk3CGA==
X-Gm-Message-State: AOJu0YxCPb8cR5KYGRmxVM3yUvy499ySMK1wwBthfg1sJz9yGFVgKCrG
	e1NdmmmSbuLYKkttklUp1neDZBhR5m/Ie/DQXnky5BFXXXdUIs4D
X-Google-Smtp-Source: AGHT+IF8+FDwmKxyThB72L1gvU1m617yeZV5LplJ9CsVs1k2okHSfEFmpXnKi2Trb0+Jrh6e0RmaCg==
X-Received: by 2002:a17:902:c943:b0:1fd:9269:72f0 with SMTP id d9443c01a7336-201d64a5b41mr42552705ad.47.1723657631850;
        Wed, 14 Aug 2024 10:47:11 -0700 (PDT)
Received: from localhost.localdomain ([2409:40f4:ad:f7ee:918a:4aa:ac70:4849])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1cfd62sm31967895ad.287.2024.08.14.10.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 10:47:11 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: nxp,lpc3220-mic: Convert to dtschema
Date: Wed, 14 Aug 2024 23:16:47 +0530
Message-ID: <20240814174651.188748-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the nxp,lpc3220-mic bindings to yaml format.

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../interrupt-controller/nxp,lpc3220-mic.txt  | 58 -------------
 .../interrupt-controller/nxp,lpc3220-mic.yaml | 85 +++++++++++++++++++
 2 files changed, 85 insertions(+), 58 deletions(-)
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
index 000000000000..66f2227ed364
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/nxp,lpc3220-mic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
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
+    description: |
+      The first cell is the IRQ number, the second cell is used to specify one
+      of the supported IRQ types:
+          IRQ_TYPE_EDGE_RISING = low-to-high edge triggered,
+          IRQ_TYPE_EDGE_FALLING = high-to-low edge triggered,
+          IRQ_TYPE_LEVEL_HIGH = active high level-sensitive,
+          IRQ_TYPE_LEVEL_LOW = active low level-sensitive.
+      Reset value is IRQ_TYPE_LEVEL_LOW.
+
+  interrupts:
+    items:
+      - description: Interrupt for SIC1
+      - description: Interrupt for SIC2
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+if:
+  properties:
+    compatible:
+      const: nxp,lpc3220-sic
+
+then:
+  required:
+    - interrupts
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
+      };
+
+    sic1: interrupt-controller@4000c000 {
+        compatible = "nxp,lpc3220-sic";
+        reg = <0x4000c000 0x4000>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        interrupt-parent = <&mic>;
+        interrupts = <0 IRQ_TYPE_LEVEL_LOW>, <30 IRQ_TYPE_LEVEL_LOW>;
+    };
+
+    sic2: interrupt-controller@40010000 {
+        compatible = "nxp,lpc3220-sic";
+        reg = <0x40010000 0x4000>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        interrupt-parent = <&mic>;
+        interrupts = <1 IRQ_TYPE_LEVEL_LOW>, <31 IRQ_TYPE_LEVEL_LOW>;
+    };
-- 
2.46.0


