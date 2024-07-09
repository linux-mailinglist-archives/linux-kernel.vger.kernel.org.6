Return-Path: <linux-kernel+bounces-246004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E200792BC90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5BAB25BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD8719CD02;
	Tue,  9 Jul 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ij10lsUk"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E51591F1;
	Tue,  9 Jul 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534389; cv=fail; b=cE6DLSddYo5DQjgFDv4kVjaFosEqzZQ2tJP0NyA/dA31g0ERbgktBDMxND0iGGSD77aity+ra4BgD+SPxOSEXpcQAikFEWUfMT6BopjobkIORcP1p9Kr7hKI6OcN0j1SYtQqC7T9ESqOWUZqLdWAe9x1Zi8pACmEB/KEiSEiSyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534389; c=relaxed/simple;
	bh=9R8PIGiOKb5JjhtDKm+PA9U6/PiiFnqMvTnDmEgZ/9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R+ZgH1Y0qPCOzvcQGjSjRb8LmxQoq9xBpGni4l4LTBsoFCAYv9iVB6l025KkdHWn+7lnRQyvivuVsjKHKbr294e2iaZvmvBy9oVt7L4nlXfPYpGFo4QRnw0t6UwWYmkL2mGRB+eUHq/aVkKe88aKbBTa/I3r9mTpuCf7UwZKr58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ij10lsUk; arc=fail smtp.client-ip=52.101.70.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be94eHWuJV2X9i3Jj0dj0rllV0UIO51BBkHIj6ZnEXh7ySZMjxYpn64r9CKw5tsejOLEYVJpWNeAdS/NgHO0Dj3WRDGOUFS+4KNnoKjXZrOje64OdWLj9ulKlvkPDYRBt7dl7VrbkCrNCq+4WgB7vgIrlJ67MclAMEn2XqBjFLbK5oXXSd9gGk/E4LH6bzWF5WwcfR57A5YYDZlHwTOAR5lUwH2gm3sqKH2qsPfbhkaDDjZFUGP9B8wmCXEAsI27pCbeuNBsuyMtor+mJUh2bnBNvzaqodjNg5D02QmLjfwu0tcRgX7JGDwibZ0PC16PXrgMZCQuPWpQZmn6lefacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8sFT11Ue0hm1hEdqjtjZjwIcP4JlyMWnGYBGmlO9Mg=;
 b=d3RTev317oW/4fN3PHID26Xvg8n5JFw9MTuRZjL1/cqyT5uYu5P9y2VBHEUfTeEf9AUrrNaE1Hqxnr4P7FB+htdq2HtE4JQyZ4hg0iIqR7xljtXXatPBKmgRXE5z4LnJKshCs8bd28GYYgsjvksjjcRukm7KTcQycXrvZNB4m52Y6P6Ci29ixdzsTgJMtF1af1vt8OezBdU9rcESl5U9IJQnpmX2yoFtljmtItmQJpWfbuboFjH/8B60txxmXzziir+XtBHMigVJqnBz7fj1RCudjNJMwlPGN3qVClXzEfKWAkwSKSHx3Oic0Dly0G9iPgBFWM8oGalf8USGAmLg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8sFT11Ue0hm1hEdqjtjZjwIcP4JlyMWnGYBGmlO9Mg=;
 b=ij10lsUkpEpj8Zuu5+vuyolMjYIKw/Qi63KWy8xpGvvQsQyMW2JzGfF3f2UEsJ/mTQiBokUpDXaWJxRuTca9ca5o4A7DXlRgIuSW+iT2F+xdokjvJ9M/JHc1/B2XuwudLCHShddUpA8a9x9UlnCvhP7j6Y6sOslG0/DcMuerY8M=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7814.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 14:13:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 14:13:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] clk: imx95: enable the clock of NETCMIX block control
Thread-Topic: [PATCH 2/3] clk: imx95: enable the clock of NETCMIX block
 control
Thread-Index: AQHa0dSnz6xtwOc5AkmkHi9IOLmwibHucDMw
Date: Tue, 9 Jul 2024 14:13:03 +0000
Message-ID:
 <PAXPR04MB8459C43A1D11FA8A9F4AD0FC88DB2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240709073603.1967609-1-wei.fang@nxp.com>
 <20240709073603.1967609-3-wei.fang@nxp.com>
In-Reply-To: <20240709073603.1967609-3-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7814:EE_
x-ms-office365-filtering-correlation-id: cf672c1e-b5b9-4671-3bcc-08dca0213f85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5PXDYFGSV+fF66UgdvmVXusJqThHsDAFOy6ottxjoBgDPR2LOfBv5EHdB+N7?=
 =?us-ascii?Q?rZeHIiaaMLTvVZlnWJJczTP90ctr3z653ZHsC4xIpqN6ORgvbji4he8OAGUi?=
 =?us-ascii?Q?OBkxmTc5Gx9PS8Uv+gkZBAQbdGaIs7hjDqS8S4TmRccQi0jEyNj6BQ4vXg06?=
 =?us-ascii?Q?1324xCGackBzLyI7dWo8dnhVYte0zgLbW88oJkgHqcMCu9cd7ANaZ54g/W2q?=
 =?us-ascii?Q?czGTAYrGskRDib1CjuOugMsgLi50CrMQ8rYA4Ye7L6/1X3wVNCPjSCbFFB9y?=
 =?us-ascii?Q?vSNgxPSZcm1p8x3cqxHIKCQBF32MDcopQcVsJ7StxWkN5/MxQgcNUsr8pkxI?=
 =?us-ascii?Q?c7QQQ4tPEnUAma96ydELj5WG2YKWiNkxbByXplxSHyVzerz9J0GXbPkZIaHj?=
 =?us-ascii?Q?9WcTZK1LCMe1FSNIxeOUi5P8K+7u+z8l07UXzx1dqmBlSXyIGG/jqIsdEW8I?=
 =?us-ascii?Q?z70erpML3O5hft/3ciFoVepk5sLrKA1UaAqc6kvjA1t5B2Ktn7nBTIatY4pw?=
 =?us-ascii?Q?h0HflzpwdM7a4l9Najj5f8oKlJe1DrNiEBxVrm4M6YfS3YkiGGcy2VOgOUbP?=
 =?us-ascii?Q?pJd2uHGZjyL901APW6rOS/kJMllckyA37jL2DdrRRcMcHukA8sSbxAdXo95/?=
 =?us-ascii?Q?79iXICwnyaKgtxIX6KIfRgy1sNIAXtqlFBk1/vQshZam2xwaLvvlkCrS84C0?=
 =?us-ascii?Q?FI6yZavQUjt5yfTAXAZ439dKhN9akHYL0pfPKhEfJLvP7Z09gruTbryKSKA+?=
 =?us-ascii?Q?H1aLN4rVU31dA0nRYWYlFE1bJhjUHxDdwkPHc+fRACSREdNtZJfW0Ck+4yUk?=
 =?us-ascii?Q?MKT5R4eru4aJHLSC2iftwdbOktZESSf1W/hrsrp+UmGCTWixxYwtbov4DeCo?=
 =?us-ascii?Q?b4L4MDP1TyVE7oqCP/HJcJdqLCcT+uRukBSw36apedqBg4SjvUCwdPVxNAjc?=
 =?us-ascii?Q?uRZYX/a0WSiot0a7MBBSziT/K8IDomOcPUvc8l4hF+KAA2EebA/gn7SqKxN6?=
 =?us-ascii?Q?xJ7E4K4HPOW/eMApmquzkRNRxbUSNHXBs5zb4l2N0pzDpUC5jnrzIdkwIWRh?=
 =?us-ascii?Q?InJYu/veg5WjFw5cm4s2g1pLPtTA2Vq7fG4NPas7OfpJAsB4rJUWpQSET26A?=
 =?us-ascii?Q?g78oS17wb1SeL+2W2R/afs3W9wDE2WIF6fVu0gnDXTysFoW1OTeXWFgOO6Ca?=
 =?us-ascii?Q?n3IiqaKkVu9S/2Fw9dYB4tMCSqyzRaAAbDJfhsyQh9MIDn1CP6c3lrddd/CJ?=
 =?us-ascii?Q?CHhptuaP+jb/+D/8vf0tXNg8Qp193r0ekQe/QCsXoSsosrjRYX4BXhBheyiN?=
 =?us-ascii?Q?YP0olHz3dQrRhGPFZWtTqGW4BhHLm+jFzoSlOP2OE35dBd6QeZOfFAKICAtu?=
 =?us-ascii?Q?SQes1xSI+9VU3fdeMUNmu8IKc8S0jgH5Suvi+9fypbOoJ06n7g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N5R5pwGNI/JNcLEleyIyW78lh2YhGxdYtrQGjatnHylvWEx5sDd4EHDyTztr?=
 =?us-ascii?Q?cE3Ad7XVnYIboyxdKwWsTHiBfgLbLvYAQRnaGrnBkoUs6BYPMN3Hd7iM/56h?=
 =?us-ascii?Q?6jm37/DKJIV5X1dAceAxhgNvGgLEDDCqSjFwQ2bJUU65O9RKXYyALIJZEFq2?=
 =?us-ascii?Q?8j/R8Xyjrk+ksp41KmxNqnrWYVzctrhAu6Oeht1G72+bPhZDXQ6ETT8/dosE?=
 =?us-ascii?Q?VdnvuHt05ZvX8KzHhSOsTaKKf+CC5kfINfe90U6sUQ4QiU1adsSKVuvSd+Cl?=
 =?us-ascii?Q?DJ7bJdzlxHYAz9baM9H9KtmKDyoIJZpsHFAPpm4RJhIGdGMZW1tiHFcWLH3k?=
 =?us-ascii?Q?iRxRb8RHeWs1G19R3nUO4vxJehXXdD8Yfy+b1SG85xj67R2OahgYkUxNO1c9?=
 =?us-ascii?Q?Ixr/Zrn7lEbVAu1uU1i0xYEOZQe9A5ErT6wt9NSqe+rN8SKFsugqi8tOrOEz?=
 =?us-ascii?Q?9LFKrnZkyW7lczXEXh/GwdNzht+DKx/gWu8w04SKffuVCXyWLDob5FM1cmLr?=
 =?us-ascii?Q?IIzxwMjVv4fWhtbCWWHyAFs+r3zqFEX3gizBMgNhoj3mHUdvAdOye97ZEeBC?=
 =?us-ascii?Q?V4Kxe3l9lP3OT+yhEFOZIIE8ncbPV2LkWYXPsXCXc63KLZT4y+01CRHo+KIV?=
 =?us-ascii?Q?/r3BAgYy1tO3FuZeY8iK/hD0ruO0upGluwivm12pOA9bQJqbvPvAWRLrt6/o?=
 =?us-ascii?Q?IEDxBUCnpMSleD248wVZDyKCFGfsmpTAOR8b3idP8UGpIH7ArBs889+sEPLU?=
 =?us-ascii?Q?8mor8fUSgZ/pjyAL9yaKM2X5o+QkH9GdQE1cdmG2cwFm5SadmVj2WR/31vb5?=
 =?us-ascii?Q?I5Kr9o63851OlsGumdh/GLLnktUK16zrbmCink0urMr0xDgCbWyCcdZx9Gtc?=
 =?us-ascii?Q?xSW+4Za+Ps1nkKXnG4Sp+uHFBgI1nNN97vqbLcVEoAulhV2yrYQ3pWx7ma24?=
 =?us-ascii?Q?3t/66kpR61ClzmQU15LL6FEkI2DVytDGyxMIl4UchrCQygYtdws/Wizn8eIr?=
 =?us-ascii?Q?uxmBLqZaMbK4brBoyfy8W3LyOlECEFSdzgeC8uS5ODDWYWoQ/4OcfIFr5cg+?=
 =?us-ascii?Q?3NH8HXp8vp+A/yaXs6Ck6H9PirmgV6cNfWT7FfJKq0ulgWlD0fvgIR9pETd1?=
 =?us-ascii?Q?+A+JCn7Lg+AKs8fCtKm9J0245su8tfH6rz+hgSLtTAmOYWBkqWPA95nEPkDm?=
 =?us-ascii?Q?m9EE7gOd+yAYm2wcqjqG+yzPUH0hvtapmeiVeFixzgHFnvhA0K/Md9J+tpJT?=
 =?us-ascii?Q?urAEoQtjZYwLI2lz9tOOqXh3tGHHjUYUMen94cQCtTTEPSRGHPRHhS4YRLXP?=
 =?us-ascii?Q?/aGd6Lk1W/4AR0pTQ31sDXZ9nn/nv9KhjN0aJIyXep2wOE4lz6k2LR7Bxy3x?=
 =?us-ascii?Q?nmy0t+fks7QOrCEhfSfW6ComOiUhvVZpcTkOHV6v9cmqvApyboLnpm3/fJw+?=
 =?us-ascii?Q?cs1+zoRENDGE9heJSjscCGmvrrCrO7R9P1+1dAQ42/Cyk+UTpnSDrQ1Il/cD?=
 =?us-ascii?Q?vAkg7WTUu8Sr8kk5ZzDaZOA6u1Fxjwp24f1/9NodRN9WRBDGPgM7qF2VNNDx?=
 =?us-ascii?Q?T3wN71WseGiSsXAFmIw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf672c1e-b5b9-4671-3bcc-08dca0213f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:13:03.9641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7Sa6v+R0MXZ2OG17rpCCB+SsHbbd/vkfYdTYV+gGhgQK1ODl/BHwWta3EZcRhFifZ6o42tLH562DpwYTopFIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7814

> Subject: [PATCH 2/3] clk: imx95: enable the clock of NETCMIX block
> control
>=20
> The NETCMIX block control consists of registers for configuration of
> peripherals in the NETC domain, so enable the clock of NETCMIX to
> support the configuration.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx95-blk-ctl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-
> imx95-blk-ctl.c
> index 74f595f9e5e3..07c70c0a53d4 100644
> --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> @@ -419,6 +419,7 @@ static const struct of_device_id
> imx95_bc_of_match[] =3D {
>  	{ .compatible =3D "nxp,imx95-lvds-csr", .data =3D
> &lvds_csr_dev_data },
>  	{ .compatible =3D "nxp,imx95-display-csr", .data =3D
> &dispmix_csr_dev_data },
>  	{ .compatible =3D "nxp,imx95-vpu-csr", .data =3D
> &vpublk_dev_data },
> +	{ .compatible =3D "nxp,imx95-netcmix-blk-ctrl", },

This should not be added here if no real clocks are
included.

Regards,
Peng.

>  	{ /* Sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, imx95_bc_of_match);
> --
> 2.34.1


