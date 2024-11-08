Return-Path: <linux-kernel+bounces-401373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D287C9C195B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28CAEB20E86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8431E1C06;
	Fri,  8 Nov 2024 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VHXV4YOj"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5F1E104F;
	Fri,  8 Nov 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058581; cv=none; b=ATMRdjNz2ZdIvbn8LiNiAHfi+X4P1nkj8dQ3OpT/MoeWNygf8CQSnnMiQqU8pi1dqhAw8dClnVvxP+eH+Lg5iblWP1VfviYZUSUF7lS+kqYf9QTpObSDubQNFl+Y/RABhqeJ4pDY2qAUGzih0amJ9ccxfyTsaBDcZ+BSpfxYEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058581; c=relaxed/simple;
	bh=A3gC+P24+8qi6Vc0ExzW4+pAXiESMqB05sankcod3CY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzUHRUVaJBxfFgLUexbNdrVeYfhO2D0JEzvgGnlJjx5KddL6cd+QaF9Dz64xGunASAjDBcxDYZgGXbYE9oA9aYcjAD04Smv+JgnbeYk54brS0YcvJ4zL6SVVe2/dVnAUxHmFJb+PRJH3JugiZHAYolZkZGZ4TVbLXuKcN99JTfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VHXV4YOj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A89Ff2A020246;
	Fri, 8 Nov 2024 04:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RWsix
	emNIwSNlZfpIJcWwocKtYWMFXnmAQqOQ7nLX8E=; b=VHXV4YOjBI4mMtY9JpGMh
	ksaC1vSamwezB/hTZyP+SXg9vlwo7YLQmE+irkiKogeB3CBUfwujeZyKHA5bgqb5
	7ETIs1QNJf8FMwCX579ZcGYMQyPJamJe1GFP6bX+NLZualI3j6dRcONMfF6Rqci/
	xZ4ypU5ol+5UEL+ekiGCV5OI6SH2GAky52eAsIFqc1uG4NKW78ToYzhrOTbCUfII
	9oZV9CN5QYHpJerMWibFXyLhngUvtm7SAkSGMNky91O/mFjq9kQ5aLHQpLm5rQW4
	cIXZ/uBOVUh7ctGy3/CwgLdJrLPqI0SJoz4m1Oe8RcmRGYbrdsZcIk45PabXTcoq
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42s6g7jjmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 04:36:10 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A89a80L034355
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 04:36:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 8 Nov 2024
 04:36:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 8 Nov 2024 04:36:08 -0500
Received: from RCALAM-L02.ad.analog.com (RCALAM-L02.ad.analog.com [10.117.222.43])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A89Zn5O026842;
	Fri, 8 Nov 2024 04:35:59 -0500
From: "Ramon Cristopher M. Calam" <ramoncristopher.calam@analog.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Cristopher Calam
	<ramoncristopher.calam@analog.com>
Subject: [PATCH 2/2] dt-bindings: regulator: Add adi,lt8722-regulator.yaml
Date: Fri, 8 Nov 2024 17:35:44 +0800
Message-ID: <20241108093544.9492-3-ramoncristopher.calam@analog.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
References: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: bdDCDP8lp0zmUmI2-UgSlUpLIEO0YcEk
X-Proofpoint-GUID: bdDCDP8lp0zmUmI2-UgSlUpLIEO0YcEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080078

Add documentation for device tree bindings of LT8722.

Signed-off-by: Ramon Cristopher M. Calam <ramoncristopher.calam@analog.com>
---
 .../regulator/adi,lt8722-regulator.yaml       | 178 ++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml
new file mode 100644
index 000000000000..3fbf788d4154
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2023 Analog Devices, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/adi,lt8722-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LT8722 Ultracompact Full Bridge Driver
+
+maintainers:
+  - Ramon Cristopher Calam <ramoncristopher.calam@analog.com>
+
+description: |
+  The Analog Devices LT8722 is a high performance, high efficiency, 15V input,
+  4A monolithic full bridge DC/DC converter. This converter has 92.5% efficiency
+  with high power output of 54W for fine control TEC driving applications.
+
+properties:
+  compatible:
+    enum:
+      - adi,lt8722
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description:
+      This pin in used together with the ENABLE_REQ bit in the SPIS_COMMAND
+      register to set the state of LT8722. When both the ENABLE_REQ bit and
+      the enable GPIO are low, LT8722 is in shutdown mode. When either the
+      ENABLE_REQ bit or the enable GPIO is high, LT8722 is active and the
+      internal VCC LDO regulator is enabled. The enable GPIO is active high.
+    maxItems: 1
+
+  switch-enable-gpios:
+    description:
+      This pin is used together with the SWEN_REG bit in the SPIS_COMMAND
+      register to set the PWM switching behavior of LT8722. When both the
+      SWEN_REG bit and the switch enable GPIO are low, LT8722 PWM switching
+      is disabled. When both the SWEN_REG bit and the switch enable GPIO are
+      high, LT8722 PWM switching is enabled. The switch enable GPIO is active
+      high.
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 10000000
+
+  adi,uv-clamp-microvolt:
+    description: Maximum negative output voltage clamp in microvolts.
+    enum: [
+      -20000000,
+      -18750000,
+      -17500000,
+      -16250000,
+      -15000000,
+      -13750000,
+      -12500000,
+      -11250000,
+      -10000000,
+      -8750000,
+      -7500000,
+      -6250000,
+      -5000000,
+      -3750000,
+      -2500000,
+      -1250000
+    ]
+    default: -20000000
+
+  adi,ov-clamp-microvolt:
+    description: Maximum positive output voltage clamp in microvolts.
+    enum: [
+      1250000,
+      2500000,
+      3750000,
+      5000000,
+      6250000,
+      7500000,
+      8750000,
+      10000000,
+      11250000,
+      12500000,
+      13750000,
+      15000000,
+      16250000,
+      17500000,
+      18750000,
+      20000000
+    ]
+    default: 20000000
+
+  adi,ilimn-microamp:
+    description: Maximum negative output current limit in microamps.
+    minimum: -6786000
+    maximum: -637440
+    default: -6786000
+
+  adi,ilimp-microamp:
+    description: Maximum positive output current limit in microamps.
+    minimum: 637440
+    maximum: 6800000
+    default: 6800000
+
+  adi,switch-frequency-hz:
+    description: PWM switch frequency.
+    enum: [500000, 1000000, 1500000, 2000000, 2500000, 3000000]
+    default: 500000
+
+  adi,switch-frequency-adjust:
+    description: PWM switch frequency adjustment.
+    enum: [0%, 15%, -15%]
+    default: 0%
+
+  adi,duty-cycle-range:
+    description: PWM duty cycle.
+    enum: [20%-80%, 15%-85%, 10%-90%]
+    default: 20%-80%
+
+  adi,vcc-vreg-millivolt:
+    description: VCC LCO regulation voltage in millivolts.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [3100, 3400]
+    default: 3400
+
+  adi,peak-inductor-current-milliamp:
+    description: Typical peak inductor current in milliamps.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [252, 594, 936, 1278, 1620, 1962, 2304, 2646]
+    default: 1620
+
+  adi,power-limit-milliwatt:
+    description: Linear power stage MOSFET power limit in milliwatts.
+    enum: [0, 2000, 3000, 3500]
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - switch-enable-gpios
+
+allOf:
+  - $ref: regulator.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@0 {
+            compatible = "adi,lt8722";
+            reg = <0>;
+            enable-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+            switch-enable-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+            spi-max-frequency = <10000000>;
+            spi-bits-per-word = <8>;
+
+            adi,uv-clamp-microvolt = <(-20000000)>;
+            adi,ov-clamp-microvolt = <20000000>;
+            adi,ilimn-microamp = <(-6786000)>;
+            adi,ilimp-microamp = <6800000>;
+            adi,switch-frequency-hz = <500000>;
+            adi,switch-frequency-adjust = "0%";
+            adi,duty-cycle-range = "20%-80%";
+            adi,vcc-vreg-millivolt = <3400>;
+            adi,peak-inductor-current-milliamp = <1620>;
+            adi,power-limit-milliwatt = <0>;
+
+            regulator-min-microvolt = <-20000000>;
+            regulator-max-microvolt = <20000000>;
+            regulator-soft-start;
+        };
+    };
-- 
2.47.0


