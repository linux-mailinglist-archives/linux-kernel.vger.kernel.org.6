Return-Path: <linux-kernel+bounces-257517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6274F937B22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21CAB22B22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A12C14601C;
	Fri, 19 Jul 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AQI3z0FY"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07571459F9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407027; cv=fail; b=KHQDZiPHJw0vviNFD2kpWbgKNsUns/rQ5I9amFHsHrVICQef6l2MIybUyKjDOvwmpWJOlkE7lkn9wJW/IQzW75RtO4owrAyYZ1vaKNGtp5gnDjQPp0ELILTmIYzP7oOqncX+YI/eeib/TMPK4EpEJzJ0goYMO3AuNQbQS6LClo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407027; c=relaxed/simple;
	bh=kEafLqpRTLRhSMfBvD5lZgO9y5uKBaGuW9sr3BmT+AE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OLkjrqOv4ARSMwvNRhy/VRkNsZsvfDqCcqyPj2eTnDEZ8rIrz4IPcTTMZTcaqLy6wDVlPfWWYKFus7Mpg/hFQXRtVM8MZnFF7WwXqBqijA/QyR/gkXZSexLU1Q7ROrNrJRI53vMzRozo+MDZtTn2ONgRqEyB6NjI0kSi0UELehk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AQI3z0FY; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qok24U7TVFpkzu69GMpydIUlw2FWhheSQLXO7Y0sF+5HAU9TFzTMnARDYZKJICQFgGrJ0ZFaKzFuFLVVi4efFw2mDGwLiXR06SEF81hGXYJ9atD9EgJ+Ao6vJ69Pv8Sk7PIjT3nGbJUQfab2BaKaIQioAhXE8v/ITHM2QyzzlqWuUvkRtiBvDxbqw2WRniCNVy3qpgoit5BExtejy87UAYKvfFMosDmyGJL9reN4BumD1IzCOi+7/tVLKSAHra+LyUnaDksXXy3Z6RMMVPy7P6U7KqkHOKz7hpi/IpNuIH5Xjidj5IKaRwVNR8kyL7PKzmzNWoe5JgAgTjEkNkfWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/G5z5mna7r+iEb6FzuRMr2PMZq5s7GsUkcE/LuGzQc=;
 b=QDRTh2AAt+sWyA8yza02t5Wq6x7aeaT2x8SmvDw96gKTDuguIQFqckznr8x0EhDRY9aClpTBnxu5bkYx30B+pJStzb2lPnJ0zLjjP1OqgZPs6rjYVzDmuqgPtI+MAjSlaMoOkGYDq7FOk5jVBp7mmbQawvnqh6cwjYQguvhf/aliH/Gzv4NHfH1PjfzIFoJVP5xA1N0n186mdV0eaYgth2s+m+ix8ETMFekIlWvMbSVEA2bG0vDEugxCIvZYThxVM72QZdqikuK4tt8tWMPiS+dRW/6o7hsywaqc30CmBHA+9Zk6d/7Ps+YY6676w1lIxSlege85uThD06RfhCYWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/G5z5mna7r+iEb6FzuRMr2PMZq5s7GsUkcE/LuGzQc=;
 b=AQI3z0FYNqx390KSl+c0DNdDnnDj5gQ+a0T88jFTARezZs38uZq5HXbr1cTCz2x7wuU76hk8jRb0UiLcZ3q1PpgnZBOBZ75dqE8Lg0cZ+oE1Z29fiGxMiLWBXSBUr/pPUZ4EQbS0D7hejX7Vz1p4ZckV83GB3McVkn/NR6Cz1V0=
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI0PR04MB10102.eurprd04.prod.outlook.com (2603:10a6:800:249::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 16:37:01 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%7]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 16:37:01 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
Thread-Topic: [PATCH v2] i3c: master: svc: adjust the first broadcast speed
Thread-Index: AQHa2bIqF20nO4POdEOhWo1zoI6QSbH+JZsAgAAQvNA=
Date: Fri, 19 Jul 2024 16:37:01 +0000
Message-ID:
 <VI1PR04MB50058C9E30C4A357E43CB34FE8AD2@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20240719080351.842848-1-carlos.song@nxp.com>
 <Zpp/uv0yeEhld6We@lizhi-Precision-Tower-5810>
In-Reply-To: <Zpp/uv0yeEhld6We@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5005:EE_|VI0PR04MB10102:EE_
x-ms-office365-filtering-correlation-id: 05ed6191-fe1a-4e92-c832-08dca81103e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5HPSqvFSLGmuUdtN2NO0sUHxPFTA7eRr4xhNqsoryEoziyVVqiXHrIsRMjR/?=
 =?us-ascii?Q?6MIYVXhxXKEqN+frNmeFzaRb5Ou/oBxeyplKTTlYe6j3u6Db+YU8KAC56Ro6?=
 =?us-ascii?Q?dkZUrIMPnF9UYs9LJKi7JuRkL10oO9DtOtQJ9wlL0X77qOXQ59enhg1LYnDA?=
 =?us-ascii?Q?UlxhdeKv+xmmqnqQ72Hat0lYEkYWy++5UOJ9O2qjjsjbpfN9msazh19xFiIQ?=
 =?us-ascii?Q?zP2ods13JBeSnccpQSbxCk8zwp8H4VXRdSEiPMX23Dr79bD/yKty1WDPMPfP?=
 =?us-ascii?Q?bALeWvfxpHwAAheSn/LuVTXo4MJ8DlwIopTGzA9TcJ3DIWh2rntwZ/s8MTkb?=
 =?us-ascii?Q?2PmBjmw7NTszB3t8qKdeEB93/ZrH0kQObCSkP7U+hNHli6ItinM3bJg2MnDd?=
 =?us-ascii?Q?hSldBdH9zoEYgTlzjHXbUis3cTYD0IoBc3IYdN7hkKpve5N8MgF4AzjB6s84?=
 =?us-ascii?Q?DsKfWYqvFjXnZHlIygZvZ4A7TXGITm6WgbWjuoGoWz0ClVYjHuVjDd8gjDpE?=
 =?us-ascii?Q?EeL2GPbyGqkbtjCQquNoMWpawM1ixwxR7WAoeFFSSiXHJB9CTGiIuF/Ga3NG?=
 =?us-ascii?Q?La2vkW8ijBhxU7e3RVD7hM23nyIkKO4DENxiF0Hc6LRoKyePclraumPXbo1b?=
 =?us-ascii?Q?+9B+nYoKOgjpva0OQVjou5O5T/8k1rXhcCVFZC2R+W0CLaVwVc2ZyRmuFR0J?=
 =?us-ascii?Q?6hKEXGVJH4AFIhrIVsXSXRhp/y5vu+FeGqjs7biXvesJLHxxrmDKTm7JzguP?=
 =?us-ascii?Q?Y9/dlET9v7DU2UGXAe2wSDaGxGFexAGibJ2RY6BnXaTtwJdnfosQ0BgiqG2F?=
 =?us-ascii?Q?H+Ox/GlYdDbkddIgRkZxOlzRjWQ4FYtv1qm02WD3fvuYha6i5/sGmPC1LKMD?=
 =?us-ascii?Q?cBja1LoLEw7vwpH3mxgSmZN/WqG/4gMprGWbMrCpG9/uZPYqWGBXe9HSToDQ?=
 =?us-ascii?Q?ZNqNHO+RZS42FI5+/G7N32ciyeTHaAklPFKgTw/Vtl884uSZy5mIN2y6IDga?=
 =?us-ascii?Q?WQ0nZVDqdNcowjoADsvohQ+l8xovIkSTyr18S0ugirG6OIf5iwMwuxC7/PBe?=
 =?us-ascii?Q?PxZ/seXeCQGDJT5LHu5XNQJTfcsFyJS8Yy73Ck6Chte5ndCoWHbVJ0BWC42u?=
 =?us-ascii?Q?bHs7EewmUx11wAx2Oy9Kpq2Dtw7wRafPOrPUwAWHk8nL6jvff36cg+ATpuWU?=
 =?us-ascii?Q?VQOOVYSyAHiBdFbHS8WF1BjaSuJYiFZMxcNzFK0+CxMrge5zQXwXOD3muZI6?=
 =?us-ascii?Q?OYx5VodJnut6K7Ef87J3cb59EwRQF7xxgHMZ6YppvlssDOdjqh2BknagihYp?=
 =?us-ascii?Q?sckYNzROdPTKPsyiSedipJjXnLNsaGGDC25/WlP/CCxA7ej3sz2Nq61nEyjq?=
 =?us-ascii?Q?r644m1a9p0eAvhJGHP/wN1hfb4pECyExsaS3AS1QkRUMkvylSg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NyUUAaUv809EwGrnyXZ79tZrjBXKiUIkD7Ixb5PITXke9qHE0yeCJJ9vSL/z?=
 =?us-ascii?Q?aY4GB1BbvraqyKTNAa80s5hypOhtGjQcYc8r3hcgjcqF8l5qCiwP+AWSm/TU?=
 =?us-ascii?Q?/qmyhzmzo2JuHMDFQT/TguQoCpLsVdaxh+r04uT5CqKt2Ngn3q+9YacwEmBc?=
 =?us-ascii?Q?LkS/OC91FF+Eql+v38/6N9qvOTwRb63xHrEZbM4dsE3IOzmFbLY688vmSjLK?=
 =?us-ascii?Q?czNOsHDWr3qdIBhyj3y8Yoxasp7PiT6FTK53i8aZNlMeimIk+cSAyMGwfZiw?=
 =?us-ascii?Q?rU5E/Zao1S/Hj6AmmGpT7JBeQ/FsvvZNgnzrFhPZtg9/fTp1IlOtms7vbZh7?=
 =?us-ascii?Q?jBn3Ren8QG6Jb7T0wi/aEX6SyJqqDp42me617vyFfqSwbKG3yzQvbcVwnZvH?=
 =?us-ascii?Q?1Ik1JiH6LHf+8IfIv6JSDbgtql+E5ajuFWn8eOG9DO5yAIklGNVOCWc1mr1G?=
 =?us-ascii?Q?NnPRp8DDC1VPNCpTjIyivySZcO9qg6TiptxM+ezGAF6JycmBd8KZVEpFAi5n?=
 =?us-ascii?Q?phcPhJhVOvRQnh/NszjYYTDtl+fUYDem7hPTZBpfyqkyMi7TU49YLLycW2EN?=
 =?us-ascii?Q?i9Am2eKuXNqpe6zKna+oSDJ9G3lkJW1NRV1QX44RdiORHim4y9idCfwAW3fM?=
 =?us-ascii?Q?valddhQQi8Z5nwqVWHACO28J6IvpG6JDoKCN2B28DwGL62JMAZI7iaChkiNE?=
 =?us-ascii?Q?QPwkq/viBtqxXb0rXjDsQEWY1Q0wUKU9Pa2k7zEX2s97QlzANWxm4aZl1uPm?=
 =?us-ascii?Q?KoNfdLWfG599lIVlzGXMZFX9MSTRGozn/8lvXMnIL+7wibLpv/HqhYi/pg4U?=
 =?us-ascii?Q?ngYYrOrN+R500lGbkUBPxkWVBZNThvz1PCM2KU6pcEesa1A8ZEX/sbFZBcmx?=
 =?us-ascii?Q?TU70E2uBXaF2OzKXMTAThNmgI24bp5nBZjFl9O8+gmEIpmZAhJrmn7Mea+F1?=
 =?us-ascii?Q?yxV9iEKBwKqbXrdCiGCid6VAIBe/PmbQ7UsqMyz1BhzjbDOBSvwFzXefSgVx?=
 =?us-ascii?Q?BTkpJbkc3t0qknnhirgj8XNA+CCn2NNGc99meQLY2TeVfdZ/5DLu91mlFTvQ?=
 =?us-ascii?Q?Wy9fIhayMnpEcqUq0CwJwc8TBopVYnfyHemIoUZT0W8Nc9TgeCqdcBCqRmEI?=
 =?us-ascii?Q?iMwtW+gQNjY6csiyRAt64Z+WO9sRjbgB7qCjd7OWwr39/a2zm1mr6q19IuDR?=
 =?us-ascii?Q?+lqUGqCCh4Us2fMKntsAlLzFcT9vbQ+iCC8Ixxqi7MfaMb3FraqDcdedwjR2?=
 =?us-ascii?Q?cDen97uNGAvYnCtjWmc6trx/T18S+hYcN/p2MxAPwOF8kU6aDG3yaouoqhKN?=
 =?us-ascii?Q?cqvFtBrP0nwZ6au06RBr3+tqcV0nEKeShSzu2z6lmVLbD2a3g+G3dvVaDcPJ?=
 =?us-ascii?Q?VSCMoo992NDb5F5fUZl/IpELPtJ8+r/z4FbIWlr4/oxCD6c3zOUrQplt4r8Q?=
 =?us-ascii?Q?tlpYLR6WRVZG9IPjbeWk7vrN95g3zyaknPlkGUM+1YoI807tTaJ+InoDl+7z?=
 =?us-ascii?Q?iAi8EP/GI29N+0e75Lw870GD48AjK2AwAHbW6Q3Hn84zgBwtVqARRTJiBlpG?=
 =?us-ascii?Q?OoTUnHr/jbR8hyVKB9M=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ed6191-fe1a-4e92-c832-08dca81103e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 16:37:01.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLJky0NIJvv+7IKCx1fPxoHZoh4AqbQMIF6oX5ulTgob1WlHKo5369Lwq5azciBsWRGG4pGyViZMG61w54flIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10102



> -----Original Message-----
> From: Frank Li <frank.li@nxp.com>
> Sent: Friday, July 19, 2024 11:01 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: miquel.raynal@bootlin.com; conor.culhane@silvaco.com;
> alexandre.belloni@bootlin.com; linux-i3c@lists.infradead.org;
> linux-kernel@vger.kernel.org; imx@lists.linux.dev; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH v2] i3c: master: svc: adjust the first broadcast spee=
d
>=20
> On Fri, Jul 19, 2024 at 04:03:51PM +0800, carlos.song@nxp.com wrote:
> > From: Carlos Song <carlos.song@nxp.com>
> >
> > According to the i3c spec 6.2 Timing Specification, the first
> > broadcast open drain timing should be adjust to High Period of SCL
> > Clock is 200ns at least. I3C device working as a i2c device will see
> > the broadcast to close its Spike Filter to change to i3c mode. After
> > that I3C open drain SCL high level should be adjust to 32ns~45ns.
> >
> > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > ---
> > Change for V2:
> > - use slow_speed instead of first_broadcast
> > - add default_speed variable in svc_i3c_xfer to avoid set default
> >   speed every time
> > - change start_xfer if else for easy understand
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 55
> > +++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >
> > diff --git a/drivers/i3c/master/svc-i3c-master.c
> > b/drivers/i3c/master/svc-i3c-master.c
> > index 78116530f431..7cd3a9a4d7dd 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -142,6 +142,7 @@ struct svc_i3c_cmd {
> >  	unsigned int actual_len;
> >  	struct i3c_priv_xfer *xfer;
> >  	bool continued;
> > +	bool slow_address;
> >  };
> >
> >  struct svc_i3c_xfer {
> > @@ -214,6 +215,11 @@ struct svc_i3c_master {
> >  	} ibi;
> >  	struct mutex lock;
> >  	int enabled_events;
> > +
> > +	unsigned long fclk_rate;
> > +	u32 mctrl_config;
> > +	bool slow_speed;
> > +	bool default_speed;
>=20
> I think you needn't two varible 'slow_speed' and 'default_speed'.
> 	default_speed should always !slow_speed
>=20
> Frank
>=20

Hi, Frank

In fact, I am struggling for using just one variable: slow speed. Adding a =
variable "default_speed "was also a have-to move.

If I use "if else" in xfer for easy understand, it means I only can change =
the MCTRL register value one time in every xfer. So in the first xfer, I mu=
st change slow_speed to false, then next xfer cmd->slow_address will be fal=
se. So in next xfer, I can set initial configuration back to the controller=
.=20
But the question is I have to set it every time, so I add the extra variabl=
e to avoid writel in every xfer.
It looks bad... Sorry for my poor coding.

If only one variable " slow_speed " is used , I think "if else" and "writel=
 one time", only one can be used. Maybe there is a better code method but I=
 don't get it?=20

Carlos
> >  };
> >
> >  /**
> > @@ -531,6 +537,43 @@ static irqreturn_t svc_i3c_master_irq_handler(int
> irq, void *dev_id)
> >  	return IRQ_HANDLED;
> >  }
> >
> > +static void svc_i3c_master_set_slow_address_speed(struct
> > +svc_i3c_master *master) {
> > +	struct i3c_bus *bus =3D i3c_master_get_bus(&master->base);
> > +	u32 ppbaud, odbaud, odhpp, mconfig;
> > +
> > +	master->mctrl_config =3D readl(master->regs + SVC_I3C_MCONFIG);
> > +	mconfig =3D master->mctrl_config;
> > +
> > +	/*
> > +	 * Set the I3C OPEN-DRAIN mode to the FM speed of 50%
> duty-cycle(400K/2500ns),
> > +	 * so that the first broadcast is visible to all devices on the i3c b=
us.
> > +	 * I3C device with 50ns filter will turn off the filter.
> > +	 */
> > +
> > +	ppbaud =3D FIELD_GET(GENMASK(11, 8), mconfig);
> > +	odhpp =3D 0;
> > +	odbaud =3D DIV_ROUND_UP(master->fclk_rate, bus->scl_rate.i2c * (2 + 2=
 *
> ppbaud)) - 1;
> > +	mconfig &=3D ~GENMASK(24, 16);
> > +	mconfig |=3D SVC_I3C_MCONFIG_ODBAUD(odbaud) |
> > +SVC_I3C_MCONFIG_ODHPP(odhpp);
> > +
> > +	writel(mconfig, master->regs + SVC_I3C_MCONFIG);
> > +	master->slow_speed =3D false;
> > +}
> > +
> > +static void svc_i3c_master_set_default_speed(struct svc_i3c_master
> > +*master) {
> > +	/*
> > +	 * The bus mode is already determined when the bus is initialized, so
> setting initial
> > +	 * configuration back to the controller. No need to set it in every t=
ransfer,
> just
> > +	 * restore it once time.
> > +	 */
> > +	if (!master->default_speed) {
> > +		writel(master->mctrl_config, master->regs + SVC_I3C_MCONFIG);
> > +		master->default_speed =3D true;
> > +	}
> > +}
> > +
> >  static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
> > {
> >  	struct svc_i3c_master *master =3D to_svc_i3c_master(m); @@ -624,6
> > +667,8 @@ static int svc_i3c_master_bus_init(struct i3c_master_controll=
er
> *m)
> >  	      SVC_I3C_MCONFIG_I2CBAUD(i2cbaud);
> >  	writel(reg, master->regs + SVC_I3C_MCONFIG);
> >
> > +	master->slow_speed =3D true;
> > +	master->fclk_rate =3D fclk_rate;
> >  	/* Master core's registration */
> >  	ret =3D i3c_master_get_free_addr(m, 0);
> >  	if (ret < 0)
> > @@ -1251,6 +1296,11 @@ static void
> svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
> >  	for (i =3D 0; i < xfer->ncmds; i++) {
> >  		struct svc_i3c_cmd *cmd =3D &xfer->cmds[i];
> >
> > +		if (cmd->slow_address)
> > +			svc_i3c_master_set_slow_address_speed(master);
> > +		else
> > +			svc_i3c_master_set_default_speed(master);
> > +
> >  		ret =3D svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
> >  					  cmd->addr, cmd->in, cmd->out,
> >  					  cmd->len, &cmd->actual_len,
> > @@ -1346,6 +1396,11 @@ static int
> svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
> >  	cmd->actual_len =3D 0;
> >  	cmd->continued =3D false;
> >
> > +	if (master->slow_speed)
> > +		cmd->slow_address =3D true;
> > +	else
> > +		cmd->slow_address =3D false;
> > +
> >  	mutex_lock(&master->lock);
> >  	svc_i3c_master_enqueue_xfer(master, xfer);
> >  	if (!wait_for_completion_timeout(&xfer->comp,
> > msecs_to_jiffies(1000)))
> > --
> > 2.34.1
> >

