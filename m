Return-Path: <linux-kernel+bounces-528936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5001DA41E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A746420F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD62561A9;
	Mon, 24 Feb 2025 11:47:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A2225486A;
	Mon, 24 Feb 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397631; cv=none; b=VjIn3JnQH3TQ8P+7Gh90sm2h4CBL7O5HAc533aJqhTpEqC+0W9fQ47/30z6wiSE206fIt1NLkdW/wrmIPgVdPsjgbFftw+rJ9WOM+uThWxQfQlRkiwkD89V5qqkml5yc2liL6w/k8vQg289V13lSwJH1/j/x5/ujowouze/FkrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397631; c=relaxed/simple;
	bh=wOubAz0sDuuNRzuYN6R/Ee5gKWQWVEt4uVgZS424IWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxBgyDQFXDre6gazSrcLrc3WrLqpMrjqP3fvraVBFOlN4cZzb5jW8chKYMIar0nttK/SMkZiCrhcyMWtUpytffAUgKrZXpwZIUQb9w9f79W1yN2x10daerwNzcTTbTe4+5vJ1UbOQ7UGclT0XNp9WVfYdYM61WeZMhsF3iacTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D84721FCD;
	Mon, 24 Feb 2025 03:47:25 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35FEA3F6A8;
	Mon, 24 Feb 2025 03:47:07 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-sound@vger.kernel.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] ASoC: dt-bindings: xlnx,spdif: Convert to json-schema
Date: Mon, 24 Feb 2025 11:46:47 +0000
Message-ID: <20250224114648.1606184-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224114648.1606184-1-vincenzo.frascino@arm.com>
References: <20250224114648.1606184-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Xilinx SPDIF 2.0 device tree binding documentation to
json-schema.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 ------
 .../devicetree/bindings/sound/xlnx,spdif.yaml | 92 +++++++++++++++++++
 2 files changed, 92 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml

diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
deleted file mode 100644
index 15c2d64d247c..000000000000
--- a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Device-Tree bindings for Xilinx SPDIF IP
-
-The IP supports playback and capture of SPDIF audio
-
-Required properties:
- - compatible: "xlnx,spdif-2.0"
- - clock-names: List of input clocks.
-   Required elements: "s_axi_aclk", "aud_clk_i"
- - clocks: Input clock specifier. Refer to common clock bindings.
- - reg: Base address and address length of the IP core instance.
- - interrupts-parent: Phandle for interrupt controller.
- - interrupts: List of Interrupt numbers.
- - xlnx,spdif-mode: 0 :- receiver mode
-		    1 :- transmitter mode
- - xlnx,aud_clk_i: input audio clock value.
-
-Example:
-	spdif_0: spdif@80010000 {
-		clock-names = "aud_clk_i", "s_axi_aclk";
-		clocks = <&misc_clk_0>, <&clk 71>;
-		compatible = "xlnx,spdif-2.0";
-		interrupt-names = "spdif_interrupt";
-		interrupt-parent = <&gic>;
-		interrupts = <0 91 4>;
-		reg = <0x0 0x80010000 0x0 0x10000>;
-		xlnx,spdif-mode = <1>;
-		xlnx,aud_clk_i = <49152913>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml b/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
new file mode 100644
index 000000000000..ef89fe05d745
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xlnx,spdif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx SPDIF IP
+
+description: |
+  The IP supports playback and capture of SPDIF audio.
+
+maintainers:
+  - Vincenzo Frascino <vincenzo.frascino@arm.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - xlnx,spdif-2.0
+
+  reg:
+    minItems: 1
+    maxItems: 4
+    description: |
+      Base address and size of the IP core instance.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
+    description: |
+      Names specified to list of interrupts in same order mentioned under
+      "interrupts".
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
+  xlnx,spdif-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0
+      - 1
+    description: |
+      0 - receiver
+      1 - transmitter
+
+  xlnx,aud_clk_i:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Input audio clock value.
+
+required:
+  - compatible
+  - reg
+  - interrupt-names
+  - interrupts
+  - clock-names
+  - clocks
+
+additionalProperties: true
+
+examples:
+  - |
+    spdif_0: spdif@80010000 {
+      clock-names = "aud_clk_i", "s_axi_aclk";
+      clocks = <&misc_clk_0>, <&clk 71>;
+      compatible = "xlnx,spdif-2.0";
+      interrupt-names = "spdif_interrupt";
+      interrupt-parent = <&gic>;
+      interrupts = <0 91 4>;
+      reg = <0x0 0x80010000 0x0 0x10000>;
+      xlnx,spdif-mode = <1>;
+      xlnx,aud_clk_i = <49152913>;
+    };
+
+...
-- 
2.43.0


