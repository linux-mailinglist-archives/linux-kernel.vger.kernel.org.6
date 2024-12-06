Return-Path: <linux-kernel+bounces-434660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A8F9E697F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40086281FCD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67AE1EBFFC;
	Fri,  6 Dec 2024 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KxS37MXw"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2089.outbound.protection.outlook.com [40.107.249.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E51E102D;
	Fri,  6 Dec 2024 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475545; cv=fail; b=cy1Ak4jqRzWa9dvJf1ui6/Pwisc2RdwTx/e9p3yb/LOd0p4Kv5b77lII/r46ZdGiIx2mz+YUsY0PFrln/BevWjU4/4cVkbOt4BKqDPGV/xUQyXrTBXbl2W6LWKcK8jcx20Y2asCSz0jv9YTcB7e5snrUK65st9GjMJ9saK3dr7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475545; c=relaxed/simple;
	bh=GlKEi0zKyZhQHy+dOeDH7TPBvnN5lEg3X/J86aZufZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bA0ia1cQY3SPOqQMEfd3PDw+94agnbmveOvuu7DuG9AbelVJCefn+aR5iKtIgwGy40Sot2gYfqV5KjoDt3+tvBamdS2aQisdprNSKQ1L68i5Hes1G5PChTl56kNnzxWxhhTzKaR2qstoui7Mg26BKIBUIO+cWtWfRraVv59VLks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KxS37MXw; arc=fail smtp.client-ip=40.107.249.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r64Su5pqC8ZPDio4rqOmO31jY1EVfj12JHLGGNkPlbedylwjXEITyzS6b7cZSeGQhzLMHTdPxvxM07o45c3e3iQX8IIAJevPXU8jZgvnxt+/PCMm431WHEsJBuMPXMFCs5Yuqt5vhIpvGOS994hU16c29N6+zGgbbFR5ID68QpJiwCe7uLDSE+PZsXUWB51lSrjnxiGKGo6rL58rPk89V3Y1kC5eQ3GjtuDI0oalou+xfIsP16GP5ZcXNBoq6f+4zTczPoPhlLYMKqWAOcO1YRt/ucY7EcUYHrH/UsDV3ffYXzLZbwCZetL55mfMyB3YXXhws+MPswP8qkSGcKS4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlKEi0zKyZhQHy+dOeDH7TPBvnN5lEg3X/J86aZufZw=;
 b=oz1mTUZcZyjvde7KkgNWdxWgPv9lguix1V2IFmPQiGnCTW/LvKqBJop6yECrDx0B0CWhFejBQx/5HeA7gnsowm6Kjj5uKo8bvmi4tFTlEh2d9CRF9Pfq0vT9ztKU07M/HsxxiwdQsyC+kVyP++Qfgeh/bDMvB5VVwuNNZo/F04ULJGojgm7zaisD3nQfluJ+lLqGVNiuPpIWzo8CmQvKd/Tuh5yu3uZjBrEgPzqUwFcTW9sDVPPi1aHqzpExlx9r7Oc9iZlICWxN37uCks3rPqoYrD8m1FfI4ErOo6GQLZKXshrIVJGLvFT+8kEAXm7HQ6kxUD0UK8McymF146qClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlKEi0zKyZhQHy+dOeDH7TPBvnN5lEg3X/J86aZufZw=;
 b=KxS37MXwbpNH1TfiwPL3WMG68vL7dgHp7e5ZGwCoM4/X5JiWB4iPcIKJ7fruVYm+P7Mh0hUsk6Kaqs0n2qT8t28zezAB3Tek1a2xQPT3YCJBWCd2hQkKF9z5w5Ez7Tfwp0/LfkQBZ5roNpyBuMdVJTQ5B9Z6FyU0kdrD2GVGDmneAEz8eyAL4isl8tUmoKaf1QCTu+1vTuvb5Xwx4KGLq4Z4E9+tmc42TUMkRffOkZFXvZu0o/3XDXNgfKbHBBlfLW+uIQiFFCDK5jVfW+mNirVRuDLPwnC05XpO53znKsntrcPYclHuDyuxmgHDcn/L8PirouFVIfNh7KWUu3qvQw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10727.eurprd04.prod.outlook.com (2603:10a6:150:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 08:58:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 08:58:57 +0000
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
Subject: RE: [PATCH v2 2/2] arm64: dt: imx93-tqma9352-mba93xxla: enable Open
 Drain for MDIO
Thread-Topic: [PATCH v2 2/2] arm64: dt: imx93-tqma9352-mba93xxla: enable Open
 Drain for MDIO
Thread-Index: AQHbRydzocyWH2/tK0K6s4w0HcY7MrLY65Tg
Date: Fri, 6 Dec 2024 08:58:57 +0000
Message-ID:
 <PAXPR04MB84599E8D7322514C6645651088312@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241205150730.3132807-1-alexander.stein@ew.tq-group.com>
 <20241205150730.3132807-2-alexander.stein@ew.tq-group.com>
In-Reply-To: <20241205150730.3132807-2-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10727:EE_
x-ms-office365-filtering-correlation-id: 1f18d5cb-6256-4040-6e9e-08dd15d43845
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fKpnaOvDJeWtaFV7sUUIICyyEJT2JNHlXXAZlekKKQdAtSkTadwjqw6y38nq?=
 =?us-ascii?Q?RN6gWS1iI3RIog0D99HwkUsP05SvLNxcbTr2BEmOzJHt2jOO5PUSR+HZXkiD?=
 =?us-ascii?Q?gdBOdHHg1oVNSlwCkjLiokdUzLHSEcpVQ8jjLfdOl4BN0J4ApHBs1tD5ROZz?=
 =?us-ascii?Q?5MpxlUY1EnrtUDDcDk7ylsx2q5kH8s+ODh7Bq6x5WzBlwEDmuTw1+LcNJSql?=
 =?us-ascii?Q?v85oIqv6p6iYsmOXNsQqIgbbHGXgEBUesRG8vq39lj6gCKrZXFksOsAazHai?=
 =?us-ascii?Q?WLH3fTRBUv9BRBJ/lnl82iqmtTxFBeeUVSVAgOSoZMkVYGL8oE9z8mbNwBED?=
 =?us-ascii?Q?XLiGJ/QVm7AlrQLae/RtjVbYZo2Kiy7TnUtjqTvM+tJXNM07dx/QQ0S+zdUL?=
 =?us-ascii?Q?Ou8wEV3/Nfqq5l68oBGlxeQgsjcZM1p3WJCLWe/7QVJWdiM9KjBoTl4CHPIM?=
 =?us-ascii?Q?x5NvXHm1mqCFgTLxQtZMgsYKnswOEb4Ty3Mh3xwiFNouXEHDZgsN02eKqmh7?=
 =?us-ascii?Q?5JYwtdZjzd4eVlqdjLZ4InVfqSCaOZdz0v1ePQ3ClsIcmGVGAeqcV+YCPRbS?=
 =?us-ascii?Q?k0T7uLDCMLI8keYAGTvPO6FbHDIxpyPlyoAYduKHNW761m3xfRajiUTHaAr0?=
 =?us-ascii?Q?eRLyYU0i/TvCAd/rWdZ7U0iu3FjC44DnhovMID1GWPUA1OEsEgENdhLd7kwK?=
 =?us-ascii?Q?shImhtBkbc5WgyjpCYgVn0NEBDr4wyu2hGg5OhAhCw2rKdvqWYRzopg1Y55i?=
 =?us-ascii?Q?B5pNtJ6XNjYef+zWYZzMhk0XAxrx+MQAriAKy+EHQNbRLaW9vdwPD/tKFAtv?=
 =?us-ascii?Q?GmhDb4MjI2q5scec4gCRb/Izas9VolyhXzx8QcOKldS7xKvDPB3n6Bu0Q0K4?=
 =?us-ascii?Q?gnIh87Ot05wHEadJhBi+ebaWzrXHhTUOXQaSu7AzfNPbQtpgdMDLA6LfJZXC?=
 =?us-ascii?Q?2V1RGPukKltCMZHf5I96Z3tBtv1Ote/br8NlOZC4aQ+/ia1qfVIBGl/TFDfB?=
 =?us-ascii?Q?V6FYuFehw5iqm6DSOCX5sb8jDDzOEQiwfOkFbLwhCssQuTDYw8ZMf+QeGvlH?=
 =?us-ascii?Q?xoGuaZZBZkM50YF9DChDi60I0X0PGsEREY5IEA+BDLw5khER2SPnFv7wfAPI?=
 =?us-ascii?Q?j45qppslVBL7NRCLPa/Ix5k6RN917QaBeBJaWIlqhNZU5cY2dLzNsxVNH6F2?=
 =?us-ascii?Q?jIr1izDZjC1YXEs7SeTzRCvG/GE6qU3S0EwkrZM8FL4KtJjzk5o/7XqhTwK3?=
 =?us-ascii?Q?QJ0UFy6SAyyuzXE3jWIgPGXEHM8XiAU/GsIELqpeJ3w6KD8o/xciYsAYrUUE?=
 =?us-ascii?Q?46p08WztBTASFwwCDubaNsVLi01wd6oDBAH9R9phQPJlJlkQ/JdD6zabUULr?=
 =?us-ascii?Q?HBOuan2i38Av2sswRRk7d2GnhxRdfRRMyYcXH/Rx3s89ELRRmw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ghJNad8IfQX3h0VH+GSOxvMdc+4E+hJJmUu5D51Es3mum5x+EJ05cIwyhwti?=
 =?us-ascii?Q?x83X25WPnotLn6VtIFrHip2Zv0d5Q2REYuQ3nKvQFaYSDeT/Yf0ZkHCd0/nr?=
 =?us-ascii?Q?mxmcywePJov429iTLziNHaG+SlC/lIQJiSHVuALX7torWNjZAnoRFYpsBM7E?=
 =?us-ascii?Q?liEX5LHzMxtmxKInzKSzbpk+TmaA9OINw3QzR4v3OeiNY8OPCnwRdF2pqQcw?=
 =?us-ascii?Q?+aFfwFchR03LIvbIPjDkTfVA0JOubNsjrnfUblvnkcG243PRWSh9K2/qSI+M?=
 =?us-ascii?Q?5bNVIXO0YNBlC6tF/HAIvCyzruEao0fRF53xHtqVtMUu2KzAJLmZCby51mO+?=
 =?us-ascii?Q?grEUJl6tBxu8QhJHxKqQD96yYCH6dxSUmom8J0q5yjlmbKbFMLRnLpnh9K7e?=
 =?us-ascii?Q?K0URXtjFQrIBB48Ytv/hnqQ51kAeFfNLOqbKg2sLQzB/wmQifqc/ogtEX11t?=
 =?us-ascii?Q?uGYb6kdWAlft5kUsQ1O10u5BKZiruTCr5rdAhRaUkYHMra6nyIkY349U77Ak?=
 =?us-ascii?Q?xKo4ioS/sD5ZVaEwKwClUqdNv4kr6V4Oa0EqaORhrvz+HgVRrWvuNHoJmff8?=
 =?us-ascii?Q?MfQdbrYhbhO0P9deLBuOo7vKhzV1fyfZGoyBzR806xldoA+XiccAgJv5O3Ct?=
 =?us-ascii?Q?jWe80H9QhmSFFMlct5jnJvfjIHB3oaOzKdfSfY9X2JtTP7O+ikpT0yb6Q2nX?=
 =?us-ascii?Q?iBQMZuYeqI0B0gF7Ga/6MU142lqmSje+5lyA9IQJiQ3ixMokFo8U1YUQmkpi?=
 =?us-ascii?Q?LvkAjahu/SYIebLJmXRRVxt+ML5EfiA5LsptHgBRGQmTyafwFtsfZ4DOvv6L?=
 =?us-ascii?Q?k7iv8+ZBtCpqv0GrbuJoeG9QcwkWrYUJn/FSL8pc4jPwgJyQD7gp9qwb+vuW?=
 =?us-ascii?Q?ATX89kTCR0ZYy2vnxR8vqGVCrz5xFdWVVDrRG0v1Er9NyCCcUEwAFxR5CWfK?=
 =?us-ascii?Q?9zBUvn+n9Qk8SmFV7td14tHMe6iqf3Pd8ZgcijVK/+uBHE3n8Bnmy90Y8OLy?=
 =?us-ascii?Q?vYX0sjR6sx+LB5tM2qzWzdXvtBTWYEnY6EuPBSsXXAOXNb1GZITFQhzJjdgu?=
 =?us-ascii?Q?eUSRPmQNPuyJ51C3Keo9sWV3bXf9wcUYftQeRkG6gIhMfiBABerVj4PccMZg?=
 =?us-ascii?Q?hQtUjnt7NZ8EtR8EewbtV8ke8nTF7VTuH2fTSoIDKX7q+Kp6GFD+3O1tl3aW?=
 =?us-ascii?Q?OLC26TzZebFqcDf3m1yDsHTfh/F8clJSU+u3OPpqf+ICgp/xHeeJsvl7AQTL?=
 =?us-ascii?Q?3bLvYhlN7bNdZWmdjpDljZXVLBxzn5onshpzLaxyQB7a8rLyQfRkBd4eM1T6?=
 =?us-ascii?Q?fX9HQi/3sev8cPEs5ocJ82U69SfyGFO/QzwX9lnC0m7LeABnK+2pbu187Qhs?=
 =?us-ascii?Q?BMOjzfK5mYX5SWXTOXUt9RLSU9RPkoLD3qa3X0xII3QJ+m4Qrwhu5DJw7428?=
 =?us-ascii?Q?AY58J7fVw43BVFtc6Dxor39t+UVCqOQWrkpI0gLOouJ2nmYX8gIqAw/9X6K2?=
 =?us-ascii?Q?+4KjIcSNl/VEfQq4MYG07/sHYGGWcyNEkwnO+FmGgSffbMw6ZuopLECEWa5E?=
 =?us-ascii?Q?9ngDBb7cJcjuEzfzZG0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f18d5cb-6256-4040-6e9e-08dd15d43845
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 08:58:57.7360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YK6PJxsimngY5a4TrJOeAsM4odC0RDKQXGAwZ2+Ofwu37IDTWXSTbWXlGWPyxxs3OojV2l1rNI+jaSdnMr7Zog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10727

> Subject: [PATCH v2 2/2] arm64: dt: imx93-tqma9352-mba93xxla:
> enable Open Drain for MDIO

s/dt/dts

>=20
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>=20
> The board has a pull-up resistor for MDIO pin per PHY design guide.
> When MDIO is idle, it needs to be high and open drain is better to be
> used here for power saving.
>=20
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Besides the typo:

Reviewed-by: Peng Fan <peng.fan@nxp.com>

