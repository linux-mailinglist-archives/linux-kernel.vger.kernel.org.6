Return-Path: <linux-kernel+bounces-187976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1328CDB74
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A35283D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321D184E02;
	Thu, 23 May 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TXi23iYq"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834FAD2C;
	Thu, 23 May 2024 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496597; cv=fail; b=IocpzRvQFz8fjAuDN4jgrTiH8dnFOefhihsT2cePEqApzY/9JtCP3MoVGmFjpZ8e5bh8wqov8cLVsGe9Soss0EYE6f8S9kb3oxxxj76ptEG+rTlrUW1nxdlA29CxIlsRuklLSofZA2AWhu9TAmhSg9gdxM8siL8Hv/vcpYY1aDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496597; c=relaxed/simple;
	bh=eC7oSpjScv2OoF2ebu6Hjez6XY8upJOLK8oeEEju0q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cdWN/AdyxmRIJT+8wUgdij4/DfFEXnDlwjdLpatsm0VnB3An3e5PBX0P2XJ7jLAumltLNKBZLhv2Lot/V7ti0WhTa6bYdIa606NWyWlpaw9B8FzzxTOCOzT7zAsr62/EUx5RFln2GMHGRWBwmWduWohaRiqZ6JnQ6Q6S9/QaHsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TXi23iYq; arc=fail smtp.client-ip=40.107.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGaxnM2h/oQrn8pRQeLI1pTlgL4bmKIblVsJmxUwLcBAQioQMF6L3hLiRIABHM8zVP1vxm2c5ZVyYhMoSC16Dmu5in06KFPy+U1X1iVUwjofVc6aMm36GPWBtV9r5Yk3GqfOdq6wlhRgTevWuV5QlKHkMSQtanVppgtBTXx4KDXDtFONM2Q2CxysGwJ3OPNm3NocwG4xedJrQdotaZ6adi76m8b98ZYMtmFCOZ38CYQE1eO2Qsc8Es75PTply81FJydXcHJkE0d2YbgmaGoQYat8FhMUUxdkSW4bP7mAUPsv3MqPZ3T0iM6AKGjjpRTmKyazuqitBHBPRA/UYMGVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFc/h7jx8SaluxWxD0MOVl0oMq0kPCbFoBTZZaqraYA=;
 b=Hcho7xxZHlPSrXAXNfkmtwHYPminVg7Gtu4cFZX2eiagxPSdgq2eIzDcvPext3KhfZlGvaCFaEcMlH08JXshiniKmMJp3THNui6B8+QHtELsB8Oa1Yx2iJ+Yy3ItFzz9mvW/kTWtcUfvhORDrfuQyAQ3/3oVfbP7QpijLeXyjngPwulpCT7jtJa2DGIJiuZMwaRLWsBDqB+JwZH3N0RcDhdTpb+g2OY4XWI2rbY1bGs/a5ZWqKv8A3ovog27RwCU46Uh7FNxV/sW0u4yxj2ZgHTDl2FJYlpBcVQ0CA04IySsOi5TCIGq7tKKnmoWBLW49x/So30DSoWcX8pkVCoGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFc/h7jx8SaluxWxD0MOVl0oMq0kPCbFoBTZZaqraYA=;
 b=TXi23iYqF52EEQUPNsKG/YmWCkE2/WaIyQuPg+9WurKPlzWprY7CJkCJHk4vM3tm7G4RTe31kGgD2SMSbJVzQDhax5plttk5Yj7wHnricL2ryTj9W4CNDAGyZQS37wyK0MI2Q488H/NpTy5tob4illZ/s/TRAmm6BZVYw48SHTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9785.eurprd04.prod.outlook.com (2603:10a6:800:1dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 20:36:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 20:36:31 +0000
Date: Thu, 23 May 2024 16:36:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, marex@denx.de,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v5 2/5] clk: imx: clk-audiomix: Add reset controller
Message-ID: <Zk+oxAh9+c0RIQ/t@lizhi-Precision-Tower-5810>
References: <1716458390-20120-1-git-send-email-shengjiu.wang@nxp.com>
 <1716458390-20120-3-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716458390-20120-3-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BYAPR21CA0024.namprd21.prod.outlook.com
 (2603:10b6:a03:114::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9a07cd-e3af-49ca-82be-08dc7b680773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QcP5ZLdG5EOQB229OMCPbDWuqecVsblWDST3ls93ixGkWuDcpJ0A054E9Ua8?=
 =?us-ascii?Q?3a+5uep8pUMS4XE5I4oFp5fj9EDezHiPbzsAsfdqbD1TzzXa59P2QlYYYwe1?=
 =?us-ascii?Q?JN4FSU0YOU1RFIrzH0RDOJe3hEfMRTfHz1iris5l9gl/ivunQRj6izudwg74?=
 =?us-ascii?Q?ZEEKXY3no3DwQhmg4BayFVubRQO33rZeKuQngXfzB3yGCE/+Y5wfW59ORqF6?=
 =?us-ascii?Q?tFNFEuKutChwY5aJDazwpnXtYEoKOB5OLDqCYkhjmPfpVsFlJoKTXzcvr+G1?=
 =?us-ascii?Q?fClqrvog4TbksxzcvqUuw0KJKw99lNioR/iejHUi4CkP/2FOSAsVSRiKymf7?=
 =?us-ascii?Q?u0GT9D9OKC+Fut5+ryVMPcG0LNmhHTbcx9kDNARE4eVPdh6AqNOPCck/bTB6?=
 =?us-ascii?Q?5D7ekA1oNvL71C+mejfdmWLQQ/exhhdNp3QBbyD7JD0wCCGoqEyS4uBLecvW?=
 =?us-ascii?Q?AHiT3qoq6ai+Wv+p+HrhuMR1ib4AOxIaeN3tYSfe3jcsMOxA9P1+h/E/cszX?=
 =?us-ascii?Q?tCoVBAigRu8HwCaJtNOId7DsCv1vHA8CtHw8rrt2tcW5aCnJzPvhTVvlvxcr?=
 =?us-ascii?Q?P6tTfAThritgMOlDf6B8hUTM1h2vdDJHyKUIdZiUlWGGbdZBkIe2vW+xLuGm?=
 =?us-ascii?Q?i5CA3vz7HdDAHVIlP1yLo7tVtD5FMYWcD/vW9bpSWg7/cBt9/k9qAR4vcu7k?=
 =?us-ascii?Q?42ONZNwsdyt4OY4Fj2CWUmV1vGMVAsH2PKEzowUGqKhWOPK2BkZ6EcnywyML?=
 =?us-ascii?Q?0Fo00K5XtK2/oBOHLxFtO5cty/HB6dwnl+/DjBlKENd5iAB2VoHhmYwZj3FT?=
 =?us-ascii?Q?OFRK5SLZ8BfvC8v4TD/2D2sO+bFfkEjYJa0fH6lpiSbQ9KFn67V9kz2v4pYy?=
 =?us-ascii?Q?YeRypEaEGvWpOCHMhSvNTU+OEQi66mxYZIzcaSuZ2IMkiL/clOB0rbEuzXFQ?=
 =?us-ascii?Q?EfFh+m9qoDrQHjifX4ytFC+187JepI9/xc3FKXPqOKGSUzos34zscnmYUoLx?=
 =?us-ascii?Q?XAJmP2V9CgAuMQBR9YOMvJk3NBvUvItyczW6CUzHJCmwTTnp5CYsNrXyn75X?=
 =?us-ascii?Q?1vsIt66PIEBoS1iBVw1em/XtUxug3spsrFnzXtKLHspphwJQ5NyxTHfTu5Ji?=
 =?us-ascii?Q?1MqtJlfIDTF89ZGN8Hqpl/IswiUFwFc4QEKB4DWYZrFHQ1yytX9jpM2CBCGg?=
 =?us-ascii?Q?KmWOQ4jHWsAWCEOUrXJpzr3qXewrTkinRe5Sxa8AQrsZlK5GdjjmSgaz/l5m?=
 =?us-ascii?Q?nWC/bX9VjrZ04/cA3Hfmmep454G4NWBuyX19aJEorLcw+D2dXfO7KPIfY4Sr?=
 =?us-ascii?Q?R9Zn8lTZAz5M5+w1inGMfxCGog41UcnAUvcgM851pWU/DA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?szODnEkJ1USazeIDiUV8n5U4lz2gCrgOo2XH03s2VVLqlJ1O8OGX1clrvGID?=
 =?us-ascii?Q?SAnOa64BqPckLdG0QO1Odb+1SVa/lurhSac0o+t3m62uwqxX11OtrxdLIktB?=
 =?us-ascii?Q?iBwxElVyU9VxMkkcnoX4xm4jTeVFDbZXTPcX0NNl/XYcn2SJms8H2YG3/GYN?=
 =?us-ascii?Q?6zhJuD+iSX40ppA5XOKzmm2kryGNSv/s3p/y8aYDNNu/k6/k2ZxhlcDlh8iu?=
 =?us-ascii?Q?6KksLabXuYhLzM6c4m4/XjrmvK2sT+TgVdqZfPGck2Qn3Mw4HYxeUFA6fH1J?=
 =?us-ascii?Q?werBOn31Izzw60vh3oU+Yvuj4sWrEhCKDNKSmHxMgVi1+3/l3NNs2yWqLZKh?=
 =?us-ascii?Q?RPSVqp/4E+hav5ocUrQ04i59ior5fH4RZHckGkUWN8OWVNEHWOKSdDQufkTN?=
 =?us-ascii?Q?qpbb4WbZFQ1QGQc2HMbQZkujpVwMn4JAfQvTwHgZcu2P0pJVQdF5Exb0cGbQ?=
 =?us-ascii?Q?SdPJQzocvwQoAdgdmpCGgdi5v2X/jO41NDzeZfeR/7xaePUZ7ErdrZR56/qr?=
 =?us-ascii?Q?C3hRuUS1agIr+a4qVBr+8FKWBYubUjMxI5Oy7fiIcNaoRk8AThmYeZk84Rnm?=
 =?us-ascii?Q?hFaCeC4dcNDX34JAIKNHx0czTHcnEFUdnTmWI5KeGC12JzhHuMV1XsTsqCgf?=
 =?us-ascii?Q?2a7jmlJEn8N20C3D2m4ayqvanilr0ioFf+yTX86oqtuxdaA7H1AVL6NTWMw7?=
 =?us-ascii?Q?h/VNUAX3plHyDjQvFiyaNx+TJXDNt3oLW9tJo0eRJfb+VeGVcfiz1AJe4sID?=
 =?us-ascii?Q?HFxtfQbFaVZdwBfQv4jYUDFhIg7gZnIos/m2qE2O7qqk4KuJsvxkW4++RRnC?=
 =?us-ascii?Q?W6e5n8jSiDEaNQaEcKZ8zi1uBmPwlXs/muq0jabZ1ASFPL0Wc8GOCQvECnOu?=
 =?us-ascii?Q?yrA8ZdluUjChgghTcb35qZg4HuT+nxSgyEnvZhan9kyssnt2CEvSDaTWcXse?=
 =?us-ascii?Q?Efl6RuDlRVF1CV4zm2+KUUH6AoNedx3cXHVl1tk476KzTZEBiixYj/gTHts6?=
 =?us-ascii?Q?Qc5gc8IOAqGiXT0fxANJmc0ysUup37/87B8elo9duRXvxWMK1WGTcFMGvIfT?=
 =?us-ascii?Q?rlBwsfcC3g0NXRZiOJ3KVH4NerIelJeoexF7pr4hV0x/S6gnwdINVkGY7j/R?=
 =?us-ascii?Q?IB93kzBAwMexTlGm2vgQB1STfVjir0W+RKAUFNxrXNSLX4wTWT2iaB+b0ZJw?=
 =?us-ascii?Q?TmaKGTVddXzREWKTwXxw093OCeszlp1KaR2C7v23kVM1SOBaZ+4uhPzkStsj?=
 =?us-ascii?Q?Q7k8FEgl3zj1ACUeEPxhiiUiw9OaFsUIlXA3wtBkLEhUSOQMkoaWgSuMg/nF?=
 =?us-ascii?Q?Pl6Ct5G0YLrNctaJ88flXx/J2txi4Mtv8yjlq5fYwZ5RtbhfXDlQaIvZPcw/?=
 =?us-ascii?Q?ffHeDgVXZTy3FQUrqfnMgTV2+oIX76bh+wGbRvAdQWr76qyX0H/ro8zNZV+4?=
 =?us-ascii?Q?SKcYREkYjri8WNYHBm4obHaqxNj9CJ1eljnBbsLo8lpvaUVnLYDrcQN9Zc0D?=
 =?us-ascii?Q?iAErGEyQYkNUYlBIpsqNJ1A6Twn1LHI5WDfx/zj27xrRpUqiS7t6sUDPh+XS?=
 =?us-ascii?Q?bOpRsYzdJ4xGQsWTh0o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9a07cd-e3af-49ca-82be-08dc7b680773
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 20:36:31.3061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTY6LAPZf+hSakjhmhlmu8bv4BF3M5a+OYgxmTnqrwqxR7BMfONht6tACwqnBLQYMJBgpNbaOLysxca/9kafEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9785

On Thu, May 23, 2024 at 05:59:47PM +0800, Shengjiu Wang wrote:
> Audiomix block control can be a reset controller for
> Enhanced Audio Return Channel (EARC), which is one of
> modules in this audiomix subsystem.
> 
> The reset controller is supported by the auxiliary device
> framework.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/clk/imx/Kconfig               |  1 +
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 60 +++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 6da0fba68225..9edfb030bea9 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -81,6 +81,7 @@ config CLK_IMX8MP
>  	tristate "IMX8MP CCM Clock Driver"
>  	depends on ARCH_MXC || COMPILE_TEST
>  	select MXC_CLK
> +	select AUXILIARY_BUS
>  	help
>  	    Build the driver for i.MX8MP CCM Clock Driver
>  
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> index b381d6f784c8..2ee68f518850 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2022 Marek Vasut <marex@denx.de>
>   */
>  
> +#include <linux/auxiliary_bus.h>
>  #include <linux/clk-provider.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> @@ -13,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/slab.h>
>  
>  #include <dt-bindings/clock/imx8mp-clock.h>
>  
> @@ -217,6 +219,60 @@ struct clk_imx8mp_audiomix_priv {
>  	struct clk_hw_onecell_data clk_data;
>  };
>  
> +#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
> +
> +static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
> +{
> +	struct auxiliary_device *adev = _adev;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +
> +	kfree(adev);
> +}
> +
> +static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
> +							 struct clk_imx8mp_audiomix_priv *priv)
> +{
> +	struct auxiliary_device __free(kfree) * adev = NULL;

nit:  *adev = NULL;

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +	int ret;
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->name = "reset";
> +	adev->dev.parent = dev;
> +	adev->dev.release = clk_imx8mp_audiomix_reset_adev_release;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret)
> +		return ret;
> +
> +	ret = auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_unregister_adev,
> +					no_free_ptr(adev));
> +}
> +
> +#else /* !CONFIG_RESET_CONTROLLER */
> +
> +static int clk_imx8mp_audiomix_reset_controller_register(struct clk_imx8mp_audiomix_priv *priv)
> +{
> +	return 0;
> +}
> +
> +#endif /* !CONFIG_RESET_CONTROLLER */
> +
>  static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
>  {
>  	struct clk_imx8mp_audiomix_priv *priv = dev_get_drvdata(dev);
> @@ -337,6 +393,10 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_clk_register;
>  
> +	ret = clk_imx8mp_audiomix_reset_controller_register(dev, priv);
> +	if (ret)
> +		goto err_clk_register;
> +
>  	pm_runtime_put_sync(dev);
>  	return 0;
>  
> -- 
> 2.34.1
> 

