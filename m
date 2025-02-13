Return-Path: <linux-kernel+bounces-512610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9140A33B81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45FA67A39D1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6671321148B;
	Thu, 13 Feb 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="bgSAX+9c"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CC20E718;
	Thu, 13 Feb 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439828; cv=fail; b=PeNAgu8z4Q87AzP4fG+pW0aWD9DoQNAHfIyZPZ5sdEikD2WmnpaxURUzxN5lAlRQfOQ+5CBGyDsZSkjEftrf+cPbnOsgH9SybboExz8Q40bJGMvsTiNjJlGSTrkUtnqt2WaUGIu3gbEjYFkgP6oRxNwzB5W+PvWaAKhhaAvrJN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439828; c=relaxed/simple;
	bh=Q8W3aeyBtpe10lNtEdNdREO2ddrqsgw3mZD8lGJQbag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNfE+2GJTo5XIEFZJT4dZzbhvi8fBfI0LmbzUfU77yVMvkcAfHKb/z/CUE3qO8fRGT7WXMR6jHtLKeZquOZvXfudKN0OgCneQeoJkYgSwRlRWhTBqt0Hz0l4WLsXLvN7ZaroRfSXGPdmHr8k0QrpF6uuPywqDzZf1K9Bzx6eg2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=bgSAX+9c; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twT1YAqNpYOpFI9dW+CmKFBZG3Go9hVm7st99d0gZEDT6/UFRF09tzeL/3/AdCMyWscOJ8fFRalQak9xTBLlokFLkxaCaa/2v505N81PrAPuDPd95j1+znA0CbLFEjQqf8RYds3psF7It8+eIx58TIg75/dGJ9ycdQHA4KObjG+0S3qFInXC7GFUXS62/wq1fjTDck6UsWLHL9QbP+MYoJkmAEUF+fMlxJYmp6cjzz4okodVHl06IyecE80+J/xQqVq6jpwCmK/L56lPh7s/sTy7qa2szjKIUB+0MS7EhIwlyhWXuvS1axE2VJ92MancDSxbxaGgzQ7vkQZO5BM9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQquAWmLJnBrk/NI1irjqZAbPW/P0L0C66h700M02cs=;
 b=wdvXWEDFO2NP1Xhs9xJ3+elJ0XS2Uh+RhUJLEoZnjEQtERWiyoJN3HVwjw/r0y7BD5iL5iLRGWLALSbD0A9t0BAhyLTfw65tIsr5GARZk31vNjKVJY+n9yZ0dZIknUcGVSRpIW1QlwB5oSZTZze76//G0dYIqmR2p0QK931u2G0dsnSurneS1qKLjrOre1vTOt8Dfiut3AeWL+45/jpiXwQwruaE8DE3a2VfxPjVgGpOlN+74nzkjc2pySN+4hzA2Syi+nmQgQUQj3GiR860o6wd379cerOVc0ib9KkceLm6h/LvX5UIHBwUc/4+JDjwIZBNoU8IgsNkyItBp78BrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQquAWmLJnBrk/NI1irjqZAbPW/P0L0C66h700M02cs=;
 b=bgSAX+9c6Ni2SYQu5uR/BLfJ2f7MBDGCE/mcbf4Td1hpTE5fd+jEHxlbnptOF4qXmHmNSi0dTtRiTGcjgn30bsWDn5KNuogbCL2EpsoIIiIiaY4tCpyl/Qg4TtNoqYv8IunixGzObW45Xy3kxIY4YbqOyE7bf/Bubj+odsihTYc=
Received: from DUZP191CA0067.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::26)
 by VI1PR06MB6526.eurprd06.prod.outlook.com (2603:10a6:800:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 09:43:42 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::4a) by DUZP191CA0067.outlook.office365.com
 (2603:10a6:10:4fa::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 09:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 09:43:42 +0000
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
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH next v3 3/3] usb: misc: onboard_dev: add vdda support for Microchip USB2514
Date: Thu, 13 Feb 2025 10:43:38 +0100
Message-Id: <20250213094338.1611389-3-catalin.popescu@leica-geosystems.com>
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
X-OriginalArrivalTime: 13 Feb 2025 09:43:41.0718 (UTC) FILETIME=[C40F9360:01DB7DFB]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|VI1PR06MB6526:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f4596b81-40dd-43b2-ebb3-08dd4c12e6cb
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pjsafbSrEQ4bbsmk5zETdkqjWEMMDCZzuWGhD4AlcQZi5LKVrOnl3mXYGMXG?=
 =?us-ascii?Q?a9lY7wFP4SW9ZX2dORpA3rbde+dCi4kcMIkJ9UYDwRNU30U+Z3A2sPWlTgW8?=
 =?us-ascii?Q?ADTdGdTv1mcDZzJ2Vx/5lATnzuhm2EaCqH3Xiz0F8OBobItChMlnR0tRSlCi?=
 =?us-ascii?Q?XjAkuOkg6n8eh8Z+WcFwg657NjlJTdnkTmYLKkHXRrT1byY1MXS+A4dBulI0?=
 =?us-ascii?Q?og+GPoF+jc9uijZZUbF9LABGwFwfwUznmm5rbTxHqqsVeWoc+yuuJeZxN7Nr?=
 =?us-ascii?Q?UPd12QFR4A4+PGz5GqPFkqZFKxb1FV2rmBp73y81KEIV7L52OUnAD+sz81ZR?=
 =?us-ascii?Q?KIUfVg5dNiFeSpEmk5Igywd53HsxQmeBEX4m+7joGoDJ+vzZactnsLnzzHAd?=
 =?us-ascii?Q?HAy1VbueOpsEMShbVVHbKhW+2+l+tH1msimjRciuydpTo72nxPOIAALEkvIz?=
 =?us-ascii?Q?WNe1kMBxx5YR0vNDdESj+6VgVbbhnVJnEdCjuYdISyBNys1esg8/rjq77Fbg?=
 =?us-ascii?Q?I+jjXjxngPeHNPWz2zxvrKhf50zC3mSTYInzY3r1dfmsk6RMdkJ0lWjjooDe?=
 =?us-ascii?Q?sAfIJTGsnxUhzKc6Wy5wCrkbYkfH6PFNNz3a1ehTtRmRlXvgTGciTLYumgkj?=
 =?us-ascii?Q?FmZ62X0QRrsjgPxxKmfRSDISpFKm0DHtL/JZwvuyvDnDdFur3mxtlBG4Qk+c?=
 =?us-ascii?Q?o7GT0m/3r6Vc5+xX3jmhfXp7diNAidayV7GfkMmxHiG//CAX8eAmGWCpMTBa?=
 =?us-ascii?Q?E0HiDYTaJSfZ7nlgDOsaZqAFcvpQFN0FdeMGhYWfruJw+EXn85ofwBoiQaDe?=
 =?us-ascii?Q?03CpPehe27OzckDCLoTZSWzqehL8hTZ1nJT+TMo3sW5ceRUeWtpjX5afWWcH?=
 =?us-ascii?Q?CmiNZzXqv0ipwnhMIYOMrGoY1six+W9bLUlAMY9MCO970VxaM7eyxkGmTMSI?=
 =?us-ascii?Q?FVjzKjUCKUkAQ7DcGx/0pSztsMy9b2l+0vcP/jtTJADn+sL4Xz+JuRhndvMl?=
 =?us-ascii?Q?4SY34BQwoFrfolWOvg9v/V6wZ9WhkI4Jcg4huz2g76V8SuW8oVoc5WFaVkq3?=
 =?us-ascii?Q?ILlAbymMkHxdH6VXmRbITH6waoYznp/E0u4RHYbgB9Ka4N8UAW8JiURY7l4Y?=
 =?us-ascii?Q?fawMAE0JNHNuTAVKTh4h3Y6ICW5myXue4z9QvQhNkzeRBvpIymhk/ZLOTghY?=
 =?us-ascii?Q?ZXe3asQoZttTE/TJXkhNXDw4+xZkVcVekwDqOQDXr8/JV9Gb01IlxEIV6PmM?=
 =?us-ascii?Q?JnKFAby9bX8q2c6lMwq45H1HdVrocYqVUDT/ODnDTaQMxo6rzG8rj245UqO7?=
 =?us-ascii?Q?yiyx2Ru0SJu5q341gJnNIwG57318ClpVjJgI5g+mvuOJvCgtZbyKJ5XmNEfl?=
 =?us-ascii?Q?F2fl3egWUVFcCLBtqiNNWKgAmAAoEg2G7lFCPaOgc66Cx6jX3J3/bU+6JtsU?=
 =?us-ascii?Q?L231lm33FK8RmO8I+G42SZQWO4kpaoGLc+xF6j17x5DzPAKW5xDUQ4gsR5NE?=
 =?us-ascii?Q?3zSiPqpaKJLf7x4=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:43:42.0318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4596b81-40dd-43b2-ebb3-08dd4c12e6cb
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6526

This hub is powered by digital and analog 3V3 power rails, so provide
the possibility to use different regulators for digital (vdd) and analog
(vdda) power rails.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
v3:
- no change

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


