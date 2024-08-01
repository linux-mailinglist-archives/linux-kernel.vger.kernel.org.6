Return-Path: <linux-kernel+bounces-270568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA879944185
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A46283399
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A8313D276;
	Thu,  1 Aug 2024 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QtLjveQR"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013060.outbound.protection.outlook.com [52.101.67.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689C1E868;
	Thu,  1 Aug 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481572; cv=fail; b=G1SYenTsTM9e0mQpanvJdTRTso+IXlqMjPUe4jfbPes2vzWQYZWx34KMKlAtcUx4JVTSbHE7Cv36Ugjr2O3AJUAqjWLgUo6ENVOQjIzF2In7gglhWKcNXEVYvUEvLp8d6XUSdy2NAyUcHsERK6tGLIbl8pbPE014QFkMK3+5CLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481572; c=relaxed/simple;
	bh=0PCL9sZSBDVfcJ+a+ul87H7pdgvdXX4PqBdxlAbccIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gxovetYJzjQCK6IntfP86Ue2AanSlRJzeZmqF/UcIviP5nlQlg9Qu4+DnSEtbIsxn1y1wcDsGGXHitYHuTGhS/SiGZ59LgqcdfLE41IYBYCTo7wo7hYMXJIpHS9oA3WVoaG/9Coss3qRQbHlF2yliP0Q6YeYXWp9QjzB3ihIjBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QtLjveQR; arc=fail smtp.client-ip=52.101.67.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7TUVQvIlZfTYy+rbW3DR0oM2XOnyiJNWMJIDK8B25xA3M8tisf1oEGMY4dhrjxvDPcu4uhO1MV7MLKQsgyTnLmnN2yOHxdjZ1jojM7VvcJu6v47CI4cDjSfFxhBKph2zdjAn0eR+susELvagNgkEyP6L824yUVNknS3VTXt49tUYJM9JuJ/kRihEmif6SDRmvqkJAwvXeR1rkMqWiNJnXuMsJjEftvda1QwlUaUID3p/iCAl6e3P+D6gnn5UZ70evJ1TwGs234c9zd4NN8KfqzGkeUmj/5iI5DNX4NZtVPwEeSDZWWGI83K6KC0ZSj2u1x+2K8FPOMsGSbdDv1u/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Tutha4VMmn2QRUMPStrcybxeqhdg06Li2Ayd4u60HM=;
 b=YCjcHkBktq1z/l9Fv8/OTJL+LaNNs7pMBeyp4J07AMqz7AW7TTyr8HxUVOW9q7YcmMX1WkPKc1uruJVWLmq6RaVq/53QmfjRYqfgoEwOcrOp0OLkexeYGe2h3IvZD1OfEABLTNAscimFzeQpCw4EKpcCKmXF3BR+3nuMbnVuWMzbIHr7NZvT7HG7IfUZZDp1OhnTQT1KiDTn2p7lC+Y3vnShVBqvwORkPylXH/s4/FGKlgQAtrLrlzkqMS6R8IgxZrz4YDxF7c0nNeb9sMDth1RLFiZKMi4oFcVe5duxhRl6Op3TAQlIZLF/Of+e1qmNjVDQqVvaa9Z2htUud4Tt4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Tutha4VMmn2QRUMPStrcybxeqhdg06Li2Ayd4u60HM=;
 b=QtLjveQRgFk3pCsNjxkQHZZL2G/Ngb8FyUEcvRkEo+iYcQWxiApXf3IVKgWsrCvUknYdy5ocgOZMcXCFVWPQETW3Gl753X46TbI3nayIGFVPDsOQO1CSScUSA607TDl1ft5YmWsCnoRdHf2ATsel3Lc7jQYzBK15ga5FS+heLX+ytKOd6OMbRrhreeqdrNGc2/WwmxPiCXWIj1EWNYq/lbegwVBRQeMH0QFcUIIp5Gadw4T7fmfKFoqIVrz1II1nCApcfohcCzssEP0d1j6limNs4oWbdj/aZZ4U4PPMH2MMkIP7J4XIFAuz82bz+v2eLQQb3b8Hp389xWX43GppOA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7925.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 03:06:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 03:06:07 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: Markus Niebel <Markus.Niebel@ew.tq-group.com>, "linux@ew.tq-group.com"
	<linux@ew.tq-group.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla:
 add irq for temp sensor
Thread-Topic: [PATCH 07/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla:
 add irq for temp sensor
Thread-Index: AQHa3cmKSR2b/+dzQ0GJ1dXJELtd27IRw78g
Date: Thu, 1 Aug 2024 03:06:07 +0000
Message-ID:
 <PAXPR04MB8459396B2F3E41E883EA20D888B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-8-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240724125901.1391698-8-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7925:EE_
x-ms-office365-filtering-correlation-id: 96943e44-ebfb-4389-015b-08dcb1d6e378
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ChRAVaPV7ymNdurbR8xaer56TKx66zUlYFCAGochXj92mufUQV1hvU3BUIz8?=
 =?us-ascii?Q?XhO99x6pyARDQg2rYgodKwg6V0zpJ0T5IV29KFvoaa1XERk9FZdZfgspoLAA?=
 =?us-ascii?Q?b6jU64dx6TULdifwzFgmVhZ6367whRaLp6Qh+K5+EoeyJSZgmxUWToukPici?=
 =?us-ascii?Q?2PAeZTN+d0iZGuL5sO0p1lzGuGYqLDzpBfea01a2H5+sGdBULE2mlJRfhyaG?=
 =?us-ascii?Q?V03uRir42dDW1s/Oq4qNrSy+4ICdDIMS2wSnJh/FkRmF435GyF5yl3iYOQXk?=
 =?us-ascii?Q?qtZBIda+5+nHMop0+cpP401jNTvBc9bI7rPlIjpRuNMeKy8HVDJds4a6lkMr?=
 =?us-ascii?Q?MiKH/N20oMuV+iO+yUUbAGMDUsDMryVUZWx3JaTp+RkSv3Spo7ZUT+iPhfhN?=
 =?us-ascii?Q?+Z/3AXZyBlDzyjthtHd+w3dr6Fx4geRN6biLVB3wPMHool2N1IbprVsIM7/p?=
 =?us-ascii?Q?Ly49RdurFxf5cnVnkhb0tllP6lyKMTLHRHgaf+GO2C7ucv17x//kWKEWUvmx?=
 =?us-ascii?Q?lq8N6N6+VSFJNjKjBBylYi4s5XLfPWJA0RjDuWYK+SVEjB5Xcr4iuBGzJCdi?=
 =?us-ascii?Q?fiYsd5knkK3Ddf6lLfp9OACqDPu8DwayomKkIZ7Mi/zjHWuTxPuf4xbmOlgz?=
 =?us-ascii?Q?RmYB/r+oerSS4qTmBRyiAeCNhznimI5DxddSQanp2WZMlUfEUX3dTQsLkmbv?=
 =?us-ascii?Q?IVpxMsUzPgDNO0qrtr4XdcBQDmEFuGa5EO8gtuJcLYTOV0XG5wJ0ynHRAUvH?=
 =?us-ascii?Q?QDIUGYjQ1wi/3YYi6eb7avlx60BQvPGcYWiEFRCZdbN6XDuRrAAr85ZsPs6R?=
 =?us-ascii?Q?lQO7ed9qPmALcMZ+KH8fP/aIXvlmgVyKjALqrfHmXZCTD9MAhjY6lrKt4Zh3?=
 =?us-ascii?Q?EZJJBcRpwkyv8zVewdOXyHq1/lNLuuaCsMq7n1pJDc8vXnd/yIK9UVUi+O66?=
 =?us-ascii?Q?HYIFv0N+oLam7NVS4AXNQOuwloX7jVhc5dmdiTpxHSX+IMQQCrW9RZdV4fOr?=
 =?us-ascii?Q?VC3B7ffxoxYjTLRFI8yYYj9tCqiXvUBK5Vr0X2QZCJWjOwm2q8H1Ir2uiqET?=
 =?us-ascii?Q?vhlswviPST3/iwxwYsxUWC50u4JW2PiyRPN4QehKmdiGxjZslPwr0f9N/+Bm?=
 =?us-ascii?Q?B6ak8jcEJ4aPD4Pl5iwy8hcF8QTIZhpquDHYFYm1avYHO/CW6OK6lBZSm14h?=
 =?us-ascii?Q?r2QntfZsq6FKIm20/c7xvWzN1yI4f87sSD+Rug8TxoRDE5NL1H8XNiC5THMJ?=
 =?us-ascii?Q?ktN/krT5FVdCESNVl5OjopwDHhGzzCDVX09GScByebPov3bCIJ0r6VZ6d5VB?=
 =?us-ascii?Q?vi4Yzg08pNkl7FXK5NyBFbQgDbO04BVtMazPaHgf8beL/idd4WYHOkLoM9zF?=
 =?us-ascii?Q?0Z00+kzAQukTtCvpd8lvSiGtMVvLI59TmG4PdQULdJLCx4vqUg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TEgWOBwhO8CgDWmamnYrpLuifx+32qgmbpSqeGPEZpDD8fuWIhvZWZS3fnMr?=
 =?us-ascii?Q?a4JZ7QhlDZYQejJ+1t4W4zDu8Z1hmw/widIXOYeThfBVtK0keIWga4qHhFYW?=
 =?us-ascii?Q?uq1yhPNI2H+kToYb8g8r/eO9ZUvjUABDRRFH7Q/jXh0nxIUk2C1fPMSIkIev?=
 =?us-ascii?Q?Ol8EzKsoTQFr3j2lzNxai/ixoN62wLEcyUQQIs/mff7OV78IgDXIpqe5o/bI?=
 =?us-ascii?Q?gOKGJnRTtlV+Dr5Jy6Ilgsd4SQexxaJM4Mj9FZBwLGRGjXjzqNZDlyuqw1jn?=
 =?us-ascii?Q?6PkeBr/mnMKWZPURQyH2RvzwQJhgm5CReffSuDgHi1HZDZUX6p0t8AhT7zSo?=
 =?us-ascii?Q?9c6c01WJWov522yyQCaGNmOeN/R0K2Ny+mA0KwymXmYH2+N/l6azbqv+NCTw?=
 =?us-ascii?Q?uU4797hXrqEU/IbvlF1atKkiHqKnYjg2Q0yAdhQANP0BRIl1X7j5yGZETpCR?=
 =?us-ascii?Q?ACsiq6MOSagSSRfpLXtpQ7iwGigNWyNTFuw5KxbkDnrY1jstoAVrHwGGkJtO?=
 =?us-ascii?Q?q747q54wsqcRkR73KUJOWVyzzoqLoXv4XTx9gm3kH8VPGg7mnwFwulv4qqQ/?=
 =?us-ascii?Q?mYNkD7Q9IHOthvNDZlQCPX6pKzYh1/qMO4KewJZEFJy6yDmTVd02byu4MChb?=
 =?us-ascii?Q?Kwxph3Ptggt5dIDEQruv/7PBQ9ToF+CuDf/IsQObzrnf3Om+7JJpBCrO7l3O?=
 =?us-ascii?Q?AkGDZe8aFocgeQGlN9slwE1/xoL7k1eCPgnkPTA+wi5kv6HhbdsCqvKA5FXM?=
 =?us-ascii?Q?7tqXyQhoDptdtYgHq4Oz977YnZzdn77F/ZfNI+DOEWuBRFVn6Hu04tgS4uab?=
 =?us-ascii?Q?Sf6/Fn1GB7q97CVPVktuz/BzKwOpUCsCzxrxE420bcsbk+kFs3Q43hOknXVS?=
 =?us-ascii?Q?Q5zWAk9dVCPffLCfKuK2RFlDj+mmEr5LR3Oqo3yhyHAnv9Z637qVV0TGZXCM?=
 =?us-ascii?Q?Fv63MYb9kNcG7QX6zBdXA79QnaxBmiDZDkFk4Uz6WaQw7LP9n58uoXaKbXOX?=
 =?us-ascii?Q?P0fgfq7UHzJNdAFHJ40fQfxFTwyKzQ9qj1tsG9ZlOfe4hRd8K7aHoIxMI1RX?=
 =?us-ascii?Q?BDBEfGaje2BMnF5HkAa3K0quXbDc8oQNfw/29Nqadi+eQZrbUR1W2Zp6+Hu+?=
 =?us-ascii?Q?FBTZyJvwoAZ4+5ZG/SW/VljksgzfnCcVTdm7OFvHcVFChjfj95S6Ahobvpvr?=
 =?us-ascii?Q?ktQLx0zOKa6bJ0QQg56QbU9twIi+Uzthw5tQ0w+4fqugG7znJzP3HEdzFgCx?=
 =?us-ascii?Q?Fk1rEk8JOIbLFwBtg4GfmjorQGOR0dnHTTPv5wio0WFXbVFRKTPgP8iEf17U?=
 =?us-ascii?Q?OWdUCVvb7R+spHakJByj+cKmoBfdxCQGsMpp9Hf+jXUxSUwS+bPqL8/JGz1e?=
 =?us-ascii?Q?hyt4PVywR4/9Md5O3pS/jFZmF889p9VRUIvReoNwfpWGt5E1rsKVg0tfhnzc?=
 =?us-ascii?Q?sDHJJZTiSL9xqNzXabkns1jH9xzhAz9rJsvqGNPF11NvTLqL21aq7j5xUk6v?=
 =?us-ascii?Q?P9DKL+CEepy/9RjyZ+uoGAml5j3oRfaFXSwgqWqU1i0pfj6olPkPVLhGUtMA?=
 =?us-ascii?Q?/H+Yl8KWTiBnA6xdkt0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96943e44-ebfb-4389-015b-08dcb1d6e378
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 03:06:07.6704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZpaqWdCH/z8T/gZzVcIX0QT6+OKgqqb47CWtaR6ry2o2nOtelqX33WdEzC/Y5P+7Md+kqA0t1LGxQFkuZmNTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7925

> Subject: [PATCH 07/14] arm64: dts: freescale: imx93-tqma9352-
> mba93xxla: add irq for temp sensor
>=20
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>=20
> This adds muxing and configuration of the irq output of the temp
> sensor on TQMa93xx that is connected to a GPIO line on MBa93xxLA
>=20
> While at it, add comment for RTC_EVENT for pcf85063 since the IRQ
> line of both devices on SoM are routed to CPU GPIO on MBa93xxLA.
>=20
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../boot/dts/freescale/imx93-tqma9352-mba93xxla.dts    | 10
> +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxla.dts
> index c663b6585c3a..3038c94a1184 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> @@ -452,13 +452,21 @@ &lpuart8 {
>  };
>=20
>  &pcf85063 {
> -	/* RTC_EVENT# is connected on MBa93xxLA */
> +	/* RTC_EVENT# from SoM is connected on mainboard */
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_pcf85063>;
>  	interrupt-parent =3D <&gpio1>;
>  	interrupts =3D <14 IRQ_TYPE_EDGE_FALLING>;  };
>=20
> +&se97_som {
> +	/* TEMP_EVENT# from SoM is connected on mainboard */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_temp_sensor_som>;

pinctrl_temp_sensor_som node node added?

Regards,
Peng.

