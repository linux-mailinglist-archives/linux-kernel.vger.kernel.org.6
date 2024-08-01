Return-Path: <linux-kernel+bounces-270571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C582D94418A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6AB21C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A513D285;
	Thu,  1 Aug 2024 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QoiTfUO3"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8113C9C0;
	Thu,  1 Aug 2024 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722481753; cv=fail; b=Nz9LI9PQDKOdN6yIRo9vZMnqaITgFSiQU52mDcqXofn+umP8lyfziUHeFs7DtTYbpzRg/gRXS/uS0UlB6ThR8/zRjxV9ji0vIrc8joe0cgSdJt6dnZoZAr+ZjLgGV2ZpRqb1sn/6G8egThl7PV9hJgUZF5HpUTffd7vqAjZpKMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722481753; c=relaxed/simple;
	bh=nPJqHChCqClADNDTTYNrmzh7x3LnqhO39HEDbZ8tjPM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oCLPS0hujw5RR3Xz1LGx9O+LBbz0E21vX0Zl1UopSi5rUE7EXP94A5JGDbRDVwdKoyMx59zKoOh5ZQkE+yYLMVPShfyDVo1ii7Dc93fBbiN5/4i1WfeV1Ni2m7gTS+fplLbeIZohMxKvz7sNEK8Aar6fCNF93pHoIDqYp1WV8W8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QoiTfUO3; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzZEhg+4uM+cgcRv9U7x+fY/ZCB78a81GhixejBIGuCrDKDMDoJaQoPQTpVjyTsz61gQvqg8ldWF9hsGsRbXDQ9YlPgZ/6TSf5sUMgRV78P+16ziEqtHqGUrwmwrRqGjEBApr9B9xQI1LFnhNbahFh297WVZ4al0X+Ta3B71P11m457TcABwEtvhismSb1mNN6qtZugTAmOQQrFDZNbLoIQSBz4iaHDmLz3u+1NW2yzekrLdpMIFVdRRHcGM1Z0g6aWiwpGQ3i27TYFYwp3mpAB1Wo/uSVHtcGgUnDOZdt/CSrXDCwD+Mf3JiI+4kXsO5Wz6soRfG0HqySkPQawa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vsz7AR1K5USSC6GstEloJEKEnmC6rbGVPFDf4gWmmxQ=;
 b=VgOsoR2jm7Pmh7CPaIIInSk5p+0kWxvmjdh01vRUfsXcOBOeoeYaOz7n+x/2FDkd1OWUphqOIWBeS304Qgq8veE3t4ffPZ8y68WpuCq6Q5TTpz28EzLSjOQ9vNoxvMLuksZ1HWPcjohYSxPY95QKauMNasDFpS4qYr4Fh+YJ0cl8E5sBL8XTqySa3O4Zkj9DiBqK3QnGuyvTxSUFluRZXxUy+/fZug9rF0zv5y0SVPNIfhA5rMuarDuL04iHiUD0P0efeDClQ6Ekef5vjlS8fcK1mOtE3fj1p4pdAFynx2MvUzJXMvdrVG6kOWuJG5sMwTy0ILRTzXx9TM5DG8HEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vsz7AR1K5USSC6GstEloJEKEnmC6rbGVPFDf4gWmmxQ=;
 b=QoiTfUO34loaNILpM9GI1aIdBomTXfpWLvUGmm6a4v0npcKrMQqGSQ3PkdJm7oJbEvPKY6kXMMQY7UzGpTbeLK9AZarYiq0Zbr1ywrisfiNTez8alJcvNw+7uKYHlBNQheW+Hzd+xQAU7vU1d9t9BuBVdhYyguroSLLmcoRe1YHXXV5uF55oiL4l1/TE+/3sfZEGGeeAKSfR6op6kPxyaZGss5BRoy1s71pnRkLd3dA5eP19trIi0S/H/LXCQ8jWWFdUGuifTsuXKJE6vuY0koRdK9x0fsQ+EN6/pR7fZOEW7wFzq6XGj9TCEDPIxyXcK4OcD54e+GKrIMuDDuQJew==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8859.eurprd04.prod.outlook.com (2603:10a6:20b:40a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 1 Aug
 2024 03:09:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 03:09:07 +0000
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
Subject: RE: [PATCH 10/14] arm64: dts: freescale: imx93-tqma9352-mba93xxca:
 improve pad configuration
Thread-Topic: [PATCH 10/14] arm64: dts: freescale: imx93-tqma9352-mba93xxca:
 improve pad configuration
Thread-Index: AQHa3cmsFrcjE5lDX0a2jPugfCDCmLIRxHrw
Date: Thu, 1 Aug 2024 03:09:07 +0000
Message-ID:
 <PAXPR04MB8459F49E3159E861599104E188B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-11-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240724125901.1391698-11-alexander.stein@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8859:EE_
x-ms-office365-filtering-correlation-id: 2a0ab5b1-0502-474e-c53c-08dcb1d74e8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KH056nZWVTtm+lC+8Y0k0FIWwxhO/ZfYgUXlKsd2HjtkOMNTPXYfmEqaZvyI?=
 =?us-ascii?Q?IpBPIZ3VJdA9+2D8zEl9MBitOY8cro7L8+/zfm/n3RjmPSiqabinHdmjWpzh?=
 =?us-ascii?Q?aDMKeevNm6qKoQFVZiOa2154O+ThTCxKTmZNJqkzCzYifx3/L8g7VvZPrCk8?=
 =?us-ascii?Q?YBX1g6sFSpXcBV6ASgcIydCqSfJYhXf2uBTNMWIF41NNVVqZMyqMkcP/qYyw?=
 =?us-ascii?Q?JeYSaa5rFbJr1gqg9a1KLlKe/dp/IFk8Er+h3Je4a2UG9cy5rduMzJ39s9bv?=
 =?us-ascii?Q?3ZYm0hdwphPNkVVrD0FrjHMWv22hkDXYXJCgPdkw4J26s1wbFZQdhGs5IRKP?=
 =?us-ascii?Q?bkK4ThKot3xGwSgryrOel8cvDyFEdXYP1cMXdZpyXGJ2SIOg00fo3xAxbaMA?=
 =?us-ascii?Q?3omw7fRxwydz68EwTPhChqwjmtIspEoUJ7/vmH2kVbYISQzylS+v3RzbRfo8?=
 =?us-ascii?Q?ozbmqzy5syxyuzuPd1qnwAGLsAsULjGiFKw4cBMrMbOhY0tFxpldxGkahyEc?=
 =?us-ascii?Q?erH1MakJkO/YXnHvbq/EAxLIbj0xPX9Z2Sp4xRmgaY9rYOSjoiZ2ublj0gC3?=
 =?us-ascii?Q?sV3khtoAgpHlHEO1V467oFfwNBf0KaAQlBpu5kTO5g4YIOB6PicYEdmXttHO?=
 =?us-ascii?Q?EUmQBg+vNjdjEr7uesoHwtrSNLUzluq9R9pTP2ZyWzUCJ72DxOpA/wJQ0olh?=
 =?us-ascii?Q?ar/5rJF9bPLeE7zK4TQMH+FnaMtH1iB3jSDHLDDDvKlNLTX9xTRCvC7ad7c6?=
 =?us-ascii?Q?8ME6NdfRK7tYI3UUKHmLvKuvXzrAsIM5EhZfTSNiCCv/sMeKbWyHswyzV3NQ?=
 =?us-ascii?Q?9c0nPUPD5QqLk8T8qi8RXVduX62YK6wsmnqrZrVto0XIFVTvZ5OQ5HRUumez?=
 =?us-ascii?Q?e4Yarrdj1CCaXRmbh6b2g1LFcK8Bxr9Bq9wDPRWTVVSdl0nU3pi0s0eFg7Nr?=
 =?us-ascii?Q?wYXodJz79TuLYGVV0GqrMfEpSZS2vq6yhLhPJqnBo/D2rNHHzts0wx+XFCwP?=
 =?us-ascii?Q?ubEJFIfx7ZzSsjnlPQ6iXjrHklJPHwcGdtGPvxssYtE0movjbizueEqqcHqV?=
 =?us-ascii?Q?MBcneHBBgk3ObSiqD+9FMRgwCi3a3Pl3XjQEyk1L8TRliFM742yn5X5uxv/U?=
 =?us-ascii?Q?Bg7AMdMXfUShaNE9ERGJM+T0RomAs7jzX4bbMQPa+J4GQ3QL70nY614s19ih?=
 =?us-ascii?Q?H42e1CCbnjQmHvEFAAbI6V1y6iA/EFnP2skOJvyPa/bPSCIzAsmkOMRV4D/p?=
 =?us-ascii?Q?kbHFUlRYaO2oDdofXZnkzidY7ZWSgMAHr/nYMnEJdG3PFSulKmOlnE/K4UaB?=
 =?us-ascii?Q?9nohD4AtiislKoT27TiZ6M58526pfvc755tf3eyNhJ5ISuBqPNGPAZ/gpTgx?=
 =?us-ascii?Q?Yq73ab2CpJLL5656eZxwmY4MuB9ak9JYXZ47c0MZpPdDnFkkLg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GFxW2NKUzdZsODMLVe53ufulmyxLw9CAPLfBuZ8npNBSm4qWL4YfYhNO6EK1?=
 =?us-ascii?Q?CDjdYxAeCl3U8tO/aiW4Xbz4EvF0JUyaJ4nzU0kAEI36k6Gi7jv6w8My0E8E?=
 =?us-ascii?Q?8E3z7EAx3WYPmIBbQjw6IHHu2cJteykseWf4lCujzZ48+/NQrFX5u92JcXaL?=
 =?us-ascii?Q?yPpOpqqoBwTCduCs1hJPjHAR41H/qfSB1Y4fjlyDNgkeTxqIEcT865SBqap3?=
 =?us-ascii?Q?ZszA0oHYGXiPTbfvQTwpz8gQJhEWHxstVLOT0wTWaiXdZqqztgnJYoaS7QHq?=
 =?us-ascii?Q?916wpIEXRR+mC4tmYsPk/0V3jdnh9AUgjM5WK3a9BGZgPEs6veIaE70BTdpz?=
 =?us-ascii?Q?MtaZHXqw328WYgEokHNQNDm3TZ93kIVR+qaWUpqrhGVvMsUG88EX9+FLnOX/?=
 =?us-ascii?Q?nifz9vvMV3/6QnMiTwVCQeMRERkZMmuoCpOJNVzjK/VxwgDjbJAL/ZVgAOBT?=
 =?us-ascii?Q?dsCJqlD6G3jnzavNl33EupChPYHr7JY09PZ8RPthsnVl8Zq2p9UHu1wGPOlY?=
 =?us-ascii?Q?6Pf+IY0pLhq5wkhnXf26lVcjpXfaYFXsPESffblooExfq8331APq6AS/dk/h?=
 =?us-ascii?Q?ELONpoxb/3cVRnfp/vy3pwrR3yWR8ICRiNiN0pojD0FkSWXt32p1tzmwSgXD?=
 =?us-ascii?Q?Xpm7j2/j9U3Y/aePDO1Nym/NxaFpaoQwM5jVQDKPqKoA+rmLUh1jB0kao05w?=
 =?us-ascii?Q?7kM+dudmhj4R1sND8bPLNiM0n2HAZIvqDAoK7FS+hFnaOGTqVTdPMD5mdJ/B?=
 =?us-ascii?Q?pjMevsEXMmkC75HefXtVPbN63olYRXoVnwUV8PJeXgf6LABphoSWkjYoo0Ez?=
 =?us-ascii?Q?5SxgxZJSmtkNou3DNJsle4H+wfnzCgfjGnvarMC1uThUUK/dFOIeYUGHZ1eA?=
 =?us-ascii?Q?QXJyk1LbEBCoaCR4Xao86ZBLFLNfiCB1B1+Xz6NTENLpMjMtc3DKF2QBSN43?=
 =?us-ascii?Q?yS2Q/4feDgIAed0F6q5AQjIO5N2XtAXfsZ1uBVJ9CRuB0BodGdt8E+Md7ZFv?=
 =?us-ascii?Q?Hm07Y0BhxHom0/WtORwr3TOP/Y82d0j5uXASNRsKHgP9vNALMyAvUQdYtscS?=
 =?us-ascii?Q?1cGRT0UWZqU14mc7/GXDYvslN82xalxEerjEoZ2aqXmLtsu1YMAk7CGggjG7?=
 =?us-ascii?Q?REBFfFGjgbx5/u9Dur7GGGJVMUaNrJGh0cU//x2mVLMZw8gIgr/DJRdhsX7r?=
 =?us-ascii?Q?rRe98C3PQOvbm65hUgnvLDP0gT7RTGM3v7qHpe3Ef58xPALMR6ea11vOJI2R?=
 =?us-ascii?Q?sanzGbT0PqFW7WXfFyS1/zxBtU+NFoxBgy5XwjgACNhO70F4X3HFuK8tpnia?=
 =?us-ascii?Q?+urXj1Z6kUFGGciN1ceYNM1JAHyG82V6uNABGRiROCnDF2jppRHdMYIFh4Y5?=
 =?us-ascii?Q?2oTxL5tAJjCVVoJwZJAh4KpGoPUma69gXFXaX+CZScSlqNGX5UPttPxsRoRb?=
 =?us-ascii?Q?r3corlHHToOaU+Y9r1LT+AhHL4HZaJB1MgcQeS08jqIpf66DnNxPOK2G5fsb?=
 =?us-ascii?Q?3yAyAkTlgGNaXeOyR3FYpiuI0CPRXQGLene8A2Tq+MWgHP5k1ZILHHIUxZbJ?=
 =?us-ascii?Q?u09HvDMSrxHLqyAcdUI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0ab5b1-0502-474e-c53c-08dcb1d74e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 03:09:07.3303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiLexsUIF00xbK6G42OKh1V5WXoiiZdK2mHOQzIESQh54c9Zoh/e3Oa4gO0ZyrGGKbt5Irb3r3g7EC/9VEfoRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8859

> Subject: [PATCH 10/14] arm64: dts: freescale: imx93-tqma9352-
> mba93xxca: improve pad configuration
>=20
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>=20
> - disable PU/PD if already done with external resistors
> - do not configure Schmitt Trigger for outputs
> - do not configure DSE / FSEL for inputs
> - add missing pad groups
> - assign muxed GPIO pads for X1 to gpio2 node
>=20
> Pad config changes suggested by hardware team.
>=20
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../freescale/imx93-tqma9352-mba93xxca.dts    | 235 ++++++++++++---
> ---
>  1 file changed, 159 insertions(+), 76 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxca.dts
> index 852dd3d2eac7..99a0b6b9e304 100644
> --- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
> +++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-
> mba93xxca.dts
> @@ -289,6 +289,11 @@ tcpc-irq-hog {
>  	};
>  };
>=20
> +&gpio2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_gpio2>;

New change.

I would prefer merge the pad improve into one. But see if
Shawn is ok to separate or merge to one.

Regards,
Peng.

> +};
> +
>  &lpi2c3 {
>  	#address-cells =3D <1>;
>  	#size-cells =3D <0>;
> @@ -559,22 +564,23 @@ &iomuxc {
>  	pinctrl_eqos: eqosgrp {
>  		fsl,pins =3D <
>  			/* PD | FSEL_2 | DSE X4 */
> -			MX93_PAD_ENET1_MDC__ENET_QOS_MDC
> 		0x51e
> -
> 	MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO
> 	0x4000051e
> -			/* PD | FSEL_2 | DSE X6 */
> -
> 	MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0
> 	0x57e
> -
> 	MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1
> 	0x57e
> -
> 	MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2
> 	0x57e
> -
> 	MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3
> 	0x57e
> -			/* PD | FSEL_3 | DSE X6 */
> -
> 	MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE
> _RX_CLK	0x5fe
> -
> 	MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL
> 	0x57e
> +			MX93_PAD_ENET1_MDC__ENET_QOS_MDC
> 			0x51e
> +			/* SION | HYS | FSEL_2 | DSE X4 */
> +
> 	MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO
> 	0x4000111e
> +			/* HYS | FSEL_0 | DSE no drive */
> +
> 	MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0
> 	0x1000
> +
> 	MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1
> 	0x1000
> +
> 	MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2
> 	0x1000
> +
> 	MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3
> 	0x1000
> +
> 	MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL
> 	0x1000
> +			/* HYS | PD | FSEL_0 | DSE no drive */
> +
> 	MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE
> _RX_CLK	0x1400
>  			/* PD | FSEL_2 | DSE X4 */
> -
> 	MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0
> 	0x51e
> -
> 	MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1
> 	0x51e
> -
> 	MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2
> 	0x51e
> -
> 	MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3
> 	0x51e
> -
> 	MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL
> 	0x51e
> +
> 	MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0
> 	0x51e
> +
> 	MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1
> 	0x51e
> +
> 	MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2
> 	0x51e
> +
> 	MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3
> 	0x51e
> +
> 	MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL
> 	0x51e
>  			/* PD | FSEL_3 | DSE X3 */
>=20
> 	MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE
> _TX_CLK	0x58e
>  		>;
> @@ -582,7 +588,8 @@
> MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK
> 	0x58e
>=20
>  	pinctrl_eqos_phy: eqosphygrp {
>  		fsl,pins =3D <
> -			MX93_PAD_CCM_CLKO1__GPIO3_IO26
> 	0x1306
> +			/* HYS | FSEL_0 | DSE no drive */
> +			MX93_PAD_CCM_CLKO1__GPIO3_IO26
> 		0x1000
>  		>;
>  	};
>=20
> @@ -590,15 +597,16 @@ pinctrl_fec: fecgrp {
>  		fsl,pins =3D <
>  			/* PD | FSEL_2 | DSE X4 */
>  			MX93_PAD_ENET2_MDC__ENET1_MDC
> 		0x51e
> -			MX93_PAD_ENET2_MDIO__ENET1_MDIO
> 		0x4000051e
> -			/* PD | FSEL_2 | DSE X6 */
> -			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0
> 		0x57e
> -			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1
> 		0x57e
> -			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2
> 		0x57e
> -			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3
> 		0x57e
> -			/* PD | FSEL_3 | DSE X6 */
> -			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC
> 		0x5fe
> -
> 	MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL
> 	0x57e
> +			/* SION | HYS | FSEL_2 | DSE X4 */
> +			MX93_PAD_ENET2_MDIO__ENET1_MDIO
> 		0x4000111e
> +			/* HYS | FSEL_0 | DSE no drive */
> +			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0
> 		0x1000
> +			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1
> 		0x1000
> +			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2
> 		0x1000
> +			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3
> 		0x1000
> +
> 	MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL
> 	0x1000
> +			/* HYS | PD | FSEL_0 | DSE no drive */
> +			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC
> 		0x1400
>  			/* PD | FSEL_2 | DSE X4 */
>  			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0
> 		0x51e
>  			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1
> 		0x51e
> @@ -612,147 +620,222 @@
> MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x58e
>=20
>  	pinctrl_fec_phy: fecphygrp {
>  		fsl,pins =3D <
> -			MX93_PAD_CCM_CLKO2__GPIO3_IO27
> 	0x1306
> +			/* HYS | FSEL_0 | DSE no drive */
> +			MX93_PAD_CCM_CLKO2__GPIO3_IO27
> 		0x1000
>  		>;
>  	};
>=20
>  	pinctrl_flexcan1: flexcan1grp {
>  		fsl,pins =3D <
> -			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX
> 	0x139e
> -			MX93_PAD_PDM_CLK__CAN1_TX
> 	0x139e
> +			/* HYS | PU | FSEL_0 | DSE no drive */
> +			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX
> 		0x1200
> +			/* PU | FSEL_3 | DSE X4 */
> +			MX93_PAD_PDM_CLK__CAN1_TX
> 		0x039e
>  		>;
>  	};
>=20
>  	pinctrl_flexcan2: flexcan2grp {
>  		fsl,pins =3D <
> -			MX93_PAD_GPIO_IO25__CAN2_TX
> 	0x139e
> -			MX93_PAD_GPIO_IO27__CAN2_RX
> 	0x139e
> +			/* HYS | PU | FSEL_0 | DSE no drive */
> +			MX93_PAD_GPIO_IO27__CAN2_RX
> 		0x1200
> +			/* PU | FSEL_3 | DSE X4 */
> +			MX93_PAD_GPIO_IO25__CAN2_TX
> 		0x039e
> +		>;
> +	};
> +
> +	pinctrl_gpio2: gpio2grp {
> +		fsl,pins =3D <
> +			/* HYS | PD | FSEL_2 | DSE X4 */
> +			MX93_PAD_GPIO_IO16__GPIO2_IO16
> 		0x151e
> +			MX93_PAD_GPIO_IO17__GPIO2_IO17
> 		0x151e
> +			MX93_PAD_GPIO_IO18__GPIO2_IO18
> 		0x151e
> +			MX93_PAD_GPIO_IO19__GPIO2_IO19
> 		0x151e
> +			MX93_PAD_GPIO_IO20__GPIO2_IO20
> 		0x151e
> +			MX93_PAD_GPIO_IO21__GPIO2_IO21
> 		0x151e
> +			MX93_PAD_GPIO_IO26__GPIO2_IO26
> 		0x151e
> +		>;
> +	};
> +
> +	pinctrl_jtag: jtaggrp {
> +		fsl,pins =3D <
> +
> 	MX93_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK
> 	0x051e
> +			MX93_PAD_DAP_TDI__JTAG_MUX_TDI
> 		0x1200
> +
> 	MX93_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO
> 	0x031e
> +
> 	MX93_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS
> 	0x1200
>  		>;
>  	};
>=20
>  	pinctrl_lpi2c3: lpi2c3grp {
>  		fsl,pins =3D <
> -			MX93_PAD_GPIO_IO28__LPI2C3_SDA
> 	0x40000b9e
> -			MX93_PAD_GPIO_IO29__LPI2C3_SCL
> 	0x40000b9e
> +			/* SION | HYS | OD | FSEL_3 | DSE X4 */
> +			MX93_PAD_GPIO_IO28__LPI2C3_SDA
> 		0x4000199e
> +			MX93_PAD_GPIO_IO29__LPI2C3_SCL
> 		0x4000199e
>  		>;
>  	};
>=20
>  	pinctrl_lpi2c5: lpi2c5grp {
>  		fsl,pins =3D <
> -			MX93_PAD_GPIO_IO22__LPI2C5_SDA
> 	0x40000b9e
> -			MX93_PAD_GPIO_IO23__LPI2C5_SCL
> 	0x40000b9e
> +			/* SION | HYS | OD | FSEL_3 | DSE X4 */
> +			MX93_PAD_GPIO_IO22__LPI2C5_SDA
> 		0x4000199e
> +			MX93_PAD_GPIO_IO23__LPI2C5_SCL
> 		0x4000199e
>  		>;
>  	};
>=20
>  	pinctrl_lpspi6: lpspi6grp {
>  		fsl,pins =3D <
> -			MX93_PAD_GPIO_IO00__LPSPI6_PCS0
> 	0x3fe
> -			MX93_PAD_GPIO_IO01__LPSPI6_SIN
> 	0x3fe
> -			MX93_PAD_GPIO_IO02__LPSPI6_SOUT
> 	0x3fe
> -			MX93_PAD_GPIO_IO03__LPSPI6_SCK
> 	0x3fe
> +			/* FSEL_2 | DSE X4 */
> +			MX93_PAD_GPIO_IO00__LPSPI6_PCS0
> 		0x011e
> +			/* HYS | PD | FSEL_0 | DSE no drive */
> +			MX93_PAD_GPIO_IO01__LPSPI6_SIN
> 		0x1400
> +			/* PD | FSEL_2 | DSE X4 */
> +			MX93_PAD_GPIO_IO02__LPSPI6_SOUT
> 		0x051e
> +			MX93_PAD_GPIO_IO03__LPSPI6_SCK
> 		0x051e
> +		>;
> +	};
> +
> +	pinctrl_mipi_csi: mipicsigrp {
> +		fsl,pins =3D <
> +
> 	MX93_PAD_CCM_CLKO3__CCMSRCGPCMIX_CLKO3
> 	0x051e /* MCLK */
> +			MX93_PAD_GPIO_IO10__GPIO2_IO10
> 		0x051e /* TRIGGER */
> +			MX93_PAD_GPIO_IO11__GPIO2_IO11
> 		0x1400 /* SYNC */
> +		>;
> +	};
> +
> +	pinctrl_pcf85063: pcf85063grp {
> +		fsl,pins =3D <
> +			MX93_PAD_SAI1_RXD0__GPIO1_IO14
> 		0x1000
>  		>;
>  	};
>=20
>  	pinctrl_pexp_irq: pexpirqgrp {
>  		fsl,pins =3D <
> -			MX93_PAD_SAI1_TXC__GPIO1_IO12
> 	0x1306
> +			/* HYS | FSEL_0 | No DSE */
> +			MX93_PAD_SAI1_TXC__GPIO1_IO12
> 		0x1000
>  		>;
>  	};
>=20
>  	pinctrl_pwmfan: pwmfangrp {
>  		fsl,pins =3D <
> -			MX93_PAD_GPIO_IO09__GPIO2_IO09
> 	0x1306
> +			/* HYS | PU | FSEL_0 | no DSE */
> +			MX93_PAD_GPIO_IO09__GPIO2_IO09
> 		0x1200
> +		>;
> +	};
> +
> +	pinctrl_tc9595: tc9595-grp {
> +		fsl,pins =3D <
> +			/* HYS | PD | FSEL_0 | no DSE */
> +			MX93_PAD_CCM_CLKO4__GPIO4_IO29
> 		0x1400
> +		>;
> +	};
> +
> +	pinctrl_temp_sensor_som: tempsensorsomgrp {
> +		fsl,pins =3D <
> +			/* HYS | FSEL_0 | no DSE */
> +			MX93_PAD_SAI1_TXFS__GPIO1_IO11
> 		0x1000
>  		>;
>  	};
>=20
>  	pinctrl_tpm5: tpm5grp {
>  		fsl,pins =3D <
> -			MX93_PAD_GPIO_IO06__TPM5_CH0
> 	0x57e
> +			MX93_PAD_GPIO_IO06__TPM5_CH0
> 		0x57e
>  		>;
>  	};
>=20
>  	pinctrl_tpm6: tpm6grp {
>  		fsl,pins =3D <
> -			MX93_PAD_GPIO_IO08__TPM6_CH0
> 	0x57e
> +			MX93_PAD_GPIO_IO08__TPM6_CH0
> 		0x57e
>  		>;
>  	};
>=20
>  	pinctrl_typec: typecgrp {
>  		fsl,pins =3D <
> -			MX93_PAD_I2C2_SCL__GPIO1_IO02
> 	0x1306
> +			/* HYS | FSEL_0 | No DSE */
> +			MX93_PAD_I2C2_SCL__GPIO1_IO02
> 		0x1000
>  		>;
>  	};
>=20
>  	pinctrl_uart1: uart1grp {
>  		fsl,pins =3D <
> -			MX93_PAD_UART1_RXD__LPUART1_RX
> 	0x31e
> -			MX93_PAD_UART1_TXD__LPUART1_TX
> 	0x31e
> +			/* HYS | FSEL_0 | No DSE */
> +			MX93_PAD_UART1_RXD__LPUART1_RX
> 		0x1000
> +			/* FSEL_2 | DSE X4 */
> +			MX93_PAD_UART1_TXD__LPUART1_TX
> 		0x011e
>  		>;
>  	};
>=20
>  	pinctrl_uart2: uart2grp {
>  		fsl,pins =3D <
> -			MX93_PAD_UART2_TXD__LPUART2_TX
> 	0x31e
> -			MX93_PAD_UART2_RXD__LPUART2_RX
> 	0x31e
> -			MX93_PAD_SAI1_TXD0__LPUART2_RTS_B
> 0x51e
> +			/* HYS | FSEL_0 | No DSE */
> +			MX93_PAD_UART2_RXD__LPUART2_RX
> 		0x1000
> +			/* FSEL_2 | DSE X4 */
> +			MX93_PAD_UART2_TXD__LPUART2_TX
> 		0x011e
> +			/* FSEL_2 | DSE X4 */
> +			MX93_PAD_SAI1_TXD0__LPUART2_RTS_B
> 		0x011e
>  		>;
>  	};
>=20
>  	pinctrl_uart3: uart3grp {
>  		fsl,pins =3D <
> -			MX93_PAD_GPIO_IO14__LPUART3_TX
> 	0x31e
> -			MX93_PAD_GPIO_IO15__LPUART3_RX
> 	0x31e
> +			/* HYS | FSEL_0 | No DSE */
> +			MX93_PAD_GPIO_IO15__LPUART3_RX
> 		0x1000
> +			/* FSEL_2 | DSE X4 */
> +			MX93_PAD_GPIO_IO14__LPUART3_TX
> 		0x011e
>  		>;
>  	};
>=20
>  	pinctrl_uart6: uart6grp {
>  		fsl,pins =3D <
> -			MX93_PAD_GPIO_IO04__LPUART6_TX
> 	0x31e
> -			MX93_PAD_GPIO_IO05__LPUART6_RX
> 	0x31e
> +			/* HYS | FSEL_0 | No DSE */
> +			MX93_PAD_GPIO_IO05__LPUART6_RX
> 		0x1000
> +			/* FSEL_2 | DSE X4 */
> +			MX93_PAD_GPIO_IO04__LPUART6_TX
> 		0x011e
>  		>;
>  	};
>=20
>  	pinctrl_uart8: uart8grp {
>  		fsl,pins =3D <
> -			MX93_PAD_GPIO_IO12__LPUART8_TX
> 	0x31e
> -			MX93_PAD_GPIO_IO13__LPUART8_RX
> 	0x31e
> +			/* HYS | FSEL_0 | No DSE */
> +			MX93_PAD_GPIO_IO13__LPUART8_RX
> 		0x1000
> +			/* FSEL_2 | DSE X4 */
> +			MX93_PAD_GPIO_IO12__LPUART8_TX
> 		0x011e
>  		>;
>  	};
>=20
>  	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
>  		fsl,pins =3D <
> -			MX93_PAD_SD2_CD_B__GPIO3_IO00
> 	0x31e
> +			/* HYS | FSEL_0 | No DSE */
> +			MX93_PAD_SD2_CD_B__GPIO3_IO00
> 		0x1000
>  		>;
>  	};
>=20
>  	pinctrl_usdhc2_hs: usdhc2hsgrp {
>  		fsl,pins =3D <
> -			/* HYS | PD | PU | FSEL_3 | DSE X5 */
> -			MX93_PAD_SD2_CLK__USDHC2_CLK
> 	0x17be
> -			/* HYS | PD | PU | FSEL_3 | DSE X4 */
> -			MX93_PAD_SD2_CMD__USDHC2_CMD
> 	0x139e
> -			/* HYS | PD | PU | FSEL_3 | DSE X3 */
> -			MX93_PAD_SD2_DATA0__USDHC2_DATA0
> 	0x138e
> -			MX93_PAD_SD2_DATA1__USDHC2_DATA1
> 	0x138e
> -			MX93_PAD_SD2_DATA2__USDHC2_DATA2
> 	0x138e
> -			MX93_PAD_SD2_DATA3__USDHC2_DATA3
> 	0x138e
> -			/* PD | PU | FSEL_2 | DSE X3 */
> -
> 	MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x50e
> +			/* PD | FSEL_3 | DSE X5 */
> +			MX93_PAD_SD2_CLK__USDHC2_CLK
> 		0x05be
> +			/* HYS | PU | FSEL_3 | DSE X4 */
> +			MX93_PAD_SD2_CMD__USDHC2_CMD
> 		0x139e
> +			/* HYS | PU | FSEL_3 | DSE X3 */
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0
> 		0x138e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1
> 		0x138e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2
> 		0x138e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3
> 		0x138e
> +			/* FSEL_2 | DSE X3 */
> +
> 	MX93_PAD_SD2_VSELECT__USDHC2_VSELECT
> 	0x010e
>  		>;
>  	};
>=20
>  	pinctrl_usdhc2_uhs: usdhc2uhsgrp {
>  		fsl,pins =3D <
> -			/* HYS | PD | PU | FSEL_3 | DSE X6 */
> -			MX93_PAD_SD2_CLK__USDHC2_CLK
> 	0x17fe
> -			/* HYS | PD | PU | FSEL_3 | DSE X4 */
> -			MX93_PAD_SD2_CMD__USDHC2_CMD
> 	0x139e
> -			MX93_PAD_SD2_DATA0__USDHC2_DATA0
> 	0x139e
> -			MX93_PAD_SD2_DATA1__USDHC2_DATA1
> 	0x139e
> -			MX93_PAD_SD2_DATA2__USDHC2_DATA2
> 	0x139e
> -			MX93_PAD_SD2_DATA3__USDHC2_DATA3
> 	0x139e
> -			/* PD | PU | FSEL_2 | DSE X3 */
> -
> 	MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x50e
> +			/* PD | FSEL_3 | DSE X6 */
> +			MX93_PAD_SD2_CLK__USDHC2_CLK
> 		0x05fe
> +			/* HYS | PU | FSEL_3 | DSE X4 */
> +			MX93_PAD_SD2_CMD__USDHC2_CMD
> 		0x139e
> +			MX93_PAD_SD2_DATA0__USDHC2_DATA0
> 		0x139e
> +			MX93_PAD_SD2_DATA1__USDHC2_DATA1
> 		0x139e
> +			MX93_PAD_SD2_DATA2__USDHC2_DATA2
> 		0x139e
> +			MX93_PAD_SD2_DATA3__USDHC2_DATA3
> 		0x139e
> +			/* FSEL_2 | DSE X3 */
> +
> 	MX93_PAD_SD2_VSELECT__USDHC2_VSELECT
> 	0x010e
>  		>;
>  	};
>  };
> --
> 2.34.1
>=20


