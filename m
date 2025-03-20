Return-Path: <linux-kernel+bounces-569212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FEA69FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B823BD24F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB12E1EF395;
	Thu, 20 Mar 2025 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rCkmbkl8"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD01581F0;
	Thu, 20 Mar 2025 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742453678; cv=none; b=anZlZD71n82URXRFyroREhoIVuXP4rVG0dOm89SgK5QP16AdFbQwBvnwUUyKbEoonhAy/+0wpmvFyp/8hlFhzRh0XUqAxWxA+cjGzZqmWfq5++9bjfAVDJQsCOWcJcozXEelpnFWt5hkqjWO6G3OIonRnlrCYrLAyBKeV2FZTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742453678; c=relaxed/simple;
	bh=pLTaIzxvTXRJwy4UBqo67Zydra9iu2BHEuFVLcQXhMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gKNjPILMGPDMoWMMCIdRNX/EhjZjtQqopc3PMJeYF6i7jRzwXzX9aq/oX8rM62SoJH7DY3QP1/Ds+vkgrSqOhZogKifQlBwkFyWJVwHihsAoPRfAOWlENASXtM7A5SQapTegLn47LuUcU8bxbu1dZ+CZEYdgZg/ct2wewR4py5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rCkmbkl8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K2oEUV030651;
	Thu, 20 Mar 2025 02:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FU+gl
	ZkR+oAHX5ozoZIUyyeks3VsNltLbVTFMmkxIJQ=; b=rCkmbkl8Bm5rJ7U5ApspF
	xecKclXy55zTts6jvnsUIHE0UmTUCl13PRRCBc2OvyUoH7S9mGrvXZ2vorOBs5rJ
	Z6hJ2PnAlxYzxLFwMkxmJya0QUk7fE8q4ZlsN21/2ADruR6zwJGLG624a5qcZfBM
	z7bCZrdP3e1mOMnTIYCbs7xdjGjFKZWtGnYa+dvyW4N1LOiA1NrBJMZiitb5vGyi
	crLJN9u31dAisDX6oFmww7vR0KThU10cW5/7ofI2CN48uohOMq31//u7FwKF0FyT
	fJ2Rmbb6H2/AMT2OXnDxrCFIcSPDeLXZFODTCZ2rqZeVsqBKUmgJnUiA0EZFDX6I
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45fwvmmxp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 02:54:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52K6sONY060176
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Mar 2025 02:54:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 20 Mar
 2025 02:54:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 20 Mar 2025 02:54:23 -0400
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.117.223.3])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52K6s5eo006548;
	Thu, 20 Mar 2025 02:54:12 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Thu, 20 Mar 2025 14:53:54 +0800
Subject: [PATCH v2 1/2] dt-bindings: regulator: add adi,adp5055-regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250320-upstream-adp5055-v2-1-aac2d3705802@analog.com>
References: <20250320-upstream-adp5055-v2-0-aac2d3705802@analog.com>
In-Reply-To: <20250320-upstream-adp5055-v2-0-aac2d3705802@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Alexis
 Czezar Torreno <alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742453645; l=6395;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=pLTaIzxvTXRJwy4UBqo67Zydra9iu2BHEuFVLcQXhMk=;
 b=/MjC6ARjdBkcOyDVv9r+kIj47v1B2pBhS05CfFCrSkGD7S1otZ8zRIKyboBnNS9EVzp58zubw
 tchov6jDumWALpWp8tp+WM40hrfqo8MmrQ2uuKMLCE45T8stSukSN0N
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: sqSUl2FeIqqfiFjpjg6azLGNnjJr1Hr8
X-Authority-Analysis: v=2.4 cv=J5+q7BnS c=1 sm=1 tr=0 ts=67dbbba1 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=LYgrlvm2vjqWaEuYVCwA:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: sqSUl2FeIqqfiFjpjg6azLGNnjJr1Hr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_02,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200042

Add documentation for devicetree bindings for ADP5055. The device consists
of 3 buck regulators able to connect to high input voltages of up to 18V
with no preregulators.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
 .../bindings/regulator/adi,adp5055-regulator.yaml  | 161 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 167 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..fc8f1e61ba321f8b4c6f8c1e3d0e91d570fb4953
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/adi,adp5055-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADP5055 Triple Buck Regulator
+
+maintainers:
+  - Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
+
+description: |
+  The ADP5055 combines three high performance buck regulators.
+  The device enables direct connection to high input voltages
+  up to 18 V with no preregulators.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adp5055.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adp5055
+
+  reg:
+    enum:
+      - 0x70
+      - 0x71
+
+  adi,tset-us:
+    description:
+      Setting time used by the device. This is changed via soldering
+      specific resistor values on the CFG2 pin.
+    enum: [2600, 20800]
+    default: 2600
+
+  adi,hw-en-array-gpios:
+    description:
+      Asserted during driver probe. Each array entry acts as the
+      hardware enable for channels 0-2. Should be marked 0 for active
+      low. Requires all three channels to be initialized. Not adding
+      the property turns the system to a software only enable mode.
+    minItems: 3
+    maxItems: 3
+
+  adi,ocp-blanking:
+    description:
+      If present, the over current protection
+      blanking (OCP) for all channels is on.
+    type: boolean
+
+  adi,delay-power-good:
+    description:
+      Configures delay timer of the power good (PWRGD) pin.
+      Delay is based on Tset which can be 2.6 ms or 20.8 ms.
+    type: boolean
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@([0-2])$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        description: The channel number representing each buck converter.
+        maximum: 2
+
+      adi,dvs-limit-upper-microvolt:
+        description:
+          Configure the allowable upper side limit of the
+          voltage output of each channel in microvolt.
+          Voltages are in 12mV steps, value is autoadjusted.
+          Vout_high = Vout + DVS_upper_limit.
+        minimum: 12000
+        maximum: 192000
+        default: 192000
+
+      adi,dvs-limit-lower-microvolt:
+        description:
+          Configure the allowable lower side limit of the
+          voltage output of each channel in microvolt.
+          Voltages are in 12mV steps, value is autoadjusted.
+          Vout_low = Vout + DVS_lower_limit.
+        minimum: -190500
+        maximum: -10500
+        default: -190500
+
+      adi,fast-transient:
+        description:
+          Configures the fast transient sensitivity for each channel.
+          "none"    - No fast transient.
+          "3G_1.5%" - 1.5% window with 3*350uA/V
+          "5G_1.5%" - 1.5% window with 5*350uA/V
+          "5G_2.5%" - 2.5% window with 5*350uA/V
+        enum: [none, 3G_1.5%, 5G_1.5%, 5G_2.5%]
+        default: 5G_2.5%
+
+      adi,mask-power-good:
+        description:
+          If present, masks individual channels to the external
+          PWRGD hardware pin.
+        type: boolean
+
+    required:
+      - regulator-name
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@70 {
+            compatible = "adi,adp5055";
+            reg = <0x70>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            adi,tset-us = <2600>;
+            adi,hw-en-array-gpios = <&gpio 17 0>,
+                                    <&gpio 18 0>,
+                                    <&gpio 19 0>;
+
+            adi,ocp-blanking;
+            adi,delay-power-good;
+
+            DCDC0 {
+                regulator-name = "DCDC0";
+                adi,dvs-limit-upper-microvolt = <192000>;
+                adi,dvs-limit-lower-microvolt = <(-190500)>;
+                adi,fast-transient = "5G_2.5%";
+                adi,mask-power-good;
+            };
+
+            DCDC1 {
+                regulator-name = "DCDC1";
+                adi,dvs-limit-upper-microvolt = <192000>;
+                adi,dvs-limit-lower-microvolt = <(-190500)>;
+                adi,fast-transient = "5G_2.5%";
+                adi,mask-power-good;
+            };
+
+            DCDC2 {
+                regulator-name = "DCDC2";
+                adi,dvs-limit-upper-microvolt = <192000>;
+                adi,dvs-limit-lower-microvolt = <(-190500)>;
+                adi,fast-transient = "5G_2.5%";
+                adi,mask-power-good;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa06545e2861abe46ea7029f9b4d3628e..b2ec43f84d84765c319d8403fb5650afa273db83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1525,6 +1525,12 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
 F:	drivers/iio/filter/admv8818.c
 
+ANALOG DEVICES INC ADP5055 DRIVER
+M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml
+
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-pm@vger.kernel.org

-- 
2.34.1


