Return-Path: <linux-kernel+bounces-436968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6399E8D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D09281343
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3FE21518F;
	Mon,  9 Dec 2024 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPbgWP+F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB8189B85;
	Mon,  9 Dec 2024 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732498; cv=none; b=DBXe7kubRtq44ELs/zBTrtMYPiI9W2kSSCxpB0ubVQ9C+UqX7qbgSm4LFM4VfxwPqSABpfXxU4myRd57F5hN3rtlnj92CCqK3cXjTqbY7nfTXqrVjY+abBTxwVGv3NR8AbS2LjZoSdXuDjCJvSdp9FBJl7MQ14qOJLnXJ6laHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732498; c=relaxed/simple;
	bh=Um7JMO3CYMOMtg9MkzluQOsT7g1qLmgYaKW8k1A2Eq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XUUZhXNC1eKYUu+GJ6k31BiWb8w2ibNZs/P85G1xgv5nUzXXUcnkf7pYl3wdyedaHkKTO9418NQn2FCBIU2qRUzPl9UDfmljuGS3R9PFNtxK+Xz7GyM0QbaQBEc/hwfhgwaJ49eky2isMdcb70BdSbmBb5MITWI+qmqOsN+2QGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPbgWP+F; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733732496; x=1765268496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Um7JMO3CYMOMtg9MkzluQOsT7g1qLmgYaKW8k1A2Eq4=;
  b=IPbgWP+FGfo23JDIv31x1C0crzQkKA9z8FQCxRH9qXbqOzaPQAn3S7T/
   t4BohNVm5MZmMkuaVVK6GlUxqhsBiGshlr6ptyKfuV8lDzCyvBLNDbL2t
   3jsEqteNvVH2WEmXzin3tis6havpqomZTIttkFOY2IIP2hURWAIJ5kSHG
   79OxjTn1LKMRoC3GAEEE0VMKnq99UEk4DPlzYRXfB5B3v1NeULngIEfOT
   n8IAEotQ3PmXZv1u8gm2MSAEeq24BTclRSCudMpHHtRVM1JUdiF8P89/k
   kKB3DjgbZsO4PC+AQfdasCcY4maRIY1Y8jD5iVkZdN+Z9bcQCkKqHD9PZ
   g==;
X-CSE-ConnectionGUID: m9CzoAGCTQeqrHon+Kx+RQ==
X-CSE-MsgGUID: 7seovTrrRJevQV4EYqNbyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34252468"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34252468"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 00:21:33 -0800
X-CSE-ConnectionGUID: B/NeFFu8QAmlGISAw3VL7Q==
X-CSE-MsgGUID: 5TZQxXd4Rz+mCZ6xhe9UCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95339983"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa010.fm.intel.com with ESMTP; 09 Dec 2024 00:21:27 -0800
From: niravkumar.l.rabara@intel.com
To: devicetree@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RESEND v4] dt-bindings: mtd: cadence: convert cadence-nand-controller.txt to yaml
Date: Mon,  9 Dec 2024 16:18:26 +0800
Message-Id: <20241209081826.1242214-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Convert cadence-nand-controller.txt to yaml format.
Update cadence-nand-controller.txt to cdns,hp-nfc.yaml in MAINTAINER file.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---

Changes in v4 resend:
- Include missing Reviewed-by tag.

Changes in v4:
- Fixed the identation for examples as per review comment in v3.

Changes in v3:
- Changed file name to cdns,hp-nfc.yaml to match with compatible.
- Update description, fixed alignment, and used defines for interrupt
  flag as per review comments in v2.

Changes in v2:
- Update name cadence-nand-controller.txt to cadence,nand.yaml in MAINTAINER
  file to resolve the warning.

 .../bindings/mtd/cadence-nand-controller.txt  | 53 -------------
 .../devicetree/bindings/mtd/cdns,hp-nfc.yaml  | 75 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 76 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml

diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
deleted file mode 100644
index d2eada5044b2..000000000000
--- a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-* Cadence NAND controller
-
-Required properties:
-  - compatible : "cdns,hp-nfc"
-  - reg : Contains two entries, each of which is a tuple consisting of a
-	  physical address and length. The first entry is the address and
-	  length of the controller register set. The second entry is the
-	  address and length of the Slave DMA data port.
-  - reg-names: should contain "reg" and "sdma"
-  - #address-cells: should be 1. The cell encodes the chip select connection.
-  - #size-cells : should be 0.
-  - interrupts : The interrupt number.
-  - clocks: phandle of the controller core clock (nf_clk).
-
-Optional properties:
-  - dmas: shall reference DMA channel associated to the NAND controller
-  - cdns,board-delay-ps : Estimated Board delay. The value includes the total
-    round trip delay for the signals and is used for deciding on values
-    associated with data read capture. The example formula for SDR mode is
-    the following:
-    board delay = RE#PAD delay + PCB trace to device + PCB trace from device
-    + DQ PAD delay
-
-Child nodes represent the available NAND chips.
-
-Required properties of NAND chips:
-  - reg: shall contain the native Chip Select ids from 0 to max supported by
-    the cadence nand flash controller
-
-See Documentation/devicetree/bindings/mtd/nand-controller.yaml for more details on
-generic bindings.
-
-Example:
-
-nand_controller: nand-controller@60000000 {
-	  compatible = "cdns,hp-nfc";
-	  #address-cells = <1>;
-	  #size-cells = <0>;
-	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
-	  reg-names = "reg", "sdma";
-	  clocks = <&nf_clk>;
-	  cdns,board-delay-ps = <4830>;
-	  interrupts = <2 0>;
-	  nand@0 {
-	      reg = <0>;
-	      label = "nand-1";
-	  };
-	  nand@1 {
-	      reg = <1>;
-	      label = "nand-2";
-	  };
-
-};
diff --git a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
new file mode 100644
index 000000000000..0bed37a994c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/cdns,hp-nfc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence NAND controller
+
+maintainers:
+  - Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
+
+allOf:
+  - $ref: nand-controller.yaml
+
+properties:
+  compatible:
+    items:
+      - const: cdns,hp-nfc
+
+  reg:
+    items:
+      - description: Controller register set
+      - description: Slave DMA data port register set
+
+  reg-names:
+    items:
+      - const: reg
+      - const: sdma
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  cdns,board-delay-ps:
+    description: |
+      Estimated Board delay. The value includes the total round trip
+      delay for the signals and is used for deciding on values associated
+      with data read capture. The example formula for SDR mode is the
+      following.
+      board delay = RE#PAD delay + PCB trace to device + PCB trace from device
+      + DQ PAD delay
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    nand-controller@10b80000 {
+        compatible = "cdns,hp-nfc";
+        reg = <0x10b80000 0x10000>,
+              <0x10840000 0x10000>;
+        reg-names = "reg", "sdma";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&nf_clk>;
+        cdns,board-delay-ps = <4830>;
+
+        nand@0 {
+            reg = <0>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..9fab4b4a75a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5009,7 +5009,7 @@ F:	drivers/media/platform/cadence/cdns-csi2*
 CADENCE NAND DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-F:	Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
+F:	Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
 F:	drivers/mtd/nand/raw/cadence-nand-controller.c
 
 CADENCE USB3 DRD IP DRIVER
-- 
2.25.1


