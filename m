Return-Path: <linux-kernel+bounces-215662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903E09095A1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B6D1C212CB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E0079F0;
	Sat, 15 Jun 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2EaDIE0"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F58DDC1;
	Sat, 15 Jun 2024 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417730; cv=none; b=Ei6eYVHJcBSpzNSda/EcOQvVEpQxzmJKSu9odjHJUyYSpxTvBHZFI6UDZRTf2dFLeY4h0fGySHitB3Prr6aOUQQXjE3pn5itOXWzzWevIOfDi//CugZkmyQedQ1aNiDqKw2QvMHzVlGHk2XbGktMEw6Ygpi7MYGNQbItws/tLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417730; c=relaxed/simple;
	bh=EOys2I62KZ1akQipaN9xi0V4ioOFDVDNkKMRki62SFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8yp6IRNbTJeBBv/P6aEdGWNQM4mBK2KrZbvUblNRbXDfjz00q0j4hUBXW9R7S19RlQfRK2bnPLLw4NKD0x02AWgd6cfKjreIeaX3YxQgj2wbcHiWEeb5I0mh4i3oHoUb7mPxqx7zp2RS/KUPWJQPxXRG1JVvE4exAACn8EOh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2EaDIE0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so2530188b3a.0;
        Fri, 14 Jun 2024 19:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718417728; x=1719022528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrGcPYJMJhishfsKRnQ7kYXDZI93Ds4JWA94AUqTVuU=;
        b=A2EaDIE0Uug1BVZd9ChS/WgLgyrVBlutBZouJ6dgYBVd25Puinqvqs9lRojdO9RwDn
         Yg/apXq32F8Sn37Q4lmEJ2qdJYzEzW54DpMNg1N6F5LIlSvYyBoOZsRQUOa6ovGk1GdX
         xqSo29ytO5055yNZ1NpDVUtP7YVgSqYk0XYIXN8jWQ/QKIA4hVDepCs3K2DY4SgqJFhA
         jqfZD4Fpkcyu6dUcxZQxa1HCYiYVpFhuMGWgMg/8bSBibdk+BKsQvktqcM9oJlAjR73C
         gczK5H1PHrsuSfndqXeCvj5rN0q2ETfbrYqejzGN0xrAwmAdMq07mAOrJwjcKSM5dibP
         pcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417728; x=1719022528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrGcPYJMJhishfsKRnQ7kYXDZI93Ds4JWA94AUqTVuU=;
        b=S9YqADdfyd4CFcwIadKqJj43QOeh6MbZwc9S+T+7rxj5JrN7MLzAHkkXXmWEWU45vr
         2aLET+jJVELPjGyzpwpXFeje131GQg+XBlwl4PZlcb/0+em6XnXoX1oWV4hKX3CP8ZSq
         gLZIpW1eiufQdnQqD+LA3M060upc0lhVffNBGBeclXBlze0BBxxEfoQW1v7Eod2ly1tL
         jf2E6FmmtN+GcPZdDyw1dFEFyx0AsAqLWeKLSIdtpyQXbLrnKZETNWBSimF3fwkOF1Vx
         6OqNkDRImCAyFcuo+5s2GBIBZLrIcUZuzRuBa1uLUTJfBmWQFxjWGbx17e88/l3NzN3z
         ZZUA==
X-Forwarded-Encrypted: i=1; AJvYcCV26CP5pZoNXkbZB0sF3wKvk0Yhk32UJh4Mtkvkg5Ks7Ku3iE1/mMyAy8Bagd19aC+ZJ4tFbD5nd3TN14egDqCshk6aJvbDThiJHtmC6qwcNBnR5mCrAQYkofkCKU/0IJ9U8d353rl3mg==
X-Gm-Message-State: AOJu0YyJUFLA0BHpY+EMANYUrsk9ag478hvFnMMHtOk6hShyhvAnJXcD
	4g+gO8F8pk5uVdWoKBiEQj1dvBPfrAMhHBEmJz3+CMTUccgZrv0F
X-Google-Smtp-Source: AGHT+IHy9xJ9AAxZPgEP89H6YEmZw/dnBWHM4EBN1NfpDlERj6i0zuoI4aibR08QW7fJZyFE29H0gQ==
X-Received: by 2002:a05:6a20:9143:b0:1b2:ff4e:20b5 with SMTP id adf61e73a8af0-1bae7dd3cffmr6873814637.9.1718417727564;
        Fri, 14 Jun 2024 19:15:27 -0700 (PDT)
Received: from ga401ii.. ([2401:4900:1c28:4b16:65cf:ef28:5753:2be4])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-705ccb3d2acsm3717839b3a.124.2024.06.14.19.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 19:15:27 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: kanakshilledar111@protonmail.com,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND v4 1/2] dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dtschema
Date: Sat, 15 Jun 2024 07:45:03 +0530
Message-ID: <20240615021507.122035-2-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615021507.122035-1-kanakshilledar@gmail.com>
References: <20240615021507.122035-1-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the RISC-V Hart-Level Interrupt Controller (HLIC) to newer
DT schema, Created DT schema based on the .txt file which had
`compatible`, `#interrupt-cells` and `interrupt-controller` as
required properties.
Changes made with respect to original file:
- Changed the example to just use interrupt-controller instead of
using the whole cpu block
- Changed the example compatible string.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
Changes in v4:
- Change DCO email to @gmail.com
Changes in v3:
- Remove reference to `interrupt-controller` in `riscv/cpus.yaml`.
Changes in v2:
- Update the maintainers list.
- Add reference to `interrupt-controller` in `riscv/cpus.yaml`.
- Update compatible property with the reference in `cpus.yaml`.
- Include description for '#interrupt-cells' property.
- Change '#interrupt-cells' property to have `const: 1` as per the
text binding.
- Fixed the warning thrown by `/renesas/r9a07g043f01-smarc.dtb`.
---
 .../interrupt-controller/riscv,cpu-intc.txt   | 52 -------------
 .../interrupt-controller/riscv,cpu-intc.yaml  | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
deleted file mode 100644
index 265b223cd978..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-RISC-V Hart-Level Interrupt Controller (HLIC)
----------------------------------------------
-
-RISC-V cores include Control Status Registers (CSRs) which are local to each
-CPU core (HART in RISC-V terminology) and can be read or written by software.
-Some of these CSRs are used to control local interrupts connected to the core.
-Every interrupt is ultimately routed through a hart's HLIC before it
-interrupts that hart.
-
-The RISC-V supervisor ISA manual specifies three interrupt sources that are
-attached to every HLIC: software interrupts, the timer interrupt, and external
-interrupts.  Software interrupts are used to send IPIs between cores.  The
-timer interrupt comes from an architecturally mandated real-time timer that is
-controlled via Supervisor Binary Interface (SBI) calls and CSR reads.  External
-interrupts connect all other device interrupts to the HLIC, which are routed
-via the platform-level interrupt controller (PLIC).
-
-All RISC-V systems that conform to the supervisor ISA specification are
-required to have a HLIC with these three interrupt sources present.  Since the
-interrupt map is defined by the ISA it's not listed in the HLIC's device tree
-entry, though external interrupt controllers (like the PLIC, for example) will
-need to define how their interrupts map to the relevant HLICs.  This means
-a PLIC interrupt property will typically list the HLICs for all present HARTs
-in the system.
-
-Required properties:
-- compatible : "riscv,cpu-intc"
-- #interrupt-cells : should be <1>.  The interrupt sources are defined by the
-  RISC-V supervisor ISA manual, with only the following three interrupts being
-  defined for supervisor mode:
-    - Source 1 is the supervisor software interrupt, which can be sent by an SBI
-      call and is reserved for use by software.
-    - Source 5 is the supervisor timer interrupt, which can be configured by
-      SBI calls and implements a one-shot timer.
-    - Source 9 is the supervisor external interrupt, which chains to all other
-      device interrupts.
-- interrupt-controller : Identifies the node as an interrupt controller
-
-Furthermore, this interrupt-controller MUST be embedded inside the cpu
-definition of the hart whose CSRs control these local interrupts.
-
-An example device tree entry for a HLIC is show below.
-
-	cpu1: cpu@1 {
-		compatible = "riscv";
-		...
-		cpu1-intc: interrupt-controller {
-			#interrupt-cells = <1>;
-			compatible = "sifive,fu540-c000-cpu-intc", "riscv,cpu-intc";
-			interrupt-controller;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml
new file mode 100644
index 000000000000..83256cc0bd5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,cpu-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Hart-Level Interrupt Controller (HLIC)
+
+description:
+  RISC-V cores include Control Status Registers (CSRs) which are local to
+  each CPU core (HART in RISC-V terminology) and can be read or written by
+  software. Some of these CSRs are used to control local interrupts connected
+  to the core. Every interrupt is ultimately routed through a hart's HLIC
+  before it interrupts that hart.
+
+  The RISC-V supervisor ISA manual specifies three interrupt sources that are
+  attached to every HLIC namely software interrupts, the timer interrupt, and
+  external interrupts. Software interrupts are used to send IPIs between
+  cores.  The timer interrupt comes from an architecturally mandated real-
+  time timer that is controlled via Supervisor Binary Interface (SBI) calls
+  and CSR reads. External interrupts connect all other device interrupts to
+  the HLIC, which are routed via the platform-level interrupt controller
+  (PLIC).
+
+  All RISC-V systems that conform to the supervisor ISA specification are
+  required to have a HLIC with these three interrupt sources present.  Since
+  the interrupt map is defined by the ISA it's not listed in the HLIC's device
+  tree entry, though external interrupt controllers (like the PLIC, for
+  example) will need to define how their interrupts map to the relevant HLICs.
+  This means a PLIC interrupt property will typically list the HLICs for all
+  present HARTs in the system.
+
+maintainers:
+  - Palmer Dabbelt <palmer@dabbelt.com>
+  - Paul Walmsley <paul.walmsley@sifive.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: andestech,cpu-intc
+          - const: riscv,cpu-intc
+      - const: riscv,cpu-intc
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+    description: |
+      The interrupt sources are defined by the RISC-V supervisor ISA manual,
+      with only the following three interrupts being defined for
+      supervisor mode:
+        - Source 1 is the supervisor software interrupt, which can be sent by
+          an SBI call and is reserved for use by software.
+        - Source 5 is the supervisor timer interrupt, which can be configured
+          by SBI calls and implements a one-shot timer.
+        - Source 9 is the supervisor external interrupt, which chains to all
+          other device interrupts.
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller {
+        #interrupt-cells = <1>;
+        compatible = "riscv,cpu-intc";
+        interrupt-controller;
+    };
-- 
2.45.2


