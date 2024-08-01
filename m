Return-Path: <linux-kernel+bounces-270531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07786944103
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBD31F22444
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0887F149005;
	Thu,  1 Aug 2024 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b7yoHUUx"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91B1494BA;
	Thu,  1 Aug 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722478235; cv=fail; b=UdpaO7cPaLfujX10DtttpuVbSDEjrJtKfawqnzW7HUBk3FF/qo9peHMc5GVQjxHzEt1HUxk5u/7alZ/7lzev0Q/uU1XxTE57SVXTa4Vuw9nU4kfwm6tzsmYDt5QJ3qKkceQcenAStD8SShV+Ay5n7HZ4l1iuItMgRQ9wdwfuDAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722478235; c=relaxed/simple;
	bh=sVF4uD87rUFGY9Gu2GxyKQEn0zE/G3e5fFuzzRIfo8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cFQBZbfunmbv6PNMa39ge8COLZgM3pBgGHtRBnTjbc0Q8CtmWDjZohM1Zh8Kc6gzQdOAXzh3bzhfBXXAXVrkngPP9ukZPCdOqvDu3vIm8Ipe49P6TQ3ijDshQYXcwi4Q5wUk6v56s8IrkvkyT2bQ4tiFsowuuWmHZ+ZAlz1I/Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b7yoHUUx; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y96mgZwJb09lx98c345Hty2x17H5vyd953c3Ipzszq6H3YIccCYPNKj7/Vm0JTnjDNVWK/Wexfa0jLmKpdoDt2WRiX6CxthMZiQUIELADOdWLQF3C3ziYKMNSEP2o51dmAN3ooEYXNoSxwi0hzFk3tdKnqO3jfke2xCNyhXu58OyFN1pLD0SrYKQtsPtJAp3CNd3LpUdNP0bvxLUaV6oqbcU9LdtoLyfeUi0Bs6hZOFcNeDxIIoYEOA74Q5pgba6j4m+ZzNpuwROlEmdNSCv4pXcktUT00txlIDa4HZ20XazovuivrzMvXQtK/ch/O3yq3dwXKXQ/Yj+Ai+CfqGxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKLpOoDVKVutcstr8maa397v1iNe1WBk68DYBINt+Lg=;
 b=dw0x7VUnmmdLgN04nSnkcdqg9McCa9EmWPmMvV4aA1AW6C/heyqyEeWfaVhRrnb1WwlnMhiMMeVyHSIsBGUFJvgqG0ClsdzbACyIM7uyRfXrBG51jgPmCSODSClkJiRP6tSAfZ4L4nKkwzZk8Y6Ghf0ejG7xvJuzn2M/i3D9weLmBLA5Z3KlG74RwxEBeDRQJIv9IbgX0WzKs0RvwFR5jzRyVh0MABLiyM8tbRFEvYdQvHwgeejLqNDf9tyNOfNkvaXctqSLUDbJ8v9pqSY070E3WxEHoUFTzN7EPPLIMWUcH5VSh/I6DSihEdiPt6m4HVR0Eus07WTCwbbwgkKIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKLpOoDVKVutcstr8maa397v1iNe1WBk68DYBINt+Lg=;
 b=b7yoHUUxO1QSG6LVwUmjLdW6w0hkGyh+nM9cZe1wuzmGH2SpRFTHaMRUPhnfy1SeYiNLlOPwNAZ9XahZNH3KdElYzVBaoPL+gbvfDrz7HzFIAaGGCH7TugbIIE3UpKrLhrCJ3ZMOurSJeU+ozPbsgj8zsvFvnHq6FdpK7r8Ugb414XcmqPpBcWavkaYXp1tlFUSyjSeKHhOm0q/z2Dbh0gfbDJENXv05gTUSZjDKPWqSTJcZ7blv7dprO+JUBCFCnWMyvZvqJ6Pzi6vsZl9Iflht8g2U/o4ff+Dov9dxWU8b3sGvGZ9SUR0VEuZIlHNDs4R0j4/CFytzTLg0zm5YCQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10708.eurprd04.prod.outlook.com (2603:10a6:150:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 02:10:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 02:10:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frieder Schrempf <frieder@fris.de>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
CC: Frieder Schrempf <frieder.schrempf@kontron.de>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>, Gregor Herburger
	<gregor.herburger@ew.tq-group.com>, Joao Paulo Goncalves
	<joao.goncalves@toradex.com>, Parthiban Nallathambi <parthiban@linumiz.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, "tharvey@gateworks.com"
	<tharvey@gateworks.com>
Subject: RE: [PATCH v3 2/2] arm64: dts: Add support for Kontron i.MX93 OSM-S
 SoM and BL carrier board
Thread-Topic: [PATCH v3 2/2] arm64: dts: Add support for Kontron i.MX93 OSM-S
 SoM and BL carrier board
Thread-Index: AQHa4bVQR4BZj1vJT0aGk6DyJmSt57IRqeLQ
Date: Thu, 1 Aug 2024 02:10:28 +0000
Message-ID:
 <PAXPR04MB8459728C46300E5507CBA6F188B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240729124450.118497-1-frieder@fris.de>
 <20240729124450.118497-3-frieder@fris.de>
In-Reply-To: <20240729124450.118497-3-frieder@fris.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10708:EE_
x-ms-office365-filtering-correlation-id: 55cb4d09-16d4-4a91-75d4-08dcb1cf1d40
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vlPOK/LP6lUswAWyKnBiwhDT9R3QJuUfzXVVjqiJ6t3ataPeekbXSkxOBcHA?=
 =?us-ascii?Q?ytf+CstPo5fklm0Fo7P/hbXIAh5a6t7rHqVdNGIt+ew2tBlBHuYiuIx1Pe5f?=
 =?us-ascii?Q?lwleXnghxPjPVVB/eSGY4KESPStQPsxn90aeCT8e3EqpAkJ7Y/08uqp3D0yf?=
 =?us-ascii?Q?RsjqPZLNMUVflYjz6IdrS10gYeddLr5iUNtKDMlNg9sdV1hTpMsbECrZWpG9?=
 =?us-ascii?Q?aYXXWrdTkUAC3egwImxzQXD6ws+vBWzhR6g+xf/uCh2dXTfRXcNHA1nLfsc3?=
 =?us-ascii?Q?wce+jmWm71uHUQni5bcJAGZxeB/VY4r5+rdVM6cU3sMg9XjDAcNgLb+GwyrE?=
 =?us-ascii?Q?Gxqw+hxdQwTI5tQhUxlqecKtTyyghiXqRSpaa6yTZ4E4WvG7C/8pDMjyMHu9?=
 =?us-ascii?Q?t0dNmtZcTztmBjlTDgmvy8GCtGy+C5ZMeBTzu0W4UEm0kWXS0K9XLguBvFee?=
 =?us-ascii?Q?e3hO5hzEXgfO1vZn2DqrVgpOdPYfWyfj3uFcBAkXh4mHYg+G/ccd6ck7hIU3?=
 =?us-ascii?Q?jRlk13THCucyyDUvEsOhhPJ9SGGD2Oi+o66WQo6f+iThLUzr9C13pLyiCEu/?=
 =?us-ascii?Q?QmhDNAeu+2WP55kTHbF6O32v2vCq8QNaaXQdRowIQrJ9vPZeVJsZlaWTzIAE?=
 =?us-ascii?Q?Co5hfpmgECNDvEWVsbUl6YcTzOBJa3eIgArm+K5ifXzuyr6aE0cPk+DKfyfX?=
 =?us-ascii?Q?ppARfS1WNTdjeesotb6dJRZhBbPUg8H7OWY3ZSeYKTbImgwtCLLI1WgpY8oY?=
 =?us-ascii?Q?tytc7h/uV8aO6xmSe4hiCMS+JtKnQh5BDq05YoyjIchaTd+F4TZ6oV0tJXw2?=
 =?us-ascii?Q?TSo54zKxlOkho2bqK88B26FOKxT2FyhF71ZevkosWPoqAtuPkKb07/Sn3IAZ?=
 =?us-ascii?Q?apzVeCYG4FYUgZ/XWbgUsmkvr+Zh8sUAFUOSYMGwOe3LTaOcbSpYODTLxJMy?=
 =?us-ascii?Q?kavfsL0tUWZw5ST/fdXSbz2A9n6Liz+o1/P2ZTvenJGRcnCAE1EuDCKb4Lxn?=
 =?us-ascii?Q?pVA40YRnj0V630FA2KUrRtO6IHcb9COHjF4KEx8vfoTlb4wwOhK47sTi2H09?=
 =?us-ascii?Q?cca53vqPQj+DlQH/AYCAvrYap1Ta+4r162UQP+QgwShT0kn8oRvSnx13WSmQ?=
 =?us-ascii?Q?I67n7fx8pdemEQtxLwff6yOeO/CcdaM8rXsrU+Y6uK58mSbqiDpMdqEkDNi0?=
 =?us-ascii?Q?SimZJc9ctJg7pTorlbU8lQnhYmE5JfqXUdMwg1SgXMcVyoWW6MK9mhS4gQDc?=
 =?us-ascii?Q?hT26tvX492fse334jdxnYX3lfzZKo9HJ8ahh/FvJ1DGjGh9YBtJdo8kBdpDF?=
 =?us-ascii?Q?Mt1s+55FAvS3oaLRtx7D9V1O84iO936lJSFL/mGkNlR9Ba+FCn/dhJBy1E3h?=
 =?us-ascii?Q?r03kjUSQsTG/2I5SYvdRyXvY724fcuHZtQ4JSfeJ1Qu2KXaJCbfzWtCVUSQ8?=
 =?us-ascii?Q?98Fmv0IzuEs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nsqpIKJsiTQSOI4hcWNnTZwiw6KKba/eRa9fipiINZ4gqglyVM9/9S6q/Upc?=
 =?us-ascii?Q?MgSIh+qb/VmBeWp2FcAtaewaIBc6OJ6W8Q1qNVxYjLWiZWHV+/6ueIeesPCw?=
 =?us-ascii?Q?ffGPb8QfJED1I/pioJk8qQUUvj0rs+7VA59sZEeo41HrA/sAobgMnDqx6UZf?=
 =?us-ascii?Q?orw83sWOHkwic1zQx/rHnfAsueJF6aWI898lSmFhKsXKA4XU3hjBdbIrkE2y?=
 =?us-ascii?Q?HLrWZFY3XGhaPRqhBp9zFcHo1AxAGv/3Lj+OslzN+YI+mY30O8veSO0f4iQZ?=
 =?us-ascii?Q?ObPoxb9gPidXJSJve4vo1KdMrp7iXWk5U28v874wxBQYqEVG4S4Dc2Uh0fj5?=
 =?us-ascii?Q?/kSfFVhSU9zPFx/rJniJuCFs4SRhqOfcvfJOGVtjzwSuT1pEcOtnZLPv7gRa?=
 =?us-ascii?Q?KwGgLRw0jHB9tAuJHu/96JiJ4YFXigyKLnyRuit/UiWrj0ACmQBDSMWtZ2fz?=
 =?us-ascii?Q?Sb3X716CCWM0mRCMuot91YAVYrpLiYSEtuczZ/tXufRsx6oLn7gNySBTIuQP?=
 =?us-ascii?Q?UWosl+TP5ptyHKrmQmX31Q0OCXblcyAaIUoEMadSDK/XqWwfRcWr6Fk0Vp8J?=
 =?us-ascii?Q?fgdrLf92wKJG+pzbhMHN/Kl2Obz4oY65j44S8qdWk36oug8CDhHRJVQ9/v3s?=
 =?us-ascii?Q?mrrhHJeTWzsyPHvR/zC8yTvVEdqNdpPf/bANb2uaf1OJI1f7Lg0MIk7G7IAR?=
 =?us-ascii?Q?hRjr7DJ1qM9XAi8NDcckOwyvEnhTuIbOUN6+f8VP7FLNgWJULSQuzDfVE1l3?=
 =?us-ascii?Q?L0SPh3SlZHIJ56UWJ1nEzReTLY1e/fu8QkBwtexR0WqWXDMYi5SY20ngG13o?=
 =?us-ascii?Q?nUpUuztACwxClA4rBZnXQE1/WyGdTdU9suCTBF6UVzlfi0gwl7p+OV6BFqXG?=
 =?us-ascii?Q?oNDk7fu9GgPijEXjuKQo/hxN4in19UBN5Lr1lW/kDy5aPHzAQNVQbBsf3dpC?=
 =?us-ascii?Q?0LZ9gfMoNcONxTVDpj3weOSlWc1Ro4SCaEJuWLMIIhnc7D1kweqbvEEIXep7?=
 =?us-ascii?Q?vbcwT5ifT9oPGIOlarWy652spTTDy+WKHaJuhtEla6xAx6I010B1qksUkvPE?=
 =?us-ascii?Q?xxzzcadUeZgnL1iXVM6EAY2UIM1ZeiEmxqOZt6jhqXq7DeM0UU102YcmhKR1?=
 =?us-ascii?Q?Btqor7pplym4rdfPvVdsbR/7Zv+GExydqk0gXiQg4eoeqyuFjd5z09VAjsLM?=
 =?us-ascii?Q?J8/6jCLo0z77J8la5inCAyW8UR+4x34gcsLa2aK1Sl7fND6dpi9y9Dy8124T?=
 =?us-ascii?Q?O2t6FPwUd3KGMBPC/hFESuzs6DA1xv2z1ezKuqARQh34R+43LuyGTC2wVvwu?=
 =?us-ascii?Q?X1n0HSQdJ+aZZL9EjCfdaIjk5Js6/t82kK9S4hmY9VVILPrSbXM86C+MUzzx?=
 =?us-ascii?Q?EGIpFcqIAxwkgXpucy+dNFoBVEfEF6uvEkcFwv7IaZjIkZlkX7EwYtVY+RkH?=
 =?us-ascii?Q?Rxs2jygqRfm2lAwDCfYWsL0Xuysk/1ixIUHzzrsvVzpRrZdzV6Y5iAh4USxt?=
 =?us-ascii?Q?9CuLanL8WJavOb2QhdCMNdENkDtn9i43MYfXkFHH4xOF31w7GN/ChX3+trYD?=
 =?us-ascii?Q?x1qOPxitCpJW35SiIO4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cb4d09-16d4-4a91-75d4-08dcb1cf1d40
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 02:10:28.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJ59Fl3L5OeEb6DS1dGLs+xZXUMUGA+TojRO1kpkiHIdIzGwtnyja8NEIgINuQcxwa8G3wKTTDBENWhPF85DTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10708

> Subject: [PATCH v3 2/2] arm64: dts: Add support for Kontron i.MX93
> OSM-S SoM and BL carrier board
>=20
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> This adds support for the Kontron Electronics OSM-S i.MX93 SoM and
> the matching baseboard BL i.MX93.
>=20
> The SoM hardware complies to the Open Standard Module (OSM) 1.1
> specification, size S
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx93-kontron-bl-osm-s.dts  | 165 ++++++
>  .../dts/freescale/imx93-kontron-osm-s.dtsi    | 547
> ++++++++++++++++++
>  3 files changed, 713 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-kontron-
> bl-osm-s.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-kontron-
> osm-s.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile
> index f04c22b7de72e..c6e82dfe37576 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -238,6 +238,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-
> tqma8xqp-mba8xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-9x9-qsb.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-kontron-bl-osm-s.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phyboard-segin.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxla.dtb diff --
> git a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
> b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
> new file mode 100644
> index 0000000000000..2dfa2381f4691
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2024 Kontron Electronics GmbH  */
> +
> +/dts-v1/;
> +
> +#include "imx93-kontron-osm-s.dtsi"
> +
> +/ {
> +	model =3D "Kontron BL i.MX93 OSM-S";
> +	compatible =3D "kontron,imx93-bl-osm-s", "kontron,imx93-osm-
> s",
> +"fsl,imx93";
> +
> +	aliases {
> +		ethernet0 =3D &fec;
> +		ethernet1 =3D &eqos;
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		led1 {
> +			label =3D "led1";
> +			gpios =3D <&gpio2 3 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger =3D "heartbeat";
> +		};
> +	};
> +
> +	pwm-beeper {
> +		compatible =3D "pwm-beeper";
> +		pwms =3D <&tpm6 1 5000 0>;
> +	};
> +
> +	reg_vcc_panel: regulator-vcc-panel {
> +		compatible =3D "regulator-fixed";
> +		enable-active-high;
> +		gpio =3D <&gpio4 3 GPIO_ACTIVE_HIGH>;

"enable-active-high" should be put under gpio property.

> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-name =3D "VCC_PANEL";
> +	};
> +};
> +
> +&lpspi8 {
> +	status =3D "okay";
> +	assigned-clocks =3D <&clk IMX93_CLK_LPSPI8>;
> +	assigned-clock-parents =3D <&clk
> IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> +	assigned-clock-rates =3D <100000000>;
> +
> +	eeram@0 {
> +		compatible =3D "microchip,48l640";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <20000000>;
> +	};
> +};
> +
> +&eqos {	/* Second ethernet (OSM-S ETH_B) */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_eqos_rgmii>;
> +	phy-mode =3D "rgmii-id";
> +	phy-handle =3D <&ethphy1>;
> +	status =3D "okay";
> +
> +	mdio {
> +		compatible =3D "snps,dwmac-mdio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			compatible =3D "ethernet-phy-id4f51.e91b";
> +			reg =3D <1>;
> +			reset-assert-us =3D <10000>;
> +			reset-gpios =3D <&gpio1 10 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&fec { /* First ethernet (OSM-S ETH_A) */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_enet_rgmii>;
> +	phy-connection-type =3D "rgmii-id";
> +	phy-handle =3D <&ethphy0>;
> +	status =3D "okay";
> +
> +	mdio {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		ethphy0: ethernet-phy@1 {
> +			compatible =3D "ethernet-phy-id4f51.e91b";
> +			reg =3D <1>;
> +			reset-assert-us =3D <10000>;
> +			reset-gpios =3D <&gpio2 18 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&flexcan1 {
> +	status =3D "okay";
> +};
> +
> +&lpi2c2 {
> +	status =3D "okay";
> +
> +	gpio_expander_dio: gpio@20 {
> +		compatible =3D "ti,tca6408";
> +		reg =3D <0x20>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +		gpio-line-names =3D "DIO1_OUT","DIO1_IN",
> "DIO2_OUT","DIO2_IN",
> +				  "DIO3_OUT","DIO3_IN",
> "DIO4_OUT","DIO4_IN";
> +		interrupt-parent =3D <&gpio4>;
> +		interrupts =3D <28 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios =3D <&gpio2 2 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&lpuart1 {
> +	status =3D "okay";
> +};
> +
> +&lpuart7 {
> +	uart-has-rtscts;
> +	status =3D "okay";
> +};
> +
> +&lpuart6 {
> +	linux,rs485-enabled-at-boot-time;
> +	uart-has-rtscts;
> +	status =3D "okay";
> +};
> +
> +&tpm6 {
> +	status =3D "okay";
> +};
> +
> +&usbotg1 {
> +	disable-over-current;
> +	dr_mode =3D "host";
> +	status =3D "okay";
> +
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	usb1@1 {
> +		compatible =3D "usb424,2514";
> +		reg =3D <1>;
> +	};
> +};
> +
> +&usbotg2 {
> +	adp-disable;
> +	hnp-disable;
> +	srp-disable;
> +
> +	disable-over-current;
> +	dr_mode =3D "otg";
> +	usb-role-switch;
> +	status =3D "okay";
> +};
> +
> +&usdhc2 {
> +	vmmc-supply =3D <&reg_vdd_3v3>;
> +	status =3D "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
> b/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
> new file mode 100644
> index 0000000000000..926c622d380ee
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-kontron-osm-s.dtsi
> @@ -0,0 +1,547 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2024 Kontron Electronics GmbH  */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "imx93.dtsi"
> +
> +/ {
> +	model =3D "Kontron OSM-S i.MX93";
> +	compatible =3D "kontron,imx93-osm-s", "fsl,imx93";
> +
> +	aliases {
> +		rtc0 =3D &rv3028;
> +		rtc1 =3D &bbnsm_rtc;
> +	};
> +
> +	memory@40000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x0 0x40000000 0 0x80000000>;
> +	};
> +
> +	chosen {
> +		stdout-path =3D &lpuart1;
> +	};
> +
> +	reg_usdhc2_vcc: regulator-usdhc2-vcc {
> +		compatible =3D "regulator-fixed";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_reg_usdhc2_vcc>;
> +		enable-active-high;
> +		gpio =3D <&gpio3 7 GPIO_ACTIVE_HIGH>;

"enable-active-high" put under "gpio".

> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		regulator-name =3D "VCC_SDIO_A";
> +	};
> +
> +	reg_vdd_carrier: regulator-vdd-carrier {
> +		compatible =3D "regulator-fixed";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_reg_vdd_carrier>;
> +		enable-active-high;
> +		gpio =3D <&gpio4 29 GPIO_ACTIVE_HIGH>;

Ditto.

> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-name =3D "VDD_CARRIER";
> +
> +		regulator-state-standby {
> +			regulator-on-in-suspend;
> +		};
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +
> +		regulator-state-disk {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&lpspi1 { /* OSM-S SPI_A */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpspi1>;
> +	cs-gpios =3D <&gpio1 11 GPIO_ACTIVE_LOW>; };
> +
> +&lpspi8 { /* OSM-S SPI_B */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpspi8>;
> +	cs-gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>; };
> +
> +&flexcan1 { /* OSM-S CAN_A */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_flexcan1>;
> +};
> +
> +&flexcan2 { /* OSM-S CAN_B */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_flexcan2>;
> +};
> +
> +&gpio1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_gpio1>;
> +	gpio-line-names =3D "", "", "I2C_A_SCL", "I2C_A_SDA",
> +			  "UART_CON_RX", "UART_CON_TX",
> "UART_C_RX", "UART_C_TX",
> +			  "CAN_A_TX", "CAN_A_RX", "GPIO_A_0",
> "SPI_A_CS0",
> +			  "SPI_A_SDI", "SPI_A_SCK","SPI_A_SDO"; };
> +
> +&gpio2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_gpio2>;
> +	gpio-line-names =3D "I2C_B_SDA", "I2C_B_SCL", "GPIO_B_1",
> "GPIO_A_2",
> +			  "UART_B_TX", "UART_B_RX", "UART_B_RTS",
> "UART_B_CTS",
> +			  "UART_A_TX", "UART_A_RX", "UART_A_RTS",
> "UART_A_CTS",
> +			  "SPI_B_CS0", "SPI_B_SDI", "SPI_B_SDO",
> "SPI_B_SCK",
> +			  "I2S_BITCLK", "I2S_MCLK", "GPIO_A_1",
> "I2S_A_DATA_OUT",
> +			  "I2S_A_DATA_IN", "PWM_2", "GPIO_A_3",
> "PWM_1",
> +			  "PWM_0", "CAN_B_TX", "I2S_LRCLK",
> "CAN_B_RX", "GPIO_A_4",
> +			  "GPIO_A_5";
> +};
> +
> +&gpio3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_gpio3>;
> +	gpio-line-names =3D "SDIO_A_CD", "SDIO_A_CLK",
> "SDIO_A_CMD", "SDIO_A_D0",
> +			  "SDIO_A_D1", "SDIO_A_D2", "SDIO_A_D3",
> "SDIO_A_PWR_EN",
> +			  "", "", "", "",
> +			  "", "", "", "",
> +			  "", "", "", "",
> +			  "SDIO_B_CLK", "SDIO_B_CMD",
> "SDIO_B_D0", "SDIO_B_D1",
> +			  "SDIO_B_D2", "SDIO_B_D3", "GPIO_A_6",
> "GPIO_A_7"; };
> +
> +&gpio4 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_gpio4>;
> +	gpio-line-names =3D "ETH_B_MDC", "ETH_B_MDIO",
> "ETH_B_TXD4", "ETH_B_TXD3",
> +			  "ETH_B_TXD2", "ETH_B_TXD1",
> "ETH_B_TX_EN", "ETH_B_TX_CLK",
> +			  "ETH_B_RX_CTL", "ETH_B_RX_CLK",
> "ETH_B_RXD0", "ETH_B_RXD1",
> +			  "ETH_B_RXD2", "ETH_B_RXD3", "ETH_MDC",
> "ETH_MDIO",
> +			  "ETH_A_TXD3", "ETH_A_TXD2",
> "ETH_A_TXD1", "ETH_A_TXD0",
> +			  "ETH_A_TX_EN", "ETH_A_TX_CLK",
> "ETH_A_RX_CTL", "ETH_A_RX_CLK",
> +			  "ETH_A_RXD0", "ETH_A_RXD1",
> "ETH_A_RXD2", "ETH_A_RXD3",
> +			  "GPIO_B_0", "CARRIER_PWR_EN";
> +};
> +
> +&lpi2c1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpi2c1>;
> +	status =3D "okay";
> +
> +	pca9451: pmic@25 {
> +		compatible =3D "nxp,pca9451a";
> +		reg =3D <0x25>;
> +		nxp,i2c-lt-enable;
> +
> +		regulators {
> +			reg_vdd_soc: BUCK1 { /* dual phase with
> BUCK3 */
> +				regulator-name =3D "+0V8_VDD_SOC
> (BUCK1)";
> +				regulator-min-microvolt =3D <650000>;
> +				regulator-max-microvolt =3D <950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay =3D <3125>;
> +			};
> +
> +			reg_vddq_ddr: BUCK2 {
> +				regulator-name =3D "+0V6_VDDQ_DDR
> (BUCK2)";
> +				regulator-min-microvolt =3D <600000>;
> +				regulator-max-microvolt =3D <600000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay =3D <3125>;
> +			};
> +
> +			reg_vdd_3v3: BUCK4 {
> +				regulator-name =3D "+3V3 (BUCK4)";
> +				regulator-min-microvolt =3D
> <3300000>;
> +				regulator-max-microvolt =3D
> <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdd_1v8: BUCK5 {
> +				regulator-name =3D "+1V8 (BUCK5)";
> +				regulator-min-microvolt =3D
> <1800000>;
> +				regulator-max-microvolt =3D
> <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_nvcc_dram: BUCK6 {
> +				regulator-name =3D
> "+1V1_NVCC_DRAM (BUCK6)";
> +				regulator-min-microvolt =3D
> <1100000>;
> +				regulator-max-microvolt =3D
> <1100000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_nvcc_snvs: LDO1 {
> +				regulator-name =3D "+1V8_NVCC_SNVS
> (LDO1)";
> +				regulator-min-microvolt =3D
> <1800000>;
> +				regulator-max-microvolt =3D
> <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_vdd_ana: LDO4 {
> +				regulator-name =3D "+0V8_VDD_ANA
> (LDO4)";
> +				regulator-min-microvolt =3D <800000>;
> +				regulator-max-microvolt =3D <800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			reg_nvcc_sd: LDO5 {
> +				regulator-name =3D "NVCC_SD (LDO5)";
> +				regulator-min-microvolt =3D
> <1800000>;
> +				regulator-max-microvolt =3D
> <3300000>;
> +			};
> +		};
> +	};
> +
> +	eeprom@50 {
> +		compatible =3D "onnn,n24s64b", "atmel,24c64";
> +		reg =3D <0x50>;
> +		pagesize =3D <32>;
> +		size =3D <8192>;
> +		num-addresses =3D <1>;
> +	};
> +
> +	rv3028: rtc@52 {
> +		compatible =3D "microcrystal,rv3028";
> +		reg =3D <0x52>;
> +	};
> +};
> +
> +&lpi2c2 { /* OSM-S I2C_A */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpi2c2>;
> +};
> +
> +&lpi2c3 { /* OSM-S I2C_B */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpi2c3>;
> +};
> +
> +&tpm3 { /* OSM-S PWM_0 */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_tpm3>;
> +};
> +
> +&tpm4 { /* OSM-S PWM_2 */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_tpm4>;
> +};
> +
> +&tpm6 { /* OSM-S PWM_1 */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_tpm6>;
> +};
> +
> +&lpuart1 { /* OSM-S UART_CON */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpuart1>;
> +};
> +
> +&lpuart2 { /* OSM-S UART_C */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpuart2>;
> +};
> +
> +&lpuart6 { /* OSM-S UART_B */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpuart6>;
> +};
> +
> +&lpuart7 { /* OSM-S UART_A */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lpuart7>;
> +};
> +
> +&usdhc1 { /* eMMC */
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&pinctrl_usdhc1>;
> +	pinctrl-1 =3D <&pinctrl_usdhc1>;
> +	pinctrl-2 =3D <&pinctrl_usdhc1>;

Same pad settings?

> +	vmmc-supply =3D <&reg_vdd_3v3>;
> +	vqmmc-supply =3D <&reg_vdd_1v8>;
> +	bus-width =3D <8>;
> +	non-removable;
> +	status =3D "okay";
> +};
> +
> +&usdhc2 { /* OSM-S SDIO_A */
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;

Ditto.

> +	vmmc-supply =3D <&reg_usdhc2_vcc>;
> +	cd-gpios =3D <&gpio3 0 GPIO_ACTIVE_LOW>; };
> +
> +&usdhc3 { /* OSM-S SDIO_B */
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&pinctrl_usdhc3>;
> +	pinctrl-1 =3D <&pinctrl_usdhc3>;
> +	pinctrl-2 =3D <&pinctrl_usdhc3>;

Ditto.

Regards,
Peng.

