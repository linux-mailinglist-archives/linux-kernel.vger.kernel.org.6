Return-Path: <linux-kernel+bounces-445220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69109F12F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A482281786
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFDC1E285A;
	Fri, 13 Dec 2024 16:52:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4217DFFD;
	Fri, 13 Dec 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108769; cv=none; b=t7xRwhDhxx9lErd77sfJPrbi+AvQ5p91nGw1P6zEXlHcyoWFKwLfiUhAziV3hts6HT+DD3H/20WVVsCWb7ypelQHPEyc2Ecez1HLFzXalGD8GK1CJGp+1Uoz5gZNkN642uhkKUWqqSP7CE/em1kYF1vby1hoUeDotWL/NrxSci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108769; c=relaxed/simple;
	bh=YYHhfT6PC0hkp+ZcJ5fgrBYpO9f+zu3Zck/Y69m4S1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hg51G0Nb5xM/m7NERcIisMIRlqF0CI4/zRCLRA7fIIv2GKDg/WQgxcI3NAU/x35nul6ZfaWplGFqTjJsG8Tk5MK/m4GV0BEZ010dC50eklA0vf5gyS502V6cW7OTYz40bUAnQRos3gJazo+HpBz1Y9xq191A7iF3n0Pt16NB7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82ACB1595;
	Fri, 13 Dec 2024 08:53:14 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72ACF3F5A1;
	Fri, 13 Dec 2024 08:52:45 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincenzo.frascino@arm.com
Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 1/3] xlnx: dt-bindings: xlnx,i2s: Convert to json-schema
Date: Fri, 13 Dec 2024 16:52:38 +0000
Message-ID: <20241213165240.3652961-2-vincenzo.frascino@arm.com>
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

Convert the Xilinx I2S device tree binding documentation to json-schema.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 -------
 .../devicetree/bindings/sound/xlnx,i2s.yaml   | 79 +++++++++++++++++++
 2 files changed, 79 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml

diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
deleted file mode 100644
index 5e7c7d5bb60a..000000000000
--- a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-Device-Tree bindings for Xilinx I2S PL block
-
-The IP supports I2S based playback/capture audio
-
-Required property:
- - compatible: "xlnx,i2s-transmitter-1.0" for playback and
-	       "xlnx,i2s-receiver-1.0" for capture
-
-Required property common to both I2S playback and capture:
- - reg: Base address and size of the IP core instance.
- - xlnx,dwidth: sample data width. Can be any of 16, 24.
- - xlnx,num-channels: Number of I2S streams. Can be any of 1, 2, 3, 4.
-		      supported channels = 2 * xlnx,num-channels
-
-Example:
-
-	i2s_receiver@a0080000 {
-		compatible = "xlnx,i2s-receiver-1.0";
-		reg = <0x0 0xa0080000 0x0 0x10000>;
-		xlnx,dwidth = <0x18>;
-		xlnx,num-channels = <1>;
-	};
-	i2s_transmitter@a0090000 {
-		compatible = "xlnx,i2s-transmitter-1.0";
-		reg = <0x0 0xa0090000 0x0 0x10000>;
-		xlnx,dwidth = <0x18>;
-		xlnx,num-channels = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml b/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
new file mode 100644
index 000000000000..b8bda7c28d37
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/xlnx,i2s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Device-Tree bindings for Xilinx I2S PL block
+
+description: |
+  The IP supports I2S based playback/capture audio.
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
+    oneOf:
+      - const: xlnx,i2s-receiver-1.0
+      - const: xlnx,i2s-transmitter-1.0
+
+  reg:
+    maxItems: 1
+    description: |
+      Base address and size of the IP core instance.
+
+  "#sound-dai-cells":
+    const: 0
+
+  "#address-cells":
+    maxItems: 1
+
+  "#size-cells":
+    maxItems: 1
+
+  xlnx,dwidth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+    oneOf:
+      - const: 16
+      - const: 24
+    description: |
+      Sample data width. Can be any of 16, 24.
+
+  xlnx,num-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+    description: |
+      Number of I2S streams.
+    minimum: 1
+    maximum: 4
+
+required:
+  - compatible
+  - reg
+  - xlnx,dwidth
+  - xlnx,num-channels
+
+additionalProperties: false
+
+examples:
+  - |
+    i2s_receiver@a0080000 {
+      compatible = "xlnx,i2s-receiver-1.0";
+      reg = <0x0 0xa0080000 0x0 0x10000>;
+      xlnx,dwidth = <0x18>;
+      xlnx,num-channels = <1>;
+    };
+    i2s_transmitter@a0090000 {
+      compatible = "xlnx,i2s-transmitter-1.0";
+      reg = <0x0 0xa0090000 0x0 0x10000>;
+      xlnx,dwidth = <0x18>;
+      xlnx,num-channels = <1>;
+    };
+
+...
-- 
2.43.0


