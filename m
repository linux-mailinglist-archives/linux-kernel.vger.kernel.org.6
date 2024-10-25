Return-Path: <linux-kernel+bounces-382695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2979B1252
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD412837C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7520EA3A;
	Fri, 25 Oct 2024 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PuyW3Wor"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA86217F53;
	Fri, 25 Oct 2024 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894111; cv=fail; b=GFhLF12EmX3pgPTCL1LGaBcxs5fJ23nmxa8RXddZDNOF/DRSiWMcoVHvjjERFDvKa+j98FeR9BEAsUZknVvFgJfQIKnHvGtMArY6RHugpOa3iGM0VnKQzbxO3iLvga96Mho7pRo3JfxLz8UglIuAPF5/WkLRSntxXgs0RDaJ5YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894111; c=relaxed/simple;
	bh=5p2XFoQB4HXuP/KyQ9IhHnOk3vRwROhi3BCUtXDvS+I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A1uDAozSbpVTilHQRiX7paJPK2IwWGhaRCIkwXKLwdSWZWfCbGh7pT+j8nopomV3KdLJuxXFUuGE/2e+/4b81LQhx+YNCAFrDXGaw0uR3R5vug0swXX2umbGlXQ5Ih8ELKaIqAYYTaT4cQ8z8ql/zY/S97oH0zSQj3Mg/8r9HNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PuyW3Wor; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RV6zguqB/YzWLjrMNwrun1A55bWreQHBhHBHe3vBPTPqAK6vTW/+3rRaWTR125bA6u465CCB4W0Ovg96XkbpNKe2EsCXNPxI0JPiwdIubGM39n38v2s3SOeyHXlGKYfrXReyd8uLtUmV+mm2dpAjAHmQL9cXqW+PA1aLTQPbkvsSy7j1fXwhPXe74LgcN+8TB+7Yki2NDe8GwgH4AcMZ7t5upheAy8ob2fLWCQ59yAYvj1Z6P7ShkyCD1edML3ghrwJPtgA04SHOLmn6nGKyRuNthJn3yBp3BIBLcqxigJxevJtu20AENTVho/6GCex1m+9RVrjNkHdNwoyzHu7RPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZnWVvuX1G03O2mqZStWp+nvKszw0pdshCRaDxa0Jvc=;
 b=bmLg3HamyDje0hQrqfUPk3qmod7RG17S5pFQdhNebwe4+7xL3oMxNc6eQKa2V+VAhE4UJokDJdDX4HXlpD+dM2gK+qpVpSvLlr6Nw9580yKKY6ONWKyuf/Fn+QepWyBwL71gx5d+yBdPvm+oMe6isO5xHiSU4yRHINd/ipqoWBSo10WNlXUZVTgplH6FgGENrRc1JnauOqZm7KzJqaQ+wbINW56pnlm9j/tmOIlhammHsrVqK6NhL1jFiQC9Q4JuM7vA7CwkFmnWG6Lju4x9UdJZQ30NIvE0qHFjgzZfJ/cKhUOnjMsSrkmD1Y/lltazHb9Ku9SCbW7V8zngTfralw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZnWVvuX1G03O2mqZStWp+nvKszw0pdshCRaDxa0Jvc=;
 b=PuyW3WorcV/DqmkST+6TM+K4/X+NMqwf49gqzde57U9sHw3ZCuiQF7NDHaVHNcjjb0v15d+GLwXzDfz+T6QFSllkdP9Rh7LdpEuTzU9RV9o2f6ZlSsZlu+L4fi8NQP1UJvWFYR4lrO7cNVlLOV8gFJ4XnoeQ3vGWtkgIPx5Vw+8hGx6RD7TXGaK8KHOi3tnLz+KT7eMVzYfKGs8dH24Sn+gmllnSIeoQCcoK2C4b1Bky7X5K2Jj0oi1SnOnxJgmo9VM5DKI8DNWvm6g8Qz9TXpocGc3X0d3deTVpoWcC+sZFFSZiD277A71elP+9RoY4t/OcWFgYR/AhAJxY66KTbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 25 Oct
 2024 22:08:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Fri, 25 Oct 2024
 22:08:26 +0000
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
Subject: [PATCH 1/3] arm64: dts: imx8qxp-mek: replace hardcode 0 with IMX_LPCG_CLK_0
Date: Fri, 25 Oct 2024 18:08:08 -0400
Message-Id: <20241025220810.1833819-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:334::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fae2ce0-b66c-4862-9cbf-08dcf5418cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d7x8Xj4Yn6aGneTwEG18WccBk2+yAtyl//A0LPBWkQyCRU0G9TWYQsTQBMwY?=
 =?us-ascii?Q?l2Izi/y4T8WTal0di+o80tlPm/QE4JFv30/7hGr4IO4s9De1riL56/lnsEUy?=
 =?us-ascii?Q?29QyyIgccbAnG3ygYhk5vbjL80gtaDHn9f9+PbTkw0D9NtvAIJm2c0AIJwzc?=
 =?us-ascii?Q?nfg5ZUhabwLfZlZgv/0cTWVimB8zjMmKb06mvh4l3HoAz+H2aOqdTIVEipzV?=
 =?us-ascii?Q?FMEwzZ2HGdi69Uw02cAa1H9JF6oNQIlsxEObVbsBG0+XY6DbiEKGgcapfNay?=
 =?us-ascii?Q?LEAMGAzXOrU4jIOAaWsTEKsbIWn3yAdIFMbru3OGJxu0fA3YzL1zgq9OT7XM?=
 =?us-ascii?Q?tFAKtixcMadBXiFf1u+lY/7Nc1fqdPNQxC87fjQzRdkjTFtbTQ0/jH42Ue/g?=
 =?us-ascii?Q?c1UWVpKh0zxB4dbWX/8VLi34X8Idix9HmY4OMGzs8xlIOIApqF3qZtwI/Vjx?=
 =?us-ascii?Q?2WKecpRSE7FhtnMO8xUIWKHj55B2JrW4NkRQ5c8+YKilrpslAS5D8J41TECZ?=
 =?us-ascii?Q?OBIBmznhlGrjJcih5vIsdmXgpiWpP3+J/QfYMyI9ujRABFUS7bKfl31np19j?=
 =?us-ascii?Q?hKNFiu0h+ym56TcG7W7uuH7HtYykJDrtrtabvf1hWCfogBp/Ym4sLN2jK0T6?=
 =?us-ascii?Q?ly7gXT2xc+imZ+Ev60Y6xcrLSneVnFaXqLZtAxBxWO4HTVXMtoHj/CoHvayW?=
 =?us-ascii?Q?xp7a0Iv2pStbK0lMbEn+JDoIvsWhbaAyMiPnsdJxmXS3AwHD78jdvlM7jaiq?=
 =?us-ascii?Q?1EQWcKeWRssCLYQT8kwg3jKzYUsNKRPh0S+LwMIqfb0IXdNRymFBNs3Hnj3z?=
 =?us-ascii?Q?vnsAb7l20isyNRKUid3624NN0a0EzIHPK2Rk4EeBUEQ1QR+ZGEOrTV1UyeKM?=
 =?us-ascii?Q?oeURoCFEz+OnkzxoOEIK0db9oz1DKvRiOeJ50wIR7ccH7mKqfTLwJzUwVUX3?=
 =?us-ascii?Q?n3lo4sRQwaTsRBaQNcMpKCa8daOu9kJIionh7Ni5bHtVcSn/nwfRxwQ9oWqM?=
 =?us-ascii?Q?EkbJ/Q6S/QKZGx9jUqD5C+fuFIiWFYfkudchVhIgo+MO3myZ/jB1Erb5tojK?=
 =?us-ascii?Q?z9QtR22PnSTu751yfIJvWOrDuNTo4Fs/Ab1IaOy7vLPBTlgpB7wVbO29r95D?=
 =?us-ascii?Q?H8c5fvUO9iguS3KTTfZMxTl3KOYazUpAO0RjYffJ+4YEn3nJt2/2J+DmkJXX?=
 =?us-ascii?Q?NMKJgwP72sdxBl6zKakUUDYQDZESBw/XVl2gaG2QSEaWqLRUcWV1s2pjNz1r?=
 =?us-ascii?Q?Pi0lwM8l5o09e2N8gyUya2DKskRSCZVmyDijjnU4H0QLnjJzLUH8zVDQGvCA?=
 =?us-ascii?Q?GQTnpsJql23efIUAFb3otxcTPlyjfhbe8IKyipGNJ3DpIVFHd4KK4+2skdEt?=
 =?us-ascii?Q?D2emyZkmmtlWNKekxshCVLruCZCT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jQb/ghhQOA/kp8xrTqgKxL2GuFS6m/2Pg1a8BWpwHYHytP/OXqK6EOFY0wI+?=
 =?us-ascii?Q?WM/tbuNBQ8wWnDx5aqanW0T2XVearxX/NagDiDraXwYlE4kxeDyG4yN8KY9Q?=
 =?us-ascii?Q?rNtSy+f2G5qcWuJcpET5HDnHO8JEa4ynt+XV2GBvfLrY9Fn3aE1AQ0w9NvUm?=
 =?us-ascii?Q?wEUdCk1uhY8XL9IpRXC++m3OYaW5uGSE3w8wJaGZ7tZfACg5muJbJ0tHI5LT?=
 =?us-ascii?Q?zh6izyte8mr/BHL21/P2cRhvYTEpHfXynwI53017uSJJkpk7EiUUaJ+ZMUI4?=
 =?us-ascii?Q?BnrBhLs3oQIG949CUn6Bg6gCRevI/NzdQA9pes19UV73qitxRo4oWWjXqxFI?=
 =?us-ascii?Q?h/KK8GwuvqZ612GofLhReMyCgHXDNtqarHZVepx/QG8bvtK2GVgNVALJYeJp?=
 =?us-ascii?Q?ooPRjPg6FY/aGOgatcWRrlPwPEzFmZw+V5OGnlBjg4RQR6+cSsdHP5pcXQwX?=
 =?us-ascii?Q?9+wKXOvKex5zVo7JQheRbj7CeCPrFKTzGDUo1L85TnFqEEZUrZIpXluTXiCy?=
 =?us-ascii?Q?3c9RrGfwv5G5gm0eMDlttAtbvQjry4N/4vxDCayKaNWgmy7a07WtNz5GgGA9?=
 =?us-ascii?Q?0tPqIA8UC4ntzKonDPy4I7XWuavB00Kkri4cdBZQkmCkG5wuHSWOCGGpFvDw?=
 =?us-ascii?Q?HWDzdAOgFJXNWWmX8veF6qI0fHTqAwKedNOxsM8D0Yd8NFVO65EXk7/4DofO?=
 =?us-ascii?Q?aMYvIKa+to2t2pRwDefTP86NknfoNRf5NQcK9VESi5/3Ym3hfXkmrBeUUC/b?=
 =?us-ascii?Q?c2QRUOpL9Qybt7/eeMCoLjjNGBBQ9HGS2c44MXysIAj/tT8y4wLZNP8/vaER?=
 =?us-ascii?Q?7kQEO1Osp924Y2s+bWcGV2a6Ij0hLfg8M7PXCLo/PQDE+pxzKnOXDNsI0kHQ?=
 =?us-ascii?Q?4jox+FzqRgyxMLm3pyNiypxl73jhxuOXFFTkTuJ+r8vKDvDXjXXLP8/egcND?=
 =?us-ascii?Q?4t4c0TXQU/yEu97oDnrKuLfdXZu6HY5H6v3Lv92OC1eBU48V6zp/19UkNBog?=
 =?us-ascii?Q?tMfa+AY5cQmT907LW0bfT9pmp0kRsGGOXgqgmPp3T7yMtYdY5kf0mCiJs9pw?=
 =?us-ascii?Q?6AYLXKj7LO5ooIA+pSyfi6/5L9EuvmDd9/2YmDXTGAqSADDlxUyOCRlP1Upc?=
 =?us-ascii?Q?qrcOk9JvfvZuonCe3IyCaHRR9PafERPFQy0XjBRdTv3yv0hSWqG2G/Y9ALAm?=
 =?us-ascii?Q?QFmTPN+ZHPELjRgNUt2bYKGj7yiQdv47IdWZdhkellpAjnJsB7Vh3kLqMlQ5?=
 =?us-ascii?Q?ouvx7M/LvBfk95qJj5r08oVx1kdExSfy+IEEYO4nqje4gew9UHwVXxb/yMTZ?=
 =?us-ascii?Q?608tjruP8Tid0phH7eh2rLmA48bQ489L9SHY9Si/pRiBTuNE4RC6dopkTuol?=
 =?us-ascii?Q?yrJnh9EHjXdXXZGlnaPjDfyrMBSM5POmF5o8SVcvdg2zpsg508tVXcXCbHOO?=
 =?us-ascii?Q?AGzKgRuIdNnD9R10zAj8SiOhl6hSsQTX5MxmDcOi/SAJn1ujLWWdSariU1J8?=
 =?us-ascii?Q?r3MqBLhpTyIed6E3DNpgfF4Sq2FhPITR5eWgcW7FV8v+k8TDu1hgyGhMznmh?=
 =?us-ascii?Q?COyS/ImhLneSfnQZW+xcNE5WYvF4KWD8gOVwFbB5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fae2ce0-b66c-4862-9cbf-08dcf5418cff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 22:08:26.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XI/HVuEQhDdGts2GeeJjS2OKQi7KYYSj5y+E/nz11BZUpCwSvNosBfparJ62TI0qovIVSQGU5YpW0ghDKbhV3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987

Update clock settings to use the macro IMX_LPCG_CLK_0 instead of the
hardcoded value 0. The first argument of lpcg is indices, not index.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 2afebe523fa9d..531236d83caa4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -230,8 +230,8 @@ &esai0 {
 			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
 			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
 			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
-			<&esai0_lpcg 0>;
-	assigned-clock-parents = <&aud_pll_div0_lpcg 0>;
+			<&esai0_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-parents = <&aud_pll_div0_lpcg IMX_LPCG_CLK_0>;
 	assigned-clock-rates = <0>, <786432000>, <49152000>, <12288000>, <49152000>;
 	pinctrl-0 = <&pinctrl_esai0>;
 	pinctrl-names = "default";
@@ -411,12 +411,12 @@ pca6416: gpio@20 {
 	cs42888: audio-codec@48 {
 		compatible = "cirrus,cs42888";
 		reg = <0x48>;
-		clocks = <&mclkout0_lpcg 0>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "mclk";
 		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
 				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
 				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
-				<&mclkout0_lpcg 0>;
+				<&mclkout0_lpcg IMX_LPCG_CLK_0>;
 		assigned-clock-rates = <786432000>, <49152000>, <12288000>, <12288000>;
 		reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;
 		VA-supply = <&reg_audio>;
-- 
2.34.1


