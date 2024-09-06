Return-Path: <linux-kernel+bounces-318398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F35996ED2E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC631281476
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A792F157494;
	Fri,  6 Sep 2024 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XLweo4LV"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013068.outbound.protection.outlook.com [52.101.67.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9E15622E;
	Fri,  6 Sep 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610080; cv=fail; b=sKt2luxHqG4vdEBzSPZV8BIn8O42b2NExV423KG3Dy8zaF4xZtQZZTcHfTfWDDu4vs579IeVH8jpenSnUZp1gIroh3LucEPpzLi109Pz1rxTXV8A9FPGaYt5c+pjDL9wPhDZ2EH4n5RI7u/i7MB8rsusCKKFABwtYdrQTLtfjXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610080; c=relaxed/simple;
	bh=p7Ttrh9A8To3lSoz8cCgFsfLlPTsGpb9H9NBXPZdPUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i3raZECJTD8QLhBgKW+qeuOv3NcmypUdyqoKByKuB2G3kzNtLh7N3RN6olqQbn3meebk8IPiZLfKQRddgeosLttnGxNF4MR3fXK1P56VwK6Jb8oDmAuFFaMU1ca9ZexY1JipHMCGXmEXCbRMAtmMqxHBIB4375RpqjHwZL34TLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XLweo4LV; arc=fail smtp.client-ip=52.101.67.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oL17JhpeCtq3qY4aNnBGZ03k1fYyb9nKSYzzSGk4Exg9D/Z4tm/1GdNi8863GUjvOoaSE83pgn2dCx5CmR1KO95VNzfGrfAOmIenvCf54kZnhQoB8i6SwCwTm9Hvowom9B+ZCTlvpF0B1UeNYM2uSwXY2sLNzj3nzGqUryHvFOKZ2HowBTfGv3bQwZAl6AK/DRN8IhFlMomIpWg1meNo7MF3aef6bLm16GYta4KJmIAxOLlGCRBntSbIp+scqIxVkSFsq41ax/qSoLLw06R1Nab4Tbf2+imTHqymLUYIMVN7SquXJprrJhnu8ROuz4IJYOS5s0Eu0Y6ZcG1XWHbrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjMABSd3O1ZGUAJm9GpjFV5XKHyDhypd1a+Xs0GzH1s=;
 b=Q+jkxs5fcmAMA0/bcJDtDmk8JLwb/leWJtWCtjyZKgLfo0jkzB5aCUf/H0YulZtKwo5c0IwvyjQdSCU98RwGbhfOpfDEGPACiGjZLwZggb67RqphAv5LioOLlLJq0pnkaKbovc9Ke4+xUTKpwALrsFGn1Apab2bjXV1M6w3u44aAI2+UJFPiSxQkc+Kn9KJK0aHxCxnTt/yncWhMtCNm7bavwC95Z7p0/bRCyP+SIrT7sP6vBogHGPMuEmPd6UU6c42X+lmPFuGI60CpRcfyhecZ2YPwpEeEqFUCxegXfp6KQIASVZJtan8K8atDkMot9YyAKmPZ6JqPoPZ9p8mfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjMABSd3O1ZGUAJm9GpjFV5XKHyDhypd1a+Xs0GzH1s=;
 b=XLweo4LVjHGs9LzMgNgmwgJXuE6gAS6eI0raB5EWLCvIAyeEb7NYgu4jBi679BL2tygsB237kSln+vpJLhR4U1ZWK/tyB7WjxHW834vXJxwQOwzVZhUf3uNGLc1vCabP9gROfWu3EnUlEUIgh+FA4O/TRhMUdlJqRhQ/Z0t2okoCP9W1YoRsuUvpWEofAiCLUKLSrfrvtqJDZUzB+ilOM2SjUGV4c5xyAKnrhnn2XKgWnL6DsTNQ01FVRMqf4b2AyCfzT77ZdEwN3Pw/pKhWHQoIV/3rLYs1T7pIhfn8wcto5u1iaU7S7Y3+tsQxDaiCI/BdXcQlfMAm5TCpt0b2HA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9987.eurprd04.prod.outlook.com (2603:10a6:102:387::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 08:07:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 08:07:55 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "open
 list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/1] arm64: dts: imx93-9x9-qsb: add I3C overlay file
Thread-Topic: [PATCH 1/1] arm64: dts: imx93-9x9-qsb: add I3C overlay file
Thread-Index: AQHa/+CLDYu3TME3mk2qJ6yT21lAa7JKZ1mA
Date: Fri, 6 Sep 2024 08:07:54 +0000
Message-ID:
 <PAXPR04MB8459EBE4C2C7EF52D0A236CC889E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240905221020.2159230-1-Frank.Li@nxp.com>
In-Reply-To: <20240905221020.2159230-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAWPR04MB9987:EE_
x-ms-office365-filtering-correlation-id: b0351056-631a-4cae-9700-08dcce4b0328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?H+Ffa9FFM0PniP72k397pRidMpsuB69MD0eJeqVlbrhlHtPz1j7lfffarv8A?=
 =?us-ascii?Q?s6YH4xE0Icbmmgb/25DrZWEygteewF1ch+HqIouw/ykdf29ieyKK7uq6Q2og?=
 =?us-ascii?Q?mySO8q8VdVH2wtyUgL8H8G6BVOMynM6QDKNwkC5e5Q7E666vTzsNpyDLBZ85?=
 =?us-ascii?Q?9U10JMLlf897euBTSd2LvaAb/QNuIwFlaoaemcO+JdbhRSQ0xJT6NsRCjPYQ?=
 =?us-ascii?Q?VX9OpsRub7yVvvbqx47VJrUyD/N+qKdNCNOb3x074gMYga6ddvFJuFKLIAIR?=
 =?us-ascii?Q?23qJV0NukbabHQ0pFeZrtTfDoAod4BwUfZPYawYyYlLoG8kSr97HWmCVx8ke?=
 =?us-ascii?Q?L94GGc10krcECH+OTcWSBfubN9vSoPlvx/CP82iaILwJ9N0/s/Vx/MqzFvvg?=
 =?us-ascii?Q?Im6FUXEuKf26OnELs1wYXzSV3hbxSp8PRo9tvUBbcgwqULXXzTdUrek6ybr3?=
 =?us-ascii?Q?dE+J4wjXXMIe/PH+hPnm06ARSoFGUNqzSc46TKHJbRaJwgRD5Ww2l+EcHhNM?=
 =?us-ascii?Q?WNv6S8Y//CJg893ktZ6iTGmY+T2V4xDcurlPki8rdWv6WQLBadwzKtTwAgUm?=
 =?us-ascii?Q?zQdIU+v0pKMoipr467RSJ5OY2ZJw14AyZlAeMQ6yZSJ+6+u9xffSySzdW18C?=
 =?us-ascii?Q?2z3FvNFvnXsEj9jD2gte3/pnWAo8jcNVUWxYLMTrEfE7zYlMq8bVYgupuVdk?=
 =?us-ascii?Q?f4gsPgnU+z0OQ5efOD4DcjCshl6Q5qxIMcBZ0t6Q9l+XLdW5wySB1BUtghMY?=
 =?us-ascii?Q?WpqPnkLtzv4qOjHP62UJ0+1yeCMcdhQdFZa3kAnQ92IcBR3HMokRx+sYRnMC?=
 =?us-ascii?Q?I4LlsbsuAI4OOuO25eNi+PnmuxS654FujJBtrokCFm92zCGkvO4px2xtXw/0?=
 =?us-ascii?Q?TQ5DibMQFNSXQW0EXy6cwlrff6AyfOWZXl8He7sj9Fb8FkzSiq1BRl3iqy6+?=
 =?us-ascii?Q?PFreXO1Ow/eMccJQE96WRwW7lSJMqAwDjAIn1XGla3RdXE6h8FxUw1M/O1yc?=
 =?us-ascii?Q?y1NwtMrcNNZcUGwbI/Y4iO9KFvRcX29JpZxdevmiako4Uka64m1FKRlDh+V4?=
 =?us-ascii?Q?kZba3HWHE+yigS0s/9WP72yV5IvbSOHFxvZJ3lnCtITo4ZO/mDg/Leq9ZO8g?=
 =?us-ascii?Q?jjUynpFUV79BiCakdFF1a7WlzGdfqlBZRZ7PKfws23dH/5UbvwEiV15b6emN?=
 =?us-ascii?Q?kRhly5OWaDGWuvzCzQnNb8AAx1ZQYZ9GRVkIDc9EvWm0mePR/lNfOAHy9Tz/?=
 =?us-ascii?Q?I14+/LcvuVIUWaM86qAtMxC7qL+57Jp4R64wmTHF/j9F0UBFeWyfVdnkyX9R?=
 =?us-ascii?Q?cpkARp6XSs7K6XCbECSAvZ7DUYBDLFMIeO9DWTL7cQFPnhUfi6lvDnnDpe2L?=
 =?us-ascii?Q?3tiy8D1pAEXyuzk3rqihcyu3froGe3unozqv5nvESR/qyCrscaI98vO2mPRz?=
 =?us-ascii?Q?jUENH/wsCyI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?b80JP5iokmhjnHFmj6TdtWeXDLGDcvGGY9dYOEMqswr0iED3UaGLXdVX06O7?=
 =?us-ascii?Q?d85h4GxberCf7gCEwSAHNFy9LBDk88xthcYQjRGfiherrHiXZrHspR3Xt/40?=
 =?us-ascii?Q?oz1yl+XqgpwHmESjnhc+cPtczOOSi3M2S7+vh/MOTwan/curbXcmduEJjjj7?=
 =?us-ascii?Q?8ay1KBwOKZiggf5GBx05KkQ++Pc5tPyMG97U6F/BlvjftvnQ9+XYW5WMfwkG?=
 =?us-ascii?Q?x6b3faU0bCMrCsXLrnIP9g1M27gkYp/ilR1/lffzSyNocIFXrCKb3Hqhxeux?=
 =?us-ascii?Q?6NU9yWHTWb2MO9HfrvrUrIdhJhyhQ+j10rkE8h2L0mwkXNLJRf5qMAdYpDvL?=
 =?us-ascii?Q?AxtN5klOrvueTQpdrgyeKXU62II10qb8wNACucQKv3kz0/xL8QKLHOfAeoQb?=
 =?us-ascii?Q?itOFHHaMYElnM4KPLi5Lxvgm9C1x0EaaRnXv/AlWwgewGMMXDaAiz10ZncUG?=
 =?us-ascii?Q?ISDrPSMB28exk/8pdMabY5wulF/myQwQVXwOmafQdslAP7n60UB0K9F4NbUj?=
 =?us-ascii?Q?HUCVAkNAEQe5qsY7+cJODIHKaAKxJY2glYdcDY9IVwOe+0oDltW6vMppnulr?=
 =?us-ascii?Q?S3gO+mVJ34osJbRRNg5+jLlDpR2yLzMJJXHYDy6Dkk9TFE+eT3OCiIFQ4mY4?=
 =?us-ascii?Q?GFqc4UPiGaZaxdQGNVTz+ijHY+CcvQUCuYYTGIWCYGXHUzikMkgGEGBJ/WDd?=
 =?us-ascii?Q?KIh57sRTte7zry/tvxy+AjgVXNu95CsZurxVHmpEDRY4/ZzK5xWmNteAKzfU?=
 =?us-ascii?Q?U6kzadFBJ0eOE0JjzcSgfChAlJNn+ZJ37+V7bBtQ4srxc9DkUJ3PorAHpypU?=
 =?us-ascii?Q?zvmz9lB5qx3YCQy520GhE4C2eLxFQhvZsc27EDRXSaOsiJGnqKedLSlXDgZd?=
 =?us-ascii?Q?7zn/P+k0ebVMcUf1s0fjy7Zg1Zme726G5rBaxQxlidYZy28RvLDsHDq6rt9A?=
 =?us-ascii?Q?xRnPjy21dmJwl2kw1OAP8Zydx13LBN6CvSBmHQcTVyEcXyZfjf1vvLv0fZSC?=
 =?us-ascii?Q?8y3e7XHtIfppXPYBa4fhOJslHk0FQCMlAKe5TNkLqx6qixVBAZ1w1gWeNi3s?=
 =?us-ascii?Q?H44MpOxGM8YQE4daUCyDeFDG4Q0TOP1K9JuO7FfUGekRydNhI5bvOeG4Fdfh?=
 =?us-ascii?Q?p/kcO/QFc/PHg8+jadM5NVwTxwRkqDncv2m6i6TdKEtrR0apt/wG4vL2zCch?=
 =?us-ascii?Q?3XKJBFN22broEUqTsWWSxtB4gPEAnI4wDmLXI+Ns1Lkzk90KijhXKK+kxmCs?=
 =?us-ascii?Q?t6doDXw7hwK7BFK8yMiAIKZmrCpQooh4YTW9MI6hqB3mJz5gdXffsVmcM+MJ?=
 =?us-ascii?Q?U6ucGr7wG0GHMbaBeWaBqXa3nKHzn76iyjhkNq65Y0yTwzEubtPfxcoFDCZ1?=
 =?us-ascii?Q?9AZmCrfqdkU1nx+sgAqPfewyMzHz0Jw/sYMJWhvoSuN5iS94s7E9XM2K0OGQ?=
 =?us-ascii?Q?7BCX+O8BsYV4WXSP2baHo6K0+5xYO9cByes7BCVpVb04AMkkbtEfkDykaSFu?=
 =?us-ascii?Q?GTYU7/tCJvdsxIIQAkYVmCdTI6avnddFF//Uv4qTTz6T6SvGd2qincWpTWy8?=
 =?us-ascii?Q?4ysSV7/ktQOThx59hkw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0351056-631a-4cae-9700-08dcce4b0328
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 08:07:55.0012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymbDEJ8PeVdleABPswdVAq8NfWaTvSSYb3LhRT42HjdWURYHtNGd9ekzJOkGAbzpnv0A8ubzKRfLyJAB9aBirg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9987

> Subject: [PATCH 1/1] arm64: dts: imx93-9x9-qsb: add I3C overlay file
>=20
> Add an overlay file to enable I3C support on the i.MX93, replacing I2C1
> with I3C. I3C is compatible with I2C, but it has not yet been enabled in
> arm64's defconfig. This overlay allows users to conveniently utilize I3C
> on the imx93-9x9-qsb platform until I3C and its driver become more
> mature and ready for full switch to I3C.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  4 +
>  .../boot/dts/freescale/imx93-9x9-qsb-i3c.dtso | 73
> +++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-9x9-qsb-
> i3c.dtso
>=20
> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile
> index 9d3df8b218a2e..032f07adc0c53 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -240,6 +240,10 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-
> mek.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-tqma8xqp-mba8xx.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-9x9-qsb.dtb
> +
> +imx93-9x9-qsb-i3c-dtbs +=3D imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-9x9-qsb-i3c.dtb
> +
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-14x14-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-kontron-bl-osm-s.dtb diff --git
> a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso
> b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso
> new file mode 100644
> index 0000000000000..94d562fa8077d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2022 NXP

Update '2022' to '2024'.

> + */
> +
> +#include <dt-bindings/clock/imx93-clock.h>=20

Drop this include.

#include
> +<dt-bindings/interrupt-controller/arm-gic.h>

Use irq.h

Regards,
Peng.

