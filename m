Return-Path: <linux-kernel+bounces-334022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3397D177
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7942823A9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3755C3E;
	Fri, 20 Sep 2024 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="RVTgfh74"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011058.outbound.protection.outlook.com [52.101.129.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A280502B1;
	Fri, 20 Sep 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815908; cv=fail; b=a/2CD+2ze3C3BfQ4ZWsJwlo/nvFVsncmqWAE8ZNHXIokFhI/nIsqVYxuCcE5wYnoPMCDXx8WCgPwXMnQgh2vH64MUmlVNpN9V3hVHCKCXpkao02jyIGS7YlYGgDE7gEhEwdC/Xc7k3AQUFc6Pski7Y8Oo5b9WOmBvyCUcI51leo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815908; c=relaxed/simple;
	bh=6pFNh2fImMqyVBMJtbVGSOT3kFKCTkwaqB9RMc6IPo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiRyofuEQaGfZBjWUsU7Upg66IDB2LezR8lYn6jbh+vVE22TUxuixu8F0scJ22K9f39FgyWygSRJ2xmBagNrUxGJZurOrq/LnEhlhfKCaNj0pgjcdHPTmr++HE7JboirKDXZ0cGawij1/Q8HTDnE+cIS9u6Ii6TlIef/DpomsOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=RVTgfh74; arc=fail smtp.client-ip=52.101.129.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQhzeGkdqNCGuzwoXmRaxLkRUkkDan60nsmQNkUkBaj+SPTGsV584/CJSpdnZaZ7wOt2SyVYxAGLEvVZULbl2aCEn49KFdPlAHjaRQVrGfx8RzyDiB2GR8oLefqx23hi/nx9R/5Z99ePa9WGpFKBH3W7SFrT146ZbvfPlUrpGDF/qNzKbVxQajqxXbsyKvSFNW1/UoUssjaLinrxD0NcOnrl7GCWcD1JXnfyqAPwHWF9leLP5qEq4/FtNqX9XJan4tc/u56j0alrwixLFRgpQaXh/b2VgOUnluLzuEDG/stxhyzeHyRXBm5+qi10vCArUmZ+uafoM/M9k+q6rpexrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak/A7LiKceYzH/Ibf+ojUHPoKN59wU2gqDAJjVq66R4=;
 b=Mqli3K1d1ym/7FKLwwCuyA/iwYAGqlFMbib0KvHu410O/mthUkqcg4ir/eOhlVNpg6mlzliqbEbafNjGMtSRGUm102PyivSPIq996WPWUmtSpiTGc8BIa2ahZWX6s8r7qEAA1FnPvNP04Fc1GChTjkpn5vkC1YkcaSb5/dJ7ka2o8xE8BlOGhjtTHnHENlHB7iu46kGrCaF4lccJO1i0zF/paBGReibUuEaqvgwgyuvY3gEZFNwddbdI6PM+3CsvafCdkeEG9pv54NYD15QtiqKox9d/J0xHFTAuKYGthBTX5siPY6tKSrSrE+sDbGMlQ4YMdeKRNjGZF8JAgqFt+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak/A7LiKceYzH/Ibf+ojUHPoKN59wU2gqDAJjVq66R4=;
 b=RVTgfh74g8BpVo/DH8+h+Iy/+LYchTg1b29j3MxV9dgPM6Fya3wLkfcRYdnzPGhuiyUqRcIAfQh6XONkbGX6VfBik3mPqARLpsgIIx8AXv+DAL3t5hTak+zSFJtQJXAlcpkwbXCgOrZpVsoD0rvjtcdoLBO07SafvGC60lKLGNS7GFeqmLmK0wcinaUx7wK8em+ET+35C9PL1dXD6vSPARZI+BlIa8YEw4czKpX59SsE7HQf5ln9uU5Olw3N7oiV7fRZFCn90VcziNMaIEIA9roA38BVrVte5SZIQhRRUEAsQtbGYllZL17vitY+AvgVRXO/8pVbscUA9+aewFAY7g==
Received: from SG2PR02CA0103.apcprd02.prod.outlook.com (2603:1096:4:92::19) by
 SG2PR04MB5913.apcprd04.prod.outlook.com (2603:1096:4:1d0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.18; Fri, 20 Sep 2024 07:05:00 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:92:cafe::74) by SG2PR02CA0103.outlook.office365.com
 (2603:1096:4:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Fri, 20 Sep 2024 07:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024
 07:04:59 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v19 2/2] ARM: dts: aspeed: yosemite4: add mctp config and sensors for NIC
Date: Fri, 20 Sep 2024 15:04:49 +0800
Message-Id: <20240920070449.3871705-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920070449.3871705-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240920070449.3871705-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|SG2PR04MB5913:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 89d0dfe3-717e-48e5-d74c-08dcd9428ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uqjXxOzQghD9h3cdYloxgc8UOBcjtox7kZafgGUHIM1tQRgYJlkNzCnr6Tei?=
 =?us-ascii?Q?Anv1xNTw34bfVJH3mCCs8oMYyJIs7KonweS4tD4fO9Xh6UTMR+VZZ5NTHneF?=
 =?us-ascii?Q?hoxixng5cPoPhI1eJfA9dtPDX+4FQQTaZZl4aCDeEUjqiaruf9bf5AA5a3cB?=
 =?us-ascii?Q?pAzOixuhbk/lHW89o2QM1SlJcR7cYyZApOVDx/1luqYCmpPVX9DRlxv4FKaG?=
 =?us-ascii?Q?r8hTb4pAQCn6Fjkxre2LTsM/0KbRKu88Zy2Xp3ot0BSv29mlgpw1Ao4aGSMe?=
 =?us-ascii?Q?v0k2zvBn+C6RCUm5HHhaZKzPgAJ5bdbdxXgX4n+i14aOaXslmB5IZzPldBzB?=
 =?us-ascii?Q?wl4hJGMdPHYA0BQ0Dj5NjDh2awOO8tawX/6j8tCahr3VfNaSIaBdZvLNUi0h?=
 =?us-ascii?Q?P1jPZrgp5VO2MU/4UYQpjb10G9RrRIy325qomDlZDbshy2miJLRWWm7FADPL?=
 =?us-ascii?Q?aaSOSgF/GS2tzBY44O+XecgSPb5hX7gOlLRaVr6Op9H36j9jUilxgJK9lruX?=
 =?us-ascii?Q?aYI4J1HXW5nqJ3qP+PJJWWDxQxwOdx40B7GQGC8gz1MOIwkxklar5/UwKzOC?=
 =?us-ascii?Q?wb6IovFMZ5rUmld5xv9I5iE2/Vj5zz3+G7lXNSBKgBodC0q/ufGRzhA2zGlG?=
 =?us-ascii?Q?3igzUGAJ01wUB6sb2B93SD1RRx7opyKqITJn96/yqfcdkQsEJ1fLXhIPZlMw?=
 =?us-ascii?Q?/HYRHRM8eo060VySKMSTBEG8PMP8QOjztYjTqqoGm/fDNzkhmzNe1+9fUhPy?=
 =?us-ascii?Q?1bVjhVPYEi6nPBwddVPm8uKRy8WCcSF0VP94Pu8CumPYDdUV6JnfJakjfa3v?=
 =?us-ascii?Q?aCLuULtvlEUR4EpCyTFRdvns7/tb9xJ15O94YcpZaB937Orx3onmtAgVG0+V?=
 =?us-ascii?Q?JSOYxoS0a9WC9E0CtxF0YNDzrbyvdksVFijSkRwPkNxXNFNS7GNG5O/GdE0m?=
 =?us-ascii?Q?7kURUJmtiPdf+QNmrD4Q+Hc2P5vHloQ66ErSkZLf0LyaNscXz+kgNQlQnmlG?=
 =?us-ascii?Q?NgRateoe1r/Oph28tXpp/yAQEYvPaKZSEAelT6DElcMsKPS/bFBPtzyfca50?=
 =?us-ascii?Q?Z7F0Bn2H/bpkvVZ4Xm9LGMm+2ba8dnAJn5yqTCVKtzmBsV7jyJRXnHp9r+FZ?=
 =?us-ascii?Q?RZY6tTPeTI29lKZin/8N4aXU376yht2TVGr3lgfwKUV0KNNQY3ZAVLThl4FJ?=
 =?us-ascii?Q?AyGPfKh1ZSYJxHyzYZnLojT1GsUMIyYyfdLeUtxGVyVy2w5EkhHIqmMgtLqh?=
 =?us-ascii?Q?nnmVqaPatGegl6XLl00JyW9YMgSnzuJufHbA3fSanWivIbtBC0flvzi57JDa?=
 =?us-ascii?Q?S6CnNN4D/TdSs/rqbzkXOR/prz+hhe3EPb47FDj3DEx6q0KWMmDrr+1tB5Z4?=
 =?us-ascii?Q?hNshcsk6BGDnoVF/TO0QfEjcRTCmcBjL96gI0t8Zohmqp3YVuqRwsaInNnPW?=
 =?us-ascii?Q?exUzEyjFV5lqpYUMeQlwlwa8LzWXv/kj?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 07:04:59.3977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d0dfe3-717e-48e5-d74c-08dcd9428ade
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5913

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

- Add MCTP config for NIC and remove the unnecessary MCTP config on bus
15.
- Add eeprom for NIC.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 6b4efb5fbd83..621e4e970790 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -937,7 +937,6 @@ &i2c15 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 
@@ -951,46 +950,73 @@ i2c-mux@72 {
 		reg = <0x72>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		imux24: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux25: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux26: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			eeprom@50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
 		};
 
 		imux27: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			mctp-controller;
+
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
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


