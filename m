Return-Path: <linux-kernel+bounces-367401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4509A01C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03051C2109B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DDB1B0F03;
	Wed, 16 Oct 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1rKbp6KV"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9E198E81
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061551; cv=none; b=Mj8vq8MVVFiymFCSO/EH1EXrllC+jtfTxVAM31S+eBjJA8sZw4T5qr21MCnOaMZGLcQJuUjmLbWAcTuIDBtUu4MHkY5+fGfvOv/ozMbHJRK3/8qQhFOEP4E3hahwObmhwQElvedk5/eEuvKgmL3psT6xli3VWj/p+LxZw3HFOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061551; c=relaxed/simple;
	bh=0PYHzBq49WUx3wDvIQ7dY33LCQQdXrdvrQ6UNdoV9Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ItT8cCujevB0u2MkB85iUaWI6M/tiAOwfpMax1C/3WgtRdkBNIeeTtlcrNrJDh68YCdEPSv6hK5PdUzhm0ut/xjaKQ0gv42ZeiI7ZNSv1TH8VbVKPpltVOlWcXe9zNzMDIGRjOSU+vuYAaAtavZSz3LMeY27S9OkU6LkgrnmeiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1rKbp6KV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db238d07b3so5424846a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729061549; x=1729666349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBZ3Mry6R0CSRRw76cyOT/ZuRl4jtXL0NnmmVv3FUPE=;
        b=1rKbp6KVS3Le7hLh+HuHd0KrqFBSe5GBkGbe5DDbsZkxl9/FIE/JLHrNgvxaMsfj9H
         UYxHmRAsVfalyE4hzOSfzAADyqCjcfa8LXeasfr9so8CCCZHzDKhKSQXiuQlTIYZ2BLd
         QqAZYgp9XcyIVHBPyR00KoxFcoe+N0D4cA0ZHUi3wWurT7zHkXR6s0dAfJIdlCEdeQij
         s6Xc/S8Rj02AlVVezd8pkqF3pTpOmWVStoNVeXNvI9WHI7iyhpAHo3Uxtm2HfGNp/fGM
         NZH0WproXgOwH5R6YkwYMymHmIxHbCLm1AJAXArLsfCAlyLKsSIq3jg3a3LbNEYwr/w8
         9ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061549; x=1729666349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBZ3Mry6R0CSRRw76cyOT/ZuRl4jtXL0NnmmVv3FUPE=;
        b=Vf4UWWN2MlEOVVnLPwLtbgzRLTp1aaWuTExfeO8lfwJkM4vhbNp74/AmQylMD6Nl56
         f/PbE7S45qeKw0BpnFTaqEAPD4X8XjFrEeeInsY2gXIBFb82LYtKixG9jGA2CPOWk2r4
         /GvfyN/iN0AooEYiQKjmqR2PGTBjGbdw1ABXYKZmcQv3EiX3u+fxmKghlvZIzLxD9TcC
         j7+FDQ7PlrcWZfQtQAK+VYup/g/395rsVbQ3SpwYZ/NeAR1jzCIQQBGSeafR9GeMxcOs
         GIg4CIc+AVA75LV7+OHJ+kTeCUcGFFuUMK0hCZrNjrZOWaC0nrPz7IBpeIvqqo4gdxJH
         lBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAnwjaxoAHdJoKEgDRthP2AgPsv5ZKJSa7QcLB1x/3A9VrGQUKoI5Qi9Gj+XEPUgNbiojVLu2IlbPtS2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGRsedHY8c5SchrMIJPIKoj5BJ2uZspLN/Oub2C3+QlcSajq/
	3rKWQ3n9XC7TjcV2Jq0PtGLKIbExitdm01ham3rZ7RIh+ow5SnxSkUUeqNwcvAo=
X-Google-Smtp-Source: AGHT+IF4FPffxtmQR9t5EZMbd+1PD+tfMLop2oLUu4PzlpvPJKV8Cf+CHLosQyW1+af6eeMKw1OQIg==
X-Received: by 2002:a05:6a20:d818:b0:1cf:2a35:6d21 with SMTP id adf61e73a8af0-1d905f69115mr4473754637.45.1729061548715;
        Tue, 15 Oct 2024 23:52:28 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77370a83sm2410762b3a.5.2024.10.15.23.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:52:27 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v10 1/7] dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
Date: Tue, 15 Oct 2024 23:52:13 -0700
Message-Id: <6c255602e296feaf0f005b498de4e6fdf8686ff7.1729059707.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729059707.git.tjeznach@rivosinc.com>
References: <cover.1729059707.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the RISC-V IOMMU device drivers.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 .../bindings/iommu/riscv,iommu.yaml           | 147 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
new file mode 100644
index 000000000000..5d015eeb06d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V IOMMU Architecture Implementation
+
+maintainers:
+  - Tomasz Jeznach <tjeznach@rivosinc.com>
+
+description: |
+  The RISC-V IOMMU provides memory address translation and isolation for
+  input and output devices, supporting per-device translation context,
+  shared process address spaces including the ATS and PRI components of
+  the PCIe specification, two stage address translation and MSI remapping.
+  It supports identical translation table format to the RISC-V address
+  translation tables with page level access and protection attributes.
+  Hardware uses in-memory command and fault reporting queues with wired
+  interrupt or MSI notifications.
+
+  Visit https://github.com/riscv-non-isa/riscv-iommu for more details.
+
+  For information on assigning RISC-V IOMMU to its peripheral devices,
+  see generic IOMMU bindings.
+
+properties:
+  # For PCIe IOMMU hardware compatible property should contain the vendor
+  # and device ID according to the PCI Bus Binding specification.
+  # Since PCI provides built-in identification methods, compatible is not
+  # actually required. For non-PCIe hardware implementations 'riscv,iommu'
+  # should be specified along with 'reg' property providing MMIO location.
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qemu,riscv-iommu
+          - const: riscv,iommu
+      - items:
+          - enum:
+              - pci1efd,edf1
+          - const: riscv,pci-iommu
+
+  reg:
+    maxItems: 1
+    description:
+      For non-PCI devices this represents base address and size of for the
+      IOMMU memory mapped registers interface.
+      For PCI IOMMU hardware implementation this should represent an address
+      of the IOMMU, as defined in the PCI Bus Binding reference.
+
+  '#iommu-cells':
+    const: 1
+    description:
+      The single cell describes the requester id emitted by a master to the
+      IOMMU.
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+    description:
+      Wired interrupt vectors available for RISC-V IOMMU to notify the
+      RISC-V HARTS. The cause to interrupt vector is software defined
+      using IVEC IOMMU register.
+
+  msi-parent: true
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+
+additionalProperties: false
+
+examples:
+  - |+
+    /* Example 1 (IOMMU device with wired interrupts) */
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    iommu1: iommu@1bccd000 {
+        compatible = "qemu,riscv-iommu", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        interrupt-parent = <&aplic_smode>;
+        interrupts = <32 IRQ_TYPE_LEVEL_HIGH>,
+                     <33 IRQ_TYPE_LEVEL_HIGH>,
+                     <34 IRQ_TYPE_LEVEL_HIGH>,
+                     <35 IRQ_TYPE_LEVEL_HIGH>;
+        #iommu-cells = <1>;
+    };
+
+    /* Device with two IOMMU device IDs, 0 and 7 */
+    master1 {
+        iommus = <&iommu1 0>, <&iommu1 7>;
+    };
+
+  - |+
+    /* Example 2 (IOMMU device with shared wired interrupt) */
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    iommu2: iommu@1bccd000 {
+        compatible = "qemu,riscv-iommu", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        interrupt-parent = <&aplic_smode>;
+        interrupts = <32 IRQ_TYPE_LEVEL_HIGH>;
+        #iommu-cells = <1>;
+    };
+
+  - |+
+    /* Example 3 (IOMMU device with MSIs) */
+    iommu3: iommu@1bcdd000 {
+        compatible = "qemu,riscv-iommu", "riscv,iommu";
+        reg = <0x1bccd000 0x1000>;
+        msi-parent = <&imsics_smode>;
+        #iommu-cells = <1>;
+    };
+
+  - |+
+    /* Example 4 (IOMMU PCIe device with MSIs) */
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@30000000 {
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            reg = <0x0 0x30000000  0x0 0x1000000>;
+            ranges = <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0 0x0f000000>;
+
+            /*
+             * The IOMMU manages all functions in this PCI domain except
+             * itself. Omit BDF 00:01.0.
+             */
+            iommu-map = <0x0 &iommu0 0x0 0x8>,
+                        <0x9 &iommu0 0x9 0xfff7>;
+
+            /* The IOMMU programming interface uses slot 00:01.0 */
+            iommu0: iommu@1,0 {
+               compatible = "pci1efd,edf1", "riscv,pci-iommu";
+               reg = <0x800 0 0 0 0>;
+               #iommu-cells = <1>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324..18b4d9b44115 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19890,6 +19890,13 @@ F:	arch/riscv/
 N:	riscv
 K:	riscv
 
+RISC-V IOMMU
+M:	Tomasz Jeznach <tjeznach@rivosinc.com>
+L:	iommu@lists.linux.dev
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
+
 RISC-V MICROCHIP FPGA SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
-- 
2.34.1


