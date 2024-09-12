Return-Path: <linux-kernel+bounces-325913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE2D975FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17713283082
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A65612D760;
	Thu, 12 Sep 2024 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fB8SK/zT"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5F1EB2A;
	Thu, 12 Sep 2024 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111878; cv=fail; b=nXz9MQWrq3cJ4kGMjp0IF6ON+hAxXK837CZMo7PG+66In1SZyVhH3zbtX6RJE5yYmahIsZwtub5BjfexZqozZRn85JlZqi5IP8PNirx3ipCbAuTRAYYrNe91rtQds0VJ+w1tEjgxtKQZ2yD3pliUwUerpIlJVSe7uQpX5wgI0FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111878; c=relaxed/simple;
	bh=CQb8dkT6eUznOJTzgLsZ/mSeiZt43XKBiQjV1eV1eyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mHh3mG4t3eGQ+JquSqs4Jb1GAfuUrURoigx43iDgwdHvCDEiBwNnLVW1TFI9wbazNVZ1KNyPGy6jMRZAXxpsc2i443GkQ70zGBPM/E2DK3s0K1UxVlujSU66gmG4FcJmoxuexXtGWV1GmzwiGyPgBz3wrnGshwq32gdn8Hb1EjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fB8SK/zT; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytk1dvqqIOy9fDYaL/1FpZSXgiQXrfaPUQnz1TowZFu6OlLGSiuuIU+DgkTHpoKeBKFzaE6Ags+u8kYOET/jAEKeDToCaeJR6fSBMA3yZ5S7NzXkZIJZXwu8twE58CkSHqpRQDgGrC63JAehU7IZUgM9g5XLzpNgnTCch9qf2wd1EdouzqPxT4lVOTvFnSh3vfzRwA0dOsRNyq5hvPKKaHce/vHgcT8dPD3k/KzTztDmOYVdmJ5E5lMIew1Rrdyx35Atjp4gVTx+hMRcv5nYNt/KXrjqrdHf8Yc95j6AYh5mxKyPsB8rjX75kU2r4ZsevKRDnNdZG/WdSz9Ox5v8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ja2AoZpptOeG3z/M7SAsG+AOZ1xoChW28Ieybd8vGgo=;
 b=Ot/VIpoNl1DwXMaOPEArlaDdoIk61lKgjGTC++KIUbo1F3LkynGrSbyVYJj//+Q/oxw2LeacDd0aKN6dHS0FPjzxlWVjtWen8KnPv7KM09JjkcxcsmUj/q/nZ1FJ6CEj6bK7YOhT/4unAIYlb+PWZDfhq4xtQcCG2pz4wLGJ4AVRXWknDSSOQLniy4jV9itO2ovMVnvh4wgbWRSMZfH1HPcH5uMmuO0VdOLEcXwX2fg8kp32XU9vU/8oZoItcyHHOnwMPkmg+yWDnKiqaBrqvCbogpFIl09ayqMj1fXw+bEjhNdRcI2DUywc8ZFnJJs7EHDpqMgDd7rdcQoyM19YjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja2AoZpptOeG3z/M7SAsG+AOZ1xoChW28Ieybd8vGgo=;
 b=fB8SK/zT9R0RTTNQJ9sPCHGMhKhV1Jycwl4YHnU9c21EGmqR/n1REIXzf+tT6fSfeTfj6u1wwMSCiq5QUGpfpUZamU41Tf7QwyGX2A7FzSXg2eblD/44GcT6IJ1drTfeFU5I+O1BD9FAxkUGv9HGMM4i9R252s+Fk5h9U+gbeL6YDwWRK1ZBgMZqhn3Wej5iq3v2ioVKRIEfVsm8AO7w9sDLTv4+DYVQ3tgLRtB05PM1FuM77U+QeQHNTTXUiS3FDKUGzIzStgBn4wmfJRqMA/x5A51Y+pga4/Y8UkD3CuOKwfgd6pyfh/8RAbXl7Rvh9OZi7RIuAaWU7PWEcJVRbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10242.eurprd04.prod.outlook.com (2603:10a6:150:1a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 03:31:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 03:31:13 +0000
Date: Wed, 11 Sep 2024 23:31:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 3/3] arm64: dts: imx93-9x9-qsb: Add PDM microphone
 sound card support
Message-ID: <ZuJgedHa7j0Wg7jZ@lizhi-Precision-Tower-5810>
References: <1726106381-1138-1-git-send-email-shengjiu.wang@nxp.com>
 <1726106381-1138-4-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726106381-1138-4-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BYAPR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:74::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10242:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9c362c-8840-467f-5a2f-08dcd2db5a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9nMtUTOP+05iGeWD8kH9T5b4pO6IiRl1YjqCCmIe/HS+InSiSlwyb6Rm+stI?=
 =?us-ascii?Q?pIcztovgJfFdyMlldaYvF3ARrID5GRe0+K0zmxzRfjYhvriux3bI4cYQo43s?=
 =?us-ascii?Q?uxHD5EcX2u7b+JySYywX3wsgceHZ+ksqI1rFe0jgSJt1rYGTxUDSqRR3XGRi?=
 =?us-ascii?Q?amFnmsjrcXsLTRtx4XO0n/TMdj1dEgXjVWc1zjq+6LHSaUgtEa5Pim73y4Bk?=
 =?us-ascii?Q?feEdV0kbE2C4BNNJorRN/hNVGA4wZUjLUCl0pOdgn43aQWhcnvRowle/D2GC?=
 =?us-ascii?Q?6imd7fE6OQgK0v+EXrrBQoIbQQYNrq/IOr6gyWllv0DB/nJkKVZdTElVPiNr?=
 =?us-ascii?Q?zLpHQfAJNDpepvNre9QmgWLWz5STzPKiJyMFDaAzAnAuUeNW4f2yTKqvYKJM?=
 =?us-ascii?Q?f6Io8Sc6c4x7uXSAZ3QZX7gWXqX88bUBSe8HR0+cH9fNM/23af/31hnbEmvC?=
 =?us-ascii?Q?3ndVq+qiCaJf5TiGNOkjHCo8ESFv24j7j7DyE7AgGTCvspc7301flZqljXbS?=
 =?us-ascii?Q?uXJG3OOZxJKXLxTbXERJ1yTvcDSVAWCj9+z+Yk0x7MLX5m7E719Pp9aUstUD?=
 =?us-ascii?Q?1rA+6xmk1tqSyiahpN4lsseb1P7l1VNmTPdMD4M6dC563LSHgNrEF0z5bS1n?=
 =?us-ascii?Q?ffs5mSzaASkgXmq9Kv93gYUsOV3PSWnNaqyIgW1nb59VihQxIfpfyEoGKwjc?=
 =?us-ascii?Q?qvYTPcnG6dzIoC8CjTanzxc6PCNANz7m5p9yyQvrrXLIRqMfh6Suvbo0GSLX?=
 =?us-ascii?Q?Jw4xHkoQuQAF0FlLWifrQt+NbTFjWiXqNP+XFiNWMH4R3OJKGCgvR+FGCUmr?=
 =?us-ascii?Q?Ti5Az3/Oh4kjZm8rMO+t4YLhZ9ppnKZmE79HIpwSjSeVUE8T8jPnOwMgFYeK?=
 =?us-ascii?Q?0IUDn1PIqK6TuspwY0nrO0i1GqaDvoNMQg1792ddq12OmyuJaw2qOqEMVgNa?=
 =?us-ascii?Q?XLGYVaa7APM6HSYEjbn5wmaOTHTVbfy+ytbZmirt2QVEE65Jubu2B6tpefy9?=
 =?us-ascii?Q?eMnkteqAh9CzHPUd3fNobh3OT2LSa4urvev0N/r1R0x3XG6+FSslkN7VeeTd?=
 =?us-ascii?Q?6kftVcjzo3Fx5Rp6nnD79fScVAKX0J3oEC72N5g0HMXqykFKtflMSMZjx2lw?=
 =?us-ascii?Q?IYXOPg5mH59YIYfSw/LivFXh9vToOo2IbVFipqGpC+n+dJ4bMVs2k1RQKw7p?=
 =?us-ascii?Q?R/aZybzeehECgcR+4wrD4qpfUBFvWmpDyfyZ9x1ldkveP7hGG1f5mkH+nfQp?=
 =?us-ascii?Q?pGY3SiTko//xsKBjvTrh9QkXT28TxY4lZVDClIwbJTohRpc0p8KaM6VswQYG?=
 =?us-ascii?Q?ox/Z3l9fGS5rQJZAmInQQmpcixbdjndO3GjxgKWamB4fQah99zXK14tjVSOq?=
 =?us-ascii?Q?dX4sJocDaoax7uU8eohYzwvAmwtU0trNg6r6I275VC3Ub5kxLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gkwRA5rBHzbJAMW3k2lTciLcS5rVCowMrYUfyUGAI9NN38ph0HH5Ia43HZ6q?=
 =?us-ascii?Q?9vaGB2T//qf7aFQIVx84jiBuXeb9OEfkk5OLCVUZlh530WBrBxNElGzwM1M+?=
 =?us-ascii?Q?eHqbgpQAbqnF20yAM/+X/3PpexLWJrIoJfckedqUebN15BT9SHPTJz7JgKWZ?=
 =?us-ascii?Q?r5EhsXQpKFZsCh5j+OFEApLD5g+4YOKskCaseR84/hp4m6RIsz1m5LHLMtgk?=
 =?us-ascii?Q?87dX6+KnGPscpT1LzN30/VUcE9rd/oorY3Vfo7TL15dn0DASwV0GwLJdi2oY?=
 =?us-ascii?Q?jlngEwVAUgBwQT8QJ1qJ2AmrQ/lJzOTLp1NutlfYGprunOGvli1zoQNmng2C?=
 =?us-ascii?Q?Jgmls+O1YUsXsK3e6pt6pfvUw08UYJPaFbalbHq0xNwfvaY88XBPUJA8x6Vj?=
 =?us-ascii?Q?ksLpsmqQtjiwc0s7Xhdl77JRHr8+TJprC83RrthaPK3IILQuFEPV/SkKoTd+?=
 =?us-ascii?Q?n4s5mfh5yCnEGaCOb2Ib9HCCGicoqFT+WCuFIwDGXv4HFUHDEilZy7uskFG5?=
 =?us-ascii?Q?r+UTEakclmY26ZvhTH8WytNRhEmQMa4mF1RQEgl3lTMEXoFTnOtEaFOBiH5h?=
 =?us-ascii?Q?FVI+JqMCX3jzO7oY4K/xVx/8lLH8qZJoGi5eHUT8W4gRoLUJbLK2nA9VioPL?=
 =?us-ascii?Q?Q3rcIQUlR6b6QO7ek/qn1luo91CjR6reMBfIh/AyK+Aj2ckG6UXjot/XHW4H?=
 =?us-ascii?Q?OIU1Z+AZegetmkRQtZm8rRsOE6ETSRC1urR98FbIm1MicdMflUxQYeRnG3qU?=
 =?us-ascii?Q?WsiqB8NHBmVaSIvKZsctaU7cClR3QS9CV/H0iQN4q6XXLUqe5WL4uxBVgBuy?=
 =?us-ascii?Q?Je4V8RHMp4N7ULVeiFZzDBUhtn+rNE2MsClVHscr5i3ysZq6htt0SQnmfREE?=
 =?us-ascii?Q?CnQ+eZ5uSf5fp/LlK659t7JqM060jMlaDxKXiI8yICka01e2y4HVum8uFmjb?=
 =?us-ascii?Q?vfUyOzei0EloG7hynxhtoHBMfa6L1b92bJ8nR24XAf4NDaGtbA6ZDnqCvxml?=
 =?us-ascii?Q?b1ME+mFGaONIryNJVO09N0tZKErksYmVZRG+q2ixkUAcbg3u9x7mHjDY/FZP?=
 =?us-ascii?Q?0nfAVhu/eXVEwF3CAd2UhXAgrunZrBTlDE9w86feL0ElReoN7nIT7CV3wbSh?=
 =?us-ascii?Q?+/rH/GLYBBmBTistCemdhIHbk4mAU6bzfxuCXEE52GdYTAIeULAso9rFF514?=
 =?us-ascii?Q?xLAWoMN8kFZ965Qf9wsSMGRPQaN/iqkUp1TKw5Vf2kv5Ae5QNKckuTeVNAUJ?=
 =?us-ascii?Q?WWYk7I5/RG61g6weC7xfAZANMi6FN/MroadDCkyFlGXxtzHBuUgyInR8wZll?=
 =?us-ascii?Q?KfcP8adwrKh9OHSNIHX9Y6yYIsbqpuobVAyPb/UFD/9Y58dqSIlAbn3SFCJO?=
 =?us-ascii?Q?01roBU0Cr5377lF4pUe1z4HS3a/hCFMXQRXcKCeQlgiRwXWZiTK8je+u9oQI?=
 =?us-ascii?Q?k1pLy++Tyeo30Q9+MRfZtzr9kBeq7iAcugIvpDZtA4T/1+rxeQR+msIchaCa?=
 =?us-ascii?Q?zgF4ZgUk64t9WkfS+/yxUuKCNyB5pSOkx4uyJdJWm3XlkTB4G3BM/jwnfzbb?=
 =?us-ascii?Q?geXZp2carFtTLdFpUziCjYcd4hv0T2OggUzycLIn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9c362c-8840-467f-5a2f-08dcd2db5a0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 03:31:13.2628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moabyCJoYHykfz6Nbck0/Ud88t+XLXHPUTpRq5MC1RWDU7oCtKk5MEMVUKb6vvVtLFJPISrZkiDzYCwcjXuRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10242

On Thu, Sep 12, 2024 at 09:59:41AM +0800, Shengjiu Wang wrote:
> Add PDM micphone sound card support, configure the pinmux.
>
> This sound card supports recording sound from PDM microphone
> and convert the PDM format data to PCM data.

nit: wrap at 75 chars

>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../boot/dts/freescale/imx93-9x9-qsb.dts      | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> index f44300225656..72a0e0290a84 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> @@ -122,6 +122,20 @@ simple-audio-card,codec {
>  		};
>  	};
>
> +	sound-micfil {
> +		compatible = "fsl,imx-audio-card";
> +		model = "micfil-audio";
> +
> +		pri-dai-link {
> +			link-name = "micfil hifi";
> +			format = "i2s";
> +
> +			cpu {
> +				sound-dai = <&micfil>;
> +			};
> +		};
> +	};
> +
>  	sound-wm8962 {
>  		compatible = "fsl,imx-audio-wm8962";
>  		model = "wm8962-audio";
> @@ -271,6 +285,12 @@ exp-sel-hog {
>  			gpios = <22 GPIO_ACTIVE_HIGH>;
>  			output-low;
>  		};
> +
> +		mic-can-sel-hog {
> +			gpio-hog;
> +			gpios = <17 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +		};
>  	};
>
>  	pmic@25 {
> @@ -355,6 +375,15 @@ &lpuart1 { /* console */
>  	status = "okay";
>  };
>
> +&micfil {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pdm>;
> +	assigned-clocks = <&clk IMX93_CLK_PDM>;
> +	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> +	assigned-clock-rates = <49152000>;
> +	status = "okay";
> +};
> +
>  &mu1 {
>  	status = "okay";
>  };
> @@ -468,6 +497,14 @@ MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
>  		>;
>  	};
>
> +	pinctrl_pdm: pdmgrp {
> +		fsl,pins = <
> +			MX93_PAD_PDM_CLK__PDM_CLK			0x31e
> +			MX93_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM00	0x31e
> +			MX93_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM01	0x31e
> +		>;
> +	};
> +
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins = <
>  			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
> --
> 2.34.1
>

