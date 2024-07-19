Return-Path: <linux-kernel+bounces-256996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE69373B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADE31C22797
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2136713DDAF;
	Fri, 19 Jul 2024 06:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="YwQtGRWm"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A8761FC4;
	Fri, 19 Jul 2024 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368847; cv=fail; b=PB0Z6+WYvXMF0sZGlGqkURxga9SvyBiVH1QssxzDYs7Q8DjD6vwDPhH+wE7EVYqTC+zfCHb506gM6bIBPU35q4/CUIi7i4uQiZUwPVuXd4cwlCsL5QrEOGcc8PlTwr5AIrkbPxMFUEVATbPA0cXZWH+Z+xTpUVhEi9XJkw4cWGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368847; c=relaxed/simple;
	bh=B/oZeUxM7Bov5AMZhp/ruSmD6wW9/+CYr54R4FGw1nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbMglHuL10FJXM2J8pQIT91ME+sN7ZaWpZto+4naJmw2UA2PVg/utOQO1FY/vEVWIjeEtML1seaCdaCJHTLgCXiqktPkpxCLboI0jBOp2k6nK4GvPdWlFDwdkH/tyO69OZII1d00YhxN5Yc7CDEYL/dWlQB9fzPyjmnwLGPaWso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=YwQtGRWm; arc=fail smtp.client-ip=40.107.215.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyKrCy8b8unOMdQ9R8+GEMR2sYptKPweMh05/i7/T3nthlaIkBus6RUNQJgUGzINqbpRPtE9Xc4N7qJltvekc9iqiX7PqxPmCoGVXzUl6qLtc4u6JZ8qnoIQNHsznoUVxLwq3lyX4sIwamGTiFSgN5mfv8j6fBqG0l354LCiJ7wswj9+533msBlOAqQa5B+Gg3Cy2sJyYX4kMuIQIrxMcoV2w2KnZDWRF1ngCXfiFOwoONHEusu3XPeVSPJr+ch6LeuOvXcUNp9HZSdWsOhX0IH2GFiG7UsAYH4f/BeYyOTOx6CWJRs1eCeXzKOB0LmquTFlkAxNHjN339AUf1feQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5nLOGzr+7KZfcZvwMsTgIEus1J7dxSLeXUDVhNOLW4=;
 b=r7cxeX0PaQwYQtPKKtGXovkqysXZiiQ+HsP4nVZvRM86QHASRn9qnbWzACmuQpjgyf5Pwfcfzw9UaQd/8KWoumf5zPQDmEdxL9J4QWF8GcqSJIkdSGW1+Zt2X0MiptgcDPN8O4sANwUuRUo0g1pmpTKw0KSkPPzoNOFmDDWrjfN77FKTchVQ22MTcGoiCokPOcohW5wAaBDvBa2WhSpSCozGAeEYsC6j4meHOtn5iY7kGbWUrjRsX+krYXITE0824UgGlttdUdSLVjulsedk4ZDwBP6kODl/WUbeXlbYXVTLz4sYbu8xE9tuHpf+LoSU+P23r94A1puJOByrzQzQ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5nLOGzr+7KZfcZvwMsTgIEus1J7dxSLeXUDVhNOLW4=;
 b=YwQtGRWmkGQtowyunEL9Iq7LB7tAqiXSX1XXMdoJiNDDrUr6U+jezSs/N4fKfJmucO9F+QmGWspmX34xInfOUzfH8jRRnvHjfiheY1FvuBzS5H4vTLKMd2FNpOB5UXA9cYCEGvCK4jAUy5o5lG997Pix/ei6qsLbFPnZpcTNjPa6kNfzFaDy23vu2hTOZbt+CWIrJUB9sN8KbW874or78M81x4bZaHj7VbV2MHBICm6XRM66PMEU7yQUoIvAbvElytMGTzZdkC0hPC1gsKHsjj1W4ik+hWX1ODJzSyip3+G5bGpwqB56CC3geQ6/ixl2BarC6ho/kCoIu/2TmTiOOw==
Received: from KL1PR0401CA0021.apcprd04.prod.outlook.com (2603:1096:820:e::8)
 by SEYPR04MB6752.apcprd04.prod.outlook.com (2603:1096:101:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.7; Fri, 19 Jul
 2024 06:00:40 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::fa) by KL1PR0401CA0021.outlook.office365.com
 (2603:1096:820:e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:39
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
Subject: [PATCH v10 21/27] ARM: dts: aspeed: yosemite4: support NIC eeprom
Date: Fri, 19 Jul 2024 13:58:50 +0800
Message-Id: <20240719055859.4166887-22-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEYPR04MB6752:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f339f60-2214-46f2-5663-08dca7b81e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OkhglmtuYjpOzSxz5jKTrhIUgG0pAaxnNP7aTkYIA3xjjjsM8M9DS8xX2c7e?=
 =?us-ascii?Q?92IEq3wyS1QbNJy78KEsSMNGmoxTiSaqtkEJNjeSLY3Ed++oXOqInoCgUmQr?=
 =?us-ascii?Q?66gjvil5Bz3UADremUormJ4sJDXjCzAdAn0e75X5UJ6aCKkIpyxsRbxHz0bq?=
 =?us-ascii?Q?Xdbpm1hlNaRMNwdbV9cqdxGMfN2m/TZEpoyG0dKBo6jJvyi+n6FUmWrtvkpT?=
 =?us-ascii?Q?BsU//rcZ0ODyca71Thi0UJ3hNmXOTBHFCSVpEX9O2SSGlRT7KdY9uCQUBzPZ?=
 =?us-ascii?Q?xAa4oty2LBRX4/OXv/ZXeyqMKnA/NkBGJec1zqkGuWHosO76IMO0JojIXOD5?=
 =?us-ascii?Q?DkNfPVUYkO1yKCc+KmV/48EJjN0krfSGEtAtWJv8lk/uNGi4bGWnNstNOHtb?=
 =?us-ascii?Q?QSPgBD3hBDsiBTGAssFm5az54ezTBC0EFIirldxSRf1EteWJmNLKPbKpvKf3?=
 =?us-ascii?Q?i5AOZpjtUeUZUl8PIMdl9j4PPAI+6Tb1mCgYflBbDWePmMMYCQruy5+7N7SW?=
 =?us-ascii?Q?8l0B6qSd0m8srFbX8HQsjeODmIKe18pNrWnmadM5GsATuNk7P5ABGWoaTUmg?=
 =?us-ascii?Q?9lEyB39JviFYH1fqhJvGVdWT+NSJPFf7hfmiTAAm3qfb0TflSD7Pa7KCIWbK?=
 =?us-ascii?Q?WRHxXLt4uReYhOB/2vhzWpLiRySWjfYHKggFElUqhfO5HOLGgcDKvDAFtr6Y?=
 =?us-ascii?Q?mDn3Lq6lhAna3OA/m2AAX54DnJL3aXbGGTz37TR+eFUMq9cZ5zOrpirxRIRD?=
 =?us-ascii?Q?+Aa66FN8QzltxfgNEtcg2cXoL37SQz51Hb6/18YCa1YxMFC9i7k3lBV0c5MY?=
 =?us-ascii?Q?FFUqTEME1Qm4qpT5/2QRXocdOglKX7L8ps10Z2HM8yGEHgrKWryaGWh98PVF?=
 =?us-ascii?Q?naG991Fu3jD7TgznOFq/rc8XeiGviIdDswiTAtgpckcvMFn17kweQmr2uOAD?=
 =?us-ascii?Q?nV/sH144ndb3ShK1DuwSaOS4V00aRPOGoigLFmAYO9ZfkmbWP22l9VyJ43D+?=
 =?us-ascii?Q?8mJ962VH46jgv4kbIVJP1v14tlRIFiDUioDLe6W3g2ta1mVpbpnVRQWm6Qki?=
 =?us-ascii?Q?c24JiUXQkG3kESFc/gSLaZxvSSV/JfRd4FAELJa4nU6Wl6DEMaYpsQ4t+ZWJ?=
 =?us-ascii?Q?9Z8TtEGnblePOhMWz2QQaXBAkr4rPyYZNvdbue4UbCdXrM4UcRmTLnlojSku?=
 =?us-ascii?Q?Kgn+42KLohMQCQem12PfVKYjioiNmQNBuXUhDkp6jdlpY7nr+xeZL905K9uS?=
 =?us-ascii?Q?R9PQXLkvShax7TkBmNj9pe0y0wZ2An4A0pgTQCGpLH96DTh/Nst8jrI4HG22?=
 =?us-ascii?Q?tQks8Le1/bsq7BGMMAx1KCReJwbGnwzkqHneLftoHNb20bO/fL1MtrRWF/oB?=
 =?us-ascii?Q?ylUJKpi1nyCu4zbpnEJMgYc9OLNtCOeqyRvCkT15LbvowHSaIWC56cxEhtEv?=
 =?us-ascii?Q?h6St5jfiYGrPFsxTbYFXR33fhtb9UKF7?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:39.7828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f339f60-2214-46f2-5663-08dca7b81e13
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6752

Add NIC eeprom devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index bacaa2208734..62dfe935cbcd 100644
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


