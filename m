Return-Path: <linux-kernel+bounces-233072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1829B91B1EB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDD0284B23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B51A0B1B;
	Thu, 27 Jun 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jka7vHA+"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EAD1A2FB3;
	Thu, 27 Jun 2024 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525635; cv=fail; b=NYaQagyNuF/96eZA9EeSjyBt6koAr12BaJB7YfzuV1aI9bbzWl34hpbT8d+2fMavvoBQSrxNIRR0AsBCzsDwVtXVN3Z69caVwRpKogw7MU8PM/1D0J21Jv36XTLL6T07SifP4QBKmiJLahbyArq04XIciuIFbWoXXaYXEMNeTjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525635; c=relaxed/simple;
	bh=TJ7ZZpODprmM1q3GA733j6B3fMw3euFpCGlK8B65vhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LeLrQTzS4Q5BCDKY/siyv8WJ7umok1D6/YN4I62zOx9Iyl7TW/iJ2CHxCAjRQDkG9eh0uC4vs/A44lZi8Gc9PkngRfXXRWi3+xOt5q/8b+QraO8ksNtrGvJ4n/pzv4865Yy1ZGqk+heALNksKNf94GSsvg3EN6i/vEYF1CqhVJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jka7vHA+; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljmRtVNe1euPB/PRQ1HLa1QAngWNiRyJaMGjwK/YWKBsWAqMCLjW+8SVy5rDrsTmTOh50LopelQUEGGFSDc+etFjVgDas1TTIUKuMhNMcC/4WHIKOftIe9VCuuWz/GbiSOZfSE32uLB2XWT7fV3mXaQeMHcUhyQbxr0JE8NLLAnORuVyorwpkoMuF+0/IMYNKwQpk0yXm7G4naO0/c1bwlLmnV2/IvGYNSaU9T5GDX2uw2mxVTdEV9UP3C3u4e7it5Ez9FIkCV0KOz+NwF6yi0qVEMOXASzQKirjjpsFMqjcHCsi4ntAY/IF0NNAFt0sqJNo6f45VxfhggPi4nx+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPblGwc4vgBZHaCA0JeF5UjzuGGeihs56COfzXbO2Vg=;
 b=kfN6Nr5E0nTd1TG7DTjDdYyR8GqA16ljDR3j5k0xyu38WGCL3wSh5sMJOFNNL7N7mf+/IYQZO06Zx2pyP/CUk5JvdSZmKvqAhCtuf3gZ1/zdgxzwR78Fe8TMxWT63shTqnoX1g7whlUNgECbwTu2k2JCrDwumJjNhk350W/j75EYd8/Pi6PeNbPNX/0GBH+b9PYuzp6BJddcXDdouoaqczicxiR7kjKdZ9iIOnNpVOAs9pGmEXc9W57L0/xF48RdtjvRPmnVXScBLRL8FO3zT30IQZwjKyS41izaJxV5issdeQb18ILdSzwqgoSXZFTG2CgQZj8B26/tqzc2/pOv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPblGwc4vgBZHaCA0JeF5UjzuGGeihs56COfzXbO2Vg=;
 b=Jka7vHA+p5CxSfV9gxee2E/nbm0c4ESMnYHGW9EOK9YSBnJ7pyulrhweEO/RzXXOqZF2kqWYyVdCra/BE0rWPfRKgd+7OSfovwC4Ed6ZbqDxo8/gKtrUCjUD1eEVDYy+F5rwDMjadahHxa45BjcBa3nQ8qjpr7pdM5tsRktmSCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 22:00:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:00:27 +0000
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
Subject: [PATCH 6/7] arm64: dts: imx95: add thermal_zone label
Date: Thu, 27 Jun 2024 18:00:00 -0400
Message-Id: <20240627220001.692875-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627220001.692875-1-Frank.Li@nxp.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:610:e6::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cf7b75-f8e2-469c-5342-08dc96f48d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4KmJQ3Bqcn/aGjyxH6+OkHzI7MwV5Ev8ASi/nY8p5c+7Bdm/OZ8sYbEtEQZM?=
 =?us-ascii?Q?1Sg6iGDfFTSVqxwPw11puS6rlbmzWufU9Zy+xO/jzlcY7kLTtW7968Gt2IGH?=
 =?us-ascii?Q?zdAX40t+pk3oZm8m0CFqdmjeafOEw7D47ZJWpFyZ290GzfhqUnPrubJVivH9?=
 =?us-ascii?Q?8RRoVnHYnIZnmh7ouaS0A3EjZ7Mq+EBWzLz0PUwjm9N3q6rvMvcHaAQ7l07k?=
 =?us-ascii?Q?Gpyggrs/5fJl39d1QPzaOC+6LlKSDOkBj6PCmTOe3Iv7O2Q9zEjl5pSlKHJt?=
 =?us-ascii?Q?+1Nj5CqgdLkUKmKRkjt3/kRvv35WZl17gF/LUZir36W21XO95sOxdvvx0ke6?=
 =?us-ascii?Q?t196aTnrR+INvpc40VyO/kP1oZOTMZ37D+IwQolPmIo8iRGE/W2HHRIJSL12?=
 =?us-ascii?Q?zNGMq2ue8+vvDqMffw5C8wjU1XnNFRlS+2ifN+XI+PdtIhkLgb9Uixb+LshQ?=
 =?us-ascii?Q?p3fD8vqB1NTu+P3AIquNo+xbfDvrv8I4o1f/EienmIAG2y8DfS0U6Cf9ti61?=
 =?us-ascii?Q?DBIHjMuTX3jnIw7ih4xgpb/kkupN3WJ2ywj9uAjlyhm44hlZnS0cuNfHkVk+?=
 =?us-ascii?Q?BSgejQVshYxiFWC2PLCMJxHSQHddslMD9nqA0vehKAkmlkPnR4kSEK5Pd5H1?=
 =?us-ascii?Q?ysignwrFV28WTuHa1AHBNXnK+YqP4MrVOMyicVHM3n4hjheKp6IRaIfb8Hxv?=
 =?us-ascii?Q?WktBA3WyVJ5P9tc7P8iWFnIWWHVQOS5Ui3StjXe5Txwjy1bSONQRg16t7tXD?=
 =?us-ascii?Q?S9EZHCCNYNtr45XfH9pZlAWXSBS1Ip1lTzEAE5LYthkPoAEDUrXk0DQplocl?=
 =?us-ascii?Q?4exxpqddhsS2/EzN1gzaZWCysjecVRhH3XTrT0oISQB0es7ri2uFyJKxYIrs?=
 =?us-ascii?Q?d14L8k4u1ynQF+0XV8PXNHj3U34rHn63ILAxZ6ZjdzqAOFooWzqMSUJq+qem?=
 =?us-ascii?Q?PjW6LuPLhSJuYHDc6zPyjKgo0CTJAoH/8lwcEMQ/bAn3gnWl08ViCLeKD6a8?=
 =?us-ascii?Q?M3r+UwJkyrLY365TqbHBki2WX0iihZcqt1PDWm/RXpdFSX02EL5uhze9ql1p?=
 =?us-ascii?Q?Nqlh/Yb36sVri5FEsQ8WdMnSeD+Utz6MZXeWtQUjcsVHTj0flfybCW8MDXXI?=
 =?us-ascii?Q?9XMLCJ6HyjN9DzQ3uqEWxs7W5mSapnPavhefwxgTMXMYR97vpLIcNe4LR03Z?=
 =?us-ascii?Q?DYIzK6kvGtaJB3e2GlsRd97qzeW2pHJkLOEFpArsjHCINWETb5q79zziPs3r?=
 =?us-ascii?Q?EjhJdBWjWIXhb92Ic9XlRUx6gjMM4EXgN/jfwRHz65631/LKZeqp0Rqq/OZq?=
 =?us-ascii?Q?cPmtrPYhH4gSoAdlTqcCjswlTCAm8fll3/WTz4itqE1D9jTCOkXzZyya21KG?=
 =?us-ascii?Q?Of6m8Q4mnP0FuiLqH1A2+q4twtKHZKYrlaX2bov30la9imbZwATQbqxE7qJF?=
 =?us-ascii?Q?XIFwmXcoOb0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+4fr5M4K4v2TsxHh+6SQwIXDdUahyMULLTHpSzrQiwMwYcUWWrsmQbWFOGuq?=
 =?us-ascii?Q?BNonOfytXh+t/JvvClbEOpTabxFWZJIGoGm+0GTyt8mH5q0+B6duslxqKQLa?=
 =?us-ascii?Q?6ytHAaBoZTGoV6yzqcvOqsdIpHCXtUqZ8vSC2UfHwaWCVrLo6Xh3Jg0puVWy?=
 =?us-ascii?Q?KfTqi3VRhQfL15xHWuMKBeDmAUIzIjQE/4/ZY3++Bsmw1ntwzyGF6ZKl82g6?=
 =?us-ascii?Q?COktXCRsrspBt0QXEe2PZERHFIOvsLqUkb9AmcCrsNaxMZ6rFGa7p8ovAilp?=
 =?us-ascii?Q?4yYActrG9/yer0kuToGUgHKAvOjWPZStDvPQueF4gHc6AE12WHNVOqdc+OqL?=
 =?us-ascii?Q?nyaxVCQ6xiVrG7RqD6zJ5mN27Qkh3bM6dNq1BrbbGurXkLUqQ3b8IRkwwYyK?=
 =?us-ascii?Q?XhgQNITvL46mCHZYOoq9ZL+5Mt0SA5fr+unL4dbaGwvA4ukLLl0qOSoYbMhx?=
 =?us-ascii?Q?kS3H+a+lUxktIe6jcKFKIPCYjChEUZ5Ycu5rt0JE0y5VeuOImjx3+/k/CYsD?=
 =?us-ascii?Q?wW7Z4H9ic1/VcTkr6y7GJWgRMDJZn5IEU0kfrgo12e3F8B62e12P9Pu63+Fz?=
 =?us-ascii?Q?9NQR6FyoqJFTrsqb1zi1ub2dmpLcLnEe9S0XRrvGHbKkJ1ijpRdsNgmlFBH3?=
 =?us-ascii?Q?Xs79e/fp6IJ+ruUvaz08agsOAVnvImNzecn6VBDpKokSlaWCA6c9hMvIKBuY?=
 =?us-ascii?Q?Wad/ucMVpP7uQ/mXpStBVzf2HzDWhAKiKMWs3A5ZPhloR2neIXzaw4Q3Y+Wy?=
 =?us-ascii?Q?A0DjZCUgIoG1JpypPxnanBkpO8j5KfTz8GsbQIi1pvSL7XkEiiT23CEQmwvv?=
 =?us-ascii?Q?PL31Sb+3GSnG88+mBYsNazLuXiLeRV+olFXIjjruSd4gKVYm4ad5SQpfQj9o?=
 =?us-ascii?Q?67zjFXCknVlgAHANKUllnfCAIhw8DOiPVYKywolhhmZVdsTyzTVKpOMGYxjE?=
 =?us-ascii?Q?G4oXiDw0p6WS4ydBEqAwHwAi/fF9UruxHllqgfW+vb66xpACWWUNoJLVmyaT?=
 =?us-ascii?Q?8GOAWi9UgCIiF0X4rtDQDsUQJ5I617ASB8EuMosRWsGpcMwAKqgkTRh/McA/?=
 =?us-ascii?Q?BSmYdky9lL0PJiBFZiR8OPoahuD38yxYUozzUlElbcKQYMwy+a3gAWMTBxrP?=
 =?us-ascii?Q?40JGOAl8kgjHZ6WTSW+Bn0eOt78U/niPo6KxQlhmNgfwq0F3atruuZifLXKy?=
 =?us-ascii?Q?sxsVrKmX7ooH734zZhJtSzP9fFgVdxZqbZfHUbSJetEek4Dvbchobz+5/94B?=
 =?us-ascii?Q?Y5fyhPX2KR8ck2w+g7Rm6QQveUn5JH6LDGJtH2dBNphtquelsYIxvbpEW41s?=
 =?us-ascii?Q?r+fdhoMtQhi0W1Ip/CQOfnL50HuAq3KAomzTAZp5Jeg7/p3EbwJQiWW4WmK+?=
 =?us-ascii?Q?/i+hlT2rgMfc9Mo5UTAv0aWNPhRlInTnDD/rsYTXvWYkTeaLKLgo0EZdNt4c?=
 =?us-ascii?Q?xSusSBx+4UyTrsFhZmhSOhMxj4cB+GFQIpEsSejFw08gbZRqyMVs9qEQLr02?=
 =?us-ascii?Q?J9P+0LJLYu6PvGS4o3PhhGdeABjCPlMXvyGfGkYrdpyQrkEwGAYY/DfHM5QN?=
 =?us-ascii?Q?aXNhSFuJedDk8+EyCDI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cf7b75-f8e2-469c-5342-08dc96f48d65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:00:27.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2n2UIfzuJDRAxsgraJipJ+Tw6qAGBxBVonP5Yn0kjIe3fgtXc4RAByI30bZEb2TSk7+uKjj6ZCc8Qwjsfyf6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

Add thermal_zone label because it may be overwrite by board level dts file.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 0870c0d13e041..e454240ab3b04 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -326,7 +326,7 @@ pmu {
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
-	thermal-zones {
+	thermal_zones: thermal-zones {
 		a55-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-- 
2.34.1


