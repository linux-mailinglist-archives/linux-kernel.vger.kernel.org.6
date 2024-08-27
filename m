Return-Path: <linux-kernel+bounces-302708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6D1960230
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8331F224EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880415350B;
	Tue, 27 Aug 2024 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bHosxXqC"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7521465AC;
	Tue, 27 Aug 2024 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741266; cv=fail; b=H+xEq3Cumdc0M78ONI95/jL0M6jD0ZO3C9ufR05JdabQxlG7mSOcCgLaEa9fJu9ql/WzGS5fYDWHKp13UBNyIERjZtSmnKSKpVwk/c3VDWZb/dg5ljP8ulqwHOtbiLHRflt+oeIM4puYGaOSIYhiNcbbfCFQcbLePijg9c0nCuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741266; c=relaxed/simple;
	bh=oHkBVVw8AdPIvKezniim+NsGmwQAcCMYFLIl45cfX2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JNjjR5W72IaROhKQJvjQYl6RTggC9lKWF3hNP1zHxRtoN++QCec4zis9uxNeV0lIpG+pYMxueq51RHHOpU1GsbwDW/QhoIj5HrLNBcXfoneW0MvoJIX2k/FF7UMvARjhtNfOE4cRE/tXVYVavH88RbyC71Dp7LaxlFPzek0EkVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bHosxXqC; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQLz+OobW31U2XkXBTqqGaj0WRasKfSbmY1qZFOk4iO2n6sIDAEgx3n4yqLrG1h+LE8dHYxfWVbJyjwyEf/UCi1bwGK23HO9/4Ri6PMiyFxK8Whf8D+7DmQbvPWY7Rbug6QVZ7to8bWRsnWELGWBgVIvag8megH9+vylWrmFbKfQ4pNO8qURQP3Fhl5ST3pBUlhhtL0wp3sm7ckt6tbMvV4P16RoE5aC5anzu9MHuwWjdTgHekk7KL66UvWqdO9rVKU1p2ArjFMAP8wKGNdhwrsRE4Qz1tIkEc6yHphNhhYWbk5DDlFNCmcZwn8UWXiO9dWQnQXlnzsvLwuZLtqewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZghnHVVIcM07nYfbg6XQ4rWSVA4Dihrv/ejgOqUWm3M=;
 b=EfLz4cwb273v+hAfhTLnhYnvJmq+n6b6SWAmZ7cp20TI/+RWG4n5kW9KN0Kv+/2nik+qS3TuGMZwp6kAJRkWchWJDBlqPyZ/ez5BB7AQR2a7WnY3FebfeYy7qOOo8mbnjOK/iX8xmKjHM9FVpy9J2ePFVu6yyql5Yo/HPmJNvt4rYO1mTH99N8u8GkRD3XoyLFThrKLoY2Bu7OsQ9xO7EA/TB4zKcwubtc8jYY+fnej/RHLDEGFSHzADGv/6hcUAL9AcTS2nUEAo8cGjEIy6MWK64A65I/q0DOO0vwhi7T2YjzuYPciGnFBqzNjmbk/TOkyQEjjLJiuElGV/wtmTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZghnHVVIcM07nYfbg6XQ4rWSVA4Dihrv/ejgOqUWm3M=;
 b=bHosxXqCGMEX3meue50N2pr83DNiViK16yrA2ruu0uAU6J+E5PMiyeCcuUvwQ+W93bcE1a7fpV25pLP/Ey6S1orvrRF5CxTMaU8wKrmMVj22P+aIHsA1F3ht4yCEAQbnY1EVpCsv4PR8gqxbAgOhecAKymhyYDdvzwcSP2yfjWzDbsiCpb8rWTEbgMRccUFOP1tzIpsK2Xqq4bxeTb6SYxivzV20OPUl/PtwgAaU4M7m6cPnVKpSkZJB2B4JUSEa/6g8ixk/htRQmWEFX2tTYcHtEcmdI7YJH0KqhKjlvQINkFN8Yfk0w2lrLxcrPbQbnKgIaJQRM9WJyqtCGw4bwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:47:43 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:47:43 +0000
From: Liu Ying <victor.liu@nxp.com>
To: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com
Subject: [PATCH 1/2] arm64: dts: imx93-11x11-evk: Add PWM backlight for "LVDS" connector
Date: Tue, 27 Aug 2024 14:47:16 +0800
Message-Id: <20240827064717.2383292-2-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827064717.2383292-1-victor.liu@nxp.com>
References: <20240827064717.2383292-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f42ad95-cd31-4def-5a59-08dcc66426d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WBnCnKwFBrsXnG0ssYDvuRy7dilRkXjBGf0yqwIsjEjwPVVNO40zcneGApNv?=
 =?us-ascii?Q?1KXf3pTaK+zzm3e2VmnXd0ddJuM/We09JDLpeGO/xrGirsJx+adqARsPLSMH?=
 =?us-ascii?Q?UkisK56CdJPbfK62R8FXWO3HTRvXUdO5RbUYS/7HurEFgE8Ywd3gGsBSWij6?=
 =?us-ascii?Q?CxjZveC5vN6ZpcpH1O5gzN1UNQqUULXAFfIgVm7V5X3hX1Dvss6x/DjVJ3LD?=
 =?us-ascii?Q?AflXiGlKp107CCA1d1/2ZjHJqWI2a4lxCe5Iu/gfo8UHJI5hMVJah0s9RwSY?=
 =?us-ascii?Q?C8bfMWk7JGdA/e6+I+4pmLwHoxmxWBjwbX6d+A9kwetIy+wUgh8TVdAgb0Jr?=
 =?us-ascii?Q?NnQf9s98jVTATnUbYzygdzFzztuSSbNIkLcsdroa3HlnV7Gipdg14Gspy+yJ?=
 =?us-ascii?Q?kfA0n5CvN9iCONXmb2LqO4pV65H7AcPgSCI883sT1ukxIWMbRKnnkm9eTgTq?=
 =?us-ascii?Q?95SCmu5TczCtydS3JOF9Jh9xTMnez1+VwN5sZbQnRIcJCBPF77IAR0Vx0jW8?=
 =?us-ascii?Q?rl7TITH6pBqXugwd0uJiC8cauSm68Ay0dkzCs8SRUowTk6T+wb93G8FD58lq?=
 =?us-ascii?Q?d6xUoQ8DT2kN496GIiZ/1vQpfZDTM2tV/zs7neBy87s5/Mb36NBoRq7ksJ8U?=
 =?us-ascii?Q?GPqj4xRx4GGbpbMV1knUlJld/CHB17753h/cgC1EJ0Ocr5R6MYN/dyKj/Hp0?=
 =?us-ascii?Q?Pz5sbWGOGWR+1+EPdANuThybdsGWBJpSlDo2cPgTq9qrIN4qQASDTjOzarf/?=
 =?us-ascii?Q?N96jNxK2EQPUddybgzWfAYPv/Cu8BxuStM4vNbspSTtXbLaA4gRElPeckR+s?=
 =?us-ascii?Q?vQw497jdE0iH0zFABCtNfJW6CS13RhilKji0MBrbyvjecdPaxKTsDwrAfCVY?=
 =?us-ascii?Q?PbPWybYAhomzjZGJNFuJ5iyxmf+HnFUIj6fMYotqeniP1fVyK+2XBfkMreoK?=
 =?us-ascii?Q?q4a0h0TyQF0WqiUuQumf8FqdxNUTyS9Xv2CUKbIxcl50TmIi431Pev8d8Fr9?=
 =?us-ascii?Q?ZdJiqkrqTn4uEJ2SyTuEEUxvcob7OTMRlKBN/IcB/DlT6WL6ld7KrvEGZwEK?=
 =?us-ascii?Q?NumuYbQcwipqToRYGDToFq1V3QjLySy9UDI+/a4E1SfeFt1x4sVXgbiInQDk?=
 =?us-ascii?Q?wTYkpjQyLE2t+Q9FeafXeTVq21CN7SUavUJqRG7AmppY+BqMtcnp0JKND1VG?=
 =?us-ascii?Q?eJOzBQRhMDuZ6YMxGgiodlx/S1Dq4JSkqVhhjD8eJniBbBa2fYCCDy7G/IBT?=
 =?us-ascii?Q?F1lOJ+c0qBp19L0fnkGwB9tgqFf/I8sxdEwNdYzrPcBw1yMTUIj8mjuYbwtl?=
 =?us-ascii?Q?ZQbE7kaCmXMdtfl+B5RB/Lsfq1hU0yg17PANLDIjHSU83rWfV5nNo3IMbXKR?=
 =?us-ascii?Q?YX6NMe9SAY2pvgXLTcwYZcwyTQkwhVZqRpWv0pHLnCVQtPe8yA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ICZkl2LwZayCz+LTevcTXTh5p/iK7zw1RU5uY7KNXjC9lIYF4Bh/qUUH8JrA?=
 =?us-ascii?Q?JHH2X2I6Ob049L+GwBVhdj0vsv7FSrwxOtmxJEsJUNzug4owuL5GU51QIOhr?=
 =?us-ascii?Q?0izyLflyHQRT6UufcYLGacV3p1H/sOr+Y8e6IH706XmfOeE7qN84rQL8ZH3P?=
 =?us-ascii?Q?wz+yghwXDLjRjxpmoJ+OnBLCFbvRGS9e55XdnfFR2pqG9O3LYcD05Y3jnEZi?=
 =?us-ascii?Q?jsM2O0WL2NjJ+T5Tk95tv+IfH+lD9uM3a1JrUI/pECHAX5Rc4fu6IDxQJXAC?=
 =?us-ascii?Q?QVTgv1/6OmTmbLXO+Uy3st+f4zVpgKQeQNHMiEjunfCzfTGg/NhnpzjAbTdk?=
 =?us-ascii?Q?7yqtr+dOwrNJonmnAXjjF6rw97MV9RQTwMPXW28ZZBBruFjq5crqM3P5Ekf5?=
 =?us-ascii?Q?jsXGc1oHc7GlpYh7V1OvGrj6myaSl8CvaHmzVnufkxhgd6IHgRQg7pGSDZTF?=
 =?us-ascii?Q?zamWnF9TwzEtE5j91RQD+FdNQmkIPCtfpu0gwVYPhPiDqJoqm5Pj10orVAO1?=
 =?us-ascii?Q?BkVMMLN7AwhuSJUTAULzLqi2HUE/LlrbfGzRl2IS2sdJBVRG8NhAaI2/B84E?=
 =?us-ascii?Q?TpJsXmCaL7pyi9jDNzep1BJzo/YOhmEvYfFZggksGIspL74+g/gJJ/gLRpNn?=
 =?us-ascii?Q?jmLgrIeq6yhTgXs25atUyphieTkDQfryP0VRHfTEeXqBe5UrBYO4glKxaGeL?=
 =?us-ascii?Q?nVhmNLHV4KaOHmHdskbpwX3xFgZ7f2axu37JaTQs8X/FQoStExLdkuv3d2Rq?=
 =?us-ascii?Q?EIBHg79W/LEU/lkLHwdhzsdT4ZFZaz+arObA0rzth/GVuVKjSzpFPG8eWrOx?=
 =?us-ascii?Q?16Fp2fH5xfU6QtWKsamJAtECjHHNm3kpChdYbK2ImRK1RIg5kC+27Mqzhcv3?=
 =?us-ascii?Q?L0GIbYjspMiW/JgktnnIwWNOcxWbX7LKbixY92XeCQ8WdgOO1QgRLBsgVWWc?=
 =?us-ascii?Q?bxJNKYWdjKQZWcbGc1aLx1fEC5rwC33USwH8jJAMtUtD3LfvPFYnVjpVndm7?=
 =?us-ascii?Q?WN7mffSXDrpCGZzX5xmOrfoUmPWL0uqFhzghARfkR5jeWlbuJx8h+S5dqHk+?=
 =?us-ascii?Q?jCaVvYtTCIJ9Nt/Qzbe9p5id5teXmYHav7BqFm2kkxOXj1pnzpdG8T7B3WyN?=
 =?us-ascii?Q?ZO1dezUUll8f2i8a68scIP2qyfAdkkF4EuzJ7r8/1ebAhMqj3KrrAiuysM6W?=
 =?us-ascii?Q?u8S31RtuS+NKQ7wT5IZJTW7soUm6InTa5pLUjDd+dKeGesAbO99nE7b+izFD?=
 =?us-ascii?Q?LJB7LD2rb9PgAZ9XJ5PzYpGIRI54mQdP08qNo6mq88EGTPwRr3/CFPJL7iyq?=
 =?us-ascii?Q?tiPB3YZP+CIanTVKSJUM6fVQC7U0ck9xO7E42Fl1+JQuaDvsjxe5KyUJUV8+?=
 =?us-ascii?Q?iVdOoW/ZcxpmNHPvHgyguk3jihrt7FPz/KxrAJiiDM/BdJUpO0u05Sb3JVOX?=
 =?us-ascii?Q?xHfZy6MBAs0vpENuERPM2dNDgGS3D0Lbivx/fK3oJPBx4e4BF1WQFfRdlYA2?=
 =?us-ascii?Q?JpeMt55lUiHJcwVIxEAMrJiN4RbVp0DKiwPHKkJ+7RaqbvDIKOaf9nuh+JXI?=
 =?us-ascii?Q?/lwj5DJRLXYHXMvNeBri0DIuTVj19yDStOoQu4NL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f42ad95-cd31-4def-5a59-08dcc66426d8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:47:43.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuPEeIuHvvCaS0J8OyfavAp1ifGNqo4uG0z0fdj6elq48wtizBYyi+CmOdyb840owT1zCj9eyY0Jan+DjWO2Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559

J702 on i.MX93 11x11 EVK base board is a 40-pin connector labelled
"LVDS".  This connector supports PWM backlight with default 12V power
supply and ADP5585 PWM controller.  Add support for the backlight.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
This patch is based on next-20240826.

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 60eb64761392..8d036b3962e9 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -62,6 +62,15 @@ vdevbuffer: vdevbuffer@a4020000 {
 
 	};
 
+	reg_vdd_12v: regulator-vdd-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_vref_1v8: regulator-adc-vref {
 		compatible = "regulator-fixed";
 		regulator-name = "vref_1v8";
@@ -81,6 +90,17 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 	};
 
+	backlight_lvds: backlight-lvds {
+		compatible = "pwm-backlight";
+		pwms = <&adp5585 0 100000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <100>;
+		power-supply = <&reg_vdd_12v>;
+		enable-gpios = <&adp5585 9 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
+
 	bt_sco_codec: bt-sco-codec {
 		compatible = "linux,bt-sco";
 		#sound-dai-cells = <1>;
@@ -302,6 +322,16 @@ ldo5: LDO5 {
 			};
 		};
 	};
+
+	adp5585: io-expander@34 {
+		compatible = "adi,adp5585-00", "adi,adp5585";
+		reg = <0x34>;
+		vdd-supply = <&buck4>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-reserved-ranges = <5 1>;
+		#pwm-cells = <3>;
+	};
 };
 
 &lpi2c3 {
-- 
2.34.1


