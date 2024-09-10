Return-Path: <linux-kernel+bounces-322420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3169728C8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64496B21560
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC22152178;
	Tue, 10 Sep 2024 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FoswfjlL"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9E12E48
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725945105; cv=fail; b=M4/SD9yM5BRGPUa6opDWOfAiNYQ4WkbPQnEIbXTr/Wdqr8ZosCH80fJ+9C17e3IWJA/RSElsspA4RyGe6XiTbDBI+YVOIcXyJeRvvePmwKqVbyP71wTdlkRsiFQlJ4EEiUCHSzieHD1Zfk3TzaBK6oQvtOH0E7exF2f3GIW52b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725945105; c=relaxed/simple;
	bh=HGwhXu76+8AzeAkaceBglWOM4/5RAB1gbP//PtCTuAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RI0mQaYPbjHfSmEdRZTReUe5WzgOxSxdXiI359h9VTxyxOL6uNsK3+8Jz5NpJGcPT84ZrFtiOHHelLsyOJsI+Og4x6A3GBon8lK4ItoAAiSPIk17rGlRKFVQyGsq9RMb2X6fXT87erd9Bk6mLcQ4VSHYir/vmvJYZuBtImQ79TQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FoswfjlL; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l78SCuC7G7A8fK/d/djlGAlYFuoHBjTjfUWKn2fZTpNRCTsQDT5/gnzGXiNBM7fX12ShQRpuP2DE5Pr2XSVCLDEAVbmiHnLyqpm5vVrtsBGrnrNYMTld9KjcDD23cvJUw1K3ncOkaZ+SwTGv3oZLHhNDKCLVACwIOCFgDMZNPVyMVtr8865rXQs376Hbq5x/NkwEN+y81cm7bJu3tY51nsso9+E2mtp5Sjg4W3UNkYgk09ngMn55aZ71zb3Ou+oEJU47HjpoNQ4G1X3Mip2z4sB4WoqqjMM3cUExxVOBbpalpu2CYZimkdxoMmqs8lybA9+S99Q9suju/08NSadd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJFBM+DymDnP1sfGuA1pQyYLacxXBo8yXjmG36Xn+LY=;
 b=v3SmoP81K1UelMuvoPH6+yfqOdWL2kc/0iOnWT1ob5zEZ6jW2+NS5PJ+aJ3n6Sz6vdCqZMgNh4Ke+qgOlaOtSz23WyxZRi0OP0Q4F8moY1Lo0P4OuQ3SnrSMtiTfPaMO6bb/TwVkuCPMUUXRcrU8dhmlHLY4LtcojqRul7xIRNre+6P/WJzcLml3x2fmj2LrzYV1JjvhG7NlAzFEeRd1mnfoA8tIw4AdBMIyyomjyYRKS8cw1s+HtyFtsDjozzglgS6Koy9DaVYlC4eiKU2besk8CWM5pEKQAuOPmdsPHVwONbaa0yagw492kBWPwHhP0fS5SYTVhW5ZnWgOFDLZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJFBM+DymDnP1sfGuA1pQyYLacxXBo8yXjmG36Xn+LY=;
 b=FoswfjlL1Oc8YFyxpsrCS1nFOVoyQCSxTa13yC29bHIdh/5FoUvR0OyKwP2r8lXcbTX8FKY/F5Q2PmgeGzC+4AX7TML/qltf4c0xKATmYGMtEFIlZ52XMbUTcQl3js8AVLLSvWq1BW1rNUf3TenZabU7I22/2q171y3I2/eWQRRBgDrAehoyHyDNrg5p3TpvDoeIJJH2dVKFfjbqAsiZm+kbz12/ahE5Dlro6PGSFw2wYCFzSGO4CKJ2g60ICaSXWhmpoyx+E39JB4a5LK5NRjTtqOKiBfNGdH/Vc1+nXA2+CRMlrWfEhbJHIyW/GARzLtId37zIPKXTtLC18o5SPg==
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com (2603:10a6:10:1a::19)
 by VI1PR04MB7134.eurprd04.prod.outlook.com (2603:10a6:800:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 05:11:38 +0000
Received: from DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::68ea:5937:4fa7:db2b]) by DB7PR04MB5003.eurprd04.prod.outlook.com
 ([fe80::68ea:5937:4fa7:db2b%6]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 05:11:38 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank Li <frank.li@nxp.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"conor.culhane@silvaco.com" <conor.culhane@silvaco.com>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH V4 1/2] i3c: master: support to adjust first broadcast
 address speed
Thread-Topic: [PATCH V4 1/2] i3c: master: support to adjust first broadcast
 address speed
Thread-Index: AQHbAwNoJoaG/PY8KU2Q1n4BtMb/sLJQeOYw
Date: Tue, 10 Sep 2024 05:11:38 +0000
Message-ID:
 <DB7PR04MB5003CB868C835B8A614C863DE89A2@DB7PR04MB5003.eurprd04.prod.outlook.com>
References: <20240905074557.3810026-1-carlos.song@nxp.com>
 <Zt9TcLqi34EDlI6b@lizhi-Precision-Tower-5810>
 <202409092103290fd1d226@mail.local>
 <Zt9vfXwEMaKbqfco@lizhi-Precision-Tower-5810>
In-Reply-To: <Zt9vfXwEMaKbqfco@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5003:EE_|VI1PR04MB7134:EE_
x-ms-office365-filtering-correlation-id: e0db5f98-45d7-43a1-0737-08dcd1570c96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hlxIcMVWfJrOcV5/O5l8J8srRYUwo+6BYC8IAIfunIvvGRYv4/z/tMIJit86?=
 =?us-ascii?Q?u2a/H0+alfIGo/5Oqa/WIAVR2Q6klriGs5TGrF17N38QamgUZtkY4k1blVJ6?=
 =?us-ascii?Q?6Y8RvExbe/ZaYZjMrp78ppPh8XNEjEN139UWUGre53rAC3XAGEMFm0eV+ml/?=
 =?us-ascii?Q?Hi/Vl6yyFXS/PTWFgXa+bqbm9yxKjDubsR7M3XFGR/t8mDoSLr0tMwJ3/o1F?=
 =?us-ascii?Q?rqEozs2U9v/u4mii77ZylMwdOyYtCHKXOIABk84VO+qaBPPyt1WTPfoE5sTD?=
 =?us-ascii?Q?J6C0DwxbY16MA25ayjYGYSjzgnmAYb4LsJ/0mxRyxmTXEiU/qFj7r90Q2xvk?=
 =?us-ascii?Q?9NzGqohMKC0Lj7O5pK3hl0rxZbjytVPgVQVzodF3OQDHqJBLGjnHXdO1TBFA?=
 =?us-ascii?Q?ZKBqmyYMVG7bNgjITymblHrhIgo2s/ThziScaC6eaHC4FjmV0Xt1yU/qRSkI?=
 =?us-ascii?Q?QFUPOZCahdm0GLNVOjWYrKYepfN+DQEyUqiDA5heMFI3ZomVZ6pX8byb/eSQ?=
 =?us-ascii?Q?P7mkFBcL8Ec8GTKdz6HzGHNPh7lj8cBCyer/t1cA+ejVYyemrmVNPgYWh/GT?=
 =?us-ascii?Q?7K9NGhMjUtJikSJil4alMihsaQaGUnpV+bOLYpsgIISG38u2lJyBlPHvyEuq?=
 =?us-ascii?Q?y0323ou0wy8P4i7sHo1mnTsehArCv4R5PS4eoiOKJaHcJSBHpSNCAYJHZRfD?=
 =?us-ascii?Q?dT8Ymgqj5yhrg+l0UwieobIB16IFsPbSaURns7MweYAz5hvMkQobbECZKUU8?=
 =?us-ascii?Q?pVPinkcX1IybAsEr3cV8qqU/HjrWwmvPDW9O6GqU86JVC8EiFllF3h1e4egY?=
 =?us-ascii?Q?YnVo5hHi46YX1oH/NKdUFgw8I2Lak5hE79r+fob3pml14HqF9ENWo1x+Pemu?=
 =?us-ascii?Q?aK8rmiX+yhE1Tk+na6VggJICajkk5aWtEEYMpQUhRgMv+u5LZ+7fWRMap1be?=
 =?us-ascii?Q?R1MkB3h3WTyPPJeqS6nqzC8yHP3sBg0XP03J+r86GBrcN7fgBkPaYRowm1mF?=
 =?us-ascii?Q?pB7MO/zPZGLudzwqqx2auJmfhgmUAcGtiPICD5uY63D3vL5UrnmS/0uOcqic?=
 =?us-ascii?Q?P2bn4gQvil6+OPh30+3G/F4xxOTEpHCbVCDb820RHe6+eJ1bhyv5nOI1Dwnz?=
 =?us-ascii?Q?pkOx6kkvE1XqVv/q+ShFe9GVveRQ4oN+kjdEsHE/PXtxFZi4XZTV6YKd9deG?=
 =?us-ascii?Q?bnfk5jaPs96i9suSpvCD+zzylRuDwBcW+UXf2WuQLTGQzYtHhgr2ZY/VQXVF?=
 =?us-ascii?Q?tapOd4H5Rh5sGT/3hcQ77KUP9OrCUa08mXmgP7EsaUEKkdsNY5y50dykMn/4?=
 =?us-ascii?Q?0qBMlPZFmWXslxNUHLuts6+1FxN5+RO8uWFbHggVsY/ItQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5003.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dHGilWD2IyZzPOb6He3WE/NeODmkDze2sTFr2oYS20WA9cO3yzMCkmSmEHW0?=
 =?us-ascii?Q?XbNsR1kqp6QUZme+qJ6qH3X6B+EBKWJn0S7zU8UDBKD/Bxh8ORrP0HnjfiYb?=
 =?us-ascii?Q?MNGyx1DfvxSH+0d9TgctGKQwwQop/nunio6qMaSl9++Tc8Hmmp0lOyQWD7ZE?=
 =?us-ascii?Q?jDXZ0F5sXs/xH3cqueugiJtrbCpVeU+mB1+1tWkASJAk1Gd2RysyL8xsvpUN?=
 =?us-ascii?Q?G5wqTq3O4937qgclM0IlxSPKf3GnAxmLaYbLNWiy2lqW3636Zns1Yc9S5JFT?=
 =?us-ascii?Q?lUxz/YiPb+wUV6ImBrcDvcJenNB+SbOxbB8goQrHBJTD2qkfDW75HNDhSg16?=
 =?us-ascii?Q?oGG6eC5/6EyThqY+vZ/0M64tvrrzmWb9MJ1eEqjPY7McoYryI9rrq7W5OXMU?=
 =?us-ascii?Q?AUhdx0FbqA0lPFN9c3hvAw1fpsNKOo9K2FHkfnc8BDuneH+A5MJVjx9RvEAl?=
 =?us-ascii?Q?grURiWklsE0EPWyxs4JLeSZ3bIPdbzlShL3MI4xCAsOeSR0h+ojVvZmPIdHQ?=
 =?us-ascii?Q?EP0TWJ8MhP5YKUVZKle+AkDC2yTtKOlgeBYvIq4s8sZsmJVho8Fk1S2CPB96?=
 =?us-ascii?Q?OFlWzikBSbV3NQ5QX50s795Zv6E42i8CHd3oaZx9AFjyeJCKWEDWPrmkLO2N?=
 =?us-ascii?Q?Uxs+IAgb8ChBy6H12BCgDk29WaKe8XMHuvGfSx9gGppcuYoPB90+ncY2E9Ht?=
 =?us-ascii?Q?p1wXyggAVhJusD7ufebgSW8Dd5Cufp1Z0m910uRco0Kv2VJh4mWzTwamtIwS?=
 =?us-ascii?Q?08hGBTs+TihFlwueVvzfAJG5SAvcxqiqNCc18kTmNU7PTS1pxwcjdXrrSd/M?=
 =?us-ascii?Q?fgjdUjaZDt0VOr/1ePJOPzpnu8sHerKKEixx2Ax4v+u7wRyxwjS0UDqUgM/h?=
 =?us-ascii?Q?iNmRuIfgI+h8s3TNDD3b8KYdjyTli94VNlEzJoL/knRd3zG6Sb/NFbUJZ9rA?=
 =?us-ascii?Q?WhT8qUUfzkk66MLmhX2rUN8nsU2Bqz312F5ql3QjJ9jM2FbZLPUAdSwo8Qsr?=
 =?us-ascii?Q?Wdlut4irKjiTbfm/wgZnD8CxmxPedPQuw2VDxdpiOoi3L7hdFa1X3H6f6U/t?=
 =?us-ascii?Q?MGKqAXxw/P52uIqDwVoKTjPyM3ZGSCGVJ8tMBVU9BTjqRslGLpwoxP2YmKa3?=
 =?us-ascii?Q?NR5GfyqOUwf+q+tQfJGhqo9F3FN2dQW5simMjdUilu7dgO5jfwck57RZ+PTB?=
 =?us-ascii?Q?k/i4vi2xx178/uEE0sc6INsvtRBXiVOZeioR2Ioxn4+GdAbTnM2nESSWLEq/?=
 =?us-ascii?Q?y3NVKVt2/PLy3joDTBlMPI2KDypBw+9lIkVu3O8lYrp58VbVzx6tptY7Gu66?=
 =?us-ascii?Q?d856NaLIkLobcAcV8tUZZnxHvRNd8Ig6OY8U4lGOavCnD2TC3k1u7GO1BlQ2?=
 =?us-ascii?Q?zRN7/h7lE+yGsAI025S88AJT0b4xK2fFfiard3EWyGNvxvlP4N6QE85aqDCf?=
 =?us-ascii?Q?vSovY9YcHl5iJzXi3pn4e+6bv4IeVqkA/l6JPDH+uzPLebiaNqAhkQB7w1GR?=
 =?us-ascii?Q?f47Ch9xHIcdQ4C+vlU1gt40jXvcWoOEaO+VmdezftBeMrET3qSUucUAyfaX3?=
 =?us-ascii?Q?hZxoKKCphDQcOYmeuss=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5003.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0db5f98-45d7-43a1-0737-08dcd1570c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 05:11:38.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9qemp2PTW2EqSxsifzFhZucA36JdxhyEz88ux4jozIw/F2+cCHZAvM9Swio6220q75tLCSdZKOb2//G3H7yuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7134



> On Mon, Sep 09, 2024 at 11:03:29PM +0200, Alexandre Belloni wrote:
> > On 09/09/2024 15:58:40-0400, Frank Li wrote:
> > > On Thu, Sep 05, 2024 at 03:45:56PM +0800, Carlos Song wrote:
> > > > According to I3C spec 6.2 Timing Specification, the Open Drain
> > > > High Period of SCL Clock timing for first broadcast address should
> > > > be adjusted to 200ns at least. I3C device working as i2c device
> > > > will see the broadcast to close its Spike Filter then change to
> > > > work at I3C mode. After that I3C open drain SCL high level should b=
e
> adjusted back.
> > > >
> > > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > >
> > > Alexandre Belloni:
> > >
> > > 	I have not seen these in patch work
> > > 	https://patchwork.kernel.org/project/linux-i3c/list/
> > >
> > > 	Any thing wrong. These two patches is critial for some boards.
> > > Could you please take care it?
> >
> > They didn't make it to the list, please subscribe and resend. Also, it
> > is very very difficult to keep track of all the patches you sent s I'm
> > not sure what actually needs to be applied and what has been dropped r
> > superseded.
>=20
> Sorry for that. Only one big patches set (about hotjoin fix) and update m=
aintaner
> are directly sent from me.
>=20
> There are 3 patches from carlos.
> one patch already in patchwork
> https://patchwork.kernel.org/project/linux-i3c/patch/20240719080233.84277=
1
> -1-carlos.song@nxp.com/
> the other two patches is what's talking about in this email.
>=20

[Carlos]:
Hi,
I have subscribe to linux-i3c@lists.infradead.org. Then resend these 2 patc=
hes V5.

Sorry for confusing!

Thank you very much.

> Anther one from Ravindra can be dropped.
>=20
> I am not sure how I can help this because there are difference contributo=
r.
>=20
> Frank
>=20
> >
> > >
> > > best regards
> > > Frank Li
> > >
> > > > ---
> > > > Change for V4:
> > > > - No change. Send this patch with svc-i3c-master.c fix patch.
> > > > Change for V3:
> > > > - Modify comments from Miquel's suggestion Chnage for V2:
> > > > - Fix set_speed description from Frank's comment
> > > > ---
> > > >  drivers/i3c/master.c       | 12 ++++++++++++
> > > >  include/linux/i3c/master.h | 16 ++++++++++++++++
> > > >  2 files changed, 28 insertions(+)
> > > >
> > > > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c index
> > > > 7028f03c2c42..6f3eb710a75d 100644
> > > > --- a/drivers/i3c/master.c
> > > > +++ b/drivers/i3c/master.c
> > > > @@ -1868,6 +1868,12 @@ static int i3c_master_bus_init(struct
> i3c_master_controller *master)
> > > >  		goto err_bus_cleanup;
> > > >  	}
> > > >
> > > > +	if (master->ops->set_speed) {
> > > > +		ret =3D master->ops->set_speed(master,
> I3C_OPEN_DRAIN_SLOW_SPEED);
> > > > +		if (ret)
> > > > +			goto err_bus_cleanup;
> > > > +	}
> > > > +
> > > >  	/*
> > > >  	 * Reset all dynamic address that may have been assigned before
> > > >  	 * (assigned by the bootloader for example).
> > > > @@ -1876,6 +1882,12 @@ static int i3c_master_bus_init(struct
> i3c_master_controller *master)
> > > >  	if (ret && ret !=3D I3C_ERROR_M2)
> > > >  		goto err_bus_cleanup;
> > > >
> > > > +	if (master->ops->set_speed) {
> > > > +		master->ops->set_speed(master,
> I3C_OPEN_DRAIN_NORMAL_SPEED);
> > > > +		if (ret)
> > > > +			goto err_bus_cleanup;
> > > > +	}
> > > > +
> > > >  	/* Disable all slave events before starting DAA. */
> > > >  	ret =3D i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
> > > >  				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
> diff --git
> > > > a/include/linux/i3c/master.h b/include/linux/i3c/master.h index
> > > > 074f632868d9..2a1ed05d5782 100644
> > > > --- a/include/linux/i3c/master.h
> > > > +++ b/include/linux/i3c/master.h
> > > > @@ -277,6 +277,20 @@ enum i3c_bus_mode {
> > > >  	I3C_BUS_MODE_MIXED_SLOW,
> > > >  };
> > > >
> > > > +/**
> > > > + * enum i3c_open_drain_speed - I3C open-drain speed
> > > > + * @I3C_OPEN_DRAIN_SLOW_SPEED: Slow open-drain speed for sending
> the first
> > > > + *				broadcast address. The first broadcast address at this
> speed
> > > > + *				will be visible to all devices on the I3C bus. I3C devices
> > > > + *				working in I2C mode will turn off their spike filter when
> > > > + *				switching into I3C mode.
> > > > + * @I3C_OPEN_DRAIN_NORMAL_SPEED: Normal open-drain speed in
> I3C bus mode.
> > > > + */
> > > > +enum i3c_open_drain_speed {
> > > > +	I3C_OPEN_DRAIN_SLOW_SPEED,
> > > > +	I3C_OPEN_DRAIN_NORMAL_SPEED,
> > > > +};
> > > > +
> > > >  /**
> > > >   * enum i3c_addr_slot_status - I3C address slot status
> > > >   * @I3C_ADDR_SLOT_FREE: address is free @@ -436,6 +450,7 @@
> > > > struct i3c_bus {
> > > >   *		      NULL.
> > > >   * @enable_hotjoin: enable hot join event detect.
> > > >   * @disable_hotjoin: disable hot join event detect.
> > > > + * @set_speed: adjust I3C open drain mode timing.
> > > >   */
> > > >  struct i3c_master_controller_ops {
> > > >  	int (*bus_init)(struct i3c_master_controller *master); @@ -464,6
> > > > +479,7 @@ struct i3c_master_controller_ops {
> > > >  				 struct i3c_ibi_slot *slot);
> > > >  	int (*enable_hotjoin)(struct i3c_master_controller *master);
> > > >  	int (*disable_hotjoin)(struct i3c_master_controller *master);
> > > > +	int (*set_speed)(struct i3c_master_controller *master, enum
> > > > +i3c_open_drain_speed speed);
> > > >  };
> > > >
> > > >  /**
> > > > --
> > > > 2.34.1
> > > >
> >
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin Embedded Linux and Kernel
> > engineering https://bootlin.com

