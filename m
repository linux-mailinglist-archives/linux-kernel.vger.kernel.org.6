Return-Path: <linux-kernel+bounces-303599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60045960FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8443F1C23338
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81581C945B;
	Tue, 27 Aug 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L7T+6NJB"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCA61BA294;
	Tue, 27 Aug 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771022; cv=fail; b=Z3h9c1EYNt2b6DjKb/4g+3meM9osSathThij1ddh5aq49A7h0g7hHo//yJ/2ZA/5MyGev/CcSIL3qpXphQfp2P983nnnxi5IOqaiRs3fa5xF8igy3vf59typ3cTFNOYkhLUFNZ/yeJW+mJbI/FkTXw+iHYdClvkIQKj1qfkU4w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771022; c=relaxed/simple;
	bh=n4hgOONLSDQdvV7I/LCmTpyKD1Io/pMJPvAcyJVL5d4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqG5qBXVkim0UQarSF/ix0yhNCYZDdxPiiFiLMX51XmL5ar671oH5yxiWEZHzbxaiVjYnltjj8yzFSGMwhuZ3bgSHbbKzNaS68Zq9syzt0DoWGMmrC1PeNajhAfbr6zYWYsctFBf/Y1GMd1gt0sIpd5rMJ4VmuN9wT6jbF0MWrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L7T+6NJB; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzzXkFVuXO4yUp456Bz/BMepeSeB/hME1QXJKVu7sVDVfK1kxrAAyFr2bFRQoujJOVUEsKgosOsRdmoIldTL/LfDJ5eory6B+2ZBw4fCfhGffiRjPJmnhb8EKgAevKCg1/Z7wOByJp683vhadT7VvWx8hzzLFAnIQAn2RNu+7PghXRT+PCAIzLuDHeGIfw87MSIBjGIjWwAvPs49iqzTP8O8VqEopMtKU6XkZQwNyThKhNsXcqCBQw/Y00scxdwHYmswJIux3z1SslhErSwTaxiuqfH7pTpV8JWUqqbBmEvoC3ip4VyFBV/qfSlLvISWEtLbENaJusZevMchG0NTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGrrgb5ZcJp5y3vYgMYK2j8JGroQFSs+KC45CTDtMA4=;
 b=dzwycXv1YdqeipvCZwhI5J+optk3zYyOnwTDP6s92sAxOs3LaSoBDyOWizpQ8QkA6c1n14a3k7JiLCqFWlcMuz0GrwOrGwybUSlCFj+HNpawDsX+XmlUz7mXA9Sw5lSUdwVQb3QAnjF0glT75E2d0i4+390FP9g9x5Lkl936rqLzOgkQqDPlgrOPAOorzqsO1JXLutKlc9KFYeISGJ1Rq2mQWLQG/F9Cxx/80ukY4OCiuN8Qyn8cXzQMTPR8blAuXwagtam4XAftM7yYaO4QUQrNJ/4l0GD0wjHla1k7zruelohDJYeFLjZqv2wRg9Zb8hHilk8kr1sZ05w3/ZWhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGrrgb5ZcJp5y3vYgMYK2j8JGroQFSs+KC45CTDtMA4=;
 b=L7T+6NJB3p1W1iuHqphiiQwamj4zIUYoksNR8m7HFq0kN8Zn27e0OqCa+CoDfQMPr0qvUz6O96qhwR0AIpSxu7Lx0Cqr5ka2gICFsZeJDdYYNbAJrAvToL0fEJ/hrzUXJVwgEVFrEa3joD/BwZoMqNU+5d7adwce3/lGzl1Qw/oi0pha/dEuAcHXhjyOK/x3DBb7qNdiIaRXIVdwJo6CcVcvFVewAUEtNTIvwpP9NLOh9tXnV12YHt9ccOXKEOYqsqIm+n8hJANX9eZdevguqcsVodpqUUW8gprZTuRUfl46kufrDQElJGYDr9IiisOJ50nHKV6l9rgLkzC5+X0QRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 15:03:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 15:03:37 +0000
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
Subject: [PATCH v2 2/3] arm64: dts: imx93-11x11-evk: add flexcan support
Date: Tue, 27 Aug 2024 11:03:16 -0400
Message-Id: <20240827150318.1001050-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827150318.1001050-1-Frank.Li@nxp.com>
References: <20240827150318.1001050-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f688d2-7a2d-450a-47c6-08dcc6a96dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6HM7MgHHgNqngh8XOGeE4iOlzfWN0tz44qaKNtcKnGdf4cbcPA6E/iz0Cac5?=
 =?us-ascii?Q?cqdqerWJbUzEq1EYWOy68DCIyfyq9OBj56V6DyqfZrXc2A3ZJJkwf3N6gO+h?=
 =?us-ascii?Q?DcZeNGopZ9//Nr5hlZsPsTp3MK3dofN60Qy1Hmajc13/jzeO/Qz8ZkF4H+Lu?=
 =?us-ascii?Q?8N+QslJcxhUDnOdV2rl5owGLsHOZjMKQMpubWJl23EgWN0j7MNtQdOlu2ngP?=
 =?us-ascii?Q?OsS4riEDFwq6uUICFnLkjZfbYGKopYrgPYirD56SwuYT4eLkOCSbc/ZqC+QT?=
 =?us-ascii?Q?4+08fxHRvilZ+xleG04/L89XqqqzgaUApdKwexDS2KXRNe115SuxmPF5j3+P?=
 =?us-ascii?Q?XYaqDdcQcWQsstcCxa2n6mT+rEW08VAmM+aGcP2EWJYZ8WD1JiXePcZmG+zA?=
 =?us-ascii?Q?/M+g94Jq9AC6U+qwUVajEv5bXkPXhsm1Hnn2y63ByINCVY0wQZ1bcJ+w/SCC?=
 =?us-ascii?Q?OBk222qNVUsudTpIYJ2trcODJlwRHkFZ/yD1XqzcPwkO8kiHN1hpOlOu1Z7M?=
 =?us-ascii?Q?IcfasOhfUgWUUcUad3k/4z/ThaIb7UvPjKjDgERHSwHNjtwf7KmV5JB8Ayhs?=
 =?us-ascii?Q?1cDrbJLw2g/4jHPlRrpZQ9oWa3J93qtJG3WDNz2p0oHqcjGIfuCPO09t60dQ?=
 =?us-ascii?Q?IZQ8pkf/SRb4BeX7oGLyaVFpMRKf08aSuHIydXCjwnQxdSqXgFCSWfZqNaNl?=
 =?us-ascii?Q?0nHWCKy9NsP5DDQua33hCOLseoCsOyOUv+t8iS2UCAsTp+73r8M8A3+WSr3f?=
 =?us-ascii?Q?En8t6HkkZ+u54J2HQWy12rtTtZHeQZ6XLgcNCCmtyEZqPGOlYx5mMLKmO8aR?=
 =?us-ascii?Q?k7LEvuwtDHly/UY+pt7ctgBztusqm41MIvhK89buw4oS0jydHBxmYUj5Hsq4?=
 =?us-ascii?Q?S6ygDm1ZrsMImWrrA+U8t25yeJIh31UNAzJBxB+PvSvA3a8JwcxbMvwjtl0/?=
 =?us-ascii?Q?5Oif2Lnpptd63x6p9fd+O7hzuvH+txrQUEWnKb0VVk/GeYwIkaSBc5AzsDXk?=
 =?us-ascii?Q?QWQYCKedXr9NZVDRTWp3M4HDKV4u4nqk0Gu7g7FA7Gttd8DzSX3KrmS/PCPy?=
 =?us-ascii?Q?ekcYSoHwssws38e2N4Fx0aR0VkrE2ecIOhhtSGo9mlkLHVAiuC35xALfzJHG?=
 =?us-ascii?Q?B+4t6+cNgPsqRW7rzz6jbqykvnuv7It20TpEs2Kt+9yI4G1X6Rs1GB5BEeNf?=
 =?us-ascii?Q?D58XcGp1Xk8XhtDCgThcPHxZeuZrP0x5c4fS4HB1HjpBw826U5e5+AAJJeE4?=
 =?us-ascii?Q?fnRWokqIGPv76p+XBKZBJ/NYIbLgF2nCzv+Y0xCUIXEQuMxIElO6bHzeB6L/?=
 =?us-ascii?Q?36AQJJyPIGIj58iFXd0GWnhpSKIBNPH9NSGglFJ2x8SQdd1q5nR3HY3M6nT/?=
 =?us-ascii?Q?m88URhz5XmXHH5eeIJqlP6olOXpTggPRcByiXQAWhiNMaz/KOKdl3/MOuXud?=
 =?us-ascii?Q?VkN2BLJSYWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrOoR+WplWsA5owuPwtDpcnpyqkQ1kQbJyA2VJmZqOfw4RlYciKQsDzA+JM4?=
 =?us-ascii?Q?ETFtHKlJO2BtGSPl2er3NyhtZIqVFscIbMG1/0apKW3gY5gmkxrOYv6qygN6?=
 =?us-ascii?Q?kYo10z8mPXbht5b/hIJHf98D0UfAn+hsz19junlOEd/cgNGk7wwm359QTprL?=
 =?us-ascii?Q?KbyqTZf+SLFvyEVk3RYBmBJLFk3GXgo6oHVtTH5V9gix+rP8XJD3UjB7Ehjl?=
 =?us-ascii?Q?yJEA1YGpJJhv0f/eApR1Lqh0s6G7wct5+CZU7MTdHEynK9NLI79/zgRSz+oA?=
 =?us-ascii?Q?2Jlpa3c2b2kPbujMriCfpO5C+hI3XrdBxnW0HjeZ2QCuVUiLs4DKKK02a4vK?=
 =?us-ascii?Q?RfzICrcA2mgTM/tu9Fm506UfHF8lS0UjnCB/7JP6vq31zHuIUHoBdcNgUY7Z?=
 =?us-ascii?Q?F9wWJSaMWykLqRmJsMJIcf9l5COGulkrzDZmg67EACkeQyKeMTdQk/GJGHuW?=
 =?us-ascii?Q?G5L+8nc2Y06iR4F8J9wFEz8pjkTQVihZEeQwtLCqeL2Ft3V3rCf8UbmvzoKo?=
 =?us-ascii?Q?tIbQZtLC81KNXVH75TbBrT8mHVrsBJBjZizRTzOrbTuTBNThm9ceiUdlPZLd?=
 =?us-ascii?Q?rqbTaCkLJghthDtbFyqfad36Ul8pS5wfrjcOVm5ckJSFpHJJ+SshATRn15jX?=
 =?us-ascii?Q?cC0dtX7An12gGdNhib2vV3nv8Oo3RtB87I1/A3Rm8crxlt9+TxiStjafRd/M?=
 =?us-ascii?Q?O4kBL2klgNhgIDMESx8gfc3+++/zUo0sMZwVFs7nMc8KHFnpdPwwlBIsdogn?=
 =?us-ascii?Q?PRdfFiHhKh8z8DvGl1YpJLTLKX8aF44p9wleW+bVK2DETonGkttm5R83pPsV?=
 =?us-ascii?Q?dIRpkbPUImliEb+0rSO9Uujiho8BvNC3CwFZlXhhsU3UVYn50NVBvqJB5/fG?=
 =?us-ascii?Q?Hy1ijjm+q+trR0bpwSG+nVbhP1l893wa+QrepwWZv+Sr7V3woQ8Sp9qlPsOL?=
 =?us-ascii?Q?bXoUHWi+O1lIpOuJtR2GUKuyz+zlhXiBcVPcMzJcFdUZP3hZHHOJxHHfbulb?=
 =?us-ascii?Q?7NHM9zKDWsthh7HCRYp/2lKuv9eNkdHvxxRMPrOprKpf0FP4Tc8+CHE+k6Nf?=
 =?us-ascii?Q?zdEHI+9aqlkBwQRNSModDVJ12Fz3yuCtA/GElQCqwepwZJOX7qGyYgAjYAMZ?=
 =?us-ascii?Q?MaOopc0TdDu4KpDvTXUDbXik4/jimKGkPwsfvE1v9LasjH77fDw/vhbQ0209?=
 =?us-ascii?Q?F72W6CsJx8NNcW5TOSSdxWMuzYQifuhpQT1DTPRCwEFU1Jwqjx0wRT/Rdo66?=
 =?us-ascii?Q?aci5dPrGwu3ScMKOkBLIJIi8Dex8otnaeMFO22llPILR2zXiow09/c/OpfuM?=
 =?us-ascii?Q?i/l4CHEHQcrMCZKjFpLGAHthWzQB2jNkySUT8HaH5b1UL4eCGkKp8udbF0Sd?=
 =?us-ascii?Q?E7a8gJBAqHrCYwve2tcDj1hBsi6Niz9qk8gHPb+90ByR2bjUugYs9O1oWV8l?=
 =?us-ascii?Q?63hcAjaIkBNWGUlOJCOPfZPGdQI9DMNMa5YB4nhW8iDWANwbmgAaSj2MBUGj?=
 =?us-ascii?Q?gU+XJzqHhy/bo4qHgUVu4HcYLa5pUu8FJUkRdZmmv3tpKFODVrypg0X/YEHI?=
 =?us-ascii?Q?m+FzGO9gSDpjNSgZraE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f688d2-7a2d-450a-47c6-08dcc6a96dff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:03:37.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giS/FGgdfhcJQoEVsOshuOhGBBO6xR0YPDoeT/0gwQAGIS4o8Ba71JjSBGJkozqAndzOEoTYbYV0k87L3KnLBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

From: Haibo Chen <haibo.chen@nxp.com>

Add flexcan support.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- none
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 7629b6b44aa43..f20d281531734 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -69,6 +69,14 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_can2_standby: regulator-can2-standby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&adp5585gpio 6 GPIO_ACTIVE_LOW>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -196,6 +204,13 @@ ethphy2: ethernet-phy@2 {
 	};
 };
 
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_standby>;
+	status = "okay";
+};
+
 &lpi2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -602,6 +617,13 @@ MX93_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
 		>;
 	};
 
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO25__CAN2_TX	0x139e
+			MX93_PAD_GPIO_IO27__CAN2_RX	0x139e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-- 
2.34.1


