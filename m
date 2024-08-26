Return-Path: <linux-kernel+bounces-300820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D8495E8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094511C21734
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E632A148310;
	Mon, 26 Aug 2024 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="gLB6giVT"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010058.outbound.protection.outlook.com [52.101.128.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545F14830D;
	Mon, 26 Aug 2024 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653608; cv=fail; b=WdZkMWZKlMWzff02Tgsxm5K0vyNSWKyR8e8+fiqNJlUjHkDBo2hkHIweXjxkbkwTqqEN56dHZPb2Hli7E15sJNdiWBR62m9o2ZxCM1kaYCgyZdpzPi5IjwLvF+6xxca4OTCnSeOaRa6xB99W+z+ew6ASyaEhXVLDOKiA8Nyxy+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653608; c=relaxed/simple;
	bh=Zc44MPj5msfgVgX+6h+5N5exmY1yQ5xjfARItL8A3D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFdSSr0nh+bjVzXpIBrZL++smVOoYJ6gAtcMXeePj9SB0oiTbJDi7KLYyKifKIUtr/n7nTsC1IFZ7o0AZB07OvMsmMVi8G5tkoIROdPlK/1sDT9o5dluDtiMI7wM6W91ODQCyHgrvJTmxbZoIRFSxRVTeKCWsQOEfpg3KzcPgyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=gLB6giVT; arc=fail smtp.client-ip=52.101.128.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuXpaHWBTlpg+QWsDD1FrrCdHVKmEOVQb7MNr6st42kOIUrAvcHVxLHs56jISRT76aHlev+D6H5YjlS/7FiRZ1g3xcBtBbcyXnp1I4U3HghPd2/bxng5zlTTGh5LZEmyVVg3IWQkLhh2m9VUz9IOGQx6qvl+JgTHk0eRBf8aAw6nt2Gjj6BdLRmSOJCjfE4CzkbHU85PPHjeFJA2CHrd6g5+rZq2xWyaP3UVXY6wcFTeG68RIbgcvnDrAGEMngVjL2M2wLDDKMfYBf6lH5+DfYprgJIz+jlbbxiE3vPdMBE1PMIens4ixb0SIo00NBfnwV52GrOkKd7/9+3rDAI83g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pXz7BSWZBdMOtEGyFa/mxHhT1h94fl5HKQ6bKEYhdI=;
 b=E1sXWTBpT7w3Dp/LkTl6WaKn58wO0FmA42iHvDIPjkWEHVpTCkFmkvRNRr9DzeIMuuZacfeBkN/6Gm9yoe5zH4Ct8H978LDa+L2PffAY9YVa6Q05D26k6HtOY5dyJJsty1rknbqo+XmBOwW7PyHB66b3Kbz0uf1k6UA/WPHObhiFtSuZCDsN7lZD1KW/93LTQx0ve0xuThDpqRBg86997+r5wyYp6uDtunIai7voPFcSuhGB2idR9JOxNrPfv7LLEt2lrFxUNfE1gY6J/j/d0dWJbiuvMTB2u5m0CKxKYtuhRTBAroexhUCPAuk4aG6Dt362EXZJnH5egmjAu3NxCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pXz7BSWZBdMOtEGyFa/mxHhT1h94fl5HKQ6bKEYhdI=;
 b=gLB6giVTveKBqwmklKK1QAWkr2xfHshh4EzWJFx24jBbZFrbc7+639PJDpbZcolyjwfFNT91h9FF8czppNBVnCXI07NNlhYG9EqcMRGEU2/jHXqFASeAaGt7gMcWEWLf4R8bi4cZ/vJOz7oxGA596E4Z9Ah8IOQosOnykgB3ux/9QBhpMYPylwUXxUrfOcz951LbTUFrMmB3U8ZGZLPdY3FQbpeyv5cB8gc/odUcDtBpuTwEhkP/7XNBjAJ3czeCiqOWONKZbIhGt84smY9ReHzzUomUYwCCqdU25xXn/2AbEjI32WPLj6XvbKMHWcI7gNtNRkY7g9JKQT9CDCHnLA==
Received: from PS1PR03CA0014.apcprd03.prod.outlook.com (2603:1096:803:3d::26)
 by SEZPR04MB6300.apcprd04.prod.outlook.com (2603:1096:101:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:26:39 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::a7) by PS1PR03CA0014.outlook.office365.com
 (2603:1096:803:3d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:38
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
Subject: [PATCH v14 27/31] ARM: dts: aspeed: yosemite4: Adjust ioexp bus and remove mctp driver
Date: Mon, 26 Aug 2024 14:24:01 +0800
Message-Id: <20240826062408.2885174-28-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|SEZPR04MB6300:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0c66b306-1717-412c-fa1d-08dcc5980acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?06OjCDNzMDraeHGIe2IxmGC/Yjx4toa6rf9z27MQ4JYY31txTKoDOSf5tIsJ?=
 =?us-ascii?Q?Eg4qFjScELUHh/jBA7w2bKR2LuK/K9InJ5PcOEwwvIl3JDDXfDNS9Gl17YUU?=
 =?us-ascii?Q?M58+lN87bIAsOXlURWfAon2trzNu0FApRfrIndz17Yd5mNBy/a8wrgGdvXs2?=
 =?us-ascii?Q?PA9VZiqBnwIabQqgloMHMcHfrRNkP1wNXu7tsZJxwuJ15ByBctNDCvt4V8wc?=
 =?us-ascii?Q?GYYUeXxdg2iM21bFGue1m4fwDo4GLl+Sll7anAL/DRRu4VuZntLLoxQPOdBC?=
 =?us-ascii?Q?Ty4xGAZqIJRKxiAi2DkLgwBsqL0s0K+mz0jNnlMH0XG+1mU3zdhQ0pdEAH2n?=
 =?us-ascii?Q?zcKIeP1Yx4LEbWYLEWklSZV2NhRxxLau7UkSMqao90LEByu804/TKWb7dHnt?=
 =?us-ascii?Q?0fY9/kmZ/Neob1DSbAgftEvrt5KVzrg33Twr1aVUOs9DmvCntUGL1aekVNTf?=
 =?us-ascii?Q?Q0PoTo9//3pUee4Nc8PCBK7WbPL7CjjH/xoko7KExi9XzKEaNDbSIdEI4juT?=
 =?us-ascii?Q?j65bkp7bjIUYx0WHaKyP+mF0F4WmEBFwOp7Huko/e0ojrxEE0ZQg7owx5hS+?=
 =?us-ascii?Q?0RCn7k+6ZuMUwdeNwB8MMBJ6nlqtKvuIN2QMDpl1puU9tl3xqqYjk9LNHF4t?=
 =?us-ascii?Q?hptCwUxQU6ujA8/hOCcar6mwixQXipLg/PBUi3tWCmZTOlqH/DfeiMTndBn9?=
 =?us-ascii?Q?n1hTcq2aEtQuNxV4jTjC088IassevjrVU86h9BHA3L8hWK96jEYFj8hEwU5E?=
 =?us-ascii?Q?KF+oZT9/e7eD5b5Jh7gVnTlAl70mh4J8IJlryO0mq9oxYeEMkk7EA5f64si4?=
 =?us-ascii?Q?0Q/f5yzbfg2urYQjk9XI+LpyAYRWgn4u7220RtgHA+OZi+6bd8doTp/sDtDV?=
 =?us-ascii?Q?KQ+oJZMjmqYbE8z5bZrC6j9/a7COJKJHFoja8E69AyaAwm+g+WcJMk3A64GF?=
 =?us-ascii?Q?zlhuVRe1OsmNV9wuvieFcSPVt7/qlSj5PaNTpaaw9Ox3uzcprgiQpAqOjN2n?=
 =?us-ascii?Q?VDXUTT2eOddkxeHzN/PmGN4adxE9DPRCthXrSylCPvHNAH1+mrHzDGtiLXuR?=
 =?us-ascii?Q?/wzMCDlkprPv3SzvsRRui0r4HN/PcRQyTHLDfKFr2BJ0up6X8byUVJcnyHEH?=
 =?us-ascii?Q?wfdNUAcuxexYZa++tG7uoYjN0iQVcYL/G5cjI+yfHr1mgKUCHO7rzXWJnLWO?=
 =?us-ascii?Q?qVy9cWKo6ZRoJ5yG4hD6IpG2kEkUeupb2aH0Ij1EsmG99tA6rIF3eGuCcan7?=
 =?us-ascii?Q?8kV4JYaJUl2nNn+n/HUmGwt4tV9bzLvP/EOUxs8KmxWvHhWgHfItGB5tYvhY?=
 =?us-ascii?Q?7kXqfSR0GGjk5xXuEGbUkpkDLxxj/k/ALAwM15YKbLPfNYCIldIF7nlI35LA?=
 =?us-ascii?Q?oTVoakixJfTGsSBgF6hmbQbun2k/VU64l2eoYPbzm4GSHsph2VIgeZeXT3zR?=
 =?us-ascii?Q?e8UgQ2S9oQgCCqSbuuoKtBmaxdRg5sul?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:38.4552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c66b306-1717-412c-fa1d-08dcc5980acd
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6300

Adjust CPLD io expender for PVT stage.
Add GPIO name for GPIOO7.
Only binding MCTP driver on the down-stream port of the mux.
Remove unnecessary driver binding since there's no MCTP device before the mux.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 59 +++++++++----------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f139f426099e..abd4a9173de4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1156,6 +1156,34 @@ rtc@6f {
 				compatible = "nuvoton,nct3018y";
 				reg = <0x6f>;
 			};
+
+			gpio@20 {
+				compatible = "nxp,pca9506";
+				reg = <0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@21 {
+				compatible = "nxp,pca9506";
+				reg = <0x21>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@22 {
+				compatible = "nxp,pca9506";
+				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpio@23 {
+				compatible = "nxp,pca9506";
+				reg = <0x23>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
 		};
 
 		imux35: i2c@1 {
@@ -1188,34 +1216,6 @@ ipmb@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 		i2c-protocol;
 	};
-
-	gpio@20 {
-		compatible = "nxp,pca9506";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio@21 {
-		compatible = "nxp,pca9506";
-		reg = <0x21>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio@22 {
-		compatible = "nxp,pca9506";
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	gpio@23 {
-		compatible = "nxp,pca9506";
-		reg = <0x23>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
 };
 
 &i2c14 {
@@ -1470,7 +1470,6 @@ adc@35 {
 
 &i2c15 {
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 	i2c-clk-high-min-percent = <40>;
@@ -1680,7 +1679,7 @@ &pinctrl_gpio3_unbiased &pinctrl_gpio4_unbiased
 			"FM_BMC_READY_R2","RST_SMB_NIC0_R_N","","",
 	/*O0-O7*/       "AC_ON_OFF_BTN_CPLD_SLOT8_N","RST_SMB_NIC1_R_N",
 			"RST_SMB_NIC2_R_N","RST_SMB_NIC3_R_N",
-			"","","","",
+			"","","","FM_BMC_SLED_CYCLE_R",
 	/*P0-P7*/       "ALT_SMB_BMC_CPLD1_N","BTN_BMC_R2_N",
 			"EN_P3V_BAT_SCALED_R","PWRGD_P5V_USB_BMC",
 			"FM_BMC_RTCRST_R","RST_USB_HUB_R_N",
-- 
2.25.1


