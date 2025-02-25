Return-Path: <linux-kernel+bounces-530850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4921CA4394B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A539E3B0A42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472CB26657F;
	Tue, 25 Feb 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SUsScpCU"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90742266188;
	Tue, 25 Feb 2025 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474924; cv=none; b=kf1MaFbScjbwUOPRKR/B2m7cgUzQLyPi5bVtkNycrUuDOYkxQECa7CW3W+Rgx2RGmTGaEaCgDoPr9On8Nhs2f0URYcQbnG3l5ItgEgcZJz9cV3Uq5JugHb9RnMal2bW91Bk6dMPsd4wqEm/RRMWt+tRHBzhN2EGFKjRhSwNb1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474924; c=relaxed/simple;
	bh=h0vqqt1ua47j4kAk66xx/6qi0qu4jn52FFohCRkEja4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qD+Pc9eBfJT0KDSH7YEPihd/oPAwoA6NsFFihJTLlxtO2QA03W4Pl7nu0FTCa7kpG0OCT8TYnROwLjkOtAl5/Qczk9h/CRhJ3gAI9VpBfmmtArGFTkcE7wBD86aw/4rIhsgH4IUR+yILXa3p8Z+YjQrpVz0JZrtr6tQG69vXKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SUsScpCU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8Axc3014531;
	Tue, 25 Feb 2025 04:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6PUoa
	EmWn/mjHqFZuB+SD1P3YFtjCZeUHkBWLl0cVdI=; b=SUsScpCUG7kpBV/Hdyb39
	ts/694Z8H3diFY2Sd0rlp/UNnTfQEy+xzS+1KemthEKKOFpL0x25z8Y1Ob+zaN/Q
	KT7IdbL5O0wl9kAPrNqf4PFPugAy7wqYvlvkbvAfyQbIlUf3uxbrHFvSHA8lEFP2
	rWOOVoJuq3D/fRSUlAiSDWzphDU6A0Dz+KOw6nFT2ayi0o6hh9hGkr/so/KNpHny
	apFc8EBjEC96aHtGan1aCDLNvb0Kj+zKZZNZKZ63KJBxvhHE+dYKOm2o1F4fAW1w
	jv/G63T+WwMeH0/agM0+W3r2jo49gHFcmz1FwJs6lUOC0nxndatb562beB0bNm6i
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 451a4kra85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 04:15:07 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51P9F6oK033346
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Feb 2025 04:15:06 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 25 Feb
 2025 04:15:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 25 Feb 2025 04:15:06 -0500
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.116.45.25])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51P9Eof9011564;
	Tue, 25 Feb 2025 04:14:58 -0500
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Tue, 25 Feb 2025 17:08:33 +0800
Subject: [PATCH 1/2] dt-bindings: regulator: add adi,adp5055-regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250225-upstream-adp5055-v1-1-a5a7f8e46986@analog.com>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
In-Reply-To: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740474891; l=8103;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=h0vqqt1ua47j4kAk66xx/6qi0qu4jn52FFohCRkEja4=;
 b=Xn3rfiXeJsjyEeFbk0aj06GhCeEd7luLo+msdPZ5Kh3Jtu/KTwxsxZFfYHiMBZjiiK3pyRD3+
 iiXmSW3S9PGCFddeNnoUdibW6svX08hbcUbJ5eEWNW8W9BbuDhyrsn8
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ldIRVjbtu54jhhvxzTp6Nf_ej-En85Jd
X-Authority-Analysis: v=2.4 cv=cK4askeN c=1 sm=1 tr=0 ts=67bd8a1b cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=u7U2QtmpIHLnvIsJR1wA:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: ldIRVjbtu54jhhvxzTp6Nf_ej-En85Jd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250063

Add documentation for devicetree bindings for ADP5055. The device consists
of 3 buck regulators able to connect to high input voltages of up to 18V
with no preregulators.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
 .../bindings/regulator/adi,adp5055-regulator.yaml  | 214 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 220 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..52cebfd48b3c4cf4ecf16b660c204c38c94e0eec
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml
@@ -0,0 +1,214 @@
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
+      adi,power-saving-mode:
+        description:
+          If present, enables power saving mode for
+          individual channels.
+        type: boolean
+
+      adi,output-discharge-function:
+        description:
+          If present, enable output discharge functionality
+          for individual channels.
+        type: boolean
+
+      adi,disable-delay-us:
+        description:
+          Configures the disable delay for each channel. Dependent on Tset.
+        enum: [0, 5200, 10400, 15600, 20800, 26000, 31200, 36400]
+        default: 0
+
+      adi,enable-delay-us:
+        description:
+          Configures the disable delay for each channel. Dependent on Tset.
+        enum: [0, 2600, 5200, 7800, 10400, 13000, 15600, 18200]
+        default: 0
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
+      - reg
+
+allOf:
+  - $ref: regulator.yaml#
+
+  - if:
+      properties:
+        adi,tset-us:
+          contains:
+            enum:
+              - 20800
+    then:
+      properties:
+        adi,disable-delay-us:
+          enum: [0, 41600, 83200, 124800, 166400, 208000, 249600, 291200]
+
+        adi,enable-delay-us:
+          enum: [0, 20800, 41600, 62400, 83200, 104000, 124800, 145600]
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
+            channel@0 {
+                reg = <0>;
+                adi,power-saving-mode;
+                adi,output-discharge-function;
+                adi,disable-delay-us = <0>;
+                adi,enable-delay-us = <0>;
+                adi,dvs-limit-upper-microvolt = <192000>;
+                adi,dvs-limit-lower-microvolt = <(-190500)>;
+                adi,fast-transient = "5G_2.5%";
+                adi,mask-power-good;
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,power-saving-mode;
+                adi,output-discharge-function;
+                adi,disable-delay-us = <0>;
+                adi,enable-delay-us = <0>;
+                adi,dvs-limit-upper-microvolt = <192000>;
+                adi,dvs-limit-lower-microvolt = <(-190500)>;
+                adi,fast-transient = "5G_2.5%";
+                adi,mask-power-good;
+            };
+
+            channel@2 {
+                reg = <2>;
+                adi,power-saving-mode;
+                adi,output-discharge-function;
+                adi,disable-delay-us = <0>;
+                adi,enable-delay-us = <0>;
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


