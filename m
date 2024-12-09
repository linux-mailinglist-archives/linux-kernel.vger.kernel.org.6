Return-Path: <linux-kernel+bounces-436972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E32E49E8D55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D921884F9C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D472921519B;
	Mon,  9 Dec 2024 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T9HRBfEx"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2087.outbound.protection.outlook.com [40.107.249.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6206374EA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732815; cv=fail; b=qtxkrBL3klOHCnODabH1J/AuEu1h+5dkezwizfxm8KVv2khEt/QejBadvODB/GX86lPdFdvOBBPBWXXiuOywC6c3tPUYUBm9pc2yK30NExMr4BdQRbzf4KNLXPs46pdqFBZywVpEg7LuCs9QHbUoP1j3Z5+hx54jL8WxvRnN3xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732815; c=relaxed/simple;
	bh=Bls8+hF0M8gM5ccD0yWbuFRf9xWQeiO2SdpVFk7YdnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O+O/Lnn3pnTyNr+bMSIVimZiVgDag8tHLoLeY14eXKp/zNxpZRP2sCZnWLQLDiNuGE1Vuayc/6Ycfe8XHidtsk1QYdj19PANPWYICTV+3QDXdHstn/XCgDPI2CJb2GYPsc5TyiCuT41JSxl79Ef+9Juhh/6A/kpeqcgL7kneikY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T9HRBfEx; arc=fail smtp.client-ip=40.107.249.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEI6EXThGjWBQuvRPOuQcosr0cDVQ01lXSFVK7jdoFDhvUwO0IsNGjt+2enfsrn8qCk738lHYxEQKeIlb7uT5qz2xLXhgU41C4oKd3fgYM1EsheAPvyLyqatXttXZcBNzKAnMApPO7WUa4JRMi5v9/psA3kCVz8iZZ+FxL1b+aaeRsoXYAkXdDrpMdWE89A2DqMZk0foJRGUWmAmbPe96W4dsQlKu+eiPw0hyFQbRcT3iWPGs5vb3UfRen8DA2rkJwMgWXsgj+JmwQAC1RrsTtlewlt9abiyl3QY6SU+60alepgwOSYlDPO7rADHV5iRznv9NxqhdUqYAy7wk0cJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+371Hyq6OexnqIKkXQ1r0rsJiltIYYMJrPCfedEZ+U=;
 b=WfrjSiUi35rqhSpDGqXLR9I33gdFj4FzEq6rLIbsgulZVKTbl2flKIjP6ax1Sfi97K3xEJKubvSTnlLlVaTjA90JgTw0ZDMDopXZIP9q3Y3Zdzw2w0NMzN020p7wAJY3y4ChkgWjfr4SKg4PulnHR4v2/dbNux0SJBOw48ykVy0xV6F6hu4bLwdOh+uxFIF9eA5bZ0ZoSemaqTpvynE96AzG4u2H/TAKzVzM7vxcFbv3P8k0nipR+fDrnWx2XCYXn9aCxkGQyrom0FJz8ctcpof7HZi5WH7FmIBJuPLg0c7HmzmhUbQF40abndOJAYmr7/oLUoClBZ/5WEF6OoLCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+371Hyq6OexnqIKkXQ1r0rsJiltIYYMJrPCfedEZ+U=;
 b=T9HRBfExyUyQ/hX0WPqrJuVB1cAvBFVhoPFjPOFJpbEF0u9VIzG/j7YmqzGBjJkXWHr3kP6qMrCSIk4MAd0cMsKneyVSmwb3aW7suEjoiZrraQs1lMBp5kW3FK+HdxPUG/8V/SdpKR/1uOkVD0lX6h/Rg7izC7sKGXBHZVwHVT/AP8OAU1iCivrlYRh4ONYwT5fNefrR7notkjBNEQ70jqqmTyCSoORAYGGu2fbzWWlxpzNfz5Zq84kV0ooLxBq3LizZ6/Ay19GrPsty+Tvh1qgr2sfb24qQOidq3cEeFSJdXpPBFvGQn+6mDBSP3+otHMDegVcLSYYIeZIxgT/tyA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10654.eurprd04.prod.outlook.com (2603:10a6:150:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 08:26:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 08:26:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "marex@denx.de" <marex@denx.de>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] soc: imx8m: Add remove function
Thread-Topic: [PATCH] soc: imx8m: Add remove function
Thread-Index: AQHbR9IRiS4d/DHhhUyZRtsVcBxxg7LZF/EAgAR//xA=
Date: Mon, 9 Dec 2024 08:26:48 +0000
Message-ID:
 <PAXPR04MB8459052EFE2C6137146F9CFC883C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241206112843.98720-1-peng.fan@oss.nxp.com>
 <20241206114130.zt4rkotzbzi3xt5n@pengutronix.de>
In-Reply-To: <20241206114130.zt4rkotzbzi3xt5n@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10654:EE_
x-ms-office365-filtering-correlation-id: 257b76ba-a490-4ec9-ac22-08dd182b39e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q9HRCL76lRNjik708MmK78jO7hBc1PTpzWccn+J/Si+Q7FdXiPO8hkPWZ+vk?=
 =?us-ascii?Q?5oyINjXaxhfUwKEjwilmuGih3uCVROvuG5f8UDAWUxyu/M2GTfFdl1baOOt5?=
 =?us-ascii?Q?M69tD0Nob9oK8aQ1krObAcgTBMxpTLEEMrdOe0v6Ck7bwKhRjgg7nyZ6Tawe?=
 =?us-ascii?Q?+zJLRImAH0liRGV5YBUVq5WNV6YyPVaAzADo+jnOj6B4+BLRMBvY7o1lUjwk?=
 =?us-ascii?Q?Kmq4XbFjuQkuffjKjpa1w+Sd792BHkSBvWUFN38kWn2Ncmueq7uo2TAL94PR?=
 =?us-ascii?Q?1u6PsxdFwQSxPLRwc49EKAxp9lMbVPVzNEOI3tkZ9HTlYyetkf+WMAjVD2HJ?=
 =?us-ascii?Q?n9oafFDtb9ECCwFdCUPKG15XU4pCCNVhl/ZJwAK7+mEs+KG1F0294qKyG2M3?=
 =?us-ascii?Q?N0tMQyzkUBxp40TY1rOPCyLWZVuoBulQMP7laIA+GBo6y2Q24gcDdQYeMbfH?=
 =?us-ascii?Q?SEmrubYRxGNihDHEF+u8kunCO31Awy8zttgpC2lSkfvZVFUKcW3UtXYQw3RK?=
 =?us-ascii?Q?XeA/jVNCo/4X5uRn02VKYyPAdXRGuEjfawxgpd28OiJGyTCFIbdF7X0X7OOk?=
 =?us-ascii?Q?u1CRl0tBmkYRl75ju09EhuUjJFv6mjq7LgzW+o3xtT1Q3fr//+NI+wZAHghD?=
 =?us-ascii?Q?dsgu7SyIDL2nxxSEv4y1sujsGzlDUOxodAoi30wIAUJNGnZT32ohj2ER3CdE?=
 =?us-ascii?Q?8rMmgT6J0yrwX5LFqswx9+JBwEVylCEkJfBJUKtA8mQGgPBcscH6fKe56OE0?=
 =?us-ascii?Q?WV8RpjscFlxZ3CON2Cd0KS0fvK69Pblzon7WK1L8bdXLqnU9xoUjcUWms+Da?=
 =?us-ascii?Q?3+2XE7wml5KYHvRS0uNcLzSwwCDUM7fPIFPWN+YYoSVp6cTN3ZmdwrtNF1BY?=
 =?us-ascii?Q?aZINu/VoXqgU1ydSVGW/BSg2do86+PvkiDg8NMVM1CAgy5GVwGj3sY/wTJe9?=
 =?us-ascii?Q?Mn7nKTsUugxkD7c0gl1Cg/Jo/pc6vjGsF9zwJTQxUgL5Uzz4qnCQg+Emlz36?=
 =?us-ascii?Q?f1f3//sc0+xj5GNr/EJX5wBB5jOeAzsa+CCJsgAiTMs82zGbpI4teo03hMfd?=
 =?us-ascii?Q?sPQ4Q8Q5TUnb97CvabCXCR0g6soYjSxrVVbPivOBYHTsUX/t0VRhrKfygA34?=
 =?us-ascii?Q?dpK64ymX5Wcnz/X838DTMOWM6taofFDfzBePZzz/wdvXNvRE7K/oB3Pey58Z?=
 =?us-ascii?Q?vBcx8b5hf6p8B5mMXs95uzZpsOtTIMAiwvaXSLntFIK9VMXhAUdbDP6f3A/T?=
 =?us-ascii?Q?7qbFdwKLyFY/mjvaL5e0hYwD0tDT4lzrHW4iHqruvCKJ+v+ucx5Va2oq6ylU?=
 =?us-ascii?Q?nSmcxLmBLRgXRKASpiGrnX3FvboKCxQLZM6vNx3Q11Tj2w6Df1Jeo48Qrhfn?=
 =?us-ascii?Q?4AwoGPIOnOo3vIC2f953sBJaBYXwIhOF6/sIz9kWqNXd1eSjcA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DIWwHEtPUjiik215qIjV+kjb1NwCQGvb0eqHpKp5QbzbxyLj8/yL/XnrzbPz?=
 =?us-ascii?Q?qsVBX8+W5DSmwBGxqMb+uUGcv43zs/uk1jqHUyL4alIWzLiJyXdZhoVRXqye?=
 =?us-ascii?Q?DZSYfYRphnyqz25wyf9xLJks1poA4zffqN6qFNPW1Kz/bY1Naq1XdPTNFV8X?=
 =?us-ascii?Q?Cb8loFOp2EiJAMkrlNIBO2r1gNjjRHSbchBUlVE0RUuEF1OWtE8IrQJm1GwV?=
 =?us-ascii?Q?ZKg2o/4ueSFm1T8bOahnSJQj8Re6wf4ZN2zsTF8GZIWyWdhaX95UouICIYMG?=
 =?us-ascii?Q?YRW03wI0ORCv/Aq5hMrW8EJXESXYi/zOvIR+FBv8hUHYQE5N5VReSbpxkCch?=
 =?us-ascii?Q?i23gDIQqVhvDCZeQKmqh05s2kjm3zyuibZyEwd8usQRTybM1PohekA8a3Yau?=
 =?us-ascii?Q?Pnt9nwFXlBl21rlc4iOnTTMa0cS874DcZukm6YiPjp5p/DuA9GEsUOVDOKWL?=
 =?us-ascii?Q?Iinm2b4/6h3O9drqU63sjz+LXo1Smkm+qPgkF7k8N0ytzMWPKFGnkLxc4tNU?=
 =?us-ascii?Q?toFSCKfKArmDHBvi0DXUT6LPezGEhRl4qGU/UwTSz1ilPLPY6z/XVLYGOF/x?=
 =?us-ascii?Q?bfLpFiJqmRQJKwK7tCFwyLNHgrprzNrl6Kg3pwt6mqkzyJHH0H2y+h/KZyOt?=
 =?us-ascii?Q?UFLxl38yvqVrfNXBk1Xc45Rs2bArkzyYVyoem4sLQPIaAwv7oQlTl5yNGOj2?=
 =?us-ascii?Q?6l8AL451SGzdOOsDj9EJLYs0exbF4YKZscbUB+m7uW5mIbFLBGoeS82MCHdr?=
 =?us-ascii?Q?4B2GAJGzwQQ2wTtBijxLOQYSpaexuZMztB4xUo4Jk9z0EAIq1SEFQITN07Kc?=
 =?us-ascii?Q?x4udSBjJjBwSfpxuZcXzqhvTwsq0YzaNK9n3g+0WocenUxRb/5mLTrcV2tPa?=
 =?us-ascii?Q?bMfi5tbUqUlunUskSf6gCowt4zmNSLEVa+Foa9edsgp5EApywQJ6u5Wo+YEc?=
 =?us-ascii?Q?aRZMJhmRbbvP9iva4MNCW4VnGJQUoqjamEnQdbOV4lXLTTU5CML2pqy1Gnfk?=
 =?us-ascii?Q?GdjpKLEFsZKDx4cesAzAc5LJZHrfODvAg6bpLprlAAG6Vku0wDLW/iL3Cy0z?=
 =?us-ascii?Q?K5Ia0LofB3Qtv86B/wiiEwZoJOq//5a+eNi84fOZM6s9YfaOBQuXM0/r8gu5?=
 =?us-ascii?Q?IKpb1Syj+anIz+SnJ02Pp4fOUmELXyI8iOA5GgkTrFajT7+xNlz+pV7X7xRQ?=
 =?us-ascii?Q?JatP3PXoPmve5rccrjFvr87tD7DhYqrWnMdxO6JUZgzGMxc0bZfihCG97TcB?=
 =?us-ascii?Q?0amuvPnL/V54mVNgxXWjSYVANbo9si2tVdDqLeEzOe1h2/nTpIdHttW/fKGd?=
 =?us-ascii?Q?rcg97Or57TosrkCk7QtQW1/ltUylhb31iQu2+AYuZJAqZ4J8i4QavjkcsDjc?=
 =?us-ascii?Q?pGpm1uGowFMCTNbxIq4V2wyZntMLvPODs4eitA09C4NLL5VifCVeijeZUhfy?=
 =?us-ascii?Q?ex+S035cHxIYaCdGHSIbbED34LZC1vpAiiKE1Yel4XEHFBUXpDgifOi3Zv0p?=
 =?us-ascii?Q?7/BYLaHtXHtm+BX0Vxukg3QzQ9YTAq4u/MkBZCKh+MCB+RIJK/Eu3F2MWNh/?=
 =?us-ascii?Q?8ZIhMyaNKh/RVgfJAEg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257b76ba-a490-4ec9-ac22-08dd182b39e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 08:26:49.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onpi8fyXNJamweb/Xhd8XdoVHzo/vSqVzfLuSLCf9dtrkLXhByKnXaXTxY24fEl+FoiYk6PmzUPklNPgOz9qbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10654

> Subject: Re: [PATCH] soc: imx8m: Add remove function
>=20
> On 24-12-06, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Unregister the cpufreq device and soc device in remove path,
> otherwise
> > there will be warning when do removing test:
> > sysfs: cannot create duplicate filename '/devices/platform/imx-
> cpufreq-dt'
> > CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> > 6.13.0-rc1-next-20241204 Hardware name: NXP i.MX8MPlus EVK
> board (DT)
> >
> > Fixes: 9cc832d37799 ("soc: imx8m: Probe the SoC driver as platform
> > driver")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/soc/imx/soc-imx8m.c | 32 +++++++++++++++++++++++++++----
> -
> >  1 file changed, 27 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-
> imx8m.c
> > index 8ac7658e3d52..8c368947d1e5 100644
> > --- a/drivers/soc/imx/soc-imx8m.c
> > +++ b/drivers/soc/imx/soc-imx8m.c
> > @@ -33,6 +33,11 @@ struct imx8_soc_data {
> >  	int (*soc_revision)(u32 *socrev, u64 *socuid);  };
> >
> > +struct imx8m_soc_priv {
> > +	struct soc_device *soc_dev;
> > +	struct platform_device *cpufreq_dev; };
> > +
> >  #ifdef CONFIG_HAVE_ARM_SMCCC
> >  static u32 imx8mq_soc_revision_from_atf(void)
> >  {
> > @@ -198,7 +203,7 @@ static int imx8m_soc_probe(struct
> platform_device *pdev)
> >  	const struct imx8_soc_data *data;
> >  	struct device *dev =3D &pdev->dev;
> >  	const struct of_device_id *id;
> > -	struct soc_device *soc_dev;
> > +	struct imx8m_soc_priv *priv;
> >  	u32 soc_rev =3D 0;
> >  	u64 soc_uid =3D 0;
> >  	int ret;
> > @@ -207,6 +212,10 @@ static int imx8m_soc_probe(struct
> platform_device *pdev)
> >  	if (!soc_dev_attr)
> >  		return -ENOMEM;
> >
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> >  	soc_dev_attr->family =3D "Freescale i.MX";
> >
> >  	ret =3D of_property_read_string(of_root, "model",
> > &soc_dev_attr->machine); @@ -235,21 +244,34 @@ static int
> imx8m_soc_probe(struct platform_device *pdev)
> >  	if (!soc_dev_attr->serial_number)
> >  		return -ENOMEM;
> >
> > -	soc_dev =3D soc_device_register(soc_dev_attr);
> > -	if (IS_ERR(soc_dev))
> > -		return PTR_ERR(soc_dev);
> > +	priv->soc_dev =3D soc_device_register(soc_dev_attr);
> > +	if (IS_ERR(priv->soc_dev))
> > +		return PTR_ERR(priv->soc_dev);
> >
> >  	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
> >  		soc_dev_attr->revision);
> >
> >  	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
> > -		platform_device_register_simple("imx-cpufreq-dt", -1,
> NULL, 0);
> > +		priv->cpufreq_dev =3D
> > +platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
>=20
> If CONFIG_ARM_IMX_CPUFREQ_DT is enabled, I asusme that
> platform_device_register_simple() shouldn't fail else it will be an error=
,
> right? Therefore I would like to add the 'if(!IS_ERR())' check here
> instead of the remove function.

You mean below?
dev =3D platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
if (!IS_ERR(dev))
   plat->cpufreq_dev =3D dev;
else
  pr_err("Failed to register imx-cpufreq-dt: %d\n", ERR_PTR(dev))?

But using !IS_ERR(plat->cpufreq_dev) in remove path looks
simpler.

Thanks,
Peng

>=20
> > +
> > +	platform_set_drvdata(pdev, priv);
> >
> >  	return 0;
> >  }
> >
> > +static void imx8m_soc_remove(struct platform_device *pdev) {
> > +	struct imx8m_soc_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +	if (!IS_ERR(priv->cpufreq_dev))
>=20
> With the above shifted, we only need to:
> 	if (priv->cpufreq_dev)
>=20
> Regards,
>   Marco
>=20
>=20
> > +		platform_device_unregister(priv->cpufreq_dev);
> > +
> > +	soc_device_unregister(priv->soc_dev);
> > +}
> > +
> >  static struct platform_driver imx8m_soc_driver =3D {
> >  	.probe =3D imx8m_soc_probe,
> > +	.remove	=3D imx8m_soc_remove,
> >  	.driver =3D {
> >  		.name =3D "imx8m-soc",
> >  	},
> > --
> > 2.37.1
> >
> >
> >

