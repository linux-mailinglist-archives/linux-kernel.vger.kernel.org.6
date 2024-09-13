Return-Path: <linux-kernel+bounces-327526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E21977724
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6438282C69
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAD71D4147;
	Fri, 13 Sep 2024 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CEubOo4C"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83B1D31AC;
	Fri, 13 Sep 2024 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726196110; cv=fail; b=NlRJkpFcoQmdlroiMoi4mNDwtDCqFnk10jKnbnih1E8mkl5r16/M8Ira9Wr3hbVjOmL15nNsIqsiHo5+ZHeyrgq4rlyfUzyIH3emFjXW7ieHTOcrTB6iQLSEosX7aKTgWigLWYFg3FJU0w9DuWHi0Cxlg4cKlgi01hfQ24RRcL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726196110; c=relaxed/simple;
	bh=gchrMsZT0X1TY+9S7qCTyCngdMU1xk12DaS+IQtSrxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OLU8WRwfwHXYryN9fFqKvQtiMIbRfjvObxS5fyZiaDdW6TmxSn4y9+mYsSfXB3DCyBFIMDYHL+eagH/9VfvivsIETa1ttZuPH8QuJt4E1UOBcAZjzpCoKy6dMOn0jfjCM5EPLqdsr6WlCWq0FiVjJVD+DOZjoYlnEOeg3DPAiTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CEubOo4C; arc=fail smtp.client-ip=40.107.105.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbLXzIFgMtMtRFh+A59zbzWhRco1sJ9i7DIcWBvpSS6GmXU1rQcjj23kiF7xhccIBYOG4EGlckYsrqp8YFa6FJDJloU5YdTk220hJ1a8WtNGMIlpIiBpUGAZkK5sPQHK575b1tRlGIid7qJVfQfNz8MWJQNrZQo4uDxA710+kuFOrOuJmHgaU4Peg7rOwVW0hfNuozXiir/lqWd4s1Ua/0n8necFNbKC3IIpGSWld8nLhpXOtbyzjxgEkNod6jwdhiT4f+e5ZrqzAF6mX1CqeFUtPJzVGURNAGNcFaUJ3OIeiNNq5R/5iX9kBI8kD+oiUkvFfqmeTyBJiEdXkKryRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnNSbE0GT6ujAMlQGALb6vMtOJ8ASnSE+Am/XfsKyfw=;
 b=H3QyWw8OOhYWLD3fdM4VXAuXUReR1fuRynylOMSKiEEOgV/JfXbgy+394GebNsTgn1JWR+tcIu05Uqsm+dQXLWSf4DPcqr4+6ApneS3BseA/ggnd4Fvu9rxyw/9azzyL5Yby26zLFGW0YlP5POzUbPsp+Mex+Jux4WBrlSY2fzAP/Lt/+RCRAHZyJbzJFVYmh4DHb592f0tiD5dgLwUM8qjcBgJCcDoXkjAoWSzxqm5WuBqasMDjE4tGGsk4FWZLfvg/4ZF6fiOf3nHct3ySPfh7nTOoxXi1ZhO9O8B5lBvDkXdsBHDtgLtqHWhgS+y+TzS9eBS2edsL0Q6lc54AZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnNSbE0GT6ujAMlQGALb6vMtOJ8ASnSE+Am/XfsKyfw=;
 b=CEubOo4CaqTXBetzpM4CQe+kEumDyzvU2u35+sm0PoaDCh+rNQjBEAK+MPoKh1yncz0pexeovqB30ieqQTN4GgEb04UUi9FKM53kit+rarwlCl4Y+v3DjhF1XeIOiMZXk3RC1fqjGAWBOFcWveSxw0h4GnGNimFfBMAelNpha+6pBoX2TjXEHHT+zBr9SWgekj+TSZ5rWbZr03pFR3ZEHhHtjXG66/rpqwtvqKhnKPcPbU4GtVj70LUcCbBZ3qgZGvpEA9/v/M4qDFMt3Ufvwa0h+cLidkijkXmYN5wE/yOWvJQxECZWdX0LsQ2o0dAziX2L8uYTIvEqrWlqttYIiQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB9732.eurprd04.prod.outlook.com (2603:10a6:20b:672::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Fri, 13 Sep
 2024 02:55:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 02:55:05 +0000
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
Subject: RE: [PATCH 2/2] arm64: dt: imx93-tqma9352-mba93xxla: enable Open
 Drain for MDIO
Thread-Topic: [PATCH 2/2] arm64: dt: imx93-tqma9352-mba93xxla: enable Open
 Drain for MDIO
Thread-Index: AQHbBBpE95owr1E/sEeLTS7n6Sh3b7JVCGWA
Date: Fri, 13 Sep 2024 02:55:05 +0000
Message-ID:
 <PAXPR04MB84599A28E69DB3B404DD07F388652@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240911071359.2971191-1-alexander.stein@ew.tq-group.com>
 <20240911071359.2971191-2-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240911071359.2971191-2-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS5PR04MB9732:EE_
x-ms-office365-filtering-correlation-id: a30c6ce0-3d1c-4590-0c2e-08dcd39f78a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4n27WdxYBHdR1tp5EVW8Xq7qRyVO+9Vg5WpwHTg8l0tBUER4BZXJMkSlJ8Ec?=
 =?us-ascii?Q?dyfiSGnQij6O88uf7g285tGO7UJzvq1EJFN56nG0bxUkKCNZ2UfTq/Z3Ll/G?=
 =?us-ascii?Q?BSNXLg7LXwvRuSF/2m1tKp0eNSyKODjgBzsXWPumewguMzbF4Vb285xVXJ+H?=
 =?us-ascii?Q?WLncAI/VIoTYKCYQkid7w+tCQelsDhIYRZcGA7SaGScqoXIFqHrBlq3JIM1u?=
 =?us-ascii?Q?BHygj/o/RyASN1Qa8SSXxqTsr2aMxAiOej1B0h/TqWgt7OtndlfXG7/XUVRE?=
 =?us-ascii?Q?HkY6hFfl9jxMnxXMt2IQqsIPTvOYdxrcObVbWt7ODZMsuoAwaaZ+DAMNUsq5?=
 =?us-ascii?Q?kHvlimnhmSnknNs9nKt5N8NzGz4WvKYkiIGKLbkMXRDwU61F4ed+sIIWoabQ?=
 =?us-ascii?Q?DxllhAKxV8T5WUAzkiTzZ3BlS6oWmPHU0cfhqb9Y3+tjG4TRnTMHtJ5t5cAP?=
 =?us-ascii?Q?7X70LEBg90W5KW9wQgqQSXxDGLOUFoDow5VDj2jd235HIAPuAzeKnH7s0pjF?=
 =?us-ascii?Q?1LON6M5qR32ujM9RnyX62rka0DNdujpKZhENA5RFyKfYWTUgU0b2pzG1xbDh?=
 =?us-ascii?Q?tyVD363GKKFlqZzOBumNDVP7oTfpW0M7LyrXrNriEHwS4cCgzYWhdvkXApT/?=
 =?us-ascii?Q?Tll7YDLAYg8XL8gt0QKru+YHjDrO8t9p+sa9GKMMn1iU6DtMgQ5cpME8dWo/?=
 =?us-ascii?Q?S0Fuw/SK4vuqSbC41YqEVliYPMevK8xMWjgf/ARihtxX0+s2t/5SDsbYOKOK?=
 =?us-ascii?Q?jMvufTyMWY3xSal81og+1g2TMwDLyrESwCew99iY1RgG6Zkl5PDkX1px5nck?=
 =?us-ascii?Q?S0dSgeUPiU+3u865pUCVo70ltlWt1frRsAwar8qJY9/TLsGJZw2P16Jr8rSd?=
 =?us-ascii?Q?XGPZVSTvWZ5RkoFeVezTxB5DH7hwiQB7RmR+TPoNjICA7r69QNo1vhudooKs?=
 =?us-ascii?Q?sWAZ/7H54pojRRz4MDeqr9MHEewFmw+OQnGMsBUM4Q/sd6+yuAT5k14kvhlO?=
 =?us-ascii?Q?rh3IQdV6dvmt7PMGeTR+UljvnyCzMt7S9QxzrpBsj5J5LbkBp/+t2OfHgGt8?=
 =?us-ascii?Q?DyD3VSSVgps7iF7CvA1GWRLPS183p7XqA/7xmcFZUFLxT20CQgkx4dfD4zFy?=
 =?us-ascii?Q?DHWvI2UPUWMeOZvrzMZIHlHNyOcczRt+NImzpHIIBaxCjlA5ILvS2wRRCQaX?=
 =?us-ascii?Q?yR8s/ZC/LSB/2vuFZpuq83MQIS5I8AApeDSQDEibhg8JZc3Bku1ev837UehH?=
 =?us-ascii?Q?JNlxCOTYWe7i1AdbAFgIW+uPKszj6uRXm24Euk6QvRY/DsDw1zcK85VMF9yG?=
 =?us-ascii?Q?+pxoUifHSEfAlD03fGw0/sRAWUJsb1152LSxFOpsGrQiY5qV1VpRyDKXA+1Q?=
 =?us-ascii?Q?Ucl9hstOuH/l0e2+WGpQ4YW1T+SrUjx3XJWVhZTeCFg2YocZoA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zonip5/g5s1vOt77UJXcR0FLvrw3oVAuVaYfxC80cqlQ/HNQQWCJ//fKHMV9?=
 =?us-ascii?Q?csjdfL0C5qnsXJ2v7NZ96g8kjjhKchdXbI6hBosviF21/2YQnCTltEkjCXsm?=
 =?us-ascii?Q?5q/kS1JPLHDeM+iQyv8ZXNh+nFV2w52/jbMznFUyXsajjNeHZmrPhBKhAfb7?=
 =?us-ascii?Q?0BubLbmHQwwO+G/fH1U00UtYGukRZi/FqN2vSxF6F3diMZ0g0sjaB75kOq5l?=
 =?us-ascii?Q?g/q4sbtNIgH2OhyErUgG7FceHC9QK0Dpc89Ic6ZZ5NeTDOowfY4xCGWf6w1T?=
 =?us-ascii?Q?wd8zbuuZh2+eMqMb7RoDq1dRSPpcGiNTVWoLJfTeuyMXR4c9iaGSENvoJLmb?=
 =?us-ascii?Q?A6/xxHSGN4bhBCYhe73iUpetp8vRU5+7EUh8UAJU70875XkUyD8hz+OnycMS?=
 =?us-ascii?Q?GM5SckrUr2CqaWp/Whw4tKtfs/Dby099JjbU3mzbnGgVTbuxMaYrq33aQhmP?=
 =?us-ascii?Q?JopU9XrDtymXbhXKY6Bf1IXgBy1rO5VF6ZuxOzdn8ld/CWRpwxIt7N/zP0qW?=
 =?us-ascii?Q?a+ZY6YkoFBrAibAM09JI6vTlyE1sOVKxon3bwLvom/YUykRPYxlPdneTbZIO?=
 =?us-ascii?Q?+JgAdGwDP+XekvDhtWpLndY7kKCYHCoMBj96CY458qIOjAdgyrZb+JHyN1pD?=
 =?us-ascii?Q?TllGX/cXqLFP6TBE1hhNS0BfvpIICbwb6hqzT+l5sa26dSoF4efNpjR0lu0U?=
 =?us-ascii?Q?38Ua3TcF1yDGX1K+TGaS0ThPOXCFXA6B9P0do0hUyZsp5TmZ3rOuGeRO+v5r?=
 =?us-ascii?Q?BM4G4PieqFSYshUx94faEsDuJzfn3ZvHNRzBLFlVmsLKZwNVcrfaGmwQBbzz?=
 =?us-ascii?Q?h8Ec8aeqDwfVHjm0mlVoi2eYRW+1NNbPXn7vS7OSwnOGEbwO2sDydx7oAgMV?=
 =?us-ascii?Q?QKpjO2VxnjV2f2tUfa/HfT8PGTwcjvWt5Mx9W2Afo/JLc5lHXDeMDpp3Rf4Y?=
 =?us-ascii?Q?/rCPRYJpX2m1Ki5jk9nOdPbLTzazqgOdRUe0g4RIBvKo67QDgL3XLPR74HWn?=
 =?us-ascii?Q?AI12P3064SQloA0zPLic3YNcaWco7QL93nRwDnbMGMePYMsCaR613cTFlmvE?=
 =?us-ascii?Q?SXKtGldLOf/qPQfMPAuvvH4w4uk3G8XhV1WyfBqz4GxydWVlZMw4C9Ss0yvG?=
 =?us-ascii?Q?mTqOyRp5BOZ+U4bIJ8TFwk3qof+m3dWxRC2me3BaZw/5zpiihBOrAOCppa0w?=
 =?us-ascii?Q?P3zbS4UsEGVB2Y5g2u7Xl6Wc/bfK0QzAejd6i8MSBZN6edZ2aHie59gTRkDF?=
 =?us-ascii?Q?73N602c7Yjznk5bBvboIiyz0yDJqUnwJMiWqoUc3q4uF2N+tEpJOXxSmLUhB?=
 =?us-ascii?Q?PhgaDBBvj17TUHJGzb2KhTfw4xK2iE440PpcuUCimW4JnHSG5/RpsZpzeV2M?=
 =?us-ascii?Q?uA5rBcqvoDF67EOd4QqtBhOV4O987ReOvyYvsiNmXSGRX9OiIVtbJCH6vOT3?=
 =?us-ascii?Q?P+fAWmwDsQbAPfYOBpeT3a9ax7Mr3f31LzAGuP9SUqlj3wJdD4IbSNRLQRGI?=
 =?us-ascii?Q?c7s2JpQkPXNcxfly32kfyD7yGAZ8AXQbORSJQlsIVG8+gDLUJGI0b8a7vx9O?=
 =?us-ascii?Q?SiocuG5kj0OZuW1tAE4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a30c6ce0-3d1c-4590-0c2e-08dcd39f78a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 02:55:05.6937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73FTvVWPdvdVXDvMbESIuKiOYS4RMEgBGqmHVJCPcn7kvaTZy2jW6cmwUWNGK/y5IJgWY7ICC8koGzymn9K2Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9732

> Subject: [PATCH 2/2] arm64: dt: imx93-tqma9352-mba93xxla: enable
> Open Drain for MDIO
>=20
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>=20
> Follow suggestion from hardware team.


Same to patch 1/2.

Regards,
Peng.

>=20
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts | 8
> ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxla.dts
> index 0b4b3bb866d06..2e953a05c590e 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
> @@ -597,8 +597,8 @@ pinctrl_eqos: eqosgrp {
>  		fsl,pins =3D <
>  			/* PD | FSEL_2 | DSE X4 */
>  			MX93_PAD_ENET1_MDC__ENET_QOS_MDC
> 			0x51e
> -			/* SION | HYS | FSEL_2 | DSE X4 */
> -
> 	MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO
> 	0x4000111e
> +			/* SION | HYS | ODE | FSEL_2 | DSE X4 */
> +
> 	MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO
> 	0x4000191e
>  			/* HYS | FSEL_0 | DSE no drive */
>=20
> 	MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0
> 	0x1000
>=20
> 	MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1
> 	0x1000
> @@ -629,8 +629,8 @@ pinctrl_fec: fecgrp {
>  		fsl,pins =3D <
>  			/* PD | FSEL_2 | DSE X4 */
>  			MX93_PAD_ENET2_MDC__ENET1_MDC
> 		0x51e
> -			/* SION | HYS | FSEL_2 | DSE X4 */
> -			MX93_PAD_ENET2_MDIO__ENET1_MDIO
> 		0x4000111e
> +			/* SION | HYS | ODE | FSEL_2 | DSE X4 */
> +			MX93_PAD_ENET2_MDIO__ENET1_MDIO
> 		0x4000191e
>  			/* HYS | FSEL_0 | DSE no drive */
>  			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0
> 		0x1000
>  			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1
> 		0x1000
> --
> 2.34.1
>=20


