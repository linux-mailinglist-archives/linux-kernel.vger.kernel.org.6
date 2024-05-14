Return-Path: <linux-kernel+bounces-179117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F94B8C5BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821651C21B96
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A1181D18;
	Tue, 14 May 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mpnf2g03"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E63181339;
	Tue, 14 May 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716493; cv=none; b=KP++HIvXn00+GQ+DfnyasrZL6qXqRlWmq5C5oZqGt4iUwK+RVX+YlwRiu8se3IaqK7cB/i28VXIEyo0LWtKWATl+/KchPvlWECWsW5VFb8STmdPe6WTaljCfKr8P1yaDjaYLTSQrLlL6oJZ1OhrGMnQyN02UBF2p40KxCl9xapk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716493; c=relaxed/simple;
	bh=JCPa+yp/zJJs3+BIrAutXGUEd2YEOV8abxWiBUbcEzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovMOdxc9nyxdAzN+xDFOwLANfjSIB7OC5tAUTJjt78z4PK5gULGjbYn0PDp/MWKtiAMcoGW8KqYokBzj3TmJ+O4IctrRaPWooYpYvNPgOcZAoFgioDcpaDcPF68HAdQd4Mn+kFLx6HvwzIXB/u1J7rLrBY/g1f9XZsq6BbgKej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mpnf2g03; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EGU89i028763;
	Tue, 14 May 2024 19:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=U1W6QwwCSxfBeEaP3xClx7D5mfTwejsAwXWmi0ZSrFA=;
 b=Mpnf2g03MjE/Hj1njE8c+5noQgtgg6Y64tck13RBYzQV3jUYF+27VFeV4lWP7IypEth2
 ibBuCqe1W8D4eiT5raxp6jRmuFcQBRarCBfXF9fZ5hYQD8lSt652P7DEe7Se3C7cMOak
 mspDePMVR+vztnSMroILFZntzh+xy5x7UehrdM4rrydSHgJvSGD2R6gmW5QY6bcr039Y
 zLgXPUEEqJnmw5fbtjdt/ONhu61oizutGBb2RY8X7GyYBk1gOwlYkqJ6xXEjWPLdg5+h
 W6qwpEbUoYfwVOoiAZkc9Y2SzzXSyDqdXQlnYbLNMOsGc4LHSTNyOq4ck5kr+yYLgfaC sg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4a9brne2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:39 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EIf23W005981;
	Tue, 14 May 2024 19:54:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmf7dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:54:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EJsaFs47186402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 19:54:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7241F5803F;
	Tue, 14 May 2024 19:54:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D3A858060;
	Tue, 14 May 2024 19:54:36 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 19:54:36 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        eajames@linux.ibm.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        robh@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au
Subject: [PATCH v5 1/9] dt-bindings: fsi: fsi2spi: Document SPI controller child nodes
Date: Tue, 14 May 2024 14:54:27 -0500
Message-Id: <20240514195435.155372-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240514195435.155372-1-eajames@linux.ibm.com>
References: <20240514195435.155372-1-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wZxgio04f5c3UvioQmcuXH03WLsseRkb
X-Proofpoint-GUID: wZxgio04f5c3UvioQmcuXH03WLsseRkb
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140142

The FSI2SPI bridge has several SPI controllers behind it, which
should be documented. Also, therefore the node needs to specify
address and size cells.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Depends on https://lore.kernel.org/all/20240514192630.152747-1-eajames@linux.ibm.com/

 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  | 36 ++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
index e2ca0b0004714..ad5c83f484255 100644
--- a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
+++ b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
@@ -9,11 +9,10 @@ title: IBM FSI-attached SPI controllers
 maintainers:
   - Eddie James <eajames@linux.ibm.com>
 
-description: |
+description:
   This binding describes an FSI CFAM engine called the FSI2SPI. Therefore this
-  node will always be a child of an FSI CFAM node; see fsi.txt for details on
-  FSI slave and CFAM nodes. This FSI2SPI engine provides access to a number of
-  SPI controllers.
+  node will always be a child of an FSI CFAM node. This FSI2SPI engine provides
+  access to a number of SPI controllers.
 
 properties:
   compatible:
@@ -24,6 +23,17 @@ properties:
     items:
       - description: FSI slave address
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^spi@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/spi/ibm,spi-fsi.yaml
+
 required:
   - compatible
   - reg
@@ -35,4 +45,22 @@ examples:
     fsi2spi@1c00 {
         compatible = "ibm,fsi2spi";
         reg = <0x1c00 0x400>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi@0 {
+            compatible = "ibm,spi-fsi";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eeprom@0 {
+                compatible = "atmel,at25";
+                reg = <0>;
+                address-width = <24>;
+                pagesize = <256>;
+                size = <0x80000>;
+                spi-max-frequency = <1000000>;
+            };
+        };
     };
-- 
2.39.3


