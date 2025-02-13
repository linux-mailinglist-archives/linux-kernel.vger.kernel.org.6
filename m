Return-Path: <linux-kernel+bounces-512609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C0A33B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A26BF1887309
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDDE21128A;
	Thu, 13 Feb 2025 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="E0LmIDVM"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48920E70A;
	Thu, 13 Feb 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439828; cv=fail; b=GMGsbE8lqsb11IExTJxhb3x9P06MwcMxkAUMADLs87YLuFfttBq4uNCSia4SPC2g9AxtNAVP8zYrAtKY9JrVBGdsn7rmEXNCm4wikUmjgLv9gsc4BCfUXL0bjuiFglGjK6xeT3Rc8XLOSEPEC/ZoHzwpvJC3OX47MBvCWTSvsrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439828; c=relaxed/simple;
	bh=o+ZC5DFxz8Ejh46H0XMAPDZ5UEbyx6UWygHg8MZ56+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRQo1ksic1F44eZryz9BEPKxBxY7gOEFXbsKxreZk0ypFwrntJHRQ1sVD+WwhWuKTRu+TVnbxfAD2qyHBFybK7Mx48ttsySpCKaO+sxq9SlMRacmztJac497Y5ZCDMgnHH2VldxMe8JrFYY51XoDJI98CakRnATqwhIfWW2xs0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=E0LmIDVM; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5/PtA/yN3+BkUa7Rzf8neWcv9sTaAFmUq6Fw+6jlXuAldi8vISqP3bytuZno5D06Z8EVhGMMVgF6MWVpW6ELsi0304VV8bOfy/rFg4wAlpRjus1na7B5uXhevHpIVnEw612fowFVn2gbmGhoGielCEY1k2ficpLp7ct1gUXnslQ5bXjzrfOFXUeZJU+zQrROjJ0j60CVsBhwoC2YR1YLSHAOKbIRz9ohQ97FKWixAdf7e2IVBdc5z7mJaSF8pX8KN5FYq4Lz5pMAF8uX6qjzw9rFBt/Saomi7nGHVQ/iQHH0y2DwvoO/FOZmand7dUD6wfkRuDH52zcMd/Ny7d2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+xNITWjfc9BrD3EIwF7+lTQm4GrJ5VI9VaiTNwd4dg=;
 b=bL1Z2jHPHC1tYj7CWBItsZN3ROQjy+MHL42IGNfzCEC5s7hRHun8J5qd7iI4MELKSPCZFFLGOzjiHW+S1U6CBp2JFZIMw2li4PoZX7g+Tz2D9uMJOTJW1sM8jSd7mn+pATTTFwEhucmD+HTFAKr1+ee6SyhAXNu+NjD06y5w/bOJRKAvmAI88VqbbHo3WOm+chM+2whl33WU7NCScuZOB5oRwXG8Ocm+D26Y9orf4T+ZkzrWtwkQg4JxbHWWvs32sceUvEOo5hBBBO0lLtuA2v+TARs2KujBq+Ih9RDkRoRQXmZlp3rC0RbWtuYs88KOqlQU094YDyhttys2Fvahjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+xNITWjfc9BrD3EIwF7+lTQm4GrJ5VI9VaiTNwd4dg=;
 b=E0LmIDVMWgo2Ul/yl2VITbZFjIiFpJ+HoPuiwM7c8d7meVJSySlk1/J116TwAmdqjHpLdu3jy6i1y+VFiCoYN/ubpO2fMcjGsgLDlmAKmxkKCDtpKMNGpqu1Gh7r6PAIMYTDJzd4p/0qMptMyqnhmQeEMnnq/Npal1pBdqUiFNA=
Received: from DUZP191CA0056.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::14)
 by AM7PR06MB6581.eurprd06.prod.outlook.com (2603:10a6:20b:122::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 09:43:41 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::f) by DUZP191CA0056.outlook.office365.com
 (2603:10a6:10:4fa::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 09:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 09:43:41 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 13 Feb 2025 10:43:41 +0100
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
	Catalin Popescu <catalin.popescu@leica-geosystems.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH next v3 2/3] dt-bindings: usb: microchip,usb2514: add support for USB2512/USB2513
Date: Thu, 13 Feb 2025 10:43:37 +0100
Message-Id: <20250213094338.1611389-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213094338.1611389-1-catalin.popescu@leica-geosystems.com>
References: <20250213094338.1611389-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Feb 2025 09:43:41.0218 (UTC) FILETIME=[C3C34820:01DB7DFB]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|AM7PR06MB6581:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 79765100-55cf-4046-16f9-08dd4c12e676
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EmDq20/0jeL0N/ZcXzFgYCv1EksnuDkj3CgoOOCwiIKDz4PjDONHxRNswQDc?=
 =?us-ascii?Q?vBJefY5DNpzgWTWglbEsLRL/UNUvzPKyf0fnsfPfuYhZTCwWeqQQG50gISV/?=
 =?us-ascii?Q?VKEfZp6QTThiBgpL95tSoCgqddUIlRHJy1foUBk7iOzvQVMQ8+P8K2QvCJvY?=
 =?us-ascii?Q?IrvG4hDNEvmETwuNvK5TUbtUkYeEmxhghOg80INMWmfUDfeeUcmKZYfCgiyC?=
 =?us-ascii?Q?p4fF1RBQ0+94L209nZvLb6qJixX0F9g+TQXnwEEAO0NnmHDdC2QiqaXR6xW6?=
 =?us-ascii?Q?hoV5zBG14I8j3mfPTLTRedTwTj5Fzw23aaggiWgtz2o7wr42KnKky+4abEpx?=
 =?us-ascii?Q?loH+hK6JHYJvt6TYezZgtr2UXJsgFxBTa7vvOli0MKbA72bPOYu6atE3rbQT?=
 =?us-ascii?Q?4IX7+a69a+BPGad33hANHD8iGBHZHiSqfwUIGH71lRLNd+ZYMPsROR/u6Y8Q?=
 =?us-ascii?Q?Sn3kaLjapYV1/0lXWtDfGfJ3Z8gsTbKA9yWdjh/DscAV5itjwjMgZ0QHR4oB?=
 =?us-ascii?Q?9gIciv0jszss+2DPC9l/yIyWX3n+XLP0ixqQTLobAcO0cneDJoJ/d5lVEaR8?=
 =?us-ascii?Q?0qlXOFZ0ylN82PBOOELbe3glE+GPvvUZv/UEAZI9CH+KeBOoi1u1PzT25MIx?=
 =?us-ascii?Q?u+up1M81B2AgpchS1sJNV+u8f2MtFv2QTyrMI++QC02+AuiGEwV7jsABjBa2?=
 =?us-ascii?Q?r7bZ8plxIjvkwaTQF/V683aj9wdS5q/Fj9PhMQscU+5blqcl87xZIv2mrbd9?=
 =?us-ascii?Q?Rvm/vBuY1Ov+yB77VLpguiZ9+CK+EY6jlghNuVruC7+04f0HYjj0XegcOl4k?=
 =?us-ascii?Q?ttlC58e7oCoxq266aYRuRxGAzrNhwhkaA1XuX0ubcI7xf3OWTEgeqbLXb/Q6?=
 =?us-ascii?Q?1SEDsvNrGmChOZUXbxhsROrF0+qlDidqm5dk/jW92T3boqf/h9RZhIAE+G0A?=
 =?us-ascii?Q?cwBwwWnUi1pvAN8z82JWEO4i3mZtbdSRXf7VenV13FhYiBgF/E2HGAnPL+Un?=
 =?us-ascii?Q?9gTYS5L57TnBxyW2KgNopGTgqsNjq05U5ceCppuShdcx18CwoUnQQzhr1ncs?=
 =?us-ascii?Q?0oguf0b7nzPmBczOcfxY4M9qa+DDuFVaUt8+Rh8xphR/Y8DGoQ94Hyf6jXY0?=
 =?us-ascii?Q?3bTO7/EzciFWzlSNxhMmdtKUp/7KxAGBVsQb5tRGMb1lq2U3G7e8VFjYuczQ?=
 =?us-ascii?Q?8FQ32yOEHj5p/T9LLzgEItiy+iNZOpKUgAf+DQCE7U4rfhRMStTqIpIXNpW9?=
 =?us-ascii?Q?m0L1wrhppskk4K9VmNQpZgyaWHtcrxjANF1w/qTkI7izWOsCkZvaLFXZXfuJ?=
 =?us-ascii?Q?HlNm31toRAOGoik4MAZtAUj63J6qfU+PNkdU379oBYJjRccu6nMRdFiGdPh+?=
 =?us-ascii?Q?1SLj5xdqb2EwVACWT6eNfCavK0zvSl3gPs5NvEVBJdi4EqNS/p9cBwlapqYJ?=
 =?us-ascii?Q?ThZZNORio2PVNs5H8xMHKId2BLvhlpT3eOmoT41cmt8emdl28P48kXeqFN6+?=
 =?us-ascii?Q?15PEsUer7Ew9ED8=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:43:41.4693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79765100-55cf-4046-16f9-08dd4c12e676
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6581

Extend support to Microchip hubs USB2512 & USB2513 which are identical
to USB2514 but offer less downstream ports (i.e. respectively 2 and 3
ports).

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v3:
- add acked-by

v2:
- remove needless "items" keyword from "oneOf"
---
 .../bindings/usb/microchip,usb2514.yaml          | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
index d0479beee30b..4e3901efed3f 100644
--- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
@@ -11,11 +11,17 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - usb424,2412
-      - usb424,2417
-      - usb424,2514
-      - usb424,2517
+    oneOf:
+      - enum:
+          - usb424,2412
+          - usb424,2417
+          - usb424,2514
+          - usb424,2517
+      - items:
+          - enum:
+              - usb424,2512
+              - usb424,2513
+          - const: usb424,2514
 
   reg: true
 
-- 
2.34.1


