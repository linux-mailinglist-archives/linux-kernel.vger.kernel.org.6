Return-Path: <linux-kernel+bounces-230371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB2917BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED871C214DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F417BB23;
	Wed, 26 Jun 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="pIMZyt0/"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF519179665;
	Wed, 26 Jun 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392919; cv=fail; b=ouzB0msVMt4QI0/oUXoaHya2IF7R5922XbaxDGgY7tzle8mTauuCHvLRW/khwP4Z/73Mx3aT+3zp/vgcL/S2WeBjqTCzZK4lfCHqPdvFDApdshYLAND6BmAjKNpTspNZEW9yaBG2o1xptrA0LnePpn7sjDouHFhDJHSXuciDDyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392919; c=relaxed/simple;
	bh=9QLFR+VmV/z9TnXDPdlSddPjyt/lOEkotMb2isambQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aX2LRNKWPQdVBGHcsPaMXzEwDj1uAFj72VBuWS6cjVt1Dmk7ARiparHor7qlTEogHYzpz1AXoRGvMYDj9CoGBibVcDErbeAigHXM/BkwwJzj6LWKBD/rvUzcAkU0xJVjPaoXAMd+enF60/Gz4WvLy7enZbqVRuYa1qJOvsBJy1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=pIMZyt0/; arc=fail smtp.client-ip=40.107.215.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzuzvICBF9tWtMYUmRjxOG7aq4bwxs0ioOghy7+EjuD9K+uVOD7TxSaUGqcoWcPlOV2L6yTRIsrWHLctawZeP56Xdgd8xmiOxvJbYi5veMHeuLwkRG+TJkQqzcfW7yYYdkUPOE2bYzSg1F3Tve6chVUlMd0kh8ALu6Rao2oTkngDkmBfneVoCO29Yy/3Y3Tmr3aM5ljZU71dqJQg0cvYxNzyoylVYoFc0bOFtcXENQpIlpERa1Bri3j/kDJFXK42AHOLH9klcA/fin9s10F1OKP5sA0EaEMnRJeyCYWVwEs0yDJ8HoX1U/AQ+Bgg8fEjgp/+GFtqCy+7IjuTELLz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S11d+Rgg5XKlgMlTPsawAewq2X5TMPnusGFqrYm+mrA=;
 b=M3yGdH2cwL+MFxklbRZ6SVRx4NQvUKPxZTAcn0BextOi2JOdpM2uvMk6FS5Ttfmw2Q70nxSaZcyU30VnHgzQRsevqJkXEQuhOu2V77AFwNTWKg9O4vP+nMOpIsTIymb+YwTmt/jzOYq5W4mudKqnx+iUBPlpVer0YJJIElTDRBFZ3vXP8bMJpCcUbNKUobCNZCI7bMwRBAEFvimkO0yzlorBN4w4X6EiMY4T9CKvP42ekxMuYvp3A8tOMFbwT4bMKgRKiJTee+OAGmy+5y+A7vB/FtaZ6GcLWY0/us7DiNhZOWJReVvIOSNCsg89mcemIFhrJsdaint6Ate0KuSlEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S11d+Rgg5XKlgMlTPsawAewq2X5TMPnusGFqrYm+mrA=;
 b=pIMZyt0/2uubIpuObC+2Kqs8xSMTzxqgh0+JOcScFOOVPCAM1b0y8zLk9+AQpHvVZO5JtJ4XTC9JkAKR6BaGAvQEbpjO/qlf2oCIiHzCmeXRoOLX69TvUvL3C0wvaGwry0zlMQ288B/0rGzWWKRv2APJh87vZrX2PPUqKywk0mX1dYrOuyOSQaTuX7L7sTTXikR5DNCz1/eDi7uFuqX4mEhmUPa9RucTGaw6qkoc0d5ja6vgCtKvCLi2XlEZhaFGOMDpUJ5QJfWr+knETrIyU/fYQ50L3+j8XOyu09oUV+w4DMsinGn9qW46wjrN3rw2Zx6agwIjlNdMrk/o/mS57A==
Received: from KL1PR02CA0002.apcprd02.prod.outlook.com (2603:1096:820:c::7) by
 SI6PR04MB8080.apcprd04.prod.outlook.com (2603:1096:4:242::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.22; Wed, 26 Jun 2024 09:08:35 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:c:cafe::39) by KL1PR02CA0002.outlook.office365.com
 (2603:1096:820:c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 09:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:08:34
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
Subject: [PATCH v9 10/26] ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
Date: Wed, 26 Jun 2024 17:07:26 +0800
Message-Id: <20240626090744.174351-11-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|SI6PR04MB8080:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf707e2e-97d2-4e78-d322-08dc95bf8f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|1800799022|82310400024|376012|7416012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sn0CQ4K5iTTHE5duMo3nk1qSuo8N2OqgoDADEBX1aHJr6luw7aCbAF9yAhvK?=
 =?us-ascii?Q?gWq24WEELm1oRmoOLSTyPlexeV+iMQBKZoaTtd0pZUXqJ2yzWq0KsaJppq6G?=
 =?us-ascii?Q?ykXmT7ZDXDty33DuDL+vJpklk44Xk391CAqs3RstdgY5DHK2pGmmkmuc69D1?=
 =?us-ascii?Q?V6prYCkv1PpvQ6IrtxcArr/OCDzwz46Kg69sbxlLptIUdJxtZOoGEN0rvhfD?=
 =?us-ascii?Q?EudCzcF8SJ2d2rQa635+syv1aKkSRJEYUrE7eQ1im3jfkL+aBLQYrUm9G2/S?=
 =?us-ascii?Q?BkLSUiKxt1146Jc/QCbHPgV/1EsKES2v/cO78trC+VaJ6FYEac3PosUrfUcV?=
 =?us-ascii?Q?wnt+qcVLl+WfQe2BO87jFiFHT/LoVnqDCvzuuFKaCMCV5cVcDNjnk95PRXQF?=
 =?us-ascii?Q?DrfwRrd02T14IapREyysl7ReQp0yfu1xmO+CodcoYMzh6iUITEz8qLIEL52v?=
 =?us-ascii?Q?6Ys/Fl0AMT3gybSllKnBLygEh5AitSh61ynYFIAmrBKPYz9Tji7fH4co9lxx?=
 =?us-ascii?Q?khCr0NcmMswyy4Q/rXvKyrziNVdRGCwb8Rrxo3ErJADdlr/8MM59V+Oa088p?=
 =?us-ascii?Q?pzKU6FcW/pmuYQFgpBAZWJBGS46s9IAJtGGovT1mf/rh+IPjzsKtypkpOWWB?=
 =?us-ascii?Q?id3DxvcQYUEDNTiyvJ2cmtYZn08Pzfsy1Jj/c3SYCiYt+YuxUBLkNKUrWU8i?=
 =?us-ascii?Q?NeVYFs2EisL9FtO8DE9GkQUlOZIxSP5oX2EUXOcPneUnd0tZrqtKOG4JRrYE?=
 =?us-ascii?Q?O/uDEMmjoPkhBZyLwBe53EvnPG6jbAwCsrLVYMJIMZy0JLwe005B/T6JoSbh?=
 =?us-ascii?Q?eb1LH3B8hBNXpZcZfBrUAMvGBbnU4+sMeMar9Wh0ZFZZvH2EjFvyhGVerJYr?=
 =?us-ascii?Q?dgGPa009IH0ctEMybzFZzedoGCp+k5M3bweI/eyHBvJ2rCAFHRrK6DE8BX1q?=
 =?us-ascii?Q?8wdwxjgiF/tebgQUT433FLuscjGVaGl4uuBYZrL8cTi2UFB81qTQk0umXvwU?=
 =?us-ascii?Q?fCOWqvpKZlMWt6varHXCJMO0t+JAjD6rZeTsv2ad7ogxSktrmjhXtFlLCDm9?=
 =?us-ascii?Q?81/xDMNgg7dyyP8G1taL2WBzaE9AeSJr/6RBQxICBeaGhEbs5JpwrnQGF96D?=
 =?us-ascii?Q?fpa98phdeIMN3SoLYgF289UB++NxnXLFZwWcYq/EXVS/i6mI6vviuUiQvUlh?=
 =?us-ascii?Q?u0pilbbyp+R/TdlhaabDGU8mnndgkqJu4ndIPl1kmUiN3tRs7cNDHwOFHIXA?=
 =?us-ascii?Q?WbwmcErbJzKADR1MXj3vHqts0LROthnu9vyljBz5eQO2IJ7/JqPx5Tzq3tlA?=
 =?us-ascii?Q?VK0AFx+zPGgSm2cQnT2qVFn7bB0WblBBWdDvCq0M+U4KUu+evpeUo7mXEoQ0?=
 =?us-ascii?Q?cW1+9U0cP8xEg7fgTkqHJxz61cCH6uluT9FASwD86LJUEsUj8N33uDF83BB8?=
 =?us-ascii?Q?bJV+DU8fK8r9OQfB5Zp2eF9fnLOiF279?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(36860700011)(1800799022)(82310400024)(376012)(7416012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:08:34.8330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf707e2e-97d2-4e78-d322-08dc95bf8f04
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR04MB8080

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


