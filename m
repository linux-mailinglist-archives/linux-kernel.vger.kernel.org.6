Return-Path: <linux-kernel+bounces-182783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746488C8FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 08:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1011C21A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 06:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524A3BE65;
	Sat, 18 May 2024 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7riXalN"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544D1A2C10;
	Sat, 18 May 2024 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716013423; cv=none; b=kP64Cs61blWZ9ZOn51Wu1QKjbsH3NZilLNvARCZosEpDEdkSS1xP7FbpHIQ9SEs1TGn0H3TOiyShuezSRSDa6FjlZQyHJj6npDZgRmdCY6F/p/ZhuFccVglJpvuDo5VmckzTWxJeqhKJlY/bcKxokh8NrEFzHCqzylvou5l8wUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716013423; c=relaxed/simple;
	bh=Gs4ZaFZ1pd9n4/qqUHeAwX0aMvkzFoGaz4hwJXK1Huo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kUlSufmesFJd/gSM/cnCyhM2ml4yo2Ng32wXmAUotRc117S01Emx1Ty5TFb0+W3WBisCmLQFu10gE3nLQ38IczfJKutoK1psMj70Q9FoJhZUc57XmB2pAxrFJYsI75fDWojXdbBOiDplx02DkCXbWGJWrTvLsaEL9rRj3vEarjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7riXalN; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2454bad9957so1174149fac.2;
        Fri, 17 May 2024 23:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716013420; x=1716618220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lChIbpiKLjP/99jCI9/LiFKYC4nQkzM10+P+N1G1jz4=;
        b=l7riXalNBHyAwp1wJPFTz8CPiDEJeQ4DV0ww0xIbcUX4D1bb0LVLFX91Ua1RwiuU3V
         p9ytpehBek+EOV6b2lQJexd/b+jAzGby5u1pmnnFqW2Ce6UhByvnZ5Me70BwD2KGyjSI
         AJe0JjJAQjc1hJW5xgvQv6CT/vRka/YwcR5toy6X9yThBZbXWlH6mXWXLQa3zSXNzF7P
         7C+raZwSEus5QitRntnLbyBlhGoU0JJQs84SQ05JxGabUZjRllM+4jNexzS3bMaRl5hO
         tWkWi6eiXugU/z+buI263dSQojZooVL63aqjIZmktlDCHVPRjtukKFzhVx4v8mq9CNmS
         M/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716013420; x=1716618220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lChIbpiKLjP/99jCI9/LiFKYC4nQkzM10+P+N1G1jz4=;
        b=g2WUXUCytPSQ33i8s4+6xsJPjOwUC5XDssmPducnKroWGeN3kc7OMQG0EEARdpR2Ow
         Ercufxa58DWEydUdr1P2W5wGEO4DHa59DMG45Jke5JOUTeO1VdcEr+JhImXS2B8hEPqz
         OC8jbKSq65M3c0Ll1KdHrQx3Qc/qOZaVhTV7CB6QX9wtCun4dvs4b+y/bO9GiV1Fdnnu
         tD0M742YbdSg5X2Kg2A8s8Ep+0m9bjwi+6Ve4oDObo3U4xK86H7SkWTqLUlPVSG11CzT
         UZjQDYhw1k5e+U9CXf3lDB9FfcPjlnnzMAz5+f0c1bSxmTZm/dgRcnT+0znOkJKHcXP1
         wXKA==
X-Forwarded-Encrypted: i=1; AJvYcCX6mFi4/62kqd7xzmcFq3JpSu3F9+GDXDTVZlEPRmVTh/DTwBj7I1gnhtgGsSLY/Uiy8Boihtt7W3aKjWuRsKT8ZRRjXALUWTRs5uN0O79/XAoH9rV88y+AtOvyW43O/HhJaZKFQqn8kg==
X-Gm-Message-State: AOJu0YyNaIV5ZHaQI3UhoWgYZCIxxPdKEBcjbWpngJQib2dxLuh5CNmp
	lIBPloUICU0bw8nqVKvrWQfjSr/UT4TgSEVl9ctTIuY0KRkSc2J/
X-Google-Smtp-Source: AGHT+IHs0B7rpGA8YYCnNcrbM/HW2ScrpVogeU4D5lviCUZIwCnatilzhab0d1p6drNssb7I4s0+gg==
X-Received: by 2002:a05:6871:8002:b0:245:2ccf:becf with SMTP id 586e51a60fabf-2452ccfc883mr10283944fac.37.1716013419743;
        Fri, 17 May 2024 23:23:39 -0700 (PDT)
Received: from localhost.localdomain ([223.178.82.123])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f4d2a6669dsm15691233b3a.31.2024.05.17.23.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 23:23:39 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dtschema
Date: Sat, 18 May 2024 11:49:21 +0530
Message-Id: <20240518061925.43549-1-kanakshilledar111@protonmail.com>
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
Changes in v2:
- Update the maintainers list.
- Add reference to `interrupt-controller` in `riscv/cpus.yaml`.
- Update compatible property with the reference in `cpus.yaml`.
- Include description for '#interrupt-cells' property.
- Change '#interrupt-cells' property to have `const: 1` as per the
text binding.
- Fixed the warning thrown by `/renesas/r9a07g043f01-smarc.dtb`.
---
 .../interrupt-controller/riscv,cpu-intc.txt   | 52 --------------
 .../interrupt-controller/riscv,cpu-intc.yaml  | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 52 deletions(-)
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
index 000000000000..e2da595ee389
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml
@@ -0,0 +1,72 @@
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
+allOf:
+  - $ref: /schemas/riscv/cpus.yaml#/properties/interrupt-controller
+
+properties:
+  compatible:
+    $ref: /schemas/riscv/cpus.yaml#/properties/interrupt-controller/properties/compatible
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
2.34.1


