Return-Path: <linux-kernel+bounces-510829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE2A32298
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908447A499F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91486207A2C;
	Wed, 12 Feb 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M8II781s"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D6207667;
	Wed, 12 Feb 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353172; cv=fail; b=st6MntKYTKkwqmIDSNtYaNWuCpbpKPFOQp1VujF6iabKNWVkpbyrcttSn8lPoSreN+bg2rbEl9O7NnZ3cKWh6B3+KeopbTW/MhRIWwcRPJlCt2cIa6pJaSgI2tyNs4YjSqpyqORX3yNiMsYmb2/Nf4ehHn8fqfjVolQSTlc5GQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353172; c=relaxed/simple;
	bh=QK/u+FD9FGx45RM3Sv9oVhKCbeo3pB2qUkD4GCOSfC4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eqX8Ih5yAdZL0wZ2EtXFGEw0L21lTVlFmrt7rsmi/lT96TGDNuO1gT8l+Mq7YO/RSYMzvVSRkAh0nK4hlpWS2nqKX7M6ofr+/9gjfRk/vLkFGwfmdwI5sh1E3RFs2gCV6wW0zK7wj4aLP1PJft2eczkMMnowQbXilLH0uKG6lDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M8II781s; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuyckVL9LoLvyc7KdYp8YfKG0b4TXaIHe9GDSQdqDGSsUNv5Z8+FOH494aSkOTIVan0rVtvmER6laK95UEk6E8iFGYm2AcdQ8kevegUuOCEyIAmk+AcXr/cD1zoBoZH8lclXk89f5l6fkOWefToAj/5eCifTavTydGG9dey9FvO+arFv7+pbiYAWHLM8jy8AgyuTJadH/0UfqecwC5fAZUFyVMs3+Gr3/uNabV7ZRf1dapT5QI+n3qNrRnv8fzq7DzPK0Cl+GmjI/a/mf5t7KAgP8rYDk6TTw7rbL/Lq46zi4m2TzjGtPV55iK2oZg7qITW9OOHHDeiVDxDqB4RrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvaYIrzqz8wezTsu86RLuHKnSa73YX3NzKyeBKRn+gE=;
 b=gohZSAX06s+V289UQDsDW9i6pkZ8c9YoE3jbw22lc8blj68O99tzPhAjfHsbmlqja/VJCYOssjnpfWzgy13g5tMDAfJ2T8txjAksQSvSt/vCjG0TMnVMAsz1tte85WgddvG8VnzPNPzH87KzR3+JzmuDRDS64OpHSbsBGqEVG1s4WsDZ5xV00h51t2BCiG/WZhODVmb7tdajJNTYeTS+yF4iY8PslHNjmghhR1C61g73TJNpzohA1kBnNSIBK00gpq3qA/Za69QnQ/VUvi2h5hp7/W3HPbMgU4cx76nHk/JYZ2kLgbIMgH3IwhYJLRMdkQDZLo6QBJBlOovnVZ+iQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvaYIrzqz8wezTsu86RLuHKnSa73YX3NzKyeBKRn+gE=;
 b=M8II781sYWfJF5Ky00LhL+3a3Y9XMo9vgarooTjSKKK+9ZmO/HZvZkLeqs7ji378CCUjNebhkeFrqmT8rZBQvwY4sD9vaDD+IUWpfHnkKAIisOsRF0PMd+PQKocOXRaxYFn9rxPrVKmk6czYH9VeJvQe0EIRcpIlgFD1dY34kGT1cOCsaaADdo4YHjWaDiBnXCDNH8VSxOXKmZMnipec/yTDP9SEXhkLNKUd/BGSvPfnEUcY49tkGcw8dUjVzGN0u7Tn7UbiBdC18DbWLKSM2CtgUm1mzdPrTHTD2Vu0ihjfLF+Xm1rGxS96a/Pqo4z1lCOPtifeRxrhhwGeIZMCTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 09:39:27 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%3]) with mapi id 15.20.8445.011; Wed, 12 Feb 2025
 09:39:27 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: imx-audmix: release cpu_mclk clock at failure
Date: Wed, 12 Feb 2025 17:38:16 +0800
Message-Id: <20250212093816.1857188-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM9PR04MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f61e07a-54aa-46d0-ac0c-08dd4b492474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/LAM7Ef6zEV3d9gZzszfHlAUqwMEeOUDsQB046EZlqulEYorg51bOyYmpNgw?=
 =?us-ascii?Q?l0ZAOWpdu/c0VYLODuoHENVdRHzHuqRNX1ftGKVFymtNvUrqo08MKOwE+ETX?=
 =?us-ascii?Q?Qi5CqBgvhMw7fxR0jDa5Nd+GBImfjbGhyiouvHID6db9JgBjpIrqISdDBdeV?=
 =?us-ascii?Q?MNEs4qIlQ4/vWkOkop2XZ+1jyCIta8WwVGofgkLROlllz4a0yoB3Bo3xIuXG?=
 =?us-ascii?Q?qVfgocoPFj5MWZ/sSXsTvIHs4BfAuZ0pjo5mEuVYuVdralp/DCPUkGzkz4zZ?=
 =?us-ascii?Q?NgFIpzRTADXv1fdsAC1/westeZJMQ27/gdGdZxfIrspOxoba/1TZ6UUBQ6jJ?=
 =?us-ascii?Q?1Aue+mubpu/yH5Qm8Crct3SI66Mjk8MYNGbYmZFP1GzuNhgAHgkx532aq3Nk?=
 =?us-ascii?Q?hAiKDSWfhboHveJkSyBt9Zpxyf7YF13sU4EW/fw9Ba0q7XGfUFfGK4YXAI2S?=
 =?us-ascii?Q?Q+RTDzgrJxlKSj0PU87BE8uZwD+wMZD0z/uA0z8S6SaoGQ3EpyO6rzWxCpcw?=
 =?us-ascii?Q?ciwP1A6pDxf9T92+FPuVw5eA52SQqGihGKb9IA4yiEJfLFryBCu9AQrGRFJ1?=
 =?us-ascii?Q?85KyQMGlcSMjrtjYOd7nWT7vz0HS+kajhzLBrd5qpMtHw+pGxCaoh40AMfKV?=
 =?us-ascii?Q?4YoSZtphVTvICfXKd6QuLaC7F9me7lsQZt+7fRRAagtvcaxECDyPPuNyfT47?=
 =?us-ascii?Q?XVn4PngIzwRfxBIHeBBS7YikAifxgJblqSk85ReGYFDiWXlb8/LHbP3mIwg/?=
 =?us-ascii?Q?OLYuOgR8dR6mJ+/e4OLf3VMZXlC6/5+mQqY5HuqeLFs5GPdzscMMS0rgdHR3?=
 =?us-ascii?Q?6Buj+n9+fOg7jQ4xnplYzWjJQyUiTOdpATtcZtZ+nrCheDcQ2uomGd3QPR62?=
 =?us-ascii?Q?k2no8ESvH+G4z2PcLR3E6FAFy1qt8QSB6EumV5kpsm8fZCRmuTe7qGt0KPyy?=
 =?us-ascii?Q?pgD9gEiexAuRQ2JQ+DR9p+maGOWI6drmx3PoMQBvYYh0zrwAy8IWdvo2L9E0?=
 =?us-ascii?Q?oyOE4QVIBL2KgC7X6Wug1/zu0gBLaP/FR326qIB5LxBzLoUXE4EEF+bmk9vp?=
 =?us-ascii?Q?mm2ZNgldEfJpUMyPzIgNGdM6EdqGeOxW8H/w3Pf40k9HOILC/lvsVBOwp1Xe?=
 =?us-ascii?Q?cRu6L7Qd4jAk/Un10ihj5W25Uacbl7H5mjNIYMjEVq2w48pTIB2sNV5a5Yid?=
 =?us-ascii?Q?QY9sH6foGZBFK2inQagxYOPVv+c/oubLISO0JsiIZybm07Nib9Hocu4qH8xG?=
 =?us-ascii?Q?VhaRdNmb/c+1HxCVK31utvi7Q7p7LN7wkzhM1qST/S/WM2RERn4zaDW/d+MY?=
 =?us-ascii?Q?hC23ys0UpBsmif/xxRL/Hl95wXBdEsKP09og4otxXnAu+ZlzQTO0vnk9g0RD?=
 =?us-ascii?Q?6d88GtIUOaGqAs+91hav4H69VovR56rEz26P+fzIEZ5qDuTk2eZ2V3tslNiX?=
 =?us-ascii?Q?+5CheiAvrOR8Cnafo3iC1ripQNyPbRzNiyUQgyz5IuIkPRiXu116bQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZJCcynMgKfJ6r2ksRpyVTYTqF5AO1JNRZsgQhqOxv6y0E7dVFfpC0QKdpE3?=
 =?us-ascii?Q?pDtvr7HxnLjxOa9FyG6dWZO8GBx576g7ROPMOyIZPs7S8LP8fdZw0rK8VqG1?=
 =?us-ascii?Q?4jVQc1+hm1PwI8dZtpJnL5WX2pGXSDvgEJwQtgzA7STMi3aBVoszCn3bQluF?=
 =?us-ascii?Q?RtO5CszQb3UDeqFZzw3Cb/sQOZcIe/YPOnnyDKipff1eNLzlrv2JwgPKuTDh?=
 =?us-ascii?Q?HO6Dnm9cS3YXTe+moGA84XIz+2yPH0XuJbJnxt/Wr0PYC3y/h04/adkujyi5?=
 =?us-ascii?Q?Vzb06hzfrX3f//CQ5tr/+ehbbWME7Te+d8CS4jdjXnpJrrJLQ/UBehbeA/MT?=
 =?us-ascii?Q?MUPvfoeRUsEd82Ywhls1Lsy4LVZmj1OESXLjn67RzyH1TA7cK7hSQ+PQjusI?=
 =?us-ascii?Q?fCtvHb7fS+OFUeW9h6nCe20xbQmrcFFZXBI8rHYBLiRponPN8fUuJnOu8X8k?=
 =?us-ascii?Q?DMcVFg1IucsUaiVdLZeZczG4xwOy6w/pB5tl3lCnxj1vZ2u2cGFsZEgH6/xO?=
 =?us-ascii?Q?WuGRghHiIts5Ar0fT+vUP2nB00GiGrjDSHLx4fG1Hk2b4ptxuh7KrYjgIory?=
 =?us-ascii?Q?pwBP4wRlGu/Auoi6JYUgs7A+M/amxMhAOljxgz7YBUUiGkEkUeXRJ1HwyTdf?=
 =?us-ascii?Q?y0txMrZDAK/Ko1nytrJFvOx0qUippEtna1oslgiUQy0tOPPeE6sjPb8TZ6ws?=
 =?us-ascii?Q?BRpfOADSHTvkRQz9k3XCEWTPfpMpEJMmPCVx/YFccaN+WyL7o0TNYaWsiWOn?=
 =?us-ascii?Q?z6Nt3wZoW9UY1ulQKjdUE+O6RTZDildQeeEOmk+KNova+rPii1V0BgUjR9UM?=
 =?us-ascii?Q?HwqdEy8q/z43kc5pRgo/1kg/rPRpMv3zYxkI0X1XpuRft2a08SyejYTQIsQ7?=
 =?us-ascii?Q?2zZxqhtwF5j1X6mmdrVkkcVSuXsUf2Nyunywvk92yQqXPtVyyJaRvTQBTfMj?=
 =?us-ascii?Q?3CyOWJn5yDUnrZaOSXlz/fPgtFpecFmVYppYp7cQ2yfHFxlQvUXfkyuq3blZ?=
 =?us-ascii?Q?1L8AToOqSr6Jst/CCkZsrwdlWmOCttARh8NmCqfQGgGpLGl5mrgPqAGBmsJC?=
 =?us-ascii?Q?oz95HaN9dOpT0XzCzpUE3ehUx3HVRUXhvJAPAItR9/A8wBi8ZNGjuo5kPOMK?=
 =?us-ascii?Q?f+DYtNMJtcq3Z7bB3KeTiDU/gLwOUXM3pYbcZAWktFEkYfj2QN/R3tof5+76?=
 =?us-ascii?Q?RfK/mg8kUffJpS0Vh3g+G54CVBPv5oBp+AxfhLH2Lhq1rOI7b0zFruV+IW9f?=
 =?us-ascii?Q?1Cn6qqFMgcgzalgrolU76+tO8ywSvwJPJBi2UIyPtKl5OIl68qzxQQTGwKr6?=
 =?us-ascii?Q?rCd9af8AyfMGOGFMDKRf/11iBGkZBYZaqJXfQaiCk4G+PvfFfU9VqDPt7xev?=
 =?us-ascii?Q?RGZTwLivj4LIlniMKBtlexZ+Kgkbg24DujihY+8uNHWnXUdgbCUMHI/1M0KJ?=
 =?us-ascii?Q?r8SocGpFOl7IuZPsE7szNkADPbJr1GO+DofJph4c2PU5DLvrY9mVOAY+eBmx?=
 =?us-ascii?Q?weCwCIKYfpIsa545FB0+275N+9I2tGF9IaaMHCFM2duS+hJveDFLySLj+n/n?=
 =?us-ascii?Q?1tKWNBetKh8HLdOklFdCEpLgWRzHx/WgSAln01ad?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f61e07a-54aa-46d0-ac0c-08dd4b492474
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 09:39:27.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoXa77yp5bEXAei1wpiOoclGFxvy+ZfGMQh/Vb5v6nFhA7jtLyqU2FFN9MRoLPHURQEU3bv6B8786oE6+pnvNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649

When defer probe happens, there may be below error:

platform 59820000.sai: Resources present before probing

The cpu_mclk clock is from the cpu dai device, if it is
not released, then the cpu dai device probe will fail
for the second time.

Fixes: b86ef5367761 ("ASoC: fsl: Add Audio Mixer machine driver")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/imx-audmix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 231400661c90..1b16470b2f7c 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -348,6 +348,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &priv->card);
 	if (ret) {
+		devm_clk_put(&cpu_pdev->dev, priv->cpu_mclk);
 		dev_err(&pdev->dev, "snd_soc_register_card failed\n");
 		return ret;
 	}
-- 
2.34.1


