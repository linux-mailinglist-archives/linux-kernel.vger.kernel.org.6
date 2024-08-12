Return-Path: <linux-kernel+bounces-282800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50DD94E8C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68926282EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E963416BE18;
	Mon, 12 Aug 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VV4oy8iz"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0716B39A;
	Mon, 12 Aug 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452131; cv=fail; b=W+avXYVk8DbNhtAbr2HWxoWiGZPBuvv7BGUSTq4VLs7RUH8AYuM0gycthiAHQofBpI3QmZImuytekDhT+SFmfsYkQMUKrLX91hpnxTOPnd+JudSdVK7sXPlRvI9DrQfjQiNqnKDmhABYVkgTj7mPE7C/VarmJNE+Vn9NWqEwrhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452131; c=relaxed/simple;
	bh=+OObOKujPNYpIHmZ1lUzfySQ/IVgwVTelgnLGArw3fk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fG567tUhf6z2LoKCXNjUTM+FftgEFUXOM4cC8o5szZynmqBCmrD0r/DL4YqG7S+NfOac/Gs9UdPVV8xbY+m/nya6VPMX0Vu7aPuZPM8q/6Qq6nhCki6yJfL3wkXzj25KJI69cRIjaegnaL26Kkh5jiEXtq/dgbgv0HO5bSR/hwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VV4oy8iz; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8i/I92c2GKVn+wOk8/q/m/ItF/dWlbOwboobWJ8WWN2ZY5i1HrNXIsuBXSLgBMfLQRB9zmtdHUmz5OBNde/EN5GgQxAs0L+PPcXfSbKDVUfFtKrM113OLEh3LXqh8haJprXjyB4gx04OW3DPtJtlVtnzA16693+Zz77sPylXJEhrrCeDSWxDB6KmDc7HTnxfkx4vLazg/+FzUE687shz6m5qsXHGRnmBgBOvuy3MuWp2hkc5pcvjafsltlrjDg6hS3QUeneZkX1EGenSTEnxFgQ/x1d6anw7ON5oIl5ZnmPg6UBC5XZyLO8KTR/u0ECmuTJC4xInamPzJgoKotNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OObOKujPNYpIHmZ1lUzfySQ/IVgwVTelgnLGArw3fk=;
 b=ZTxJ8+GchhT7KBwxku1ngQ7btZejxphbq4OrNfEEmwCVQ52Fl01SY67dlRcJrm2xRxt1eEfXIliiFJv+6CZhD5FP5lGonqv+S1tKfpgDq/R5s+rHr7ZOJX9hGAUb0wFwpePbIIpCIYQFbEOk7YumQnddeN+aG45dZyEW+5tf0GLnpdkZG89BW9xfDp9fU/OPBghF9FsJMNk7Z15sc7yhT+4FLib3P3TYvOBtIRBVVlqohHJNjHVyzvPMgMnT6zqP/vIc/p5Tk/6gQFLIlT1bN5oNCg9KdTTR4PtmRtko3z5UF5SmOxUY/2Grgwv9HNRRdnKEyQatAdLD+3UysMO5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OObOKujPNYpIHmZ1lUzfySQ/IVgwVTelgnLGArw3fk=;
 b=VV4oy8izI/h9rgarx8p4RhHg3tmeFhQuIFJkZgv2OSzmIezGTRUqBj9PEuoH/Mc6syiYgU422kmf72P3Bw2Q+cnQrSLd3z61yDGly0SL7uQom7Bna8mRQHmbA6fqKBBfriMI+UmqseUiACes2vMcYjQfWN+hzMzlcGPbD0nE3sNax5Nr8gkFrjRJijZc20qa+XFX6LQlNUOLLgzrcXRUOk6YlBH4N11kX8FhIQCUrjvSki5my+/XOJvyNXjjNHdw6AKIGtTR9ibVr2dl34VGDh//4GFy7pwq5PRPJDbdADy+2udttOCo1XEbKE5uxi1Xk6y6yS5VpZ51r/BzSQewmA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 08:42:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 08:42:05 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC
 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso node
Thread-Topic: [PATCH v3 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso node
Thread-Index: AQHa6a83yeryn+ZP90+Cff1Xfg1h57IjU4kQ
Date: Mon, 12 Aug 2024 08:42:05 +0000
Message-ID:
 <PAXPR04MB8459E033317A80CAAF12C6EF88852@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240808162157.3323811-1-Frank.Li@nxp.com>
In-Reply-To: <20240808162157.3323811-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8868:EE_
x-ms-office365-filtering-correlation-id: 9fc78fef-cc6e-43be-263c-08dcbaaaa4d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?n0ifJ/IMytHB31rbBjAmRNm8MXT0+3JTFciTgF64DkaHbm0ToaqRbPevblcm?=
 =?us-ascii?Q?MHnsR+UnC+dyh7p4yR+/Nak8P4IKTnKdyjuP5k0vuJxWyzI/5+F78DikQSIO?=
 =?us-ascii?Q?ZcLep6WbPpCRsN9gWH5dsI/iPhyjd0iP4SryuSD06vsUedIY8xfyZkOvWeLo?=
 =?us-ascii?Q?7KKxU4nOeKu8auYNGRhxPHfbemAUlSi9WuZp3hzDICBTU/xe12QNia1LrAS6?=
 =?us-ascii?Q?BXOGyESltUn8z9ExYRqoWTDkYYf68MQXK9Hh/kvLpeP6WdHtkZZSEiM/JtlT?=
 =?us-ascii?Q?Ez266Ni3HQX4CW6nBTd1M0KUcpM8ylyP7iWNRSKx/NO8DHaujHpDE8vqSzyQ?=
 =?us-ascii?Q?6A3yqTlN+fjNds209MwjBCkABplIUt6TKQyq0I/KeSL8Rlg9Ft1IBIGgrmTt?=
 =?us-ascii?Q?Jz1XzX3dNiG1CSVSBv/9co5nRqg/CVG/+gCQTiyHgWMhb+wIAVpIrYtfqSKd?=
 =?us-ascii?Q?ipopR6NQq9m+5TbBKgMhlGQcA6prSKNoZQw6oqGw2tilh/dt3kbrhm3wr/XE?=
 =?us-ascii?Q?FRKIZ0+Q3HFugTfvUjlVE2z6NdDEuV0wqqlDuVa25JCsmAb5puwdrBvHuBBA?=
 =?us-ascii?Q?5ygKMTejQZ6/XrLEddgVBCf20a96rzceTjG8a1bnaGlbA1COGw/EX6zLGZVa?=
 =?us-ascii?Q?7Tzmk7L7pi8HGvV04/Sgo6izeMx6RrtEpl/mSyUUcCjPSOw8RWrpxsXfjjQi?=
 =?us-ascii?Q?OKJO4aJwKPRwoTRa4mdrJZ4Y4stguAlh4/MrPXGrKNTywoEkmiVvhSs+ZUPc?=
 =?us-ascii?Q?We0R9thCvETxswerFywuKif/J+4zmoW1B0khveBsUwLIZHTlav/NLRiDTM4A?=
 =?us-ascii?Q?cEudb/P1xYuv1kBsfdWvYzPUtCEzpbE2fOXAFhyYynY+dAQqOodqP3ukKU1I?=
 =?us-ascii?Q?bUDO526nBfHvB7ldVGK1rDQh+lS+J3jCNgXCnXlOVP0vH4vxaxABzIJlGZPP?=
 =?us-ascii?Q?2KZugepR7f9HxNc6X6om0xRVvhbCGAzPly5p/jW7voewyYR/D0JWoFzX96H6?=
 =?us-ascii?Q?iGDVDBSKEFMJGy1CID6DdhWmCcCLkSUSX489a+lX8rdBsB5pKgx/NbDT6uK0?=
 =?us-ascii?Q?TGhojCVk+NN364l1yJj5rnEhZEDXpEZK1+LkL+zmDfxLfmKzAYHf2sS/icAK?=
 =?us-ascii?Q?XOlwWSyAAoixadQf1JHzNMJCekzj/q0djwjwsKXkVdx8rlTDdDE+KJPIOagN?=
 =?us-ascii?Q?Qq8cRZJLsme3cqctoO9U/qGtwBzuBQ1lvoy118weXwGnUJgtMcYQ4nadRLvm?=
 =?us-ascii?Q?L8BDmb0LYOK2MT6YER3gDLo1TqAUK5wtACEHDu2PWDmXQbwP99wqqjn7N31X?=
 =?us-ascii?Q?y/wlgCvytkds+yB9w4E8DcKXSipGcuWEpfTftguKvRXClmo/Ud7nIWiXu/eL?=
 =?us-ascii?Q?KBx6YqjKq45m2SLEfz5uiUQTF3J8bOLyLn2lpcimo35prp6c7HnYB40AJC3n?=
 =?us-ascii?Q?03m7J+uoOjU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AfpqSUPvYjU7m8tJuuBvvOgQwpsch+0YTguwZS8EQhzQO5Umz/GXq2C1EGFZ?=
 =?us-ascii?Q?hRU1r4yauwOztLAr2+RERJpdrgosNMkVgm94NF1gGSpCGrx5pBK4XaMKgB5n?=
 =?us-ascii?Q?xATmvSCbKUWs8V/z+34iwlfAlHVpgqb1O8iOYGfeui2wVQaNhBEneRHZkXZB?=
 =?us-ascii?Q?IkqRdns6ATmqvcReoBFEoKJfwNhaSgBYXEJSUqTIznGdaEo3BCOTNYT4RO5p?=
 =?us-ascii?Q?07rEQnucplXjryggemTen8Et7MPExm8LvzDJTzk5IKkNfe2jnM1I9vjPOBsZ?=
 =?us-ascii?Q?sXzoZIiNqFkcKTPVWkFu6+PzjGDSmXpZ3oSTRVwO9byScd/L26uO4oMpzjdK?=
 =?us-ascii?Q?UvBg2LivWNbounemMgN/jxlmPSYaahvK43h+uItmu2kU2Y47bvCXGgu3pXTz?=
 =?us-ascii?Q?IPYHFhsUAdeinlxs/XwQwAbYzAAhFxOef/pGKCvmJhGqHbvnnIzQYIUth3Bk?=
 =?us-ascii?Q?oy7vzFPL6lSaRIPKMjZTT4NGUVBHOUptHwT6yVTcD7fCQxluHtFj0/Sjd+tK?=
 =?us-ascii?Q?1CAixPVLSP9JuL4Ann9alLAqBJF4ZUD49Vz3l7QV9cLFlVBhXwCG2Kr8ADJe?=
 =?us-ascii?Q?32HytSkMorOaG3P4Lanv+y1/kDbwyTlj9uIf/ZWi/BNwkZq27p2zybZ+x4FG?=
 =?us-ascii?Q?U7jBqXI0tZLDirpufYGI7N8brIsqee+KlhOwlLg21bSIydCXqczRAvXqHv6s?=
 =?us-ascii?Q?rGsh/c+Je68NJUp93ioOmvQaR6hYWGm8k1KcX+Ryd4AayPQy6YdKG9y4q6VJ?=
 =?us-ascii?Q?xC8l5qq0Xk0qXXGpGe2FW9vdplnvVDCRN1xy2ltRureyouNFpQybT+8omGp0?=
 =?us-ascii?Q?EdNY1p9q4bxjFMeHaACVsBWq+PVxkuNwIamJjeoEom1I5HKVRB4EeZ95sfwZ?=
 =?us-ascii?Q?3z09bZKqxFbRwtaz/lQWd0jxF2xjKOa4yKDu2Ich9o+0HsbTriNCCPANCLiW?=
 =?us-ascii?Q?Gb8CGtYm/fax+zB89PwKWCKpUlzi1RFoF9Au7HeFDQaQwfk5GImvvCePoH/8?=
 =?us-ascii?Q?u4KMQm0Xo5Ls9M5zPqRriEbKovPCk2mtdG7gvv4Bn57vYQZ5zrcO4FOBPWCL?=
 =?us-ascii?Q?kWeYifsSRBngnN3aqyj6zpi6l+zAhZy3iqhHBb0OuRVH/TulVZ6QERgxz0vN?=
 =?us-ascii?Q?+8unPryT6VZ2dw5O1nECNGkz0L2mZwRmnzuXesVeVK4DL1LQHi1WnOJ/MGoA?=
 =?us-ascii?Q?G4cOmXDlVWJaaMKpfGa6N/7eYtc46HlyglsNPcskYR9ZXYXoC/gjC5zFoJz6?=
 =?us-ascii?Q?ezw1DUQo4WK7EwjQQpnTNr4NZNjoMZ0/EzU6U6AxYzT8nEyZgsRnoDubE/PC?=
 =?us-ascii?Q?Q9ncbMv2m28P0fR7PQltaVsHADefjT4Dt6CffoSoAtVKztQXwbxMWyrWsoEN?=
 =?us-ascii?Q?v7tBGlPdHWL9xbfEmrv2x5wHUT8hPLO7vsv7GnlzeILTi4F0D7u9+nshK9Uu?=
 =?us-ascii?Q?G8KjTaNnCYHLnUnjdlWNzOFz7gyi9mtJS5fYjw/BZgQI78N9bIH3YglxJFmj?=
 =?us-ascii?Q?96hs/hXrRgmVByHBTjF4g/sY0PYI6v0g0v7OJhxSPLIGXmVm4GZ9S4GiMV5u?=
 =?us-ascii?Q?DntMUHaY9y2yPUWmUtg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc78fef-cc6e-43be-263c-08dcbaaaa4d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 08:42:05.2205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ro2/sWGZO/OU7Gtd320oWRBI9uL1qKL3Enr1S/JwYvZytKcvKHcI4b4JaMpzTsChea6iJJEp/Nt9jHbHxD+0uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8868

> Subject: [PATCH v3 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso
> node
>=20
> From: Clark Wang <xiaoning.wang@nxp.com>
>=20
> The i.MX93 11x11 EVK has a ST LSM6DSO connected to I2C, which a is
> 6-axis IMU (inertial measurement unit =3D accelerometer & gyroscope).
> So add the missing parts to the DTS file.
>=20
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>

