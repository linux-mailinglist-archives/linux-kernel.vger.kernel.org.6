Return-Path: <linux-kernel+bounces-409680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6004E9C9001
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C211F242A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB07C185940;
	Thu, 14 Nov 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jd+vY/01"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71EB183CC9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602534; cv=fail; b=nxWzrOdtDZ7JpF1/RuQ1IpEjBcQjpalKZTljAUZo1A+cZjMsbyzFwx4N4oGDConBfg7ekjCThWA8mmdiO7lKebdLz0pF1rOQ6c76Gig2nqU0BkbKaYvRMDnHzfbU4bqAhvfMMvpvxOmD7PUFXo78IoN6Q72nKUwiIYq/0M1vUjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602534; c=relaxed/simple;
	bh=ETuHLX6P0xyg+yUBYkDRYkTpFldNg36uf8oB6jEDPvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Brb8VckHEKvG38at64gGe3eEkOEFCg0DeTDrdfvMyBHswj62/5a3ab9sb4ysgPT1LCriQpg64ngzBKkCtTJGSCCspyoqlOCKQn8+OvRv0+Iq0Dc6sbjfAJqxa163U18EDfYPkwBxEEBiZcdhY3AgbyDAXD2Ni83GkxuZ1VSw6Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jd+vY/01; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxhEtfb2EN4xn1DiM4Rwoy9LPzQhvSNN3LdkWOYiLMNrZKiziZjInDamaOTSTaZSsUZMXdwrY9Gzl/HV+7oZzaOGUtc1SirtbDzf0WyS2ubdKDap5TaXFUCi/OxWX44+02s65cBLgNfm/3Oi/IAVaRbgmZsBiVMzS257KcTjwcqQX+G1yV8KaIYkbUv0P4Fv4byTYzEIhqz2LZ7uJQ6rb5/nj8shfFjeLG4AI1CMQoKzTM+OGm0dUgm8dwP3WLiIXBDPLR7SVuJ8GWHUo/SP6HmoW1chELoveZaSG1/Kt0iHOhEffpxTW3VCUyMXkLE1nTKAAtx6CusVb3h/5nIEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4oBcSoPWS1ijLnjT7UuN2GM4IwcjkpvQQ/xe1vRpqU=;
 b=t8iuF9ZTmADGzW2tkRS0WVFLM8by5fvuMqEvuke12xtORUn1BrYc4E+dsJ4Z+awNj6ZajlK6kq3eYUVKbS78+CPL9uXWSuYg8ASBOm0Ro8WUPHaEezWICXX77xzav5PDHEyZ3MQP2rUrgAUNxvzjQRSHI+/LdL0APduP3DHvBpk1kLfR35u8HNxrOHF1uQxP8aYUVDUR0Auf3cT3E4pew3OG+v+TYSCWMWTsu17ZLhminYeos/SQOQVgz0ngzolte0Htx7U1wW4XMctTDdqhg+inpTEHKlE69kvcE4Yh9KAvDMCEPpTIqTHv3Ns+LYYv6r7peY5SXQxpMWZHSla08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4oBcSoPWS1ijLnjT7UuN2GM4IwcjkpvQQ/xe1vRpqU=;
 b=Jd+vY/01cCCawiQAbKD0VnJSGVP2Gq1vGLwcOee4Cd61lvPXEADDZd1dr5smZOTnNMr0zkg9BKwDeD8Q4nfedHfQzi5TGPZRPG1EVefGWtRugG4fAfIerFCMjmn1m0vHMLmeQcOh2BvO6ldA6YX1fo8yOSXc0iR7nQULhGizxyaHG4/jxi89l6zESI+2PB2dJqutSE0DtuELctDjFox7rpRFTEwGHpd42KHkJrlK9nIhI5r4xsVzYXcVcGgdOmAuBoVIRbdtTii7ZLnVEPeerWe3j4aNj20YBfoPk8FT0376VmPhq4OQk0pPQxxRHYYNhbd/Cglaj6cfj/WW+e0e/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7623.eurprd04.prod.outlook.com (2603:10a6:20b:29c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 16:42:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 16:42:08 +0000
Date: Thu, 14 Nov 2024 11:42:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jassisinghbrar@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mailbox: imx: Modify the incorrect format specifier
Message-ID: <ZzYoWFVhfNnAcAmy@lizhi-Precision-Tower-5810>
References: <20241114055926.38502-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114055926.38502-1-zhangjiao2@cmss.chinamobile.com>
X-ClientProxiedBy: SJ0PR05CA0207.namprd05.prod.outlook.com
 (2603:10b6:a03:330::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 5179fd89-d498-4ac8-8689-08dd04cb47de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wJyegtNsiU11w7jWGWq8qiqfy6b0i62z6tCMcB74kU5jkvqOVb7PDHVid7o6?=
 =?us-ascii?Q?MNXHxx6ehDjKmG3s6J8xVCKtDgskzoiXNwX4L1nt+LDnuyrdx2YYkQT8chfl?=
 =?us-ascii?Q?wzA21OvdyyY2mTTtCLQDk9lklyNpWCRGsDmJpV6Q1bzNECVMSpix/akz1913?=
 =?us-ascii?Q?HrRhhnMhOC2ImR5ngB8gkNkOZDvptsh2mFNOQzsP6vqUZxicJV1/hVucV+wt?=
 =?us-ascii?Q?SNGzthQq2SA1Jpo8R57qjchNHNSYR2aqtYWmZu/INxV0sVJFjxq1GiRS4vDY?=
 =?us-ascii?Q?Q8dWsO8Jv7X6WrJ+z4gAMOUiHXrjVZ0QIQp1k91LjCCKDaCf0yUPMOPKJfbT?=
 =?us-ascii?Q?stklEXI6sNPd09YirrQWWiajR9lsmMGS7/HSUY2mt2jtVuRUAh7py1TTnb3y?=
 =?us-ascii?Q?B0JrQzf6EL+Tj54yb1LeuQhxG88P4fylYTRXlbBApHJ0l7BnpCB5SIxALHnC?=
 =?us-ascii?Q?sfIdbY2JuJbEczevb9rsEcl3vxpBPyDjZ9/OYWiY8BEJQuJuZ4oEHTGLhsiP?=
 =?us-ascii?Q?/6vivG+GCAY+EJWOBpqwLSBLBo0nndf2ZVp1Yt0u0jZ2il6efdMs7Ofj/snb?=
 =?us-ascii?Q?kcIuXJNBuIumpN/4AqYHu65a0cPxp874VP/zjeRKq+yVo2O+GKCQsZ/tvEOK?=
 =?us-ascii?Q?fTPkvfD3cRn6O3vOrDpD7l7MdQJqNe0/aLQuNW1VYmYjlKghOyB89ZfCqc6L?=
 =?us-ascii?Q?pkKEC1lUH/86ZadSauLMz0eWlXV9weAJdf0qFsoUzqGwnu0uld4ltGH6Iybn?=
 =?us-ascii?Q?r+RghKCRaYTCUzbhg7XlMvROu+uuPd3igtMtuzB7BxfPDpDVbrrDpmW/K+qd?=
 =?us-ascii?Q?6NfcvLqbQIZbgLhjz9KMNC9teG0Hic9xgZZ/DmtpNGdX/9HKG6HoauSMVhiu?=
 =?us-ascii?Q?BcZxXgnyZfM0uQuaifuv/OjRZKVXL8GR6NS/0zdPvwCud+5a0jda2MRCDyhT?=
 =?us-ascii?Q?332HYeXLK4nfpeLgOnOnAbw5evbuH8g5vR66r4+qR6tAsckXzZ26QbdiMGDa?=
 =?us-ascii?Q?dcMscVGG1glszLaZman5HVAJqFcjPwHuFFsv4VnYfHj78AQ0RNxxWEo6ScFF?=
 =?us-ascii?Q?89/26fwMT7q/+Hf36qchTZ8Z8D8r1jw+GqF+hud5Mg+7ZGzY+HCH/B5qr/fA?=
 =?us-ascii?Q?Oe/BS/4mfG6elYrN3xFBMHVmO3t4P8kTJzF9VmxP6Sar0W258/ktxM95hC3o?=
 =?us-ascii?Q?pYsnSeMlKPABhdLw8dG5+qCpuy4G3rL+i2wX1e7nRmnOvhzyjkoNGifslGUE?=
 =?us-ascii?Q?10ASwBPi3cJoI+tjCSY95echQ5cNPVqRlnOAn+AOZlqeyfijUTqc0355rpBV?=
 =?us-ascii?Q?9foetXpMCMp0X9OgDm+ivuzI3S49cdaVGwjLtoWsdLGGWHxuM4M21JYWM/VA?=
 =?us-ascii?Q?683uptU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OCzmBaQDrSxIPwjRnDhKfnKtlABFSlvECWUkTHXeC3wZdElOuEGAUL1j3rFh?=
 =?us-ascii?Q?cUG7epylim/OewU6A2di2Zbk91h5YeEE+7DV9PnLfe9Vm6c7uUKsu2P6PL20?=
 =?us-ascii?Q?DOHzQnalvfdHz7ia4ll+6Enld9tU2I+Dn+SpCicUxkzmh/CXzKl8pzY05G30?=
 =?us-ascii?Q?mEPcHkp4nflohGjYCdU7mfGu4kmVgeEQMs27R+ygQkFYrA8opo2PVjzGnNiu?=
 =?us-ascii?Q?Z6B2xyjW66P9z6Pp/Lyg5e5+ZoGG5s5KCRDhoSCAUcMLZZXY4Mf7F1V+9HlK?=
 =?us-ascii?Q?ymLFPkvWXZ7ttJ7JEXV6qeNXpoLwNDBlKW8iYL0U0pCkrjJDlbvR5/VNGR+C?=
 =?us-ascii?Q?gsqkDK+M3SbCZB1nx4TQRCFe0iMHBZp5YfSbH8M0KVMMf/vUct8rdeJFJcs3?=
 =?us-ascii?Q?hKq5zTgp0YE6UjgbdVeTrZaz0oAdP4On2Wevmhfa7f7jptgboBzBSxSy6XT2?=
 =?us-ascii?Q?xplKl/DmJsqYMEi4bzOYU17zEqRDoOuNjPoTsGXldR/QFkPBEZBy9Ga6pWAJ?=
 =?us-ascii?Q?z8l2xd8wM6i4goav7dQMT4R6L7dy0bYUXjes83btdKFJlGspXp6Vm9JktsU7?=
 =?us-ascii?Q?ucT4bYTqyFsksPVPn9O9CSfqnaKrw6o2bBwVH9L7cJbARkUmHxIfBnyilKDa?=
 =?us-ascii?Q?GzOLdmkryi7uBLt+oXsl2vd0GJhNAxlT+bAZYbdrRoIl5U1o5ck4X3uUeFL0?=
 =?us-ascii?Q?3LSOiFhK+4Dld8BuSgbbhw1GhC3Iw0mxj/yvwtX2p1EJ3JCQPUEk/58jNVZx?=
 =?us-ascii?Q?RhPKKJ20Wqot4Cq/daOeL0PsVhS10dSz0jD+JRZ6l6uW7Sp+GHJLDKjtQAqt?=
 =?us-ascii?Q?8ed5fBi9zUGEvpRfO9WZKYNXpMDfziEcFxnrx3qvuH8T2ycJ0jImnwF0xgSh?=
 =?us-ascii?Q?K7cUa7jyavoM6x856iNopKq9qASeLV7SfxxObuEKoPOHOBZNvfamcY5NKKxn?=
 =?us-ascii?Q?1eNKJu13mckoytPQynm//NVBYMHe7pqByKAJeUiUv21PIFZi2pShUVOS8IXM?=
 =?us-ascii?Q?1OUnszYN+JCygV8tO2o8XwqrU8k/WEBWhjBPGd5ztvE8BS+GNY/oiCqQ3p5x?=
 =?us-ascii?Q?U1B/WLsm2i/vTHA8CYy6y+FWbz2oDtjjSA8ohhWa9vi6KOfqhOueK/MOC9tM?=
 =?us-ascii?Q?omC6xYd07tbJWDPNbfbq4kOErrQny4aWJU6Y/VDBAxZSfAAftkl8GyExUtjY?=
 =?us-ascii?Q?aS6/fGKvbo9gw9V3oQc9zF19LNAk3bA8olpkdlRhom9tA9n9mKAdbmQ5qipd?=
 =?us-ascii?Q?ZmsG/0kvd4B1R3Z41dk+KQ7b/RRJlX2oMcZqqIbysQM/QhV625TYeE1QbbqS?=
 =?us-ascii?Q?Bf2wqT3s8AsA7ElaCf8/Wl/9dpoP8VbOgSrntrqN77bDrd0VVcW/RztDJ6Q1?=
 =?us-ascii?Q?hoFOgw5nGJfyosjWCueln5mmGvOhPoH2xst+YjX3VPjOuJxQ7oqbA5Kne1e5?=
 =?us-ascii?Q?8wbd+zXxLz/zBSm45KSbgfZQiPX/Cvm/sDKQ8z3nVMYuROxk2YoWYm7wW98V?=
 =?us-ascii?Q?4Gr3XcX4ha87eDjEq3cicO7HUtulvAOtcRseddskDC5jxiCDstmRrhcFrBDu?=
 =?us-ascii?Q?YXM5jEd1lrLOnpt7Tws=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5179fd89-d498-4ac8-8689-08dd04cb47de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:42:08.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehEl0irEZYwjesHWWXIL7KHGxvh0d3Q0d28xE9XwDRMHptNDi4XiaDuNZIuY2u4MF9XNvvVGlN8rcHslald1Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7623

On Thu, Nov 14, 2024 at 01:59:26PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>
> The format specifier of "unsigned int" in snprintf()
> should be "%u", not "%i".

Replace %i with %u in snprintf() because it is "unsigned int".

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  drivers/mailbox/imx-mailbox.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index f815dab3be50..3fe51b2de89e 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -782,7 +782,7 @@ static int imx_mu_init_generic(struct imx_mu_priv *priv)
>  		cp->chan = &priv->mbox_chans[i];
>  		priv->mbox_chans[i].con_priv = cp;
>  		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
> -			 "%s[%i-%i]", dev_name(priv->dev), cp->type, cp->idx);
> +			 "%s[%i-%u]", dev_name(priv->dev), cp->type, cp->idx);
>  	}
>
>  	priv->mbox.num_chans = IMX_MU_CHANS;
> @@ -819,7 +819,7 @@ static int imx_mu_init_specific(struct imx_mu_priv *priv)
>  		cp->chan = &priv->mbox_chans[i];
>  		priv->mbox_chans[i].con_priv = cp;
>  		snprintf(cp->irq_desc, sizeof(cp->irq_desc),
> -			 "%s[%i-%i]", dev_name(priv->dev), cp->type, cp->idx);
> +			 "%s[%i-%u]", dev_name(priv->dev), cp->type, cp->idx);
>  	}
>
>  	priv->mbox.num_chans = num_chans;
> --
> 2.33.0
>
>
>

