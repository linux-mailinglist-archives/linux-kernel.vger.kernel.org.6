Return-Path: <linux-kernel+bounces-179113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6F38C5BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C332728228A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490CF18132F;
	Tue, 14 May 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="quPeHa+D"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF218131D;
	Tue, 14 May 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716490; cv=none; b=WVm1aoAyRxmEF6YahMrITDc9TdD2DPQQcIb+O+P5Y3eUGsYB6NcgBdofI6FSdj/2vmeR8wl1tjQhspNIoA3IDAwZJ8Z4BgpsQsA0xWxOFhCL9GX2Nm063pHPvP6NqCwkTxtGBSN8U2UDCTKLrOqF601+NfCojQWwKyaH3lppF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716490; c=relaxed/simple;
	bh=8SU/iENpN6Xx0OwWxYt2bSul9xedwDdanqRkSWI9w2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axv9yeeIU4BVbdbtklpUf0YwpxBHbQ5wPylK85p6Y1onTms1xA+xxOz2UvJn3cHYwmUrXiUiLo1bZG1+rKrH7M5Zb5RIoq/nTzdjwDow50ypjvLcBsZjV+S0npf79ZmIxF+mXsYPm51GZgf60tC8CVw8ZZKk8lFX0gZvsQI3uEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=quPeHa+D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EJjwOV023527;
	Tue, 14 May 2024 19:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=Surtr2BpZP7CJ3MaLpzg58YwcjcFGIXkZ4hi7cV1P9I=;
 b=quPeHa+DdOVIUF8m+GmFsppgTCgfLqEJMWMsdT5Igr7QovTZ8FL2XfLCo64NGM8cQwYC
 BUQWG8mkKFQ8HIgHw0TWnjynm+i1ZnNTOtQgbsj7hX0DfCH9nwgXHHwQsYVfhoQ+lNwj
 4oBeRWXYiiR/L3ZE7k3dm4dGibuLAOIBzrVLyB4pYrgq5Bp1Xamdq0wI4ELrPZaPsPR4
 4yrmEY8Ftx+eYXlqiXxIkEr5QK5aNwv0P/irorJEu4Jlp5tOoLsSksSL2rDl2idfHXv5
 pAKc1sKrYS0i993q8Tzdy1+C4UTUu9IaAFpoNWivnaY4gsZEFzpvNxcTbOjxGpjiS2/V +g== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4dpf045a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EHbd2W018828;
	Tue, 14 May 2024 19:54:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2k0tfhpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EJsatS27525792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 19:54:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AED3858060;
	Tue, 14 May 2024 19:54:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A9C558063;
	Tue, 14 May 2024 19:54:36 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 19:54:36 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        eajames@linux.ibm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        robh@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
Subject: [PATCH v5 2/9] dt-bindings: fsi: Document the IBM SCOM engine
Date: Tue, 14 May 2024 14:54:28 -0500
Message-Id: <20240514195435.155372-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240514195435.155372-1-eajames@linux.ibm.com>
References: <20240514195435.155372-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ymgI5bxXx9Pl-ltUt-JYp3VdwVXzoDow
X-Proofpoint-GUID: ymgI5bxXx9Pl-ltUt-JYp3VdwVXzoDow
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
 clxscore=1015 lowpriorityscore=0 mlxlogscore=963 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140142

The SCOM engine provides an interface to the POWER processor PIB
(Pervasive Interconnect Bus).

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/fsi/ibm,p9-scom.yaml  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml b/Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml
new file mode 100644
index 0000000000000..8cd14a70bedf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,p9-scom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached SCOM engine
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  The SCOM engine is an interface to the POWER processor PIB (Pervasive
+  Interconnect Bus). This node will always be a child of an FSI CFAM node.
+
+properties:
+  compatible:
+    enum:
+      - ibm,p9-scom
+      - ibm,i2cr-scom
+
+  reg:
+    items:
+      - description: FSI slave address
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    scom@1000 {
+        compatible = "ibm,p9-scom";
+        reg = <0x1000 0x400>;
+    };
-- 
2.39.3


