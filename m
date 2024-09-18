Return-Path: <linux-kernel+bounces-332880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EDF97C03B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60ED1F223E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CE81C9ECD;
	Wed, 18 Sep 2024 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K67o8q1v"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F8136327;
	Wed, 18 Sep 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726685848; cv=fail; b=Ui+kZOVeOhgpG8nY3F06wdWOovmrYdEUNv1tKof+dGsnwIeiXRK0OdVSaP7+sGQfWQ1Csy0HZPisv3kpEJxZljvvT1MO6aXpFD1rAyvc0fuIixOeovtlH7Qbz7YAZAfrGH6ALvIBkMfLl7tlOEbaaTwOUTERdLnhKbnKDwx99pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726685848; c=relaxed/simple;
	bh=hlA1MWi9BLjmWtfwDAyWQCws8+g82cK7R73khHhy+nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uZbWqcPwLmw20QulYKVs4jUHeA52kgUbfmyCqAz6JtLI0aAoZ13zIfsHsqe9CNSoDTCiB387/HPyjb8xqtfkyuQyu251Z9jLEOeQpxbwtO+jszrUWuUJGrdteWz5S5KkCyqcugMq2cW0MKmOQPUtBlFxWtsLqMGAi0r4Lo17Jmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K67o8q1v; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZl/VK0LuhMFtYZ9gnOk88hDIJkvaJzY4z5KjspTWood0/R1j/F+p1yfe6gcFzyyoLyB+lUfSSXK5MvAepG5By7cVBGUJFEiqLA+dgQC8+DpBfA1fIRabXZKU5pGn5K2tBsrzygSoPBP25P+tGVIFbFiVaGwEE4GLOc7qSdJv8IHOXNPUZ5RAyPSFCiUAIM9rJ3EcE6k7z8iK3Rq28uRFXmB/kWSMSCjHeQznlkpxCdie/GpP7ZEQ3W81FL9WkVt0lRnuGP7PDwg0iF2OwAgPWyQ0zaPAZ1MXjM0ClSGFfo3U9mg0eSD1LHITi/DMdEWNSwcotK6VhImG9trxJ3/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTc2eB2aGSYhyN+Hqm5WXZO1w4Cp4cKmFjkJlkq/OaM=;
 b=LJJZmG8euayutA/EC+Gn5VGckq+rEcPf7Hyxxkx/5hfXB7uba6wCh/0c5X2Lg2BasF29AH85XVkwtT8owhJ1yrwdJmtnJXT3cuCpzhvYun/mT1OWNfZ+/7MopBQLZz+6eM930H2zo0FX7/5bEmpZqcBPokkGi9cWdWzqaGZNYX7Ro6j7D0Q6yoT6LZBT+ZpasRFJ2ne+48b/UxTGliXLS8rX4LyJAhNBBA8N1GkN+1Cmvl9AjjKeIDz2FWFaqOTEVPnvzKmnJovciK25xczON2lKk2Ywigz5Gykskeuz5FmKv19iCHH+pTowTGKkO1a7fMu9F2jUCCTBONl0jb0r6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTc2eB2aGSYhyN+Hqm5WXZO1w4Cp4cKmFjkJlkq/OaM=;
 b=K67o8q1vjDeXkF2cnX4ioa9xw5dVGXyGSE7NYCd0PQDVmmfpnyVtpDMmlydf+NOUBqt02s4OMFmjy8khxquoHPUw5Yyl64XnBK4/B53VvjnAHf5RgksGGBRhCVIXDh783ClOoHUJFdd50szolqtM3Hs+5zd8ixnwT+3HQfwrlwnW3p46oL3Oodryp4zIgahpTo9GBXFRMTCAlNZ7I7IMYHN9SetmRXld1ymaGELGukGF2COJ1ZWDRBEKTYhv7CMnHwqThYqExlF1EqnMGHLNzFNafkPBjfZhXSCcguogO9zu31h86dUiv1AbBfEXWAEB3gBCbBb+7gInvxCPGq4XPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8731.eurprd04.prod.outlook.com (2603:10a6:20b:43e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 18 Sep
 2024 18:57:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 18:57:23 +0000
Date: Wed, 18 Sep 2024 14:57:18 -0400
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
Subject: Re: [PATCH 4/5] arm64: dts: imx8qm: add node for VPU dsp
Message-ID: <ZusijsRFJPtFc0h8@lizhi-Precision-Tower-5810>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-5-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918182117.86221-5-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SA9PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:806:28::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcfe220-8eab-4e93-b6c5-08dcd813bb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hy921ulrVLyYwLkvXUxgGIPgaa83gn0bmHhcyPjXpvo7tI7SkJ47FJ/S/4mr?=
 =?us-ascii?Q?gs1MsyHAHCkc0I7z65D2WGKvmhIavf/YgJVb0/GUpqT/1kkEhB8MKr2V0xR3?=
 =?us-ascii?Q?3lZcrbgQBg4Pjucm2eEI8cHJcVHNnV6bgIxs8poIlVLOeXfXwyX8PayliwTg?=
 =?us-ascii?Q?oQBjSr8B+PRVCCU86y9DMHSA51T9/NY56x8cZLCkgGVz2pRpG5UA9A5scoEV?=
 =?us-ascii?Q?Y7Gj0hvabmrVngdTVM4cLMvHvoNrXUBs8lCp698AHmskNFLcwlbDta6/3D8w?=
 =?us-ascii?Q?UFkNLiMOG/nuy0tgY7c6qtLFivu+VrVs80J/GFyymzFzQhQSdWIZz4vUYn2p?=
 =?us-ascii?Q?z3oo2dDzyG/jy1W8h9FegFki+N4Z87jBHx4g5SBywOs/t0+3xR6S0OvJ2Mrv?=
 =?us-ascii?Q?WmxGCQMriyEau4godEPIKTvD15LvVNBHl6swsZOmjCV/2SQJQPfn2xKGdaDu?=
 =?us-ascii?Q?eKPgROqHISqIUo8bHkK3HEE2KN5kCggJoyD28yg8dHZUHwqleI5vSZLvyfiD?=
 =?us-ascii?Q?MUREbjjNL2iyd+dHpeKIsNnxOzvvm0Xh+l6OIpVqjpsxt+sX/Hc2vldz+kk+?=
 =?us-ascii?Q?TsFQQG4JYYMFOi8xI9bPYwTnQZXLNMXK/H6fo8EkAP8fkRGyJJM/wYHNx+a7?=
 =?us-ascii?Q?tsmkeFFhOHf5P/aO14TErlDX7nb47+ZfqYTzfMKuFIYqe5DbWWd1cLE0pGer?=
 =?us-ascii?Q?Qc42p3Gl1Qb1wFke1Gh9W8qzJgxmo4ag2/X9IKI/ci5gkilYrpHDPsL7DfwT?=
 =?us-ascii?Q?wDiiARFe6qs+5BhNmhq4EN0mr2PLBmAi+UuDkLd2aLA3IXuoGMvmBDP+As0d?=
 =?us-ascii?Q?AdlqDJELu1+ibMpGSX/EN7zZy7Z78K5zZHCYRExr8L0O9OYwAYXxsXVNr2Qe?=
 =?us-ascii?Q?Qln00YA6ZYub4B0hTWc6ET+/GMWQCbKPJ6boLtvyNuDzyJuhCTtlD0TU6m4J?=
 =?us-ascii?Q?pJgfF7yn0xEzsMBzniu15daF0oiKnc74LZT978/ov+rwfqgMYSAoszI0NjWK?=
 =?us-ascii?Q?oJYdRYVLT5WJc7bDc8XfGTM8OevfeiuO/gBq9IOAYG3ezwqqNy7z3OgWEQXQ?=
 =?us-ascii?Q?boIaTc+Q5v3LUtMFZsQBG65ZawZuecLBcMN+B2agdxq5dzTyfWWXUwD3MO+k?=
 =?us-ascii?Q?cyldWtThUkrLwzETe5jqPoYprsxYamKc1xmEmKvvsGH/WYYPuQOEl0AW1XDl?=
 =?us-ascii?Q?f1H3jicmliKf4TasCPze2AzvAF4Eo8dbj3j7n0HqMirsPNS4+lQw2y0bSeQU?=
 =?us-ascii?Q?n5mz67ZnDOb2iTbAHeD7Jd68YFgHF+NbaNELK5gfclV4YhOsxIJ/c6zMaTjR?=
 =?us-ascii?Q?b32UOZxzR6vvn95ag3Pj6TP5PDkhCxhnAX9wvS/fecGbzwC/jV7ZKYAF6lPp?=
 =?us-ascii?Q?Yo/zr3vPe2XR12bncX49tQJbZY/zpC6BugzxMGdf8nqD/KEN8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B1Ns7pk0vHMqdUjGd48b/NRb6bp2tT8K03GJ/TZo5DbgWhk6DcZkY5hg2rIO?=
 =?us-ascii?Q?SfMIXOzA/0FdUkp/ovHB1EP+n8gZbWxiarsByNfElk1iJF0Kq01uVVad1Rvr?=
 =?us-ascii?Q?BjI0i/N5PSBI8+y8eI711ltTFW3fC/WTjQosZWMEau3CoYr1cvrp8DnUvhyh?=
 =?us-ascii?Q?GBQFto+mWExKb94MILE3Sd0EdDsosCeKQnN/XFLrCb8bay8uzbDlhSzED7Ks?=
 =?us-ascii?Q?pdnScOp6i3qiwxCOXDHFFgJ7/nAgnpuHzc3T9uW4ThPqFtuKomQD+e5X/Znw?=
 =?us-ascii?Q?1qekg39vG0gg3eZqO5RiAzl2durP5PmCwPA7adLGYrhZVtlPavR6SqwNVnvW?=
 =?us-ascii?Q?/rT2L2VtGYiPiPkvC4RYmsctUHh4PIH7T1mlCA6rThWJhfRnF9rCvnLh7e6W?=
 =?us-ascii?Q?LXzuw7LQ+KGuwlNq0cdokak7OLUs2AJCywnsYHZc/VRKmW7Wmm4yCWZ8pXC+?=
 =?us-ascii?Q?GM4jJ4blgyteDXs1LnVqlytJpJ3xSBeQF+w3dB+P452FoRrxnqZ+NG4ILgaZ?=
 =?us-ascii?Q?6ScYI8KpnFroYos2KedKxgQANo2SN3hUrCrUAm38md532+MACSkV2TSrPVNO?=
 =?us-ascii?Q?CKUYnQa6m6xZLpRFR7mIVXTCPTtXt6e035uIFQmuUOCrpM6SoRrh8SMuTMQ7?=
 =?us-ascii?Q?vKry3IGOpYaUPSctwWc54LuCH1rTRzR/548lhLdFNodThtAWwQLXYT6TCeV2?=
 =?us-ascii?Q?Qovtut/3BjfJWsr2Gx7AMwtwNZSCMuOs9BbzWeqeWZYiM1aF4CdosOgm81do?=
 =?us-ascii?Q?+Xgq/HcJbe3afCaCPuU4TPSxtNjryu/Z/11ObAhheVEQxPjIFhM+elUylNiU?=
 =?us-ascii?Q?9KghtlXOk+J5/0Zx03kY9WvDdYN1otQsJnQUwtR1n6hbXTfcZjpdhBYj/zJ3?=
 =?us-ascii?Q?kgHe2pxgUODGZMiAD7Ra02w7WQwNN4xyPr+Gt6HHdbP8eDqNoKDAafN4+YTB?=
 =?us-ascii?Q?g6wFD7PrevS+eZz2LeRpkwZY7RBtQWvGugIsogDsMSJ0fmvb5ZJEZxp/PXQb?=
 =?us-ascii?Q?FI+oS+MDce8o0Ci9LxqezQovHEUMEk2urRiM/bn3rNR5CZyedipSFj02saeO?=
 =?us-ascii?Q?vB7+sQS989G9DScGQMyDcW3moPJKS2FHxDioWxYkvacAdcj71lIQX7CZPc6M?=
 =?us-ascii?Q?wLhCRQepq5zNmCRX4Ahw4/rohx8r/2/I/qGkdclUV7xTX3+CBjmC7NO3RMgC?=
 =?us-ascii?Q?Gx7imvruyDv0crv9tbMWVFGwd6A++JL0aZEmo88R/PhWbRA/6Rhrvr1v3Yjy?=
 =?us-ascii?Q?+5QTWgQVGPVS4JLUe5uy4+ro6sB3gHnk3dObml6DQXyL+xL78ujHkl8OJ5W5?=
 =?us-ascii?Q?2sv8vfFS3pQ9M93cetusXZsvxAzHqarAUolabbmh9g6I5K+89vDgR9ikxOo9?=
 =?us-ascii?Q?j2Sp1S6UXVZ7NQojxi5tGEdnpowPwd+g96+QEB2E4lpjxust3suiXIs/e9cc?=
 =?us-ascii?Q?60PbHPPBtpiDQV4KcCGZd3LzbkfWoQ8kVS9TlJs4/ya4MDKSgcHcR04o1N35?=
 =?us-ascii?Q?Rp+BqE/v8p0PA8IjHcUC5Vc30cRcwuumI5bhynnsku0KedP3R2nVGkk5J58j?=
 =?us-ascii?Q?mCg1MZo46N1cQQoUHtU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcfe220-8eab-4e93-b6c5-08dcd813bb38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 18:57:23.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3TAIH9WSHMu/T7wsFemU+y1ywqUSMDt2vrgxDM6tGRKo109IUOfeZYn+A1bqQVG8DM+0k1utRfseHWR5tlfeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8731

On Wed, Sep 18, 2024 at 02:21:16PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add DT node for i.MX8QM's DSP, which is found in
> the VPU subsystem.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 27 +++++++++++++++++++++++

why not add a file imx8qm-ss-vpu.dtsi to keep consistent with others.

Frank

>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> index f8b577ebdbef..ae0165a44dcd 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> @@ -581,6 +581,33 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
>  		clock-output-names = "mipi_pll_div2_clk";
>  	};
>
> +	vpu_subsys_dsp: bus@55000000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x55000000 0x0 0x55000000 0x1000000>;
> +
> +		vpu_dsp: dsp@556e8000 {
> +			compatible = "fsl,imx8qm-hifi4";
> +			reg = <0x556e8000 0x88000>;
> +			clocks = <&clk_dummy>,
> +				 <&clk_dummy>,
> +				 <&clk_dummy>;
> +			clock-names = "ipg", "ocram", "core";
> +			power-domains = <&pd IMX_SC_R_MU_13B>,
> +					<&pd IMX_SC_R_DSP>,
> +					<&pd IMX_SC_R_DSP_RAM>,
> +					<&pd IMX_SC_R_IRQSTR_DSP>,
> +					<&pd IMX_SC_R_MU_2A>;
> +			mbox-names = "tx", "rx", "rxdb";
> +			mboxes = <&lsio_mu13 0 0>,
> +				 <&lsio_mu13 1 0>,
> +				 <&lsio_mu13 3 0>;
> +			firmware-name = "imx/dsp/hifi4.bin";
> +			status = "disabled";
> +		};
> +	};
> +
>  	/* sorted in register address */
>  	#include "imx8-ss-cm41.dtsi"
>  	#include "imx8-ss-audio.dtsi"
> --
> 2.34.1
>

