Return-Path: <linux-kernel+bounces-515594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5AA3668C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB695188E015
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6937B1C84D1;
	Fri, 14 Feb 2025 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AKlk6oCz"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3141C84B3;
	Fri, 14 Feb 2025 19:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562908; cv=fail; b=InnOWdDx0NL//XcMYtnXpz7tPqrgkljuGVV6pA5V8jx+dwpho6jS4hBf8pfg9DsXwIk01L1sqcUQumE3T1S/ev47cftemZKtLB1KIYr1e1LmtV1ExmBJKFES+JxYoIZWIFHkecdXkgNPoWJ3AdtEH/rOBGTysrHxU2SwwWyOeg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562908; c=relaxed/simple;
	bh=mKOrRAZbks+Cx2xL+qdULHjKhE9e93IKy3HpbFfZhRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V5s830j5hRHR/nRPPEFpr97u3p2yrIRzdQIVBDLP8LZRmWVKOlp9taY5TpY91tXWgaFTdQTdDNc4yMp8Si/PeQK87BUJUPCdoYvwf7lCqU57foklWHadfahfxD8EF5icpk3AILIiemBW0Dfoq7pHvmYHVFtLOnltCT/8pQqAeBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AKlk6oCz; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq1CtvE3zZzBNkeo3rWxwlRpraDBLKq2O173YhBnSVgi8XF3iw0SA9KoAidNp4mlxQG5hWEB4KenfSI9N51wACU9xp4Jp8zy9ktXUNTrNKey+UbB0Hm/TRNCaFTXNoCwtMeRxPuqxPfcBWKcevLXEmLiWOby2inDinaAzJXdQVHP3q0/cNWl3m2hms/vk3TJ9ObfQPLhPCIc4bYb4xjF35RzG+rMM7D/uep6pDEUtw4DV+mXxn5kIJx1qUUKvp6NYfRMdQbxN5yCP5ng1hzPtcvcUhzyccGM91Bd3QvGq5DJtIJUwB+bduyL5qUMhumzwXIGQZPQdwC6LIP7DKaBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoqeFrgvjgdrxVq7JubIVfUNZMfdn2q2JXFEC/uMALw=;
 b=A/GQo2MRJYgdjFY0NUV0C8HUnEGd+Q+U7FcemkbVx+IJuEuWX6Eg4A80gy85n7wbQgkIW/z8xM/Kz42+daEsth4N0VYfHwqkxzrRd5IYOVC3owCcteZOF7xRvvt8gHSCaIYiDHXKNLxrCqwbJrglE7VkPb0yeLSbF5yBcfk5B6MjJKjphlMjT5TiPHdDllbDjTSvY4nl8705g6dYPqSLPSOcIjO0X3WPyqWHyNuJP0t8P0FqGtULv3b1ZCGS/EKj8GiLv+uklEIqqyphAEufAGMSw5HqEFg2xVPXsYs7Lfgpgb0vrqjCezbvOUEsSzEthZtSM4s3wYZP+kVgyR+hIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoqeFrgvjgdrxVq7JubIVfUNZMfdn2q2JXFEC/uMALw=;
 b=AKlk6oCzYdEje2EegB8VsalUTMQb/iWqYNafV58cIhTSP0UzdKKwBCy+xVvr0ptiJrJs2JbV5y8+pNhPdnuRR8G1gsYLkljp+3j1jOi8x1G6FTkXwXKXxKr7WWQ/sBG6ySa61j0Z5Y4e+IrtxlQz/C4XeYkQPMwlyipVlxVUuLm/NzSNjekhthbMlAlfNtRMjrDABpzIMVqvl+R2cLrst1U62YROSjMfvWZRio2raCsZWOzJdEZB0KdOWJzeuDGenI4+fUTKwK/S80fu0h1oRYeCO4UtaQBFheC/VfW3fdzBFploPKkwiWN2hQXNXomWmmhnsmih1yx9kzlK51sMWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7211.eurprd04.prod.outlook.com (2603:10a6:102:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 19:55:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 19:55:03 +0000
Date: Fri, 14 Feb 2025 14:54:55 -0500
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: freescale: imx8mm-verdin: Remove LVDS
 panel and backlight
Message-ID: <Z6+fjygpOeCUM9nd@lizhi-Precision-Tower-5810>
References: <20250214092634.12414-1-francesco@dolcini.it>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214092634.12414-1-francesco@dolcini.it>
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d1877e-15e5-4d14-1d08-08dd4d3178c8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ZbXKD7IlzFsd2efFSD7DZEYJTOmxNVrq0NWDTzTFQe97Vr0GJoCrTOYnNnfg?=
 =?us-ascii?Q?XRorrLFmp22gr3uB5LTWN59Vqox08FUzreL84I91NS19hUyEjnN5S4XfNobg?=
 =?us-ascii?Q?s3txmMrlblNM2glLjskd8ChHcpk1McwhADKeXgiMDFwJRVxFGPTieS652QtM?=
 =?us-ascii?Q?4nv8+IoD1orvFJIsat5owi0C5qEehWKBm8LBat+p9rGQQQMxygZe/tmk2kNr?=
 =?us-ascii?Q?12d96jTD2eesBjOJ57tMaTjnT5jB9ZZL1Q0gEQ7SybPaYaXSCTXjA+9SxUqS?=
 =?us-ascii?Q?KvDW55F5vDjKbBNq9QydtoaA6vWljMWNd6de0f1XteWx0D31cL1PILZbVU2P?=
 =?us-ascii?Q?9umEJ7pQ5kjxfp8Hf31d0KtWHaVzAdcJQyJwUkF2zACmfcI1iSyiIy0lXl62?=
 =?us-ascii?Q?06/nZCY+fjz8APfIG9hCXWGyMC2QxW7xukQMLsWk9NQsnhTadTH1gGzFmAIT?=
 =?us-ascii?Q?XYOA6Z9pysStMmTiXzydWgZ4yqNRsrFGOi78lmFKu3bOMf+Kay1JB2HGE2G2?=
 =?us-ascii?Q?aeHf/U2XIkCouG9dVhFwaD45Jl6CMN8dNm6oTariBt1rqmodtsySKcd6j+o+?=
 =?us-ascii?Q?5NTS+nx5+f7v4ocA2Fzfxvu7LYkYWG+kvanpZGzZ6fx8chle8vRSC33Gf9sw?=
 =?us-ascii?Q?JAIQ3dSwqqCgmO/atxYjlkNaqtOVTawCDgMuX02tjgDf1kEqpDB3OcaWIbqS?=
 =?us-ascii?Q?NazaknNsr8llj5EIBokcDG/PyFdKPWDPfnc7Gl49YLzsc88erEXqAMEKg3DK?=
 =?us-ascii?Q?2x4Nm93iSzEWBeMoEZLG1ae6m92BjL6oVxev8KAs4UcsS6qrBaNp69B3dBBs?=
 =?us-ascii?Q?WszD7QejQXMrLiGF5pxTvuESrS0TQtXcGXgi+VTbgicxOR3Zavj1znXFBKE1?=
 =?us-ascii?Q?6TAVfT0rr4BatrT8lDr0dQogRlC/OgK5GlBW5EihBv4dWpfdpCYFyblkbVZb?=
 =?us-ascii?Q?+7zXrMqRjnhdX/49+7Ks6Ie+VuwWLMCHECJjRcj1OVa9gcX/bAQzhNFEXWZZ?=
 =?us-ascii?Q?V3qHLhVIi2abUqJwS7VddwL4wPEbaUa+g+doi0Rl7tRRBHfD54pgUkgFIsM5?=
 =?us-ascii?Q?5OqoDWSTEa0IYlSDZwszrlsJq1L8P83t6sFcDCYKXiNb3BOWrQ36odsvcJQ+?=
 =?us-ascii?Q?TnQoPa8n1YpRO69ov4M86zLjE9CZV2rUYDbbWgGcnxbd1rHiHFZUk0eaB/Mc?=
 =?us-ascii?Q?9UCzuooqAH61mZnCTUaIRglCr/YTAXfpvqQYnF82Tz5I0BD0FJohSZTXYJxs?=
 =?us-ascii?Q?cw+mXvDBqDB19UAIa3A3j8Y/SgbnqMfWSU6V2YSDQhskAUlXAnFw5NUd/A0S?=
 =?us-ascii?Q?wWPxJaV2WPjVhhANpFSuvep3qe9eJUGM/6MMlJA+NG02jUVHeGcmYC39C4Z1?=
 =?us-ascii?Q?gQYBqbt98YLmA/mRwmmiZ+tK+NPvXeXa+Fem0OZBmI8tEXipQfL54TDJmXRR?=
 =?us-ascii?Q?6NoYKNfEakG6RcWxLL3yxQztB4B43kpJ?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?JiLQtTeICbg34SsBpxxvq5TOdWV7xvyvs9yRh+sfoDnfus167uMjPb+tGCx5?=
 =?us-ascii?Q?BwBgeRp2T/jJ/rv/AkTMSWH7ACClW6/gHpiYj9e+xUtOqQdcctg/1pOc20+B?=
 =?us-ascii?Q?QK0nFkMSiH2jcM/U9ulzwluBnqXeikHjWQyX1VhXPrHkvzEB/IyR7RKy03oz?=
 =?us-ascii?Q?BsOa563ybmyNl44xiD4RRgjapiW7HC+EkiS9IPVBJvUoflF5XUTD+UIRunrb?=
 =?us-ascii?Q?cnZ8IDDNCx6WXkwBnQV4BEwIbQQPfSjxbKH/bpInYDGaZq7dHJ+2LxhGW/hg?=
 =?us-ascii?Q?POE/PviPTl+xF8Emg/AZo/7Ar8TO1KcN8lNUDO/g7+7I1JlcLxR2mZcPULXg?=
 =?us-ascii?Q?c1fKPTz8mNcDQmAyfFL1QvVv3XBrUCANW6NHI68/EUZrGBm6bJnjNVe9rpcT?=
 =?us-ascii?Q?qG7PYZvjJwUk3X1hBwAwCAkZ++Wdv+glG7FABSghvzCgjQE1Yj9bep1ixgWS?=
 =?us-ascii?Q?bEVoqmGeF8OKpvTDHav7W7c/kVsVRFZKtrIUr+7SsCuCeUCF1xztceV37OWl?=
 =?us-ascii?Q?PCynrNHDYxrDpDDdndhNdOeFk5u375N0HXrMdv5Mc80NCUAsZeG3LG+S5LpM?=
 =?us-ascii?Q?FjqOkealcn1gyj3vqKh1mxH9ZDzf6S0hIGqra3xhOetKXKar9pJx+qkmg3Am?=
 =?us-ascii?Q?FP8ZPQWkSw70yu8pX7YrRoc5/UZgc8g7uGo9YMIOpmdExM6Y6eTorlWj8WLw?=
 =?us-ascii?Q?3D4Y+v0FeCMELRCn4al50iVdhaeRuhubUIzkljsfqOYnusgiko3Bxoy+6XmF?=
 =?us-ascii?Q?/fanMsEc+/Fk5Lpv/iCIHnCU/em+wuO5fjA2VR0/BMNnQtJWYnaCE/gKKIh0?=
 =?us-ascii?Q?wVdG+JQ3bQIS7iNjPYn8UEJkS4E3uFrGEgvrOa2IDgcNcW6uVEGjCp04m0Th?=
 =?us-ascii?Q?AjaTwFo2X+NltmsMLT+jquuYc4yajC01GpNScWdu4+yYhzT6Hz9I1HJJeul3?=
 =?us-ascii?Q?62zbO9XdyhSnEVPZa4S4U8TOPyVBFDaIRqF9cyAIjgcasMsybMsSITLJuIRF?=
 =?us-ascii?Q?+7/VzuGsHV+FMsnUOQqTT3Gp6/qN791C5fleRmX6zFjLWOcvf1QyhoM7JXA/?=
 =?us-ascii?Q?aogqDbw2sYkU9b+SsEJxniqVLJvTzlAAdMG2PmiXM9DfUVOmIt6KB4i6jcUV?=
 =?us-ascii?Q?7gM7sJU1Jgjzfp7hUCAMvheePF5nR1porIUUVoC8a6L+3s7bRjt+Du6Zk4qO?=
 =?us-ascii?Q?sTbcSkO7DXOK5aD0ZNrLG28YsTS3OlO6wgLUCv0391ARwnfhjhDrN72gmiKl?=
 =?us-ascii?Q?NQutXBV1cGeK1hDZo6eDXSTebOMqR2PUAY4G0q61pRxDu4DzTAWEgSSoAx4R?=
 =?us-ascii?Q?tTUt/vr9Zs9zn7g0tilX2p6ATit5Y6W4K4iRt1wI56RWQYypMuse70s1+a1t?=
 =?us-ascii?Q?slC9Ea3ia5pRbTxAzEqkuquJ1tP/CBPXySaXWNMoMqwfre0O4ZAeClaBt+dQ?=
 =?us-ascii?Q?p+QnfvPqDxKGlNWQ1wjLoK1kpg9EGkxSJngEVWHHxQOx8dKeCKuObKKcNnPU?=
 =?us-ascii?Q?RMWur0mQ/rx7Ap9fryghlEePo1JhtC2GAyqqJ1Zd/YTMud07XU5aiwUJAsFu?=
 =?us-ascii?Q?Vd2njzammJj0a+j+R1bJ93/gBSTU+cH9tO9iuB4y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d1877e-15e5-4d14-1d08-08dd4d3178c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:55:03.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaRaODLajnjPUBFWrksJAo96Cgij+x6Hy0Ac3xOCSTK6xUrCFncsbHh0t3sO9D3qe7IXNEA4aZOkOVODkKYnLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7211

On Fri, Feb 14, 2025 at 10:26:34AM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Remove LVDS panel and backlight nodes from the Verdin iMX8M Mini SoM
> dtsi file, those two hardware components are not part of the SoM,
> therefore they should not be present in this file.
>
> This is solving a dtb checker warning about panel-lvds compatible.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Thank you very much.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../boot/dts/freescale/imx8mm-verdin.dtsi     | 21 -------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> index c528594ac442..7251ad3a0017 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> @@ -18,20 +18,6 @@ aliases {
>  		rtc1 = &snvs_rtc;
>  	};
>
> -	backlight: backlight {
> -		compatible = "pwm-backlight";
> -		brightness-levels = <0 45 63 88 119 158 203 255>;
> -		default-brightness-level = <4>;
> -		/* Verdin I2S_2_D_OUT (DSI_1_BKL_EN/DSI_1_BKL_EN_LVDS, SODIMM 46) */
> -		enable-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_i2s_2_d_out_dsi_1_bkl_en>;
> -		power-supply = <&reg_3p3v>;
> -		/* Verdin PWM_3_DSI/PWM_3_DSI_LVDS (SODIMM 19) */
> -		pwms = <&pwm1 0 6666667 PWM_POLARITY_INVERTED>;
> -		status = "disabled";
> -	};
> -
>  	/* Fixed clock dedicated to SPI CAN controller */
>  	clk40m: oscillator {
>  		compatible = "fixed-clock";
> @@ -66,13 +52,6 @@ hdmi_connector: hdmi-connector {
>  		status = "disabled";
>  	};
>
> -	panel_lvds: panel-lvds {
> -		compatible = "panel-lvds";
> -		backlight = <&backlight>;
> -		data-mapping = "vesa-24";
> -		status = "disabled";
> -	};
> -
>  	/* Carrier Board Supplies */
>  	reg_1p8v: regulator-1p8v {
>  		compatible = "regulator-fixed";
> --
> 2.39.5
>

