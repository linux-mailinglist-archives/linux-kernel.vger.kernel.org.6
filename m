Return-Path: <linux-kernel+bounces-512608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D869A33B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1061887182
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FFB20E329;
	Thu, 13 Feb 2025 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="MgYkDTg0"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B32063E1;
	Thu, 13 Feb 2025 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439825; cv=fail; b=DtVSYUlTVoWCZU3ahOVhqxdVKIBRjISUsFTMGjK7wsTbgJ9NHebMkCE5UI/Coiajl8O7ndcCuO8TaVnvh/cDfkgV34DwKJ6Nt0RvV405b59YZNOaxO+Miav7/dW1td1Uxkew3HNZHyR04xW+FG27RrYEJ4blbPuSuChLSA1lCIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439825; c=relaxed/simple;
	bh=SnRKKND+lEBQpIy3E9W365mEbVNiBSMkRVCDMo47OOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nZoUY9KuGUBxKiC18hb04VTdCW1gPdhdiYpKByQtVHNmNqFW6QSjcv6AS/3mq/vVztfPmiu2f2kRUROSz1/yr3Ci0tKIqPzF8400e6g6bSPxVAhsrDuwqvvGv0kcOGPA4unoyF9rr+gHszR5zd5i+neY/iE4rnHt7nKLxOj9Jac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=MgYkDTg0; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nt7N8QINO81rbXn/kRz4hhgAjPUZHamwZZAsKMIzjQCzUOvliYM8iqjYx8IsjVpAuhMxpeCOlyrPbIy3SdWiqcU8EJgEmybB7NfMTYBmGLCB2lQaQjL4EiYk7lHrS/+Qk+JN4Dq1LnCqVMthPdUYyg1FXWEdCHO2FT4HFMK071BzO0iP6KS2nWsTlj2zuauNeZOBkzWYEez/sQl6JWMOtvVvXPiabxaeHqN3Wg3fbLQ2kjE/WzH9qgY9nJf2XfUiWbuLLztYtbl5Jv2mFK4jiOBRMqbpWg5KCY4Y+ybTrmWyUG45NshIm8mg2WwBwAbiYhqSReUiJ2huIn8UNFhh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUVGGDMjrXNejR0O607qM0VOH01fLv0U60hygab0Gqw=;
 b=wojf6p6YaXnXtK+Cw7rtYAFBmFwbh/iR/p9aPsVy2yNE7m3nXveGJtKh5coyJCbQOAS6U/OVxSh0o53KmUub12qImTEjPy7lZQilIQkNnI2UUgZka2DyNgvhqb+Bmsk+nUSAwEglBrSLqNRJ93URxqrVVE1MKljIIrjOg7t+LZow/gwXdlED0V/xI+515485RRQD5oARDaoZW9LchtCxZ04uPW9r5HaxPpRYbysMYUABoQGCOP83eJ6bp9P3MLbfQICKtrgpkrfnuT3JswEZl+L7eGh7nxzNArcnClZreJ5XqRqPFl7kyQKhsdgi2SVzfoU2LQIumGgfxUieoIALbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUVGGDMjrXNejR0O607qM0VOH01fLv0U60hygab0Gqw=;
 b=MgYkDTg0Mrvfs3+ugA9t3DxTbOgWb+BUVEcUDmoLU/rYqj+waswGSnAfZvVJHCraxhL7YL1Ml8Li+l3BMNgfOFV2q4Tz1nYOSbzAPnD+NnTtE0ikZCoq2yQrPiyKXbrFroe7iI9/maGWotErZ5nF32THvn3rKui0koOZdz6ETFs=
Received: from DB8PR06CA0046.eurprd06.prod.outlook.com (2603:10a6:10:120::20)
 by DBAPR06MB6949.eurprd06.prod.outlook.com (2603:10a6:10:1a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 09:43:41 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::6f) by DB8PR06CA0046.outlook.office365.com
 (2603:10a6:10:120::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Thu,
 13 Feb 2025 09:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 09:43:40 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 13 Feb 2025 10:43:40 +0100
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
Subject: [PATCH next v3 1/3] dt-bindings: usb: microchip,usb2514: add support for vdda
Date: Thu, 13 Feb 2025 10:43:36 +0100
Message-Id: <20250213094338.1611389-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Feb 2025 09:43:40.0468 (UTC) FILETIME=[C350D740:01DB7DFB]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|DBAPR06MB6949:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ea3a7aca-8948-42a7-20de-08dd4c12e60b
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3aJbn7ljdrMKgrR9lk3ueYQai4W0wo/o2PAiFCKsGfUCt42QIeJwARQ4Q/Su?=
 =?us-ascii?Q?SYJWWGhY32leicwq0vWfPVKGZi66gAyPkggDfcy4QCe7BmzKCo7lyv1jpdwl?=
 =?us-ascii?Q?boJI6UuGiMuFFOY5KE06tNIJ5rNdex1u7KsI15U2M7iUge9CZ6fUsbxhkybh?=
 =?us-ascii?Q?VF5wcDjFa8BOaGirMd1GikqNW3oAGfeGMvy+Z0zlz53ICLBI7bJtcR0g/qtP?=
 =?us-ascii?Q?AsSxhEOd8WLomK4KXpT9Fe8hThj7YTb/3gv6mnrhjxphJ7CGiY/ir+A+p6r9?=
 =?us-ascii?Q?DDVz05bzbxjyiN7mltHt2BVKlLNjEOBJfumqpNDy10bFjCf9xhRw+tzftafY?=
 =?us-ascii?Q?CguwdZVb36oTTfqKLBNERBH6i6HOb9KEtYjuvULcKUZrny5aABx3lCkqggci?=
 =?us-ascii?Q?bofQBygfYRaTFCZ3cJCv/ULLmG0Ll10l28ijTUlv73Y2oErHR77De4T346gt?=
 =?us-ascii?Q?bwQ5FsON7IzECscRRTlFL2bNwotgQOVO+PX/p1AALvRhrcaHtH0Fun4JtWbJ?=
 =?us-ascii?Q?OOap76JKUD/EdxaxIj8wReoGM4aINjLg6LtWTOhyvM36v04IWoIU0q8SH/v4?=
 =?us-ascii?Q?BTNzx3JbSEMTQ9qgIgq7eRJwxlAzp2Tz7lRiVC1K40SpBmaVTyXhadSSRcuw?=
 =?us-ascii?Q?pdBxXOrQdCe8x36sOKATvCTuDuwDrinMOMBctAMhuhipV62RmsbmRsviQvCk?=
 =?us-ascii?Q?jUo/CXoeXKY4HbraLWBTs/sD69UxZ+Zo4zoJiUvWM78T0cdkmV323zxY6Lss?=
 =?us-ascii?Q?H7B6rWhmR3vxs9pnIoHGuQavHteEckYIUkVjvIm3JWoWXsoPSqMNBbUYntlN?=
 =?us-ascii?Q?MZJ8iHSHyNaqVCQcLdJ6B8YQCMKT3Y1/90S/NcaaVR3dLp1zrl1zpHec2cud?=
 =?us-ascii?Q?mSWjfQsRP50xeilBVTDURIoLjiCFLUuhjrD6pCcNtax1iiChVkwR0I45Qqvs?=
 =?us-ascii?Q?Va986mxn7hOqLEKzld1nCLJx3RsrHwv1Mtvsmk7jo527CKSPbcO8ge00nwgm?=
 =?us-ascii?Q?vbo48tI5XmHuzU/rfDyDnMAjQyUdeZISCEtJQyr2kvyrN6+KOiChILeulB4A?=
 =?us-ascii?Q?gB8caAMZ0W0U+Uaro95ELTwBeIz35rO4kY2PBuiyucNpvMf6m9rLYF78Gujz?=
 =?us-ascii?Q?vsqNlXgU6DS1GizXV9rk8UaRtb5yS9f/r77NgPHklLDF29H7AuHL+Ts7hi8u?=
 =?us-ascii?Q?EK9tlG78ZFF8snfv13O5ZgQOeKD9fKj9HOQWAOYd945/1GG29s43NOToL/19?=
 =?us-ascii?Q?UYJmUlnJn9CERK6fUYeZCI4gN5L0OvdMWiQ60vlv5fuRDFpaEA3c9koF01xm?=
 =?us-ascii?Q?t3KvZYsTJm3UZ4YodERD2swOoFm7xvp9q7/lwPIiC4xua3S6M0x0w7RbcbHx?=
 =?us-ascii?Q?dSvEQOsOYrpndHcnQD01yxoQZVR1f76xQuC9gOrC3tKCbsMKMdShUpPCgcOk?=
 =?us-ascii?Q?CKG88xLW14MHJyIpVDVGYXfWI9Te1z2CAabKfq4ztQfySd5tPSMKqYk3n/am?=
 =?us-ascii?Q?/qnVdFtb5rD2tsE=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:43:40.7683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3a7aca-8948-42a7-20de-08dd4c12e60b
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6949

Microchip hub USB2514 has one 3V3 digital power supply and one 3V3
analog power supply. Add support for analog power supply vdda.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
v3:
- replace "if then else" by "if not then"

v2:
- merge "if" with "allOf" and move the whole after patternProperties
  section
---
 .../bindings/usb/microchip,usb2514.yaml       | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
index b14e6f37b298..d0479beee30b 100644
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
@@ -43,6 +43,18 @@ patternProperties:
     $ref: /schemas/usb/usb-device.yaml
     additionalProperties: true
 
+allOf:
+  - $ref: usb-device.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: usb424,2514
+    then:
+      properties:
+        vdda-supply: false
+
 unevaluatedProperties: false
 
 examples:
@@ -60,6 +72,7 @@ examples:
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


