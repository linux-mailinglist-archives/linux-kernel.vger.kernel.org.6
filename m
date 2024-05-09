Return-Path: <linux-kernel+bounces-174603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CA08C1171
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD149281ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010370CC9;
	Thu,  9 May 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o26xxa6B"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0A2BCFF;
	Thu,  9 May 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265864; cv=fail; b=kSWXA5JZf+0yx6466rPAjjdt2Fzeu22ar4pirM2rb9yZDIKrxXZFTBmY6jnnx8jfoX2ekagOwxTGDxzc8Rc8ysgaP6qz+6VYlGG3AI3pliov1st9jL33bNpfZctFux1QlPRs2LbWRDyuVYkeDyr2J0QRu9zsqeZpuqa4rYEIWAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265864; c=relaxed/simple;
	bh=ADSNkK/HDekIPfR8SnMcoSh0AzqgnGFla64w66ZME1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hRxjl+IIutxwjARMMKHG7V3G7qiZIui182CKzkFsbc9Ay8442IpfplBDSnTpRCryqE1pfT+DueZW7HAQQxjzyYfXXcfhYysT2/rvzCYN4d73s1qsPyqv+YhUtPXwII2KaoxfJva6SpQbATdJQfh9f9NzdYXvOgzzQ+cILgCvOnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o26xxa6B; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaaFXU144Lq9rjtmbsbED93t2R3oc5K/cZhA7zWF9rinSh1xBJwzUJgujq1if9QQnTMC86JibF49iZVmloJ+a6jlHQ9DCQ8Br8t+GARcc3kBt25W5M7WjHJ++pwuFO+3dZScgOGIfBFmh6X3A2/21fY32+QW8geWIn3834z4aw6U34jSGVFjmEMa4l/kUaMpe58aZpAMZfGQGFWK3PKb0PNOXTQm21Dos1umCIL7y1P+r81/EgDjBOzV9G4W5PYC+6MvzD1onK0SHmgnLdZq5iXR2HXUY/AM+NBCTBCUTREsEKCIwR3fKZHc+0JMXtyI3R3oSVoChcKpayM8oo5Log==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWcQg1NyGcM/Q+FgzgUQW5cGI5J7Ec5aPqvwWBtrKZ8=;
 b=FprJfnRsqX1giTvWcGCX9BRTfTQ0wibTun9rKgZGoojdQZC53N0tGxfSsxQ9FR6KVyrQqltPyXuRbawealZolf3h76v1lm7+Edb+aJulIlJ9S7I4SSckr9WilWhFzUIH/X2ukRqU5hZcOlE/Vku9YxAgI+Cws7AD632L3eQCSAP8+UZcvpgsH69PpXVwVC0P+JLS7/Thsjetw7xVOJhwdQ8eCdORhnlALgO5HiqwW2kgCPhnPz3pvo/6p5EmvrufKQe1gME3X8MP3Uf4jf+nPZzlnotdcXvcbO461IaXOP/lukYKyuXQU5q8WZY/6PPiw8ejsf49w1Bs7kEXL2ne+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWcQg1NyGcM/Q+FgzgUQW5cGI5J7Ec5aPqvwWBtrKZ8=;
 b=o26xxa6Bbhs+lMTivTUOfP/WhO9WqHryjkR0INa27mAxQpEhAOnw/uQRmd5+DDCqEHlarq8LJYi+aOeIpAMyn/n4dgPBKO+JqdpXq0u8Xjsfm7y0gGTwJYxD0xERbR942iJ9C2P1lu11+XtzcKBYymm6P1SYlQmwCG5bOtMhzwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9647.eurprd04.prod.outlook.com (2603:10a6:10:30b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Thu, 9 May
 2024 14:44:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.041; Thu, 9 May 2024
 14:44:17 +0000
Date: Thu, 9 May 2024 10:44:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: conor@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 3/3] phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY
 driver support
Message-ID: <ZjzhOOSWE4pY1wEY@lizhi-Precision-Tower-5810>
References: <1715234181-672-1-git-send-email-hongxing.zhu@nxp.com>
 <1715234181-672-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715234181-672-4-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 5387bf7e-70dd-4357-be37-08dc703680e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|52116005|1800799015|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/xavW/6iIPhjTTAwoNWMYPlVlvpskM4ZrU1OcbG9ZlPxyjlAPK7Xob1u1SSI?=
 =?us-ascii?Q?s5OLMWIettzl9Kq5JxlBsrDSRyho91FMQglnQMEg2d3bxEOiixyqPY55tEbf?=
 =?us-ascii?Q?VeViQ/Z6DC1u66VEuXrykjpZsaXuV6PXphkWryB7dLi/maX5+CznPYkLerKI?=
 =?us-ascii?Q?2z+6Wy60DgqJjRQiijVJ7qQ+htvT1wRoLs6upZfkgPyfxQPXTDDQA6L9bB4P?=
 =?us-ascii?Q?RAy8QyG777EOlx9XK3qz99xNds+Gb5HtHs1otvosFFO1WrEu38SWcgKtK1N8?=
 =?us-ascii?Q?rj1l8r/nChd0ab4otazrAqw69SpFRaZgw7pKUFZAsMi8Waq+5I3f2GS/Zdjp?=
 =?us-ascii?Q?CL9JLhSqVsvdItszA4+TQ51iSYbUvxaCyl9hJE7RMWbQ+9aaVDI3SV19XRQ8?=
 =?us-ascii?Q?/bpjNeFmxNAfUG7IsDblnQoF7UwMLVFDvctr+xSHAHnkbBgXc97t5utc98Xn?=
 =?us-ascii?Q?T/Nc55ENllA42bVZEZzgUx673IMPYtj1ChKVJFBrADUI9+emnxCH2Z6IejlY?=
 =?us-ascii?Q?YFHiIw/ygTQypDQHf/QAzpOgbdhUj11DZplV3XdYX+Vvu9qN/q5+rzXaR1by?=
 =?us-ascii?Q?QiwHarXoHSminOGDuv9hD6FfCM0a9MwiPvstG1C37/MLgLvRV4HhlKnb1pLB?=
 =?us-ascii?Q?ZAXE1ybgJ/kNlUb1QKhc8ZM90LkkOVk4vdRRWaH8VPY8Gdh7TUOOAavg48sd?=
 =?us-ascii?Q?uy3ci4APfzLZ+2E3G0g4aP9XHLutsuG4vBAO8Kcj/IJ5+C4xPLou5NgOTmL+?=
 =?us-ascii?Q?5SjMuqlkQ34kzeUZq43aUWvTTTiN+YGl26HtGzD2kS8N4yD2TnmVQslIX9gS?=
 =?us-ascii?Q?sDqWjn0NjhUVD9sCacJ2vitPscsefwjr80gUw0tRu7MUUnj8E4OLoXeDQVud?=
 =?us-ascii?Q?Bxg44sNXJw1/liD0D1M16OPPtpeiSrfQQQh7RvQLeynKX83I4K0cYyJGWJlB?=
 =?us-ascii?Q?6tfSAkHE1miMP0xdTwLizrkicDaPewg7jxnx8iG+OOHZJIa8CqyMUZxb7ApS?=
 =?us-ascii?Q?QGpL5OQf2WBGL9vSbrbjQJJ9RLCvyoc3tYMqhTuYHWpoB9CMZjCP9kCupQkD?=
 =?us-ascii?Q?A0uApcpuQiU6yf6O6ne24hvXYgR9iGouzPxvF85cUs3UWJuxPEZXcn0yVlLu?=
 =?us-ascii?Q?7OuSOAwn712YPkVY+y8XMr/PyvlMu9DiLuudjMG5R+0crJuXoAKEWN9Y6JJx?=
 =?us-ascii?Q?hQ1RXVnvpFizo/AcS9FR6kWpSHWZdaCZRFkCLZ/OJjW063jgPEn24/wkfvas?=
 =?us-ascii?Q?t1I2o4DVdofkG3NS/ofCipfDWtfPhM5Cfoet+9DBR6dzLs7mcWdaWIZPKJja?=
 =?us-ascii?Q?OCsAmunxJsZ1CD5l6fZK/mrwXSryVZD9eQ2pAaC9d8UTbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(1800799015)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EEGzTtuq8NCcgzUtbr9uNNpkNIn8lg+c+o0+XyZtuvkceAtx5F3I4MkXbY9h?=
 =?us-ascii?Q?b2cU78EQkRk8y83PHQE6avFWPpKXUZfvAoQqu734sSvZb9Ll/tYlp8xtuj3F?=
 =?us-ascii?Q?tcSaqQZ19VtFsT5XY63tUcsHJ/SeD82mMTii6lG7CCkY/1e4QIfVqsRGZRbW?=
 =?us-ascii?Q?DU5g2m6oHls4FtVXeMVaeMRefe5tABKoCb3qtSWj1yA/LKs+I5zuMd1kPgku?=
 =?us-ascii?Q?nRWfo42xJDfPxRewQyU0bHSWi/BdYfMsJtxQrrixdJ6pka329oadzfdCePRy?=
 =?us-ascii?Q?/xF6HlUeizd6I7F1CIRO3LSCv4mTBzhfc7Bw+hNeJVNRiRZxqFuHILtKmwvT?=
 =?us-ascii?Q?Eg0zasCmA0AfmiqvvclK2c4jFSR2Zgzrk1b4OXlmHfrCGZ2n8ymUBqyENWy5?=
 =?us-ascii?Q?eQTGaCkB59dcoXIFHaN+U+0xl5jN3DN4AkFzpbuF6qBO9oPgrm/grprGlvA6?=
 =?us-ascii?Q?MPDQG14y9YwlSFmECoFy0jl3hn+0rjGFOlO2J9sneJlHSQ7JaF1Lq+1f1Lbb?=
 =?us-ascii?Q?JebqXnaBd1z8i99JSR4Acq5EdxxY/kBxDskBqjXeZf87E+f158ReYzKfemag?=
 =?us-ascii?Q?frMX4G6SN6lEtY7Mtb/OWZAn5r4ai2rQdzKFpxLUSRPuh9IlfAy9xYQ+8BiT?=
 =?us-ascii?Q?OIR4uh8hCzqYdHWrPPkpR7ixl1lDcKZLB8fmNeynvnnopfeO2+oegV7Df1vC?=
 =?us-ascii?Q?g61zVBECLFLPKCmBQKwhrH6Lp7fSVewqygOA3mlpIQV14qtL5BjhvNfAB6o3?=
 =?us-ascii?Q?5F8iUS2A3fouT3AKdwwfkfXWLYcIIcwfHJhE2d/7oqKkepCY20rAhy+Esq4a?=
 =?us-ascii?Q?Eww5b2oHYlnxAufIrdayelGPN3WGQGNC/DsbCGZbPOoulC15G7AWbie0w8oj?=
 =?us-ascii?Q?VIcx8oa5E4WZq+80VD2QWGKQmK9Ar+GVMkYpOWch7Je0AzmJ7LF1Cq0akQv2?=
 =?us-ascii?Q?h0/nlze0ZnG7fFEPorzWL9RPSFiGiES4ls1FJepE3zLowvlO2sw66tcH/XRR?=
 =?us-ascii?Q?h13sNmV1IhDdW+qygL04j6Cvty2YqQnWtvZEvnnlmLSdstYNOIPtTAfJ47lM?=
 =?us-ascii?Q?MLLOVZ/L5P9FGCc75EfM96yB2OFPooMRQd1sVA6IoGNZDgsJPjNg0ui+pIn4?=
 =?us-ascii?Q?M1eyZLHVGdl8W4dkl5WTPzxv4xgMxCU+H4CsGRxsMfowgvBiCmyMT3Z8K3tC?=
 =?us-ascii?Q?HqnQzHB2AJOyY82fV1CTn4sA68KqqVoDAD5aN2Y4Qjou/g1JpyqUHzDHLVi3?=
 =?us-ascii?Q?IPSmySsoTAf3XK6bVy7ghiLai/R55IggCnq1xfHw1uRI7mZDWefMncnJcbgN?=
 =?us-ascii?Q?w+R25CwEN++l0Zf2MidSh+rgX/OePqehUpkxW3coTx9I2NqTo+GDgToebDoj?=
 =?us-ascii?Q?X41B9w+PWMf1tAtt9ag9y0gqlg4mlNyE9u+8HG3++kbsB4NYBSY4rw8hPbf+?=
 =?us-ascii?Q?KN5T6i8Cy34qYY3PWdxZlUVtg2ASX++XtWIh7XVOfVA4Xz2LUR/WuG9C8TUy?=
 =?us-ascii?Q?xJxpZiuPsd9ExkZfWCS1dzvDjcxNGZHCdgUXqhe88/xubhEI5tHwDnAIhJRy?=
 =?us-ascii?Q?dp//Wa474LYP7PhCdb4sqY9NX6YELAzp8yWZHHuh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5387bf7e-70dd-4357-be37-08dc703680e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 14:44:17.5357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWlcHG1Hq/rT3BPCRc8/yGN85+A6uC8b0rPjbRvqJHBYls5nZMDKnK6lGU9Gs9BDvWBo5yNuqAWHr2/1kXMJKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9647

On Thu, May 09, 2024 at 01:56:21PM +0800, Richard Zhu wrote:
> Add i.MX8QM HSIO PHY driver support.
> 
> i.MX8QM HSIO has three lane PHY instances, and can be bound to the
> following controllers in the different use cases listed in below table.
> - two lanes capable PCIEA controller.
> - one lane PCIEB controller.
> - AHCI SATA controller.
> 
> i.MX8QM HSIO PHYs support the following use cases.
> +----------------------------------------------------+
> |                               | Lane0| Lane1| Lane2|
> |-------------------------------|------|------|------|
> | use case 1: PCIEAX2SATA       | PCIEA| PCIEA| SATA |
> |-------------------------------|------|------|------|
> | use case 2: PCIEAX2PCIEB      | PCIEA| PCIEA| PCIEB|
> |-------------------------------|------|------|------|
> | use case 3: PCIEAPCIEBSATA    | PCIEA| PCIEB| SATA |
> +----------------------------------------------------+
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/phy/freescale/Kconfig               |   8 +
>  drivers/phy/freescale/Makefile              |   1 +
>  drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 598 ++++++++++++++++++++
>  3 files changed, 607 insertions(+)
>  create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> 
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> index 853958fb2c06..c9ee48aeea9e 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -35,6 +35,14 @@ config PHY_FSL_IMX8M_PCIE
>  	  Enable this to add support for the PCIE PHY as found on
>  	  i.MX8M family of SOCs.
>  
> +config PHY_FSL_IMX8QM_HSIO
> +	tristate "Freescale i.MX8QM HSIO PHY"
> +	depends on OF && HAS_IOMEM
> +	select GENERIC_PHY
> +	help
> +	  Enable this to add support for the HSIO PHY as found on
> +	  i.MX8QM family of SOCs.
> +
>  endif
>  
>  config PHY_FSL_LYNX_28G
> diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
> index cedb328bc4d2..b56b4d5c18ea 100644
> --- a/drivers/phy/freescale/Makefile
> +++ b/drivers/phy/freescale/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+= phy-fsl-imx8mq-usb.o
>  obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)	+= phy-fsl-imx8qm-lvds-phy.o
>  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
>  obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
> +obj-$(CONFIG_PHY_FSL_IMX8QM_HSIO)	+= phy-fsl-imx8qm-hsio.o
>  obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
> diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> new file mode 100644
> index 000000000000..90b57a6893c9
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> @@ -0,0 +1,598 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pci_regs.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/pcie.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +#define MAX_NUM_LANE	3
> +#define LANE_NUM_CLKS	5
> +
> +/* Parameters for the waiting for PCIe PHY PLL to lock */
> +#define PHY_INIT_WAIT_USLEEP_MAX	10
> +#define PHY_INIT_WAIT_TIMEOUT		(1000 * PHY_INIT_WAIT_USLEEP_MAX)
> +
> +/* i.MX8Q HSIO registers */
> +#define HSIO_CTRL0			0x0
> +#define HSIO_APB_RSTN_0			BIT(0)
> +#define HSIO_APB_RSTN_1			BIT(1)
> +#define HSIO_PIPE_RSTN_0_MASK		GENMASK(25, 24)
> +#define HSIO_PIPE_RSTN_1_MASK		GENMASK(27, 26)
> +#define HSIO_MODE_MASK			GENMASK(20, 17)
> +#define HSIO_MODE_PCIE			0x0
> +#define HSIO_MODE_SATA			0x4
> +#define HSIO_DEVICE_TYPE_MASK		GENMASK(27, 24)
> +#define HSIO_EPCS_TXDEEMP		BIT(5)
> +#define HSIO_EPCS_TXDEEMP_SEL		BIT(6)
> +#define HSIO_EPCS_PHYRESET_N		BIT(7)
> +#define HSIO_RESET_N			BIT(12)
> +
> +#define HSIO_IOB_RXENA			BIT(0)
> +#define HSIO_IOB_TXENA			BIT(1)
> +#define HSIO_IOB_A_0_TXOE		BIT(2)
> +#define HSIO_IOB_A_0_M1M0_2		BIT(4)
> +#define HSIO_IOB_A_0_M1M0_MASK		GENMASK(4, 3)
> +#define HSIO_PHYX1_EPCS_SEL		BIT(12)
> +#define HSIO_PCIE_AB_SELECT		BIT(13)
> +
> +#define HSIO_PHY_STS0			0x4
> +#define HSIO_LANE0_TX_PLL_LOCK		BIT(4)
> +#define HSIO_LANE1_TX_PLL_LOCK		BIT(12)
> +
> +#define HSIO_CTRL2			0x8
> +#define HSIO_LTSSM_ENABLE		BIT(4)
> +#define HSIO_BUTTON_RST_N		BIT(21)
> +#define HSIO_PERST_N			BIT(22)
> +#define HSIO_POWER_UP_RST_N		BIT(23)
> +
> +#define HSIO_PCIE_STS0			0xc
> +#define HSIO_PM_REQ_CORE_RST		BIT(19)
> +
> +#define HSIO_REG48_PMA_STATUS		0x30
> +#define HSIO_REG48_PMA_RDY		BIT(7)
> +
> +struct imx_hsio_drvdata {
> +	int lane_num;
> +};
> +
> +struct imx_hsio_lane {
> +	u32 ctrl_index;
> +	u32 ctrl_off;
> +	u32 idx;
> +	u32 phy_off;
> +	u32 phy_type;
> +	const char * const *clk_names;
> +	struct clk_bulk_data clks[LANE_NUM_CLKS];
> +	struct imx_hsio_priv *priv;
> +	struct phy *phy;
> +	enum phy_mode phy_mode;
> +};
> +
> +struct imx_hsio_priv {
> +	void __iomem *base;
> +	struct device *dev;
> +	atomic_t open_cnt;
> +	const char *refclk_pad;
> +	u32 hsio_cfg;
> +	struct regmap *phy;
> +	struct regmap *ctrl;
> +	struct regmap *misc;
> +	const struct imx_hsio_drvdata *drvdata;
> +	struct imx_hsio_lane lane[MAX_NUM_LANE];
> +};
> +
> +static const char * const lan0_pcie_clks[] = {"apb_pclk0", "pclk0", "ctl0_crr",
> +					      "phy0_crr", "misc_crr"};
> +static const char * const lan1_pciea_clks[] = {"apb_pclk1", "pclk1", "ctl0_crr",
> +					       "phy0_crr", "misc_crr"};
> +static const char * const lan1_pcieb_clks[] = {"apb_pclk1", "pclk1", "ctl1_crr",
> +					       "phy0_crr", "misc_crr"};
> +static const char * const lan2_pcieb_clks[] = {"apb_pclk2", "pclk2", "ctl1_crr",
> +					       "phy1_crr", "misc_crr"};
> +static const char * const lan2_sata_clks[] = {"pclk2", "epcs_tx", "epcs_rx",
> +					      "phy1_crr", "misc_crr"};
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int imx_hsio_init(struct phy *phy)
> +{
> +	int ret, i;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +	struct device *dev = priv->dev;
> +
> +	/* Assign clocks refer to different modes */
> +	switch (lane->phy_type) {
> +	case PHY_TYPE_PCIE:
> +		lane->phy_mode = PHY_MODE_PCIE;
> +		if (lane->ctrl_index == 0) { /* PCIEA */
> +			lane->ctrl_off = 0;
> +			lane->phy_off = 0;
> +
> +			for (i = 0; i < LANE_NUM_CLKS; i++) {
> +				if (lane->idx == 0)
> +					lane->clks[i].id = lan0_pcie_clks[i];
> +				else
> +					lane->clks[i].id = lan1_pciea_clks[i];
> +			}
> +		} else { /* PCIEB */
> +			if (lane->idx == 0) { /* i.MX8QXP */
> +				lane->ctrl_off = 0;
> +				lane->phy_off = 0;
> +			} else {
> +				/*
> +				 * On i.MX8QM, only second or third lane can be
> +				 * bound to PCIEB.
> +				 */
> +				lane->ctrl_off = SZ_64K;
> +				if (lane->idx == 1)
> +					lane->phy_off = 0;
> +				else /* the third lane is bound to PCIEB */
> +					lane->phy_off = SZ_64K;
> +			}
> +
> +			for (i = 0; i < LANE_NUM_CLKS; i++) {
> +				if (lane->idx == 1)
> +					lane->clks[i].id = lan1_pcieb_clks[i];
> +				else if (lane->idx == 2)
> +					lane->clks[i].id = lan2_pcieb_clks[i];
> +				else /* i.MX8QXP only has PCIEB, idx is 0 */
> +					lane->clks[i].id = lan0_pcie_clks[i];
> +			}
> +		}
> +		break;
> +	case PHY_TYPE_SATA:
> +		/* On i.MX8QM, only the third lane can be bound to SATA */
> +		lane->phy_mode = PHY_MODE_SATA;
> +		lane->ctrl_off = SZ_128K;
> +		lane->phy_off = SZ_64K;
> +
> +		for (i = 0; i < LANE_NUM_CLKS; i++)
> +			lane->clks[i].id = lan2_sata_clks[i];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Fetch clocks and enable them */
> +	ret = devm_clk_bulk_get(dev, LANE_NUM_CLKS, lane->clks);
> +	if (ret)
> +		return ret;
> +	ret = clk_bulk_prepare_enable(LANE_NUM_CLKS, lane->clks);
> +	if (ret)
> +		return ret;
> +
> +	/* allow the clocks to stabilize */
> +	usleep_range(200, 500);
> +	return 0;
> +}
> +
> +static int imx_hsio_exit(struct phy *phy)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +
> +	clk_bulk_disable_unprepare(LANE_NUM_CLKS, lane->clks);
> +
> +	return 0;
> +}
> +
> +static void imx_hsio_pcie_phy_resets(struct phy *phy)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			  HSIO_BUTTON_RST_N);
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			  HSIO_PERST_N);
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			  HSIO_POWER_UP_RST_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			HSIO_BUTTON_RST_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			HSIO_PERST_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			HSIO_POWER_UP_RST_N);
> +
> +	if (lane->idx == 1) {
> +		regmap_set_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +				HSIO_APB_RSTN_1);
> +		regmap_set_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +				HSIO_PIPE_RSTN_1_MASK);
> +	} else {
> +		regmap_set_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +				HSIO_APB_RSTN_0);
> +		regmap_set_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +				HSIO_PIPE_RSTN_0_MASK);
> +	}
> +}
> +
> +static void imx_hsio_sata_phy_resets(struct phy *phy)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	/* clear PHY RST, then set it */
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +			  HSIO_EPCS_PHYRESET_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +			HSIO_EPCS_PHYRESET_N);
> +
> +	/* CTRL RST: SET -> delay 1 us -> CLEAR -> SET */
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0, HSIO_RESET_N);
> +	udelay(1);
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +			  HSIO_RESET_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0, HSIO_RESET_N);
> +}
> +
> +static void imx_hsio_configure_clk_pad(struct phy *phy)
> +{
> +	bool pll = false;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	if (strncmp(priv->refclk_pad, "output", 6) == 0) {
> +		pll = true;
> +		regmap_update_bits(priv->misc, HSIO_CTRL0,
> +				   HSIO_IOB_A_0_TXOE | HSIO_IOB_A_0_M1M0_MASK,
> +				   HSIO_IOB_A_0_TXOE | HSIO_IOB_A_0_M1M0_2);
> +	} else {
> +		regmap_update_bits(priv->misc, HSIO_CTRL0,
> +				   HSIO_IOB_A_0_TXOE | HSIO_IOB_A_0_M1M0_MASK,
> +				   0);
> +	}
> +
> +	regmap_update_bits(priv->misc, HSIO_CTRL0, HSIO_IOB_RXENA,
> +			   pll ? 0 : HSIO_IOB_RXENA);
> +	regmap_update_bits(priv->misc, HSIO_CTRL0, HSIO_IOB_TXENA,
> +			   pll ? HSIO_IOB_TXENA : 0);
> +}
> +
> +static void imx_hsio_pre_set(struct phy *phy)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	atomic_set(&priv->open_cnt, 1);
> +	if (priv->hsio_cfg & IMX8Q_HSIO_CFG_PCIEAX2PCIEB)
> +		regmap_set_bits(priv->misc, HSIO_CTRL0, HSIO_PCIE_AB_SELECT);
> +	if (priv->hsio_cfg & IMX8Q_HSIO_CFG_PCIEAX2SATA)
> +		regmap_set_bits(priv->misc, HSIO_CTRL0, HSIO_PHYX1_EPCS_SEL);
> +
> +	imx_hsio_configure_clk_pad(phy);
> +}
> +
> +static int imx_hsio_pcie_power_on(struct phy *phy)
> +{
> +	int ret;
> +	u32 val, addr, cond;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	imx_hsio_pcie_phy_resets(phy);
> +
> +	/* Toggle apb_pclk to make sure PM_REQ_CORE_RST is cleared. */
> +	clk_disable_unprepare(lane->clks[0].clk);
> +	mdelay(1);
> +	ret = clk_prepare_enable(lane->clks[0].clk);
> +	if (ret) {
> +		dev_err(priv->dev, "unable to enable phy apb_pclk\n");
> +		return ret;
> +	}
> +
> +	addr = lane->ctrl_off + HSIO_PCIE_STS0;
> +	cond = HSIO_PM_REQ_CORE_RST;
> +	ret = regmap_read_poll_timeout(priv->ctrl, addr, val,
> +				       (val & cond) == 0,
> +				       PHY_INIT_WAIT_USLEEP_MAX,
> +				       PHY_INIT_WAIT_TIMEOUT);
> +	if (ret)
> +		dev_err(priv->dev, "HSIO_PM_REQ_CORE_RST is set\n");
> +	return ret;
> +}
> +
> +static int imx_hsio_sata_power_on(struct phy *phy)
> +{
> +	int ret;
> +	u32 val, cond;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	regmap_set_bits(priv->phy, lane->phy_off + HSIO_CTRL0, HSIO_APB_RSTN_0);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +			HSIO_EPCS_TXDEEMP);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +			HSIO_EPCS_TXDEEMP_SEL);
> +
> +	imx_hsio_sata_phy_resets(phy);
> +
> +	cond = HSIO_REG48_PMA_RDY;
> +	ret = read_poll_timeout(readb, val, ((val & cond) == cond),
> +				PHY_INIT_WAIT_USLEEP_MAX,
> +				PHY_INIT_WAIT_TIMEOUT, false,
> +				priv->base + HSIO_REG48_PMA_STATUS);
> +	if (ret)
> +		dev_err(priv->dev, "PHY calibration is timeout\n");
> +	else
> +		dev_dbg(priv->dev, "PHY calibration is done\n");
> +
> +	return ret;
> +}
> +
> +static int imx_hsio_power_on(struct phy *phy)
> +{
> +	int ret;
> +	u32 val, cond;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	if (atomic_inc_and_test(&priv->open_cnt))
> +		imx_hsio_pre_set(phy);

when multi client try power_on at the same time, it need wait first
imx_hsio_pre_set(phy) finish. So atomic is not enough here.

	scope_guard(mutex, &priv->lock) {
		if (!priv->open_cnt)
			imx_hsio_pre_set(phy);
		priv->open_cnt ++
	}

in power_off function
	scope_gard(mutex, &priv->lock) {
		priv->open_cnt --;
	}

> +
> +	if (lane->phy_mode == PHY_MODE_PCIE)
> +		ret = imx_hsio_pcie_power_on(phy);
> +	else /* SATA */
> +		ret = imx_hsio_sata_power_on(phy);
> +	if (ret)
> +		return ret;
> +
> +	/* Polling to check the PHY is ready or not. */
> +	if (lane->idx == 1)
> +		cond = HSIO_LANE1_TX_PLL_LOCK;
> +	else
> +		/*
> +		 * Except the phy_off, the bit-offset of lane2 is same to lane0.
> +		 * Merge the lane0 and lane2 bit-operations together.
> +		 */
> +		cond = HSIO_LANE0_TX_PLL_LOCK;
> +
> +	ret = regmap_read_poll_timeout(priv->phy, lane->phy_off + HSIO_PHY_STS0,
> +				       val, ((val & cond) == cond),
> +				       PHY_INIT_WAIT_USLEEP_MAX,
> +				       PHY_INIT_WAIT_TIMEOUT);
> +	if (ret) {
> +		dev_err(priv->dev, "IMX8Q PHY%d PLL lock timeout\n", lane->idx);
> +		return ret;
> +	}
> +	dev_dbg(priv->dev, "IMX8Q PHY%d PLL is locked\n", lane->idx);
> +
> +	return ret;
> +}
> +
> +static int imx_hsio_power_off(struct phy *phy)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	if (atomic_dec_and_test(&priv->open_cnt)) {
> +		atomic_set(&priv->open_cnt, -1);
> +		regmap_clear_bits(priv->misc, HSIO_CTRL0, HSIO_PCIE_AB_SELECT);
> +		regmap_clear_bits(priv->misc, HSIO_CTRL0, HSIO_PHYX1_EPCS_SEL);
> +
> +		if (lane->phy_mode == PHY_MODE_PCIE) {
> +			regmap_clear_bits(priv->ctrl,
> +					  lane->ctrl_off + HSIO_CTRL2,
> +					  HSIO_BUTTON_RST_N);
> +			regmap_clear_bits(priv->ctrl,
> +					  lane->ctrl_off + HSIO_CTRL2,
> +					  HSIO_PERST_N);
> +			regmap_clear_bits(priv->ctrl,
> +					  lane->ctrl_off + HSIO_CTRL2,
> +					  HSIO_POWER_UP_RST_N);
> +		} else {
> +			regmap_clear_bits(priv->ctrl,
> +					  lane->ctrl_off + HSIO_CTRL0,
> +					  HSIO_EPCS_TXDEEMP);
> +			regmap_clear_bits(priv->ctrl,
> +					  lane->ctrl_off + HSIO_CTRL0,
> +					  HSIO_EPCS_TXDEEMP_SEL);
> +			regmap_clear_bits(priv->ctrl,
> +					  lane->ctrl_off + HSIO_CTRL0,
> +					  HSIO_RESET_N);
> +		}
> +
> +		if (lane->idx == 1) {
> +			regmap_clear_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +					  HSIO_APB_RSTN_1);
> +			regmap_clear_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +					  HSIO_PIPE_RSTN_1_MASK);
> +		} else {
> +			/*
> +			 * Except the phy_off, the bit-offset of lane2 is same
> +			 * to lane0. Merge the lane0 and lane2 bit-operations
> +			 * together.
> +			 */
> +			regmap_clear_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +					  HSIO_APB_RSTN_0);
> +			regmap_clear_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +					  HSIO_PIPE_RSTN_0_MASK);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_hsio_set_mode(struct phy *phy, enum phy_mode mode,
> +			     int submode)
> +{
> +	u32 val;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	if (lane->phy_mode != mode)
> +		return -EINVAL;
> +
> +	val = (mode == PHY_MODE_PCIE) ? HSIO_MODE_PCIE : HSIO_MODE_SATA;
> +	val = FIELD_PREP(HSIO_MODE_MASK, val);
> +	regmap_update_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +			   HSIO_MODE_MASK, val);
> +
> +	switch (submode) {
> +	case PHY_MODE_PCIE_RC:
> +		val = FIELD_PREP(HSIO_DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
> +		break;
> +	case PHY_MODE_PCIE_EP:
> +		val = FIELD_PREP(HSIO_DEVICE_TYPE_MASK, PCI_EXP_TYPE_ENDPOINT);
> +		break;
> +	default: /* Support only PCIe EP and RC now. */
> +		return 0;
> +	}
> +	if (submode)
> +		regmap_update_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +				   HSIO_DEVICE_TYPE_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int imx_hsio_set_speed(struct phy *phy, int speed)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	regmap_update_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			   HSIO_LTSSM_ENABLE,
> +			   speed ? HSIO_LTSSM_ENABLE : 0);
> +	return 0;
> +}
> +
> +static const struct phy_ops imx_hsio_ops = {
> +	.init = imx_hsio_init,
> +	.exit = imx_hsio_exit,
> +	.power_on = imx_hsio_power_on,
> +	.power_off = imx_hsio_power_off,
> +	.set_mode = imx_hsio_set_mode,
> +	.set_speed = imx_hsio_set_speed,
> +	.owner = THIS_MODULE,
> +};
> +
> +static const struct imx_hsio_drvdata imx8qxp_hsio_drvdata = {
> +	.lane_num = 0x1,
> +};
> +
> +static const struct imx_hsio_drvdata imx_hsio_drvdata = {
> +	.lane_num = 0x3,
> +};
> +
> +static const struct of_device_id imx_hsio_of_match[] = {
> +	{.compatible = "fsl,imx8qm-hsio", .data = &imx_hsio_drvdata},
> +	{.compatible = "fsl,imx8qxp-hsio", .data = &imx8qxp_hsio_drvdata},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx_hsio_of_match);
> +
> +static struct phy *imx_hsio_xlate(struct device *dev,
> +				  const struct of_phandle_args *args)
> +{
> +	struct imx_hsio_priv *priv = dev_get_drvdata(dev);
> +	int idx = args->args[0];
> +	int phy_type = args->args[1];
> +	int ctrl_index = args->args[2];
> +
> +	if (idx < 0 || idx >= priv->drvdata->lane_num)
> +		return ERR_PTR(-EINVAL);
> +	priv->lane[idx].idx = idx;
> +	priv->lane[idx].phy_type = phy_type;
> +	priv->lane[idx].ctrl_index = ctrl_index;
> +
> +	return priv->lane[idx].phy;
> +}
> +
> +static int imx_hsio_probe(struct platform_device *pdev)
> +{
> +	int i;
> +	void __iomem *off;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct imx_hsio_priv *priv;
> +	struct phy_provider *provider;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +	priv->drvdata = of_device_get_match_data(dev);
> +	atomic_set(&priv->open_cnt, -1);
> +
> +	/* Get HSIO configuration mode */
> +	if (of_property_read_u32(np, "fsl,hsio-cfg", &priv->hsio_cfg))
> +		priv->hsio_cfg = 0;
> +	/* Get PHY refclk pad mode */
> +	if (of_property_read_string(np, "fsl,refclk-pad-mode",
> +				    &priv->refclk_pad))
> +		priv->refclk_pad = NULL;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "phy");
> +	priv->phy = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->phy))
> +		return dev_err_probe(dev, PTR_ERR(priv->phy),
> +				     "unable to find phy csr registers\n");
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> +	priv->ctrl = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->ctrl))
> +		return dev_err_probe(dev, PTR_ERR(priv->ctrl),
> +				     "unable to find ctrl csr registers\n");
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "misc");
> +	priv->misc = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->misc))
> +		return dev_err_probe(dev, PTR_ERR(priv->misc),
> +				     "unable to find misc csr registers\n");
> +
> +	for (i = 0; i < priv->drvdata->lane_num; i++) {
> +		struct imx_hsio_lane *lane = &priv->lane[i];
> +		struct phy *phy;
> +
> +		memset(lane, 0, sizeof(*lane));
> +
> +		phy = devm_phy_create(&pdev->dev, NULL, &imx_hsio_ops);
> +		if (IS_ERR(phy))
> +			return PTR_ERR(phy);
> +
> +		lane->priv = priv;
> +		lane->phy = phy;
> +		lane->idx = i;
> +		phy_set_drvdata(phy, lane);
> +	}
> +
> +	dev_set_drvdata(dev, priv);
> +	dev_set_drvdata(&pdev->dev, priv);
> +
> +	provider = devm_of_phy_provider_register(&pdev->dev, imx_hsio_xlate);
> +
> +	return PTR_ERR_OR_ZERO(provider);
> +}
> +
> +static struct platform_driver imx_hsio_driver = {
> +	.probe	= imx_hsio_probe,
> +	.driver = {
> +		.name	= "imx8qm-hsio-phy",
> +		.of_match_table	= imx_hsio_of_match,
> +	}
> +};
> +module_platform_driver(imx_hsio_driver);
> +
> +MODULE_DESCRIPTION("FSL IMX8QM HSIO SERDES PHY driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.37.1
> 

