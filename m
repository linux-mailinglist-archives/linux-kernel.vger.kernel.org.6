Return-Path: <linux-kernel+bounces-511209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E8A327C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A007A0249
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DBE20F079;
	Wed, 12 Feb 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="ePqqxgLj"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012049.outbound.protection.outlook.com [52.101.71.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4F20E329;
	Wed, 12 Feb 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368620; cv=fail; b=g9EeuyvFJ00RtMiksSnvlwyozkUL5a4oDjianETMDGURYLfIYiecbVJNOxvpf26lL2VyXClMuLt5lIePMpKUUaJDLwkpXNd/ps774mfcAc/Ry/TW4/KxhjWyvDGRl40nXmerymGDJ/LryVUO434bpfv/4cuY/eE9RkYqZtHz2nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368620; c=relaxed/simple;
	bh=ZO9GtwXtI70toNwvARD4v58U9jmXhoKOv06y5Ujpa/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haqKT1toCQpqY7w2hxoGeMrUlFQnGSImUNg1mTjb0goAHR7gMpMOqDF/ldbJZQcczR/79Ct8fDx76/oKtFxNfexUrHVbA5OZBImV5E5fUu0IYdWb7xBhngJtAPgdM2KMS/tG11j5E2jiAGozp6e0lh+lZZjDM5dDvTd1DyiuNwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=ePqqxgLj; arc=fail smtp.client-ip=52.101.71.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMGBiF2hDGGrD7C8Z87uI8FUN3SfPI/0WbVWofbYZZ01St8ujXps6I9eWOuFxu5UCrBtk3PlWYIiRxJiQ/206NQYteW5Vek19LdNyU7KK4zj2VY7gmjyvj7Zt5MNIDLIHoq2qSjtWgIsQ3L5vlCZUMPnq4d8aWdGCZCN0KGYW5yAHYbQqgF4571BEJPFf8GrLvziN4f9ShWFX6zuieg78wVdnf/Qzvmkno8OImtgkBfh4J9ApZBehbnOgeQsVycENPWY1knZdz8JT+qg7mw7XNaAmfTwJjug37q8b+izUbIuSyJUtW7sMuqzKhiLgKU/QzuQXxb2catPhO6sjCb8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCBdVMgd1/WeLJUvPT/PwKOR+MgIJbOFf5PFgi36dj8=;
 b=T/3xtBeVW90VEskyWeLKQj1/7OYAxbbtgFLkYcKt53XvwK/Lx0LvBixk5gAWXAQot9IFK935gkzhDxZ2g0uXtgzQYSFrXBfp2BsfXwDCxJUq2ags0H9U5+69MRKrgRhXxeD5Vp+JT4XoQbK77bl4skdKLmq8TjJJSNAZA+G/nFXE5gA+8jujXwY4LPJQfRcus25b1wxivTI705bcLEZkYGlvfLMYzI7wudIug772jubo1yQG0OeEFhi+1sfg3HnfjrM9vwKz2LY8jQ7mHDcicVUx191lms3LCJ7FEjBJBTM7Hkdcfax0n/olsxZ3jua3gR9Xkgdz44ECx58wubz2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCBdVMgd1/WeLJUvPT/PwKOR+MgIJbOFf5PFgi36dj8=;
 b=ePqqxgLjxEwibSwT3IYgQ1XsIQkO9FZcofGL6Zp1M8vhzheYfb60zhpBJ6w+jKnPegYIeU+CGhI2y0hWm23mvjvjfvJBBXDx94TKXlwBCohHzqRantL6xC1pyQVQZEB5RpiADLxHKHr7R+UG5UH1NVVEq3eunXL8PTVjWYouknQ=
Received: from PAZP264CA0248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:239::19)
 by PA4PR06MB7295.eurprd06.prod.outlook.com (2603:10a6:102:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 12 Feb
 2025 13:56:55 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:102:239:cafe::29) by PAZP264CA0248.outlook.office365.com
 (2603:10a6:102:239::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 13:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.0 via Frontend Transport; Wed, 12 Feb 2025 13:56:55 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 12 Feb 2025 14:56:54 +0100
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
Subject: [PATCH next v2 3/3] usb: misc: onboard_dev: add vdda support for Microchip USB2514
Date: Wed, 12 Feb 2025 14:56:49 +0100
Message-Id: <20250212135649.3431570-3-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212135649.3431570-1-catalin.popescu@leica-geosystems.com>
References: <20250212135649.3431570-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Feb 2025 13:56:54.0427 (UTC) FILETIME=[F9353EB0:01DB7D55]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|PA4PR06MB7295:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0f23398-8b16-4bc2-1931-08dd4b6d1c64
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dgYOTbI7lDRnRdd6D9SiWtUljGAmuGge0JmoI6Yu65F6h6CsS8ESZTS3QZaA?=
 =?us-ascii?Q?29fxW+h+DGYSAmutttZRSKPIRDt2Wa9gOQ3XPDIVN7G/rLNrgYNPJzn4aRdb?=
 =?us-ascii?Q?piK4EhyyweNknN+Koh6LHPMf2GZ0azv+amwr2bv2Hs5cNW9+OFgD116tSjM6?=
 =?us-ascii?Q?L97a7ifXgSH+m6oXIUIdnXBhY9lXGsonhNuCpAmh6U5BMSINb9tp7dcrpJku?=
 =?us-ascii?Q?L6Z59ZTYKEsgvu+up4+YsFrKiC1smSGdHFm8qel1ETmOtl0GcuQhfcvfR8hv?=
 =?us-ascii?Q?RXDw0qxKuVEAZ09zbPPEidXwpyESZD52cDHmxzfiMnZN3rdDrVUtbMTgvXHc?=
 =?us-ascii?Q?zvog6kQg4SNILMZy7HTUrGMAcKyerYawuuFax+Ek8WV8bMsekovR6i2q962N?=
 =?us-ascii?Q?TFZ5gks5muYkoMReQRQ2m8PwPi3DdpWJs9VkdbSDEDlMa7pg7maLGIzfmBIa?=
 =?us-ascii?Q?4AWCCtgANUu1+cndiMVLg0HMxRAARhkXgQXv1x90H+HQ6NJF0Wj/qvmFby4c?=
 =?us-ascii?Q?m2i9LLmtTNB3Xqk7uOd1MjZ6RrdWORcEVSoNHr/9OSrSc2rN2Ngh8UA+V1A9?=
 =?us-ascii?Q?dcFn7cgWwhSwjCy/1xs9BqUC7qP3oVW5mvBJ1GmYzOQiZSbcEPCES0RzGQKX?=
 =?us-ascii?Q?uXQTA0aioI+FqIkeh8OgVG6Pm06v9LopRAKnaNK8l1DD7BZCWbRcfo5TtRSa?=
 =?us-ascii?Q?kDdG4WuuwiAzvv6LizvUaR7tbnJ5oU0ylRSHh4Y3A3+4VsRLPi/qF5Psbziw?=
 =?us-ascii?Q?FhQ9xs+2QluA9rg6M9XbMhk/m58/tiI6VERiBzM1XxP1jZgVK6oVJ6/wWwsw?=
 =?us-ascii?Q?bRk6W2Zn7KKgL8quYpNuVfW7iV09JtatSOQiA16ay9moqXCVtUSxc4DnKw7H?=
 =?us-ascii?Q?4veYOfXfrGNdWfxSmw4fM2lDUv2GTgjnGAUtzPl9754FrzSFLiTgKrS0HK4K?=
 =?us-ascii?Q?PI7TyEbQe76KZkHh8KuDj2TOTZM1PRNt2SrHYTUVI3ukAw/XVpVbie20XuhV?=
 =?us-ascii?Q?cYN0CMeMrWKnhhvQD2QUc5fy99hUKEre95lHuMaHQcb+fRsao7/3XaLTpGAA?=
 =?us-ascii?Q?bG7l/Vp4bBYXfFiTiSVVSOhYSpJue/WXMWkdUkEifhy4AH6ShtuPo26LwXUg?=
 =?us-ascii?Q?LXsHz0S2AzdQ6nc7aTP1mO5fCOEKuwneCBvjYWKCLmBEmVHIivl8HbLSXO5U?=
 =?us-ascii?Q?XlZRugij9xvUJWN5wDEHL9YsGTCyp9E3JSkOqtGLl7yhLbjRZqcc4MchwNmV?=
 =?us-ascii?Q?J+femTmiOyMhUXVBIEY2dbRjJ5RgLN2htMi4FYUnZse+zLUbNFwlmEsIbIQy?=
 =?us-ascii?Q?IHXO9AzHmEqDijeVxsG2IZeowHs5ljtXt8+Tp1/K8sEzR1iQ3+j/Zf+8K43Z?=
 =?us-ascii?Q?oFKH9gRyGCz2657yHh5cr/6VUrqu6n5tVBHwIA2zIIiU3Whuqeel82JQfjmQ?=
 =?us-ascii?Q?BhSUIsLHuy3FD9HmFIzhrpvWaKRJMSDIXLpTW0y0zDA4sgC07/ftnYQIOfa7?=
 =?us-ascii?Q?DEdjQ4ZN6uHJ5no=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 13:56:55.5381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f23398-8b16-4bc2-1931-08dd4b6d1c64
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7295

This hub is powered by digital and analog 3V3 power rails, so provide
the possibility to use different regulators for digital (vdd) and analog
(vdda) power rails.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
v2:
- no change
---
 drivers/usb/misc/onboard_usb_dev.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index 317b3eb99c02..933797a7e084 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -23,6 +23,13 @@ static const struct onboard_dev_pdata microchip_usb424_data = {
 	.is_hub = true,
 };
 
+static const struct onboard_dev_pdata microchip_usb2514_data = {
+	.reset_us = 1,
+	.num_supplies = 2,
+	.supply_names = { "vdd", "vdda" },
+	.is_hub = true,
+};
+
 static const struct onboard_dev_pdata microchip_usb5744_data = {
 	.reset_us = 0,
 	.power_on_delay_us = 10000,
@@ -96,7 +103,7 @@ static const struct onboard_dev_pdata xmos_xvf3500_data = {
 
 static const struct of_device_id onboard_dev_match[] = {
 	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
-	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
+	{ .compatible = "usb424,2514", .data = &microchip_usb2514_data, },
 	{ .compatible = "usb424,2517", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2744", .data = &microchip_usb5744_data, },
 	{ .compatible = "usb424,5744", .data = &microchip_usb5744_data, },
-- 
2.34.1


