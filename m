Return-Path: <linux-kernel+bounces-330851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865F897A534
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F191F217F9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4AA158A3C;
	Mon, 16 Sep 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cxFoYx7p"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDEB158A30
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500142; cv=fail; b=gqfHZ3wosaAR/01gcZJVL41MTq6E38fFCaKTJngLgQKdfrVxk4X/66jY4seu35VcPc2yXzKufZMDo42XIJb5+HKbxBzOEppA8I9TEs9MmZIEC0dwOR6Q1Su2QRoEJgFsidcnpCqL/oTdeP9VgwbkTNOrjbCUlUA97mbiFiTBXRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500142; c=relaxed/simple;
	bh=HCClrWxYy2fEVykWuDaz9k+rjfWoVsVaxF5vSKfAjtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FgWBiuIGMq9f6Xk2ZdmJVdMVWKzFuSoQM7gC06eO8eV1kRBr9izIe7HeCbjlOujml9YgSd8Xw1BrDGx45vvpj8yr391hoC9X8vHqQmFvgS1Pi9q5+ZdmV+zYY42ARntQCtLOOp3w4atzHeR81osWpU0esKfnY11j/mEn0zNI7Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cxFoYx7p; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7Gm2SSWYJa/Begkb1y3kmoXk+3Dn1jTJEiMp9OP821/42l3AMOudHm5yUbetveIhoR1I/K/b8vpa+whNtAg/MDbXUCw39a7ADUkSi83b+Sw6j9yXnlqDWBO9AG8HJPuOGMQ3iWcIQ2vhHMon3SzdWx0I7CwAN5ro6EQ8qlAk+mmbrfXce6eMRYD9SH9mHCQPhKedFNX+JtMKN7vyOXBIRrI3W94PhdV2FUCIKbPygJSurykqKlq29L3qysQLBwFqtHea+WLUZfFl0CJaWou877239LwEy9z0MRh/Hr6iaZAZFbIPPNKAbVemJ7Di0Z0Ie/wrB/TGySw6w9uyET4hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nrXDzod+BKEIljj4Gzy9pf0O59/EVfRkATotBwSafA=;
 b=B9ZEzDwJWCpwnz/ECn4nldZ8A02wiVWSsJGrao9Upnj3CDnJZJXs5WqbHYYluITOVuTTam/1ol4B6hYJCeHR+RUZaCI0Zj6RanSwmTXnw5aPhiGBF88kAl/Rf+C3xQfB45avgjljjHqImrv+PK2vkfSSa10NyhAnmFq+9goZ7+6scX7jnKiJ2rP48aw5pKExgR3q+ZNRuXN87oJFP8kzNfXBCxPMVXqiJJQ9ZCDw462nzoeiRmE6vswxDKbz8+56C828q0CiDWBle1fxe7aS03Wy4FvJKWt/nD6z7VqMl/Mg8/6kANjQzAfvWa/As37KtP4PTsnPNcAjCreXlJRFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nrXDzod+BKEIljj4Gzy9pf0O59/EVfRkATotBwSafA=;
 b=cxFoYx7pXSOcZMFd5mZ/ijvIFyU//cdFlyd2JxD4/NmrcId4E40rgfTOeUscGhKG14/0Rmi2v8HNyn0Vf/6HNlR+lQgGHiKBh9d+KbSN85yGukGW7ZYoE2ZY3n+ieq0QHfHdTkx4Ib1IpHNh4SfIQNZjqbl3atmheXvdcyLWOyuBsPHvtdznxmtbhQnLDm3aQHZPkx+4k54vVzYwz3okASSySIZY/OqS9bYnjX+EQLf4Nl2JWdHjRYoAtPck8wCRiA56IOIVU/Y4qVa4E8i0gnwZsGKJRm7DiJAWCr7QXxJilLIQMCpFITbm90SsoHmkm2WH4unhpK79x06aWGjFfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7958.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 15:22:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 15:22:17 +0000
Date: Mon, 16 Sep 2024 11:22:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: carlos.song@nxp.com, alexandre.belloni@bootlin.com
Cc: miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH V5 1/2] i3c: master: support to adjust first broadcast
 address speed
Message-ID: <ZuhNIpoTe61M7rEL@lizhi-Precision-Tower-5810>
References: <20240910051626.4052552-1-carlos.song@nxp.com>
 <ZuhLBFQMScBc+PIu@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuhLBFQMScBc+PIu@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: f0be6ce2-28c6-476b-dbd1-08dcd663598c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AjD1HvozO8svHLst0ahUr9pSF0VlZLUMDdxsZ/bSJ7dXiCYebtyPE+oNcB+/?=
 =?us-ascii?Q?66lO1ffudBybqIvLfTLX1iBxkFSMuhKNbmT3nWMtYRA0Lujhl2EgZTNOjrbX?=
 =?us-ascii?Q?yGLaJyajXRK4GwPT4JrSQQaJUv4r9nD7ZKMelwET/FsnsM+nO+AjZwJiC8u5?=
 =?us-ascii?Q?UFsSbnp21o7i9z/ER20wxOxhi6oXW0Hl+DRKnbMC4B1fKtAS1V4YA7NSDlK6?=
 =?us-ascii?Q?h38D60mqrLNFyOm6LwlM0qqlbJH4QrK+BI49v1gsuzKG67xPmoVt6biX456b?=
 =?us-ascii?Q?o/luJlL5gGqcFt89u3DK3k+y1WnnEVEBDONlHYRO2yHyIyzlMbxhpqIegZt4?=
 =?us-ascii?Q?pgvvXb4q0Ed9zWto/1oiCyag/9InwC+ghgI4+yl8tyDgO1fBW3hMdvFBLoFs?=
 =?us-ascii?Q?fqkoa+v+QLFu3j5ng4v5MSkJQj/AR6Mcn7Q211hwVsSg/xFWc6Ab52cLb3Ka?=
 =?us-ascii?Q?OYYPNRwdhbgWL7RHeL7vRa5qke5I5r1kd6fT7/1DQagenPDg2OtX+NA4/9Qi?=
 =?us-ascii?Q?OQOSOgv1R4bwdhvz5PBKacWQJmhKo0JKahlWSmTPLmh8JGosnw5m7xxCZPzL?=
 =?us-ascii?Q?CxYaDXH0E4sVcH1wmkTdYOns4HJkVuLeksKM91EbxTsHAIiZCnv3CC/7hV7M?=
 =?us-ascii?Q?OvtSZ+Evetsu4he15uTwm5sFdYU7u7PL0mI0fXY8NwUcd5AW6MsFw1LL6WwS?=
 =?us-ascii?Q?sAdIvwu2cO54sR3AKZ2qJoXui6L+rwc31cScN5LevknCKg4pl0kgUgjHA0SN?=
 =?us-ascii?Q?lwQwFsobDF4lXTeH2wNiBMrVcRYZTtRmbmN4nrWy+VzrWFTaYM1znh6hcwRI?=
 =?us-ascii?Q?r1T8HKfHjhN5fav4KmuKjz2TjXPX3N9t7z2FnesohlOs6bAy6n7VGVmxSQWE?=
 =?us-ascii?Q?oOhB59KQkjEYC6Bd8TkrB02Yr3kYvy/1nIaYUgfKo5P9GyyIRR7ui941ct2J?=
 =?us-ascii?Q?q9byKmN+Iyo9NB55YWU6vaCSnyh9uvFsXYk6D+fsimExIIE73A6kYrpF7Bi6?=
 =?us-ascii?Q?gdZhPtLB2/Aa8xHc3GZICq/+3zH1j9WpWzzKbADJNvsn8+sp7iM5meAqSJTH?=
 =?us-ascii?Q?+AmzNsDhtMsQFrdXfzAowOmGbBaBr1Q5/PMK/KrSJ0nJ+lRVBVzfM7zFvTSX?=
 =?us-ascii?Q?7vYDcrhlQyKuWshM1XjzWLHNdePMac/Wlt/sX6jgXfgGGqdfm8VZ+ktSHZK8?=
 =?us-ascii?Q?jKm/YB5QR2fY1H73UUxyqmkdbfRmF1S+5W/RBt+0/nxnuCUm8/YN2QfQBsqQ?=
 =?us-ascii?Q?1OnxNjUOIkaLYtoU5Vs62GU7szYNkW+x+l6Ovj1OfvkxlMOgqMsGyEGf8lIh?=
 =?us-ascii?Q?4SW8cHjFtljbhwX0rId651Rs0A5V62tvE2kYrU+0Xf3//Uu7cM3h/ETwz+OH?=
 =?us-ascii?Q?scwLp8zhuEHvviNNldyZwm36/jUoNF3I02j5sHuPH+bZUmLT4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yLWf4OztnlEOOR1HuCs0xqZ658YDGuspEVN6R6gyUKueMg7zGW7wmvdp3e2q?=
 =?us-ascii?Q?XYplyzfnXxAgGQYBfFaVwrqoKBU0DucR97va6uk1u/1uqOouR1VbCkzuDB/J?=
 =?us-ascii?Q?g4r+ZbTHaJP4X38EIdrG6mLnUxtEuQqcaR26g6RwJ2i2+Xw0TMx5mRzzp8iL?=
 =?us-ascii?Q?ml2FrNP/LwqUuENZshLVifsUTl0u2JE/fSi7tvpkw1NFakUdECVmIKDMlj+V?=
 =?us-ascii?Q?LmVo0jgea8Pe3sPTVOxSWDl1dzThhjWSoeWVDTD2gQZuMFtCMVD6kC9D1l0W?=
 =?us-ascii?Q?nUUrMKGcfNPg/3VjLNjR45PmZ/hUov3/Q7UbRC4i1gKKIAOQaRU8Jw+b870z?=
 =?us-ascii?Q?Yu563H0UgIvoVKrp11/+j2o3QnFTNpFRAMJSM2v1nQA9IoD4/kfSMqrMeX00?=
 =?us-ascii?Q?WrmajcOs3es1oS5lbyjpmAj3XHqH6jJkGmmwmh2EfZviE59K+fr+G4t2LmS0?=
 =?us-ascii?Q?ZolLFcRxtfnP440aUOBKVE8fvwaI8k15NtxZDYNETIq3I3agZbtVmf6rfQQm?=
 =?us-ascii?Q?Tqdr2UagYL/+4cpBDk91J/iWHdrxxkvI+JD7tqWGPhXGucdmWCFaqlqYdOeN?=
 =?us-ascii?Q?zguK8p8NAJblSJkD3nEtFDraxNYvIvqmnb2eGdMJ3AHWoCd17gfNt7ZMukaT?=
 =?us-ascii?Q?NEf5bPejaQybQKB8ownmdqmNtnEVSQuPLYlwj1UW1H2b8WdQOgOzHZl9Dfqv?=
 =?us-ascii?Q?E3aPdIaezRnPPSVccWZnGjNXPwzk/5k5TKNwRZSfuoWBPM8McvzxK4Nw8Vko?=
 =?us-ascii?Q?gbwQIuqolVfdeLL4vkgNcojOK57cy6D6/jHmd5PuPokqBnNE0aDdK03EO4id?=
 =?us-ascii?Q?7iZVTxNoZa4bCy6lLXUk8ycyj6JTMDpmKI9JwcH3RDm9GZ0JH6TJkLqJe8Lh?=
 =?us-ascii?Q?yPc/wWy9vGIDHmUDnRxWOIeIwApDl1GlU44jpHq8rHkbgqvMmAZtzmz2QUHF?=
 =?us-ascii?Q?KHRDAWFGdNs0/Kp0aD9s/9Wojkxj+bUutRMlgFGHNrQKjSFMhSEdHIYnZDgN?=
 =?us-ascii?Q?ONp/w2tA3qFsHXpend8bawqfyduPiWLODPVxVgewurI6ktRgwjIsNSHsC/+D?=
 =?us-ascii?Q?RZFmGcsFttEtoq0AgxRk8eFUIsdZ2dKvwpWrQlB+F2KGvWhpI/5uNJITyXxD?=
 =?us-ascii?Q?UCyY11pZZFyro/KiVVmGoxUR1vbmKq88tb2q6qR81ibAhbFUuOtvEm3SS0+e?=
 =?us-ascii?Q?uRvnOPvKZ7v4Mg4ffsIAh8QHKNPvg/6uhB3r0s3/E7yJFX8ah3SOrb1OiCDp?=
 =?us-ascii?Q?1dJoFRnndw2Gx3y8nMc9v62weSzx+15RBUc9XpAtqgXxAxaCG/TYe/aS+luz?=
 =?us-ascii?Q?nxzFN6zRRSjBbsa05l8V1fA27t3U4Fn94t8fxtskcZ9Nw9W0xsLuQsYkVZUG?=
 =?us-ascii?Q?Gi02jA82VvGjJ2aonvfAsBI53OkB14f3O7ouH4OecCFPIIstYogg4QJYNnBA?=
 =?us-ascii?Q?gxsuAkSbaJesu9cT4b2gFxJoCxmAZKR4R9L02lo1q8Fp81GthSEaMw3TQTkX?=
 =?us-ascii?Q?KVyUFrAfGyj71YrGfUwDJvUJ7Hup6nQk0SNXn2ejqEQQO4Et5Hbx4l9Zrril?=
 =?us-ascii?Q?uh+JzXeFiMxLd+3C39g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0be6ce2-28c6-476b-dbd1-08dcd663598c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 15:22:17.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VV3x1xHobyD6q7t5ViO5mjrwdhchtZJJxl3e2DQ6HDGj0Oxw7QB6udDtTnLMPDOLdAzo5Yy6q1UHFFKHnPjC1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7958

On Mon, Sep 16, 2024 at 11:13:08AM -0400, Frank Li wrote:
> On Tue, Sep 10, 2024 at 01:16:25PM +0800, carlos.song@nxp.com wrote:
> > From: Carlos Song <carlos.song@nxp.com>
> >
> > According to I3C spec 6.2 Timing Specification, the Open Drain High Period
> > of SCL Clock timing for first broadcast address should be adjusted to 200ns
> > at least. I3C device working as i2c device will see the broadcast to close
> > its Spike Filter then change to work at I3C mode. After that I3C open drain
> > SCL high level should be adjusted back.
> >
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
>
> Alex:
> 	I saw v6.11 tag, These two patches is critical for imx93-9x9-evk
> boards. without these two patch, all i3c devices can't be proble. I am
> sure if there still have chance to get merged for 6.12.

Sorry, miss 'not'
'I am not sure if there still have chance to get merged for 6.12.'

>
> Frank
>
>
> > Change for V5:
> > - No change. Resend this patch to list after subscribe to mail list.
> > Change for V4:
> > - No change. Send this patch with svc-i3c-master.c fix patch.
> > Change for V3:
> > - Modify comments from Miquel's suggestion
> > Change for V2:
> > - Fix set_speed description from Frank's comment
> > ---
> >  drivers/i3c/master.c       | 12 ++++++++++++
> >  include/linux/i3c/master.h | 16 ++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 7028f03c2c42..6f3eb710a75d 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -1868,6 +1868,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> >  		goto err_bus_cleanup;
> >  	}
> >
> > +	if (master->ops->set_speed) {
> > +		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
> > +		if (ret)
> > +			goto err_bus_cleanup;
> > +	}
> > +
> >  	/*
> >  	 * Reset all dynamic address that may have been assigned before
> >  	 * (assigned by the bootloader for example).
> > @@ -1876,6 +1882,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> >  	if (ret && ret != I3C_ERROR_M2)
> >  		goto err_bus_cleanup;
> >
> > +	if (master->ops->set_speed) {
> > +		master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
> > +		if (ret)
> > +			goto err_bus_cleanup;
> > +	}
> > +
> >  	/* Disable all slave events before starting DAA. */
> >  	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
> >  				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
> > diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> > index 074f632868d9..2a1ed05d5782 100644
> > --- a/include/linux/i3c/master.h
> > +++ b/include/linux/i3c/master.h
> > @@ -277,6 +277,20 @@ enum i3c_bus_mode {
> >  	I3C_BUS_MODE_MIXED_SLOW,
> >  };
> >
> > +/**
> > + * enum i3c_open_drain_speed - I3C open-drain speed
> > + * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open-drain speed for sending the first
> > + *				broadcast address. The first broadcast address at this speed
> > + *				will be visible to all devices on the I3C bus. I3C devices
> > + *				working in I2C mode will turn off their spike filter when
> > + *				switching into I3C mode.
> > + * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open-drain speed in I3C bus mode.
> > + */
> > +enum i3c_open_drain_speed {
> > +	I3C_OPEN_DRAIN_SLOW_SPEED,
> > +	I3C_OPEN_DRAIN_NORMAL_SPEED,
> > +};
> > +
> >  /**
> >   * enum i3c_addr_slot_status - I3C address slot status
> >   * @I3C_ADDR_SLOT_FREE: address is free
> > @@ -436,6 +450,7 @@ struct i3c_bus {
> >   *		      NULL.
> >   * @enable_hotjoin: enable hot join event detect.
> >   * @disable_hotjoin: disable hot join event detect.
> > + * @set_speed: adjust I3C open drain mode timing.
> >   */
> >  struct i3c_master_controller_ops {
> >  	int (*bus_init)(struct i3c_master_controller *master);
> > @@ -464,6 +479,7 @@ struct i3c_master_controller_ops {
> >  				 struct i3c_ibi_slot *slot);
> >  	int (*enable_hotjoin)(struct i3c_master_controller *master);
> >  	int (*disable_hotjoin)(struct i3c_master_controller *master);
> > +	int (*set_speed)(struct i3c_master_controller *master, enum i3c_open_drain_speed speed);
> >  };
> >
> >  /**
> > --
> > 2.34.1
> >

