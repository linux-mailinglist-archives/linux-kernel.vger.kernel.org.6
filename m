Return-Path: <linux-kernel+bounces-278820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D894B54C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B151C2187C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091042E400;
	Thu,  8 Aug 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SEJIzGDZ"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51770C133;
	Thu,  8 Aug 2024 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086251; cv=fail; b=FRqzj/WTr9B0nIz3wOF41aJeGnxxrfBwkU2AYzw2f0HPB064LEF/2am/ZMji2XZ0qcjl0YOH1O11UkoWx3nFW63QDHfebvirA7MQ5JXlxT/DHeLq01rlKLA+AlF3QW8tYz+cNKp4J4S8Mzz6t73cPJ8GFHT2MD4EWP/4NpIh80g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086251; c=relaxed/simple;
	bh=/6ESFpAaEFL8XcUVWrJqWANzJo9KMiaRvGbGm3oFuo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s/Yz66IszSf7Z/JAhR0rjZleBGEA22JTMQIzCmOWZqtx4DIypysvvBAgn55C9Ys9LvHr6MLTKxPmdtRcFgknUadhgqA0sPMA5NTlmq1SAi/H2xRXkiUEAGp7plKNCQ/rTUU7TMySWnIGhseWR7KpJRqZO926h5EU7qNhk911sxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SEJIzGDZ; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjE4Pp3FJkDA8idTc7LRzCKSSicbhJWPl+3v8+GzPjdeush+CEAmuLklPLBf5RIsjO3ZrabXmN9tBIIIPaAN8BLt5YnlKUVPaQ2HucxMAY9xBAuIS9n7tK2so3N2f6ecStqZ7plTpyLcEs0DcR701QilNos+7q/M7MzNKRQ4LWZ9gfB0Mp2kCNk+WfyRK2vfRojK3Oqc0SBC9pJ10zn6ftAooyU0C36plQK1IZ6I1PUPOiWjd4/97okLoIewjPvVXDB+IyaBUFdkwmy0LS8O80DtHdamJUGTNPgsO+R5E52jqr1xEgBeWDERTw5RFwwn0lwZGH6MZPfWYjKVW6+Zcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzvIsGsOrKE/phKiN7QeyMrpaU9drPDYU8fRNPyEMac=;
 b=uq+Lmttd1EUikwedLzfo7mp8kGa02wPZCvEHSZbRpuFZ3b15pCsJ85FROD999duGkfINAqZmg6CHq4Fab47Zu3Pj3hvrSw2F55l3tJYinx7P8iMy+UM6VOI6GVrU6OBYDfOt/qNNLDmAtyVOkR7vVCmtRli2TLxn3keHte8UDym8hSrdXto7HqUvpm0w6TthKqAuGpIS+bWsl1CJZfnLv8L3qZCPomUdkwT46aQwqnic1n7KTCj6A36FRX0kDgZfNM7p1I2lgW7cz+2/vWSJWpEEJROmA8MTTYf9p0gLQMV6du9vk+Q/piKYrYVsM5u1WzeHTc9WSV8ov6hwSGMKrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzvIsGsOrKE/phKiN7QeyMrpaU9drPDYU8fRNPyEMac=;
 b=SEJIzGDZRvgE0rUMDmt4n/oHNPzwB805sL/V2uLo/5OpM73RLrGLa0qA+7Sw8SUrjoBR7AotZ2UyzN6iEOLC9avcJqufDTpjEr/+YhYSKFfrqokSXe0Ogq7oB3oTJIGK0ZYYqBwx+7d7iZCufG0mFhVTIUcHCQdcjh1DGbXPc5n1PUHAdjFI8KuA3ZH9uxMcpdSWHVxc0WuuHzvAK0QTCx87sQGKjknE7VzgTqY5sRjYLRGBuXKit53cp//JGupc5XDcajfmr6cl6a/CLOb2IOsRUJK3MLPOYSNR0+G6xEA/l4zgYSLpQ2QEy/z3yrl0DJJszYFC9f4e8Q9V05NWAw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 03:04:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 03:04:05 +0000
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
Subject: RE: [PATCH v2 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso node
Thread-Topic: [PATCH v2 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso node
Thread-Index: AQHa51TXzp6G42wakEOgRgdXHbtDU7IcsE/w
Date: Thu, 8 Aug 2024 03:04:05 +0000
Message-ID:
 <PAXPR04MB8459C0E16C4A02D69FBF20F788B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240805163019.2932223-1-Frank.Li@nxp.com>
In-Reply-To: <20240805163019.2932223-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB7619:EE_
x-ms-office365-filtering-correlation-id: 04d83337-213f-4451-de5f-08dcb756c3ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R5J8hW/OI/2B/vwhpt/Gy3f7huD/r/iTlq665w0zhshB5uVy3Ym5rtBZxXrH?=
 =?us-ascii?Q?DaM6JUSL0bNihRA8ASNZMnqPmadcMnFG3ygzRCSU9rFcJnT72SxMCzpR7Us+?=
 =?us-ascii?Q?bIiIYL5NAA3CB0MS0kgkBKgRd9dVHU7IX33aW4upYxlLFSSnaqHFLqyHlyXZ?=
 =?us-ascii?Q?zMD34Wt8GEA8eNlhowrc+s9g7RNGgB5aJT+oXb59o12NlRf/eXlnVB/bgyu+?=
 =?us-ascii?Q?4emNGtO5j4Kj9u39Bdl085h/L6hDmXCl+ZAu3kSogKS2ePj2D8+9h5l5zYHp?=
 =?us-ascii?Q?TBduO8cY3zbpeyLjpXGWagodV77WCKc5olgGYSkKEAR7C/RZlEjMKveLvMzl?=
 =?us-ascii?Q?uj6gdU87cJl3SQm+kqHQCzE7T0vP2JGte6HU2oXbkr/di76SQlHbrtTgZ/g/?=
 =?us-ascii?Q?IgldYLlsgu/rtBPkhY9PyQ2bO5/Mg52Msi2puqpwlURN0ODCbXymcUNsOHWf?=
 =?us-ascii?Q?y91il7N3WrvJXP8RG4dptZLe3X5fRh95znkW9MCOjCmcYDP5mCYRQqGg9GuZ?=
 =?us-ascii?Q?KskmVhx9PhGj6llq/LAfzC6SXs6D5TwXYq2lzoVYyS4fOkNXwGMKwEtYsSly?=
 =?us-ascii?Q?Ykd02YMH0htIfaxjmLDRZu4+H5F6tmAhYO36gouTWK5RXxMK1yyUpTNVodwz?=
 =?us-ascii?Q?QonUdaRfnzI7gNtim92QzWlwCKSolx/jvZNh/188EH4+IsgmZFKjpAK0r7LL?=
 =?us-ascii?Q?2+PKyk617xmm1CFFwCkNeAWP8ZfblwoPKHKfw6Jw65+Ygf1XCY61/MeUFKZw?=
 =?us-ascii?Q?Evj3ugg85VBEYz1YRGTUGulKgDHHxHuZAvA0kuNRywiGh1W70eesBaSL6uGi?=
 =?us-ascii?Q?ET7AhBL26ffDGH7YR6mlARgc7qHFs5ps9C8ob5c9qn0vEvZRosTBBXVm1J/8?=
 =?us-ascii?Q?kp8DH/ru4nIcxou0aCLw3skQGGgzwTtUFo1g6yaRF1iaeu2Wj4F2s7EhwMHg?=
 =?us-ascii?Q?Y/kZYkSmarEjQBbuZsmaWdU0r8b4F/TgUTUraWvTHOvOEC+GHiFUMZ+yIoRl?=
 =?us-ascii?Q?7E43uuZzXp6AoRxhKGfu6Gld0t1TO6ww8tZf0Rfzol9gL7AhqtgYDfeXckt6?=
 =?us-ascii?Q?7rxK9LrkM2ozBlM8acVu0qi+gKF7MZMcAngxtI/fXsGpri2B9qgCOmGYCsYl?=
 =?us-ascii?Q?pIiQDRhAiYQs399ZbTwhEFrRiwa0SUA3jIeFVllYAroIMin/7Jn17st6gRzU?=
 =?us-ascii?Q?XKOoYby8/6PdWgCpZwwKsVM/av4PW+Svu1byP5uX3mN8Bvn5wRDkRLgOhuQ1?=
 =?us-ascii?Q?ybxyDyo6EwpobAS5v4S6eVmadqbTxzCsv3fpF5GBUO2ju9b/LPejSEt5EU5z?=
 =?us-ascii?Q?bEXwiDNUqi/phitf/U32KlVXPY1JxYAtHdCyICsiswEXOAWcVhe37mxKAdNY?=
 =?us-ascii?Q?i4VRjJ6I9IxUViX/vH9vm/zPllUlDmLyyTTsZEZ6ONrXYSBV7sghq8H8iQXj?=
 =?us-ascii?Q?5rQRxdlhZWc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A1ilzRgYb619Sni12w/VUcJDFTE2NgGSiZ2WWkfwaCIB02XYAV7ZnD8WqO/e?=
 =?us-ascii?Q?oU2mLezwbnBOGt6RwKBhJlwE8UtpGU19ayH+pNj3W+L/VABbn1VPbn0fR7W4?=
 =?us-ascii?Q?10shDwVzmHjY2DZ8BVCuQzNKYia5FQ/jnc80WKCYQZB+oqRoW+VAiplYJpFC?=
 =?us-ascii?Q?hvaJF5V2m1iB830eAeriAtKEIdtJlr8j35STtEashORopTW0hiQAzjXkjVBN?=
 =?us-ascii?Q?qFcMT++AYqHPNOX57bmTb37mTiE9470srfn0OEgjb4RDhelwCmpwG2HkVOVq?=
 =?us-ascii?Q?wfSyUmFu/JrK1/ZlbzM+kZ0sfsHeGaJoRjuBWQgs96cjVHZs0/n05EDn6Bia?=
 =?us-ascii?Q?Pz26o23CZgievCUxU1BWb21O7Krl1a4KH5UaDgku4epvpD0b4OLDeBr90I3t?=
 =?us-ascii?Q?XMoSnhQZ7w3iwmvodukyXrvjjeATCfBD0QOBGV20f5rdd3VX+8Nq7CBbyYhF?=
 =?us-ascii?Q?1D5iXzifkjGt3wZE4VwQvHr6bHEY6XNzWP3B3d7H+SM0NP07he5fmu9aUZ7t?=
 =?us-ascii?Q?5J3FYFOCi6fYHe9rlTm810U1DovU40FnghnTEFdFVBYu63HzsXrSD8cRHSec?=
 =?us-ascii?Q?BUKdJGNN6fZvmOrC6aV/JadGxlaPyI8NsZ/1iNP67dttY1vKf626NGnnBzO3?=
 =?us-ascii?Q?M3raTJP++SoBR65vB+LO6B8nregSxg1mQj1+AokDmDAnYo6pz9Ha6+k7NF+9?=
 =?us-ascii?Q?VRbvwKIxTeB4AOlQrEcfWTYwiA2qyR8bqqLUPRZg5w9nS6b3tTXYdkhppIQA?=
 =?us-ascii?Q?PZzLuCe5P0lidbeKbVtWf2tnR5+bOjmRlQr1mjoHQfVZv548hSnGNujlfn98?=
 =?us-ascii?Q?XvT3EV0NqNrm9Se5T0Q/7+RtQvC2NHD5RbrWmVE4Se/JpqULTZQOdhgdiJIT?=
 =?us-ascii?Q?YwWDb5Ng1N5fmyF/i6Ibj4iGrlvBxGOJ03KZVvowa0VHAy+1uqzR5WM3sje5?=
 =?us-ascii?Q?cZo/DcYpgEq0I2Dj0nee0WfD2kYRc5l4MF0+5u9nDCZnG3+xZDob4S60LMJq?=
 =?us-ascii?Q?htD0RX7E19l2lnPPeKukImjLOUEeICZ1+NUJ49oo8h+SM6m8yFsRwNanfjau?=
 =?us-ascii?Q?MIEVrm9YZAoDWUp30WjB5UPOcoJmu17mBvsHaWAcQjGFb9uGF1dpBx55j/4h?=
 =?us-ascii?Q?9GV/HpJPfSkBPoa9AMkmHQI0SKLhj8GTMhxx2mttSMjxly0zMvIUiLutGkWE?=
 =?us-ascii?Q?gSEMS4zx7yaCkRN3lr3CJba3UXSoqPDTZ8ni9lAin8nI9ghkyUfDGAmyeos5?=
 =?us-ascii?Q?ZqEHSzj3lJ/sDxgKIoXNoXGYYLDG8sJoKWaDosfrUGUVrRpfPfnC1hRAa4xO?=
 =?us-ascii?Q?0VrL+hCxB76EaPkrIGYrh++4Ghjo89xP+fIVlM58UigObcYBtY7sFnzudMPv?=
 =?us-ascii?Q?9MHOGRaoG17pwIlG4dPfPV/kewv1Xmt8+uX0F3Fd+oSNwtqyTCJprCzYSl6d?=
 =?us-ascii?Q?6uMHP3XlnCSbwEDfExJyqYGeyZSAtPFClS5ueURLj/Rv0uI/qJaboVLzzVwm?=
 =?us-ascii?Q?lvFJrBU2XLFsyFvaG+SNuaaR7lt5WMHaJhVDqqLUZV5jGwgQgsDFwb7f4+qx?=
 =?us-ascii?Q?arKNjKBaTUMfF/JONew=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d83337-213f-4451-de5f-08dcb756c3ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 03:04:05.9570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +X2mjuuCcxCHcSQlKS9LsJMaVcYgZdy26O2trOgbhxQwDF389JmFsf+HF0vLQsmrXXFo3Io7vq3zlaHJTiMTOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619

> Subject: [PATCH v2 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso
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
> Change from v1 to v2
> - update commit message.
> - use common node name.
> ---
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 21
> +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> index 2597c5b2eacb4..23c96a418682d 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> @@ -145,6 +145,20 @@ ethphy2: ethernet-phy@2 {
>  	};
>  };
>=20
> +&lpi2c1 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;

Duplicated property with imx93.dtsi. Other that this:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

Regards,
Peng.

