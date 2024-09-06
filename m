Return-Path: <linux-kernel+bounces-318409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C896ED6A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B262838F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBED156F4C;
	Fri,  6 Sep 2024 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EwT+JvhF"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D692156887;
	Fri,  6 Sep 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610500; cv=fail; b=m9vTVdKhAAlf9BjKNYyF6YQX3f6doBXpproWYISDjsTVyBhWUYIRXrG/tawi5NQwjAnj/wfH0tXOnmK8mOSVkgluHNXoeuQS1JubOVGPvcGVgA/BN6+yLm2zcShf/SI4cZyiCV3aRxvlZsxmhamtvtxlQchBAPOHydJaVWmMIKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610500; c=relaxed/simple;
	bh=zZqJ9zCELnLo4OnNAX/poj8APjEOi4AdtoImvBmuJuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OCPWop+ie9KL7kss3ngnvGTIaQiKndlD6o0PyUjRHCN6zGttbDIepU/IyL4I5DJ+7KCe0xzpYDv3ZU32ydK1PCeVU9Yx9VAsHSVZir/zd47OWJF/l+zuSuuKwR4XqEKlPm9DJS8ImGmQWRc7Hag/OGwdBw88icoakRZZV55cQjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EwT+JvhF; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjBOu+U8GBENM/2BAORHQ+nicVyWAwn99TkKbn8YhpkZLVEP+/iz2PC08pqJthW7FbUjwiZ2yz4mVtZjt/qY+McmebXAzPYyjynungsMEa5edna2pZszksXdHB6NvKp+0R062DrPWhYisZWQ9jEY7p67q987B69S6JyarE7DShVCkZc6owuFCuksoXQm0Th1OVe1S4DOJO0+/TdGfzeA/Q9FJzxPNt9Eg3jTR8MV4hFm8VRpi6eMAwIF0ktCcbj4HxCP4DYUKCZ2sS6t07UaQrBz5nbbtwfseaZHOp6bYVlIYbQ1YZHwzBtr9pBuHrKc4GambB339SBVwclbcE841g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3dUZlZwR8UmLdEhBQLV88/+R38GQlGu/hzCyTHCqAk=;
 b=EUAYZx4iCCxUpmA459Kf/h5aUMFZlQgjjYcuZKD1UWnQpIN6rVjQ0Z8ya9MS6OFVHnSrwDUF7jWOE/0ykS8IKHm4Aj6ZAjVJYcNj/JdLHUiccdiwfHck1M7xp1D9WwC/4/KzMhKnvwavPna41MbycdXXkk4hXbDHjcKU9rnBCUWogTm2ipm2vXVa0UjTMUKZoIARrmANaL3t0UDEOFAHIxO7IE9HSvtJcLdgAHtFbPNyRDFt7EBZlhWQicwiq9iBeimw6U2W9Py4dkUDSi/lj+H6YcZgw9F8zgDSv5Tz1qz/Nun866wtc0wsikWLasG+JDQthoejOuL6ZaT186jNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3dUZlZwR8UmLdEhBQLV88/+R38GQlGu/hzCyTHCqAk=;
 b=EwT+JvhF6FmAL+5OeGNyPX+INrRlVPUl3ZHeGTBhhDC02e4z+zEFirbW2bEPMzpHzr4DqAigKdKibWvcQi8KqdmCfeEnwDut/eo8LRxf4ShYYHmuPQMvsWOe4v/j0AewbKsnSRKC7BbTdODhmvraBlN5DXKp7MoJ3HAn4zaec4p26DtgZ8p2DugCuemeR31UPYs86ZHaF/DqBivZGNw1CRySuHvH38Z05WCVCyiAEIEEa3qKUEiDMMkpt1QXblMsrSEv3S1yNMi4FLNJJ5fgmTRP70YrEBw3LfG4sfg7qosnkrnOcIzzZZc40gwIW9ym9yUTQDkOn7Y+WLOSH4L2vw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 08:14:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 08:14:54 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "tharvey@gateworks.com" <tharvey@gateworks.com>
Subject: RE: [PATCH] arm64: dts: imx8m*-venice-gw75xx: add Accelerometer
 device
Thread-Topic: [PATCH] arm64: dts: imx8m*-venice-gw75xx: add Accelerometer
 device
Thread-Index: AQHa/8HY6LPm20VQ40+xs1vzOOiTXLJKacBg
Date: Fri, 6 Sep 2024 08:14:54 +0000
Message-ID:
 <PAXPR04MB8459CD40E8A0925EE3396F2D889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240905183107.517244-1-tharvey@gateworks.com>
In-Reply-To: <20240905183107.517244-1-tharvey@gateworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBAPR04MB7304:EE_
x-ms-office365-filtering-correlation-id: 9a44bdd6-a915-40c6-9d86-08dcce4bfd5e
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KRIfuQ58AAnaInSLGZ1CwElaU4culGpzMSLug45asrjT0ypvIMMVMWEfq22D?=
 =?us-ascii?Q?i5+Wcv44kwrxvOyrLl+QMxuOscg054qKy4FFRSjwi/T1cRisNsA3vi+g4GM2?=
 =?us-ascii?Q?+oAP4uz75afbmRoQNgfVzIqWd3itwvDL5yNaKd6VsPxqsiuPTaLLSh/QNV6/?=
 =?us-ascii?Q?WnzssZhikxOjygcYLd0efMVdlYmtSjrL41aFgFvtatXPu13f1zHIVNcGQB0U?=
 =?us-ascii?Q?b4edD/otSfo3LjB/CpNr6tGHmMbiMhaZrXbmc79pa0Btt17IYPFVNuiACebn?=
 =?us-ascii?Q?sX05NIbcPh/rWLX1mvRRfwpAIjyRywUlsgtxQYQHHEv7j6OfOJ39J84FuFsy?=
 =?us-ascii?Q?Z222/o/p1NRX2yxjuZDLRevCLzBwE6unPZmAin2v5RJQ+jrI1DYX+yDq5WVb?=
 =?us-ascii?Q?gGdyPXaQeG8A7ivvm/cHeEcSWE+e+LZLIswzQD7aUgypkgJy13k6JFWigizH?=
 =?us-ascii?Q?c28DKafs4aljl0Qxb4grgGKt1fRLchjSoAzU4cpp9r2YBKn5Hn05Tiz0ISgw?=
 =?us-ascii?Q?9Ck8OzT4YqgVaXV6wYuLyzvpbhk1cVwjLTK/FqRY5PuWGpC/b8bmojP9K7jd?=
 =?us-ascii?Q?KtIOCdua2I3akcYKpSGqSc068ZM4B+81diLUeS4Qkt7zD6UTiWgKVvlKwVR7?=
 =?us-ascii?Q?LVBP/R1NNrnT/ToJUGpSPkTgzfDeC6KSnV5BVmgOuLxJ3NOS+py5vCiVivOS?=
 =?us-ascii?Q?/jBmU2R6lVcpYuEUP13ESpoKT05KWlIARJywDqvvoux87uaBkztD3xPWpwDD?=
 =?us-ascii?Q?C6P9GjMnkpaHtZSNfrMJakbC+qTPhZ2a3gsH9lfJl4FDieQsJXJQ5sBvRwhB?=
 =?us-ascii?Q?rxFUKXiNZT6kaSUliaUeM4j5tTGVXuEG3ijYFi8kOlWN7/5rBYnA55MNYoVb?=
 =?us-ascii?Q?ZJfGdJ5gWur2w6kxi0lG2P8QK6VsitUShOERQjhUlcKUD+8tpEWqDNy78PhM?=
 =?us-ascii?Q?Cpq/M9Z1ykFCHOolcQZHTadfxJtN1S0cUmgwqDYyzYiAef4YjKUKZusGWMHD?=
 =?us-ascii?Q?kLnMQLqx6NmpUukEqaKU2ywmmMMocKqrvzEuyjzYio5FMVtFZx8PlB3uQOZZ?=
 =?us-ascii?Q?Pdlcv7L9+sDT489iNc02obmOL+QxAWw/NwZMXVOvW1NbTqjVNluJfx+4P2QZ?=
 =?us-ascii?Q?8kMa+wCMcIPqyExkJj2fktxb35cbGTFP20RpFyCSUGKB11Uk6Eri2H3oir4D?=
 =?us-ascii?Q?E4PUuFz35LvG5O/9wMXg+qnruV8yaJz/JtXs0lhNIKxlBv6EY4tpvyP4E3CR?=
 =?us-ascii?Q?0uKKVU6jH/zY3dFdgT4QpbRUV0wHDiCNwpXBJR89Dli/sUwyr2yRBlJUo75v?=
 =?us-ascii?Q?yF7GaAHa3OiUh/aXMyPQ0bEpSoDHZD9mOETpQcDL/A5xehOeTY8Fzl7r7e5L?=
 =?us-ascii?Q?OcK6qEdOqUMpt8SR3BXzEHb7Ow326zUgdnYUp0Bm4F/IIh1HRiZTu1Sg/rS+?=
 =?us-ascii?Q?o9pUH4Zs0pk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mL8GEx6JLoQEoExbE3orI9iOeqTe6y5o/GImYOVrQiotQVb+JV6Y62TT5Fse?=
 =?us-ascii?Q?bgmIm5iBIQcmrE8r6mgnQ3/HMkPWHS9xBrH89TG6vYfWR6SFofc14fRTXdZs?=
 =?us-ascii?Q?hYg5r4ujpxt9K3yEVUlScwZNVRYlzO295yAsmSd0ALhvQUZ5rhdvkKI7fKiw?=
 =?us-ascii?Q?oSish/PpzLFGQ1HvK8rRI/buUko9IGS4s3sPzjFJmbwAh/0MAwqlyZstfUni?=
 =?us-ascii?Q?bnnzjkMv/fxh6VL3nu6wDn8axhAXBMkIIFBk4UiK9F54Kbk5AN40JeZH/zAn?=
 =?us-ascii?Q?4PXtDpceWK0sh4UwMQt5OZ07xOsYKq+vjJQWJfbQX09L+BZYlZsgG6y339/V?=
 =?us-ascii?Q?7vjQR+TEf2O6xd6LxA9xTektV6YN9dj3SVigjMrUSQP9pjZ8EXImTVO2pEDP?=
 =?us-ascii?Q?tTs2QEPIZw8aya5mihzPmHupfmxCzU1R3uk66iYijTTgPKyNJYuHlgJ5lMhN?=
 =?us-ascii?Q?Lkz8uKfnSDsfYeIpeKQiEb7dzbc2JSHQpd4MIPUihxFzN3Q+jiDtuWfDMRd2?=
 =?us-ascii?Q?PcVTzeLnEHwjFvA6PYGWSQsbA2tUWCRlMrZ3KFIxXDK1p4GZ2MriyqsXZma9?=
 =?us-ascii?Q?mkGtHpot48d+TL1NgkYGOim9sDf6ybkEazX0gB/FMWLix85G9xW6oTTSNjow?=
 =?us-ascii?Q?Ouojwg8a+BkkEr/YUAOnNHm1Sg0s3d99paFlH6EZPkPgim2i/+89nLjUt5cG?=
 =?us-ascii?Q?ZrxtDEJu7tLO8nyJEYwG2F6gtdAAh6CJzuyNXxOgpP/ZUyPR08HUgaUPSRS/?=
 =?us-ascii?Q?hQt72wIJBNiD6Gt90CuGUQsURIUKTdC5a+oVBEBNB3dEdhEve6xVANMOTq5k?=
 =?us-ascii?Q?g1wilpQSrx2UyCiL5L7TwQptKnQaKH1WslGPPaPqLbkBzwhR9haBMQ/j5vh3?=
 =?us-ascii?Q?sq6X7JBr7l7tGaGW+n87CXHz7GJ0txYuemddFnQd9ssnZN9GnO0eUYeTLCHx?=
 =?us-ascii?Q?ZBhLIn+5K7Xfdt8JsU4zGfk2EDy+JHh9pdF9KDUDdxrAi1OAkiR4TEcy7Dds?=
 =?us-ascii?Q?HjGL232qpsXJl9Be/nH3o+MNgusWrHl7SNgocT9+b6pJupv1kD6yE3XlylmY?=
 =?us-ascii?Q?eq2Rbyi30kSp7qn+7ACRLs581qLvzDqhgyzbIrteWW3697xVV5GbW0F9H0/I?=
 =?us-ascii?Q?1sGMk6z2iIANBcpCKQr1V710jKKhUXZwkD1oHDOnl9gdsls2G5u2w8cVL4Y6?=
 =?us-ascii?Q?y+d9zbqVpxrcucjB+junJ7/orp0YYN9MZmkA09+Lxo7mzQlVB1Gko/qPes9y?=
 =?us-ascii?Q?dJriZtbnRHswZZwEVQNoFarH0e6QujE9hYtnG0vWTi8aY/j5T2YJENIbUubG?=
 =?us-ascii?Q?S722XelTXIZqHntxsh/bR+yS+KFm5Z94lO+lZM5R7fW1543KUXwh1xNAsG3B?=
 =?us-ascii?Q?eEi/A2MjoN7wneQoPOsCl72KRfkOaJfGzE/1gfO0cdNe01u1PmC1j5p+UHhc?=
 =?us-ascii?Q?Yy13N4816hw2sUZniLlFcEGiDgKb5tlZn1L2a6D6lElwcjJkBJwSAD/77tnq?=
 =?us-ascii?Q?cL+CfQ2NeicDrugMsM+V9XyJvLC0/EluBekMpGprox4VxUP65avn9gZ50/22?=
 =?us-ascii?Q?wkV8ufrTEoNp2pH3HZk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a44bdd6-a915-40c6-9d86-08dcce4bfd5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:14:54.7917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+2qcT3OS2vTc9RosPTpxJRjmxguZxpo7921RYTLd+G1wp3Lm/8F/TLFBHHqgRhmcT7u3CExdWAjdjmBzf2YmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

> Subject: [PATCH] arm64: dts: imx8m*-venice-gw75xx: add
> Accelerometer device
>=20
> The GW79xx has a LIS2DE12TR 3-axis accelerometer on the I2C bus
> with an interrupt pin. Add it to the device-tree.
>=20
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../boot/dts/freescale/imx8mm-venice-gw75xx.dtsi | 16
> ++++++++++++++++  .../boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
> | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
> index 5eb92005195c..417c19774b17 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw75xx.dtsi
> @@ -116,6 +116,16 @@ &i2c2 {
>  	pinctrl-0 =3D <&pinctrl_i2c2>;
>  	status =3D "okay";
>=20
> +	accelerometer@19 {
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_accel>;
> +		compatible =3D "st,lis2de12";
> +		reg =3D <0x19>;

Nitpick:
compatible, reg should be top.
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

> +		st,drdy-int-pin =3D <1>;
> +		interrupt-parent =3D <&gpio5>;
> +		interrupts =3D <8 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
>  	eeprom@52 {
>  		compatible =3D "atmel,24c32";
>  		reg =3D <0x52>;
> @@ -198,6 +208,12 @@ MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4
> 		0x40000040 /* GPIOC */
>  		>;
>  	};
>=20
> +	pinctrl_accel: accelgrp {
> +		fsl,pins =3D <
> +			MX8MM_IOMUXC_ECSPI1_MISO_GPIO5_IO8
> 	0x159
> +		>;
> +	};
> +
>  	pinctrl_gpio_leds: gpioledgrp {
>  		fsl,pins =3D <
>  			MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0
> 	0x6	/* LEDG */
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
> index 0d40cb0f05f6..797d1168f4f2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw75xx.dtsi
> @@ -104,6 +104,16 @@ &i2c2 {
>  	pinctrl-0 =3D <&pinctrl_i2c2>;
>  	status =3D "okay";
>=20
> +	accelerometer@19 {
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_accel>;
> +		compatible =3D "st,lis2de12";
> +		reg =3D <0x19>;

Ditto.

> +		st,drdy-int-pin =3D <1>;

This should be at end.

Regards,
Peng.
> +		interrupt-parent =3D <&gpio5>;
> +		interrupts =3D <8 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
>  	eeprom@52 {
>  		compatible =3D "atmel,24c32";
>  		reg =3D <0x52>;
> @@ -204,6 +214,12 @@ MX8MP_IOMUXC_SAI3_RXFS__GPIO4_IO28
> 	0x40000106 /* PCI_WDIS# */
>  		>;
>  	};
>=20
> +	pinctrl_accel: accelgrp {
> +		fsl,pins =3D <
> +
> 	MX8MP_IOMUXC_ECSPI1_MISO__GPIO5_IO08	0x159
> +		>;
> +	};
> +
>  	pinctrl_gpio_leds: gpioledgrp {
>  		fsl,pins =3D <
>  			MX8MP_IOMUXC_SAI2_RXC__GPIO4_IO22
> 	0x6	/* LEDG */
> --
> 2.25.1
>=20


