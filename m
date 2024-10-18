Return-Path: <linux-kernel+bounces-372321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D3E9A471F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C6C1C21EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F573477;
	Fri, 18 Oct 2024 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D9AsXbTE"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A9757F3;
	Fri, 18 Oct 2024 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280355; cv=fail; b=hBW+LEOFUWbnKz4J7YjYv61UG/U57/buOpJItxcliv23iAE61QnIJlnyNRJcmB+0Y4lhJ4ucg29OyGuoJbkg3eWas8V7c6zNH/498Pl40WN3BjQgMX9OhgT361AiQPvhPop5aiOIwUg0HvmNaodc4IFb47plSW4Ifk0+U4og/0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280355; c=relaxed/simple;
	bh=kC97CuLrMGzMPst32+ycRaI6xUgXYa+gkO9+0ufGwgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uAFC7YaNNhzIz7BhFT7kuaO1NiJpoz4kFypXMX0np54Di8LsfNxrGICJnWCIEOvQ1FsY8ekAx2zcoDPyED/vJePoivIgh3IDntMgVGXX558pcs7qKJRZPRFxB3YNmoaftFiBEaRmzEfNq35ngjhLprpQtA5CSzexaCmcrTbCB0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D9AsXbTE; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYaLNEHTR4DlCfk3FGKmcjEmDLuJVqyE+geL/wl3Jlw6KSezVauMXAIC4iwyo/NWq1ffL+akG4F5JI/3urdvhFgceD6PtwnA+vQX4ixJFf/XGUl94txIRX+VXSKAwkcmEXu2GqB5vJLsFiH5KKT0RCHZl7thMW4AivH2sjxbv9AtHlgGEwlNzhCvP79F/CF97WfpclFZ8+0ebsrUvOWlsJdpJ3X0HsaIsi9eYM0BVIV5e+pJBHahoS02/SGXnnLfTZYb1Jc0I6FdS1fxwAiq0ezIjRpwid8YHzJZp63pokGsKvdPqbVhWNk2WcCe7DHtMivfPuV++g+2Ze5aXS8Nbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIXeiLvf4nMrSe0nkgrWiReR/VMgkEMls06/P/f3RDU=;
 b=Uo5N9ixNmbPNojlRMcTaXNFs2wZ11kKekDu6njb/aYA6NxxHCqtcYgkQmY1KuL6kPPtqn9FD/RyL7Ja4PbF6fFldPoajjj5IbabNZJdg41sf3NC55Pz1FTIpU680dKX0ShJN2AhpxLWgJc7Xjxd7bHRcS2UckRsnO/W3oA055MqXpRduTlkxv7JCOdDqbWSFXylvpcQNWEupC161smhF2BLzn5ezMojd5eA/SwBiL7UdIDHOIdH51tkAlxg9F7DuIn68HSYkARMCSWNmZ5i/CYdWy5ID9wWYi/PwgfjdNvtMKJZnfrvP+w49xIZc3SpFZYN6CVPq9hN/wY7cO2oySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIXeiLvf4nMrSe0nkgrWiReR/VMgkEMls06/P/f3RDU=;
 b=D9AsXbTEq1xheX8qpycoOHVNQipljC+3rXto+xx80/COA/LUlBwc6OD/UX8Bjm80k8Bp30Nad/OWbVErMS9Ml4MQVAMTknKp9iFShfHpfDcRMpbc27vgviCeaSTZjHP2B0UNuE5p7CY6P9q24JZ4nWsu9YtdF7RH4fJrC20LBKMxMd1UxQ2kAxMvoCepvZEu+SfsE+3dn6y3wkoC04/Hd/+BYICgwDjE4I2pLR9cXqjbqmSzvjvSNwhdTiE/DHX8NuKSvFYV7kcuPA7ZngTEaPt1aXsa8lcnmS23IsuPQKeITGa7YykCcPvA9ZS4RajYEbUAw1Ej0ZV9hOf6D9wmkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 19:39:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 19:39:10 +0000
Date: Fri, 18 Oct 2024 15:39:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/6] arm64: dts: imx8qxp-mek: add bluetooth audio codec
Message-ID: <ZxK5VqKzvZLE8DHM@lizhi-Precision-Tower-5810>
References: <20240930212604.118756-1-Frank.Li@nxp.com>
 <172784021530.525807.17173207157125562594.robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172784021530.525807.17173207157125562594.robh@kernel.org>
X-ClientProxiedBy: BY5PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5bb759-6610-4b6e-40d4-08dcefac8968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nK11EME23tMOxx4RvEuXBsyhGBf+i7yw3dYxoGmQkQaCiB0KqKcctbSCrlhn?=
 =?us-ascii?Q?koYvQtWAW7K+QBpL5mtfhOeVwo5RO7rhLU56TBTRfF+rncwnk85kBltOvpnP?=
 =?us-ascii?Q?PN0ydxc2910JCcvpNKqDupr4BdXXpdOn27+ZdycgHXCUXj2Nh9E5jPnk9s2S?=
 =?us-ascii?Q?7NhH3YrGSRCh6uK4XlALkCahVSFsEiby26BWjypnqVkdsQ7BriyvOvLS3rXd?=
 =?us-ascii?Q?VljVulyvcQuYyYtVqsSmGSJe32fOkE2A2dlVG6TUfRhP6sh6hOtkUQjong11?=
 =?us-ascii?Q?1DM9KaGzbw1np7kXR7UmhjLUdHBAlItJgiwCYXUttDxe2fJBNXFpP6l59z9x?=
 =?us-ascii?Q?7kYfa8jSEV0+ymmGpeg81eCJZ5YMJY4qpShBVCUjGbsFidwGR1VgFTvvFvja?=
 =?us-ascii?Q?3ZbywztrVknoMVnFSgCfLin45rPwT6+5EPitXE9pJxVkWadUJ4+WI34wurdi?=
 =?us-ascii?Q?c0u9/yMtPH3m+aMVEklZjGsEdNev7+hjK5GoGaxHVkRnJJcn1QpX44qAHZlZ?=
 =?us-ascii?Q?X9uBEXUR13q4E3DHjoB1+BTUpcFT/kRTGhgDjXRQOrOtL7o64GpAnIBGZdO0?=
 =?us-ascii?Q?vmiFWWNuzNh12448YXdgaGbEkYamLkGf+sGm8+hFjCt9dy7Y6vPM8epxUGjy?=
 =?us-ascii?Q?xtFq57H5zcm5V0fnBXilmZFn9MekrQn8QMBpFH48kUcQW4s0u4fjdr1WnVLc?=
 =?us-ascii?Q?yguWlt20Q0oQ1utmoniTKnlTCUbeHSg8j6mTfhUVTWoDhvJNrpVAUdLCTOUG?=
 =?us-ascii?Q?iREV8VkUm7KyxduiOGahtPpAvl4FjjSGdslWA3qFdbvcrJQ0cacUeUNFDBn1?=
 =?us-ascii?Q?ylcFNyt5qkslb5L0QRF+MK+jPydOUgu+3y32B1z+UVbiFwFq7yot9lFqct/g?=
 =?us-ascii?Q?NihYwoPIDLG03UOlyiwToOS4tENImNxCvIsa9k2rQApAPch1Ylj6Z9XcHWkG?=
 =?us-ascii?Q?JbUJ4tPE8g6odj8L3PF7mjTWhs6ac/Gqc/C4amHA/Uw90WPch1QLslcF0JUt?=
 =?us-ascii?Q?5oTuiwTZU+K5lL7i6ECJBxGz4EdirLRW4Ae1Yev1f3QI39o2nUuvm2ArsLxd?=
 =?us-ascii?Q?kfQS6bV1G5i9opprymU5iNZwbaTXZndThHkIGc24B59Aogr/vAiVI1hKMVow?=
 =?us-ascii?Q?Cw+vXvsmaSIct5xOtlJ5bGKPLLJIpE2Gymp/Ck3KbvIa3ieJsoXsB8LotDxS?=
 =?us-ascii?Q?Mmx4UWhKz/cnvkfIfnNcL8fM4nClLG0GPiGocktNpq7K5f8i/b8TnQYHkxKV?=
 =?us-ascii?Q?b8yh8lGNDMlFWhNIx95gap7IqFVfkGhDh7FGGpb9oC4bqqrxy0/yilQVUb42?=
 =?us-ascii?Q?8KhijHzmbAJK4HVDuEMP4rBS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8N7TIsAWzP3GHQiwld7zEaVfuGIqUhVzN5CJI9SxG0PFDYlJPcP4w22oN99R?=
 =?us-ascii?Q?2YejSh1Ns2pCCGw6S7m/q+eN/LzEE7xk+irtrl0VLPWBPkcdsipHy3wnYSKe?=
 =?us-ascii?Q?y1YjVB80j3gdvPLoUbHtIuUzxaxMhPOxruOJnrneK94NRq6HGpW8ZHeWI8jL?=
 =?us-ascii?Q?QKjMz0sysWoI0wPFgN8eEegt3LYd5duIkS4gNF3R2edsXUmxzgTpvvUPGNTJ?=
 =?us-ascii?Q?wl+hRWTfMCLM/zDqkhkPJ86tNs4BXWn+DhXk9Iwba5tQGR13FwgMV277PGoj?=
 =?us-ascii?Q?rZC7oOv6Nk6ssKZWh4SlknUeyRd164529wPpW25tUvvAkbDDx+HhtNtW6T+E?=
 =?us-ascii?Q?q8yPCnvKY4OXMbK97xI2ode2CgucOuDUc7sDqJYPsmvv08CtpWuLOyPb7OZ0?=
 =?us-ascii?Q?AOItkWW++8IzFbZYhf6xNfPeQ9ZA3lLc8vOWuKvDVN6OBB+qe49k5d7IQm1s?=
 =?us-ascii?Q?/ooSabaZINko5mc+zY2FZFKcr4N4BdbfRpwTDlRu1FBR/7AGXt6/HiUXcwVR?=
 =?us-ascii?Q?29A6vHBruMgyGfLeXfPdYzKgomnrNi4XX6q0kyLbY7mYnRbwDxBgBLoWE/73?=
 =?us-ascii?Q?BkE8CLokEQQaWGLYJDV8KjRtXGKtnoPUZG7IWpCil4rJVM+3q1Czu/YkJdNb?=
 =?us-ascii?Q?vnGuVBemIdy2xCk4wqAYxJSQAUyELUyrFSrGvr3w+WWvjP2CZtGVJj4aNaA2?=
 =?us-ascii?Q?QvEf0wEUvzYeAy6Vq2L/w30t0wHGfCZ3LFsm+zQ50qFI6Uzx6Q8kRHfaRzDe?=
 =?us-ascii?Q?6tP82sBN/DafimTVe2zgT/usOzUFEsmDMroJZbimlcfnP/o5JsSAslqJ7van?=
 =?us-ascii?Q?7bzFpbb8oR0hhCYyt1ZNH42qTA9en92OTL6Rh4fOQhhPPXNClfioqmcBTmZX?=
 =?us-ascii?Q?M5FnL9zToPaRNMEB9p3bf0uZcOPtgKkqFW3fsXTbXfHGBv8zq2Br2o9lk8hl?=
 =?us-ascii?Q?4SXLWBTAk1TMbfOnnQHvaVdxaAg67qBvcmysCEp0xIQe+9vW4i1N48oeKWX8?=
 =?us-ascii?Q?nRJf/aQ4uDomNZt8Pj4BL4XXhv95K1rbDSyRwJKDOhseqoZtzg2umFbNyN+J?=
 =?us-ascii?Q?l1tBTNNlbZY7usD39Rno0o+E7bvf+7UTVyrPzxR5EMs2oORe5+qZgl8J31pJ?=
 =?us-ascii?Q?y4GsGW5jV8bSYzSbeww14c9ZF2Ky6QSVRlXKJFpp44+psXFs8riehCZd0YyV?=
 =?us-ascii?Q?sO82giZICOb9YPWHE9TyTgzKoXGWqGMwTNkUjLck3Y7xjR5AeYSKA3ik4VoG?=
 =?us-ascii?Q?9gJulJcnzbEbftAB14HY8oaJef9hS2YscqOlpR2p8jek6mwHIwU6UJm3i6oP?=
 =?us-ascii?Q?6FEMKU367ETss1LcHZ/BqDDHBgoHNlVU6vwh7fPrynGF3dxKRXlOb4y0QQGl?=
 =?us-ascii?Q?bC1QH0uu4TkRMlzLyoz2CcIX5eBmn7HuqNwUa6khiZHhHNa3CxLyXiN2erbg?=
 =?us-ascii?Q?snrj9TlfUdvQT1pLCpQ/FXbgWHwQHWyuhSDhRvOh5RBK/h6VRYzPgeQVF4j2?=
 =?us-ascii?Q?VV2ciM++JHFm2W6vUCsfuEwSedDG2tT0GrXKtvWoI8UkosafxURc3ofz0dYZ?=
 =?us-ascii?Q?SX8m0R6ag4qM3zNniSY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5bb759-6610-4b6e-40d4-08dcefac8968
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:39:09.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SYbtH1yW9gsLXeQcjBgjS6KlU3AhLWy9Q4Cj1dKyhA122GFeSLoUTrMRAlFxD3nV+GJVtabrJ52lD/tbZjQIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

On Tue, Oct 01, 2024 at 10:51:01PM -0500, Rob Herring (Arm) wrote:
>
> On Mon, 30 Sep 2024 17:25:58 -0400, Frank Li wrote:
> > Add bluetooth audio codec.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >

shawn:
	Do you have chance to check these patches. The below warning is not
caused by these patches. And this warning's fixed patch already in mail
list.

Frank

>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=y freescale/imx8qxp-mek.dtb' for 20240930212604.118756-1-Frank.Li@nxp.com:
>
> arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: usbphy@5b100000: 'nxp,sim' is a required property
> 	from schema $id: http://devicetree.org/schemas/phy/fsl,mxs-usbphy.yaml#
>
>
>
>
>

