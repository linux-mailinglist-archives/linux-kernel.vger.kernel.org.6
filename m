Return-Path: <linux-kernel+bounces-300804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16095E8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45DC1C2117D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7ED13C676;
	Mon, 26 Aug 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Ecagu8cf"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2062.outbound.protection.outlook.com [40.107.117.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABAE84A5E;
	Mon, 26 Aug 2024 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653515; cv=fail; b=f47bfLx5FOZuybpKXOdb6l127hsDUeEUsSr7vwvnTD+63g9uruyh8+PnsdWC+fbX6WGgScUP8Tz9TTbpawop1/MVlgM0UB25tCwA3AFB4OgDxzHKfPCEbV3zcO/WbtALpVAVvR1JFXAg4ZWU+SNInw6X+Ebja7qTfaQj3xyA4N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653515; c=relaxed/simple;
	bh=9vedNn4zZ5Ih4XUlJByZ0k4YoTGBuTwqHj0FUTJT7YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=of0NJ8LvzyL04hINkdRB6R37gelJh3VtuyeHppV3qsk4pQTz8JsrNUPPgyeinfEeH5axVgAlBZ900PWpyzuUhqBytzEpijHiXxGfN4sSbIXTAFHEanodymEOXTs/38tcaF0KbMyt6iefSX8Lw88YZ9/prlvOAQ8SncGeXR/n6Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Ecagu8cf; arc=fail smtp.client-ip=40.107.117.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pD+MaOzgj5PwLGTo/PWnBiriNg/tGHLIBjMfoGY6MzpIYcQIdaFkYf6RCQgm51d19//eaJCUh4CNrMMVh8eSuL/wh6vfXxWqpnebEbRDDbMbEUonyrriTY5Z5T1CxA0gapWX+tkqFKbhv0LWoZUMvxpHtelmwmRcfmPJuJbDgrhbGRIXAbJ2blTA5EL6aNI6Mtr3dhFUBSpE6ZeV0aLTgUxSMIYeLsONl9vsIy4J9UQY8zTLLBBYk5mOmuTHLwSDYtY5RR3MyISt0/3oNUJ8V+5luiWGUWeLITUxFhJPDifTrqmX8me47uzaBizu1QHaWqs2l0SK/WvFliKbx8NUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ8R9uD5dS2CYOtc4xvne6zIrhYDAk0BYpQGanDefRc=;
 b=X77iVVYNX5hAj1QEYEbbIPjcn66/c7c1NEpTaZPrrhnwbjlV+drFbVcu54fOnhQ7G4iwieBGZRWLl0uNBZQMaLK5WzLar202XvkzMbXVndgf7nPh5DCwTziH21dxrzVzekxtyVdAphe1uAwzCMU6uVO6ZJWOxqxsqwhXBJMuBBxYJ0I0V/2CebJEGx1gW6HUcxB+OxeKmNGlGnXwz1xpevd6Pv4skRgXtuMQPBRX/9yxfNivAhPNjGuKluDYYydnvBszyG2+rDhdg57sn8COYtipZ2kdLEQg3hJjOz0Th4VuDwzAmlA5qFkWsliAfKgKXl9mO2c3C++VohuUvuhDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ8R9uD5dS2CYOtc4xvne6zIrhYDAk0BYpQGanDefRc=;
 b=Ecagu8cfIaxZNqCs3XOxjvUJPil7/96elXcL0whZmQbvdjmtYg6oQiDOYtMlTMUc4V9uNDbTZE4GaMZOpKF8ei/bd7hhZGYJcw6TcwHlhvZT03+xXI6gGfMh31begLdjPGKwxvl1goQFc0NxnRoZ0EKoG5vhQYA2MaEYd3tmvBHCs7KKS+eS44q9oG+12c24SG3tecs8VSNsATv7mhIM3/aBhrx0CwrnOE4YZ+L8aDuAV89l/KH15fTDMuqUjlVWIQGtcQ53FMaBd6v4hKoKf2T7zFypw+AZYeub5qw8YTNaqGB8zANsYi/DLvMixN8xJLXksbapSRzEA86MYl2cGg==
Received: from PS1PR03CA0004.apcprd03.prod.outlook.com (2603:1096:803:3d::16)
 by TYZPR04MB6685.apcprd04.prod.outlook.com (2603:1096:400:33f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:25:09 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::2b) by PS1PR03CA0004.outlook.office365.com
 (2603:1096:803:3d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:25:08
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
Subject: [PATCH v14 12/31] ARM: dts: aspeed: yosemite4: Remove temperature sensor for yosemite4 schematic change
Date: Mon, 26 Aug 2024 14:23:46 +0800
Message-Id: <20240826062408.2885174-13-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYZPR04MB6685:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8ce5bbff-8c8b-4f67-7cf9-08dcc597d518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t0X0yIbJqQc0nxF29pNqq9pfHAwenJ7sWcIpVDgBMPZ+ojajEOXydg0DGTHm?=
 =?us-ascii?Q?PJOLUu86519VJCkTa0KnEsPPkMg9yc7JwjwUIP9lHi3FQMuLfE+EX7RIM5EI?=
 =?us-ascii?Q?0SeFcVAblzLluaxDlwrDcChYL1qs6l5oNN2u7Low3vzZ8qOI/IrMPMw0PqTp?=
 =?us-ascii?Q?RUj3Ja6cGdFDS/C0dUkhUebv27nbDfMvBbk73MU3lZzEJ2iUOZ99GTxJ8NBv?=
 =?us-ascii?Q?xTMV8dhzbEo05Aucj2+guRWX5cHE17Z4Yk26lmAp/hQLC3Pj9RoKl0lFJVB1?=
 =?us-ascii?Q?2/3e3ukMutvNRlmbeWT0Bs2OW4kJETV5ZO+CcZNZ0G+xqx2peWtWemLGxbuY?=
 =?us-ascii?Q?V3ZI60+ZCqiDY7l0OZTyBhmjdiziPyUmn6/klx4rkuExP6LKOTYmWnxx6b4k?=
 =?us-ascii?Q?bXEn9YxMBKcz+ty3tcDZdVYgkkTkFBt/NOIlmLNFMzgS+SIgjm553TCykP99?=
 =?us-ascii?Q?Qn0pGT+VPYdT0/htM5ZDCUpQt2vAYzDHTUZXdUynboziXbdrzy5G+BJWbYZY?=
 =?us-ascii?Q?ORXMv/FX/32kwPgUZstIVD/2bq1JH6N4zGlfCDBTOWToYuYI7MitKbdEyUjA?=
 =?us-ascii?Q?SJESeHqvrWQGAwGzZaOGC9564CGG/I65iHz7npgYJnKKHqmqwn8ySmeL0scN?=
 =?us-ascii?Q?sPAQBLvE2cwuo2JZ0vEFHHdCWPC2GCBAv/uzr49wIvvQOg8cosbsXEk6GL5M?=
 =?us-ascii?Q?1RIsObtkiVJGBSbZCmx+Jqo8EgvtELZhMCY+Fk1beoJghLC0ZBUSO13YHLQ2?=
 =?us-ascii?Q?CymnFp0qQP+e9FCTf7MTmjsjwFbLtJlk8SWssT2XV0zNdeNbdXeqXU2S/3xh?=
 =?us-ascii?Q?1030i/UZzhxQrAv22o5rtGsONtp/6lUsiFxlfQHT0Y92f9nsraWtq/4Zp7gC?=
 =?us-ascii?Q?RjWOvuS+NNzrJarXqSMdEaP+Zr64vw8/cvU5zgE83JfOGuurfQsAWS4Ql10Y?=
 =?us-ascii?Q?FFDnh8raMytDPn5c6HKqwqFfgxU4B7i+Hsj9W/pDF+IQP4L/k5OJOhRw8g/R?=
 =?us-ascii?Q?CqdNwkPwizRyJuOfBm3bPjwNMu2XSABMGTB1qMFdtWDIbaz6Hy2kWojYN3Gl?=
 =?us-ascii?Q?9GuVV3GRI1jk3VaT8H2H9lYvIdZSF8fY1nkfFdOxqkHADNYSdJLnaKdG38rz?=
 =?us-ascii?Q?FM0lwmLlya7yW/J9BI/YGfinfMCbrIUSLpPtNeL7dvUjo5yLQjHG5+EmbkiF?=
 =?us-ascii?Q?pKg06KCJ6zQa6V/vmtUwrYLfe8jIbCK1W/oQ4UcMCakPCf/bvc7FhdIi/tMV?=
 =?us-ascii?Q?Mjb0hO7Kyj8WOoJKC1hkGJGtpirwpQtmh5oyuwYx+D0Kd3E/bhHzy7DkXyO2?=
 =?us-ascii?Q?5kVp8USw72024Ls4Tz974uEo3IuY1gocdvDPYv+4PLH8sQIPe/gK4WqjqiM1?=
 =?us-ascii?Q?til6oGvkaQdTpRG2V5NImDZIMsxUQksgpq5NVbN9A2nK3xOE2ETqN4sXjmpD?=
 =?us-ascii?Q?834lFP+DHWN08fxo72BkqZqn3xZfgU/K?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:25:08.2996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce5bbff-8c8b-4f67-7cf9-08dcc597d518
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6685

Remove temperature sensor for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts  | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e83cb51ac19d..2c0c37b3ee5b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -921,16 +921,6 @@ temperature-sensor@49 {
 		reg = <0x49>;
 	};
 
-	temperature-sensor@4a {
-		compatible = "ti,tmp75";
-		reg = <0x4a>;
-	};
-
-	temperature-sensor@4b {
-		compatible = "ti,tmp75";
-		reg = <0x4b>;
-	};
-
 	eeprom@54 {
 		compatible = "atmel,24c128";
 		reg = <0x54>;
-- 
2.25.1


