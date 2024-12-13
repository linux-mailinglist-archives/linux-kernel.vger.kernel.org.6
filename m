Return-Path: <linux-kernel+bounces-445221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D819F12F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF31281BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57E1EE01A;
	Fri, 13 Dec 2024 16:52:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9361E4113;
	Fri, 13 Dec 2024 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108769; cv=none; b=f5v6ijXasDSIJuuTyhZb6ijXsWtpe6WMRwnhmeeNo08uiJ5ruGY4j4Qk3B/t+MGwHTu6iH87PCzAdvgTJJf0uJ0p/qpGWMJWfHDSedsXpgV5YzsiUx57ED1nAVdtgbm9PQlXimd1DRE+L9pD3fc4k5WNV23yFXoWX+cRQcBUKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108769; c=relaxed/simple;
	bh=sr/4CoG4xSadFidIeha+kzz8Ys4Iaepr17VZ5u1nADI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOpK7HmhcGnR2UpePqDqVMcLq98TZcLcsA8oZFQZTVSR4o83lIRsxDiCkOkEHgwP8Oxd+FJE2ffQcYZ+8fELQKwhEi9rpk5hMc7t4YDl55PlwThZ76FpNG2AJpow53g0YWnAyekuFgUlw1aDL+nxjV7dRwKr5TQPSaQH8vK/F6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5A921480;
	Fri, 13 Dec 2024 08:53:15 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5B743F5A1;
	Fri, 13 Dec 2024 08:52:46 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincenzo.frascino@arm.com
Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 2/3] xlnx: dt-bindings: xlnx,audio-formatter: Convert to json-schema
Date: Fri, 13 Dec 2024 16:52:39 +0000
Message-ID: <20241213165240.3652961-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213165240.3652961-1-vincenzo.frascino@arm.com>
References: <20241213165240.3652961-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Xilinx Audio Formatter 1.0  device tree binding documentation
to json-schema.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 .../bindings/sound/xlnx,audio-formatter.txt   | 29 -------
 .../bindings/sound/xlnx,audio-formatter.yaml  | 84 +++++++++++++++++++
 2 files changed, 84 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml

diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
deleted file mode 100644
index cbc93c8f4963..000000000000
--- a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Device-Tree bindings for Xilinx PL audio formatter
-
-The IP core supports DMA, data formatting(AES<->PCM conversion)
-of audio samples.
-
-Required properties:
- - compatible: "xlnx,audio-formatter-1.0"
- - interrupt-names: Names specified to list of interrupts in same
-		    order mentioned under "interrupts".
-		    List of supported interrupt names are:
-		    "irq_mm2s" : interrupt from MM2S block
-		    "irq_s2mm" : interrupt from S2MM block
- - interrupts-parent: Phandle for interrupt controller.
- - interrupts: List of Interrupt numbers.
- - reg: Base address and size of the IP core instance.
- - clock-names: List of input clocks.
-   Required elements: "s_axi_lite_aclk", "aud_mclk"
- - clocks: Input clock specifier. Refer to common clock bindings.
-
-Example:
-	audio_ss_0_audio_formatter_0: audio_formatter@80010000 {
-		compatible = "xlnx,audio-formatter-1.0";
-		interrupt-names = "irq_mm2s", "irq_s2mm";
-		interrupt-parent = <&gic>;
-		interrupts = <0 104 4>, <0 105 4>;
-		reg = <0x0 0x80010000 0x0 0x1000>;
-		clock-names = "s_axi_lite_aclk", "aud_mclk";
-		clocks = <&clk 71>, <&clk_wiz_1 0>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
new file mode 100644
index 000000000000..d599ee34c8b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xlnx,audio-formatter.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Device-Tree bindings for Xilinx PL audio formatter
+
+description: |
+  The IP core supports DMA, data formatting(AES<->PCM conversion)
+  of audio samples.
+
+maintainers:
+  - Vincenzo Frascino <vincenzo.frascino@arm.com>
+  - Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: xlnx,audio-formatter-1.0
+
+  reg:
+    maxItems: 1
+    description: |
+      Base address and size of the IP core instance.
+
+  "#sound-dai-cells":
+    const: 0
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
+    description: |
+      Names specified to list of interrupts in same order mentioned under
+      "interrupts".
+
+  interrupts-parent:
+    $ref: /schemas/types.yaml#/definitions/string
+    maxItems: 1
+    description: |
+      Phandle for interrupt controller.
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+    description: |
+      List of Interrupt numbers.
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+    description: |
+      List of input clocks.
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+    description: |
+      Input clock specifier. Refer to common clock bindings.
+
+required:
+  - compatible
+  - reg
+  - interrupt-names
+  - interrupts
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    audio_ss_0_audio_formatter_0: audio_formatter@80010000 {
+      compatible = "xlnx,audio-formatter-1.0";
+      interrupt-names = "irq_mm2s", "irq_s2mm";
+      interrupts-parent = <&gic>;
+      interrupts = <0 104 4>, <0 105 4>;
+      reg = <0x0 0x80010000 0x0 0x1000>;
+      clock-names = "s_axi_lite_aclk", "aud_mclk";
+      clocks = <&clk 71>, <&clk_wiz_1 0>;
+    };
+...
-- 
2.43.0


