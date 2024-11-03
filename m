Return-Path: <linux-kernel+bounces-393803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ED19BA56C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 13:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F021F21850
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B170832;
	Sun,  3 Nov 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsiAyq4/"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9D15A8;
	Sun,  3 Nov 2024 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730637320; cv=none; b=QBxD/oWqSA9jryp3tXCpApJgpVjsHBfBoVSXsba3IvFJS/9NZJAfAXupsi2H05cpiI/7HV9tJACcUOYRPUcnLlIRgHmOpCLGqWCCzEHhNFd20x7nEum8tfp3OT2pNq3SO/gS2JepGEg9MiFNAV4l4N9GejvSL4Lmu1k0psE9tb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730637320; c=relaxed/simple;
	bh=pyMhGlOko2l1l4rPvpvIIJR5UOe1eWHbUFWCyGiJd7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n9eAR0X4KfH2xS66wLvDwASrvfbYFQaRydmEPLtwE80xZHrtHK1xGn8OceffsSR08qCnyBqFKnrrgaHXKJ8yVsm0Udhxn+RbQjC/SY1END/GEVw+kowYt/u3Lx/sS3rP1gqUNxw1u9IgYKeG35KnHnnZ9gFtOUq7f9wHC1dFk9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsiAyq4/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso583556466b.2;
        Sun, 03 Nov 2024 04:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730637317; x=1731242117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLWzptnhbAYcuwHkPTV5EYcOi52RjfwzuyiUdLBphLI=;
        b=SsiAyq4/JCh4pq6KlsLhj6nFuwOUKjdP0qCpXaNxobNj9OamHyk5d3ttgzIAMTD+FN
         vVeAohMFnaMSxP8OeKmLuIGykAQ5C1m5WVJ7tZemfH1xCKXa3hNBVZrb7uWZrobnYdd7
         GW6jr/CAGbbkfqSbueC5AbgYu2geHCHZ1/fDbYawAT/5faep0QtDsGgHw0vvQ6/n8WmI
         JrW1vhsckHNc90ltHsEF/0ass0YdiKP0norXiCX5RuwVbItRS0jxak8soGSNokgUtiwC
         1EbaaRiFjA+KTdsANA1rM1zydyQTtYH0w+CVGgcaFvMUFTDINYs7yz8vhA2SkJ+oVwgk
         jUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730637317; x=1731242117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLWzptnhbAYcuwHkPTV5EYcOi52RjfwzuyiUdLBphLI=;
        b=lR8aonIdydLvgJGFyohQmEVUb1pk7+P8hNwSBtS6BHft9Brv2XZgVqZkyI65hftI0k
         0BchNgdAglPh3RTXc2XuW65OhGazWB0kbHGnEix65wAfZRIdZJKmIlaw0fZFzFSGqtrQ
         nf8lGnoqzzwKAx8TgjL29cGSY6UxwGbAvtVeccZTStcD8rdD8IIp3mAUcz+iww/F/ZEs
         Nh2UYmBtnjcTcXYoBZ3WOIPx4xjRhg8fM07F+D64DDCsAQ3XhV5EYwitGLPSQ4LMFaoN
         XZ48rqBkaqu7Upvdo0efavQieb/sZ5eAA3jATjQjmqO7rRJgR9nhUxPxpjgWjcy+U5wr
         kRow==
X-Forwarded-Encrypted: i=1; AJvYcCUJCg+swc5bXXJt+MdHIbY48DyIa9YUhP2Z1pq39l1Qn4WJighA+Umb2Gz+/8v+wd//grsqcmqTV+Ei@vger.kernel.org, AJvYcCViqCN0D2mH/U/Ns4iJULRfu4KLxyk3rL+DNAJVuIYFPePa8EMXet1ETA4BpRIP4uTEAla2gTtGKYusgZNq@vger.kernel.org
X-Gm-Message-State: AOJu0YxWEimi5YpdRifKSgsiCCwbEICiWg2i3pPGgKdpkKZ1cm82vQrS
	CnTVNHSDDu62taE9yjvqoLxzdAL1R2vIS2/i+S7WC0TO0vA9BbwN
X-Google-Smtp-Source: AGHT+IHXfkrHb7besGkh4Nbcj39gl2gY+KXPI9aF9iT7CR5AegIJ0eV9DFkX1G+cTTqp04nuc7chCg==
X-Received: by 2002:a17:907:7f9f:b0:a9a:be:37f8 with SMTP id a640c23a62f3a-a9de61675a4mr3072270166b.43.1730637317039;
        Sun, 03 Nov 2024 04:35:17 -0800 (PST)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566797a7sm418754866b.190.2024.11.03.04.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 04:35:16 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-actions@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: timer: actions,owl-timer: convert to YAML
Date: Sun,  3 Nov 2024 14:35:11 +0200
Message-ID: <20241103123513.2890107-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Actions Semi Owl timer bindings to DT schema.

Changes during conversion:
 - Add a description
 - Add "clocks" as a required property, since the driver searches for it
 - Correct the given example according to owl-s500.dtsi

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
v2: update commit message to be accurate (Krzysztof)
v2: don't preserve formatting in the description (Krzysztof)
v2: add allOf:if:then block constraining per variant (Krzysztof)
v2: add a blank line after additionalProperties (Krzysztof)
---
 .../bindings/timer/actions,owl-timer.txt      |  21 ----
 .../bindings/timer/actions,owl-timer.yaml     | 107 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 108 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
deleted file mode 100644
index 977054f87..000000000
--- a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Actions Semi Owl Timer
-
-Required properties:
-- compatible      :  "actions,s500-timer" for S500
-                     "actions,s700-timer" for S700
-                     "actions,s900-timer" for S900
-- reg             :  Offset and length of the register set for the device.
-- interrupts      :  Should contain the interrupts.
-- interrupt-names :  Valid names are: "2hz0", "2hz1",
-                                      "timer0", "timer1", "timer2", "timer3"
-                     See ../resource-names.txt
-
-Example:
-
-		timer@b0168000 {
-			compatible = "actions,s500-timer";
-			reg = <0xb0168000 0x100>;
-			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-			             <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "timer0", "timer1";
-		};
diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml b/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
new file mode 100644
index 000000000..646c554a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/actions,owl-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl timer
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+description:
+  Actions Semi Owl SoCs provide 32bit and 2Hz timers.
+  The 32bit timers support dynamic irq, as well as one-shot mode.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-timer
+      - actions,s700-timer
+      - actions,s900-timer
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 6
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 6
+    items:
+      enum:
+        - 2hz0
+        - 2hz1
+        - timer0
+        - timer1
+        - timer2
+        - timer3
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - interrupts
+  - interrupt-names
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - actions,s500-timer
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: 2hz0
+            - const: 2hz1
+            - const: timer0
+            - const: timer1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - actions,s700-timer
+              - actions,s900-timer
+    then:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: timer1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      timer@b0168000 {
+        compatible = "actions,s500-timer";
+        reg = <0xb0168000 0x100>;
+        clocks = <&hosc>;
+        interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "2hz0", "2hz1", "timer0", "timer1";
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 5f34d168b..76ea65128 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2024,7 +2024,7 @@ F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/net/actions,owl-emac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
-F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
+F:	Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
 F:	arch/arm/boot/dts/actions/
 F:	arch/arm/mach-actions/
 F:	arch/arm64/boot/dts/actions/
-- 
2.43.0


