Return-Path: <linux-kernel+bounces-179121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B37ED8C5BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BF31F22DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A971836F9;
	Tue, 14 May 2024 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nzDqP1Hg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52C181D19;
	Tue, 14 May 2024 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716495; cv=none; b=Ap8Q4WVyihFP4eNEqCVoB3wUquuLXZFxWq+iDrR9qi89N9xB9WZoobWrvZI2Xo/9zZy0UywTGBswbw8vLI/Dub2N2BUGbxNdhbm5SZwefmKWE0t8A0e42EVGVdeABQy2DDXY9iiNxUEfFL41taK53QTiqLZvRSNCT/0MDGIZ49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716495; c=relaxed/simple;
	bh=Qi2euXzCp5PGcQXAAb+wa2tXMspYjo5xkygMnaTRdRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KdF122KZV9Hjkk6u5ATf2NL5seOdI4x2Fm25+75I/EZ0Ei4K7MVaC1NOK+JJsa+r/JVem3bK94iy4FIjQ9/sId1L9R75PjUpqomZrZmhF31RuUfQ4uxsz18Qx56zRyltD7AqQZRn1q1jI12KwjT+rN2MrNGZmFhQQDb9xOcvlOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nzDqP1Hg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EIUBb2021066;
	Tue, 14 May 2024 19:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=wuft68RODxlOpu5pXHhFBr/uxxXbBnlditP2AYn8hy4=;
 b=nzDqP1HgKzGqx7S/wk/NzasVMvgMMXEE6Abi4RxcMBbZQNhh9i1iKFHlUnUTpDJ5Lg8E
 xbhxsd53vhrdIsh2vLpUtzve4DBlf3z6L1/IESDrSoErQXgNetFS38osy3fmr4y0Ze9i
 7y4Lwtd231pujPxcjIATY3+ZAdsLytxhpCeMEzf97ruTi7IQlXYaGwrDCICt0I9gZre7
 NsJrlUVmSWUsJGE0E+qYfMD9LoLD5IGg1Y9hlNLNKCM1K6fKypc7s1cTjZnBOCAqwKCy
 vEvXaZ9HEzMYZCr9PkrbJce54JTDVkqbhIdG5rMfBxJogYjIbDqTVfRWZ+cpP23CW/WN Hg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4d1qg73n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EHriNb020349;
	Tue, 14 May 2024 19:54:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kcyyfjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:41 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EJsdE340763676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 19:54:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75E8B5806E;
	Tue, 14 May 2024 19:54:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40B6858070;
	Tue, 14 May 2024 19:54:37 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 19:54:37 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        eajames@linux.ibm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        robh@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
Subject: [PATCH v5 5/9] dt-bindings: fsi: Document the FSI controller common properties
Date: Tue, 14 May 2024 14:54:31 -0500
Message-Id: <20240514195435.155372-6-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240514195435.155372-1-eajames@linux.ibm.com>
References: <20240514195435.155372-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kk-dG1gi_4c2m81zcq06tZ2kBuWv98gI
X-Proofpoint-GUID: kk-dG1gi_4c2m81zcq06tZ2kBuWv98gI
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140142

Since there are multiple FSI controllers documented, the common
properties should be documented separately and then referenced
from the specific controller documentation.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v4:
 - Add interrupt controller properties
 - Add clock-frequency property to FSI controller and CFAM
 - Add detail to chip-id property description

 .../bindings/fsi/fsi-controller.yaml          | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml

diff --git a/Documentation/devicetree/bindings/fsi/fsi-controller.yaml b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
new file mode 100644
index 0000000000000..8620e4da6de77
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi-controller.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/fsi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FSI Controller Common Properties
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  FSI (FRU (Field Replaceable Unit) Service Interface) is a two wire bus. The
+  FSI bus is connected to a CFAM (Common FRU Access Macro) which contains
+  various engines such as I2C controllers, SPI controllers, etc.
+
+properties:
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 0
+
+  '#interrupt-cells':
+    const: 1
+
+  clock-frequency:
+    minimum: 1
+    maximum: 200000000
+
+  interrupt-controller: true
+
+  no-scan-on-init:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The FSI controller cannot scan the bus during initialization.
+
+patternProperties:
+  "cfam@[0-9a-f],[0-9a-f]":
+    type: object
+    properties:
+      chip-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Processor index, a global unique chip ID which is used to identify
+          the physical location of the chip in a system specific way.
+
+      clock-frequency:
+        minimum: 1
+        maximum: 100000000
+
+      reg:
+        maxItems: 1
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 1
+
+    required:
+      - reg
+
+    additionalProperties: true
+
+additionalProperties: true
-- 
2.39.3


