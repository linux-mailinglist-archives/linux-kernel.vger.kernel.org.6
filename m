Return-Path: <linux-kernel+bounces-263236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5806693D30E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE06E1F21CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A700E17B437;
	Fri, 26 Jul 2024 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RMyRdtsf"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B89E225D4;
	Fri, 26 Jul 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997306; cv=fail; b=Ryds5PziEYhyVw5qtfbZaWh8UeY1h+CbiiIWGvwcwAN2vWH+d3+dHmT5evDQDJ4wnC5cD3pvjo0pTTI+fxhdzB4Ne7aJvQ/vTB4Nm9J2vG/50RrfGx2vi7x3mTUe4dB/gZYs+WyTEU1G8eVPL7ouSaFpGi7pDbG+aO+Exs5RH44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997306; c=relaxed/simple;
	bh=nCUONEPnZilUrm1MPDRolPZFn/bnp+qBiU3t/jXtzlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dR4Wt/ZcdHdUXO1JbP4dvJEZD+xffWudP5/nLOxZ7emfO3g6QBnXmlIeLFeJN5TcCbiChu3gzfoO0chsEp1dV5Q7QLPihVK+MuSMnpauBH8ei1dcKBPmV31apGznDG7VHUj+AHtmJVG069XmUCPIkgdD7BpPusYgGSYtFlR9H3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RMyRdtsf; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0uvavVXWFeKnGYSrNTtuk51Rzad+3benNfEEqkEQqZI9CM48O3wMxE5AE29Mzyq+WxtqFlyH+y6tWCJJN1nkmfyM7tRwYOdwcMLhmK1tg9Urnt4TBji5kg1R9NIFOGtt/AO5bePxMBAqhv7Rya+85H1EkzwwuP5H70UTeuEmpkTGhfQflISKmnn5V92ffiCb2r3IoYEMzapHsXRJ4MLkQHyzO9uWp9S8VlURbLq3opywZGDFmnSfpG+DFuxyit9XJTUag//yZ81kXNYEvyykWLUBrZ4ock8H9QIRRyu2zSXJZGyDCZSttLrH3P/hO29YthU1rLODHnR525sdELh2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArqXfAM/Pqh4X9hF88/wv8IS+QxXGKlkjDrRCDnWhFM=;
 b=DhB3dv7uGnpsMCHTURVO74MDHD0kzXbKlGu7vy8FN6qYcY5iWk+WPlww0J7tnHvzYtK15zhY61eF5PKnIRlp+JQ/kWPUu5ClaUPsorFqV9rDeQJmJuDse2H6p1sPIkypOVHlNtlrKFQG+/cP9i5qT8aZTG2wIkqgE+cTsa1gt7bCmueVL0QbU7eY4YgCZjRbkTOFakpaAJfXL5wrBgUKRO2uv8AzfipmTJeR1a780Uy81iwDn2nA2HVyDvP2D9xCQwRLMYAFUC+V4P0zV3tnvaZhJAmWxreXe9SMl1tY5gBriDQNMyTqIBIKRWpzJlDPo+NNAG4iyWlQfpsNZLAzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArqXfAM/Pqh4X9hF88/wv8IS+QxXGKlkjDrRCDnWhFM=;
 b=RMyRdtsfJuL3cXQIzOji+OP8Ack8MK3ao8+pkDMLfxT9XB+YtSqiDUqKxSDRGuzPQWN4lcFzmLilNp3sWQHIuMaQTNLpFfA/IvfMFNdxA//c3cPgDWryA/A3dNa94SrYmiUP+UAIiwSaqzZpHu+sKJH8GF1NkkbLNViwvmFOH/xq6baiqn8loG9uAemUD0/8eKS50Zzfsq6yW2W7gCXconR8p2d0iIhCTLFpX67qYuYffpJ5ubcoFwss1oBaF0nHLj4++BIdunSQ5/wzJF3T1EyEne/eViu76Cd+vghe/9h6fTnf03EMC93DEahcvcGelxjt5qPGNclPXmEpIG34lA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9503.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 12:35:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 12:35:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH] clk: scmi: add is_prepared hook
Thread-Topic: [PATCH] clk: scmi: add is_prepared hook
Thread-Index: AQHa3nDdvyZ63JzdWUmPgzcBzaVdhrII4KiAgAASqGA=
Date: Fri, 26 Jul 2024 12:35:00 +0000
Message-ID:
 <PAXPR04MB8459D7FF7393CEF70105CC2F88B42@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240725090741.1039642-1-peng.fan@oss.nxp.com>
 <ZqOIFfkxylcdIIFB@pluto>
In-Reply-To: <ZqOIFfkxylcdIIFB@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS1PR04MB9503:EE_
x-ms-office365-filtering-correlation-id: 1e9c8736-2397-4dcc-1a13-08dcad6f5d82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iI6rVE1QDJLZTc5b/ynVouP5NKL27Jlqyx/CJkYFxwpTOJXdjG6fRda1HaW0?=
 =?us-ascii?Q?eYNaXjsR84OnlcNx0t+FkMknNTYy5j4i1Tnk8aKv4gJj6lX3CKlPsDzVcC1k?=
 =?us-ascii?Q?n1RdKewDTclB51twbs4wKCsmLnwEHnIAb7TzR74+KJC5t+er9Co0zt0isUah?=
 =?us-ascii?Q?vnr4GXqADiZqiI1YmuGiybVgprgCaW0d/5ER59c7uVntUyhN9LYQBD2PaH/C?=
 =?us-ascii?Q?tf8b5enszKY5yoPnjLS08hCXkZNOUtNZww0hGJOmoJeNsQnPjp+ugOhYqmk3?=
 =?us-ascii?Q?MiqagFPcI2bj0HQdOEw3yjJSUFXm0Ljn3yGYumgBegDrnoto5wqhkutu+363?=
 =?us-ascii?Q?qGgLNZou9aUNV8g+vIPwpQyY59on8RoUAp8W3iFBgaBskdzyrxtRKB+kgRys?=
 =?us-ascii?Q?Mvc3UQ1wAdeS51u0ZZbC6gxd6ixv8ckUG3v2WhtsBqFfQP/syOZbXCLaTkCQ?=
 =?us-ascii?Q?gOkxKY1Ms9aXASxJbyidAud9e3BHfJe1ixPMZVJyFADEDmrbdhTff7xM1aEO?=
 =?us-ascii?Q?O53HUvj4TB4kuQ3+gWqYSW3yMpmIGmsllaSmWlHHutMg+zFzdVilxU/Bf1i/?=
 =?us-ascii?Q?OnVuVcwycDNB9MJX/kaNXh5skGIcapqw2hxHlf+Jdh6laIRRWp0iQE13aFOv?=
 =?us-ascii?Q?D5drMkoZnmzfdRMCukgjQKx5fucj2WIzz43T9vvs2tz79NN/rHNwyWLT3oUO?=
 =?us-ascii?Q?0FsjXj2KdV85rggFepz/UpuvdB+e7MePc2bGApk8QGLibrp+nzLeCtE/CzAI?=
 =?us-ascii?Q?bZMjdxMfEFeX3vedIx0lMENUGwbvzeWi8B4HW8pO3IR6QUDLp9aox88euq5v?=
 =?us-ascii?Q?XQIo9959zaIOKGtHuGhjcSMo9BJ/8DYmPNoIizlZa8Y0h3XK6SeZmfJVVnkf?=
 =?us-ascii?Q?s4XGI7KVVaGLL9l+BxcAruAzYWcXiVXikscuQjLekE+W9ixmbo98lhAwyOm9?=
 =?us-ascii?Q?i9kVMNqhgARFSgp/7OuRRhQc7BWkqWMt0DEFOh4QOLWx8tj0mS6mQSnQQjdJ?=
 =?us-ascii?Q?6BQ+Enl4r4LJANvTTRSNVGJlw7DSqUWWuqNRx1wxuymkMxguGW0XrGEo3wLq?=
 =?us-ascii?Q?X7DaJ5Jf20A4suNqG7nfQgl78LSLYlt5lQQwfdTPVeikmtWFRcru/fChgYjq?=
 =?us-ascii?Q?k+KQLRUXZvgdwCjQVuUb0GmhdaRyMYVwKdESp81+H1FdMUdm4G4OH+chz5rA?=
 =?us-ascii?Q?xuNpa/6RQ/sn6fxtnVoxwgi6QnHOvVGeZ72ivygE/ES4meQ1D49tib+eyYl3?=
 =?us-ascii?Q?LsoiczXlA4p4hINsOlztw6UkEZIm+NQkQsCW7x9dW1FinE4LZyHKUDy5jv3d?=
 =?us-ascii?Q?empaem1to9blFdQ5X4Pg20mAcIfhwsdDu3J4Rv+oTKfHwOxg8rSJTJeVIw2t?=
 =?us-ascii?Q?BXUOgHo8nCppOY7bKDtXXctG8xR/i07rpluDDRfiF6Wcc3Iz2Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bM9ipdt8duDiVY66vd7w2zgt/G9rbhAJC2ELPO31nMVVHpQVr2/4XjXUqVb6?=
 =?us-ascii?Q?T53H23h0HRVBxwn5MP5zr4ZyfQhR2FeevzRdHa/wQbGQ7o8WeT2LWKLpk+zE?=
 =?us-ascii?Q?7oWxy7hqd50wP9tqd4u/R/wpI89lfuhWFkCKS4Sq+/Ki0+dy637ItywGSYD6?=
 =?us-ascii?Q?Fq4vM86XG5b0Iif5KmDh1X5+sGJzmM146PGIKzldU9U564MyfCwu+fJpnuNj?=
 =?us-ascii?Q?qFXpGSvlievCXWDuZJVD84sY20nK1/fk7Z8T9p2EL2ahIGnPJ7gmgWflroLu?=
 =?us-ascii?Q?nZbnTERAyUeRt4DdusQLj3I/xIOAIKU5FYYLraU7n62E+F3/t52GA0FHFA0d?=
 =?us-ascii?Q?5tyzVaqzvlaXRmnoOAFTSf5XKScnKq+CdifwA4C+Uo+WA7gx2dPVuxi/WPpc?=
 =?us-ascii?Q?B5j3Pn1a5d82EYUw/QdgVMyMeA5OW4LtkK8mPwSvSzXE5XlxD2bCfDGnetJ8?=
 =?us-ascii?Q?cvIE0l1E28z6Cy4RHy7Yi4vydeZaD8BGGIxG/DPR5ss1VkWvvX1ev22pPBad?=
 =?us-ascii?Q?cxIZBKH6re7IWEjsP0LcIGWEjmr9jm9BCDLhBPwbFT/3r3sfesSQj/2DycrM?=
 =?us-ascii?Q?qpqadWSF0T/lB79nTKU7JlsnpLV1n1SVRUDd9HI9iX9OPhGz9N5jm/Och3hF?=
 =?us-ascii?Q?JujH1AchHdCTahLljfuiNrdOUxbI36rdAtaOLAEjPhHny25BfDAnPcJHJaoI?=
 =?us-ascii?Q?AtM2GYMNabTl6Isw3T+Y5X6f2uckFqvjflj/Y1hz88IRfTw3R5tE+gU1e4Au?=
 =?us-ascii?Q?QoFxmWhoDFavfmCwKNV5mmQVU37jyA/6D2NvdqsWSvh4jLzUdF47NRDfsFWl?=
 =?us-ascii?Q?WzG+bHsrUVW2hHoJo0kPoEgSWXCJj3cnGIITRH2g2IaE8vQyOfmEBk3p3ysO?=
 =?us-ascii?Q?DlxGC+9blrkgj/lJxjqjGMeIGvO8Eim+yAV/hmxBNtOsgbhwGPFIEmwIk5p0?=
 =?us-ascii?Q?aWdWTInFEDIBF4Sby+Ppezl4b4wBEFl+UNyKFaSAy63TNKRQVxvITWlZ8hTP?=
 =?us-ascii?Q?+rRj+uFaTV7s4zwQnsWxEYRXCeXRCJQYjpJro+uU79AOrj4wMt6affztd9sF?=
 =?us-ascii?Q?KfMgM/F+gAsUqHsax3U8isciVhYM4MXhMNls3yuq9Qq29uKJCe8awni55HmW?=
 =?us-ascii?Q?03PQKGPOGY4GG61Cg3IlfZaP5WoIFJ+eTAWMbalf4MFnpOZTXUCzHBFiW2A/?=
 =?us-ascii?Q?LJU3UGQoUngT63O7ZmN3nhKZcbkaPreEFdvomZGgUZFuyjEeHOkOzJkiGa0f?=
 =?us-ascii?Q?VY4erozEd0DenVeFwb7+GZlkhf9mdIBhSn4Zct2k+X5WkfctlGzkdk/bfQXb?=
 =?us-ascii?Q?id3z2e8QKLJCpPSJObDuQ+KlJ9OYHWHTguDsTZ6dinKUfw/Sy5QUIr8fcfWp?=
 =?us-ascii?Q?yDqrhyfY/YJlpaiANh8hmYjIJC7L4T7QKHIA0r3iOwLjHrJyyf0hjv5XArbz?=
 =?us-ascii?Q?F5RHXhNSn/JSdFwH5CmBmw8n7LvlOf/AckdZmddRRW9kn1emMwMBXPuwjPBy?=
 =?us-ascii?Q?EMj01BgF4L8LPYHiuTLnNLo7mUtYZTeL45BZL/Tf/J/FgDdg5yrCXXNN1sqZ?=
 =?us-ascii?Q?OZqsRMNcejNp9X+8Pmc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9c8736-2397-4dcc-1a13-08dcad6f5d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 12:35:00.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2OKwNoyyXm/y92NPJ6wQGAvrMVF+Bp0dFpkIszg98FSeDjo3xhEqAz/xt+zn07sojtswWBRNi0+DX+tb5ou5mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9503

> Subject: Re: [PATCH] clk: scmi: add is_prepared hook
>=20
> On Thu, Jul 25, 2024 at 05:07:41PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
>=20
> .... one more remark..
>=20
> > Some clks maybe default enabled by hardware, so add is_prepared
> hook
> > to get the status of the clk. Then when disabling unused clks, those
> > unused clks but default hardware on clks could be in off state to save
> > power.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/clk-scmi.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index
> > d86a02563f6c..d2d370337ba5 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -142,6 +142,20 @@ static void scmi_clk_disable(struct clk_hw
> *hw)
> >  	scmi_proto_clk_ops->disable(clk->ph, clk->id, NOT_ATOMIC);  }
> >
> > +static int scmi_clk_is_enabled(struct clk_hw *hw) {
> > +	int ret;
> > +	bool enabled =3D false;
> > +	struct scmi_clk *clk =3D to_scmi_clk(hw);
> > +
> > +	ret =3D scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled,
> NOT_ATOMIC);
> > +	if (ret)
> > +		dev_warn(clk->dev,
> > +			 "Failed to get state for clock ID %d\n", clk-
> >id);
> > +
> > +	return !!enabled;
> > +}
> > +
> >  static int scmi_clk_atomic_enable(struct clk_hw *hw)  {
> >  	struct scmi_clk *clk =3D to_scmi_clk(hw); @@ -280,6 +294,7
> @@
> > scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
> >  		} else {
> >  			ops->prepare =3D scmi_clk_enable;
> >  			ops->unprepare =3D scmi_clk_disable;
> > +			ops->is_prepared =3D scmi_clk_is_enabled;
>=20
> ... you should NOT add the is_prepared ops here, since this would
> mean
> that you will have the is_prepared ops available only when
> SCMI_CLK_STATE_CTRL_SUPPORTED, WHILE you most probably want
> to be able
> to check (non atomically) the current enabled-status for a clock EVEN
> IF
> you are allowed to change its state...please add the is_prepared in the
> else-branch down below where the ATOMIC is_enabled is added

Will use this in v2. And together try to avoid duplicate code.
        if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED))
                ops->is_enabled =3D scmi_clk_atomic_is_enabled;
+       else
+               ops->is_prepared =3D scmi_clk_is_enabled;
=20
        /* Rate ops */

Thanks,
Peng.

>=20
> Thanks,
> Cristian


