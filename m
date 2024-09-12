Return-Path: <linux-kernel+bounces-325908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FFC975FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE842855A6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6378F1448DC;
	Thu, 12 Sep 2024 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nUe51pSm"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0113D503;
	Thu, 12 Sep 2024 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111737; cv=fail; b=H9ox/XmuNHRip78QQjEAzLAld+tkm+1DjcAEquYwJhtMFBuuzPMsdPeolYnv/7wfB++eK0fsntcL6ow97ec3DglydusAOMhaBD4A1l6w25WKczf2Dw/T3WSjpoVih+s+8w4mdG1O/xHRabVutb1lbUTu9hBcs5WDGiUGW2u3/NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111737; c=relaxed/simple;
	bh=VcZIlBR0hGOJ4xvML40junKKiwwH2bFbyaio3bzB3i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bZ2nYGTHy6jSfzCHu8c0iMeZH1qIm3jx0U6uh66w3YGX9Xp52cabiXEXYH5g1ecdFJilBpyLpflGhJ4v13daFgdfGAw/rlw89LhoFC3sWd6KbGyxxU/v9vm3p3shNs6LTMqVZT7skHjcOBVMZ07ClQ391F+sqNeKHv/WBao0ymc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nUe51pSm; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILx42I3zkNSzby5metuLFiwqHHNhO8zEO7wcEswrqovpmrRvG+SlzDmSK2QkcWnkj+TUq/oXaaQz+/VuR82uOBlqLWvs3zweF7m8rEO/XTa1AK4mqA1mWIhWus7nqCDc0PIK/cVvYSJDtXV76R4pWiTiRqt2zmA66hA+K6v2rFCv/Qis53Zc1hHmM3RmiEoXUzG4IthVgIre9bpeLgSv2UYGanhZWQnTupLonsZ8UiSB6Ev6M4prIzvvdZWPJtgdw83FeE9aA3X3aepWd5j4EeyJ35vE4yd+xYKmUqrp68bfQ9mdEjM3YzF3k7rQC4Fn1JOisX9kYaavrO3sMZr1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t42P3gYaePbSkU4yQwYmg/Oi2deTKfuxJ0uKjvCUXDk=;
 b=CGZkq9Xz8NzsPsVyyNi6XPaFt6foQ0OfX16UmngBwGwbFLg/uKafwSibEiCliYvUlQE+gny/vult28AgBf4GGwDk3PjLk2fa/UHg44SQjodZZNa8svu8GDe+uhheuocAv5v80ZylkwU0nVEFylR5V1r592ng39vX2GPSOa2Em6qq530psPZ7orlePawQycws4RPWVxLWX2y0WSBSV4+HQDhVTgUApECp9jcMCF9M6+QzIJOIgLMU+i48x97nlVbz/xHV9AJoZwUz0Wmarnd8FdTQ2lkFZ1y4O05aBFl5PX3gdPGQ8L3GhS0ZPZRRG4iNHVlvXqGbmgcKSt7Un1Ljew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t42P3gYaePbSkU4yQwYmg/Oi2deTKfuxJ0uKjvCUXDk=;
 b=nUe51pSmssVsClrypibFKzA2jyMVyOxJeEpAKJ4AFXkmJceSm9kjHdOr7gIJli1SeXPVwX6L6ZQ6nVf3hcCcLgyCwVqo/cnIaLHheUYDjlNKKSiVKpzmbi3Oa4uYMukNLDCzRHc6SLPCqo5+E2hPtCc2Fnd8oObVS3+6LZ2W2UfRIj8JgoMro7j9qmXqzy4wPUqvvh0dnLAGEcBahUgammakJ4a8f9DLIs2oK289Alt56aSlC7XdRyjLFq5EcgeyaBF0Zkh2lwxnZTyZdcBg/8mJ08QhubYM0YPnK3FTl9VAZ7eNffZuiEkxW9VF0sxlumEs1fccQe+FAQgSKQmGNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10242.eurprd04.prod.outlook.com (2603:10a6:150:1a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 03:28:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 03:28:50 +0000
Date: Wed, 11 Sep 2024 23:28:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 1/3] arm64: dts: imx93-9x9-qsb: Enable sound-wm8962
 sound card
Message-ID: <ZuJf6j70Bqg8JaO2@lizhi-Precision-Tower-5810>
References: <1726106381-1138-1-git-send-email-shengjiu.wang@nxp.com>
 <1726106381-1138-2-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726106381-1138-2-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10242:EE_
X-MS-Office365-Filtering-Correlation-Id: 2005112a-816e-4724-7c84-08dcd2db0526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U7n6Nwik2zRt3GxuBDlY4+6XgWN0QW34wjhQzguZ0N9FXHjOaAehfV+CjRPJ?=
 =?us-ascii?Q?P8cC1y3/v0vPaXcNVtoOy7j9vzYBCIkxtU+5t4mp6X+urIWrraEgjHnvqQDx?=
 =?us-ascii?Q?twhE06w2XTEvVspVwKhTeCPJDR0XUh/O0GUTbUKFKB3xANkfn/1qv5JIqfui?=
 =?us-ascii?Q?XQTsoXmUorL81gCCA1cHMrWZkLOsR5zSMMRF59O+1j3QnccDAmDk/+4TWoWK?=
 =?us-ascii?Q?VD7lXgqIhRZGn8xWaDqRtkLvaPDWkVwP3ZU6Q1ndwiBbogccayxKrbMI6e3I?=
 =?us-ascii?Q?fTa4bp0pqLv4NG2+Rog+VD7O271hnq1ZdqCXBzBDq3RmEm90AHE1lfoMjWQe?=
 =?us-ascii?Q?223K11zpfD1ChCMR9n1utRQGrosWjg/jfB6pb76mVUYQNmAcUm28/a4Batjy?=
 =?us-ascii?Q?CrdhL9nF0X4xdekNzXl5/J7tXQgLpdbWDB0ZuWLlwg9f/S+n0Bm2GwDtsfoi?=
 =?us-ascii?Q?3ubAVSM6MheSqtEQ0XjFRBVAGrpMvbXHOd2mme6lv3U/nAiqQrT+Kx4zsThH?=
 =?us-ascii?Q?iNGtguq3sxY+ZZZBCl5rXeLrK9MwOGcGOJswFrZX4N6Qbqq9YVAZ9G09EAh4?=
 =?us-ascii?Q?pRtDELCe9N/HboNnarXLmBBwO7456V9vnd/yo85u6CIJTDsB7SezDecOJEaO?=
 =?us-ascii?Q?JCbS4VV7g8r74oopGUDGf42Zg37cMdmRfMGcx7AquMQhwvMmV4tNM4czaMgy?=
 =?us-ascii?Q?vXcjmHQkX3GpgpwoqsaNs0paBWUp6TKyQLoQkAN682+o6s87H4WqU3JmyV+S?=
 =?us-ascii?Q?PWQliDH0xc8XfqjJLMlLkZ6tvpx7LvNHArE9PYOa04B8SspLk2XrUKVCaO96?=
 =?us-ascii?Q?fYJtmW47skgLIU7hdJAnkloFBXRrEAiY8+yrvH2ktqRYNoKXf41L6fX2gvcK?=
 =?us-ascii?Q?vhPMPxe27v9aYqnBKifr5LX9L0c1LCx+cQYlufOzn9bKWyvFNYgYxEujoV79?=
 =?us-ascii?Q?c+HZ0+1nPaYnXXR9D5UsRyj4js+VR7JvibOweEE1UVzdJ5vUb6QIZIZ0moHg?=
 =?us-ascii?Q?zQjXLOioIHK+CnnUJ0kFCEvYLxto9wafaDfj2Xv4k5x2CpN0LnI2gN/KGO4q?=
 =?us-ascii?Q?VJQ/UpGxbU6qp51y+r9ED1liCHnPJv5YBDVsi0qdkiRCoRM21jJlVamYQiEi?=
 =?us-ascii?Q?pfJ62uUDHv5QPVCqqisGusGZbXqiaO33ADNnRmJafuTs8cyA5acDj3zqnB8/?=
 =?us-ascii?Q?bxDOpi8digErhZrTv0HffU7nUKYa8uArpzoyU+V+Nv0eRAokM0P2961Yo4HD?=
 =?us-ascii?Q?dJCkqxqLObpu5VFA/V1B5ZBqHxN/WjDeUXNUOPpLrt+Z23wIIaSNXqBQxRv5?=
 =?us-ascii?Q?/XVClyCMeBCmdeFNJpYBtHZhFP1QMEpnpIjXqtpsW0C2LX6IVA4MXA6Cun3t?=
 =?us-ascii?Q?fuItVcOLjh7VJzVyqt06XK36dxvaQXfOD4mAtz/Gv4mQNvJMEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yoXPdlBoaEBY1D2V3iaLkGgWb0KZvc9FAfnT2P+ArBMVdjfeQAf4rYvyKeFz?=
 =?us-ascii?Q?fspIZZc/+mRcFwARfyUSefQBJjtqS5IXtMxqv6tYg+gRxq1ouIGWrYwYXhdN?=
 =?us-ascii?Q?a62NAB/z9kpyyBlkOmpBxHBoh5wWOOj0kig6TglyUbwHEL1ugWf03t5Si3+6?=
 =?us-ascii?Q?peErZthYEE3BuooxBQPtlgIp51eeSPwuma5pdeGrPDwk61ex9tLAyjfh/pLU?=
 =?us-ascii?Q?wxulNggeq9cUKLLvjSgpN1idCbKsy2goIWKJrR5rDC2x/lz7jocnFHDc/TAy?=
 =?us-ascii?Q?J7ZweYsAGtIRQtsnPjuxfWgc4dQCRGmXMCaBC+mIZRoGJkjw0EDBUOn+FZQm?=
 =?us-ascii?Q?BX9CND6z+iqAmr9Ek+0ZcLZ28ESnyazcVAN30RjKliVMckvCtfFWl55AW7bA?=
 =?us-ascii?Q?1tEJ9DjypKcNM42B3D6lirATuAy94gSjbNaa6ef3i284feeCFCspyPB2fc9n?=
 =?us-ascii?Q?8cy6GjGD4GFofeB+e3nxPbu65KklBGzLwhfLWDaTdG8BN23d6BDgz2JfAPte?=
 =?us-ascii?Q?wFMFW3NCvdajZtrP9f8sEOpMmuhboCre1q9VQ16lH9mCPkVHkOIURL6uLo12?=
 =?us-ascii?Q?+VWEpz98sLGE1RfbfVjWzzH84otmxbDaT0oAORHFqG00QtddQX5ABS9vfUyR?=
 =?us-ascii?Q?CS3tbaJoZ7BeSinIVq/pZlf6XlgO416Fdfd7XSLRuNizpMoa1J4p5+/nadXo?=
 =?us-ascii?Q?/GCDUYRQjXahLKkl0K1yfTPmnuCdKrQMj2t/Hcqvr2cVgH93Y8cituLQfPJP?=
 =?us-ascii?Q?Uv8eEs06EfMTDsq5PWzyFK3uJAyY3FiuWHBmV0yhuI3V+oOF4tBwZbe6v35v?=
 =?us-ascii?Q?jOXgaMNcv4ciIhMuzUDTXRUwdCwg6lngS2r8u0x83iXSR+PZCOqs6gFjgqsM?=
 =?us-ascii?Q?MyjJhpRBV+4fIPxh8htQXPyyBbBYkKyG7TAt4wRIgbvQwchGqG8eq3wC0lfX?=
 =?us-ascii?Q?Xj/69LjxvOQ18Nlyh/eB5bz2sEvUtiAwgcZCHqZZvdKy96cT9d02PZrdZs2p?=
 =?us-ascii?Q?ewo0FQOfAX0X6/xY3rHYwkrgWrXRwervKRd3iPmemkrrCpe50G9QytwSTygz?=
 =?us-ascii?Q?yjZGOECI2dYZya0anA5bU0e6bAHUVRDv8/qmWQ0Z65kbJbDuofMKxNs7Ypn5?=
 =?us-ascii?Q?RugJsFi8enWBFkQ3vWGZUPbIb0okkLO6Yig2LOAPLP0wIStOKnUhSB89linj?=
 =?us-ascii?Q?BJOgJIOqwdKqEZmO0XCpzahmVjUTh87M99AXgN5w7J459VS7xSNidHu4QqOI?=
 =?us-ascii?Q?B8GhtJKlwYUyQpIo1l1vGvoEaMFfVtKGRNZxeJtp5GgYNMjjZAVONdcjAO8q?=
 =?us-ascii?Q?0zkuWSePoaaNKYqh+t6WG0LKbnDtZCnsJ7JGu3MX1DGgkbVQpom6y3x4gW7F?=
 =?us-ascii?Q?iqugJIFgo0yC1rO2AC/okK7eeR+U7x9vUYJbfJDPY+z4v9fW7HaiGfqW957y?=
 =?us-ascii?Q?lgOF02/u20xewSMnTupvkK1IXbeLB8BhD3t/VCa8LZ8A+4jVCn+HE+srWV4l?=
 =?us-ascii?Q?9ZWT/JkcpYK2ReGrMvK2gfj9tMhAEfs9JU7iZ3ukuBGh+YOUCTJcujz1z14K?=
 =?us-ascii?Q?h4Z7KCNbIyUggYlXPFk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2005112a-816e-4724-7c84-08dcd2db0526
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 03:28:50.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi1QtkzuCGpTgmJin9Nhx5Oo2PqW7MzNnnyIjEXc6QuSwbsGQZ/+HP6zISs3GxN04t/MAZTod/8VEuuJez473Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10242

On Thu, Sep 12, 2024 at 09:59:39AM +0800, Shengjiu Wang wrote:
> Add wm8962 sound card which connects to sai3. The connection
> of SAI3 and wm8962 is controlled by PCAL6524HEAZ module, add
> gpio-hog for it.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../boot/dts/freescale/imx93-9x9-qsb.dts      | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> index f8a73612fa05..10f3366b8253 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb.dts
> @@ -68,6 +68,15 @@ reg_vref_1v8: regulator-adc-vref {
>  		regulator-max-microvolt = <1800000>;
>  	};
>
> +	reg_audio_pwr: regulator-audio-pwr {
> +		compatible = "regulator-fixed";
> +		regulator-name = "audio-pwr";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pcal6524 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_rpi_3v3: regulator-rpi {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VDD_RPI_3V3";
> @@ -88,6 +97,22 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		enable-active-high;
>  		off-on-delay-us = <12000>;
>  	};
> +
> +	sound-wm8962 {
> +		compatible = "fsl,imx-audio-wm8962";
> +		model = "wm8962-audio";
> +		audio-cpu = <&sai3>;
> +		audio-codec = <&wm8962>;
> +		hp-det-gpio = <&pcal6524 4 GPIO_ACTIVE_HIGH>;
> +		audio-routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"Ext Spk", "SPKOUTL",
> +			"Ext Spk", "SPKOUTR",
> +			"AMIC", "MICBIAS",
> +			"IN3R", "AMIC",
> +			"IN1R", "AMIC";
> +	};
>  };
>
>  &adc1 {
> @@ -136,6 +161,28 @@ &lpi2c1 {
>  	pinctrl-0 = <&pinctrl_lpi2c1>;
>  	status = "okay";
>
> +	wm8962: codec@1a {
> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		clocks = <&clk IMX93_CLK_SAI3_GATE>;
> +		DCVDD-supply = <&reg_audio_pwr>;
> +		DBVDD-supply = <&reg_audio_pwr>;
> +		AVDD-supply = <&reg_audio_pwr>;
> +		CPVDD-supply = <&reg_audio_pwr>;
> +		MICVDD-supply = <&reg_audio_pwr>;
> +		PLLVDD-supply = <&reg_audio_pwr>;
> +		SPKVDD1-supply = <&reg_audio_pwr>;
> +		SPKVDD2-supply = <&reg_audio_pwr>;
> +		gpio-cfg = <
> +			0x0000 /* 0:Default */
> +			0x0000 /* 1:Default */
> +			0x0000 /* 2:FN_DMICCLK */
> +			0x0000 /* 3:Default */
> +			0x0000 /* 4:FN_DMICCDAT */
> +			0x0000 /* 5:Default */
> +		>;
> +	};
> +
>  	ptn5110: tcpc@50 {
>  		compatible = "nxp,ptn5110", "tcpci";
>  		reg = <0x50>;
> @@ -194,6 +241,12 @@ pcal6524: gpio@22 {
>  		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_pcal6524>;
> +
> +		exp-sel-hog {
> +			gpio-hog;
> +			gpios = <22 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +		};
>  	};
>
>  	pmic@25 {
> @@ -286,6 +339,17 @@ &mu2 {
>  	status = "okay";
>  };
>
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	assigned-clocks = <&clk IMX93_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
> +	assigned-clock-rates = <12288000>;
> +	fsl,sai-mclk-direction-output;
> +	fsl,sai-synchronous-rx;
> +	status = "okay";
> +};
> +
>  &usbotg1 {
>  	dr_mode = "otg";
>  	hnp-disable;
> @@ -443,6 +507,16 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
>  		>;
>  	};
>
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX93_PAD_GPIO_IO12__SAI3_RX_SYNC		0x31e
> +			MX93_PAD_GPIO_IO18__SAI3_RX_BCLK		0x31e
> +			MX93_PAD_GPIO_IO17__SAI3_MCLK			0x31e
> +			MX93_PAD_GPIO_IO19__SAI3_TX_DATA00		0x31e
> +			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00		0x31e
> +		>;
> +	};
> +
>  	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
>  		fsl,pins = <
>  			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> --
> 2.34.1
>

