Return-Path: <linux-kernel+bounces-256985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32793739A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066181F231C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE582D8E;
	Fri, 19 Jul 2024 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="oKTen0wY"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010022.outbound.protection.outlook.com [52.101.128.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58154DA13;
	Fri, 19 Jul 2024 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368802; cv=fail; b=c46wBKpXfY4fJNDVnngGyr8pjy1HWXZleuxCFtnmvmYZJUU9yyuIWsh2UHn6UeVY56SVn5SDdkYKFCOjp5bimyihlBDKVEGuOjWaudf3sMVG94i36Nblh5ZU2FvzVKCAClWGDUG2Mbt7pRYcUnqlOV2X/XeLPrjmLzazQGOAZEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368802; c=relaxed/simple;
	bh=9QLFR+VmV/z9TnXDPdlSddPjyt/lOEkotMb2isambQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i92Dvmbfxbb8M8WyQNlksXfKnbPBWVFd+yBl/Ta1maSdMREWkFiE+owSGBZ2/wgJDfCK5Bz6CdPSeBFIG1KCk60RxuNUVoPuDoVKo3zg+leGkTW2rVOikPk6jz/6cqtjzwUkEtyyAn8lxZ6X0GltpdbcUkhywkCroldSMjQ8myM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=oKTen0wY; arc=fail smtp.client-ip=52.101.128.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giZTT2qpoC0lHzJtB2ZFGHFwM38hLlTb3NuV95T6nHO2rOV2FnEqQ2lpdMjPzTTWB96/wEeihvNHwoHnYzsRBnK+2oTkv+q28iAoJl64niDWiXWNHtuju5UBYOkFoHDVybNwgt1o4WrXXooeCcZAqF9+MukZ/VzBwx+22Po2AX3rEbEXcwZ0TMRco+6M3GfKvYmWV8CEH/j2T+jBWKF+bzdKZyaBCr7HuToR3R9+15qaydQRG3COrpIqbKZDe0KaYASv7pW/yM1Zr9PNnVA6cswK0S/SEHvkBLeuCHmxiXDNxSA5MZFM/55dGCvnN7vNsICvC8YvbNoFkFJZB2wdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S11d+Rgg5XKlgMlTPsawAewq2X5TMPnusGFqrYm+mrA=;
 b=Juc8XQAYcmr3QP1kX8bm7xNaxEnFkeh5Gn1Zpf+Gvu0PoaCWFcauUTQtvvHC6MCEahiNkfP+Gc1Rhzy7Cxn5ola0IGnjmC3+fqotl+QYh6D2M59bQue1c02lDUM1OHhcq1+dpPYLZIl4mveMZ/guWxdqWhIKhVkRsnhnabVtl0GMuaJx/ihgQYcbDKt8DlGQmHSAVKTqYR5EiieWhsyyr2bt02Xalzyve9iWae2WKtAci7Jl4hXcswOtRTHLzqWLNgaevK5MjQ9v1kEHUAGKMm9FTmcLe7FKHrQ7qNnVHVaRsRJdbINITT3bg+ksHW1zmmWPLLL4usAAna94tgdraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S11d+Rgg5XKlgMlTPsawAewq2X5TMPnusGFqrYm+mrA=;
 b=oKTen0wY5j3uYwuYI7/jD24SMDCf8Rm2Yfv987F830FtPz62BMa1x6MEnxjWbB8x05SZ2HmlmsGcIuRLniTGPy0ifAwlxsfJFuj9bH2/a2WU/vG/uX6h/E7My2EDRBBXEUjRZyInPnKgtL02rLX9FC5zKq8XHb58QGgitfhSEl8otGDUTJeiWqrUq6/NcNmuQkiOngBXmgRPf7lwRnERSW4ZXltybETvgQyzDhAZLPN+oLB89mxeoStJKZc0oPDHZJO2nLQ0e1Kdh/jjK/jdHQHTaSPJnzqJORrS+uMyQR7NlvJWPXxbXxIWGr5q/PxRAlIHykRRKcyHEh5t1lbL2g==
Received: from KL1PR0401CA0036.apcprd04.prod.outlook.com (2603:1096:820:e::23)
 by SEZPR04MB6657.apcprd04.prod.outlook.com (2603:1096:101:e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 05:59:56 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::22) by KL1PR0401CA0036.outlook.office365.com
 (2603:1096:820:e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Fri, 19 Jul 2024 05:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 05:59:55
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
Subject: [PATCH v10 10/27] ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
Date: Fri, 19 Jul 2024 13:58:39 +0800
Message-Id: <20240719055859.4166887-11-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEZPR04MB6657:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 18577245-fb9d-4505-3fd7-08dca7b803f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W7ukNkk5iynlbPeUD+pSYdVgQ6cuK96XTDeIjDbBXEzEFwGek6EL680aGF/c?=
 =?us-ascii?Q?UOEXRAaM09EicAMzMQzgB+7d5myLXrsGtf9zP4x/2Vtg+GwFcoPW6K0G28IP?=
 =?us-ascii?Q?wX1ap96a3DTMYohETbIuHZGSIOVXQBQEFiHbvGNMoV450b9PrqpFMFXfWbTV?=
 =?us-ascii?Q?0IWZENLl+aCNKFtBcRLRiHidJlkRzhnvsEyw9TgW4MwjGhc5x9Luvi5wT57S?=
 =?us-ascii?Q?yBYgQKOsehmzrLrLzzxp+47D1cAvuYEIGdJFu5pYZHxjCVLeI6ZXMe+diaFC?=
 =?us-ascii?Q?mNU08uvmT953Wpr4Kdx8f2sLtkBIbCp0FYr10jsw5OsNSgGicXLQGCp/UFkx?=
 =?us-ascii?Q?4XdUFFicnnVdQLlpVdBIH7KAvAGOMjSTR1s+/+Lkl4w7imFVW4gGM4X+1pTq?=
 =?us-ascii?Q?E5R7aOslUTG3SNrC/8g4cOryfk70suingyscCrHgHTYtOBnuRov/5kaLV9xu?=
 =?us-ascii?Q?dV+tuGy+ZSiwPryiv6b9hS5bnji78ggwptXR0WMuKL1Rvb7ZUr2E74IhAH6X?=
 =?us-ascii?Q?sMH3VXJ+7JwMe1QoASzLvxAXdImrpGWSQ9qOHxr556LKv/NFMB2rJLuvivbn?=
 =?us-ascii?Q?HuKtyJ21csgPv2EKK0I4raMXze6CuXfM0Y6fEeOmlUa8DhEdRRf490QBp9dh?=
 =?us-ascii?Q?8MjPXIcjZQEaGsI30Eluo8zxYp5CQrCIaz60j/F0svv7MdKx9ABmOOtB3+Og?=
 =?us-ascii?Q?p/TO0Ub7JDaJ4/8kaXFum4hkV4+mf32oy+GwHsZ9NxScNhmrg4ecbhKAkhyP?=
 =?us-ascii?Q?mXsd4b9TNnmIZgLZnJMEdKvhBTFCT+SNI30KNEsceOs1lE2WF94UMpCQX7f4?=
 =?us-ascii?Q?HbvRz4nqR8bZdD/QiGjrPZ1Akiij/LuNC03n80tZZxdMwanYcRbtBSH996Kb?=
 =?us-ascii?Q?bCD9zwk7rWR8oq5nvY/KkvDrZyclEPYbscnoNwl1H85XuxV2RfxsRrzLQJAd?=
 =?us-ascii?Q?QlzhvQlZW9qgn78fsMPwKJHHdrf10XRqsohdhj3+mDpWt/OX8Bda+PBBg/uG?=
 =?us-ascii?Q?JvhgBgmnZ8OGWCZRnkJc9KJTHuCb6vIStjfAZWW9sInw1vVsqxbxQEL9uv72?=
 =?us-ascii?Q?jDvQRkPEbB2D3ixLpyq5rSNDGzdHX/w+Ab5IBdG4ygUCA1ItXfRQanWltpPy?=
 =?us-ascii?Q?DQbyVo7KAtGg+wVle48E12CLv6BogHgL14oyjYJ4rpzrTaNetd/iMtlOUd7n?=
 =?us-ascii?Q?FEtdpXlux7ea0JvSzjBX+TGjnDXvfJNECXJcurmjPTDwYellz1oCvf3nxHlk?=
 =?us-ascii?Q?DZlZ0/v74YHapNbGui/C9gSz3dCDqq7sBeOOsXd+c93czeyQrr6J/OSJ/Y67?=
 =?us-ascii?Q?K6SzscEHfC0DgLQafSMpjVRvId85Dc17W0C1EJo0qpai0Fp0PDiHH3enSAGv?=
 =?us-ascii?Q?8CfeoZHKgBNp8Ob9+xdo0Se2vpTzx8AQXL9pHNOn+s+OedrFwoFhx/E4p2dt?=
 =?us-ascii?Q?HKFzq8A7S8+qyrAzySf4AoOz4l+DpDBD?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 05:59:55.9387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18577245-fb9d-4505-3fd7-08dca7b803f1
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6657

Add power sensor for power module reading

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 92733a8ecf0b..2ac872878acd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -906,6 +906,11 @@ gpio@23 {
 		"HSC7-ALERT2-R-N","HSC8-ALERT2-R-N";
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -930,6 +935,26 @@ eeprom@54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


