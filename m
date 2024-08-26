Return-Path: <linux-kernel+bounces-302193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CE495FAFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7B11C224ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E5C19A282;
	Mon, 26 Aug 2024 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="daTaeHTi"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764A77115;
	Mon, 26 Aug 2024 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705633; cv=fail; b=TcC3pEWN1usG+q3sUd80+BlZNOBTIwSG7AxV6XSa9Ks6XtP6WzX8qfRYJIl7seKDZJ8zifiYKoXfDgsFp4jhAQ+ascbknIHoSth4Z56cT99nyXV9DEu1xeAl6RnMZYSJuYbGE7SB304RnDyMULRbY28tuO1fVx88YEzi6jABrh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705633; c=relaxed/simple;
	bh=xVaDuwfScIxt1fhirTJa1+q1s+kiNEPNcS+PxRE+GVY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=awFjhGFI2vtiTAsIYD46UOxu5SXSf4MjwoU+WlNtfK41zwPJV0wXalR1p5JGHI6O+BKgJnha6YzFPMyfIaqtfIgu9CXAtRNBJhLg8hMZ8RsySJ0nYoWMEhtaVfxKemlEcnGWrMcUy9a2WskqAVLlpEGDpPfmJNFdFjkk2HZVW7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=daTaeHTi; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yp5OVBUiZxYNr5d7BOscOMBkfFOFYOf6LpHfvUKdJ47Hy2b9w9SAHZmrsoLSK6Sf7GBNQWrLRHD4sv84Vdm3/OCUN/hn67hhvsZjM1aGpgWzWcqNNCa4YKsS3sGdJH8QmdL4z0RWnwhCTrYUhXq8eBXNHLl35D0O9kIlQypk9Mb4PQvHMQrgINy8g0bCgR0yaREvDnJbNGfV1sr+CNmmv1lZ730d8873gjtk2qLQsYGGmQvk80gky2myuVXc5G0yCUCH9gT46JHe2/TQTrsixrniFVGaazYonCOQVL4jduqEXM0dtTWMUrp3u3uyGznhizR38cYF+3Zah+vA0+js/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnaBO6ZwW9cE/JLN6wwr2ZIFi8v1FJaCpS+2jlmSSU4=;
 b=klV2kseT+Pa9eV92f5C5E8Nx3/jCwnmg4eLgJp5OxoszNTQhQysYxpUFPjEdNHMDXI6p5Xr/3+2Ny7fpwHwpr4Vc4yxTwFI6xraCPJ5T//bJNkXt58KxThBbWNVC5O2NtPoEhMoYxZoAxzIgvGIu748McWb/71biYfWSi3YCnk4aeNQsu8D5XaKl7srkBzc0Wuql/wGRoZsKKK0Iwi0mNir+/ixQDxfueyq0mqO9UQtWc6KlTyd3rbZjUzCKSl/OTzGC1SQC9gYd4JzbPRWzzRclBel4q+6hFfkvMnZmMROtF9UqpJRd/i2ZHhTLw5serzrj5d8mBX6eDAhqubEcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnaBO6ZwW9cE/JLN6wwr2ZIFi8v1FJaCpS+2jlmSSU4=;
 b=daTaeHTidPm4dgNd3f9QP8oTSlHvtWdHu/7ncD+Qn5m6AGph2ZNbnBdd6ZNreSQQjoVivH2Vmka+9lCBvCkG+T92VtSXjniYOGitMHfCBIrWlUrdGq0Qa/JqX2k5p8tjssLybk9br71DEchoMPcy56DSk3mw63yrGOP0Jauz2f6iSC1iQKqkF6AY7jcwad7kx99AjSIoH9EzC3zJ2a46ky8Az7FWUe33dPcQckLnn3xOtdydpKLHJtXdZsQ9JKjpURh+1Z9yln25Pg8UCCw/eyyBLjm+KnGllAm1859mAnHATvPropTRhv00hzPX2u/R8JUe0cRUMNDblP4UccAdIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10681.eurprd04.prod.outlook.com (2603:10a6:150:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 20:53:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 20:53:48 +0000
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
Subject: [PATCH 1/3] arm64: dts: imx93-11x11-evk: add io-expander adi,adp5585-00
Date: Mon, 26 Aug 2024 16:53:32 -0400
Message-Id: <20240826205334.975272-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcaa792-0876-4124-394c-08dcc6112eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Sw3ii4dd0tqTNn5EroceFl4dhV+T3c//OwInZttyONVxTgZlYahMMZzxOSh?=
 =?us-ascii?Q?WQHHhyHToQmK/E3/vmAiFWg5WVk413tkXv/QTYGBgdP+q4Tzy85z9uS9OuaS?=
 =?us-ascii?Q?qGpbF0+yz0ovL+PhyE7LkXjaXzhIe/aepI27HUbH8Dz/eLJfIYb2k8XRdXKZ?=
 =?us-ascii?Q?2XS6/HWZfmDHXFuEINy1YMaWOxlGbY5sY6WlSILleGdYsR8okTCWvA6Nt+9M?=
 =?us-ascii?Q?ZdVcQrwrKaUAeAa7BiL4hD4yQ6rUKcYTBvJq0BoYP/eMyboNxDQyeqHpwcyj?=
 =?us-ascii?Q?Z2hSwR2CS7IlTlARGMa8C+m6cqVbFE1KI9nt2iWlETRrb+p2XPJR97tLyBWR?=
 =?us-ascii?Q?AyNgbmdsyLpzjgAZRhdw25vcFYcBguJBIT0Oh1oD2UjoBfVm9x105IoozzWk?=
 =?us-ascii?Q?y+I7duky1fFQeCqum8lq+6opD4j/py9FHS65fqeSNhvaN1yALOO+YjyLYhO6?=
 =?us-ascii?Q?90nyUidRsPIGjLJjnTJGjE4Zl5cICRax3FjGmHk7FKFK5UQ2TtwtX2xVheYP?=
 =?us-ascii?Q?/Svs41RNq2MZSIPIWYU8jTO8fcNsC/ZQn0SlIk77TzfqpetlqufGH93Ye0qH?=
 =?us-ascii?Q?1KHFOE2nlAIqztyvCDInnDJCkJ9Swv+gC86E1YDC3FqDCTUZg1cqhgoS5j7i?=
 =?us-ascii?Q?rQfQ+SfCKJKTi8PPnW68j2LJikLntS2Ui5/mfAstc2mRbEv8hX6pwnPdHGIZ?=
 =?us-ascii?Q?/yykz33+vbijJX5Ry72aMwa/OQqSVThgyjCGb0E86mbmAuUodpleUFZ61AWQ?=
 =?us-ascii?Q?l9YCgseZT8tkauF0DF9jTII0lbq39iIyMK7FPpTgDi64YBpFFJDM+JFPZZca?=
 =?us-ascii?Q?XeTDiezF6Z1tL6sQuXLqgLUWJ0m/p0/hfjEk9PAwJBExaKxXNlXBwkp43Ntn?=
 =?us-ascii?Q?JBuige5P4lDfK3TCE5ICgJNKUFOKcxhU6oopxyCUhw9+CFvQXSTQoJAYCA68?=
 =?us-ascii?Q?pX5bbsAZH4I3ijsA4HYMvUluDVm+VafYAHp+Ot01ZZbAKDdBFrd/1tK5e4Ec?=
 =?us-ascii?Q?UIE0iRb3mlmjl3v0CL3vuVDyMSp+xJAeCH874CxXNMPSGrIRjqqk9LVpm4MV?=
 =?us-ascii?Q?kuZHeUvyEtNyH71z9j04P57O9AuUY6l4pRzdTOBHLujfy9FpqiS1w3tb79BX?=
 =?us-ascii?Q?V3TE718CKHiKM6P17IO5dCAZmxXOFP61T/ke2YvU+AXAKXqwI/rsgcVfgwi+?=
 =?us-ascii?Q?WOKMFAEp94u3FmYLuNj1Ie82IICkhRgCPfhDdITKaCGmvxVPUnofHqbeWV5F?=
 =?us-ascii?Q?ulQwRx9qwSA8iGpr9km9w3bjxiSk9EgrK6a0wi+sHfQjQnUwI8PX0478+WyA?=
 =?us-ascii?Q?9EQN4PB7YSLOWRJoojWAS8siPWSr2bYo9f0H1gHX4hfTNkLr0aDCmJQ3I8yG?=
 =?us-ascii?Q?Bukh9cETo8SfbND1+rmTHAVq0Jp/8KP52SCp5TpQqVgeUYVcNbbKheMJ4pPu?=
 =?us-ascii?Q?r+556hc9WW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lrfmsf6uBe1DNs3QGjQIu9wDjWzclo6/pfgs6/es0XgDCjtAwPx9zfrOLoxa?=
 =?us-ascii?Q?v8AGSlEqE9L7inDHgLRkXnUGjSnbvKzK40C1qU+KuBpn0u0pbms5m5vu0szS?=
 =?us-ascii?Q?N8JsybAOT/6f2xrwIdXCzX+gcs7dRJc11TI5Y4Fi5omwiQ+U+e/OlWvS/U+x?=
 =?us-ascii?Q?sLl0e17z8prfTkROvWey3orYWPA8/rE9Dg8aEEiGD1GNFKwBuENCQV1rnZ9B?=
 =?us-ascii?Q?iNBChr2d5cPWzocb2FWkztt/qvvKIUmwXUkdrdQgXnqtO9xbS3DAekJOxNIw?=
 =?us-ascii?Q?nDEtabjf+WZWQobzZsFCgn9wUjWN+w6BgueMmiHTRf3ZZIfpC+Nyo+THK6l5?=
 =?us-ascii?Q?yf5pg5Qog8jqUgWxumMDlS6IjX99/BmJAhYHaaMZVW+VICnaN7deXifZXBnm?=
 =?us-ascii?Q?Jq/j022FDMEmartjcVqo8/yEqjO46NEXukOfikKmMTgcN0bsP2K42WKwSuh8?=
 =?us-ascii?Q?hpzc1gyn4SOjCBCuv256wTeKh8CK+AbRzpVqi+95vSj5Magg5HPGpGWd1h+U?=
 =?us-ascii?Q?MEM7Pii9u6qvhufkyyCe26m0vjnfXW596hRyWwyBM7Xe48vSlWIA0fGgPH45?=
 =?us-ascii?Q?Ht7NesJ18H93hSANVZAYJUaB4FHTG42bKegiDMlDzt8+0nnC4/Q6londPfme?=
 =?us-ascii?Q?/YiCRiDV7AjM26AkCRoXYrGFuE/epMyaWszWEuS0Hvgsul9tvcZwCkFe7PYR?=
 =?us-ascii?Q?5IvEmU3eKssJyoZmhMDXY+utUJTKrqJHnU/R6PRSw+hLz85S5NeWgxIe0OR2?=
 =?us-ascii?Q?Wf7uLIJELteAJt/cIq1bI7+sJzjN0zEAEeWKAdsTtjLqM35eEu7GVYlz2OAB?=
 =?us-ascii?Q?qjEOL8mTUTz/iBwDMvv5TuK1qtjd6VVOke9lk9jsD9zKjMTySJGWuXn5rf8i?=
 =?us-ascii?Q?jKVTc23pXukjWvcD2W6Y0YfWL7PzKlbGwAwrMZHern9fipRvEyLUpCglOo4m?=
 =?us-ascii?Q?MOIhtCL8e+mRuTvqfQjQBkz0Llt240m7KqStLlzeoH/3QrLeS3SE0mOqlZTu?=
 =?us-ascii?Q?pvfJb+bvx2VyQCET2Q7JU9pETGOa8fVMGMxSoKCZC+aeGc2HSDjJpFjryX0L?=
 =?us-ascii?Q?lJyQXum2nNmzIQUYW7SFozFGVZor3ssgaS/dZZhPD50N3DJbKasyYQE61ydi?=
 =?us-ascii?Q?c81rGlnMXkcpszTelBy94cSywW0qdvIA60jJdbZ40tLSdo9Qq7fd1p+CxXlj?=
 =?us-ascii?Q?9/38mmv4VuBlNG1bq22u2tqseYMv5mKu1J7tKvqMqVtgSuxsEh5hWDfP4+5X?=
 =?us-ascii?Q?hEhpPCJ9Kx6BZUxmMkDTuwUOY1GRFVHMGoiLpOCPhivwpaMVlvlWY/vXe6VF?=
 =?us-ascii?Q?XZ+zOdBxLC1uO66DpCPqkjnYZpCnsDsEzCJSP13+QeE3Ei7KfcRQYyfmXzwp?=
 =?us-ascii?Q?+O/klqsm7sB2zJjtfTWMz628100paaWu/8yGKupNUkJAb7gbWyWJAYFWNFYg?=
 =?us-ascii?Q?UP/VnpVLFyezqngnsfuJcIeWxLpVPkOifRy7BAAr1UzwfHNvzJxb6KljkpbR?=
 =?us-ascii?Q?yh+yqrlNNzfhFd0SsEWRdW4GhIEnETW2JJnmcxMVJ4cYZAr/sY9MwOSTBVk9?=
 =?us-ascii?Q?drcsxMr1bHyxdavA3XscqRdlSdI3eEQJ9IDrdFYR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcaa792-0876-4124-394c-08dcc6112eb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 20:53:48.2433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csy0K1Xp0c32Bf76LrO7C5zYInLVzZI3xw7udq7bo5j79iao6xwfhQdG5IbRWeF946LaUgpTWuBfsFEDWRYwGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10681

Add io-expander adi,adp5585 under lpi2c2 and lpi2c3.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 60eb64761392e..7629b6b44aa43 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -302,6 +302,16 @@ ldo5: LDO5 {
 			};
 		};
 	};
+
+	adp5585gpio: io-expander@34 {
+		compatible = "adi,adp5585-00", "adi,adp5585";
+		reg = <0x34>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-reserved-ranges = <5 1>;
+		#pwm-cells = <3>;
+	};
+
 };
 
 &lpi2c3 {
@@ -310,6 +320,14 @@ &lpi2c3 {
 	pinctrl-0 = <&pinctrl_lpi2c3>;
 	status = "okay";
 
+	adp5585_isp: io-expander@34 {
+		compatible = "adi,adp5585-01", "adi,adp5585";
+		reg = <0x34>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		#pwm-cells = <3>;
+	};
+
 	ptn5110: tcpc@50 {
 		compatible = "nxp,ptn5110", "tcpci";
 		reg = <0x50>;
-- 
2.34.1


