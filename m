Return-Path: <linux-kernel+bounces-237121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E305F91EBB0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70EB51F227B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E41523D;
	Tue,  2 Jul 2024 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CU+QxNCz"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D734C8B;
	Tue,  2 Jul 2024 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719878536; cv=fail; b=SKGOaKCfWRJ8kDgBOvnOdSTpQTO6Lv8cK/Ztekv4m/zsbCiA9syvSaK20Xoo8dVGqx94+8csa3NJI1vRzSKvQ9RGfPeiIzddlYrTgS5hcKNgjMh6h+G7DGBInoe+8SlKYRxy/m7A+LU3KMq8vKQ55I4zFmbeAXh2N9qPi1u95qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719878536; c=relaxed/simple;
	bh=wSIU/6dqblkACxLnRvzfKvvI2Fc6Dn8ih/8ORZGHu/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ze+RT/nVgT7owRS9hSBkGIRwFZW2EsrmJlWkvdYmnvemahM20lsyaCz103nJWnlNmZAmrtAiWF5ULMANoWNcTK0EkwrnwIkQyRUrVrsyTkSFL5ogKG5Q+592mHJXcGdcTH/OYvBSFcF4/+yT1GBNFjSnk07tb16YzHEnDkPlIUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CU+QxNCz; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTW+OdYJ/ltukmtcx7+wMDrCnqY2A47MIxEWfrgYFXjYYLkNDyc9sTt5UmBUlkkNIGtMQb1yQBvmBE/djqYf0nfmEFdgvn8pF1kuhrIH6Pqsfm7gVzRnCb7ZgrUIDJ0UOK4QlHbnL3x0jsffgSwnZaNnZcExs7oMy0fjsQPZXpOwa8eOve5hLjVdDF1HRdnPBJ3ycFYsQ21XI9zZo+LQgUqZMWXshKwxZARuV+m308zcYHBJ2q8We8IMpCOXGftJUXtAPYmlIoaK1+7hpi8AMeB+nnmUCu2B4br7m5JP8HRR0zd0MxTNmwD89x3sHqDeGDgdDkNUXVyvZyo4wglNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3IplXdszZj+IzHNbFy8+tydP155w8Rh2z4JIIrGi1o=;
 b=SnHcRqAOfwf6uE49mgNrG7ohYrycXqaUbhDunHDE/fUY+T7HY5Nc8q5cPcGNXH4a5n9RSVbPK1Vl9wMGaNo/IO2wBnJ+ZOl8IJBHsylDq38iBBCYK1q9A7vJjUOFogVT21/79oj4dUyE6jPpVpS0fJSUjyhVw1WO1o4gtDiBO2RNzNyiV45x9wnBjzyoWdG3xs0DAEk0viblZZQ57aBjvCikjGvIE+8du/I70BJU2gDKhVOlLYFPCqkWvMl8r01eOU4Syaq97q7sibQUk8PHNP/CCGS1u7lvE13pqJQGFIBACtpVIYpeFpyG6kYIv6FTEHDXiDUBl8rflpMYouST2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3IplXdszZj+IzHNbFy8+tydP155w8Rh2z4JIIrGi1o=;
 b=CU+QxNCzolMsBMxuAFnHDf/pT4C7ecsopEQrAG1wVGxoVffDwgNY0da5HKIR4IXGUMM9dOQKjowF2LmOSHwEX0ZCrVFuBoV01w36syzfKmXDg/chteXDPrJoyqrKPgK5f7FufBCTdk+4VLQcy5MT9s8F2p0WPo7cuVwXQC4mLQQ=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Tue, 2 Jul
 2024 00:02:12 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 00:02:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] arm64: dts: imx95-19x19-evk: Add audio related nodes
Thread-Topic: [PATCH 3/7] arm64: dts: imx95-19x19-evk: Add audio related nodes
Thread-Index: AQHayN14VGZNcpI1iU2oSBWPCVBY67HcSzYggAW+gQCAAIqH8A==
Date: Tue, 2 Jul 2024 00:02:12 +0000
Message-ID:
 <AM6PR04MB5941835C8FC15609AC00D29F88DC2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
 <20240627220001.692875-3-Frank.Li@nxp.com>
 <AM6PR04MB5941C1138E4F33AA3FA49AA388D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <ZoLPJPR8r1+XaRAB@lizhi-Precision-Tower-5810>
In-Reply-To: <ZoLPJPR8r1+XaRAB@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DB9PR04MB8364:EE_
x-ms-office365-filtering-correlation-id: 7eb9556a-5095-4b80-2a3e-08dc9a2a397e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?j4SUnOcordIjT/yyMxiF1KdFS+o89wG2rOSbjlUnlPaAHPrOSX8G0SPphCxN?=
 =?us-ascii?Q?MhnMwwpaZU8a7QfvLByXdnWV5WZuIsYzgmSEO+aK2mni5H7hsTWXEseOWTRy?=
 =?us-ascii?Q?gc4hD0IWx8xYcDVVikTFKaWAMIJhw+Q1vieCY7EHMSmXdFPbGtX+k0gEOqM5?=
 =?us-ascii?Q?BHHXXcmizJAMc3mZroCZsPEyKqUDO4mbwe62LIkf7eFY6g+6UrM1sAZrNoOP?=
 =?us-ascii?Q?pAlsl3zk7QL0fplsfdy1xMYLyYbwvvJpAS+RiDZNJmwcDSfpAVzW13XtQK0p?=
 =?us-ascii?Q?SYYnNaykK7e1L14CfdvieqjI5pQnwPZ4Hsy3n9fI0KX0jBlQE4eP4zgRXvuX?=
 =?us-ascii?Q?Xp452HpPtWO3Lo8n/THhDv2y55tGpLIzqhZMEDyK603v/fkZ/i2XnRrsduWh?=
 =?us-ascii?Q?lXZsJoDsJ4goPmKO/DhmR39fnnpzsbyJ+YFO5MgimrhSnhDJAnQ74DwKvTyW?=
 =?us-ascii?Q?Dn3RNnZp1XYTUx7/FQtc0IJulDlRipqCqeJJIrn1S21YEYd/yqaV/m1zXaeX?=
 =?us-ascii?Q?4qlQSGPfMGko44cEPHBchPA4EqG2dK2hulFYVc7OlTuhh0Q3M02xWhKtwg3d?=
 =?us-ascii?Q?mn8vjnBLQQiQDyzCPRguZSGaQ72DaJZhZV9L7mlY+o7TbUNRGAs71kx/QCpm?=
 =?us-ascii?Q?7K0OB2L/DNVQQd35S9r9jd052cWAjVSsOjS0dQeF8cLIT1/QKT+2ED/2SPSQ?=
 =?us-ascii?Q?FG1FJ1Zqos5W4xBPDNuIT2R5NOVQZu5fP2h0u+hCygkxMPsMhdHtWJJpgEpz?=
 =?us-ascii?Q?TSY4iREUAqqZpI1ASSxPZMonv8tCnhlHiHFd7CE19ThrWaArL5KKtuqeO+b9?=
 =?us-ascii?Q?LJM7hXg/FVCBrE4IU5hi25bcmXYfn2cmc0ESIuEDXAbXys4vs/Wd+BRxpGUS?=
 =?us-ascii?Q?Fu7wSXZBl4WI5maKJVTX+haJJTmktIwyk1AoJ10To/66xKMYTTGx05RyFer7?=
 =?us-ascii?Q?9S+f7iGzXkh1U1jMQcHphpLiXmbhiLFvgFj6c6k2uPv8L46ojKZrhQDZXeGF?=
 =?us-ascii?Q?UuoZiGU9ETfF/EYv3aH2D95WdDeqegvN1CgvEFfk+89Ps19yvBE2BuuFPvJ0?=
 =?us-ascii?Q?6WEyaumiHYcPYryag0xlj8joY3bWWINfa9/sQrm9YLEyV7hu8QnLss6J8x//?=
 =?us-ascii?Q?+P9MNpIz5NyFNTMJz99tyMjEpwYPNpFqY6aYd+Jb0iZXcC6/5jlCy8HN2dOr?=
 =?us-ascii?Q?qJWnXe4G/Ujy9o35TXU9ODAKW4SPFeJOXv+o46e1C1by3bBLJSlG3OCeLTPN?=
 =?us-ascii?Q?JwIlUWFKuqLS0mJvnLVpohRNNgkcROQdV/1BxzpP9PPSANR5/ImpydM4fuu1?=
 =?us-ascii?Q?tjk3SqMyB3dnAv2HZfr/29ChxCqXQWNb6dMnYd+rg88ouQZGwmu+zF88pXJ6?=
 =?us-ascii?Q?mdykoTW8cWhSywFnoPzDRl4O5mouwyS8ObQy7lFbPu4hBEfgTQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EPHjEsCPaJ8o+h2e+xY91r7p71Y8aHDDAUdN2An4Ju6662mKqSkYzsxY4Biz?=
 =?us-ascii?Q?cC6LXPcT57PfynLEsW6nCwarCBZ1mrUmuf+c5qYYL8rjNqr4bLREUBSb0LsZ?=
 =?us-ascii?Q?jBeZFRTQ9fBRS1UYab1Exp9vAML1fc8Zwl1Kgko4NuiCmJ0TCpQCkzuBs+3l?=
 =?us-ascii?Q?HZHB2EyTvlG9q/YMW35n2xKyrTKEZ2Hl5xmM3yLxfMA/LgmtPrzdvBrVJUx0?=
 =?us-ascii?Q?lvAH3UyUqs3LpcLg8FtSg4oSKj0W7F0qG1x0KS5X06Lz78e+C3/Q03jf8CbN?=
 =?us-ascii?Q?NkL3OVJ4cJxgVoj9imoNGUw5MEnnr6agd9QQJXdpG/pIOTQFhwcSnkgcDulY?=
 =?us-ascii?Q?Feq/ZNTwTnDUbUKA19kYw/f8ZiNG3k11WxwAqu94gXViBN6G3bJTw15aB8/O?=
 =?us-ascii?Q?et8w6RlBtvnJeny51ivZOirW9W9PK+YItCSDw1OCiCHhrhWNI8GDv/VZ2oOP?=
 =?us-ascii?Q?7FZBxUnQVbT69wGxyRCjiLUYcQgEFz2h33JLLxe+2QSwQ7nVVEEnmR4ywPxB?=
 =?us-ascii?Q?sRUgEUbZvelR/9eu1GFrAgrKi8dfS+VERBXiKQQUMc4Ay/41Ualox2GfYi+m?=
 =?us-ascii?Q?WYrXDzSmnAJWZDDiZ5U0LZTzf7nlLK59wxcP0EvFFhdnJ1Bty7/XaBT9FRNU?=
 =?us-ascii?Q?qcPxlFqGU/uhzCIM9DOGn1nkCfC9lDa4o3zK1Dkde9qG4mMu3bN+EzhK7rsf?=
 =?us-ascii?Q?wIaxIAB/PwSsuIx6rBUK/J/UKA5bxdXjuZUfgtvbNC5cyJipTdiW1kCvKNzC?=
 =?us-ascii?Q?3ea5AYAfE8puUhDksD+qb/TL11AL0VPSFHAsPxVT55rsjLHoQr8Lgoc79l7B?=
 =?us-ascii?Q?8+EKpXl4hF0Bbo8Nd/pV4yi5KzRob4fxbmJfm2esomApuQkG+gJSQ7ugwlh8?=
 =?us-ascii?Q?3vVgKL9QmBBJH2dl1qzUL006aSdFwsMa2HjaRqrvLVkePRVM/jaQ1SRRf8NP?=
 =?us-ascii?Q?NR0pcesF0ETlX5GlydixRJkSOMCwi5dmTxSqnay2ROOh2km1lMDHZmmN0agS?=
 =?us-ascii?Q?dwHaIkvGkmpdJMyAqnVtF23FNcivA7PRDGXF59olrSi8/eryr8JAS1fzbl3x?=
 =?us-ascii?Q?EFdukSie8WQLd4MR7wFwbnBWnVTNiLfMQRTC2oWHMfE8uVjvmpp/YVHYj9Tn?=
 =?us-ascii?Q?O6IjbJanUABQxxE4NQ/VdJ3WmQt6nz1+hrwO0WQHhgoZIK1E6UMzDxJH9NIk?=
 =?us-ascii?Q?+w9/Rz7tK35B/tNwIUAxl+a/rXRet9xHZYmKgrlQ7NjqvNlXxFCfesZp0Td9?=
 =?us-ascii?Q?42scIF4n2DD/pVbKClbcCLsWZXFYkx3cV2cTDvOBmTcmP+dpcgGN/UuTRVmS?=
 =?us-ascii?Q?uFCueR/OhkIekAzZfGp0NRly+QeU46axY4wv9+lw0em7qfzuQK0WsltD4A4h?=
 =?us-ascii?Q?aIpHX7HLn9xaLpCiOEzLZFe8Z5z29yimmdFV/DH6GhU6Uy5FGJJUq/CPAOfh?=
 =?us-ascii?Q?IoDMaMOYBI6e6bKQ/Hz9tlbxwu82usPg0PaXaePtfz3UpNrCVqV9anKJ+eEv?=
 =?us-ascii?Q?EioIzCetLCmcJgsePeYMqxd3kyXTPVloXq4HQHW6X+8tq9CkkwpM85gZbvEQ?=
 =?us-ascii?Q?gucz8vZeJOPFTa8D8VQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb9556a-5095-4b80-2a3e-08dc9a2a397e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 00:02:12.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XRVpXXaWfdt87BenUHmg5odc6aXIT6IfkdaZoXKo7EGhiPtbw0NPh9hcIohdUlyXcx6ZybufVME6hhdI/j28Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364

> Subject: Re: [PATCH 3/7] arm64: dts: imx95-19x19-evk: Add audio
> related nodes
>=20
> On Fri, Jun 28, 2024 at 12:03:27AM +0000, Peng Fan wrote:
> > > Subject: [PATCH 3/7] arm64: dts: imx95-19x19-evk: Add audio
> related
> > > nodes
> > >
> > > Add sai1, sai2. Add i2c4 and wm8962 and other dependent nodes.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../boot/dts/freescale/imx95-19x19-evk.dts    | 238
> > > ++++++++++++++++++
> > >  1 file changed, 238 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > > index d14a54ab4fd47..660e623f4f964 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> > > @@ -17,6 +17,11 @@ aliases {
> > >  		serial0 =3D &lpuart1;
> > >  	};
> > >
> ...
> > > +			     0x0000 /* 4:FN_DMICCDAT */
> > > +			     0x0000 /* 5:Default */
> > > +			   >;
> > > +	};
> > > +
> > > +	i2c4_gpio_expander_21: gpio@21 {
> >
> > Use gpio-expander@21?
> > It is easy to duplicate the node if other i2c bus also has one.
>=20
> It should be fine, parent node is difference. gpio-expander@21 can't
> resolve your problem.
>=20
> i2c2
> {
> 	gpio-expander@21 {};
> }
>=20
> i2c3
> {
> 	gpio-expander@21 {};
> }
>=20
> It should be same situation as gpio@21.
>=20
> DT should allow the same name under difference parent.

As I recall, there is build error of duplicated node.

Regards,
Peng.

>=20
> Frank
>=20
> >
> > Regards,
> > Peng.
> >

