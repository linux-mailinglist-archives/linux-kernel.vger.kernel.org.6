Return-Path: <linux-kernel+bounces-220740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A11FF90E677
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EE31F2363A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F67EEF5;
	Wed, 19 Jun 2024 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RWFQHe3Q"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B59224D4;
	Wed, 19 Jun 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787752; cv=fail; b=XUCMJ9gmIJHEM2F9lYD7A5jatX/P10uU20UjedEEsPyL/bvU5O7rQ7G4zdd3YQ/8iQ+ZW4sueuzBxRYWXm4x7LRoEsRJQHkuusy/cWRL4FsfnafrYaEedjCw6VfJy6ty9AI9fFbbrV9DxGQcO+al8c4mTE3Sr1FJQevvD7ky8v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787752; c=relaxed/simple;
	bh=WhkAl64i9hEdoEdlw3vpq3sLRA+/MKuLIQ4gbTbMlVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OJjQgx1touvIbLaqavZi7CQwOuznZAQJbLB7Uu8NTGzb3OJ4llshVHiB473AKcvVhYVc9labwcXgo9oM2Zo7p2ikn+qvmn3plP+apFnE8hi/FC6pcblnhFeaVeoHruHvISkKuM5MOh3Bnj8FTn5EjCfBiUqHIqft3NYNvxVyKmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RWFQHe3Q; arc=fail smtp.client-ip=40.107.6.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An+WYYU7zKyPTfEJVqITzYS/MYkoAU6VjHys6o7hC7CqRw07ejZX6FHGU4RzaXc5NzYJBBJUVVKGcH8uUIeN9caM9ez9KEnOnafmFkBhxzbhL46VHVwTcea4yqKfLfmny2uICZ37HOO9/YJbc97l/Yfst3WTBUuBu4KN+KpIB/dF9LFFAVhCqlsURqZ9P1WV5cWj3LagILcfx1JC4Rc77RiU6WksfxJ4FJ1n6Mtdu9ouDe6GsV2pYQT1b5s9ZLD+o+p77N5vYwZ25fbx7FL6bFQUUQsF1FKJVqslED1gro/g1oYr8q9+a0CA04BDWKXtMLA8+pT9Alf+y/8OnO+mhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsAPtkgOHIFhylu5auGLhiuL0mEwWC/c/9ay8S2lSuU=;
 b=P31eUg6PEweESDMNeIoYDiaTkDGUbgpxSBe453Pfe2WLM73e3DfJYRFNiz/iPk9QMauk4AS167vfVHkUkV+HaOlYpfssG4uFuVRh1gfSXO141kVHGRBCzl5bSbWSjNgb0LpZU8iCZBZEVawX5o3YWjMosV0UiGnAcfaL/Z2w6fA1eOyEljeWuoGsfoKPCp8R+u4X4YOzDJ2vXHfTwjwYI9ZdXsBAopDUFHNDfyXLNgEGM6bc08dTgTSBUrLy2JOdc9nAMJzW0WDusId2Z5w3EuuFEGs4BN2+KBOYZ85o3vpbqrVDwmYBlzZ/o1QPhbPBvVObtzSyLpxDGZ3fMjqTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsAPtkgOHIFhylu5auGLhiuL0mEwWC/c/9ay8S2lSuU=;
 b=RWFQHe3QOnP0W2g0REvjBATRVjpNJO1GO+uFdBZSm5rwgwYIpbMPbfS4bqA58TrOGnwp/+ZJyWMGj7WhWX6/Ynl8GNxJujbE2Rk5ZJ9Jopp2vjwZX1NnTyc9QI+fbkrPadGERo+VZOqt6IOs+7geSKO0gPn5ETNpV8uNMLTTH+8=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM9PR04MB8779.eurprd04.prod.outlook.com (2603:10a6:20b:40a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 09:02:25 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 09:02:25 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 5/5] firmware: imx: adds miscdev
Thread-Topic: [EXT] Re: [PATCH v3 5/5] firmware: imx: adds miscdev
Thread-Index: AQHawIicdamSKXolo0+7SySlWnKHebHOC/YAgAAC4oCAAL66oA==
Date: Wed, 19 Jun 2024 09:02:25 +0000
Message-ID:
 <AM9PR04MB8604AC683625E13E1D93740995CF2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240617-imx-se-if-v3-0-a7d28dea5c4a@nxp.com>
 <20240617-imx-se-if-v3-5-a7d28dea5c4a@nxp.com>
 <c2ef0570-0392-4290-a008-df74f980f76d@infradead.org>
 <c9007e7e-ca1e-4a2e-a80b-4ee3cd873fa8@infradead.org>
In-Reply-To: <c9007e7e-ca1e-4a2e-a80b-4ee3cd873fa8@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM9PR04MB8779:EE_
x-ms-office365-filtering-correlation-id: 1c0274bc-7062-4b44-21f5-08dc903e89b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|1800799021|7416011|366013|376011|38070700015|921017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?g6YXtcj9vC+1y0Af+U39CFMtfvowUUvXUtKD9K8AKB525h+zE7yPkycpRmq/?=
 =?us-ascii?Q?JcA6azMICgRRHah8EgxyBFuUOEMhAyCUycr15qv6Z3g1ufRmFBkeIKDRobGy?=
 =?us-ascii?Q?6ciN7SKoFN0AeiNnN7g+LhrbC5OGgEWMY/ZK7xIY1W3mg4/gyXAjnX3B58ew?=
 =?us-ascii?Q?xM8BOgIyiZ/gwu1RYCWz5cQesG5yHQ0t1ZnI2RrNlZQNT1JjhIpQOutOBFzm?=
 =?us-ascii?Q?pVPQXpp9rrY93OBIh4ZrhG1hB8K2ubGn2RY2MAte5jtS7aKfyE5RWsHBySB7?=
 =?us-ascii?Q?p2HRbY5BB9ExnJKGrmMXJeeqofDxgBj0znXfc55kzjh1PiohYM53Mj697VeS?=
 =?us-ascii?Q?kxUxOIFqF9uzFAlT8TjuiAtoH9SYvoitaawOA8taJ/HXVRl464qeci62H47R?=
 =?us-ascii?Q?YKDqF5uaSKokb5ESIZhq1iC37X2O2vs8OrVGjlPO4n5c7S763cNWQP9xPM6i?=
 =?us-ascii?Q?W+GqwN8EikW0OsYExeZilvWVb+ZKXJOvUR1XDuw1sTuBYDi2psDifYTQqijG?=
 =?us-ascii?Q?MGQUkwMjcbnIF3S+IztA4ztVwjefWCdx6OH6uQUSzeJVrTim0QP86fafRWjG?=
 =?us-ascii?Q?WSJyMj8yCHZ6wDdlHqddtv+To5DK7NbYwHBwXBIPhhuZ9+aKebGJMyz260cc?=
 =?us-ascii?Q?WKhFeQT1FIdXDWJVHH6ZiNVuCstyQRUwzimhVjwXgI644MZVCzTqU24SEmrj?=
 =?us-ascii?Q?5lyoKKlywqojuDdGefg72ycwbCI9DNOlYG2qeiUOtqPxqBb7xYELG0zlfhrz?=
 =?us-ascii?Q?5PJjG1NUpYk0DgHbge5rhUsRPpzGxEsuQvhcSOKufTs0yhMMpUHpKcj018tG?=
 =?us-ascii?Q?mYmujJN5jobdFlRBUF2syDIQPYVLSlCPU+ej9lkEuDZMyZARJ95VGpBzhDWG?=
 =?us-ascii?Q?Ht03xVsCZ9Wbd7uvViTZdQZl8UQ72/LBGYji0B1GeclZNaSF2gCqb9IlylZM?=
 =?us-ascii?Q?26CgR3hErHd0bvG80dZ4PMNWHuVWwT8HcEUxFJhz+vnvNaO+Qko6qpT26XIy?=
 =?us-ascii?Q?QZy7mvrGjyryXNb6VmzmiILdzfGvEIHNuN0AAyehsHKPLNNdrkclcWNcEQPR?=
 =?us-ascii?Q?rDWnDqTrHvGxe3h0J9TGAcC39umFxp3+y98fLLfpZ++zsg+HfRR26y1z8ntY?=
 =?us-ascii?Q?2evE+NThcj6u5LxyHL+Olbe0etkm7/y0xk96PoGK949pkXU4MlD9CxMKVTbU?=
 =?us-ascii?Q?LaYOplu0248ZofSoV0w+XkStJkLfha6t/fK27rYHrNNcGtxKMF8Vjw+zzd5/?=
 =?us-ascii?Q?7T7k6NnpxKZLO9hfHCOD+oEkrb4BgFpGAkfD6EbmQxgQ+OQ+PSbRYstGk7oN?=
 =?us-ascii?Q?ORtzlRloXGjo0AL8MtHLSlx+9bIY0ESPcklygo3FZ0n35A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(366013)(376011)(38070700015)(921017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5Mm/y+jp+FXp6Bzj2x/9lasoAA9G41jK7bdeL9lQ1xA9z+qUbQBNzOtP91Io?=
 =?us-ascii?Q?MQGyyh6YDVNAscNRDRcvXoIsxsm5Gn3icQz6cFmp0hQM2XKcQvfkegOmjjn4?=
 =?us-ascii?Q?mi46UCC0lCQ9Dsf8tC/962dRbxe+qw7jd1pSqEC70Um/u+CPOdbiA9LrEkPr?=
 =?us-ascii?Q?CngLEGJF8wrbycZlXZ6YFhoswBA5NQglYTXWeuVIg73T9mODvRQNAMm96++b?=
 =?us-ascii?Q?+iQdM3DElw/jejSjAsjRUeYZh8HSBCqLwRaZerqzcfuC7LkJiA9x2x2s0iz+?=
 =?us-ascii?Q?AYdzZcnLMdGQuF2RhTP80gnFfRLW4he9lLs2Q4e5QXVVJeP/SLYoAGE+haiI?=
 =?us-ascii?Q?kWdd9QXseeWF97bAOVYo0TDDKn1ze/rPjTgUKF22CWrxK1ptbhwo5ciCb3nc?=
 =?us-ascii?Q?wy5T7t/a3c2S8J6F2Jam+G1Lhd4JbatFcJbroOBBeLQfoGcX6L+A+kkcK5Xm?=
 =?us-ascii?Q?DB4jASwP4YrNW0myucAQxvloGqRU8aO01p8bVqXPx5beoPWpH4lzHnnXgHG0?=
 =?us-ascii?Q?CNLoTGpZmP2ei31oSW4egnR5iwuhWyJ9wlyT+CCALQ4iQreSJ35jJZm2DB2C?=
 =?us-ascii?Q?cqjmvQPg2OY4k/LTtnjJ4PcNOleA1FVZ5jaMJ/btVMnR+WoOhK/c97b2W5kc?=
 =?us-ascii?Q?T9UbX2+9pyZWmsnMJyskei5fdTEKP9GlHtWfg616t18kU83/Mp9Y52lViGOH?=
 =?us-ascii?Q?QLJvpm5ex8UBZ6RKUxrTuQe6HFYY3rQt596gqU5IzXx7t/7cCa4UfSAI+hC6?=
 =?us-ascii?Q?F3BSGxcFJl9XMjIJkouCrGTCJQFN0W2JTXCqY+ngaisFjT6qNuuMTZfDboK7?=
 =?us-ascii?Q?sf1nm53f4nXyJ/kHhYUFQDFUnvKAAdaShL3jWn4hvZkCd9vvU25AomwpXLYT?=
 =?us-ascii?Q?N8b81gxFZAe+WXvQJ6GSY8kP4dCGnXlCpTwppZHCfgWycWB5+v4b/5IU2TWy?=
 =?us-ascii?Q?wPQNbTB0jgCEFOPkmFwtR2PfBBs30hg4t6g/3avu54MthVKr8Ra7G5tfXcyd?=
 =?us-ascii?Q?++0nQRIbPuwPCgux6vyFrwFETDy3ndqUjh6Au/A8z9C/oLWllk4eSUK5FYTn?=
 =?us-ascii?Q?m5QbksZWKfyV9j5ZEoLH6unZVsAIp0VbHyBO2W7VAGyqPkiNirEuFxpOQzRQ?=
 =?us-ascii?Q?FbwWpVnZJypTxZy5haBLzNLQugnB4Bbk4rhVydROaychaSXK65zR6BGyPHty?=
 =?us-ascii?Q?5VTrM4v1mefdzeQ3d0wWpIbcyeF6K6MHQXpkq2yAa3/D+Dl6V9ZIZOVy+3OZ?=
 =?us-ascii?Q?yGMfcVdGZT3HHkKUrUW2crLcyjax6nJfYnOMYKLDRDnQfOZ5X2quw26EmZQU?=
 =?us-ascii?Q?Vp+5LFxZHp93ZnTz5DtyN7xMJuNWUFNKEujY2fEXBv005LpvIvMnUKiG8XxE?=
 =?us-ascii?Q?lsTTzTXzqObdxck83+Yt5OQXxeSX9ryvCP7f+HHGbtKNlZYGk2eSQmbCJs/Y?=
 =?us-ascii?Q?Vp5H8VOzHk1cCpn61fE+QjkVCwCJCSKTdnj4UZVwunX6GWqxQFkoStB0bxII?=
 =?us-ascii?Q?j715oeM7q0t+dym/gMpfLHZcD4UXsssp33xgzOZ849V7soEt+zMD2TDaI4GN?=
 =?us-ascii?Q?57VOATHI6KFbnEKrYGOt1xHkvooB2nCpxEpVhZqW?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0274bc-7062-4b44-21f5-08dc903e89b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 09:02:25.1809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qT+gzLBaCYo0T+m253NZCfFpOz96MObOiRKtPoVB/ElKbsZR6phMKTYoxwt/8lDxpa9V2vM3QJ4GFRvaFBoFVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8779



> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Wednesday, June 19, 2024 3:09 AM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Jonathan Corbet
> <corbet@lwn.net>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v3 5/5] firmware: imx: adds miscdev
>
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>
>
> Sorry, I missed one comment here:
>
>
> On 6/18/24 2:28 PM, Randy Dunlap wrote:
> > Hi--
> >
> > On 6/17/24 12:29 AM, Pankaj Gupta wrote:
> >> Adds the driver for communication interface to secure-enclave, for
> >> exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
> >> Enclave from:
> >> - User-Space Applications via character driver.
> >>
> >> ABI documentation for the NXP secure-enclave driver.
> >>
> >> User-space library using this driver:
> >> - i.MX Secure Enclave library:
> >>   -- URL:
> >> https://git/
> >> hub.com%2Fnxp-imx%2Fimx-secure-
> enclave.git&data=3D05%7C02%7Cpankaj.gupt
> >>
> a%40nxp.com%7C5a42a8d6ea17423104e408dc8fdf1a0a%7C686ea1d3bc2b4c6f
> a92c
> >>
> d99c5c301635%7C0%7C0%7C638543435571166030%7CUnknown%7CTWFpbG
> Zsb3d8eyJ
> >>
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 0%7
> >>
> C%7C%7C&sdata=3DvLyxSGFLArjDy5s2ebW%2Fw6EZI22QHWoKqHvrov15JI0%3D&
> reserv
> >> ed=3D0,
> >> - i.MX Secure Middle-Ware:
> >>   -- URL:
> >> https://git/
> >> hub.com%2Fnxp-imx%2Fimx-
> smw.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com
> >> %7C5a42a8d6ea17423104e408dc8fdf1a0a%7C686ea1d3bc2b4c6fa92cd99c5
> c30163
> >>
> 5%7C0%7C0%7C638543435571176586%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLj
> >>
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7
> C&sda
> >>
> ta=3DQFrkeMwm1yT1s2gyjmFHkVGhV%2BegAFKx84b5mmFsTOY%3D&reserved=3D0
> >>
> >> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> >> ---
> >>  Documentation/ABI/testing/se-cdev |  42 +++
> >> drivers/firmware/imx/ele_common.c | 153 ++++++++-
> >>  drivers/firmware/imx/ele_common.h |   4 +
> >>  drivers/firmware/imx/se_ctrl.c    | 694
> ++++++++++++++++++++++++++++++++++++++
> >>  drivers/firmware/imx/se_ctrl.h    |  49 +++
> >>  include/uapi/linux/se_ioctl.h     |  94 ++++++
> >>  6 files changed, 1034 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/testing/se-cdev
> >> b/Documentation/ABI/testing/se-cdev
> >> new file mode 100644
> >> index 000000000000..699525af6b86
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/se-cdev
> >> @@ -0,0 +1,42 @@
> >> +What:               /dev/<se>_mu[0-9]+_ch[0-9]+
> >> +Date:               May 2024
> >> +KernelVersion:      6.8
> >> +Contact:    linux-imx@nxp.com, pankaj.gupta@nxp.com
> >> +Description:
> >> +            NXP offers multiple hardware IP(s) for  secure-enclaves
> >> +like EdgeLock-
> >
> >                                                  for secure enclaves
> >
> >> +            Enclave(ELE), SECO. The character device
> >> + file-descriptors
> >
> >                                                        file
> > descriptors
> >
> > and what is SECO?
> >
> >> +            /dev/<se>_mu*_ch* are the interface between user-space
> >> + NXP's secure-
> >
> >                                                           userspace    =
    secure
> >
> >> +            enclave shared-library and the kernel driver.
> >
> >                       shared library
> >
> >> +
> >> +            The ioctl(2)-based ABI is defined and documented in
> >> +            [include]<linux/firmware/imx/ele_mu_ioctl.h>
> >> +             ioctl(s) are used primarily for:
> >> +                    - shared memory management
> >> +                    - allocation of I/O buffers
> >> +                    - get mu info
> >
> >                       - getting mu info
> >
> >> +                    - setting a dev-ctx as receiver that is slave to
> >> + fw
>
> Documentation/process/coding-style.rst says not to introduce new uses of =
the
> word "slave":
>
> For symbol names and documentation, avoid introducing new usage of 'maste=
r
> / slave' (or 'slave' independent of 'master') and 'blacklist / whitelist'=
.
>
Accepted.

-                       - setting a dev-ctx as receiver that is slave to fw
+                       - setting a dev-ctx as receiver to receive all the =
commands from FW

> Recommended replacements for 'master / slave' are:
>     '{primary,main} / {secondary,replica,subordinate}'
>     '{initiator,requester} / {target,responder}'
>     '{controller,host} / {device,worker,proxy}'
>     'leader / follower'
>     'director / performer'
>
>
> >> +                    - get SoC info
> >
> >                       - getting SoC info
> >
> >> +
> >> +            The following file operations are supported:
> >> +
> >> +            open(2)
> >> +              Currently the only useful flags are O_RDWR.
> >> +
> >> +            read(2)
> >> +              Every read() from the opened character device context i=
s waiting on
> >> +              wakeup_intruptible, that gets set by the registered
> >> + mailbox callback
> >
> >                 typo in that name?
> >               or is it something that this patch series introduces?
> >
> >> +              function; indicating a message received from the
> >> + firmware on message-
> >
> >                 function,
> >
> >> +              unit.
> >> +
> >> +            write(2)
> >> +              Every write() to the opened character device context ne=
eds to
> acquire
> >> +              mailbox_lock, before sending message on to the message =
unit.
> >
> >                 mailbox_lock before
> >
> >> +
> >> +            close(2)
> >> +              Stops and free up the I/O contexts that was associated
> >
> >                           frees up                 that were associated
> >
> >> +              with the file descriptor.
> >> +
> >> +Users:
> https://github.c/
> om%2Fnxp-imx%2Fimx-secure-
> enclave.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5a42a8d6ea17423
> 104e408dc8fdf1a0a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 8543435571183041%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D
> VNnIyu2RKFHaWh6aRo9aHEtjSSdI1gvzP%2BMy1%2BGggt4%3D&reserved=3D0,
> >> +
> https://github.c/
> om%2Fnxp-imx%2Fimx-
> smw.git&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C5a42a8d6ea1742310
> 4e408dc8fdf1a0a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6385
> 43435571187283%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D23
> Y%2FOKyv2%2BSGuPbGyekpBlCDHYlwiAA8sriLXydEgFw%3D&reserved=3D0
> >> +            crypto/skcipher,
> >> +            drivers/nvmem/imx-ocotp-ele.c
> >
> >
>
> --
> ~Randy

