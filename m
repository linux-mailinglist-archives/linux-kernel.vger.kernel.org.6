Return-Path: <linux-kernel+bounces-511210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFF0A327D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF578188808F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA5D1DFDE;
	Wed, 12 Feb 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="PQqzGqwv"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6A20E326;
	Wed, 12 Feb 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368621; cv=fail; b=erV0J7xwMqAHRDNutYAur/c220iWz1yvBZHgLafLMpaaD4SzFkBthADXhHa5mANUEvIS99K/E/E9H1cosLz10o0wt8VecSWXkCn7F6PyvKx8c960qMoX3AuRm954sUhDj57CZ1F568t8au+xYlz2buKGhgSK+DjKXaHXrULYRP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368621; c=relaxed/simple;
	bh=hVd2H6SeA6prvsRJ0JRpkubEJ1WEwNf6aeYWl4PX/60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Un/2A/An/NQS8WVtaRzbVdTJ/h8Gd9APijUyNQzsHO2/FbnRv1CTvBuHfIkK9pJTlo/dPkDDsfRhpqA9Y2l3R1L5AKeJ4XoqQYd44m5uGnf/t9ybsRoKYdUgKE6jQskcAglcwLH0fMVf8u19QQnWQ/TaK0Hpj2kgTk7AGuiVW4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=PQqzGqwv; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjdtSYm4XY/FIrNza6rTB3ahC6nIch4CRnGzL2Fad9GmWCPB3TWqXgV+Su8ZyFQKXXVVpNKDZw1hzkzkQEjhUGQst+2kZPX5mIq0eeXgr2OpZnUcpTFi5FR3enCt9ZjAz1W84ANLHkGLcgf2MqevFvdU2uswAmoNxW0uotIAoc+vCeo3wV/pEMXYCfFMfg5qaVU4YSBlm4YioEbFDYBAJkzR93DSEYdgqE91VofZnsypNokAkPcO/I8P9yTjLggIOAdylXzHxzY17zXu0zscqdfdr8nRW+eZ9MgMPFbCkN0eWMZxoQDYFQ6NdkLfL55+lv5kYZWa2SwzlIN41NXceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy+iAXBDg2zi+E7/mYu8/E/Sl6y+2of9c7BmpByo3aE=;
 b=M1x3hNBXntgmLnnTYNeKCZa+meQJfoIsBohtGEcpwC70M8ESflbZFkcLvNP4a4h8PM0/og7wAuaTEFlCDYICc/yDrLWp+f02hua43En1qEe8rtc31GnZRwGteaL78h/N+qqHlvCyDDsf0rSMxAVlRAK9cqwb60stNlQLtVSCnyWD0/TNrRufFfaxyQ6URSqLt9QiPgEHZaJojlG2fKRH3Xv4blBVBiY4jUtyiBdH2Bm+sNM+2orB7mfg7UhqXYxstsPalr5gJaZmBxqROtu5ctdXXvUhz3nmCedTHMDHJorZU6uCroVgYRb6jQwdu2Qm8kHLAvFDaJ4wwKQX0vGFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy+iAXBDg2zi+E7/mYu8/E/Sl6y+2of9c7BmpByo3aE=;
 b=PQqzGqwvO9RxbZyRHqnhGyaIXQcwokMNaLb4j3gcZTUGmGZZ6jyRkS1/wekVgw+j6tkA4/popsm0cnT1DGDFtnwDTn+zeVVHZj3yclyueJXx4xEz7emgoRMwq6GLFONHpJ8OukjR137psFnKSKBYjIBhTrhPZQWQGV5kzIQKv+0=
Received: from PAZP264CA0254.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:239::20)
 by DU4PR06MB9619.eurprd06.prod.outlook.com (2603:10a6:10:565::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Wed, 12 Feb
 2025 13:56:54 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:102:239:cafe::28) by PAZP264CA0254.outlook.office365.com
 (2603:10a6:102:239::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Wed,
 12 Feb 2025 13:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.0 via Frontend Transport; Wed, 12 Feb 2025 13:56:52 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 12 Feb 2025 14:56:52 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH next v2 1/3] dt-bindings: usb: microchip,usb2514: add support for vdda
Date: Wed, 12 Feb 2025 14:56:47 +0100
Message-Id: <20250212135649.3431570-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Feb 2025 13:56:52.0505 (UTC) FILETIME=[F80FF890:01DB7D55]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|DU4PR06MB9619:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 483ad5ac-a9d5-41c2-2bb9-08dd4b6d1ab2
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bw0sW3gktMc/Y/+36bPv8FuZYd39o7pYUPIATDqBFmm6XA3Y9sSMRfee2Yep?=
 =?us-ascii?Q?BQ5U3g2xaqgHN79bHw7YG5mlPLU1yXCb0rUzUhQrhbXGVFe0jTtRO7pV7oai?=
 =?us-ascii?Q?KZgAWpgKoeyu81FRaKZovfbXf+UNpSMNrOsNIz2xxb0THwxWMcLz/qZGr+se?=
 =?us-ascii?Q?eZJ9gDecAeS6H2MY3o5Xw4RmnunDnVoSlO/h1q9bRqZ8fWUrwDKGqcHk7TR5?=
 =?us-ascii?Q?r2PJ1f+xvGjb4Terx8GLkrISV8KpNsP+sT6/GwppkiK30nxM4qXtdOJpEFvW?=
 =?us-ascii?Q?YvZAkScqZlosYu1Z4EeRf8YezM02J6UFrOC57bsqTEru1EF1R1fP0cs6OPbR?=
 =?us-ascii?Q?t8Eqx2M2dDa0uTMubV2vy5w0Bm9N7wxE6SVJ4QOG4F8lmM52LmxLdoEesGPq?=
 =?us-ascii?Q?eXHg2UDeD7xsz1M/UUQE1tzdt0uxuTs1butflRo16eXM2t9Nohd91TlPL71q?=
 =?us-ascii?Q?mreQYVcjDrY+4wsdNKfvHOkyPwrNsHaQVAzySL39lLSNTfEe3gE+m5YdFE3g?=
 =?us-ascii?Q?fi/3xlG/qmkp1Q/vYEoUG5zA01jORxp+EX083O7cjUXkytxVHnGslSJE9moD?=
 =?us-ascii?Q?EblV9bCZE2fS02KIwZQKbaG39j6fhGhHhXHpwD8prhNnM1xX9ueFEhAwrn8O?=
 =?us-ascii?Q?HgiW38q7sBwjx6V6vYtDhRlV4GrzomCao2ccmR8PTLoJhM3QD2IOrT/uDnE/?=
 =?us-ascii?Q?QjCE+ld/HXpweCfG1eQz4mD14AkeuGr87yMPEKX9SwM8iRB0Ko8KoFI9PfH9?=
 =?us-ascii?Q?fEkf0QH/iorf6n1cjLdOHTd37NmFCVMrRs7IYJnfZrPNK9POOjhCswYndJx0?=
 =?us-ascii?Q?wUK3EXYJ1WTaGM4aNYR/6yJjzTybcUAV1Gr2vMPPVC0zAlqf6A2LQ2pzhhPU?=
 =?us-ascii?Q?8XdnQBtK5vdqnwUEsn9vq2nRDEzdQGf6uaLEGwm/n4SF4s/G//B+S3kTQI1e?=
 =?us-ascii?Q?zDvRelEWLNFu34x66IzhoreIfMiwzZ6uLlXrTGm1JUUXJ7iWpH+o39w/T0Mo?=
 =?us-ascii?Q?/sAprKFchAG/TNH1MLBLNY7jI4d5y+7ry4L6/ZjszuwYQref0KZ2SYdkWjwa?=
 =?us-ascii?Q?z6DjNizGNghH+HL76i3dxVtW1ZENs4VkRK4HBI4NfSzDY0C5CKhtRNUPYjLm?=
 =?us-ascii?Q?aROJ6MfxA4lC6HPRUvohSHSg6wckHYjqwj/LH3tsdMK5JjOS8xkvwpj4eTmu?=
 =?us-ascii?Q?8adrdh+VgDTZSom2uMBOlYMPy5ar4QUsRym/Sh5mJIVPDyQUF0BCUekdclKC?=
 =?us-ascii?Q?e97w2vbq7mr45dghDkG0mKngvrKXKHWL3brlruOKUxd6uU9iz6I2mmun8c5V?=
 =?us-ascii?Q?gNnx+0nkFIE3BuHExkWRSKtnFWVFEXUpOdaWEVspnq1R8OyCs6BH5DMzJmAz?=
 =?us-ascii?Q?Z+RQeL+nb+xDkvpZrk+pyBvYTJZIClt+4LdqY4AWeX+o4DpZ6xuE9tkZlxcF?=
 =?us-ascii?Q?Jolnrrjmn+EL7tdjurk6JU3Fz8g31oB2CmyKaCcu2H3CcIzUxkxpZUySwXpT?=
 =?us-ascii?Q?eKAFeKWVvmeRrrA=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 13:56:52.6943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483ad5ac-a9d5-41c2-2bb9-08dd4b6d1ab2
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB9619

Microchip hub USB2514 has one 3V3 digital power supply and one 3V3
analog power supply. Add support for analog power supply vdda.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
v2:
- merge "if" with "allOf" and move the whole after patternProperties
  section
---
 .../bindings/usb/microchip,usb2514.yaml       | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
index b14e6f37b298..aeffdf0362c2 100644
--- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
@@ -9,9 +9,6 @@ title: Microchip USB2514 Hub Controller
 maintainers:
   - Fabio Estevam <festevam@gmail.com>
 
-allOf:
-  - $ref: usb-device.yaml#
-
 properties:
   compatible:
     enum:
@@ -28,6 +25,9 @@ properties:
   vdd-supply:
     description: 3.3V power supply.
 
+  vdda-supply:
+    description: 3.3V analog power supply.
+
   clocks:
     description: External 24MHz clock connected to the CLKIN pin.
     maxItems: 1
@@ -43,6 +43,20 @@ patternProperties:
     $ref: /schemas/usb/usb-device.yaml
     additionalProperties: true
 
+allOf:
+  - $ref: usb-device.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: usb424,2514
+    then:
+      properties:
+        vdda-supply: true
+    else:
+      properties:
+        vdda-supply: false
+
 unevaluatedProperties: false
 
 examples:
@@ -60,6 +74,7 @@ examples:
             clocks = <&clks IMX6QDL_CLK_CKO>;
             reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
             vdd-supply = <&reg_3v3_hub>;
+            vdda-supply = <&reg_3v3a_hub>;
             #address-cells = <1>;
             #size-cells = <0>;
 

base-commit: df5d6180169ae06a2eac57e33b077ad6f6252440
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1


