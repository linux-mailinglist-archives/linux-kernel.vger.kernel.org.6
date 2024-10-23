Return-Path: <linux-kernel+bounces-377255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 393CF9ABC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9485AB2340B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4647F7711F;
	Wed, 23 Oct 2024 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZU/ufe3X"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54075139E;
	Wed, 23 Oct 2024 03:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653319; cv=fail; b=jlsk/POaIBWKglxoZnJjaHb8qRs+TLnkIQ+Ewl+NYXTrrmWSuFRxHEXMGdCslCgy3PtGgErD6VCBJObiG/W6FZiwqsmiZYNYUsZdXjeAot/ZHHTD1H3qFQFa2LkH6Ibr/6v8meGcr6htFowFndpaKDtn3flzm4SM0VfIO7+4rmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653319; c=relaxed/simple;
	bh=B138Udx02ZHSopJo755qb+uZ870MDqe44wKut/AQ9/Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jVfDZVK1iFLPXRavy+MoTyULwdbfdPpU5p40+1IZ9oLZx0iyLeYbUYiIWB4zYjLETMahvC92NfG0+5wxd2vR2xXT365rzt0j/v6yVnvN0ebbaxRyl5nsy2y9cgDZegpBov2nSttxUENqif+shG/4B4lr+CRTK0up0HIyavQkqvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZU/ufe3X; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAuKaw6D4s9liVDXGlVtQLHqRUQSagrL8zqKZdcHGtJoV91ron0z/ufCUloZYOxltd5r91Cwjdse4AtqTZMDCjSe2Dnh/nGVxc6vqTChsPn0JQgcYiGJmB3J7KCZUlVEH1ovITPoKxym6Y1Nq9jcwzTfoTq9KKT6rL2CH1u8o0NxXxMCSajK9iFhPdDmUqa3wY1JbrPCNeahO0n04JZqiSXUI38o7OYS4PoZwmhmk5c1QAuwTs/QeLcQWqRBGJwYl5142IAxzfbFLuSvAtQ3hiBT21EUicQ7T59CzqI6ymnzZVij8xdaMEWeXhJ+IBaClHtMOp/sIaNHnf/BPI0JJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGg4Rta4nS+LBjiI3vvpn62HSsgAt45/NpU+F8ElDLg=;
 b=R4gGyrWWj+aa3ZeZOF3rVfPtjXT41YKboG+ymapLFGNcnbB2PrsTnhQLbTnZdnSgje9E6Hj0Fjoehh5YkN1p3+zh4rZo77L8vJ2PstSsBORpTlHWVhe4wyyxBhPrz9j00BeMbE4CloBbg/DfO3uRLCjaCVZtAUi0V2GDufXL8t0KpBws76cxrVwvYO3NiEhixrlAQIJEint7pOnNU4LrRYMNBFWcOYsm8oEIDwsxjMMy15HH724Up/JR17VMLNHrAa608MCdT6BiYArqYFxmR20ysMzzant64v1gpGZ7tq1R8XRxOGa+fO0ruCL3dHcEdFT9LlWGtdJpcnigCYnewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGg4Rta4nS+LBjiI3vvpn62HSsgAt45/NpU+F8ElDLg=;
 b=ZU/ufe3X9/hTCPVQ7ZCthMhFaRatzUxrE6DzNdULf7leSr5VWJclFIjRUG/ntW6EPSU+vtilhsV+42Mkxv0VPmHBWalIl5zqboiPq3tofyNNhGN18VhlG0q7Box2jOdoTNBlyuN+Ng9xVSppxwfFjb2oEMtDkdBC0THt7lHYTjAy+vACcRdifPcZlKLrFdDekEBNmvn4ConmYydzuUZtzz+pm9CVKsXDtZf9dXDq/WSyXLsK14bG133c7iwu7KLHSFtmDocOoZw1qVc9BauJHGY+YlGRY/pRXxYgOgYcVMLUdY2sRuQ1WM2P6AX9oA2M8cCuizk+oHaENTrvdYn8iw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 03:15:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Wed, 23 Oct 2024
 03:15:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Abel Vesa <abel.vesa@linaro.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Aisheng Dong <aisheng.dong@nxp.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] clk: imx: lpcg-scu: SW workaround for errata
 (e10858)
Thread-Topic: [PATCH v2 1/4] clk: imx: lpcg-scu: SW workaround for errata
 (e10858)
Thread-Index: AQHbIUNzYeaKVcTfX02X9oEy4vh+erKS2wcAgADVigA=
Date: Wed, 23 Oct 2024 03:15:13 +0000
Message-ID:
 <PAXPR04MB8459745D3E1C12A97A2CB1A1884D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
 <20241018-imx-clk-v1-v2-1-92c0b66ca970@nxp.com> <Zxe2vtwKP0hFrPKV@linaro.org>
In-Reply-To: <Zxe2vtwKP0hFrPKV@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10069:EE_
x-ms-office365-filtering-correlation-id: 58e690ea-905a-451d-2c46-08dcf310e957
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?giDR/Ilp/tpMMj+OF8oD65OsIYF/My12sOlC+bV/ck3zVd+ssT1EWvf29CFX?=
 =?us-ascii?Q?yOCKtNAq8WvHCDmDhCPfaC0qjjqW/KPmcZOlB7yLLdflq/+W4T5dT4iwkzf9?=
 =?us-ascii?Q?tmvgzHC/etdoSaSpcynULHDh0Z+VL/7xHBDq7jDDu1VY8OkrKldZV6H6o/v1?=
 =?us-ascii?Q?xsLz3w7OOTC3UNF+aefM7imjDjQ/zgVnNZGiDxjNKeMSP1bvlM1Za3plibx8?=
 =?us-ascii?Q?ny+k/iJVuLDvHjW+L0lMGrJV9e9K6Am+IehcO4YyNGRkn0TQcvif0UC4iMJR?=
 =?us-ascii?Q?OSR4FFt9NJLqSKSS85ci2AQ800VudqghokuXjeDASXY7wfTuC8+X1JNyxI5X?=
 =?us-ascii?Q?N1hq0V1y/zpJQlmsz6eEu9Ekbe0WkIBI/xuUjDFSkqJpU/hxbvs6jZI57zcJ?=
 =?us-ascii?Q?47smgeCYtjQxINAFbcaCpMh+IM2uGZuwtXnFiPq92Q3buhEYv62mOVDWkHaC?=
 =?us-ascii?Q?hEUEw3uch7/rtPebyCT5zuqfpWf2lkqVDOjPVnfJpQi7r0XdiOalitEElV1l?=
 =?us-ascii?Q?l9NZ/WOhv5BFmee6BJpL53TgyymUPApvjPT1BcNyRzKemJcdt/PbOBbDWleQ?=
 =?us-ascii?Q?h5f03dZioJGJzPHZT5fWCxgsTWIx51rh58UXZqjZsUzV16Bl48ZcWpWuwezM?=
 =?us-ascii?Q?ptWYHB5d1YxrpHXvzh9UhhPzcceDgYX/NDnOxvTNLjrbKIEotaOsRAtx9ajs?=
 =?us-ascii?Q?/xAtDAmjNr0Vo6Grc8s1pHWBBrV228j8ahwToJ/XEBvjKOduy3b5ugHwp4xo?=
 =?us-ascii?Q?jmzCZGUc8l4iPeBnPHwhuNYs+teDD4swx7oD0Z04FgxX5J7+5k6mzD7dwUcN?=
 =?us-ascii?Q?d+A3EAw7UTMKuinoxl9nxX6QfeIf1h01ksXTaxgRr3W11pjuEYfr9b3I8zwC?=
 =?us-ascii?Q?5GyTN+eH3lcSrncbwto8vJZyL3j6Z4yIPx3d6bdVHiNB/NXyaBdNNfKVw2MU?=
 =?us-ascii?Q?d1Y/7T5l2K3vSSnGYqOfOFonQdvJrv8Nm76LJjWV6ij0lGRfCgYU0D4UyZNt?=
 =?us-ascii?Q?1udtlzoz8X9ONJbAabNe+WGGpLFWWvd82VK9PeOJQbDjO6Icsvm2dQcL1mY9?=
 =?us-ascii?Q?t0srsce9uXQ36Auwq4SQdgFjktsGmsMwyB+5MHu0STWNZFzmRgjOZQsMSUR1?=
 =?us-ascii?Q?sp8qfkj8qjrkPqwpVrQ5WwlV5MQOF1B2HWaVMy6iY0SLiatQ7Cu02QBspq/y?=
 =?us-ascii?Q?9MZBhwqOb3lhEpVgQjWbrFYRyW3uE30/NZqAGC1UluqU3OuK5dEaz4V0TOVe?=
 =?us-ascii?Q?YZcf4VoUUtsMQ5zOkbgfjb2ziSH5UCUQ4/ChMpL+p/6Rru00JQrmfLqjkPX6?=
 =?us-ascii?Q?16IYmBqWVCvgndRzzI1iARfZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?56VuyAma0qfO4EoKfBDh7hGlTKdFQ6SNksLIgD1e3O4y6BCMOJ2Oxl6Ycn8J?=
 =?us-ascii?Q?75UlO1EcJyToH31je/ZRHwnvPw3EpzTEX961sZBPW4tSPA0vPx6lktRuA1kM?=
 =?us-ascii?Q?avSFq2jDMg9v7zD3dp9gg5CLA7L/EL9+WKrwAWoRQQbKcnHKWmit1VrYftQf?=
 =?us-ascii?Q?BxiijS/i5UhxlzBcPhwFG1TGeA9intd+qIs3dgdUmtMV8Dhx+qO0H9gRCvUX?=
 =?us-ascii?Q?EezW+V1wvW0Ss+w36ki76TCgHGNzbsR3tD2XGz3g2F46yCzl/ky1Zag5egnM?=
 =?us-ascii?Q?vTVAN2J1C5/Ip9wipGVAUZv4FhwSVcELh+Ej7phfZN+B7A5hyZ3qAxdLqdRI?=
 =?us-ascii?Q?cFVaL/qj/U7mUo+CSnj4U1Oe3cnv6ybLeDTEgXAgSnGfL8Q+kJPE7Cuy3dJQ?=
 =?us-ascii?Q?uUuJ7rFTxmpzXVBxb/ZxNuUQfU1kFYZEIwRNouZqJ4tCNYvMpU0xJr6SLuaF?=
 =?us-ascii?Q?XaRHhogj5Qm85uAd6R2vJu1FCXhVG8nxFvVqHsevUXKM/fWWZgdDSVazyl/e?=
 =?us-ascii?Q?pLnFzlAQaJeyhMFXv7DOE3wV2BStGGz/UZpbZQ7AXaKixT0C6vas2fIg8QaH?=
 =?us-ascii?Q?RQE+voHpcvQY3SkLw5vQmC4WkG3Q92n8fKVdYhVXH3ZMS6SvgCFdEj6rB7ut?=
 =?us-ascii?Q?isdg6Ew6rIW+nfc3C2YtcxQvPrTdW0NXwk8mO+A1X2fE/8o5JNiw84mxad8U?=
 =?us-ascii?Q?gWb4190LTzTirv8qWdUcHpjUsNM3M0QynV80FCcQwi5I05lWTdUZZdeI8IHN?=
 =?us-ascii?Q?OG+Oy1PO6Q6ZYi4sQQlpvI/VLtmqbloUiwzzhFFa1Ya5JkKSGPjxDi5/7zSd?=
 =?us-ascii?Q?gOKM32yuVEwzFSwmvH9EY5f00lYwMtn7hV4bETa0VrloEIoSH1OUcpkRAUee?=
 =?us-ascii?Q?7Uca5ipnk1FYL0F8S2wOdMxg9qLmiVfZcIv++kP/tIiFMO7eZz0wjLN6YfD1?=
 =?us-ascii?Q?KK9R+YqbKA0+VlV0uX8QDPuaQrmUGS746NlOKoqTL67uP4/3+6zxEzeC+m5q?=
 =?us-ascii?Q?49bdMeeiAjQwe+kgZHUCoPiNkGzF+CUm7RE2+ip3aPAR1P/PBOZf1nSeqQZG?=
 =?us-ascii?Q?X0e0fH7rPPeA7IYVfe8FYu9hIwRbMqFZgNJyFeqhMTTNpagfWMlAq5uxvjgM?=
 =?us-ascii?Q?75dtH7hsy1NQzxPosL/Lh+Lm11n6IrRVt2SyXuwuaDdzTij6CoUGQ2OAdSIZ?=
 =?us-ascii?Q?2k+ut/7gBvlXx3E0L5/gcWQzfZo9lzxvBD5Cnr7l3R+nPQYdKJ2z7KRU/uQy?=
 =?us-ascii?Q?u87YMwK+AX5W/d8j/AD5qmVpU52R7NTx+E692VyVxY7nHmTnaUtNMCoJYEG2?=
 =?us-ascii?Q?EFqoFBjPDz46ABehe3o1aorNyV0OvHpTTlE0hJMFZP7ShvX2S0+75HsaDdrt?=
 =?us-ascii?Q?3erfenbPTWMI5FIPvPe8aChR3BSN28saB9fN+xZJG+S2hi4Py427WG2WitGB?=
 =?us-ascii?Q?NQJKf9MQRSUmeYEvnbzDHe3bKri2/bD+EDbYMJrgf208Zyo+HqexpudYeQT9?=
 =?us-ascii?Q?0H/ZfnZ8bhiVsxZ666qIYcgteWvkR6As82p0ouVVEwpoVuzKaesbUuYCRmYW?=
 =?us-ascii?Q?EL7qCY0z2Z+sqwl3t+M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e690ea-905a-451d-2c46-08dcf310e957
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 03:15:13.9264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzhbdoxYBWPpkaY6cCGgbw1lirQofyYt0ThZlbnbOqdjqoEivwTXZC4Ho0BP/nnvF5uJHqyXFse1A+d+tSNzhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069

> Subject: Re: [PATCH v2 1/4] clk: imx: lpcg-scu: SW workaround for
> errata (e10858)
>=20
> On 24-10-18 18:00:55, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Back-to-back LPCG writes can be ignored by the LPCG register due to
> a
> > HW bug. The writes need to be separated by at least 4 cycles of the
> > gated clock. See
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> www.
> >
> nxp.com.cn%2Fdocs%2Fen%2Ferrata%2FIMX8_1N94W.pdf&data=3D05%
> 7C02%7Cpeng.f
> >
> an%40nxp.com%7Cbe85b7f113724069f20408dcf2a5eb47%7C686ea1
> d3bc2b4c6fa92c
> >
> d99c5c301635%7C0%7C1%7C638652041660547699%7CUnknown%7
> CTWFpbGZsb3d8eyJW
> >
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C0%7C%
> >
> 7C%7C&sdata=3DYYgvBob0hm1poDDzb%2FEo6uRo1G29a0jmhqzhwr%2B
> Hzcg%3D&reserve
> > d=3D0
> >
> > The workaround is implemented as follows:
> > 1. For clocks running greater than or equal to 24MHz, a read followed
> > by the write will provide sufficient delay.
> > 2. For clocks running below 24MHz, add a delay of 4 clock cylces
> after
> > the write to the LPCG register.
> >
> > Fixes: 2f77296d3df9 ("clk: imx: add lpcg clock support")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-lpcg-scu.c | 35
> > +++++++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-lpcg-scu.c
> > b/drivers/clk/imx/clk-lpcg-scu.c index
> >
> dd5abd09f3e206a5073767561b517d5b3320b28c..cd42190233662c6
> 6f2c354f0a2ee
> > e3a2531eeb3a 100644
> > --- a/drivers/clk/imx/clk-lpcg-scu.c
> > +++ b/drivers/clk/imx/clk-lpcg-scu.c
> > @@ -6,10 +6,12 @@
> >
> >  #include <linux/bits.h>
> >  #include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/units.h>
> >
> >  #include "clk-scu.h"
> >
> > @@ -41,6 +43,31 @@ struct clk_lpcg_scu {
> >
> >  #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu,
> > hw)
> >
> > +/* e10858 -LPCG clock gating register synchronization errata */
> > +static void lpcg_e10858_writel(unsigned long rate, void __iomem
> *reg,
> > +u32 val) {
> > +	u32 reg1;
> > +
> > +	writel(val, reg);
> > +
> > +	if (rate >=3D 24 * HZ_PER_MHZ || rate =3D=3D 0) {
> > +		/*
> > +		 * The time taken to access the LPCG registers from
> the AP core
> > +		 * through the interconnect is longer than the
> minimum delay
> > +		 * of 4 clock cycles required by the errata.
> > +		 * Adding a readl will provide sufficient delay to
> prevent
> > +		 * back-to-back writes.
> > +		 */
> > +		reg1 =3D readl(reg);
> > +	} else {
> > +		/*
> > +		 * For clocks running below 24MHz, wait a minimum
> of
> > +		 * 4 clock cycles.
> > +		 */
> > +		ndelay(4 * (DIV_ROUND_UP(1000 * HZ_PER_MHZ,
> rate)));
> > +	}
> > +}
> > +
> >  static int clk_lpcg_scu_enable(struct clk_hw *hw)  {
> >  	struct clk_lpcg_scu *clk =3D to_clk_lpcg_scu(hw); @@ -57,7
> +84,8 @@
> > static int clk_lpcg_scu_enable(struct clk_hw *hw)
> >  		val |=3D CLK_GATE_SCU_LPCG_HW_SEL;
> >
> >  	reg |=3D val << clk->bit_idx;
> > -	writel(reg, clk->reg);
> > +
> > +	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
> >
> >  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
> >
> > @@ -74,7 +102,7 @@ static void clk_lpcg_scu_disable(struct clk_hw
> *hw)
> >
> >  	reg =3D readl_relaxed(clk->reg);
> >  	reg &=3D ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
> > -	writel(reg, clk->reg);
> > +	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
> >
> >  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);  } @@ -
> 149,9
> > +177,8 @@ static int __maybe_unused
> imx_clk_lpcg_scu_resume(struct device *dev)
> >  	 * FIXME: Sometimes writes don't work unless the CPU issues
> >  	 * them twice
> >  	 */
> > -
> > -	writel(clk->state, clk->reg);
>=20
> Now that you removed one of the writes, doesn't the comment above
> has to be removed as well ?

Sure, let me remove it.

Thanks,
Peng
>=20
> >  	writel(clk->state, clk->reg);
> > +	lpcg_e10858_writel(0, clk->reg, clk->state);
> >  	dev_dbg(dev, "restore lpcg state 0x%x\n", clk->state);
> >
> >  	return 0;
> >
> > --
> > 2.37.1
> >

