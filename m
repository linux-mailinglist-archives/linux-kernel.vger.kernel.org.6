Return-Path: <linux-kernel+bounces-259828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB996939DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1AE1C21D07
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C01155305;
	Tue, 23 Jul 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ta6fbsbC"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2064.outbound.protection.outlook.com [40.107.117.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CF1552FE;
	Tue, 23 Jul 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726693; cv=fail; b=ujyAqY7bQZ0PiHax7fZ5fJBgq13OZECzHnuZmtyehhOFAK8ikEDCxAcE2AXnJvp1D1wvhMxJ6OiiF16VvhwCGs6NN3LFFSmxvXDi91Vv8WwYk8fdRGM5bFiYLYeC8M2HYfS0Ne/uFUfVA/QdLOBLIaD8iY3RJeJCrjJ8Nk30VKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726693; c=relaxed/simple;
	bh=javoh9yV7WrDdF6nED6Caxxup6WdbdzzX/IVbBhNWOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rq/KSKRJnTR8vMe/InO24KzzaH0pEHcOKooqMR3Lvjdx47gOqY9fDo3gtd7xEZpSaI/YEWDECTy98mCZyoi9bwX0fO4fo/BuZwNtElHbzb8pAPfHPd6JrVfqJqWP2hW6S3GHZJzI8OWl5e27GG0DqQznPo0rMmb1hbevivJf7Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ta6fbsbC; arc=fail smtp.client-ip=40.107.117.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRTt2cKfcFWpUbQOIeES6quAVIa7L6arecapQQQqP8q61lm7zTXEBMSPn6A4L4oxDIqsV86dQXQ16XUAoRlcicNaPNZnBI7RTvP7Bofdyc5mMIIM1s//6THZ+EgZbR+r+TtPg9+o9s78865ZF6PgpFEk115hL1efsL8tfhw8IBkukvVrTnj8ZScoi+Cy/12QgCaOX9cmnxomz+vGiGA0KYNUXLfcf9g8EZQS0KUgtKL7PT//m3lOvXCJpjCLgmU+DNHWDFk+a8GP84CvvB/RWjtDjEfCpqBJ+d7p7QRKOOkfdGn3rKcUJFPw69AAjt/B8GJ0c3SMSFVz9yjWe7MTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE8IuzdQZjntYqD6nUPQnwn7C+BubHdv/yTEbKi/B1Q=;
 b=tUSNqAtRi3cIqvc2Soi5U/DbdOXNxfQxpYtqoG5TlV6Rgi2LePH6UHaHd1CxKeLEft396P6XP1iHrhmTWvZPJ0zG59mvqlixEk/2AX+TU/E7MjWT6ZClxVE3dh/Cc7dAZuxlvNJBoJObWP44erI2W1/l7M3wACbG22esESOBhZzW6DORf0EmguyHoPqDZjv4LxL3Fck8Uly5VzcEGatdV2rzu4gUwZb49sZF1bVARd+7Na1Ve2NULgYiPhucyJJG9QVHbR/f1VhhKk9NMd+IV7P6lFgJUMOMv669ZmuFIt3TCmO+Tcl56q/AMhf8He/5+JnOPg0PAgmx3PlJTONo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE8IuzdQZjntYqD6nUPQnwn7C+BubHdv/yTEbKi/B1Q=;
 b=ta6fbsbCf2qvoxgT6u2XmqV4dquQDsID/N1fcLqXz1DTlLmIddL0l6g7aE8Ey5AViAKUM4kAiarUU8qCWlBXhZLE4UyCGeqnrpu7+ghOX7HEO6vlvjyVQFDO/cABTI4/ajT1fbQX2s3HsTXSyJQ0hVVh4ekpNXbdTOKHgyDDzNTfHhAA7V+z50g0EaoI8fKDxsHXrF3hipGGKfc2GWyiIcD3tF1nQH0oXXG1gYgGTKHjVmSQxUcO9kjmRMiGOVjheA5MYejpN8drI0M2pRqifkMNfgL4J1azdY4pwFE9mSiRFrGKsuLpxiLqBbo/cKAPGGKHP3b2B0zF7FEJssGB0w==
Received: from PS1PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::13) by SI2PR04MB5648.apcprd04.prod.outlook.com
 (2603:1096:4:1a4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.12; Tue, 23 Jul
 2024 09:24:46 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::2a) by PS1PR01CA0001.outlook.office365.com
 (2603:1096:300:75::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:45
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 24/27] ARM: dts: aspeed: yosemite4: add XDP710
Date: Tue, 23 Jul 2024 17:23:05 +0800
Message-Id: <20240723092310.3565410-25-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SI2PR04MB5648:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9ff2cfdc-663c-43c8-4ad9-08dcaaf94aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9TGlnhFpRXUUdEpcbWDBAVw4VnJL64T4J276hT4krwRD6RMa7Qxf69DRk/5?=
 =?us-ascii?Q?ak1TIXpQia+2z+pKd1Gn1R7fOME2nypkil8YwewkR9DPOoliM90LybGTmAyz?=
 =?us-ascii?Q?dhHFmiRkfUGviTq+XqCtfBIic9VLp0WynPDKE/P41MR9qH7LhhODFWspDMRa?=
 =?us-ascii?Q?5DoX3OXNzVaicKjku8bHjuE74LmDlJLAqNDWc/eBS8BazdyBNUggBeX/x6ra?=
 =?us-ascii?Q?pr9janJAFWgmaFEupQv/npbi9OgC5WagI8BJeGfuFZSkxNnkTE48+tK172zt?=
 =?us-ascii?Q?4ct8i0H235csdhVd2YoGPcXDNWNTCsbjNr/wHJsITs3EaClWYj18+9bn0OaE?=
 =?us-ascii?Q?KH+wo1Wa3pF1ew2eGhDdwFyZr/MUHKHG8W5TpH2uilW43h/tYxo1Ctm+HQTS?=
 =?us-ascii?Q?n99x4ZZXDHEe4nKT8cNOHdRYScCJvOOs/t9nXIS3mP2mhyNbSNW2b+prT8cX?=
 =?us-ascii?Q?6zAqJXRIEZIV1wjqkaEBQ84WZMUXDoHnjPNagt0lqKVtrMYBrooMu2V6yFxY?=
 =?us-ascii?Q?6gU6H5MtuPCqXD0FmE2KFOE4Agdm3bW32QNkfNWfy+4h4XK/k3teQZEbsZIA?=
 =?us-ascii?Q?RkEKK/gVLXPWkJUM1jh5ewDS3hBH98QrvjuJBy0XrarLNmJXULSIgUdk2HHU?=
 =?us-ascii?Q?dON/Z+YRFNB21yp5W5w6/M9noogH7xvaGhjX7xofwsbyWcUIFHcQYXw7Ccp/?=
 =?us-ascii?Q?yVNdCV/9bH3/Dy9spEgsje9T1n5mhPC/eWnPw8E4ZwYynTnsZ24/YWcbGUn3?=
 =?us-ascii?Q?lV959DkGvPtu3Ng3PoAdJwfxaPs8qAdOb/0k0ZeLyA+ysdrbQVnFR0An4BJz?=
 =?us-ascii?Q?mU4K2wow208KHDzDJANiS3C8MS6iUd/u5msbTAP18lRkXvVlHN6BHVvdy7JX?=
 =?us-ascii?Q?55BCvvhHlBQGUpcbCZV8YYOFH6FFif4nxGD5k7g/IbAbM4OdkZFQIo5GxIsS?=
 =?us-ascii?Q?yFkeG2Wfojf4B8BzQvVBtRWYiTdtTE670rcQPdk8SE6Bgt6kSwDtw3C1cvM7?=
 =?us-ascii?Q?oDrQD//uO6cYHG+1JJbpjEWN6U61fe3uueS/sfS/2MTCLXCyTd84xKbWbp95?=
 =?us-ascii?Q?EdrKiRMr9diBOgLmEmdmGkxKiuEpHV2OrHyVIWz5z+MT2Op6QxUzF7uyQHre?=
 =?us-ascii?Q?+m88FEcY3o4yogSDqa7xIbc+v3/zbqEhUBD5HAJBwUSxzQorn99Q6FYnndnu?=
 =?us-ascii?Q?HPEqikDjqNAdJveripgPOt4423tNWOt9yhwawROoI1FELSX5A84TRKtC8jrA?=
 =?us-ascii?Q?xxPymlThmN5xczThz9QE+ZMwP4yJp+XAu1gbCw7aOeI1jDvfEDCMIX3TZKbe?=
 =?us-ascii?Q?yqsQoV0RTH0hU4xZgO74YaLmfSH2KwQByl9viFwPu2q7KfOKtaD7+PgcFSc4?=
 =?us-ascii?Q?ou+pc/ikzfLL7uTB+uZ4hw0nHSodgFrsgH5S226drdQ2Tf76a6RKCqt3OX84?=
 =?us-ascii?Q?rNsqlsNJGixSroiaoCuz+Z724pRV7CK2?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:45.3636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff2cfdc-663c-43c8-4ad9-08dcaaf94aa7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5648

Add XDP710 in yosemite4 DTS.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 2f4e9c5edd5a..f73719b3c2f1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -978,11 +978,21 @@ power-sensor@10 {
 		reg = <0x10>;
 	};
 
+	power-sensor@11 {
+		compatible = "infineon,xdp710";
+		reg = <0x11>;
+	};
+
 	power-sensor@12 {
 		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
+	power-sensor@13 {
+		compatible = "infineon,xdp710";
+		reg = <0x13>;
+	};
+
 	gpio@20 {
 		compatible = "nxp,pca9555";
 		pinctrl-names = "default";
-- 
2.25.1


