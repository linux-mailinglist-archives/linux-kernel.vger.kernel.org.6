Return-Path: <linux-kernel+bounces-179115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3297C8C5BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B261C2172E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4423181BAA;
	Tue, 14 May 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nhyAY52u"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9018131A;
	Tue, 14 May 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716492; cv=none; b=fg/7aFOBR5KE58gcuPRoti8xwXuFFWOUIb4wzAooPAcJJJrt3vbhESLo8amnk56v6J6fpOLj8dZxz/aWgDTTIKUR7DVKZBuD4X9kkBp5Or+PzbIWH0ko2jwRoAbOPiQrh2WguDAR6GgAvCEd3xDFZSJWxouxiNb2Z8fgOd6yI/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716492; c=relaxed/simple;
	bh=H0xRJQ6LDdxDuN2PzaZdBBdPg11ytfH3K+BmtolIEAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUIuGt0raGPs8yIverQyIVwr1pWANf6aJY7Mp8TKQP/bN2OgzUBt/hfPyDqwuYaYhD2H1N18J8RJMqy5L5RUifGygni4iGOLDh2wtvl5Lo/YNYWI96R5dB+El0sZ1Ei1XrjpmWr1LDgoXd4whTgtD1CikknwVzOutH7u4S0RwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nhyAY52u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EIwOfc016844;
	Tue, 14 May 2024 19:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=WnPfUf5IXHpKV/OOkMuYDSco6oumQS7hu/4yRGO9v5w=;
 b=nhyAY52uzZARrDOSPotLHpFXh2E1Leb4mW+uj8EG978MbNiZjb4UB2LeelvKMAtfdtsZ
 7iCKEEp8R/JmMamnt5mEghoLoDGft72YJn5UvkvJn6UmQZR9SjGWyascNQDqu47Mef2T
 Dx6UOcRBh79p4FYYG40S7X1vSKpVLb1THRSKzLXoCnmP9mgow1me8STiiYgWeLwSK9/Y
 V/+zHBMbL+jVfpmj/57sYa7R3q8iVTVNwbymhKquU5lLw9fO84KULoJM3OUvjpUnEZVn
 tbEeAxV/dC4Ik9jK9/eAYKlW2yav3SHjFOxLp0i1nx1odvVoOLuRumkG52pXBOWLhHS7 Tg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4dpf045b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:40 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EGjZMn029591;
	Tue, 14 May 2024 19:54:39 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2n7kq03g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EJsb8Z33489230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 19:54:39 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38A645806A;
	Tue, 14 May 2024 19:54:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01B455806E;
	Tue, 14 May 2024 19:54:37 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 19:54:36 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        eajames@linux.ibm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        robh@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
Subject: [PATCH v5 4/9] dt-bindings: fsi: Document the IBM SBEFIFO engine
Date: Tue, 14 May 2024 14:54:30 -0500
Message-Id: <20240514195435.155372-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240514195435.155372-1-eajames@linux.ibm.com>
References: <20240514195435.155372-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hxx9OZwXUVlvLEJpiz7w0g-CQ7Jkq8i8
X-Proofpoint-GUID: Hxx9OZwXUVlvLEJpiz7w0g-CQ7Jkq8i8
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140142

The SBEFIFO engine provides an interface to the POWER processor
Self Boot Engine (SBE).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
Changes since v4:
 - Drop pattern properties for occ node

 .../bindings/fsi/ibm,p9-sbefifo.yaml          | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml b/Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml
new file mode 100644
index 0000000000000..3cd966fb3c0df
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,p9-sbefifo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached SBEFIFO engine
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  The SBEFIFO is an FSI CFAM engine that provides an interface to the
+  POWER processor Self Boot Engine (SBE). This node will always be a child
+  of an FSI CFAM node.
+
+properties:
+  compatible:
+    enum:
+      - ibm,p9-sbefifo
+      - ibm,odyssey-sbefifo
+
+  reg:
+    items:
+      - description: FSI slave address
+
+  occ:
+    type: object
+    $ref: ibm,p9-occ.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    fsi-slave-engine@2400 {
+        compatible = "ibm,p9-sbefifo";
+        reg = <0x2400 0x400>;
+
+        occ {
+            compatible = "ibm,p9-occ";
+        };
+    };
-- 
2.39.3


