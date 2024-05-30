Return-Path: <linux-kernel+bounces-195790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4A88D51D8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648FA1F24242
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924E34D9EA;
	Thu, 30 May 2024 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i+dkDCD1"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDCE502BC;
	Thu, 30 May 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094044; cv=fail; b=hIn+exNNV9/Y0VkWrheYFKu67osggMo+u9nGaxNjmvPa9srd+O3HL7aXJPaubOfKXDzgbwS3DUqW3mWWEGWEwJ7zZHwF9xFyoP2eT3xM5bwZcbeJij1gb1M4jj3JV1jJepDjKcg2E6/Y6ldjRaFgYKPSGCfgms9If+TwiztIqs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094044; c=relaxed/simple;
	bh=S1T0QE9NVIE4EPF6AeW2hxVoCI+t474Yn673ymLlYgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iWk8Ylh1m93Bvl9kM6LAbtA/3jGTlcFJF3kBfIVew4UDQTMnSuXdYEtHUuXmwcPUF4VeOgShAK2Msq86XK6vPS6ds50s78TP5EHaCYZscmZzV1Cq2G4M2/lO6Wnf1kSwgfM7Q7l8G3q2lVpUfECQ7TdYJlIq5IRIXljDb3PAIEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=i+dkDCD1; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDNfv/jb9a6LvEDmZmRsc0teUf8WEICQhtK5txTsYkyISKIIqSHC5lTcgG+hMQbGAEu+gEK2+rfN5QntBaYrh8KAoMnQoX+MH/2y7fr/B5aC8ug2CvaEnvGlTi5gFncCPGPAU51lvT0OdM8nPMaht4JRSpyYABO75SRfC7X8Mi00uJmMe3FbMVwk2skndj22dhQAjdxx/XbsUHqLjDWkXudX3/dNu9tTIfKWwaO/jEBcrSvTHZjP3bY4AHM6z1itnUFFW6/tw+/SjjGSfMsU0KwzgZr2JNrmjT+nhS3sjeQyA52zZE4eGL15dAmGIyi1+toORWSOfwXYSAoNffZIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2qB5DsfNAqsWA3mcWDa5syWeWlfgp0hnMvTb0fKhz8=;
 b=idoCdTCcIfeK5WJbKqzgs6Tdp+yPpMMRhNVnG+uYWlxnrxb2cY4PC0swRH4aEsu6RN5W3sSOeV23V4Q8MH0b7qYlQzSQ4w5GwnOvHOuihvxcQOqVBne8bQZ9L8bIw0BBOuej4okfK/q2MAbbVhxrsyWpWontBtdyA5fS/nWr5V88gwVHNnqQfsjNG4Bbe0AMpCxHMhT0d/gFMq3aoehf8LnMCFakt0n0/0SJRExEqNVKKAkajIH2rVo4dgpcZqu8000fQXOtRRNVBklw1g07Ru0JGONGHWI/B4cfnSVE1AInZk8X/fED6muAtPgO//UpmAEwHmkD4jlDv/Cc35+fpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2qB5DsfNAqsWA3mcWDa5syWeWlfgp0hnMvTb0fKhz8=;
 b=i+dkDCD1s7EjP6BAj71x1SIn9EfWSyCAxoQpHjGFBIdYIm32ERdLzIHSBwRpoqDQmgLb2gb/oL/tUEDM6s8yThsMYAA9d6BPN6I/Dsh8Ju5Y3TqGvdHhGZZ1/tM8ky9HTO6GK7i4BS7qsAZ4YBqT4ExcfVcCuZjR5vntgUWJAgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10660.eurprd04.prod.outlook.com (2603:10a6:150:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 18:33:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 18:33:58 +0000
Date: Thu, 30 May 2024 14:33:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, p.zabel@pengutronix.de,
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, marex@denx.de,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH v6 3/5] reset: imx-aux: Add i.MX auxiliary reset driver
Message-ID: <ZljGi+VPGgDxVYKf@lizhi-Precision-Tower-5810>
References: <1717036278-3515-1-git-send-email-shengjiu.wang@nxp.com>
 <1717036278-3515-4-git-send-email-shengjiu.wang@nxp.com>
 <20240530090558.53reobf2zea22oi2@pengutronix.de>
 <Zlig/Z7u4nxvKLoQ@lizhi-Precision-Tower-5810>
 <20240530164510.fyznsyzvqrbu4a4e@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530164510.fyznsyzvqrbu4a4e@pengutronix.de>
X-ClientProxiedBy: SJ0PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10660:EE_
X-MS-Office365-Filtering-Correlation-Id: 5712378f-d98b-46e0-1472-08dc80d711b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GjJqwNcuTUc6KK8XH6a6YIRvFlRrz4ivcI/Mdo0x13Ygs38rlapRpbrwCmg1?=
 =?us-ascii?Q?+nVCJn1/2voFXEEMfyZgI0eWvUJrUr5SlR7w+fas2AZ789GCt9YQEWdSEn/h?=
 =?us-ascii?Q?bulXV4wxdAZqoAY107TU3Ld3BNpXdZWksMvO0/rc7Spe7nPrqqfHXIt+u8R7?=
 =?us-ascii?Q?S7Q+2TB1Bdd1joNoioZh22eKsC+xjBVeaMrsXX8QoWCsi1p6RkSWAAYYaobB?=
 =?us-ascii?Q?XAGgnH27VuEx2pE0j0f3y/wa2h1vDKX2hz024dgv37R15p5M5lfflO1NHLeA?=
 =?us-ascii?Q?Dpz4SLch85cSBTNe3GgHYblBifbPHTg2X66nl85k/dqakt0Eqd1+jjpK89n9?=
 =?us-ascii?Q?DvIuqB1M8lU9j4zE6j+dGbRDN1mS1w6CiZY98SGQvXuFHKcSpAcncGtxJoZW?=
 =?us-ascii?Q?ra082WZ/MgRSoirE1AX9rueb5GtfBYwpQnGMr8NKPveUxuvFEQwKOKqSdyoM?=
 =?us-ascii?Q?pRD5fiu8M6rmbyCEI45xmCdRJztjq398YRrqhAWObjhXqaJrnyYrPnK+N/rE?=
 =?us-ascii?Q?kXGWoMhWlF0QkWn730gXRwyWZydhNWzbEi7T+ocGetcBIl1PstqNHJpNGs0A?=
 =?us-ascii?Q?ToU5GBBzuUq85kYPVYW/UWBk7czDvAnLT0Y95PVBjRNyx1PPxvVDJ/C9lQdg?=
 =?us-ascii?Q?e/pZBv7TmvVwhh+T+m+okSLPqwxTk1fgB1SqdX86lxYlvkuAc5qoF5Gjx2dt?=
 =?us-ascii?Q?IkZ3k6byUwpcreqLWkS0QzyF+WNtHUTWtWHGcH2SYRzv8Ub/F+BmD85w5oTB?=
 =?us-ascii?Q?maPrMVOtFYnGpI8LywZdHozdk2gjoHs4PD9QQMZzBqNsV4oO8zygwNJwp4Ra?=
 =?us-ascii?Q?4l78AVKioQlM5npPVxhgffEAzK5VdS607PfBu82QOxT9tL9CXpuONVS3d6Vd?=
 =?us-ascii?Q?gqjOrsS/dohEtzebn3Z3kwkn3vod91ZaCVOdOBxoJFmd9uc3+txJ4FFiZTkD?=
 =?us-ascii?Q?/YPsZ7ZTnwDvQghRuQQn/QY1HldGAv8pTTVN0eqpFlXXo9j1SuXaHBJ9mxbZ?=
 =?us-ascii?Q?qQex3UItrc6AnROjOp6Nsf24piEgY/ZsLsTW1/1AABFnD4xChSbfbpp1wXcG?=
 =?us-ascii?Q?mE9V/kxYPTBc74t7ZKtewn0SmR3hEsGGFDsZkKVNMXv0hn22ye7CdzFZmaYt?=
 =?us-ascii?Q?kuTTkjL79iwkVSnsoT5KFb+RFP68sR5Xk6WZr22VLkRemnmqFIj5cF6ZYnEt?=
 =?us-ascii?Q?dEgQbuKeBY7kPJWyxU9mkSmoRTXbuiarHJKWezBwSSz4GuFwia5BzEaJTK0p?=
 =?us-ascii?Q?r5GqtmKYhIoqAu8TXe2XDNZvKh3j8QulmMuKvi0HKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYw3KVhwEqilpQAb5G4saUOJq+lJ45IJrtRm71KmiuX7c/4atvF1zo0RTq4e?=
 =?us-ascii?Q?z8gRxWxk0naon8fzhMKia9RPipBP/Viu4RPdg3NSXZASGVNVC4Pmc6Ks6cUN?=
 =?us-ascii?Q?ZUKRsCSPrB4+fCbAwPHwkOvym38yguNV4/B/AQWD41TZiPHqkSXsTCmE0btc?=
 =?us-ascii?Q?mndFEJKYZaWW7hQpaf+R176K+OxqUgxTt9WHyN8d8wq2Z79LTI5dM4qUit10?=
 =?us-ascii?Q?ks3y9C004PmH6PVQYcFI7Njx/PYlg+ftYTDvEaPkGGdU/GmDcx4pB6Oi4YKr?=
 =?us-ascii?Q?3lTQmmYFhXVQrlSnhmjvNa3FqLL0B+nhddzQqnuVq+fIXffrx97Hk5ZiqVQI?=
 =?us-ascii?Q?BMFKaw8HhB3xeI7XzfvunC2D5QmPEgvRhNdmanyk3BJoaFlAV7x+lDbFX+eQ?=
 =?us-ascii?Q?8bTNhCu3wPLEJaNguwTnQMQFPGjMLNVUA9RmVLL8NfaTn866VH2h2k99lmqb?=
 =?us-ascii?Q?SQWr1Jx1wZTI8XwFXbC1kLcZgG64NiYlL41U/cEeveM2qFThje+HE5d0jnfJ?=
 =?us-ascii?Q?MIjI6hS3qR2xiJKc98JB9FPlUhXGIQL0Vl3DQOZQVu46VnLZvcPK329I6fS6?=
 =?us-ascii?Q?SNqd3DHwQZQvuFAIu/Pc1KVhg8V3vG9278t7HRhApB0Js94NKfYzH5vBuEuw?=
 =?us-ascii?Q?9cXm70kSxLBWDwoid+2BHz49+/Aq7ZsjMFjKHiJ8qG3Ow05IuyFcdGH45vZD?=
 =?us-ascii?Q?kdvx2c6hheuAmW5ZVdsuzZgKqpMKfk9Qm0poTaNUZgfXpAvrCJYRT4eY3Uwx?=
 =?us-ascii?Q?nNkmHq6N6hyrAlvrRKPbUyNyDQwjXq1o778WCSczFpQ6ibRE6y50jN8TBR/b?=
 =?us-ascii?Q?Clj5wDqT3C+Vcpg7axas3USWtBM0t7i/NY/2FYExE5UP6HpOgXV01n0B7lfi?=
 =?us-ascii?Q?zeSiLaR1yi93EJrAGtRZTh2UQRT7eBZDAhx9OpvksxH3EuUZe0RTNuMBNwnm?=
 =?us-ascii?Q?7N4x2FACLlOBF0JxCO/Wj3w3kSAFUUBrVFCNzqnIU/+dkda3DNlCN0iQOYlR?=
 =?us-ascii?Q?nEsENGlh9NZZmdX06kppV7SLLGttaeZ84eJo6EiKgdrwfP+hJxrxvpcjt/B1?=
 =?us-ascii?Q?FiA6eCcb92LfKFWokTvS8h6slW5IercqTI1tIc+cprFneI1Bz2paRufw2Oek?=
 =?us-ascii?Q?k7saHHvdTZhiFp+N61G8seIkJgnBhwPfuTOlO6xkoXSpwkf7Tu8extWVXprz?=
 =?us-ascii?Q?7Je3f0wEc1xsF+2zwv2wJQ/GCkusyWGt0SUjTcOcQiIEAjCQ7bV/D4yOzRF4?=
 =?us-ascii?Q?9DL6Bv9PEnO8DBwlcxpDmze4eO/4asqVkBLVbrvIpXX4NRmodu+1TfHz02H1?=
 =?us-ascii?Q?IVRqRQvjVeCcdf+Xe+srClYxxHppLgCFbviWgieWxvRzPbRjFAQCyDEiXqSK?=
 =?us-ascii?Q?oWPhFNXB2cQWCyVeWexXSTddYJ9/AMDD+xFi+PYfG3BRAGRYPcLw9mKadE82?=
 =?us-ascii?Q?v9Ht4pkSx/vTDYREWu0yhsFvnrD6VxW2YLzagbvio0aQAH7KyvjR29BRhiBW?=
 =?us-ascii?Q?IRLdM6X25i03i9+qj65IxrdO4VEFFn7aHMPDncMhjXxq2anOpYD27f+S2iHQ?=
 =?us-ascii?Q?jHvysDlfaWLTRZDlUaOi2O2o6+ol2KxF/0Hjk36P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5712378f-d98b-46e0-1472-08dc80d711b1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 18:33:58.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DesOzDliZ8NLRyUoWZ+i383MTKHlabhVE6Yuj0JrHd+fDeqTQ/lvoiHwSbYtnYa9bL9fa39yJFjcOoxlue0eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10660

On Thu, May 30, 2024 at 06:45:10PM +0200, Marco Felsch wrote:
> On 24-05-30, Frank Li wrote:
> > On Thu, May 30, 2024 at 11:05:58AM +0200, Marco Felsch wrote:
> > > Hi,
> > > 
> > > On 24-05-30, Shengjiu Wang wrote:
> > > > Add support for the resets on i.MX8MP Audio Block Control module,
> > > > which includes the EARC PHY software reset and EARC controller
> > > > software reset. The reset controller is created using the auxiliary
> > > > device framework and set up in the clock driver.
> > > > 
> > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > ---
> > > >  drivers/reset/Kconfig         |   8 ++
> > > >  drivers/reset/Makefile        |   1 +
> > > >  drivers/reset/reset-imx-aux.c | 217 ++++++++++++++++++++++++++++++++++
> > > 			    ^
> > > You make use of the auxiliary bus but this isn't a aux driver, it's the
> > > i.MX8MP EARC reset driver. According the TRM only the EARC reset bits
> > > are covered by the AUDIOMIX blk-ctrl.
> > > 
> > > >  3 files changed, 226 insertions(+)
> > > >  create mode 100644 drivers/reset/reset-imx-aux.c
> > > > 
> > > > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > > > index 7112f5932609..38fdf05b326b 100644
> > > > --- a/drivers/reset/Kconfig
> > > > +++ b/drivers/reset/Kconfig
> > > > @@ -91,6 +91,14 @@ config RESET_IMX7
> > > >  	help
> > > >  	  This enables the reset controller driver for i.MX7 SoCs.
> > > >  
> > > > +config RESET_IMX_AUX
> > > > +	tristate "i.MX Auxiliary Reset Driver"
> > > 			^
> > >               Same applies here
> > > 
> > > > +	depends on CLK_IMX8MP
> > > > +	select AUXILIARY_BUS
> > > > +	default CLK_IMX8MP
> > > > +	help
> > > > +	  This enables the auxiliary reset controller driver for i.MX.
> > > > +
> > > >  config RESET_INTEL_GW
> > > >  	bool "Intel Reset Controller Driver"
> > > >  	depends on X86 || COMPILE_TEST
> > > > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > > > index fd8b49fa46fc..f078da14c327 100644
> > > > --- a/drivers/reset/Makefile
> > > > +++ b/drivers/reset/Makefile
> > > > @@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
> > > >  obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
> > > >  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
> > > >  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> > > > +obj-$(CONFIG_RESET_IMX_AUX) += reset-imx-aux.o
> > > >  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
> > > >  obj-$(CONFIG_RESET_K210) += reset-k210.o
> > > >  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> > > > diff --git a/drivers/reset/reset-imx-aux.c b/drivers/reset/reset-imx-aux.c
> > > > new file mode 100644
> > > > index 000000000000..61c353abc84e
> > > > --- /dev/null
> > > > +++ b/drivers/reset/reset-imx-aux.c
> > > > @@ -0,0 +1,217 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * Copyright 2024 NXP
> > > > + */
> > > > +
> > > > +#include <linux/auxiliary_bus.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/io.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_address.h>
> > > > +#include <linux/of_platform.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/reset-controller.h>
> > > > +
> > > > +/*
> > > > + * The reset does not support the feature and corresponding
> > > > + * values are not valid
> > > > + */
> > > > +#define ASSERT_NONE     BIT(0)
> > > > +#define DEASSERT_NONE   BIT(1)
> > > > +#define STATUS_NONE     BIT(2)
> > > > +
> > > > +/* When set this function is activated by setting(vs clearing) this bit */
> > > > +#define ASSERT_SET      BIT(3)
> > > > +#define DEASSERT_SET    BIT(4)
> > > > +#define STATUS_SET      BIT(5)
> > > > +
> > > > +/* The following are the inverse of the above and are added for consistency */
> > > > +#define ASSERT_CLEAR    (0 << 3)
> > > > +#define DEASSERT_CLEAR  (0 << 4)
> > > > +#define STATUS_CLEAR    (0 << 5)
> > > > +
> > > > +/**
> > > > + * struct imx_reset_ctrl - reset control structure
> > > > + * @assert_offset: reset assert control register offset
> > > > + * @assert_bit: reset assert bit in the reset assert control register
> > > > + * @deassert_offset: reset deassert control register offset
> > > > + * @deassert_bit: reset deassert bit in the reset deassert control register
> > > > + * @status_offset: reset status register offset
> > > > + * @status_bit: reset status bit in the reset status register
> > > > + * @flags: reset flag indicating how the (de)assert and status are handled
> > > > + */
> > > > +struct imx_reset_ctrl {
> > > > +	u32 assert_offset;
> > > > +	u32 assert_bit;
> > > > +	u32 deassert_offset;
> > > > +	u32 deassert_bit;
> > > > +	u32 status_offset;
> > > > +	u32 status_bit;
> > > > +	u32 flags;
> > > > +};
> > > 
> > > Why do we make it this compicated for an simple EARC module reset? I
> > > understand that you want to provide a generic driver which can be
> > > re-used but there is actual no other user and may will get no other user
> > > in the future too. Therefore I would like to keep it simple at the
> > > begin and adapt the code on-demand.
> > 
> > There are many similar cases. such as
> > https://elixir.bootlin.com/linux/v6.10-rc1/source/drivers/pci/controller/dwc/pci-layerscape.c#L251
> > 
> > Previously it use syscon and regmap to a global register space region and
> > direct operate the register. Now this way will not preferred. It needs
> > export as reset driver. but actually, it just write some bits. 
> 
> It depends, if your reset-controller is part of an complete different
> device like this EARC reset you're right else you can write to the reset
> directly within you driver.

These reset bits allocated a global register regions. Such as bit0 for
pcie0, bit1 for pci1, bit2 for usb0, bit3 for usb1. Hardware pack these
to misc mmio region.

> 
> > We face the similar problem at difference driver when do upstream.
> > 
> > One on going a discussion about sim module reset
> > https://lore.kernel.org/imx/131e46b1-61d9-41de-a225-853b09c765d1@gmail.com/
> > 
> > We hope an unified and simple method to handle these cases.
> 
> An unified driver for non-unified reset modules? This makes no sense to
> me. When it comes to possible quirk handling for different reset modules
> your code gets even more complex.
> 
> I'm fine with a common code base (driver) if NXP has an common reset
> controller IP which is added to several SoC. There should be no common
> code base if this isn't the case.

Some chip have common reset controller IP. Some chip simple packed reset
bits to one global misc mmio region with other misc control bit, such power
on/off / clock source choose / enable debug features. 

Here we just consider the second case. Anyway we need handle these case at
somewhere. 99% case just write bit<n> to register offset. Only difference
is bit posstion and register offset. If write difference driver for these
just because bit posstion or offset, there will be many duplicated codes
under driver/reset.

For example:
Misc: 0x1000
      bit0: pcie0 reset
      bit2: usb0 reset
      bit3-bit4: pcie clk source select
      bit5-bit6: usb0 clk source select
      bit7: pcie0 phy power on
      bit8: usb0 phy power on.

The difference chip, bit possition will be changed.
How handle this case corporately?

> 
> Regards,
>   Marco
> 
> 
> > 
> > Frank
> > 
> > > 
> > > Regards,
> > >   Marco
> > > 
> > > > +struct imx_reset_data {
> > > > +	const struct imx_reset_ctrl *rst_ctrl;
> > > > +	size_t rst_ctrl_num;
> > > > +};
> > > > +
> > > > +struct imx_aux_reset_priv {
> > > > +	struct reset_controller_dev rcdev;
> > > > +	void __iomem *base;
> > > > +	const struct imx_reset_data *data;
> > > > +};
> > > > +
> > > > +static int imx_aux_reset_assert(struct reset_controller_dev *rcdev,
> > > > +				unsigned long id)
> > > > +{
> > > > +	struct imx_aux_reset_priv *priv = container_of(rcdev,
> > > > +					struct imx_aux_reset_priv, rcdev);
> > > > +	const struct imx_reset_data *data = priv->data;
> > > > +	void __iomem *reg_addr = priv->base;
> > > > +	const struct imx_reset_ctrl *ctrl;
> > > > +	unsigned int mask, value, reg;
> > > > +
> > > > +	if (id >= data->rst_ctrl_num)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ctrl = &data->rst_ctrl[id];
> > > > +
> > > > +	/* assert not supported for this reset */
> > > > +	if (ctrl->flags & ASSERT_NONE)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	mask = BIT(ctrl->assert_bit);
> > > > +	value = (ctrl->flags & ASSERT_SET) ? mask : 0x0;
> > > > +
> > > > +	reg = readl(reg_addr + ctrl->assert_offset);
> > > > +	writel(reg | value, reg_addr + ctrl->assert_offset);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int imx_aux_reset_deassert(struct reset_controller_dev *rcdev,
> > > > +				  unsigned long id)
> > > > +{
> > > > +	struct imx_aux_reset_priv *priv = container_of(rcdev,
> > > > +					struct imx_aux_reset_priv, rcdev);
> > > > +	const struct imx_reset_data *data = priv->data;
> > > > +	void __iomem *reg_addr = priv->base;
> > > > +	const struct imx_reset_ctrl *ctrl;
> > > > +	unsigned int mask, value, reg;
> > > > +
> > > > +	if (id >= data->rst_ctrl_num)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ctrl = &data->rst_ctrl[id];
> > > > +
> > > > +	/* deassert not supported for this reset */
> > > > +	if (ctrl->flags & DEASSERT_NONE)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	mask = BIT(ctrl->deassert_bit);
> > > > +	value = (ctrl->flags & DEASSERT_SET) ? mask : 0x0;
> > > > +
> > > > +	reg = readl(reg_addr + ctrl->deassert_offset);
> > > > +	writel(reg | value, reg_addr + ctrl->deassert_offset);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int imx_aux_reset_status(struct reset_controller_dev *rcdev,
> > > > +				unsigned long id)
> > > > +{
> > > > +	struct imx_aux_reset_priv *priv = container_of(rcdev,
> > > > +					struct imx_aux_reset_priv, rcdev);
> > > > +	const struct imx_reset_data *data = priv->data;
> > > > +	void __iomem *reg_addr = priv->base;
> > > > +	const struct imx_reset_ctrl *ctrl;
> > > > +	unsigned int reset_state;
> > > > +
> > > > +	if (id >= data->rst_ctrl_num)
> > > > +		return -EINVAL;
> > > > +
> > > > +	ctrl = &data->rst_ctrl[id];
> > > > +
> > > > +	/* status not supported for this reset */
> > > > +	if (ctrl->flags & STATUS_NONE)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	reset_state = readl(reg_addr + ctrl->status_offset);
> > > > +
> > > > +	return !(reset_state & BIT(ctrl->status_bit)) ==
> > > > +		!(ctrl->flags & STATUS_SET);
> > > > +}
> > > > +
> > > > +static const struct reset_control_ops imx_aux_reset_ops = {
> > > > +	.assert   = imx_aux_reset_assert,
> > > > +	.deassert = imx_aux_reset_deassert,
> > > > +	.status	  = imx_aux_reset_status,
> > > > +};
> > > > +
> > > > +static int imx_aux_reset_probe(struct auxiliary_device *adev,
> > > > +			       const struct auxiliary_device_id *id)
> > > > +{
> > > > +	struct imx_reset_data *data = (struct imx_reset_data *)(id->driver_data);
> > > > +	struct imx_aux_reset_priv *priv;
> > > > +	struct device *dev = &adev->dev;
> > > > +
> > > > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > > +	if (!priv)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	priv->rcdev.owner     = THIS_MODULE;
> > > > +	priv->rcdev.nr_resets = data->rst_ctrl_num;
> > > > +	priv->rcdev.ops       = &imx_aux_reset_ops;
> > > > +	priv->rcdev.of_node   = dev->parent->of_node;
> > > > +	priv->rcdev.dev	      = dev;
> > > > +	priv->rcdev.of_reset_n_cells = 1;
> > > > +	priv->base            = of_iomap(dev->parent->of_node, 0);
> > > > +	priv->data            = data;
> > > > +
> > > > +	return devm_reset_controller_register(dev, &priv->rcdev);
> > > > +}
> > > > +
> > > > +#define EARC  0x200
> > > > +
> > > > +static const struct imx_reset_ctrl imx8mp_audiomix_rst_ctrl[] = {
> > > > +	{
> > > > +		.assert_offset = EARC,
> > > > +		.assert_bit = 0,
> > > > +		.deassert_offset = EARC,
> > > > +		.deassert_bit = 0,
> > > > +		.flags  = ASSERT_CLEAR | DEASSERT_SET | STATUS_NONE,
> > > > +	},
> > > > +	{
> > > > +		.assert_offset = EARC,
> > > > +		.assert_bit = 1,
> > > > +		.deassert_offset = EARC,
> > > > +		.deassert_bit = 1,
> > > > +		.flags  = ASSERT_CLEAR | DEASSERT_SET | STATUS_NONE,
> > > > +	},
> > > > +};
> > > > +
> > > > +static const struct imx_reset_data imx8mp_audiomix_rst_data = {
> > > > +	.rst_ctrl = imx8mp_audiomix_rst_ctrl,
> > > > +	.rst_ctrl_num = ARRAY_SIZE(imx8mp_audiomix_rst_ctrl),
> > > > +};
> > > > +
> > > > +static const struct auxiliary_device_id imx_aux_reset_ids[] = {
> > > > +	{
> > > > +		.name = "clk_imx8mp_audiomix.reset",
> > > > +		.driver_data = (kernel_ulong_t)&imx8mp_audiomix_rst_data,
> > > > +	},
> > > > +	{ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(auxiliary, imx_aux_reset_ids);
> > > > +
> > > > +static struct auxiliary_driver imx_aux_reset_driver = {
> > > > +	.probe		= imx_aux_reset_probe,
> > > > +	.id_table	= imx_aux_reset_ids,
> > > > +};
> > > > +
> > > > +module_auxiliary_driver(imx_aux_reset_driver);
> > > > +
> > > > +MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
> > > > +MODULE_DESCRIPTION("Freescale i.MX auxiliary reset driver");
> > > > +MODULE_LICENSE("GPL");
> > > > -- 
> > > > 2.34.1
> > > > 
> > > > 
> > > > 
> > 

