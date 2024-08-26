Return-Path: <linux-kernel+bounces-302321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6868795FC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F493283251
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5667A19D07D;
	Mon, 26 Aug 2024 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="my/pE9/o"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17A119D06A;
	Mon, 26 Aug 2024 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710512; cv=fail; b=lndLP/UFqoj0e/NAuqS3ZWxk/GCFs0jqmhB0DH9S2jwqqgZmzv35Jx3gmiOztooWzCnWS9OV2u5jqSFqhJRHkmf2AaYYX/L9s77KZplrGkNoRDUojLhOx3y2yYrPGk8phRE6DX6qaSHj3hDyxp4uuteR+ZlIh6dLEP7NThYvQDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710512; c=relaxed/simple;
	bh=4Wlw/wcHdGpLYwY+ifwzso5qSjN1NIghXVHHUUeMAzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qeVtMcwqhZxrrsx7HvldNZN++Ptg8tP+nh9z2A/R5V9R6sk1oLiH43duzCeTiRGyHWOQB6RzzvTyC0s/NrvJTpD3uZriX2bTuYZDB9v3PDk2Fi5bEl09HPA46MAy39cYhS6CbacphRRkVPTjmFB1RXR+a61qK3qzjrj6/e1xYpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=my/pE9/o; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jjQ+iN63S765BTvG2IbFEHynXjbutPEk/pQvYsM2J1P4h9H/Xk87+E9j1zmiVTEfer5WTrqxSzGSJxc2uX9zE1dDdhQ7od3xwIRBP9+JtyTyxS6QKeGBIAgNRc5DCV87amF+/5I3JB/W6+V2iJCCzbXdEALd1jBRnGCX5nX87kBt0Z1QsaRkNdp6qS+QEqhZpELdmnSCGVuvL8zZcS5iF0a4lJh56b+WYhljF/HGddGEsF7LrlJ2jGvwlXY7IpcsnwqeSHF3eOtwHbFA2oUe05Hl2nxRiGBPnH4oxr0+bD/Pkse7PGuwjInQIbBSm+oDii7jDypJqSprLTbcfNh3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gsp00/QqLgPn2DDNGVXT9dEp0STg+SRFvtEOH4WgmCc=;
 b=LWt22h5SsU/S5ST0WaVCB5KakHzpWmNVSEyBTh5J07OmyCYJC8wcKG2kldT0A9rDHLIS3HRfuneOK3AXT6v6Bo+T0501G7R85tay07/ddlHWAD8TT4rQ6+K5uRh9NNKNEAq9o/ntHHA16rTZKP2MdvyhLLxr5RY34Ka/bXqGaIsQiolDiRJzXo/Fs7eK1T1XYuMSQf8cHh70pXyjzV4pcaJPsx1wydLcJJfal10JDPr08tPu9YV1mmEM+qtWwfzuTtZuMCYEn1Mk7dUlH1yI8Sqh7SUUHXMpylG+f61M+0ObDblr+6RHNzuRdDFgd1ftGN/fqkLSeFG3RVX4byzy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gsp00/QqLgPn2DDNGVXT9dEp0STg+SRFvtEOH4WgmCc=;
 b=my/pE9/ob1/Cv5thy63biOTeNPdbx04MUSThLR/pm35j3WysIkQHWhqrMKfpMozrOgNj6xWjY7/+5GaweO3uDSvs6+Zw+2Lht3d44Q+Qk9SKaOqjDLgRP44iNaW3UyxY8On6LzGdECZ1D4SeMuWVjrC0nnjVfmqFeZ9sECqDKbk4bCG07gpHUn833iwTwcawKmcmGRCqwRjJ+tNikbIL2nNp7xEAQPEq6hXqYhtWU2TVP4Wxe5XzgORIAAWGiOfaX5m3G5FxA9JjHeINA0nuaHaRJ2UHFS2WDVKAgAvxxWkSfUO/tFB9VEzQ5gKVGlzz47pyloaa8KStpcXKbGjtbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 22:15:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 22:15:06 +0000
Date: Mon, 26 Aug 2024 18:14:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 01/10] arm64: dts: colibri-imx8x: Add usb support
Message-ID: <Zsz+YjOyGoReEqUm@lizhi-Precision-Tower-5810>
References: <20240826215922.13225-1-francesco@dolcini.it>
 <20240826215922.13225-2-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826215922.13225-2-francesco@dolcini.it>
X-ClientProxiedBy: BYAPR07CA0105.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: de39782e-0d58-4044-3599-08dcc61c8aaf
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?0qd8UCDS8+jTI/a0byb41fVM1riEzR2ve3QRc+QVEUAghV3RODz9GP00utdY?=
 =?us-ascii?Q?VMoZ0GbQeTTBrYCiOM3j5rNFPgCUw/x0FnWb7k7ah8Wdn8WG47CaKXhdMSHa?=
 =?us-ascii?Q?QDZNZ+a/h1UUJiLT32fEcXM4zzmdZIdKCZtPOhdeictIxzoDFdu3dPOxnhXl?=
 =?us-ascii?Q?5OON0y6mjxgBamJ8t5/Mo7GGQ0AlBDEvuolng/9FFGKEGtCDu/8HJJW/d+4r?=
 =?us-ascii?Q?C3tmbTT4kaqViyeo5ImVA24eQcrYyPsUUU6MGvv+BdiyYxmAHTmMu+eRuEbX?=
 =?us-ascii?Q?olswYfJtSAjAjpb2cpJw+Nd+nfyI5CQP9gMPtC2BkznIQFUQQKguchNtbzAN?=
 =?us-ascii?Q?CNyu7OqS2RLdyYPOiAx2qbcdhOZN7hoPrAiYteW/go3xCoQafFMW3YWQhTtg?=
 =?us-ascii?Q?KbjFs47rfQUBZqKxZ77V5dL/E5w/gCWnDzFx6hCeorTERIrx6YZyJsB5vNrR?=
 =?us-ascii?Q?5Sxpg3XG0jc6u1lwHnFwPiX0b3YfgBUeTqVyXgoqnh1xPNnErbPDgctOzVet?=
 =?us-ascii?Q?zOx2X5hImHm1Ml5oRNv2fLdRbfWlhNoflO+s8CL/FhTKP8sYeVCrqOlBmHVC?=
 =?us-ascii?Q?dDxlUvnieAJEnyWBsEQr9qxfy43D0dMzODzTQiefHKS0oGqKqvCUQ3ssO1iR?=
 =?us-ascii?Q?+j9Cvl7VffmhzzDC5Ps2Jy7Sayt2HzS6nnyZLyWtheWymqnKhyNerOYImHPe?=
 =?us-ascii?Q?1DV6tSr+VPcZpOwjTLhhINKOhFk+dLqtt1IDgHfU6ixVDY2539WtZrQoEqwH?=
 =?us-ascii?Q?wbdVtSBlWx8fSGEbMyQci4OClWwqLqfUPIOrplnt5HISX7AYvgTi8CscER/8?=
 =?us-ascii?Q?1QIgEQ1DQ6H6WtPN8M1zRKa02IDWueuRMxj0r/wV8aJX5PlvDOZ64NkY8pi7?=
 =?us-ascii?Q?H0mmMF5JwQyRfFPwm4P2grkIuxnN5+kBQGK5ZBExG3qvJB+fpvBd0jU5WBlV?=
 =?us-ascii?Q?mPqQMPNTuWeyr7+qQywDF9d/L03sW8GABibzG/248LcxsPBwUe7jbbleYeyq?=
 =?us-ascii?Q?KYrRzrvzF7RmRLRm6vYf/zzxg3DhCRb95kut3BMrq+A1OB7X2bZVRYzo94Bz?=
 =?us-ascii?Q?DVU8nd6ynfady0zJjtwBPvN6ss3A2objRMbugAlA7fO2tLTfzmwc1jjvrZbe?=
 =?us-ascii?Q?fvlItHsdocaNxYVOpftxb6vSZHFTf6CAkwZ96VooEMPEerI7Hwrvq++qZ0O1?=
 =?us-ascii?Q?ObhVbKQjSgRcdDtlz7HQOq+dUyye1JCA5tuPwChQZpfZFDLctqBDB76HtKae?=
 =?us-ascii?Q?v8PVlLVri62pzfJeEzptQIt+RjA8gw39RPxFhziN19gig+1iOwRYcI9CTcla?=
 =?us-ascii?Q?MSUHLWlI7yMKYJfzn10xjumYRTOuquwzciY1ZK3fYowgRPQyhu5RnUR63gbV?=
 =?us-ascii?Q?TA5QHxU=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?FR8W5fecZ6mQpYGD22ud0ub6/I85g7JMvrYlzEtw+6XoE+GSp1PKvJrUcLiP?=
 =?us-ascii?Q?EDdbG1mmVLsWr/J+sjzMwe+5jXRX7YEfBFhEFdBlPWw6pJJNYoCnvpydiC7/?=
 =?us-ascii?Q?gQvEIWX3wnBO7Pps0kI296KY6pTEN894aPE7gUgA66+T1z24II1O0DPRlUzy?=
 =?us-ascii?Q?kEwSxexh+b9u6VP1rLXDUPbmQlnOb7/6zaCqS/75GyyWgv6j25OqtRnmFNb6?=
 =?us-ascii?Q?RmGduQx/85ro67pLIOeXSVSRp1NJt6LO202dkR7av4kgVzwpnDwlQUbnsRJ3?=
 =?us-ascii?Q?xUS95kawmdpECakBi1ajqBRd0j7xNxWeKO9avM7PLPnHRfMqSqF1wlmuE9eS?=
 =?us-ascii?Q?9Lr4LKh521x6qSk9RFxTb+eGNbYfkUnEYk5l4VlfvBPJaxaAPCwoyZ2rIh14?=
 =?us-ascii?Q?f4iKJPM7Vo97m+F3758tOlv9KIZoH5fEvNAY9SWhMgGLDdiLJN+lH0xoknpP?=
 =?us-ascii?Q?d2gQ50W08+pH+mKyvLV2afaZAShK/+SDy6mlzBILdE2lLbiUldiAgKh8iYtP?=
 =?us-ascii?Q?NqpGJ+ZeTv1mhFCjznNx1N4GSGXeAEiFBEZqC8UabOscCJhMAgThkW563rmk?=
 =?us-ascii?Q?s5TyxOItlNvcBCcIyLb3pHY/4hSw9ag6BPnXW2O9Rs13KPUkNOuXwjkUm6aI?=
 =?us-ascii?Q?TdBK3eAOA9Bd40x6ptXiZL19zqJisgitsJm3hQBTF28Cee3bMszeiemYehLT?=
 =?us-ascii?Q?f7oXw1H9bLPItNeimakT/+8h/i+z1o2jm2idGw4O9i6p4wAJUI5Vb49R2c/8?=
 =?us-ascii?Q?m6fPgjyiFrkWNEky+bpyUeiRrY1Hfdei8c3wtCuKN7nHTX17DIUpoqkIWPFp?=
 =?us-ascii?Q?0vxL/rKeLKuc7a+SLIBwKiAGSW/dTE3Y2nFNmoLhTFOo++uUZSO9aHj9IHgR?=
 =?us-ascii?Q?8Dz0ivY6EE0mxE/nXS1x9bvNNXSqaisEayWYErHVhSg19kFjEwEH1Qo6z+Qd?=
 =?us-ascii?Q?XwcvM2BRrwre+BjQiSsNoJoO2t3sbW8EsCD9MSOC4ncqTqxuSIfmBtHLWUK3?=
 =?us-ascii?Q?mgmHvEMyC4yzD0u6mNK+zac3Dbm+zNLaIr+Apl0iGyHWxmdBl/ct4pD070S/?=
 =?us-ascii?Q?sZSQimrbDIXdRewHJHJ0NNyG80lzDZWZSAfnLM69Bwh4xWN/hrq91jnmjvHd?=
 =?us-ascii?Q?jcSD124Prhzt9P+yu1pYszNaZKaDzDGeXueXnVy2SIMqSgS/cQJbgtpjAhph?=
 =?us-ascii?Q?yQRnUOzr/KUHVd/ETlUyBEpX29S0VohrJ7sez6HxjSo6wQmsxJcrPuN0uq9v?=
 =?us-ascii?Q?J2hEwPbmJmAEAGh1O4fMxQF2KsoYzshm2Q8TXRkl6qtILnvcTN5OQxKLSKyX?=
 =?us-ascii?Q?1F8g7YxS5+xXF5tetEeLFSIp8vdGvjC3CQP0lonm333lcL6aVlIbQvc+vaFP?=
 =?us-ascii?Q?LwtbUJiTd4iKs47wvh0Tbt4Jwb78anBFhkRZMgHZmfwSxExOUqvT0k1/AW9u?=
 =?us-ascii?Q?RJHp2T0C2Bfqvc2j0D3Zoebpt6ybLXoXW/0uli5i/roRJcfAvBPa5LqlVXT5?=
 =?us-ascii?Q?fTQ9Yu4rZ8mOnZsjtTD2Rt3a8stgbmRqtjs+jif5ogIwyZvaPzul4RuNkjw1?=
 =?us-ascii?Q?3LPSSnCaNC2S2CZR/GZIJQv15a+phiD6OXLrueGx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de39782e-0d58-4044-3599-08dcc61c8aaf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 22:15:06.9104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgW4hO+LZb14GR3MtzXsiI5bzwZ1d6EkAYUJk0jD9kDr/y/avYQ2P0ro46j8JKs6LqcDnlgrnDU6BG+sumUmkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762

On Mon, Aug 26, 2024 at 11:59:13PM +0200, Francesco Dolcini wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> Add USB HOST and OTG support to Colibri-iMX8X carrier boards.
>
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../dts/freescale/imx8x-colibri-aster.dtsi    | 26 +++++++++++++
>  .../dts/freescale/imx8x-colibri-eval-v3.dtsi  | 26 +++++++++++++
>  .../dts/freescale/imx8x-colibri-iris.dtsi     | 26 +++++++++++++
>  .../boot/dts/freescale/imx8x-colibri.dtsi     | 37 +++++++++++++++++--
>  4 files changed, 111 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
> index bc659066e19a..c02dfdd75b60 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
> @@ -7,6 +7,10 @@ &colibri_gpio_keys {
>  	status = "okay";
>  };
>
> +&extcon_usbc_det {
> +	status = "okay";
> +};
> +
>  /* Colibri Ethernet */
>  &fec1 {
>  	status = "okay";
> @@ -38,6 +42,28 @@ &lpuart3 {
>  	status = "okay";
>  };
>
> +/* USB PHY for usbotg3 */
> +&usb3_phy {
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	status = "okay";
> +};
> +
> +&usbotg3 {
> +	status = "okay";
> +};
> +
> +&usbotg3_cdns3 {
> +	status = "okay";
> +};
> +
> +/* USB PHY for usbotg1 */
> +&usbphy1 {
> +	status = "okay";
> +};
> +
>  /* Colibri SDCard */
>  &usdhc2 {
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
> index 9af769ab8ceb..91de84772e1c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
> @@ -23,6 +23,10 @@ &colibri_gpio_keys {
>  	status = "okay";
>  };
>
> +&extcon_usbc_det {
> +	status = "okay";
> +};
> +
>  &i2c1 {
>  	status = "okay";
>
> @@ -90,6 +94,28 @@ &fec1 {
>  	status = "okay";
>  };
>
> +/* USB PHY for usbotg3 */
> +&usb3_phy {
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	status = "okay";
> +};
> +
> +&usbotg3 {
> +	status = "okay";
> +};
> +
> +&usbotg3_cdns3 {
> +	status = "okay";
> +};
> +
> +/* USB PHY for usbotg1 */
> +&usbphy1 {
> +	status = "okay";
> +};
> +
>  /* Colibri SD/MMC Card */
>  &usdhc2 {
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
> index 8d06925a8ebd..a6b013cc6929 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
> @@ -21,6 +21,10 @@ &colibri_gpio_keys {
>  	status = "okay";
>  };
>
> +&extcon_usbc_det {
> +	status = "okay";
> +};
> +
>  /* Colibri FastEthernet */
>  &fec1 {
>  	status = "okay";
> @@ -108,6 +112,28 @@ &lsio_pwm2 {
>  	status = "okay";
>  };
>
> +/* USB PHY for usbotg3 */
> +&usb3_phy {
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	status = "okay";
> +};
> +
> +&usbotg3 {
> +	status = "okay";
> +};
> +
> +&usbotg3_cdns3 {
> +	status = "okay";
> +};
> +
> +/* USB PHY for usbotg1 */
> +&usbphy1 {
> +	status = "okay";
> +};
> +
>  /* Colibri SD/MMC Card */
>  &usdhc2 {
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> index 49d105eb4769..1199e311d6f9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> @@ -23,12 +23,31 @@ key-wakeup {
>  		};
>  	};
>
> +	extcon_usbc_det: usbc-det {
> +		compatible = "linux,extcon-usb-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbc_det>;
> +		id-gpio = <&lsio_gpio5 9 GPIO_ACTIVE_HIGH>;

Not sure if I missed something, CHECK_DTBS report below warning.

arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris.dtb: usbc-det: 'id-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/extcon/linux,extcon-usb-gpio.yaml

> +		status = "disabled";
> +	};
> +
>  	reg_module_3v3: regulator-module-3v3 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "+V3.3";
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  	};
> +
> +	reg_usbh_vbus: regulator-usbh-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbh1_reg>;
> +		gpio = <&lsio_gpio4 3 GPIO_ACTIVE_LOW>;
> +		regulator-always-on;

Needn't regulator-always-on, because reg_usbh_vbus referece by other node.

> +		regulator-max-microvolt = <5000000>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-name = "usbh_vbus";
> +	};
>  };
>
>  /* TODO Analogue Inputs */
> @@ -329,6 +348,20 @@ &lsio_pwm2 {
>
>  /* TODO On-module i2s / Audio */
>
> +&usbotg1 {
> +	adp-disable;
> +	disable-over-current;
> +	extcon = <&extcon_usbc_det &extcon_usbc_det>;
> +	hnp-disable;
> +	power-active-high;
> +	srp-disable;
> +	vbus-supply = <&reg_usbh_vbus>;
> +};
> +
> +&usbotg3_cdns3 {
> +	dr_mode = "host";
> +};
> +
>  /* On-module eMMC */
>  &usdhc1 {
>  	bus-width = <8>;
> @@ -356,10 +389,6 @@ &usdhc2 {
>  	no-1-8-v;
>  };
>
> -/* TODO USB Client/Host */
> -
> -/* TODO USB Host */
> -
>  /* TODO VPU Encoder/Decoder */
>
>  &iomuxc {
> --
> 2.39.2
>

