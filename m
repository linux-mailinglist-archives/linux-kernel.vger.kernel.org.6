Return-Path: <linux-kernel+bounces-381634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBAA9B01D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17291F22EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE0203700;
	Fri, 25 Oct 2024 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z1y05CC0"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94520263F;
	Fri, 25 Oct 2024 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857667; cv=none; b=au94vUe36sAyqt5dQx/lbU0QE0pj/CctPIxmhsGDuFQofw3F1eEX+o7N2RcqVoXegDxERcrq0GEUx2zFUDZsMxzWW+Vfo2YdiCVfRdJyzqR1AZ50Ys1/AMAMGt3aRYVDdSX5zRBydZ2RXKBANqfD7CjM3xCosfI5uzfZcKfGBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857667; c=relaxed/simple;
	bh=/DGqcREFzcBJ9qhC2Ai7dj0AJKvQ1eSIUwTQkscnemg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFidlCsXMkIYEbw1G8iBkq1MgFQrxGPmCVhe2/ahtSNlvebhmE8gfbb+DM1TMGQ9OeeJ6PLY1uAQ9o/5VIOd785Xu0YKfbeaGO0QZaTHLXNX988SyuBgJ/aYaDSshVLDOzCiahu+g38Q1jOQKmBmWU8HnHOsHLHl7z/bd9UwBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z1y05CC0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P7kPih029237;
	Fri, 25 Oct 2024 08:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VA6Ba
	td+/cCbvxMvsU1gH6OGA/pDDUOfb7zQs15Digo=; b=z1y05CC04DrwKV+M2lmb2
	hD/Z8oESWYQpXfXLpCZ4SJEdtdxx51OtwCRfjkv+jetG+yYsGLUVScUDjhoI80xW
	4zs61c+werIDfkkatWVjz77exMZiN+w3na5MCK4BFE02JVV7/BNVrHG0SU+K5Qdw
	4w5dhwTx2cHplqxO62viuE9iep5zhdEIwjPWkmfD0e4NzFhdCChX7Kro2FJVJTAn
	QMHn2/NVzUebs38fetbrBfreHQFTH/YRDJsFqXx6+BnueHvjlghb2qtwE+R30NNi
	5TKUb3m7PQHVQdOY2H4RmGPB/lTfID78k6mz1JCLRGkrOJzLTKHnpOXlfoSLtSDL
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42fjqqp1u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 08:00:49 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49PC0mbm045692
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Oct 2024 08:00:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 25 Oct
 2024 08:00:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Oct 2024 08:00:47 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.117])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49PC0XRt016585;
	Fri, 25 Oct 2024 08:00:44 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: hwmon: add ltc4296-1 support
Date: Fri, 25 Oct 2024 14:56:10 +0300
Message-ID: <20241025115624.21835-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241025115624.21835-1-antoniu.miclaus@analog.com>
References: <20241025115624.21835-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: qdNE4s0MHzKbX981D_0e3ShKgi-3f7a1
X-Proofpoint-ORIG-GUID: qdNE4s0MHzKbX981D_0e3ShKgi-3f7a1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250092

Add devicetree bindings for the ltc4296-1 device.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/hwmon/adi,ltc4296-1.yaml         | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc4296-1.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc4296-1.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc4296-1.yaml
new file mode 100644
index 000000000000..be73d59a7d65
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,ltc4296-1.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/adi,ltc4296-1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LTC4296-1 5-Port SPoE PSE Controller
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  The LTC4296-1 is an IEEE 802.3cg-compliant, five port, single-pair
+  power over Ethernet (SPoE), power sourcing equipment (PSE)
+  controller. SPoE simplifies system design and installation with
+  standardized power and Ethernet data over a single-pair cable.
+
+  Datasheet:
+    https://www.analog.com/en/products/ltc4296-1.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: adi,ltc4296-1
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  vin-supply: true
+
+patternProperties:
+  "^channel@[0-3]$":
+    type: object
+    description:
+      Represents the current monitoring channels.
+
+    properties:
+      reg:
+        description:
+          The channel number. ltc4296-1 can monitor 5 currents.
+        items:
+          minimum: 0
+          maximum: 4
+
+      shunt-resistor-micro-ohms:
+        description:
+          The value of curent sense resistor in micro ohms.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vin-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon@0 {
+            compatible = "adi,ltc4296-1";
+            reg = <0x0>;
+            vin-supply = <&vcc>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            compatible = "adi,ltc4296-1";
+            reg = <0x0>;
+            vin-supply = <&vin>;
+
+            channel@0 {
+                    reg = <0x0>;
+                    shunt-resistor-micro-ohms = <100000>;
+            };
+
+            channel@1 {
+                    reg = <0x1>;
+                    shunt-resistor-micro-ohms = <100000>;
+            };
+        };
+    };
+...
-- 
2.46.2


