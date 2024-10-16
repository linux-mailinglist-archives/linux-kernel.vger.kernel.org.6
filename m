Return-Path: <linux-kernel+bounces-367938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBFE9A089E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641E21C231B1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0AF207A06;
	Wed, 16 Oct 2024 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jnpxjyQ6"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2078.outbound.protection.outlook.com [40.107.247.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30578206059;
	Wed, 16 Oct 2024 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079223; cv=fail; b=Z7Ptkx7UYKx5fGd2wcVGomAui15rDOYIz7iXT5Yto7Ld0qGAYwq0dXnLUNIV7rfSU2b0o4HQ4EuIMYvFNzvevJW8ksbHJqmXS4FtQdVMb79rVf3pduIvX9UZ2pbrHZSiJR3U0SjJKeWrNHCbLgQjCXnRwxIazmWHBVjly2CKE9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079223; c=relaxed/simple;
	bh=EnfrSyuiv1+GG6ypjryv9D0vYaGdR3LVJ9rinkIlCO4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P34azWv5qPLKA1LMldsfsFXXdtKmkV731d3P9zirzrpx5H5juuBHVRW78WPQGf+lVwhyyDKi0Bye43BmVNK8qMoHQt9N9OfvW7OXOCs/Ud6IbxDJ4wjJ/jgIgxLvjQfltzb7ynzkHbyNlwSFT8m6SnqJbEfpb6e+UAHs1+YdN5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jnpxjyQ6; arc=fail smtp.client-ip=40.107.247.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsnZemEWVsC2OFNqGW3hv5sd5CnUISzhk4zWpTQkjGMXb9N3jsOTO1DAvPkBkPiSVmbL4f6/qOb+P/aWTvw1B1UDdIfwmsItKWAM2/enYqvpL/Q+Fllt03eDgvPyODXFOVh58QdoP2AkmicnndD8Dw1/b7wCA8nw2Wf77Fm8x3wBMYDVPS7E8ofQdznSEy++EP2bFQyHp+Zji422twSon4/gf5QvAzu5eziO8HhabZkD6juB0xx/fpSyRTB6fqOSZGGIiSBFV5bOUFUC8uSOeZUYPfSwH4OCsYkoZsZ0lmZuNH0aTTeEiDyubB2S2t2TgV5O/Neuj9VfV5TeduWzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnfrSyuiv1+GG6ypjryv9D0vYaGdR3LVJ9rinkIlCO4=;
 b=JlhViMfDpwqMgcj158k6gUKd/TwNvVyXUyYvSRegk1vDxGWh3oWzHTKou8ItniNx6eVZZ4Qk47HI+AEYwRt5oXzvm+vEogzOLNkczyPo2DLIlBEE0604i24sKJedirOJU+wOWeHeE/nTxUJBEEDsAo4osQtrxVlRlmz+9N75gdX2ROw0ssqyRH5BrQp8ak3MrSmcc+5v/dy3seFA5lzyoAM+5EAHY0fITYiYZcA8qFJPU7ff3gO/0Ilps89+WkmbIoee0rZgC0odLOyaX1g85RQOrwKWaqG1COG5kdtfpE/RrTFV9AEp4VIgWmzbcCbGy6mN5XfVby2ROOaZQkzXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnfrSyuiv1+GG6ypjryv9D0vYaGdR3LVJ9rinkIlCO4=;
 b=jnpxjyQ6AptfH+FotdW8Z3LzFt7Ta4rqHXMbTnX8mHi1I7L/sfhuFal58OAwPrqLxj+pp5JsyWyWNdC61X8twr0nq9ZbOZqeOUyIOOKrOOIVF7R9CrH3tzWaBtIr4c3HHK7UO16TG8qBw7cvYvDB+zGEhffm8pE0zZKgkpJeBU1hyZ2DrNQjjYriFZGba+jMCxO5LHU3PKJkDtvASgi18zhFQjO8HGyi6c2N9ZZFEItqUsOjb+8ckjGX4WXHg9y7sFQpM25Ntpscu6m6ytzUxUHU3scaeLPEM76xjJgqkOMj/6SH++3mGt8EF/DYthNLU3LpfWZ86KLuPtkYoTvy4Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9929.eurprd04.prod.outlook.com (2603:10a6:800:1dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 11:46:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 11:46:57 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"abelvesa@kernel.org" <abelvesa@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>, Frank Li <frank.li@nxp.com>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] clk: imx: add i.MX91 clk
Thread-Topic: [PATCH v4 4/4] clk: imx: add i.MX91 clk
Thread-Index: AQHbHeAjm9fLRS2nnUiA8tP+KG2SAbKJRUtQ
Date: Wed, 16 Oct 2024 11:46:57 +0000
Message-ID:
 <PAXPR04MB8459B770DC2356B2177FCA3488462@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241014182438.732444-1-pengfei.li_1@nxp.com>
 <20241014182438.732444-5-pengfei.li_1@nxp.com>
In-Reply-To: <20241014182438.732444-5-pengfei.li_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB9929:EE_
x-ms-office365-filtering-correlation-id: e575b8a3-6d30-4742-37d8-08dcedd83d06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7kvsekatQzCXoi8Uox1S+390j2LI4tTaySzhio/gOLrNQ0muYQ53NwP6kw0o?=
 =?us-ascii?Q?BPGirdPEbI8Fqqrg4No5rg4VRQnj35AGH+E3bP8882Nru3Mb1X1kfUvOAyOV?=
 =?us-ascii?Q?ihw1IUdXor60Wpump5Lb991wyI6b5UEJ3nscYcjeMFIOHmgIUAQ8tkbRqEa2?=
 =?us-ascii?Q?i5DlFOV2Q4skX6QVg+2PPAQwPIVz1jmQftTiSQpVM7h1QMuAVQEjkRR0I++I?=
 =?us-ascii?Q?C6DflPkZXXsWJHTQR7xJTygag5C3Du23C9qXcbf4CpCIUB/D7gUJio/XDMl4?=
 =?us-ascii?Q?1T1ARgy5NLUYon4KKAHNBWAQOof05jAYamrlbDOnMWZE758/utePMYCWzAGC?=
 =?us-ascii?Q?5JQy8wX81IC1YytayDxGuIBm83ZpEVui372dlhYEk8iIrzoH9+uDGS0ON+hm?=
 =?us-ascii?Q?nb67CiK3Avm4BzPIix3tVn+vE4rcT7cdGeEPQ53Jp6e4jak0qtQFUfsT8E/+?=
 =?us-ascii?Q?fMRKYXIcDQqaS6ocaPUKsdXwyr40UvFSySQIdQTc+yhiWoGO2iM85xyEPczh?=
 =?us-ascii?Q?DS//bAUu8xxnE3900DBxXDn27xiZIX9OIqh+NxyMqBuXJKvWkJVqA9//NkB3?=
 =?us-ascii?Q?LlVWo2aE0jAOMboQZbQ6RErpxPQaVzZVf3SabDDf4wBgPrQtDv9+cCZOxDA9?=
 =?us-ascii?Q?CgcWUODrVCfJ0rAXl0fbOBxNSyAMabdRNk8APR6JmV7L+s/EBxOGEr1NE3Ka?=
 =?us-ascii?Q?itLF3PTl0viGvP2VJCSEdAbTXhGMDHKW2MNCnPRT5Lxshj7MoqUwuQiS/3E6?=
 =?us-ascii?Q?bvs7uB5HnMwRqnU2avRdRWMZnIQ3z+YAfHgxxtxQhjx92+FWQNN7e+ZBzutP?=
 =?us-ascii?Q?mF3DjVdoBxgFvKv2EalmECge1a1fTTQTwMPqXKHk2XS4Dj/ltcJ4X/030KI3?=
 =?us-ascii?Q?IYG3UWXlzRm3EkvPmQG7JaY/0OoAORT1zrhjkrk7WbsqhCTHyMH4+30ux14+?=
 =?us-ascii?Q?LAykMUvPDnuREz9mwzWXcbMAF9FmWCcZdvXb0DtkzAhgGWnPTxpHjJUwkQ8H?=
 =?us-ascii?Q?bq1KaNfkPZHPg6eFnwsKfABAsd9ne4vpHBnuIXcPsMe25sl/w9SpS7mJPjE8?=
 =?us-ascii?Q?FlG9wA4B308pm9pGRKGVENrKRqSzU7cgxvvwBFtDUe67e8kZceMM+iJk4s8Z?=
 =?us-ascii?Q?rohZ5KaTXVERwdfHy4t+U4dJ3t6lzGcK2SJO7HCfncf8y7tJorUxVD4C9+ru?=
 =?us-ascii?Q?vb5/afdUez7ETFs+ji5rZENZQgo1Qk2qtIGekLS6VC0AiqFtVDsAjVbA1Bft?=
 =?us-ascii?Q?xfSUsXCvkEYjUaTra1KVJ7hsRsC6KmfIa6OVyKXcSaChz/WmamD5kMropODO?=
 =?us-ascii?Q?oMJ9bmZ2aCNftubdZWQQIPm42NRXIFJ+WE6oqFiHp9Mmyw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CfyIGyGPyXwrk8I1DPbvXLiy+lillezRuuqMVNZc8f8w74FALQb2dTHu+UIb?=
 =?us-ascii?Q?xNq5T+8O1rttVkWSc1lcjFdLGgqxCNuGihMeux00s/kfGN2eZYoypmBHc9UT?=
 =?us-ascii?Q?ngh4QWXLvihqwSWwu6rqBpKfwIWBzyX0/zmxU94XA0DQ/4/Vwq7thJ3rABmR?=
 =?us-ascii?Q?BLDBueO/x/YFUH4IQeWWtbsiJKs//Rlf808drLJlYJnx9+QIerYlEjkSiYwy?=
 =?us-ascii?Q?BtnfvoSsuC6qpPlTA1Gyz76OTnTAOxDVD+aY7Qln/4fVMcr9oW8VfTxOCKM8?=
 =?us-ascii?Q?BRx+n+5p1uMEkYHRkZ3T+U5veFrPg2PyoxuhsxZ6ldYAFIV/AB787dgVvhtT?=
 =?us-ascii?Q?7T3CThkwCILUDWdETpWihXWHEjaBdwo4gAZOURz3HjiWDIS9NQs1KaRv1EMf?=
 =?us-ascii?Q?lOcRS2wyK9yNM91vtOGhdKuB+mlgUa8eSjNXWePeYhxhZe4glNCXLD3b+Ix6?=
 =?us-ascii?Q?F8bdgMXQEV/fYZ8L9NdWx8VWqE5opdoSAyzBoSyyPH544xZnOoLJiBo1qNLV?=
 =?us-ascii?Q?Z8NcY6aaGGh64hSSfqGRUo1aaezCc8eYQKNH45LMGzZMjaPNjZs8MsccL/lL?=
 =?us-ascii?Q?mcVq9uiaUrbONZneedXDX6Y2nxasKVOpfBQSnNZWiIMd6P1FrWZfYvcrYL9m?=
 =?us-ascii?Q?PoGvzLV/oSMzpsnk7Up4VGwpUGHrEWvgU/M2FmWW/Tkql+IsW2J7+1hiJsb+?=
 =?us-ascii?Q?hxcR7QFbQe9amwyq6+r30cbTe+9kmJ2P+CkNamJv4/hcx1qZYb4ouG9wc7E0?=
 =?us-ascii?Q?5cyvfa5yFOxRjMgkBGhxSIudjJSHtEjYbyfa3MEClxm8KScwsSu9UumG9vez?=
 =?us-ascii?Q?0XvSalpwvR7lPsV9kVu21NvrEzA0u9lurPVHGMaD6yq2di+QwwqHKS7TP+pJ?=
 =?us-ascii?Q?YtGf/taxE0J2fV31P0iJOr+OdITdT9edevVjXu0hQjUEw4wvFBnovf1i5PR7?=
 =?us-ascii?Q?BYDdeUICjFLYVRS7kQXgMccn+vyWvCvwUcqp1G42fR3U2ZlZ3RfJB3XdXc0K?=
 =?us-ascii?Q?brs2mZfCj6vU6UcF7e4rTsxTXW37B4Wa3d7eMP8hm2c1baZy8Py5JzPidQlg?=
 =?us-ascii?Q?4KVI4bMiJV21JlLe5241KxyJEr824LjHlUHa+Xi0m6vHwvR1w1D4q1boQ1V5?=
 =?us-ascii?Q?3x7zh5Om5Xel9kTDGee5vGGVyIjA8FjBV3JprhFVpA/am7raq5DbLcspRAzM?=
 =?us-ascii?Q?da64SXuSRZYTcE/Nq5o0UMGQFMAlEYsGBeR4PjT7TRiVipOk1U3gipGlBgs7?=
 =?us-ascii?Q?vSFAt1+QNOhQKxIlMGSO9BQ43tPsYsBXU0EMF212nCEIUFYDWq3vDxMJfsp5?=
 =?us-ascii?Q?0LD0Udn/vNFbn/189HZ5Jqvq6bvx6o/9bgrjNoenbjcM40Ov7fujXf11Lvnu?=
 =?us-ascii?Q?aWG40y12tQA2OK3CokjgVWVtu5c9kC03yp7kLGGVYDMAj5AJ7qLwNdYOKie8?=
 =?us-ascii?Q?GsIUK5YoJc8hjVEY+FSO4jjPJLKs3qXLt0RcyBLPq1+a6ZD/O6A5o8nyeE84?=
 =?us-ascii?Q?gg3RAAiTmp07zvSN1fa6bKvG25hUi8U1v+5iqcN6QpYa1ACTc09v7nkyV3jN?=
 =?us-ascii?Q?PNRVeX3w6bHQTQi9SsA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e575b8a3-6d30-4742-37d8-08dcedd83d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 11:46:57.1919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLgskby42EEqhyGq/VA4DbhJNaih2u0FUN4VL3ToXbnu2RhLp9DsLZMYKHvN7pmv73gy3czZf9gx1QtVZ6nNGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9929

> Subject: [PATCH v4 4/4] clk: imx: add i.MX91 clk
>=20
> Add i.MX91 clk driver which reuses the 93 driver and removes some
> clks.

Please rephase, example:

"
Reuse i.MX93 clk driver for i.MX91, because i.MX91 reuses the Clock
Control Module from i.MX93, with only a few clocks removed and
a few clocks added.

For clocks specific to i.MX93 use PLAT_IMX93 to flag them, for
clocks specific to i.MX91, use PLAT_IMX91 to flag them. Others are
shared by both.
"

Then:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.

