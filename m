Return-Path: <linux-kernel+bounces-270562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE912944174
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56E4283DC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3581EB4A8;
	Thu,  1 Aug 2024 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h/qT70dN"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80F13C67C;
	Thu,  1 Aug 2024 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480873; cv=fail; b=ov+VKrmJmiy8H5kSdJef/AFsya0uXiF8lB0TrEtbOMmDZMH7me1+1/P8k7nTcK93IKQE0QrxfzWDDrFYYeImaR626ScePrxhG4zFth/ya0WKHk8Oq70GtWnqK3djYpBrsvN6yOtJDPe7rvxci+Q6pXBgvb2SXDIAHlUwxpQnm8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480873; c=relaxed/simple;
	bh=aJkHq5G6ELPZpidwTyO5cjVNfgT3sc3+zNlIJP84WjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mM7JsVS2Wd8e3uEUm7pU7ojoXSbBUp2Q1tzR3LJ2aHmTvZDswvJSNhSfGIxpizYqiHDT1PCogdN0HAVGKZa2fOanxTgyLNaeosMlH0CNs4Px4vcGt3o0O+MeGc+THLN4ecYb0DOtJajmw1Qfj32MLIdztuyxgayHANSFci4yuC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h/qT70dN; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIseVBw9CSJCkq9aoVX0HagZBeTA0aJjXI2mYW+mG5t98EKbjFaIdMPHDaQyX6aifOAnoRElmZC4P6YeQL6B2iuGV9S4wbZEB37LBT6FfXcoW5baX6pQxO5JLBxrZsVoHCLHRRy6GGIXRCW9mBzNa18tafsBuAe+BYyv7wSSMgc6JezP6ToI6BavHzDsFHnpr2RGksG/QE9eO7e1GgrC8rt+29BfkS6ue3b+AGgjHPW2QoyztA2N0aEsZwAccc+U7LfM1N8uOhe+iq3TyqPQQ2KiP5HPSCo5YP7p7u1aihxPxlefgPmQa98su3r10Fboza0yz1yLhYEAsMPqrQSnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJkHq5G6ELPZpidwTyO5cjVNfgT3sc3+zNlIJP84WjY=;
 b=bu0EbRQux0FQfRLQoXZtYWWheC4dtsaYQ1Q8szifb/C11UnOaUjMh1PAmML0QqiIrqzpbm+VhUOIt8FdcgO5APNJolyZWFq2AXXHWwf0dffDRJAtRPGdw5hNHLDx36OYUC0ipw5mJUmnuLGq2lTOHzhx5X5FgH6Igm+u31Ln3HAASPCGL57ylp/i9KzuWFjT7OPbZLteUaiiiwBxzBMkFZheEGK69GNPtRtqAuu363qvBVk1LF+RnrmUepHYy8uW7IalMwCuYwYu7yi7YHof+6eAzNiDI5aBJj90/8WwB85opHs3zpmgdzBi8Wku+Ba2ZsLP2ke7xTZ1giCD+FvAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJkHq5G6ELPZpidwTyO5cjVNfgT3sc3+zNlIJP84WjY=;
 b=h/qT70dNGqO+2az+wTdcYgV5fBNQTnyHLPtIpS3t6ZOhB4AIgXtijcVoBCZ+5tRHJdHQp8GbfuSIjN16ui0WmhsmgMaEzTR1yvy5ihwpuraegZhmM1OkcczDUcu0O/i1Ol+CxOYPdNb6G8ELo7Ov60MODjk1o5sTwo/pyzsVgzg518M2v+W6sD0VOYcdrC+HL1ghVnQF8RnvVofuhYJz5bPSaxKz08eq0mruvWzY6kCK+xYFT5qUR1P5Lml6XnSL9ozHCFJ/HEUOSNaItCPq3XX0S+CkINnXJwMdVphnLeM2LONab2k3Y3+iUoJhSLzoVzx1WLyNNYeajrG+LK/U1A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7954.eurprd04.prod.outlook.com (2603:10a6:20b:237::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 02:54:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 02:54:29 +0000
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
Subject: RE: [PATCH 01/14] arm64: dts: freescale: imx93-tqma9352: fix CMA
 alloc-ranges
Thread-Topic: [PATCH 01/14] arm64: dts: freescale: imx93-tqma9352: fix CMA
 alloc-ranges
Thread-Index: AQHa3clfHxHPFrgMA0+KrUGdAwncRLIRwGeA
Date: Thu, 1 Aug 2024 02:54:28 +0000
Message-ID:
 <PAXPR04MB84591D2924CE2E8B4AE2311988B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-2-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240724125901.1391698-2-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7954:EE_
x-ms-office365-filtering-correlation-id: c150d5cf-0129-431d-75f2-08dcb1d542fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oZNBxRDq6aqFCucl/pvg4iK3ER/lH9q7CX1GE/zHXWQAu+krE2TM/hX+x3CH?=
 =?us-ascii?Q?DDboTQrUm/SkYSHTLIJxWAHhF3vZfcKPbDLdxXAV+dg4b8dgIoctZCzl8Rym?=
 =?us-ascii?Q?67ORCq7M3jjnwhKCz2MJjMGC96pp2a38v+7UFzbNQ2BMpWMkhoAmjPIYuxC+?=
 =?us-ascii?Q?W9Y8B4aWvtMJs0PSgHjHLFTZ4Ovra/6AvvQKD8ao/isuNC95BMhou6WH02ju?=
 =?us-ascii?Q?lpULgG7brLKKBhoC85W9jxkRePoOwUQ51CHWKOWwIElafiDaDyzimXyX7Fmo?=
 =?us-ascii?Q?iEkHlepEUiV8Ve5sGajVbtLgWPOn4Cs8kdP1lElTxPZ5bxXRBXYqcjR8eGiR?=
 =?us-ascii?Q?iimMJDmiCojIlsn1a1L4d22jKY6bcDbtXvvWKQkhC64LYA4dteJy649mP2Hu?=
 =?us-ascii?Q?cY1x213aFUw5z71tE5FGqWMOa6CfiiPPyBP375/CXieJqjyxbv0oQtVbxp4i?=
 =?us-ascii?Q?jU5G7HqcG/pA/C8Mn0c9qCYIRIwBXZBqBI2pRPmPgaIDTEF4gi5A2U9DidnM?=
 =?us-ascii?Q?Wbc9pDAihqYWJhTkhlPLd0UDenaGOEY3x4KAEWrjlj1CU8gePIFL8tYXMieY?=
 =?us-ascii?Q?3XuNcMnM+9VrDX5IQyliJhS+25Bc2O3Qus6GwicA+xkv+0LQFKrWEKDWvKvt?=
 =?us-ascii?Q?HEk0sPQW8m5CuAHGL8Rxr27LNTSvflcd1cgREt5eCnddV+fZTNnzpwOwsH2F?=
 =?us-ascii?Q?leEDEvg88MDk+XK2sAOlC3tKomKZRvDTB6UZsb7DGyUcnXHiFOI2ZBvNbLeN?=
 =?us-ascii?Q?A5/+57zvCKEbibT3vArLHiB6bXvznXB+zmvACPqxBabMgK8V1GYOMcksfo/3?=
 =?us-ascii?Q?2sI/2FNhEaYvtw1NSMgk/zM9Z+aYjyQ8ePR1tNn3I44DuuSJDZpbhIccMF5H?=
 =?us-ascii?Q?vgRW4641rCi0+UMZq9KtQax9wKFEV9qDUfHEA90tToov8zlrmIHea5U3Izh4?=
 =?us-ascii?Q?LvWuD0Y57d1MZ8n9VNU6EO1+zD0ixUCpkHnl5KetoweXvsibKRZAN251umMm?=
 =?us-ascii?Q?c8TZUVSceJfMWg2A+d2CZLg0+JAEnv9D/l0Ux8vw2M6qD37kBAivHkbrqx03?=
 =?us-ascii?Q?bT6cRDbGmHmHsoJN5DnE1ogDqf+MMHel44VyR640GxamHvK2m/FwF3FEGzAC?=
 =?us-ascii?Q?Qlw5pE3S5JgcWUSjYDY/4b5uIvHSEmQw86JCJHpb6g6hcG2uDiwPHrWUZS7T?=
 =?us-ascii?Q?vrE9+wsi9PvFrDuC2JBmhnSu+g6YxiVplGnekRPe16PYZmoRdP4z3hyooToY?=
 =?us-ascii?Q?5wKoNNFBoE2Z7gUhOJSXqNkc7ymMOmE/XzzynJ0n9t5IyLsSrdlf1h8+wvOm?=
 =?us-ascii?Q?h3rFkwEnMZ+L63zWkuNjbkg4M21RpmZR6MZH3UY5jJg3pAmwRAZ+/M5sKf0o?=
 =?us-ascii?Q?TSHpu6VA3sdfrjQoOBI16qc1R/XlckjXFZTkTeyaIMBOvgTl2A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pEmVM7bLHxNIX96zlhOOdNY/QBfzMVQb61p1BTpKRyH2Jg9/GRvU5J0nBT/v?=
 =?us-ascii?Q?mNoH3GHCZIPf6COqyZ8QDJ/gUDnV9mga93sfyfRTou98LRb6FPUfoAe6pADc?=
 =?us-ascii?Q?j2Ln8w5nILXpzpBpF5g+fPGkcdHHzVPtuujjNoTHTAtGekWnn89XIUrbDunO?=
 =?us-ascii?Q?QdkoD/pIYhPOLEfUsDCXF9lrDpEKhJ+tUbFAnJmBqY2WjrTdOlQT7QSaaGNe?=
 =?us-ascii?Q?XDLPWFUfk/LOe193USCal+YqwFrPE9zZzcOrxJVCSOvHMtbDPKyeiWrtQ6FU?=
 =?us-ascii?Q?1DHq8Q2CKcsK9zOnYAMGinrvzCk3aNMCr2xu3xwkfCZqRZW6wmj/IV0oE4CX?=
 =?us-ascii?Q?aWSNUSTrgfWzUra1AF1orwK1FaM4Yce475iL27uJVienFidCcHyRs/LndBKw?=
 =?us-ascii?Q?d9d5x3obuoxm/13g1lkybLwE9Rd1vz42htSPM57VdHEuM+hTVHfx+L+bNPwA?=
 =?us-ascii?Q?7Kf+JdSIeeMIhzDY9lH6Pt9J0nsM3JRDABDsfMf/X/xRbGOIqDuQvP5ehigY?=
 =?us-ascii?Q?tfPWjJQCatGRru3KN88cPG3yhmdyaaYR5SMfHjKR8K3w48tYrZ+Kknwud0L/?=
 =?us-ascii?Q?mpDN0nXBKf35/BmvjHf1S20qHg7U5u9FzA3LZpDxbZLum8vvQyEZ4T63eaxc?=
 =?us-ascii?Q?gqMIfu4V6kt1gez3srdQ9idIo0ET48pHuQIjWbS6x9b+ziw2r3Xhb75JZsfZ?=
 =?us-ascii?Q?corXr5jgsJsROfkxO58Pao3SEbFY7ay2Eii9OhzGOiRwyL/xWUxUVDT1z4hm?=
 =?us-ascii?Q?rfDZrsGMPVRrWGibC5Vat9nsGH2NsZFWTHkcCGdg1KaFHcwkpBuN8P0TdkvU?=
 =?us-ascii?Q?jW2wBu7yX7XbXoUyzrMLzxpIXNvk7rhehcEIHxreZ6ymKQKdGofsiBm4OKD4?=
 =?us-ascii?Q?DTZEnq/bHwqJfPgFX/fIy2g/Xe0ORteNnwhlAtmfwokDoDKtz6Vq88Vk3CwH?=
 =?us-ascii?Q?uTmx32VrXJMYEczVfJ9jhHwAzNB7M8Tpx8eh/xVguCSLGGyPQuCjdhsWtUrR?=
 =?us-ascii?Q?fG1PG46adGkgId4zBkWTMj2ptDmZFGQQVX4CHNihZPUHzBnHIs3xj6P5C43L?=
 =?us-ascii?Q?5SqdEnN1FV1bCNvU5qiSQ52S6r1Gr1G5sJ+5W7pIUli4WYt0KtWK+vXmdGgO?=
 =?us-ascii?Q?DjdBFwbWUtm7abGR99rNMO7ku4T3VMY4Fd1CoZll256FSVcjWcaRtyfMCx7A?=
 =?us-ascii?Q?NhEZKdI9nn6mKLgwtabV353wp8CTJBcxWoIUgAkiMMqaIoPS9wz+uKIFtf5Z?=
 =?us-ascii?Q?dXvSK4/IjTuO0qUAkcr9KIYckl2sMEvTaKEE9VLP6H0X4pZCWRhs3VO2y5tZ?=
 =?us-ascii?Q?3/NRY6Zop1ewzS5S/+jRzUYypq69BfUVuTcea/QMzYSjet4TQvqE+Mhtd3ih?=
 =?us-ascii?Q?LjagOV/0OEWTEiw3Bvi5wbcYyIQzOO19Pw0TjmbWmn4mYI/yVg2lLz94Rznw?=
 =?us-ascii?Q?z4jQQXnx1BwMVMHUZHlGzIjnW0Gx6IWKyHlcYo6E8v6rMbhbQhIYfzwxeg8i?=
 =?us-ascii?Q?PGv4fop7uqboNV4765p5vxVzRwQwfTEYDvJ9Oxe4DT7cm6y52qTcYIEAnR0w?=
 =?us-ascii?Q?W6njtYANCBS7tUSgWh0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c150d5cf-0129-431d-75f2-08dcb1d542fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 02:54:28.9381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5YYY7onggym4syyNtLvYqKOJ4HHPHhUjzBBlhM1neLhx+IHHc2Ot0cOcboOmTWGy1SOSjGZHHykWAnVozyPGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7954

> Subject: [PATCH 01/14] arm64: dts: freescale: imx93-tqma9352: fix
> CMA alloc-ranges
>=20
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>=20
> DRAM starts at 0x80000000.
>=20
> Fixes: c982ecfa7992 ("arm64: dts: freescale: add initial device tree for
> MBa93xxLA SBC board")
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

