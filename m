Return-Path: <linux-kernel+bounces-179120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D52C8C5BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B55B222E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33351836C7;
	Tue, 14 May 2024 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jPp1zOon"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E30181BB5;
	Tue, 14 May 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716494; cv=none; b=X3tvR+1scux2QxZUxGqFT/q4eXZbBkn1LgvBhJ4+v/MWc9br+a9e6SmJ+OQzvV9wGyGDO59c9Dye1VXmm3VCgLykl2ZxpY9X0Os64745YzhzhyrlThRMzg5qo0/onnN7GrhQAiNaFSg8pkDeUFwCN85XbNn9wourddFvsO/J6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716494; c=relaxed/simple;
	bh=agYXwcXjKlclaIuuk4OomHNz/udWY5UggU4ucwdyyU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RMYN2R2e2ngs5kOCAGCDXXyb1xgjJwgHLZbcOB9s/zV20Gg3YU2Gx+0cN4JLiyEcrj1L/XAk3LQA9gprz8Y2Cq6PnoLKQOb+b9QwZzd9SgAxv0z4/veFUKbheGbUOrpvX2BgP2w5ZzW3Qn6xYramTlSdnDexaWK8IpP87VCVQpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jPp1zOon; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EJsD6j026139;
	Tue, 14 May 2024 19:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=zB3qSIICbdqCzp1o85wzqyylb2WQvFU3VTcjolZGeeI=;
 b=jPp1zOonArc6pKAbe5IsFTvZgIEntwbGGQliIx4ay9ovy5+55JsGTIlYntH6+EXJ2WvW
 qEzLLaNYlx213gqEDK6T3VUl/z/QzmKF2F8Rmdpq+S7gZOdtb/FKaisoTb2PQUde/n80
 zqudh8KSzhxxfBxlK/ba7l/qUxZtbUfMuI3UHXS6TC57ldv8G4zO179WGoHcgFzSYK/1
 JrQ87nzIAFfYbBs1pq/RT8z7HOJLw3mw6iz9Eg/y9t1jfXXtE1rwOz3MdonXt2n5ZrKF
 E/rdAesjAWGAFbNys9MjtodkGxo+bJ4SPiy3XUF7pBisE5fb8KZ5fRbZ1g8wpTwPsCf1 5g== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4ctqr7gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:41 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EIf23X005981;
	Tue, 14 May 2024 19:54:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmf7dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:40 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EJsc9H50463262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 19:54:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04C6258073;
	Tue, 14 May 2024 19:54:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C509A58063;
	Tue, 14 May 2024 19:54:37 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 19:54:37 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        eajames@linux.ibm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        robh@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
Subject: [PATCH v5 7/9] dt-bindings: fsi: ast2600-fsi-master: Convert to json-schema
Date: Tue, 14 May 2024 14:54:33 -0500
Message-Id: <20240514195435.155372-8-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240514195435.155372-1-eajames@linux.ibm.com>
References: <20240514195435.155372-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0yD2jQe7oPqIUFVcsifrwjOWR5cl34wO
X-Proofpoint-ORIG-GUID: 0yD2jQe7oPqIUFVcsifrwjOWR5cl34wO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_12,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140142

Convert to json-schema for the AST2600 FSI master documentation.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v4:
 - Remove the addition of the AST2700 compatible

 .../fsi/aspeed,ast2600-fsi-master.yaml        | 80 +++++++++++++++++++
 .../bindings/fsi/fsi-master-aspeed.txt        | 36 ---------
 2 files changed, 80 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
 delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt

diff --git a/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
new file mode 100644
index 0000000000000..2f531c47994bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed FSI master
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  The AST2600 and later contain two identical FSI masters. They share a
+  clock and have a separate interrupt line and output pins.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-fsi-master
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  cfam-reset-gpios:
+    maxItems: 1
+    description:
+      Output GPIO pin for CFAM reset
+
+  fsi-routing-gpios:
+    maxItems: 1
+    description:
+      Output GPIO pin for setting the FSI mux (internal or cabled)
+
+  fsi-mux-gpios:
+    maxItems: 1
+    description:
+      Input GPIO pin for detecting the desired FSI mux state
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+allOf:
+  - $ref: fsi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    #include <dt-bindings/gpio/aspeed-gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    fsi-master@1e79b000 {
+        compatible = "aspeed,ast2600-fsi-master";
+        reg = <0x1e79b000 0x94>;
+        #address-cells = <2>;
+        #size-cells = <0>;
+        interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_fsi1_default>;
+        clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
+        fsi-routing-gpios = <&gpio0 ASPEED_GPIO(Q, 7) GPIO_ACTIVE_HIGH>;
+        fsi-mux-gpios = <&gpio0 ASPEED_GPIO(B, 0) GPIO_ACTIVE_HIGH>;
+        cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
+
+        cfam@0,0 {
+            reg = <0 0>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            chip-id = <0>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
deleted file mode 100644
index 9853fefff5d83..0000000000000
--- a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Device-tree bindings for AST2600 FSI master
--------------------------------------------
-
-The AST2600 contains two identical FSI masters. They share a clock and have a
-separate interrupt line and output pins.
-
-Required properties:
- - compatible: "aspeed,ast2600-fsi-master"
- - reg: base address and length
- - clocks: phandle and clock number
- - interrupts: platform dependent interrupt description
- - pinctrl-0: phandle to pinctrl node
- - pinctrl-names: pinctrl state
-
-Optional properties:
- - cfam-reset-gpios: GPIO for CFAM reset
-
- - fsi-routing-gpios: GPIO for setting the FSI mux (internal or cabled)
- - fsi-mux-gpios: GPIO for detecting the desired FSI mux state
-
-
-Examples:
-
-    fsi-master {
-        compatible = "aspeed,ast2600-fsi-master", "fsi-master";
-        reg = <0x1e79b000 0x94>;
-	interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_fsi1_default>;
-	clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
-
-	fsi-routing-gpios = <&gpio0 ASPEED_GPIO(Q, 7) GPIO_ACTIVE_HIGH>;
-	fsi-mux-gpios = <&gpio0 ASPEED_GPIO(B, 0) GPIO_ACTIVE_HIGH>;
-
-	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
-    };
-- 
2.39.3


