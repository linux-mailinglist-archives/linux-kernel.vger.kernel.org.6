Return-Path: <linux-kernel+bounces-375925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F99A9D52
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1ACF2829A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25311186E46;
	Tue, 22 Oct 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KMgMaXpn"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3BC189BA6;
	Tue, 22 Oct 2024 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586726; cv=fail; b=A25n/C61QG7eoxjJsK78/UmRRQGKJu5h74AkFfUcts3zTpc0yQApqQhYmFFRStYWxzs1owAfSLUI8BIR0fhFx+m/wBOnl9Y7qnvexe1JLrL3qClzyADWFkt716DC44Ixrm8pDeAXhaAKg72mYon7TFRCdBkQzhmbe/SAWBKd7tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586726; c=relaxed/simple;
	bh=vT+7pbZdPoK53AQc/auvC1XKvsBrQSRIUKnWu8qpgy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P0JNoGGjYKQEfnZNHGihL5iz2WIY8ngnNrAPt2I9MXLQyL0aZ+qQXDdSkLLiDypSp/faCHzJ91Ce2svYBxJFFXJ78gB4P0GFNycgWMNLlfuI+Dms4BXSacazkM1MCiSNJVnBnX8Y4IjJ538HZpcczUT9OqgsrU33YZkw56PEPC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KMgMaXpn; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFJSZ6YobHrAvFG3KNsqG0nnz4eT9vtY7ivEzY4m/m9pzKeaSCKL7qzpbYPvyqsGmoyKVvrnCYmG2doSflYOGqf6JNtLmhrj92nblbt5kzRX8GF2ZGbp8GL/o2f6JLmfhL7vsFD+FuidoIDHnu9gRtsKpaHvZe7IUML2ppbi+PWtZgG4VEAK6bOhPkRp3rBd2qCeFl19crdGsu/EqY9O4l/0axoZdh2btF4J9tkTE3MoGkGkL82+TnPdjJ2nEqQtsfAoYjt01ELMSnLWc9rSNdi5WB1CBvHpXt28fqxGpPfc7MYU/D3XJI83qqsEV6VIMw5n9ZvNTi9HhcfcNMJpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GnmnjQY7pahcI4FEj2ngWR0gziZL/PUsucU01KP/Dg=;
 b=xhMqJcZt/E4o1I9hLDsNGdrRKUix5LjYIdIfqUDMSoQTAMc1yJIxOymkhbHUuMHnNiLDI6OVNvU4UGU9ajZtISupuQKPewqFLva2SCWgGVOAX8v3jXtqcDHKd6tyDTBUX0ylMMK7jX0V1DdmUhU2Veg466k9C6tAHQOYQ3sKwg2ztq8FYrV3PhS7CKu8Tr1zpQOmh1XGrOGLdrNw0QQWeB7Gm3xq+tLVGE4usJqJISZVaHcMhUcnkGGoBh9lXKL3sZgv/N1EoiKoiUF6FqrDekBby+JIf2IZnzIIH3uxqKONFFJcb8L8vH4R+rRBgkLhsdd0HIyIK829tPj299sjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GnmnjQY7pahcI4FEj2ngWR0gziZL/PUsucU01KP/Dg=;
 b=KMgMaXpnoAPQM184mTmhsy+bFvTCrBPtZno1qBudtP/LD90qWdkU5fL7fUQip3aUi/pPJUBdyIVrNJgpS92UyXbBlPhmnbTXd+T8Zt97lrDsziAhIcleJclsZqVgBzx2CCmTFslUhTYXFKfLldip1qVbsxbJqWKLlni4P0XWMcn1zeBw22Y128dVq2tcOBuc62ns6d0xVtRDzFk/M1Wc0ieQbEXbReGJz15bN0S/078EiVLWyy99jOCPrp2hbgTO+WGuCoM16aUJREtxla2oxeHv6Sx2aoOjYKulDdgyQJQtNKle7L3yjAULwc6N5Dlb7zo+o55VyaEQ2A/WgweEEg==
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
 by GVXPR04MB10540.eurprd04.prod.outlook.com (2603:10a6:150:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 08:45:16 +0000
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0]) by AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0%4]) with mapi id 15.20.8048.020; Tue, 22 Oct 2024
 08:45:16 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, Bough
 Chen <haibo.chen@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx7s: change i2c compatible string for
 applying errata ERR007805
Thread-Topic: [PATCH] ARM: dts: imx7s: change i2c compatible string for
 applying errata ERR007805
Thread-Index: AQHbJF63tF0trvPPW0e2LlLDovMvpg==
Date: Tue, 22 Oct 2024 08:45:15 +0000
Message-ID:
 <AM0PR0402MB3937B89BD8A42DDFAD2F703CE84C2@AM0PR0402MB3937.eurprd04.prod.outlook.com>
References: <20241021031148.2682015-1-carlos.song@nxp.com>
 <20241021092743.GA21104@francesco-nb>
 <AM0PR0402MB3937F54EF17F80B80A77DE07E8432@AM0PR0402MB3937.eurprd04.prod.outlook.com>
 <ZxdWuUZ4EQfUJw1H@gaggiata.pivistrello.it>
In-Reply-To: <ZxdWuUZ4EQfUJw1H@gaggiata.pivistrello.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR0402MB3937:EE_|GVXPR04MB10540:EE_
x-ms-office365-filtering-correlation-id: 6bd6830e-db67-4113-9ac8-08dcf275d9ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?25r3YGlYzjeet5MdKm9NlJrH/Wm3OecPS6o8lVKPoseUeGQsQ3WVBLCnFvfR?=
 =?us-ascii?Q?ztUSIpHQV7C0xUOv4RhZRR32yWv1Xq52bJuOS39vHipe2fb79qJa3aJL691G?=
 =?us-ascii?Q?2EPOOHZ2ycjWBLZsRoYRDUMX/9WQCCb9dKuC9Q42sQqPoc6F27bpeJpDJd/k?=
 =?us-ascii?Q?KhEQv+/7VDIMTtKwru51NiSXx0FzsPDWqhhhyL4Fy8+ztJ7Yh1oGP+0YDJCH?=
 =?us-ascii?Q?BNu0Au9RyU7YX7htAd2tS1XuOKtLDs8/iHpM64Zxeas4YV8qdmxvUGYvzYDz?=
 =?us-ascii?Q?FhZJgmmUZgCcisbs4keaH9412fx982ZbecHM44DKM33ryZKmPrS26FgQIsUi?=
 =?us-ascii?Q?/x1FA/QP94To7lUXVo7+Qc9H+etMe+WBWK8SLU0T67oxZJq62sFwqFmSMPqx?=
 =?us-ascii?Q?tjxNejkKwwdyIJ6f/w+Yb77PkyyRv+0vOfNlrECofUcmffVBwSEkrA74mNFA?=
 =?us-ascii?Q?NvAP43wohRdO8DQ/Y+6cPP1E8cI6YbP1KdUo1Wwc8K90F3q2gN17tyfzOOLe?=
 =?us-ascii?Q?y5lulD2iaOn5SCoCPVTKDdjfKoGnpRHLwJ477wEx45KwNoyZrpEiAN5xPTVI?=
 =?us-ascii?Q?KxFfsT0rTtVzqGsi6CDg7h0c/7l3TpVZfpZd+Js0prKUCi+ID/TSbvqR18p6?=
 =?us-ascii?Q?9MkDnT2nzEtHmSLMhvPS3QVjx0OKTmlY+2DtZQSwCq51MFrjcJMAeUyCXn9a?=
 =?us-ascii?Q?2gZrFDVudFbBw1pK5VB/s2DL6MJ9T9mbtcRK5HT9NW04Bmn8pSjFcntsZgR1?=
 =?us-ascii?Q?/2I1MiKLqbMTUy+F/UPQ0jcDTGyzgOi0X2i4UUT3ecxzDggSG4OTPcV2KImX?=
 =?us-ascii?Q?lkqodU3kNxbtXWxXuyJUaPbGZiyHzGg609XTVbd1ypW+RCRRjzYK2jv68mT2?=
 =?us-ascii?Q?MyvRKRvQPo8D///EzTbqtS5CHdGYOieTcsNBTmgnbXA7ItVP7zhNEj8mMRHW?=
 =?us-ascii?Q?TTZPiQPcZTOQyWduYSOJTAJe+a8UX2DU98qWXgEqM6ijbDKkdL/hdOvl55zn?=
 =?us-ascii?Q?IIn8tLB9beq3vT8F4+jbOVJ6mMnsv26gP7bQdxHVn2u69tEEgl0+H/LpFrtN?=
 =?us-ascii?Q?PPpECeouSthqiChvjlEgHRVeV6n0viuVIvP3Ij3vN78uDS1AO2r7ESJ3PE0N?=
 =?us-ascii?Q?dcCmmZ50enoNpGBmfWttQdo22ac1tT2rfpYM+pv8DoHvflT1mymj1Pd5XRAB?=
 =?us-ascii?Q?sbgcy51zX7n4hDsq/uUK4X/r1n0uTVikc1/kfDoNecRinpKxPfmgi1OeKv1+?=
 =?us-ascii?Q?KjU0xbrMqouBAFkX6iAUWoie91EpPbWAb5/96YRJBvFxoqTKYQFgfDJkv3qr?=
 =?us-ascii?Q?b0/FfOYc9lgWmIidH+Fq9ZZkk4uDkPBHlIKqdirJ+f5jgV0WxN+JcFPfvrFo?=
 =?us-ascii?Q?5ptWgFU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3937.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p0XTQI39+PXG4N+YGhsuRvZfJ6uxMYm9YyWaDxdfoCNyp7fYkZOWvAc7F9Ft?=
 =?us-ascii?Q?P0jKzBqLaZjaRE/qCDeur+kFEGoTk1T68KTbfv3htroXOH5KhIvn8UOmSRTp?=
 =?us-ascii?Q?KnWnE/Q0+jeDgT75d7+tGd3zOQhF+smLnma3RaBpLaYFpUVeV5KJSRGW+orE?=
 =?us-ascii?Q?XUk+LSzmcwg0frDKtK9KJklCYLhWFTR9j00hG7DU1KHkXVuD0EAgirQBYy53?=
 =?us-ascii?Q?1KYI359WvQ/Wa6+vbPwr2ogBj9mSv4Fj04gwaNsO3WrY9SihYv5th4n026r/?=
 =?us-ascii?Q?iSDdjEd4KfpvgDbqUJ7SzLjnUthL7Ay2UbYqqJGd0C1gg7QkiSARJ6/VN2JM?=
 =?us-ascii?Q?DHX2y/S8iCJFMFdn2SzI9epB60LnrmSqDpmTiQ8eqBLLsXK3y1e/V2PeyNPE?=
 =?us-ascii?Q?pgHbX5ls10bk0ZvOyzZobvBFYE046Olm6QlR9QLin9c8vJOUUzNS5ztLuCGt?=
 =?us-ascii?Q?ohTcII4o7j7UYjzVer/bKHFB5Gm21/9/Xpas+qlhI8KkJ1QA0BdHWuSmxzOe?=
 =?us-ascii?Q?6bB99RKkR44UWVgnX04u+3Dg91n4l9zmzp7ccOH1b0d30GvJImzBfeGJZ/eF?=
 =?us-ascii?Q?gC14M0OcGUCqI3R2xXVXQ3laPSig/VHTnrYgAXFhJrPxGAc9d4ofVnVelkXq?=
 =?us-ascii?Q?ey+xRUL//xOm2Y0gNyyEhM8sIXMg+qm4B9p30QxZSSnUSTJWbSmP9Z8JhJTW?=
 =?us-ascii?Q?Vlj9gotkbQY5gSBCGl0w4VUtStw+ubpSH64+wrFoWImy/hLDjALVajMisCS0?=
 =?us-ascii?Q?03iM0MIio/r+UFXY1fnJ750TXg8oDFHlssUbJuIINlm16BfhV5C0KsiUpw1h?=
 =?us-ascii?Q?B28oNufu34c5qCLTFwb97gFScIW0BCv1S+Fj+sMIrvfZfn2TdJArMwR1+qpA?=
 =?us-ascii?Q?Hz3JCR4Hap2wuIvL6tModIbZNQdSZEmJPs0JBHPU/gMcJkmsSlEr1994bwub?=
 =?us-ascii?Q?hBlHkD7lrLT4T19/iFzzx1w4x0pyphdp2Tf0uvoW9TlckW72CZWoNyKSQckT?=
 =?us-ascii?Q?HIJDSo0ALsf4FsciK+8Rnp7Yc055/rj+UaM6orS5wt6rvQnl/eIsAzKTKzpe?=
 =?us-ascii?Q?n3eyTOerYkpQL21sioYlG3vKxKNcka3nvl6qaEVbgKhbe6Omonnt9K7okM3F?=
 =?us-ascii?Q?hF5Kfnt4KAXryesK+PFtk6ltdkie0HTXizC91JRgjlp1JJTlgufJ556uTl27?=
 =?us-ascii?Q?08MY3yv219aJrBmxYJEQzNhstQIdlHC1TyVHs5LRx0uzdB3IxwJHhyyz2YmI?=
 =?us-ascii?Q?svbCUeEz07N51LPaY4SPLiNVMKHMPz8EwdXXIqZaSUWbQIeYb08pz6iIfUzk?=
 =?us-ascii?Q?iQotHuAiQ2MG6kgyr9y4We9K9Jyf+LCh8v7jzIZFxdUR5kqktuecAB1K8sOe?=
 =?us-ascii?Q?24Ww90RR+Ggxc2EZpKc5tqhW37tE4UkoBmgagXdntnlrlSen49ejardPfhuS?=
 =?us-ascii?Q?IgFw9qVVJkUiS+UR/L9gRFsL4TE3CWQU0t0V8SWiXapaVfFXJC4heTnWoB6N?=
 =?us-ascii?Q?L9v419XoM2xKpykmkH/kiWwFrzdMAFgySd4wfS3eOGkzyL0Fl1JIPPPD4SdR?=
 =?us-ascii?Q?1cLieboSN4JfwCSysDQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3937.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd6830e-db67-4113-9ac8-08dcf275d9ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 08:45:16.0400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqsGy4lOB/SBxGcZ2fBIk5JR/4A9pHy8ZS5Oqvy+/HdE5l9WoGZUIppzoGaZGMTpQ10OHFug6nBo02pc+tEcEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10540



> -----Original Message-----
> From: Francesco Dolcini <francesco@dolcini.it>
> Sent: Tuesday, October 22, 2024 3:40 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: Francesco Dolcini <francesco@dolcini.it>; robh@kernel.org;
> krzk+dt@kernel.org; conor+dt@kernel.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> Frank Li <frank.li@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
> devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH] ARM: dts: imx7s: change i2c compatible string =
for
> applying errata ERR007805
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Mon, Oct 21, 2024 at 10:07:23AM +0000, Carlos Song wrote:
> > > From: Francesco Dolcini <francesco@dolcini.it>
> > >
> > > On Mon, Oct 21, 2024 at 11:11:48AM +0800, carlos.song@nxp.com wrote:
> > > > From: Carlos Song <carlos.song@nxp.com>
> > > >
> > > > Compatible string "fsl,imx7d-i2c" is not exited at i2c-imx driver
> > > > compatible string table, at the result, "fsl,imx21-i2c" will be
> > > > matched, but it will cause errata ERR007805 not be applied in fact.
> > > >
> > > > Replace "fsl,imx7d-i2c" by "fsl,imx7s-i2c" compatible string in
> > > > dts file for appling the errata ERR007805.
> > >
> > > Did you considered changing the driver instead? If I understand this
> > > correctly it would be a better solution.
> >
> > This errata fix patch has been applied on i2c-imx.c driver: 39c025721d7=
0 i2c:
> > imx: Implement errata ERR007805 or e7805 bus frequency limit
> >
> > The patch commit log says: this errata is found on all MX7{S,D},
> > MX6{UL{,L,Z},S{,LL,X},S,D,DL,Q,DP,QP} and MX8M{M,N,P,Q}.  So imx7d and
> > imx7s both needs this errata fix. "fsl,imx7s-i2c" was added into
> > compatible string table in the i2c-imx patch, this is the patch diff
> > snap.  So when "fsl,imx7s-i2c" is matched, the arrata fix will be appli=
ed.
>=20
> It is clear what you did. What I wrote is that IMO it's not the correct s=
olution.
>=20
> Kernel and the FDT can be updated indipendently, with the FDT being part =
of the
> firmware, and you should not expect people to update the FDT to fix an er=
rata
> that is implemented in the driver.
>=20
> My suggestion is that the errata should be applied in the driver to both
> compatibles, and such a fix should be backported to stable kernel.
>=20
> Francesco

Hi, Francesco

Thanks! I get it. I will send V2 patch in i2c-imx.c driver to add one compa=
tible string for imx7d
to fix this errata.

Carlos


