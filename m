Return-Path: <linux-kernel+bounces-322330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC76972765
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A617F282DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2E414D719;
	Tue, 10 Sep 2024 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="G3XtO9eW"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767A4A0C;
	Tue, 10 Sep 2024 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937415; cv=fail; b=mOm2WCe1nYCDRwWyA61fXMJkvtbMbg9BRSabwOdLvSGo4bThc9Ca8qAtrM8L+Jqy11Mz+jAGfU8AY5keUVvgiDYKL0hQYgf7t4uEkvAHNq3QXxssGBYaQ4stZ09PttNtpqBO84yWzxgHZjzOAuG7b+RbwVBDjXtZO0Rdd2dwPIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937415; c=relaxed/simple;
	bh=DOaWDHu5sUurPC95lI6Y0xsiroYYnY4tsigVCp+2JCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VStM01Ig/inmjli45Y0ZQ0reNbf5Af0AJQj2KbU1Hp1KcBiT0ERuaXQYdV7c3EtJiOGtmOxzOlcYyqRYDs+Ssj5R2rWza6T8qTXp002C5DGz2xXnNWgOCbKnN55+N52bsFA6SjdSw04uAOJc+iT+/9JR94dyM3VPel5dcre3NJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=G3XtO9eW; arc=fail smtp.client-ip=40.107.117.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltBadatRH+XtC9hvRR/QKWj6e2NSrHCNq5ppl4nC9DfK0ZvXcTGMejwynT/6UPpl2sCKkxNmsHYXYoCjoAAkelFm3M7Tph1iymY/3T9c/tuACLEpWhG1GU8AH7WJ8DW2JumJtcds2rEFJNhmGmZkPCIrrJ/IDskh0MXLou0IQ3BB7akm/wazqfKEDFGLcRMalCF6Qym5GITi9iV2Vp/5BbD8eTQtqfgT3SPC/+3oITnGheOnLtau7BW0rHqX5/Q14adBsZ5wDpUK9RPmXJwPQ9owd3ZjtFmxct71WMgANADPMwYqIx/9JrA8FWselxsn1Qq/pldZfW0eKuNFmTWT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n711xcEgwGmiAV8g2KeohqJYfUwIrqGeCPOmSGYRGa8=;
 b=PVLmQ+redBeykvXdUSgMADWUr2Q9oxSd9KjiPgkLFemAniCpt97oQKJUyBftuvDBuF5fiZ0CSPVxFvmGr3eOdt4/tTXUwSKnmFYwjGKGq2k7CnQrNz4W8p0fmIkgs0GG8M+Z9MMfcsIuyE0CxJnhqltaAh/ntTcrkYSrTQkHApIqVqoFcB/9LT0iEPg5S++6H9kUCTjaRdo5Nb3r9twVdY6csz2pYaV7Li6MJteVSV+fro7NsYbQ3fd05U0J20l4OItK/Y1l2sjayUlM5IUxCbDVub3ed+s3eljWHIo39uGyUhfCVGWB7tqMm2lxlxg3XC1UJUaTY/tgu7QY5Edysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n711xcEgwGmiAV8g2KeohqJYfUwIrqGeCPOmSGYRGa8=;
 b=G3XtO9eWTCPHRfDTxWpt2IUunhQ+GP9UQdN04uIqkvCnYlOsCrzF4Xmr39YIWIJiijvv8IX2gblRAyeiXga/7VIMMBpTDIA52OGDp0eZaD3lAhBdZ7GkXzua51UsNn8ORbkU+Hqtdgd9HiiMkXCzPKmpZlLwdD2R+B0At1Aaibi2GbOljZOC5m8S7UfmBL3j8Ijm3kcAVv5NbuParEZdJ95eo50w12DOYcCDMo0TH7bSq4nepl9wiCf9xwLgjxGCX9JLfV+6NkU7J2M+RE9id2fx+GWu1xLMqb1n1sYGvvFIIwNx6FkdbsW5zPeyU9M5jMgZV/DnsaHZMGpfbytHyg==
Received: from KL1P15301CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:820:3d::6)
 by TY0PR04MB5910.apcprd04.prod.outlook.com (2603:1096:400:214::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 03:03:27 +0000
Received: from HK2PEPF00006FAE.apcprd02.prod.outlook.com
 (2603:1096:820:3d:cafe::5e) by KL1P15301CA0049.outlook.office365.com
 (2603:1096:820:3d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.5 via Frontend
 Transport; Tue, 10 Sep 2024 03:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FAE.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 03:03:25
 +0000
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
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date: Tue, 10 Sep 2024 11:03:23 +0800
Message-Id: <20240910030324.2256698-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAE:EE_|TY0PR04MB5910:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4c2ed7e5-8c41-420c-d0c4-08dcd14523b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cxWW2u1gxCWbF0d/o5bEfotsYKkKYOi79owQF5IQTSOFdWcBGfOTo9kzGHQN?=
 =?us-ascii?Q?fsPAWAYYTkgnd8isoQLNifNw7DO51NmT+dPJzGYRtNpgpviGGdfaA7ALxNPk?=
 =?us-ascii?Q?pvGEi4jnjyRYVI4UJC9UAIOkT/WK4eOBsNG31Kl6vrL2FF0+GeCnvErkQsol?=
 =?us-ascii?Q?HW+EJtQqS5AOjv0EzRkhuVsV0wA8vnA7fq3KebOHPIhmSXO+ZNqbN3EjtSmS?=
 =?us-ascii?Q?FXFaNaIaPRfH531yQdKvygMnZTAC87AmM4edJENHCbR7/2Fi4z7c/nTYPJF5?=
 =?us-ascii?Q?FIFvUtigqhJct3CaviSe2qhGNzaFDLLOKoWK6d+zVuiuyZDs16J20Pe5MoWg?=
 =?us-ascii?Q?p9B6GIXG6TcdaE5UJmSR+SdCla4KunE50qYz7w7figS7YTd/G/4czUGlcvdo?=
 =?us-ascii?Q?s01uGFEyIMx4aptbo8LhQ72Rxg19huttebAkDfaU4zX03L4h8+3ocsdWmorv?=
 =?us-ascii?Q?WSvMJBjzR8x700FQGTmdRgnOjuAdfWG1tHdVArOl7uU0Fnh2Qo/tAysuPFfQ?=
 =?us-ascii?Q?kHdyC2Z14JjVuMvBr95xjpqfWgjkzr6t/VbKu1r3PmeLtX6J/RTyd0roOPci?=
 =?us-ascii?Q?djWNjFeZjAdB2PhLdZHep4qwh6qUIv0aSmqhFcAbgJRwv+E/z5/ys8elBhCs?=
 =?us-ascii?Q?7yxCznA89ZvC0jVmQtksxY5UmeJq77JGqF0XcYG5rpILmHOWXv2XW3meHtgf?=
 =?us-ascii?Q?N6+OHsnzxVNekxmCS7mK69bSNEz0eKSf2x3/X0+zl6j6FZ5e1DM8WkNvX9ab?=
 =?us-ascii?Q?TbRNkayvE7WfPYbxI6dA7VXFH1CG15WGyNU8Iz3CB9d7DUscKhKjtxxa614s?=
 =?us-ascii?Q?5rn/J9A7yhMgGVKCiLAFIPpBoXdlVGdLqCphUq4rT3+VAVM9Q4D5M/9mZoJS?=
 =?us-ascii?Q?X5BpqFabA+dvzdwWvGKLH/TdSnRfoetoxaq7mW6rYG8RaFJXvXvUjdpxlWkK?=
 =?us-ascii?Q?/HdhO64SiWSPmF48E6xr9PhWJP+TdjgYUN15sdSIv3X2gfA8ZBDRMIzz4d5i?=
 =?us-ascii?Q?KpafdY2t3nPwwi45yYMTFBkWCqLHUa6vkCZw8FXclDLoN17bUFkHNeYJnjUF?=
 =?us-ascii?Q?1m6/QT1AXNQWPcIJND3BXxDcKG2rK1pODR5akRzOrqhLDcFzUy+q1URh8vll?=
 =?us-ascii?Q?NvGyamqCjgnCzyr/3O8N5XwkyeM5QuDC3V7U50kB7h3k+vYiv9+ROY0YqX6I?=
 =?us-ascii?Q?f5fa6oBX47owS4Vhog7s7fMYI5qvdd9wxT317H4VqZpPHvEt8mvS8t9ofzsz?=
 =?us-ascii?Q?PX2KezHLCzAtOPL8bMq/tPVn2CBumoEkg7ydSUmWi33F9RTXXoRYn9lRA1LW?=
 =?us-ascii?Q?3oQ4HPCYv8d2CtrnHHkryInIgfQf/T3ZESdRT2AcuuBjdFuRPRurdfE8QWnt?=
 =?us-ascii?Q?jZrs2z+KcCYPBf6ymX+eGSRm52LBJl75QMD5MAIWab8OQiVTA2ElDZc/811D?=
 =?us-ascii?Q?LQAXrB/9dvGpzWpu7uncD3A4WGJ/u4r2?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 03:03:25.9490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2ed7e5-8c41-420c-d0c4-08dcd14523b5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FAE.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5910

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Enable spi-gpio setting for spi flash in yosemite4.
Add tpm device under spi.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..fdf9040d655b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -34,6 +34,24 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>;
 	};
+
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+		num-chipselects = <1>;
+
+		tpm@0 {
+			reg = <0>;
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.25.1


