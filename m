Return-Path: <linux-kernel+bounces-321945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 168D59721BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9134F1F23D42
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1617DFF7;
	Mon,  9 Sep 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bdRD390w"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C897716E863;
	Mon,  9 Sep 2024 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905836; cv=fail; b=VOYl2/c6fHeSrGJzM4vFpDZ7WyjPYMm6Ie24KTSRBLi0Rp7H4Mmh95riJ+1vZKCjvJk20FY5q8+HtaVQrC0ilvtNOey2+1BsCKVTdaBkIiSMhpK/4Wn2t6uxLUeriHvU/wIQEz7hPp5hxOM7cWoG8biWkrruSIViKlxtmzihuVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905836; c=relaxed/simple;
	bh=buRBKpFHTzJd9CUVzGpqzef5B+lb6XynKYFpkchKGsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZxjIDcV0CChJT4qfrsza17eHUXVKB1PYgxY5o8x8hUo4Dak81oqs5EcWX9zkEm2Lk1gkgbxRtk841IXp0FRLg6XaR7CsKZgwE1GMTIx/q1VNAdPpkXprf8WiUoWsiUnTYTWuzVXSGoizD1832sHgJOzerFw9ZlECmrawbRwDKLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bdRD390w; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkvWIgUtg49XIYZdC+GmF1llEDNv1YytnBPNUJdfCc2e5yDaJYnvmBuk/69Vl1GK+gKVQFZUjqUBeYp946JTnwgJzUXLGm7nsTfvOeF4MrcgdJjyE3N/4ZzcRFA6KonUOFjTLhd/gBCWN7NoPdLOmdklxwk71NR2GY0U0iGub4uaPjY9aQf+gQIxOBEFhij+SHIrhk/bCjvKBybK1bqEByoXLrWdarzxcdq1HbRIXgI0qiBz4xr5TtXVODSqcGoui0tAqHMnT3L6ShLU3kcep47CmshRQX0jkCd2oVYwxAE/PBhRo8lKMnVMRiP/XzjQztDmmoPYKTKOu72IzF0dJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGr6MW07cq8MM3OqEEo+DWpMmrl9bgnP3svVxDl4qxo=;
 b=MsDNQtknbNn1zYvd02T1GPlbvlk0rjccxc/d7DpZY14xyzvcm3kmvAsp3dsyouEK8WTv9vm8XVh/3h4hV9xiPdWUw2n4SVv4QaFiszTXJi76/gaGgkdSKhkRZTNmd92zcjLN885HQaDQxiznLNKZZcQ95y1fw3k0mnYJLJcUowmZ4qXWHeSOFVM4wXOaNipMCXbg6Kxn9zgzqDWsCeFgrBpjR5FwERmaGn16YK/kZ2f+Po4VP5J7Yip63QnTnTpdPm2Q7k7sZivS1oIT423izNjt05KeTBwd0IQimcv3lExQ8RjPi02aRjt35uV4JVWlHGgc6tPPzifznZGJVBK8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGr6MW07cq8MM3OqEEo+DWpMmrl9bgnP3svVxDl4qxo=;
 b=bdRD390wmyrw38DHeS1Jod+Fp/QwvdBl2hhe7UbruHqi8ufBsM6u5jD5mdms5z7/8R3hCKuLeUC64vFmQ3GdV144IUyxZB3Ofzf/QyNcTo4Dwmv6OuS57qHY/u6AUGSLPJG82RHPhu0miNQXyyPOoKTr6TArLyZ0+13oIsELfjgnozAeQMDKZh+lLMMFSKt0aoYnr0qdr+sxnWeAKB63M9cblLLq57uC0fPSMe7xxzgxT4AJXZuFaz7YxpCC6QCQz171JAUPFvXy93OzO8xdxX9VTAraU+hSNM5BYS2s8FYr5BUB3b8Vz4WizUjwD3LReCZsBh8SP2g97ZMSosGLkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9994.eurprd04.prod.outlook.com (2603:10a6:150:11a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 18:17:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 18:17:10 +0000
Date: Mon, 9 Sep 2024 14:17:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: arm64: dts: ls1028a-rdb: Add iio-hwmon compatibility table
Message-ID: <Zt87n+NTaN7qSQTS@lizhi-Precision-Tower-5810>
References: <20240909163608.80541-1-martyn.welch@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909163608.80541-1-martyn.welch@collabora.com>
X-ClientProxiedBy: SJ0PR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:332::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9994:EE_
X-MS-Office365-Filtering-Correlation-Id: 593f749c-7ead-462d-114d-08dcd0fb9eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BABtcLKnTlNUAVrV/HeUx3XenbSG/WhOdkKokSSMVvxYSo5QXM/rPNERqJcr?=
 =?us-ascii?Q?4YbB1kq6yJabOWXYDominlKwQrdWuM8VLDyNc0nximV4k5i8Q2i0VBXx6nId?=
 =?us-ascii?Q?wTn/tKuov0AwIIpfu0Ews3nqqPr2XJMApZ+JDM/M+gl0Jojj70CyhhZeoBSx?=
 =?us-ascii?Q?dK0kaEYeCwNEd5qfujj8ADcNhZkIaNiUKjpBt9tkKk1LVwozxqwFehwXCtDU?=
 =?us-ascii?Q?TdLFPLDu/W8rkbyrAkwn4+TBwy+pQTzfmHL+0QhRElXYZEVq1KHkIsuphb1J?=
 =?us-ascii?Q?W05Tt2A6Nye11c4eDuJStodFYAdcySNwWIsfEOuR1xWzIX0WdFNo6sxpG6iz?=
 =?us-ascii?Q?hTkKh3lFg8L8EkSZ+tpRaWd4lXJhxCdehkp4ZhkFXNgSvZMma5IqLaiiqXdH?=
 =?us-ascii?Q?Qwp8JI4Uh/wsIJ49k0sT3iOfTJlBdKqEdxfrTNcK0//Yu8YuLxKER4Fgm1z8?=
 =?us-ascii?Q?UlDsz+Q+ClZwSWdH1IYBBvF4XLIS13qtqpBavVVhqY/9N5E9tYIfy517fwf8?=
 =?us-ascii?Q?rDsZitmMyNSYj+z5NVoUrLOJjfvltiX6I1YzgVm65fkExye1KH1dne8jM4QI?=
 =?us-ascii?Q?yXR/WU6gjz8DLi8GQ6haS1qRc1Z353Nk0aGKf0fGmlerHlpvGEs0kOkc9yFq?=
 =?us-ascii?Q?NZwHgRFs8p1WFj8FDARjLhOMeGIFLOuhKDiY2sR1Ccd9yzdC+UdLl/PKTPpT?=
 =?us-ascii?Q?gDysDtSQNMuZZyVACcT25YDd/edCnOB3QkMe91AL5bjjnJORr3D5iRl+2vfZ?=
 =?us-ascii?Q?H9V/PrSGSFyCONYpVCTeSy9Px2jWZyVIo0kLMK1+9uZ+kRpaVVeSoMLI3r8V?=
 =?us-ascii?Q?bjKDTyFuXL2ivD4Dxj7iknCYHI9rLuo4gA6dcVvKAqhVE8BejtZzxHowr6RO?=
 =?us-ascii?Q?jEG4vpcOn0JJ2wmmYeXdIDbVUKoa5ytOIWKqWDJKJQXkrPiDi9lWSRh5Fs9q?=
 =?us-ascii?Q?wnOVyO+Uw8pj8EGHgrGmYpBOLIJu1vu0PsSm828hOBo0Xc4cLPTtYAw5gZs5?=
 =?us-ascii?Q?gZ4guvJZ5hOYomdrqVyxdzZ6Ha2U4h3lyE0hW34b4pHeIPn//a7+xhiyVVAn?=
 =?us-ascii?Q?Tag0RilDUCtsRjJyQ8EMiIAS3JCpN/niz31UVVX+1M6yt6KM9RMtGFQy1EWl?=
 =?us-ascii?Q?QDc8sun23TscMWROuxhbNFnKuxmkg1P6prQ1h2qPcCc4Ea4xxyTQHEuihLGC?=
 =?us-ascii?Q?TRR8r9WhJ2YScdIRCuNH35IkadkOmFTyH5hU/sciVJ9rZ1ZuLbpXUCvBP9EJ?=
 =?us-ascii?Q?/Zi96XkUsPzlcX/d00IVN3txqVmG8bl8LTIuT4a8VIJYj/0wZuvtLJoLliXE?=
 =?us-ascii?Q?w9W/XXgkJ2no8vemLLXjb+QJwMmtvtpNLYqwIfO2b/rUGDBqJ+kEv5BE5d5A?=
 =?us-ascii?Q?k4CMGtqPCOqgTqayaEGrjmQ0ILquEcifyT+sFV8W/ibskNXlKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8UBGpV5FIq+5LLc6UgemNpWlM8slPpvdEYwd6L0LedGEWJlrtAHHzH4Lg3zi?=
 =?us-ascii?Q?WXFyAN8ML8BaIde+2HMFNnU8N7usCc/D946cLZ0HF5P8jxwNpUWk8NFgfYU6?=
 =?us-ascii?Q?zR7FeSXNv74UxK7eNcHDx3FL5AyyYFnQH8f4WdRRYhcYheLAeteMLdVM7kme?=
 =?us-ascii?Q?zEx/c9nNz5YktwTfR55trosZyNiqoM1o2O1oOeYeZRdQiZogeQc5BzvoTZFm?=
 =?us-ascii?Q?EItD//c4NVGlkAreMxT9eb7BbKAdiXZgZVUrcYsoywpeK4yE+4pbU7bAWHrw?=
 =?us-ascii?Q?8IjMYVAjYvdJ0r5sCTQZ7nUmUnRSN3iqzKUaBFvJGkdmlLCF2NcUySa4vxJ4?=
 =?us-ascii?Q?kP4VcVyKJXfCGJBPC2ZcQi47tJX45sgcpRJhipGtsuXrp3VpQuw5FyZpmWhb?=
 =?us-ascii?Q?1g5MWyKigiQ3dKCyasoU9oOKl3PiIH7pBsiNCwJxwQBq41mDreNforzRLXnq?=
 =?us-ascii?Q?C/lnFp6IV/2VGlLmBK4xD7NiocXO1xvcDO3BqfDl2TvVHzlX6PILEASmjaJk?=
 =?us-ascii?Q?97pWBBtjcyf2D7DulCt17LpxUWF5X4a22/Q661+7Gfh21n9lymV2iqwFOgXa?=
 =?us-ascii?Q?kYWOeyLVqbq+VeyTttbOwaerX1jySetN+nXdblihQJkXRkmJ/AhskjZBQiFq?=
 =?us-ascii?Q?sDe81uSAeS71AM5Ai2O05OUwt9zx0GY4q9WqNGK19I+xYUsgE9AHbrfO5vWE?=
 =?us-ascii?Q?OdbR8qC/uPhIhKZrJM5hGzzJtkgUctBgRdXnJlE6HUqLgIl02KM1vQDx5VMx?=
 =?us-ascii?Q?rRPC2HmRWD+8FnLuQjpzlflPWoWLMn3hzEhY53McHFxeEuXLhN8qMzRKQulR?=
 =?us-ascii?Q?prfQV8RqpLf2r6ivIF8zA2Ad94osTE4B1i5Tok7L8+i7WUiKLTqbkYAZIyDg?=
 =?us-ascii?Q?RsD64RrJJK/CNn7rCWrYR4oeDedk9qp+E79fuTzbNCsCbdkU1eTNR5a2wWNF?=
 =?us-ascii?Q?sLx2X29VI70lX7gp/PdfCeQxV6PE4ketZOyE29+vBpEITIarNvBcWWyPgFan?=
 =?us-ascii?Q?QMTDa46BKPUbnFmnhceel7MEkIhJWdvQF+sokBMzI3Hboqj91FM4CO9eXcWk?=
 =?us-ascii?Q?TojkBTF+glYjMpsXC8KzKsAJ2DEKe8od4WoWQvwCFmA9Unm7RpvSk1lZTWnz?=
 =?us-ascii?Q?KtdZEvjv/aHVw+Dplasy2F2ulfqCbbgk5L0eXoLh0i6Aib+bBkJaDpgXdlRc?=
 =?us-ascii?Q?VUN4jJpsdAiAe4PDEpdFhcmclovRTmJEcuogVS3MM57QzbYKekA5X03TBMm4?=
 =?us-ascii?Q?DkbvH/sGf/Nxop74yxgg0QRRATrYz2twKsxrkL8LLDTCgh6R9U7ZOWuUBZP5?=
 =?us-ascii?Q?Rrq/SxaPgoyS0GzrNEgqUfWSm4yrgKWWyy9Xc/xA8Q0ys+Js6IMIMdSq1jAf?=
 =?us-ascii?Q?YeiG+TSbQLBotAGL1+44xutpACnoYkjhnvBVDVRTG81lxom0FZ1U9ilIBUm2?=
 =?us-ascii?Q?Iypa1Q2BsSbl3+LiFyyzaRL/aQ3LzgxqEU20mvVzSuVtPAKAkRa7ROlimXV9?=
 =?us-ascii?Q?6/NxNaTwfVwXffHO9FC5Cmj3Wuxdjcn+C886avMaN67yPLO0Mjq/w6/8V/SJ?=
 =?us-ascii?Q?WbYl2zEjX6LtL3iO0MHyC2mttaPw53VEM5XW51sA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593f749c-7ead-462d-114d-08dcd0fb9eff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 18:17:10.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mw/Ml/tiZi4ZyOZYEATe0c67O4LFvHlae90nzvW0+VQ/eJgAbLOrtQ6o5PXyGZJ11kqO0GSHNoIameDTAOFf+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9994

On Mon, Sep 09, 2024 at 05:36:07PM +0100, Martyn Welch wrote:
> The ls1028ardb uses the TI ina220 power monitor. This device has an IIO and
> hwmon drivers, but can't be used with both at the same time.

> To enable us
> to utilise the iio framework, but also access power information via the
> hwmon framework, add an iio-hwmon map. This allows the IIO driver to be
> used for the ina220, with the iio-hwmon driver mapping the data from the
> IIO framework into hwmon.

Can you simply said:

Add an iio-hwmon map to utilise the iio framework and access power
information via the hwmon framework at the same time.

Frank
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index ecd2c1e..b062de5 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -94,6 +94,12 @@ simple-audio-card,codec {
>  			system-clock-frequency = <25000000>;
>  		};
>  	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&ina220 0>, <&ina220 1>,
> +			<&ina220 2>, <&ina220 3>;
> +	};
>  };
>
>  &can0 {
> @@ -222,8 +228,9 @@ i2c@2 {
>  			#size-cells = <0>;
>  			reg = <0x02>;
>
> -			current-monitor@40 {
> +			ina220: current-monitor@40 {
>  				compatible = "ti,ina220";
> +				#io-channel-cells = <1>;
>  				reg = <0x40>;
>  				shunt-resistor = <500>;
>  			};

