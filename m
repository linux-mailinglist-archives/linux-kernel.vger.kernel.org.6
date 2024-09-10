Return-Path: <linux-kernel+bounces-323388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E40973CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93958282A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A2119F487;
	Tue, 10 Sep 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BcDSiQ0i"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD031946CD;
	Tue, 10 Sep 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983182; cv=fail; b=jyxsgQQpWr7hWNF4SWeQQ8jBkKeQzOKpJfQPv44tC8Qoj92pfE0HkvYsfwaCfP23uzaqG5sGfcZzocLEYpVlnqYJNmhdWodT8FaOgQVxBm9FyCXE/GAt8wKgJg2VCH4I4O9IzpkQHtyg5mbpHYerNVV9bOIJDmitn867rJPWzbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983182; c=relaxed/simple;
	bh=d8bfeNl8MxFHsYymX2tAx0JoSyc/zVs/ibHxXPxxY+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VqyYJEV6UgtCd4RylX1KXRMFbAOtac0XGNqeDTHSNcg6V6ueP+mx2GlO6+JEtirzEApW42XesBprRjIJqGcc04SvPbE9UtLA0Wf+zANlCW5FMc6KXMMVee+uUX1Iufi6Owij1AOnTljyejqQFx+LaQUECVG5PsL2Vbj3o1OoTpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BcDSiQ0i; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBuQI8EU2Q2C5d7Nl9s1XMZd1UVTZZozU1rgw/FPAPFmnh3iNBH63GzTdR5wXMqtU2cZGKuLzFr4ie0vQw9xT7F7KR4RLbpXBGM/qpdT51h72MYPhecwOuC9Ud5G8L+anpNEu10W9+3pCPF6rtfn1q3PrGND+em2Zh3ikIqn8v6JFOBLtvy17hZFT3hC1kaf9k7CdEpum4Z/yuPtUnLfZgBkGKcBZlcli+i0PC+e/xEo0SbdHQkHeVMsxPr9qEIRjDlRhPOEZ0Jw3/n+n5Yp7gFcinqJNXaShWHuy9iKXdLbAm7odyXXLqjLXPtvtBCkD/dMAmzNLfS1sHMLOzJ37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5cNtFHIdxnm+HNOlbZwtfiwqgoQaQZ+c9XjjXycXFc=;
 b=V7j5IaUv1hhYBcbx7xfWG6PNCSALoFqMHxo5xLq4DCOqbuO7rzYmWaUqLElFr/IQWdVRP3tS+9M9XpYIeftulN1eBxDb4juS42O6krN01kEWrjbSx7L/nhT2HLBVj+MvBrMw6DSbuReyrsu11uwf0tuaM1hjIra75iV36xf07a4DKAFB1f3s3jrTP1PSDG+bOag7+wo7C4axgcZdBjFB30dBoGdymhVhtexFfznxvPIEAjnSdjgbNyCpAueqQRNxlcptN0YDK3zSSp/3cRHeL4kyquPeep4ALNHgTXVrS3WWww25Q84t3Z7Ya/IB1OYPMh/Oj/5M8ZqplXrNoG/xvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5cNtFHIdxnm+HNOlbZwtfiwqgoQaQZ+c9XjjXycXFc=;
 b=BcDSiQ0iGquM8QVdf4R9kEBvBdna60gfZRIphcmy7nK2bLwC6IJtxoEOKZwAtSm3Qq4l0FTXzS3tCIOcSXloXYpiZgBPWk/tv9660CXEvajZNfHH5wHcbTfyPxErjZ4bRngh7jjGkZuMWsyLlrh4BjNrV3Ae4eMYbUKOBU1H38XU45itPMTEZ8qAusnpt2eI3wSnif8S7tiFNgfcm51ikPsuLhgTGnk7+bong/W9lZp1BHnwbBThIfF7JKMGyFnuvowldtuljRv/ANQG51PS974VHNp2XyORVyTDsqjOyFqBu2xzgKvj02nBatuUz4H1pkx4N0HKTpeGWjG0sjkFXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 15:46:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 15:46:16 +0000
Date: Tue, 10 Sep 2024 11:46:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH 3/3] arm64: dts: imx93-9x9-qsb: Add PDM microphone sound
 card support
Message-ID: <ZuBpv1S9VP5NWCUD@lizhi-Precision-Tower-5810>
References: <1725952772-30357-1-git-send-email-shengjiu.wang@nxp.com>
 <1725952772-30357-4-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725952772-30357-4-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BYAPR02CA0062.namprd02.prod.outlook.com
 (2603:10b6:a03:54::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: ed00a2c4-38d6-4506-5849-08dcd1afb4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hcWwD+j8eYxyQN9RYZ9IkpUaggrKFho5in0I4L1+Kb5aG1tsoAL/1hMfBluI?=
 =?us-ascii?Q?VTjLM9OwKAISjbshR8i3LfSu+RZzhP7rDSYeHXm8PA7fIqkf875KIozGM3RJ?=
 =?us-ascii?Q?ouU/ubRL9/KFvgliuef8fZi6ExxZdKWE8s1/mpVPQBVpbobycVyuvknraUDh?=
 =?us-ascii?Q?11dYm4dPHVdA1YTBidZqV5ougV4cxnxJbtg59wABWlNT4WKhiKeLFNQfrNmc?=
 =?us-ascii?Q?IZ/VeK9JLHcH/T4WAdPXYBTo6oRJmqeoJ0wS+uIaiurU1g6CwQfMB22MX+O2?=
 =?us-ascii?Q?RUvfKggJ+niNgPHTplkkvwhpO8/b4H6ombjtlMQgNjpXbZhKqoFKWonZJdB4?=
 =?us-ascii?Q?lpN7KGsltOltEPFeB2nq/ahhUaEtKCfpwmIXix3Nr164DsNpBM4yhgbZMGJI?=
 =?us-ascii?Q?Al/QR8LY0xd+NvD04cIIGOCZxdn4erLGxSe5Ipe4+AYM1keS1K9B6Cblg3gV?=
 =?us-ascii?Q?tA4prUex5T66RswA0I14PJ456Jju3nNFg9NeexpTQV+JAsiqCBpAdUYpWa24?=
 =?us-ascii?Q?+Z4UiCv+x3mZDp6b+mm/ac8REzMLqhoRDCtLUsVo8+lzqI/XJ2CVCPMT3b2X?=
 =?us-ascii?Q?5OiogXaeifcJiQdCu4iVDUmIAOVFzdkrBfkXHmJr0GyUsaJO2/5k3Af6YlM4?=
 =?us-ascii?Q?8EeoU3dNF6BlhrGYqGjk4qd7u2wrwLyf1++HIlrgjt35l9y++IITUClY8ygC?=
 =?us-ascii?Q?p5JIYRnR91LFEaQW34kxny3g31IChBSpb+gUwHZVcUGnE4bMmX3Vk8L9eDDV?=
 =?us-ascii?Q?kcdVWeNeUx+X5sUQjtdqOvlkwpBm7YaUc8AYr9Xey1yEm3HzTGr6x9bpAe41?=
 =?us-ascii?Q?0bJFn3nTISzhglBX9pDF9bCsmaiv0x2eLvliyIdp1sO5AeP2NjBfB7lCRhP4?=
 =?us-ascii?Q?KM2QK5J0zjMAw/gaA2xaz8ZGThBWSIMRwdo1fN/bmif8TGZiqx43Hd9dCS0J?=
 =?us-ascii?Q?O+z8HjfkQjkPXEumchkvuTwXYm69IZXOErRTlQ56fffx/VYh7VMv8NlicmeQ?=
 =?us-ascii?Q?E/XYPSTXtgGywbvfouEbn4VpxP0PDemm83i0hpfZhDQ5/bhF/DvYYX9rAR3G?=
 =?us-ascii?Q?TWOt27jNUTPF9JpEsw6AvacOsjRqsxq7Th488EFY3oBN4NHLhS+y0VIr31Un?=
 =?us-ascii?Q?dOCR1YrpPpcozgbaucRJDLQLyWY0V0XLcypBmXHIqBOi11Ew7h248h+y6cmb?=
 =?us-ascii?Q?nNPIvYTGwwcanLT7AC3y5LFcHNwZyC0fOHXDRymsVPrbck3ciI4ufrqNLk2k?=
 =?us-ascii?Q?aFJrAw9coy0H5Cu4ODfN+7XqVOHier8XXCWvQK5MPF2Zv9CaAP6/Qfhdn65v?=
 =?us-ascii?Q?2I4dArsPEySR9+B3SgZJdUh4uLZ8IGYPMa+Nvs5siRcmzfpky0W9SaptlKnO?=
 =?us-ascii?Q?r8HblaB91XLUtBO0duX2WNoG3/tKYwJmrp7vSDG71NTlJisXAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t9JcvduZNIZkRwojhcs4nJr7NkwIp9dBM3pldaKsx/W0hiYax8HGe/2uJtdU?=
 =?us-ascii?Q?bGhOvc3rFI0NX2EsTQxfvehemdQJ/TpZmYP8vLPyBdJgxL6kCF1Ly1kBNurq?=
 =?us-ascii?Q?Sk8B8nSX+N6B/Ofr4d60u1ajtAP8Ww6dp8Vp1LuGkRPfUwlV3HKhnEAyOYkJ?=
 =?us-ascii?Q?IVxwvFkqAvs+n2b04nOuK9Z0nyeza/WMpjCeF9IrYU7jMUjFyXSpsqwFU+FX?=
 =?us-ascii?Q?cN2GX2N9JTLh1gnkxt7iPYDbRaWtiMTT2Zb7tqK3xrmHFqDDwI8TeVxVt8RN?=
 =?us-ascii?Q?No2aH4zvnNP7v/DuBjLXbJ85jgui6oxtPfNiOVeOsIpezTCDR3SckG/bT2G4?=
 =?us-ascii?Q?jtDW1GJi1pM/lAa6qBt1eWuhdtmTjT6kOXj87LwHQk/lTK08cd3wHBdRkFTt?=
 =?us-ascii?Q?8jfMzKWtpen/QKydr/SfPW8sWIDKckuxGeFtypqKuPsg/ZivYHpp7p+3rp2r?=
 =?us-ascii?Q?P92XJKnFoaX3JZGaIVrIH9EdZQWI01LJGTeBws32ikei36RD6ZswxD+ObwYw?=
 =?us-ascii?Q?YGIy7bEpyYgxCpiRaAoM3wf3ODF90xJesWQ6vHwuQaRR5GFA2VisYUxNN52o?=
 =?us-ascii?Q?KpqizcG8Wch00VvuggU/bR1JxxZRz6ClWJatRUzWuO546iQ3xxTGp31psOqm?=
 =?us-ascii?Q?UQZkegbBX61nnJnBvi3UEPS7J1uKLzfivyj2bT5EQS9yFVHazXolwXQoKsCQ?=
 =?us-ascii?Q?6ExKQVbBnKZzD4J9eZyQV9LSXSKWHf9TXRnqiRIj91wuSXQRNGnngR+ngvhn?=
 =?us-ascii?Q?WGP0VOpWMpgWKZT4kRouOBWmQinU1QkukX50SO1LarbGToTb2OF79kWBzuWD?=
 =?us-ascii?Q?8SwydxclX62lnwnoWI1hNg2G//jBMJNb/YmiHVEApXb25nTSEB1Om6KjUIzs?=
 =?us-ascii?Q?+NJp/BwOdGtDhNdoFUW9FNbm6tQEyn1izC8ga6k79c0gQIe3BfIsiBziMFit?=
 =?us-ascii?Q?ZJ4eYnEjjz9xnQn1aRrGMk8FhOze1t1CDVvyfPsI9l7xtuF7rvsFGMMiLZYS?=
 =?us-ascii?Q?EqAiWYGR0UlMI33qV29c62mPJaQ3cBjB24deVkGIiu3yaC1tLbeqa/Q6huMV?=
 =?us-ascii?Q?Pq1adXIH8Pfp2jaJ16CbCCPse8Q8Ypwu8lljENwZWTdyV9k3dVdtJkt3y0sG?=
 =?us-ascii?Q?/gHVaoRocG83WMa1WQyISmCYaHZUbpAwDYiB6LM+EmcWqWlLlL0COFYsBadc?=
 =?us-ascii?Q?hWw2P+NO5LuOxf/6uBWwA4ruX1OzWFDTNDNNZ7qGbmTb7tHcJkBpPPvKFTQ6?=
 =?us-ascii?Q?xmjxG8t7MILOJvDX2kwUD+mX3lcUNlLd5aa+lxkldcGfjOthU9GbpsylToZe?=
 =?us-ascii?Q?Ibv5axFdWkj3EXK4MllG2B+mO6UAo109dp3kbaCzvRWfiJ7z7jTJcP841YOK?=
 =?us-ascii?Q?cQ8jEYqvtl5TVKI6C3fvT171dOUNyQ9buXlpi5zE/eMuXiyQvSN5TJ8txp81?=
 =?us-ascii?Q?J455BGpO79s4g2KMcYobuUTx0h6xOS4qZqhzySGjSbBIVG203xRQsZZMTViB?=
 =?us-ascii?Q?pyjBWMnWwPxUDg3DxMs3cAjZr3HCAoJO9Rp5Db+zqSEPsDlmzrw9guSo2mL/?=
 =?us-ascii?Q?zO4Hw1AQrE26r8Poc6HUrZUx5VV3eCRPlLWxQndo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed00a2c4-38d6-4506-5849-08dcd1afb4ca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:46:16.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq82QjdfSPmQdyNV4qZgnYpqZ13cf9/xIJnyCN2WoOOgfEFUxrkDVUhhvXnbYQDMqQwaf86jgecraZ8Vez7jXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

On Tue, Sep 10, 2024 at 03:19:32PM +0800, Shengjiu Wang wrote:
> Add PDM micphone sound card support, configure the pinmux.
>
> This sound card supports recording sound from PDM microphone
> and convert the PDM format data to PCM data.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../boot/dts/freescale/imx93-9x9-qsb.dts      | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> index d213a5343803..1340f5462d11 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> @@ -122,6 +122,18 @@ simple-audio-card,codec {
>  		};
>  	};
>
> +	sound-micfil {
> +		compatible = "fsl,imx-audio-card";
> +		model = "micfil-audio";
> +		pri-dai-link {
> +			link-name = "micfil hifi";
> +			format = "i2s";
> +			cpu {
> +				sound-dai = <&micfil>;
> +			};
> +		};
> +	};
> +
>  	sound-wm8962 {
>  		compatible = "fsl,imx-audio-wm8962";
>  		model = "wm8962-audio";
> @@ -266,6 +278,12 @@ pcal6524: gpio@22 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_pcal6524>;
>
> +		mic-can-sel-hog {
> +			gpio-hog;
> +			gpios = <17 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +		};
> +

sort nodename, it should after exp-sel-hog.

>  		exp-sel-hog {
>  			gpio-hog;
>  			gpios = <22 GPIO_ACTIVE_HIGH>;
> @@ -355,6 +373,15 @@ &lpuart1 { /* console */
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
> @@ -535,6 +562,14 @@ MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
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

Does pdmgrp is ordered? look like it should be ahead of USDHC

Frank

>  	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
>  		fsl,pins = <
>  			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
> --
> 2.34.1
>

