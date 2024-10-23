Return-Path: <linux-kernel+bounces-378926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0729AD751
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA441C22C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371D2003B3;
	Wed, 23 Oct 2024 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z3ZLRDyk"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2045.outbound.protection.outlook.com [40.107.103.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9A1FEFC3;
	Wed, 23 Oct 2024 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720995; cv=fail; b=iandKdAInqBeBkRc9WNyxcat0Hmc3Ysv3/bNcMSDgswIVvGlxCYrQHsFU2mTT4xT9f6xfaL+Gj1qGfVG6moOENqDUTBI+zWdfnbwPn3nGMZUThPHXG86Bm9XrVGzpQM4j9viojsGxK9WY25q/gRdTapsTvmOlvvbrEOuMNAMr70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720995; c=relaxed/simple;
	bh=yyCVRrRePNO4uE+hJP6k6TdPfP5CzPY+nVqR9xb6AWM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Jxn7lkxSmd2cRo7liDSn9efspL/wsDgSyPvfhAIveqS8on+VrVkZwQIv8eALmX69l5Ig2FZW1HupPNMi5liSbXvZdkc+5sgwnRSYfK6BzUC08v+EtoNJm2i2tGGEKNeDK+DY8gbPiA+6kRII3sFXya8jYdWUfOfqCNW0+2D79uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z3ZLRDyk; arc=fail smtp.client-ip=40.107.103.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKTk4ajf3zX9sskVkGZ2ZSaUAb9pa0pCMtlUVfaMJcvA3ajlmq3Ij9LFS8SJTTIRjaFtArG6ba9HwTeCglH3XAe1mD1FJ/WXL73AU2Tp8uCpR+KmliCSR2ZDF25IN4cGmEjhd5q83t7IG0uJOpRiNXBpjVk4uF48zKl+HH1wmEkxaGcgZ51XruIl14qQxSRHTZX56TZgbG69AARm3qT3HCLZ8v0A2Sqt5VUc63IpotXTXmTb/SfbJvLbGzc/+kG3PMGIXeRn4hUWNLoOjWZbYICkoGjmLz7XcP42ca0BOGVXVF+QZwbrSBpsJSNCip5l8iSrvgVCdLmt1jIgJyk2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVe1yu3ewWqnzDzv1CkxAdlrwtDVr82QN2opMgVd2uk=;
 b=jKVf8BxxQHXiS1x3ACxN7WXjmNYfpP50FmDxKnH2ePZzUMHKaUadwvhhUC41A1z1smPi5wNIM55nHFPI3fajnttgGbi5HBQJgB4oiPNrY4WHD3hg+9OnIG/QL2dpN8+/J0StpwV5ziiwYkarlBhe8rsK3JG0NcHs32cqOXYz1NaqaZEX8iou43FJHuOuAf05/uIxQrm1xyVVYseTSqGb2xuXR64Ip5pWO5EwYiwnhST1XCmWcED8/ARje+diw88J+hSQo6QYuhQm/Fnm+hgELsdho0yS7MHhQ1p7ee/QJc95LSDpMAPa5Lvhk83Clev+rH3K2QBLA1VqrrehifZWUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVe1yu3ewWqnzDzv1CkxAdlrwtDVr82QN2opMgVd2uk=;
 b=Z3ZLRDyk67ymmkpWoFmQuzxf+DyY/UJjH+ECK9FfTxAAAEqVGVokDm8nLjzYsPdLIuUcOHRqAX+GizY8T/UJKCmZmYUfqtUxXQObewe8p0OS+yFFIM6/QiUY6hwWNCFXeDvj4ZnOgFrO4wUszt/aRrSom4sCBJqcy6+e7enPhYZzVS4c6J5C4IgN1H5s7XL4FdBa2Uo3dOvH5NuXnzfJBAuX1OZWsFDlD4ZUr4bkYxY1I5wlf3lSKei0rsSmV18V/p0SYsBXa19LadW9cHw2sOKSbap7a8fDBTP+4gfGfeJVstm4MyMVCLIcU9Rax1EnWjbQAgaJ2l60hKtDvUPHQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9438.eurprd04.prod.outlook.com (2603:10a6:102:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 22:03:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 22:03:08 +0000
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
Subject: [PATCH 1/1] arm64: dts: imx8mq-librem5: remove undocument property 'extcon' for usb-pd@3f
Date: Wed, 23 Oct 2024 18:02:52 -0400
Message-Id: <20241023220252.1392585-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 728273f2-ecb6-4d26-9b99-08dcf3ae7a93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?irHLV2lYMfq9bf5Z3y+AoC31ktkNnp2DGaHHn5aqGdRGEVMcq0bYVeg6uaPd?=
 =?us-ascii?Q?N4H9R9z795J8kIvgy9uG77fiKiceI8AKZvgYeqqRWl2e2nUyCf1cIdTPMFk0?=
 =?us-ascii?Q?UgWuePntxgMa6Nfjjw0ZOdmtZ00talbfMqM2RC0GACogS3OREipot3c6jI80?=
 =?us-ascii?Q?7j717BFaPa+kmfPjUQROCwS8VA/1xUTPHUgzVt09mX+JtFhKf5WmiYXLg9BR?=
 =?us-ascii?Q?rp9ZlYibSCkGx/D55WMxHfr9mG/sG6wjeyaG7o3IP0a0KHojfuAyNlXXzOUZ?=
 =?us-ascii?Q?9DbWdnteKwRv4+dM9s0KDArwmCtj6cC95UGCKe7msbTLG6yQwuwX9zNY35rF?=
 =?us-ascii?Q?p1Ac15k9W9evpHj/8Z6ImEnAm0ZMy35VKHHXRtkdsbfWVgTRn2GwBFchjLFr?=
 =?us-ascii?Q?m1vlt8xhxIzv0ir1p1vj9qkubxjoZh1SndKn8VnlCfmzG3vkAcfusm31CEJY?=
 =?us-ascii?Q?cr7xWr9ziHoWQScvJaL94b03QCXviBdFNAbQtKzp0hHjIoOopkbWiKxZyh97?=
 =?us-ascii?Q?mbwpYKCbSJ17Nsc51aGr6JyphuHzxuybNd5OoAGqrc1JnkgWnYni6pmy6nSt?=
 =?us-ascii?Q?tiexEP6OmWR1nnSr+L/ZrIkNavLWJy/RV1oKbn+0LUayN1IyTAdSP0HQz3RO?=
 =?us-ascii?Q?KSkAbmo+nN1J3vKXVdrLt/I3LYaIlJTQZGQLc4H7PV+n5J4aoSVsuTc6Tu3/?=
 =?us-ascii?Q?bii96QlhCP5priXS32M1i0IfSCCqhrFDdBVwkX1++J5dsToVB+iGHN9e92L6?=
 =?us-ascii?Q?QTFKFmG9TncziW4KksCa1TKZtYi0x7ojZJES8PYUA3w9oZQ7NekbD4d21gCy?=
 =?us-ascii?Q?59Mqv8e0PEHOvdbZ1Z5s/wFc/OO6hLtXm2WBAlF6EU3sqPuGiEyKATNfmD6N?=
 =?us-ascii?Q?qUHA9kkSyFw9VRXA8MQjoo9Ko1jWnDRjJG8L71jeId281POAVxSS28u2yBwV?=
 =?us-ascii?Q?7xB5nMKLJbdf08PNG7AoOLEcCCLdia5W25RvtKslfvVovtB6N0LVar2LsX8j?=
 =?us-ascii?Q?YQCr+jL++Uf94nCM18LzrvGXVWMVC0+TFncuwEnlDzgJf7mE43XxeWgJkvFG?=
 =?us-ascii?Q?6yc31g94lrBSI8cl2xRHfLgNHJJF3ocv8fYMx6J6mOaSjsYqoGjFTpzJwxAO?=
 =?us-ascii?Q?oDIXKFffSAHG1J2oSAvCMGqy1YT3j2uUgLCzhMQvBS6dOXXsELkdwna34i1K?=
 =?us-ascii?Q?PJKJPTkiVEk4q+XexRNbyabreQ9FP299+sgZWKUW/gBLTHjqNh+t1mqqAKAy?=
 =?us-ascii?Q?UoULpoT5BkdPTplDXqllPvSNCAPsQGOpZSULu5v7Xd5U3XvwF9q5zrXj0bvK?=
 =?us-ascii?Q?Sb/LOqY3n2fnw56YjFnIC8PSkzS9PCKLmx/XxxHGCUaDRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JZzBWx5BTH5xVyZHChRnmUQh+0svEjArkhiyjivX6FmGRVM6N2Hs/FQt2CaY?=
 =?us-ascii?Q?SRGVZY+RaYkU+u9AVPfNw53WwcM94pEslT1ySmhUF3ecZHRc88o95AiLQQzl?=
 =?us-ascii?Q?Smk8V5O6QKZCE2K1X9OwB4cOxYG5ieoozUsmo8u26N6dtASt05c8sIfoGkor?=
 =?us-ascii?Q?FG8AlcKsLiluipKao+tGiWjNXFn/kKOtc9y0VFG+7bM8LJNbN6cEPAu61BtD?=
 =?us-ascii?Q?PAbPv9ykdF9zs/k/qPXndrDka0LWyJ371c1yYIfP0D7Tn6d5aRCErUcABcnV?=
 =?us-ascii?Q?b/m+JWdN2Th1iP/hfyxqp3szUKWXMVRiS3yyTaIbboxWLThNpCiLb11r8RbF?=
 =?us-ascii?Q?+bQv3QzJaPzMnymNvFaiCj6AZksANnm4szdnuYvZOrE4tc3jWbNql4cQ5vFN?=
 =?us-ascii?Q?G6IPL9g2wa82RdLSdnQEvedhhDh0P7xlHxxoArTz/1ctGVbRLLUOG0kwwMZc?=
 =?us-ascii?Q?TS5PxD+O54ckCJ19dI2lgbTNHQcA/GeoUgdDkxC4x6bcj7/423tHIuVPGkkW?=
 =?us-ascii?Q?9aztwmcmt22VoqMRVZqNnOI+uhY6MKRYGgRVVst7Ny8CQ2bog9K4qv+FVIpG?=
 =?us-ascii?Q?O/Q8btfkS/NwzeiZZ+D1pYeBI0WLm+bNKCSuBRWtTDpwmKRArzJTxMHGdUi4?=
 =?us-ascii?Q?A8Uf/18MLdDsXTODcwQMT3Gox4SHRmXg3lbkBDfVmD5PSdGcUJ0YeiLRBmh0?=
 =?us-ascii?Q?EHRKUMslyWBTWeYfnjKr2DYgOrUREnRyF+8csi5Kjtz7+rMaCSGjO4jKlzJX?=
 =?us-ascii?Q?D5KVNtbqYkifTJhYkQSD/5C2zVW4h0Y+N/MFP+byuIJi84KT98gAv3ycMJLL?=
 =?us-ascii?Q?ADxKhBZ02xr4W/yy/MofW90XqHrZF5yG4IVfU8K5s+vhrXy+GqFBr+UbIWIN?=
 =?us-ascii?Q?vfwrgBMX+fqrFx81ldMoaiQ6haiQVe6IToJnrvvisHTe7wbK59SYFFNmLM5X?=
 =?us-ascii?Q?waOdl+3LCnlxkg6z2iCV+NSAC+hB+8tvvvBeQdWusxAWyKyXQMNwxTl/trbZ?=
 =?us-ascii?Q?Uw+8hcQKxuJ+faxc0CHYMeVCptijJjGL9Mzjx7u15jDbbDh4buFgMBAVJNzO?=
 =?us-ascii?Q?66K3yXEm7GuTjgMKIyH8+CDprzKbruHYxa0Vsfq0GRHJSxNgVkHBBPanqii6?=
 =?us-ascii?Q?q/m6+5i/u0eXVbuLhnyu/yYAJ9Wg5MY7pX8dH23yPO7KTfskqwAetPhi4ehn?=
 =?us-ascii?Q?qRNnKdLXj9FvveYXhlWahGIiJsnGVPkvuR+uyEuuouILB8nO3IzrGy3G62jr?=
 =?us-ascii?Q?lOg6u+FD+6C8wcGmpFkG4+qYXezPHu3DSzY3FVCfpfIWzUDnhMstJAzipLYi?=
 =?us-ascii?Q?hksj6Kf+p++eslpf05oPcm9IY55Kw6NvO4J6j8oU3UlBTVHqd0mMcwnDkKAr?=
 =?us-ascii?Q?qvct5NC9RVA6Jde2rrFVyxXNDYhVH5ge6RtP4nyJs1+Hy0pQNx6q4IlPfLyz?=
 =?us-ascii?Q?Oihu+d1n9ugc1bTGa7LL8MlPCd4gRAdlzQWHH22tMNFenAATUDF1rnOHvzuy?=
 =?us-ascii?Q?tGRZVLSmgoV0g/NWyNRns3FUi8HgPOUCMNbigWLaGT2CsgRrUZYJILyF0yW3?=
 =?us-ascii?Q?8kK3RHGjAYwGjOWgJ+rQ6QBGcpiMctjNNLg35QjI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728273f2-ecb6-4d26-9b99-08dcf3ae7a93
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 22:03:08.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SYWJzwEgUSG/kbqhh735+O7v/aQSJzZtx+zmhRG+aCXnx2W9qI8IGXwtf6Jb9rw0HlL1X4MfOARpWWy4FU4fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9438

Remove undocment property 'extcon' for usb-pd@3f to fix below CHECK_DTBS
warnings:
arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: usb-pd@3f: 'extcon' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/usb/ti,tps6598x.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 1b39514d5c12a..61bdb43dec31d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -794,7 +794,6 @@ typec_pd: usb-pd@3f {
 		interrupt-parent = <&gpio1>;
 		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-names = "irq";
-		extcon = <&usb3_phy0>;
 		wakeup-source;
 
 		connector {
-- 
2.34.1


