Return-Path: <linux-kernel+bounces-233918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA04191BF46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005A5B2368C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1E91BE843;
	Fri, 28 Jun 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XpZs1lnQ"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDED3B79C;
	Fri, 28 Jun 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719580240; cv=fail; b=mr9gY/EYdXl+u2m9XCh1ByjfYJu9Tzzqi+cU9YZOwgWZb+JouCAiiahCafAbPCiMkUsl90tyVuOP/9/u3l7i9l9iWk1XXNT//oo9viB4up0q0UyH2l+QMOPJaKtDqFjBEdNLjvKnN72kOLZu8c6ca0m8yULNcTtxdV7MOQnoCrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719580240; c=relaxed/simple;
	bh=+jnC2NDuphw6JkU6CX72dcrUAM7HDUxsTz5OGSatNpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oVHSArYki/naQnClaW+4zQELC3yL343He3sW57IRVXVAKeG1Py++l1xFb4PZEqngfM40YrA876HmGpGGuS2NGcA/2qrH16q0SUkLaQCV9Gyzu2hS8wX/f7IKwY5R4gj1POpIjrrrtC+1XXZc3ZU16QFl6OCPpqcNmVmhhgw1s3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XpZs1lnQ; arc=fail smtp.client-ip=40.107.105.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efb1+H+LkHpk3G1DJ78rfhMLY2rECcWxKQ2LiUpybP4JmwhNH8LXZF8izUPtuW/lwHsTyZHb7oj0cC8d51QzRMYz5xeFer7XEdj3p9k6bqUb56L49q77UGFPhrZCC9BwISmCDO2flie98Gjjt6Ab0WHluQ00ItTGW+PtavbFRAf3UeDXzBFjz6bcM40QtK62irx6ONhDClgFFmEicmiFkqdkdQGMOs7LxLxqpMfOzqaPyef3bV6LnR2PeRNgAZqAHBrnzpgu2okofkwAu+bVjhwUKczvoqghep1ZRsgcLSY7U4SMYjttK0Ek6F1VVRlqG+UnWvDKW8/0+PbePppMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ht3oS351eES76RTC9zBDqt5B9yWWCjikSBYzpt7S6lo=;
 b=eQAmD16ijbhYauQqCu0wQetE+/jLgWR1ZTKhEIA+UCTXsz/5pIyts9ZGLpwf42giaQBQeI0m0sGr/dp6Lx6TBSbGwEbIwAeWwSMJ3fa78pWisUn+gNCnr+m0gxiJvDaGZYL9p/LngmohmXzhVExuAlY9d1AbcXGJ6DKc/MnitJrbcVgCJd/75aQjbiJ1/CQUAhgl+vNWd9F/NE8zhBRYGix7yvVTvDuDC/AlJBs+qxVWcFKvo6AjkHbqJqOw74+/6OV2MFpy8Bp6mVnNZUML60WQCWk3gUsfG3T0kxtcplJwC8LvDH/dLdsgpI2lvSVw1lVsoP6FCjdSA2JIN0odag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ht3oS351eES76RTC9zBDqt5B9yWWCjikSBYzpt7S6lo=;
 b=XpZs1lnQI4/EX8IkMyQ3Yqw6RN4bVbkrO1MFIGOdz0eetxPvOGQWb7cdyttQngvXXU7pdj790ikafTnUCSKLYdA2VPpkuboBq2lJOGLzIsHahxiiPABjzDnOvEP78cREOBx/myAOt+wPE5DzSxrEPn3ANaz8S6tRil8L/301uXI=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS8PR04MB8658.eurprd04.prod.outlook.com (2603:10a6:20b:429::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 13:10:35 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 13:10:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
CC: Saravana Kannan <saravanak@google.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 1/2] of: property: add of_property_for_each_u64
Thread-Topic: [PATCH 1/2] of: property: add of_property_for_each_u64
Thread-Index: AQHaw9ZmlXnGs5ZPSEao+eKKDoQ6w7HcLoqAgAD3VmCAAAtK0A==
Date: Fri, 28 Jun 2024 13:10:34 +0000
Message-ID:
 <AM6PR04MB5941D30C26F2CB818FEC082C88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240621-clk-u64-v1-0-d28a611b2621@nxp.com>
 <20240621-clk-u64-v1-1-d28a611b2621@nxp.com>
 <20240627214355.GA601888-robh@kernel.org>
 <AM6PR04MB59416E3C8FFC904450F3B02D88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM6PR04MB59416E3C8FFC904450F3B02D88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AS8PR04MB8658:EE_
x-ms-office365-filtering-correlation-id: 9b2e3898-49fb-4a09-381f-08dc9773b257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6Xj0CjmjGWBvOjCUkKEPdZT8OAeQ71W+S6HZDDFXxJppBTgXpwzQQVwqDUG5?=
 =?us-ascii?Q?yx/KHN+ERAN6m9VMrDdGPK+20O9gISeimAo6Ljlto2UF8mpjdCqOTwdxlAIJ?=
 =?us-ascii?Q?ORnk7xJ8ceii386qsNvQeDQwfVSLi0UXVVK0R5rz2zrR63SAr2cRU+MWd+yF?=
 =?us-ascii?Q?74kGzlhZcHR4i4CXFBJIDGrCXMyviATB84F/PVrKekGsbHWcK3E3m1BrbGv2?=
 =?us-ascii?Q?c5NVpYqVv6ppWarDhtepYE2asAjXKL7w3YNGj45HfskhnCdi0d2QtDtbf3LL?=
 =?us-ascii?Q?bpTO7pqby3HX0ctmMJRmO7BFELcsptSBKfoSQUrxjm7O1J0mEa+vUqRu7jF4?=
 =?us-ascii?Q?6nVVcs5zviDIqlo2DZDK11MnxxaVsSKofxyKP378Nx08RlbNW0Wijhg5rUnp?=
 =?us-ascii?Q?7TZXE+H8lr7ErZ0AnB3gLzZezBLcNZKECWKDkZNCkqTf0SqCSxkSqje3zcW+?=
 =?us-ascii?Q?E6ASegkxi2Zs7h5xhV9jNgl/qwnKz+iLHGB0XIa6WUiIEQgU5LISLCpSl9yj?=
 =?us-ascii?Q?uUC6fYrz/9M7qcsbD+IemtK8opXwF/o4ccvb3zJ8AEloSexTF/wTjlpPjw2a?=
 =?us-ascii?Q?RwJMvNGSDfAFK8sbq3wuDFOgJ++SnZm8qaspvGjgvhCrn1pwd4RobuWhyH3U?=
 =?us-ascii?Q?do4pnF3AYz0Bt+0KWqE5D08KATtkmTQoZj1uv4J2DZug1+Bh/s2VCCqy84Gx?=
 =?us-ascii?Q?sfiR25JS5wxQBp+cuxX08RobaSTFfIhiNIZMdBX/PMWegO0uH01SpMyOU/GJ?=
 =?us-ascii?Q?j0VVH7ylAivd0NCyd7v1MMhf1gWRU58HnjufZPeanKJAFXUSKitbtWibij9p?=
 =?us-ascii?Q?oKgw6Tg6VPYdytO8CRzPGU86WPLfrFfZPnH3iQVSD43u7g/h5XVEa1bDhpxs?=
 =?us-ascii?Q?ON0kPbyTWyXsRtgRhrSiAjtzRQGi39RGmfwPh1uGaxt2J8GfyoJ0RMAcL2uQ?=
 =?us-ascii?Q?16NceiFDztZmQsljbtb6MP0Su8ZxW+k9xn7hcZb7QCtc6oOfVtFkBkg3JvjQ?=
 =?us-ascii?Q?Ck6xGQPXzcQk4ADv6TPiSC3BRQC1JTc2lj3PP0SZaOqUgAfLuFAusTVhAeWF?=
 =?us-ascii?Q?a1d2OiWp9KAUBviN8zFl7R6hk1NZSnrBOrh++GWt+WcUVZMot809dstDv3lQ?=
 =?us-ascii?Q?JDG4GqzVhBuIAH4t/ZeX0RG794hSRnwv0oowqOjy2rv0AGK0TF3wxQsPwMLh?=
 =?us-ascii?Q?+i2/uTL9MC5gQOWdLuTQzdZ0VH+kjeHJCA6OIuRL5p4ETSM7XTa5VD4k6PT2?=
 =?us-ascii?Q?lsJsu5z8OJ6zkLHLxqzAe9xBQ+TcLoSlYtwSYpAZqo9w4qTgOA9v3EkCkHlv?=
 =?us-ascii?Q?lNwz8CLOYF0Edp+58KKptSn/Caxabc0nHpo6hAfcpbYFJAaSZ/VucGNWhWeO?=
 =?us-ascii?Q?iFDVtjs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MMgQrivgr0F71GfUi0Wulq2xG45HaUWWeVlSVLqvkIKi6wtNa6qSXgZVAMt5?=
 =?us-ascii?Q?JSte9DBQ9QiDbeGn9Cn1Bh20e5XLT3B8Y0hPhKFuJn+XR8ZeZNszv/BnWMQt?=
 =?us-ascii?Q?lRvq2LceUiJVQECtFHLvXXohj0ARddMxmTS7IPEKFFQ0fSOuJaavX/Stf0uC?=
 =?us-ascii?Q?m9/shJOHgupLQzv6zrSNihua+sw7edRJukh9vz0QDjV6voYYUO86fBhWWaai?=
 =?us-ascii?Q?Ks+OXoYI0t03Q2j1gl0tRG2mlQlDL/+YkqJ+edczUY7jZYBBuld5eiPUu4Vq?=
 =?us-ascii?Q?fTo0QFm2fpMZrkH3q0T6GdLs0vtq1yCaLW+0HStIkxE4C5leJMRnzlk3/JjI?=
 =?us-ascii?Q?HqLoNgi/RVrtg4dpzXv9F4jH+ZY0z4qVR74BfYPf9UZIouGxRrnxXHmsqJm/?=
 =?us-ascii?Q?GFUTe79xzljvRvNowY8DFt4mYeQyiLwXZMBenbnNs+B94adIH6aY4nj6foSv?=
 =?us-ascii?Q?bh08Ib20omwuoeiY3KOTFXQURSQSX5kCDtNSaBF88wKPML/Y0Ji42W+I/cSk?=
 =?us-ascii?Q?aoy+Fg5KvaoAy69PQq4PWrSmf09J/XmQDGncxQ0+I4ccW77g6f+H6SJBcE30?=
 =?us-ascii?Q?QWRAFNxIDrUzG0PAjJwD9Co1mXlozSD1W8shyk0gMvNX7P7SLpyKziiW98xn?=
 =?us-ascii?Q?vJsg/nMXvFI1ls1r0AEC2YHNWvrmtm6RrrDgoIC9kpl1TxbDO3ym5bJ972os?=
 =?us-ascii?Q?2c+xd623xWSPLNTCBa3YFK7LUd47tFVD9u/HhF5u/bEnQ4TWwPXSPG/EQupq?=
 =?us-ascii?Q?huk+gfmN4TEjUXYbE1J6Bg8NzKeyqJOXIbh3U7HTKup5hAZ105tMiRB+LVqW?=
 =?us-ascii?Q?NW9UoDWKZ2ZFOLdUOzuAlDB8tZ5uEQjSRUxg+PrtnukBkz8Xit4Io8Ccf8/P?=
 =?us-ascii?Q?GEyRjzJBSnLKsVx1ZyKmJMW47/Gsn4dCtsnnIeIzgfHkeb/kCeOEBkPIVrBv?=
 =?us-ascii?Q?+hWKJDlL3ab84Rqa+Ol8YS3T2jzvxXD73MpDk5arKgUrHTGgZdUhfRGX9uK4?=
 =?us-ascii?Q?9vG+W1Zw5uITOsjpK0mh2HjIDdg5Gg7fg5mR2L6vL2uxpxFTLPyUbTDBupg7?=
 =?us-ascii?Q?+U3Zal/jrmLpcHQCWFfAscPr6Q1i4C2YRUwus71yQqe4mslzZJFrIhyXBE1s?=
 =?us-ascii?Q?cMHt5Sox1gHHBwLXQ/breaE3GVkzjU7Vwc60aZWH1V59yN+xVINw4AHqodLV?=
 =?us-ascii?Q?1Rr9nL8fmYdANkp4YXkRIvA8eoxqYdqpWZma7Z3shIUpRX+NAN//+/PEmsWs?=
 =?us-ascii?Q?SIklsewv2KHSAn69TcjNf16LvWJGnXeXlmH2zAWN6ddjCwBo5aezpR/TTiRs?=
 =?us-ascii?Q?gC/yGYRFTTHB7xfJDS5ehPJOyeJdhxVx5Sm65VO32NXdKjiXDK22jLhiPeGq?=
 =?us-ascii?Q?9AXVptjFjfRhHflQ6SeN1kXlPxaYJVJuSp/TmoOPANxoabS76jHU3CWqNYrj?=
 =?us-ascii?Q?qkQ2V7XnM3TXmJ4C99tMKsZClzq0j8oScUMbuamrpNoL0goQB21lePuqg/sh?=
 =?us-ascii?Q?hobzzJhxA2T6xu9yyqI5oRSALoeO6nKGhm3tOCrLJiqbB9yRmfTbjBwR25GX?=
 =?us-ascii?Q?MNgBQAcGoFFPNctpxTY=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2e3898-49fb-4a09-381f-08dc9773b257
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 13:10:34.8710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3W8WscAflClIiT0ixYC+GusMAUHPlZ4xtyBaq6leKISKMDTXKcoOzJr7vkW5N+fJyysAba2pQiD9ubI9IjC6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8658

> Subject: RE: [PATCH 1/2] of: property: add of_property_for_each_u64
>=20
> > Subject: Re: [PATCH 1/2] of: property: add of_property_for_each_u64
> >
> > +Luca
> >
> > On Fri, Jun 21, 2024 at 08:36:39PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Preparing for assigned-clock-rates-u64 support, add function
> > > of_property_for_each_u64 to iterate each u64 value
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/of/property.c | 23 +++++++++++++++++++++++
> > >  include/linux/of.h    | 24 ++++++++++++++++++++++++
> > >  2 files changed, 47 insertions(+)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c index
> > > 164d77cb9445..b89c3ab01d44 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -548,6 +548,29 @@ const __be32 *of_prop_next_u32(struct
> > property
> > > *prop, const __be32 *cur,  }
> > EXPORT_SYMBOL_GPL(of_prop_next_u32);
> > >
> > > +const __be32 *of_prop_next_u64(struct property *prop, const
> > __be32 *cur,
> > > +			       u64 *pu)
> >
> > struct property can be const
>=20
> Fix in v2. BTW, I am thinking something as below:
>=20
> const __be64 *of_prop_next_u64(const struct property *prop, const
> __be64 *cur,
>                                u64 *pu)
> {
>         const void *curv =3D cur;
>=20
>         if (!prop)
>                 return NULL;
>=20
>         if (!cur) {
>                 curv =3D prop->value;
>                 goto out_val;
>         }
>=20
>         curv +=3D sizeof(*cur);
>         if (curv >=3D prop->value + prop->length)
>                 return NULL;
>=20
> out_val:
>         *pu =3D be64_to_cpup(curv);
>         return curv;
> }
> EXPORT_SYMBOL_GPL(of_prop_next_u64);
>=20
> >
> > > +{
> > > +	const void *curv =3D cur;
> > > +
> > > +	if (!prop)
> > > +		return NULL;
> > > +
> > > +	if (!cur) {
> > > +		curv =3D prop->value;
> > > +		goto out_val;
> > > +	}
> > > +
> > > +	curv +=3D sizeof(*cur) * 2;
> > > +	if (curv >=3D prop->value + prop->length)
> > > +		return NULL;
> > > +
> > > +out_val:
> > > +	*pu =3D of_read_number(curv, 2);
> > > +	return curv;
> > > +}
> > > +EXPORT_SYMBOL_GPL(of_prop_next_u64);
> > > +
> > >  const char *of_prop_next_string(struct property *prop, const char
> > > *cur)  {
> > >  	const void *curv =3D cur;
> > > diff --git a/include/linux/of.h b/include/linux/of.h index
> > > 13cf7a43b473..464eca6a4636 100644
> > > --- a/include/linux/of.h
> > > +++ b/include/linux/of.h
> > > @@ -439,6 +439,18 @@ extern int of_detach_node(struct
> > device_node *);
> > >   */
> > >  const __be32 *of_prop_next_u32(struct property *prop, const
> > __be32 *cur,
> > >  			       u32 *pu);
> > > +
> > > +/*
> > > + * struct property *prop;
> > > + * const __be32 *p;
> > > + * u64 u;
> > > + *
> > > + * of_property_for_each_u64(np, "propname", prop, p, u)
> > > + *         printk("U64 value: %llx\n", u);
> > > + */
> > > +const __be32 *of_prop_next_u64(struct property *prop, const
> > __be32 *cur,
> > > +			       u64 *pu);
> > > +
> > >  /*
> > >   * struct property *prop;
> > >   * const char *s;
> > > @@ -834,6 +846,12 @@ static inline const __be32
> > *of_prop_next_u32(struct property *prop,
> > >  	return NULL;
> > >  }
> > >
> > > +static inline const __be32 *of_prop_next_u64(struct property
> *prop,
> > > +		const __be32 *cur, u64 *pu)
> > > +{
> > > +	return NULL;
> > > +}
> > > +
> > >  static inline const char *of_prop_next_string(struct property *prop,
> > >  		const char *cur)
> > >  {
> > > @@ -1437,6 +1455,12 @@ static inline int
> > of_property_read_s32(const struct device_node *np,
> > >  		p;						\
> > >  		p =3D of_prop_next_u32(prop, p, &u))
> > >
> > > +#define of_property_for_each_u64(np, propname, prop, p, u)	\
> > > +	for (prop =3D of_find_property(np, propname, NULL),	\
> > > +		p =3D of_prop_next_u64(prop, NULL, &u);		\
> > > +		p;						\
> > > +		p =3D of_prop_next_u64(prop, p, &u))
> >
> > I think we want to define this differently to avoid exposing struct
> > property and the property data directly. Like this:
> >
> > #define of_property_for_each_u64(np, propname, u) \
> >   for (struct property *_prop =3D of_find_property(np, propname, NULL),
> >          const __be32 *_p =3D of_prop_next_u64(_prop, NULL, &u);
> >          _p;
> >          _p =3D of_prop_next_u64(_prop, _p, &u))

This will trigger a compilation error, because C not allow
declare two variables with different types as for loop expression 1.
Need to think about other methods.

Thanks,
Peng.

> >
>=20
> Sure, I will fix in v2.
>=20
> Thanks,
> Peng.
>=20
> > See this discussion for context[1].
> >
> > Rob
> >
> > [1] https://lore.kernel.org/all/20240624232122.3cfe03f8@booty/


