Return-Path: <linux-kernel+bounces-211765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A99A290568B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433C6B28941
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDFB17FABB;
	Wed, 12 Jun 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HZUtami8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FC17A931;
	Wed, 12 Jun 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205040; cv=none; b=AVDuYJwODerTyNxOf4Z+RXctnroVaDJqL4auBFhMwFDgIJN9vpxullwKbJFGrSglB86fwwZS62LrOhlp6bxuRuwfuFrgCiNHfaJRK4KdAETr4fzTPH3OE43uQ1nMKcxXUUuGQGMYmcdE3WMkHW5wMUlIGqbnJ7FPhPrKapZBd/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205040; c=relaxed/simple;
	bh=08X+8GVT+TiFiZvVfHbVgUCyb01zFog3sj0t9IBoQcQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VnyjQOdIK7HpKgvzH7mikjRyxSY+Dn8XVaNpwvwl2U6gd5ik1sb9n+p7b1xVrIyIPQi/MbjMWPatYs9mqPGPwu8BKkQx8Cj/9SWsKOdLmihYLQ4xo/UtGFeRJV4N2zX4G0EixddyDph3ZVPh4jxBd2IO1KQHruSLfUOQPkwfjzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HZUtami8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CFAOcW112956;
	Wed, 12 Jun 2024 10:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718205024;
	bh=l2S0IDfKuLt9bQulBhVNfq3zB4+JOecc8rEkeL+2prs=;
	h=From:To:CC:Subject:Date;
	b=HZUtami8i93fZrX2XFoz/LEwbg9pXs1cyP4fyNyjyaB+QMHRcs18C3QTJIo/0R68B
	 gxeRfwcmFw8+aKrpfvpm6cfpm6j121aDd8WKYTsh2HorYDp+iHftijs+oJj6ARpSq7
	 3+bHrmNY9PlC6Km0UjujkbEriErVv/b51wapRSVk=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CFAO4O130047
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 10:10:24 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 10:10:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 10:10:24 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CFAOG2099675;
	Wed, 12 Jun 2024 10:10:24 -0500
From: Andrew Davis <afd@ti.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH] dt-bindings: interrupt-controller: lsi,zevio-intc: convert to YAML
Date: Wed, 12 Jun 2024 10:10:23 -0500
Message-ID: <20240612151023.27187-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Convert Zevio interrupt controller bindings to DT schema.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../interrupt-controller/lsi,zevio-intc.txt   | 18 --------
 .../interrupt-controller/lsi,zevio-intc.yaml  | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/lsi,zevio-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/lsi,zevio-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/lsi,zevio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/lsi,zevio-intc.txt
deleted file mode 100644
index aee38e7c13e7d..0000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/lsi,zevio-intc.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-TI-NSPIRE interrupt controller
-
-Required properties:
-- compatible: Compatible property value should be "lsi,zevio-intc".
-
-- reg: Physical base address of the controller and length of memory mapped
-	region.
-
-- interrupt-controller : Identifies the node as an interrupt controller
-
-Example:
-
-interrupt-controller {
-	compatible = "lsi,zevio-intc";
-	interrupt-controller;
-	reg = <0xDC000000 0x1000>;
-	#interrupt-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/lsi,zevio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/lsi,zevio-intc.yaml
new file mode 100644
index 0000000000000..2b77d84ddae17
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/lsi,zevio-intc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/lsi,zevio-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI NSPIRE interrupt controller
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    const: lsi,zevio-intc
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#interrupt-cells"
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@dc000000 {
+        compatible = "lsi,zevio-intc";
+        reg = <0xdc000000 0x1000>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+    };
-- 
2.39.2


