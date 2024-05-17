Return-Path: <linux-kernel+bounces-182277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CB8C8923
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A6D1F27266
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8212D212;
	Fri, 17 May 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NwkBXk5K"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84A12C7E1;
	Fri, 17 May 2024 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958986; cv=fail; b=UW0VLaUmvm8Yt4+jWuwXgZtKENw3DNYbOvh4dUQwusDfVOjjrh8pehGUL9HshS0onof+53AuHKGrqfhubKvZ9b2GyZU38dsQ6cera0tD0f/WJN5e2jciwbdH2LyYs7sDR5Ue20MXxP/WPYpOmiKyAdJbT3iENnxONrhSILDQ6Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958986; c=relaxed/simple;
	bh=GvBeTlRbxIAsOohYqK7PSAYxy56tAb72hB0E4R7+Fs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C++5bIBLwH45x+8wRHNQZZMFzP54ySzDn2lsr4MfjU2Ae1Ih3xkldBa0IEhcc7YnnRjAg/Np/NzAJQTsJDPkhFWvQne07HAwXeMLIfZOXQz4NqHq00vWa7mw536uLn3n5dvs4NHo8c+5nc2hRUK7gLFeE3poB8WZ6aFEGr/87Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NwkBXk5K; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCtYWdFsq3UCIwiu2C5TW+VsppYS4Xv8tfAXTWUNof+pC18/Hds64UcSNvh+mUqg4cZLoI4jBsNDPcInVfsd3hHnNYOPMdeyg8kmhODLxu1LmGm9rlDtq070etjeUMg/TsfGYrgVvDgNoRmYX+N1FYo+O1YbR0ehM/99QVcpYBW7M3QKcAMzrUwe11CQGw3bNvVcryHQ+zKWEKh0EHmWrRpH8h0YfKxvh2X4ny3AOqJyZBTaLc/F4Fyz7j8MxQBwZG6gmyC0x3rGk+INnBRwDaE0/CxolIJPh8hyLYy3VjAlTHm3u3mqPyT9jPNw2XeYQvqNLYbnDV9AkdUD7lK98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9AwDtIdEduGty41j7HuJKGp4IKgVeNuQPfJ17M/ktI=;
 b=DsBkkfpVgJRN3uWEwJzy72fRmmkMVAZU/dPCLamLzXHjuMTpHgxReDPSmPnBwSbFAoCdoEPXgl+V3nopJglrnV1CsWNfd+O5dykksSbnA/cYHGaE4RbUB2HszwSfLtHosDJCQ+wgPxrM9Y3A+xglrPBAmkrLI4tHhlhrJ82LrJo22L2oRdRMvPshv55jvRTPMz4sqi9z4eHXAU1h+i8p/67fcE4Ey43BQw12b64kKn0zrXEpUaSwrxEVd1ixXiTdMUY0FZ1Ks+czzkM7xhPHCkLwE/BhTjDaf48K4ItZbyjQfSF8dD3WbxMMkCGK5IT53qch3xt42AE0lj5lQEXvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9AwDtIdEduGty41j7HuJKGp4IKgVeNuQPfJ17M/ktI=;
 b=NwkBXk5K5QO/JmqQ4hu0VSVttbeK5lsgNd+0YJN8KxDil53r+nxi2M75DP42DNv1BMb/5x08gTL/idj+sHfoAbQ8QIXG/8ao7nN/kXhPWIOhSaJvanEFPGnha1MTInRazjFRwSBbHiTf9Swwu7tB4zjKxgz/0ZgHi480rW8V/jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10352.eurprd04.prod.outlook.com (2603:10a6:150:1c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Fri, 17 May
 2024 15:16:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 15:16:17 +0000
Date: Fri, 17 May 2024 11:16:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] reset: add driver for imx8ulp SIM reset controller
Message-ID: <Zkd0uIaJiwzYrBIK@lizhi-Precision-Tower-5810>
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
 <20240516204031.171920-3-laurentiumihalcea111@gmail.com>
 <ade33946-bb94-4357-bc6d-a354661b50ca@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ade33946-bb94-4357-bc6d-a354661b50ca@marvell.com>
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10352:EE_
X-MS-Office365-Filtering-Correlation-Id: 84104740-f188-4044-825c-08dc76844c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1jr7bWc9GYQUQ9SrFlsFOsWHhP1SHLRNfT8zcdQJ3I1G/nyUgk4NYHbIBQn?=
 =?us-ascii?Q?SADKrav4OjsPg18jNjokPwu6HcjRj3kxuOUEbRkELKEB3kmSWIy9RKY8DsJe?=
 =?us-ascii?Q?AV7Lox8MFjY5UEtGl7ev6egKoNcag/Mws3s+DwFshHPBr1m+llU/ihAjqDA7?=
 =?us-ascii?Q?EsY/09D9CgMcOfqv2lRCHfFigTx0TxvntSMSg7e8LJ4LrPkYDPNeFS8Imd++?=
 =?us-ascii?Q?C9Ff/nMY0HbhH/8ompn+LJmLIPtxyINnDhj6ncnz8/UyvDTOswQwUrzT/m+u?=
 =?us-ascii?Q?qA1kkwRKS7UpH6s6X4QuQg7OUccpEj6v+drskPKGEqYg0W8PFarErMZAw4Vp?=
 =?us-ascii?Q?5TxL5loacqrvgI3LONBeUtwTgnR9aAi9fX4KgRTLIOgpqo0wuWtIVOjOFJi0?=
 =?us-ascii?Q?IaEL6PqX2esl0YqlILoQclO4qoK69k7sY9AqWDMcwx7QKDSu81kNsM9qjsjD?=
 =?us-ascii?Q?TtfREXUcrFMXf18IKAY6SgrzWM+cqjhWxzzM9La5u8x2dFkvFYae+sBlt27d?=
 =?us-ascii?Q?8h1UECI41c8vRwaLG39/vumRDL0CuZtKYgSCTFVHZBpqmj0RWuCcBzFqwQCK?=
 =?us-ascii?Q?f+BxnlVrAW+eIDhjxP4uWJwDztzCNUyOVgvpUSmoT0vGTZmhDputnoWhlIji?=
 =?us-ascii?Q?a4f4MFAJCVUBeZySMo09BNhY4zc3E+43xDFK1QSbujQpAKdNwpzXARd7n3+c?=
 =?us-ascii?Q?ioZ4craLa2VG+dPTIm6jHBxgg7gwcN6R3sUFkdD4YbayFgXn1p33+fcVQgE3?=
 =?us-ascii?Q?+IvNRLm5YepUMobdqZmfP1gR8z2eaWBJXWydwb+QOGSoZypk8ypFbqBDEXmN?=
 =?us-ascii?Q?mwMZTNMnec6wwXTveS45IJknw8IonHaj9x7FyBrtDTSCBS8MzBTqnBirRU2K?=
 =?us-ascii?Q?tNHHO7M34MiMfzdbDZW0nVdQjbLrGBigG2+59PuMQjdnzaDiH8BeXJ2WVBUY?=
 =?us-ascii?Q?Ksg9g2XcQoixrG8rkzVY19Ju2qoqnGMVuiOVOHL24mwqOzphgaTf5UtS/o4o?=
 =?us-ascii?Q?u+9TqeZoz6SsPNhy3XTTgffM0BkGFzfDMe8mu3pKmhXhgLxXcqO3dohr0lCo?=
 =?us-ascii?Q?hNPHrI23EyYy8ZlLIuU6dHM5NmBLxA+nacMAXl9AZ4yNA8Ss3993sLY0rQN9?=
 =?us-ascii?Q?fj/yVWhMT8I6smYyK6ynG34KiciCFTn7HoF6pIQ/uZGyfvkDbjIG8eAuAnwR?=
 =?us-ascii?Q?fiFWpW9oURODo5ifLczSxhjboipRxXgAoraIRYccjcepxPTgIUonijTdBgmH?=
 =?us-ascii?Q?xe4cqW9CQoXf5ig13yjSrG19FO7iQ3r0AyLcHGyBAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZNL/G1FLLV8PUpVxDBJOsJ3ZhW+6TXIkDN3WOYjH3NnkxW9e3nPu6opiPQ74?=
 =?us-ascii?Q?CvmyWcKSDHYB+q9Godp09jXl+EGSZPT5pPSIQBziDjC4H/vxFBb+OkN7auHj?=
 =?us-ascii?Q?TmgH270u3sXcNICh4pGAhODjQfslKHkgMwJCPeH9a1UCZYTPv+DN4MBkrMLd?=
 =?us-ascii?Q?02sYkt7npO46eeyi7j67ayyGFWXlOLa8ScXshD6/7fvS6sx2wNsSQGbeZ+9f?=
 =?us-ascii?Q?/ltN0dw9hlqzskdhqjq39IMyTeXec3783TRC3aw1km3JmSGtFT3gQkWKwIv/?=
 =?us-ascii?Q?JQhfXrb3QE8taOct6sizQsx3VnsBpQHg2Lgg7g6XZIjihlGr3KLutyKOMjXc?=
 =?us-ascii?Q?5PJ6eBr+xPAmUYwtR2dNra5A0TnEs5bdL7O7wIz//LSSZg9T+xbQII7UcLtt?=
 =?us-ascii?Q?50f2yCxvH3NEXalVHyi6h2qEnqutGQmM/q/18XcYuJeduGzlzghDYr5eEmuY?=
 =?us-ascii?Q?E3nU1CPLFy4OVTC+x/+bX4VZTtpySvEMVH6Tk84oxcoRb38ZsX+jRIdSIPw1?=
 =?us-ascii?Q?pZC50PWlA2JCelDjIbXHKc4bpco0BGpLg2/84KGSwJJrEyOq3q9/WbGmuT3n?=
 =?us-ascii?Q?1dMj4fxckajDy2vRXkH1cfOSfa9ldv0ZyQqADcYJrnsavGaR22DvnlP7+rWF?=
 =?us-ascii?Q?44TMvmqQBj2UfqKQSa2f7PxGu2kM43NfOhHzZjiy4iR6xmIsA195PrZ3D6+X?=
 =?us-ascii?Q?xl3CBKE8SQH5ft3VNQQzkoD8tHSSUCWuwSCtzshvqL1Q7uPjG9IJLV+OPATO?=
 =?us-ascii?Q?X/9JYwmIXTD1awgXZ4LQ2nacShXwvU1OhVJhiI+ljFKpBsd5X+8AVsma+zmh?=
 =?us-ascii?Q?Z6hhqaYLVbhxfsYZWSd9L39sq6+rjGIkhnvUM1GnNrkG1VCfGbPIDRd+rU89?=
 =?us-ascii?Q?4LsY1iY7z+jrUwwMeZY4bIiJsWmlJ2uRqg/7HUE1HNFhWZ0DobJIm8/Thxor?=
 =?us-ascii?Q?rdrBjze+5w+R6Lom5LDCC/OC72mUxgdoYWpsxa6RDMk88xkVteJ82mNEf9aB?=
 =?us-ascii?Q?SCphuSze9HUSDN7hlhOE20zortAxLMW2FdRpv42o7jlob5MjJGfdivYviuC0?=
 =?us-ascii?Q?gMXFA9ly5bsOL5wUn2nTiJbwk5QMO0KzhqRFK6tdt4HzggY/YbbjTO7R8L36?=
 =?us-ascii?Q?QPtCiR8Qlipl6d9J0Xhg3c2AXJMPtarxRK2YbeLrhlByQ3dVqBSMSm9HbeZz?=
 =?us-ascii?Q?EA+HaMB6rYu7RchkMecoUX2J9uLsnNRyKNpGgHtaqSL6+1KOh/ePawcDRU5I?=
 =?us-ascii?Q?oiLx2p1r49WrPhG9YXLkSOLNbts2ozVLshVaJNNBV8y3qdQI5hOv0BU0QiPn?=
 =?us-ascii?Q?655XtzLkXKvmffEcjyHxhDDklVK9uUqI/lZFGT8LiC+2CLu0LxdMY7F6MJuq?=
 =?us-ascii?Q?EXyADF6PDAUXFFvshCsM02ADW2e3WcH2FiEQ+wNVlwD/6htaMwMLf2FvEkw/?=
 =?us-ascii?Q?nEjCEwDL9befmnSpZe6FhxzxVwt7peF7+0MxT1+frYWpPmGoHAN+Z20Z9rlO?=
 =?us-ascii?Q?xFruJ9jbGPQLwbqKrjk/RW9ws9pPzmmMFlipaMIV4tXCiz7p3rK96ovzTlCu?=
 =?us-ascii?Q?ocuGjWcDMX2k7KT4LnK1RlghRXj+zdV8pPP9DrOi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84104740-f188-4044-825c-08dc76844c89
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 15:16:17.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtXGmEyYTLWUwLGbKN1GNhmld5t9m/gDp451jRK00hyQMTui8kfm3O7eVKGoHBoh5TF19VnLPDs1noFUXDca3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10352

On Fri, May 17, 2024 at 11:51:30AM +0530, Amit Singh Tomar wrote:
> Hi,
> 
> > ----------------------------------------------------------------------
> > From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > 
> > Certain components can be reset via the SIM module.
> > Add reset controller driver for the SIM module to
> > allow drivers for said components to control the
> > reset signal(s).
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> > ---
> >   drivers/reset/Kconfig                         |  7 ++
> >   drivers/reset/Makefile                        |  1 +
> >   drivers/reset/reset-imx8ulp-sim.c             | 98 +++++++++++++++++++
> 
> Just out of curiosity, can't this be accomplished using a generic reset
> driver?
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/reset/reset-simple.c

reset-simple have not use regmap. I think it can use ti's
https://elixir.bootlin.com/linux/latest/source/drivers/reset/reset-ti-syscon.c

Or should change ti to reset-simple-syscon?  or add regmap support for
reset-simple.c 

Frank Li


> 
> >   include/dt-bindings/reset/imx8ulp-sim-reset.h | 16 +++
> >   4 files changed, 122 insertions(+)
> >   create mode 100644 drivers/reset/reset-imx8ulp-sim.c
> >   create mode 100644 include/dt-bindings/reset/imx8ulp-sim-reset.h
> > 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 85b27c42cf65..c1f4d9ebd0fd 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -91,6 +91,13 @@ config RESET_IMX7
> >   	help
> >   	  This enables the reset controller driver for i.MX7 SoCs.
> > +config RESET_IMX8ULP_SIM
> > +	tristate "i.MX8ULP SIM Reset Driver"
> > +	depends on ARCH_MXC
> > +	help
> > +	  This enables the SIM (System Integration Module) reset driver
> > +	  for the i.MX8ULP SoC.
> > +
> >   config RESET_INTEL_GW
> >   	bool "Intel Reset Controller Driver"
> >   	depends on X86 || COMPILE_TEST
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index fd8b49fa46fc..f257d6a41f1e 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -42,3 +42,4 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
> >   obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
> >   obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
> >   obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
> > +obj-$(CONFIG_RESET_IMX8ULP_SIM) += reset-imx8ulp-sim.o
> > diff --git a/drivers/reset/reset-imx8ulp-sim.c b/drivers/reset/reset-imx8ulp-sim.c
> > new file mode 100644
> > index 000000000000..27923b9cd454
> > --- /dev/null
> > +++ b/drivers/reset/reset-imx8ulp-sim.c
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset-controller.h>
> > +#include <dt-bindings/reset/imx8ulp-sim-reset.h>
> > +
> > +#define AVD_SIM_SYSCTRL0        0x8
> > +
> > +struct imx8ulp_sim_reset {
> > +	struct reset_controller_dev     rcdev;
> > +	struct regmap                   *regmap;
> > +};
> > +
> > +static const u32 imx8ulp_sim_reset_bits[IMX8ULP_SIM_RESET_NUM] = {
> > +	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N] = BIT(3),
> > +	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N] = BIT(4),
> > +	[IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N] = BIT(5),
> > +};
> > +
> > +static inline struct imx8ulp_sim_reset *
> > +to_imx8ulp_sim_reset(struct reset_controller_dev *rcdev)
> > +{
> > +	return container_of(rcdev, struct imx8ulp_sim_reset, rcdev);
> > +}
> > +
> > +static int imx8ulp_sim_reset_assert(struct reset_controller_dev *rcdev,
> > +				    unsigned long id)
> > +{
> > +	struct imx8ulp_sim_reset *simr = to_imx8ulp_sim_reset(rcdev);
> > +	const u32 bit = imx8ulp_sim_reset_bits[id];
> > +
> > +	return regmap_update_bits(simr->regmap, AVD_SIM_SYSCTRL0, bit, 0);
> > +}
> > +
> > +static int imx8ulp_sim_reset_deassert(struct reset_controller_dev *rcdev,
> > +				      unsigned long id)
> > +{
> > +	struct imx8ulp_sim_reset *simr = to_imx8ulp_sim_reset(rcdev);
> > +	const u32 bit = imx8ulp_sim_reset_bits[id];
> > +
> > +	return regmap_update_bits(simr->regmap, AVD_SIM_SYSCTRL0, bit, bit);
> > +}
> > +
> > +static const struct reset_control_ops imx8ulp_sim_reset_ops = {
> > +	.assert         = imx8ulp_sim_reset_assert,
> > +	.deassert       = imx8ulp_sim_reset_deassert,
> > +};
> > +
> > +static const struct of_device_id imx8ulp_sim_reset_dt_ids[] = {
> > +	{ .compatible = "nxp,imx8ulp-avd-sim-reset", },
> > +	{ /* sentinel */ },
> > +};
> > +
> > +static int imx8ulp_sim_reset_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct imx8ulp_sim_reset *simr;
> > +	int ret;
> > +
> > +	simr = devm_kzalloc(dev, sizeof(*simr), GFP_KERNEL);
> > +	if (!simr)
> > +		return -ENOMEM;
> > +
> > +	simr->regmap = syscon_node_to_regmap(dev->of_node->parent);
> > +	if (IS_ERR(simr->regmap)) {
> > +		ret = PTR_ERR(simr->regmap);
> > +		dev_err(dev, "failed to get regmap: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	simr->rcdev.owner = THIS_MODULE;
> > +	simr->rcdev.nr_resets = IMX8ULP_SIM_RESET_NUM;
> > +	simr->rcdev.ops = &imx8ulp_sim_reset_ops;
> > +	simr->rcdev.of_node = dev->of_node;
> > +
> > +	return devm_reset_controller_register(dev, &simr->rcdev);
> > +}
> > +
> > +static struct platform_driver imx8ulp_sim_reset_driver = {
> > +	.probe  = imx8ulp_sim_reset_probe,
> > +	.driver = {
> > +		.name           = KBUILD_MODNAME,
> > +		.of_match_table = imx8ulp_sim_reset_dt_ids,
> > +	},
> > +};
> > +module_platform_driver(imx8ulp_sim_reset_driver);
> > +
> > +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
> > +MODULE_DESCRIPTION("NXP i.MX8ULP System Integration Module Reset driver");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/dt-bindings/reset/imx8ulp-sim-reset.h b/include/dt-bindings/reset/imx8ulp-sim-reset.h
> > new file mode 100644
> > index 000000000000..a3cee0d60773
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/imx8ulp-sim-reset.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
> > +
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#ifndef DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H
> > +#define DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H
> > +
> > +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N    0
> > +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N    1
> > +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N   2
> > +
> > +#define IMX8ULP_SIM_RESET_NUM                   3
> > +
> > +#endif /* DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H */
> 

