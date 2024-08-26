Return-Path: <linux-kernel+bounces-302283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C708B95FC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643C6B21176
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C10E19D880;
	Mon, 26 Aug 2024 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="GOVQzMZd"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5E129E93
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709014; cv=none; b=bmT1EWr9S3BjLKDNo9UWvkhwM/b0yl2coer07byp0J3i3qlP6DQTKxYAvU+sBnj/7Ej4Hh3mNQo3GYGLUgstSLoGMLWvE5fQoAgZLmoMOY9vawfmbi0VzdYGsKu7kd/PgxSLy73pl4QA7A00Pk+IenATAFlAiCPPomlX9NUzDzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709014; c=relaxed/simple;
	bh=qdq5vGiiOybA24Cm3w+q2RH2ru9lwvmnTnhPBbu3xsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r020iwYREP/ID7OuJypwAHC99k81al3EsRFzswZ9Y5Z/CpoS3iPaFQbUlEWHXESh8ZWOyALR5jT1jQrtWmQv8Bb9fNT8ClSwobxJH6rvl95uIA0Xr+HX1EHzuW130SO0fiFkCpu7/6jEw9Z0PGJ4zX6CIk2/OqFEfd4uhrrASAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=GOVQzMZd; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202408262150098bb5a2585f1f40120a
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Aug 2024 23:50:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bWPNoWMVESBUTCke6xVnHcukgvVbb6weNuBU8N9F0/o=;
 b=GOVQzMZdmdG67wFXtsmGmM+ufZPaA8JGnjEeof29m9MHNttf3rU0QxZk8bkvM+LL2KDOdR
 xbfSNrjFq0jAXHL7LqJW4U552/VqCMg0sLCgYgOHzCfKbaTUqEhbLwKgWOPtXaxOI8gUteZR
 qjkIcXpC4mjpFUTiRw5/T6gr+yg+RKFzxPxPxaNVsZKswaQc2nhSDVbFW226vISkbZUBSs44
 7s6hNPJVbYyswLWvRt7YjAmXlcP1bxQGb7cLJjwj2VFjj50nS/GytwRTUvle4LEZoxPHXUex
 qEt1CBR61u9264kNGbscGxt4xVrLyr5ZDjMGsIdR3vAWCD9ZMchX8WOA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v2 1/6] dt-bindings: soc: ti: Add AM65 peripheral virtualization unit
Date: Mon, 26 Aug 2024 23:50:02 +0200
Message-ID: <a167791956834ca40c39acde8a55a1de41809b36.1724709007.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1724709007.git.jan.kiszka@siemens.com>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

The PVU allows to define a limited set of mappings for incoming DMA
requests to the system memory. It is not a real IOMMU, thus hooked up
under the TI SoC bindings.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../bindings/soc/ti/ti,am654-pvu.yaml         | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
new file mode 100644
index 000000000000..fd0f86fa27b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-pvu.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) Siemens AG, 2024
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ti/ti,am654-pvu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM654 Peripheral Virtualization Unit
+
+maintainers:
+  - Jan Kiszka <jan.kiszka@siemens.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,am654-pvu
+
+  reg:
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: tlbif
+
+  interrupts:
+    items:
+      - description: fault interrupt
+
+  interrupt-names:
+    items:
+      - const: pvu
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    ti-pvu@30f80000 {
+        compatible = "ti,am654-pvu";
+        reg = <0x30f80000 0x1000>,
+              <0x36000000 0x100000>;
+        reg-names = "cfg", "tlbif";
+        interrupts-extended = <&intr_main_navss 390>;
+        interrupt-names = "pvu";
+    };
-- 
2.43.0


