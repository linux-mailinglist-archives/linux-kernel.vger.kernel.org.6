Return-Path: <linux-kernel+bounces-427763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182E09E0630
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DB9162519
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1A20ADCA;
	Mon,  2 Dec 2024 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WBejcPSR"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010047.outbound.protection.outlook.com [52.101.229.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8568204F82;
	Mon,  2 Dec 2024 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150392; cv=fail; b=n6nQ59ozmI7zqBIQ+2cDQWfiGlH06rFaQOl0yPyvQUEi67ZrgLkKKXKjlBuy+J9oU1YQkP3gqKTpvmWGyQTn16JEsCC/vA+uhzrPI5+L/NtM0RztWJ+zGHnRErRSf5S+L4U+t4OQybtCA3iez+JliHxh6DAA04/rAkme7w7Ko2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150392; c=relaxed/simple;
	bh=i8JIpBVvPNXbtiYWkobSeONVVmhd1flLZSLNQDgZeos=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YxWt3K35bH6ZlGtjBDtLNt5KnSDu03d22bNEfXoJWtytwPPFAtzUQ0K8+uGR+t6udRzoI/jr3taL7/8PnN86yaKhYCX1qabm0iW/bxd7zCttlOqYFGsYRthtfLE0fHuc6kVMDdV+/gsBzNrl6pB20HhzfKWDoSc59ckSPnyN1z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WBejcPSR; arc=fail smtp.client-ip=52.101.229.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhdqpCBwuzDsbJnecFTtxCfsk0q0/TmA7f6eMEBxuEPplgJYP3fT+2dz70psbi6fJcKRs+PIl7KkKNeo25ul+67R96ePQepGd0Q3ttS3vy0iI8lgKDmxJgAi10bjzWDYWJiMCycH356yFQZUFBY8rXs/LZws6+SrXraVdlCy3bQXBz6N2nlqn6uyik7ApUcT0Jhk0XDMMbQCtR+aDOCu8CpFFjheo60vPYqxcTl9kmfCSomp5oMroDFEEuQf0td0C1i6yaB5VovD2liJ4NEQJCf00AwF8r/Sw991t9obwBloafE7P6sk32mPqeZ5lr9s3QRm7BBn0Dcl/Eru22Gv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zt00srLm3t6P4Moq9yNT5b1n7kwW7WTXZezB4Tw+9rQ=;
 b=RrsgfqjKggLkP/Kn1gw1kWG9OEGwK9l2XzX9nlk9b0gthdTBd82cwDVNpP8+gs9DTOy6nUVKxgbSAQ44BA0U89rAJa6dHy7HTyHuq+x0110JmXNOXT6odGEyx1D95RAEhk9+1DHhpPWG+wGLeSQNk/1hvw25VWW2TO69gf/guTOVoY15ES4gZ+7yFpIpy1oYwa76Mooa0nz8JmqmzM9JCq/SwvRAu826FtPnh8iqOzKTjU2Ke5V7j2bxtAOfXrZ+8ZsKu55j7zCT897dK2Iweo7Ubj7LNNv0MIa8smjIbvY6XMRVDsZutHJU50S5yoDKbc++ndzy7P/xdf4Uv58xkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zt00srLm3t6P4Moq9yNT5b1n7kwW7WTXZezB4Tw+9rQ=;
 b=WBejcPSRO3XtVoCbTOqzxGjikDH5bigoc5Ts3V0PKhWLJldKS//u7kNyUgJtjOUwdBpFnuOXbjnWCOmGf82AbzD1gwua7oAMi6p+pTKUZj4488lE2bDbQ99pd58c3RauTikjxPsBSkASZtK9UrApf9UFOpFQQV/bWK89oT/leN0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY3PR01MB11875.jpnprd01.prod.outlook.com (2603:1096:400:40c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 14:39:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 14:39:39 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Facklam=2C_Oliv=E9r?= <oliver.facklam@zuehlke.com>
CC: Biju Das <biju.das@bp.renesas.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "von Heyl, Benedict"
	<benedict.vonheyl@zuehlke.com>, =?iso-8859-1?Q?F=F6rst=2C_Mathis?=
	<mathis.foerst@zuehlke.com>, "Glettig, Michael"
	<Michael.Glettig@zuehlke.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Topic: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Index:
 AQHbNmuSilIo7RjEfU+qZS7GfgvaKrK88xQAgAAkloCACsT7AIAC/AuAgAALKlCACDv6gIAAAktA
Date: Mon, 2 Dec 2024 14:39:39 +0000
Message-ID:
 <TY3PR01MB1134679FB8FFB248F8FDF214586352@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References:
 <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
 <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>
 <Zzsp2JOhnnPPOWvB@kuha.fi.intel.com>
 <ZR1P278MB10224924F48419CA813402309F272@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
 <Z0RRQoRN7721FF-Z@kuha.fi.intel.com>
 <ZR1P278MB1022EC72C26F483A416DB1979F282@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
 <TY3PR01MB1134648B9A537D826754AFB0486282@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <ZR1P278MB1022A148E41AECEC8718DBD39F352@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To:
 <ZR1P278MB1022A148E41AECEC8718DBD39F352@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY3PR01MB11875:EE_
x-ms-office365-filtering-correlation-id: 887ce538-f1d7-4cb6-f06b-08dd12df2700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?mlKWoPtjYGclvVmPCd1S7O3R4wr/Ya2gi+e+rlGvZ0vY+NnUb+hTT/40iY?=
 =?iso-8859-1?Q?U2nwegS+dlg4TFLZgsb47be1AGGkiSYrTrKcNP7I5lIgeAzZIfRfTUpK8U?=
 =?iso-8859-1?Q?0q4Tx0lVprHWYReKzQ4ElGzppu7GwfAYNitLknhOvH7Xp+xzLfjLmDzykl?=
 =?iso-8859-1?Q?WH5NGOIOy4pnOA2Do/hu+RM4HISf5kNV0vPdy9hzN1eL6wQ25XMsP1GHOP?=
 =?iso-8859-1?Q?YdMZS7PNx3+hf9Acxb5HXP9OpWU+l0kaBvwIq1Xj55e9UslzZ+i+hC/Kc4?=
 =?iso-8859-1?Q?xsohuAWXMA5MX3+c9Ay4ghyXNxkLNsaSp1I2sOqjlIjQbEp7LzOiK39ThN?=
 =?iso-8859-1?Q?l8LnkyegIlfpgbGCdFBhkn3Hm/ZEo5CqXI4brMJPt3eamQYNkC2mw5RJwz?=
 =?iso-8859-1?Q?qvWtiwcIRG6raA8YvIp82yWl+6EZWtu2e4vjk1e66d0yxCGJ8eRvSwFvYM?=
 =?iso-8859-1?Q?noccb7nDgj1NhfquKj9RSZN5aQVERtdzrAk5VcKMX9IVwgHc/Bn2O1/mSR?=
 =?iso-8859-1?Q?j/8p33XJ95ISqmqjPJEoHcAGxqR3TgX0EYkYpjD0uKEe+qWmcLXGNnKb9W?=
 =?iso-8859-1?Q?BM0X+rYKM/kT+MSdG7QV4J8zM8ouxQgsZOwMSbyCw48CYAQo4zrxxVYq5n?=
 =?iso-8859-1?Q?pb86t4A948JiP1SQ2zGayn2oPBDMnu78xyB0g/CByYBhn+nKU7i6vk069S?=
 =?iso-8859-1?Q?+FYQrFWfK+LL7NY2DFuwcacjitXqvg67DlaZNiGOpa06cC7jooG7aPxcFO?=
 =?iso-8859-1?Q?Z5iw4/o7W6Q5PgYHm4JOwUIfEELVpAhCsgi9xxw2jlN5Sm6i8J2OA+D8b1?=
 =?iso-8859-1?Q?szDTSkYH0+wOWMmWktTjU/kegzDWCDCYgmD7TplcwCwmGQSyNEuxHvR9+s?=
 =?iso-8859-1?Q?kj4COAj9NGJSlhsIMmBzehN4FU4ahZzgymEDGdlBgVxT1td6qKgF5ldd9Y?=
 =?iso-8859-1?Q?VT70ekUpvacJIrZNWYfm1gyj88VeU4fskNlquXrj0CVkr9iTVLoNHDquGw?=
 =?iso-8859-1?Q?RIT1MjeKg4uY+xSPlthJps0XoTgyI7dOa7pPKwBeblJohmpSL5oRrkGfq+?=
 =?iso-8859-1?Q?tGNB5H52Ve1looQuOJ5+2c8hyCOaqkp680A8S5L15oSwqs22TkwKhZ0+4X?=
 =?iso-8859-1?Q?QtNnGIaMfRo4tKZsckKj7Jv02iIlGm1LskwP7DnMlPsr3c0faxx56ZI0ym?=
 =?iso-8859-1?Q?U3pK3db+WfGTiuOa2xv61kRptE218kHbXwJsB/DJ17m5pLZJZod/g20D5L?=
 =?iso-8859-1?Q?TSZFbCjaWg0wkwyuJw/PyKdNKknYF7Ezy2cteDl+xQsjhcN8t8eMzOzMSs?=
 =?iso-8859-1?Q?bz3OgxvlY4yypYPCSJ/GxflnczZMs83JVJeP8xpFYzWlM+ARDL50/ui7us?=
 =?iso-8859-1?Q?C7cdmMNfIyspGDYFuR7P0bLqZ30gi5ItLFSYVDYyaKOmnlWNGrAZA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4fTAxVf3RNjBaIiqCuJtFUSN6bzgkGjw+RG5bns4cVViXQ1FYVyqmK4m53?=
 =?iso-8859-1?Q?vnoGGG8TIi7FO/ap7Pw67zqIlDnnGFCxBGG7JxZU7nAa9VLEJgawYvFCQX?=
 =?iso-8859-1?Q?Rx5qVa/oAYafAh58u/dO8glusorV/Prg+SBqNUKTyE1Ysu5KrHq/XnpSOr?=
 =?iso-8859-1?Q?VdEKkTrRC0VDnOy2EnqWC8SLlHj6JyEn7L3USRiCJVc++ePA72rhBQSq4G?=
 =?iso-8859-1?Q?7UXMck7ZItmSr8IAWDF59Q8Efw8OGuSaifEA8FADN51N+S22UlmO/YBd+x?=
 =?iso-8859-1?Q?otjr+t2PP+1zFfJsKxjiJPWPLEur+zX9L51zSvwTIGUz+angdzIssRAUhk?=
 =?iso-8859-1?Q?n6fO3e4ThUlLr75Ld5HWdyYh2uzXn0dCix7hlm/jAKJQH3aa4jtiBQ5don?=
 =?iso-8859-1?Q?yNnLeVNRUK0ejarO6ng1Aq8uFpduE9H5mESjBsCaZ5CIIGvQJRcimMSutA?=
 =?iso-8859-1?Q?nEtcWOyWla6/vvueWYJe0T7QAzkJkrXFkJnu222xjrCiTo76WPooUe59AW?=
 =?iso-8859-1?Q?J16EfIipzjSj5JcxkomB4FqsSHTh/Dqqpd9/NXu59tJtKeqyvKdU5ptv9R?=
 =?iso-8859-1?Q?ymtRWYCJEacQObWiQobcxX74Z7pS/6ZVhB7C65+GfoUUCpSugXVwFsw/C3?=
 =?iso-8859-1?Q?uPGLNDH896Z1lfyHZxCME3qOqvKeVHM/SHxsqWm+pA56C8dqlf9H2KrZZx?=
 =?iso-8859-1?Q?ICh1Dixi6Z2P9H9PRgjVh5Bqlqqp3wCa0l9kpBlkUqK2ZX7kMGlxL2a28C?=
 =?iso-8859-1?Q?i6MLQvooBRYqeNXjxPQawvTwbKJ6pU85wFLM6oc7HYrvKegfZ2OX6EQ6j7?=
 =?iso-8859-1?Q?3n5j1Vs2Awqb9Jlt4kdeS2LoDlPX5wJKSzo+u4tAw84S4/9XpjZmbIiqIN?=
 =?iso-8859-1?Q?2+AX0W9b3CXTmnRps1qkkXPwCqSUu8rK/aqkB1KVUDQGlPZYdiv93D3cXb?=
 =?iso-8859-1?Q?DT9q0N1pdLeU+VoAQ0RG2qudhm0lP/RusAU1DEOkVuK6H0Qb/BK7oYULEC?=
 =?iso-8859-1?Q?N1GwLgLIOEFyBOo/OGhpg2sRCdMKlNknVTU7R0gxNW0n8H2Ve/NS3vfCDa?=
 =?iso-8859-1?Q?cLx1F//fPEUPIwRyC2nw9uv+i5LJ/SJ+EYWbkIn9SwpmnK/y6ghbEMTvim?=
 =?iso-8859-1?Q?3kzjR3JYDZ8AH4cFyFDn3bosTk9Vq/fNCsESEGKNa6T7p0liJ70y5WMNm2?=
 =?iso-8859-1?Q?TRrpDVJMJMkU+TJIEO1iwdqZqTo0UUcmmCMQ+WglMApG5cFLk5dcSdTPoW?=
 =?iso-8859-1?Q?Nyz6oQjYUXva3z18U5sIw/zqC3gR30uoAzZxNhxw27FY4JYdcSoWJqQ+ji?=
 =?iso-8859-1?Q?Rsr/Zmk6x/trNl8Zpz0i56WfMN8PVGsWaxTQ+QrgNAwmV4yzSdLa3069pV?=
 =?iso-8859-1?Q?NHHrOV1apXQp+GnQ2tROnRs1g3/QgTdIt4nL3HnBvHnEsy0L/8sl1TfK5/?=
 =?iso-8859-1?Q?+H5rhSEQ6QhFVWXtR6ranAiy3cR0uu6QXPAABh/Aol07A256FxVPguO5mR?=
 =?iso-8859-1?Q?rW8CSmpQ/Il+xoGPJjz6ZRk4drVu7+/xkpb8kW0ivrYiXJABZRNxA6z610?=
 =?iso-8859-1?Q?KMvMgVD5545U0yNokHJOG6gm7DFH6Zv5Vr8yk8ljPXMfIvqK3K2b2iA5t8?=
 =?iso-8859-1?Q?M/MnpkqBbghjcAUUyx9YUipVG1hKvIPLHnC9MRIvVCJ3g2DMwFxA4UQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887ce538-f1d7-4cb6-f06b-08dd12df2700
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 14:39:39.7715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bHnA4Fn4Ymaa+h8RulpdrHuMzzlQOf2ufTOpJSAs1m/JInz9j4RsDh1iZAK9+vNWRBlQbkqCtnWa+USyYvLD0b/WA6WuaGkPrDEw310b2k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11875

Hi Facklam, Oliv=E9r,

> -----Original Message-----
> From: Facklam, Oliv=E9r <oliver.facklam@zuehlke.com>
> Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring po=
rt type
>=20
> Hello Biju,
>=20
> Thanks for your response and sorry for the delay.
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Wednesday, November 27, 2024 9:48 AM
> > Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring
> > port type
> >
> > Hi Facklam, Oliv=E9r,
> >
> > > -----Original Message-----
> > > From: Facklam, Oliv=E9r <oliver.facklam@zuehlke.com>
> > > Sent: 27 November 2024 08:03
> > > Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support
> > > configuring port type
> > >
> > > Hi Heikki,
> > >
> > > > -----Original Message-----
> > > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Sent: Monday, November 25, 2024 11:28 AM
> > > >
> > > > Hi Oliv=E9r,
> > > >
> > > > Sorry to keep you waiting.
> > > >
> > > > On Mon, Nov 18, 2024 at 02:00:41PM +0000, Facklam, Oliv=E9r wrote:
> > > > > Hello Heikki,
> > > > >
> > > > > Thanks for reviewing.
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > > Sent: Monday, November 18, 2024 12:50 PM
> > > > > >
> > > > > > Hi Oliver,
> > > > > >
> > > > > > I'm sorry, I noticed a problem with this...
> > > > > >
> > > > > > On Thu, Nov 14, 2024 at 09:02:08AM +0100, Oliver Facklam wrote:
> > > > > > > The TI HD3SS3220 Type-C controller supports configuring the
> > > > > > > port type it will operate as through the MODE_SELECT field
> > > > > > > of the General Control Register.
> > > > > > >
> > > > > > > Configure the port type based on the fwnode property "power-r=
ole"
> > > > > > > during probe, and through the port_type_set typec_operation.
> > > > > > >
> > > > > > > The MODE_SELECT field can only be changed when the
> > > > > > > controller is in unattached state, so follow the sequence
> > > > > > > recommended by the datasheet
> > > > > > to:
> > > > > > > 1. disable termination on CC pins to disable the controller 2=
.
> > > > > > > change the mode 3. re-enable termination
> > > > > > >
> > > > > > > This will effectively cause a connected device to disconnect
> > > > > > > for the duration of the mode change.
> > > > > >
> > > > > > > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > > > > > > ---
> > > > > > >  drivers/usb/typec/hd3ss3220.c | 66
> > > > > > ++++++++++++++++++++++++++++++++++++++++++-
> > > > > > >  1 file changed, 65 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/usb/typec/hd3ss3220.c
> > > > > > b/drivers/usb/typec/hd3ss3220.c
> > > > > > > index
> > > > > >
> > > >
> > e581272bb47de95dee8363a5491f543354fcbbf8..e3e9b1597e3b09b82f0726a
> > > > > > 01f311fb60b4284da 100644
> > > > > > > --- a/drivers/usb/typec/hd3ss3220.c
> > > > > > > +++ b/drivers/usb/typec/hd3ss3220.c
> > > > > [...]
> > > > > > > @@ -131,8 +183,16 @@ static int hd3ss3220_dr_set(struct
> > > > > > > typec_port
> > > > > > *port, enum typec_data_role role)
> > > > > > >       return ret;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int hd3ss3220_port_type_set(struct typec_port *port,
> > > > > > > +enum
> > > > > > typec_port_type type)
> > > > > > > +{
> > > > > > > +     struct hd3ss3220 *hd3ss3220 =3D typec_get_drvdata(port)=
;
> > > > > > > +
> > > > > > > +     return hd3ss3220_set_port_type(hd3ss3220, type); }
> > > >
> > > > > > >  static const struct typec_operations hd3ss3220_ops =3D {
> > > > > > > -     .dr_set =3D hd3ss3220_dr_set
> > > > > > > +     .dr_set =3D hd3ss3220_dr_set,
> > > > > > > +     .port_type_set =3D hd3ss3220_port_type_set,
> > > > > > >  };
> > > > > >
> > > > > > So here I think you should implement the pr_set callback instea=
d.
> > > > >
> > > > > I can do that, but based on the MODE_SELECT register
> > > > > description, it seems to me that this setting is fundamentally
> > > > > changing the operation mode of the chip, i.e. the state machine
> > > > > that is being run for initial
> > > > connection.
> > > > > So there would have to be a way of "resetting" it to be a
> > > > > dual-role port again, which the "pr_set" callback doesn't seem to=
 have?
> > > > >   This register can be written to set the HD3SS3220 mode
> > > > >   operation. The ADDR pin must be set to I2C mode. If the default
> > > > >   is maintained, HD3SS3220 shall operate according to the PORT
> > > > >   pin levels and modes. The MODE_SELECT can only be
> > > > >   changed when in the unattached state.
> > > > >   00 - DRP mode (start from unattached.SNK) (default)
> > > > >   01 - UFP mode (unattached.SNK)
> > > > >   10 - DFP mode (unattached.SRC)
> > > > >   11 - DRP mode (start from unattached.SNK)
> > > >
> > > > Okay, I see. This is not a case for pr_set.
> > > >
> > > > I'm still confused about the use case here. It seems you are not
> > > > interested in role swapping after all, so why would you need this
> > > > functionality to be exposed to the user space?
> > > >
> > > > I'm sorry if I've missed something.
> > > >
> > > > About the port_type attribute file itself. I would feel more
> > > > comfortable with it if it was allowed to be written only when
> > > > there is nothing connected to the port. At the very least, I think
> > > > it should be documented better so what it's really meant for would
> > > > be more
> > clear to everybody.
> > >
> > > After researching some more about this operation, I came across the
> > > driver for TUSB320 [1] which seems to have a very similar behavior
> > > (also
> > from TI).
> > > [1] - https://lore.kernel.org/all/20220730180500.152004-1-
> > > marex@denx.de/T/#ma7a322bc207414e4185c29d257ff30f5769f5d70
> > >
> > > For one variant of the chip, the implementation relies on the CC
> > > disabling like in this patch. A different variant tests the current
> > > connection
> > status before proceeding.
> > >
> >
> >
> > Can you please provide your test logs?
>=20
> Adding them below.
>=20
> >
> > Previously I tested 2 devices with
> > Switching roles host->device->host using
> >
> > echo device > /sys/class/typec/port0/data_role
> >
> > and
> >
> > echo host > /sys/class/typec/port0/data_role
>=20
> Could you clarify what your test setup was?
> Did you control both sides of the USB connection and execute these comman=
ds on both sides?


Yes, Two Renesas RZ/G3E boards connected each other by usb type-c cable and=
 execute these commands on both sides.

1)Host->device->Host  (First board)
2)Device->Host->device (Second board)


Cheers,
Biju

