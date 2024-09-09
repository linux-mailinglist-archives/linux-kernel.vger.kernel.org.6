Return-Path: <linux-kernel+bounces-322148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8F9724B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11B6B22E40
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D86A18C91D;
	Mon,  9 Sep 2024 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QEs+mXSA"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F018C35E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919115; cv=fail; b=Pso/1rvQ7RdbSsJdDIuEt2qMwv8OOed49leZZp0+OuP43LdwsI+qvbwLrpH7dFdt+FxMaqwY7FpDZgE/1rdEovL10KYR1PUYBvCommbuslTDO34UF1rBOeEN0KYKHGbpee8s8KXXe6EUM1b83E0UP8SFl+9vH1Oz5D14q7DPWdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919115; c=relaxed/simple;
	bh=cRGaf/UdFobYxrGAbAJtwfu7uo6kTIIj90MCiuIXxDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k4bngxJntEkHkTnaS97bmlUScn/gRZ8cUBULLF1Iv3fmdL3XHURpPg2OEWFGKLolbFOgG01Fc5wezBZiwFsbRozgLT3kBiidEu4vL2gKR2c/eVlPCGoZWbBtKSjuwLD/GBNPaNzf73jDYYoMxXrnK6k0SOY7WOPsjp4Y4THSTHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QEs+mXSA; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3AkUNJDp4FjIB5U8Kev21ByW+J+49XZz01934byfwhLKUx3YFwUpPhVmxHNOSEJXq70DNjmCDl3CrD6yKt/N0TwWxilWdIKMG3JrPbfDtJrYoIe9Chj24Vg2feO8QanW+89D3vCcQbgVp0bWRmHBxfXTZ21PZTfc3OY6q1vv7LCeAwwgPhPqI8Ixjm8iQTZCrPI5WRyMKnGhRKOqcmYS4CNf3Bheasse6hc/dqAO/up19kT7PJxTd12gRxtaRoy1xHE2GeHmqdPHC8cTkYA2s0G6c47GMOixuF+DOjlJGEDk3n10ZHTjnavVUOHA9b/k/7MfTBFyfAkGKJEAAmjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox4WMw1fpJTQH667XAUssEOq3V6C7gVJTK+nHljYY3A=;
 b=Z/bTUGzj46Y2u1nuJpVz8uNeahsPtcEgQLZ5pQ+hWztON+HRh8y0VdFE0NIBM+Cozoxw3OAZelSkwjSaCDJsE2yR7mX/mlgpza10d3yI2S/SPkpL71+8bQcgS9M46FZD/unvDMv6LTho27zTCKBBj0A+/vQ32H2r8mo4j8vjdSTXnvSSLUH2rHnDyvKnBAE4e4twznzF+yngYS2tyenENfGzC7fNbc0rVpj7X9Z2R+7MX/IghalfZALJNu9LLTma6rYLQXu4wWAfksiNPeaxALvJXRIKB3idrw/F5obXcyV8cJSf/GwfzlO4YD0ohqMhiVnfoC0B7+YLmCOyoNLZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox4WMw1fpJTQH667XAUssEOq3V6C7gVJTK+nHljYY3A=;
 b=QEs+mXSAYAmYjTnPOZqSWGVRHqk4dux8bbcp9lit4YAYJVPneS8PfWDUUR4MrQKnqzNveHM60LyVUDexhvZHBW7GjoEmIMqRnjD/8Z2iO/dMjLIM3qnToPmcF1SQxg+/c6pYQqzIwvkMImMvxx951XMN8j4+Rvr8Eh5VdHQxcuVjRx2okVoy+TOH/9wzzX36Hgv7M3Fj7IabK0elXwEJnv5DdAiFAHqeJzM/WEavlTO+Wkm1zH5Ats20OSPD0Cag3O5GwnvUOXDt6sycdG7WnWiHAXTCh//l/CZVYrzFpaWqDPhqohCuiFU0/wyGT8rv1nfXLNriK/f/cFlcvGqQUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7258.eurprd04.prod.outlook.com (2603:10a6:102:80::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 21:58:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 21:58:28 +0000
Date: Mon, 9 Sep 2024 17:58:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Carlos Song <carlos.song@nxp.com>, miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH V4 1/2] i3c: master: support to adjust first broadcast
 address speed
Message-ID: <Zt9vfXwEMaKbqfco@lizhi-Precision-Tower-5810>
References: <20240905074557.3810026-1-carlos.song@nxp.com>
 <Zt9TcLqi34EDlI6b@lizhi-Precision-Tower-5810>
 <202409092103290fd1d226@mail.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409092103290fd1d226@mail.local>
X-ClientProxiedBy: BYAPR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:74::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b36d85-2305-4858-b19b-08dcd11a8955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3rjfwXaM8Mo9OCzvWPFvg0hj97TfnF87JoLVIZTe9kToxyYqSpkv9FK7Q0t8?=
 =?us-ascii?Q?Q7j6K0xyNoSg50hnb9GqiXVHqxbTAv7sxU+D3SUopdCOFYDlBNQOpWQ6m8o0?=
 =?us-ascii?Q?CqmEQiJMMEgiA+ZmJiqeEwi8xJdMb/1DJYXzwlsnvzJ4HgHMDU//8SPO9z04?=
 =?us-ascii?Q?qe2KR+7UjoSCeSr9h2MoQx9IdfPzP/R2fOiGThTULjBEFHv1RMqjOF26UvDd?=
 =?us-ascii?Q?k7Vj4eW82yWOz2AT3CTt29MtnZFQgYV3HzCCPtcrLF8CzIl4NwPxqALm+vge?=
 =?us-ascii?Q?bM/C48MPLjQwdVW5UCUgqz7CQw9fS3LpGiqOSvt1MVFUpNgK+C83X0i+cpX0?=
 =?us-ascii?Q?yn/Q64dalBGOilmfFGsKa+oCOi7LW4X4G4V0xvmFH6k1d+hJ8KgvN1GjACTz?=
 =?us-ascii?Q?uOLEUhOHAKkvzPKFQFyTuQ+dMM3UStRtb7qrnEJl81xzdSszXZaQodZT1bqm?=
 =?us-ascii?Q?bxNzuzQ0Gtc4QVbm5RYwjeupmomUo9pFZb7jpCHbl1TJCVe2SUUj0MLvOnAb?=
 =?us-ascii?Q?mLMpsutp50liaSbjdg18zomnI9vNPvFACoEdbZjAjjq8+mmnMmQWYN0Wi3qZ?=
 =?us-ascii?Q?ozIugc/y0TEAM3S/GXibQAE2JRYRhNUlpbRdMBNbIkJmCjKOLTU+EXq5RLId?=
 =?us-ascii?Q?aI+ag/RdbjwBlXPCja5fpzQ16IuIuWRibRltdzQjUvjoIx6AYQmEYiauKU9j?=
 =?us-ascii?Q?f0pCE/LRLyUNOyhWH/aQZwNIVxgGmd3hR76iVcw8PUN8d+ymFOwAl/qz2ApN?=
 =?us-ascii?Q?gpznIxi65X78eh50s+p7cBxPVrqMe+6lWNeohtuU+thlRuGVx/FHYh4+tSr4?=
 =?us-ascii?Q?wrp3+Fnu8VttkfpliWo8cbZjVzkon1PgRMZsTfS8U3GeX4PSP4jR6hDjQiZd?=
 =?us-ascii?Q?KZlOaOeq+/Q3nzkigk6zA6/Btngmkx5HhuRbHBAdnWMnjX7mrVJ45ABaHrCC?=
 =?us-ascii?Q?Kiu1zcapmuTd1gzLf8/Og50izCVtHObnnnvQUT10/yeSmhY+4aecKyHvc2sT?=
 =?us-ascii?Q?X6bB2eu5ptFX3wKMEx59DgwrTFDKt0fZDdk7jyBRoDp5VLYIHWqZ6R9iVV24?=
 =?us-ascii?Q?dvSGgj922xJNmsg9JegdPs5UVVLryK9gqFq/STcyuKuPfg6oMsGdX6uDTp8V?=
 =?us-ascii?Q?PQiCm/d0nOyi589nM9+5iznKESA5h7iuDVVzMp28/Y1OxYe0R2NOvnpN6lQq?=
 =?us-ascii?Q?mrE/8OhXLI0LUqP2o/VASn8YH5NgTW7YfwZEmXodPOqjCNGx/xokfRUmppMN?=
 =?us-ascii?Q?KC1x6Ox7nPmCkH6fmuhruDeWgTk1sn8SDsmVivCSbvKf/VW7Y5Ow3CMX0Rhq?=
 =?us-ascii?Q?rc0YGPgk8OrHkLIcwc5W6AINLE0q+VEqqBW9bCyDIeYW5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+HO+EpnB6UDDSDoykm3OalACRwncuzeCHPpVsJxhPuLT0n+EYPFFDO39SaOj?=
 =?us-ascii?Q?WfCnphZHJqroQ9woQrIkLapibnXBrpTdOHsRD5w/vviwlEcX4xTKASiWs9XZ?=
 =?us-ascii?Q?6RWuzFJiuVNrhX6/sDi43QLjGgXLG+803zlemCd/LC+xC7Vo//5+Ech0b8Et?=
 =?us-ascii?Q?KIOqn3GO3nOs+yxiApzoWs1jGPb0BXsaCAfpAtE0x2T4wOzEY+vQVnN6Op2W?=
 =?us-ascii?Q?uitu6l+j7SiOKljZIG89dtKOURtlmVY4H3Kl0SNYf+o7hAWxGwXTzHA5RpII?=
 =?us-ascii?Q?T/MqwSS3gwbS3KSbe8BruLGeXmo7aFZ6t/Jj6dCrmzDTk7HguAxU8FEfafDp?=
 =?us-ascii?Q?IYA20Hvj8n7gq54Iu1ZOElFtaeUrSzRIXh3QEvha4pf7inxaF8+hlOEyQ0GW?=
 =?us-ascii?Q?K8Si/XBXZeCtFubBDiBEPclYQQ7ld9Lbu/H5ORn1VchVUntZMa0uc9SRke9F?=
 =?us-ascii?Q?orO2exkG+DkeXa2a7oSgAAOcHkmXj6/Q3PwCNRNKaExVBkX5ho3MyeHxU+VS?=
 =?us-ascii?Q?3UkxAVz50+JXdJxHx5pAy2KN3xRZ2bqcowUQbNEhlvLUcGSNB8gQNktCYfSp?=
 =?us-ascii?Q?TuGyUS96Iic101OkiCTA5oMikRmREZhWSMW+OMnpmMecuE+1RgreICG7JpD1?=
 =?us-ascii?Q?FumamiNYV4tU1I9e3iQn9uQOOlRXAla7F+xwi3qOWnbeJlfzI3dnobTgRhZG?=
 =?us-ascii?Q?ZGOSIpxgm32BFADB2foUR4vJq8D/Wszzg2JBBwkMg7nDAb7FbjBXr/wV+abL?=
 =?us-ascii?Q?yi4P8Tmbzt0AUpSW6uTl4hGpd8HHHgha3JCHytkjWsOdKFR5evXB1jNal+Eo?=
 =?us-ascii?Q?iixJ/ui5QquFvg9H8zkL7oWauLUQGXfrxvwZ9p8R9JzBoZCSA9vjqHEL4WRS?=
 =?us-ascii?Q?nrXjU3gTqtaeVAWIA5rf7alM0EZ3A2BSmhc2goX92Cy20miGVeN1pl1CmZ1U?=
 =?us-ascii?Q?EDgaR9m68Q9WN83BE/VGQEalBrVy0Bjx9tTkYNdYaPHTjHmC0+KG2caYfvEx?=
 =?us-ascii?Q?9S5EeLDyj/uVUkk1OzhrUIEyq7Pc56rzcN1mu3fp9xWPV+bPYcRt6mM25NWd?=
 =?us-ascii?Q?sFsz2ww/a1vnmVKm7JbBApbRsuwAR4B/AKhvMpq2zJfCMOZIpZi61mUsnmQM?=
 =?us-ascii?Q?plX79vwbJI+h3NsOytETgRdZAG3CTY+Q1mXvN5BGF3RBdJWBo/kaix2Eaqta?=
 =?us-ascii?Q?tw8/N3jyxs0C0aNwkyFqIitKe0ukEn2ne7ZxbZVBJyiz4xUucumLNWSJUom5?=
 =?us-ascii?Q?j0ilqnhAPUfxfXR8L5zox49hwsSgnYOFR6c5XViDiY2qgEAHqgKknPFsZ3Tr?=
 =?us-ascii?Q?nss8m4k6RsW1KhtnnfyiKjTF1AecdBy+aoVZ/fVEPBrbHGQ9CFAQeDertr0P?=
 =?us-ascii?Q?5+WPin77u7U4ASLwQaS/Qh7zLe8dK7qV/n3DTn69Q3QyKyJO7GZCaOoOhBmx?=
 =?us-ascii?Q?7SgTut7sRFhd7DTnX3AlARDkI8CSnGaVS/dId3Qg6VR2SZKhpxwd2V8VSqg0?=
 =?us-ascii?Q?j2EuJfb+aSOYEMcnZvh5f3UA88pgqQtG81MMfwmlzars/h4kCtGRZwzKujj4?=
 =?us-ascii?Q?2mn+i+mAf+NdLTmsIKfghU10EHS0XVfvFp793Ljw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b36d85-2305-4858-b19b-08dcd11a8955
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 21:58:28.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAqtRXQ+zk1UDnov/TtxqoVUgDTdGV+0jtCs10N9km7gMZm9ZLkFra4SZVZynafFh7DyWwfscKFdHJZekNg+ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7258

On Mon, Sep 09, 2024 at 11:03:29PM +0200, Alexandre Belloni wrote:
> On 09/09/2024 15:58:40-0400, Frank Li wrote:
> > On Thu, Sep 05, 2024 at 03:45:56PM +0800, Carlos Song wrote:
> > > According to I3C spec 6.2 Timing Specification, the Open Drain High Period
> > > of SCL Clock timing for first broadcast address should be adjusted to 200ns
> > > at least. I3C device working as i2c device will see the broadcast to close
> > > its Spike Filter then change to work at I3C mode. After that I3C open drain
> > > SCL high level should be adjusted back.
> > >
> > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> >
> > Alexandre Belloni:
> >
> > 	I have not seen these in patch work
> > 	https://patchwork.kernel.org/project/linux-i3c/list/
> >
> > 	Any thing wrong. These two patches is critial for some boards.
> > Could you please take care it?
>
> They didn't make it to the list, please subscribe and resend. Also, it
> is very very difficult to keep track of all the patches you sent s I'm
> not sure what actually needs to be applied and what has been dropped r
> superseded.

Sorry for that. Only one big patches set (about hotjoin fix) and update
maintaner are directly sent from me.

There are 3 patches from carlos.
one patch already in patchwork
https://patchwork.kernel.org/project/linux-i3c/patch/20240719080233.842771-1-carlos.song@nxp.com/
the other two patches is what's talking about in this email.

Anther one from Ravindra can be dropped.

I am not sure how I can help this because there are difference contributor.

Frank

>
> >
> > best regards
> > Frank Li
> >
> > > ---
> > > Change for V4:
> > > - No change. Send this patch with svc-i3c-master.c fix patch.
> > > Change for V3:
> > > - Modify comments from Miquel's suggestion
> > > Chnage for V2:
> > > - Fix set_speed description from Frank's comment
> > > ---
> > >  drivers/i3c/master.c       | 12 ++++++++++++
> > >  include/linux/i3c/master.h | 16 ++++++++++++++++
> > >  2 files changed, 28 insertions(+)
> > >
> > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > > index 7028f03c2c42..6f3eb710a75d 100644
> > > --- a/drivers/i3c/master.c
> > > +++ b/drivers/i3c/master.c
> > > @@ -1868,6 +1868,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> > >  		goto err_bus_cleanup;
> > >  	}
> > >
> > > +	if (master->ops->set_speed) {
> > > +		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
> > > +		if (ret)
> > > +			goto err_bus_cleanup;
> > > +	}
> > > +
> > >  	/*
> > >  	 * Reset all dynamic address that may have been assigned before
> > >  	 * (assigned by the bootloader for example).
> > > @@ -1876,6 +1882,12 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> > >  	if (ret && ret != I3C_ERROR_M2)
> > >  		goto err_bus_cleanup;
> > >
> > > +	if (master->ops->set_speed) {
> > > +		master->ops->set_speed(master, I3C_OPEN_DRAIN_NORMAL_SPEED);
> > > +		if (ret)
> > > +			goto err_bus_cleanup;
> > > +	}
> > > +
> > >  	/* Disable all slave events before starting DAA. */
> > >  	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
> > >  				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
> > > diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> > > index 074f632868d9..2a1ed05d5782 100644
> > > --- a/include/linux/i3c/master.h
> > > +++ b/include/linux/i3c/master.h
> > > @@ -277,6 +277,20 @@ enum i3c_bus_mode {
> > >  	I3C_BUS_MODE_MIXED_SLOW,
> > >  };
> > >
> > > +/**
> > > + * enum i3c_open_drain_speed - I3C open-drain speed
> > > + * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open-drain speed for sending the first
> > > + *				broadcast address. The first broadcast address at this speed
> > > + *				will be visible to all devices on the I3C bus. I3C devices
> > > + *				working in I2C mode will turn off their spike filter when
> > > + *				switching into I3C mode.
> > > + * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open-drain speed in I3C bus mode.
> > > + */
> > > +enum i3c_open_drain_speed {
> > > +	I3C_OPEN_DRAIN_SLOW_SPEED,
> > > +	I3C_OPEN_DRAIN_NORMAL_SPEED,
> > > +};
> > > +
> > >  /**
> > >   * enum i3c_addr_slot_status - I3C address slot status
> > >   * @I3C_ADDR_SLOT_FREE: address is free
> > > @@ -436,6 +450,7 @@ struct i3c_bus {
> > >   *		      NULL.
> > >   * @enable_hotjoin: enable hot join event detect.
> > >   * @disable_hotjoin: disable hot join event detect.
> > > + * @set_speed: adjust I3C open drain mode timing.
> > >   */
> > >  struct i3c_master_controller_ops {
> > >  	int (*bus_init)(struct i3c_master_controller *master);
> > > @@ -464,6 +479,7 @@ struct i3c_master_controller_ops {
> > >  				 struct i3c_ibi_slot *slot);
> > >  	int (*enable_hotjoin)(struct i3c_master_controller *master);
> > >  	int (*disable_hotjoin)(struct i3c_master_controller *master);
> > > +	int (*set_speed)(struct i3c_master_controller *master, enum i3c_open_drain_speed speed);
> > >  };
> > >
> > >  /**
> > > --
> > > 2.34.1
> > >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

