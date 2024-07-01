Return-Path: <linux-kernel+bounces-236973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B909291E93A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6571F228CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E30172BCF;
	Mon,  1 Jul 2024 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xmjirti7"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B34171083;
	Mon,  1 Jul 2024 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864492; cv=fail; b=HiRKe96bscfatpmx22ScSSpdV4GWMf6qwx80nlCpBDD6yUhusBcuUcCVzhcFX0a7/R2OlcdtZ6SZ51cE7pbFybpOxhKoUBC9jeAkhRG9HU3QEMmyUa2VGUpTmiClxOA3Umg/dwoNluNBogAlR2gxPb77dFiLV+nSGQJG/U+9OKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864492; c=relaxed/simple;
	bh=0T8ze9mdC/CKn2/1t7dNIKHNIR/DmoYaMfU7M2W7dK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T29WS+OzoJZCDdjduRqQUGKPYewQShk9AVBhvBnaTy7QWeOzO/JlPyANZ1Dtxw/1pMfwd4b90cY5j1bXI7aIq/PfrSL+c8w5anS11xijdQgqIAPwKX9gotD7JPrZsuceTaMv+LcRWKTIF8cTSpgLaXuDUhaHvJiGAPVrvMfwsPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xmjirti7; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUoYBSkijUvBCNCOzueoKGHXtJ1Bv/govCkh3+HK+5UG0JZHDjFiu9vjqdEMaYteOYikkrLCzVwg3BRj5QC7avfV9VSb8CA73FeHg7BqWJzaaG3378AZ6/AqI968slUZOshdWlk7VAq6s1pwM2+1oHgPfcCH7fAMjk4xc/HKnzqdzXbCgEpRmtnaKT/azxJb4C9gaW4VXauOfhQEyUYfG4AWMDidixRYhYfpjLA8deKwmrj697sxFgJgYx9cAe7Ly/SULguVg9fDOyqlZDgJ0aizb9lVkKfKhPhNetkj1BXuHZGj9D94L0mYyTlaEYhz4uRmxo03/qxzKT8EFYiS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htGdMN3WvG8WjOfmDTtqv5oNASYVI02yim3ZGU97JWM=;
 b=IkTS+i2Ml2Ous+1tU+Tfp27EuQ2U8mpSVAxyB65rwPbRFIQyqnfDkaaRUq3ITdiq6V2xTfITlJpWF+QN6/plZU33WiTdSeQ5gfiiWaEQvAaj6WASZvAfvvMSP21TovcHLZoj113SbcKsQ9/WWYj3M0x4OeyIgL+Bzg0x6puM+2j0KiGDs0VIAitnfi8wnL3kam6g3RszI8zfnHdkt+RZ5EwBj10+hVvxUshM02lYwJw4FsBM5xi1Fz6TcC86gfhEj7DDcPQ4BLWHaQhd901hGf+PfN04q/xDqyRSQKg7XRfQXiMOyP+I7LMVXmBGVkV5QAfCab4wlFZRnsPk1vI7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htGdMN3WvG8WjOfmDTtqv5oNASYVI02yim3ZGU97JWM=;
 b=Xmjirti768o/hPP1q0k5bzMgsR+JtMb6jrwZ7YrblzAU3NkkKQBNV9QjmCSFYwc3fm5nr+DeuUZKhuzQMKIzUMglK9gfwY1AhgVu732yQje2vZxj+J+iCAk10TWRmWKkWnPt+nxDWPHEGXjdYjyawrd5+TKJfGxxCSr5PI61Q3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 20:08:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:08:09 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 7/7] arm64: dts: imx95-19x19-evk: add pwm fan control
Date: Mon,  1 Jul 2024 16:07:28 -0400
Message-Id: <20240701200728.1887467-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701200728.1887467-1-Frank.Li@nxp.com>
References: <20240701200728.1887467-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: 723d694a-eb33-4e8f-6d38-08dc9a098755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?00OsRe3eL/kWVt/72NtHzLYkSi5sXs06t7McpP4/QYCqw5L/+k8nUbnCgrb+?=
 =?us-ascii?Q?4bpzyJ6Mj/DLCbSv3orL7H4a0oLiVH05saDvgl3ZJsrRLhj1mk6gsr6pRXrP?=
 =?us-ascii?Q?PhYM6XXR0jmSQ+KEB975mJIvplumS61JW9ZKtdEuHizv57Fp+iw5Fkk+5+Yx?=
 =?us-ascii?Q?Y/TfkM7M5xNOmLEnqg1jteAAuK38NATHjBisDVDMLrrkcavJ9ewfEtEd/csA?=
 =?us-ascii?Q?BhZPrmQsEuiCa4tX8DXl+zvVR1gE1+Ha53Z/uoeTfIb7X8am86qtjryCI5lK?=
 =?us-ascii?Q?0MzjRx7FJRbpnXTxrr0hewtc+tgRhe9nzLOITAjvQXtaT2hMxnwxYyNyimGM?=
 =?us-ascii?Q?VHUh3YFIv7IIQUYrUhgFUTw21x+fVX6SM9FEeA9PUcMK5mZa5FFTtafy3323?=
 =?us-ascii?Q?8TlcCZwNtTZXtoy0EIihKWTHWbbtZlnGPFo8RinDmj8K74uPzZ8wqTSnRj/Y?=
 =?us-ascii?Q?th/n5n3MP1GpRrzVrpzikVnnCzC4mS9dkNgMnrDMwbbSN8Igx58go4Bqgi3K?=
 =?us-ascii?Q?jiyNE6jEo9csbVeGUA6TPzXRh8V6+EUonPHCRsmprn82xxkA6Za5vFCiKBQo?=
 =?us-ascii?Q?Y1Fmy/AmHxze+G5WeQ+SNEpOYgoDCc7V3wKoFuLX7trWo9YnLlqGtEcBSXMs?=
 =?us-ascii?Q?VCUOZxJZOZi1NCfMx2DFcoNgOm5HT7uAD+97yf0+OKvPP7w00Ap6GHpI5zMM?=
 =?us-ascii?Q?5WWPc1SDvAUQ5DQPfpSYqgO09jg8mEOpRvgQKNxd62MGlz633KfJ3kCA+syG?=
 =?us-ascii?Q?BFxlGXYNzTkoulwdxuIGd8ayzsZY21wuJKB3Oc+v6xaD9luEHrz+tbPNU/8L?=
 =?us-ascii?Q?gieEvOkN2mN0NmQ3DCgPcPX5UG+L2njQj7O6rb1kjjEmpvbI76LGIdxMKgNC?=
 =?us-ascii?Q?80EZRNptFWTiHlTHOL4WGzjQFtsWy4r8ZyYqyHNsZ+4zUrpGXjyvudkqDiqX?=
 =?us-ascii?Q?S17i9frk6IxtQbtROWyAgvffdTs1sXN1kNFlMcI2Pw1eRYnNkEYViOrHj6nJ?=
 =?us-ascii?Q?lQeN6ESc/TnceP9ElQHSeIP9I0gxbtXazEmaEf1pPL6HpV09RbTaNukNMpR+?=
 =?us-ascii?Q?MX7fDQESFCCWfJr1ze4VxE7HVHI78kNYwe4aerNH9qMhHU5CfSSmm0t6fGPS?=
 =?us-ascii?Q?2rii1Zs1ld86QcsOUR1Hgi8fmnzJBuouwdhfkRUHCo8R/XeQl2hujQwqcWtT?=
 =?us-ascii?Q?7b0+SOLtKwvoabwJbQqZYd2WJN/sO2qa5D/0Ql1obcf7m621LkkgJC9Ij+aV?=
 =?us-ascii?Q?C5Is8Tc5RovcP8LJG+GluthVy9IKqXznKHgIPG9VxvIn2OHZ2D2TgkXrrHlu?=
 =?us-ascii?Q?wrzJpOSf90QK4qFHQs9023wdU9j4K+eYbzgDfcRiCkpSCDTXzB19ZTxawKGA?=
 =?us-ascii?Q?7rw261Uo+ci+hp+z0pmjlNVDEA9r6q8OIVhQGU2AGuitMEYiK0XcO7N3H++P?=
 =?us-ascii?Q?s4WsiG1F4mY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rEGeIyRbZ6ce0SRDAWgcBSHfWTkNZ1hfzK+NwurMdIczdEoixvlSnj39I0hI?=
 =?us-ascii?Q?2sPGPDz2Zp10KP9c65tipa6uj0ep/jZ3+tfzEtUqisreLYy0ROHqxOhdgZgw?=
 =?us-ascii?Q?6QfJW4NS/nAbfQiJtxCCwUdymOfl2rykYHwMpnZwPaFNq345Wy8V4yBOm9zF?=
 =?us-ascii?Q?nom1Y0iarTyMuV8JPH+IoHI/NU5YK0P7JEPoCLICcPONObrPuN92X4zQHlT3?=
 =?us-ascii?Q?vqjeo/ULCvMN/b6KJr1J0qaWTFUWZTQ1LnfNLLOBgo8pjCihh4M4kY/TpZFQ?=
 =?us-ascii?Q?ARtIL/tirXj7dXaE8O143XmN3GEArNKlcjEmNon++zkAg/03UcHCy9QFG30N?=
 =?us-ascii?Q?k90JQir3fXmLEA0+J1F5spkyeLfF59gZioQ2GSRx3PVM7J4EmiCSV/koAEUt?=
 =?us-ascii?Q?qS702RefU3dno5a+n2ju1uQG2u5vVvuuOCtAdPXMK4GFW+gxM8JzIWAoGKbR?=
 =?us-ascii?Q?LBU8MqJZMLL+3apSjb2fTUxX07uRmmJf5eZX4DW1xh0JCMG9ODj8aLv7/q8y?=
 =?us-ascii?Q?320H6zCOaLUQU/RfP1uRuudiYlYqGJXq0jWiYQnNistJ4t4ERt6WTeQO9Gaq?=
 =?us-ascii?Q?7pD0ALqZ7uzEwB/1r2rFcUDkAyiPZkWsNbj9STJHehwv1XgB7+WWA4tjiF8p?=
 =?us-ascii?Q?KlBMGbm0Iorfixgb87fO+NK2UBZb+EPwewZFWcLsnDU2jiCMzN+OBLOvJFiK?=
 =?us-ascii?Q?e82rfashe665JXhU5EE/SKFjufiL15mFyanNGjrY6awdA1le3l1UH2tcGJ5K?=
 =?us-ascii?Q?LdxlKb+WbtM+8y1LGDSFWL/IO9M4xZQPcEkIxG5gqCxMxJlC5tVptDBw21V4?=
 =?us-ascii?Q?UpwtSMLA2d48IbATJxpQEHEKwRrPa1Rqj8Mao88tM61s5iftWASJA/6/nd6w?=
 =?us-ascii?Q?DJElwhiNbLlsR6GspCyI0aS6vl+3dsxUwqXD3xC9HbiAxUepc4j3xjztgzpH?=
 =?us-ascii?Q?sN5Le+4o4B9wlpqbMG0AeysZg++k53UpLhKGmoZn679/g0sSHptibLtRBgd6?=
 =?us-ascii?Q?oCy8Uf7Uj3nRfCcgEDhy3Zyz7qE6kVBNA83zW4dkz80fUJodJDvcogHr0M84?=
 =?us-ascii?Q?LTdcIUlD9NOQIkFNqUkTCSr6plT4SKi50RHKXo+G2NcJRCPT5B2iPcHfqQVe?=
 =?us-ascii?Q?JOrqijAscQiRW9+FHsIEjqFElE0D6GDGsncC8kfOs+71CNjWBjSPSklO0wKb?=
 =?us-ascii?Q?lkoXN/K6VEhtixkRy2775CErzpjhNrqRq1uY+2ebu+VS5jRGH2WEc+OSGJOB?=
 =?us-ascii?Q?2F80ts9HBho3TduRM85ArE8twwekOdXH8w1EV5t84zuZqY8u/SIH0AjgZfJS?=
 =?us-ascii?Q?mzJRTgOJguTL3FHlCaC3eGv0NvjtTea8eFDV7eqqrtOqY008ZwZduxZJdck9?=
 =?us-ascii?Q?UHYTlDdYYpI7qq0gOxCLPP7sUDv5/ge5LtgdwXusV6Hita83w2PPSmibcuxG?=
 =?us-ascii?Q?SNNDIMK9uCdFeBUBvl4jmW7EdbCRHGEInCKb6cNDubEtg8kZNS6vzx9n6lyo?=
 =?us-ascii?Q?qCwuQvjFh9TKU5YdC6W43F45xNB3Thrga6F9n7BlAHw1KJVrpca1RC5KN26J?=
 =?us-ascii?Q?9grGe/zPH7vjv+/AtoRbVDR2UsprZ5uRTBi1HLY3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723d694a-eb33-4e8f-6d38-08dc9a098755
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:08:09.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr3SudhfWKdHkWtxLKkxDnpr+2zwHhbhhIzeurkLZ3X7ltnoXd6lHPERLSbe7Qrhxydi5cvRDHVdHsg87fuSyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

Add pwm fan and overwrite default thermal nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Add tpm6 node
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 2b820a961c173..37a1d4ca1b207 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/pwm/pwm.h>
 #include "imx95.dtsi"
 
 / {
@@ -31,6 +32,13 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
 
+	fan0: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		pwms = <&tpm6 2 4000000 PWM_POLARITY_INVERTED>;
+		cooling-levels = <64 128 192 255>;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -463,6 +471,12 @@ IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0			0x31e
 		>;
 	};
 
+	pinctrl_tpm6: tpm6grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO19__TPM6_CH2			0x51e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX      0x31e
@@ -566,3 +580,50 @@ IMX95_PAD_SD2_VSELECT__USDHC2_VSELECT		0x51e
 		>;
 	};
 };
+
+&thermal_zones {
+	a55-thermal {
+		trips {
+			atrip2: trip2 {
+				temperature = <55000>;
+				hysteresis = <2000>;
+				type = "active";
+			};
+
+			atrip3: trip3 {
+				temperature = <65000>;
+				hysteresis = <2000>;
+				type = "active";
+			};
+
+			atrip4: trip4 {
+				temperature = <75000>;
+				hysteresis = <2000>;
+				type = "active";
+			};
+		};
+
+		cooling-maps {
+			map1 {
+				trip = <&atrip2>;
+				cooling-device = <&fan0 0 1>;
+			};
+
+			map2 {
+				trip = <&atrip3>;
+				cooling-device = <&fan0 1 2>;
+			};
+
+			map3 {
+				trip = <&atrip4>;
+				cooling-device = <&fan0 2 3>;
+			};
+		};
+	};
+};
+
+&tpm6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm6>;
+	status = "okay";
+};
-- 
2.34.1


