Return-Path: <linux-kernel+bounces-424777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BB19DB93E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D815F163BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201BE1AE01F;
	Thu, 28 Nov 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mma1VoFv"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09421AA786;
	Thu, 28 Nov 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802922; cv=none; b=kqIub2RLeAdA4HTrJy6olagVE54hXk8iAeVZg3p93277IK49Skh37yHu4e8/Rf5IJQ2uXEkXZna5DYoa4btjBWLfSy3AcarlS0WYoa3mF79hkpz7BglkgOD9sfquuhzWxm4IyzjGr/MvWRn95iSclEFUqZl4UtuXLI9Ufv+TyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802922; c=relaxed/simple;
	bh=RXl8EqCZPi7360lIjPBNSmoOmPR60Q+j6pNqrqDb6NE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgV8rN4gR7iC+uhOpbYI1ScXX/8F+e9Iy+ZqY68P6OXNs7IMbamvqkB+UdHVMeswufjAd7LbWr+hKqEy/TH03eGyxQ6MD2JJTcvncozpv/HPcDIkB5Qq6dQmANEwzcikYl12sGcF7PwNVnYYhBLj40cFJKhBW0UtwrNF0+i94wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mma1VoFv; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ASE8Y2Y1171260
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 08:08:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732802914;
	bh=DEqsPZvCDv6fZXTIc5Sjc+0RGxvXQb4IPrR1wEGEkGg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Mma1VoFvfoyiQ7mc3d7kDS/wHTAJMVOs698qQ5Pvk/rMDvaYLSWWJUWwsqHiQNPhZ
	 g4hEYmUsL/O2oXjDQGkt0z7sn/4QdS2jvUHfVhqWB/XqDIATzMAo+7y9Cu8s3hcqOJ
	 xeeADVIvOcGPVxXFW+yC88bV5jkxv2iF9jOINKoE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ASE8YhD013206
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Nov 2024 08:08:34 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Nov 2024 08:08:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Nov 2024 08:08:33 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ASE8Qce019782;
	Thu, 28 Nov 2024 08:08:30 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 1/2] dt-bindings: misc: bist: Add BIST dt-binding for TI K3 devices
Date: Thu, 28 Nov 2024 19:38:24 +0530
Message-ID: <20241128140825.263216-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128140825.263216-1-n-francis@ti.com>
References: <20241128140825.263216-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Document the binding for TI K3 BIST (Built-In Self Test) block.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 .../bindings/misc/ti,j784s4-bist.yaml         | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml

diff --git a/Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml b/Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml
new file mode 100644
index 000000000000..bd1b42734b3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/ti,j784s4-bist.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/ti,j784s4-bist.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments K3 BIST
+
+maintainers:
+  - Neha Malcom Francis <n-francis@ti.com>
+
+description:
+  The BIST (Built-In Self Test) module is an IP block present in K3 devices
+  that support triggering of BIST tests, both PBIST (Memory BIST) and LBIST
+  (Logic BIST) on a core. Both tests are destructive in nature. At boot, BIST
+  is executed by hardware for the MCU domain automatically as part of HW POST.
+
+properties:
+  compatible:
+    const: ti,j784s4-bist
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: ctrl_mmr
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  ti,bist-instance:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      the BIST instance in the SoC represented as an integer
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - ti,bist-instance
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        bist@33c0000 {
+            compatible = "ti,j784s4-bist";
+            reg = <0x00 0x033c0000 0x00 0x400>,
+            <0x00 0x0010c1a0 0x00 0x01c>;
+            reg-names = "cfg", "ctrl_mmr";
+            clocks = <&k3_clks 237 7>;
+            power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>;
+            ti,bist-instance = <14>;
+        };
+    };
-- 
2.34.1


