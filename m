Return-Path: <linux-kernel+bounces-256956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7347893732C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58411F21AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 05:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F225D38DD8;
	Fri, 19 Jul 2024 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i9MhFtdW"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013063.outbound.protection.outlook.com [52.101.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E9F10E5;
	Fri, 19 Jul 2024 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721365665; cv=fail; b=Rfv1jkfZKWqUNetJ5bF3Umeyji0Aq3uIapb32QRexJHPhN/MJ1+ZT4BOlz/Aei8QN1GNW9jS9Gd87xiUdDTTr0IXSqt9ImlvstjEGxsYScNQLfQeo3i9oW3haMFZTMaqOxxOgAGBOSluNFZIqfanPJA73XD59x8uleGGuchkigw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721365665; c=relaxed/simple;
	bh=XttndzI3ac27nBGlm41Hw4tsAbChxY1cNT+npTflaGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FO129bPa5KG+3potXDQIbcvRcjPCWq9jvgSPLKOmT5Z7FCcmqRbhvu33zMgxjuwkIMWOl49sSavh0dqpvI1stROYCYUq4jjc/X4owrgI30Brd6JJiaS4tukkUW2QUQJf7k0Q/AbI8QCowN0q49B8KZZNJnxyEUzxCJiU6FXVMV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=i9MhFtdW; arc=fail smtp.client-ip=52.101.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yr5WRyV9U6J3p71M2ZiMzN6aEu9os0EdrDityl14LgSIN8sjxplPuxFXdYYDHHOA/4BHdgjl6v6uf7qhVCS9dFTWbiJdbQBsqQd6438f1IDN30ShhBncrwJuhnvennu0m7Y8ob6k1GMi3j9dmjyPIHbGihLkQ60NxSitYxFfkvY/jaY3NLLz5BJW9Rkx2w+ZKPssO3L5oKhVdTX1N8qpqavA1Zt1w2TlsTgqCX6VWtBQ7FrJPOO6nqkupHn4wm7Sa+ht9qfQev0YoGMkomMpSzI600yxz8ZUIyAhbRIdKqyAqUWgDPO7X/Mke9MW8+v1Gm3rEbjZ1PFotQtzhw00mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XttndzI3ac27nBGlm41Hw4tsAbChxY1cNT+npTflaGU=;
 b=Fe4h6a9yn0uFL32bmHCx2uYGlVPBQRFfszcpvohcAvgpV5QOLM9qDBUoGAlwGs+fAbj5gYABQj2sGakma6FfqiWEMP973nTno5PZxF+UbU2qVC7+qvhuKMU1Yq7k57AfbFPsjmmUQgrh7EIgLWS29lgwWvgHsE6gUUwhfnblS/Hhoce5O8HozxvCqXus53g6ARAmxRzlTCYMMqymAWg0nSve/Kg0mSEcgfI1z7mCjX8ztnzrbdjJe2gT1v7k/Y82tBdWZmOFnoKmzCGmM/G1oml+1JKIhz62t6eu94xbPigIPvFKSHAjL5TOB0RGGJE92h9Wcl+C6TLdPe4sMRiDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XttndzI3ac27nBGlm41Hw4tsAbChxY1cNT+npTflaGU=;
 b=i9MhFtdWMRC/kodG4Xtu97MSsEQOl+BEABxK5nn+s+5+gyTv9cMWcK3tyRcU+9iGSc/dCaOQoeCnwnhmmMgbAUCKe94Vr4LOJ7vXcN+klkw4pxm+rPV4/pnjIfHrhKnRkFoPRqMVaJvreyujeI2E2Igd3ZsoQQ5TY7HT09CE3+8=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7889.eurprd04.prod.outlook.com (2603:10a6:20b:24c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 19 Jul
 2024 05:07:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Fri, 19 Jul 2024
 05:07:40 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] clk: imx95: enable the clock of NETCMIX block
 control
Thread-Topic: [PATCH v2 3/4] clk: imx95: enable the clock of NETCMIX block
 control
Thread-Index: AQHa0qcdca2IpPJJJkyywPIhPKTWr7H9jbeA
Date: Fri, 19 Jul 2024 05:07:40 +0000
Message-ID:
 <PAXPR04MB8459429C79EAF1DEAB79C1A088AD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240710084345.2016687-1-wei.fang@nxp.com>
 <20240710084345.2016687-4-wei.fang@nxp.com>
In-Reply-To: <20240710084345.2016687-4-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7889:EE_
x-ms-office365-filtering-correlation-id: 3ac72c78-f1ba-45c0-d95d-08dca7b0b6c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xDMDgAYkO5jr7DhF2C2QUCQgT0y/r7KdMy3mBRMJxMj/+IgDemMI+9JLFPl4?=
 =?us-ascii?Q?RtX+EKKKkDwL5otsYSz4eX6MkuncHXLc9kkjioWVB7Q+w5D9skIQrxE58ESI?=
 =?us-ascii?Q?U1qqKml8Ayg6pfSyHiQb4F/F5FPMmqhDNAJNttM+ytXRZ3YuEFkFUb4lKHHJ?=
 =?us-ascii?Q?13nMG4w4Jd3+g9cAGgNNjAApfssx+h/oQYNllaABvmkXxsoa/Nw60w9NtC6r?=
 =?us-ascii?Q?fd+a0rZ9Uc/oJKhFFUF0NiZfUBH9LiPnZkgDkCF6RKmpRJm76r0KSsbrghvb?=
 =?us-ascii?Q?7bSsQy7RzJ7cfbMsZYlv0tM8Zhqmnmhxdr0g/0rslQggKw61gKnph5VUBXMx?=
 =?us-ascii?Q?vsLNLXdRJ2GTC56LBAZBS5ndxwDnRkpnVVs2oTFgYPgsnqqGF5PIP7ZBeSzL?=
 =?us-ascii?Q?YiQAKdLuhiDBcgSxsAKuj4pdT7ifceprNvFQsuO70Uo4kKfP1Qc2wZQBiOYr?=
 =?us-ascii?Q?AAWhGK6VvU0LNQRzAmKgCOPVzsa3TlJ+2XM3d/s7wlLkvPQS/9z/Ny8GEYbN?=
 =?us-ascii?Q?Fjf/aLLxU9CBFLIyfHfipcOKaiAr/3dBruDkGKQfDLz1OrDKRe+Jn+qnk5Si?=
 =?us-ascii?Q?M0+EtK8b4q3K2i6bGgiIVgu2hJm6SWBTuRk2hReNH+T/n/iFdHutW3f21bbK?=
 =?us-ascii?Q?6BtVL8Z00yR6EzCMXiN/6MWHk3Vz6x13SIQHQs9pGwp8qb3HeoVvuhZXAQbd?=
 =?us-ascii?Q?YdaX/LTb3VfUsG8GJLHq5/WMrEdfSrj7ScwpphsquXmpndmupSNA/ArIAEdG?=
 =?us-ascii?Q?VtkkOgHaxV3/ZXLMWUsIbaHy969IzrdPUQ9aJ4sMb9ExC89weccn+eAx8qWy?=
 =?us-ascii?Q?/NH8sAdBiNu5i+iW8Ge4xjaCcaHF5DfB4sAMBrweQ6AKBfrCXWauGYYEJTso?=
 =?us-ascii?Q?vQE2QuhqS4fdAcVbNBBOW9hODJFmsae2o0YpvJ0zEkCTrGoYJdXfBd6JEr9s?=
 =?us-ascii?Q?7OGyIzi8yWV6qNimhBbSFf0jjsaZYxu2A/mPPxWKy+Nww2h/Vu+kP0zNJzfX?=
 =?us-ascii?Q?Kx9cYOfIjJbTxHUvUL8lLrLROmgS5m6GtHdLhLm3zRNoP4upnd4D980OFZ5s?=
 =?us-ascii?Q?uQC74riS6A+acfDGdWTFf0rtAOmKkudqpNrlKDt25XBo6WgHcScc7lKHiddp?=
 =?us-ascii?Q?6Ot+cFz4fpVBDonKSiHKs2kHOZ9gqUpfflWEJQ1/xdjusIe2J3L2go5gQHWC?=
 =?us-ascii?Q?1RRRBipgizmJZjF1LWcFpL6E+B/z2dS6YsWtyUWyW7wWYJeGDzNgl+4UGZl6?=
 =?us-ascii?Q?sdqcDwM0waHJALs5u7PWnS6+3JjA5Tg2b9CpbG/ZG/FY6+RKNVgfofIbnSlo?=
 =?us-ascii?Q?etME4xfYbIYhQoIpnj+kl4yCjw3aprkcjeUOOJlhNOueJrO9sgZUc+PAtKm7?=
 =?us-ascii?Q?OrMB06G0DMYewUL6FaFxRlvzfluXHyLnNUB1twu6HKrG6rYAxw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?86h53ifpz+It/uuy7kF5J6dHxFxFGZa6fgA8mI1SRb2KzFjkmocLx0gyjlui?=
 =?us-ascii?Q?uT3XW09955i1JX/tI0qZFP+K27D+C23JyRlt3G2JC3NxQdpoeLZbb/1Qg4ot?=
 =?us-ascii?Q?DC4h+ztzGK16SX/11BpuieuYEYsTZxzun+OsSsgqP2bGyP2VmgIFsPJoekbP?=
 =?us-ascii?Q?zY1ClYJZrphiImtZgy9dhRL15Z55e6A2DXqGUYZgC9RS5ldV1cS7+lcjPfF1?=
 =?us-ascii?Q?j2C1zhuJlMMqzaJmuFaVRTybrN4Du0VQEfP6pF1wYpJPCjjHYbLAFINe7J3o?=
 =?us-ascii?Q?etWDcEVXFEH6F5Zqm00rf+XFzNywrdk2iRCLWmcqsKeUMGMv+8x2ag8aAt2/?=
 =?us-ascii?Q?0qrqsjtjo3a7bV5DCrJBYkIy95U++AG4zxJD3CdVv18jZmB+7RlWnIffy8qf?=
 =?us-ascii?Q?3jiaVulzHJM6YGc7FQm2fpAoABmEAvthNl25RxYs1vAbR9cb21jZgfX3hOky?=
 =?us-ascii?Q?U1s/5dhfTrZnkN/v+CrKLxj2s/XK9/LTiC5ZVXxijd6s2mM/or1CHIIYS7hU?=
 =?us-ascii?Q?Cx0ILZ8csHgyJp7+ZPlG/n7YtRgxk5QIchPpOvEwp8pVsczHr9KYjIbmTNwr?=
 =?us-ascii?Q?qplDF97AQptTr0cgdTec3b55NQcP0GS8pvo0+mKhpziojgvIN0S8nfo6kHTj?=
 =?us-ascii?Q?T6LJasA5a9XRykYiJMjtKLN4fHw9UCrAzitOtxGgUhB+Giuy8XbNC1vQBe/o?=
 =?us-ascii?Q?vqijDHs+zt4dvmh6BRjpSmQHU9J2uPKcs/k7erNz21XidkB9gPVFpYDKyLm6?=
 =?us-ascii?Q?BeA2d6UfyQlx1CZSvgrPn6IPRb5/7FfOHcyjQ3itFxYQPrqKdx/H16/lOPno?=
 =?us-ascii?Q?Qu01WURDPYJkvK/Ae0Gkwef70GnD2VgY0YwKeHC2L1vhbANZ+WuPmm0iuGQt?=
 =?us-ascii?Q?bn48iOz4nV/5YzjBxnn0w9+kt3EGRU0IPl8lFHGjcsRJN9gfVaKwz6nh+kpx?=
 =?us-ascii?Q?PG9wjagUU0lUCK3k48jkczgJxySos6cu5ebLY60O+Yzi72NXV+DbQ/bwzeYZ?=
 =?us-ascii?Q?lY6O7/R9FBuZQ6uesUCUeddHP7fCFF5xdY+F/WAYg/j9B9zJIY/enhkxGZEi?=
 =?us-ascii?Q?VftDrwSQjxSL/GkKt9dfxPPagbTSN+PW3PnafvUhUyxY9ho3s7bSyup73FEN?=
 =?us-ascii?Q?0rWC4xj3rfSwUt8NQTpjaOIhROiamjFOaQJQtSBlz3yVE1Pvm5r5vlXaQqyg?=
 =?us-ascii?Q?WQo01bIlqhIKdLE3jybu4RBMiTSb50b2kWSDh+Uc85hkX2TwrK5arWM0Ivz8?=
 =?us-ascii?Q?rud4R/mmBCFNAZtu5n/vEhy3GA0NOPBQ6W2LigRTsVdfBf6TDwBCeT5Z7uVX?=
 =?us-ascii?Q?zsezU3hPkU+HeNreIInE9CJPJpZzmJ8NTNxH7jwLHq88p135EFEQdTo9tBwm?=
 =?us-ascii?Q?jNrh97wY61Ig97AXW1C4uXYuntKiYr0pxaUdaZG3urKttqw7uiIBQ+ETtZp3?=
 =?us-ascii?Q?Y7wm978Cw6BEaStouyA6qHnlm0yW2NUNFcRnDYw2M/6ShDptp1DNFhVtfkOX?=
 =?us-ascii?Q?2w4mu2VLUmz2N4MAgBnTsb4oeTSpvH0E6I1XEm7TKJOLcxWWgtmVaJl+Lu/5?=
 =?us-ascii?Q?S0cLEf3Kdbn97Ek9/Go=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac72c78-f1ba-45c0-d95d-08dca7b0b6c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 05:07:40.2067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6vBeXV0hfaUrqFIzjiHXd8pWxNu6TGyFA6+FtCkaXcRJ43eUc1EGsJ4ersvU0iB/4AXzYtkx9Dt0V9le5tJRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7889

> Subject: [PATCH v2 3/4] clk: imx95: enable the clock of NETCMIX block
> control
>=20
> The NETCMIX block control consists of registers for configuration of
> peripherals in the NETC domain, so enable the clock of NETCMIX to
> support the configuration.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>

