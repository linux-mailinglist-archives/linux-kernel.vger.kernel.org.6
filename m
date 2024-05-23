Return-Path: <linux-kernel+bounces-187249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E398CCF07
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE52286B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647A14EC53;
	Thu, 23 May 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="NCtwCcQ9"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2062.outbound.protection.outlook.com [40.107.117.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482614E2E8;
	Thu, 23 May 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455956; cv=fail; b=EG+fKRecK83SNNbPBJc09Ua8Vr+Qqo/3uAqs3ifv3AOSujaHaqHQ3wpVqJXv65+J8De22/VKx5iNPY+OaCHuMBkunJVbZNq2OKmKy6RZSFF7rt4SQoWo9/T3uu83i5lq1uiJh8+xbnGBbhIXOsONt1h2Yff3SC85ji4cSdkSAOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455956; c=relaxed/simple;
	bh=FmeTRl7VvcjfBLGcGy+uhaZd2SETeUmaTr3cZihxq58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLiZ4xJM49HZ5gu0XF0tvrnuvFcoKJ8qU1N0ozoOtjGDto7fEqpYcINsAijLO9JU4LWYQgx8tTtDSXTjp4gs+f2eGt8FPC+meSWD0z1CjQhHndZo7FwA9/PYlEyTq3ElxTfQCtyd8PZQj5oWs7gjAI4OKcvTTOKvM/9IEJy6X0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=NCtwCcQ9; arc=fail smtp.client-ip=40.107.117.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMISOmpysdVGH1uU0hSJa0mDelhmSteTUBb3iXjEnEZuD9ShlSZDucBLnvGlhzCcY4UzWGdA23PHr+q2CrTrM9J+l5JFcd/DnwlqC9Ib5Yj8Df2CN/LdFhpeqjCxNKJTAkkHNG6fG+a/Q/Exth4PbqM6FNx9AzfUhFP1bONC7F1eu20VfPi44F+rG6tMtP6Yo2JgXH1/B5uy/JfmNtpuwMYHk6wDlMy5/VUNRSDuERBU2d/LY3I1IbbnOGnb60pjfvatV8ps1IC+W6UmG9LlNu2zzAnNRhF0EvRoeomswwli83LDDRi9PDSI/UxqkJgS5F3EttbfE58ZC1gyhBP/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j10ZjYa9m8Zaq+5l8uhw5k3ZR3hJFjHMdwiXMttLE3U=;
 b=Fz9XkIaonyumsUsk1QX9yqnGXYSV//tf+PAxyvNrfFUsaTwh1U8rg7ZA6Ej5IEb35XSFgAChchPW/PBP0g3ZmZ+kZoc4RiVUAiFO83sOG8e8g/1zahBS604hfNRmT8FtXX8KJ38VHVljm5BbEoRi54lkDAhMJIzvH2+1RIuDmGVEUeWt2tKvKmepnUhVonBSj5wiyRXJfQzUQLX9ACUcQ1gQD4fUymAH6htJeP01JfErTNU0XatCPKWuRwlO9vszh9B0ovCmAarxPozPrEePucEzrgt5caYU9feo5KZ2HMMn4e/JZc0roFLjwCygLZXBnjh5kNhcFuKUAt8AnX5SLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j10ZjYa9m8Zaq+5l8uhw5k3ZR3hJFjHMdwiXMttLE3U=;
 b=NCtwCcQ9oXMd5m7VMljDwjwAwOCqLO37ZIlX6/TnUiWvd6jjOKXu7VZqiNpT8sTFKAc18mYkxjeoQuk3Wf07kn0aDnZnS59mT54ejB7iyk4N+Dc04W3Aw3mRb/qFECCLjVc6auAfPD0CmkInEwUfWZUThMleTFnW8EsERrfE+w/zaNQyosx06GDxmilQyaopFCWc5UAsvQk73Zqm3b+c7/kFfKHIe7lCxdypEKwT5UZgVHtUfQg0lMETZvkIKLxnMJvIWM6DdfXk5h2pc/FxNz/OY6jNMFNT0HFD+cTbkhOd6/azqpRqXbNEtXygQTvR3iuv4/+pou1pK+JnaMdu/Q==
Received: from PS2PR03CA0007.apcprd03.prod.outlook.com (2603:1096:300:5b::19)
 by SEZPR04MB7530.apcprd04.prod.outlook.com (2603:1096:101:1f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 09:19:08 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::1e) by PS2PR03CA0007.outlook.office365.com
 (2603:1096:300:5b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Thu, 23 May 2024 09:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:19:07
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
Subject: [PATCH v8 16/23] ARM: dts: aspeed: yosemite4: Initialize bmc gpio state
Date: Thu, 23 May 2024 17:18:03 +0800
Message-Id: <20240523091812.2032933-17-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEZPR04MB7530:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 493350c9-ba06-4485-744a-08dc7b09664e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n0L7SU3vc2gmVlRYcMBEdgB6X9uuEe7OQ0GXpqRQxPvVUO1l782LMgpk3LDT?=
 =?us-ascii?Q?DRXfPdEsZN5W2534VgSlaiz/EWE1sXKBcj0GMuyRSpziwkSpzsDPJzbWcoBN?=
 =?us-ascii?Q?ruQJw+vpEotxUAdw4PQOEri0aoq0vVNd1zxXFVJeEwQnpHsWhpmHBrfTVHlO?=
 =?us-ascii?Q?49uTZIzIOfzpUCvcZZQAkoPQa7zq+7eJl1jSeues+OUa1E1DyaBhPC9y67i7?=
 =?us-ascii?Q?MGbpOFN+g/IS+fn19q282rHh2uMrHA8qACdEVlaEZjFcII9dSjKeOu9yJSQ9?=
 =?us-ascii?Q?4lJe4lKVOEk+ZFW+6Kamn5vvfceEbqP2+XMWCxcxjp0cDGxuIRPf16rcS0WP?=
 =?us-ascii?Q?Lec2I6yKkzsWuUT5WQT1OfJ9zB07Bm74s9Tk0VCaKeSOXnt1YjTsXxoNwFGX?=
 =?us-ascii?Q?Sjmcl8KCOfw+cu3KjS7maD0wWPB03B1mXB1SR+WkaL5+SgpKZSVcbSifgxOT?=
 =?us-ascii?Q?oGFs6L0WadOIaDHofSCdCImPgom4MOF6yayVm1YLui168rypsg6PKu7KBqWf?=
 =?us-ascii?Q?H3L3XD3XQktPwMLCzUy0W1s1nXVKZeT0UjuqUfGledL4D3x4pWBMUs9ALxBG?=
 =?us-ascii?Q?Pnj/JYy7Ci5vK51rThQZ/hUxwKlJQ4rZkFBuK56t5Ovp22XkfEVTkpWCCOzM?=
 =?us-ascii?Q?IzpudWRVgV30KUxebgXM6W/DrnBA5p2QWhvab3pgsBY8rDJAQzf2Dmee1mMS?=
 =?us-ascii?Q?AlURoFhzBbzop6RbjaV5RIhKCSXeh2+faq6vj87evI4t0Fgz5Roegpc3SvaT?=
 =?us-ascii?Q?RI314JdjqHo/doWWnskSZD/6kvavNEuVouno6VH/bT3Q/wSQnpSZsq2v+kOl?=
 =?us-ascii?Q?lS7vGlJiukraqSqJXyz88VfUTXgbSLXRbpo6xiXApr1MHvjgkb6oUKVFzwGU?=
 =?us-ascii?Q?WZyEni8JWrex44vAQtdS8yKkhx/CLZpKozg0UbUohSU7U54D4oHSimgThZy/?=
 =?us-ascii?Q?rN94r+Yh/gc3nI8+HXoSZAiv1lx+S39Y/RqlGy4g+QRdJNr5ufct64i6pNzh?=
 =?us-ascii?Q?NADz9sQZvkXjef3S1aNXAhbRbTmU55Ds0cfHu2QPgYcmenJI7cP6n2Buo59r?=
 =?us-ascii?Q?OUXa5HA79ZdNmhfraCE9QbVNN6qbrYkzGaijuPkwmvKxrSYqpKTRTjEXAqoC?=
 =?us-ascii?Q?LGeDc/qbnpoXm6WW+SUopczwfKFaGsqpSlFAt8+8+SIp7vqjE/EIujB5BAqC?=
 =?us-ascii?Q?0OJ3Q1CTszdnYlvk+HU7s2FeaizoHmvA9oG5MK+/LS2eOvuWt7yqNc/I0KK/?=
 =?us-ascii?Q?NnJ5QgSzTR7Ujuwq2RHIn1nLBJkdny7LfClAT6TnB96x3zBEx1tx+/KarBEy?=
 =?us-ascii?Q?EVXqqovo2XB7BPgKAR2rFetfaaNQahG5UytDGYVLWZoOBVPMshZTvwyA9dP9?=
 =?us-ascii?Q?5Mp7zzTphZySQ1P9CvfLDtfJY7dB?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:19:07.8920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493350c9-ba06-4485-744a-08dc7b09664e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7530

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


