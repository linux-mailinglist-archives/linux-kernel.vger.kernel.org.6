Return-Path: <linux-kernel+bounces-332879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3A597C039
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38058B219DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6418A932;
	Wed, 18 Sep 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZxCI4yzl"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8121C9878;
	Wed, 18 Sep 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726685682; cv=fail; b=IQEcKFyIj0aE4hVuuyzh0ust/aCE1xvyrNAdLpfulS+NuFak6VXJUzKCCjaQ5YSuEVOUW9Zd27K+e4hlXG5KA/Rjd7+vnBmsgd5e5ASoIDTuJZmopofL/6E/kjfWqbElfXmTIeVz1p6pl6ceCOzSnNomeruEh/I6CSPJvv0AgMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726685682; c=relaxed/simple;
	bh=A5z9/WIhVRbRLG87oggRGrbuQ83SNcFTU500gENPD3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UfksOppyFDnZ1CFOqW5cWRUFYLAQtqlafw7dtAwZ4O2ONcIpm5dthN1RKKiDbCaYqJNKQ4p+Kfk/7TO0hxfj/prxkRxWRAvqVYQHk5B+V94nbmA411MVisYPqBY0yn05qEea6B67KhrjWqg2xtpLkrXS14Gvsc3VzWwQCJgXsXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZxCI4yzl; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB4kFzGMcAyyzMbC+cSfMd3HJ/fzQx8b+LCG+y3UNWGDMK+s/doToXaMjysshomnyui1ELLEM0277QpWtdalqlX5mx3Q/MeEtG9WJHyBRbeoeJvq2psYVs2tldkpap9E/05kEFY236BVb5xCXSXnq54EIlvWdYSGHfj7jn8CkUKiX8V1+jfyfUsB+31oLImCe4EKz06rz+EvNsh1Ht9Tae1qv/k6B2rcpjXdw/tk2Wmyj+5Tf6s/VQm6Tt/qmKjV2jyfl4jOSPY7P0jBAohi1tVtxyBjDzixx6Sa+yQJeNBzAmSmng8q02o8wVRCkjed9bQqQMKGxYt5n+HgOM6Icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDWzrERPdq9hX5kMMwBpXjUieL/6C+NmPeWk233zWMI=;
 b=EixCdclV5N9mqd6FVVAYMgxl88fFoxP5E0pzQU/RWzPVRk90C4awWjOqm4/TwjzFB8M1d1ntEyGH2nsH8XVwdV4jwodDIzxA6X9eYA5ckavOB8IKc1IjNxAoV5/sPT2NSa/bEd6YvFRc2dJqNMBXBvVjvunYbga8t/5kzhRxMKD50hjmRupJKNgjQbSBXAyfT/ogTDduCo1dJERv1AWuih85AsqoVWjVTmRMz2UTqHqXjiz4DPzpaM9gxiK4ZnOisNB5D3VjX4sQ66pr6Wsj3PE71iJmDIM05iR9ZX2yHRglc1delORA6fHtvRslVJFBUuAvPTICrJ7/wmqCuPyLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDWzrERPdq9hX5kMMwBpXjUieL/6C+NmPeWk233zWMI=;
 b=ZxCI4yzlrNiqb0vD7mT3R7tSu1Et0LUR8H2ON/VnH2z5irIaJyOrSRP+B5C2oHZa+5N49b2RxOCIq6VEQf+Hvkm4aXhZG9YPpZG0pbXVvnPNrPE4KpSZftOJ+zJC8wNVwx/XKwKyPq3K+5c8IwnlgvmnE6lO+CISnnFLsLPjiqDDFTGDnKa8PIaEuWeEIuL68Sx3W1A4cRy7u9nrOX+Q8RFGMNmAOYW7fZgTy+zW/z4u1NxhH/w90V0UXJSJjkUxyy+CeV/8KzD7x+D+m5nqf9aO46KZ/itY8UOG86l4ajChk4oFjmDsLo60/W93F0JJ1F5eEdpl/m/KtoVfafx8Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8731.eurprd04.prod.outlook.com (2603:10a6:20b:43e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 18 Sep
 2024 18:54:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 18:54:37 +0000
Date: Wed, 18 Sep 2024 14:54:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: imx8qm: drop dsp node from audio_subsys
 bus
Message-ID: <Zush5Tw9cpZvv+QF@lizhi-Precision-Tower-5810>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-4-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918182117.86221-4-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: e9221e7b-e13d-46b4-e604-08dcd8135824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2iGP46XxyyJP3LbIHp//Eg4QAvpt4KJOSvdihyJpWBtYjfDsrGHDM10vqOWd?=
 =?us-ascii?Q?ePK4vhq0OpiQXUwSgdnQqnCluqo18gejGgBcY0HyB0BDfn4XAo7eptiF6+pW?=
 =?us-ascii?Q?qyDJ4T4dvF93ifSR/L62U3Hi/bQFKA2YHP+7FvNbJqklvNDWk26vbyOjU9ac?=
 =?us-ascii?Q?y0SfMX1ntUapoviXAVEz7lVoqs1o+zbu5UIf6U+51D//cHL9SnoQtZp3Qq/W?=
 =?us-ascii?Q?lNGUWzPoKr3CG+pVUD4GR6/ld1kdPN0nDf2EuCgGwurufDuWteO+7h7vWlAP?=
 =?us-ascii?Q?uUgmfwGKo6gJKzS18ufN/UnTTu4Wyib3RxsN96XbLTtBABRLozuQOyDmAsC6?=
 =?us-ascii?Q?ZYV3/xPUI73wP240DyStGplnUa4DfPGccpbyHom8gBuywhvnPD1ZxdMjejqO?=
 =?us-ascii?Q?O5T+tYlGnbmk5akFHJ4hxiXAkJ/kEPzwIAaMB55HQG5f4DsKzL35dxoxMwIv?=
 =?us-ascii?Q?WnRyqzZrFLZAonzyGAeIwUjMpODIt5fkJpzpU0clCeUVV1j/E/NYctJX7CO9?=
 =?us-ascii?Q?IUeF2JDefAi2q2bJPi78xDfFfTJTwRZK3GE6YLdqICwLQD8xrhCbAS8rrpMx?=
 =?us-ascii?Q?Ye15FNgcUOIz3QX7q+MINFHkA4SHh35WbJ0l5pma+XeP7uobhMjaKq9sXwZy?=
 =?us-ascii?Q?Kpi4Pf46nw84+019OF6Pxr0MM/Bt+Z88mN7fh6rTstE6VzRP3FKDQS/1NKA9?=
 =?us-ascii?Q?nZYIuLBubGHn33Pp/6gOH45gh/UjFVcOYOrsaWZy/F90T2sEJjYOgqznSPKh?=
 =?us-ascii?Q?kgZmjSap4jT+bBHDgLTvzn4xu+hncWZXQsd3p5g3HpZgxpPB4tYocRS2oNp7?=
 =?us-ascii?Q?AwIx58daUj0du3lcKwuCH7RnWEkTgQ0WFWLszDiN9GO1GXfDl6kjglgW5DMV?=
 =?us-ascii?Q?pQOpH2ln/7q5fZg11Uu9sMJIHGrxhAzhe5t/5QLbp2Y1ra9dNWq63uPq5Di7?=
 =?us-ascii?Q?rgHuec3N8rR8eGzFIMXPlviohEIYiDAWNg05KljcL4+yaaOUct3yur+WMk0j?=
 =?us-ascii?Q?ckB10+5hTsRcfeJ3OS+rK13jzV1EShEWEi1DFDF4OpJ0B6K4LWG7DjX2BCTX?=
 =?us-ascii?Q?yxyOwaW3kwAY/Ht0t49wfj/xl8+Dz94x4Zn8Df9jBKscDCvnMPAfCO/DxXjI?=
 =?us-ascii?Q?dksYR8cssykRiKxsz3/Bk8p7FSpgC8cPr4Wiyy5yDmtsm8rNg0liE0pBBvgu?=
 =?us-ascii?Q?U2jEv2g3spGSk8kQonY3zj6q+iHJL1EaGSH9gOqNsAFiTAAqo25VU22OPjkX?=
 =?us-ascii?Q?2OVTKMDhQgltr6MZuyb7XP6nkAFS8UQOvfVYOFvgQVVLaF1hYu2wTh2VIVZi?=
 =?us-ascii?Q?5Yymw9W9NCnvmVy9A/UTRZwvJohQKKUosYDcaOukvKq3SpxRQvN38PcA3yC3?=
 =?us-ascii?Q?79FkKXqpincWsipqbE5FAxo+8hOJkb4bTyxzTJ99KtSqLNzmMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bI/ZqiQheEtULRgp49g++kbyyV2yxNQS2gCUbpQsZ2YwQVho965jln+lWUxL?=
 =?us-ascii?Q?iY/jN1VCaXw8DnCZMJVAR6QX6MX8yA1Sd7vvICs6MzPhXIF6w69JP/C2TtI9?=
 =?us-ascii?Q?nG0oKGXP+CrEUjRa+x6e9hZ3bS3Sn6rA0nGEdPy2vDehv1jLmseT6vbW/a+T?=
 =?us-ascii?Q?nhlOq0Ddaj/BtbNMUJ6J1HWgj9p44Mc78SmCfroUoZ7Kq13i4WswGGafzEtJ?=
 =?us-ascii?Q?FHoY6ZjHHQl5T+v2gAMVmvkN+z7Md8LyYIw4KLqs38mdWC6bsrTiJjxyiTP0?=
 =?us-ascii?Q?1jphcY6B0l1bmb4+o5hV0c525lhGTsfrV69nzbnzTMSKvTD1AjfxgOm2XvOU?=
 =?us-ascii?Q?5NCP447NlVnvnblJDBFdUtDPKw+oobLIolLd9OgcyeDIRlbEjwVS1kphHelt?=
 =?us-ascii?Q?kTzWIF/eArjDOoKmTl5cruEGJYXvgY1xVos0pQVMgepVt/rdMihzJiA3tOGH?=
 =?us-ascii?Q?d19iWO+xwPlVDjqPKdNK8mppYYn6DclW47+3I4XpEmPK4OG13ZsAhWuGCe4V?=
 =?us-ascii?Q?/oW1afN7j8qlc9oW2FH7xVVygWvEoF1GZkzvUGgEhD58u4HpFu6RdD+MkdpE?=
 =?us-ascii?Q?pNmtrfr47xJriobxrxBd/9kEShdRmRWlMilslez0bPwQ6PnhumYzMr5bXOsc?=
 =?us-ascii?Q?DdGZ04eAFUPjT7QeXZJ9a0o7lt7+b/mL3T+K2K5QbpN/3Z5qvKM/9Af+Goib?=
 =?us-ascii?Q?yM97kFAWlYf+LukDNTLFa4rlYjYjJ5oXpcikVSbALQfKUfkRJftvzsdjazZV?=
 =?us-ascii?Q?tDlzYWx50+xroKOjeqpktq8slHY4x0WU3K0eIF5T5P0EeykLiUwsfny09/59?=
 =?us-ascii?Q?MyHhDvhnf85tFo1pyMt68jwCcG0BOSQ8FxBcvGDDbIpFM+wsFb/2U4Q5YR+G?=
 =?us-ascii?Q?r5IoeIowsTgvWkwjYMk7Gnmn9ah8TOAkcbJcHGQnXDTDwQ/5BRjXpY5T2Z63?=
 =?us-ascii?Q?NBBxc0qc7TE2uMwGsIioJ60zAQmUfBKfhs7/if+LaMUFd6bGJ6OxXbgGn1fk?=
 =?us-ascii?Q?9mN3ToabBko0htoaw7CFMlEpT5WFT1LLqWVkNSdetG2o6KTcmh0JaCTy+waf?=
 =?us-ascii?Q?ApGaW0K/88QNkixYnkraXdSHYA+0+JNinP9UKL7S7YxdFU3Bew/ECbQyyYhY?=
 =?us-ascii?Q?wdQd/a0g+nqrRTOlAOgVa1uJzB3kG4RGqWXu8XMVRE9HQEFzBmYz756HmIKO?=
 =?us-ascii?Q?7sLyyu36Ts0uiuOKfmVEIGTPLSMCMq4sNwKT1wO6zU2BX/aJFW3zSu6GMmHP?=
 =?us-ascii?Q?nd2dhKtBBu5+l9KaaNzObm921gVp46DeIRIGE1eIXEdltUy7Fxidtoozbz+t?=
 =?us-ascii?Q?yzWUGqpARcXj7aPxM0SS4IV/N2umKKI4bbrf0cGQLTGqu16+Qj6dodofZ1qG?=
 =?us-ascii?Q?vmdq45akw7Afm+L25n5XZ9dMuJNVVPpzlCtZ64/thphozLpGVEpCwAJ29ZuF?=
 =?us-ascii?Q?ycqQMNHdtblYyi22u0qr6ztgQazZWD4ZNf8HFhQz3nNvN02Rie4Et8PEQQt1?=
 =?us-ascii?Q?eiDX560MMbQKS8OID0RPMoLon+El4nRssOeZeIUlxf6WtgSxs9dBhNo2/b1v?=
 =?us-ascii?Q?FId9F+5NVlN/7/KPtXO43xHsXg/9Q/pZQUyMqaHL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9221e7b-e13d-46b4-e604-08dcd8135824
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 18:54:37.5682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibS0PMUPN+dnPgLC/N++brY93EF4P4lE/owTc027IN9ICx/+ZGDxGzJUcbE0yfyRs12ri7DTNihQjl9JMs55Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8731

On Wed, Sep 18, 2024 at 02:21:15PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> On i.MX8QM, the DSP is in the VPU subsystem, which
> means that using the dsp node from 'imx8-ss-audio.dtsi'
> is wrong as it's placed under the wrong bus. Luckily,
> there's no users for the dsp node so drop it.
>

Fix tag, and wrap at 75 chars.

the 'dsp' node from 'imx8-ss-audio.dtsi' is wrong in i.MX8QM because it is
in the VPU subsystem. So delete it.

Frank

> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index 3ee6e2869e3c..f8b577ebdbef 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -603,3 +603,5 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
>  #include "imx8qm-ss-audio.dtsi"
>  #include "imx8qm-ss-lvds.dtsi"
>  #include "imx8qm-ss-mipi.dtsi"
> +
> +/delete-node/ &dsp;
> --
> 2.34.1
>

