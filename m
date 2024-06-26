Return-Path: <linux-kernel+bounces-230377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE39917C03
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C0B2891A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6788180A6D;
	Wed, 26 Jun 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="uiv0KH8M"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2069.outbound.protection.outlook.com [40.107.117.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2F17FADB;
	Wed, 26 Jun 2024 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392940; cv=fail; b=KiGb8F8vb4gbw25OR5TCSKqYIzhFCwdfzg4J6Z9SMnjn32ndkRToDEAazz+Q0j4Zp3rjTgNjS/B2v12C5lmeGmP7IpHqk9exuGJXS9rUCFmIkIPbSy50DwwOsr9tZn+ajgfTjfQD5D8X6NXFK8LhV1IvYkhJlv8eQBC7922yig4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392940; c=relaxed/simple;
	bh=FmeTRl7VvcjfBLGcGy+uhaZd2SETeUmaTr3cZihxq58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0rvlkP11Td1P1abOtFl14npLa054muvdtGE7eRoxhXOYOQBbsTrVpdFLN4zYysTRITyVW/fDtb+cZvuviFUzOj19+RbcIVHw0Cxp/AoLJeii6vaciZ1koV1yvvI9oTMxQJsF/XR3gWBNf4lJkvNdx2Q9mAmiC9T+4cbarRlYPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=uiv0KH8M; arc=fail smtp.client-ip=40.107.117.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNVxdM4H33OyH5nxmDFWpjS0Ek291uaJLyStpTqOzR+p+eT/mYZ/ZB1JFYmvwu6BSLat7KRH0lDajVJXCxKmCYulevjf0wCr8HhhqAQIESN0FSVXHrRbojHuEhwHopYSj40GeIIM1WXNoEsTrwyXnlAkDYFx6+qQogtdxUm3jFWykZwIamZp/I0p1Osq+VTUr6QdOPAG4RguCgOLnsFi3Vq6hsR4kdldTmgToBWwbTyrD8WRGckmgGBvfge0sLpi2HOaj+/x9DLFdZcBj8b/uIExH8VfmFfGxjBGA8SBUDqkq5Pn1w7nyTFCcHu3rjHxbPgox2qR96fMXqzCiSaKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j10ZjYa9m8Zaq+5l8uhw5k3ZR3hJFjHMdwiXMttLE3U=;
 b=bn5crocFGitLtHF9JMMLuQaVkd/wWrenQc7GV0moZTPTTLja6ZMoVkv2O6qgzKclu0HZaH6eRlc+3X91Zrn6/JvEChDclBjUtEQn6fk+zkXCT05oApYHLWVOTusZDFNFMDdQwRcobpj3VFpW4b+VLv2wbeiYiWVfrspX8GrP8FERInQHSQpyGw5xjZW4AcvTKp/DXC+CgvU9cV4dhKJpGTB1c7uYpZjxCQcgtfWWGuDSXX7VJYuPb0w5ma7ijNSv8F3gd4s4WKL6jFj17kdJnZHj/SVZ9e3rgg8LeSzbLahPMrxkXAXfWLM5atP2/R0fkvr+3NtVj08RUY4QQcyWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j10ZjYa9m8Zaq+5l8uhw5k3ZR3hJFjHMdwiXMttLE3U=;
 b=uiv0KH8MSWu5Pmq0aGd811Cf5DG8BztQeA1wMLzHIQM8Y0TWlLFrc+E7I5JJ0M7PzNEhGVrJRzU7vkwoSF+Gzb58blwWt8T/E4Os1EvrRziwm4dkUglP+maS79K2VJN51L/xHuXQgULahR+YlpVRWvA5bNK1kI4TGhgFGcN5zu8pC43NCyxyaol1VGP32wQApgmTJpJTEsU3ZbICh4Ve9lTJoZyiBhXsVIszGKcl52X/UvD4uHP+V4MgyHtCx8eltuejjHKs4w/6YiLnhPI+Lm40CgfcRnFRFpHU8ZIPg07mcDxZb+QrMWLX0Ho0pE2ADEBdhmMiBSansCFzekvBFA==
Received: from KL1PR02CA0002.apcprd02.prod.outlook.com (2603:1096:820:c::7) by
 SEZPR04MB8175.apcprd04.prod.outlook.com (2603:1096:101:253::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22; Wed, 26 Jun
 2024 09:08:54 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:c:cafe::cd) by KL1PR02CA0002.outlook.office365.com
 (2603:1096:820:c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Wed, 26 Jun 2024 09:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:08:53
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
Subject: [PATCH v9 16/26] ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
Date: Wed, 26 Jun 2024 17:07:32 +0800
Message-Id: <20240626090744.174351-17-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|SEZPR04MB8175:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2797ea3c-cb54-4a9d-03b0-08dc95bf9a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|7416012|376012|36860700011|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Rlt14Kk+E5hcc4kvD1/r97AJl+hp94BvC5AOX0S3F0NK7sOJ9hpbe2zzFGb?=
 =?us-ascii?Q?X0s18GQPNfGUMGNs94J55ylAjVv47fi74beVF8Ty7IHE2sfjMH2ul5kytqZX?=
 =?us-ascii?Q?pTobKtywIQ5piiU5ZFvwQ0DMOB+CwqQng+by/uBk1d1TPen6Op2vluokY7lE?=
 =?us-ascii?Q?RLL7DcOcpVE6J4u+mJTO5wGPl0gSKkFU4Wsky2KtlzPHX06C2KgChbuyvaT4?=
 =?us-ascii?Q?scwuhubT8q8AJ2klA8tWNLSOczE5ECZFf8nb1thZ+48zNjlP84NpFiGQ5dCf?=
 =?us-ascii?Q?xonxbkAoKp8vYtI5yjskze0aUn53i0UZGcugbT7aE4hb7X0WF4T2I3l/XZu2?=
 =?us-ascii?Q?uyUmnprXsprscL0rYZ7lHo+uOw0GJXu/BcH6gFBY/9lLbK8P1zopTOXmqZf5?=
 =?us-ascii?Q?Of/O+X20iY1Qxf0jc9cYgsQZXIbvK5nsalr4RJ+pL4TvsU2Da0SCmwF2qA4D?=
 =?us-ascii?Q?WggRc63yzhETjzUxnlGq+NRsnlIpOfB2laBBavJpLN/NiBy0tzNRKJqZLZ96?=
 =?us-ascii?Q?hw4CVtQkZHK1WHgRcy9trTARruZgyv2iNYE+iExijP3GsaPWU1elPrg6FHFg?=
 =?us-ascii?Q?SEUnWS51OkfUcRlTaLGtKxFpxuvlHvVENseHUba1mDgII+mDwq5IaOxcYcis?=
 =?us-ascii?Q?+XTV28D95D2qdnXwGJmd3Uu8WoJ5DFLACPIwJ5awgFrrMH12rxhkdToC7yL/?=
 =?us-ascii?Q?T6rXA5QbgDHv8ZFsR1Fc5xeuB6tK11uXN3ah93+Cqemp3yOzSM9+gSW2DOlZ?=
 =?us-ascii?Q?rXNegGAhNxGMAXFMvSrww65BkaKTb4ISNuw4CcKggBfrxpV4rgX8lUTKhdYZ?=
 =?us-ascii?Q?uuQw83ebuCDjZl5MS3tSUbJzFicxCSaYK2QOVTRws+98WWTznuHXzNzeWB2S?=
 =?us-ascii?Q?rJEKA1IzfCG/Hdk0ly5ZEJOEh/q4/QLMkKERNl3YgXRh6Cvlf8a8YpfNO21m?=
 =?us-ascii?Q?XMaGDkaFbOZ0+Fv0Dy0pEF5EUwiuxPTmxoEJ1A0xCo4ebnD5acB5PE54VUfC?=
 =?us-ascii?Q?1DLnIx/nTvKsa+vkTrkcQbVwu3qIatxyTWskywoui3ssXSqFGvR3/wC33sRe?=
 =?us-ascii?Q?qdW9+3z6wXjU+rtqDYEdyejXp/RFjt+5n03pA1QfIlvn3hYsKPBqmf3/ZCh7?=
 =?us-ascii?Q?FQFZg6xQvhILZZ637AX5DHDiYe0gF9swAWOvTGU8XxqLgLjI4/f/fsEYNcKS?=
 =?us-ascii?Q?U4YsnmXzI3xJ/Eil5DitYckGGGgz2z4HUlhr1JMLZfA6vlFV3K1l7YlVL5dI?=
 =?us-ascii?Q?KfSKfTtdOtYPbh0qr+u5P2VGgB0FjkRYm6ziwN7bX2PGVY9da9/FJ5KSHGPJ?=
 =?us-ascii?Q?vlkdpLRdXYBlCBIzz2/6eGCw8SqyEB6WRlvstvzlg10h7SOYBsR2wm3nOgTt?=
 =?us-ascii?Q?NeAUuUnAD3GHWA8Peuq1QNhDPfq4h4e4fozhCupDoSEsIAXiaBC9UCFQRFcE?=
 =?us-ascii?Q?c2rR/eEcwKBMz9wpx1ayRqYAce9UO4z0?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(7416012)(376012)(36860700011)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:08:53.8331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2797ea3c-cb54-4a9d-03b0-08dc95bf9a58
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8175

Initialize bmc gpio state

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 234 ++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 8b23b012d6f5..3baf1df11a81 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1304,3 +1304,237 @@ &ehci1 {
 &uhci {
 	status = "okay";
 };
+
+&sgpiom0 {
+	status = "okay";
+	ngpios = <128>;
+	bus-frequency = <48000>;
+};
+
+&pinctrl {
+	pinctrl_gpio0_unbiased: gpio0_unbiased {
+		/* GPIOB0, GPIOB1 */
+		pins = "J26", "K23";
+		bias-disable;
+	};
+	pinctrl_gpio2_unbiased: gpio2_unbiased {
+		/* GPIOI5, GPIOI6, GPIOI7,
+		   GPIOL6 */
+		pins = "E16", "B16", "A15", "B14";
+		bias-disable;
+	};
+	pinctrl_gpio3_unbiased: gpio3_unbiased {
+		/* GPIOM2, GPIOM3, GPIOM4, GPIOM5,
+		   GPION0, GPION1, GPION2, GPION3, GPION5,
+		   GPIOO0, GPIOO1, GPIOO2, GPIOO3,
+		   GPIOP0, GPIOP1, GPIOP2, GPIOP3, GPIOP4, GPIOP5, GPIOP6 */
+		pins = "A12", "E14", "B12", "C12", "P25", "N23", "N25", "N24", "M23", "AD26", "AD22", "AD23", "AD24", "AB22", "W24", "AA23", "AA24", "W23", "AB23", "AB24";
+		bias-disable;
+	};
+	pinctrl_gpio4_unbiased: gpio4_unbiased {
+		/* GPIOR0, GPIOR1, GPIOR2, GPIOR3, GPIOR4, GPIOR5, GPIOR6, GPIOR7
+		   GPIOS0, GPIOS1, GPIOS2, GPIOS3, GPIOS5, GPIOS6, GPIOS7 */
+		pins = "V25", "U24", "V24", "V26", "U25", "T23", "W26", "U26", "R23", "T25", "T26", "R24", "P24", "P23", "T24";
+		bias-disable;
+	};
+	pinctrl_gpio5_unbiased: gpio5_unbiased {
+		/* GPIOV0, GPIOV1, GPIOV2, GPIOV3, GPIOV4, GPIOV5, GPIOV6, GPIOV7
+		   GPIOX1, GPIOX2 */
+		pins = "AB15", "AF14", "AD14", "AC15", "AE15", "AE14", "AD15", "AF15", "AA9", "AC9";
+		bias-disable;
+	};
+	pinctrl_gpio6_unbiased: gpio6_unbiased {
+		/* GPIOY2, GPIOY5, GPIOY6
+		   GPIOZ0, GPIOZ1, GPIOZ3, GPIOZ4 */
+		pins = "AE11", "AF12", "AC12", "AC10", "AD10", "AB11", "AC11";
+		bias-disable;
+	};
+};
+
+&gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpiu2_default &pinctrl_gpiu3_default
+		     &pinctrl_gpiu4_default &pinctrl_gpiu6_default
+		     &pinctrl_gpio0_unbiased &pinctrl_gpio2_unbiased
+		     &pinctrl_gpio3_unbiased &pinctrl_gpio4_unbiased
+		     &pinctrl_gpio5_unbiased &pinctrl_gpio6_unbiased>;
+	gpio-line-names =
+	/*A0-A7*/       "","","","","","","","",
+	/*B0-B7*/       "FLT-HSC-SERVER-SLOT8-N","AC-ON-OFF-BTN-CPLD-SLOT5-N",
+			"PWRGD-SLOT1-STBY","PWRGD-SLOT2-STBY",
+			"PWRGD-SLOT3-STBY","PWRGD-SLOT4-STBY","","",
+	/*C0-C7*/       "","","","","FM-NIC0-WAKE-N",
+			"FM-NIC1-WAKE-N","","RST-PCIE-SLOT2-N",
+	/*D0-D7*/       "","","","","","","","",
+	/*E0-E7*/       "PRSNT-NIC1-N","PRSNT-NIC2-N","","RST-PCIE-SLOT1-N",
+			"","","","",
+	/*F0-F7*/       "FM-RESBTN-SLOT1-BMC-N","FM-RESBTN-SLOT2-BMC-N",
+			"FM-RESBTN-SLOT3-BMC-N","FM-RESBTN-SLOT4-BMC-N",
+			"PRSNT-SB-SLOT1-N","PRSNT-SB-SLOT2-N",
+			"PRSNT-SB-SLOT3-N","PRSNT-SB-SLOT4-N",
+	/*G0-G7*/       "","","","","","","","",
+	/*H0-H7*/       "","","","","","","","",
+	/*I0-I7*/       "","","","","","ALT-MEDUSA-ADC-N",
+			"ALT-SMB-BMC-CPLD2-N",
+			"INT-SPIDER-ADC-R-N",
+	/*J0-J7*/       "","","","","","","","",
+	/*K0-K7*/       "","","","","","","","",
+	/*L0-L7*/       "","","","","","","ALT-MEDUSA-P12V-EFUSE-N","",
+	/*M0-M7*/       "EN-NIC0-POWER-BMC-R","EN-NIC1-POWER-BMC-R",
+			"INT-MEDUSA-IOEXP-TEMP-N","PRSNT-NIC3-N",
+			"INT-SMB-BMC-SLOT1-4-BMC-N",
+			"AC-ON-OFF-BTN-CPLD-SLOT6-N","","",
+	/*N0-N7*/       "FLT-HSC-SERVER-SLOT1-N","FLT-HSC-SERVER-SLOT2-N",
+			"FLT-HSC-SERVER-SLOT3-N","FLT-HSC-SERVER-SLOT4-N",
+			"FM-BMC-READY-R2","RST-SMB-NIC0-R-N","","",
+	/*O0-O7*/       "AC-ON-OFF-BTN-CPLD-SLOT8-N","RST-SMB-NIC1-R-N",
+			"RST-SMB-NIC2-R-N","RST-SMB-NIC3-R-N",
+			"","","","",
+	/*P0-P7*/       "ALT-SMB-BMC-CPLD1-N","'BTN-BMC-R2-N",
+			"EN-P3V-BAT-SCALED-R","PWRGD-P5V-USB-BMC",
+			"FM-BMC-RTCRST-R","RST-USB-HUB-R-N",
+			"FLAG-P5V-USB-BMC-N","",
+	/*Q0-Q7*/       "AC-ON-OFF-BTN-CPLD-SLOT1-N","AC-ON-OFF-BTN-CPLD-SLOT2-N",
+			"AC-ON-OFF-BTN-CPLD-SLOT3-N","AC-ON-OFF-BTN-CPLD-SLOT4-N",
+			"PRSNT-SB-SLOT5-N","PRSNT-SB-SLOT6-N",
+			"PRSNT-SB-SLOT7-N","PRSNT-SB-SLOT8-N",
+	/*R0-R7*/       "AC-ON-OFF-BTN-CPLD-SLOT7-N","INT-SMB-BMC-SLOT5-8-BMC-N",
+			"FM-PWRBRK-NIC-BMC-R2","RST-PCIE-SLOT4-N",
+			"RST-PCIE-SLOT5-N","RST-PCIE-SLOT6-N",
+			"RST-PCIE-SLOT7-N","RST-PCIE-SLOT8-N",
+	/*S0-S7*/       "FM-NIC2-WAKE-N","FM-NIC3-WAKE-N",
+			"EN-NIC3-POWER-BMC-R","SEL-BMC-JTAG-MUX-R",
+			"","ALT-P12V-AUX-N","FAST-PROCHOT-N",
+			"SPI-WP-DISABLE-STATUS-R-N",
+	/*T0-T7*/       "","","","","","","","",
+	/*U0-U7*/       "","","RST-PCIE-SLOT3-N","",
+			"","PRSNT-NIC0-N","","",
+	/*V0-V7*/       "FM-RESBTN-SLOT5-BMC-N","FM-RESBTN-SLOT6-BMC-N",
+			"FM-RESBTN-SLOT7-BMC-N","FM-RESBTN-SLOT8-BMC-N",
+			"","","","",
+	/*W0-W7*/       "PRSNT-TPM-BMC-N","PRSNT-OCP-DEBUG-BMC-N","ALT-TEMP-BMC-N","ALT-RTC-BMC-N",
+			"","","","",
+	/*X0-X7*/       "","LT-HSC-SERVER-SLOT6-N","FLT-HSC-SERVER-SLOT7-N","","","",
+			"PWRGD-SLOT5-STBY","PWRGD-SLOT6-STBY",
+	/*Y0-Y7*/       "","","SPI-LOCK-REQ-BMC-N","PWRGD-SLOT7-STBY",
+			"","","EN-NIC2-POWER-BMC-R","",
+	/*Z0-Z7*/       "EN-P5V-USB-CPLD-R","'FLT-HSC-SERVER-SLOT5-N",
+			"PWRGD-SLOT8-STBY","","","","","";
+
+	pin_gpio_b4 {
+		gpios = <ASPEED_GPIO(B, 4) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_b5 {
+		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+		input;
+	};
+	pin_gpio_f0 {
+		gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f1 {
+		gpios = <ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f2 {
+		gpios = <ASPEED_GPIO(F, 2) GPIO_ACTIVE_LOW>;
+		input;
+		};
+	pin_gpio_f3 {
+		gpios = <ASPEED_GPIO(F, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f4 {
+		gpios = <ASPEED_GPIO(F, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f5 {
+		gpios = <ASPEED_GPIO(F, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f6 {
+		gpios = <ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_f7 {
+		gpios = <ASPEED_GPIO(F, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_l6 {
+		gpios = <ASPEED_GPIO(L, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_l7 {
+		gpios = <ASPEED_GPIO(L, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_s0 {
+		gpios = <ASPEED_GPIO(S, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_s1 {
+		gpios = <ASPEED_GPIO(S, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v0 {
+		gpios = <ASPEED_GPIO(V, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v1 {
+		gpios = <ASPEED_GPIO(V, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v2 {
+		gpios = <ASPEED_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_v3 {
+		gpios = <ASPEED_GPIO(V, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w0 {
+		gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w1 {
+		gpios = <ASPEED_GPIO(W, 1) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w2 {
+		gpios = <ASPEED_GPIO(W, 2) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w3 {
+		gpios = <ASPEED_GPIO(W, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w4 {
+		gpios = <ASPEED_GPIO(W, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w5 {
+		gpios = <ASPEED_GPIO(W, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w6 {
+		gpios = <ASPEED_GPIO(W, 6) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_w7 {
+		gpios = <ASPEED_GPIO(W, 7) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z3 {
+		gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z4 {
+		gpios = <ASPEED_GPIO(Z, 4) GPIO_ACTIVE_LOW>;
+		input;
+	};
+	pin_gpio_z5 {
+		gpios = <ASPEED_GPIO(Z, 5) GPIO_ACTIVE_LOW>;
+		input;
+	};
+};
-- 
2.25.1


