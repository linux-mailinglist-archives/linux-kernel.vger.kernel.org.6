Return-Path: <linux-kernel+bounces-295247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39247959904
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07271F2344E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1735A1F9013;
	Wed, 21 Aug 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="laNqxSUf"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010064.outbound.protection.outlook.com [52.101.128.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DF1F8FF8;
	Wed, 21 Aug 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233307; cv=fail; b=cv1cglOTuSb3yQTWtDNboMOLWi+U6A6rOT7MylZtaGxeOVie34by4UY1x+6JTvchACnSY098qpEvqr1YW8LjUziqo9SsKNz3YQsu3cdncQOzN1AO0w5pkYOsuTLxDs1HSI4Ax9LreCe/8M/PXh0EGakgGxqCkVW/O/LLNrEOxGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233307; c=relaxed/simple;
	bh=FOb8jOZM6I/Yf4bmbBSziNy2HqRVQUfHDF/sd4v9AWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEupd0AqGpU535kBV7Ofx4d8/d9R3K2LR9kA98boFbx1Q6Nof0RJ8cxTrDw+IavdsMaHMatCAe/Z5vRdgCs6TsPBZ2fENhjyOphUwHaeNG8EXqb/BDszdaGVmkM9V70Va9i4ZOo+NeDoLIWQerBKEzqSW2TDAxtpjH1C9e6hNcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=laNqxSUf; arc=fail smtp.client-ip=52.101.128.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy2/6w+c0+r8SOCdZy/0npIgmuOp1p6bzeaLbIgh8sv7WLDm8/ZjGvtpUaLWG/KTbiywaSdi5l1JYVr8xs+xv1Lyde6UmMCOlT6w2rDdY+g4R2Ovgf9nSkpABy3C0iiWitC4/nwjduxCoh1w2aC0LJb82PVRnfiNSdtgoA0lYrunG5lEKSio2t+ASCAfhAdJXpejFw43f0vJwdabCgg+nERRYINHofk985ahni03OsDJpELOtgoum3r6s9hjIHMENdC+8/GNn1xGmBDryj8wQkbmuih3ULFRHqPP42zU6j+xf8aMP31X5thu2YRlUEsUpN0uDhrOyjxOuKiKjPAjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2AzjfJFXFA/0WPUqtPxoFn2BZSzzb91uVzc8URhJAk=;
 b=VLaPhZm5flO09kDh+yKlJbAvGC0dUmJ+q3p3DHlXg/TKt/LmUBiO/F35qxLoIjruPX2UeiVwc7MiWVfkRlhZmGXGWYuFMrya1Qi3uwZMozja0O0zIKNsUQ6VwXkX2KeH5EVWKCSoLIpnj98EfQQrAlCVpQ/n3FkURBxDnZ5jYTFv6k3FrFAHkoL8HsKYzAQcr/S1ui3N4bCkxk4l6JkV6GFIdmHVHjdYKlqiLvSrq7k1emS/Qd94IiLcOnYmoOFZExeXkmMuc29Zq03n8WkyDoSzxH0P37gEZ98Z8eKFcw/opT1TeCZeFwdsFEUYqej4xWPy+sCj3z7LmNRYtTPbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2AzjfJFXFA/0WPUqtPxoFn2BZSzzb91uVzc8URhJAk=;
 b=laNqxSUf6BXKp6pLkI657brAfNYEYKJZUmxw+gVb8hYW3WgAEscrLyTKDF2UetTkAlgApol3cN29fifbByrOhSPiOqx8n43p+FX6gLsmOzyGSocyIEPlIqdxqBP4FwqUqscDEPyt1ptrNp+JBhbYms78q8MSElDy32dcyaaMaXcG2b8phMTjr/LqplIX61HPNSqLUtx6iwang7ttQ+QfhwgHTXvbsLHeVcNEzVukKMR3nuhhn8AZaMPeXXpCLCu6fZX1oc0NC47oxW5we7ofTKUajhlDPmipKva1BIa/J6I6pIcj8XZ9deBd4s0erLJVfN6wjKIE8ZCKjQ61wQEPyg==
Received: from SI2PR02CA0028.apcprd02.prod.outlook.com (2603:1096:4:195::8) by
 SEZPR04MB8310.apcprd04.prod.outlook.com (2603:1096:101:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:41:38 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::b3) by SI2PR02CA0028.outlook.office365.com
 (2603:1096:4:195::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17 via Frontend
 Transport; Wed, 21 Aug 2024 09:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:41:37 +0000
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
Subject: [PATCH v13 04/29] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date: Wed, 21 Aug 2024 17:40:15 +0800
Message-Id: <20240821094043.4126132-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEZPR04MB8310:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b89033c1-8e9e-41c4-4f41-08dcc1c57459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R3byIIU2qOo2qoR1cpIlj9zKSZFc0MigOA/VfO7ieniWEtZtm2vbDaJGoGtk?=
 =?us-ascii?Q?COW71UP5BWlMIqbevDwYTeLE1+ArcBqUfou9/pruQC70gTH/207fmxU2A0b5?=
 =?us-ascii?Q?gte13Y6hOeMoa5uEgGFVggNIJ3ciqtz0xVl7B6qljlRg3Tf0cf0cYcnV6uos?=
 =?us-ascii?Q?WT8H9ezqOHhOj7+5y6J5ue/m7sWmON9m5idz/bRMFoOj+4lfiLLah85YHrh+?=
 =?us-ascii?Q?f3gXPMI/gPv2jV3prvKpo6Hkn8snNLf08n0m4jdLXnYeBhpLCy6VyoEvTKFa?=
 =?us-ascii?Q?cqDHS3yTqUEQn7KwAFrDeuxoZMErdl+cEWAkCVT+ynG4QBkbg0/xLBDGaetY?=
 =?us-ascii?Q?fdP1RjPrTNqtb0fVGnq4VQ775wEz9s7RHy9eXbFj89CGQm7iOONhEmAA15jB?=
 =?us-ascii?Q?OCOLBfnmkdhUfjCyTzA48SGuL2vodTgbLT0cvmlmTdakQ+XKUz6Tt3GJWu6m?=
 =?us-ascii?Q?Wqu+mGwdA+iCeA6FH29zq++F9pIx5A1Y/RzeeKuC/KlViXkwPHyea4V7J9xp?=
 =?us-ascii?Q?k5NApH0ZZJRPP+Z1txbwkNT6L5bMvmz3AcqCenSnpfvCxeiifBkW9/dJCjvy?=
 =?us-ascii?Q?x10fSCSKSacuWBkKCDI4VbPcwkAz+FW5TE7bto/svoBAto6czwfLia0M18Ug?=
 =?us-ascii?Q?eNl6BBVUa94/yuhhN2awpoMuidnYhcmOlmJnAw+Lx/HT2aofQln/AmaQDvX/?=
 =?us-ascii?Q?jkwhZ73IPQuHljxOitB0L4h/6NiMPJJiSYdjYvl74BHYCXeqC7rpYBlhqYgj?=
 =?us-ascii?Q?nDUB9Ww08IeK5V/fBMozamoW2ogBvyynWrDorlvbNrFvp6KmnTcIBCLl4ge/?=
 =?us-ascii?Q?pcwz1mjGebvrNaU+Lw1IclRlRXwPo/e7AQSbM97GKghc2oK6LANgWj4GgJSt?=
 =?us-ascii?Q?pYFAqZkBMlKUugQTc6iB8+GhL68a9eIkiS6V7pyxcuEgQve/dpAxotNeomTm?=
 =?us-ascii?Q?SenQq65hagwznp/bEfMaQMwAoTeXrvrDmBRnIkl5ncIeABqZhOoiLGk2MCAo?=
 =?us-ascii?Q?Ny7SIVeJ8JjU9NGWA7B6h6c3BfXnk3Vd4PjFIzasa/UDMX5u7xL5a5jJlVAY?=
 =?us-ascii?Q?DPE8VwAfk2xzJ/7nq7ojeDQC/4pSrZ+uI+jYM8x+Y7RQ4TjN9A7bXP7gexFY?=
 =?us-ascii?Q?l6+AQa6lR4ajmMhxpLBK+qmDENEI56GlgCkPCFO2O53/L57ebVYDwjE8RTgD?=
 =?us-ascii?Q?4OCR0QXLCJHgHbkZFib3OSAytsrhSiy/BfU9o7zZi2KwScDX0pS7/x2fdM72?=
 =?us-ascii?Q?KtxePvdz8nenV+rhcNScYKElk6XwkwPDWPpoDuXdiDU6EAdyt70ZmM1NIk49?=
 =?us-ascii?Q?h9wV9NNMR/MHESo81647h/yNU6BAjZP2WFhqHffflaN5ekTJ4nhDUWBihIjH?=
 =?us-ascii?Q?DfDvMCRcVxV4XWwbaYRffy5GFLSqY19x/v27p6cBeSFppfUqfwM0GF/Etrn0?=
 =?us-ascii?Q?C62yok5GQzhuClJPs3+Bd+WEZv2M9ShY?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:41:37.7620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89033c1-8e9e-41c4-4f41-08dcc1c57459
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8310

enable watchdog2 setting

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 575abdd530df..51b4e9ae13cc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -120,6 +120,13 @@ &wdt1 {
 	aspeed,ext-pulse-duration = <256>;
 };
 
+&wdt2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst2_default>;
+	aspeed,reset-type = "system";
+};
+
 &mac2 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


