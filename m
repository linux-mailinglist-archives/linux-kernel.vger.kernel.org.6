Return-Path: <linux-kernel+bounces-522866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AAEA3CF66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1FA175077
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609FA1D63E3;
	Thu, 20 Feb 2025 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Ij5s/juf"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2049.outbound.protection.outlook.com [40.107.255.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5321C6FF0;
	Thu, 20 Feb 2025 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018778; cv=fail; b=JX4PkNCV/h9JjJFDM7gIhbhaRuAPLpfwYmguCg7FnEa246wOZf89kK1cfFqriFtnZlE4lqV52kyeyF9dcQhMK/jrERLhSf/JJM0DjveYBDnVjiTdoHCg2s9vky/Iygx/VfYC9C1mkilrP7zrOp5D8q72SmmIqWPBsQ+m6nBEQtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018778; c=relaxed/simple;
	bh=bfDUlOXeVLYUHqpekZYCXV6CY34N1W2+PnStN6jces4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=X+sr/+AusnK49YdEmXiF1vgEUVJxn135SICC5nzjuiLO3rjJFAFN01ZE03I0BO6UMx7yCOXTHqaifgG40iD8DyeCmQxkTx2QI1V6Vh5QkvxsoR/+2JhzjbmaK7l+h2qS4pu81mCv5mUU7R+xfhZuo3MHud2rIr2XyWKZ1ChtuJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Ij5s/juf; arc=fail smtp.client-ip=40.107.255.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0lX4NEkim9MWqGDIFx5egKuwtu1yEfKg6UilYKRxWzXEioaNN79CUorvCM3EnI+2scAqnhd0dlMDg2YAfKj59p2Y07X88+9J+M5hjCI8PeGjNMDlURmIIswZe4KUis+kxYbJja2REncrf8FHUtbaBSXclcYjBXvN1y1jngWxvY7ch49sExySTndkty+2OiaR0yIL8Xk6ENRgVB2vuJf0h6dqNyo3RokTjDU2FeZT8ZK6q1MG37Csgx/7PZrU7WzEsVDKILa/ThMOACfrmYDmDYrGB6z7+HDvJuBQv69DGT8A+/FZ/s+fb7+06UmN2997dqNoCL1Gk3C0zYCRy62aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x787lNgNntEc47QXNfeY2l5Pt9oXXCzO9vFsY4d+S0=;
 b=YtzZCdywLlKHu0a9UI7pjbxvofPDHAJm5SFSUJD83ERhzqz5BGyMo3tAasERAjuOFdZGN3QXQjsgLdvmdjLulCxAo3rUaSgQXqGXPw7sbBfj7m7ZHPowx1iK/HXOtNQC7Gi8SoeQrm4RrgiPNi998OerA4PyofYs/mX/bqFzUt5BdKD3fD6BTC5qqr0Ovkf+isleiG3Uj+4VZ/4W3bKVZfi84sh+AmNGgMilpzNrE3gjGsj6YtHQDc9XNjqBjmk6oNk6M5NYU5KsOOb7cUT+8ipmjsDVtxw1oVtiypk42J9pNa+lzSvkBUi2me/1idEyPOrDYQ4GRULCxzjEYj7qLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x787lNgNntEc47QXNfeY2l5Pt9oXXCzO9vFsY4d+S0=;
 b=Ij5s/jufpaApD2P6rc0ptkRaG6Tq0aJb3HuGAWNEsFSJ/Fp9n0VtRgdLZysQtcidRF8qY5XZA77uoH8+/UYhgWaCWYO2XLz0xmlbMoM4vsRttOTuHETRYDtHpAkj7+1lDv/g7pLAMaEj7W+Fam4De1nIGx9dz4hjzyYVQf8lHjFuqVQnGfIIeJw4JKhNPWphgdXTeyxktgNhqtFCXSXLOECGYv16GKsx/jBRP1NmlPss6R3lSdvn84VMMYM2RoQpvSmVD3k3Mh46aDDv9J2cwOrq/DFq4zQx/9udVI54UwT3sk7s5vUdqkK0tN0FWoEzx6M5VJ+DkKj8xIMeX40YCA==
Received: from SG2PR02CA0011.apcprd02.prod.outlook.com (2603:1096:3:17::23) by
 SEYPR04MB7320.apcprd04.prod.outlook.com (2603:1096:101:170::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Thu, 20 Feb 2025 02:32:50 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::4e) by SG2PR02CA0011.outlook.office365.com
 (2603:1096:3:17::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 02:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 02:32:49 +0000
From: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>,
	Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] ARM: dts: aspeed: yosemite4: add I3C config in DTS
Date: Thu, 20 Feb 2025 10:32:32 +0800
Message-Id: <20250220023233.1686419-1-delphine_cc_chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|SEYPR04MB7320:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 56b282eb-a00b-4b0a-0e46-08dd5156de73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t6YA5OyGpVgLGgnTDumtLiUep5upxsCzHruNTTYvBs+EJ2lWRQ+vqtTb3358?=
 =?us-ascii?Q?3m/1hTtWFAe3YArBZwoYNyrh+397qmlT4/B6Si7pssCAXmqSWJryVIQtQRia?=
 =?us-ascii?Q?bshSWTgTAYM073efDGQ+wSRAecpwtXi6AgeplfrD89CB6E4R9mo1TuFkEw3X?=
 =?us-ascii?Q?DO+lg74pG0J27D6MmbSoAl1XryfI2E7ovDxDxh6nDKHYjpHjYvjFpQVtcaVX?=
 =?us-ascii?Q?icXUm+f0jkWyb/0dACuUE8ErgiXB32RURXfk1JQMOhRcNhGihW16p4WAgoLt?=
 =?us-ascii?Q?O0iEn4+jjhOaCWZmdKvjfyhBHIcTkiipak9dbbztK90mxUpg6m5e7d0h72LI?=
 =?us-ascii?Q?ZtvlHS86YuwzDUhiaiTgmHqjVYVw2ZsurgzHhwlP1fL0diskB76ZwIedkOOD?=
 =?us-ascii?Q?ol2PiHWXxtg98DDB/uHVzJK0ES8+g+TwtJhH0q+xz6DwwaiF7YowhyQmSHF3?=
 =?us-ascii?Q?qqgsQZi5MiPXbteVJN2us8ORTmP0sf4keKgWJy3FoP7l7d6nA0bBlP9JqarA?=
 =?us-ascii?Q?l212JVtN4R5Es5tPO11/VagREDWurS+bm5nT/5Xja1LRWflR8olifRHoaY5R?=
 =?us-ascii?Q?hsgprsjJODx6lN38J9jXPZpVtEDXJeguIcSe5laJON3Ugag60qgnTILhHWLv?=
 =?us-ascii?Q?M2I55IhfhOZi25o6lJtAkBel5358nGS1iItOM7XvnsROjuVlZCgxvcmz7q/+?=
 =?us-ascii?Q?gUHFAOlo6cnzxxIYc+Howk4UNg+zOdbHWPx2+mFb4sC2AmcXxdOvuegJG5b8?=
 =?us-ascii?Q?7rWNlQucmlIH1GWTd6zuAoeWDO0IKr0W6y7vMiHtQXF+/6ybMbMsLPkallZs?=
 =?us-ascii?Q?O5gTpNcuggy0SG8zn6yCBQtU6YddPBNsC136mz6Z36zdrz8Q8TsLYX2Rk14/?=
 =?us-ascii?Q?zqRc+N73F/ZGV23PmnYMC6eWVL/Yl9PmMq2zK3Pob4zG/KckgQSC2fNPBINW?=
 =?us-ascii?Q?1VXSSmfYFIBV+AlGFf6VDucsPjcgBZRcR9QPgLJ55A8LDS99sKz5sp24Pipo?=
 =?us-ascii?Q?sz1yY4btapfoDGz7uP6HynPC9NIcbPa0KmEo3FKyyVoG/1X+CNhBit3K/DDf?=
 =?us-ascii?Q?qPxgCwJxMbZIGBMVfwla9wg3pMJt53MjVh+DLrzCkqbEaxy1ZRdUJlNbwPB/?=
 =?us-ascii?Q?DdmUdkZbT0slHo9N1gZ3S+UWR6hbx5bT41IBfVEq9jWf4JT69g2F5S7vht9P?=
 =?us-ascii?Q?60CtWA5VnUNB+OhXeMh4603fLnscZV80GX3auEO1Sh4ipQr+jXfggSm5Ybdt?=
 =?us-ascii?Q?/ypF+Tk1jElihTGdvMU//zp81maRG8Dv57EGTkYdEUHC/BMTjOqNaiiEb6FI?=
 =?us-ascii?Q?Crl+fMNaSITzyElEm2if08hC4Q96yNHyUqMW6lOoc1KUnShw5TF8Z0UtWzgN?=
 =?us-ascii?Q?fq+ISbP+OSfI+j9ERxEV3S8eursHm5GHo5ByldxabyC/+wKmlwJzyUcRef01?=
 =?us-ascii?Q?8/GuWHTQLGVFVvrGca4RJwl4XwaP88J/HgS1Ru/HO0ZF8t43lT5AjEfRLLmd?=
 =?us-ascii?Q?piVpCMu8NJgVo8M=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 02:32:49.1035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b282eb-a00b-4b0a-0e46-08dd5156de73
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7320

From: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>

Set I3C config in yosemite4 DTS.

Test plan:
Tested PLDM GetTID successfully with the I3C hub driver.

Signed-off-by: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>
Signed-off-by: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 29f224bccd63..5dbfe073e536 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1317,6 +1317,92 @@ eeprom@50 {
 	};
 };
 
+&i3c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c1_default>;
+	i3c-pp-scl-hi-period-ns = <40>;
+	i3c-pp-scl-lo-period-ns = <40>;
+	i3c-od-scl-hi-period-ns = <380>;
+	i3c-od-scl-lo-period-ns = <620>;
+	sda-tx-hold-ns = <10>;
+
+	mctp-controller;
+	hub@0x70 {
+		reg = <0x70 0x3c0 0x00700000>;
+		cp0-ldo-en = "disabled";
+		cp1-ldo-en = "disabled";
+		cp0-ldo-volt = "1.2V";
+		cp1-ldo-volt = "1.2V";
+		tp0145-ldo-en = "disabled";
+		tp2367-ldo-en = "disabled";
+		tp0145-ldo-volt = "1.2V";
+		tp2367-ldo-volt = "1.2V";
+		tp0145-pullup = "2k";
+		tp2367-pullup = "2k";
+
+		target-port@0 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@1 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@2 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@3 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+	};
+};
+
+&i3c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c2_default>;
+	i3c-pp-scl-hi-period-ns = <40>;
+	i3c-pp-scl-lo-period-ns = <40>;
+	i3c-od-scl-hi-period-ns = <380>;
+	i3c-od-scl-lo-period-ns = <620>;
+	sda-tx-hold-ns = <10>;
+
+	mctp-controller;
+	hub@0x70 {
+		reg = <0x70 0x3c0 0x00700000>;
+		cp0-ldo-en = "disabled";
+		cp1-ldo-en = "disabled";
+		cp0-ldo-volt = "1.2V";
+		cp1-ldo-volt = "1.2V";
+		tp0145-ldo-en = "disabled";
+		tp2367-ldo-en = "disabled";
+		tp0145-ldo-volt = "1.2V";
+		tp2367-ldo-volt = "1.2V";
+		tp0145-pullup = "2k";
+		tp2367-pullup = "2k";
+
+		target-port@0 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@1 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@2 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+		target-port@3 {
+			mode = "i3c";
+			pullup = "enabled";
+		};
+	};
+};
+
 &adc0 {
 	status = "okay";
 	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
-- 
2.25.1


