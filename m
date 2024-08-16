Return-Path: <linux-kernel+bounces-289382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349649545B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AE32816C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97E15821A;
	Fri, 16 Aug 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="xyaS3F/n"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010069.outbound.protection.outlook.com [52.101.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2961422D8;
	Fri, 16 Aug 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800347; cv=fail; b=nYRA9d+wQfds5VCh9XKi0ZPCV5JEMA2i8bUXwWilVo3y5Uuz647pMMrLEKemywGTwrNH2hPweQHb1vVgtBtBv2rFEemxuOHA3XJn1liXhwhXXyT1FpQcGjDBFNcxXeYJ17XTqv3hrjSftjqwbcIKgkGFcvICjNexb3xVPkZ2pxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800347; c=relaxed/simple;
	bh=W1y+C4sXnox4wumSSdh7WwUCooTgolgBiJuZYNS8v0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVvSG1WpHOFPO8ZKMbhOlTZ0tTCYbbOglB23xier64QwrXoEa4C3t4yr72eIRPg8FnxvONFh5tatnB3nEDS9VUMdJyUAi8mkWOr2Z1lya66Hxy4pJxYEUnIQzy/eHkHmrUVgHLqpU7QeqrYKTfFfOThKx8Hh2/gvJd7dvSxBfgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=xyaS3F/n; arc=fail smtp.client-ip=52.101.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1eT7mcBaMZ1wUuemhuVHuZeHt0O4ATq+vh+HYvq37QtUn35umnY23B2eV1oh/NT5/F8gQkg4DVHg2hq9V3bjb6PoUOdcTWrDZ9eb33Qa3oS/2HEHTMP3TvF0Kf4mBdboNsuvP7WmI+HHjP8cLBDLhh68L4uHnxFF2RJJFz3XhPLMzOauCeH9Cw9GGt1Kghq1N91S2+vZUaY06ivKVw8aj3AHm8cCxwYVhNFfDibD4kTqkSzUDJwxrjORVGaD+8mptmY4CFjPSrZ9oXE6W7zP5thj2gwTycY8PSO95uVWX1ARtH3NxZ72qEwlEytE/SrF0NWygn87i2CvrKzh4RZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a3fmLxoiZoHer3nbvtXCi+p9e6DuNqkqeX2BgsIrCA=;
 b=SWi6nlgwpGpBfWAd/FYfj4my5ELM8GpIpxp1s0+AljdqA6ZzNQ6Yocre7NMEdtq0aFTZlEN6EgPX5ajYQoUlw6awDqF06AR80tS5RSRh0/O5k5ztp7UZRVIpsg9yJlWe4AFKLqZwJOUnhf8UnC8rrxXOTeVqhLdFAxwnq1pFSkZg0jSoph878P38oPZWvlmS4xnJ0YHVJzqPlydyjLKlPe9EdgBr6UY6Ek7tNEspjlOOf1H5y6ysJFibjlVB2C8pf633ZLSToFOblCSq9J1bFUC6ZZlurEmjSw2w4TN4OIWZ4bkInVBtVetmwlTX/SaVJjOSeEmGBv1pDPyr2kattQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a3fmLxoiZoHer3nbvtXCi+p9e6DuNqkqeX2BgsIrCA=;
 b=xyaS3F/n+hkn1zsEX7YBxM39GvYSMeGV5ZiUf1MRpinFnvDeXrYvqUs79itgwTEfB9PGnk47gqEPPPZz/SAS4N/5S6mRetzzOENVXchZuhqWNbbnDthy9Npy2dKBtI6zSQf279F4dKXjeSY6R8CBdf9V+z7+kgDQAwuX1x804LSKhUP/gy4VXhJXcdSa65NIm+fBqvYdVkrmPVHyauUa1F8zr4aN9PKNRQoEf4IM++TQ32EIe7nMHItG40NQfknHRH+o8q8UaOimYCLddXbvWjF/fVDAw4xMk+8/9UWB/zz2SX2a6YCEoSF8jxz94R5l5dUOM5sDLn98pUiv+ROGJQ==
Received: from SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) by SG2PR04MB5793.apcprd04.prod.outlook.com
 (2603:1096:4:1d8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:25:38 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::bf) by SI2PR01CA0046.outlook.office365.com
 (2603:1096:4:193::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:25:38
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
Subject: [PATCH v12 16/28] ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
Date: Fri, 16 Aug 2024 17:24:03 +0800
Message-Id: <20240816092417.3651434-17-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|SG2PR04MB5793:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1d025aeb-0a20-4211-25fc-08dcbdd5642c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gIeHhTEMVHv51DzcDpZTPEWk9X3EGrzLZ4LOtwrtUpUhTlyIwRiKD0UbBLOD?=
 =?us-ascii?Q?vdP3ZxGr7sXphz1HRoLsuIBkzF0sku7kS+tfoUBt/gsT1BsWRPsXgag5u0Yp?=
 =?us-ascii?Q?CfPAqF406CsUtHaEtRq39LOg2/BLRNoWwMwhm1BguouD0dlGtDb5171wPzNS?=
 =?us-ascii?Q?C8RsjtlmVfhlxfYvPIHOVyeaUETD3EKOV9vPfIWwO/4vmhurH2pvJOf0zPjz?=
 =?us-ascii?Q?6CYGc8p5CcpoqgM/f6opC4Zd0njHrx/MnTwh+VzDQ37sGeKO2n/Lz2sKByh4?=
 =?us-ascii?Q?Pj8l949Y70PqLLUZx5ra0pNCf2XUwLfhzL9VxQ9pJX2syaOrXNUVljVDeENP?=
 =?us-ascii?Q?Q40PRBIpRe1XagnNVn/pswEF36KhLGXq4eMZE8JGSyFskpp9FwNrqI1psHbg?=
 =?us-ascii?Q?oIzuB7GFhWhLlh1kIepXZ5Y1uRcMqSAuLTVUykCjdvR1gK/uvrCO575sn0//?=
 =?us-ascii?Q?49kG9NcaslRxzQWaWtGYB/dbQg17GIpy/gh5ASam1mChf1hszqoHUBZsdLkw?=
 =?us-ascii?Q?D1pi5hShXX2lpFiWFR18PdxdGdQLzt3QrAaMkunBmFPIt3mvJeLwCnskouKg?=
 =?us-ascii?Q?s2+MaYJkwvWoaWcNp1VlkS39L0lR4dzQTfzv1kqGehRstkHT12tjtEi5JacA?=
 =?us-ascii?Q?Df4HZ7/91OJMTXdyGc0Dv3llxvxCfBnvEy/OkmV2Fw/JysIxOoNv1fmLYSgp?=
 =?us-ascii?Q?h7ZEDLHVwjm9xdqUGoXDgklFZDUsfmtJ5yCykwr6LUy6cLFYsWaLLfjxVrdq?=
 =?us-ascii?Q?5A/cXXxxJ/6Hgq+H4rolHZNcJUoQJED5bCfqgcqzG15rrEhGHztkbPqGvE8I?=
 =?us-ascii?Q?qFMDoXxGWrToQUHGt/7HQ6KW9wBRbrYCPHudCjqrwWAKSB8qYGghoDt6cONR?=
 =?us-ascii?Q?pROTI/vwCXCkl0lqaxi0NWjG7SLGeju4fUKN5SG94DViRI9GJaupT3n4XJVH?=
 =?us-ascii?Q?N9Cu+W/1cL3idVkboUcShqnIdjY34AOUNNdUT8qdWoepw65UUhuSc41A1c48?=
 =?us-ascii?Q?vY82iw3cVuDpLGxFcDBOPBkVAMCNWLsYhHrVIqpiCTZotzFyxcpqS8ULAwEm?=
 =?us-ascii?Q?C1mRm2QDxqBs8BkMzVk8R/K0YavnCL/VvCY0VlC2YAn1Ew5ghIWJsJ2ayE2Q?=
 =?us-ascii?Q?ZFY69I4Tmj6U2DJMrjxVTG24/6xKhATMNoR/wtcdXzT6ewxDd6ufokDwTuQi?=
 =?us-ascii?Q?OsVUCx7FsYkE1CueAK1mx5v8ylhvawAgWadSaivKTmE9/TFBRSSS3eXeh10k?=
 =?us-ascii?Q?zlb4hNIDfwqtf74Pbh6Rnrz7hk7jLS9x6S1Vf5uT0XFRMgQ77yRE7qWclfsE?=
 =?us-ascii?Q?yp3b1GulNCb3R+BLB8t0OvpZbROku1Nk4ND64MxgJDLjQp8pRh12bWV6w8M/?=
 =?us-ascii?Q?d3hm6lBd/AKP+ZmVUbmV8yKA9FB1+du/F97iriEwJbeLoZAFutBHlnXdeiMX?=
 =?us-ascii?Q?+yBR6eYNP6gCKF+ITrTqH6OXlO8ZU0Ra?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:25:38.3878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d025aeb-0a20-4211-25fc-08dcbdd5642c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5793

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


