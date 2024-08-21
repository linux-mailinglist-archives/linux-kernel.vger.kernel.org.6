Return-Path: <linux-kernel+bounces-295276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064AC95993F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B738B28601A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC941FE932;
	Wed, 21 Aug 2024 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="rTSbkbDa"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010038.outbound.protection.outlook.com [52.101.128.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56881FE928;
	Wed, 21 Aug 2024 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233471; cv=fail; b=o5W+dItDAmMf4Pmu31/7yw+mB0HBuKuBgWSqDELRVGmK7uvDC4B4hyQbD4BkqXk645GZ4Pq1VuvpyY7v+oSPIby7xX1S84V6kRCt1P5pHUHCRy1eRBSe66QgDTuE8ZcM1wTUWQ19GmexYKylqcM6ccIOwq4OftGmZxw6XNZoij4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233471; c=relaxed/simple;
	bh=CiwkhpR7VbJ58wUM7Ct53vT3yoEHw3YDSjBZX8BpqGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6uqX+3mEs0ucuW05RHZ0YJ305Nux4TCIHaYm9HbBN/px2Z6O1FrJEocvfrKLGOi72cYCtk0MC/hsSPjSLU2kA9VtMKS1EuK0e5vp0qkGRPIBimciIAbCEoSqmvDpVIhxet229j0Ylb6hOCtp0zxHYIOvN4GPQ16YxJWG/GGk9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=rTSbkbDa; arc=fail smtp.client-ip=52.101.128.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8CHaoAbXGrw1nmnsR6xgeoaOoANlEy9etUqnALP22PLAnASTt5moSaX4fVh9klJUxQUnEogSPDTh83I6CdGp83MH1CjCKYHHeCPgtg/NEoRKuRFKmSmm+J1ogTgYdDDAjWyfIRnkqN2qjvayNpNRwS9F55L+lYr2buEzoSBeL6gBRTr3QeV/7F/9qLiK1Z+chnIoWT6H4TQgP3TU1LJVe0IkbhosZGtRbiyjvZ3wlK2qazJWFt7rDgPk1Iiq9IQbtIsgaMekvxgw8giB2SBeeASV9ER4KeWd9m0oQYXr6w7hiyePP8ZVzS/cpHzkZyr8lOzOoqQDLdl+mlWFknNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrtsG6giv8Vmzw5ONrss4xcIYIDPtDHUY7eE3zbiJjM=;
 b=QGRribOxmZkE5BckL1BeaL6cjZ5agyVq4yvSG40ARYErUXRjE6p4XQYa0xpwbALvlTNb6p7r1TcChNvtE3h8lqAmR+XLd7B4mLC9Kg8UjbOJAu9e4IfvNl5VqnDqFfjT3epW8a2arhgC+w7NUTGhSXl2BYktF/5uZNYnWlQcwrmhQEn9o6AebDEYa+S13dXHz/31y9LKoQ79VB6sgoRRPlUdBkeDsgB25BRxs7Sz1O0DI0PSv1iTDUBuC2DeH+kfuMS9oJmqQBrQis1aH7WP/6goDt0Txkobb1FEFAlMgp/UVIL8s+bCnPepqpPJrlaGA5z4+yIlXuB76wow0T8NPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrtsG6giv8Vmzw5ONrss4xcIYIDPtDHUY7eE3zbiJjM=;
 b=rTSbkbDarq8Xauu5ZxNGpXIHkuGk62ZTzM1PTiUgbgCHD4SmnuLo5Dfno0xD0Ux3dQog5HhOe5I/xdkNlpp6I2wdGy9+OXsdiEZup/Kt2iG4olHyZOXl7TS32D+rKXUmriBSi0Vfhd1cHSEttybz4REqvjC9n/gAQQxI+IHayA5gTwHg47YA/NDIomyfzIu0C/K9kwzotRZW0m5Z1BjXgQD0Qjfn6Pbmp+njTzvNHwX/B084WqDROKLWkmn8p/QFqyLaE9NXk9JpSfhpaAqHVl55J8ZPEYAUY5jpDgp9xEw7xPxgbyidUHr6qmW3NKaJlNsaCYgLsgqxOc68Vd6F1Q==
Received: from SI2PR02CA0031.apcprd02.prod.outlook.com (2603:1096:4:195::16)
 by OS8PR04MB8301.apcprd04.prod.outlook.com (2603:1096:604:2b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:42:59 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::b6) by SI2PR02CA0031.outlook.office365.com
 (2603:1096:4:195::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18 via Frontend
 Transport; Wed, 21 Aug 2024 09:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:42:58 +0000
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
Subject: [PATCH v13 21/29] ARM: dts: aspeed: yosemite4: support NIC eeprom
Date: Wed, 21 Aug 2024 17:40:32 +0800
Message-Id: <20240821094043.4126132-22-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|OS8PR04MB8301:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8ddab028-bea1-49a1-60ee-08dcc1c5a452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jt+z3ODbEipgGAUClFsE0Z2wC7PEtJPPvFOf00vPTm8zW2c4OMv4S4wlDxgG?=
 =?us-ascii?Q?QIt5JI3Fu31zb4pGOXVUpV6wtJeGbpOzjRirWqDapp5oxKsW/DGvzihlIkMW?=
 =?us-ascii?Q?pTtZ8/Fq7qsZh3OHM4IqDgexN5gtMe5A0XjvYWjtEroc1VaGcvTQHIcqRkK6?=
 =?us-ascii?Q?S7zrnhD1f7f8lFkprfIjJPQgWwoXQoMmNG1bBurrJW/UsFuthsVpYRiaf3i4?=
 =?us-ascii?Q?/DsWzLOcyTRwvnT1PKY1DoflPpvxeXjQ/DVxMmixzVcTaPGqUog/5KfTTf9w?=
 =?us-ascii?Q?rtN8zo4c2Irn7Ug0+vOPLiZO4Ku8G+9bJHhQuNdwtZZDCu+7ZjkVm8PO4Rcv?=
 =?us-ascii?Q?SW1OIIW7ip5Bne26xi6M9ab01U+U1vARQzecvIWbNEDHCZn6i3C8sywijAgZ?=
 =?us-ascii?Q?J4K5YfkERFb3z76E7e6nQ5vtLsihkFXbwckDhdWptN4UWfSUjvBmqBJm8hjm?=
 =?us-ascii?Q?yxvcUVc/km9C4zID+I49deIPQFlkKnC11L2gtdnV+h+hCL5puDOl9dr6Q11C?=
 =?us-ascii?Q?aWv5esifImP+hBFnAw6+gHVEb4jKeIbvI1XGGT6+5ggcXQPweoaxzP4SLNor?=
 =?us-ascii?Q?6tM8xkqsce2/X9SVW6gNVur++jKO1uMEcahcvZJcpB+FpWq2+aqw+BylkTTp?=
 =?us-ascii?Q?dz+sy6k/7Kx4tCLqLt4n9O6aE2CRanyEVy1oVRYwn790JtckL4PU3GZ5rccw?=
 =?us-ascii?Q?C8aBT9+4EX7zA+xobIylmV7LxFCJsfsVn7REKbuiBmbEH/3r+UZHn/FFjXLU?=
 =?us-ascii?Q?F+8MdFkdc1JDWqgXRpb7hOUw7xMFOBU9k4SX4stpCngEFhAVvcLtnVYmcgKl?=
 =?us-ascii?Q?sUJJxXwKka5WnrYzifrZLwb7eETKG9Lc+++7/CMbmGu3xmkLWlNg7gWZrtUI?=
 =?us-ascii?Q?5Hb79b4xEOS+MfP6I2W/vpon5HlZI1E/eCUjk3dWSZ8YWhdwvpOc12NcQ4WJ?=
 =?us-ascii?Q?uL2YcU4RegwqjJNSn2FLry7PKPMSHrdV1sDCHUz0IFnpWqBeALirE8ZIKkJD?=
 =?us-ascii?Q?T0GUtYCWfYVKWCAp3I09q3chAKREISrCivZOJf6vXWFXksFYk3xuR0kXC+cx?=
 =?us-ascii?Q?Fmss0hfYE3NHi8b6Ue5M6nQ5yy6pUh3xOhuB9oNtcwFNGQrAadzA9SEfC4GC?=
 =?us-ascii?Q?G5z01Cw3fvM8bvjeVc/2ULgKWEyNrM/rJJZ7e6M0WD02X5dFbS5CP1qfgopr?=
 =?us-ascii?Q?yK1RtdLyw1qCKNDCEZiJNa1Or2MZ772LT74Hr857I/YViye/f+VyfrZDxFVV?=
 =?us-ascii?Q?bG53fE1S5JeZDtJ/RLgl/vnJ7vzCFBbEWWKClyno8bCeCTPaZYiJi+ijsqg7?=
 =?us-ascii?Q?cANujXKnlMeKWglvofttwoXzjBq1v6mnS0e4QeN9vt5KDYtf4m+jz5OQI2nG?=
 =?us-ascii?Q?RZJBHrzLw7p3iI4YV/RNazLuBHGC/envuKHZSzohgKfB8GZzEXhdOPNJ3J4Z?=
 =?us-ascii?Q?vovZzD1Gg7feC7xSnZQDsxzdFgBu+Hie?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:42:58.3098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddab028-bea1-49a1-60ee-08dcc1c5a452
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8301

Add NIC eeprom devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 49500db53a13..c2994651e747 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1338,6 +1338,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c@1 {
@@ -1354,6 +1359,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c@2 {
@@ -1370,6 +1380,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c@3 {
@@ -1386,6 +1401,11 @@ temperature-sensor@3c {
 				compatible = "smsc,emc1403";
 				reg = <0x3c>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 	};
 };
-- 
2.25.1


