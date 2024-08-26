Return-Path: <linux-kernel+bounces-300808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A529A95E8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B026B211B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5093E12BF24;
	Mon, 26 Aug 2024 06:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="JPO1baus"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5F213DB8D;
	Mon, 26 Aug 2024 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653541; cv=fail; b=kIEOV0GigPUx7NS0DSg8e+kqP8p+Ki6W1dkLaRKIagDm6INcGsM1KPiI3UdlL172SiIFyTOHfnF4cJap4mnRGs25R8lEEWH4czb5RPcoLgokX6/H5on+QwYp3h7rNma1WfN+klkyGDS6R6RjfBqYEY9d3FSPCkhLGUe0SXiZHSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653541; c=relaxed/simple;
	bh=W1y+C4sXnox4wumSSdh7WwUCooTgolgBiJuZYNS8v0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwz7ROWnQfZS6jzYIbWvVlgIQg/x9RDw7sAwa1oxmy2A+0Rvpb5If3sXvB1zpDJrsFPFb9t3RCYFgTPwEVm+h63YI+t4BSIFYDGrKO/HnJ5+7didWf9l8rk2KL95i/MPdi35Im/B/r94diELH2xUPolSf6GxEzGQxq2q2/pbRQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=JPO1baus; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWTrJgqKVrqWM0XFUnjF6Piumosv0PiA/ThrHAkpIJKF6iTfodzO1wTL75eDoFX7WPYjdpeBil2g1MA394MULOqiEZqZWbrElzVAxWKDDChRWITBlzVafr1ILMT+kq8CDxQGsPNQO/HrdtFVeoIJ2QBEAJ+w2/v8V1AaO2KfTjoA6ZP0P0wAXgeOwewY7tSgY9AGKDGyMEei8XelB9un40hJOO/040cOXag17kOb8PAHsLNycSGrTlYEzZ3qBhQZEpRjCy6oa9EOw8oBlfvGBjcswOKnJuTXhIf7qGVuLYVhMfUtdqik3MsC0JdC68aEEwVIQPQcEYHqVSY5tePBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a3fmLxoiZoHer3nbvtXCi+p9e6DuNqkqeX2BgsIrCA=;
 b=KGpqaNEq4LqtFodFBAjcVtBIQXQpDFa/CVYM6Ve9R+nAPg1YXiR2QF6j+pGm+7AMnIbO3rQlkA99fFhQ2uoH22LfvGGfy+7fZNT2wsTre/yy1CYXh6NHuMVmL5ttyuHcC6buZpe07Ptb5zJW6lpTlzYupRunJKK33F07zTZtRx71oY3F91rOwtBY2taL6rIaAT8Ho315AgErlTgGhWpwy0eWCQH+E9o/9bjAeUWksF6HVC91c0AU0aAuAdEhWIc/Hez7PVu9fWEeQWX7wFk6MtnhLOL1gJdSF2Ydl6yDgJW91Kk0PumbNOlL3DRU+FpQ1kYW1CEtCQuuYjisF5R56A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a3fmLxoiZoHer3nbvtXCi+p9e6DuNqkqeX2BgsIrCA=;
 b=JPO1baus3OwJRXrKZR2YbB4oRlwaoyE1rp42ZrxxSUv/R0AfJEqC3JlAwHdhrYIx8S4+XgYdhGIuo2hATGtCjeeIbsAC8cpFIJySDl8OVO8VPEfXS8UJXBu3W8VOwQjHykc56SQwRqxTCyhhlvvpiHDyuR9ExLw4xR6TeHDzQZbm7aAhYTlI3Jm0iwRxK4mQwVk5BEWopx7/lRhNdku4GqPrM97G6sQ6elMgXdJflfglqCueGcC7cjbqI9gAITGn3yHn/+u95q+QbHrRuxMAK7ZcxjveLPaGvNvLqyr72z3gULiRY1rT5WE0q/28igeZvgr/cjzW7gOB6iA94SVKSA==
Received: from PS1PR03CA0004.apcprd03.prod.outlook.com (2603:1096:803:3d::16)
 by KL1PR04MB7212.apcprd04.prod.outlook.com (2603:1096:820:f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 26 Aug
 2024 06:25:28 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::7f) by PS1PR03CA0004.outlook.office365.com
 (2603:1096:803:3d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:25:27
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
Subject: [PATCH v14 16/31] ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
Date: Mon, 26 Aug 2024 14:23:50 +0800
Message-Id: <20240826062408.2885174-17-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|KL1PR04MB7212:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d58a348-be9f-4d50-7ce6-08dcc597e045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?APckJpJhfkoy8OugOkyymcnt51pKA074xPp34CoGLSv2tIWOrQ4QqhrkPJrj?=
 =?us-ascii?Q?2x8+O2o3/QxbZ99vzGfhyZn4AclkOilpnKxhppIrXEW7GZbQvgbkO+nCjHnI?=
 =?us-ascii?Q?WFCC5TRbD9H53kvunFKRnFGyCL/GKF7wdC01OgN0OEDjYWr9pK3CFCzP/D3H?=
 =?us-ascii?Q?88KGWEd31khvCB8qfuDgHQHwej6nS7M/7OM7N/3yjUt7jy9VQy0nYHnfkJ9o?=
 =?us-ascii?Q?DBrUpNNZRXfPTGgC3i3qr8W8nzmBWyepQYsBIxZw6ll7Xayx7kcILJReDo+u?=
 =?us-ascii?Q?w0jMn58RCSUoWEI5O4W8rJEgUGiCrU6JTU4S/U5RnRjy7jKWw3fqgkxA5T7U?=
 =?us-ascii?Q?AAxErT0lE8+Zhn4DBUEEy5zSqoqogNvfsoEGAFEmgJb+8pRtkZbJXjBjEys9?=
 =?us-ascii?Q?NOhP21T6Bzhd96V86kN6jekuC+jsOTEVQjFBwvoDLQoRDd1OxCzQZ+oFLWnq?=
 =?us-ascii?Q?JnMU/0LCaP1awmK8bi65Tad/XmOe+6QdAZTcznXGxV5jIXKG0wyRQaWiHE57?=
 =?us-ascii?Q?syCKmiwd73z5Mj2EJGvFGUa8NscFE90S7m147b2PGzoin+xYwxMA+AxPzvtd?=
 =?us-ascii?Q?lvieG8WZZyHe25gwYIbz21ksdnwXXh6qAJ1qYOLg8OwMXacgfW+A8g80yx3L?=
 =?us-ascii?Q?DcP6ceKciItzT8QkPbW1mRySBs3s47VUFv/ub8qTh09XJfZ0CODX3gEgoCUJ?=
 =?us-ascii?Q?zvKq8VMmK2V1W2KjXcDLMnftt5h5DthgJfg4P1ZGsKcrMrpC1ILxbCXSmdYu?=
 =?us-ascii?Q?bMypO5ZgYZzs2BQUVpyMaSL/cr1d6wEilj4tCEJwnqtvpHfp5PY2r9r6IFFl?=
 =?us-ascii?Q?CxX1H0tK//xAnmPeJ+XI7c0PFJ3hRu9jejXZzLsD23SV7HFutRk7ZElW6H+B?=
 =?us-ascii?Q?jfMKXC228b9X9BvlHzC4tGg5OXP9jhcuHhgfbzgRMstzy/B9QxljjRSf9u+Y?=
 =?us-ascii?Q?RqjrnFpXzGWz9vfWCFSK3IHRN+P6YvpdzszCxPn2Yi/MRSgP9dQ5bxbySs3j?=
 =?us-ascii?Q?5Fecshaxcv0fbi3jXMp8SAiV3iX8TX88w4eyK0MNJ9I6vjfcUWG8EGhzyzDi?=
 =?us-ascii?Q?Sorbfpx6tVrTnVJYrOUWbziUP7bJSxucQ9/MX86JQ4OSOP00cLJrWlv9buMK?=
 =?us-ascii?Q?ulvRawOs8p1FiuyJRncatObN5dixDvhq8+9uUbcgA+/Gtt+bIFWY6vfzLw7e?=
 =?us-ascii?Q?uubDOc/Xfsmp87nmIcpFz7W9xCY++6JLvPBDYkWx25Sk8znaVsh5IWGMZtwi?=
 =?us-ascii?Q?TTogMlHI3/7FMuL19Dc8JwwVZFRg2g6fysbxmtVN8KjrSdJmMhKWaFIUGHYQ?=
 =?us-ascii?Q?WSHAYP+NL+Mf6GKjMjSeN/HuPHgXeS2WODhEPQ6/NsrT0eQR5xf3OjBMao4B?=
 =?us-ascii?Q?AVG0SxVYtmzqHw4m/utvlBmUR1H3E4lD8eiINlRaFP4FDXWwKphosvc6zWBW?=
 =?us-ascii?Q?RgYWhVhx3PVYYxZPm+4JDoeC0FX+Lt7X?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:25:27.0964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d58a348-be9f-4d50-7ce6-08dcc597e045
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7212

Initialize bmc gpio state

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 234 ++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index c0497a1aa93e..60743f9829a5 100644
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
+	/*B0-B7*/       "FLT_HSC_SERVER_SLOT8_N","AC_ON_OFF_BTN_CPLD_SLOT5_N",
+			"PWRGD_SLOT1_STBY","PWRGD_SLOT2_STBY",
+			"PWRGD_SLOT3_STBY","PWRGD_SLOT4_STBY","","",
+	/*C0-C7*/       "","","","","FM_NIC0_WAKE_N",
+			"FM_NIC1_WAKE_N","","RST_PCIE_SLOT2_N",
+	/*D0-D7*/       "","","","","","","","",
+	/*E0-E7*/       "PRSNT_NIC1_N","PRSNT_NIC2_N","","RST_PCIE_SLOT1_N",
+			"","","","",
+	/*F0-F7*/       "FM_RESBTN_SLOT1_BMC_N","FM_RESBTN_SLOT2_BMC_N",
+			"FM_RESBTN_SLOT3_BMC_N","FM_RESBTN_SLOT4_BMC_N",
+			"PRSNT_SB_SLOT1_N","PRSNT_SB_SLOT2_N",
+			"PRSNT_SB_SLOT3_N","PRSNT_SB_SLOT4_N",
+	/*G0-G7*/       "","","","","","","","",
+	/*H0-H7*/       "","","","","","","","",
+	/*I0-I7*/       "","","","","","ALT_MEDUSA_ADC_N",
+			"ALT_SMB_BMC_CPLD2_N",
+			"INT_SPIDER_ADC_R_N",
+	/*J0-J7*/       "","","","","","","","",
+	/*K0-K7*/       "","","","","","","","",
+	/*L0-L7*/       "","","","","","","ALT_MEDUSA_P12V_EFUSE_N","",
+	/*M0-M7*/       "EN_NIC0_POWER_BMC_R","EN_NIC1_POWER_BMC_R",
+			"INT_MEDUSA_IOEXP_TEMP_N","PRSNT_NIC3_N",
+			"INT_SMB_BMC_SLOT1_4_BMC_N",
+			"AC_ON_OFF_BTN_CPLD_SLOT6_N","","",
+	/*N0-N7*/       "FLT_HSC_SERVER_SLOT1_N","FLT_HSC_SERVER_SLOT2_N",
+			"FLT_HSC_SERVER_SLOT3_N","FLT_HSC_SERVER_SLOT4_N",
+			"FM_BMC_READY_R2","RST_SMB_NIC0_R_N","","",
+	/*O0-O7*/       "AC_ON_OFF_BTN_CPLD_SLOT8_N","RST_SMB_NIC1_R_N",
+			"RST_SMB_NIC2_R_N","RST_SMB_NIC3_R_N",
+			"","","","",
+	/*P0-P7*/       "ALT_SMB_BMC_CPLD1_N","BTN_BMC_R2_N",
+			"EN_P3V_BAT_SCALED_R","PWRGD_P5V_USB_BMC",
+			"FM_BMC_RTCRST_R","RST_USB_HUB_R_N",
+			"FLAG_P5V_USB_BMC_N","",
+	/*Q0-Q7*/       "AC_ON_OFF_BTN_CPLD_SLOT1_N","AC_ON_OFF_BTN_CPLD_SLOT2_N",
+			"AC_ON_OFF_BTN_CPLD_SLOT3_N","AC_ON_OFF_BTN_CPLD_SLOT4_N",
+			"PRSNT_SB_SLOT5_N","PRSNT_SB_SLOT6_N",
+			"PRSNT_SB_SLOT7_N","PRSNT_SB_SLOT8_N",
+	/*R0-R7*/       "AC_ON_OFF_BTN_CPLD_SLOT7_N","INT_SMB_BMC_SLOT5_8_BMC_N",
+			"FM_PWRBRK_NIC_BMC_R2","RST_PCIE_SLOT4_N",
+			"RST_PCIE_SLOT5_N","RST_PCIE_SLOT6_N",
+			"RST_PCIE_SLOT7_N","RST_PCIE_SLOT8_N",
+	/*S0-S7*/       "FM_NIC2_WAKE_N","FM_NIC3_WAKE_N",
+			"EN_NIC3_POWER_BMC_R","SEL_BMC_JTAG_MUX_R",
+			"","ALT_P12V_AUX_N","FAST_PROCHOT_N",
+			"SPI_WP_DISABLE_STATUS_R_N",
+	/*T0-T7*/       "","","","","","","","",
+	/*U0-U7*/       "","","RST_PCIE_SLOT3_N","",
+			"","PRSNT_NIC0_N","","",
+	/*V0-V7*/       "FM_RESBTN_SLOT5_BMC_N","FM_RESBTN_SLOT6_BMC_N",
+			"FM_RESBTN_SLOT7_BMC_N","FM_RESBTN_SLOT8_BMC_N",
+			"","","","",
+	/*W0-W7*/       "PRSNT_TPM_BMC_N","PRSNT_OCP_DEBUG_BMC_N","ALT_TEMP_BMC_N","ALT_RTC_BMC_N",
+			"","","","",
+	/*X0-X7*/       "","LT_HSC_SERVER_SLOT6_N","FLT_HSC_SERVER_SLOT7_N","","","",
+			"PWRGD_SLOT5_STBY","PWRGD_SLOT6_STBY",
+	/*Y0-Y7*/       "","","SPI_LOCK_REQ_BMC_N","PWRGD_SLOT7_STBY",
+			"","","EN_NIC2_POWER_BMC_R","",
+	/*Z0-Z7*/       "EN_P5V_USB_CPLD_R","FLT_HSC_SERVER_SLOT5_N",
+			"PWRGD_SLOT8_STBY","","","","","";
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


