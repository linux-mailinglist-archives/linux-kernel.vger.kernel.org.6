Return-Path: <linux-kernel+bounces-182269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9374B8C8906
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B641C22288
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4F369D2F;
	Fri, 17 May 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/pUygbm"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2428479;
	Fri, 17 May 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958507; cv=none; b=aOK2yW6SL/7PPFBnPgdkuQHLU6QOh5/OQF8aPKAw/aOr3wpuCmcX4lLICvWHr49Uspnm6ITYQsEEMYWiSsTa7+I5bkt5OJeO8nLLlw0v5bQx9VvR1sdAUg0UAEBMV7XOjkRD+o2QDQirMjkO26WTBpLZcZGU4YR4eiVZPiRuI7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958507; c=relaxed/simple;
	bh=ntipFH19OKh0e6p03a5BVC6XD+eZwfY4p57qddiFvRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VtGVvpfk067F64y109WY6+YJix/Jo/3/Vh1R5dncVA4ypdVhjaTtAOwG527NnH1rZXdP8GPGwawyBZcJZgmGmTUTnVNglodwiIZfRHtPa3slNZgku+plkVbNZXLvUSkvOZept2seCGk5a367527jWfBkgTpDJ9OQC+Gv/gMIypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/pUygbm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1edf506b216so11249695ad.2;
        Fri, 17 May 2024 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715958505; x=1716563305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv54+/RYiMmMOtNi1mq/Z0D5fhkYk22Dy/dLYDtHm+c=;
        b=I/pUygbm4xAiTinknMw13RloN6rTD9p4gQy7Kr4Fa8N2/mWsqqqyHeMPDN+TCTr/F+
         hd5oyYIx8D/qV2zCzb/DkxToOOdPj+rpxSfwB2cPcRYnSZ/la0iJAAMkz4fu6zBa+MMe
         AI/ONsk7irgT+XRyHagfbQ6RYzi60dNLdyMhk1XP36IO2b/Bpo/Uzt+AqSUaMC9cmc7S
         2z02SdEpSSSm/v1fDFkBZ1L+eNVdwe25yk9ceQpFqtdiXrRP2bAHVgKZA7PnuL2F5Qqg
         WqgDinjeu8ER6MzABs7Nf02+fHk/uyBsj15A6jkx4V1vKkSj9EMiq3mJMH93NylleZNF
         9Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715958505; x=1716563305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iv54+/RYiMmMOtNi1mq/Z0D5fhkYk22Dy/dLYDtHm+c=;
        b=jt067XvTDe/chPC2BwIdOfP7VumSsA9cEIbOVpV9oqlg4Yf9LaUfE8ZJnHZKyyV5lH
         zxKqrzvSEgebnHZcGhuxuRGBMzlG9aq0ta+r1yaiKqSeSUDvm8wsdmM679KTXedwHvsL
         o+snrcVGRcBc0guNaYLuX8xNEl5uJNsWBWTdZspcWYxf7XEu0CyDdCnZAA+LtELMQUQv
         tXpqJjTsSe6vz8gWH0AjLBkFRr6+3K9udiXmEQd//kWkBMUJ56BBPb5tCnSINk57u7Jt
         gzk3q9zw47A1Tr+HJB6+DgmwTLJ30FZw9VMuFZC8Kt+RIB2fomICiMEQZwEap7Cp3MoB
         3CFg==
X-Forwarded-Encrypted: i=1; AJvYcCXqtqyPj6+dPpumD2TMlQwl+lQIxfGoWIOguWtR0IXVpQK1U5oVsehwldJEvOhNFTW9+5RR9yPadO9JJumd7WJ2kogAqzU2Lq+BiueybjPgT0WJM/O1FQ1Zh712CX0nLfmCdiyt9Uuu3A==
X-Gm-Message-State: AOJu0YyNU3SsN4DI3aPSdUI8JFWeu0gUopSlXoLCCraTmy9P7jB4t3zE
	Am5XL0h9YlVyroDawpfzkmjCUFGH5uaByOpMk/0KIpLG7+8AlDps
X-Google-Smtp-Source: AGHT+IFOk1Z8tKHx4PNlsmj1SdqKmikqavDjQTEj4ooLTFLGPr7uF21G5WM/AlInMnfWHnhIFhKhsg==
X-Received: by 2002:a17:902:e892:b0:1e5:9dff:a52c with SMTP id d9443c01a7336-1ef43d2e258mr262962585ad.10.1715958505178;
        Fri, 17 May 2024 08:08:25 -0700 (PDT)
Received: from localhost.localdomain ([223.178.82.123])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-64f61b921ddsm6563371a12.89.2024.05.17.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 08:08:24 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
X-Google-Original-From: Kanak Shilledar <kanakshilledar111@protonmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
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
	linux-riscv@lists.infradead.org
Subject: [PATCH] dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dtschema
Date: Fri, 17 May 2024 20:37:40 +0530
Message-Id: <20240517150741.181303-1-kanakshilledar111@protonmail.com>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
---
 .../interrupt-controller/riscv,cpu-intc.txt   | 52 -----------------
 .../interrupt-controller/riscv,cpu-intc.yaml  | 57 +++++++++++++++++++
 2 files changed, 57 insertions(+), 52 deletions(-)
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
index 000000000000..6fe86d243633
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml
@@ -0,0 +1,57 @@
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
+  - Kanak Shilledar <kanakshilledar111@protonmail.com>
+
+properties:
+  compatible:
+    const: "riscv,cpu-intc"
+
+  interrupt-controller: true
+
+  '#interrupt-cells': true
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
2.34.1


