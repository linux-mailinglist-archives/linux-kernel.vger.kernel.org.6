Return-Path: <linux-kernel+bounces-271487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2205E944EE7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF22A1C23B84
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C37F1A3BCE;
	Thu,  1 Aug 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mhP3Amu3"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260801A01C3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525334; cv=fail; b=S3jDSNPUpG2Fb1/jeA734wzpvQfUfOKNGuAFdvT6HyGd0velwtxqbg8RHPqJcBpX87DCXnN2ZVeWlYmIVjWdpRIxZhXTraGqrrHUD9IMER5cb+gLrUl1Bs4sW2PvJ9wkfNIXVTrJ6VZYht9X0toyXVNqIjc+NXwzs+Xq+nZS2oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525334; c=relaxed/simple;
	bh=0smV+qNxn0tEuGs2ku1qqJ/CC/CBRpgxH/4wtZjIGc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MJjkSSlU6jEb/jgtzfzm145SetZaNydl/zpkVOfb1HfvE2CmtAe52ZdIaXHqyZezBnrMDFeNOcuDUFCYOoduiyRTOjQWNDvfFrDV9ZccVQtZ6WYIhkH4ZkhZLzrzEYS9cnW97GENKsMjcso4DI2fDKZu2cgQNb1OJ0xRs71Rxw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mhP3Amu3; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3eolg663GZf5XqaPtf/hXLS/1DvV+pZIWRqySdAn7WloMd65dx5pQP4CBfhqmB15+CBqAy7UkDazzEy7Zk/pn9lrqTHudPUWuB0z3SIu1YADhwKYda403vyx48FcORPUkOpRAVTkIIw41CzsbU7abL1hSToSech+2Ot+FgIM8pUhy/b7hjbl2k9OR/HFPkfmbo7aCE5xbal/sTXtXpouL/Ln57IV+kXQYOnU9lqM9AeO1wa3bGKgUAI+UJ4wOgki3rGKz6VNAl8cHRKJYd8wS/k+h70H67piNmCznwOz1OKOShxWY0GlC2UA2L9GB8uf8jkRA33xzAbSo/rFgorHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3v7oxyl6GJJNVEXsknK44jt2JvNuCMwqxOkZxdqrxU=;
 b=l0oOUGJfnOC67K6JRsjq62AuryOmJ26UzVNbh066cWdK2Fx1l9x6/NsBDXkHM1t1LqlHh/Sgqz7orunJZMGdH0eIe57qBKJbeeegCJx06ZGR+TXWFN+Yoa87wFiDt++4EvveGiZfVWFKouJDFq4+1lR3ZQdy1GgwsKgSBb4MBYObshZNvvPJ+qm8WjK8bbJ7R1tjMKAiQpPznmERoycmo+7gLOAmWV1UHzGuvYETANEvcUIb/Ea98z5nAS83XOQg1etKxZcC/wGkfOhrd5fzD/tYtGreBBMcbbkKEMXT9kuV4rOgzjOOSWCTcGgoqyClc9tviwK0fmvfFaT4RWF2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3v7oxyl6GJJNVEXsknK44jt2JvNuCMwqxOkZxdqrxU=;
 b=mhP3Amu35GuLu4+pRPyCv4xHpZuS2/uTShtuEdiuvt8kiowLWrmxnKh9ZYp0YwYY6UsTBkXTS1KcX++xfSV5GFtHh+R6m7Tn0EdGg7LuxAWprDr+RVsGlPjNmMJvzv2IOTcgTbBsHSk4ZHi7o0/D2r69kS8hQn48C5yqwwNaddsYXnRl+vRYCNONQyb3ldQvhl4I3rVj6a2huxPBBajzliiG729sOmmbLUx1Z2ah5R0P2GauUBOHOZ9p6YhsW5TGoZqCHKLTf2IWoxY5wfsEB+WoCUlFjIRAFxwmXQx+vJ5yzvKOfD1+xl69GsSK/gMkTkrL7Wrk4zp/to4de1QdLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6882.eurprd04.prod.outlook.com (2603:10a6:208:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 15:15:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 15:15:28 +0000
Date: Thu, 1 Aug 2024 11:15:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] linux/io.h: Add cleanup defination for iounmap() and
 memunmap()
Message-ID: <ZqumhgZ5heh0OYuA@lizhi-Precision-Tower-5810>
References: <20240731233145.2485874-1-Frank.Li@nxp.com>
 <969fb014-682e-4984-ad1b-7ab4f068ed85@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969fb014-682e-4984-ad1b-7ab4f068ed85@app.fastmail.com>
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f1bf4e-34d6-4e28-5e64-08dcb23cc69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?neIEaIdXOyH6al25/YmSAKUrtMUjcBdIMD5SDMdtqDq3fbd7T+Dn9hthkiSy?=
 =?us-ascii?Q?YV78r10xp4QVJgAkx+qo5yD8YH2HgqNFf24lKxs6AksO8Iwq8CCo50SbipBl?=
 =?us-ascii?Q?oan7de72WiL6q9kcTpRAV0vAv79IHyZVp62UfCZnmTU0WGVcNvJdj5KafGKl?=
 =?us-ascii?Q?6Oa3tsHsSkx2eNago1kr2Wy84c0JQq60KM3crd3zKsFolABnHf8ppjLNMKHz?=
 =?us-ascii?Q?3AqPkgZwn0TC77KmjKoIdtVRJab+DflGU12W0A6/P280I/JXn8uZfeKwS5nl?=
 =?us-ascii?Q?Ovs6yaqAK8sZqhjKwwnC2M+4TFhZq+I2HED9qUljssemIzg6+0VzIAOKPW4V?=
 =?us-ascii?Q?2muDZy30eL3F00DD7iwYU+LamJM0BRrYbcWtjOJhmk2D7dJR9Dw8JiNlHdOK?=
 =?us-ascii?Q?AAdHav05cf3C+iC/t7TSHh4eKtJ8H+cJY8ifUOhl7EUrSKbWKd541BjK0zia?=
 =?us-ascii?Q?J2r0WUIf4MSP1PMCDnHEpEkGRchkgKvicG0s/k6GLoe3ee6nBxKCWxHK0QcB?=
 =?us-ascii?Q?9mCbCUniO0Z+PHbXLZiJ2mvDc2hf3parLmA4szItylZjPnO2YrjIDlewod7R?=
 =?us-ascii?Q?WPYeFUewXXn8OcPoKnI1rSQIMEkKGD4IbwCKROOhblmK+IMG7G8hh6wYCwyU?=
 =?us-ascii?Q?4VrTXN6Q1/8IVvGlALTJR64IEy7HMYZ85Fcn5vEsNF+du3FJgV8dkOvr2XDK?=
 =?us-ascii?Q?NlRBPalyDq0WSd9DBKJgzHc+/BlUjeRnf4vG9dh53fG4JqhIRnGPwcA1bcsP?=
 =?us-ascii?Q?9f1oQqP+VjuuczwwCq8IYnZCmzAJr/+2KmLirMvL6Gc/MQ6Z5xHhWflKD2Tg?=
 =?us-ascii?Q?VQVIO3Lj1B/iDpp+uNDxliZdd+8rsINQahWpd23fCCz4L6t5feivQXbnLnA6?=
 =?us-ascii?Q?76nM2v1kKcOWNTF3tT+w4A7DEXtgV4QBPu2D22pplAVhQvRBLELUjCH5dzKV?=
 =?us-ascii?Q?deuh6njvvYRj1oDLvZR175eT+eajX384k/aD5Jq20WVHfGdhCdabJ0I54G3r?=
 =?us-ascii?Q?i5h4PIv4zRSXg6mWLMxWxAidrVnN+grN7PIGk1dKJ1Z0IKMgOIw9rfQnI9WU?=
 =?us-ascii?Q?JI/jRyOWPnZLOWGh10S7tmON5mmZc9mVbb81BqXYr7wmAfYIC3PucNmSHuoR?=
 =?us-ascii?Q?0kcaVWnX9OFMXO1YJScWR3qhH5F9d0Xcfs/Dwnw32THPZ7Xbs+D60ewZP3iK?=
 =?us-ascii?Q?xILro4OhdRBuzBi6bsH3MtKqpHPTmyThGUc3ZWUVf0DbjVcZFJzvzjscy/0O?=
 =?us-ascii?Q?fJzqwAiqiDrf51LC/Efp3HvUAeAyFekmVtITWHwhVNex1tAnmYZDx5BgqoRb?=
 =?us-ascii?Q?CYw7QEPXq+ypTc8KK5HedghAP9qRMEP+Ml8BU7omtXZp7Tq6Pn7Dd4fHeut2?=
 =?us-ascii?Q?YvItSLWU+4D/VtTh8nnthSBVz8Gk5f7R/UaFZ+3YjE3a50XTkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PFbz8l0IFv0MG/MjA6OrJ7k5YxMuBXNgtGrCnAdyYJ9/PZe2FSTU3ws8fUcL?=
 =?us-ascii?Q?eF67SBgHer30WNOvSpH3lBEiuwgkbDtxcGxT7RQ3VAHIM3o7/n/tb0WYC6wU?=
 =?us-ascii?Q?50jnC6QPyyL8YFNDteqbL5XWkd0/2ex8qBiHP5hYzjOap5fx5ZhzWTRfR75i?=
 =?us-ascii?Q?CyVDfvPb+Cpt+GvHDMQtogL38QkWyJNnIO7dGe/OZZSnN2wSczRH/0C5em0C?=
 =?us-ascii?Q?/2vZ+yqmaFhNHfrVoFwZ3Rx4terJchOvk2tFaofeNtqDsI4LlmlbRGuSRN9U?=
 =?us-ascii?Q?6PDWO9mVd1rvZVRQ8YOYaPhZk/EvJpacM9AE2BcCMQQ0kffLY5p0WKS/vUxq?=
 =?us-ascii?Q?5bV6CXiOoXsjir7qsfBHvqz+L1y/fxgVtW6bzZED6qPWBKsrwMfIjVg8d1SY?=
 =?us-ascii?Q?uaxNcnKvAhVX8RfblB+Wo7PGujhrfHrERzrlrSxjMSZNzDPRgDoOqpkAlpHf?=
 =?us-ascii?Q?bvcO9wlZYAa2QNBtAbug6BBr52BzumoRZQ0m17GMszkMZR+69nwBlJMnztBn?=
 =?us-ascii?Q?Z9uwhMRS3HreHrxgAYWFlZ6kNfEoW2+RQFtlvF8sy357lxNeo9EH9Lah0Ast?=
 =?us-ascii?Q?u3lARQxsSSou2DAyMUFdKWZmEVqbd8EkRuB9hKBLGHQbrYbsHRaM7tZh1qD6?=
 =?us-ascii?Q?rerLw5aZGKjSU2lnmPUfKGKdf1+v2sWEQ5mGHZkI/a+sSY+By+/0KMB8jpxI?=
 =?us-ascii?Q?pws2tXtdlhaplH0j+5gSMjHHMzQQPSIiRpId7kKON3jTVsRKqg98v1oEfs44?=
 =?us-ascii?Q?IDG69jDmEAFJYUKKN2CfdkcafIDwiw+Jf4up8QzacD8ZIfLOJX6c+K9UhPo9?=
 =?us-ascii?Q?LAgqzX0mPzgY3PzhIOn7CdCIvAvr3GnAUFVxXi8amrqBVAdiZTgEnteyhSBn?=
 =?us-ascii?Q?amanRw5M1u0j83++s3Sht/gZz+RMmhy0fJ/4ZUE71qMLf+ATT5jYMEszNtyP?=
 =?us-ascii?Q?shVjdRYPs24XUPsY+ngRelJlyThaDcIzTSZY9lgxVLstXJ/d/oI1bets2P4y?=
 =?us-ascii?Q?sbrEm0ifBSNSGC3lYGl7sbXgfZAvJydE67PLgRLY+Jy+oOil6NgtjzB/epN1?=
 =?us-ascii?Q?JXvxqfe/aPGEMu/QnJfrTPMkj3iWfWTcFt1hvrBuMSed/XknBab/99qZV7a4?=
 =?us-ascii?Q?Xx69Cx3aZqFejoI4F6T+ZXS9wtSAC6LDOkQe5Ax6XlwbhsHd9ZezsAzw5zUs?=
 =?us-ascii?Q?8Zk7CqkmZ24t/vFvxKSSHhm71g2sd9SdKTAJuKBelrmyLot4P16O8b5Ys01s?=
 =?us-ascii?Q?JkRw2NuGXvdam+2x3D3dQHebW55I94d6abmAjp7WlHOzfrGwFo/sptViyZak?=
 =?us-ascii?Q?Ndk/BSBuKa4qEFgI9PyujLvZSEVi0qZ1aWUyUJaOOW6jHu9k5oDRYltVULln?=
 =?us-ascii?Q?cXiWxe2nO22ecqIZR1ch/6m73A99jCqx+I2KbktX3sR4oyCRPwXqNftqNVB7?=
 =?us-ascii?Q?JZdfZwJDSolmSO5FS1ra3EKxvTVH3vNWF+rSlu8AuBIMUl9ywFlZIw+/U83s?=
 =?us-ascii?Q?BJyi/ut1nTQ+XyJ0kr7ZwKX5Ci73Zf5lHM7Qb5EE0lAeyEE13gWlavZeK3wY?=
 =?us-ascii?Q?thwr4D5hSGg+nAkaUOQIDNk/+ukrGrmeqNgk6jP0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f1bf4e-34d6-4e28-5e64-08dcb23cc69e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 15:15:28.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MD1l6n/DOhi8siWxaeYdinKEaGUOTxarnK17eM57UOdNzlOS32ymYMoPmp4NzC2P/BLUgp3xAnn6JBsFM4i7Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6882

On Thu, Aug 01, 2024 at 09:27:40AM +0200, Arnd Bergmann wrote:
> On Thu, Aug 1, 2024, at 01:31, Frank Li wrote:
> > Add DEFINE_FREE for iounmap() and memunmap() to support scope based
> > cleanup.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  include/linux/io.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/linux/io.h b/include/linux/io.h
> > index 59ec5eea696c4..7695d7973c8ff 100644
> > --- a/include/linux/io.h
> > +++ b/include/linux/io.h
> > @@ -163,6 +163,9 @@ enum {
> >  void *memremap(resource_size_t offset, size_t size, unsigned long flags);
> >  void memunmap(void *addr);
> >
> > +DEFINE_FREE(iounmap, void __iomem *, if (!IS_ERR_OR_NULL(_T)) iounmap(_T))
> > +DEFINE_FREE(memunmap, void *, if (!IS_ERR_OR_NULL(_T)) memunmap(_T))
>
> I don't like the use of IS_ERR_OR_NULL(), which tends
> to indicate a problem in the interface design.

Just !(_T) ? I just refer kfree()'s implementation.

>
> In which cases do you expect to need scope based cleanup
> on an error pointer here? The only interfaces I see that
> returns an __iomem error pointer are the devm_* ones, but
> those have their own cleanup method.


devm_* can help much especial in probe() function. but scope base cleanup
also useful.

Give a existed example:

drivers/clocksource/timer-fsl-ftm.c

static int __init ftm_timer_init(struct device_node *np) {
	...
	priv->clksrc_base = of_iomap(np, 1);
        if (!priv->clksrc_base) {
                pr_err("ftm: unable to map source timer registers\n");
                goto err_clksrc;
        }
	...

err_clksrc:
        iounmap(priv->clkevt_base);
}

If use scoped base cleanup it will be simple.
ftm_timer_init()
{
	base __free(ioumap) =  of_iomap(np, 1);

	...
	priv->clksrc_base = no_free_ptr(base);
	return 0;
}

drivers/clocksource/arm_arch_timer.c
Some example need map and unmap in function such as:
arch_timer_mem_frame_get_cntfrq()
{
	base = ioremap(frame->cntbase, frame->size);
	...
	iounmap(base);
}

of course this example is too simple. If there are many error branch
between ioremap() and iounmap(), scoped based clean up make code simple.

Frank

>
>     Arnd

