Return-Path: <linux-kernel+bounces-339777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F46986A69
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9831C21C37
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D242208A5;
	Thu, 26 Sep 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UEMR2iPW"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBAF4A3E;
	Thu, 26 Sep 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314234; cv=fail; b=GkGLSJAhIWornQH6IteKPbDqmd4IA7vMkO44+YR7MBAOT4jt82Of7Qqbk5uUElUKwSNynoqsfPV5C5D+O/3e2JtnUSYD2UyIIdZGizADQTwzLOB/V097I/e/aiR4GQx1198vQSSaW7ga0H0HkqCPSCTNZX2OwY/yDPx1y3rchGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314234; c=relaxed/simple;
	bh=ix3663DQOm/XXDeKxF38Fsqqx2jx1p7OaxMzG/d7i/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NSY+AmUFAJ2j3DnDUK/k3MRSOwZYS+pX+fe0lqDdqkyYr5d63sZ17cWagMFTzSyiLiM25dXdS5AwVn7643ZcnLdUtWrcY/wDl/n8geBK/XfFe3YiGmh+GbZn2dyL3QON9opRUyV9N9QXAip5sROtQq+O+oaPVNPOy8x800qFmrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UEMR2iPW; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNSvugQz5d/DLe5yfvPHU4A0APYt2xT9HeS0b+IsV6K/QM8Pyp1ZzL7/GUPW8AmIijMSP7UH/6W6p9gP/7TxNGIEYUvdL1K7qdFlFxArIBm3iZXSbevXZZmNr3NOVbJOe9+TaVLKxO5zFOQeROqIwyjfXSGb7YbLFMhxVNZ1dipueYFP/pGYv0O4mS8iCCTiGBFRJ/6L/BaeYsQ23eggm73POLFbjqQlxoA10l2ctEL42YmXokuwMDsqjgcFiryAVJyCejdiZNWdXZdsm9AQu3RZtBkHq+GHAuYIOVG1cNpqOOesy5dxqZT8zhGWAKs14GHY3b1etJLeteVBlXteAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i85TNniDGBojuZwkJZ/rRL6ObXHIFT+Z1UKqPF1lXlw=;
 b=Pvp6VIuHH7jw6gvYw6DjCii5FCr+fK6XWrJ0ZVWoBTIoXhgkEwC0vYEP5KPy3MiV97Qid+TMVX+ygl0ZNtnVL8WLCAYLHdUWokxnqswWJn8jggFqFmcocnH/ESxEBdEyXmK0oNFeeneXVzYK8U8Jbz22Ov5+AR3XGbpU6W65hJcXTyg94jC4a08qrG7SVg/KkUCNJLlLhwOuxhJTBpU4SHAXrFAQRd7ebPN0iQsm5rPAQv4eLJMFgCVmaG76+T74iZH42h5R8anaI64gXta5jHz+afraNl+OqTPFBURBC136gvZBCKhA5KjWYvcyq3mxekiNX8Mxjmf2CzGTxU2TUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i85TNniDGBojuZwkJZ/rRL6ObXHIFT+Z1UKqPF1lXlw=;
 b=UEMR2iPWVop++hhCnzh9KqgD2kX7RaD+Jq5qjApySdHGQEKQXmzQRZaQpgzWc1BH8Ev0pKKhlPdmuUdNL9Yl2kwHdUGXccj8qOTdpVxayrQgH90UcvXV/gi3q9DyUSF7UXzVWQTTaHGb36cUxL5Iu4M7QvfeXYzwh3TSj2kjmxhtJ6AkA/FTxmkLgHSx6YH/mPqvDKQQ+a2pC6HivKzdxCfPrhRnA4kwmxP6owAelYSlx9LeYs2CxDJ7Jg+BscPQYyAxtxAY85UhjVQ4XYN1QkZ+FHbkb6MIJV+m+Xa5jDMRu1HUx6QT5cDkvGML39QFsVSEG+buhhezUQVHPVb/AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 01:30:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 01:30:23 +0000
Date: Wed, 25 Sep 2024 21:30:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/6] arm64: dts: imx8qxp: configure dsp node for rproc
 usage
Message-ID: <ZvS5J/DAc29JmJ4m@lizhi-Precision-Tower-5810>
References: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
 <20240925232008.205802-4-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925232008.205802-4-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 948fc893-7a13-4233-4df8-08dcddcacaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z3zRPq9rnaAmecTAWzP7wDQ3ZbLCYCKISXQm5Ted4UOA8ic6Ng2JHQ9MjWwx?=
 =?us-ascii?Q?rFPY/7HguvXP0XTIdmxCzf0eNXTHyd95vYkGJyLuvm7d2A5g8ataVCANzdto?=
 =?us-ascii?Q?cWx4YMN2tUPxdnWBE6kUX14sWEa3yw5h/C+BLCKAG9McUDoPuDMzSfqHgsd/?=
 =?us-ascii?Q?NqEZ+sE9O+sM/nRoxc8AXvHO8kCrQIEb4/ltwjsR8qo0X/TCm2bIHGG3kYOp?=
 =?us-ascii?Q?bC5y+G4DydvJV3QK/NgooT8wcrxoEtJJfwjnVfegeW/s7zJ+2//LHqeM9MwU?=
 =?us-ascii?Q?L1S8BOHRjBMxPRdS36A+3UW27vVLq7EE5RC9lM7cF1pRVFY8oWYhvGGDY1lo?=
 =?us-ascii?Q?Vy4HCVgsC5mF6NxGviOXQ4KNo4qPhhaySOv0+AGnL0bTGGz1cgfdW+w+FA9Q?=
 =?us-ascii?Q?UARyDXA5Dw7clExIt5j4lRiGXiD06nL4Vj29QnNo7IVcpD7eRKk85SxLKZGl?=
 =?us-ascii?Q?4zemns0sHj0A+oRJ8094jyWGgnzA3/WdM0WYTZi4oeq1d5c4CWrVQ2UgepIq?=
 =?us-ascii?Q?fJkoiP7Vm/aA10F96t9UUawII8ycjiBTXNANG/u70Im27LNgrTmGj0aR+4n7?=
 =?us-ascii?Q?Brhvj9WT3JemFYTKpJb4S49gWHfusUAWCAiQdfs8BzJQTh0sZBjL1yXXbLbW?=
 =?us-ascii?Q?FyuHAaLoMnt8DsNechDRGhk++9iUyJMzr3YCkcSuhLlk8Lt36Q8xUQxtxz1/?=
 =?us-ascii?Q?3XtXH5qwfpg6Sh4U1FBbf6roDCxvHrcyNMiP7Q+KiP+AQpsNdZsimZlcWweh?=
 =?us-ascii?Q?iaH6H/4I0w/BWTzfTYn2u2yV0pu8T2ppfNHelIt1nh5so3J159vAWpdIXewH?=
 =?us-ascii?Q?FitLiTMfn9jO/OB+m8E0ClidSc/vilj4dDh6npP/1gW6y0bvr7M6ersrilbg?=
 =?us-ascii?Q?3k02HvdvvdznWWvxswxfJvvyecZfye1rOfxnUYZs5XnTv3Hmspo7V2FKTrEi?=
 =?us-ascii?Q?vAilBRadeT8W3qJKHM32l0/CBQxCJ/gv9o+DhZUA2ZQkbkFWMj0UpY+g/vZj?=
 =?us-ascii?Q?rU6uShySTKR3wMBUhozv3kw5ycvAegS/Daw86R5W2MUvzmTQcxBt+0wCC9tQ?=
 =?us-ascii?Q?jgH2zaFxrItLyBSJYMh8cNTWSpH9Adi30YJmLwBmuQbDb3Nm+Fol52dNs9uF?=
 =?us-ascii?Q?EKS7HIz3xXlkyyNQfbtngeLArZ1k+xFKB4RjsQwiHFVnT8o1vE7E1OWZqdzD?=
 =?us-ascii?Q?WQf1K+qab6M8Xc9AE77xSBy2Sl3wG03DESeuJbQTzCCB5Kn81RkurJkInpjv?=
 =?us-ascii?Q?Se8zgL+dMyEGANe5BgWx7BJHA+5hRutqsAvj/bnr356rvCBuf15IVa1rXObf?=
 =?us-ascii?Q?IDCX93bKvgNRscfId/hUD0LxvaH56khDzR3HEdS1HIjq4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dUfWQFK3gL2FBmd3lX9jgGG8qGwxCPXRvZ91W8ppoUyxsQKCec42Z7ZnB244?=
 =?us-ascii?Q?qiF+XdE7ncF6RD5rXQVujogFuSE2VELoboCRwBqYWLcZWg8grE9SlVrj/Z56?=
 =?us-ascii?Q?r25e7rbDyVKToXTVBTmARHvdlLwofbLvFwJhdUJi1NSvRc8zeNak0hlRBaY1?=
 =?us-ascii?Q?8d631lcdSl+1Pa++aNS97kJHDbISP0wJZVK8iWyuW444ckK/a+FeZNr/YQlw?=
 =?us-ascii?Q?R0zlzX3W0sGIkVjix2OHx4H1is8Ub8dnRPG5Fkj/Q+8hOVlJ7fc25Fyorgyc?=
 =?us-ascii?Q?hHouDjrlYYbtO2A3TzvPN5w7JA23sLf9nU9KzRf6n1B9x5lM8vau2TcMDhlH?=
 =?us-ascii?Q?P4twfDhNP33I3JcPwe1oCGZTyjfa3g0W0WYEWbf6VGz/ktBeyTW8I6MFcf1X?=
 =?us-ascii?Q?FygCcxHau8Dv/699o535GGNq/1iK6zwqArkhDZ+gqU4XxPf9ZDqoJdxc1+Jw?=
 =?us-ascii?Q?Slqj8wJdwBUgok3QBiPFgEC92vIGsxtpvAIVhOaKfnqO0LYXrjmAw3M7ODuU?=
 =?us-ascii?Q?VsAGvKAEo5KUkYe+UMbSsTWtWF4MqreXWUTVNZGrrLAnQ1NXSH228ATPPZWH?=
 =?us-ascii?Q?6zvdIgdeSH99rn44b1rYMcC/x46m1cfAz18oFw39CBmVotLJcQOwJz0hqBz7?=
 =?us-ascii?Q?rixzizcHbPEYAlGLfOele3Li3tC1Yr3xr4DS9ksCaRDlWhGmFTVdJohc9SjA?=
 =?us-ascii?Q?6Gi2C5tLg4kT7VvgcFwye8EaD1JWp76HbU/wpSJzRclSA+fiKN68kq6IcfMq?=
 =?us-ascii?Q?7vuqIVdCmRbXoKbGbj+WzlNMjMumVN9I0yAg9WFWuc3BR2kj1IbszfXb5f7H?=
 =?us-ascii?Q?j5uvVyA9nrI4enYkGM7lRvxKU/0TiIayq2J5yps/WK9i4UiKgXJo/avOtbNi?=
 =?us-ascii?Q?TPRgj4RSya1ZdFftQdxan6odS9OWMqEADywg+EJ+ilo5BY23/2z+N/l14wRD?=
 =?us-ascii?Q?CX0oi/0tCdyJ4jU/H3+IlXDPo7w8ssw2VMtAGnZA57e4QGBhgNJMjOXMHDZn?=
 =?us-ascii?Q?+o0m6LrisA+NEk95M9EvZBxaoSFkAP/xGYYOZ19Exaq9o0uNvC6yNbJ/LReO?=
 =?us-ascii?Q?2hIGwJ4pQ3GTuOzochVJJY7oOGhDiCslDzzaesSi+Nqd8PqAYj+dtkDGhaax?=
 =?us-ascii?Q?aPTJRLKacqfAtZkI+W5beWm004Do/LTDPMyvbCpl/Q3LTXm0vgElrRHzwmr0?=
 =?us-ascii?Q?dMRjcIZZnbrLjE35CUr2smVZ6q3PqBgqhKxeOnVglh8Ovpg34qoZ+TTt32jj?=
 =?us-ascii?Q?CXGrtKQLSCaAvZ48LnWCigGddXVzHtPz056KrqKDmyoBGdZSpTNTIgZjsYDF?=
 =?us-ascii?Q?Tke3XwUUm4zW2zSoGsy9RLuHSB21Js093jFdpIN1WKWxVx5sKJnLaly3Q1Yo?=
 =?us-ascii?Q?84vi1NOvqX3xo+pIvkdfWgOWESpblA+oTVTp7A2qJJLmDHZ7VRXw/oXl5z/X?=
 =?us-ascii?Q?y7Ky86sOX/O6x/w9AY23NIUswdVp/RO1KyR40IfR/27tcby/Psu7TW1zPddi?=
 =?us-ascii?Q?DlBUmVvnLQazV9QdzeJojO4uXGDxmnKR8rCTyLxDrIn73Klbk131AmQPqsle?=
 =?us-ascii?Q?zRJDbfqSeDWkzW2/F60=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948fc893-7a13-4233-4df8-08dcddcacaf2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 01:30:23.8765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiFAmt92dG1OnoMzkGOwZpEopIl9HtIQef5G/tXeBPN54D8UdZRwfnoXV8DDwgC/OPuzsP02HazwmqMqTMBs6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9694

On Wed, Sep 25, 2024 at 07:20:05PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Currently, the dsp node is configured for SOF usage, which is not the
> "default" case and should be done in a separate SOF DTS. As such,
> configure the dsp node for rproc usage, which is the "default" case.

You should descript the reason why SOF is not default one.

>
> This also includes the addition of the 2 optional power domains which
> may be required by some applications.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../boot/dts/freescale/imx8-ss-audio.dtsi     | 20 +++++++++----------
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 15 +++++++++++++-
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 19 ++++++++++++++++++
>  3 files changed, 42 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> index ff5df0fed9e9..28970211dd67 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi
> @@ -431,22 +431,20 @@ dsp_ram_lpcg: clock-controller@59590000 {
>  	};
>
>  	dsp: dsp@596e8000 {
> -		compatible = "fsl,imx8qxp-dsp";
> +		compatible = "fsl,imx8qxp-hifi4";
>  		reg = <0x596e8000 0x88000>;
>  		clocks = <&dsp_lpcg IMX_LPCG_CLK_5>,
>  			 <&dsp_ram_lpcg IMX_LPCG_CLK_4>,
>  			 <&dsp_lpcg IMX_LPCG_CLK_7>;
>  		clock-names = "ipg", "ocram", "core";
> -		power-domains = <&pd IMX_SC_R_MU_13A>,
> -			<&pd IMX_SC_R_MU_13B>,
> -			<&pd IMX_SC_R_DSP>,
> -			<&pd IMX_SC_R_DSP_RAM>;
> -		mbox-names = "txdb0", "txdb1",
> -			"rxdb0", "rxdb1";
> -		mboxes = <&lsio_mu13 2 0>,
> -			<&lsio_mu13 2 1>,
> -			<&lsio_mu13 3 0>,
> -			<&lsio_mu13 3 1>;
> +		power-domains = <&pd IMX_SC_R_MU_13B>,
> +				<&pd IMX_SC_R_IRQSTR_DSP>,
> +				<&pd IMX_SC_R_MU_2A>;
> +		mbox-names = "tx", "rx", "rxdb";
> +		mboxes = <&lsio_mu13 0 0>,
> +			 <&lsio_mu13 1 0>,
> +			 <&lsio_mu13 3 0>;
> +		firmware-name = "imx/dsp/hifi4.bin";
>  		status = "disabled";
>  	};
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index 936ba5ecdcac..527933a3eb5c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts

Shawn's requirement: board dts should be sperated patch.

> @@ -63,7 +63,8 @@ sound-wm8960 {
>  };
>
>  &dsp {
> -	memory-region = <&dsp_reserved>;
> +	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
> +			<&dsp_vdev0vring1>, <&dsp_reserved>;
>  	status = "okay";
>  };
>
> @@ -71,6 +72,18 @@ &dsp_reserved {
>  	status = "okay";
>  };
>
> +&dsp_vdev0buffer {
> +	status = "okay";
> +};
> +
> +&dsp_vdev0vring0 {
> +	status = "okay";
> +};
> +
> +&dsp_vdev0vring1 {
> +	status = "okay";
> +};
> +
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec1>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 0313f295de2e..9522a65b3e22 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -186,6 +186,25 @@ dsp_reserved: dsp@92400000 {
>  			status = "disabled";
>  		};
>
> +		dsp_vdev0vring0: vdev0vring0@942f0000 {
> +			reg = <0 0x942f0000 0 0x8000>;
> +			no-map;
> +			status = "disabled";
> +		};

This should move into board file like imx8qm-mek.dts because diffference
board has difference memory layout.

And node name 'vdev0vring0' should be common name 'memory'. I forget reply
your email. Driver should use phandle to get it. Node name doesn't impact
your driver if driver implement is correct.

Frank
> +
> +		dsp_vdev0vring1: vdev0vring1@942f8000 {
> +			reg = <0 0x942f8000 0 0x8000>;
> +			no-map;
> +			status = "disabled";
> +		};
> +
> +		dsp_vdev0buffer: vdev0buffer@94300000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x94300000 0 0x100000>;
> +			no-map;
> +			status = "disabled";
> +		};
> +
>  		encoder_rpc: encoder-rpc@94400000 {
>  			reg = <0 0x94400000 0 0x700000>;
>  			no-map;
> --
> 2.34.1
>

