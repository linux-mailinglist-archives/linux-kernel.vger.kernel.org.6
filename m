Return-Path: <linux-kernel+bounces-566227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90310A67530
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D0418951D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D968207E0B;
	Tue, 18 Mar 2025 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ixPjKgfE"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D01EF377
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304734; cv=fail; b=saZ3sx3X+SbjR96if9veHx6BscraCkuGknqaVanPG1fric+y/KHHj7Ijm7nYeaCRzkORZQpyasIAnj832N7Br3JtgeDKU4bL79fW/QNBwcozp32cgk3Aa9bMqxNJ3vuWUcRRIXBHUtfP7gtxlFbVNZ930AH7iozC+4D1mQ1yQRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304734; c=relaxed/simple;
	bh=Ddp2Kzqfvhq/4qJijieuuXTeXD+uQcIdzC3wuYx6HGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rl9t4QC7V3MiNqFUWzLBXvNIFiIi03+tbjgNd6bW4bHvFF9BoWP12nkoAlEKzP6rs4fe1HGadzQRvzScojKPhavOKt5jOYBYdi2Mb1+GF73cNxwr0cyyk/nLlysNetvEScECorSlsghRNqp+RGptPq6fXNygxVTYJZymd8iFR94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ixPjKgfE; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeYFlM7TAUvulRPWctsKtbidAltzRt8T0VsWJVczcZyz8aOIU7w9mVEu1LVqjiCe6WaqYsCvZWJ0ogGW/GfHMWgKrU3ftctmpFMzuOO3xayUc1nLZ5GEQvD0PLwNa517SdMyFSvXi67jYdSOLRtZMnVRu4WHXApIbEn+lrWsspdqrIM89o/IlAZgsUlPW8bBeb10VkXUjC+Iqj6wTtrgX+i8Ig+PoV3EPs552/9aLqhpwLy0rJ7IGN+Fs8XOY7xQuQrzeK53dJjTG1fFO0FJAZKq7wbAp9OVAhpmbbtC7TYKu5yk/kKiDdLLfX2E/2kaCWLEFx8N03c73Ml9LFmpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/aWCcCDpMu1NZMBnUBEU8jbsf7va9mxHZpT0tq/jX0=;
 b=ZP0fFuI4e/RNv0olfBjju6rsMa7sAhG9BtSSrbZmwnlm9PmIR7QZ3N/ra3zBYgMtYPT8e2tpPOj2bGiRuYuku6SbOzE9qyFDZLFNGJoimFizo9m7If2D6Sl+hfnG2inxCJK6bcU68pN4tA121uYNGArj0EM0NstgyJEvadb7UmR0oUNtIQJx1g96hzP1+OqhIdQXq9pbBnUMsAfwZ/T3uENdAzsRTaU0Tw3a9Ol7m8fqeHlh0+KK4BUaEWgYSEMwMJx2UvUtYbupexoQaVxMTGAopoFwUZpQpK+NAWLfG4Hmhk5jUJBV6okvQVZhQaAKFUWSg6mT7N5RLka1/RGFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/aWCcCDpMu1NZMBnUBEU8jbsf7va9mxHZpT0tq/jX0=;
 b=ixPjKgfEavrabMBE6jTfbg1Ka2uCCCw03qwnY/ZWyp1obFeoS8f+qyXdnggIyzmE7icklalrVDxVq/4KtneUy/pjfaoIw0YqiDxlzEeiqj1NntThXG/zlpfJnF6ivOGRDdjqY6aNr/ua4ZdG4tOnWJoGhKl+6xrxq7IE7tGKXM6poRhOwkMvEUjGBg+3d0gH2KeVxto1zd2J2BT9vl1HtlVUbZRLucwslFVZyjnjSc6WrmX38k0OdINV8D5qq/qAT/RnYegk5nz6lWCBvDYHi4JhfOA5RgLRpF7Qt2Y+YsDAWXYFn8AOvHdhONbrXq1tPGmqh07NQPh2mM5EGRwTvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8241.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:32:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:32:05 +0000
Date: Tue, 18 Mar 2025 09:31:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Stanley Chu <stanley.chuys@gmail.com>, miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1 1/3] i3c: master: svc: Fix missing the IBI rules
Message-ID: <Z9l1ycFFisuZn2zI@lizhi-Precision-Tower-5810>
References: <20250317051951.3065011-1-yschu@nuvoton.com>
 <20250317051951.3065011-2-yschu@nuvoton.com>
 <Z9glVBnpdwXuLwD7@lizhi-Precision-Tower-5810>
 <20250317224440840e4117@mail.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317224440840e4117@mail.local>
X-ClientProxiedBy: BYAPR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: d863b316-70c6-40fa-0b72-08dd66214521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YBDc4P4i5diYlUfNY2SxvOF5CrYPzufLkH2wwS226U5LOzeb75q5VAMLhAMc?=
 =?us-ascii?Q?OkMs/q8eq/21f3fAh2JYFwS60Io3LmTuVoDj+Ano2nKF4zFU2UU3cJWxcbhk?=
 =?us-ascii?Q?es/7EaoLZqhMx8UhL+lLPnL/Y9bTwRJM0P92T00QRpSog5hpQHdeyzSPqtcw?=
 =?us-ascii?Q?clS+znECQ2jjvVPmhbt9Fgo4fvCkurv7Wnl5zVSf+VcZmQ3Z7LNtff5H3kZy?=
 =?us-ascii?Q?XAVA88kKfHaoRS8IFWgtetelfJM6UFGquK82gHr5qH9Xs0RgZ2bTWjfxaPd2?=
 =?us-ascii?Q?TZYv7ej1qb4nT/JOMMht7GO2FeR8ULs8VdHmhZXvE6/0bGP46wUxPFWxb7wN?=
 =?us-ascii?Q?5gbCvWtsnfjHQibWQQCImNvjgsNDAHs/VYLHUpv7gBUVfRcT9ztFMb4vxouQ?=
 =?us-ascii?Q?SUwgFjdrURdR1W3t3CiQ7gRAwQYIiTkcWdGtkBi2FHhLxLAanzJqp+a8LEAN?=
 =?us-ascii?Q?HbItoGvxSN8DRd2hUyxZ0jPv5afHIiiWPV72nZqEAVqIQTA1eMiSk/WqH9pC?=
 =?us-ascii?Q?BH0Tqtd3IDuzZ1Dg/ZF8U8O0udSW6YNqrDZIqWdVNieGmXeMc1jM1Gzhc25C?=
 =?us-ascii?Q?cSmVzrtLfD1C/SxUq28I/q9Ota3CEALBQPGS0rF1SGPH48wtO/TW17Xq0gJB?=
 =?us-ascii?Q?p5cCzzke8jJiT5xrMvx1sfY76WzHzVYLhg8u3zkQ6lq6gq282sw6b0zekXzn?=
 =?us-ascii?Q?YKFwpabN2udvdP4RR0oJSMzosbEvbvXGQbJ+s3OT4YthSK+kTh05RCCisezI?=
 =?us-ascii?Q?u4VTwBgbVYNNO6cPGQ7M/Olf1s2X7icejveRtpn/m6xTQzm9VEV+UustzWMM?=
 =?us-ascii?Q?0dppVlctQpuHHuUILZfJxP2q7MRKiSH+HZfaU6HesltSeBuruDKcGSU5/vLz?=
 =?us-ascii?Q?unyKKIrAkKjhe7A7XGscvpXFL+nd972PLAelXQwxhwE1i3WSMoZq8k4f8Vy7?=
 =?us-ascii?Q?zsfNojxet9tmHgqnXQM/wb8xFrLl8+Uy9skP+4BJyiwgX4gsHantNOu23oEj?=
 =?us-ascii?Q?IKMZB9H7Db7a42uiUgPQftufpGD+ayiEIM6pSz1j79OzjvYMwAtFGStJsnCL?=
 =?us-ascii?Q?4YA8MDe5JgFZtl8JnyRUcKRW9o0BUkGdiOHuwTBMkoA6o4iteAFVSt6xRQW5?=
 =?us-ascii?Q?Z7I7K/4rTaYOEgKxkiL5y6SX50o+X2dpFZLK+f2RJXXVvEHFyq8lU1XwBnLN?=
 =?us-ascii?Q?b5pveNx5zsh1yLgnlNMGejkn516oFE+L09UBxtOUpNbFR5rk1YpoCNJJzTIr?=
 =?us-ascii?Q?IGdUdKCDFaDA1rNvpE686peOnTRiLDgCu5q2oWvd24wiXjqgDMUB6tmGfF0v?=
 =?us-ascii?Q?EPJY8tSeETdq9M0gUZ0rgWDqRD+sOKbApt80dgA0Vxl3b43LRc6q3hp+sFe8?=
 =?us-ascii?Q?LzihSAN3+904s4/+MZ81FhS3ymbB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5awPiFCu2INKsAweSW/djs3rGTB/lC2MjVTJvGk/vJdQylG0/7dZnDKg9BWT?=
 =?us-ascii?Q?v63a/hEKR2EmD3Q+S28JcMyKVgGeJWCHTc1DmAUSvq1tIbnmIIqBVu3M+wdi?=
 =?us-ascii?Q?KG6G7PmQE95hpO3V3ggMYPWcPZU2sjGKrIA6M9eWCzowNHhjV/WtkB7NFxYa?=
 =?us-ascii?Q?xCw9oxRLKGhnITyxG8KqyugflY1FP+ESihvY+TzwuLZfUhRGLwut2PQnaZJs?=
 =?us-ascii?Q?pWNrMGBgm+8bhffgIQ1Mo/FmsePC0U+CcPh+V5ntyF3RnT18mozjfJsoNTJo?=
 =?us-ascii?Q?agPs9aaSp+80BmfH5KzimInnPIm87xZrLdc0/cdgHT/rZuUCaC2DThcjKXln?=
 =?us-ascii?Q?qgvS3aqsCwrgtoibSzohg3oxjbKibgCk9jR0WGDBoY/+s4NZgtR9vB6WQ/eg?=
 =?us-ascii?Q?DIo89GiwqtnAgM2FcN8sZrikh23R6yJDkawAxrTbF0IuPPEXAIVy4MxqE3z0?=
 =?us-ascii?Q?2eUkhhNreftrlEDVp4ilbhV/wpbop6O3ni/yZJ5hWYnuShTKzfcNDZnSURgw?=
 =?us-ascii?Q?KRCb+k80iTvTbpWhIFDOOLe0VvORQyN37Map6lSYsdZGzG+j4DoIlmVOo4YH?=
 =?us-ascii?Q?nGZog+3xzAjFP//B79DQAq9px13rhMzoGSA0iFgcS9QEhsYolMPsIlCnExXI?=
 =?us-ascii?Q?U3/dwfWgc9NgbmrELK1MWZcBJYNdZKKlnOv2ywUiw0u3R/2iBi+H2Om5LIFB?=
 =?us-ascii?Q?7IyWvn97mu612hpFOPL/u1sbKfowIv/vE0gUxdfzT7PTrbKBx9GcQkJwVL42?=
 =?us-ascii?Q?gy1czZarM5M0JlemkfYiyQOWmcDgv0pqTCNe7g2Ci1gj6UcAK5zAHCw1pu+a?=
 =?us-ascii?Q?PlHj/nJg/9zT2sRjorq+KprGVBBX2558CLizTFMToHY/Me7fmlrMm71ZhIBN?=
 =?us-ascii?Q?fkd3sGAWFNVp3M7NOGh6lxUda7vuQ7CgSZlKTMUtZB/vA1jqRUaPSMyjdTec?=
 =?us-ascii?Q?NX2Fv0a7BtCQZzqvOlS0iFSftQZ3sgdnpXiibtHunUJMsWCayD1V4REpnNaY?=
 =?us-ascii?Q?y+fShgFzUBAlWjolGFlmH9CvRFI1x7Vx1UqbkgvsmWxgNfi4ORPfjX6KLkjG?=
 =?us-ascii?Q?b1Zusi+7c1xIM3YKatj+Hop3eQFgEEBzazZ7SHfx0wpp9UrFi/rbMUyslzAA?=
 =?us-ascii?Q?jXLGZ/gbyr/4vESNxav2Xx01DmVEcEn/Ja/jnghsskcDMcS2RRiDzEU+GD6h?=
 =?us-ascii?Q?KSeXzaL6wwiJ4jtBjuVSmG32117DedjVzjUbQIRhHOzuX6XzQU27vccCh+t1?=
 =?us-ascii?Q?uVCRleqAyGcK4D4KneCQKSTGzKKk9X4adRXfBXKzE736QiYiLmcmPT+xqEvp?=
 =?us-ascii?Q?hKqNFcQfP9la7TdxgVdTv7MASHKFVbeleCgLieE1/U+DmSTuNz4iyRBNbfSn?=
 =?us-ascii?Q?CBoi89OT/oT4gg+ATYaOcJVqnLtfZZdWlZEyjNBqLqEDZ13MEZWc0mUnfloS?=
 =?us-ascii?Q?iM5MPlIOiJ+vY5VrqWRr/SWIuITiqlbWvFkR2zHg0MS6qgZOkoI1yzZ9A4O7?=
 =?us-ascii?Q?Yi6NPX5wUzyosqxAe5eK3qaRk2fqLa01E8y0Dr0RmMRVvljCWhOkXio++zUZ?=
 =?us-ascii?Q?79T29uCfYCZeKOdiFlQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d863b316-70c6-40fa-0b72-08dd66214521
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:32:05.2030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GiNp6Mmkj6dC8F8TkMsJ3+7ugR2iezAEJa3qOxu3FFt0Oi+4cdwNFtTJte6FwzbQELkuZhgxUo9lucnfP8bhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8241

On Mon, Mar 17, 2025 at 11:44:40PM +0100, Alexandre Belloni wrote:
> Hello Frank,
>
> On 17/03/2025 09:36:20-0400, Frank Li wrote:
> > On Mon, Mar 17, 2025 at 01:19:49PM +0800, Stanley Chu wrote:
> > > From: Stanley Chu <yschu@nuvoton.com>
> > >
> > > The code does not add IBI rules for devices with controller capability.
> > > However, some target devices, such as secondary controller, also have
> >                 ^^ dual rule devices
> >
> > OR
> >
> > However, the second controller have the controller capablity and work at
> > target devices mode when the device probe. So add IBI rules for such
> > devices.
> >
> >
> > > the controller capability.
> > > Modify the code to add rules for devices capable of sending IBI requests.
> > >
> > > Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> > > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> >
> >
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Please avoid adding you reviewed-by tag when you request changes, else
> patch work will show the patch as being applicable. This is fine to do
> it occasionally but not for all the patches you review. You can simply
> wait for the next version to come.
>

Okay, I saw some device tree reviewer provide tag if only some minor
changes.

Frank

> >
> >
> > > ---
> > >  drivers/i3c/master/svc-i3c-master.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > > index 1d1f351b9a85..a72ba5a7edd4 100644
> > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > @@ -1106,7 +1106,7 @@ static int svc_i3c_update_ibirules(struct svc_i3c_master *master)
> > >
> > >  	/* Create the IBIRULES register for both cases */
> > >  	i3c_bus_for_each_i3cdev(&master->base.bus, dev) {
> > > -		if (I3C_BCR_DEVICE_ROLE(dev->info.bcr) == I3C_BCR_I3C_MASTER)
> > > +		if (!(dev->info.bcr & I3C_BCR_IBI_REQ_CAP))
> > >  			continue;
> > >
> > >  		if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD) {
> > > --
> > > 2.34.1
> > >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

